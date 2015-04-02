library(tidyr)
library(dplyr)

pitching <- read.csv("data/FanGraphs_StandardPitching_2014.csv", stringsAsFactors = F)
pitching <- tbl_df(pitching)

pitching <- rename(pitching, demo.name = `ï..Name`
                   demo.team = Team,
                   stat.win = W,
                   stat.loss = L,
                   stat.save = SV,
                   stat.games = G,
                   stat.starts = GS,
                   stat.innings = IP,
                   stat.Kper9 = K.9,
                   stat.BBper9 = BB.9,
                   stat.HRper9 = HR.9,
                   stat.BBperIP = BABIP,
                   stat.leftonbase = LOB.,
                   stat.batted = GB., #Is this right?
                   stat.HR.FB = HR.FB, #What is this?
                   stat.ERA = ERA,
                   stat.FIP = FIP, #?
                   stat.XFIP = xFIP,
                   stat.WAR = WAR,
                   demo.id = playerid
                   )

pitching <- mutate(pitching, 
                   stat.leftonbase = as.numeric(sub(" %", "", stat.leftonbase))/100,
                   stat.batted = as.numeric(sub(" %", "", stat.batted))/100,
                   stat.HR.FB = as.numeric(sub(" %", "", stat.HR.FB))/100,
                   stat.outs = stat.innings%/%1*3 + stat.innings%%1*10
                   )
