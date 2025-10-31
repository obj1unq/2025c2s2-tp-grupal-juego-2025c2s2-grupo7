import enemigos.*
import randomizer.*
import elementosDelMapa.*
object zombieFactory{
    method crear(ejercito){
        const _position = randomizer.posicionVaciaCentral()
        return new Zombie(position = _position , posicionAnterior = _position, ejercito = ejercito)
    }
}

object minotauroFactory{
    method crear(ejercito){
        const _position = randomizer.posicionVaciaCentral()
        return new Minotauro(position = _position , posicionAnterior = _position, ejercito = ejercito)
    }
}

object muroFactory {
    method crear(posicion) {
        return new ElementoDelMapa(image="muro.png", position=posicion)
    }
}