require 'builder'
require 'intacct/authentication_methods/credentials'
require 'intacct/authentication_methods/session'

module Intacct
  class Request
    def initialize(transaction_operation: false)
      @functions = []
      @authentication = nil
      @transaction_operation = transaction_operation
    end

    def add_function(function, control_id)
      @functions << { function:, control_id: }
    end

    def use_credentials_authentication(user_id:, company_id:, user_password:)
      @authentication = Intacct::AuthenticationMethods::Credentials.new(
        user_id:, company_id:, password: user_password
      )
    end

    def use_session_authentication(session_token)
      @authentication = Intacct::AuthenticationMethods::Session.new(session_token)
    end

    def to_xml(control_config)
      raise MissingAuthenticationException unless @authentication

      builder = Builder::XmlMarkup.new
      builder.instruct!
      builder.request do
        add_control_block(builder, control_config)
        add_operation_block(builder)
      end
    end

    private

    def add_control_block(builder, config)
      builder.control do
        builder.senderid config.fetch(:sender_id)
        builder.password config.fetch(:sender_password)

        # As recommended by Intacct API reference. This ID should be unique
        # to the call: it's used to associate a response with a request.
        builder.controlid          config.fetch(:controlid, Time.current.to_s)
        builder.uniqueid           config.fetch(:uniqueid, false)
        builder.dtdversion         config.fetch(:dtdversion, 3.0)
        builder.includewhitespace  config.fetch(:includewhitespace, false)
      end
    end

    def add_operation_block(builder)
      builder.operation transaction: @transaction_operation do
        builder.authentication do
          builder << @authentication.to_xml
        end

        builder.content do
          @functions.each do |function_entry|
            function_xml = function_entry[:function].to_xml
            builder.function controlid: function_entry[:control_id] do
              builder << function_xml
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
  end
end
