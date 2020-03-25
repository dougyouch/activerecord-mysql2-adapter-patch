# frozen_string_literal: true

require 'active_record'
require 'active_record/connection_adapters/abstract_mysql_adapter'

class ActiveRecord::ConnectionAdapters::AbstractMysqlAdapter
  def new_column_from_field(table_name, field)
    type_metadata = fetch_type_metadata(field[:Type], field[:Extra])
    default, default_function = field[:Default], nil

    if type_metadata.type == :datetime && /\ACURRENT_TIMESTAMP(?:\([0-6]?\))?\z/i.match?(default)
      default, default_function = nil, default
      default_function += ' ' + field[:Extra] if field[:Extra] != ''
    elsif type_metadata.extra == "DEFAULT_GENERATED"
      default = +"(#{default})" unless default.start_with?("(")
      default, default_function = nil, default
    end

    MySQL::Column.new(
      field[:Field],
      default,
      type_metadata,
      field[:Null] == "YES",
      default_function,
      collation: field[:Collation],
      comment: field[:Comment].presence
    )
  end
end
