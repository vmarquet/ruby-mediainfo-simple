class GeneralStream < Stream
  attr_accessor :complete_name
  attr_accessor :file_size
  attr_accessor :duration
  
  attr_accessor :format
  attr_accessor :format_profile
  attr_accessor :format_info
  attr_accessor :codec
  attr_accessor :overall_bit_rate
  attr_accessor :encoded_application
  attr_accessor_alias :writing_application, :encoded_application
  attr_accessor :encoded_library
  attr_accessor_alias :writing_library, :encoded_library
  
  attr_accessor :mastered_date
  attr_accessor :tagged_date
  attr_accessor :encoded_date
  attr_accessor :last_modification_date
  attr_accessor_alias :file_modified_date, :last_modification_date

  # ID3Tags
  attr_accessor :artist
  attr_accessor :performer
  attr_accessor :title
  attr_accessor :genre
  attr_accessor :album
  attr_accessor :copyright
  attr_accessor :year
end

