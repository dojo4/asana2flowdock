module Asana2Flowdock
  module Asana
  # ref: http://developer.asana.com/documentation/
  #
    class Api
    #
      Uri = URI.parse('https://app.asana.com/api/1.0')

    #
      fattr(:token)
      fattr(:uri){ Uri.dup }
      fattr(:debug){ false }
      fattr(:logger){ nil }

    #
      def initialize(token = ENV['ASANA_TOKEN'])
        @token = token
      end

      def log(level, *args, &block)
        if logger?
          logger.send(level, *args, &block)
        end
      end

      def me
        get("/users/me", :model => User)
      end

      def users(options = {})
        get("/users", User, options)
      end

      alias_method :my, :me

      def get(url, *args)
      #
        url = url.to_s
        options = Map.options_for!(args)
        model = args.detect{|arg| arg <= Model} || options.delete(:model)
        query = options[:query] || options

      #
        unless url['://']
          url = url_for(url)
        end

      #
        uri = URI.parse(url)

        unless query.blank?
          uri.query = query.map{|k,v| [CGI.escape(k.to_s), CGI.escape(v.to_s)].join('=')}.join('&')
        end

        url = uri.to_s

      #
        result = nil
        error = nil
        cmd = nil

      #
        3.times do
          begin
            cmd = "curl -s -u #{ @token }: #{ url.inspect } 2>/dev/null"

            log(:debug, cmd) if debug

            result = `#{ cmd }`
            break result

          rescue => e
            error = e
            sleep(3)
            nil
          end
        end

      #
        raise "#{ cmd } blargh'd!?" if error || result.nil?

      #
        result = JSON.parse(result)

        if result['errors']
          raise result['errors'].inspect
        end

        data = result['data']

      #
        result_for(data, :model => model)
      end

      def url_for(*paths)
        uri = Uri.dup
        path = uri.path
        uri.path = File.join(path, *paths.flatten.compact.map{|path| path.to_s})
        uri.to_s
      end

      def result_for(data, options = {})
        case data
          when Array
            data.map do |item|
              result_for(item, options)
            end
          when Hash
            attributes = Map.for(data)
            model = options[:model]

            if model
              model_for(model, attributes)
            else
              attributes
            end
          else
            raise ArgumentError, data.class.name
        end
      end

      def model_for(model, *args, &block)
        model = model.for(*args, &block)
      ensure
        model.api = self if model
      end
    end

  #
    class Model < ::Map
      fattr(:api)

      def Model.for(attributes, *args, &block)
        new(attributes, *args, &block)
      end

      def initialize(attributes, *args, &block)
        super(attributes)
        options = Map.options_for!(args)
        if options.has?(:api)
          @api = options.delete(:api)
        end
      end

      def inspect(*args, &block)
        "#{ self.class.name }(\n#{ super }\n)"
      end

      %w(
        model_for
        url_for
      ).each do |method|
        class_eval <<-__
          def #{ method }(*args, &block)
            api.#{ method }(*args, &block) if api
          end
        __
      end
    end

  #
    class User < Model
      def workspaces
        Array(self[:workspaces]).map{|attributes| model_for(Workspace, attributes)}
      end

      def projects(options = {})
        options = Map.for(options)

        workspaces.map{|workspace| workspace.projects(options)}
      end

      def tasks(options = {})
        options = Map.for(options)

        workspaces.map do |workspace|
          workspace.tasks(options.merge(:assignee => id))
        end.flatten.compact
      end
    end

  #
    class Workspace < Model
      def projects(options = {})
        api.get("/workspaces/#{ id }/projects", Project, options)
      end

      def tasks(options = {})
        options = Map.for(options)

        if options.has?(:assignee)
          api.get("/tasks", Task, options.merge(:workspace => id))
        else
          projects.map do |project|
            project.tasks(options)
          end.flatten.compact
        end
      end
    end

  #
    class Project < Model
      def tasks(options = {})
        api.get("/projects/#{ id }/tasks", Task, options)
      end
    end

  #
    class Task < Model
      def stories(options = {})
        api.get("/tasks/#{ id }/stories", Story, options)
      end
    end

  #
    class Story < Model
    end

  #
    def Asana.api_for(token)
      token = token.to_s
      (@apis ||= {})[token] ||= Api.new(token)
    end
  end
end
