class Feedback < ActiveRecord::Base
  self.table_name = 'feedback'

  attr_accessible :option, :comment, :support, :user, :choice,:useful,:useless, :flag
  validates_presence_of :user_id, :message => 'Requires a user'
  validates_presence_of :option_id, :message => 'Requires an option'
  validates_presence_of :choice_id, :message => 'Requires a choice'

  validates_uniqueness_of :user_id, :scope => :choice_id, :message => 'only one comment and vote per person per choice'

  belongs_to :user
  belongs_to :option
  belongs_to :choice
  has_many :memes
  
  after_initialize :count_responses
  
  def count_responses
    self[:usefulVal] = self.useful.split(',').length + ( self.useful.split(',').empty? ? 0 : 1 )
    self[:uselessVal] = self.useless.split(',').length + ( self.useless.split(',').empty? ? 0 : 1 )
  end
  
  
end
