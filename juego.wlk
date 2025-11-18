import wollok.game.*
import elementosDelMapa.*
import config.*
import drops.*
import nivel.*
import personaje.*
import imagenesEnPantalla.*

object reyDeLaPradera{
    var nivelActual = menu
    const elementosEnElMapa = elementos

    method empezarJuego(){
        configuracion.configEscenario()
        configuracion.configControles()
        configuracion.configColisiones()
        nivelActual.jugarNivel()
        game.start()
        game.schedule(1000, {reproductorMusica.reproducir(nivelActual.cancion())})
    }

    method pasarASiguienteNivel(){
        reproductorMusica.parar(nivelActual.cancion())
        elementosEnElMapa.limpiarNivel()
        drops.borrarDrops()
        personaje.volverAPosicionInicial()
        nivelActual = nivelActual.siguienteNivel()
        game.removeVisual(vidas)
        nivelActual.jugarNivel()
        reproductorMusica.reproducir(nivelActual.cancion())
    }

    method reiniciarNivel(){
        reproductorMusica.parar(nivelActual.cancion())
        nivelActual.reiniciarNivel()
        drops.borrarDrops()
        reproductorMusica.reproducir(nivelActual.cancion())
    }

    method perderJuego(){
        game.removeVisual(vidas)
        game.addVisual(gameOver)
        game.stop()
    }
}

object reproductorMusica{
    method reproducir(cancion){
        cancion.shouldLoop(true)
        cancion.play()
    }

    method parar(cancion){
        cancion.stop()
    }
}