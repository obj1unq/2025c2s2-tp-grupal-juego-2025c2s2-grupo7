import enemigos.*
import randomizer.*

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