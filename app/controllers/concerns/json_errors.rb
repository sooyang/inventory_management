# Module for providing json error messages
module JsonErrors
  def error
    render json: {
      status: 'error',
      message: "Can't find inventory belonging to Distribution Center/SKU"
    }, status: 400
  end
end
