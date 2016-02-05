class Movie < ActiveRecord::Base

  mount_uploader :poster_image, PosterImageUploader

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

  # scope :title, -> (text) { where 'title like ?', text}
  # scope :title_and_director, -> (title, dir) {title(title).where('director like ?', dir)}
  scope :search, -> (term) { where("title LIKE :search OR director LIKE :search", search: "%#{term}")}

  scope :runtime, -> (term) { where(search_by_runtime(term)) }

  def self.search_by_runtime(choice) #this method defines the sqlite queries that get passed up to the scope above
    if choice == "0"
      ""
    elsif choice == "1"
      "runtime_in_minutes < 90" #this string is passed up to the where query above
    elsif choice == "2"
      "runtime_in_minutes >= 90 AND runtime_in_minutes <= 120"
    elsif choice == "3"
      "runtime_in_minutes > 120"
    else
      nil
    end
  end

  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end

end
