namespace :random_portfolio do
  task seed: :environment do
    puts "Starting to create random bets"
      # RANDOM BETS ON ALL FINISHED MATCHES
      OUTCOME = ["Home","Away","Draw"]

      def generate_odd(match)
        odd = Odd.new(match: match)
        odd.outcome = OUTCOME.sample
        odds_number = rand(1.1..2.0).round(2)
        odd.odds = odds_number
        odd.bookmaker = Bookmaker.all.sample
        odd.rating = 80
        odd.save!
      end

      def generate_bet(odd, user)
        bet = Bet.new(user: user, stake: rand(1..6))
        bet.odd = odd
        bet.save
      end

      def seed_random_odds_for_finished_games
        finished_matches = Match.where(status: "FINISHED")
        finished_matches.each do |match|
          odd = generate_odd(match)
        end
      end

      def print_bets
        array = []
        Bet.all.each do |bet|
          sub_array = []
          sub_array << "#{bet.match.home_team.name} -v- #{bet.match.away_team.name}"
          sub_array << "BET: #{bet.odd.outcome}\tACTUAL: #{bet.match.outcome}"
          array << sub_array
        end
        puts array
      end

      def sample_finished_matches
        finished_matches = Match.where(status: "FINISHED")
        finished_matches.sample
      end

      def create_random_bets(number_of_bets, user = User.first)
        seed_random_odds_for_finished_games
        number_of_bets.times do
          match = sample_finished_matches
          odd = match.odds.first
          generate_bet(odd, user)
          match.save
        end
      end

      ################# CHANGE THESE VARIABLES ####################

      number_of_bets = 15
      user = User.first

      #############################################################

      create_random_bets(number_of_bets, user)

      puts "#{number_of_bets} bets created for User: #{user.id} - #{user.email}"
  end
end
