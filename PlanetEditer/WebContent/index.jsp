<%@page import="common.Util"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="/resources/style/basic.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/three@0.122.0/examples/js/controls/OrbitControls.min.js"></script>
    <script src="/resources/js/util/util.js"></script>
    <script src="/resources/js/App.js" type="module"></script>
</head>
<body>

	<div id="init-data">
	<%
		User user = (User) session.getAttribute("userSession");
	
		if(user != null){ 
			out.println(Util.UserToJSON(user));
		} else {
            out.println("null");
        }
	%>
	</div>

	


    <!-- 로딩창 -->
    <div class="wait active">
        <h1>잠시만 기다려주세요</h1>
    </div>
    <!-- 로딩창 -->
    
    <!-- 메인페이지 -->
    <div class="fix-full main-container active">
        <div>
            <div class="session">
                <div class="d-flex gap-10 session-btns active">
                    <button class="btn login-btn">로그인</button>
                    <button class="btn join-btn">회원가입</button>
                </div>
                <div class="session-btns">
                    <button class="btn logout-btn">로그아웃</button>
                </div>
            </div>

            <div>
                <button class="btn planet-list-btn">행성 리스트 조회</button>
            </div>

            <div>
                <button class="btn my-planet-list-btn">내 행성 조회</button>
            </div>

            <div>
                <button class="btn planet-create-btn">새 행성 만들기</button>
            </div>

            <div>
                <button class="btn information-btn">상세정보</button>
            </div>
        </div>
    </div>
    <!-- 메인페이지 -->
    
    <!-- 행성 리스트 뷰어 -->
    <div class="fix-full list-container">
        <h2 class="d-flex">행성 리스트</h2>           
        <div class="d-flex">
            <div class="planet-table grid-3-3 gap-10 ">
                <div class="card d-flex">
                    <img src="./resources/image/canvas/map/test.png" alt="지도">
                    <div class="text">
                        <h3>지구</h3>
                        <p>가장 아름다운 행성 - 지구는 내가 먼저 선점했다 ㅅㄱ</p>
                        <p class="creater">제작자 : 주승규</p>
                    </div>
                </div>
            </div>
            <div class="scroll-bar">
                <i class="fa-sharp fa-solid fa-shuttle-space"></i>
            </div>
        </div>
        <div class="d-flex">
            <div class="w-1000px">
                <button class="btn main-btn">메인화면으로</button>    
            </div>
            <div class="w-10px"></div>
        </div>
    </div>
    <!-- 행성 리스트 뷰어 -->

    <!-- 행성 편집기 -->
    <div class="fix-full canvas-container">
        <div class="left-top ui d-block">
            <div>
                <p>※ 개발자도구를 열고 있으면 랙이 걸릴 수 있습니다.</p>
                <p>※ 현재 시점 기준 행성 가장자리에서 작업하는 걸 권장하지 않습니다.</p>
            </div>
        </div>
        <div class="center-top ui">
            <div class="d-flex gap-10 continent-tool-menu">
                <div class="tool continent-up active">
                    <i class="fa-solid fa-mountain"></i>
                </div>
                <div class="tool continent-down active">
                    <i class="fa-solid fa-mountain"></i>
                </div>
            </div>
            <div class="d-flex gap-10 cloud-tool-menu">
                <div class="tool cloud-up active">
                    <i class="fa-regular fa-pencil"></i>
                </div>
                <div class="tool cloud-down active">
                    <i class="fa-solid fa-eraser"></i>
                </div>
            </div>
        </div>
        <div class="right-top ui">
            <button class="small btn save-btn">저장하고 나가기</button>
            <button class="small btn exit-btn">나가기</button>
        </div>
        <div class="left-center ui">
            <div class="d-flex gap-10 continent-tool-menu">
                <div class="range-input">
                    <p>브러쉬 반지름</p>
                    <input type="range" class="rotate-range continent-size" min="1" max="40" step="1" value="5">
                </div>
                <div class="range-input">
                    <p>경사도</p>
                    <input type="range" class="rotate-range continent-color" min="0.01" max="0.99" step="0.01" value="0.01">
                </div>
            </div>
            <div class="d-flex gap-10 cloud-tool-menu">
                <div class="range-input">
                    <p>브러쉬 반지름</p>
                    <input type="range" class="rotate-range cloud-size" min="1" max="40" step="1" value="5">
                </div>
                <div class="range-input">
                    <p>구름 두께</p>
                    <input type="range" class="rotate-range cloud-color" min="0.01" max="0.99" step="0.01" value="0.01">
                </div>
            </div>
            <div class="d-flex gap-10 water-tool-menu">
                <div class="range-input">
                    <p>해수면</p>
                    <input type="range" class="rotate-range water-level" min="-1" max="256" step="1" value="-1">
                </div>
            </div>
            <div class="d-flex gap-10 color-tool-menu">
                <div class="range-input">
                    <p>브러쉬 반지름</p>
                    <input type="range" class="rotate-range color-size" min="1" max="40" step="1" value="5">
                </div>
            </div>
        </div>
        <div class="right-center ui">
            <div>
                <div class="color-tool-menu color-view">
    
                </div>
                <div class="d-flex">
                    <div class="d-flex gap-10 color-tool-menu">
                        <div class="range-input">
                            <p>R</p>
                            <input type="range" class="rotate-range color-r" min="0" max="255" step="1" value="0">
                        </div>
                    </div>
                    <div class="d-flex gap-10 color-tool-menu">
                        <div class="range-input">
                            <p>G</p>
                            <input type="range" class="rotate-range color-g" min="0" max="255" step="1" value="0">
                        </div>
                    </div>
                    <div class="d-flex gap-10 color-tool-menu">
                        <div class="range-input">
                            <p>B</p>
                            <input type="range" class="rotate-range color-b" min="0" max="255" step="1" value="0">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="left-bottom ui">
            <div>
                <div class="d-flex gap-10 color-tool-menu bottom-absolute">
                    <p class="nowrap">브러쉬 타입 : </p>
                    <select class="color-brash-type">
                        <option value="dot">dot</option>
                        <option value="line">line</option>
                    </select>
                </div>
                <div class="d-flex gap-10 continent-tool-menu bottom-absolute">
                    <p class="nowrap">브러쉬 타입 : </p>
                    <select class="continent-brash-type">
                        <option value="dot">dot</option>
                        <option value="line">line</option>
                    </select>
                </div>
                <div class="d-flex gap-10 cloud-tool-menu bottom-absolute">
                    <p class="nowrap">브러쉬 타입 : </p>
                    <select class="cloud-brash-type">
                        <option value="dot">dot</option>
                        <option value="line">line</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="center-bottom ui">
            <div class="map">

            </div>
        </div>
        <div class="right-bottom ui">
            <div class="tool draw-color-tool">
                <i class="fa-solid fa-paintbrush"></i>
            </div>
            <div class="tool move-tool">
                <i class="fa-solid fa-computer-mouse"></i>
            </div>
            <div class="tool draw-cloud-tool">
                <i class="fa-solid fa-cloud"></i>
            </div>
            <div class="tool draw-continent-tool">
                <i class="fa-solid fa-mountain"></i>
            </div>
            <div class="tool draw-water-tool">
                <i class="fa-solid fa-water"></i>
            </div>
        </div>
    </div>
    <!-- 행성 편집기 -->

    <!-- 로그인, 로그아웃 -->
    <div class="fix-full user-container">
        <div class="join">
            <h2 class="d-flex justify-between">회원 가입하기 <button class="btn small login-btn">로그인 하기</button></h2>           
            <fieldset class="text-form">
                <legend class="label">아이디</legend>
                <input type="text" id="user-join-id">
            </fieldset>
            <fieldset class="text-form">
                <legend class="label">비밀번호</legend>
                <input type="text" id="user-join-pw">
            </fieldset>
            <fieldset class="text-form">
                <legend class="label">이름</legend>
                <input type="name" id="user-join-name">
            </fieldset>
            <div class="d-flex gap-10 mt-10">
                <button class="btn create-user-btn">가입하기</button>
                <button class="btn main-btn">메인화면으로</button>
            </div>
        </div>
        <div class="login active">
            <h2 class="d-flex justify-between">로그인 하기 <button class="btn small join-btn">회원가입 하기</button></h2>           
            <fieldset class="text-form">
                <legend class="label">아이디</legend>
                <input type="text" id="user-login-id">
            </fieldset>
            <fieldset class="text-form">
                <legend class="label">비밀번호</legend>
                <input type="name" id="user-login-pw">
            </fieldset>
            <div class="d-flex gap-10 mt-10">
                <button class="btn user-login-btn">로그인하기</button>
                <button class="btn main-btn">메인화면으로</button>
            </div>
        </div>
    </div>
    <!-- 로그인, 로그아웃 -->

    <!-- 새 행성 추가 -->
    <div class="fix-full planet-create-container ">
        <h2 class="d-flex">새 행성 만들기</h2>           
        <div class="d-flex flex-col gap-10">
            <fieldset class="text-form">
                <legend class="label">제목</legend>
                <input type="text" id="planet-create-title">
            </fieldset>
            <fieldset class="textarea-form">
                <legend class="label">설명</legend>
                <textarea id="planet-create-content"></textarea>
            </fieldset>
            <div class="d-flex gap-10">
                <button class="btn create-btn">행성 생성</button>
                <button class="btn main-btn">메인화면으로</button>
            </div>
        </div>
    </div>
    <!-- 새 행성 추가 -->

    <!-- 상세설명 페이지 -->
    <div class="fix-full information-container">
        <div>
            <div class="w-1000px">
                설명설명설명설명설명설명설명설명<br>
                설명설명설명설명설명설명설명설명<br>
                설명설명설명설명설명설명설명설명<br>
                설명설명설명설명설명설명설명설명<br>
            </div>
            <div class="d-flex justify-end w-1000px">
                <button class="btn main-btn">메인화면으로</button>
            </div>
        </div>
    </div>
    <!-- 상세설명 페이지 -->
    

</body>
</html>