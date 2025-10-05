import wollok.game.*
import personaje.*
import enemigos.*
import direcciones.*

object configuracion {

    method configEscenario(){
        game.title("Rey de la pradera")
        game.height(15)
        game.width(15)
        game.cellSize(48)
        game.boardGround("nivel.png")
    }

    method configVisuales(){
        game.addVisual(personaje)
	    game.addVisual(basico)
        game.addVisual(basico2)
	    game.addVisual(basico3)
        game.addVisual(basico4)
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

    method configEnemigos(){
        game.onTick(500, "perseguir enemigo", {basico.perseguir(personaje)})
        game.onTick(500, "perseguir enemigo2", {basico2.perseguir(personaje)})
        game.onTick(500,"perseguir enemigo3",{basico3.perseguir(personaje)})
        game.onTick(500,"perseguir enemigo4",{basico4.perseguir(personaje)})
        game.onTick(250, "enemigo da un paso", {basico.darPaso()})
        game.onTick(250, "enemigo2 da un paso", {basico2.darPaso()})
        game.onTick(250, "enemigo3 da un paso", {basico3.darPaso()})
        game.onTick(250, "enemigo4 da un paso", {basico4.darPaso()})
        game.onCollideDo(basico, {objeto => objeto.colisionarCon(basico)})
        game.onCollideDo(basico2, {objeto => objeto.colisionarCon(basico2)})
        game.onCollideDo(basico3, {objeto => objeto.colisionarCon(basico3)})
        game.onCollideDo(basico4, {objeto => objeto.colisionarCon(basico4)})
    }
}