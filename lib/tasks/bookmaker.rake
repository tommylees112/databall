namespace :bookmakers do
  task seed: :environment do

    bookies = ['10Bet', '138.com', '21Bet', '888 Sport', 'ApolloBet', 'Bet 365', 'Betbright',
      'Betfair Sportsbook', 'Betfred', 'BetVictor', 'Betway', 'Boylesports', 'Comeon',
      'Coral', 'LeoVegas', 'Marathonbet.co.uk', 'MatchXtra', 'NetBet', 'Paddy Power', 'Skybet',
      'Smart Live Sports', 'Sportingbet', 'Stan James', 'Titan Bet', 'totesport', 'Vernons',
      'William Hill', 'youwin', 'Matchbook.com']

    bookies.each do |bookie|
      Bookmaker.create(name: bookie)
    end


 end
end
