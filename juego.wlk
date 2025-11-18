import wollok.game.*
import elementosDelMapa.*
import config.*
import drops.*
import nivel.*
import personaje.*
import imagenesEnPantalla.*

object reyDeLaPradera{
    var nivelActual = primerNivel
    const elementosEnElMapa = elementos

    method empezarJuego(){
        configuracion.configEscenario()
        configuracion.configControles()
        configuracion.configVisuales()
        configuracion.configColisiones()
        nivelActual.jugarNivel()
        game.start()
    }

    method terminarNivel(){
        elementosEnElMapa.limpiarNivel()
        drops.borrarDrops()
        personaje.volverAPosicionInicial()
        nivelActual = nivelActual.siguienteNivel()
        game.removeVisual(vida)
        nivelActual.jugarNivel()

    }

    method reiniciarNivel(){
        nivelActual.reiniciarNivel()
        drops.borrarDrops()
    }

    method perderJuego(){
        game.addVisual(gameOver)
        game.stop()
    }
}
