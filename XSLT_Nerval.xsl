<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="2.0">
    
    <!-- 1. INSTRUCTION D'OUTPUT HTML -->
    <xsl:output method="html" indent="yes" omit-xml-declaration="yes"/>
    
    <!-- 2. DECLARATION DES VARIABLES -->
    
    
    <!-- a. Fichiers de sortie -->
    
    <xsl:variable name="accueil">
        <xsl:value-of select="concat('accueil','.html')"/>
        <!-- variable stockant le contenu de la page d'accueil  -->
    </xsl:variable>
    <xsl:variable name="poeme1">
        <xsl:value-of select="concat('poeme1','.html')"/>
        <!-- variable stockant le contenu de la page du poème "El Desdichado"  -->
    </xsl:variable>    
    <xsl:variable name="poeme2">
        <xsl:value-of select="concat('poeme2','.html')"/> 
        <!-- variable stockant le contenu de la page du poème "Myrtho"  --> 
     </xsl:variable>
    <xsl:variable name="poeme3">
        <xsl:value-of select="concat('poeme3','.html')"/> 
        <!-- variable stockant le contenu de la page du poème "Delfica" -->
    </xsl:variable>
    <xsl:variable name="poeme4">
        <xsl:value-of select="concat('poeme4','.html')"/> 
        <!-- variable stockant le contenu de la page du poème "Artémis" -->
    </xsl:variable>
    <xsl:variable name="poeme5">
        <xsl:value-of select="concat('poeme5','.html')"/> 
        <!-- variable stockant le contenu de la page du poème "Fantaisie" -->
     </xsl:variable>
    <xsl:variable name="index">
        <xsl:value-of select="concat('index','.html')"/>  
        <!-- variable stockant le contenu de la page "Index"  -->
    </xsl:variable>
    <xsl:variable name="bibliographie">
        <xsl:value-of select="concat('bibliographie','.html')"/> 
        <!-- variable stockant le contenu de la page "Bibliographie"  -->
     </xsl:variable> 
     <xsl:variable name="recueil1"> 
    <xsl:value-of select="concat('recueil1','.html')"/>  
        <!-- variable stockant la page du recueil "Les Chimères" -->
    </xsl:variable>
    <xsl:variable name="recueil2">
        <xsl:value-of select="concat('recueil2','.html')"/> 
        <!-- variable stockant la page du recueil "Odelettes" -->
    </xsl:variable>  
        
    <!-- b. Variables stockant des chemins XPath -->
    
        <!-- Chemin long vers les personnes (cf. index) -->
    <xsl:variable name="chemin_personne" select="//teiHeader/profileDesc/particDesc/listPerson"/>
    
        <!-- Chemin long vers les lieux (cf. index) -->
    <xsl:variable name="chemin_lieu" select="//teiHeader/profileDesc/settingDesc/listPlace"/>
    
    
    <!-- c. Variable stockant l'en-tête HTML, comprenant les métadonnées et le CSS --> 
    
    <xsl:variable name="header">
        <head>
            <meta name="viewport" content="width=device-width, initial-scale=1"/>
            <title>Edition numérique de cinq poèmes de Gérard de Nerval (1853 ; 1856)</title>
            <meta name="description">
                <!-- Définition de l'attribut @content -->
                <xsl:attribute name="content">
                    <xsl:value-of select="//teiHeader/fileDesc/titleStmt/title"/>
                </xsl:attribute>
            </meta>            
            <meta name="author">
                <xsl:attribute name="content">
                    <xsl:value-of select="//teiHeader/fileDesc/titleStmt/author"/>
                </xsl:attribute>
            </meta>
            <!-- Fichier CSS externe -->
            <link rel="stylesheet" type="text/css" href="css/Nerval.css"/>
        </head>
    </xsl:variable>  
    
    
    <!-- d. Variable stockant le contenu du pied de page --> 
    
    <xsl:variable name="footer">
        <footer>
            <div class="footer">
                <div class="boite_pied">
                    <i><b>Encodage TEI et transformation XSLT réalisés par Pauline Charrier dans le cadre du Master 2 "Technologies numériques appliquées
                    à l'histoire" de l'Ecole nationale des chartes.</b></i>
                    <br/>
                    <br/>
                        <b>Sous licence CC-BY-SA.</b>
                    <br/>
                    <br/>
                        Image en arrière-plan : <i>Les Chimères</i>, Gustave Moreau (1826-1898), Paris, Musée Gustave Moreau.
               </div>
            </div>
        </footer>
    </xsl:variable>
    
    <!-- e. Variable avec le css du background du body --> 
    
    <xsl:variable name="css_background">                 
        /* Arrière-plan du body */
        background-image: url('./img/moreau_chimeres_bas.jpg'); 
        background-size: cover; 
        background-position: center; 
        background-repeat: no-repeat; 
        background-attachment: fixed;
        /* Définition des marges */
        margin-right: 10%;
        margin-left: 10%; 
        margin-top: 6%;                
    </xsl:variable>
    
    <!-- f. Variable avec les liens de retour (accueil/index/bibliographie) --> 
    
    <xsl:variable name="retour_accueil">
        <i>
            <a href="{concat('./', $accueil)}">Revenir à l'accueil</a>
        </i>
    </xsl:variable>
     <xsl:variable name="retour_index">
        <i>
            <a href="{concat('./', $index)}">Visiter l'index</a>
        </i> 
    </xsl:variable>
    <xsl:variable name="retour_biblio">
        <i>
            <a href="{concat('./', $bibliographie)}">Consulter la bibliographie</a>
        </i>
    </xsl:variable> 
    
    <!-- g. Variable avec l'en-tête du <body> (titre et barre de navigation) -->
    
    <xsl:variable name="body_header">
        <div class="en_tete">
            <div class="boite_titre">
            <h1>Edition numérique de cinq poèmes de Gérard de Nerval tirés des <i>Chimères</i> (1856) et des <i>Odelettes</i> (1853)</h1>
            </div>
        </div>
        <nav>
            <ul>
                <li><a href="./{$accueil}">Accueil</a></li> 
                <!-- menu déroulant pour les recueils -->
                <li>Les recueils 
                    <ul>
                        <li>
                            <!-- Les Chimères -->
                            <a href="./{$recueil1}">
                                <xsl:value-of select="//TEI[1]/teiHeader/fileDesc/titleStmt/title[2]"/> 
                                
                            </a>
                        </li> 
                        <li>
                            <!-- Odelettes -->
                            <a href="./{$recueil2}">
                                <xsl:value-of select="//TEI[2]/teiHeader/fileDesc/titleStmt/title[2]"/> 
                            </a>
                        </li>
                    </ul>
                </li>
                <!-- menu déroulant pour les poèmes -->
                <li>Les poèmes
                    <ul>
                        <li>
                            <!-- El Desdichado -->
                            <a href="./{$poeme1}">
                            <xsl:value-of select="//TEI[1]/text/body/div1/div2[@n='1']/lg/head"/>
                            </a>
                        </li> 
                        <li>
                            <!-- Myrtho -->
                            <a href="./{$poeme2}">
                            <xsl:value-of select="//TEI[1]/text/body/div1/div2[@n='2']/lg/head"/>
                            </a>
                        </li> 
                        <li>
                            <!-- Delfica -->
                            <a href="./{$poeme3}">
                            <xsl:value-of select="//TEI[1]/text/body/div1/div2[@n='5']/lg/head"/>
                            </a>
                        </li> 
                        <li>
                            <!-- Artémis -->
                            <a href="./{$poeme4}">
                            <xsl:value-of select="//TEI[1]/text/body/div1/div2[@n='6']/lg/head"/>
                            </a>
                        </li> 
                        <li>
                            <!-- Fantaisie -->
                            <a href="./{$poeme5}">
                            <xsl:value-of select="//TEI[2]/text/body/div1/div2[@n='2']/lg/head"/>
                            </a>
                        </li> 
                    </ul>
                </li>
                <li><a href="./{$bibliographie}">Bibliographie</a></li> 
                <li><a href="./{$index}">Index des personnes et des lieux</a></li>
            </ul>
        </nav>
    </xsl:variable>   
   
    
    <!-- Fin des déclarations de variables -->   
    
    <!-- 3. APPEL DES TEMPLATES CORRESPONDANT A CHAQUE PAGE -->
    
    <xsl:template match="/">
        <xsl:call-template name="accueil"/>
        <xsl:call-template name="poeme1"/>
        <xsl:call-template name="poeme2"/>
        <xsl:call-template name="poeme3"/>
        <xsl:call-template name="poeme4"/>
        <xsl:call-template name="poeme5"/>
        <xsl:call-template name="index"/>
        <xsl:call-template name="bibliographie"/>
        <xsl:call-template name="recueil1"/>
        <xsl:call-template name="recueil2"/>
    </xsl:template>    
    
    <!-- 4.DEFINITION DES TEMPLATES -->  
    
    <!-- a. Template de la page d'accueil -->
    
    <xsl:template name="accueil">
        <xsl:result-document href="{$accueil}" method="html">
            <!-- Ajout manuel de la déclaration DOCTYPE du fait d'une version d'oXygen (?) ne le produisant pas automatiquement dans les fichiers de sortie -->
            <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>            
            <html lang="fr">
                <xsl:copy-of select="$header"/>
                <body>
                    <!-- Définition de l'attribut @style du <body> pour stocker du CSS -->
                    <xsl:attribute name="style">
                        <xsl:value-of select="$css_background"/>
                    </xsl:attribute>
                    <xsl:copy-of select="$body_header"/>
                    <div class="css_div">
                        <!-- Partie gauche pour l'image -->
                        <div class="conteneur_image">
                            <img src="img/Nerval_redim.jpg" class="image" alt="Photographie de Gérard de Nerval par Félix Nadar (vers 1854-1855)"/>
                        </div>
                        <!-- Partie droite pour le texte -->
                        <div class="conteneur_texte">
                            <h2>Présentation du projet d'édition numérique : </h2>
                            <p>Ce site s'appuie sur un encodage TEI de cinq poèmes de Gérard de Nerval.</p>
                            <p>
                                <xsl:value-of select="//projectDesc/p"/>                                
                                <br/>
                                <br/>
                                Les pages HTML sur lesquelles vous naviguez actuellement ont été générées
                                par transformation XSLT à partir de l'encodage XML-TEI réalisé
                                préalablement. <br/>
                                L'encodage de la métrique a été exploité lors de la transformation
                                pour mettre en évidence visuellement les jeux de sonorité d'une rime
                                à l'autre. <br/>
                                Les césures ont également été marquées par une double barre oblique.
                            </p>
                        </div>
                        <div>
                            <h3>Remarque concernant la transcription des poèmes :</h3>
                            <p id="p_centre">
                                <xsl:value-of select="//editorialDecl/p"/>
                            </p>
                            <!-- Liste des liens vers les poèmes -->
                            <div>
                                <h2>Consulter les pages de chacun des cinq poèmes : </h2>
                            <p class="p_centre">
                                <a href="./{$poeme1}">"El Desdichado", tiré des <i>Chimères</i> (1856)</a><br/>
                                <a href="./{$poeme2}">"Myrtho", tiré des <i>Chimères</i> (1856)</a><br/> 
                                <a href="./{$poeme3}">"Delfica, tiré des <i>Chimères</i> (1856)</a><br/> 
                                <a href="./{$poeme4}">"Artémis", tiré des <i>Chimères</i> (1856)</a><br/> 
                                <b>~</b>
                                <br/>
                                <a href="./{$poeme5}">"Fantaisie", tiré des <i>Odelettes</i> (1853)</a>                                                            
                            </p>
                            </div> 
                            <!-- Liens en bas de la page -->
                            <p>
                            <a href="./{$index}">Index</a><br/>
                            <a href="./{$bibliographie}">Bibliographie</a>
                            </p>                        
                        </div>
                     </div>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    
    
    <!-- b. Template du poème "El Desdichado" --> 
    <xsl:template name="poeme1">
        <xsl:result-document href="{$poeme1}" method="html">
            <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
            <html lang="fr">
                <xsl:copy-of select="$header"/>
                <body>
                    <xsl:attribute name="style">
                        <xsl:value-of select="$css_background"/>
                    </xsl:attribute>
                    <xsl:copy-of select="$body_header"/>
                    <div class="css_div">
                        <div>                        
                            <!-- Titre du poème avec exposant pour la note de bas de page -->
                            <h3>
                                <xsl:value-of select="//TEI[1]/text/body/div1/div2[@xml:id='P1']/lg[@type='sonnet']/head"/>
                                <!-- Appliquation du template de la note à la suite du titre -->
                                <xsl:apply-templates select="//TEI[1]/text/body/div1/div2[@xml:id='P1']/lg[@type='sonnet']/head/note"/>
                            </h3> 
                            <xsl:apply-templates select="//TEI[1]/text/body/div1/div2[@xml:id='P1']/lg[@type='sonnet']"/>
                             
                        </div>
                    </div>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <!-- Template pour l'élément <note> dans le titre -->
    <xsl:template match="//TEI[1]/text/body/div1/div2[@xml:id='P1']/lg[@type='sonnet']/head/note">
        <!-- Note de bas de page sous forme d'exposant -->
        <sup>
            <a>
                <xsl:attribute name="href">
                    <!-- Identifiant unique pour la note de bas de page (renvoi par lien) -->
                    <xsl:text>#note-poeme1</xsl:text>
                </xsl:attribute>
                <!-- Numéro de la note entre crochets -->
                <xsl:text>[</xsl:text>
                <xsl:number/>
                <xsl:text>]</xsl:text>
            </a>
        </sup>
    </xsl:template>
    
    <!-- Template pour le contenu du poème -->
    <xsl:template match="//TEI[1]/text/body/div1/div2[@xml:id='P1']/lg[@type='sonnet']">
        <div>
            <!-- Boucle sur les lignes de chaque groupe de vers (quatrain ou tercet) -->
            <xsl:for-each select=".//lg[@type='quatrain' or @type='tercet']//l">
                <p>
                    <xsl:apply-templates/>
                </p>
                <!-- Retour à la ligne si vers non suivi d'un autre vers -->
                <xsl:if test="not(following-sibling::l)"> 
                    <br/>
                </xsl:if>
            </xsl:for-each>
        </div>
        
        <!-- Contenu de la note de bas de page -->
        <div>
            <xsl:attribute name="id">
                <xsl:text>note-poeme1</xsl:text>
            </xsl:attribute>           
            <p id="note">
                Note : 
                <xsl:value-of select="//TEI[1]/text/body/div1/div2/lg/note[@target='#Note_1']"/> 
            </p>             
        </div>
        
        <!-- Liens vers le poème suivant au sein du recueil et liens de retour vers les autres pages principales -->
        <div>
            <p><a href="{$poeme2}">Poème suivant : <b>"Myrtho"</b>, tiré des <i>Chimères</i> (1856)</a></p>
            <p>
                <xsl:copy-of select="$retour_accueil"/><br/>
                <xsl:copy-of select="$retour_index"/><br/>
                <xsl:copy-of select="$retour_biblio"/>
            </p>
        </div>
    </xsl:template>
    

    <!-- c. Template du poème "Myrtho" -->
    
    <xsl:template name="poeme2">
        <xsl:result-document href="{$poeme2}" method="html">
            <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
            <html lang="fr">
                <xsl:copy-of select="$header"/>
                <body>
                    <xsl:attribute name="style">
                        <xsl:value-of select="$css_background"/>
                    </xsl:attribute>
                    <xsl:copy-of select="$body_header"/>
                    <div class="css_div">
                        <div>                        
                            <h3>
                                <xsl:value-of select="//TEI[1]/text/body/div1/div2[@xml:id='P2']/lg[@type='sonnet']/head"/>
                            </h3> 
                            <xsl:apply-templates select="//TEI[1]/text/body/div1/div2[@xml:id='P2']/lg[@type='sonnet']"/>
                        </div>                        
                    </div>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="//TEI[1]/text/body/div1/div2[@xml:id='P2']/lg[@type='sonnet']">
        <div>
            <!-- Boucle sur les lignes de chaque groupe de vers (quatrain ou tercet) -->
            <xsl:for-each select=".//lg[@type='quatrain' or @type='tercet']//l">
                <p>
                    <xsl:apply-templates/>
                </p>
                <!-- Retour à la ligne si vers non suivi d'un autre vers -->
                <xsl:if test="not(following-sibling::l)">
                    <br/>
                </xsl:if>
            </xsl:for-each>
        </div>
        
        <!-- Liens vers le poème suivant au sein du recueil et liens de retour vers les autres pages principales -->
        <div>
            <p><a href="{$poeme3}">Poème suivant : <b>"Delfica"</b>, tiré des <i>Chimères</i> (1856)</a></p>
            <p>
                <xsl:copy-of select="$retour_accueil"/><br/>
                <xsl:copy-of select="$retour_index"/><br/>
                <xsl:copy-of select="$retour_biblio"/>
            </p>
        </div>        
    </xsl:template>
    
    <!-- d. Template du poème "Delfica" -->
    
    <xsl:template name="poeme3">
        <xsl:result-document href="{$poeme3}" method="html">
            <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
            <html lang="fr">
                <xsl:copy-of select="$header"/>
                <body>
                    <xsl:attribute name="style">
                        <xsl:value-of select="$css_background"/>
                    </xsl:attribute>
                    <xsl:copy-of select="$body_header"/>
                    <div class="css_div">
                        <div> 
                            <h3>
                                <xsl:value-of select="//TEI[1]/text/body/div1/div2[@xml:id='P3']/lg[@type='sonnet']/head"/>
                            </h3> 
                            <xsl:apply-templates select="//TEI[1]/text/body/div1/div2[@xml:id='P3']/lg[@type='sonnet']"/>                            
                        </div>
                    </div>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="//TEI[1]/text/body/div1/div2[@xml:id='P3']/lg[@type='sonnet']">
        <div>
            <!-- Boucle sur les lignes de chaque groupe de vers (quatrain ou tercet) -->
            <xsl:for-each select=".//lg[@type='quatrain' or @type='tercet']//l">
                <p>
                    <xsl:apply-templates/>
                </p>
                <!-- Retour à la ligne si vers non suivi d'un autre vers -->
                <xsl:if test="not(following-sibling::l)"> 
                    <br/>
                </xsl:if>
            </xsl:for-each>
        </div>
        
        <!-- Liens vers le poème suivant au sein du recueil et liens de retour vers les autres pages principales -->
        <div>
            <p><a href="{$poeme4}">Poème suivant : <b>"Artémis"</b>, tiré des <i>Chimères</i> (1856)</a></p>
            <p>
                <xsl:copy-of select="$retour_accueil"/><br/>
                <xsl:copy-of select="$retour_index"/><br/>
                <xsl:copy-of select="$retour_biblio"/>
            </p>
        </div> 
    </xsl:template>   
    
    
    <!-- e. Template du poème "Artémis" -->
    
    <xsl:template name="poeme4">
        <xsl:result-document href="{$poeme4}" method="html">
            <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
            <html lang="fr">
                <xsl:copy-of select="$header"/>
                <body>
                    <xsl:attribute name="style">
                        <xsl:value-of select="$css_background"/>
                    </xsl:attribute>
                    <xsl:copy-of select="$body_header"/>
                    <div class="css_div">
                        <div> 
                            <h3>
                                <xsl:value-of select="//TEI[1]/text/body/div1/div2[@xml:id='P4']/lg[@type='sonnet']/head"/>
                            </h3>
                            <xsl:apply-templates select="//TEI[1]/text/body/div1/div2[@xml:id='P4']/lg[@type='sonnet']"/>
                        </div>
                    </div>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="//TEI[1]/text/body/div1/div2[@xml:id='P4']/lg[@type='sonnet']">
        <div>
            <!-- Boucle sur les lignes de chaque groupe de vers (quatrain ou tercet) -->
            <xsl:for-each select=".//lg[@type='quatrain' or @type='tercet']//l">
                <p>
                    <xsl:apply-templates/>
                </p>
                <!-- Retour à la ligne si vers non suivi d'un autre vers -->
                <xsl:if test="not(following-sibling::l)"> 
                    <br/>
                </xsl:if>
            </xsl:for-each>
        </div>
        
        <!-- Liens vers le poème suivant (recueil suivant) et liens de retour vers les autres pages principales -->
        <div>
            <p><a href="{$poeme5}">Consulter la page du poème<b> "Fantaisie"</b>, tiré des <i>Odelettes</i> (1853)</a></p>
            <p>
                <xsl:copy-of select="$retour_accueil"/><br/>
                <xsl:copy-of select="$retour_index"/><br/>
                <xsl:copy-of select="$retour_biblio"/>
            </p>
        </div>         
    </xsl:template>
    
    <!-- f. Template du poème "Fantaisie" -->
    
    <xsl:template name="poeme5">
        <xsl:result-document href="{$poeme5}" method="html">
            <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
            <html lang="fr">
                <xsl:copy-of select="$header"/>
                <body>
                    <xsl:attribute name="style">
                        <xsl:value-of select="$css_background"/>
                    </xsl:attribute>
                    <xsl:copy-of select="$body_header"/>
                    <div class="css_div">
                        <div> 
                            <h3>
                                <xsl:value-of select="//TEI[2]/text/body/div1/div2[@xml:id='P5']/lg[@type='ode_lyrique']/head"/>
                            </h3>
                            <xsl:apply-templates select="//TEI[2]/text/body/div1/div2[@xml:id='P5']/lg[@type='ode_lyrique']"/>
                        </div>
                    </div>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>   

    <xsl:template match="//TEI[2]/text/body/div1/div2[@xml:id='P5']/lg[@type='ode_lyrique']">
        <div>
            <!-- Boucle sur les lignes de chaque groupe de vers (quatrains seulement) -->
            <xsl:for-each select=".//lg[@type='quatrain']//l">
                <p>
                    <xsl:apply-templates/>
                </p>
                <!-- Retour à la ligne si vers non suivi d'un autre vers -->
                <xsl:if test="not(following-sibling::l)"> 
                    <br/>
                </xsl:if>
            </xsl:for-each>
        </div>
        
        <!-- Liens de retour vers le premier poème du premier recueil et liens de retour vers les autres pages principales -->
        <div>
            <p><a href="{$poeme1}">Retourner sur la page du poème <b> "El Desdichado"</b>, tiré des <i>Chimères</i> (1856)</a></p>
            <p>
                <xsl:copy-of select="$retour_accueil"/><br/>
                <xsl:copy-of select="$retour_index"/><br/>
                <xsl:copy-of select="$retour_biblio"/>
            </p>
        </div>
    </xsl:template>
    
    <!-- g. Template de l'index --> 
    
    <xsl:template name="index">
        <xsl:result-document href="{$index}" method="html">
            <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
            <html lang="fr">
                <xsl:copy-of select="$header"/>
                <body>
                    <xsl:attribute name="style">
                        <xsl:value-of select="$css_background"/>
                    </xsl:attribute>
                    <xsl:copy-of select="$body_header"/>
                    <div class="css_div">
                        <div> 
                            <h3>Index des noms propres cités dans les poèmes encodés</h3>
                            <p class="p_centre">
                                <a href="#index_lieux">Index des toponymes</a> - 
                                <a href="#index_mythiques">Index des personnages mythiques</a> - 
                                <a href="#index_historiques">Index des personnages historiques</a>
                            </p>
                        </div>
                        <div>
                            <h4 id="index_lieux">Index des lieux</h4>
                            
                            <!-- Boucle sur les <placeName/> -->
                            <xsl:for-each-group select="//body//placeName" group-by="./@ref">
                                <!-- Limitation à ces valeurs spécifiques de @ref pour éviter 
                                    que la boucle n'attrape tous les <placeName/> par ordre d'apparition dans les poèmes -->
                                <xsl:if test="./@ref='#Pausilippe' or ./@ref='#Acheron' or ./@ref='#Vesuve'">                                    
                                    <div>
                                        <!-- Affichage de l'entrée et d'une courte description la première fois que l'occurrence est trouvée au sein d'un poème -->
                                        <xsl:choose>
                                            <xsl:when test="./@ref='#Pausilippe'" >
                                                <p><b><xsl:value-of select="//$chemin_lieu/place[@xml:id='Pausilippe']/placeName/name[1]"/></b></p>
                                                <p><xsl:value-of select="/$chemin_lieu/place[@xml:id='Pausilippe']/note"/></p>
                                            </xsl:when>
                                            <xsl:when test="./@ref='#Acheron'">
                                                <p><b><xsl:value-of select="//$chemin_lieu/place[@xml:id='Acheron']/placeName"/></b></p>
                                                <p><xsl:value-of select="//$chemin_lieu/place[@xml:id='Acheron']/note"/></p>
                                            </xsl:when>                                        
                                            <xsl:when test="./@ref='#Vesuve'">
                                                <p><b><xsl:value-of select="//$chemin_lieu/place[@xml:id='Vesuve']/placeName/name[1]"/></b></p>
                                                <p><xsl:value-of select="//$chemin_lieu/place[@xml:id='Vesuve']/note"/></p>
                                            </xsl:when>                                            
                                        </xsl:choose>
                                        <p>
                                            <!-- Afficher la forme de l'occurrence référencée au sein du poème -->
                                            <i><xsl:value-of select="."/></i> : 
                                            <!-- Afficher le nom du poème d'où est extraite l'occurrence -->
                                            <xsl:for-each-group select="current-group()" group-by="ancestor::div2[@type='poème']">
                                                <!-- Création des liens vers les poèmes -->
                                                <a>
                                                    <xsl:attribute name="href">
                                                        <xsl:choose>
                                                            <xsl:when test="ancestor::div2[@xml:id='P1']">
                                                                <xsl:text>./</xsl:text><xsl:value-of select="$poeme1"/>
                                                            </xsl:when>
                                                            <xsl:when test="ancestor::div2[@xml:id='P2']">
                                                                <xsl:text>./</xsl:text><xsl:value-of select="$poeme2"/>
                                                            </xsl:when>
                                                            <xsl:when test="ancestor::div2[@xml:id='P3']">
                                                                <xsl:text>./</xsl:text><xsl:value-of select="$poeme3"/>
                                                            </xsl:when>
                                                            <xsl:when test="ancestor::div2[@xml:id='P4']">
                                                                <xsl:text>./</xsl:text><xsl:value-of select="$poeme4"/>
                                                            </xsl:when>
                                                            <xsl:when test="ancestor::div2[@xml:id='P5']">
                                                                <xsl:text>./</xsl:text><xsl:value-of select="$poeme5"/> 
                                                            </xsl:when> 
                                                        </xsl:choose>
                                                    </xsl:attribute>
                                                    <!-- Affichage du nom du poème -->
                                                    <xsl:value-of select="ancestor::div2[@type='poème']/lg/head"/>
                                                </a>
                                                <!-- Condition vérifiant si le nom du poème est suivi d'un autre ou non -->
                                                <xsl:if test="position()!= last()">, 
                                                </xsl:if>
                                                <xsl:if test="position() = last()">.
                                                </xsl:if>
                                            </xsl:for-each-group>
                                        </p>                                        
                                    </div>
                                </xsl:if>
                            </xsl:for-each-group>
                            
                            <br/>
                            <h4 id="index_mythiques">Index des personnages mythiques</h4>
                            
                            <!-- Boucle sur les <persName/> -->
                            <xsl:for-each-group select="//body//persName" group-by="./@ref">
                                <!-- Limitation à ces valeurs spécifiques de @ref pour éviter 
                                    que la boucle n'attrape tous les <persName/> par ordre d'apparition dans les poèmes -->
                                <xsl:if test="./@ref='#Amour' or ./@ref='#Myrtho' or ./@ref='#Phebus' or ./@ref='#Orphee' or ./@ref='#Muse'or ./@ref='#Dafne' or ./@ref='#Melusine' or ./@ref='#Iacchus'" >
                                <div>
                                <!-- Affichage de l'entrée et d'une courte description la première fois que l'occurrence est trouvée au sein d'un poème -->
                                <xsl:choose>
                                    <xsl:when test="./@ref='#Amour'" >
                                        <p><b><xsl:value-of select="//$chemin_personne/person[@xml:id='Amour']/persName"/></b></p>
                                        <p><xsl:value-of select="//$chemin_personne/person[@xml:id='Amour']/note"/></p>
                                    </xsl:when>
                                    <xsl:when test="./@ref='#Dafne'">
                                        <p><b><xsl:value-of select="//$chemin_personne/person[@xml:id='Dafne']/persName"/></b></p>
                                        <p><xsl:value-of select="//$chemin_personne/person[@xml:id='Dafne']/note"/></p>
                                    </xsl:when>                                        
                                    <xsl:when test="./@ref='#Iacchus'">
                                        <p><b><xsl:value-of select="/$chemin_personne/person[@xml:id='Iacchus']/persName"/></b></p>
                                        <p><xsl:value-of select="//$chemin_personne/person[@xml:id='Iacchus']/note"/></p>
                                    </xsl:when>
                                    <xsl:when test="./@ref='#Melusine'">
                                        <p><b><xsl:value-of select="//$chemin_personne/person[@xml:id='Melusine']/persName"/></b></p>
                                        <p><xsl:value-of select="//$chemin_personne/person[@xml:id='Melusine']/note"/></p>
                                    </xsl:when>
                                    <xsl:when test="./@ref='#Muse'">
                                        <p><b><xsl:value-of select="//$chemin_personne/person[@xml:id='Muse']/persName"/></b></p>
                                        <p><xsl:value-of select="//$chemin_personne/person[@xml:id='Muse']/note"/></p>
                                    </xsl:when>
                                    <xsl:when test="./@ref='#Orphee'">
                                        <p><b><xsl:value-of select="//$chemin_personne/person[@xml:id='Orphee']/persName"/></b></p>
                                        <p><xsl:value-of select="//$chemin_personne/person[@xml:id='Orphee']/note"/></p>
                                    </xsl:when>
                                    <xsl:when test="./@ref='#Phebus'">
                                        <p><b><xsl:value-of select="//$chemin_personne/person[@xml:id='Phebus']/persName"/></b></p>
                                        <p><xsl:value-of select="//$chemin_personne/person[@xml:id='Phebus']/note"/></p>                                        
                                    </xsl:when>
                                    <xsl:when test="./@ref='#Myrtho'">
                                        <p><b><xsl:value-of select="//$chemin_personne/person[@xml:id='Myrtho']/persName"/></b></p>
                                        <p><xsl:value-of select="//$chemin_personne/person[@xml:id='Myrtho']/note"/></p>
                                    </xsl:when>
                                    </xsl:choose>
                                        <p>
                                            <!-- Afficher la forme de l'occurrence référencée au sein du poème -->
                                            <i><xsl:value-of select="."/></i> : 
                                        <!-- Afficher le nom du poème d'où est extraite l'occurrence -->
                                        <xsl:for-each-group select="current-group()" group-by="ancestor::div2[@type='poème']">
                                            <!-- Création des liens vers les poèmes -->   
                                            <a>
                                                <xsl:attribute name="href">
                                                    <xsl:choose>
                                                        <xsl:when test="ancestor::div2[@xml:id='P1']">
                                                            <xsl:text>./</xsl:text><xsl:value-of select="$poeme1"/>
                                                        </xsl:when>
                                                        <xsl:when test="ancestor::div2[@xml:id='P2']">
                                                            <xsl:text>./</xsl:text><xsl:value-of select="$poeme2"/>
                                                        </xsl:when>
                                                        <xsl:when test="ancestor::div2[@xml:id='P3']">
                                                            <xsl:text>./</xsl:text><xsl:value-of select="$poeme3"/>
                                                        </xsl:when>
                                                        <xsl:when test="ancestor::div2[@xml:id='P4']">
                                                            <xsl:text>./</xsl:text><xsl:value-of select="$poeme4"/>
                                                        </xsl:when>
                                                        <xsl:when test="ancestor::div2[@xml:id='P5']">
                                                            <xsl:text>./</xsl:text><xsl:value-of select="$poeme5"/> 
                                                        </xsl:when> 
                                                    </xsl:choose>
                                                </xsl:attribute>
                                                <!-- Affichage du nom du poème -->
                                                <xsl:value-of select="ancestor::div2[@type='poème']/lg/head"/>
                                            </a>
                                            <!-- Condition vérifiant si le nom du poème est suivi d'un autre ou non -->
                                            <xsl:if test="position()!= last()">, 
                                            </xsl:if>
                                            <xsl:if test="position() = last()">.
                                            </xsl:if>
                                         </xsl:for-each-group>
                                    </p>                                        
                                </div>
                               </xsl:if>
                            </xsl:for-each-group>
                           
                            
                            <br/>
                            <h4 id="index_historiques">Index des personnages historiques</h4>
                            
                            <!-- Boucle sur les <persName/> -->
                            <xsl:for-each-group select="//body//persName" group-by="./@ref">
                                <!-- Limitation à ces valeurs spécifiques de @ref pour éviter 
                                    que la boucle n'attrape tous les <persName/> par ordre d'apparition dans les poèmes -->
                                <xsl:if test="./@ref='#Biron' or ./@ref='#Constantin' or ./@ref='#duc_normand' or ./@ref='#Jenny_Colon' or 
                                    ./@ref='#Louis_XIII'or ./@ref='#Lusignan' or ./@ref='#Mozart' or ./@ref='#Prince' or ./@ref='#Rossini' or ./@ref='#Ste_Gudule' or ./@ref='#Virgile' or ./@ref='#Weber' " >
                                    <div>
                                        <!-- Affichage de l'entrée et d'une courte description la première fois que l'occurrence est trouvée au sein d'un poème -->
                                        <xsl:choose>
                                            <xsl:when test="./@ref='#Biron'">
                                                <p><b><xsl:value-of select="//$chemin_personne/person[@xml:id='Biron']/persName"/></b></p>
                                                <p><xsl:value-of select="//$chemin_personne/person[@xml:id='Biron']/note"/></p>
                                            </xsl:when>
                                            <xsl:when test="./@ref='#Constantin'">
                                                <p><b><xsl:value-of select="//$chemin_personne/person[@xml:id='Constantin']/persName"/></b></p>
                                                <p><xsl:value-of select="//$chemin_personne/person[@xml:id='Constantin']/note"/></p>
                                            </xsl:when>
                                            <xsl:when test="./@ref='#duc_normand'">
                                                <p><b><xsl:value-of select="/$chemin_personne/personGrp[@xml:id='duc_normand']/persName[1]"/> et 
                                                    <xsl:value-of select="/$chemin_personne/personGrp[@xml:id='duc_normand']/persName[2]"/></b></p>
                                                <p><xsl:value-of select="//$chemin_personne/personGrp[@xml:id='duc_normand']/note"/></p>
                                            </xsl:when>
                                            <xsl:when test="./@ref='#Jenny_Colon'">
                                                <p><b><xsl:value-of select="//$chemin_personne/person[@xml:id='Jenny_Colon']/persName"/></b></p>
                                                <p><xsl:value-of select="//$chemin_personne/person[@xml:id='Jenny_Colon']/note"/></p>
                                            </xsl:when>
                                            <xsl:when test="./@ref='#Louis_XIII'">
                                                <p><b><xsl:value-of select="//$chemin_personne/person[@xml:id='Louis_XIII']/persName"/></b></p>
                                                <p><xsl:value-of select="//$chemin_personne/person[@xml:id='Louis_XIII']/note"/></p>
                                            </xsl:when>
                                            <xsl:when test="./@ref='#Lusignan'">
                                                <p><b><xsl:value-of select="//$chemin_personne/person[@xml:id='Lusignan']/persName[1]"/></b></p>
                                                <p><xsl:value-of select="//$chemin_personne/person[@xml:id='Lusignan']/note"/></p>
                                            </xsl:when>
                                            <xsl:when test="./@ref='#Mozart'">
                                                <p><b><xsl:value-of select="//$chemin_personne/person[@xml:id='Mozart']/persName"/></b></p>
                                                <p><xsl:value-of select="//$chemin_personne/person[@xml:id='Mozart']/note"/></p>
                                            </xsl:when>
                                            <xsl:when test="./@ref='#Prince'">
                                                <p><b><xsl:value-of select="//$chemin_personne/person[@xml:id='Prince']/persName"/></b></p>
                                                <p><xsl:value-of select="//$chemin_personne/person[@xml:id='Prince']/note"/></p>
                                            </xsl:when>
                                            <xsl:when test="./@ref='#Rossini'">
                                                <p><b><xsl:value-of select="//$chemin_personne/person[@xml:id='Rossini']/persName"/></b></p>
                                                <p><xsl:value-of select="//$chemin_personne/person[@xml:id='Rossini']/note"/></p>
                                            </xsl:when>
                                            <xsl:when test="./@ref='#Ste_Gudule'">
                                                <p><b><xsl:value-of select="//$chemin_personne/person[@xml:id='Ste_Gudule']/persName"/></b></p>
                                                <p><xsl:value-of select="//$chemin_personne/person[@xml:id='Ste_Gudule']/note"/></p>
                                            </xsl:when>
                                            <xsl:when test="./@ref='#Virgile'">
                                                <p><b><xsl:value-of select="//$chemin_personne/person[@xml:id='Virgile']/persName"/></b></p>
                                                <p><xsl:value-of select="//$chemin_personne/person[@xml:id='Virgile']/note"/></p>
                                            </xsl:when>
                                            <xsl:when test="./@ref='#Weber'">
                                                <p><b><xsl:value-of select="//$chemin_personne/person[@xml:id='Weber']/persName"/></b></p>
                                                <p><xsl:value-of select="//$chemin_personne/person[@xml:id='Weber']/note"/></p>
                                            </xsl:when>
                                        </xsl:choose>
                                            <p>
                                                <!-- Afficher la forme de l'occurrence référencée au sein du poème -->
                                                <i><xsl:value-of select="."/></i> : 
                                                <!-- Afficher le nom du poème d'où est extraite l'occurrence -->                                                
                                                <xsl:for-each-group select="current-group()" group-by="ancestor::div2[@type='poème']">
                                                    <!-- Création des liens vers les poèmes -->
                                                    <a>
                                                        <xsl:attribute name="href">
                                                            <xsl:choose>
                                                                <xsl:when test="ancestor::div2[@xml:id='P1']">
                                                                    <xsl:text>./</xsl:text><xsl:value-of select="$poeme1"/>
                                                                </xsl:when>
                                                                <xsl:when test="ancestor::div2[@xml:id='P2']">
                                                                    <xsl:text>./</xsl:text><xsl:value-of select="$poeme2"/>
                                                                </xsl:when>
                                                                <xsl:when test="ancestor::div2[@xml:id='P3']">
                                                                    <xsl:text>./</xsl:text><xsl:value-of select="$poeme3"/>
                                                                </xsl:when>
                                                                <xsl:when test="ancestor::div2[@xml:id='P4']">
                                                                    <xsl:text>./</xsl:text><xsl:value-of select="$poeme4"/>
                                                                </xsl:when>
                                                                <xsl:when test="ancestor::div2[@xml:id='P5']">
                                                                    <xsl:text>./</xsl:text><xsl:value-of select="$poeme5"/> 
                                                                </xsl:when> 
                                                            </xsl:choose>
                                                        </xsl:attribute>
                                                        <!-- Affichage du nom du poème -->
                                                        <xsl:value-of select="ancestor::div2[@type='poème']/lg/head"/>
                                                    </a>
                                                    <!-- Condition vérifiant si le nom du poème est suivi d'un autre ou non -->
                                                    <xsl:if test="position()!= last()">, 
                                                    </xsl:if><xsl:if test="position() = last()">.</xsl:if>
                                                </xsl:for-each-group>
                                            </p>  
                                    </div>
                                </xsl:if>
                            </xsl:for-each-group>
                         </div>
                        <div>
                            <!-- Liens de retour vers les autres pages principales -->                    
                            <div>
                                <p>
                                    <xsl:copy-of select="$retour_accueil"/><br/>
                                    <xsl:copy-of select="$retour_biblio"/><br/>
                                </p>
                            </div>
                        </div>                        
                    </div>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <!-- h. Template de la bibliographie -->
    
    <xsl:template name="bibliographie">
        <xsl:result-document href="{$bibliographie}" method="html">
            <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
            <html lang="fr">
                <xsl:copy-of select="$header"/>
                <body>
                    <xsl:attribute name="style">
                        <xsl:value-of select="$css_background"/>
                    </xsl:attribute>
                    <xsl:copy-of select="$body_header"/>
                    <div class="css_div">
                        <div>
                            <h2>Bibliographie</h2>
                            <h3>Liste des ouvrages sources :</h3>
                            <ol class="biblio_1">
                                <xsl:apply-templates select="//sourceDesc/listBibl/biblStruct[@type='recueil']"/>
                            </ol>
                            <h3>Liste des ouvrages complémentaires consultés :</h3>
                            <ol class="biblio_2">
                                <xsl:apply-templates select="//sourceDesc/listBibl/biblStruct[@type='anthologie' or @type='encyclopedie' or @type='article']"/>
                            </ol>
                        </div>
                        <div>
                            <!-- Liens de retour vers les autres pages principales -->                    
                            <div>
                                <p>
                                    <xsl:copy-of select="$retour_accueil"/><br/>
                                    <xsl:copy-of select="$retour_index"/><br/>
                                </p>
                            </div>
                        </div>
                    </div>
                    <xsl:copy-of select="$footer"/>              
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <!-- Règles pour l'extraction des informations à afficher dans les listes -->    
    <xsl:template match="//sourceDesc/listBibl">
        <ol>
            <xsl:apply-templates/>
        </ol>
    </xsl:template>
    
    <!-- Template de construction de la liste des ouvrages sources au format MLA -->    
    <xsl:template match="//sourceDesc/listBibl/biblStruct[@type='recueil']">
        <li>
            <xsl:value-of select="analytic/author/persName/surname"/>
            <xsl:text>, </xsl:text>
            <xsl:value-of select="analytic/author/persName/forename"/>
            <xsl:text>. </xsl:text>            
            « <xsl:value-of select="analytic/title"/> »
            <xsl:text>. </xsl:text>            
            <cite><xsl:apply-templates select="monogr/title"/></cite>
            <xsl:text>, </xsl:text>            
            <xsl:value-of select="monogr/imprint/publisher"/> 
            <xsl:text>, </xsl:text> 
            <xsl:value-of select="monogr/imprint/date"/> 
            <xsl:text>, </xsl:text>            
            <xsl:value-of select="monogr/imprint/pubPlace"/>
            <xsl:text>, </xsl:text>            
            <xsl:value-of select="monogr/biblScope"/>
            <xsl:text>. </xsl:text>            
        </li>
    </xsl:template>
    
    <!-- Template de construction de la liste des ouvrages complémentaires au format MLA --> 
    <xsl:template match="//sourceDesc/listBibl/biblStruct[@type='anthologie' or @type='encyclopedie' or @type='article']">
        <li>
            <xsl:if test="monogr/author/persName">
                <xsl:value-of select="monogr/author/persName[1]/surname"/>
                <xsl:text>, </xsl:text>
                <xsl:value-of select="monogr/author/persName[1]/forename"/>            
                <xsl:text> et </xsl:text>
                <xsl:value-of select="monogr/author/persName[2]/surname"/>
                <xsl:text>, </xsl:text>
                <xsl:value-of select="monogr/author/persName[2]/forename"/>
                <xsl:text>. </xsl:text>                
            </xsl:if>             
            <xsl:if test="analytic/author/persName">
                <xsl:value-of select="analytic/author/persName/surname"/>
                <xsl:text>, </xsl:text>
                <xsl:value-of select="analytic/author/persName/forename"/>
                <xsl:text>. </xsl:text>                
            </xsl:if>            
            <xsl:if test="analytic/title">
                « <xsl:value-of select="analytic/title"/> »
                    <xsl:text>, </xsl:text>
            </xsl:if>            
            <cite>
                <xsl:value-of select="monogr/title"/>	
            </cite>
            <xsl:text>, </xsl:text>            
            <xsl:if test="series/title">
                <xsl:value-of select="series/title"/>
                <xsl:text>, </xsl:text>
            </xsl:if>            
            <xsl:if test="series/biblScope">
                <xsl:value-of select="series/biblScope"/>
                <xsl:text>, </xsl:text>
            </xsl:if>             
            <xsl:value-of select="monogr/imprint/publisher"/>
            <xsl:text>, </xsl:text>            
            <xsl:value-of select="monogr/imprint/date"/>
            <xsl:text> </xsl:text>            
            <xsl:if test="monogr/imprint/pubPlace">
                <xsl:text> </xsl:text>
                <xsl:value-of select="monogr/imprint/pubPlace"/>
                <xsl:text>, </xsl:text>
            </xsl:if>            
            <xsl:if test="monogr/biblScope">
                <xsl:value-of select="monogr/biblScope"/> 
                <xsl:text>, </xsl:text>
            </xsl:if>            
            <xsl:if test="monogr/idno">
                <xsl:text>ISBN : </xsl:text>
                <xsl:value-of select="monogr/idno"/>
                <xsl:text>. </xsl:text>                
            </xsl:if>
            <xsl:if test="position() = last()">
                <xsl:text>.</xsl:text>
            </xsl:if> 
        </li>
    </xsl:template>    
    
    <!-- i. Template du recueil "Les Chimères" -->
    
    <xsl:template name="recueil1">
        <xsl:result-document href="{$recueil1}" method="html">
            <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
            <html lang="fr">
                <xsl:copy-of select="$header"/>
                <body>
                    <xsl:attribute name="style">
                        <xsl:value-of select="$css_background"/>
                    </xsl:attribute>
                    <xsl:copy-of select="$body_header"/>
                    <div class="css_div">                        
                        <div> 
                            <!-- Construction de la page en extrayant des informations depuis le document TEI -->
                            <h3>
                                <xsl:value-of select="//TEI[1]/teiHeader/fileDesc/titleStmt/title[@level='a']"/>
                            </h3>
                            <p class="p_centre">par</p>
                            <h3>
                                <xsl:value-of select="//TEI[1]//teiHeader/fileDesc/titleStmt/author"/>
                            </h3>
                            <p>
                                <xsl:value-of select="//TEI[1]/teiHeader//edition"/> 
                            </p>
                            <p>                                
                                <xsl:value-of select="//TEI[1]/teiHeader/fileDesc/titleStmt/respStmt/resp"/> 
                                <xsl:text> </xsl:text>
                                <xsl:value-of select="//TEI[1]/teiHeader/fileDesc/titleStmt/respStmt/persName"/>
                                <xsl:text>.</xsl:text>
                            </p>
                            <p>
                                <xsl:value-of select="//TEI[1]/teiHeader/fileDesc/publicationStmt/p"/>
                            </p>
                            <p>
                                <xsl:value-of select="//TEI[1]/teiHeader/fileDesc/sourceDesc/sourceDesc/p"/>
                            </p>
                            <p>
                                <xsl:value-of select="//TEI[1]/teiHeader/profileDesc/creation/date"/>
                            </p>
                        </div>
                        <div>
                            <h4>Liste des poèmes ayant fait l'objet d'un encodage :</h4>
                            <p class="p_centre">
                                <a href="{$poeme1}">"El Desdichado"</a> - 
                                <a href="{$poeme2}">"Myrtho"</a> - 
                                <a href="{$poeme3}">"Delfica"</a> - 
                                <a href="{$poeme4}">"Artémis"</a>                                 
                            </p>
                            <!-- Liens de retour vers les autres pages principales -->        
                            <div>
                                <p>
                                    <xsl:copy-of select="$retour_accueil"/><br/>
                                    <xsl:copy-of select="$retour_index"/><br/>
                                    <xsl:copy-of select="$retour_biblio"/>
                                </p>
                            </div>
                        </div>
                    </div>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>       
    </xsl:template>
    
    <!-- j. Template du recueil "Odelettes" -->
    
    <xsl:template name="recueil2">
        <xsl:result-document href="{$recueil2}" method="html">
            <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
            <html lang="fr">
                <xsl:copy-of select="$header"/>
                <body>
                    <xsl:attribute name="style">
                        <xsl:value-of select="$css_background"/>
                    </xsl:attribute>
                    <xsl:copy-of select="$body_header"/>
                    <div class="css_div">
                        <div> 
                            <h3>
                                <xsl:value-of select="//TEI[2]/teiHeader/fileDesc/titleStmt/title[@level='a']"/>
                            </h3>
                            <p class="p_centre">par</p>
                            <h3>
                                <xsl:value-of select="//TEI[2]//teiHeader/fileDesc/titleStmt/author"/>
                            </h3>
                            <p>
                                <xsl:value-of select="//TEI[2]/teiHeader/fileDesc/titleStmt/respStmt/resp"/> 
                                <xsl:text> </xsl:text>
                                <xsl:value-of select="//TEI[2]/teiHeader/fileDesc/titleStmt/respStmt/persName"/>
                                <xsl:text>.</xsl:text>
                            </p>
                            <p>
                                <xsl:value-of select="//TEI[2]/teiHeader/fileDesc/publicationStmt/p"/>
                            </p>
                            <p>
                                <xsl:value-of select="//TEI[2]/teiHeader/fileDesc/sourceDesc/sourceDesc/p"/>
                            </p>
                            <p>
                                <xsl:value-of select="//TEI[2]/teiHeader/profileDesc/creation/date"/>
                            </p>
                        </div>
                        <div>
                            <h4>Lien vers le poème ayant fait l'objet d'un encodage :</h4>
                            <p class="p_centre">
                                <a href="{$poeme5}">"Fantaisie"</a>                              
                            </p>
                            <!-- Liens de retour vers les autres pages principales -->                            
                            <div>
                                <p>
                                    <xsl:copy-of select="$retour_accueil"/><br/>
                                    <xsl:copy-of select="$retour_index"/><br/>
                                    <xsl:copy-of select="$retour_biblio"/>
                                </p>
                            </div>
                        </div>
                      </div>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
     </xsl:template>
    
    <!-- Fin de la définition des templates des pages -->  
    
    <!-- 5. REGLES COMPLEMENTAIRES -->
    
    <!-- a. Templates pour l'isolement graphique des rimes finales --> 
    
    <!-- Template pour identifier les éléments <rhyme> (vaut pour l'ensemble des poèmes) -->
    <xsl:template match="rhyme">   
        <!-- Variables stockant des attributs (doivent se trouver sous le match) -->        
        <xsl:variable name="xmlId" select="@xml:id"/>
        <xsl:variable name="sameAs" select="@sameAs"/>
        <xsl:choose>
            <!-- Boucle pour vérifier l'existence d'un attribut @xml:id ou @sameAs de manière à éviter de copier
        des valeurs d'attributs vides (créant un HTML fonctionnel mais non conforme) -->
            <xsl:when test="$xmlId != ''">
                <!-- Recours à l'attribut universel "data-*" pour permettre la conformité avec le standard HTML -->
                <span data-xml_id="{$xmlId}">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="$sameAs != ''">
                <span data-sameAs="{$sameAs}">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span>
                    <xsl:apply-templates/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>    
    <!-- Template pour les éléments <l> -->
    <xsl:template match="l">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>    
    
    <!-- b. Template pour la représentation de la césure -->
    
    <xsl:template match="caesura">
        <b>//</b>
    </xsl:template>
    
    <!-- c. Rétablissement de l'italique et des petites capitales dans les poèmes -->    
      
    <xsl:template match="*[@rend='italics']">
        <em>
            <xsl:apply-templates/>
        </em>
    </xsl:template>
    
    <xsl:template match="*[@rend='small-caps']">
        <em style='font-variant-caps: small-caps; font-style: normal'>
            <xsl:apply-templates/>
        </em>
    </xsl:template>  
    
    <!-- d. Ignorer le contenu de la balise <metamark><abbr/></metamark> (éviter les redoublements de mots dans les poèmes) -->    
    
    <xsl:template match="//body//metamark/abbr">
        <xsl:text/>
    </xsl:template>    
    
    <!-- e. Rétablissement des titres en italique (non fonctionnel)  -->
    
    <xsl:template match="//title[@rend='italics']">
        <xsl:message>Eléments traités (test console) : </xsl:message>
        <em>
            <xsl:apply-templates/>            
        </em>     
    </xsl:template>       
    
    <!-- Fin des règles complémentaires -->
    
</xsl:stylesheet>
