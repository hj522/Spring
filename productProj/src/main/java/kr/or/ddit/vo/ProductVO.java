package kr.or.ddit.vo;

public class ProductVO {
	private String productId;	// 상품 아이디(product테이블의 product_id 컬럼)
	private String pname;		// 상품명
	private int unitPrice;		// 상품 가격
	private String description;	// 상품 설명
	private String manufacturer; // 제조사
	private String category;	 // 분류
	private int unitsInStock;	// 재고수
	private String condition;	// 신상품 or 중고품 or 재생품
	
	public ProductVO() {
		
	}

	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	public int getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(int unitPrice) {
		this.unitPrice = unitPrice;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getManufacturer() {
		return manufacturer;
	}

	public void setManufacturer(String manufacturer) {
		this.manufacturer = manufacturer;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public int getUnitsInStock() {
		return unitsInStock;
	}

	public void setUnitsInStock(int unitsInStock) {
		this.unitsInStock = unitsInStock;
	}

	public String getCondition() {
		return condition;
	}

	public void setCondition(String condition) {
		this.condition = condition;
	}

	@Override
	public String toString() {
		return "ProductVO [productId=" + productId + ", pname=" + pname + ", unitPrice=" + unitPrice + ", description="
				+ description + ", manufacturer=" + manufacturer + ", category=" + category + ", unitsInStock="
				+ unitsInStock + ", condition=" + condition + "]";
	}
}
