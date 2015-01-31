class User 
  include Neo4j::ActiveNode
  after_create :update_auth_code

  scope :administrator, -> { where(is_admin: true) }
  has_one :out, :team, model_class: FantasticTeam
  
  property :auth_code
  property :is_admin, type: Boolean, default: false
  

  property :username, type: String
  property :created_at, type: DateTime
  property :updated_at, type: DateTime
  property :email, type: String, null: false, default: ""
  index :email
  property :encrypted_password

  devise :database_authenticatable, :registerable
  validates :username, :email, uniqueness: true
  validates :username, presence: true

  def update_auth_code
    self.auth_code = TokenGenerator.create
    self.save
  end

  def team_id
    return -1 if team.nil?
    team.neo_id
  end
end
