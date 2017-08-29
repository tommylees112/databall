require 'open-uri'
require 'nokogiri'

namespace :model do
  task seed: :environment do

    ## DICTIONARIES

    DICTIONARY = { "man. united": "Manchester United FC",
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
      "brighton": "Brighton & Hove Albion"
    }

    # URL
    League.all.each do |league|
      league_name = league.name.downcase.strip.gsub(' ', '-')
      url = "https://projects.fivethirtyeight.com/soccer-predictions/#{league_name}/"
    end

      url = "https://projects.fivethirtyeight.com/soccer-predictions/premier-league/"
      webpage = open(url).read
      html_doc = Nokogiri::HTML(webpage)


      # GET TIMESTAMP FOR MODEL UPDATED AT ...
      time_string = html_doc.css('.timestamp').last.text.strip
      # => "Updated Aug. 27, 2017 at 12:55 PM"
      #clean up the string
      time_string.slice! "Updated "
      time_string.slice! "at "
      time_string.slice! ". "
      # => "Aug 27, 2017 12:55 PM"
      date_object = DateTime.strptime(time_string, '%b %e, %Y %m:%M %p')

###############
    #1 GET TEAM MODEL OUTPUTS
      League.first.teams.each do |team|
      end

    ##### ATTEMPT 2 ########
        html_doc.search('#forecast-table').each do |_big_table|
          _table_body = _big_table.css('tbody')
          _table_body.css('tr').each do |table_row|

            ## INIT THE OBJECTS
            team = table_row.css('.team').attribute('data-str').value
            team_object = Team.find_by_name(DICTIONARY["#{team_parsed}".to_sym])
            team_model_object = TeamModelOutput.new()

            ## GET THE VARIABLES
              spi = table_row.css('.num.rating.overall').attribute('data-val').value.to_f
              offensive_score = table_row.css('.num.rating.offense').attribute('data-val').value.to_f
              defensive_score = table_row.css('.num.rating.defense').attribute('data-val').value.to_f # higher the worse!
              simulated_wins = table_row.css('.num.record.wins').text.to_f
              simulated_losses = table_row.css('.num.record.losses').text.to_f
              simulated_draws = table_row.css('.num.record.ties').text.to_f

              values = []
              table_row.css('.num.record.drop-3').each do |element|
                << element.text.to_f
              end
              simulated_goal_difference = values[0]
              simulated_season_total = values[1]

              values_2 = []
              table_row.css('.pct').each do |element|
                values_2 << element.attribute('data-val').value.to_f
              end
              relegation_probability = values_2[0]
              ucl_probability = values_2[1]
              league_win_probability = values_2[2]

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
              team_model_object.league_win_probability = league_win_probability
              team_model_object.last_updated = date_object

            ## SAVE THE OBJECTS
            team_model_object.save!
            team_object.team_model_output = team_model_object
          end
        end

##########
    #2 GET MATCH MODEL OUTPUTS
    # ONLY DO FOR FINISHED MATCHES
    # FIND MATCH BY home_team & away_team (unique!)
    # THEN ASSIGN PROBABILITIES to a new OBJECT (CLASS INSTANCE)
      Match.where("status = 'FINISHED'").each do |match|
      end
  _all_matches = html_doc.search('.games-container.upcoming').first
  _all_matches.children.css('.match_container').each do |match|

      ## INIT THE OBJECTS
      match_model_object = MatchModelOutput.new()

      ## GET THE VARIABLES

      ## SET THE VARIABLES

      ## SAVE THE OBJECTS


# MatchModelOutput
#  home_win_probability: nil,
#  away_win_probability: nil,
#  draw_probability: nil,
#  date_updated: nil,
#  match_id: nil,

#########
  html_doc.css('.games-container.completed').each.do |_big_table|
  end
      #3 GET MATCH STATS
      Match.where("league_id = 1").each do ||
        Match.where("status = 'FINISHED'").each do ||
        end
        Match.where("status NOT = 'FINISHED'").each do || #??
        end
      end




  end
end



