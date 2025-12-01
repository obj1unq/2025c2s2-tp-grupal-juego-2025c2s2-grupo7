import wollok.game.*
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

object gargolaFactory{
    const randomizador = randomizer

    method crear(){
        return new Gargola(position = randomizador.posicionVaciaCentral())
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

object vampiroFactory{
    const randomizador = randomizer

    method crear(){
        return new Vampiro(position = randomizador.posicionVaciaCentral())
    }
}

object zombieTutorialFactory {
    const posicionesTutorial = [game.at(2,2), game.at(14,14), game.at(2,14), game.at(14,2)]

    method crear(){
        const posicion = posicionesTutorial.anyOne()
        posicionesTutorial.remove(posicion)
        return new ZombieTutorial(position = posicion)
    }
}

// DROPS

object vidaFactory {
	method crear(_position) {
		return new VidaDrop(position= _position)
	}
}

object nuclearFactory {
	method crear(_position) {
		return new NuclearDrop(position= _position)
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

object arcoFactory {
	method crear(_position) {
		return new ArcoDrop(position = _position)
	}
}

// ELEMENTOS DEL MAPA

object muroFactory {
    method crear(posicion) {
        return new Elemento(image="elemento_muro.png", position=posicion)
    }
}

object arbustoFactory {
    method crear(posicion) {
        return new Elemento(image="elemento_arbusto.png", position=posicion)
    }
}

object troncoFactory {
    method crear(posicion) {
        return new Elemento(image="elemento_tronco.png", position=posicion)
    }
}

object sepulcroFactory {
    method crear(posicion) {
        return new Elemento(image="elemento_sepulcro.png", position=posicion)
    }
}

object cactusFactory {
    method crear(posicion) {
        return new Elemento(image="elemento_cactus.png", position=posicion)
    }
}