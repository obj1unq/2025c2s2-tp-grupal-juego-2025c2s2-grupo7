import wollok.game.*
import personaje.*

object armaPrincipal{
    var position = game.at(7,7)
    const property image = "bala.png"
    const poseedor = personaje 
    const property daño = 10

    method position(){
        return position
    }

    method disparar(direccion){
        game.removeTickEvent("Arma dispara")
        game.removeVisual(self)
        position = poseedor.position()
        game.addVisual(self)
        game.onTick (100, "Arma dispara", {self.balaViajando(direccion)})
    }

    method balaViajando(direccion){
        const nuevaPosicion = direccion.siguiente(position)
        if (nuevaPosicion != position){ // La bala puede moverse a su siguiente posicion ya que esta vacía y esta dentro de los limites del mapa.
            position = nuevaPosicion
        } else { // Significa que la bala colisiono con un elemento del mapa o con el borde del mapa.
            game.removeTickEvent("Arma dispara")
            game.removeVisual(self)
            position = poseedor.position()
        }
    }

    method colisiono(){
        game.removeTickEvent("Arma dispara")
        game.removeVisual(self)
        position = poseedor.position()
    }

    method colisionarConPersonaje(personaje){} // No se hace nada. El personaje no interacciona con su bala disparada.
}