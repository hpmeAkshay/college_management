class AcademicSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :college_name, :career_goals, :known_languages, :other_languages, :currently_working, :specialization, :total_experience, :availability, :interest, :qualification, :cv, :government_id
  
  def interest
    {
      id: object.interest.id,
      name: object.interest.name
    }
  end

  def qualification
    {
      id: object.qualification.id,
      name: object.qualification.name
    }
  end

  def cv
    if object.cv.attached?
      {
        cv: rails_blob_path(object.cv, disposition: 'attachment', only_path: true)
      }
    end
  end

  def government_id
    if object.government_id.attached?
      rails_blob_path(object.government_id, only_path: true)
    end
  end

end
