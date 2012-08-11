# -1.you can input 1.1000,500,100,50 or 10 coins (only one)
class VendingMachine
  attr_accessor :total
  attr_accessor :item_info
  def initialize
    @total = 0
    @item_info =  {
      :name => "coke",
      :price => 120,
      :stock => 5
    }
  end
  def input coin
    return coin unless [10,50,100,500,1000].include? coin 
    @total += coin
  end
  def refund!
    total = @total
    @total = 0
    total
  end
  def can_purchase?
    @total >= @item_info[:price]
  end

end
describe VendingMachine ,"when initialized with object" do
  before do
    @vending_machine = VendingMachine.new
  end
  it "should not be nil" do
    @vending_machine.should_not be_nil
  end
  it "total output should be 0" do
    @vending_machine.total.should == 0
  end
  it "input 10 coin" do
    @vending_machine.input 10
    @vending_machine.total.should == 10
  end
  it "input 10 and 100 coin" do
    @vending_machine.input 10
    @vending_machine.input 100
    @vending_machine.total.should == 110
  end
  it "you can only 10,50,100,500,1000" do
    @vending_machine.input(1).should == 1
    @vending_machine.total.should ==  0
    @vending_machine.input(10000).should == 10000
    @vending_machine.total.should ==  0
  end
  it "when you refund then total_output should be 0" do
    @vending_machine.input 10
    @vending_machine.input 50
    total = @vending_machine.total
    @vending_machine.refund!.should == total
    @vending_machine.total.should == 0
  end
  it "item info returns :name => coke , :price => 120 , :stock => 5" do
    @vending_machine.item_info.should == {
       :name => "coke",
       :price => 120,
       :stock => 5
    }
  end
  it "if you input 10 then you can't buy" do
    @vending_machine.input(10)
    @vending_machine.can_purchase?.should == false
  end
  it "if you input 120 then you can buy" do
    @vending_machine.input(10)
    @vending_machine.input(10)
    @vending_machine.input(100)
    @vending_machine.can_purchase?.should == true
  end


end
