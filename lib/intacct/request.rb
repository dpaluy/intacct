require 'builder'

module Intacct
  class Request
    attr_reader :opts

    def initialize(opts)
      @opts = opts
    end

    def add_content_block(functions)
      blocks = functions.is_a?(Array) ? functions : [functions]
      @content_block_children = blocks
    end

    def to_xml
      builder = Builder::XmlMarkup.new
      builder.instruct!
      builder.request do
        add_control_block(builder)
        add_operation_block(builder)
      end
    end

    private

    def add_control_block(builder)
      builder.control do
        builder.senderid opts[:senderid]
        builder.password opts[:sender_password]

        # As recommended by Intacct API reference. This ID should be unique
        # to the call: it's used to associate a response with a request.
        builder.controlid          timestamp
        builder.uniqueid           opts.fetch(:uniqueid, false)
        builder.dtdversion         opts.fetch(:uniqueid, 3.0)
        builder.includewhitespace  false
      end
    end

    def add_operation_block(builder)
      builder.operation transaction: @opts.fetch(:transaction, false) do
        authentication_block(builder)
        builder.content do
          @content_block_children.each do |content_block_child|
            child_xml = content_block_child.to_xml
            builder.function controlid: Digest::MD5.hexdigest(child_xml) do
              builder << child_xml
            end
          end
        end
      end
    end

    def authentication_block(builder)
      builder.authentication do
        builder.login do
          builder.userid    opts[:userid]
          builder.companyid opts[:companyid]
          builder.password  opts[:user_password]
        end
      end
    end

    def timestamp
      @timestamp ||= Time.now.utc.to_s
    end
  end
end
