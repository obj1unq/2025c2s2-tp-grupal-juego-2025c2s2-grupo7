import wollok.game.*
import personaje.*

class Arma {
    const property municion 
    
    method disparar(direccion){
        municion.serDisparada(direccion)
    }
}

object armaPrincipal inherits Arma(municion = municionNormal){}

object escopeta inherits Arma(municion = cartucho){}

object uzi inherits Arma (municion = municionVeloz){}

object lanzacohetes inherits Arma (municion = municionExplosiva){}

object arco inherits Arma (municion = flechaPenetrante){}

class Municion{
    const property velocidadDeProyectil
    const property image
    const daño
    var position = game.at(7,7)
    const tirador = personaje

    method colisionarConEnemigo(enemigo){
        enemigo.recibirDaño(daño)
        self.colisiono()
    }

    method position(){
        return position
    }

    method serDisparada(direccion){
        game.removeTickEvent("Arma dispara")
        game.removeVisual(self)
        position = direccion.siguiente(tirador.position())
        game.addVisual(self)
        game.onTick (velocidadDeProyectil, "Arma dispara", {self.balaViajando(direccion)})
    }

    method balaViajando(direccion){
        const nuevaPosicion = direccion.siguiente(position)
        if (nuevaPosicion != position){ // La bala puede moverse a su siguiente posicion ya que esta vacía y esta dentro de los limites del mapa.
            position = nuevaPosicion
        } else { // Significa que la bala colisiono con un elemento del mapa o con el borde del mapa.
            self.colisiono()
        }
    }

    method colisiono(){
        game.removeTickEvent("Arma dispara")
        game.removeVisual(self)
    }

    method colisionarConPersonaje(personaje){} // No se hace nada. El personaje no interacciona con su bala disparada.
}

object municionNormal inherits Municion (velocidadDeProyectil = 100, daño = 10, image = "bala.png"){}

object municionVeloz inherits Municion (velocidadDeProyectil = 250, daño = 10, image = "bala.png"){}

object municionExplosiva inherits Municion (velocidadDeProyectil = 250, daño = 10, image = "bala.png"){
    override method colisionarConEnemigo(enemigo){
        const posicionEnemigo = enemigo.position()
        self.explotar(enemigo)
        self.explotarPosicionesCercanas(posicionEnemigo)
    }

    method explotar(enemigo){
        self.efectoExplosion()
        enemigo.muerte()
    }

    method efectoExplosion(){}

    method explotarPosicionesCercanas(posicion){}
}

class MunicionPenetrante inherits Municion(){
    override method colisionarConEnemigo(enemigo){
        enemigo.recibirDaño(daño)
    }
}

object flechaPenetrante inherits MunicionPenetrante (velocidadDeProyectil = 100, daño = 10, image = "bala.png"){}

object cartucho inherits Municion (velocidadDeProyectil = 150, daño = 200, image = "bala.png"){}