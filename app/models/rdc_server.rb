class RdcServer < ActiveRecord::Base
    validates :typename,
        :presence => true
    validates :num1,
        :numericality => {:greater_than_or_equal_to => 0,
                         :less_than_or_equal_to => 10}
end
