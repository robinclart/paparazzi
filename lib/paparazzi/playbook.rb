module Paparazzi
  class Playbook
    def initialize(source)
      @source  = source
      @context = Context.new
    end

    def self.open(path)
      source = File.read(path)
      new(source)
    end

    def run!
      @context.run(@source)
    end
  end
end
