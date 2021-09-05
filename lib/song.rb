require 'pry'

class Song
    attr_accessor :name, :genre
    attr_reader :artist

    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist = artist if artist
        self.genre = genre
    end

    def self.all
        @@all
    end

    def self.destroy_all
        self.all.clear
    end

    def save
        @@all << self
    end

    def self.create(name)
        song = Song.new(name)
        song.save
        song
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre  
    end

    def self.find_by_name(name)
        self.all.detect {|s| s.name == name}
    end

    def self.find_or_create_by_name(name)
        find_by_name(name) || create(name)
    end

    def self.new_from_filename(filename)
        new_file = filename.split(" - ")
        artist = new_file[0]
        name = new_file[1]
        genre = new_file[2].gsub(".mp3", "")

        artist_instance = Artist.find_or_create_by_name(artist)
        genre_instance = Genre.find_or_create_by_name(genre)
        # binding.pry

        Song.new(name,artist_instance,genre_instance)
    end

    def self.create_from_filename(filename)
        song_instance = new_from_filename(filename)
        song_instance.save
    end

end