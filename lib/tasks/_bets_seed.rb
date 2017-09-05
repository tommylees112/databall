# RANDOM BETS ON ALL FINISHED MATCHES
OUTCOME = ["Home","Away","Draw"]

def generate_odd(match)
  odd = Odd.new(match: match)
  odd.outcome = OUTCOME.sample
  odds_number = rand(1.1..2.0).round(2)
  odd.odds = odds_number
  odd.bookmaker = Bookmaker.all.sample
  odd.save!
end

def generate_bet(odd)
  bet = Bet.new(user: User.first, stake: rand(1..6))
  bet.odd = odd
  bet.save
end

def seed_random_odds
  finished_matches = Match.where(status: "FINISHED")
  finished_matches.each do |match|
    odd = generate_odd(match)
  end
end

15.times do
  finished_matches = Match.where(status: "FINISHED")
  match = finished_matches.sample
  p match
  match.update_bets
  odd = match.odds.first
  generate_bet(odd)
end

Bet.all
