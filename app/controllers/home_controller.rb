require 'net/http'
require 'json'

class HomeController < ApplicationController
    # USD-BRL
    # EUR-BRL
    # BTC-BRL

    CURRENCIES = [
        { code: 'USD-BRL', title: 'Dolar - Real', color: '#FF0000' },
        { code: 'EUR-BRL', title: 'Euro - Real', color: '#ADD8E6' },
        { code: 'BTC-BRL', title: 'Bitcoin - Real', color: '#FFFF00' },
    ]
    def index
        @chart_data = []

        CURRENCIES.each do |currency|
            url = URI("https://economia.awesomeapi.com.br/json/daily/#{currency[:code]}/15")
            response = Net::HTTP.get(url)
            data = JSON.parse(response)
            hash = {}

            data.each do |entry|
                date = Time.at(entry['timestamp'].to_i).strftime("%d/%m/%Y")
                rate = entry['high']

                hash[date] = rate
            end 
            
            @chart_data << { name:currency[:title], data: hash, color: currency[:color] }
            
        end
    end
end
