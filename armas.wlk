import wollok.game.*
import personaje.*

class Arma {
    const property municion 
    const sonidoDeDisparo = "_sonido_disparo.mp3"
    
    method disparar(direccion){
        municion.serDisparada(direccion)
        game.sound(sonidoDeDisparo).play()
    }
}

object revolver inherits Arma(municion = municionNormal){}

object escopeta inherits Arma(municion = cartucho){}

object metralleta inherits Arma (municion = municionVeloz){}

object lanzacohetes inherits Arma (municion = municionExplosiva){}

object arco inherits Arma (municion = flecha){}

class Municion{
    var position = game.at(7,7)
    var image
    const velocidadDeProyectil
    const daño
    const tirador = personaje

    method image(){
        return image
    }

    method position(){
        return position
    }

    method colisionarConEnemigo(enemigo){
        enemigo.recibirDaño(daño)
        self.colisiono()
    }

    method serDisparada(direccion){
        game.removeTickEvent("Arma dispara")
        game.removeVisual(self)
        position = direccion.siguiente(tirador.position())
        image = self.nombreDeImagen() + direccion + ".png"
        game.addVisual(self)
        game.onTick (velocidadDeProyectil, "Arma dispara", {self.balaViajando(direccion)})
    }

    method nombreDeImagen()

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

object municionNormal inherits Municion (velocidadDeProyectil = 100, daño = 100, image = "municion_normal_derecha.png"){
    override method nombreDeImagen(){
        return "municion_normal_"
    }
}

object municionVeloz inherits Municion (velocidadDeProyectil = 50, daño = 200, image = "municion_veloz_derecha.png"){
    override method nombreDeImagen(){
        return "municion_veloz_"
    }
}

object municionExplosiva inherits Municion (velocidadDeProyectil = 150, daño = 1000, image = "municion_explosiva_derecha.png"){
    override method nombreDeImagen(){
        return "municion_explosiva_"
    }

    /*
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
    */
}

class MunicionPenetrante inherits Municion(){
    override method colisionarConEnemigo(enemigo){
        enemigo.recibirDaño(daño)
    }
}

object flecha inherits MunicionPenetrante (velocidadDeProyectil = 150, daño = 200, image = "municion_flecha_derecha.png"){
    override method nombreDeImagen(){
        return "municion_flecha_"
    }
}

object cartucho inherits MunicionPenetrante (velocidadDeProyectil = 100, daño = 400, image = "municion_cartucho_derecha.png"){
    override method nombreDeImagen(){
        return "municion_cartucho_"
    }
}