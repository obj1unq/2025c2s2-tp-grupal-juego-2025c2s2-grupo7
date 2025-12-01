import wollok.game.*
import personaje.*
import enemigos.*
import juego.*
import tableroYRepresentaciones.*
import imagenesEnPantalla.*
import config.*

class Nivel{
    const layout
    const imagenDeFondo
    const enemigosEnNivel = enemigos
    const tiempoDeSpawn = 500
    const limiteDeEnemigosEnMapa = 4
    const fondoDelNivel = fondo
    const jugador = personaje
    const property cancion = "_cancion_nivel.mp3"
    const tableroDelJuego = tablero

    method iniciarNivel(){
        fondoDelNivel.image(imagenDeFondo)
        tableroDelJuego.crearNivel(layout)
        self.iniciarSpawnDeEnemigosDelNivel()
    }

    method iniciarSpawnDeEnemigosDelNivel(){
        self.spawnearEnemigos()
        enemigos.activarEnemigos(jugador)
    }

    method spawnearEnemigos(){
        game.onTick(tiempoDeSpawn, "Spawn de enemigos del nivel", {self. intentarSpawnearSiguienteEnemigo()})
    }

    method intentarSpawnearSiguienteEnemigo(){
        if (!self.condicionDePosibleFinDeNivel()){
            if (self.hayEspacioParaSpawnearEnemigo()){
                self.spawnearSiguienteEnemigo()
            }
        } else {
            self.detenerSpawnDeEnemigos()
        }
    }

    method condicionDePosibleFinDeNivel()

    method hayEspacioParaSpawnearEnemigo(){
        return limiteDeEnemigosEnMapa > enemigosEnNivel.cantidadDeEnemigos()
    }

    method spawnearSiguienteEnemigo(){
        enemigosEnNivel.agregarEnemigo(self.enemigoASpawnear())
    }

    method enemigoASpawnear()

    method detenerSpawnDeEnemigos(){
        game.removeTickEvent("Spawn de enemigos del nivel")
    }

    method reiniciarEnemigos(){
        enemigosEnNivel.matarTodos()
        enemigos.detenerEnemigos()
        self.iniciarSpawnDeEnemigosDelNivel()
    }
}

// NIVEL FINAL (JEFE)

object nivelFinal inherits Nivel(layout = layoutNivelFinal, imagenDeFondo = "fondo_nivel4.png", cancion = "_cancion_ultimoNivel.mp3", tiempoDeSpawn = 250)
{
    const jefeDelNivel = jefeFinal
    const property enemigoASpawnear = vmp

    override method iniciarSpawnDeEnemigosDelNivel(){
        super()
        game.addVisual(jefeDelNivel)
        jefeDelNivel.activar()
    }

    override method condicionDePosibleFinDeNivel(){
        return !jefeDelNivel.estaVivo()
    }

    override method detenerSpawnDeEnemigos(){
        super()
        enemigos.matarTodos()
    }

    override method reiniciarEnemigos(){
        game.removeVisual(jefeDelNivel)
        super()
    }
}

// NIVELES CON CANTIDAD FINITA DE ENEMIGOS (Niveles previos al final.)

class NivelConCantidadFinitaDeEnemigos inherits Nivel{
    const property siguienteNivel
    const enemigosASpawnearIniciales // Un set de los enemigos que se van a spawnear en un nivel. (No se le deben eliminar o agregar elementos).
    var enemigosASpawnear = enemigosASpawnearIniciales.copy() // Un set de los enemigos que aun no se han spawneado durante la ejecución de un nivel.
    const juego = reyDeLaPradera

    override method iniciarSpawnDeEnemigosDelNivel(){
        enemigosASpawnear = enemigosASpawnearIniciales.copy()
        super()
    }

    override method condicionDePosibleFinDeNivel(){
        return enemigosASpawnear.isEmpty()
    }

    override method enemigoASpawnear(){
        const enemigoASpawnear = enemigosASpawnear.anyOne()
        enemigosASpawnear.remove(enemigoASpawnear)
        return enemigoASpawnear
    }

    override method detenerSpawnDeEnemigos(){
        super()
        self.esperarFinalDelNivel()
    }

    method esperarFinalDelNivel(){
        game.onTick(3000, "Chequeo final del nivel", {self.terminarNivel()})
    }

    method terminarNivel(){
        self.validarPuedeTerminarseNivel()
        enemigos.detenerEnemigos()
        game.removeTickEvent("Chequeo final del nivel")
        juego.pasarASiguienteNivel()
    }

    method validarPuedeTerminarseNivel(){
        if (enemigosEnNivel.quedanEnemigos()){
            self.error("")
        }
    }

    override method reiniciarEnemigos(){
        game.removeTickEvent("Chequeo final del nivel")
        super()
    }
}

object nivelTutorial inherits NivelConCantidadFinitaDeEnemigos(layout = layoutPrimerNivelYTutorial, siguienteNivel = primerNivel, imagenDeFondo = "fondo_nivel1.png",
enemigosASpawnearIniciales = [ttr, ttr, ttr, ttr]){
    const configuracionDelJuego = configuracion

    override method iniciarNivel(){
        configuracionDelJuego.configVisualesEmpezarJuego()
        super()
    }
}

const primerNivel = new NivelConCantidadFinitaDeEnemigos(layout = layoutPrimerNivelYTutorial, siguienteNivel = segundoNivel, imagenDeFondo = "fondo_nivel1.png", 
enemigosASpawnearIniciales = [zmb, zmb, zmb, zmb,
                              zmb, zmb, zmb, zmb,
                              zmb, zmb, zmb, zmb,
                              zmb, zmb, zmb, zmb,
                              acz, acz])

const segundoNivel = new NivelConCantidadFinitaDeEnemigos(layout = layoutSegundoNivel, siguienteNivel = tercerNivel, imagenDeFondo = "fondo_nivel2.png",
enemigosASpawnearIniciales = [zmb, zmb, zmb, zmb,
                              zmb, zmb, zmb, zmb,
                              zmb, zmb, zmb, zmb,
                              zmb, zmb, zmb, zmb,
                              acz, acz, mtr, mtr])

const tercerNivel = new NivelConCantidadFinitaDeEnemigos(layout = layoutTercerNivel, siguienteNivel = cuartoNivel, imagenDeFondo = "fondo_nivel3.png", 
enemigosASpawnearIniciales = [zmb, zmb, zmb, zmb,
                              zmb, zmb, zmb, zmb,
                              zmb, zmb, zmb, zmb,
                              zmb, zmb, zmb, zmb,
                              zmb, zmb, zmb, zmb,
                              ggl, ggl, ggl, ggl,
                              mtr, mtr, mtr, mtr,
                              acz, acz])

const cuartoNivel = new NivelConCantidadFinitaDeEnemigos(layout = layoutCuartoNivel, siguienteNivel = nivelFinal, imagenDeFondo = "fondo_nivel4.png", 
enemigosASpawnearIniciales = [zmb, zmb, zmb, zmb,
                              zmb, zmb, zmb, zmb,
                              zmb, zmb, zmb, zmb,
                              zmb, zmb, zmb, zmb,
                              zmb, zmb, zmb, zmb,
                              ggl, ggl, ggl, ggl,
                              ggl, ggl, ggl, ggl,
                              mtr, mtr, mtr, mtr,
                              acz, acz, mom, mom])

// MENU DEL JUEGO

object menu{
    const property siguienteNivel = nivelTutorial
    const fondoDelJuego = fondo
    const property cancion = "_cancion_menu.mp3"
    const imagenDeMenu = "pantalla_menu.png"

    method iniciarNivel(){
        fondoDelJuego.image(imagenDeMenu)
    }
}

// LAYOUT DE LOS NIVELES:

const layoutPrimerNivelYTutorial = [[b,b,b,b,b,b,b,_,_,_,b,b,b,b,b,b,b],
                                    [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
                                    [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
                                    [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
                                    [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
                                    [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
                                    [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
                                    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
                                    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
                                    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
                                    [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
                                    [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
                                    [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
                                    [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
                                    [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
                                    [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
                                    [b,b,b,b,b,b,b,_,_,_,b,b,b,b,b,b,b]].reverse()

const layoutSegundoNivel = [[b,b,b,b,b,b,b,_,_,_,b,b,b,b,b,b,b],
                           [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
                           [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
                           [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
                           [b,_,_,_,m,m,m,_,_,_,m,m,m,_,_,_,b],
                           [b,_,_,_,m,_,_,_,_,_,_,_,m,_,_,_,b],
                           [b,_,_,_,m,_,_,_,_,_,_,_,m,_,_,_,b],
                           [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
                           [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
                           [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
                           [b,_,_,_,m,_,_,_,_,_,_,_,m,_,_,_,b],
                           [b,_,_,_,m,_,_,_,_,_,_,_,m,_,_,_,b],
                           [b,_,_,_,m,m,m,_,_,_,m,m,m,_,_,_,b],
                           [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
                           [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
                           [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
                           [b,b,b,b,b,b,b,_,_,_,b,b,b,b,b,b,b]].reverse()

const layoutTercerNivel = [[b,b,b,b,b,b,b,_,_,_,b,b,b,b,b,b,b],
                           [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
                           [b,_,_,_,_,_,_,_,_,_,_,a,_,_,_,_,b],
                           [b,_,a,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
                           [b,_,_,a,_,_,_,_,_,_,_,_,_,_,_,_,b],
                           [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
                           [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
                           [_,_,_,_,_,_,_,_,_,_,a,_,_,_,_,_,_],
                           [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
                           [_,_,_,_,_,_,_,_,_,_,t,_,_,_,_,_,_],
                           [b,_,_,_,_,t,_,_,_,_,a,_,_,_,_,_,b],
                           [b,_,_,_,_,_,_,_,_,_,_,_,_,a,_,_,b],
                           [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
                           [b,_,_,t,_,_,_,_,_,_,t,_,_,a,_,_,b],
                           [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
                           [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
                           [b,b,b,b,b,b,b,_,_,_,b,b,b,b,b,b,b]].reverse()

const layoutCuartoNivel = [[b,b,b,b,b,b,b,_,_,_,b,b,b,b,b,b,b],
                           [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
                           [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
                           [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
                           [b,_,_,_,s,s,_,_,_,_,s,_,s,_,_,_,b],
                           [b,_,_,_,s,s,_,_,_,_,s,_,s,_,_,_,b],
                           [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
                           [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
                           [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
                           [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
                           [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
                           [b,_,_,_,s,s,_,_,_,_,s,_,s,_,_,_,b],
                           [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
                           [b,_,_,_,s,s,_,_,_,_,s,_,s,_,_,_,b],
                           [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
                           [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
                           [b,b,b,b,b,b,b,_,_,_,b,b,b,b,b,b,b]].reverse()

const layoutNivelFinal = [[b,b,b,b,b,b,b,s,s,s,b,b,b,b,b,b,b],
                          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
                          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
                          [b,_,_,_,_,_,_,s,s,s,_,_,_,_,_,_,b],
                          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
                          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
                          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
                          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
                          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
                          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
                          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
                          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
                          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
                          [b,_,_,_,_,_,_,s,s,s,_,_,_,_,_,_,b],
                          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
                          [b,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,b],
                          [b,b,b,b,b,b,b,s,s,s,b,b,b,b,b,b,b]].reverse()