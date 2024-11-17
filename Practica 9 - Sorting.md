Practica 9 - Sorting
Ejercicio 1. Comparar la complejidad de los algoritmos de ordenamiento dados en la te´orica para el caso en que el arreglo a ordenar se encuentre perfectamente ordenado de manera inversa a la deseada.
INSERTION
O(n^2) -> peor caso
SELECTION
O(n^2) -> el costo no depende del orden
MERGESORT
O(n log n) -> el costo no depende del orden
QUICKSORT
O(n log n) -> tomando el n° de mitad del arreglo como pivote
HEAPSORT
O(n log n) -> el costo no depende del orden

O(n) BUCKET SORT, COUNTING SORT, RADIX SORT: Complejidad en el peor caso
* - Bucket Sort: O(n) si los datos están distribuidos uniformemente en los buckets.
* - Counting Sort: O(n) si el rango de valores (k) es pequeño en comparación con n.
* - Radix Sort: O(n) si el número de dígitos (d) es una constante.
* - Nota: Si las condiciones no se cumplen (ej. rango grande k), estas
*   complejidades pueden aumentar.
* - Resultado: Complejidad lineal bajo ciertas condiciones

Ejercicio 3. Imagine secuencias de naturales de la forma s = Concatenar(s', s''), donde s' es una secuencia ordenada de naturales y s'' es una secuencia de naturales elegidos al azar. Que metodo utilizaria para ordenar s? Justificar. (Entiendase que s' se encuentra ordenada de la manera deseada.)
Elegiría merge sort ya que es estable y eficiente, aplicado unicamente a s'' para luego concatenarla con s', de este modo la complejidad seria O(n log n), con n = cant elementos s ''



 * Ejercicio 4:
Escribir un algoritmo que encuentre los k elementos más chicos de un arreglo de dimensión n, donde k ≤ n.
 
 ¿Cuál es su complejidad temporal?
 ¿A partir de qué valor de k es ventajoso ordenar el arreglo entero primero? A partir de k = 2

 proc buscarKMinimos (array s, int k) array{ //O(n log n + k)
    s_O = merge(s) //O(n log n)
    res = new int[] //O(1)
    int i = 0       //O(1)
    while i <= k do   //O(k)
        res.append(s_O[i])
        i++
 }

 * Ejercicio 7
 Algoritmo para reposicionar escaleras dentro de un arreglo 
 Criterios:
Es una escalera si la posicion siguiente tiene como valor la posición anterior +1. Me importa ubicar primero las escaleras con mayor longitud, si tienen la misma longitud se ordenan según el menor primer valor de la escalera
 Idea de algoritmo:
 Usar buckets para escaleras de tamaño n y luego ordenarlas en mis buckets y rearmar el arreglo.

 proc escaleras(array s)array{ //O(n)
    s_B = bucket(s) //ordenar s según la longitud de escaleras, armar listas enlazadas de arreglos segun el tamaño del arreglo. Los arreglos que estén en un mismo bucket se ordenan con radix según su primer elemento. Se devuelve la lista desde el bucket más grande hasta el más pequeño
 }
 proc escaleras(array s)array{
   arrayList listaEscaleras = []
   int i = 0
   while i < s.lenght -1{ //armo una lista de escaleras
      arrayList escalera = []
      escalera.append(s[i])
      while i < s.length - 1 && s[i] == s[i+1]-1{
         escalera.append(s[i+1])
         i++
   }
      listaEscaleras.append(escalera)
      i++
   }
   listaEscaleras_B = bucketsort(listaEscaleras) //Separo la lista en buckets segun la longitud de escalera de forma decreciente
   listaEscaleras_B_R = radixSort(listaEscaleras_B) //Ordeno los buckets según el primer numero de cada escalera de forma creciente
 }
 // Paso 4: Reconstruir el arreglo ordenado a partir de los buckets
    array resultado = []
    for (bucket in listaEscaleras_B_R) do
        for (escalera in bucket) do
            resultado.extend(escalera)   ---> NECESARIO???
        endfor
    endfor

    return resultado

 /*
 * Ejercicio 8:
 Suponga que su objetivo es ordenar arreglos de naturales (sobre los que no se conoce nada en especial),
 y que cuenta con una implementación de árboles AVL. 
 ¿Se le ocurre alguna forma de aprovecharla? Conciba un algoritmo que llamaremos AVL Sort.
 ¿Cuál es el mejor orden de complejidad que puede lograr?
 Ayuda: debería hallar un algoritmo que requiera tiempo O(n log d) en peor caso, donde n es la cantidad de 
 elementos a ordenar y d es la cantidad de elementos distintos.
 Para inspirarse, piense en Heap Sort (no en los detalles puntuales, sino en la idea general de este último).
 Justifique por qué su algoritmo cumple con lo pedido.

 Nodo en AVL primero se ubica como en ABB respetando las reglas derecha/izquierda y luego de ser necesario se aplican rotaciones
 Se podría usar un iterador para ir recorriendo uno a uno los elementos desde el mínimo al máximo
 
Complejidad total: 𝑂(𝑛 log 𝑑)
O(nlogd) para las inserciones. Ya que si hay repetidos se mantiene igualmente el balanceo
O(n) para el recorrido in-order.
La complejidad total es entonces 
O(nlogd), dominada por la fase de inserción.

proc AVLSort (inout s : array){
   AVL arbolAux = new AVL
   for(int i = 0, i < s.lenght, i++){ O(nlogd)
      arbolAux.insertar(s[i])
   }
   iterador it = arbolAux.iterador
   array res = []
   while (it.haySiguiente){ O(n)
      res.append(it)
      it = it.siguiente
   }
   return res
}


 * Ejercicio 9:
 Se tienen dos arreglos de números naturales, A[1..n] y B[1..m]. 
 Nada en especial se sabe de B, pero A tiene n′ secuencias de números repetidos continuos 
 (por ejemplo, A = [3333311118888877771145555], n′ = 7). 
 Se sabe además que n′ es mucho más chico que n. 
 Se desea obtener un arreglo C de tamaño n + m que contenga los elementos de A y B, ordenados.
  
  1. Escriba un algoritmo para obtener C que tenga complejidad temporal 
     O(n + (n′ + m) log(n′ + m)) en el peor caso. Justifique la complejidad de su algoritmo.

    proc ordenarDosListas(array A, array B)array{
        A_o = countingSort(A) //O(n)
        AB = concat(A_o,B) //O(n'+m)
        C = merge(AB)  //O((n'+ m) log (n'+m))
        return C
    }
  
  2. Suponiendo que todos los elementos de B se encuentran en A, escriba un algoritmo para obtener C 
     que tenga complejidad temporal O(n + n′(log(n′) + m)) en el peor caso y que utilice solamente 
     arreglos como estructuras auxiliares. Justifique la complejidad de su algoritmo.


*  Ejercicio 10

Usaría bucketsort para separar en dos buckets según turno (mañana o noche) y luego por radix ordeno según nota cada bucket

proc ordenarPalnilla(inout p: Array<alumno>){
p_O = bucketsort(p)  
}

Complejidad del algoritmo
Separación en buckets: 
O(n), ya que recorres el arreglo una sola vez.
Ordenar cada bucket: 
O(n), porque las notas tienen un rango limitado (0 a 10).
Concatenar los resultados: 
O(n), al recorrer los buckets y combinarlos.

La cota O(n) no contradice el lower bound Ω(n log n) para los algoritmos de 
ordenamiento general porque ambas cotas representan cosas diferentes y se aplican 
en contextos específicos:

1. **Teorema del lower bound (Ω(n log n)):**  
   Este teorema aplica a algoritmos de ordenamiento comparativo en el peor caso. 
   Establece que cualquier algoritmo que ordene elementos mediante comparaciones 
   no puede ser más eficiente que Ω(n log n) en el peor caso.

2. **Cota O(n):**  
   Esta complejidad es posible en algoritmos de ordenamiento **no comparativos**, 
   como Counting Sort, Radix Sort o Bucket Sort. Estos algoritmos no se basan en 
   comparaciones directas entre elementos y pueden lograr O(n) en ciertos casos, 
   pero dependen de restricciones específicas (e.g., rangos limitados de valores, 
   representaciones especiales).

3. **Contexto:**  
   La cota O(n) no contradice el lower bound porque este último es aplicable 
   únicamente a algoritmos que utilizan comparaciones. Si un algoritmo como 
   Counting Sort es aplicable, significa que no pertenece al conjunto de algoritmos 
   a los que afecta el teorema del lower bound.

En resumen, O(n) no contradice Ω(n log n) porque se refieren a clases distintas de 
algoritmos.


* Ejercicio 11
 Sea A[1 . . . n] un arreglo de números naturales en rango (cada elemento está en el rango de 1 a k, 
siendo k alguna constante). Diseñe un algoritmo que ordene esta clase de arreglos en tiempo O(n). 
Demuestre que la cota temporal es correcta.

Ya que tengo valores acotados en A voy a implementar countingSort para resolver el Ejercicio
Solución:
   Usaremos Counting Sort, un algoritmo de ordenamiento estable y eficiente para datos con 
   rangos acotados. Su complejidad es O(n + k), donde n es el tamaño del arreglo y k el rango máximo. 
   Como k es constante (k ≪ n), la complejidad se simplifica a O(n).

proc arregloAcotado (in s : Array, in k : int)array{
   s_C = countingSort(s) //Hace countingSort de 1 a k O(n)
   Array res = []
   int i = 0 
   while i < s_C.lenght{ //A partir de la lista de conteos los pasa a una lista resultado O(k)
      res.append(s[i])
   }
   return res
}
La cota temporal es entonces O(n+k) que equivale a O(n) ya que k es constante


* Ejercicio 12
 Se desea ordenar los datos generados por un sensor industrial que monitorea la presencia de una 
sustancia en un proceso químico. Cada una de estas mediciones es un número entero positivo. 
Dada la naturaleza del proceso se sabe que, dada una secuencia de n mediciones, 
a lo sumo ⌊√n⌋ valores están fuera del rango [20, 40].
 
Proponer un algoritmo O(n) que permita ordenar ascendentemente una secuencia de mediciones 
y justificar la complejidad del algoritmo propuesto.

Podria usar bucketSort para los n° fuera y dentro de rango. Eso sería O(n). Se que a los sumo √n valores están fuera del rango por lo tanto para cumplir la complejidad el bucket fuera de rango lo ordeno por un algoritmo que tenga como complejidad O(n^2).

proc OrdenarSensor (mediciones : Array) array{
   mediciones_B = bucketSort(mediciones) //Separo en dos buckets según si está en rango o no O(n)
   mediciones_B_enRango_R = radixSort( mediciones_B_enRango) //O(n') con n'< n
   mediciones_B_NoenRango_I = insertionSort (mediciones_B_NoenRango) //O(√n^2) = O(n)
   Array res = mediciones_B_enRango_R
   for (int i = 0, i< mediciones_B_NoenRango_I.lenght, i++){  //O(√n)
      elemento = mediciones_B_NoenRango_I[i]
      if elemento < 20{
         ubicarAntes(res,elemento) 
      }
      else{
         res.append(elemento)
      }
      return res
   }
}

/* Ejercicio 12
   Ordenar ascendentemente una secuencia de mediciones generadas por un sensor industrial. 
   Restricciones:
   - Las mediciones son números enteros positivos.
   - A lo sumo ⌊√n⌋ valores están fuera del rango [20, 40].
   
   Idea:
   Usar Bucket Sort para dividir las mediciones en dos grupos:
   1. Dentro del rango [20, 40].
   2. Fuera del rango [20, 40].
   
   - El bucket "en rango" se ordena con Radix Sort (O(n)).
   - El bucket "fuera de rango" se ordena con un algoritmo O(n²), ya que este bucket tiene a lo sumo ⌊√n⌋ elementos, 
     lo cual no afecta la complejidad asintótica total (O(n)).
   
   Complejidad total: O(n).
*/

proc OrdenarSensor(in mediciones: array): array {
    // Paso 1: Separar las mediciones en dos buckets: dentro y fuera del rango
    array mediciones_B_enRango = []
    array mediciones_B_NoenRango = []

    for (int i = 0; i < mediciones.length; i++) do
        if (mediciones[i] >= 20 && mediciones[i] <= 40) then
            mediciones_B_enRango.append(mediciones[i])
        else
            mediciones_B_NoenRango.append(mediciones[i])
        endif
    endfor

    // Paso 2: Ordenar los buckets
    // Ordenar el bucket "en rango" con Radix Sort (O(n))
    mediciones_B_enRango_R = radixSort(mediciones_B_enRango)

    // Ordenar el bucket "fuera de rango" con Insertion Sort (O(√n²) = O(n))
    mediciones_B_NoenRango_I = insertionSort(mediciones_B_NoenRango)

    // Paso 3: Combinar los resultados
    array resultado = mediciones_B_enRango_R

    for (int i = 0; i < mediciones_B_NoenRango_I.length; i++) do
        int elemento = mediciones_B_NoenRango_I[i]
        if (elemento < 20) then
            resultado.insertarAntes(elemento)  // Insertar antes de los valores en rango
        else
            resultado.append(elemento)  // Insertar después de los valores en rango
        endif
    endfor

    return resultado
}

/* Justificación de la complejidad:
   1. Separar las mediciones en dos buckets: O(n).
   2. Ordenar el bucket "en rango" con Radix Sort: O(n').
   3. Ordenar el bucket "fuera de rango" con Insertion Sort: O(√n²) = O(n).
   4. Combinar los resultados: O(√n).

   Complejidad total: O(n), dominada por la separación y ordenamiento del bucket "en rango".
*/



Ejercicio 13. Se tiene un arreglo A[1 . . . n] de T, donde T son tuplas ⟨c1 : N × c2 : string[ℓ]⟩ y los string[ℓ] 
son strings de longitud máxima ℓ. Si bien la comparación de dos N toma O(1), la comparación de dos string[ℓ] 
toma O(ℓ). Se desea ordenar A en base a la segunda componente y luego la primera.

1. Escriba un algoritmo que tenga complejidad temporal O(nℓ + n log(n)) en el peor caso. Justifique la 
   complejidad de su algoritmo.

Uso un algoritmo comparativo que lleve O(n) y por cada comparación O(ℓ) por lo tanto el total de esa parte será O(nℓ), para ordenar según la segunda componente string. Luego con mergeSort ordeno según la primer componente O(n log n). 
No encuentro algoritmos comparativos que lleven O(n), por lo tanto podría usar uno no comparativo considerando ℓ como la longitud de cada string. Por ejemplo con radixSort que tiene una complejidad O(d(n+k)) d aprox ℓ (longitud máxima de string) k = 26 (posibles valores de cada dígito) n = cantidad de elementos. Por lo tanto considerando que d no es un n° fijo ya que podría ser menor que ℓ y k si es un n° fijo,constante, mi complejidad sería O(nℓ) para esa parte de mi algoritmo.

proc ordenarArregloDeTuplas(A = array(T)){ //O(nℓ + n log(n))
   A_R = radixSort(A) //Ordeno según la segunda componente O(nℓ)
   A_R_M = mergeSort(A_R) // Ordeno según la primer componente O(n log n)
}


2. Suponiendo que los naturales de la primera componente están acotados, adapte su algoritmo para que 
   tenga complejidad temporal O(nℓ) en el peor caso. Justifique la complejidad de su algoritmo.
proc ordenarArregloDeTuplas(A = array(T)){ //O(nℓ )
   A_R = radixSort(A) //Ordeno según la segunda componente O(nℓ) y luego según la primera O(n)
}

---

Ejercicio 14. Se tiene un arreglo A de n números naturales y un entero k. Se desea obtener un arreglo B ordenado de
n × k naturales que contenga los elementos de A multiplicados por cada entero entre 1 y k, es decir, para cada 
1 ≤ i ≤ n y 1 ≤ j ≤ k se debe incluir en la salida el elemento j × A[i]. Notar que podría haber repeticiones en la 
entrada y en la salida.

a- Implementar la función:
   proc ordenarMúltiplos(in A : Array⟨N⟩, in k : N) : Array⟨N⟩
   que resuelve el problema planteado. La función debe ser de tiempo O(nk log n), donde n es el tamaño del arreglo.

b- Calcular y justificar la complejidad del algoritmo propuesto.

proc 




---

Ejercicio 15. Se tiene un arreglo A de n números naturales. Sea m := máx{A[i] : 1 ≤ i ≤ n} el máximo del arreglo. 
Se desea dar un algoritmo que ordene el arreglo en O(n log m), utilizando únicamente arreglos y variables ordinarias 
(i.e., sin utilizar listas enlazadas, árboles u otras estructuras con punteros).

a- Implementar la función:
   proc raroSort (in A: Array⟨N⟩) : Bool{
   que resuelve el problema planteado. La función debe ser de tiempo O(n log m), donde n es el tamaño del arreglo 
   y m = máx{A[i] : 1 ≤ i ≤ n
   }

b- Calcular y justificar la complejidad del algoritmo propuesto.

     





