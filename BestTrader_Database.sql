/*IF EXISTS DROP TABLE player, walletactionslog, walletactions, wallet,devise,indice,titre,actioncostlog, action;*/

CREATE TABLE Titre(
	isin VARCHAR(50),
	ticker VARCHAR(10),
	name VARCHAR(25)
);

CREATE TABLE Devise(
	deviseId SERIAL PRIMARY KEY,
	_money VARCHAR(20),
	change DECIMAL
)INHERITS (Titre);

CREATE table Indice(
	indiceId SERIAL PRIMARY KEY,
	deviseId INTEGER,
	marketPlace VARCHAR(20),
	countryCode VARCHAR(3),
	FOREIGN KEY (deviseId) REFERENCES Devise(deviseId)
)INHERITS (Titre);

CREATE TABLE _Action(
	actionId SERIAL PRIMARY KEY,
	sharePrice DECIMAL,
	deviseId INTEGER,
	indiceId INTEGER,
	FOREIGN KEY (deviseId) REFERENCES Devise(deviseId),
	FOREIGN KEY (indiceId) REFERENCES Indice(indiceId)
)INHERITS (Titre);

CREATE table ActionCostLog(
	costLogId SERIAL PRIMARY KEY,
	day DATE,
	time VARCHAR,
	cost DECIMAL,
	actionId INTEGER,
	FOREIGN KEY (actionId) REFERENCES _Action(actionId)
);

create table Wallet(
	walletId SERIAL PRIMARY KEY,
	_money MONEY
);

create table WalletActions(
	walletActionsId SERIAL PRIMARY KEY,
	walletId INTEGER,
	actionsIds INTEGER,
	quantity DECIMAL,
	FOREIGN KEY (walletId) REFERENCES wallet(walletid),
	FOREIGN KEY (actionsIds) REFERENCES _Action(actionId)
);

create table WalletActionsLog(
	walletactionslogid SERIAL PRIMARY KEY,
	day DATE,
	time VARCHAR,
	walletId INTEGER,
	actionsIds INTEGER,
	quantitybought DECIMAL,
	FOREIGN KEY (walletId) REFERENCES wallet(walletid),
	FOREIGN KEY (actionsIds) REFERENCES _Action(actionId)
);

CREATE TABLE Country(
	countryId SERIAL PRIMARY KEY,
	countryCode VARCHAR,
	countryName VARCHAR
);

CREATE TABLE _User(
	userId SERIAL PRIMARY KEY,
	firstName VARCHAR,
	lastName VARCHAR,
	avatar BYTEA,
	login VARCHAR,
	_password VARCHAR,
	countryId INTEGER,
	FOREIGN KEY (countryId) REFERENCES Country(countryId)
);

CREATE TABLE Game(
	gameId SERIAL PRIMARY KEY,
	indicesIds INTEGER,
	startHour VARCHAR,
	endHour VARCHAR,
	gameStatut VARCHAR,
	FOREIGN KEY (indicesIds) REFERENCES Indice(indiceId)
);

CREATE TABLE Player(
	playerId SERIAL PRIMARY KEY,
	gameId INTEGER,
	userId INTEGER,
	walletId INTEGER,
	FOREIGN KEY (gameId) REFERENCES Game(gameId),
	FOREIGN KEY (userId) REFERENCES _User(userId),
	FOREIGN KEY (walletId) REFERENCES Wallet(walletId)
);




