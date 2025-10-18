import wollok.game.*
import personaje.*
import randomizer.*

class Botiquin {
    var property position = game.at(7,5)
    var property curacionQueAporta = 20 // La idea es que tenga 2 o 3 valores randoms ej:
                                        // (20,50,80 dependiendo del daño de enemigos)

    method image(){
        return "botiquin1.png"
    }

    method colisionarConPersonaje(){
        personaje.curarCon(self)
        game.removeVisual(self)
    }
}

class Escopeta {

    var property position = game.at(9,7)

    method image(){
        return "escopeta.png"
    }

    method colisionarConPersonaje(){
        personaje.cambiarArma(self)
        game.removeVisual(self)
    }
}

class Metralleta {
    var property position = game.at(2,7)

    method image(){
        return "uzi.png"
    }

     method colisionarConPersonaje(){
        personaje.cambiarArma(self)
        game.removeVisual(self)
     }
}

class Lanzacohetes {
    var property position = game.at(10,10)
    
    method image(){
        return "lanzacohetes.png"
    }
}
