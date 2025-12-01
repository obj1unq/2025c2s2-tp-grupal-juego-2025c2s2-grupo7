import wollok.game.*
import drops.*
import tableroYRepresentaciones.*
import reproductor.*

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
        game.removeTickEvent("Enemigos dan paso.")
        game.removeTickEvent("Enemigos persiguen a personaje.")
    }

    method enemigosDanPaso(){
        game.onTick(150, "Enemigos dan paso.", {enemigosEnNivel.forEach({enemigo => enemigo.darPaso()})})
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

class Enemigo{
    var property  position    // se hace property para facilitar el test
    var property  vida        // se hace property para facilitar el test
    const reproductorSonidos = reproductor

    method position(){
        return position
    }

    method recibirDaño(daño){
        vida = vida - daño
        if (self.debeMorir()){
            self.muerte()
        }
    }

    method muerte(){
        reproductorSonidos.reproducirSonido(self.sonidoDeMuerte())
        self.dropearObjeto()
    }

    method sonidoDeMuerte()

    method colisionarConPersonaje(personaje){
        personaje.muerte()
    }

    method colisionarConBala(bala){
        bala.colisionarConEnemigo(self)
    }

    method debeMorir(){
        return vida <= 0
    }

    method dropearObjeto()
}

class EnemigoPerseguidor inherits Enemigo{
    var estado
    const tableroDeNivel = tablero
    const dropeo = drops
    const sonidosDeMuerte = #{"_sonido_muerteEnemigo1.mp3", "_sonido_muerteEnemigo2.mp3"}
    const enemigosDeNivel = enemigos

    method image(){
        return estado.image()
    }

    method perseguir(personaje) {
        position = self.mejorPosicionParaPerseguirEntre(tableroDeNivel.posicionesLindantesOrdenadasXDistancia(position, personaje.position()))
    }

    method mejorPosicionParaPerseguirEntre(posiciones){
        return posiciones.findOrDefault({posicion => !tableroDeNivel.hayAlgoAca(posicion)}, position)
    }

    method darPaso(){
        estado = estado.siguienteEstado()
    }

    override method muerte(){
        enemigosDeNivel.enemigoMurio(self)
        super()
    }

    override method sonidoDeMuerte(){
        return sonidosDeMuerte.anyOne()
    }

    override method dropearObjeto(){
        dropeo.crear(position)
    }
}

class Vampiro inherits EnemigoPerseguidor (vida = 200, estado = vampiroPasoDerecho){}

class Gargola inherits EnemigoPerseguidor(vida = 200, estado = gargolaArriba){ 
    override method mejorPosicionParaPerseguirEntre(posiciones){
        return posiciones.findOrDefault({posicion => !tableroDeNivel.hayEnemigoAca(posicion)}, position) // Las gargolas vuelan sobre los elementos del mapa.
    }
}

class EnemigoPerseguidorDeMovimientoLento inherits EnemigoPerseguidor{
    var ticksParaMoverse
    const ticksParaMoverseIniciales = ticksParaMoverse

    override method perseguir(personaje){
        if (ticksParaMoverse == 0){
            super(personaje)
            ticksParaMoverse = ticksParaMoverseIniciales
        } else {
            ticksParaMoverse -= 1
        }
    }
}

class Zombie inherits EnemigoPerseguidorDeMovimientoLento(vida = 100, estado = zombiePasoDerecho, ticksParaMoverse = 1){
    override method recibirDaño(daño){ // El zombie muere de un solo golpe sin importar que.
        self.muerte()
    }
}

class ZombieTutorial inherits Zombie(){
    override method perseguir(personaje){}

    override method darPaso(){}

    override method colisionarConPersonaje(personaje){
        personaje.volverAPosicionInicial()
    }
}

class Minotauro inherits EnemigoPerseguidorDeMovimientoLento(vida = 400, estado = minotauroPasoDerecho, ticksParaMoverse = 1){}

class Momia inherits EnemigoPerseguidorDeMovimientoLento(vida = 700, estado = momiaPasoDerecho, ticksParaMoverse = 3){}

class Acorazado inherits EnemigoPerseguidorDeMovimientoLento(vida = 700, estado = desprotegido, ticksParaMoverse = 1){ // Un acorazado aguanta 200 de vida en su estado desprotegido, luego se acoraza.
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
}

object jefeFinal inherits Enemigo(vida = 2500, position = game.at(8,2)){
    const estado = jefeAnimado
    const property sonidoDeMuerte = "_sonido_muerteEnemigo1.mp3"
    const coberturas = #{game.at(8,2), game.at(8,14)}
    const vidaInicial = vida
    const objeto = placaDeSheriff

    method image(){
        return estado.image()
    }

    override method recibirDaño(daño){
        self.intentarMoverse()
        super(daño)
    }

    override method muerte(){
        super()
        game.removeVisual(self)
    }

    method intentarMoverse(){
        position = coberturas.anyOne()
    }

    method estaVivo(){
        return vida > 0
    }

    method activar(){
        vida = vidaInicial
        estado.realizarAnimacion()
    }

    override method dropearObjeto(){
        game.addVisual(objeto)
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

object gargolaArriba inherits EstadoDeMovimientoDeEnemigo(image = "enemigo_gargolaArriba.png", siguienteEstado = gargolaAbajo){}
object gargolaAbajo inherits EstadoDeMovimientoDeEnemigo(image = "enemigo_gargolaAbajo.png",  siguienteEstado = gargolaArriba){}

object vampiroPasoDerecho inherits EstadoDeMovimientoDeEnemigo(image = "enemigo_vampiroDerecho.png",  siguienteEstado = vampiroPasoIzquierdo){}
object vampiroPasoIzquierdo inherits EstadoDeMovimientoDeEnemigo(image = "enemigo_vampiroIzquierdo.png", siguienteEstado = vampiroPasoDerecho){}

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

object jefeAnimado{
    var image = "protegido0.png"
    var contadorDeFrames = 0
    const cantidadMaximaDeFrames = 3

    method image(){
        return image
    }

    method realizarAnimacion(){
        game.onTick(250, "Jefe realiza animación", {self.cambiarFrame()})
    }

    method detenerAnimacion(){
        game.removeTickEvent("Jefe realiza animación")
    }

    method cambiarFrame(){
        if (contadorDeFrames == cantidadMaximaDeFrames){
            contadorDeFrames = 0
        } else {
            contadorDeFrames += 1
        }
        self.cambiarImagen()
    }

    method cambiarImagen(){
        image = "protegido" + contadorDeFrames + ".png"
    }
}