import wollok.game.*

object elementos {
    const elementosEnNivel = #{}
    const elementosDestructiblesEnNivel = #{}
    
    method agregarElemento(elemento){
        elementosEnNivel.add(elemento)
        if (!self.hayElementoDeBordeDeMapaAca(elemento.position())){
            elementosDestructiblesEnNivel.add(elemento)
        }
        game.addVisual(elemento)
    }

    method hayElementoAca (position){
        return self.hayElementoDeBordeDeMapaAca(position) or
               elementosDestructiblesEnNivel.any({elemento => elemento.position() == position})
    }

    method hayElementoDeBordeDeMapaAca(position){ // Se crea esta función para evitar recorrer el set de elementos del mapa lo más que se pueda.
        const x = position.x()
        const y = position.y()
        return ( (x == 0 or x == 16) and (y < 7 or y > 9) ) or ( (y == 0 or y == 16) and (x < 7 or x > 9) )  
        //       Es elemento del borde superior o inferior   O    Es elemento del borde derecho o izquierdo  
    }

    method limpiarElementos(){
        elementosEnNivel.forEach({elemento => game.removeVisual(elemento)})
        elementosEnNivel.clear()
        elementosDestructiblesEnNivel.clear()
    }
}

class Elemento{
    const property image
    const property position
}