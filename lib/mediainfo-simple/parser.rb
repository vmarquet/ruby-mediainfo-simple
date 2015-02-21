require 'rexml/document'


class MediaInfoParser
  attr_accessor :mediainfo_path_verified

  def initialize filename, mediainfo_object, mediainfo_path=nil
    # we check that MediaInfo CLI is installed
    if not mediainfo_installed? mediainfo_path
      raise RuntimeError, "mediainfo command-line interface not installed"
    end

    # we launch the MediaInfo scan
    # it will fill the MediaInfo object with the data
    mediainfo_run! filename, mediainfo_object
  end


  private #################################################

  # a method to check that MediaInfo CLI is installed
  # return true if installed, false otherwise
  def mediainfo_installed? mediainfo_path=nil
    # if the user specified the path, we check that MediaInfo
    # is installed at the path provided by the user
    # else, we get path with bash command `which`
    # (`which` works on Linux and Mac, but I don't know about Windows)
    if mediainfo_path != nil
      if File.exist? File.expand_path(mediainfo_path)
        @mediainfo_path_verified = mediainfo_path
        return true
      else
        return false
      end
    else
      mediainfo_path = `which 'mediainfo'`.rstrip
      # NB: rstrip is needed to remove final '\n'
      if mediainfo_path != ""
        @mediainfo_path_verified = mediainfo_path
        return true
      else
        return false
      end
    end
  end

  # we use the mediainfo command-line interface to get the XML results
  # it returns the raw XML data
  def mediainfo_run! filename, mediainfo_object
    command = "#{mediainfo_path_verified} '#{filename}' --Output=XML"
    raw_xml_response = `#{command} 2>&1`
    unless $? == 0
      raise RuntimeError, "Execution of `#{command}` failed: #{raw_xml_response.inspect}"
    end
    parse! raw_xml_response, mediainfo_object
  end

  # we parse the raw XML data (with ReXML), 
  # and we fill the MediaInfo object attributes
  def parse! raw_xml_response, mediainfo_object
    # puts "#{raw_xml_response}"
    REXML::Document.new(raw_xml_response).elements.each("/Mediainfo/File/track") { |track|
      # we create a "Stream" object, depending on the Stream type
      stream = StreamFactory.create track.attributes['type']

      # we get each tag about the stream
      track.children.select { |n| n.is_a? REXML::Element }.each do |c|
        # we convert the tag name to a ruby-attribute-compatible name
        tag_name = c.name.strip  # remove whitespaces at the beginning and the end
        tag_name = tag_name.gsub(/ +/, "_")  # we replace spaces by '_'
        # we replace characters forbidden in Ruby method names by '_':
        tag_name = tag_name.gsub(/[\(\)\{\}\[\]\*\/\\,;\.:\+=\-\^\$\!\?\|@#\&"'`]+/, '_')
        tag_name = tag_name.gsub(/^_+/, "")  # remove '_' at the beginning
        tag_name = tag_name.gsub(/_+$/, "")  # remove '_' at the end
        tag_name = tag_name.gsub(/_+/, "_")  # we replace several '_' following by a single one
        tag_name = tag_name.downcase

        # if there is an attribute in the Stream class,
        # that has the same name as the tag name, we set it with the tag content
        if stream.class.method_defined? tag_name + "="
          # we call the method which name is the content of the string tag_name
          stream.send tag_name + "=", c.text.strip
        else
          # to print the tag ignored, in case we want to support them
          # puts "#{stream.class}: tag ignored: #{tag_name}, #{c.text.strip}"
        end
      end
      
      # we add the Stream objects to the MediaInfo object
      mediainfo_object.streams << stream
    }
  end
end


