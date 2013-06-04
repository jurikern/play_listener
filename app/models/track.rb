class Track < ActiveRecord::Base
  belongs_to :playlist

  serialize :properties, ActiveRecord::Coders::Hstore

  %w[title description published_at player_url thumbnail_url duration].each do |key|
    define_method(key) do
      properties && properties[key]
    end

    define_method("#{key}=") do |value|
      self.properties = (properties || {}).merge(key => value)
    end
  end

  scope :by_uid, ->(uid) {where(:uid => uid)}
end
