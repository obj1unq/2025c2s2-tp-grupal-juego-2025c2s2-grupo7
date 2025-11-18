import wollok.game.*
import personaje.*

object fondo{
    var property image = "fondo_nivel1.png"
    const property position = game.origin()

    method agregarFondo(){
        game.addVisual(self)
    }
}

object instrucciones {
    const property image = "instrucciones.png"
    const property position = game.at(6,2)
}

object vida{
    const property position= game.at(0,16)
    const jugador = personaje

    method image(){
        return "vidas_"+ jugador.vidas()  +".png"
    }
}

object gameOver {
    const property image = "game_over.png"
    const property position = game.at(4,5)
}