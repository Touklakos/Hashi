    load "Grille.rb"
load "Case.rb"
load "Sommet.rb"
load "Arete.rb"
load "Generateur.rb"

#gene = Generateur.new("easy")
#gene = Generateur.new("normal")
#gene = Generateur.new("hard")
gene = Generateur.new(nil,10, 10, 10)
grille = gene.creeUneGrille()
#grille = gene.creeUneGrille(10)
grille.afficher()
