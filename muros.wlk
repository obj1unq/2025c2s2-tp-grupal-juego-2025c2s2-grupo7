object muros {
    const property murosTotales = #{} 
    
    method agregarMuro(unMuro) {
        murosTotales.add(unMuro)
    }
}


class Muro {
    const  image = "muro.png"
    const position

    method image(){
        return image
    }

    method position(){
        return position
    }
}