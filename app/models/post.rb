class Post < ActiveRecord::Base
  # New and Edit form validations
  validates :image, presence: true
  validates :customer_name, presence: true
  validates :customer_email, presence: true
  validates :customer_phone_no, presence: true, :numericality => {:only_integer => true}
  validates :house_name, presence: true
  validates :house_address, presence: true
  validates :description, presence: true
  validates :post_type_select, presence: true
  validates :rent_price, presence: true, :numericality => {:only_integer => true}
  
  # Google Maps API callbacks to save the latitude and longitude value
  geocoded_by :google_address  
  after_validation :geocode
  
  # This callback assures that three methods mentioned below runs before record 
  #is created or edited/updated
  before_save :default_values, :set_google_address, :geocode
  
  # paperclip attributes
  has_attached_file :image, styles: { medium: "200x200#", thumb: "100x100>" }

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  
  # The transaction action that is passed in controller is now made as an instance var
  def action_n(action_name)
    @action_name = action_name
  end

  protected
  # This method saves/edit/update the record. Action Name here signifies that except 
  # transaction, save/edit/update action can use this method
  def default_values
    # It sets the default values for status of post based on what type of post it is
    if @action_name != "transaction"
      if self.post_type_select == "Rent"
        self.status = "Not Rented"
      elsif self.post_type_select == "Sell"
        self.status = "Not Sold"
      end
    end
  end
  
  # This callback method sets the field of google_address that sets the coordinates for map
  def set_google_address
    self.google_address = "#{self.city} #{self.country}" 
  end

end
