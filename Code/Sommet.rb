class Sommet
    #@listArete
    #@position
    #@valeur
    attr_accessor :position
    attr_reader :valeur, :listeArete, :complet
    #creer un Sommet proprement
    def self.creer(valeur, position)
        objet = new(valeur, position)
        objet.completerInitialize()
        return objet
    end

    private_class_method :new
    def initialize(valeur, position)
        @valeur = valeur
        @position = position #la case dans lequel est le sommet
        @listeArete = Array.new()
        @complet = false
    end

    #ajoute self comme contenu de la case a laquelle il est et a la liste de sommet de la grille
    def completerInitialize()
        @position.ajouterContenu(self)
        @position.grille.addSommet(self)
    end

    #defini la valeur du sommet
    def setValeur(valeur)
        @valeur = valeur
    end

    #defini si un sommet est complet ou non
    def setComplet(condition)
        @complet = condition
    end

    #compte le nombre d'aretes
    def compterArete()
        total = 0
        @listeArete.each{ |arete|
            total += arete.estDouble ? 2 : 1
        }
        return total
    end

    #ajoute une arrete a la liste de ses arrete
    def ajouterArete(arete)
        @listeArete << (arete)
    end

    #retire une arrete de la liste de ses arrete
    def retirerArete(arete)
        @listeArete.delete(arete)
    end

    ## Méthode retournant le nombre de voisins d'un sommet
    #
    # === Return
    #
    # * +nb_voisins+ : Nombre de voisins du sommet
    def compterVoisins()
      nb_voisins = 0
      voisins = [false, false, false, false]

      @position.grille.sommets.each do |x|
        if @position.x > x.position.x && @position.y == x.position.y
          voisins[0] = true
        elsif @position.x < x.position.x && @position.y == x.position.y
          voisins[1] = true
        elsif @position.y > x.position.y && @position.x == x.position.x
          voisins[2] = true
        elsif @position.y < x.position.y && @position.x == x.position.x
          voisins[3] = true
        end
      end

        for bool in voisins
            if bool
                nb_voisins += 1
            end
        end

        return nb_voisins
    end

    ## Méthode testant si une case possède un sommet
    #
    # === Return
    #
    # Une Array contenant la liste des voisins du sommet
    def getListeVoisins()
      voisins = Array.new()

      (@position.x - 1).downto(-1) do |i|
        caseCourante = @position.grille.getCase(i, @position.y)
        if(hasSommet(caseCourante))
          voisins.push(caseCourante.contenu)
          break
        end
      end

      (@position.y - 1).downto(-1) do |i|
        caseCourante = @position.grille.getCase(@position.x, i)
        if(hasSommet(caseCourante))
          voisins.push(caseCourante.contenu)
          break
        end
      end

      (@position.x + 1).upto(@position.grille.longueur) do |i|
        caseCourante = @position.grille.getCase(i, @position.y)
        if(hasSommet(caseCourante))
          voisins.push(caseCourante.contenu)
          break
        end
      end

      (@position.y + 1).upto(@position.grille.largeur) do |i|
        caseCourante = @position.grille.getCase(@position.x, i)
        if(hasSommet(caseCourante))
          voisins.push(caseCourante.contenu)
          break
        end
      end

      return voisins
    end

    ## Méthode testant si une case possède un sommet
    #
    # === Paramètres
    #
    # * +uneCase+ : Case à tester
    #
    # === Return
    #
    # true si la case possède un sommet, false sinon
    def hasSommet(uneCase)
      if(uneCase != nil)
        return uneCase.contenu.class == Sommet
      else
        return false
      end
    end

    def afficher()
        print(@valeur)
    end

    ## Méthode calculant le nombre d'arêtes restantes dont un sommet a besoin afin d'être complet
    #
    # === Return
    #
    # Le nombre d'arêtes restantes
    def connectionsRestantes()
      return @valeur - @listeArete.size()
    end
end
