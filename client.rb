require 'httparty'
require 'json'

class Client
    def initPrompt
        while true
            print "Enter a zip code (or enter 'x' to exit): "
            input = gets.chomp
            
            if input == "x"
                puts "Exiting now. Goodbye!"
                break
            elsif input.length != 5
                puts "Error: Zip code must be a 5 digit number."
                next
            end
            
            zip = Integer(input)
            callApi(zip)
        end
    end

    def callApi(zip)
        api = 'https://jhpkmm4jz2.execute-api.us-west-2.amazonaws.com/v2/population-growth-v2'
        response = HTTParty.get(api, body: { 'zip' => zip }.to_json)
        responseBody = JSON.parse(response.body)
        puts "> Zip: " + responseBody['Zip'].to_s
        puts "> CBSA: " + responseBody['CBSA'].to_s
        puts "> Name: " + responseBody['MSA'].to_s
        puts "> Population in 2014: " + responseBody['Pop2014'].to_s
        puts "> Population in 2015: " + responseBody['Pop2015'].to_s
    end

client = Client.new
client.initPrompt
end