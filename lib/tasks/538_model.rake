require 'open-uri'
require 'nokogiri'

namespace :model do
  task seed: :environment do

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

      ## GET EACH ROW OF THE TABLE
      # get the team names from the row (but with pts inside the span)
        teams_dirty = []
        html_doc.search('.team-row').each do |row|
          teams_dirty << row.css('.name').text.strip
        end
        # use the last 20 (too many for some reason)
        prem_teams_dirty = teams_dirty.last(20) #only premier league team names eg "Man. United9 pts"
        teams = []
        # clean up the team names
        prem_teams_dirty.each do |team|
          teams << team.slice(0..(team.index(/\d/)))[0..-2] #remove after the number
        end
        # use the teams
        html_doc.search('.team-row').each do |row|
          teams.each do |team|
            # find the right team based on the parsed string
            team_object = Team.find_by_name(DICTIONARY["#{team}".to_sym])
            #create a new TeamModelOuput object
            team_model_object = TeamModelOutput.new()

            team_model_object.last_updated = row.css('.num.rating.overall').text.strip.to_f
            team_model_object.defensive_score = row.css('.num.rating.overall').text.strip.to_f
            team_model_object.offensive_score = row.css('.num.rating.overall').text.strip.to_f
            team_model_object.simulated_wins = row.css('.num.rating.overall').text.strip.to_f
            team_model_object.simulated_losses =
            team_model_object.simulated_draws =
            team_model_object.simulated_goal_difference =
            team_model_object.simulated_season_total =
            team_model_object.relegation_probability =
            team_model_object.ucl_probability =
            team_model_object.league_win_probability =

            team_model_object.save!
            team.team_model_output = team_model_object
          end
        end

# TeamModelOutput OBJECT
  # defensive_score: nil,
  # offensive_score: nil,
  # simulated_wins: nil,
  # simulated_losses: nil,
  # simulated_draws: nil,
  # simulated_goal_difference: nil,
  # simulated_season_total: nil,
  # relegation_probability: nil,
  # ucl_probability: nil,
  # league_win_probability: nil,
  # last_updated: nil,



##########
    #2 GET MATCH MODEL OUTPUTS
      Match.where("status = 'FINISHED'").each do |match|
        #get date
        date = match.match_date
        date_string = date.strftime("%m/%e") #turn date into 08/09
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
end



