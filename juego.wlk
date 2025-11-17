import elementosDelMapa.*
import wollok.game.*
import enemigos.*
import config.*
import drops.*
import nivel.*
import personaje.*

object reyDeLaPradera{
    var nivelActual = primerNivel
    const elementos = elementosDelMapa

    method empezarJuego(){
        configuracion.configEscenario()
        configuracion.configPersonaje()
        configuracion.configVisuales()
        configuracion.configColisiones()
        nivelActual.jugarNivel()
        game.start()
    }

    method terminarNivel(){
        elementos.limpiarNivel()
        drops.borrarDrops()
        personaje.volverAPosicionInicial()
        nivelActual = nivelActual.siguienteNivel()
        nivelActual.jugarNivel()
    }

    method reiniciarNivel(){
        nivelActual.reiniciarNivel()
        drops.borrarDrops()
    }

    method perderJuego(){
        game.stop()
    }
}