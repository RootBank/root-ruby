describe Root::Banking::Client::Transaction do
  let(:base_url) { "https://api.root.co.za/v1" }
  let(:url) { "#{base_url}/transactions" }

  let(:api_key) { 'api_key' }

  let(:client) { Root::Banking::Client.new(api_key) }

  let(:transaction_id) { "5ceabb76-c16b-493a-8f79-7ababadceeea" }

  describe :list_transactions do
    it "gets from the correct url" do
      stub_request(:get, url)
        .to_return(body: "{}")

      client.list_transactions
    end
  end

  describe :get_transaction do
    let(:transaction_url) { "#{url}/#{transaction_id}" }

    it "gets the transaction from the correct url" do
      stub_request(:get, transaction_url)
        .to_return(body: "{}")

      client.get_transaction(id: transaction_id)
    end
  end

  describe :change_transaction_category do
    let(:transaction_url) { "#{url}/#{transaction_id}" }

    context "when supplying a category id" do
      let(:category_id) { "3f17630c-b37a-4607-9203-bae7a303e8a7" }

      it "patches the correct url with the correct data" do
        stub_request(:patch, transaction_url)
          .with(body: {category_id: category_id})
          .to_return(body: "{}")

        client.change_transaction_category(
          id:          transaction_id,
          category_id: category_id)
      end
    end

    context "when supplying a category rule" do
      it "patches the correct url with the correct data" do
        stub_request(:patch, transaction_url)
          .with(body: {category_id: nil, category_rule: 'future'})
          .to_return(body: "{}")

        client.change_transaction_category(
          id:            transaction_id,
          category_rule: :future)
      end
    end

    context "when not supplying a category id" do
      it "patches the correct url with the correct data" do
        stub_request(:patch, transaction_url)
          .with(body: {category_id: nil})
          .to_return(body: "{}")

        client.change_transaction_category(id: transaction_id)
      end
    end
  end

  describe :tag_transaction do
    let(:tag_url) { "#{url}/#{transaction_id}/tags" }
    let(:tag_ids) { ["7b426af8-191a-4f9c-a2a1-d2d247a088d8"] }

    it "posts to the correct" do
      stub_request(:post, tag_url)
        .with(body: {tag_ids: tag_ids})
        .to_return(body: "{}")

      client.tag_transaction(
        id:      transaction_id,
        tag_ids: tag_ids)
    end
  end

  # describe :tag_transaction do
  #   let(:tag_url) { "#{url}/#{transaction_id}/tags" }
  #   let(:tag_ids) { ["7b426af8-191a-4f9c-a2a1-d2d247a088d8"] }

  #   it "posts to the correct" do
  #     stub_request(:post, tag_url)
  #       .with(body: {tag_ids: tag_ids})
  #       .to_return(body: "{}")

  #     client.tag_transaction(
  #       id:      transaction_id,
  #       tag_ids: tag_ids)
  #   end
  # end
end
