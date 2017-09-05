FootballData.configure do |config|
    # get api key at 'http://api.football-data.org/register'
    config.api_key = 'eb0643c7781c41aea30373aa79059908'

    # default api version is 'alpha' if not setted
    config.api_version = 'alpha'

    # the default control method is 'full' if not setted
    # see request section on 'http://api.football-data.org/documentation'
    config.response_control = 'minified'
end
