import direcciones.*
import wollok.game.*


class Enemigo {
  var image = "enemigoBasico1.png"
  var position = game.at(14,7)
  var vida = 10

  method image(){
      return image
  }

  method position(){
      return position
  }

  method perseguir(personaje) {
    const distanciaHorizontal = (position.x() - personaje.position().x()).abs()
    const distanciaVertical = (position.y() - personaje.position().y()).abs()
    if (distanciaHorizontal >= distanciaVertical) {
      self.perseguirHorizontal(personaje)
    } else {
      self.perseguirVertical(personaje)
    }
  }

  method perseguirHorizontal(personaje){
    if (position.x() < personaje.position().x()){
      position = derecha.siguiente(position)
    }  else {
      position = izquierda.siguiente(position)
    } 
  }

  method perseguirVertical(personaje){
    if (position.y() < personaje.position().y()){
      position = arriba.siguiente(position)
    }  else {
      position = abajo.siguiente(position)
    } 
  }
  
  method colisionarCon(_daño){
    game.removeVisual(self)
  }

    method darPaso(){
        if (image == "enemigoBasico1.png"){
            image = "enemigoBasico2.png"
        } else {
            image = "enemigoBasico1.png"
        }
    }
}