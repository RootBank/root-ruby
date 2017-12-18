class Root::Banking::Client
  module Transaction

    def list_transactions
      get("transactions")
    end

    def get_transaction(id:)
      get("transactions/#{id}")
    end

    def change_transaction_category(id:, category_id: nil, category_rule: :current)
      data = if category_rule == :current
        {category_id: category_id}
      else
        {
          category_id:   category_id,
          category_rule: category_rule
        }
      end

      patch("transactions/#{id}", data, keep_nil_values: true)
    end

    def tag_transaction(id:, tag_ids: [])
      data = {tag_ids: tag_ids}

      post("transactions/#{id}/tags", data)
    end

  end
end
