-- This is the DB structure needed.  This structure should work on versions
-- of MySQL from 3.23.44 on up without a problem.  If you are using an older
-- version than that, you will have to modify it.  Specifically, the InnoDB
-- table type and FOREIGN KEY constraints will have to be removed.
-- 
-- Also included is a default set of Unita types that should cover most cases,
-- as well as a starter set of Categorie.  New ones can be Data_aggiunta from within
-- the software, using the Manage Unitas or Manage Categorie pages.
-- Ingredientei are Data_aggiunta dynamically as they are entered into recipes.
--
-- Database: recipes
-- 

-- --------------------------------------------------------

-- 
-- Table structure for table Categorie
-- 

CREATE TABLE Categorie (
	Id int(10) unsigned NOT NULL auto_increment, 
	Nome varchar(80) NOT NULL default '', 
	Parent int(10) unsigned default NULL, 
	PRIMARY KEY  (Id), 
	UNIQUE KEY Nome_2 (Nome,Parent), 
	KEY Parent (Parent), 
	KEY Nome (Nome),
	FOREIGN KEY (Parent) REFERENCES Categorie(Id) 
		ON DELETE CASCADE ON UPDATE CASCADE
	) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Table structure for table Ingredientei
-- 

CREATE TABLE Ingredienti ( 
	Id int(10) unsigned NOT NULL auto_increment, 
	Nome varchar(80) NOT NULL default '', 
	PRIMARY KEY  (Id), UNIQUE KEY Nome (Nome)
	) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Table structure for table Ingredientei_ricette
-- 

CREATE TABLE Ingredienti_ricette ( 
	Id int(10) unsigned NOT NULL auto_increment, 
	Quantita varchar(10) NOT NULL default '', 
	Unita int(10) unsigned NOT NULL default '0', 
	Ingrediente int(10) unsigned NOT NULL default '0', 
	PRIMARY KEY  (Id), 
	UNIQUE KEY Quantita (Quantita,Unita,Ingrediente), 
	KEY Unita (Unita), KEY Ingrediente (Ingrediente),
	FOREIGN KEY (Unita) REFERENCES Unita(Id) 
		ON UPDATE CASCADE, 
	FOREIGN KEY (Ingrediente) REFERENCES Ingredienti(Id) 
		ON UPDATE CASCADE
	) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Table structure for table recipes
-- 

CREATE TABLE Ricette ( 
	Id int(11) NOT NULL auto_increment, 
	Nome varchar(80) NOT NULL default '', 
	Porzioni int(11) NOT NULL default '0', 
	Ingredienti varchar(255) default NULL, 
	Istruzioni text NOT NULL, 
	Descrizione text NOT NULL, 
	Categoria int(10) unsigned NOT NULL default '0', 
	Data_aggiunta datetime NOT NULL default '0000-00-00 00:00:00', 
	Modificato timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP, 
	Creatore INT(10) UNSIGNED NOT NULL DEFAULT '0', 
	-- editor INT(10) UNSIGNED NOT NULL DEFAULT '0', 
	Imagefile VARCHAR( 50 ) NOT NULL, 
	PRIMARY KEY (Id), 
	UNIQUE KEY Nome (Nome), 
	KEY Ingredienti (Ingredienti), 
	KEY Categoria (Categoria), 
	FULLTEXT KEY Nome_2 (Nome,Istruzioni,Descrizione)
	) ENGINE=MyISAM DEFAULT CHARSET=latin1; 

-- --------------------------------------------------------

-- 
-- Table structure for table sessions
-- 

CREATE TABLE Sessions ( Id varchar(80) NOT NULL default '', 
	UserId int(10) unsigned NOT NULL default '0', 
	Username varchar(16) NOT NULL default '', 
	CookieOK char(1) NOT NULL default '', 
	Privs int(10) unsigned NOT NULL default '0', 
	Ts timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP, 
	PRIMARY KEY  (Id), 
	UNIQUE KEY UserId (UserId), 
	KEY ts (ts),
	FOREIGN KEY (userId) REFERENCES Utenti (Id) 
		ON DELETE CASCADE ON UPDATE CASCADE
	) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Table structure for table Unita
-- 

CREATE TABLE Unita ( 
	Id int(10) unsigned NOT NULL auto_increment, 
	Nome varchar(80) NOT NULL default '', 
	Plurale varchar(80) NOT NULL default '', 
	PRIMARY KEY  (Id), 
	UNIQUE KEY Nome (Nome)
	) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Table structure for table Utenti
-- 

CREATE TABLE Utenti (
	Id int(10) unsigned NOT NULL auto_increment, 
	Username varchar(16) NOT NULL default '', 
	password varchar(20) NOT NULL default '', 
	Nome varchar(80) NOT NULL default '', 
	Email varchar(80) default NULL, 
	privs int(10) unsigned NOT NULL default '0', 
	PRIMARY KEY  (Id), UNIQUE KEY Username (Username)
	) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 
-- Constraints for dumped tables
-- 

-- 
-- Constraints for table Categorie
-- 
ALTER TABLE Categorie 
	ADD CONSTRAINT Categorie_ibfk_1 
	FOREIGN KEY (Parent) 
	REFERENCES Categorie (Id) 
	ON DELETE CASCADE ON UPDATE CASCADE;


-- 
-- Dumping data for table Categorie
-- 

INSERT INTO Categorie VALUES (1, 'Main', NULL);
INSERT INTO Categorie VALUES (2, 'Entrees', 1);
INSERT INTO Categorie VALUES (3, 'Desserts', 1);
INSERT INTO Categorie VALUES (4, 'SIde Dishes', 1);
INSERT INTO Categorie VALUES (5, 'Appetizers', 1);
INSERT INTO Categorie VALUES (6, 'Salads', 1);
INSERT INTO Categorie VALUES (7, 'Cakes', 3);
INSERT INTO Categorie VALUES (8, 'Cookies', 3);
INSERT INTO Categorie VALUES (9, 'Pies', 3);
INSERT INTO Categorie VALUES (10, 'Other', 3);
INSERT INTO Categorie VALUES (11, 'Poultry', 2);
INSERT INTO Categorie VALUES (12, 'Meat', 2);
INSERT INTO Categorie VALUES (13, 'Beverages', 1);
INSERT INTO Categorie VALUES (14, 'Seafood', 2);
INSERT INTO Categorie VALUES (15, 'Soups and Stews', 1);
INSERT INTO Categorie VALUES (16, 'Other', 2);

-- 
-- Dumping data for table Unita
-- 

INSERT INTO Unitas VALUES (1, 'can', 'cans');
INSERT INTO Unitas VALUES (2, 'dash', 'dashes');
INSERT INTO Unitas VALUES (3, 'package', 'packages');
INSERT INTO Unitas VALUES (4, '', '');
INSERT INTO Unitas VALUES (5, 'pound', 'pounds');
INSERT INTO Unitas VALUES (6, 'each', 'each');
INSERT INTO Unitas VALUES (7, 'pinch', 'pinches');
INSERT INTO Unitas VALUES (8, 'kilogram', 'kilograms');
INSERT INTO Unitas VALUES (9, 'gram', 'grams');
INSERT INTO Unitas VALUES (10, 'fluId ounce', 'fluId ounces');
INSERT INTO Unitas VALUES (11, 'ounce', 'ounces');
INSERT INTO Unitas VALUES (12, 'liter', 'liters');
INSERT INTO Unitas VALUES (13, 'mililiter', 'mililiters');
INSERT INTO Unitas VALUES (14, 'gallon', 'gallons');
INSERT INTO Unitas VALUES (15, 'quart', 'quarts');
INSERT INTO Unitas VALUES (16, 'pint', 'pints');
INSERT INTO Unitas VALUES (17, 'cup', 'cups');
INSERT INTO Unitas VALUES (18, 'tablespoon', 'tablespoons');
INSERT INTO Unitas VALUES (19, 'teaspoon', 'teaspoons');