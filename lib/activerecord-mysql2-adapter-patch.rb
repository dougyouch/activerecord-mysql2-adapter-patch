# frozen_string_literal: true

require 'active_record'
require 'active_record/connection_adapters/mysql2_adapter'

class ActiveRecord::ConnectionAdapters::Mysql2Adapter
  def each_hash(result) # :nodoc:
    if block_given?
      result.each(as: :hash, symbolize_keys: true) do |row|
        if row[:Type] == 'datetime' && row[:Extra] != ''
          row[:Default] += ' ' + row[:Extra]
          row[:Extra] = ''
        end
        yield row
      end
    else
      to_enum(:each_hash, result)
    end
  end
end
