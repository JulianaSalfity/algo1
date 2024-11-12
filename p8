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
var coordenadasDefinidas: Trie <K,V>
var complemento: Boolean

proc Crear () MatrizInfinita{
res = new MatrizInfinita
(res.coordenadasDefinidas.raiz = null
res.coordenadasDefiidas.tamaño = 0)
res.coordenadasDefinjdas.diccionarioVacio
res.complemento = True
}

proc
