import wollok.game.*
import personaje.*
import enemigos.*
import direcciones.*
import drops.*
import nivel.*

object configuracion {

    method configEscenario(){
        game.title("Rey de la pradera")
    }

    method configVisuales(){
        game.addVisual(personaje)
        game.addVisual(new Escopeta())
        game.addVisual(new Botiquin())
        game.addVisual(new Metralleta())
        game.addVisual(new Lanzacohetes())
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
    }

    method configDropeo (){
       game.onCollideDo(personaje, {drop => drop.colisionarConPersonaje()})
    }
}