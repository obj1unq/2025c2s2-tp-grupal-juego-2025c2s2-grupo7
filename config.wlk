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
        keyboard.up().onPressDo({self.armaDispara(arriba)})
        keyboard.down().onPressDo({self.armaDispara(abajo)})
        keyboard.left().onPressDo({self.armaDispara(izquierda)})
        keyboard.right().onPressDo({self.armaDispara(derecha)})
    }

    method armaDispara(direccion){
        game.removeTickEvent("Arma dispara")
        game.onTick(150, "Arma dispara", {personaje.disparar(direccion)})
    }

    method configEnemigos(){
        game.onCollideDo(basico, {objeto => objeto.colisionarCon(basico)})
        game.onCollideDo(basico2, {objeto => objeto.colisionarCon(basico2)})
        game.onCollideDo(basico3, {objeto => objeto.colisionarCon(basico3)})
        game.onCollideDo(basico4, {objeto => objeto.colisionarCon(basico4)})
    }
}