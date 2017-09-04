namespace :historical do
  desc "Benchmark model against historical data"
  task performance: :environment do
    puts "Running benchmark performance statistics..."

    def calculate_correct(matches)
      matches.each do |match|
        if match.predicted_outcome == match.outcome
          correct << match
        else
          wrong << match
        end
      end
    end

    def print_matches(array_of_matches)
      array_of_matches.each do |match|
          puts "#{match.home_team.name} #{match.goals_home_team} -v- #{match.away_team.name} #{match.goals_away_team}"
          puts "Actual: #{match.outcome}"
          puts "Predicted: #{match.predicted_outcome}"
          puts "Probabilities: Home #{match.final_home_win_probability} Draw #{match.final_away_win_probability} Away #{match.final_draw_probability}"
      end
    end

    def matches_in_csv_format(array_of_matches)
      array_of_matches.each_with_index do |match, index|
          puts "#{index+1}\t#{match.gameweek}\t#{match.match_date}\t#{match.league.name}\t#{match.home_team.name}\t#{match.goals_home_team}\t#{match.away_team.name}\t#{match.goals_away_team}\t#{match.outcome}\t#{match.predicted_outcome}\t#{match.final_home_win_probability}\t#{match.final_away_win_probability}\t#{match.final_draw_probability}"
      end
    end

    def odds_bias?(array_of_matches)
      matches_pass_odds_bias = []
      array_of_matches.each do |match|
        if match.odds_bias?
          matches_pass_odds_bias << match
        end
      end
      return matches_pass_odds_bias
    end

    finished = Match.where(status: "FINISHED")
    calculate_correct(matches)
    accuracy = correct.count.to_f / matches.count

    print_matches(matches)
    print_matches(correct)
    print_matches(wrong)

    matches_in_csv_format(matches)

  end
end
