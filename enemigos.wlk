import wollok.game.*
import drops.*
import tableroYRepresentaciones.*
import personaje.*

object enemigos{
    const enemigosEnNivel = #{}

    method agregarEnemigo(tipoDeEnemigo){
        const enemigo = tipoDeEnemigo.crear()
        enemigosEnNivel.add(enemigo)
        game.addVisual(enemigo)
    }

    method activarEnemigos(personaje){
        self.enemigosDanPaso()
        self.enemigosPersiguen(personaje)
    }

    method detenerEnemigos(){
        game.removeTickEvent("Enemigos dan paso")
        game.removeTickEvent("Enemigos persiguen a personaje.")
    }

    method enemigosDanPaso(){
        game.onTick(150, "Enemigos dan paso", {enemigosEnNivel.forEach({enemigo => enemigo.darPaso()})})
    }

    method enemigosPersiguen(personaje){
        game.onTick(300, "Enemigos persiguen a personaje.", {enemigosEnNivel.forEach({enemigo => enemigo.perseguir(personaje)})})
    }

    method enemigoMurio(enemigo){
        game.removeVisual(enemigo)
        enemigosEnNivel.remove(enemigo)
    }

    method matarTodos(){
        enemigosEnNivel.forEach({enemigo => enemigo.muerte()})
    }

    method cantidadDeEnemigos(){
        return enemigosEnNivel.size()
    }

    method hayEnemigoAca(position){
        return enemigosEnNivel.any({enemigo => enemigo.position() == position})
    }

    method quedanEnemigos(){
        return !enemigosEnNivel.isEmpty()
    }
}

class Enemigo {
    var estado
    var position 
    var vida
    const ejercitoDeNivel = enemigos
    const tableroDeNivel = tablero
    const dropeo = drops
    const sonidosDeMuerte = #{"_sonido_muerteEnemigo1.mp3", "_sonido_muerteEnemigo2.mp3"}

    method image(){
        return estado.image()
    }

    method position(){
        return position
    }

    method perseguir(personaje) {
        position = self.mejorPosicionParaPerseguirEntre(tableroDeNivel.posicionesLindantesOrdenadasXDistancia(position, personaje.position()))
    }

    method mejorPosicionParaPerseguirEntre(posiciones){
        return posiciones.findOrDefault({posicion => !tableroDeNivel.hayAlgoAca(posicion)}, position)
    }

    method recibirDaño(daño){
        if(vida > daño){
            vida = vida - daño
        } else {
            self.muerte()
        }
    }

    method muerte (){
        ejercitoDeNivel.enemigoMurio(self)
        game.sound(sonidosDeMuerte.anyOne()).play()
        dropeo.crear(position)
    }

    method darPaso(){
        estado = estado.siguienteEstado()
    }

    method colisionarConPersonaje(personaje){
        personaje.muerte()
    }

    method colisionarConBala(bala){
        bala.colisionarConEnemigo(self)
    }
}

class Aliado inherits Enemigo (vida = 200, estado = aliadoPasoDerecho){}

class Vampiro inherits Enemigo(vida = 200, estado = vampiroArriba){ 
    override method mejorPosicionParaPerseguirEntre(posiciones){
        return posiciones.findOrDefault({posicion => !tableroDeNivel.hayEnemigoAca(posicion)}, position) // Los vampiros vuelan sobre los elementos del mapa.
    }
}

class EnemigoDeMovimientoLento inherits Enemigo{
    var ticksParaMoverse

    override method perseguir(personaje){
        if (ticksParaMoverse == 0){
            super(personaje)
            ticksParaMoverse = self.ticksParaMoverseIniciales()
        } else {
            ticksParaMoverse = ticksParaMoverse - 1
        }
    }

    method ticksParaMoverseIniciales()
}

class Zombie inherits EnemigoDeMovimientoLento(vida = 100, estado = zombiePasoDerecho, ticksParaMoverse = 1){
    override method recibirDaño(daño){ // El zombie muere de un solo golpe sin importar que.
        self.muerte()
    }

    override method ticksParaMoverseIniciales(){
        return 1
    }
}

class ZombieTutorial inherits Zombie(){
    override method perseguir(personaje){}

    override method darPaso(){}

    override method colisionarConPersonaje(personaje){
        personaje.volverAPosicionInicial()
    }
}

class Minotauro inherits EnemigoDeMovimientoLento(vida = 400, estado = minotauroPasoDerecho, ticksParaMoverse = 1){
    override method ticksParaMoverseIniciales(){
        return 1
    }
}

class Momia inherits EnemigoDeMovimientoLento(vida = 700, estado = momiaPasoDerecho, ticksParaMoverse = 3){
    override method ticksParaMoverseIniciales(){
        return 4
    }
}

class Acorazado inherits EnemigoDeMovimientoLento(vida = 700, estado = desprotegido, ticksParaMoverse = 1){ // Un acorazado aguanta 20 de vida en su estado desprotegido, luego se acoraza.
    override method perseguir(personaje){
        if (estado.puedeMoverse()){
            super(personaje)
        }
    }

    override method recibirDaño(daño){
        super(daño)
        if (vida <= 500){
            estado = estado.siguienteEstado()
        }
    }

    override method darPaso(){
        estado.darPaso()
    }

    override method ticksParaMoverseIniciales(){
        return 1
    }
}

object jefeFinal{
    var position = game.at(8,2)
    var image = "protegido0.png"
    var vida = 2500
    const enemigosDeNivel = enemigos
    const sonidosDeMuerte = #{"_sonido_muerteEnemigo1.mp3", "_sonido_muerteEnemigo2.mp3"}
    const jugador = personaje
    const enemigoAliado = ald
    const coberturas = [game.at(8,2), game.at(8,14)]
    const dropeo = drops
    var contadorDeFrames = 0

    method image(){
        return image
    }

    method position(){
        return position
    }

    method recibirDaño(daño){
        if(vida > daño){
            vida = vida - daño
            self.moverse()
        } else {
            self.muerte()
        }
    }

    method moverse(){
        if (self.estaEnPrimeraCobertura()){
            position = coberturas.get(1)
        } else {
            position = coberturas.get(0)
        }
    }

    method estaEnPrimeraCobertura(){
        return position == coberturas.get(0)
    }

    method muerte(){
        game.sound(sonidosDeMuerte.anyOne()).play()
        dropeo.crear(position)
    }

    method activar(){
        self.realizarAnimacion()
        enemigosDeNivel.activarEnemigos(jugador)
        game.onTick(100, "Jefe spawnea aliado", {self.spawnearAliado()})
        game.schedule(10000, {self.detenerOleada()})
    }

    method spawnearAliado(){
        if (enemigosDeNivel.cantidadDeEnemigos() < 4){
            enemigosDeNivel.agregarEnemigo(enemigoAliado)
        }
    }

    method detenerOleada(){
        game.removeTickEvent("Jefe spawnea aliado")
        enemigosDeNivel.matarTodos()
        enemigosDeNivel.detenerEnemigos()
    }

    method colisionarConBala(bala){
        bala.colisionarConEnemigo(self)
    }

    method realizarAnimacion(){
        game.onTick(250, "Jefe realiza animación", {self.cambiarFrame()})
    }

    method detenerAnimacion(){
        game.removeTickEvent("Jefe realiza animación")
    }

    method cambiarFrame(){
        if (contadorDeFrames == self.cantidadMaximaDeFrames()){
            contadorDeFrames = 0
        } else {
            contadorDeFrames += 1
        }
        image = "protegido" + contadorDeFrames + ".png"
    }

    method cantidadMaximaDeFrames(){
        return 4
    }
}

// ESTADOS DE LOS ENEMIGOS

class EstadoDeMovimientoDeEnemigo{
    const property image
    const property siguienteEstado
}

object momiaPasoDerecho inherits EstadoDeMovimientoDeEnemigo(image = "enemigo_momiaDerecho.png", siguienteEstado = momiaPasoIzquierdo){}
object momiaPasoIzquierdo inherits EstadoDeMovimientoDeEnemigo(image = "enemigo_momiaIzquierdo.png", siguienteEstado = momiaPasoDerecho){}

object minotauroPasoDerecho inherits EstadoDeMovimientoDeEnemigo(image = "enemigo_minotauroDerecho.png", siguienteEstado = minotauroPasoIzquierdo){}
object minotauroPasoIzquierdo inherits EstadoDeMovimientoDeEnemigo(image = "enemigo_minotauroIzquierdo.png", siguienteEstado = minotauroPasoDerecho){}

object zombiePasoDerecho inherits EstadoDeMovimientoDeEnemigo(image = "enemigo_zombieDerecho.png", siguienteEstado = zombiePasoIzquierdo){}
object zombiePasoIzquierdo inherits EstadoDeMovimientoDeEnemigo(image = "enemigo_zombieIzquierdo.png", siguienteEstado = zombiePasoDerecho){}

object vampiroArriba inherits EstadoDeMovimientoDeEnemigo(image = "enemigo_vampiroArriba.png", siguienteEstado = vampiroAbajo){}
object vampiroAbajo inherits EstadoDeMovimientoDeEnemigo(image = "enemigo_vampiroAbajo.png",  siguienteEstado = vampiroArriba){}

object aliadoPasoDerecho inherits EstadoDeMovimientoDeEnemigo(image = "enemigo_aliadoDerecho.png",  siguienteEstado = aliadoPasoIzquierdo){}
object aliadoPasoIzquierdo inherits EstadoDeMovimientoDeEnemigo(image = "enemigo_aliadoIzquierdo.png", siguienteEstado = aliadoPasoDerecho){}

object protegido{
    const property image = "enemigo_acorazadoProtegido.png"
    const property puedeMoverse = false

    method siguienteEstado(){
        return self
    }

    method darPaso(){}
}

object desprotegido {
    var estado = acorazadoPasoDerecho
    const property siguienteEstado = protegido
    const property puedeMoverse = true

    method image(){
        return estado.image()
    }

    method darPaso(){
        estado = estado.siguienteEstado()
    }
}

object acorazadoPasoDerecho inherits EstadoDeMovimientoDeEnemigo(image = "enemigo_acorazadoDerecho.png", siguienteEstado = acorazadoPasoIzquierdo){}
object acorazadoPasoIzquierdo inherits EstadoDeMovimientoDeEnemigo(image = "enemigo_acorazadoIzquierdo.png", siguienteEstado = acorazadoPasoDerecho){}