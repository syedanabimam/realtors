class ReportPdf < Prawn::Document
  def initialize(posts)
    super()
   # Prawn::Document.new
    @posts = posts[0]
    @type = posts[1]
    header
    text_content
    table_content
  end

  def header
    #This inserts an image in the pdf file and sets the size of the image
    image "#{Rails.root}/app/assets/images/header.png", width: 430, height: 120
  end

  def text_content
    # The cursor for inserting content starts on the top left of the page. Here we move it down a little to create more space between the text and the image inserted above
    y_position = cursor - 50

    # The bounding_box takes the x and y coordinates for positioning its content and some options to style it
    bounding_box([0, y_position], :width => 270, :height => 100) do
      text "About Report:", size: 25, style: :bold
      text "The generated report contains information as requested by admin", size: 15
    end

    bounding_box([300, y_position], :width => 270, :height => 100) do
      text "Support:", size: 25, style: :bold
      text "Email us at support@realtors.com \n You may call us at +13-456-78945", size: 15
    end

  end

  def table_content
    # This makes a call to product_rows and gets back an array of data that will populate the columns and rows of a table
    # I then included some styling to include a header and make its text bold. I made the row background colors alternate between grey and white
    # Then I set the table column widths
    table post_rows do
      row(0).font_style = :bold
      self.header = true
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.column_widths = [120, 220, 200]
    end
  end

  def post_rows
    [['Name', 'Current Status', 'Price']] +
      @posts.map do |post|
      [post.customer_name, post.status, "$ #{post.rent_price}"]
    end
  end
end