module ProxyOperationMacros

  def self.included(base)
    base.extend Macros
  end

  module Macros
    SUPPORTED_OPERATIONS   = [:create, :fetch, :update, :delete, :all]

    def it_executes_a_valid_operation(*operations)
      let(:arguments)    { double('arguments') }
      let(:api_response) { double('api_response') }

      before do
        [:get, :post, :delete].each do |method|
          client.stub(method).and_return(api_response)
        end
      end

      operations.each do |operation|
        unless SUPPORTED_OPERATIONS.include?(operation)
          raise "##{operation} is not a supported operation."
        end

        self.send("it_executes_a_valid_#{operation}_operation")
      end
    end

    def it_executes_a_valid_create_operation
      describe "#create" do
        before { @response = proxy.create(arguments) }

        it "sends a request to create the resource" do
          expect(client).to(
            have_received(:post).with("/#{resource}", body: arguments)
          )
        end

        it_returns_the_api_response
      end
    end

    def it_executes_a_valid_fetch_operation
      describe "#fetch" do
        before { @response = proxy.fetch }

        it "sends a request to fetch the resource" do
          expect(client).to(
            have_received(:get).with("/#{resource}/#{resource_id}")
          )
        end

        it_returns_the_api_response
      end
    end

    def it_executes_a_valid_update_operation
      describe "#update" do
        before { @response = proxy.update(arguments) }

        it "sends a request to update the resource" do
          expect(client).to(
            have_received(:post)
              .with("/#{resource}/#{resource_id}", body: arguments)
          )
        end

        it_returns_the_api_response
      end
    end

    def it_executes_a_valid_delete_operation
      describe "#delete" do
        before { @response = proxy.delete }

        it "sends a request to delete the resource" do
          expect(client).to(
            have_received(:delete).with("/#{resource}/#{resource_id}")
          )
        end

        it_returns_the_api_response
      end
    end

    def it_executes_a_valid_all_operation
      describe "#all" do
        context "with the default arguments" do
          before { @response = proxy.all }

          it "sends a request to fetch all instances of the resource" do
            expect(client).to(
              have_received(:get).with("/#{resource}", body: nil)
            )
          end

          it_returns_the_api_response
        end

        context "with additional arguments" do
          before { @response = proxy.all(arguments) }

          it "sends a request to fetch specified instances of the resource" do
            expect(client).to(
              have_received(:get).with("/#{resource}", body: arguments)
            )
          end
        end
      end
    end

    def it_returns_the_api_response
      it "returns the API response" do
        expect(@response).to eq api_response
      end
    end

  end
end
