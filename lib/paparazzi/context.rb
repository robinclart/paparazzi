module Paparazzi
  class Context
    BROWSERS = {
      firefox: "Firefox",
      safari:  "Safari",
    }

    def initialize(dirname)
      @dirname = dirname
    end

    def use(name, width: 1280, height: 800)
      return if @browser

      @name    = name
      @browser = Watir::Browser.new(name)

      @browser.window.resize_to(width, height)
    end

    def name
      unless @name
        use :firefox
      end

      @name
    end

    def browser
      unless @browser
        use :firefox
      end

      @browser
    end

    def run(filename)
      path   = File.expand_path(filename, @dirname)
      path   = "#{path}.rb" if path[-3, 3] != ".rb"
      source = File.read(path)

      instance_eval(source)
    end

    def snap(filename)
      window_id = `osascript -e 'tell app "#{BROWSERS[name]}" to id of window 1'`

      sleep 0.2 # ensure the page finishes to load before taking a screenshot.

      `screencapture -l #{window_id.strip} #{filename}-#{name}.png`
    end

    def respond_to_missing?(method_name)
      if browser.respond_to?(method_name)
        true
      else
        super
      end
    end

    def method_missing(method_name, *args, &block)
      if browser.respond_to?(method_name)
        browser.send(method_name, *args, &block)
      else
        super
      end
    end
  end
end
