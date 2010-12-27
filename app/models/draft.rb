class Draft < ActiveRecord::Base
  before_validation :validates_record_type
  before_validation :validates_record_existence
  
  def reconstitute
    if record_id.nil?
      record_type.constantize.new(JSON.parse(content))
    else
      return false if !valid?
      record = record_type.constantize.first(:conditions => { :id => record_id })
      record.attributes = JSON.parse(content)
      record
    end
  end
  
  # PRIVATE METHODS
  private
  
  def validates_record_type
    return true if !record_type.blank? && Object.const_defined?(record_type)
    !errors.add(:record_type, 'is invalid.')
  end
  
  def validates_record_existence
    return true if record_id.blank? || record_type.constantize.respond_to?(:first) && record_type.constantize.first(:conditions => { :id => record_id })
    !errors.add(:record_id, 'does not correspond to a valid record.')
    false
  end
end
