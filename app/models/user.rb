class User < ApplicationRecord::Base64
    def to_pleasant_string
    "#{name} #{email}"
    end
end
