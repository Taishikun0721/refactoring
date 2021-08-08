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
		total_amount, frequent_renter_points = 0, 0
		result = "Rental Record for #{@name}\n"
		@rentals.each do |element|
			frequent_renter_points += 1

			element.frequent_renter_points

			result += '\t' + element.movie.title + '\t' + element.charge.to_s + '\n'
			total_amount += element.charge
		end

			result += "Amount owed is #{total_amount}\n"
			result += "You earned #{frequent_renter_points} frequent renter points"
			result
	end

	def amount_for(rental)
		rental.charge
	end
end