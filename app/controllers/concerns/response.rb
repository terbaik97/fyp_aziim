module Response
    def json_response(data: {}, message: '', status: :ok, meta: {})
      has_error = false
      if status != :ok
        has_error = true
      end
  
      obj = {
        message: message,
        data: data,
        has_error: has_error,
        meta: meta
      }
  
      render json: obj, status: status
    end
  end