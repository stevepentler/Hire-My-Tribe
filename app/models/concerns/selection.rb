module Selection
  #opts requires a value n: 5 to rep size of pop to consider.
  def self.tournament
    Proc.new do |chromosomes, opts|
      chromosomes.map do
        chromosomes.shuffle[0..opts[:n]-1].max_by {|chrom| chrom.fitness}
      end
    end
  end
end
