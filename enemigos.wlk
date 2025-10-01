import direcciones.*
import wollok.game.*

object baddy {
    var vida = 10
    var image = "Baddy1.png"
    var property position = game.at(9,4)


   
    method mover(direccion) {
      position = direccion.siguiente(position) 
    }
    method image(){
		return image
	}



}

object boss{
  var image = "Boss1.png"
  var property position = game.at(0, 4)


    method mover(direccion) {
      position = direccion.siguiente(position) 
    }
    method image(){
		return image
	}

  method perseguir(personaje){
  if (self.position().x() < personaje.position().x() && ){
  if (self.position().x() < personaje.position().x() && ){
    position = derecha.siguiente(position)
  }  else {
    position = izquierda.siguiente(position)
  } 
  if (self.position().y() < personaje.position().y()){

  }
  }
}



