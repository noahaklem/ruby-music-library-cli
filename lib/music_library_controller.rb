require 'pry'
class MusicLibraryController

    attr_accessor :path

    def initialize(path = "./db/mp3s")
        @path = path
        MusicImporter.new(path).import
    end

    def call
        input = ""
        
        until input == "exit"
            puts "Welcome to your music library!"
            puts "To list all of your songs, enter 'list songs'."
            puts "To list all of the artists in your library, enter 'list artists'."
            puts "To list all of the genres in your library, enter 'list genres'."
            puts "To list all of the songs by a particular artist, enter 'list artist'."
            puts "To list all of the songs of a particular genre, enter 'list genre'."
            puts "To play a song, enter 'play song'."
            puts "To quit, type 'exit'."
            puts "What would you like to do?"

            input = gets.strip

            case input
                when "list songs"
                list_songs
                when "list artists"
                list_artists
                when "list genres"
                list_genres
                when "list artist"
                list_songs_by_artist
                when "list genre"
                list_songs_by_genre
                when "play song"
                play_song
            end
        end
    end
    
    def list_songs
        sorted_songs = Song.all.sort do 
            |a, b| a.name <=> b.name
        end
        sorted_songs.each_with_index do |s, i|
            puts "#{i+1}. #{s.artist.name} - #{s.name} - #{s.genre.name}"
        end
    end
    
    def list_artists
        sorted_artists = Artist.all.sort do 
            |a, b| a.name <=> b.name
        end
        sorted_artists.each_with_index do |a, i|
            puts "#{i+1}. #{a.name}"
        end
    end

    def list_genres
        sorted_genres = Genre.all.sort do 
            |a, b| a.name <=> b.name
        end
        sorted_genres.each_with_index do |g, i|
            puts "#{i+1}. #{g.name}"
        end
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets.strip

        if artist = Artist.find_by_name(input)
            sorted_artists = artist.songs.sort do 
                |a, b| a.name <=> b.name
            end
            sorted_artists.each_with_index do |a, i|
                puts "#{i+1}. #{a.name} - #{a.genre.name}"
            end
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets.strip

        if genre = Genre.find_by_name(input)
            sorted_genres = genre.songs.sort do 
                |a, b| a.name <=> b.name
            end
            sorted_genres.each_with_index do |g, i|
                puts "#{i+1}. #{g.artist.name} - #{g.name}"
            end
        end
    end

    def play_song
        puts "Which song number would you like to play?"

        input = gets.strip.to_i
        if (1..Song.all.length).include?(input)
            song = Song.all.sort{ |a, b| a.name <=> b.name}[input - 1]
        end

        puts "Playing #{song.name} by #{song.artist.name}" if song
    end
end