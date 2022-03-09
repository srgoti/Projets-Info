type arbre = Nil | Noeud of (bool * arbre * arbre);;



let rec cherche elt abr =
    let bin  = ref (Math.log 2 elt) in
    let rec loop elt abr mod_ =
        bin:= !bin - (bin:=
      match arb with
      | Nil -> false
      | Noeud (_, a1, a2) ->
         if !bin = 
