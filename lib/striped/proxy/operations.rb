module Striped
  module Proxy

    def self.Operations(*operations)
      Module.new do
        include API::Create if operations.include?(:create)
        include API::Fetch  if operations.include?(:fetch)
        include API::Update if operations.include?(:update)
        include API::Delete if operations.include?(:delete)
        include API::All    if operations.include?(:all)
      end
    end

    module API
      module Create
        def create(arguments)
          client.post("/#{resource}", body: arguments)
        end
      end

      module Fetch
        def fetch
          client.get("/#{resource}/#{resource_id}")
        end
      end

      module Update
        def update(arguments)
          client.post("/#{resource}/#{resource_id}", body: arguments)
        end
      end

      module Delete
        def delete
          client.delete("/#{resource}/#{resource_id}")
        end
      end

      module All
        def all(arguments = nil)
          client.get("/#{resource}", body: arguments)
        end
      end
    end
  end
end
