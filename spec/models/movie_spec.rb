require 'rails_helper'

RSpec.describe Movie, type: :model do
    # Title must be valid if there is a title, production year, screening time, and Eirin classification.
    it "is valid with a title, production_year, running_time, rating" do
      movie = Movie.new(
        title: 'DIC',
        production_year: 2000,
        running_time: 120,
        rating: 'G')
      expect(movie).to be_valid
    end
    # # If there is no Title
    # it "is invalid without a title"
    # # Duplicate Title must be invalid
    # it "is invalid with a duplicate title"
    # # Title is 101 characters or more, it is invalid.
    # it "is invalid with title is 101 or more characters"
end
