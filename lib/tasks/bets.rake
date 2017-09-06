namespace :bets do
  task seed_historical: :environment do

    puts "Seeding Historical Bets ... "

    if User.where(email: "email@email.com").first
      User.where(email: "email@email.com").first.destroy
    end

    website_historical = User.create!(first_name: 'website_historical', email: "email@email.com", password: "password")

    def create_bet(bet_array)
      home = Team.find_by(name: bet_array[0])
      away = Team.find_by(name: bet_array[1])
      p "#{home.name} vs #{away.name}"
      match = Match.where(home_team: home).where(away_team: away).first
      bookmaker = Bookmaker.all.sample
      odd = Odd.create!(match: match, bookmaker: bookmaker, odds: bet_array[2], outcome: bet_array[3], rating: 50)
      Bet.create!(user: bet_array[4], stake: bet_array[5], odd: odd)
      match.save
    end

    historical_matches = [ ['1. FSV Mainz 05', 'Hannover 96', 1.95, "Home", website_historical, 10],
    ['AS Saint-Étienne', 'Amiens SC', 1.63, 'Home', website_historical, 10],
    ["Hertha BSC",  "VfB Stuttgart",  2.09, "Home", website_historical, 10],
    ["Crystal Palace FC",  "Huddersfield Town",  1.83, "Home", website_historical, 10],
    ["Leicester City FC", "Brighton & Hove Albion", 1.77, "Home", website_historical, 10],
    ["Borussia Dortmund", "Hertha BSC", 1.41, "Home", website_historical, 10],
    ["Newcastle United FC", "Tottenham Hotspur FC", 1.78, "Away", website_historical, 10],
    ["1. FC Köln",  "Hamburger SV", 2.05, "Home", website_historical, 10],
    ["Olympique Lyonnais",  "RC Strasbourg Alsace", 1.33, "Home", website_historical, 10],
    ["EA Guingamp", "RC Strasbourg Alsace", 1.78, "Home", website_historical, 10],
    ["Valencia CF", "UD Las Palmas",  1.83, "Home", website_historical, 10],
    ["FC Barcelona",  "Real Betis", 1.21, "Home", website_historical, 10],
    ["FC Bayern München", "Bayer Leverkusen", 1.3,  "Home", website_historical, 10],
    ["Benevento", "Bologna FC", 3.34, "Draw", website_historical, 10],
    ["Levante UD",  "RC Deportivo La Coruna", 3.45, "Draw", website_historical, 10],
    ["Athletic Club", "Getafe CF",  1.54, "Home", website_historical, 10],
    ["Paris Saint-Germain", "Amiens SC",  1.09, "Home", website_historical, 10],
    ["SPAL Ferrara",  "Udinese Calcio", 3.38, "Draw", website_historical, 10],
    ["OGC Nice",  "EA Guingamp",  1.91, "Home", website_historical, 10],
    ["Girona FC", "Málaga CF",  3.48, "Draw", website_historical, 10],
    ["OGC Nice",  "ES Troyes AC", 1.52, "Home", website_historical, 10],
    ["FC Augsburg", "Bor. Mönchengladbach", 3.56, "Draw", website_historical, 10] ]

    historical_matches.each do |match_array|
      create_bet(match_array)
    end

    puts "Historical bets made !!!"

  end
end

