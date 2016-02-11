class Post < ActiveRecord::Base
  validates :image, presence: true
  validates :customer_name, presence: true
  validates :customer_email, presence: true
  validates :customer_phone_no, presence: true
  validates :house_name, presence: true
  validates :house_address, presence: true
  validates :description, presence: true
  validates :post_type_select, presence: true
  
  before_save :default_values
  
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  
  protected
  
  def default_values
    if self.post_type_select == "Rent"
      self.status = "Not Rented"
    elsif self.post_type_select == "Sell"
      self.status = "Not Sold"
    end
  end

end
