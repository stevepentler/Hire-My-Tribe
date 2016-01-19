module Mutation
  def self.bit_flip
    Proc.new do |x|
      {0 => 1, 1 => 0}[x]
    end
  end

  def self.add_rand
    Proc.new do |bp, opts|
      bp + rand(-1.0..1.0) * opts[:m_max]
    end
  end

  def self.swap_dev
    Proc.new do |dev|
      Developer.all.sample
    end
  end
end
