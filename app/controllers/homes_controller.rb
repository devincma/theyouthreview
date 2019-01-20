class HomesController < ApplicationController

  def show
    # @writings = Writing.where(is_featured: true).order(created_at: :desc)
    @writings = Writing.where(is_approved: true).order(created_at: :desc)
    @users = User.where(is_star_writer: true).order(last_name: :asc).limit(3)
    set_meta_tags site: 'The Youth Review | A publicly contributing online student magazine',
                  description: "The Youth Review is a global online student magazine. It's like a high school student magazine/newspaper, except it's online, everyone can contribute to it, and you write with our easy-to-use rich-text editor.",
                  keywords: 'The Youth Review, Student, Teen, Student Writings, Articles'
  end

  def about
    set_meta_tags title: 'About The Youth Review',
                  description: 'Learn more about The Youth Review and how you can get involved by applying for a staff position.',
                  reverse: true,
                  keywords: 'The Youth Review, About The Youth Review, Student, Teen'
  end

  def contributors
    set_meta_tags title: 'Contributors',
                  description: 'Take a look at who contribute to The Youth Review.',
                  reverse: true,
                  keywords: 'The Youth Review, About The Youth Review, Student, Teen, Writers, Editors, contributors'
    @contributors = User.includes(:writings).where.not(writings: {id: nil}).order(last_name: :asc)
  end

  def submit
    @user = User.new
  end

end
