class PublicController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false

  def maintenance
    respond_to do |format|
      format.html { render file: Rails.public_path.join("503.html"), layout: false, status: :service_unavailable }
      format.json { render json: { error: "Service Unavailable", status: 503 }, status: :service_unavailable }
      format.all  { render file: Rails.public_path.join("503.html"), layout: false, status: :service_unavailable, content_type: "text/html" }
    end
  end

  def not_found
    respond_to do |format|
      format.html { render file: Rails.public_path.join("404.html"), layout: false, status: :not_found }
      format.json { render json: { error: "Not Found", status: 404 }, status: :not_found }
      format.all  { render file: Rails.public_path.join("404.html"), layout: false, status: :not_found, content_type: "text/html" }
    end
  end

  def internal_error
    respond_to do |format|
      format.html { render file: Rails.public_path.join("500.html"), layout: false, status: :internal_server_error }
      format.json { render json: { error: "Internal Server Error", status: 500 }, status: :internal_server_error }
      format.all  { render file: Rails.public_path.join("500.html"), layout: false, status: :internal_server_error, content_type: "text/html" }
    end
  end

  def unprocessable
    respond_to do |format|
      format.html { render file: Rails.public_path.join("422.html"), layout: false, status: :unprocessable_entity }
      format.json { render json: { error: "Unprocessable Entity", status: 422 }, status: :unprocessable_entity }
      format.all  { render file: Rails.public_path.join("422.html"), layout: false, status: :unprocessable_entity, content_type: "text/html" }
    end
  end

  def bad_request
    respond_to do |format|
      format.html { render file: Rails.public_path.join("400.html"), layout: false, status: :bad_request }
      format.json { render json: { error: "Bad Request", status: 400 }, status: :bad_request }
      format.all  { render file: Rails.public_path.join("400.html"), layout: false, status: :bad_request, content_type: "text/html" }
    end
  end

  def unsupported_browser
    respond_to do |format|
      format.html { render file: Rails.public_path.join("406-unsupported-browser.html"), layout: false, status: :not_acceptable }
      format.json { render json: { error: "Not Acceptable", status: 406 }, status: :not_acceptable }
      format.all  { render file: Rails.public_path.join("406-unsupported-browser.html"), layout: false, status: :not_acceptable, content_type: "text/html" }
    end
  end

  def show
    page = params[:page].to_s.sub(/\.html\z/, "")
    case page
    when "503", "down", "maintenance"
      maintenance
    when "404", "not_found"
      not_found
    when "500", "error", "internal_error", "internal_server_error"
      internal_error
    when "422", "unprocessable_entity", "unprocessable"
      unprocessable
    when "400", "bad_request"
      bad_request
    when "406", "unsupported_browser", "406-unsupported-browser"
      unsupported_browser
    else
      target_file = Rails.public_path.join("#{page}.html")
      if target_file.exist?
        status_code = page.to_i.between?(100, 599) ? page.to_i : 200
        render file: target_file, layout: false, status: status_code
      else
        not_found
      end
    end
  end
end
