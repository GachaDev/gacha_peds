CREATE TABLE IF NOT EXISTS `gacha_peds` (
  `identifier` varchar(50) NOT NULL,
  `peds` longtext NOT NULL DEFAULT '',
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
