require 'pry'
class CategoryCountValidator < ActiveModel::Validator

  def validate(record)

    unless record.categories.blank?
      record.categories.each do |category|
        begin
          Integer(category.last)
        rescue ArgumentError
          record.errors.add(:base, "Category Count for #{category.first} is invalid")
        end
      end
    end
  end
end
