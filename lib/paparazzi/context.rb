module Paparazzi
  class Context
    BROWSERS = {
      firefox: "Firefox",
      safari:  "Safari",
    }

    def use(name)
      @name    = name
      @browser = Watir::Browser.new(name)

      @browser.window.resize_to(1280, 800)
    end

    def name
      return @name if @name

      use :firefox
    end

    def browser
      return @browser if @browser

      use :firefox
    end

    def run(source)
      instance_eval(source)
    ensure
      browser.close
    end

    def snap(filename)
      window_id = `osascript -e 'tell app "#{BROWSERS[name]}" to id of window 1'`

      sleep 0.2 # ensure the page finishes to load before taking a screenshot

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
