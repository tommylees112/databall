DICTIONARY_capitalized = { "Man. United": "Manchester United FC",
  "Man. City": "Manchester City FC",
  "Chelsea": "Chelsea FC",
  "Liverpool": "Liverpool FC",
  "Tottenham": "Tottenham Hotspur FC",
  "Arsenal": "Arsenal FC",
  "Everton": "Everton FC",
  "Leicester City": "Leicester City FC",
  "Southampton": "Southampton FC",
  "Burnley": "Burnley FC",
  "Stoke City": "Stoke City FC",
  "West Brom": "West Bromwich Albion FC",
  "Watford": "Watford FC",
  "Swansea City": "Swansea City FC",
  "West Ham": "West Ham United FC",
  "Bournemouth": "AFC Bournemouth",
  "Huddersfield": "Huddersfield Town",
  "Crystal Palace": "Crystal Palace FC",
  "Newcastle": "Newcastle United FC",
  "Brighton": "Brighton & Hove Albion"
}


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


number_teams = {
  "Premier League": 20,
  "La Liga": ,
  "Bundesliga": ,
  "Serie A": ,
  "Ligue 1": ,
}







    # STRUCTURE OF SITE
    # # LAST UPDATED
    # h3.timestamp # when the model last updated

    # # GET THE TEAM RANKINGS (offensive & defensive)
    # div.forecast-table-wrapper
    #   table.forecast-table
    #     thead ...
    #     tbody
    #       tr.team-row(date-str="<team_name>")
    #         td.team(date-str="<team_name>")
    #           div.logo
    #           div.team-div
    #             div.name (innertext)
    #               span.record #NUMBER OF PL Points in the table
    #         #MODEL VARIABLES
    #         td.num.rating.overall.drop-6(data-val="") # SPI Score (soccer power index)
    #           div(innertext)
    #         td.num.rating.offense.drop-6(data-val="") # DEFENSIVE SCORE
    #           div(innertext)
    #         td.num.rating.defense.drop-6(data-val="") # OFFENSIVE SCORE
    #           div(innertext)
    #         #DATA FOR AVG SIMULATED SEASON
    #         td.num.record.wins.drop-1(innertext) # number wins
    #         td.num.record.ties.drop-1(innertext) # number draws
    #         td.num.record.losses.drop-3(innertext) # number losses
    #         td.num.record.drop-3(data-val="") # GOAL DIFFERENCE
    #         td.num.record.drop-3(data-val="") # simulated season total
    #         #END OF SEASON PROBABILITIES
    #         td.pct.border-left.drop-5(data-val="") #probability of RELEGATION
    #         td.pct(data-val="") #probability of qualfying for UCL
    #         td.pct(data-val="") #probability of winning premier league

    # # GET THE MODEL OUTPUTS (for each match)
    # div.games-container.upcoming
    #   div.match-container #ITERATE ON THIS!!
    #     (data-team1) # = HOME team
    #     (data-team2) # = AWAY team
    #     table < tbody
    #       tr.match-top
    #         td.date #date 9/9 (format for 9th September)
    #         td.team(data-str = "<team>") # HOME team name
    #           div.team-div
    #             div.name(INNER TEXT) # HOME team name
    #         td.prob(innertext) # (probability for home team)
    #         td.prob.tie-prob(innertext) # probability for draw
    #       tr.match-botton
    #         td.team(date-str="") # AWAY team name
    #           div.team-div
    #             span.name(inner text)
    #         td.prob


    # # GET THE POST MATCH STATS (adjusted goals; shot-based xG; non-shot xG)
    # div.games-container.completed
    #   div.match-container(data-team1="",data-team2="") #ITERATE ON THIS!!
    #     table
    #       tbody
    #         tr.match-top
    #           td.date # 9/9 format for date
    #           td.team(data-str="<team>") # home team
    #             div.logo
    #             div.team-div
    #               span.name(innertext) # = team1
    #               span.score(innertext) # = match_score
    #           td.prob
    #           td.prob.tie-prob
    #         tr.match-bottom
    #           td.team
    #             div.logo
    #             div.team-div
    #               span.name(innertext) # = team2
    #               span.score(innertext) # = match_score
    #           td.prob
    #     div.additional-info-container
    #       table.additional
    #         tbody
    #           tr (td,td,td) # first HEADERS
    #           tr # second
    #             td.title(inner-text) #adjusted goals
    #             td(innertext) # data
    #             td(innertext) # data
    #           tr # third
    #             td.title(inner-text) #shot-based-xg
    #             td(innertext) # data
    #             td(innertext) # data
    #           tr.moves # fourth
    #             td.title(inner-text) #non-shot-xg
    #             td(innertext) # data
    #             td(innertext) # data



    # ATTEMPT 1
    #       ## GET EACH ROW OF THE TABLE
    #   # get the team names from the row (but with pts inside the span)
    #     teams_dirty = []
    #     html_doc.search('.team-row').each do |row|
    #       teams_dirty << row.css('.name').text.strip
    #     end
    #     # use the last 20 (too many for some reason)
    #     prem_teams_dirty = teams_dirty.last(20) #only premier league team names eg "Man. United9 pts"
    #     teams = []
    #     # clean up the team names
    #     prem_teams_dirty.each do |team|
    #       teams << team.slice(0..(team.index(/\d/)))[0..-2] #remove after the number
    #     end
    #     # use the teams

    # #####ATTEMPT 1#######
    #     html_doc.search('.team-row').each do |row|
    #       teams.each do |team|
    #         # find the right team based on the parsed string
    #         team_object = Team.find_by_name(DICTIONARY["#{team}".to_sym])
    #         #create a new TeamModelOuput object
    #         team_model_object = TeamModelOutput.new()

    #         team_model_object.last_updated = date_object
    #         # model inputs
    #       end
    #     end