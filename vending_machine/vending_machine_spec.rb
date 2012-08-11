# -1.you can input 1.1000,500,100,50 or 10 coins (only one)
class VendingMachine
  attr_accessor :total
  attr_accessor :item_info
  attr_accessor :sale_proceeds
  def initialize
    @total = 0
    @item_info =  {
      :name => "coke",
      :price => 120,
      :stock => 5
    }
    @sale_proceeds = 0
  end
  def input coin
    return coin unless [10,50,100,500,1000].include? coin 
    @total += coin
    0
  end
  def refund!
    change = @total
    @total = 0
    change
  end
  def purchasable?
    @total >= @item_info[:price]
  end
  def purchase
    return unless purchasable?
    @item_info[:stock] -= 1
    @sale_proceeds += @item_info[:price]
    @total -= @item_info[:price]
  end

end
describe VendingMachine ,"when initialized with object" do
  before do
    @vending_machine = VendingMachine.new
  end
  subject { @vending_machine }
  its(:total) { should == 0 }
  it { should_not be_nil }
  context 'after input 10 coin' do
    before do
      @vending_machine.input 10
    end
    subject { @vending_machine }
    its(:total) { should == 10 }
    it { should_not be_purchasable }
  end

  context 'after input 10,10 and 100 coins' do
    before do
      @vending_machine.input 10
      @vending_machine.input 10
      @vending_machine.input 100
    end
    subject { @vending_machine }
    its(:total) { should == 120 }
    it { should be_purchasable }
  end
  context 'after input 10,10 and 100 coins and purchase' do
    before do
      @vending_machine.input 10
      @vending_machine.input 10
      @vending_machine.input 100
      @vending_machine.purchase
    end
    subject { @vending_machine }
    its(:item_info) {should == {
        :name => "coke",
        :price => 120,
        :stock => 4}
    }
    its(:sale_proceeds) {should == 120}
    its(:total) {should == 0}
  end

  context 'after input 10,50 coins then refund!' do
    before do
      @vending_machine.input 10
      @vending_machine.input 50
      @refunded = @vending_machine.refund!
    end
    subject { @vending_machine }
    its(:total) { should == 0 }
    it 'refunded amount == 60' do
      @refunded.should == 60
    end
  end

  [1,5,2000,5000,10000].each do |yen|
    context "when input #{yen}" do
      before do
        @input_return = @vending_machine.input(yen)
      end
      subject { @vending_machine }
      it "should return #{yen}" do
        @input_return.should == yen
      end
      its(:total) { should == 0 }
    end
  end

  [10,50,100,500,1000].each do |yen|
    context "when input #{yen}" do
      before do
        @input_return = @vending_machine.input(yen)
      end
      subject { @vending_machine }
      it "should return 0" do
        @input_return.should == 0
      end
      its(:total) { should == yen }
    end
  end
  

  it "item info returns :name => coke , :price => 120 , :stock => 5" do
    @vending_machine.item_info.should == {
       :name => "coke",
       :price => 120,
       :stock => 5
    }
  end

end
