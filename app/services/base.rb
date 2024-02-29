# frozen_string_literal: true

class Base

  attr_reader :errors

  def initialize
    @errors = {}
  end

  def collect_errors(*resources)
    resources.each do |resource|
      next if resource.errors.empty?

      errors[resource.class.name.downcase.to_sym] = resource
                                                      .errors
                                                      .messages
                                                      .transform_values(&:uniq)
                                                      .transform_keys(&method(:transform_error_key))
    end
  end

  def transform_error_key(key)
    key.to_s.split('.').last.to_sym
  end

end
