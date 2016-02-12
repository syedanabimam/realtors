class Post < ActiveRecord::Base
  validates :image, presence: true
  validates :customer_name, presence: true
  validates :customer_email, presence: true
  validates :customer_phone_no, presence: true
  validates :house_name, presence: true
  validates :house_address, presence: true
  validates :description, presence: true
  validates :post_type_select, presence: true
  
  geocoded_by :google_address   # can also be an IP address
  after_validation :geocode
  
  before_save :default_values, :set_google_address, :geocode
  
  has_attached_file :image, styles: { medium: "200x200#", thumb: "100x100>" }

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  
    
  def action_n(action_name)
    @action_name = action_name
  end

  
  protected
  
  def default_values
    if @action_name != "transaction"
      if self.post_type_select == "Rent"
        self.status = "Not Rented"
      elsif self.post_type_select == "Sell"
        self.status = "Not Sold"
      end
    end
  end
  
  def set_google_address
    self.google_address = "#{self.city} #{self.country}" 
  end

end
