require 'open-uri'
require 'json'


class Match < ApplicationRecord
  # ASSOCIATIONS
  belongs_to :home_team, class_name: 'Team', foreign_key: 'home_team_id'
  belongs_to :away_team, class_name: 'Team', foreign_key: 'away_team_id'

  belongs_to :league
  has_many :odds
  has_many :bets, through: :odds
  has_many :users, through: :bets
  has_many :match_model_outputs

  # VALIDATIONS
  VALUES = ["Home", "Away", "Draw"]
  validates :match_date, presence: true
  validates :gameweek, presence: true, numericality: true
  validates :league, presence: true
  # validates :outcome, inclusion: {in: VALUES}

  def teams
    { home: home_team, away: away_team }
  end

  def flat_teams
    [ home_team, away_team ]
  end

  def outcome
    if self.status = "FINISHED"
      outcome = ""
      if self.goals_home_team > self.goals_away_team
        outcome = "Home"
        self.outcome = outcome
       elsif self.goals_home_team < self.goals_away_team
         outcome = "Away"
         self.outcome = outcome
       elsif self.goals_home_team == self.goals_away_team
         outcome = "Draw"
         self.outcome = outcome
       end
    end
    return outcome
  end

  def model_output
    self.match_model_outputs.order(created_at: :desc).first
  end

  def model_outcome_probability(odd)
    if odd.outcome == "Home"
      return self.model_output.home_win_probability
    elsif odd.outcome == "Away"
      return self.model_output.away_win_probability
    elsif odd.outcome == "Draw"
      return self.model_output.draw_probability
    else
      return "N/A"
    end
  end

  def model_outcome_odds(odd)
    probability = self.model_outcome_probability(odd)
    model_odds = 1/probability
    return model_odds.round(2)
  end

  def h2h_info
    h2h_url = self.url
    h2h_serialized = open(h2h_url, "X-Auth-Token" => ENV['FOOTBALL_KEY']).read
    h2h = JSON.parse(h2h_serialized)

    h2h_array = []
    h2h["head2head"]["fixtures"].each do |h2h_fixture|
      home_team = Team.find_by(name: h2h_fixture["homeTeamName"])
      goals_home_team = h2h_fixture["result"]["goalsHomeTeam"]
      away_team = Team.find_by(name: h2h_fixture["awayTeamName"])
      goals_away_team = h2h_fixture["result"]["goalsAwayTeam"]
      matchday = h2h_fixture["matchday"]
      date = h2h_fixture["date"]
      match = Match.new(goals_home_team: goals_home_team, goals_away_team: goals_away_team, gameweek: matchday, match_date: date)
      match.home_team = home_team
      match.away_team = away_team
      match.status = "H2H"
      match.league = self.league
      match.save
      h2h_array << match
    end
    return h2h_array
  end

  def prev_info
    first_team_form = []
    first_team_home_prev = Match.where(home_team: self.home_team).where(status: "FINISHED")
    first_team_home_prev.each {|match| first_team_form << match}
    first_team_away_prev = Match.where(away_team: self.home_team).where(status: "FINISHED")
    first_team_away_prev.each {|match| first_team_form << match}

    second_team_form = []
    second_team_home_prev = Match.where(home_team: self.away_team).where(status: "FINISHED")
    second_team_home_prev.each {|match| second_team_form << match}
    second_team_away_prev = Match.where(away_team: self.away_team).where(status: "FINISHED")
    second_team_away_prev.each {|match| second_team_form << match}

    return previous_matches = [first_team_form.sort_by {|match| match.gameweek}, second_team_form.sort_by {|match| match.gameweek}]
  end


  def odds_bias?
    if model_difference > 0.3
      return true
    elsif model_difference < -0.3
      return true
    elsif model_difference.abs < 0.15
      return true
    else
      return false
    end
  end

  def predicted_outcome
    if model_difference > 0.3
      return "Home"
    elsif model_difference < -0.3
      return "Away"
    elsif model_difference.abs < 0.15
      return "Draw"
    else
      return false
    end
  end

  private

  def model_difference
    home_prob = self.final_home_win_probability
    away_prob = self.final_away_win_probability
    draw_prob = self.final_draw_probability
    model_difference = (home_prob - away_prob)
    return model_difference
  end

end
