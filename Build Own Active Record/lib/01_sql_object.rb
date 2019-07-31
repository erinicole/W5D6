require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
 
  def initialize
    p "initialize"
  end

  def self.columns
    @data ||= DBConnection.execute2(<<-SQL)
      SELECT * FROM cats
    SQL

    cols = @data[0]
    cols.map do |col|
      col.to_sym
    end
  end

  def self.finalize!
      
      self.columns.each do |col|
        define_method(col) { instance_variable_get("@#{col}")}
        define_method("#{col}="){ |val| instance_variable_set("@#{col}", val)}
      end
      
      define_method("name") { instance_variable_get(:@attributes)[:name] }
  end

  def self.table_name=(table_name)
    # ...
    @@table_name = table_name
  end

  def self.table_name
    # ... 
    @@table_name ||= "#{self.name.downcase}s"
    @@table_name
  end

  def self.all
    # ...
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    # ...
  end

  def attributes
    # ...
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
