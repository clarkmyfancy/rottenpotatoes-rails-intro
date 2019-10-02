class Movie < ActiveRecord::Base

    @@ratings = ['G','PG','PG-13','R']
    
    def self.get_possible_ratings
        return @@ratings
    end

    def self.with_ratings(ratings)
        return Movie.where(rating: ratings)
    end

end
