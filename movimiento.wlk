import wollok.game.*
import elementosDelMapa.*
import personaje.*

class Direccion{
    const elementosEnElMapa = elementos

    method siguiente(posicion){
        const siguientePosicion = self.siguientePosicion(posicion)
        if (self.estaDentroDelTablero(siguientePosicion) and !elementosEnElMapa.hayElementoAca(siguientePosicion)){
            return siguientePosicion
        } else {
            return posicion
        }
    }

    method estaDentroDelTablero(posicion)

    method siguientePosicion(posicion)
}

object arriba inherits Direccion(){
    override method estaDentroDelTablero(posicion){
        return posicion.y() != game.width()
    }

    override method siguientePosicion(posicion){
        return posicion.up(1)
    }
}

object derecha inherits Direccion(){
    override method estaDentroDelTablero(posicion){
        return posicion.x() != game.width()
    }

    override method siguientePosicion(posicion){
        return posicion.right(1)
    }
}

object abajo inherits Direccion(){
    override method estaDentroDelTablero(posicion){
        return posicion.y() != -1
    }

    override method siguientePosicion(posicion){
        return posicion.down(1)
    }
}

object izquierda inherits Direccion (){
    override method estaDentroDelTablero(posicion){
        return posicion.x() != -1
    }

    override method siguientePosicion(posicion){
        return posicion.left(1)
    }
}