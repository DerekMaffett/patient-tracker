class EncounterSerializer < ActiveModel::Serializer
  attributes :id, :encounter_type, :encountered_on, :submitted_on

  has_one :user

  def submitted_on
    object.created_at
  end
end
