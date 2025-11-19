import wollok.game.*
import personaje.*

class Municion{
    const property velocidadDeProyectil
    const property image
    const daño
    var position = game.at(7,7)
    const tirador = personaje

    method colisionoConEnemigo(enemigo){
        enemigo.aplicarDaño(daño)
        self.colisiono()
    }

    method position(){
        return position
    }

    method disparar(direccion){
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

object municionPenetrante inherits Municion (velocidadDeProyectil = 100, daño = 10, image = "bala.png"){
    override method colisionoConEnemigo(enemigo){
        enemigo.aplicarDaño(daño)
    }
}

object municionRapida inherits Municion (velocidadDeProyectil = 250, daño = 10, image = "bala.png"){}

object cartucho inherits Municion (velocidadDeProyectil = 150, daño = 200, image = "bala.png"){
    override method colisionoConEnemigo(enemigo){
        enemigo.aplicarDaño(daño)
    }
}

object municionExplosiva inherits Municion (velocidadDeProyectil = 250, daño = 10, image = "bala.png"){
    override method colisionoConEnemigo(enemigo){
        const posicionEnemigo = enemigo.position()
        self.explotar(enemigo)
        self.explotarPosicionesCercanas(posicionEnemigo)
    }

    method explotar(enemigo){
        self.efectoExplosion()
        enemigo.muerte()
    }

    method efectoExplosion(){}

    method explotarPosicionesCercanas(posicion){
    }
}