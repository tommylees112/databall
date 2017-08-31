require 'csv'
CSV.open("matches.csv", "wb") do |csv|
  matches = Match.where(status: "FINISHED")
  csv << matches.attribute_names
  matches.all.each do |match|
    csv << match.attributes.values
  end
end

# CSV.open("~/Desktop/matches.csv", "wb") do |csv|
#   matches = Match.where(status: "FINISHED")
#   csv << matches.attribute_names
#   matches.all.each do |match|
#     csv << match.attributes.values
#   end
# end

# CSV.open("~/Desktop/matches.csv", "wb") do |csv|
#   matches = Match.where(status: "FINISHED")
#   csv << matches.attribute_names
#   matches.all.each do |match|
#     csv << match.attributes.values
#   end
# end
