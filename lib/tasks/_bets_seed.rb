100.times do
  bet = Bet.new(user: User.first, stake: rand(1..6))
  matches = Match.where(status: "FINISHED")
  match = matches.where(league_id: 1).order("RANDOM()").first
  odd = Odd.where(match: match).first
  bet.odd = odd
  bet.save
end

user.bets.where(odd: nil).destroy_all
bets = user.bets
