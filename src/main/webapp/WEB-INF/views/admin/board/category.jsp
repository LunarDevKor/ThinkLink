<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판 카테고리 관리</title>
    <style>
/*         /* CSS 스타일링 */ */
/*         body { */
/*             font-family: Arial, sans-serif; */
/*             background-color: #f4f4f4; */
/*             margin: 0; */
/*             padding: 0; */
/*         } */
/*         .container { */
/*             max-width: 800px; */
/*             margin: 20px auto; */
/*             padding: 20px; */
/*             background-color: #fff; */
/*             border-radius: 5px; */
/*             box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); */
/*         } */
/*         h1 { */
/*             text-align: center; */
/*         } */
/*         ul { */
/*             list-style: none; */
/*             padding: 0; */
/*         } */
/*         li { */
/*             margin-bottom: 10px; */
/*         } */
/*         .category-item { */
/*             display: flex; */
/*             justify-content: space-between; */
/*             align-items: center; */
/*             padding: 10px; */
/*             border: 1px solid #ccc; */
/*             border-radius: 5px; */
/*         } */
/*         .category-name { */
/*             flex-grow: 1; */
/*         } */
/*         .btn { */
/*             padding: 5px 10px; */
/*             background-color: #007bff; */
/*             color: #fff; */
/*             border: none; */
/*             border-radius: 3px; */
/*             cursor: pointer; */
/*         } */
/*         .btn:hover { */
/*             background-color: #0056b3; */
/*         } */
    </style>
</head>
<body>
    <div class="container">
        <h1>게시판 카테고리 관리</h1>
        <ul id="category-list">
            <!-- 카테고리 목록이 여기에 동적으로 추가됩니다. -->
        </ul>
        <button class="btn" onclick="addCategory()">카테고리 추가</button>
    </div>

    <script>
        // JavaScript 코드
        function addCategory() {
            var categoryName = prompt("추가할 카테고리의 이름을 입력하세요:");
            if (categoryName) {
                var categoryList = document.getElementById("category-list");
                var li = document.createElement("li");
                li.className = "category-item";
                li.innerHTML = `
                    <span class="category-name">${categoryName}</span>
                    <button class="btn" onclick="editCategory(this)">수정</button>
                    <button class="btn" onclick="deleteCategory(this)">삭제</button>
                `;
                categoryList.appendChild(li);
            }
        }

        function editCategory(button) {
            var newName = prompt("새로운 카테고리 이름을 입력하세요:");
            if (newName) {
                button.parentElement.querySelector(".category-name").textContent = newName;
            }
        }

        function deleteCategory(button) {
            if (confirm("정말로 이 카테고리를 삭제하시겠습니까?")) {
                button.parentElement.remove();
            }
        }
    </script>
</body>
</html>
