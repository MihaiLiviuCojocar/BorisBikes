# link to the bike class
require './lib/bike'
require './lib/docking_station'

# we're describing the functionalityvof o specific class, Bike
describe Bike do 

	let(:bike) { Bike.new }

	# this is a specific feature (behaviour)
	# that we expect to be present
	it "should not be broken after we create it" do 
		# expect an instance of this class to have
		# a method "broken?" that should return false
		expect(bike).not_to be_broken
	end

	it "should be able to break" do 
		bike.break
		expect(bike).to be_broken
	end

	# if a bike can be broken, it can be fixed
	it "should be able to get fixed" do 
		bike.break
		bike.fix 
		expect(bike).not_to be_broken
	end

end


describe DockingStation do 

	def fill_station(station)
		20.times {station.dock(Bike.new)}
	end

	let(:bike)    { Bike.new }
	let(:station) { DockingStation.new(:capacity => 20)}

	it "should accept a bike" do 
		# bike = Bike.new
		# station = DockingStation.new
		# we expect the station to have 0 bikes
		expect(station.bike_count).to eq(0)
		# let's dock a bike into the station
		station.dock(bike)
		# now we expect the station to have one bike
		expect(station.bike_count).to eq(1)
	end

	it "should release a bike" do 
		station.dock(bike)
		station.release(bike)
		expect(station.bike_count).to eq(0)
	end

	it "should know when it's full" do
		expect(station).not_to be_full
		20.times {station.dock(Bike.new)}
		expect(station).to be_full
	end

	it "should not accept a bike if it's full" do 
		# 20.times {station.dock(Bike.new)}
		fill_station(station)
		expect(lambda { station.dock(bike) }).to raise_error(RuntimeError)
	end

	it "should provide the list of available bikes" do 
		working_bike, broken_bike = Bike.new, Bike.new
		broken_bike.break
		station.dock(working_bike)
		station.dock(broken_bike)
		expect(station.available_bikes).to eq([working_bike])
	end

end