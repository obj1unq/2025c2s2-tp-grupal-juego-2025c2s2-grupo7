import armas.*
import wollok.game.*
import personaje.*
import movimiento.*
import elementosDelMapa.*
import nivel.*

object configuracion {
    const tableroDelJuego = tablero

    method configEscenario(){
        game.height(tableroDelJuego.height())
        game.width(tableroDelJuego.width())
        game.cellSize(tableroDelJuego.cellSize())
        game.title("Rey de la pradera") // Esto tal vez hay que cambiarlo y moverlo al objeto reyDeLaPradera.
        fondo.agregarFondo()
    }

    method configVisuales(){
        game.addVisual(personaje)
        game.addVisual(instrucciones)
        game.schedule(10000, {game.removeVisual(instrucciones)})
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
        keyboard.space().onPressDo({personaje.cambiarArma()})
    }

    method configColisiones(){
        game.onCollideDo(personaje, {objeto => objeto.colisionarConPersonaje(personaje)})
        game.onCollideDo(municionNormal, {objeto => objeto.colisionarConBala(municionNormal)})
        game.onCollideDo(municionPenetrante, {objeto => objeto.colisionarConBala(municionPenetrante)})
        game.onCollideDo(municionRapida, {objeto => objeto.colisionarConBala(municionRapida)})
        game.onCollideDo(cartucho, {objeto => objeto.colisionarConBala(cartucho)})
        game.onCollideDo(municionExplosiva, {objeto => objeto.colisionarConBala(municionExplosiva)})
    }

}

object instrucciones {
    var property image = "instrucciones.png"
    var property position = game.at(8,2)
}