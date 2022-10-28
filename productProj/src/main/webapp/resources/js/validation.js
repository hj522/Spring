function checkAddBook() {
    alert("테스트");
    
    var bookId = document.getElementById("bookId");
    var name = document.getElementById("name");
    var unitPrice = document.getElementById("unitPrice");
    var unitsInStock = document.getElementById("unitsInStock");

    // 도서 아이디 ISBN 으로 시작
	// 숫자 포함해서 문자 길이 5~12자
    if(!check(/^ISBN[0-9]{5,12}$/, bookId, "[도서코드]\nISBN과 숫자를 조합하여 5~12자까지 입력해주세요.\n첫 글자는 반드시 ISBN으로 시작하세요."))
        return false;

    // 도서명 문자 길이 4~12자
    if(name.value.length<4 || name.value.length>12) {
        alert("[도서명]\n최소 4자에서 최대 12자까지 입력해주세요.");
        name.focus();
        return false;
    } 

    // 가격 문자 길이 0인지 숫자인지
    if(unitPrice.value.length == 0 || isNaN(unitPrice.value)) {
        alert("[도서가격]\n숫자로만 입력해주세요.");
        unitPrice.focus();
        return false;
    }

	// 가격 음수인지
    if(unitPrice.value < 0) {
        alert("[도서가격]\n음수는 입력할 수 없습니다.");
        unitPrice.select();
        return false;
    }
    // 재고 수 숫자인지
    if(isNaN(unitsInStock.value)) {
        alert("[재고 수]\n숫자로만 입력해주세요.");
        unitsInStock.select();
        return false;   
    }
    
    function check(regExp, e, msg) {
        if(regExp.test(e.value)) {
            return true;
        }
        alert(msg);
        e.focus();
        return false;
    }
    
    document.newBook.submit();
}