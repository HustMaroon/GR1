class Bonu < ActiveRecord::Base
  belongs_to :sclass
  COND_REGEX = /\A[<\>\=]+[0-9]/
  validates :condition, presence: true, length: {maximum: 2}, format: {with: COND_REGEX}

  def match? number
  	arr = self.condition
  	if arr[0] = '<'
  		return true if number < arr[1].to_i
  	elsif arr[0] == '>'
  		return true if number > arr[1].to_i
  	elsif arr[0] == '='
  		return true if number == arr[1].to_i
  	end
  	return false  		
  end
end
