require 'open-uri'
require 'nokogiri'

namespace :model do
  task seed: :environment do

    ## DICTIONARIES

DICTIONARY = {
    "man. united": "Manchester United FC",
    "man. city": "Manchester City FC",
    "chelsea": "Chelsea FC",
    "liverpool": "Liverpool FC",
    "tottenham": "Tottenham Hotspur FC",
    "arsenal": "Arsenal FC",
    "everton": "Everton FC",
    "leicester city": "Leicester City FC",
    "southampton": "Southampton FC",
    "burnley": "Burnley FC",
    "stoke city": "Stoke City FC",
    "west brom": "West Bromwich Albion FC",
    "watford": "Watford FC",
    "swansea city": "Swansea City FC",
    "west ham": "West Ham United FC",
    "bournemouth": "AFC Bournemouth",
    "huddersfield": "Huddersfield Town",
    "crystal palace": "Crystal Palace FC",
    "newcastle": "Newcastle United FC",
    "brighton": "Brighton & Hove Albion",
    "monaco": "AS Monaco FC",
    "st Étienne": "AS Saint-Étienne",
    "St Étienne": "AS Saint-Étienne",
    "St \U+FFC3tienne": "AS Saint-Étienne",
    "St tienne": "AS Saint-Etienne",
    "st \U+FFC3tienne": "AS Saint- tienne",
    "saint-%C3%A9tienne": "AS Saint-Étienne",
    "amiens": "Amiens SC",
    "angers": "Angers SCO",
    "dijon fco": "Dijon FCO",
    "guingamp": "EA Guingamp",
    "troyes": "ES Troyes AC",
    "bordeaux": "FC Girondins de Bordeaux",
    "metz": "FC Metz",
    "nantes": "FC Nantes",
    "montpellier": "Montpellier Hérault SC",
    "nice": "OGC Nice",
    "lille": "OSC Lille",
    "lyon": "Olympique Lyonnais",
    "marseille": "Olympique de Marseille",
    "psg": "Paris Saint-Germain",
    "strasbourg": "RC Strasbourg Alsace",
    "caen": "SM Caen",
    "rennes": "Stade Rennais FC",
    "toulouse": "Toulouse FC",
    "juventus": "Juventus Turin",
    "cagliari": "Cagliari Calcio",
    "verona": "Hellas Verona FC",
    "napoli": "SSC Napoli",
    "atalanta": "Atalanta BC",
    "roma": "AS Roma",
    "udinese": "Udinese Calcio",
    "chievo": "AC Chievo Verona",
    "sassuolo": "US Sassuolo Calcio",
    "genoa": "Genoa CFC",
    "sampdoria": "UC Sampdoria",
    "benevento": "Benevento",
    "lazio": "SS Lazio",
    "spal": "SPAL Ferrara",
    "inter milan": "FC Internazionale Milano",
    "fiorentina": "ACF Fiorentina",
    "bologna": "Bologna FC",
    "torino": "Torino FC",
    "crotone": "FC Crotone",
    "ac milan": "AC Milan",
    "athletic bilbao": "Athletic Club",
    "leganés": "CD Leganes",
    "leganés": "CD Leganes",
    "leganes": "CD Leganes",
    "legan%C3%A9s": "CD Leganes",
    "atlético madrid": "Club Atlético de Madrid",
    "atl%C3%A9tico madrid": "Club Atlético de Madrid",
    "Atl\U+FFC3\U+FFA9tico Madrid": "Club Atlético de Madrid",
    "alavés": "Deportivo Alavés",
    "Alavés": "Deportivo Alavés",
    "Alav\U+FFC3\U+FFA9s": "Deportivo Alavés",
    "barcelona": "FC Barcelona",
    "getafe": "Getafe CF",
    "girona": "Girona FC",
    "levante": "Levante UD",
    "málaga": "Málaga CF",
    "Málaga": "Málaga CF",
    "m%C3%A1laga": "Málaga CF",
    "M\U+FFC3\U+FFA1laga": "Málaga CF",
    "celta vigo": "RC Celta de Vigo",
    "deportivo": "RC Deportivo La Coruna",
    "espanyol": "RCD Espanyol",
    "real betis": "Real Betis",
    "real madrid": "Real Madrid CF",
    "real sociedad": "Real Sociedad de Fútbol",
    "eibar": "SD Eibar",
    "sevilla": "Sevilla FC",
    "las palmas": "UD Las Palmas",
    "valencia": "Valencia CF",
    "villarreal": "Villarreal CF",
    "1. fc cologne": "1. FC Köln",
    "1. FC Cologne":"1. FC Köln",
    "mainz": "1. FSV Mainz 05",
    "leverkusen": "Bayer Leverkusen",
    "gladbach": "Bor. Mönchengladbach",
    "dortmund": "Borussia Dortmund",
    "eintracht": "Eintracht Frankfurt",
    "fc augsburg": "FC Augsburg",
    "bayern munich": "FC Bayern München",
    "schalke 04": "FC Schalke 04",
    "hamburger sv": "Hamburger SV",
    "hannover 96": "Hannover 96",
    "hertha bsc": "Hertha BSC",
    "rb leipzig": "Red Bull Leipzig",
    "sc freiburg": "SC Freiburg",
    "hoffenheim": "TSG 1899 Hoffenheim",
    "vfb stuttgart": "VfB Stuttgart",
    "wolfsburg": "VfL Wolfsburg",
    "werder bremen": "Werder Bremen",
}

  def create_url(league)
    puts "Starting to seed data for the #{league.name} ... "
    league_name = league.name.downcase.strip.gsub(' ', '-')
    url = "https://projects.fivethirtyeight.com/soccer-predictions/#{league_name}/"
    return url
  end

  def parse_url(url)
    webpage = open(url).read
    html_doc = Nokogiri::HTML(webpage)
    return html_doc
  end

  def assign_team_model_variables(table_row, team_object, team_model_object, model_updated_date)
    ## GET THE VARIABLES
      spi = table_row.css('.num.rating.overall').attribute('data-val').value.to_f
      offensive_score = table_row.css('.num.rating.offense').attribute('data-val').value.to_f
      defensive_score = table_row.css('.num.rating.defense').attribute('data-val').value.to_f # higher the worse!
      simulated_wins = table_row.css('.num.record.wins').text.to_f
      simulated_losses = table_row.css('.num.record.losses').text.to_f
      simulated_draws = table_row.css('.num.record.ties').text.to_f

      values = []
      table_row.css('.num.record.drop-3').each do |element|
        values << element.text.to_f
      end
      simulated_goal_difference = values[0]
      simulated_season_total = values[1]

      values_2 = []
      table_row.css('.pct').each do |element|
        values_2 << element.attribute('data-val').value.to_f
      end
      relegation_probability = values_2[0]
      ucl_probability = values_2[1]
      league_win_probability = values_2[2].to_f

  ## SET THE VARIABLES
    team_model_object.soccer_power_index = spi
    team_model_object.defensive_score = defensive_score
    team_model_object.offensive_score = offensive_score
    team_model_object.simulated_wins = simulated_wins
    team_model_object.simulated_losses = simulated_losses
    team_model_object.simulated_draws = simulated_draws
    team_model_object.simulated_goal_difference = simulated_goal_difference
    team_model_object.simulated_season_total = simulated_season_total
    team_model_object.relegation_probability = relegation_probability
    team_model_object.ucl_probability = ucl_probability
    team_model_object.league_win_probability = league_win_probability.to_f
    team_model_object.last_updated = model_updated_date
    team_model_object.team = team_object

  ## SAVE THE OBJECT
    team_model_object.save!
  end

  def assign_match_model_variables(match, match_model_object, match_object, model_updated_date)
    draw_float = match.css('.tie-prob').text.to_i / 100.0

    probabilities = [] # push floats for outcomes
    match.css('.prob').each do |probability|
      probabilities << probability.text.to_i / 100.0
    end

    home_win_probability = probabilities[0]
    draw_probability = probabilities[1]
    away_win_probability = probabilities[2]

    ## SET THE VARIABLES
    match_model_object.match = match_object
    match_model_object.home_win_probability = home_win_probability
    match_model_object.away_win_probability = away_win_probability
    match_model_object.draw_probability = draw_probability
    match_model_object.date_updated = model_updated_date

    ## SAVE THE OBJECTS
    match_model_object.save
  end

  def assign_match_statistics(match_html, match_object)
      stats_rows = match_html.css('tr')[-3..-1].children

      _adj_goals = stats_rows[1..2]
      home_adj_goals = _adj_goals[0].inner_text.to_f
      away_adj_goals = _adj_goals[1].inner_text.to_f

      _shot_xg = stats_rows[4..5]
      home_shot_xg = _shot_xg[0].inner_text.to_f
      away_shot_xg = _shot_xg[1].inner_text.to_f

      _non_shot_xg = stats_rows[7..8]
      home_non_shot_xg = _non_shot_xg[0].inner_text.to_f
      away_non_shot_xg = _non_shot_xg[1].inner_text.to_f

      ##NEW
      probabilities = []
      match_html.css('.prob').each do |prob|
         proability_str = prob.inner_text
         proability_str.slice! "%"
         probabilities << proability_str.to_i / 100.0
      end

      final_home_win_probability = probabilities[0]
      final_away_win_probability = probabilities[1]
      final_draw_probability = probabilities[2]

    ## SET THE VARIABLES
      match_object.home_adj_goals = home_adj_goals
      match_object.away_adj_goals = away_adj_goals
      match_object.home_shot_xg = home_shot_xg
      match_object.away_shot_xg = away_shot_xg
      match_object.home_non_shot_xg = home_non_shot_xg
      match_object.away_non_shot_xg = away_non_shot_xg

    ## NEW
      match_object.final_home_win_probability = final_home_win_probability
      match_object.final_away_win_probability = final_away_win_probability
      match_object.final_draw_probability = final_draw_probability

    ## SAVE THE OBJECTS
      match_object.save
  end

  def find_date_model_updated(html_doc)
    time_string = html_doc.css('h3.timestamp').text.strip
    # => "Updated Aug. 27, 2017 at 12:55 PM"
    time_string.slice! "Updated "
    time_string.slice! "at "
    time_string.slice! "."
    # => "Aug 27, 2017 12:55 PM"
    model_updated_date = DateTime.strptime(time_string, '%b %e, %Y %m:%M %p')
    return model_updated_date
  end

  def find_team_object(team_string)
    team_object = Team.find_by_name(DICTIONARY["#{team_string}".to_sym])
    return team_object
  end

  def find_match_object(home_team_object, away_team_object)
    match_object = Match.find_by home_team: home_team_object, away_team: away_team_object
    return match_object
  end

  def find_team_names(match_html)
    team_names = []
    match_html.css('.name').each do |team_name|
      if team_name.text.downcase
        team_names << team_name.text.downcase
      end
    end
    return team_names
  end

  def verify_team_objects(_538_home_team, _538_away_team, home_team_object, away_team_object)
    puts "!! Match = #{_538_home_team} -v- #{_538_away_team} !! "
    puts "finding HOME: #{_538_home_team} name ... "
    if Team.find_by_name(DICTIONARY["#{_538_home_team}".to_sym])
      puts Team.find_by_name(DICTIONARY["#{_538_home_team}".to_sym]).name
      puts "object found"
    else
      puts "#{_538_home_team} object not found"
      puts 'Is nil?' + DICTIONARY["#{_538_home_team}".to_sym].nil?.to_s
    end

    puts "finding AWAY:#{_538_away_team} name ... "
    if Team.find_by_name(DICTIONARY["#{_538_away_team}".to_sym])
      puts Team.find_by_name(DICTIONARY["#{_538_away_team}".to_sym]).name
      puts "object found"
    else
      puts "#{_538_away_team} object not found"
      puts home_team_object
    end
  end

##############################################################################
####################  START THE CODE #########################################
##############################################################################
    # URL PARSING
    League.all.each do |league|
      url = create_url(league)
      html_doc = parse_url(url)
      model_updated_date = find_date_model_updated(html_doc)

      puts "---------- Getting Team Forecasts and Model Input Variables ..."
      #1 GET TEAM MODEL OUTPUTS
          _big_table = html_doc.search('#forecast-table').children.last
          _big_table.css('tr').each do |table_row|
              ## INIT THE OBJECTS
              team_parsed = table_row.css('.team').attribute('data-str').value
              team_object = find_team_object(team_parsed)
              team_model_object = TeamModelOutput.new()

              if team_object
                assign_team_model_variables(table_row, team_object, team_model_object, model_updated_date)
              end
          end

      puts "--------- Team Model Objects Created!"
##########
      puts "--------- Getting Match Model Outputs ... "
      # GET THE SECOND DIV with CLASS games-container.upcoming class (first is a weird hidden one)
      _all_matches = html_doc.search('.games-container.upcoming')[1].children[1..-1]
      _all_matches.each do |match_html|
        ## INIT THE OBJECTS
        team_names = find_team_names(match_html)
        _538_home_team = team_names[0]#.downcase
        _538_away_team = team_names[1]#.downcase

        home_team_object = find_team_object(_538_home_team)
        away_team_object = find_team_object(_538_away_team)
        # verify_team_objects(_538_home_team, _538_away_team,home_team_object, away_team_object)
        match_object = find_match_object(home_team_object, away_team_object)

        if match_object
          # build new match_model
          match_model_object = MatchModelOutput.new()
          ## GET THE VARIABLES
          assign_match_model_variables(match_html, match_model_object, match_object, model_updated_date)
        end
      end

      puts "--------- Match Model Outputs created!"
#########
      puts "--------- Getting Completed Match Statistics"
        _completed_match_div = html_doc.search('.games-container.completed').children
        # drop the first element(dirty)
        _all_completed_matches = _completed_match_div[1..-1]

        _all_completed_matches.each do |match_html|
          ## INIT THE OBJECTS (FIND THE MATCH)
          team_names = find_team_names(match_html)
          _538_home_team = team_names[0]
          _538_away_team = team_names[1]
          home_team_object = find_team_object(_538_home_team)
          away_team_object = find_team_object(_538_away_team)
          # verify_team_objects(_538_home_team, _538_away_team,home_team_object, away_team_object)
          match_object = find_match_object(home_team_object, away_team_object)
          ## GET THE VARIABLES
          # get the table rows with the stats
          if match_object
            assign_match_statistics(match_html, match_object)
            match_model_object = MatchModelOutput.new()
            assign_match_model_variables(match_html, match_model_object, match_object, model_updated_date)
          end
        end
      puts "--------- Completed Match Statistics!"

    # END THE LEAGUE LOOP
    puts "Ending for the #{league.name}!!!"
    puts "___________________________________"
    end

  end
end



