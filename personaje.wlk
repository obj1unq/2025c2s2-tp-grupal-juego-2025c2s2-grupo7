import wollok.game.*
import enemigos.*

object personaje{
    var position = game.at(7,7)
    const image = "personaje.png"

    method image(){
        return image
    }

    method position(){
        return position
    }

    method mover(direccion){
        position = direccion.siguiente(position)
    }

    method disparar(direccion){
        arma.disparar(direccion)
    }

    method colisionarCon(enemigo){
        game.stop()
    }
}

object arma{
    var position = game.at(7,7)
    const image = "bala.png"
    const poseedor = personaje 
    const daño = 2

    method image(){
        return image
    }

    method position(){
        return position
    }

    method disparar(direccion){
        game.removeTickEvent("Arma dispara")
        game.removeVisual(self)
        position = poseedor.position()
        game.addVisual(self)
        game.onTick (100, "Arma dispara", {self.balaViajando(direccion)})
    }

    method balaViajando(direccion){
        if (position.x().between(0,14) and position.y().between(0,14)){
            position = direccion.viajar(position)
        } else {
            game.removeTickEvent("Arma dispara")
            game.removeVisual(self)
            position = poseedor.position()
        }
    }

    method colisionarCon(enemigo){
        enemigo.colisionarCon(daño)
        game.removeTickEvent("Arma dispara")
        game.removeVisual(self)
        position = poseedor.position()
    }
}