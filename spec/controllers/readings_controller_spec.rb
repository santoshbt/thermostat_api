require 'rails_helper'
require 'sidekiq/testing' 
Sidekiq::Testing.fake! 

RSpec.describe ReadingsController, :type => :controller do
  let(:thermostat_id) {'1'}
  let(:household_token) {'1cyed7l2dd'}

  def validate_parse_response response
    expect(response).to have_http_status(200)
    JSON.parse(response.body)
  end

  describe "POST create reading" do
    it "Takes the input and runs background job to create" do         
      reading_params = { reading: { temperature: "26.9", humidity: "15.44", battery_recharge: "24.4",
                                    thermostat_id: "1", household_token: "1cyed7l2dd"  } }

      post :create, as: :json, params: reading_params   

      expect {
        CreateReadingWorker.perform_async(thermostat_id, household_token, reading_params)
      }.to change(CreateReadingWorker.jobs, :size).by(1)
               
      json_data = validate_parse_response response
      expect(json_data["status"]).to eq(200)
    end
  end

  context "GET the reading data and stats"
    before(:all) do
      DatabaseCleaner.clean 
      @thermostat = FactoryBot.create(:thermostat)
      reading = FactoryBot.create(:reading)
    end

    describe "GET reading data by tracking number" do      
      it "Takes tracking number and returns the reading data" do
        params = {reading: {household_token:  "1cyed7l2dd"}, tracking_number: 1}

        get :show, as: :json, params: params
        json_data = validate_parse_response response

        expect(json_data["temperature"]).to eq(26.9)
        expect(json_data["humidity"]).to eq(15.44)
        expect(json_data["battery_recharge"]).to eq(24.4)
        expect(json_data["status"]).to eq(200)
      end
    end

    describe "GET stats of the thermostat" do
      it "Takes thermostat id and outputs statistical data" do
        reading_1 = FactoryBot.create(:reading_1)
        params = {reading: {household_token:  "1cyed7l2dd", thermostat_id: @thermostat.id} }

        get :stats, as: :json, params: params
        json_data = validate_parse_response response

        expect(json_data["status"]).to eq(200)
        expect(json_data["avg_temperature"]).to eq("25.4")
        expect(json_data["avg_humidity"]).to eq("12.94")
        expect(json_data["avg_battery_recharge"]).to eq("21.4")
        expect(json_data["max_temperature"]).to eq(26.9)
        expect(json_data["min_temperature"]).to eq(23.9)
        expect(json_data["max_humidity"]).to eq(15.44)
        expect(json_data["min_humidity"]).to eq(10.44)
        expect(json_data["max_battery_recharge"]).to eq(24.4)
        expect(json_data["min_battery_recharge"]).to eq(18.4)
      end
    end
end