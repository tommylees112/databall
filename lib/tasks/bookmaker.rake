namespace :bookmakers do
  task seed: :environment do

    bookies = ['10Bet', '138.com', '21Bet', '888 Sport', 'ApolloBet', 'Bet 365', 'Betbright',
      'Betfair Sportsbook', 'Betfred', 'BetVictor', 'Betway', 'Boylesports', 'Comeon',
      'Coral', 'LeoVegas', 'Marathonbet.co.uk', 'NetBet', 'Paddy Power', 'Skybet',
      'Smart Live Sports', 'Sportingbet', 'Stan James', 'Titan Bet', 'totesport', 'Vernons',
      'William Hill', 'youwin', 'Matchbook.com']

    image_codes = ["10bet_wmfyje", "138.com_nsjvl6", "21bet_cbqqyu", "888_zrj7r9", "apollobet_pzl4hx",
      "bet365_iknws0", "bet-bright_uijini", "betfair_febhgp", "betfred_rbmrsw", "betvictor_i4qwix",
      "betway_y3qvuj", "boylesports_zrl2wl", "comeon_colu1k", "coral_qptmlr", "leovegas_t4mk2i", "marathonbet_rvghai",
      "netbet_digdmw", "paddpower_hql07v", "skybet_tkxbmg", "smartlive_m8s2hq", "sportingbet_zg78bi", "stanjames_fxadp2",
      "titanbet_myroxr", "totesport_teb0xc", "vernons_m4lwla", "williamhill_slev2s", "youwin_sbk43n", "matchbook_mqyvri"]

    urls = ["https://www.10bet.co.uk/sports/football/", "https://global.138.com/en-gb/sportsbook", "https://www.21bet.co.uk/sportsbook/SOCCER/",
      "https://www.888sport.com/football/football-betting.htm#/filter/football", "https://www.apollobet.com", "https://www.bet365.com/#/HO/",
      "https://www.betbright.com/football", "https://www.betfair.com/sport/football", "http://www.betfred.com/sport", "https://www.betvictor.com/en-gb/sports/football",
      "https://sports.betway.com/en/sports/grp/soccer/spain/copa-del-rey", "http://www.boylesports.com/betting/football/?navigationid=top,23.1",
      "https://www.comeon.com/gb/sports/", "http://sports.coral.co.uk/football", "https://www.leovegassports.com/en/sportsbook/football/",
      "https://www.marathonbet.co.uk/en/betting/Football/", "https://sport.netbet.co.uk/football/", "http://www.paddypower.com/football/?",
      "https://www.skybet.com", "http://dlpsport.titanbet.co.uk/uk-football.html?gclid=", "https://www.sportingbet.com/sports-football/0-102-410.html",
      "https://www.stanjames.com/football-betting", "https://www.titanbet.co.uk", "https://www.totesport.com/sports/b/football",
      "http://sports.vernons.com/en", "http://sports.williamhill.com/bet/en-gb/betting/y/5/Football.html", "https://www.youwin.com/sports-football/0-102-102.html",
      "https://www.matchbook.com/events/soccer"]

    combined = bookies.zip(image_codes, urls)

    combined.each do |group|
      Bookmaker.create(name: group[0], logo: group[1], url: group[2])
    end

 end
end
