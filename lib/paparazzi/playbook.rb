module Paparazzi
  class Playbook
    def initialize(path)
      @path    = path
      @context = Context.new(File.dirname(@path))
    end

    def run!
      @context.run(@path)
    ensure
      @context.close
    end
  end
end
