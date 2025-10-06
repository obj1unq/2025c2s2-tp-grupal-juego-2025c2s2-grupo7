import direcciones.*
import wollok.game.*


class Enemigo {
  var image 
  var position 
  var vida
  var posicionAnterior

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
      posicionAnterior = position
      self.perseguirHorizontal(personaje)
    } else {
      posicionAnterior = position
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
  
  method colisionarCon(objeto){
    position = posicionAnterior
  }

  method aplicarDaño(_daño){
   if(vida > _daño){
    vida = vida - _daño
   }else {
    self.muerte()
   }
  }

  method muerte (){
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

const basico = new Enemigo(image = "enemigoBasico1.png",position = game.at(1,1),vida = 10,posicionAnterior = game.at(1,1))

const basico2 = new Enemigo(image = "enemigoBasico1.png",position = game.at(7,14),vida = 10,posicionAnterior = game.at(7,14))

const basico3 = new Enemigo(image = "enemigoBasico1.png",position = game.at(7,0),vida = 10,posicionAnterior= game.at(7,0))

const basico4 = new Enemigo(image = "enemigoBasico1.png",position = game.at(0, 7),vida = 10,posicionAnterior= game.at(0,7))