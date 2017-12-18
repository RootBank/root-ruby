require 'root/banking/client/transaction'

module Root::Banking
  class Client
    include Root::Banking::Client::Transaction

    def initialize(api_key)
      @api_key = api_key
    end

    private
    def client
      @client ||= Root::Client.new(@api_key, "", :production)
    end

    def post(entity, data, opts={})
      cleaned_data = clean_data(data, opts)

      client.post("#{entity}", cleaned_data)
    end

    def get(entity, query=nil)
      cleaned_query = query ? query.reject { |key, value| value.nil? } : nil
      client.get("#{entity}", cleaned_query)
    end

    def put(entity, data, opts={})
      cleaned_data = clean_data(data, opts)

      client.put("#{entity}", cleaned_data)
    end

    def patch(entity, data, opts={})
      cleaned_data = clean_data(data, opts)

      client.patch("#{entity}", cleaned_data)
    end

    def clean_data(data, opts)
      if opts[:keep_nil_values]
        data
      else
        data.reject { |key, value| value.nil? }
      end
    end

  end
end
