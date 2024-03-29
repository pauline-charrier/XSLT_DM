# XSLT_DM | 29 mars 2024
Dépôt dédié au devoir final du cours de XSLT du Master 2 "Technologies numériques appliquées à l'histoire"

## Edition numérique de cinq poèmes de Gérard de Nerval tirés des _Chimères_ (1856) et des _Odelettes_ (1853).

Le présent repository se compose comme suit : 

  - un dossier `img` comprenant deux images
  - un dossier `css` comprenant un fichier CSS externe
  - un fichier XML-TEI correspondant à l'encodage source pris en entrée
  - un feuille de style XSLT définissant les règles de transformations à appliquer
  - 10 fichiers HTML produits en sortie après application de la transformation


*Note 1* : Pour permettre l'ouverture et la bonne lecture du fichier XML-TEI, il est nécessaire d'activer la prise en charge des caractères spéciaux (symboles de l'alphabet phonétique international).

*Note 2* : Du fait de l'utilisation pour l'élaboration de la feuille de style XSLT d'une version d'oXygen ne produisant pas automatiquement une déclaration `<!DOCTYPE>` en en-tête de document pour les fichiers HTML de sortie, j'ai été contrainte de l'insérer manuellement par un `<xsl:text/>` pour chacun des templates servant à générer les fichiers de sortie. Cet ajout est susceptible de produire un document HTML non valide en cas de nouvelle compilation depuis une version d'oXygen plus récente.
