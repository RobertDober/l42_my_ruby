require_relative '../lib/l42'

DC = L42::DataClass

class Example1
  extend DC

  attributes :a, :b, c: 42

  def show
    [a, b, c]
  end
end

p Example1.new( 1, 2).show
p Example1.new( 1, 2, c: 0).show
begin
  Example1.new( 1, 2, d: 0).show
rescue DC::KeywordArgumentError => e
  p e
end
begin
  Example1.new( 1, c: 0).show
rescue DC::PositionalArgumentError => e
  p e
end
begin
  Example1.new( 1, 2, 0).show
rescue DC::PositionalArgumentError => e
  p e
end


Example1.new( 1, 2, 0).show
