import wollok.game.*
import elementosDelMapa.*
import personaje.*

object izquierda{
    const elementosEnElMapa = elementosDelMapa
    const property estadoDePersonajeAsociado = personajeIzquierda // Capaz haya una forma mejor de que el personaje cambie de estado.

    method siguiente(posicion){
        const siguientePosicion = posicion.left(1)
        if (siguientePosicion.x() != -1 and !elementosEnElMapa.hayElementoAca(siguientePosicion)){
            return siguientePosicion
        } else {
            return posicion
        }
    }
}

object derecha{
    const elementosEnElMapa = elementosDelMapa
    const property estadoDePersonajeAsociado = personajeDerecha // Capaz haya una forma mejor de que el personaje cambie de estado.

    method siguiente(posicion){
        const siguientePosicion = posicion.right(1)
        if (siguientePosicion.x() != game.width() and !elementosEnElMapa.hayElementoAca(siguientePosicion)){
            return siguientePosicion
        } else {
            return posicion
        }
    }
}

object abajo{
    const elementosEnElMapa = elementosDelMapa
    const property estadoDePersonajeAsociado = personajeAbajo // Capaz haya una forma mejor de que el personaje cambie de estado.

    method siguiente(posicion){
        const siguientePosicion = posicion.down(1)
        if (siguientePosicion.y() != -1 and !elementosEnElMapa.hayElementoAca(siguientePosicion)){
            return siguientePosicion
        } else {
            return posicion
        }
    }
}

object arriba{
    const elementosEnElMapa = elementosDelMapa
    const property estadoDePersonajeAsociado = personajeArriba // Capaz haya una forma mejor de que el personaje cambie de estado.

    method siguiente(posicion){
        const siguientePosicion = posicion.up(1)
        if (siguientePosicion.y() != game.width() and !elementosEnElMapa.hayElementoAca(siguientePosicion)){
            return siguientePosicion
        } else {
            return posicion
        }
    }
}