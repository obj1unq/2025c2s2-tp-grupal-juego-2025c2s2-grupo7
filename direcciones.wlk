import wollok.game.*

object izquierda{
    method siguiente(posicion){
        if (posicion.x() > 0){
            return posicion.left(1)
        } else {
            return posicion
        }
    }
}

object derecha{
    method siguiente(posicion){
        if (posicion.x() < game.width()-1){
            return posicion.right(1)
        } else {
            return posicion
        }
    }
}

object abajo{
    method siguiente(posicion){
        if (posicion.y() > 0){
            return posicion.down(1)
        } else {
            return posicion
        }
    }
}

object arriba{
    method siguiente(posicion){
        if (posicion.y() < game.width()-1){
            return posicion.up(1)
        } else {
            return posicion
        }
    }
}