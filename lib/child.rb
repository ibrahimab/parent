module Parent
  module Child
    module ClassMethods
      def acts_as_child
        include Parent::Child::InstanceMethods
      end
    end
    
    module InstanceMethods
      attr_accessor :manageables, :inverse
      
      def allow(subject, *actions)
        manageable(subject).allow(actions)
      end
    
      def deny(subject, *actions)
        manageable(subject).deny(actions)
      end
    
      def allowed?(subject, action)
        if inverse
          inverse = false
          manageable(subject).denied?(action)
        else
          manageable(subject).allowed?(action)
        end
      end
    
      def denied?(subject, action)
        if inverse
          inverse = false
          manageable(subject).allowed?(action)
        else
          manageable(subject).denied?(action)
        end
      end
    
      def not
        inverse = true
        self
      end
    
      def manageable(subject)
        manageables[subject.to_s] ||= Parent::Manageable.new(subject)
      end
      
      def manageables
        @manageables ||= {}
      end
      
      def inverse
        @inverse ||= false
      end
      
      def inverse=(value)
        @inverse = value
      end
    end
  end
end