class Stream
  # to create aliases (getter and setter method)
  # for attributes defined with attr_accessor
  def self.attr_accessor_alias alias_name, alias_target
    alias_method alias_name, alias_target                    # alias for the getter
    alias_method alias_name.to_s+'=', alias_target.to_s+'='  # alias for the setter
  end

  attr_accessor :id
  attr_accessor_alias :stream_id, :id
end