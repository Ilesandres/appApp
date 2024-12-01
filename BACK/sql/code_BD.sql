DROP DATABASE IF EXISTS `app_raices`;
CREATE DATABASE IF NOT EXISTS `app_raices`;
USE `app_raices`;

CREATE TABLE users(
idUser INT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
mail VARCHAR(30) NOT NULL,
`password` TINYTEXT NOT NULL,
createdAt DATETIME,
updateAt DATETIME
);
CREATE TABLE gender(
idGender INT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
`name` VARCHAR(10),
createdAt DATETIME,
updateAt DATETIME
);
CREATE TABLE people(
idPeople INT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
`name` VARCHAR (50) NOT NULL,
lastName VARCHAR (50)NOT NULL,
birthdate DATE NOT NULL,
profilePicture VARCHAR (255),
idUser INT(20),
idGender INT (20),
FOREIGN KEY(idUser)REFERENCES users (idUser),
FOREIGN KEY(idGender)REFERENCES gender (idGender),
createdAt DATETIME,
updateAt DATETIME
);

CREATE TABLE roles(
idRol INT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
`name` VARCHAR(15) DEFAULT 'student',
createdAt DATETIME,
updateAt DATETIME
);
CREATE TABLE userRoles(
idUserRol INT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
idUser INT(20),
idRol INT(20),
FOREIGN KEY(idUser)REFERENCES users(idUser),
FOREIGN KEY(idRol)REFERENCES roles(idRol),
createdAt DATETIME,
updateAt DATETIME
);
CREATE TABLE languages(
idLanguage INT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
`name` VARCHAR(15) NOT NULL,
community VARCHAR(15) NOT NULL,
DESCRIPTION TINYTEXT,
createdAt DATETIME,
updateAt DATETIME 
);
CREATE TABLE levels(
idLevel INT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
`name` VARCHAR(15),
createdAt DATETIME,
updateAt DATETIME
);
CREATE TABLE  lessons(
idLesson INT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
idLanguage INT(20),
idLevel INT(20) DEFAULT NULL,
title VARCHAR(15) NOT NULL,
`description` TINYTEXT NOT NULL,
isPremium BOOLEAN DEFAULT FALSE,
FOREIGN KEY(idLanguage) REFERENCES languages(idLanguage),
FOREIGN KEY(idLevel) REFERENCES Levels(idLevel),
createdAt DATETIME,
updateAt DATETIME
);
CREATE TABLE userLesson(
idUserLesson INT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
idUser INT(20),
idLesson INT(20),
score INT(20),
lastAccess DATETIME,
FOREIGN KEY(idLesson) REFERENCES lessons(idLesson),
FOREIGN KEY(idUser)REFERENCES users(idUser),
createdAt DATETIME,
updateAt DATETIME
);

CREATE TABLE mediaFiles(
idMediaFile INT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
media VARCHAR(10) NOT NULL,
createdAt DATETIME,
updateAt DATETIME  
);
CREATE TABLE content(
idContent INT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
idUser INT(20),
idLesson INT(20),
idMediaFile INT(20),
url VARCHAR(255),
`description` TINYTEXT NOT NULL,
FOREIGN KEY(idUser)REFERENCES users(idUser),
FOREIGN KEY(idLesson) REFERENCES lessons(idLesson),
FOREIGN KEY(idMediaFile) REFERENCES mediaFiles(idMediaFile),
createdAt DATETIME,
updateAt DATETIME
);
CREATE TABLE state(
idState INT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
`name` VARCHAR(15) NOT NULL,
createdAt DATETIME,
updateAt DATETIME
);
CREATE TABLE learningProgress(
idProgress INT(20) NOT NULL AUTO_INCREMENT PRIMARY KEY,
idUser INT(20),
idLesson INT(20),
idState INT(20),
initDate DATETIME NOT NULL,
endDate DATETIME NOT NULL,
score INT(20),
attempCount INT(20),
timeSpent TIME,
FOREIGN KEY(idUser)REFERENCES users(idUser),
FOREIGN KEY(idLesson)REFERENCES lessons(idLesson),
FOREIGN KEY(idState)REFERENCES state(idState),
createdAt DATETIME,
updateAt DATETIME
);
CREATE TABLE subscriptions (
idSubscription INT(20)NOT NULL AUTO_INCREMENT PRIMARY KEY,
idUser INT(20),
subscriptionType VARCHAR(10),
startDate DATE,
endDate DATE,
`status` VARCHAR(12) NOT NULL,
FOREIGN KEY(idUser)REFERENCES users(idUser),
createdAt DATETIME,
updateAt DATETIME
);
CREATE TABLE paymentsGateways(
idPaymentsGateway INT(20)NOT NULL AUTO_INCREMENT PRIMARY KEY,
gateway VARCHAR(50),
createdAt DATETIME,
updateAt DATETIME
);
CREATE TABLE payments(
idPayment INT(20)NOT NULL AUTO_INCREMENT PRIMARY KEY,
paymentCode VARCHAR(255),
idUser INT(20),
idSubscription INT(20),
idPaymentMehod INT(20),
idPaymentsGateway INT(20),
`status` VARCHAR(15),
paymentDate DATETIME NOT NULL,
amount DECIMAL(10,2),
FOREIGN KEY(idUser)REFERENCES users(idUser),
FOREIGN KEY(idSubscription)REFERENCES subscriptions(idSubscription),
FOREIGN KEY(idPaymentsGateway)REFERENCES paymentsGateways(idPaymentsGateway),
createdAt DATETIME,
updateAt DATETIME
);
CREATE TABLE paymentMethods(
idPaymentMehod INT(20)NOT NULL AUTO_INCREMENT PRIMARY KEY,
methodName VARCHAR(15),
createdAt DATETIME,
updateAt DATETIME
);
CREATE TABLE auditLogs (
idAuditLogs INT(20)NOT NULL AUTO_INCREMENT PRIMARY KEY,
`user` VARCHAR(255),
`action` VARCHAR(50),
tableName VARCHAR(255),
recordId INT,
oldValue TEXT,
newValue TEXT,
actionTime TEXT
);