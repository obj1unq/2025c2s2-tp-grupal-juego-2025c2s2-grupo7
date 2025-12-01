import wollok.game.*
import config.*
import tableroYRepresentaciones.*
import nivel.*
import personaje.*
import imagenesEnPantalla.*
import drops.*
import reproductor.*

object reyDeLaPradera{
    var nivelActual = menu
    const tableroDelJuego = tablero
    const jugador = personaje
    const dropsEnElJuego = drops
    const reproductorMusica = reproductor
    const cancionVictoria = "_cancion_victoria.mp3"
    var juegoIniciado = false

    method empezarJuego(){
        configuracion.configEscenario()
        configuracion.configControles()
        configuracion.configColisiones()
        nivelActual.iniciarNivel()
        game.start()
        game.schedule(1000, {reproductorMusica.reproducirCancion(nivelActual.cancion())})
    }

    method pasarMenu(){
        if (!juegoIniciado){
            juegoIniciado = true
            self.pasarASiguienteNivel()
        }
    }

    method pasarASiguienteNivel(){
        self.limpiarNivelActual()
        jugador.volverAPosicionInicial()
        nivelActual = nivelActual.siguienteNivel()
        self.iniciarSiguienteNivel()
    }

    method reiniciarNivel(){
        reproductorMusica.detenerCancion()
        nivelActual.reiniciarEnemigos()
        dropsEnElJuego.borrarDrops()
        reproductorMusica.reproducirCancion(nivelActual.cancion())
    }

    method iniciarSiguienteNivel(){
        nivelActual.iniciarNivel()
        reproductorMusica.reproducirCancion(nivelActual.cancion())
    }

    method limpiarNivelActual(){
        reproductorMusica.detenerCancion()
        tableroDelJuego.limpiarTablero()
    }

    method perderJuego(){
        game.removeVisual(vidas)
        game.addVisual(gameOver)
        game.stop()
    }

    method ganarJuego(){
        reproductorMusica.detenerCancion()
        reproductorMusica.reproducirCancion(cancionVictoria)
        game.removeVisual(vidas)
        game.addVisual(youWin)
        game.schedule(500, {game.stop()})
    }
}