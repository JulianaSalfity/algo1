1-
Producto es string Monto es Z Fecha es Z (segundos desde 1/1/1970)
TAD Comercio {
obs ventasPorProducto: dict⟨P roducto, seq⟨⟨F echa, Monto⟩⟩⟩
}
Modulo ComercioImpl implementa Comercio <
var ventas: SecuenciaImpl<tupla<Producto, Fecha, Monto>>
var totalPorProducto: DiccionarioImpl<Producto, Monto>
var ultimoPrecio: DiccionarioImpl<Producto, Monto>
>

Invariante de Representación 
Las claves de totalPorProducto y ultimoPrecio son las mismas, los Producto de ventas pertenecen a las claves de totalPorProducto y ultimoPrecio, la suma de todos lo montos registrados en ventas asociados a un mismo producto es igual al valor de ese producto en totalPorProducto. El ultimo monto regisrado asociado a un producto en ventas (con la fecha más alta) es igual al valor de ultimoPrecio de ese producto.

pred invRep (in c = ComercioImpl){
    ∀ k:key  k ∈ c.ultimoPreci <-> k ∈ c.totalPorProducto
    ∀ p:producto y ∀ v:int (0<= v < c.ventas.lenght) if c.ventas[v].producto = p -> p ∈ c.ultimoPrecio && p ∈ c.totalPorProducto
    ∀ p:producto y ∀ v:int (0<= v < c.ventas.lenght) if c.ventas[v].producto = p sumatoria c.ventas[v].monto = c.totalPorProducto(p)
    ∀ p:producto ∃ v:int (0<= v < c.ventas.lenght) && c.ventas[v].producto = p && esLaMaxima (c.ventas[v].fecha ) -> 
    c.ventas[v].monto = c.ultimoPrecio(p)
}

Funcion de Abstraccion
Las claves del atributo del TAD son las misma que las de totalPorProducto y ultimoPrecio, todo elemento tipo producto de ventas pertenece a las claves de ventasPorProducto. Las fechas y montos registrados en ventasPorProducto son las mismas que la segunda y tercer componente de ventas.

pred Abs (in c = ComercioImpl, in C = Comercio){
    ∀ k:key  k ∈ c.ultimoPrecio, k ∈ c.totalPorProducto -> k ∈ C.ventasPorProducto
    ∀ p:producto y ∀ v:int (0<= v < c.ventas.lenght) if c.ventas[v].producto = p -> p ∈ C.ventasPorProducto
    ∀ p:producto y ∀ v:int (0<= v < c.ventas.lenght) if c.ventas[v].producto = p -> <c.ventas[v].fecha,c.ventas[v].monto> ∈ C.ventasPorProducto(p)
}

Ejercicio 5. 
El TAD Matriz infinita de booleanos tiene las siguientes operaciones:
Crear, que crea una matriz donde todos los valores son falsos.
Asignar, que toma una matriz, dos naturales (fila y columna) y un booleano, y asigna a este ultimo en esa coordenada.
(Como la matriz es infinita, no hay restricciones sobre la magnitud de fila y columna.)
Ver, que dadas una matriz, una fila y una columna devuelve el valor de esa coordenada. (Idem.)
Complementar, que invierte todos los valores de la matriz.

Ejemplo de uso del modulo:
MatrizInfinita M := Crear()
bool b1 := Ver(M, 0, 0)
Asignar(M, 1, 3, False)
Asignar(M, 100, 5000, True)
bool b2 := M.Ver(100, 5000)
Complementar(M)
bool b3 := Ver(M, 394, 788)
bool b4 := Ver(M, 100, 5000)
Tras lo que deberıamos tener
b1 = False
b2 = True
b3 = True
b4 = False

Elija la estructura (diccionario) y escriba los algoritmos de modo que las operaciones Crear, Ver y Complementar tomen O(1) tiempo
en peor caso.

Diccionario digital

Trie
var raiz = Nodo
var tamaño = int

Modulo Matriz infinita implementa Matriz{
var coordenadasDefinidas: Trie <tupla<int,int>,boolean>
var complemento: Boolean

proc Crear () MatrizInfinita{
res = new MatrizInfinita                                        O(1)
(res.coordenadasDefinidas.raiz = null
res.coordenadasDefinidas.tamaño = 0)
res.coordenadasDefinidas.diccionarioVacio                       O(1)
res.complemento = True                                          O(1)
}

proc Asignar(inout M:matrizInfinita, in fila :int, int columna: int, in bool : boolean){
     M.coordenadasDefinidas.definir(<fila,columna>) = bool      O(1)
}

proc Ver(inout M:matrizInfinita, in fila :int, int columna: int)boolean{
    if M.coordenadasDefinidas.esta(<fila,columna>){
        return M.coordenadasDefinidas.obtener(<fila,columna>)   O(1)
    }
    else{
        return M.complemento                                    O(1)
    }

proc Complementar(inout M: matrizInfinita){
    M.complemento = !M.complemento                              O(1)
    it = M.coordenadasDefinidas.iterador
    while it.haySiguiente(){
        M.coordenadasDefinidas(it) = !M.coordenadasDefinidas(it)     //acotado por la cantidad de claves 
        it = it.siguiente                                                            O(k) -> O(1)
         }
}
}


Ejercicio 6. 
Una matriz finita posee las siguientes operaciones:
Crear, con la cantidad de filas y columnas que albergara la matriz.
Definir, que permite definir el valor para una posicion valida.
#Filas, que retorna la cantidad de filas de la matriz.
#Columnas, que retorna la cantidad de columnas de la matriz.
Obtener, que devuelve el valor de una posicion valida de la matriz (si nunca se definio la matriz en la posicion solicitada
devuelve cero).
SumarMatrices, que permite sumar dos matrices de iguales dimensiones.
Dado n y m son la cantidad de elementos no nulos de A y B, respectivamente, disene un modulo (elegir una estructura
y escribir los algoritmos) para el TAD MatrizFinita de modo tal que dadas dos matrices finitas A y B,
(a) Definir y Obtener aplicadas a A se realicen cada una en Θ(n) en peor caso, y
(b) SumarMatrices aplicada a A y B se realice en Θ(n + m) en peor caso.

Modula MatrizF implementa MatrizFinita{
    var posicionesDefinidas : DiccionarioLineasl <<int,int>,v>
    var dimensiones : <int,int>

proc Crear(in filas:int, in columnas:int)MatrizF{
    res.posicionesDefinidas.diccionarioVacio
    res.dimensiones = <filas,columnas>
    }

proc Definir(inout M: MatrizF, in fila: int , in columna: int, in valor: v){
    if esPosicionValida(fila,columna,M.dimensiones){
        M.posicionesDefinidas.definir(<fila,columna>)= valor;
    }
}

proc Obtener(in M:MatrizF,in fila:int, in columna:int)v{
    if esPosicionValida(fila,columna,M.dimensiones){
        if M.posicionesDefinidas.pertenece(<fila, columna>){

            return M.posicionesDefinidas.obtener(<fila, columna>)
        }
        else{

            return 0
        }
    }
    else{
        return 0
    }
}
 
proc #filas(in M:MatrizF)int{
    return M.dimensiones[0]
}
 
proc #columnas(in M:MatrizF)int{
    return M.dimensiones[1]
}

proc SumarMatrices(inout A:MatrizF, in B:MatrizF){
    <int,int> it = A.posicionesDefinidas.iterador
    while (it.haySiguiente()){
        if B.posicionesDefinidas.pertenece(it){
            A.posicionesDefinidas(it) = A.obtener(A,it[0],it[1]) + B.obtener(B,it[0],it[1])
        }
        it = it.siguiente
    }
    <int,int> it2 = B.posicionesDefinidas.iterador
    while (it.haySiguiente()){
        if A.posicionesDefinidas.pertenece(it2) == false{
            A.posicionesDefinidas(it2) = B.obtener(A,it[0],it[1])
        }
    }
}

}

Ejercicio 7. Considere la siguiente especificacion
Vagon es string
Tren es seq⟨Vagon⟩
TAD PlayaDeManiobras {
obs trenes: seq⟨Tren⟩
proc abrirPlaya (in capacidad : Z) : PlayaDeManiobras {
requiere {capacidad > 1}
asegura {|ret.trenes| = capacidad ∧ (∀i : Z)(0 ≤ i < capacidad) →L (ret.trenes[i] = [])}
}
proc recibirTren (inout pdm : PlayaDeManiobras, in t : Tren) : Z {
requiere {(∃v : Z)(0 ≤ v < |pdm.trenes|) ∧L (pdm.trenes[v] = []) ∧ pdm = pdm0}
requiere {TodosLosVagonesSonDistintos(pdm, t)}
asegura {(∃v)(0 ≤ v < |pdm0.trenes|) ∧L
(pdm0.trenes[v] = [] ∧ pdm.trenes = setAt(pdm0.trenes, v, t)) ∧ ret = v}
}
proc despacharTren (inout pdm : PlayaDeManiobras, in v) : Z {
requiere {(0 ≤ v < |pdm.trenes|) ∧L (pdm[v] ̸= []) ∧ pdm = pdm0}
asegura {pdm.trenes = setAt(pdm0.trenes, v, [])}
}
proc unirTrenes (inout pdm : PlayaDeManiobras, in via1 : Z, in via2) : Z {
requiere {(0 ≤ via1 < |pdm.trenes|) ∧ 0 ≤ via2 < |pdm.trenes|}
requiere {pdm.trenes[via1] ̸= [] ∧ pdm.trenes[via2] ̸= []}
requiere {via1 ̸= via2}
requiere {pdm = pdm0}
asegura {|pdm| = |pdm0|}
asegura {pdm.trenes[via1] = concat(pdm0.trenes[via1], pdm0.trenes[via2])}
asegura {pdm.trenes[via2] = []}
asegura {(∀v : Z)(0 ≤ v < |pdm.trenes| ∧ v ̸= via1 ∧ v ̸= via2) →L
(pdm.trenes[v] = pdm0.trenes[v])}
}
proc moverVagon (inout pdm: PlayaDeManiobras, in vagon: Vagon, in viaOrigen: Z, in viaDestino: Z) {
requiere {0 ≤ viaOrigen, viaDestino < |pdm.trenes|}
requiere {vagon ∈ pdm.trenes[viaOrigen]}
requiere {pdm = pdm0}
asegura {|pdm| = |pdm0|}
asegura {vagon ̸∈ pdm.trenes[viaOrigen]}
asegura {vagon ∈ pdm.trenes[viaDestino]}
asegura {(∀v : Z)(0 ≤ v < |pdm.trenes| ∧ v ̸= viaDestino ∧ vagon ̸∈ pdm0.trenes[v]) →L
(pdm.trenes[v] = pdm0.trenes[v])}
}
pred TodosLosVagonesSonDistintos (pdm: PlayaDeManiobras, t: Tren) {
(∀vi : Z)(0 ≤ vi < pdm.trenes) →L
(∀vg : V agon´ )(vg ∈ pdm.trenes[vi] → vg /∈ t) ∧ (vg ∈ t → vg /∈ pdm.trenes[vi])
}
}
1. Implementar el TAD PlayaDeManiobras usando listas enlazadas y arreglos.
2. Calcular la complejidad de las operaciones en peor caso en funcion de la cantidad de vıas v y el largo del tren mas
largo t
3. Si la complejidad calculada para las operacion moverVagon() es mayor a O(t) y/o la de unirTrenes() es mayor a
O(1), modifique la estructura para lograr estas complejidades

Implementar el TAD PlayaDeManiobras usando listas enlazadas y arreglos.
Vagon es string
Tren es Vector <vagon>
Modulo PDMImpl Implementa PlayaDeManiobras{
    var trenes : ListaEnlazada <tren>

proc abrirPlaya(in capacidad: int)PDMImpl{  //O(capacidad)
    int i = 0
    while i < capacidad{
        Tren trenNuevo = new Tren
        res.trenes.agregarAtras(trenNuevo)
        i++
    }

}    
proc recibirTren(inout pdm:PDMImpl,in t : Tren)int{ //O(n^2)
    Tren it = pdm.trenes.iterador
    int i = 0
    while (it.haySiguiente){ //O(n)
        if |it.valor| == 0{
            pdm.trenes.modificarPosicion(i,t) //O(n)
            skip/break
        }
        else{
            i++
            it = it.siguiente
        } 

    }
    return i
}

proc despacharTren (inout pdm:PDMImpl, in v:int){//como v<n-> O(n)
    Tren it = pdm.trenes.iterador
    int i = 0
    while i < v{  //O(v)
        it = it.siguiente
    }
    pdm.trenes.elimiar(it) //O(n)
}

proc unirTrenes(inout pdm:PDMImpl, in via1:int, in via2:int){

}
}

Vagon es string
Tren es ListaEnlazada <vagon>
Modulo PDMImpl Implementa PlayaDeManiobras{
    var trenes : Vector <tren>

proc abrirPlaya(in capacidad: int)PDMImpl{  //O(capacidad)
    int i = 0
    while i < capacidad{
        Tren trenNuevo = new Tren
        res.trenes[i] = trenNuevo
        i++
    }
}

proc recibirTren(inout pdm:PDMImpl,in t : Tren)int{ //O(n)
    int i = 0
    while (i < pdm.trenes.size ){ //O(n)
        if |pdm.trenes[i]| == 0{
            pdm.trenes[i] = t //O(1)
            skip/break
        }
        else{
            i++
        } 

    }
    return i
}

proc despacharTren (inout pdm:PDMImpl, in v:int){//como v<n-> O(n)
    pdm.trenes[v] = new Tren //O(1)
}

proc unirTrenes(inout pdm:PDMImpl, in via1:int, in via2:int){ //O(1) Cosultar por problema de aliasing
    primerosVagones = pdm.trenes[via1]  
    ultimosVagones = pdm.trenes[via2]
    pdm.trenes[via2] = new Tren  //O(1)
    nuevosVagones = unir(primerosVagones,ultimosVagones)
    pdm.trenes[via1] = nuevosVagones //O(1)
}

aux unir(lista1: ListaEnlazada, lista2: ListaEnlazada){
    lista1.ultimo.siguiente = lista2.primero //O(1)
    lista1.ultimo = lista2.ultimo //O(1)
    return lista1
}

proc moverVagon(inout pdm: PDMImpl,in vagon: Vagon,in viaOrigen: int, in viaDestino: int){ //O(n)
    trenMenor = pdm.trenes[viaOrigen]
    trenMayor =  pdm.trenes[viaDestino]
    trenMenor.elimiar(vagon) //O(n)
    trenMayor.agregarAtras(vagon) //O(1)
}
}

Ejercicio 8. Se desea disenar un sistema de estadısticas para la cantidad de personas que ingresan a un banco. Al final del
dıa, un empleado del banco ingresa en el sistema el total de ingresantes para ese dıa. Se desea saber, en cualquier intervalo
de dıas, la cantidad total de personas que ingresaron al banco. La siguiente es una especificacion del problema.
TAD IngresosAlBanco {
obs totales: seq⟨Z⟩
proc nuevoIngresos () : IngresosAlBanco {
asegura {totalDia == []}
}
proc registrarNuevoDia (inout i: IngresosAlBanco, in cant: Z) {
requiere {cant ≥ 0}
asegura {i.totales == old(i).totales + [cant]}
}
proc cantDias (in i: IngresosAlBanco) : : Z {
asegura {res == |i.totales|}
}
proc cantPersonas (in i: IngresosAlBanco, in desde: Z, in hasta: Z) : Z {
requiere {0 ≤ desde ≤ hasta ≤ |i.totales|}
asegura {res =
Phasta
j=desde i.totales[j]}
}
}
1. Dar una estructura de representacion que permita que la funcion cantPersonas tome O(1).
2. Calcular como crece el tamano de la estructura en funcion de la cantidad de dıas que pasaron.
3. Si el calculo del punto anterior fue una funcion que no es O(n), piense otra estructura que permita resolver el problema
utilizando O(n) memoria.
4. Agregue al diseno del punto anterior una operacion mediana que devuelva el ultimo (mayor) dıa d tal que cantPersonas(i, 1, d)
≤ cantPersonas(i, d + 1,totDias(i)), restringiendo la operacion a los casos donde dicho dıa existe.
