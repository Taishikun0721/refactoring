class Movie
	REGULAR = 0
	NEW_RELEASE = 1
	CHILDRENS = 2

	attr_reader :title
	attr_accessor :price_code

	def initialize(title, price_code)
		@title, @price_code = title, price_code
	end
end

class Rental
	attr_reader :movie, :days_rented

	def initialize(movie, days_rented)
		@movie, @days_rented = movie, days_rented
	end

	def charge
		this_amount = 0
		case movie.price_code
		when Movie::REGULAR
			this_amount += 2
			this_amount += (days_rented - 2) * 1.5 if days_rented > 2
		when Movie::NEW_RELEASE
			this_amount += days_rented * 3
		when Movie::CHILDRENS
			this_amount += 1.5
			this_amount += (days_rented - 3) * 1.5 if days_rented > 3
		end
	end

	def frequent_renter_points
		movie.price_code == Movie.NEW_RELEASE && days_rented > 1 ? 2 : 1
	end
end

class Customer
	attr_reader :name

	def initialize(name)
		@name = name
		@rentals = []
	end

	def add_rental(arg)
		@rentals << arg
	end

	def statement
		result = "Rental Record for #{@name}\n"
		@rentals.each do |element|
			result += '\t' + each.movie.title + '\t' + element.charge.to_s + '\n'
		end

		result += "Amount owed is #{total_charge}\n"
		result += "You earned #{total_frequent_renter_points} frequent renter points"
		result
	end

	private

	def total_charge
		result = 0
		@rentals.each do |rental|
			result += rental.charge
		end
		result
	end

	def total_frequent_renter_points
		@rentals.inject(0) { |summary, rental| summary += rental.frequent_renter_points }
	end
end