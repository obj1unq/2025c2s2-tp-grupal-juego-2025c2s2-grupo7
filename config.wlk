import wollok.game.*
import personaje.*
import enemigos.*
import movimiento.*
import drops.*
import nivel.*

object configuracion {

    method configEscenario(){
        game.title("Rey de la pradera") // Esto tal vez hay que cambiarlo y moverlo al objeto reyDeLaPradera.
    }

    method configVisuales(){
        game.addVisual(personaje)
    }

    method configPersonaje(){
        keyboard.w().onPressDo({personaje.mover(arriba)})
        keyboard.s().onPressDo({personaje.mover(abajo)})
        keyboard.a().onPressDo({personaje.mover(izquierda)})
        keyboard.d().onPressDo({personaje.mover(derecha)})
        keyboard.up().onPressDo({personaje.disparar(arriba)})
        keyboard.down().onPressDo({personaje.disparar(abajo)})
        keyboard.left().onPressDo({personaje.disparar(izquierda)})
        keyboard.right().onPressDo({personaje.disparar(derecha)})
        keyboard.q().onPressDo({personaje.cambiarArma()})
    }

    method configDropeo (){
       game.onCollideDo(personaje, {drop => drop.colisionarConPersonaje()})
    }
}