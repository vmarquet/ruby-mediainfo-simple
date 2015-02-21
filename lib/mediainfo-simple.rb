require 'mediainfo-simple/parser'
require 'mediainfo-simple/stream_factory'
require 'mediainfo-simple/stream'
require 'mediainfo-simple/streams/audio'
require 'mediainfo-simple/streams/video'
require 'mediainfo-simple/streams/text'
require 'mediainfo-simple/streams/image'
require 'mediainfo-simple/streams/general'
require 'mediainfo-simple/streams/menu'
require 'mediainfo-simple/streams/other'


class MediaInfo

  attr_accessor :streams

  def initialize filename
    # we check that the file exist
    raise ArgumentError, "give the filename as a parameter (got nil)" if filename == nil
    raise ArgumentError, "filename must be a string" if ! filename.is_a? String
    filename = File.expand_path filename
    raise ArgumentError, "#{filename} does not exist" if ! File.exist? filename
    
    # we parse the file
    @streams = []
    MediaInfoParser.new filename, self
  end


  # return true if there is a general stream, false otherwise
  def general?
    @streams.any? { |stream| stream.is_a? GeneralStream }
  end

  # return true if there is a video stream, false otherwise
  def video?
    @streams.any? { |stream| stream.is_a? VideoStream }
  end

  # return true if there is an audio stream, false otherwise
  def audio?
    @streams.any? { |stream| stream.is_a? AudioStream }
  end

  # return true if there is a text stream, false otherwise
  def text?
    @streams.any? { |stream| stream.is_a? TextStream }
  end

  # return true if there is an image stream, false otherwise
  def image?
    @streams.any? { |stream| stream.is_a? ImageStream }
  end

  # return true if there is an menu stream, false otherwise
  def menu?
    @streams.any? { |stream| stream.is_a? MenuStream }
  end

  # return true if there is an undefined stream, false otherwise
  def other?
    @streams.any? { |stream| stream.is_a? OtherStream }
  end

  # returns an array with all the video streams
  def general
    @streams.select { |stream| stream.is_a? GeneralStream }
  end

  # returns an array with all the video streams
  def video
    @streams.select { |stream| stream.is_a? VideoStream }
  end

  # returns an array with all the audio streams
  def audio
    @streams.select { |stream| stream.is_a? AudioStream }
  end

  # returns an array with all the text streams
  def text
    @streams.select { |stream| stream.is_a? TextStream }
  end

  # returns an array with all the image streams
  def image
    @streams.select { |stream| stream.is_a? ImageStream }
  end

  # returns an array with all the menu streams
  def menu
    @streams.select { |stream| stream.is_a? MenuStream }
  end

  # returns an array with all the other streams
  def other
    @streams.select { |stream| stream.is_a? OtherStream }
  end

end

