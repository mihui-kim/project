package mall.cart;

public class CartDTO {
	//장바구니 번호, 구매자, 상품번호, 상품이름, 정가, 할인율, 판매가, 구매수량, 구매이미지
	
	private int cart_id;
	private String buyer_id;
	private int product_id;
	private String product_name;
	private int product_price;
	private int discount_rate;
	private int buy_price;
	private int buy_count;
	private String product_image;
	
	
	public int getCart_id() {
		return cart_id;
	}
	public String getBuyer_id() {
		return buyer_id;
	}
	public int getProduct_id() {
		return product_id;
	}
	public String getProduct_name() {
		return product_name;
	}
	public int getProduct_price() {
		return product_price;
	}
	public int getDiscount_rate() {
		return discount_rate;
	}
	public int getBuy_price() {
		return buy_price;
	}
	public int getBuy_count() {
		return buy_count;
	}
	public String getProduct_image() {
		return product_image;
	}
	public void setCart_id(int cart_id) {
		this.cart_id = cart_id;
	}
	public void setBuyer_id(String buyer_id) {
		this.buyer_id = buyer_id;
	}
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}
	public void setDiscount_rate(int discount_rate) {
		this.discount_rate = discount_rate;
	}
	public void setBuy_price(int buy_price) {
		this.buy_price = buy_price;
	}
	public void setBuy_count(int buy_count) {
		this.buy_count = buy_count;
	}
	public void setProduct_image(String product_image) {
		this.product_image = product_image;
	}
	
	@Override
	public String toString() {
		return "CartDTO [cart_id=" + cart_id + ", buyer_id=" + buyer_id + ", product_id=" + product_id + ", product_name="
				+ product_name + ", product_price=" + product_price + ", discount_rate=" + discount_rate
				+ ", buy_price=" + buy_price + ", buy_count=" + buy_count + ", product_image=" + product_image + "]";
	}

}
