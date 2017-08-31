require 'open-uri'
require 'nokogiri'

namespace :odds do
  task seed: :environment do
    desc 'Scrapes all odds from internet'

    DICTIONARY = {
      "Arsenal FC" => "arsenal",
      "Leicester City FC" => "leicester-city",
      "Watford FC" => "watford",
      "Liverpool FC" => "liverpool",
      "Southampton FC" => "southampton",
      "Swansea City FC" => "swansea-city",
      "West Bromwich Albion FC" => "west-bromwich-albion",
      "AFC Bournemouth" => "afc-bournemouth",
      "Everton FC" => "everton",
      "Stoke City FC" => "stoke-city",
      "Crystal Palace FC" => "crystal-palace",
      "Huddersfield Town" => "huddersfield-town",
      "Chelsea FC" => "chelsea",
      "Burnley FC" => "burnley",
      "Brighton & Hove Albion" => "brighton--hove-albion",
      "Manchester City FC" => "manchester-city",
      "Newcastle United FC" => "newcastle-united",
      "Tottenham Hotspur FC" => "tottenham-hotspur",
      "Manchester United FC" => "manchester-united",
      "West Ham United FC" => "west-ham",

      "AS Monaco FC" => "as-monaco",
      "AS Saint-Étienne" => "saint-%C3%A9tienne",
      "Amiens SC" => "amiens-sc",
      "Angers SCO" => "angers-sco",
      "Dijon FCO" => "dijon-fco",
      "EA Guingamp" => "en-avant-guingamp",
      "ES Troyes AC" => "troyes-ac",
      "FC Girondins de Bordeaux" => "girondins-de-bordeaux",
      "FC Metz" => "fc-metz",
      "FC Nantes" => "fc-nantes",
      "Montpellier Hérault SC" => "montpellier-hsc",
      "OGC Nice" => "ogc-nice",
      "OSC Lille" => "lille-osc",
      "Olympique Lyonnais" => "olympique-lyonnais",
      "Olympique de Marseille" => "olympique-marseille",
      "Paris Saint-Germain" => "paris-saint-germain",
      "RC Strasbourg Alsace" => "rc-strasbourg",
      "SM Caen" => "sm-caen",
      "Stade Rennais FC" => "stade-rennais",
      "Toulouse FC" => "toulouse-fc",

      "Athletic Club" => "athletic-bilbao",
      "CD Leganes" => "legan%C3%A9s",
      "Club Atlético de Madrid" => "atl%C3%A9tico-de-madrid",
      "Deportivo Alavés" => "deportivo-alaves",
      "FC Barcelona" => "fc-barcelona",
      "Getafe CF" => "getafe",
      "Girona FC" => "girona",
      "Levante UD" => "levante-ud",
      "Málaga CF" => "m%C3%A1laga",
      "RC Celta de Vigo" => "celta-de-vigo",
      "RC Deportivo La Coruna" => "deportivo-la-coru%C3%B1a",
      "RCD Espanyol" => "espanyol",
      "Real Betis" => "real-betis",
      "Real Madrid CF" => "real-madrid",
      "Real Sociedad de Fútbol" => "real-sociedad",
      "SD Eibar" => "sd-eibar",
      "Sevilla FC" => "sevilla",
      "UD Las Palmas" => "ud-las-palmas",
      "Valencia CF" => "valencia",
      "Villarreal CF" => "villarreal",

      "1. FC Köln" => "1-fc-k%C3%B6ln",
      "1. FSV Mainz 05" => "1-fsv-mainz-05",
      "Bayer Leverkusen" => "bayer-04-leverkusen",
      "Bor. Mönchengladbach" => "borussia-m%C3%B6nchengladbach",
      "Borussia Dortmund" => "borussia-dortmund",
      "Eintracht Frankfurt" => "eintracht-frankfurt",
      "FC Augsburg" => "fc-augsburg",
      "FC Bayern München" => "fc-bayern-m%C3%BCnchen",
      "FC Schalke 04" => "fc-schalke-04",
      "Hamburger SV" => "hamburger-sv",
      "Hannover 96" => "hannover-96",
      "Hertha BSC" => "hertha-bsc",
      "Red Bull Leipzig" => "rb-leipzig",
      "SC Freiburg" => "sc-freiburg",
      "TSG 1899 Hoffenheim" => "1899-hoffenheim",
      "VfB Stuttgart" => "vfb-stuttgart",
      "VfL Wolfsburg" => "vfl-wolfsburg",
      "Werder Bremen" => "werder-bremen",

      "Juventus Turin" => "juventus",
      "Cagliari Calcio" => "cagliari",
      "Hellas Verona FC" => "hellas-verona",
      "SSC Napoli" => "napoli",
      "Atalanta BC" => "atalanta",
      "AS Roma" => "as-roma",
      "Udinese Calcio" => "udinese",
      "AC Chievo Verona" => "chievo",
      "US Sassuolo Calcio" => "sassuolo",
      "Genoa CFC" => "genoa",
      "UC Sampdoria" => "sampdoria",
      "Benevento" => "benevento",
      "SS Lazio" => "lazio",
      "SPAL Ferrara" => "spal",
      "FC Internazionale Milano" => "internazionale",
      "ACF Fiorentina" => "fiorentina",
      "Bologna FC" => "bologna",
      "Torino FC" => "torino",
      "FC Crotone" => "crotone",
      "AC Milan" => "ac-milan",

      "Premier League" => "england/premier-league",
      "La Liga" => "spain/primera-divisi%C3%B3n",
      "Bundesliga" => "germany/fussball-bundesliga",
      "Serie A" => "italy/serie-a",
      "Ligue 1" => "france/le-championnat"
    }



    def build_url(match)
      gameweek = match.gameweek
      sub_url_fixture = DICTIONARY[match.home_team.name] + "-v-" + DICTIONARY[match.away_team.name]
      sub_url_league = DICTIONARY[match.league.name]
      url = "http://odds.bestbetting.com/football/#{sub_url_league}/round-#{gameweek}/#{sub_url_fixture}/match-result/all-odds"
    end

    def convert_odds(odd)
      odd_arr = odd.split("/")
      decimal = ((odd_arr[0].to_i / odd_arr[1].to_f) + 1).round(2)
    end

    Match.where(status: "TIMED").each do |match|
      p (match.home_team.name + "v" + match.away_team.name)
      url = build_url(match)
      html_file = open(url).read
      html_doc = Nokogiri::HTML(html_file)
      outcomes = ["Home", "Draw", "Away"]
      html_doc.search('.contents tr').each_with_index do |element, index|
        outcome = outcomes[index]
        element.search('.cellOdd').each do |column|
          odd = convert_odds(column.text.strip)
          Odd.create!(bookmaker: Bookmaker.find_by(name: column.attribute('title').value), match_id: match.id, outcome: outcome, odds: odd) if Bookmaker.find_by(name: column.attribute('title').value)
        end
      end
      # puts "about to sleep"
      # # sleep rand(10..14)
      # puts "back"
    end
  end

  task clean_up: :environment do
    desc 'Destroys all odds with no bets on them'
    Odd.left_outer_joins(:bets).where(bets: {odd_id: nil}).destroy_all
  end
end

















