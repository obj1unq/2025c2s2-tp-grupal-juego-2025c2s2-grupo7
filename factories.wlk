import enemigos.*
import randomizer.*
import elementosDelMapa.*
import drops.*

// ENEMIGOS

object zombieFactory{
    const randomizador = randomizer

    method crear(){
        return new Zombie(position = randomizador.posicionVaciaCentral())
    }
}

object minotauroFactory{
    const randomizador = randomizer

    method crear(){
        return new Minotauro(position = randomizador.posicionVaciaCentral())
    }
}

object vampiroFactory{
    const randomizador = randomizer

    method crear(){
        return new Vampiro(position = randomizador.posicionVaciaCentral())
    }
}

object acorazadoFactory{
    const randomizador = randomizer

    method crear(){
        return new Acorazado(position = randomizador.posicionVaciaCentral())
    }
}

object momiaFactory{
    const randomizador = randomizer

    method crear(){
        return new Momia(position = randomizador.posicionVaciaCentral())
    }
}

// DROPS

object vidaFactory {
	method crear(_position) {
		return new VidaDrop(position= _position)
	}
}

object escopetaFactory {
    method crear(_position){
        return new EscopetaDrop(position = _position)
    }
}

object metralletaFactory {
	method crear(_position) {
		return new MetralletaDrop(position = _position)
	}
}

object lanzacohetesFactory {
	method crear(_position) {
		return new LanzacohetesDrop(position = _position)
	}
}

// ELEMENTOS DEL MAPA

object muroFactory {
    method crear(posicion) {
        return new ElementoDelMapa(image="elemento_muro.png", position=posicion)
    }
}

object arbustoFactory {
    method crear(posicion) {
        return new ElementoDelMapa(image="elemento_arbusto.png", position=posicion)
    }
}

object troncoFactory {
    method crear(posicion) {
        return new ElementoDelMapa(image="elemento_tronco.png", position=posicion)
    }
}

object sepulcroFactory {
    method crear(posicion) {
        return new ElementoDelMapa(image="elemento_sepulcro.png", position=posicion)
    }
}

object cactusFactory {
    method crear(posicion) {
        return new ElementoDelMapa(image="elemento_cactus.png", position=posicion)
    }
}

