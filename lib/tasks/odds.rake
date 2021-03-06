require 'open-uri'
require 'nokogiri'

namespace :odds do
  task seed: :environment do
    desc 'Scrapes all odds from internet'

    puts "Starting odds seed ..."

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
      if odd.include?("/")
        odd_arr = odd.split("/")
        decimal = ((odd_arr[0].to_i / odd_arr[1].to_f) + 1).round(2)
      else
        decimal = odd.to_i + 1
      end
      return decimal
    end

    def rate_bet(outcome, odd, match)
      if outcome == "Home"
        model_prob = match.model_output.home_win_probability
      elsif outcome == "Away"
        model_prob = match.model_output.away_win_probability
      else
        model_prob = match.model_output.draw_probability
      end
      return rating = (odd * model_prob).round(2)
    end

    def make_odds(match)
      p (match.home_team.name + " v " + match.away_team.name)
      url = build_url(match)
      p url
      html_file = open(url).read
      html_doc = Nokogiri::HTML(html_file)
      outcomes = ["Home", "Draw", "Away"]
      html_doc.search('.contents tr').each_with_index do |element, index|
        outcome = outcomes[index]
        element.search('.cellOdd').each do |column|
          frac_odd = column.text.strip
          odd = convert_odds(frac_odd)
          rating = rate_bet(outcome, odd, match)
          Odd.create(bookmaker: Bookmaker.find_by(name: column.attribute('title').value), match_id: match.id, outcome: outcome, odds: odd, rating: rating, frac_odd: frac_odd) if Bookmaker.find_by(name: column.attribute('title').value)
        end
      end
    end

    def find_league_id
      leagues = []
      prem = League.find_by name: "Premier League"
      laliga = League.find_by name: "La Liga"
      bund = League.find_by name: "Bundesliga"
      serie = League.find_by name: "Serie A"
      ligue = League.find_by name: "Ligue 1"
      leagues = [prem, laliga, bund, serie, ligue]
      return leagues
    end

    leagues = find_league_id
    # leagues[0].id
    # leagues[1].id
    # leagues[2].id
    # leagues[3].id
    # leagues[4].id
    # (League.find_by name: "Premier League").id
    # (League.find_by name: "La Liga").id
    # (League.find_by name: "Bundesliga").id
    # (League.find_by name: "Serie A").id
    # (League.find_by name: "Ligue 1").id

    puts "------ Scraping odds for Premier League ------"
    Match.where(status: "TIMED").where(league: (League.find_by name: "Premier League").id).order(:gameweek).first(20).each do |match|
      make_odds(match)
    end

    puts "------ Scraping odds for La Liga ------"
    Match.where(status: "TIMED").where(league: (League.find_by name: "La Liga").id).order(:gameweek).first(20).each do |match|
      make_odds(match)
    end

    puts "------ Scraping odds for Bundesliga ------"
    Match.where(status: "TIMED").where(league: (League.find_by name: "Bundesliga").id).order(:gameweek).first(18).each do |match|
      make_odds(match)
    end

    puts "------ Scraping odds for Serie A ------"
    Match.where(status: "TIMED").where(league: (League.find_by name: "Serie A").id).order(:gameweek).first(20).each do |match|
      make_odds(match)
    end

    puts "------ Scraping odds for Ligue 1 ------"
    Match.where(status: "TIMED").where(league: (League.find_by name: "Ligue 1").id).order(:gameweek).first(20).each do |match|
      make_odds(match)
    end
  end

  task clean_up: :environment do
    desc 'Destroys all odds with no bets on them'
    Odd.left_outer_joins(:bets).where(bets: {odd_id: nil}).destroy_all
  end

  task match_test: :environment do
    fixtures_url = 'http://api.football-data.org/v1/competitions/450/fixtures'
    fixtures_serialized = open(fixtures_url).read
    fixtures = JSON.parse(fixtures_serialized)
    fixtures["fixtures"].each do |fixture|
    fixture["_links"]["self"]["href"]
    end
  end

  task clean_up_h2h_matches: :environment do
    Match.where(status: "H2H").destroy_all
  end












end
