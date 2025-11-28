import wollok.game.*
import personaje.*
import movimiento.*
import tableroYRepresentaciones.*
import imagenesEnPantalla.*
import armas.*
import juego.*

object configuracion {
    const tableroDelJuego = tablero
    const juego = reyDeLaPradera

    method configEscenario(){
        game.height(tableroDelJuego.height())
        game.width(tableroDelJuego.width())
        game.cellSize(tableroDelJuego.cellSize())
        game.title("Rey de la pradera") // Esto tal vez hay que cambiarlo y moverlo al objeto reyDeLaPradera.
        fondo.agregarFondo()
    }

    method configVisualesEmpezarJuego(){
        game.addVisual(personaje)
        game.addVisual(vidas)
        game.addVisual(instrucciones)
        game.schedule(10000, {game.removeVisual(instrucciones)})
    }

    method configControles(){
        keyboard.w().onPressDo({personaje.mover(arriba)})
        keyboard.s().onPressDo({personaje.mover(abajo)})
        keyboard.a().onPressDo({personaje.mover(izquierda)})
        keyboard.d().onPressDo({personaje.mover(derecha)})
        keyboard.up().onPressDo({personaje.disparar(arriba)})
        keyboard.down().onPressDo({personaje.disparar(abajo)})
        keyboard.left().onPressDo({personaje.disparar(izquierda)})
        keyboard.right().onPressDo({personaje.disparar(derecha)})
        keyboard.space().onPressDo({personaje.cambiarArma()})
        keyboard.enter().onPressDo({juego.pasarASiguienteNivel()})
    }

    method configColisiones(){
        game.onCollideDo(personaje, {objeto => objeto.colisionarConPersonaje(personaje)})
        game.onCollideDo(municionNormal, {objeto => objeto.colisionarConBala(municionNormal)})
        game.onCollideDo(flechaPenetrante, {objeto => objeto.colisionarConBala(flechaPenetrante)})
        game.onCollideDo(municionVeloz, {objeto => objeto.colisionarConBala(municionVeloz)})
        game.onCollideDo(cartucho, {objeto => objeto.colisionarConBala(cartucho)})
        game.onCollideDo(municionExplosiva, {objeto => objeto.colisionarConBala(municionExplosiva)})
    }
}