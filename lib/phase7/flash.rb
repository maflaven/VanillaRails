module Phase7
  class Flash
    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)
      @cookie = {}
      req.cookies.each do |cookie|
        if cookie.name == "_rails_lite_app_flash"
          @now = JSON.parse(cookie.value)
        end
      end
      @now = {}
    end

    def [](key)
      @now[key] if @cookie.include?(key)
    end

    def []=(key, val)
      @cookie[key] = val
    end

    def now
      @now
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_flash(res)
      res.cookies << WEBrick::Cookie.new("_rails_lite_app_flash", @cookie.to_json)
    end
  end
end
