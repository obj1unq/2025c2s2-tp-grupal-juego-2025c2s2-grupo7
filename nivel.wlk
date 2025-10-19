import wollok.game.*
import randomizer.*
import factories.*
import enemigos.*

class Nivel{
    const layout
    var enemigos
    const ejercitoDeNivel
    const tiempoDeSpawn

    method crearNivel(){
        layout.forEach({elementoDeNivel => elementoDeNivel.crear()})
    }

    method spawnearEnemigos(){
        game.onTick(tiempoDeSpawn, "Spawn de enemigos del nivel", {self. spawnearSiguienteEnemigo()})
    }

    method spawnearSiguienteEnemigo(){
        if (!enemigos.isEmpty()){
            ejercitoDeNivel.agregarEnemigo(enemigos.first())
            enemigos = enemigos.drop(1)
        } else {
            game.removeTickEvent("Spawn de enemigos del nivel")
        }
    }

    method jugarNivel(){
        self.crearNivel()
        self.spawnearEnemigos()
        ejercitoDeNivel.enemigosDanPaso()
        ejercitoDeNivel.enemigosDanPaso()
    }
}

const nivel1 = new Nivel(enemigos = [z,z,z,z], tiempoDeSpawn = 350, layout=[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                            _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                            _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                            _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                            _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                            _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                            _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                            _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                            _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                            _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                            _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                            _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                            _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                            _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                            _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                            _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                            _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                            _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                            _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                            _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_], ejercitoDeNivel = ejercito)

object z{
    method crear(ejercito){
        return zombieFactory.crear(ejercito)
    }
}

object m{
    method crear(ejercito){
        return minotauroFactory.crear(ejercito)
    }
}

object _{
    method crear(){}
}