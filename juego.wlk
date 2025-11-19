import wollok.game.*
import config.*
import tableroYRepresentaciones.*
import nivel.*
import personaje.*
import imagenesEnPantalla.*
import drops.*

object reyDeLaPradera{
    var nivelActual = menu
    const tableroDelJuego = tablero
    const jugador = personaje
    const dropsEnElJuego = drops
    const reproductorMusica = reproductor

    method empezarJuego(){
        configuracion.configEscenario()
        configuracion.configControles()
        configuracion.configColisiones()
        nivelActual.jugarNivel()
        game.start()
        game.schedule(1000, {reproductorMusica.reproducir(nivelActual.cancion())})
    }

    method pasarASiguienteNivel(){
        self.limpiarNivelActual()
        jugador.volverAPosicionInicial()
        nivelActual = nivelActual.siguienteNivel()
        self.iniciarSiguienteNivel()
    }

    method reiniciarNivel(){
        reproductorMusica.parar(nivelActual.cancion())
        nivelActual.reiniciarEnemigos()
        dropsEnElJuego.borrarDrops()
        reproductorMusica.reproducir(nivelActual.cancion())
    }

    method perderJuego(){
        game.removeVisual(vidas)
        game.addVisual(gameOver)
        game.stop()
    }

    method iniciarSiguienteNivel(){
        nivelActual.jugarNivel()
        reproductorMusica.reproducir(nivelActual.cancion())
    }

    method limpiarNivelActual(){
        reproductorMusica.parar(nivelActual.cancion())
        tableroDelJuego.limpiarTablero()
    }
}

object reproductor{
    method reproducir(cancion){
        cancion.shouldLoop(false)
        cancion.play()
    }

    method parar(cancion){
        cancion.stop()
    }
}