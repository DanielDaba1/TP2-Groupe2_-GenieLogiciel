using System;

namespace GestionPersonneLib
{
    public class Adresse
    {
        public int Id { get; set; }
        public string Quartier { get; set; }
        public string Commune { get; set; }
        public string Ville { get; set; }
        public string Pays { get; set; }

        public Adresse()
        {
        }

        public Adresse(int id, string quartier, string commune, string ville, string pays)
        {
            Id = id;
            Quartier = quartier;
            Commune = commune;
            Ville = ville;
            Pays = pays;
        }
    }

    

}