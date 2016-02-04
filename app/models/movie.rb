class Movie < ActiveRecord::Base

  mount_uploader :poster_image, PosterImageUploader

  # paginates_per 10

  belongs_to :user
  has_many :reviews

  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  # validates :poster_image_url,
    # presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_past

  def review_average
    if reviews.present?
      reviews.sum(:rating_out_of_ten) / reviews.size
    else
      nil
    end

  end

  # def some_search_method

  # end

  # scope :search_all, -> (term) {
  #   where(
  #     'description LIKE ? OR name LIKE ?' "%#{term}", "%#{term}"
  #   )
  # }





  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end

end
