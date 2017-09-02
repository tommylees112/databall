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

    combined = bookies.zip(image_codes)

    combined.each do |pair|
      Bookmaker.create(name: pair[0], logo: pair[1])
    end

 end
end
