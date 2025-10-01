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
    var property image = "arma.png"
    const persona = personaje 
    var danio = 2

    method disparar(direccion){
        game.removeTickEvent("Arma dispara")
        game.onTick (100, "Arma dispara", {self.balaViajando(direccion)})
    }

    method balaViajando(direccion){
        position = direccion.siguiente(position)
    }

    method colisionarCon(monstruo){
        monstruo.recibirDanio(danio)
        game.removeTickEvent("Arma dispara")
        position = game.at(7,7)
    }
}

object monstruo{
    var property position = game.at(14, 7)
    var property image= "Baddy1.png"
    
    method recibirDanio (numero){
    }
}