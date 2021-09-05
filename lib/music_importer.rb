require 'pry'
class MusicImporter
    attr_accessor :path

    def initialize(path)
        @path = path
    end 

    def files
        @file ||= Dir.glob("#{path}/*.mp3").collect {|f| f.gsub("#{path}/","")}
        # binding.pry
    end

    def import
        files.each {|f| Song.create_from_filename(f)}
    end

end