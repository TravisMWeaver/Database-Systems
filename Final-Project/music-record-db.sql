CREATE SCHEMA `music_rec_info_sys` ;

-- MySQL Workbench Synchronization
-- Generated: 2017-04-30 17:49
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Travis Weaver

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE TABLE IF NOT EXISTS `music_rec_info_sys`.`Musician` (
  `musician_id` INT(11) NOT NULL,
  `SSN` INT(11) NULL DEFAULT NULL,
  `first_name` VARCHAR(20) NOT NULL,
  `last_name` VARCHAR(20) NOT NULL,
  `phone_number` VARCHAR(16) NOT NULL,
  PRIMARY KEY (`musician_id`),
  INDEX `phoneNum_idx` (`phone_number` ASC),
  CONSTRAINT `phone_number_m_fk`
    FOREIGN KEY (`phone_number`)
    REFERENCES `music_rec_info_sys`.`Household` (`phoneNum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `music_rec_info_sys`.`Instrument` (
  `instrument_id` INT(11) NOT NULL,
  `name` VARCHAR(32) NULL DEFAULT NULL,
  `musical_key` VARCHAR(16) NULL DEFAULT NULL,
  PRIMARY KEY (`instrument_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `music_rec_info_sys`.`Album` (
  `album_id` INT(11) NOT NULL,
  `copyright_date` DATE NULL DEFAULT NULL,
  `format` VARCHAR(36) NULL DEFAULT NULL,
  `producer` INT(11) NULL DEFAULT NULL,
  `album_title` VARCHAR(64) NULL DEFAULT NULL,
  PRIMARY KEY (`album_id`),
  INDEX `mId_idx` (`producer` ASC),
  CONSTRAINT `musician_id_a_fk`
    FOREIGN KEY (`producer`)
    REFERENCES `music_rec_info_sys`.`Musician` (`musician_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `music_rec_info_sys`.`Household` (
  `phoneNum` VARCHAR(16) NOT NULL,
  `address` VARCHAR(64) NULL DEFAULT NULL,
  PRIMARY KEY (`phoneNum`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `music_rec_info_sys`.`Songs` (
  `title` VARCHAR(64) NOT NULL,
  `author_id` INT(11) NULL DEFAULT NULL,
  `album_id` INT(11) NOT NULL,
  `track_number` INT(11) NOT NULL,
  PRIMARY KEY (`album_id`, `track_number`),
  INDEX `mID_idx` (`author_id` ASC),
  CONSTRAINT `album_id_s_fk`
    FOREIGN KEY (`album_id`)
    REFERENCES `music_rec_info_sys`.`Album` (`album_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `musician_id_s_fk`
    FOREIGN KEY (`author_id`)
    REFERENCES `music_rec_info_sys`.`Musician` (`musician_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `music_rec_info_sys`.`Instruments_For_Musician` (
  `instrument_id` INT(11) NOT NULL,
  `musician_id` INT(11) NOT NULL,
  PRIMARY KEY (`instrument_id`, `musician_id`),
  INDEX `musician_id_im_fk_idx` (`musician_id` ASC),
  CONSTRAINT `instrument_id_im_fk`
    FOREIGN KEY (`instrument_id`)
    REFERENCES `music_rec_info_sys`.`Instrument` (`instrument_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `musician_id_im_fk`
    FOREIGN KEY (`musician_id`)
    REFERENCES `music_rec_info_sys`.`Musician` (`musician_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `music_rec_info_sys`.`Song_Credits` (
  `album_id` INT(11) NOT NULL,
  `track_number` INT(11) NOT NULL,
  `musician_id` INT(11) NOT NULL,
  PRIMARY KEY (`album_id`, `track_number`, `musician_id`),
  INDEX `musician_id_sc_fk_idx` (`musician_id` ASC),
  CONSTRAINT `song_info_sc_fk`
    FOREIGN KEY (`album_id` , `track_number`)
    REFERENCES `music_rec_info_sys`.`Songs` (`album_id` , `track_number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `musician_id_sc_fk`
    FOREIGN KEY (`musician_id`)
    REFERENCES `music_rec_info_sys`.`Musician` (`musician_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

---------------------------------------------------------------

INSERT INTO `music_rec_info_sys`.`Household` (`phoneNum`, `address`) VALUES ('123-456-7890', '123 Cool St. Miami, FL 33133');
INSERT INTO `music_rec_info_sys`.`Household` (`phoneNum`, `address`) VALUES ('112-233-4455', '217 Live Oak Ln. Altamonte Springs, FL 32714');
INSERT INTO `music_rec_info_sys`.`Household` (`phoneNum`, `address`) VALUES ('305-000-1111', '3845 Beep Boop Rd. Miami FL, 33245');
INSERT INTO `music_rec_info_sys`.`Household` (`phoneNum`, `address`) VALUES ('786-111-0000', '8899 Big Flood Rd. Miami Beach, FL 33341');
INSERT INTO `music_rec_info_sys`.`Household` (`phoneNum`, `address`) VALUES ('407-256-4620', '3339 Virginia St. Miami, FL 33133');
INSERT INTO `music_rec_info_sys`.`Household` (`phoneNum`, `address`) VALUES ('567-923-0908', '9712 Hepatitis Ct. Austin, TX 78345');
INSERT INTO `music_rec_info_sys`.`Household` (`phoneNum`, `address`) VALUES ('1-800-555-0505', '675 Big Buck Rd. Billings, MT 82543');

---------------------------------------------------------------

-- MySQL Workbench Synchronization
-- Generated: 2017-04-30 18:02
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Travis Weaver

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

ALTER TABLE `music_rec_info_sys`.`Household` 
CHANGE COLUMN `phoneNum` `phone_number` VARCHAR(16) NOT NULL ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-----

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

ALTER TABLE `music_rec_info_sys`.`Musician` 
CHANGE COLUMN `SSN` `SSN` VARCHAR(11) NULL DEFAULT NULL ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


---------------------------------------------------------------

INSERT INTO `music_rec_info_sys`.`Musician` (`musician_id`, `SSN`, `first_name`, `last_name`, `phone_number`) VALUES ('1', '123-45-6789', 'John', 'Jacobs', '123-456-7890');
INSERT INTO `music_rec_info_sys`.`Musician` (`musician_id`, `SSN`, `first_name`, `last_name`, `phone_number`) VALUES ('2', '837-89-8934', 'Bill', 'Hicks', '123-456-7890');
INSERT INTO `music_rec_info_sys`.`Musician` (`musician_id`, `SSN`, `first_name`, `last_name`, `phone_number`) VALUES ('3', '228-39-9900', 'Jill', 'Butters', '567-923-0908');
INSERT INTO `music_rec_info_sys`.`Musician` (`musician_id`, `SSN`, `first_name`, `last_name`, `phone_number`) VALUES ('4', '928-11-3409', 'Trevor', 'Hendricks', '112-233-4455');
INSERT INTO `music_rec_info_sys`.`Musician` (`musician_id`, `SSN`, `first_name`, `last_name`, `phone_number`) VALUES ('5', '743-88-4755', 'Zach', 'Miller', '1-800-555-0505');

INSERT INTO `music_rec_info_sys`.`Instrument` (`instrument_id`, `name`, `musical_key`) VALUES ('1', 'Violin', 'C');
INSERT INTO `music_rec_info_sys`.`Instrument` (`instrument_id`, `name`, `musical_key`) VALUES ('2', 'Oboe', 'C');
INSERT INTO `music_rec_info_sys`.`Instrument` (`instrument_id`, `name`, `musical_key`) VALUES ('3', 'Bass', 'C');
INSERT INTO `music_rec_info_sys`.`Instrument` (`instrument_id`, `name`, `musical_key`) VALUES ('4', 'Piano', 'C');
INSERT INTO `music_rec_info_sys`.`Instrument` (`instrument_id`, `name`, `musical_key`) VALUES ('5', 'Trumpet', 'B Flat');
INSERT INTO `music_rec_info_sys`.`Instrument` (`instrument_id`, `name`, `musical_key`) VALUES ('6', 'Clarinet', 'B Flat');
INSERT INTO `music_rec_info_sys`.`Instrument` (`instrument_id`, `name`, `musical_key`) VALUES ('7', 'Soprano Saxophone', 'B Flat');
INSERT INTO `music_rec_info_sys`.`Instrument` (`instrument_id`, `name`, `musical_key`) VALUES ('8', 'Tenor Saxophone', 'B Flat');
INSERT INTO `music_rec_info_sys`.`Instrument` (`instrument_id`, `name`, `musical_key`) VALUES ('9', 'French Horn', 'F');
INSERT INTO `music_rec_info_sys`.`Instrument` (`instrument_id`, `name`, `musical_key`) VALUES ('10', 'English Horn', 'F');
INSERT INTO `music_rec_info_sys`.`Instrument` (`instrument_id`, `name`, `musical_key`) VALUES ('11', 'Flute', 'C');
INSERT INTO `music_rec_info_sys`.`Instrument` (`instrument_id`, `name`, `musical_key`) VALUES ('12', 'Tuba', 'C');
INSERT INTO `music_rec_info_sys`.`Instrument` (`instrument_id`, `name`, `musical_key`) VALUES ('13', 'Alto Saxophone', 'E Flat');
INSERT INTO `music_rec_info_sys`.`Instrument` (`instrument_id`, `name`, `musical_key`) VALUES ('14', 'Baritone Saxophone', 'E Flat');
INSERT INTO `music_rec_info_sys`.`Instrument` (`instrument_id`, `name`, `musical_key`) VALUES ('15', 'Guitar', 'C');
INSERT INTO `music_rec_info_sys`.`Instrument` (`instrument_id`, `name`, `musical_key`) VALUES ('16', 'Bass Guitar', 'C');
INSERT INTO `music_rec_info_sys`.`Instrument` (`instrument_id`, `name`, `musical_key`) VALUES ('17', 'Clarinet', 'B Flat');
INSERT INTO `music_rec_info_sys`.`Instrument` (`instrument_id`, `name`, `musical_key`) VALUES ('18', 'Piccolo Clarinet', 'A Flat');
INSERT INTO `music_rec_info_sys`.`Instrument` (`instrument_id`, `name`, `musical_key`) VALUES ('19', 'Drums', 'C');
INSERT INTO `music_rec_info_sys`.`Instrument` (`instrument_id`, `name`, `musical_key`) VALUES ('20', 'Harp', 'C');

INSERT INTO `music_rec_info_sys`.`Musician` (`musician_id`, `SSN`, `first_name`, `last_name`, `phone_number`) VALUES ('6', '892-92-8495', 'Thomas', 'Bangalter', '305-000-1111');

INSERT INTO `music_rec_info_sys`.`Album` (`album_id`, `copyright_date`, `format`, `producer`, `album_title`) VALUES ('1', '2009-01-01', 'CD', '3', 'In Rainbows');
INSERT INTO `music_rec_info_sys`.`Album` (`album_id`, `copyright_date`, `format`, `producer`, `album_title`) VALUES ('2', '2000-01-01', 'Vinyl', '3', 'Kid A');
INSERT INTO `music_rec_info_sys`.`Album` (`album_id`, `copyright_date`, `format`, `producer`, `album_title`) VALUES ('3', '2001-01-01', 'CD', '6', 'Discovery');
INSERT INTO `music_rec_info_sys`.`Album` (`album_id`, `copyright_date`, `format`, `producer`, `album_title`) VALUES ('4', '1997-01-01', 'CD', '6', 'Homework');
INSERT INTO `music_rec_info_sys`.`Album` (`album_id`, `copyright_date`, `format`, `producer`, `album_title`) VALUES ('5', '2005-01-01', 'Vinyl', '6', 'Human After All');
INSERT INTO `music_rec_info_sys`.`Album` (`album_id`, `copyright_date`, `format`, `producer`, `album_title`) VALUES ('6', '2013-01-01', 'CD', '6', 'Random Access Memories');
INSERT INTO `music_rec_info_sys`.`Album` (`album_id`, `copyright_date`, `format`, `producer`, `album_title`) VALUES ('7', '2003-01-01', 'CD', '6', 'Daft Club');
INSERT INTO `music_rec_info_sys`.`Album` (`album_id`, `copyright_date`, `format`, `producer`, `album_title`) VALUES ('8', '2012-01-01', 'EP', '2', 'Moderation');
INSERT INTO `music_rec_info_sys`.`Album` (`album_id`, `copyright_date`, `format`, `producer`, `album_title`) VALUES ('9', '2013-01-01', 'Vinyl', '1', 'Outrun');
INSERT INTO `music_rec_info_sys`.`Album` (`album_id`, `copyright_date`, `format`, `producer`, `album_title`) VALUES ('10', '2010-01-01', 'EP', '1', 'Nightcall');
INSERT INTO `music_rec_info_sys`.`Album` (`album_id`, `copyright_date`, `format`, `producer`, `album_title`) VALUES ('11', '2008-01-01', 'CD', '4', 'Los Angeles');
INSERT INTO `music_rec_info_sys`.`Album` (`album_id`, `copyright_date`, `format`, `producer`, `album_title`) VALUES ('12', '2012-01-01', 'CD', '4', 'Until the Quiet Comes');
INSERT INTO `music_rec_info_sys`.`Album` (`album_id`, `copyright_date`, `format`, `producer`, `album_title`) VALUES ('13', '2010-01-01', 'Vinyl', '4', 'Cosmogramma');
INSERT INTO `music_rec_info_sys`.`Album` (`album_id`, `copyright_date`, `format`, `producer`, `album_title`) VALUES ('14', '2007-01-01', 'CD', '5', 'Oi Oi Oi');
INSERT INTO `music_rec_info_sys`.`Album` (`album_id`, `copyright_date`, `format`, `producer`, `album_title`) VALUES ('15', '2009-01-01', 'CD', '5', 'Power');

UPDATE `music_rec_info_sys`.`Instrument` SET `name`='Banjo', `musical_key`='C' WHERE `instrument_id`='17';

INSERT INTO `music_rec_info_sys`.`Instruments_For_Musician` (`instrument_id`, `musician_id`) VALUES ('1', '1');
INSERT INTO `music_rec_info_sys`.`Instruments_For_Musician` (`instrument_id`, `musician_id`) VALUES ('4', '1');
INSERT INTO `music_rec_info_sys`.`Instruments_For_Musician` (`instrument_id`, `musician_id`) VALUES ('15', '1');
INSERT INTO `music_rec_info_sys`.`Instruments_For_Musician` (`instrument_id`, `musician_id`) VALUES ('4', '2');
INSERT INTO `music_rec_info_sys`.`Instruments_For_Musician` (`instrument_id`, `musician_id`) VALUES ('19', '2');
INSERT INTO `music_rec_info_sys`.`Instruments_For_Musician` (`instrument_id`, `musician_id`) VALUES ('20', '2');
INSERT INTO `music_rec_info_sys`.`Instruments_For_Musician` (`instrument_id`, `musician_id`) VALUES ('16', '3');
INSERT INTO `music_rec_info_sys`.`Instruments_For_Musician` (`instrument_id`, `musician_id`) VALUES ('3', '3');
INSERT INTO `music_rec_info_sys`.`Instruments_For_Musician` (`instrument_id`, `musician_id`) VALUES ('4', '3');
INSERT INTO `music_rec_info_sys`.`Instruments_For_Musician` (`instrument_id`, `musician_id`) VALUES ('5', '4');
INSERT INTO `music_rec_info_sys`.`Instruments_For_Musician` (`instrument_id`, `musician_id`) VALUES ('7', '4');
INSERT INTO `music_rec_info_sys`.`Instruments_For_Musician` (`instrument_id`, `musician_id`) VALUES ('13', '4');
INSERT INTO `music_rec_info_sys`.`Instruments_For_Musician` (`instrument_id`, `musician_id`) VALUES ('15', '4');
INSERT INTO `music_rec_info_sys`.`Instruments_For_Musician` (`instrument_id`, `musician_id`) VALUES ('5', '5');
INSERT INTO `music_rec_info_sys`.`Instruments_For_Musician` (`instrument_id`, `musician_id`) VALUES ('6', '5');
INSERT INTO `music_rec_info_sys`.`Instruments_For_Musician` (`instrument_id`, `musician_id`) VALUES ('7', '5');
INSERT INTO `music_rec_info_sys`.`Instruments_For_Musician` (`instrument_id`, `musician_id`) VALUES ('8', '5');
INSERT INTO `music_rec_info_sys`.`Instruments_For_Musician` (`instrument_id`, `musician_id`) VALUES ('19', '6');
INSERT INTO `music_rec_info_sys`.`Instruments_For_Musician` (`instrument_id`, `musician_id`) VALUES ('20', '6');
INSERT INTO `music_rec_info_sys`.`Instruments_For_Musician` (`instrument_id`, `musician_id`) VALUES ('1', '6');
INSERT INTO `music_rec_info_sys`.`Instruments_For_Musician` (`instrument_id`, `musician_id`) VALUES ('4', '6');

INSERT INTO `music_rec_info_sys`.`Songs` (`title`, `author_id`, `album_id`, `track_number`) VALUES ('Nude', '3', '1', '3');
INSERT INTO `music_rec_info_sys`.`Songs` (`title`, `author_id`, `album_id`, `track_number`) VALUES ('All I Need', '3', '1', '5');
INSERT INTO `music_rec_info_sys`.`Songs` (`title`, `author_id`, `album_id`, `track_number`) VALUES ('Jigsaw Falling Into Place', '6', '1', '9');
INSERT INTO `music_rec_info_sys`.`Songs` (`title`, `author_id`, `album_id`, `track_number`) VALUES ('Everything In Its Right Place', '3', '2', '1');
INSERT INTO `music_rec_info_sys`.`Songs` (`title`, `author_id`, `album_id`, `track_number`) VALUES ('Kid A', '3', '2', '2');
INSERT INTO `music_rec_info_sys`.`Songs` (`title`, `author_id`, `album_id`, `track_number`) VALUES ('Idioteque', '3', '2', '8');
INSERT INTO `music_rec_info_sys`.`Songs` (`title`, `author_id`, `album_id`, `track_number`) VALUES ('One More Time', '6', '3', '1');
INSERT INTO `music_rec_info_sys`.`Songs` (`title`, `author_id`, `album_id`, `track_number`) VALUES ('Harder, Better, Faster, Stronger', '6', '3', '4');
INSERT INTO `music_rec_info_sys`.`Songs` (`title`, `author_id`, `album_id`, `track_number`) VALUES ('Digital Love', '6', '3', '3');
INSERT INTO `music_rec_info_sys`.`Songs` (`title`, `author_id`, `album_id`, `track_number`) VALUES ('Fresh', '3', '4', '6');
INSERT INTO `music_rec_info_sys`.`Songs` (`title`, `author_id`, `album_id`, `track_number`) VALUES ('Around the World', '6', '4', '7');
INSERT INTO `music_rec_info_sys`.`Songs` (`title`, `author_id`, `album_id`, `track_number`) VALUES ('Television Rules the Nation', '6', '5', '8');
INSERT INTO `music_rec_info_sys`.`Songs` (`title`, `author_id`, `album_id`, `track_number`) VALUES ('Giorgio By Morodor', '6', '6', '3');
INSERT INTO `music_rec_info_sys`.`Songs` (`title`, `author_id`, `album_id`, `track_number`) VALUES ('Within', '5', '6', '4');
INSERT INTO `music_rec_info_sys`.`Songs` (`title`, `author_id`, `album_id`, `track_number`) VALUES ('Moderation', '2', '8', '1');
INSERT INTO `music_rec_info_sys`.`Songs` (`title`, `author_id`, `album_id`, `track_number`) VALUES ('Reversion', '2', '8', '2');
INSERT INTO `music_rec_info_sys`.`Songs` (`title`, `author_id`, `album_id`, `track_number`) VALUES ('Blizzard', '1', '9', '2');
INSERT INTO `music_rec_info_sys`.`Songs` (`title`, `author_id`, `album_id`, `track_number`) VALUES ('Protovision', '1', '9', '3');
INSERT INTO `music_rec_info_sys`.`Songs` (`title`, `author_id`, `album_id`, `track_number`) VALUES ('Odd Look', '1', '9', '4');
INSERT INTO `music_rec_info_sys`.`Songs` (`title`, `author_id`, `album_id`, `track_number`) VALUES ('Rampage', '1', '9', '5');
INSERT INTO `music_rec_info_sys`.`Songs` (`title`, `author_id`, `album_id`, `track_number`) VALUES ('Suburbia', '6', '9', '6');
INSERT INTO `music_rec_info_sys`.`Songs` (`title`, `author_id`, `album_id`, `track_number`) VALUES ('Nightcall', '1', '10', '1');
INSERT INTO `music_rec_info_sys`.`Songs` (`title`, `author_id`, `album_id`, `track_number`) VALUES ('Pacific Coast Highway', '1', '10', '2');
INSERT INTO `music_rec_info_sys`.`Songs` (`title`, `author_id`, `album_id`, `track_number`) VALUES ('Nightcall (Dustin N\'Guyen Remix)', '1', '10', '3');
INSERT INTO `music_rec_info_sys`.`Songs` (`title`, `author_id`, `album_id`, `track_number`) VALUES ('Pacific Coast Highway (Jackson Remix)', '1', '10', '4');
INSERT INTO `music_rec_info_sys`.`Songs` (`title`, `author_id`, `album_id`, `track_number`) VALUES ('Brainfeeder', '4', '11', '1');
INSERT INTO `music_rec_info_sys`.`Songs` (`title`, `author_id`, `album_id`, `track_number`) VALUES ('Camel', '4', '11', '4');
INSERT INTO `music_rec_info_sys`.`Songs` (`title`, `author_id`, `album_id`, `track_number`) VALUES ('SexSlaveShip', '4', '11', '14');
INSERT INTO `music_rec_info_sys`.`Songs` (`title`, `author_id`, `album_id`, `track_number`) VALUES ('All In', '4', '12', '1');
INSERT INTO `music_rec_info_sys`.`Songs` (`title`, `author_id`, `album_id`, `track_number`) VALUES ('Getting There', '4', '12', '2');
INSERT INTO `music_rec_info_sys`.`Songs` (`title`, `author_id`, `album_id`, `track_number`) VALUES ('Until the Colours Come', '6', '12', '3');
INSERT INTO `music_rec_info_sys`.`Songs` (`title`, `author_id`, `album_id`, `track_number`) VALUES ('Zodiac Shit', '4', '13', '5');
INSERT INTO `music_rec_info_sys`.`Songs` (`title`, `author_id`, `album_id`, `track_number`) VALUES ('Table Tennis', '4', '13', '16');
INSERT INTO `music_rec_info_sys`.`Songs` (`title`, `author_id`, `album_id`, `track_number`) VALUES ('& Down', '5', '14', '1');
INSERT INTO `music_rec_info_sys`.`Songs` (`title`, `author_id`, `album_id`, `track_number`) VALUES ('Shine Shine', '5', '14', '8');
INSERT INTO `music_rec_info_sys`.`Songs` (`title`, `author_id`, `album_id`, `track_number`) VALUES ('Jeffer', '5', '15', '4');
INSERT INTO `music_rec_info_sys`.`Songs` (`title`, `author_id`, `album_id`, `track_number`) VALUES ('Transmission', '6', '15', '5');

INSERT INTO `music_rec_info_sys`.`Song_Credits` (`album_id`, `track_number`, `musician_id`) VALUES ('1', '3', '3');
INSERT INTO `music_rec_info_sys`.`Song_Credits` (`album_id`, `track_number`, `musician_id`) VALUES ('1', '3', '6');
INSERT INTO `music_rec_info_sys`.`Song_Credits` (`album_id`, `track_number`, `musician_id`) VALUES ('1', '5', '3');
INSERT INTO `music_rec_info_sys`.`Song_Credits` (`album_id`, `track_number`, `musician_id`) VALUES ('1', '5', '6');
INSERT INTO `music_rec_info_sys`.`Song_Credits` (`album_id`, `track_number`, `musician_id`) VALUES ('1', '9', '3');
INSERT INTO `music_rec_info_sys`.`Song_Credits` (`album_id`, `track_number`, `musician_id`) VALUES ('1', '9', '6');
INSERT INTO `music_rec_info_sys`.`Song_Credits` (`album_id`, `track_number`, `musician_id`) VALUES ('6', '3', '6');
INSERT INTO `music_rec_info_sys`.`Song_Credits` (`album_id`, `track_number`, `musician_id`) VALUES ('6', '3', '5');
INSERT INTO `music_rec_info_sys`.`Song_Credits` (`album_id`, `track_number`, `musician_id`) VALUES ('6', '4', '6');
INSERT INTO `music_rec_info_sys`.`Song_Credits` (`album_id`, `track_number`, `musician_id`) VALUES ('6', '4', '5');
INSERT INTO `music_rec_info_sys`.`Song_Credits` (`album_id`, `track_number`, `musician_id`) VALUES ('11', '1', '4');
INSERT INTO `music_rec_info_sys`.`Song_Credits` (`album_id`, `track_number`, `musician_id`) VALUES ('11', '1', '1');
INSERT INTO `music_rec_info_sys`.`Song_Credits` (`album_id`, `track_number`, `musician_id`) VALUES ('13', '5', '4');
INSERT INTO `music_rec_info_sys`.`Song_Credits` (`album_id`, `track_number`, `musician_id`) VALUES ('13', '5', '6');
INSERT INTO `music_rec_info_sys`.`Song_Credits` (`album_id`, `track_number`, `musician_id`) VALUES ('13', '5', '2');

-----------------------------------

-- MySQL Workbench Synchronization
-- Generated: 2017-05-05 19:19
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Travis Weaver

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

ALTER TABLE `music_rec_info_sys`.`Musician` 
DROP FOREIGN KEY `phone_number_m_fk`;

ALTER TABLE `music_rec_info_sys`.`Album` 
DROP FOREIGN KEY `musician_id_a_fk`;

ALTER TABLE `music_rec_info_sys`.`Instruments_For_Musician` 
DROP FOREIGN KEY `instrument_id_im_fk`,
DROP FOREIGN KEY `musician_id_im_fk`;

ALTER TABLE `music_rec_info_sys`.`Song_Credits` 
DROP FOREIGN KEY `musician_id_sc_fk`;

ALTER TABLE `music_rec_info_sys`.`Musician` 
ADD CONSTRAINT `phone_number_m_fk`
  FOREIGN KEY (`phone_number`)
  REFERENCES `music_rec_info_sys`.`Household` (`phone_number`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `music_rec_info_sys`.`Album` 
ADD CONSTRAINT `musician_id_a_fk`
  FOREIGN KEY (`producer`)
  REFERENCES `music_rec_info_sys`.`Musician` (`musician_id`)
  ON DELETE SET NULL
  ON UPDATE CASCADE;

ALTER TABLE `music_rec_info_sys`.`Instruments_For_Musician` 
ADD CONSTRAINT `instrument_id_im_fk`
  FOREIGN KEY (`instrument_id`)
  REFERENCES `music_rec_info_sys`.`Instrument` (`instrument_id`)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
ADD CONSTRAINT `musician_id_im_fk`
  FOREIGN KEY (`musician_id`)
  REFERENCES `music_rec_info_sys`.`Musician` (`musician_id`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `music_rec_info_sys`.`Song_Credits` 
DROP FOREIGN KEY `song_info_sc_fk`;

ALTER TABLE `music_rec_info_sys`.`Song_Credits` ADD CONSTRAINT `song_info_sc_fk`
  FOREIGN KEY (`album_id` , `track_number`)
  REFERENCES `music_rec_info_sys`.`Songs` (`album_id` , `track_number`)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
ADD CONSTRAINT `musician_id_sc_fk`
  FOREIGN KEY (`musician_id`)
  REFERENCES `music_rec_info_sys`.`Musician` (`musician_id`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

