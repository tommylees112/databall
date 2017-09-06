namespace :matches do
  task export: :environment do

    require 'csv'
    puts "hi"
    # FILEPATH IS RELATIVE TO THE TERMINAL!!
    CSV.open('matches.csv', 'wb') do |csv|
      matches = Match.where(status: 'FINISHED')
      puts matches.count
      csv << matches.attribute_names
      matches.each do |match|
        puts match.attributes.values
        csv << match.attributes.values
      end
    end

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
