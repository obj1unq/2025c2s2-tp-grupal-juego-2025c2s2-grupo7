import wollok.game.*

object reproductor{
    var cancionActual = null
    
    method reproducirCancion(cancion){
        cancionActual = game.sound(cancion)
        cancionActual.shouldLoop(false)
        cancionActual.play()
    }

    method detenerCancion(){
        cancionActual.stop()
    }

    method reproducirSonido(sonido){
        game.sound(sonido).play()
    }
}