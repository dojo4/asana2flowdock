# -*- encoding : utf-8 -*-
#
# built-ins
#
  require 'cgi'
  require 'yaml'
  require 'digest'
  require 'net/http'
  require 'cgi'
  require 'uri'
  require 'time'
  require 'digest/md5'

# dao libs
#
  module Asana2Flowdock
    Version = '1.3.0' unless defined?(Version)

    def version
      Asana2Flowdock::Version
    end

    def dependencies
      {
         'arrayfields'  => [ 'arrayfields'    , '~> 4.7.4'  ] , 
         'main'         => [ 'main'           , '~> 6.1.0'  ] , 
         'pry'          => [ 'pry'            , '~> 0.10.1' ] , 
         'pry-debugger' => [ 'pry-debugger'   , '~> 0.2.3'  ] , 
         'pry-nav'      => [ 'pry-nav'        , '~> 0.2.4'  ] , 
         'stringex'     => [ 'stringex'       , '>= 2.1.0' ] ,
         'amalgalite'   => [ 'amalgalite'   ] , 
         'sequel'       => [ 'sequel'       ] , 
         'json'         => [ 'json'         ] , 
         'map'          => [ 'map'          ] , 
         'coerce'       => [ 'coerce'       ] , 
         'fattr'        => [ 'fattr'        ] , 
         'threadify'    => [ 'threadify'    ] , 
         'flowdock'     => [ 'flowdock'     ] , 
      }
    end

    def description
      "asana2flowdock relays asana events into flowdock awesomely"
    end

    def libdir(*args, &block)
      @libdir ||= File.expand_path(__FILE__).sub(/\.rb$/,'')
      args.empty? ? @libdir : File.join(@libdir, *args)
    ensure
      if block
        begin
          $LOAD_PATH.unshift(@libdir)
          block.call()
        ensure
          $LOAD_PATH.shift()
        end
      end
    end

    def load(*libs)
      libs = libs.join(' ').scan(/[^\s+]+/)
      Asana2Flowdock.libdir{ libs.each{|lib| Kernel.load(lib) } }
    end

    extend(Asana2Flowdock)
  end

# gems
#
  begin
    require 'rubygems'
  rescue LoadError
    nil
  end

  if defined?(gem)
    Asana2Flowdock.dependencies.each do |lib, dependency|
      gem(*dependency)
      require(lib)
    end
  end

  Asana2Flowdock.load %w[
    slug.rb
    asana.rb
  ]

# blargh
#
  Asana2flowdock = Asana2Flowdock

# hack
#
  class Net::HTTP
    alias_method :old_initialize, :initialize

    def initialize(*args)
      old_initialize(*args)
      @ssl_context = OpenSSL::SSL::SSLContext.new
      @ssl_context.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end
  end
