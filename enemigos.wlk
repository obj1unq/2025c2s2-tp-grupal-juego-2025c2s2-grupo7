import movimiento.*
import randomizer.*
import wollok.game.*
import factories.*
import drops.*
import elementosDelMapa.*

object ejercito{
    const enemigosEnMapa = #{}
    const dropeo = drops

    method agregarEnemigo(tipoDeEnemigo){
        const enemigo = tipoDeEnemigo.crear()
        enemigosEnMapa.add(enemigo)
        game.addVisual(enemigo)
    }

    method enemigosDanPaso(){
        game.onTick(150, "Enemigos dan paso", {enemigosEnMapa.forEach({enemigo => enemigo.darPaso()})})
    }

    method enemigosPersiguen(personaje){
        game.onTick(300, "Enemigos persiguen a personaje.", {enemigosEnMapa.forEach({enemigo => enemigo.perseguir(personaje)})})
    }

    method enemigoMurio(enemigo){
        dropeo.crear(enemigo.position())
        game.removeVisual(enemigo)
        enemigosEnMapa.remove(enemigo)
        if (enemigosEnMapa.isEmpty()){
            game.removeTickEvent("Enemigos dan paso")
            game.removeTickEvent("Enemigos persiguen a personaje.")
        }
    }

    method matarTodos(){
        enemigosEnMapa.forEach({enemigo => enemigo.muerte()})
    }

    method cantidadDeEnemigosEnMapa(){
        return enemigosEnMapa.size()
    }

    method hayEnemigoAca(position){
        return enemigosEnMapa.any({enemigo => enemigo.position() == position})
    }
}

class Enemigo {
    var estado
    var position 
    var vida
    const ejercitoDeNivel = ejercito
    const tableroDeNivel = tablero

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

    method aplicarDaño(daño){
        if(vida > daño){
            vida = vida - daño
        }else {
            self.muerte()
        }
    }

    method muerte (){
        ejercitoDeNivel.enemigoMurio(self)
    }

    method darPaso(){
        estado = estado.siguienteEstado()
    }

    method colisionarConPersonaje(personaje){
        personaje.muerte()
    }

    method colisionarConBala(arma){
        self.aplicarDaño(arma.daño())
        arma.colisiono()
    }
}

class Vampiro inherits Enemigo(vida = 20, estado = vampiroArriba){ 
    override method mejorPosicionParaPerseguirEntre(posiciones){
        return posiciones.findOrDefault({posicion => !tableroDeNivel.hayEnemigoAca(posicion)}, position) // Los vampiros vuelan sobre los elementos del mapa.
    }
}

object vampiroArriba{
    const property image = "enemigo_vampiroArriba.png"
    const property siguienteEstado = vampiroAbajo
}

object vampiroAbajo{
    const property image = "enemigo_vampiroAbajo.png"
    const property siguienteEstado = vampiroArriba
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

class Zombie inherits EnemigoDeMovimientoLento(vida = 10, estado = zombiePasoDerecho, ticksParaMoverse = 1){
    override method aplicarDaño(daño){ // El zombie muere de un solo golpe sin importar que.
        self.muerte()
    }

    override method ticksParaMoverseIniciales(){
        return 1
    }
}

object zombiePasoDerecho{
    const property image = "enemigo_zombieDerecho.png"
    const property siguienteEstado = zombiePasoIzquierdo
}

object zombiePasoIzquierdo{
    const property image = "enemigo_zombieIzquierdo.png"
    const property siguienteEstado = zombiePasoDerecho
}

class Minotauro inherits EnemigoDeMovimientoLento(vida = 30, estado = minotauroPasoDerecho, ticksParaMoverse = 1){
    override method ticksParaMoverseIniciales(){
        return 1
    }
}

object minotauroPasoDerecho{
    const property image = "enemigo_minotauroDerecho.png"
    const property siguienteEstado = minotauroPasoIzquierdo
}

object minotauroPasoIzquierdo{
    const property image = "enemigo_minotauroIzquierdo.png"
    const property siguienteEstado = minotauroPasoDerecho
}

class Momia inherits EnemigoDeMovimientoLento(vida = 150, estado = momiaPasoDerecho, ticksParaMoverse = 4){
    override method ticksParaMoverseIniciales(){
        return 4
    }
}

object momiaPasoDerecho{
    const property image = "enemigo_momiaDerecho.png"
    const property siguienteEstado = momiaPasoIzquierdo
}

object momiaPasoIzquierdo{
    const property image = "enemigo_momiaIzquierdo.png"
    const property siguienteEstado = momiaPasoDerecho
}

class Acorazado inherits EnemigoDeMovimientoLento(vida = 70, estado = desprotegido, ticksParaMoverse = 1){ // Un acorazado aguanta 20 de vida en su estado desprotegido, luego se acoraza.

    override method perseguir(personaje){
        if (estado.puedeMoverse()){
            super(personaje)
        }
    }

    override method aplicarDaño(daño){
        super(daño)
        if (vida <= 50){
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

object protegido{
    const property image = "enemigo_acorazadoProtegido.png"
    const property puedeMoverse = false

    method siguienteEstado(){
        return self
    }

    method darPaso(){}
}

object acorazadoPasoDerecho{
    const property image = "enemigo_acorazadoDerecho.png"
    const property siguienteEstado = acorazadoPasoIzquierdo
}

object acorazadoPasoIzquierdo{
    const property image = "enemigo_acorazadoIzquierdo.png"
    const property siguienteEstado = acorazadoPasoDerecho
}

class EnemigoPrueba inherits Enemigo {
     
     override method perseguir(personaje){
        position = self.position()
     }
}