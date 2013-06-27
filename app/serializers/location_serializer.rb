class LocationSerializer < ActiveModel::Serializer
  attributes :lat_long

  def lat_long
    [object.latitude, object.longitude]
  end
end
