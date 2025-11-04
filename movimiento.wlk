import wollok.game.*
import elementosDelMapa.*

object izquierda{
    const elementosEnElMapa = elementosDelMapa

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

    method siguiente(posicion){
        const siguientePosicion = posicion.up(1)
        if (siguientePosicion.y() != game.width() and !elementosEnElMapa.hayElementoAca(siguientePosicion)){
            return siguientePosicion
        } else {
            return posicion
        }
    }
}