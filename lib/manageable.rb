module Parent
  class Manageable
    attr_accessor :manageable, :permissions
    
    def initialize(manageable)
      @manageable  = manageable
      @permissions = {allow: [], deny: []}
    end
    
    def allow(*actions)
      @permissions[:allow] = actions
    end
    
    def deny(*actions)
      @permissions[:deny]  = actions
    end
    
    def allowed?(action)
      !@permissions[:deny].include?(action) || @permissions[:allow].include?(action)
    end
    
    def denied?(action)
      @permissions[:deny].include?(action) || !@permissions[:allow].include?(action)
    end
  end
end