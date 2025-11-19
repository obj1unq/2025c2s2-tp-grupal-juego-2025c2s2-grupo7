import wollok.game.*
import elementosDelMapa.*
import personaje.*

class Direccion{
    const elementosEnElMapa = elementos
    const property estadoDePersonajeAsociado // Capaz haya una forma mejor de que el personaje cambie de estado.

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

object izquierda inherits Direccion (estadoDePersonajeAsociado = personajeIzquierda){
    override method estaDentroDelTablero(posicion){
        return posicion.x() != -1
    }

    override method siguientePosicion(posicion){
        return posicion.left(1)
    }
}

object derecha inherits Direccion(estadoDePersonajeAsociado = personajeDerecha){
    override method estaDentroDelTablero(posicion){
        return posicion.x() != game.width()
    }

    override method siguientePosicion(posicion){
        return posicion.right(1)
    }
}

object abajo inherits Direccion(estadoDePersonajeAsociado = personajeAbajo){
    override method estaDentroDelTablero(posicion){
        return posicion.y() != -1
    }

    override method siguientePosicion(posicion){
        return posicion.down(1)
    }
}

object arriba inherits Direccion(estadoDePersonajeAsociado = personajeArriba ){
    override method estaDentroDelTablero(posicion){
        return posicion.y() != game.width()
    }

    override method siguientePosicion(posicion){
        return posicion.up(1)
    }
}