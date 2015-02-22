module AbstractTransaction
  attr_accessor :errors
  

  def initialize
   self.errors = []
  end

  def transaction
    errors = []
    begin
       tx = Neo4j::Transaction.new
       yield
    rescue StandardError => e
      tx.failure
      Rails.logger.error e.message
      return false
    ensure
      tx.close()
    end
  end

  def check(condition, message)
    if condition
      self.errors << message
    end
  end

  def check_if_not(condition, message)
    check(!condition, message)
  end

  def valid?
    return self.errors.empty?
  end

  alias_method :check_if, :check
end