require_relative '../lib/life'
# Any live cell with fewer than two live neighbours dies, as if caused by underpopulation.
# Any live cell with two or three live neighbours lives on to the next generation.
# Any live cell with more than three live neighbours dies, as if by overpopulation.
# Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.


RSpec.describe Ecosystem do
  context 'given a blank ecosystem' do
    it 'should return an empty nested array' do
      @ecosystem = Ecosystem.new([[]])
      expect(@ecosystem.tick).to eq [[]]
    end
  end


  describe '#alive_neigbour_count' do
    it 'counts with a 1x2' do
      @ecosystem = Ecosystem.new([[0,0]])
      expect(@ecosystem.send(:alive_neigbour_count, 0, 0)).to eq 0
      expect(@ecosystem.send(:alive_neigbour_count, 0, 1)).to eq 0

      @ecosystem = Ecosystem.new(
        [
          [1,1]
        ]
      )
      expect(@ecosystem.send(:alive_neigbour_count, 0,0)).to eq 1
      expect(@ecosystem.send(:alive_neigbour_count, 1, 0)).to eq 1

    end

    context 'counts with 3x3' do
      it 'counts with 3x3' do
        @ecosystem = Ecosystem.new([[1,1,1], [1,1,1], [1,1,1]])
        expect(@ecosystem.send(:alive_neigbour_count, 1, 1)).to eq 8
      end

      it 'counts with 3x3' do
        # bottom riht
        @ecosystem = Ecosystem.new([
          [1,1,1],
          [1,1,1],
          [1,0,1]])
        expect(@ecosystem.send(:alive_neigbour_count, 2, 2)).to eq 2
      end
    end

    context '#alive?' do
      def alive?(alive,alive_neigbour_count)
        Ecosystem.new([[]]).send(:alive?, alive, alive_neigbour_count)
      end

      it 'underpopulation' do
        expect(alive?(true, 0)).to eq(false)
        expect(alive?(true, 1)).to eq(false)
      end

      it 'survival' do
        expect(alive?(true, 2)).to eq(true)
        expect(alive?(false, 2)).to eq(false)
      end

      it 'resorection or survival' do
        expect(alive?(true, 3)).to eq(true)  # survival
        expect(alive?(false, 3)).to eq(true) # resorection
      end

      it 'overpopulation' do
        4.upto(8).each do |i|
          expect(alive?(true, i)).to eq(false)  # survival
          expect(alive?(false, i)).to eq(false) # resorection
        end
      end
    end
  end
end
