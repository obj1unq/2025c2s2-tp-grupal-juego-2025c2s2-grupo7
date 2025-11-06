import enemigos.*
import randomizer.*
import elementosDelMapa.*

object zombieFactory{
    method crear(ejercito){
        const _position = randomizer.posicionVaciaCentral()
        return new Zombie(position = _position , ejercito = ejercito)
    }
}

object minotauroFactory{
    method crear(ejercito){
        const _position = randomizer.posicionVaciaCentral()
        return new Minotauro(position = _position, ejercito = ejercito)
    }
}

object vampiroFactory{
    method crear(ejercito){
        const _position = randomizer.posicionVaciaCentral()
        return new Vampiro(position = _position, ejercito = ejercito)
    }
}

object acorazadoFactory{
    method crear(ejercito){
        const _position = randomizer.posicionVaciaCentral()
        return new Acorazado(position = _position, ejercito = ejercito)
    }
}

object muroFactory {
    method crear(posicion) {
        return new ElementoDelMapa(image="muro.png", position=posicion)
    }
}