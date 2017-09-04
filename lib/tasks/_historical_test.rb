finished = Match.where(status: "FINISHED")
matches = []
finished.each do |match|
  if match.odds_bias?
    # puts "#{match.home_team.name} -v- #{match.away_team.name}"
    matches << match
  end
end

matches.each do |match|
  puts "#{match.home_team.name} #{match.goals_home_team} -v- #{match.away_team.name} #{match.goals_away_team}"
  puts "Predicted: #{match.predicted_outcome}"
end

# ALL MATCHES:
