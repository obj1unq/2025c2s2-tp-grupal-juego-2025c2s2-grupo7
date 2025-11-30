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
    const property image = "pantalla_instrucciones.png"
    const property position = game.at(6,2)
}

object vidas{
    const property position= game.at(0,16)
    const jugador = personaje

    method image(){
        return "vidas_"+ jugador.vidas()  +".png"
    }
}

object gameOver {
    const property image = "pantalla_gameOver.png"
    const property position = game.at(4,5)
}

object youWin{
    const property image = "pantalla_youWin.png"
    const property position = game.at(4,5)
}