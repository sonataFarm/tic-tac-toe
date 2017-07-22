class Player
  attr_reader :name
  attr_accessor :mark

  def initialize(options = {})
    options = defaults.merge(options)

    @name = options[:name]
  end

  def defaults
    { name: 'Player' }
  end
end
