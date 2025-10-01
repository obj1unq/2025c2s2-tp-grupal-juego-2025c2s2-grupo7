import wollok.game.*

object personaje{
    var property position = game.at(7,7)
    var property image = "Boss1.png"
    var vida = 5

    method mover(direccion){
        position = direccion.siguiente(position)
    }

    method disparar(direccion){
        arma.disparar(direccion)
    }

    method colisionarCon(monstruo){
        vida = vida - monstruo.danio()
    }
}

object arma{
    var property position = game.at(7,7)
    var property image = "bala3.png"
    const poseedor = personaje 
    const danio = 2

    method disparar(direccion){
        position = poseedor.position()
        game.addVisual(self)
        game.removeTickEvent("Arma dispara")
        game.onTick (100, "Arma dispara", {self.balaViajando(direccion)})
    }

    method balaViajando(direccion){
        if (position.x().between(1,13) and position.y().between(1,13)){
            position = direccion.siguiente(position)
        } else {
            game.removeTickEvent("Arma dispara")
            game.removeVisual(self)
            position = poseedor.position()
        }
    }

    method colisionarCon(enemigo){
        enemigo.recibirDanio(danio)
        game.removeTickEvent("Arma dispara")
        game.removeVisual(self)
        position = poseedor.position()
    }
}

object monstruoPrueba{
    var property position = game.at(14, 7)
    var property image= "Baddy1.png"
    
    method recibirDanio (numero){
    }
}