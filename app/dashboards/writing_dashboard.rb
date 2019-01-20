require 'administrate/base_dashboard'

class WritingDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
      # taggings: Field::HasMany.with_options(class_name: "::ActsAsTaggableOn::Tagging"),
      # base_tags: Field::HasMany.with_options(class_name: "::ActsAsTaggableOn::Tag"),
      # tag_taggings: Field::HasMany.with_options(class_name: "ActsAsTaggableOn::Tagging"),
      # tags: Field::HasMany.with_options(class_name: "ActsAsTaggableOn::Tag"),
      # topic_taggings: Field::HasMany.with_options(class_name: "ActsAsTaggableOn::Tagging"),
      # topics: Field::HasMany.with_options(class_name: "ActsAsTaggableOn::Tag"),
      user: Field::BelongsTo,
      tag_list: Field::String,
      id: Field::Number,
      title: Field::String,
      body: Field::Text,
      is_featured: Field::Boolean,
      is_featured_today: Field::Boolean,
      is_approved: Field::Boolean,
      created_at: Field::DateTime,
      updated_at: Field::DateTime,
      slug: Field::String,
      draft_token: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
      :title,
      :user,
      :is_approved,
      :body,
      :tag_list,
  # :taggings,
  # :base_tags,
  # :tag_taggings,
  # :tags,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
      # :taggings,
      # :base_tags,
      # :tag_taggings,
      # :tags,
      # :topic_taggings,
      # :topics,
      :title,
      :user,
      :is_approved,
      :body,
      :tag_list,
      :is_featured,
      :is_featured_today,
      :created_at,
      :updated_at,
      :slug,
      :draft_token,
      :id,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
      # :taggings,
      # :base_tags,
      # :tag_taggings,
      # :tags,
      # :topic_taggings,
      # :topics,
      # :user,
      :title,
      :body,
      :is_approved,
      :tag_list,
      :is_featured,
      :is_featured_today,
  ].freeze

  # Overwrite this method to customize how writings are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(writing)
    "Writing \"#{writing.title}\" (##{writing.id})"
  end
end
