class EncounterSerializer < ActiveModel::Serializer
  attributes :id, :encounter_type, :encountered_on, :created_at, :updated_at
end
