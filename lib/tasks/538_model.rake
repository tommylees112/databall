require 'open-uri'
require 'json'
require 'rest-client'

namespace :model do
  task seed: :environment do

    # URL
    League.all.each do |league|
      league_name = league.name.downcase.strip.gsub(' ', '-')
      url = "https://projects.fivethirtyeight.com/soccer-predictions/#{league_name}/"
    end

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
  end
end


# EXAMPLES

# url = "http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
# cocktails_hash = RestClient.get "http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list" # RestClient::Response class
# ingredients_hash = JSON.parse(cocktails_hash)
# # hash with nested array of hashes => {[{},{},{}}
# #turn into an array
# ingredients_array = ingredients_hash["drinks"]
# ingredients = []

# #iterate over an array
# ingredients_array.each do |ingredient|
#    Ingredient.create!(name:ingredient["strIngredient1"])
#    ingredients << ingredient["strIngredient1"]
# end

# # CREATE Doses and Cocktials
# 10.times do
#   # create cocktail
#   cocktail_name = Faker::Superhero.name
#   cocktail = Cocktail.new(name: cocktail_name)
#   cocktail.save!
#   #create image for cocktails
#   url = "https://source.unsplash.com/random?sig=123" ## sees the multiple requests to the same URL and caches the response
#   cocktail.photo_url = url

#   #Create Ingredients/doses for that cocktail
#   3.times do
#     dose_description = Faker::Measurement.metric_volume
#     ingredient = Ingredient.find_by name: ingredients.sample
#     dose = Dose.create(description: dose_description, cocktail: cocktail,ingredient: ingredient)
#   end
#   ## link doses to one cocktail and to one ingredient
# end


### USING OPEN URI
# puts 'Seeding database...'
# url = 'http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
# text = open(url).read
# # .read extract the json file & accesses the text
# ingredients = JSON.parse(text)
# # .parse will transform from json to a hash

# ingredients["drinks"].each do |ingredient|
#   Ingredient.create(name: ingredient["strIngredient1"])
# end
# puts 'Finished!'
