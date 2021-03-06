-- Run code in SQL tab

CREATE TABLE `users` (
 `user_id` int(8) NOT NULL AUTO_INCREMENT,
 `user_email` varchar(255) NOT NULL,
 `user_password` varchar(255) NOT NULL,
 `user_role` varchar(20) NOT NULL DEFAULT 'student',
 `user_firstname` varchar(45) NOT NULL,
 `user_lastname` varchar(45) NOT NULL,
 `user_university` int(8) NOT NULL,
 PRIMARY KEY (`user_id`),
 UNIQUE KEY(`user_email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `universities` (
 `university_id` int(8) NOT NULL AUTO_INCREMENT,
 `university_name` varchar(255) NOT NULL,
 `university_domain` varchar(45) NOT NULL,
 `university_location` varchar(255) NOT NULL,
 PRIMARY KEY (`university_id`),
 UNIQUE KEY(`university_name`,`university_domain`,`university_location`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `events` (
 `event_id` int(8) NOT NULL AUTO_INCREMENT,
 `event_name` varchar(255) NOT NULL,
 `event_type` varchar(45) NOT NULL,
 `event_description` varchar(255) NOT NULL,
 `event_email` varchar(255) NOT NULL,
 `event_phone` varchar(255) NOT NULL,
 `event_location` varchar(255) NOT NULL,
 `event_date_start` DATETIME NOT NULL,
 `event_date_end` DATETIME NOT NULL,
 `event_university` int(8),
 `event_rso` varchar(255),
 PRIMARY KEY (`event_id`),
 UNIQUE KEY(`event_id`,`event_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `comments` (
 `comment_id` int(8) NOT NULL AUTO_INCREMENT,
 `comment_poster` varchar(255) NOT NULL,
 `comment_body` varchar(255) NOT NULL,
 `comment_event` int(8) NOT NULL,
 PRIMARY KEY (`comment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `rsos` (
 `rso_id` int(8) NOT NULL AUTO_INCREMENT,
 `rso_name` varchar(255) NOT NULL,
 `rso_description` varchar(255) NOT NULL,
 `rso_email` varchar(255) NOT NULL,
 `rso_phone` varchar(255) NOT NULL,
 `rso_university_id` int(8) NOT NULL,
 `rso_approval` int(1) NOT NULL DEFAULT 0,
 `rso_admin` varchar(255) NOT NULL,
 PRIMARY KEY (`rso_id`),
 CONSTRAINT `rso_is_associated_with` FOREIGN KEY (`rso_university_id`) REFERENCES `universities` (`university_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- sql trigger that checks if  there are greater than 5 users in a petition for a particular rso (that was created to the temp table). If this is the case then it adds that temp rso to the pending approvals list
CREATE TABLE `rso_petitions` (
 `petition_rso_id` int(8) NOT NULL,
 `petition_user_id` int(8) NOT NULL,
 CONSTRAINT `pk_rso_user` PRIMARY KEY (`petition_rso_id`, `petition_user_id`),
 CONSTRAINT `petition_rso_is_associated_with` FOREIGN KEY (`petition_rso_id`) REFERENCES `rsos` (`rso_id`) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT `petition_user` FOREIGN KEY (`petition_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- -- sql trigger that checks if  there are greater than 5 users in a petition for a particular rso (that was created to the temp table). If this is the case then it adds that temp rso to the pending approvals list
-- CREATE TABLE `rso_petitions` (
--  `petition_rso_id` int(8) NOT NULL,
--  `petition_user_id` int(8) NOT NULL,
--  PRIMARY KEY (`petition_rso_id`, ),
--  CONSTRAINT `rso_is_associated_with` FOREIGN KEY (`petition_rso_id`) REFERENCES `temp_rsos` (`temp_rso_id`) ON DELETE CASCADE ON UPDATE CASCADE
--  CONSTRAINT `petition_user` FOREIGN KEY (`petition_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
-- ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- CREATE TABLE `temp_rsos` (
--  `temp_rso_id` int(8) NOT NULL AUTO_INCREMENT,
--  `temp_rso_name` varchar(255) NOT NULL,
--  `temp_rso_university_id` int(8) NOT NULL,
--  PRIMARY KEY (`temp_rso_id`),
--  CONSTRAINT `rso_is_associated_with` FOREIGN KEY (`temp_rso_university_id`) REFERENCES `universities` (`university_id`) ON DELETE CASCADE ON UPDATE CASCADE
-- ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- CREATE TABLE `rso_pending_approvals` (
--  `pending_approval_id` int(8) NOT NULL,
--  `temp_rso_id` int(8) NOT NULL,
--  PRIMARY KEY (`pending_approval_id`),
--  CONSTRAINT `rso_is_associated_with` FOREIGN KEY (`temp_rso_id`) REFERENCES `temp_rsos` (`temp_rso_id`) ON DELETE CASCADE ON UPDATE CASCADE
-- ) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `user_associates_rso` (
 `user_email` varchar(255) NOT NULL,
 `rso_name` varchar(255) NOT NULL,
  PRIMARY KEY (`user_email`,`rso_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `user_associates_university` (
 `user_id` int(8) NOT NULL,
 `university_id` int(8) NOT NULL,
 KEY `user_id` (`user_id`),
 KEY `university_id` (`university_id`),
 CONSTRAINT `user_associates_university_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT `user_associates_university_2` FOREIGN KEY (`university_id`) REFERENCES `universities` (`university_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `messages` (
 `message_id` int(8) NOT NULL AUTO_INCREMENT,
 `message_header` VARCHAR(45) NOT NULL,
 `message_content` VARCHAR(255) NOT NULL,
 `to_user_id` int(8) NOT NULL,
 `from_user_id` int(8) NOT NULL,
 `creation_time` datetime NOT NULL,
 PRIMARY KEY (`message_id`),
 KEY `to_user_id` (`to_user_id`),
 KEY `from_user_id` (`from_user_id`),
 CONSTRAINT `message_recipient` FOREIGN KEY (`to_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT `message_sender` FOREIGN KEY (`from_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
