require 'json'

module GeocoderService
  module Api

    def coordinates(city)
      response = connection.post do |request|
        request.params['city'] = city
      end

      JSON.parse(response.body) if response.success? && response.body.present?
    end
  end
end
