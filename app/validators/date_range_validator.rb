class DateRangeValidator < ActiveModel::Validator
  
  def validate(record)
    if LogEntry.overlaps(record.first_date, record.last_date).exists?
      record.errors[:value] << "Date range is invalid"
    end
  end

end
