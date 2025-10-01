import direcciones.*
import wollok.game.*

object baddy {
    var vida = 10
    var image = "Baddy1.png"
    var property position = game.center()


   
    method mover(direccion) {
      //const nuevaPos = posicion.siguiente(position)
      //self.position(nuevaPos)
      position = direccion.siguiente(position) 
    }
    method image(){
		return image
	}



}




