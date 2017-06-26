require 'voight_kampff'

class Shortener::ShortenedUrlsController < ActionController::Base
  include Shortener

  def show
    token = ::Shortener::ShortenedUrl.extract_token(shortener_params[:id])
    track = Shortener.ignore_robots.blank? || request.human?
    url   = ::Shortener::ShortenedUrl.fetch_with_token(token: token, additional_params: shortener_params, track: track)
    redirect_to url[:url], status: :moved_permanently
  end

  private

  # ugh...
  def shortener_params
    params.permit(:id, :controller, :action)
  end
end
