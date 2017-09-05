require 'open-uri'
require 'json'

Team.destroy_all
League.destroy_all



#########################################################
########### PLANS #######################################
#########################################################

plan = Stripe::Plan.create(
  :amount => 1000,
  :interval => 'month',
  :name => 'Basic Plan',
  :currency => 'aud',
  :id => 'basic'
)

Plan.create(name: plan.name, stripe_id: plan.id, display_price: (plan.amount.to_f / 100))

##############################################################################
######     MATCHES, LEAGUES, TEAMS                                  ##########
##############################################################################

# Leagues
['Premier League', 'La Liga', 'Bundesliga', 'Serie A', 'Ligue 1'].each do |league|
  League.create(name: league)
end

# teams
premier_teams_url = 'http://api.football-data.org/v1/competitions/445/teams'
premier_teams_serialized = open(premier_teams_url, "X-Auth-Token" => ENV['FOOTBALL_KEY']).read
premier_teams = JSON.parse(premier_teams_serialized)


bundesliga_teams_url = 'http://api.football-data.org/v1/competitions/452/teams'
bundesliga_teams_serialized = open(bundesliga_teams_url, "X-Auth-Token" => ENV['FOOTBALL_KEY']).read
bundesliga_teams = JSON.parse(bundesliga_teams_serialized)

ligue1_teams_url = 'http://api.football-data.org/v1/competitions/450/teams'
ligue1_teams_serialized = open(ligue1_teams_url, "X-Auth-Token" => ENV['FOOTBALL_KEY']).read
ligue1_teams = JSON.parse(ligue1_teams_serialized)

laLiga_teams_url = 'http://api.football-data.org/v1/competitions/455/teams'
laLiga_teams_serialized = open(laLiga_teams_url, "X-Auth-Token" => ENV['FOOTBALL_KEY']).read
laLiga_teams = JSON.parse(laLiga_teams_serialized)

serieA_teams_url = 'http://api.football-data.org/v1/competitions/456/teams'
serieA_teams_serialized = open(serieA_teams_url, "X-Auth-Token" => ENV['FOOTBALL_KEY']).read
serieA_teams = JSON.parse(serieA_teams_serialized)

premier_teams["teams"].each do |team|
  team_name = team["name"]
  crest_url = team["crestUrl"]
  team = Team.new(name: team_name, logo: crest_url)
  team.league = League.where(name: 'Premier League').first
  team.save!
end

bundesliga_teams["teams"].each do |team|
  team_name = team["name"]
  crest_url = team["crestUrl"]
  team = Team.new(name: team_name, logo: crest_url)
  team.league = League.where(name: 'Bundesliga').first
  team.save!
end

laLiga_teams["teams"].each do |team|
  team_name = team["name"]
  crest_url = team["crestUrl"]
  team = Team.new(name: team_name, logo: crest_url)
  team.league = League.where(name: 'La Liga').first
  team.save!
end

serieA_teams["teams"].each do |team|
  team_name = team["name"]
  crest_url = team["crestUrl"]
  team = Team.new(name: team_name, logo: crest_url)
  team.league = League.where(name: 'Serie A').first
  team.save!
end

ligue1_teams["teams"].each do |team|
  team_name = team["name"]
  crest_url = team["crestUrl"]
  team = Team.new(name: team_name, logo: crest_url)
  team.league = League.where(name: 'Ligue 1').first
  team.save!
end


premier_fixtures_url = 'http://api.football-data.org/v1/competitions/445/fixtures'
premier_fixtures_serialized = open(premier_fixtures_url, "X-Auth-Token" => ENV['FOOTBALL_KEY']).read
premier_fixtures = JSON.parse(premier_fixtures_serialized)

premier_fixtures["fixtures"].each do |fixture|
  home_team = Team.find_by(name: fixture["homeTeamName"])
  goals_home_team = fixture["result"]["goalsHomeTeam"]
  away_team = Team.find_by(name: fixture["awayTeamName"])
  goals_away_team = fixture["result"]["goalsAwayTeam"]
  matchday = fixture["matchday"]
  date = fixture["date"]
  status = fixture["status"]
  match_url = fixture["_links"]["self"]["href"]
  match = Match.new(goals_home_team: goals_home_team, goals_away_team: goals_away_team, gameweek: matchday, match_date: date, status: status)
  match.home_team = home_team
  match.away_team = away_team
  match.url = match_url
  match.league = League.where(name: 'Premier League').first
  match.save!
end

bundesliga_fixtures_url = 'http://api.football-data.org/v1/competitions/452/fixtures'
bundesliga_fixtures_serialized = open(bundesliga_fixtures_url, "X-Auth-Token" => ENV['FOOTBALL_KEY']).read
bundesliga_fixtures = JSON.parse(bundesliga_fixtures_serialized)

bundesliga_fixtures["fixtures"].each do |fixture|
  home_team = Team.find_by(name: fixture["homeTeamName"])
  goals_home_team = fixture["result"]["goalsHomeTeam"]
  away_team = Team.find_by(name: fixture["awayTeamName"])
  goals_away_team = fixture["result"]["goalsAwayTeam"]
  matchday = fixture["matchday"]
  date = fixture["date"]
  status = fixture["status"]
  match_url = fixture["_links"]["self"]["href"]
  match = Match.new(goals_home_team: goals_home_team, goals_away_team: goals_away_team, gameweek: matchday, match_date: date, status: status)
  match.home_team = home_team
  match.away_team = away_team
  match.url = match_url
  match.league = League.where(name: 'Bundesliga').first
  match.save!
end

ligue1_fixtures_url = 'http://api.football-data.org/v1/competitions/450/fixtures'
ligue1_fixtures_serialized = open(ligue1_fixtures_url, "X-Auth-Token" => ENV['FOOTBALL_KEY']).read
ligue1_fixtures = JSON.parse(ligue1_fixtures_serialized)

ligue1_fixtures["fixtures"].each do |fixture|
  home_team = Team.find_by(name: fixture["homeTeamName"])
  goals_home_team = fixture["result"]["goalsHomeTeam"]
  away_team = Team.find_by(name: fixture["awayTeamName"])
  goals_away_team = fixture["result"]["goalsAwayTeam"]
  matchday = fixture["matchday"]
  date = fixture["date"]
  status = fixture["status"]
  match_url = fixture["_links"]["self"]["href"]
  match = Match.new(goals_home_team: goals_home_team, goals_away_team: goals_away_team, gameweek: matchday, match_date: date, status: status)
  match.home_team = home_team
  match.away_team = away_team
  match.url = match_url
  match.league = League.where(name: 'Ligue 1').first
  match.save!
end

laLiga_fixtures_url = 'http://api.football-data.org/v1/competitions/455/fixtures'
laLiga_fixtures_serialized = open(laLiga_fixtures_url, "X-Auth-Token" => ENV['FOOTBALL_KEY']).read
laLiga_fixtures = JSON.parse(laLiga_fixtures_serialized)

laLiga_fixtures["fixtures"].each do |fixture|
  home_team = Team.find_by(name: fixture["homeTeamName"])
  goals_home_team = fixture["result"]["goalsHomeTeam"]
  away_team = Team.find_by(name: fixture["awayTeamName"])
  goals_away_team = fixture["result"]["goalsAwayTeam"]
  matchday = fixture["matchday"]
  date = fixture["date"]
  status = fixture["status"]
  match_url = fixture["_links"]["self"]["href"]
  match = Match.new(goals_home_team: goals_home_team, goals_away_team: goals_away_team, gameweek: matchday, match_date: date, status: status)
  match.home_team = home_team
  match.away_team = away_team
  match.url = match_url
  match.league = League.where(name: 'La Liga').first
  match.save!
end

serieA_fixtures_url = 'http://api.football-data.org/v1/competitions/456/fixtures'
serieA_fixtures_serialized = open(serieA_fixtures_url, "X-Auth-Token" => ENV['FOOTBALL_KEY']).read
serieA_fixtures = JSON.parse(serieA_fixtures_serialized)

serieA_fixtures["fixtures"].each do |fixture|
  home_team = Team.find_by(name: fixture["homeTeamName"])
  goals_home_team = fixture["result"]["goalsHomeTeam"]
  away_team = Team.find_by(name: fixture["awayTeamName"])
  goals_away_team = fixture["result"]["goalsAwayTeam"]
  matchday = fixture["matchday"]
  date = fixture["date"]
  status = fixture["status"]
  match_url = fixture["_links"]["self"]["href"]
  match = Match.new(goals_home_team: goals_home_team, goals_away_team: goals_away_team, gameweek: matchday, match_date: date, status: status)
  match.home_team = home_team
  match.away_team = away_team
  match.url = match_url
  match.league = League.where(name: 'Serie A').first
  match.save!
end

