<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>use DB register</title>
	<style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f6f9;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .form-container {
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            padding: 30px;
            width: 100%;
            max-width: 400px;
        }

        h2 {
            text-align: center;
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
        }

        label {
            font-size: 14px;
            color: #333;
            margin-bottom: 5px;
            display: block;
        }

        input[type="text"],
        input[type="password"],
        input[type="email"],
        select,
        input[type="radio"] {
            width: 100%;
            padding: 12px;
            margin: 8px 0 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            color: #333;
        }

        input[type="text"]:focus,
        input[type="password"]:focus,
        input[type="email"]:focus,
        select:focus {
            border-color: #4CAF50;
            outline: none;
        }

        /* 전화번호 입력을 한 줄로 배치 */
        .phone-input {
            display: flex;
            gap: 10px;
            justify-content: space-between;
        }

        .phone-input select,
        .phone-input input {
            width: 32%;  /* 각 입력 필드가 한 줄에 고르게 배치되도록 설정 */
        }

        /* 성별 선택 버튼 스타일 */
        .gender {
            display: flex;
            justify-content: space-between;
            gap: 10px;
            margin-top: 10px;
        }

        .gender label {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 10px;
            border-radius: 5px;
            background-color: #f0f0f0;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .gender input[type="radio"] {
            display: none;  /* 라디오 버튼 숨기기 */
        }

        .gender label:hover {
            background-color: #e8e8e8;
        }

        .gender input[type="radio"]:checked + label {
            background-color: #4CAF50;
            color: white;
        }

        input[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
	<div class="form-container">
        <h2>회원가입</h2>
        <form action="RealRegisterProcess.jsp" method="post" onsubmit="return validateForm()">
            <label for="id">아이디</label>
            <input type="text" id="id" name="id" required>

            <label for="pwd">비밀번호</label>
            <input type="password" id="pwd" name="pwd" required>

            <label for="name">이름</label>
            <input type="text" id="name" name="name" required>

            <label for="email">이메일</label>
            <input type="email" id="email" name="email" required>

            <label>전화번호</label>
            <div class="phone-input">
                <select name="phone1">
                    <option value="010">010</option>
                    <option value="02">02</option>
                    <option value="031">031</option>
                    <option value="051">051</option>
                </select>
                <input type="text" name="phone2" placeholder="####" maxlength="4" required>
                <input type="text" name="phone3" placeholder="####" maxlength="4" required>
            </div>

            <label>성별</label>
            <div class="gender">
                <input type="radio" name="gender" value="m" id="male" checked>
                <label for="male">남자</label>

                <input type="radio" name="gender" value="f" id="female">
                <label for="female">여자</label>
            </div>

            <input type="submit" value="회원가입">
        </form>
    </div>
</body>
</html>