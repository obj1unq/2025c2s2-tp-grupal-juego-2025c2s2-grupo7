import wollok.game.*
import enemigos.*
import balas.*

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
        arma.dispararBalas(direccion)
    }

    method colisionarCon(enemigo){
        game.stop()
    }
}