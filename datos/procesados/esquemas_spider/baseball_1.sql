CREATE TABLE `all_star` (
  `player_id` varchar(50) DEFAULT NULL,
  `year` int DEFAULT NULL,
  `game_num` int DEFAULT NULL,
  `game_id` varchar(50) DEFAULT NULL,
  `team_id` varchar(50) DEFAULT NULL,
  `league_id` varchar(50) DEFAULT NULL,
  `gp` double DEFAULT NULL,
  `starting_pos` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `appearances` (
  `year` int DEFAULT NULL,
  `team_id` varchar(50) DEFAULT NULL,
  `league_id` varchar(50) DEFAULT NULL,
  `player_id` varchar(50) DEFAULT NULL,
  `g_all` double DEFAULT NULL,
  `gs` double DEFAULT NULL,
  `g_batting` int DEFAULT NULL,
  `g_defense` double DEFAULT NULL,
  `g_p` int DEFAULT NULL,
  `g_c` int DEFAULT NULL,
  `g_1b` int DEFAULT NULL,
  `g_2b` int DEFAULT NULL,
  `g_3b` int DEFAULT NULL,
  `g_ss` int DEFAULT NULL,
  `g_lf` int DEFAULT NULL,
  `g_cf` int DEFAULT NULL,
  `g_rf` int DEFAULT NULL,
  `g_of` int DEFAULT NULL,
  `g_dh` double DEFAULT NULL,
  `g_ph` double DEFAULT NULL,
  `g_pr` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `batting` (
  `player_id` varchar(50) DEFAULT NULL,
  `year` int DEFAULT NULL,
  `stint` int DEFAULT NULL,
  `team_id` varchar(50) DEFAULT NULL,
  `league_id` varchar(50) DEFAULT NULL,
  `g` int DEFAULT NULL,
  `ab` double DEFAULT NULL,
  `r` double DEFAULT NULL,
  `h` double DEFAULT NULL,
  `double` double DEFAULT NULL,
  `triple` double DEFAULT NULL,
  `hr` double DEFAULT NULL,
  `rbi` double DEFAULT NULL,
  `sb` double DEFAULT NULL,
  `cs` double DEFAULT NULL,
  `bb` double DEFAULT NULL,
  `so` double DEFAULT NULL,
  `ibb` double DEFAULT NULL,
  `hbp` double DEFAULT NULL,
  `sh` double DEFAULT NULL,
  `sf` double DEFAULT NULL,
  `g_idp` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `batting_postseason` (
  `year` int DEFAULT NULL,
  `round` varchar(50) DEFAULT NULL,
  `player_id` varchar(50) DEFAULT NULL,
  `team_id` varchar(50) DEFAULT NULL,
  `league_id` varchar(50) DEFAULT NULL,
  `g` int DEFAULT NULL,
  `ab` int DEFAULT NULL,
  `r` int DEFAULT NULL,
  `h` int DEFAULT NULL,
  `double` int DEFAULT NULL,
  `triple` int DEFAULT NULL,
  `hr` int DEFAULT NULL,
  `rbi` int DEFAULT NULL,
  `sb` int DEFAULT NULL,
  `cs` double DEFAULT NULL,
  `bb` int DEFAULT NULL,
  `so` int DEFAULT NULL,
  `ibb` double DEFAULT NULL,
  `hbp` double DEFAULT NULL,
  `sh` double DEFAULT NULL,
  `sf` double DEFAULT NULL,
  `g_idp` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `college` (
  `college_id` varchar(50) DEFAULT NULL,
  `name_full` varchar(69) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `fielding` (
  `player_id` varchar(50) DEFAULT NULL,
  `year` int DEFAULT NULL,
  `stint` int DEFAULT NULL,
  `team_id` varchar(50) DEFAULT NULL,
  `league_id` varchar(50) DEFAULT NULL,
  `pos` varchar(50) DEFAULT NULL,
  `g` int DEFAULT NULL,
  `gs` double DEFAULT NULL,
  `inn_outs` double DEFAULT NULL,
  `po` double DEFAULT NULL,
  `a` double DEFAULT NULL,
  `e` double DEFAULT NULL,
  `dp` double DEFAULT NULL,
  `pb` double DEFAULT NULL,
  `wp` double DEFAULT NULL,
  `sb` double DEFAULT NULL,
  `cs` double DEFAULT NULL,
  `zr` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `fielding_outfield` (
  `player_id` varchar(50) DEFAULT NULL,
  `year` int DEFAULT NULL,
  `stint` int DEFAULT NULL,
  `glf` double DEFAULT NULL,
  `gcf` double DEFAULT NULL,
  `grf` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `fielding_postseason` (
  `player_id` varchar(50) DEFAULT NULL,
  `year` int DEFAULT NULL,
  `team_id` varchar(50) DEFAULT NULL,
  `league_id` varchar(50) DEFAULT NULL,
  `round` varchar(50) DEFAULT NULL,
  `pos` varchar(50) DEFAULT NULL,
  `g` int DEFAULT NULL,
  `gs` double DEFAULT NULL,
  `inn_outs` double DEFAULT NULL,
  `po` int DEFAULT NULL,
  `a` int DEFAULT NULL,
  `e` int DEFAULT NULL,
  `dp` int DEFAULT NULL,
  `tp` int DEFAULT NULL,
  `pb` double DEFAULT NULL,
  `sb` double DEFAULT NULL,
  `cs` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `hall_of_fame` (
  `player_id` varchar(50) DEFAULT NULL,
  `yearid` int DEFAULT NULL,
  `votedby` varchar(50) DEFAULT NULL,
  `ballots` double DEFAULT NULL,
  `needed` double DEFAULT NULL,
  `votes` double DEFAULT NULL,
  `inducted` varchar(50) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `needed_note` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `home_game` (
  `year` int DEFAULT NULL,
  `league_id` varchar(50) DEFAULT NULL,
  `team_id` varchar(50) DEFAULT NULL,
  `park_id` varchar(50) DEFAULT NULL,
  `span_first` varchar(50) DEFAULT NULL,
  `span_last` varchar(50) DEFAULT NULL,
  `games` int DEFAULT NULL,
  `openings` int DEFAULT NULL,
  `attendance` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `manager` (
  `player_id` varchar(50) DEFAULT NULL,
  `year` int DEFAULT NULL,
  `team_id` varchar(50) DEFAULT NULL,
  `league_id` varchar(50) DEFAULT NULL,
  `inseason` int DEFAULT NULL,
  `g` int DEFAULT NULL,
  `w` int DEFAULT NULL,
  `l` int DEFAULT NULL,
  `rank` double DEFAULT NULL,
  `plyr_mgr` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `manager_award` (
  `player_id` varchar(50) DEFAULT NULL,
  `award_id` varchar(50) DEFAULT NULL,
  `year` int DEFAULT NULL,
  `league_id` varchar(50) DEFAULT NULL,
  `tie` varchar(50) DEFAULT NULL,
  `notes` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `manager_award_vote` (
  `award_id` varchar(50) DEFAULT NULL,
  `year` int DEFAULT NULL,
  `league_id` varchar(50) DEFAULT NULL,
  `player_id` varchar(50) DEFAULT NULL,
  `points_won` int DEFAULT NULL,
  `points_max` int DEFAULT NULL,
  `votes_first` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `manager_half` (
  `player_id` varchar(50) DEFAULT NULL,
  `year` int DEFAULT NULL,
  `team_id` varchar(50) DEFAULT NULL,
  `league_id` varchar(50) DEFAULT NULL,
  `inseason` int DEFAULT NULL,
  `half` int DEFAULT NULL,
  `g` int DEFAULT NULL,
  `w` int DEFAULT NULL,
  `l` int DEFAULT NULL,
  `rank` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `park` (
  `park_id` varchar(50) DEFAULT NULL,
  `park_name` varchar(50) DEFAULT NULL,
  `park_alias` varchar(74) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `pitching` (
  `player_id` varchar(50) DEFAULT NULL,
  `year` int DEFAULT NULL,
  `stint` int DEFAULT NULL,
  `team_id` varchar(50) DEFAULT NULL,
  `league_id` varchar(50) DEFAULT NULL,
  `w` int DEFAULT NULL,
  `l` int DEFAULT NULL,
  `g` int DEFAULT NULL,
  `gs` int DEFAULT NULL,
  `cg` int DEFAULT NULL,
  `sho` int DEFAULT NULL,
  `sv` int DEFAULT NULL,
  `ipouts` double DEFAULT NULL,
  `h` int DEFAULT NULL,
  `er` int DEFAULT NULL,
  `hr` int DEFAULT NULL,
  `bb` int DEFAULT NULL,
  `so` int DEFAULT NULL,
  `baopp` double DEFAULT NULL,
  `era` double DEFAULT NULL,
  `ibb` double DEFAULT NULL,
  `wp` double DEFAULT NULL,
  `hbp` double DEFAULT NULL,
  `bk` int DEFAULT NULL,
  `bfp` double DEFAULT NULL,
  `gf` double DEFAULT NULL,
  `r` int DEFAULT NULL,
  `sh` double DEFAULT NULL,
  `sf` double DEFAULT NULL,
  `g_idp` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `pitching_postseason` (
  `player_id` varchar(50) DEFAULT NULL,
  `year` int DEFAULT NULL,
  `round` varchar(50) DEFAULT NULL,
  `team_id` varchar(50) DEFAULT NULL,
  `league_id` varchar(50) DEFAULT NULL,
  `w` int DEFAULT NULL,
  `l` int DEFAULT NULL,
  `g` int DEFAULT NULL,
  `gs` int DEFAULT NULL,
  `cg` int DEFAULT NULL,
  `sho` int DEFAULT NULL,
  `sv` int DEFAULT NULL,
  `ipouts` int DEFAULT NULL,
  `h` int DEFAULT NULL,
  `er` int DEFAULT NULL,
  `hr` int DEFAULT NULL,
  `bb` int DEFAULT NULL,
  `so` int DEFAULT NULL,
  `baopp` varchar(50) DEFAULT NULL,
  `era` double DEFAULT NULL,
  `ibb` double DEFAULT NULL,
  `wp` double DEFAULT NULL,
  `hbp` double DEFAULT NULL,
  `bk` double DEFAULT NULL,
  `bfp` double DEFAULT NULL,
  `gf` int DEFAULT NULL,
  `r` int DEFAULT NULL,
  `sh` double DEFAULT NULL,
  `sf` double DEFAULT NULL,
  `g_idp` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `player` (
  `player_id` varchar(50) DEFAULT NULL,
  `birth_year` double DEFAULT NULL,
  `birth_month` double DEFAULT NULL,
  `birth_day` double DEFAULT NULL,
  `birth_country` varchar(50) DEFAULT NULL,
  `birth_state` varchar(50) DEFAULT NULL,
  `birth_city` varchar(50) DEFAULT NULL,
  `death_year` double DEFAULT NULL,
  `death_month` double DEFAULT NULL,
  `death_day` double DEFAULT NULL,
  `death_country` varchar(50) DEFAULT NULL,
  `death_state` varchar(50) DEFAULT NULL,
  `death_city` varchar(50) DEFAULT NULL,
  `name_first` varchar(50) DEFAULT NULL,
  `name_last` varchar(50) DEFAULT NULL,
  `name_given` varchar(50) DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `height` double DEFAULT NULL,
  `bats` varchar(50) DEFAULT NULL,
  `throws` varchar(50) DEFAULT NULL,
  `debut` varchar(50) DEFAULT NULL,
  `final_game` varchar(50) DEFAULT NULL,
  `retro_id` varchar(50) DEFAULT NULL,
  `bbref_id` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `player_award` (
  `player_id` varchar(50) DEFAULT NULL,
  `award_id` varchar(50) DEFAULT NULL,
  `year` int DEFAULT NULL,
  `league_id` varchar(50) DEFAULT NULL,
  `tie` varchar(50) DEFAULT NULL,
  `notes` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `player_award_vote` (
  `award_id` varchar(50) DEFAULT NULL,
  `year` int DEFAULT NULL,
  `league_id` varchar(50) DEFAULT NULL,
  `player_id` varchar(50) DEFAULT NULL,
  `points_won` double DEFAULT NULL,
  `points_max` int DEFAULT NULL,
  `votes_first` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `player_college` (
  `player_id` varchar(50) DEFAULT NULL,
  `college_id` varchar(50) DEFAULT NULL,
  `year` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `postseason` (
  `year` int DEFAULT NULL,
  `round` varchar(50) DEFAULT NULL,
  `team_id_winner` varchar(50) DEFAULT NULL,
  `league_id_winner` varchar(50) DEFAULT NULL,
  `team_id_loser` varchar(50) DEFAULT NULL,
  `league_id_loser` varchar(50) DEFAULT NULL,
  `wins` int DEFAULT NULL,
  `losses` int DEFAULT NULL,
  `ties` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `salary` (
  `year` int DEFAULT NULL,
  `team_id` varchar(50) DEFAULT NULL,
  `league_id` varchar(50) DEFAULT NULL,
  `player_id` varchar(50) DEFAULT NULL,
  `salary` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `team` (
  `year` int DEFAULT NULL,
  `league_id` varchar(50) DEFAULT NULL,
  `team_id` varchar(50) DEFAULT NULL,
  `franchise_id` varchar(50) DEFAULT NULL,
  `div_id` varchar(50) DEFAULT NULL,
  `rank` int DEFAULT NULL,
  `g` int DEFAULT NULL,
  `ghome` double DEFAULT NULL,
  `w` int DEFAULT NULL,
  `l` int DEFAULT NULL,
  `div_win` varchar(50) DEFAULT NULL,
  `wc_win` varchar(50) DEFAULT NULL,
  `lg_win` varchar(50) DEFAULT NULL,
  `ws_win` varchar(50) DEFAULT NULL,
  `r` int DEFAULT NULL,
  `ab` int DEFAULT NULL,
  `h` int DEFAULT NULL,
  `double` int DEFAULT NULL,
  `triple` int DEFAULT NULL,
  `hr` int DEFAULT NULL,
  `bb` int DEFAULT NULL,
  `so` double DEFAULT NULL,
  `sb` double DEFAULT NULL,
  `cs` double DEFAULT NULL,
  `hbp` double DEFAULT NULL,
  `sf` double DEFAULT NULL,
  `ra` int DEFAULT NULL,
  `er` int DEFAULT NULL,
  `era` double DEFAULT NULL,
  `cg` int DEFAULT NULL,
  `sho` int DEFAULT NULL,
  `sv` int DEFAULT NULL,
  `ipouts` int DEFAULT NULL,
  `ha` int DEFAULT NULL,
  `hra` int DEFAULT NULL,
  `bba` int DEFAULT NULL,
  `soa` int DEFAULT NULL,
  `e` int DEFAULT NULL,
  `dp` double DEFAULT NULL,
  `fp` double DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `park` varchar(70) DEFAULT NULL,
  `attendance` double DEFAULT NULL,
  `bpf` int DEFAULT NULL,
  `ppf` int DEFAULT NULL,
  `team_id_br` varchar(50) DEFAULT NULL,
  `team_id_lahman45` varchar(50) DEFAULT NULL,
  `team_id_retro` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `team_franchise` (
  `franchise_id` varchar(50) DEFAULT NULL,
  `franchise_name` varchar(50) DEFAULT NULL,
  `active` varchar(50) DEFAULT NULL,
  `na_assoc` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `team_half` (
  `year` int DEFAULT NULL,
  `league_id` varchar(50) DEFAULT NULL,
  `team_id` varchar(50) DEFAULT NULL,
  `half` int DEFAULT NULL,
  `div_id` varchar(50) DEFAULT NULL,
  `div_win` varchar(50) DEFAULT NULL,
  `rank` int DEFAULT NULL,
  `g` int DEFAULT NULL,
  `w` int DEFAULT NULL,
  `l` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
