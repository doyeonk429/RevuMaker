//
//  StoreModel.swift
//  RevuMaker
//
//  Created by 김도연 on 4/29/25.
//

import Foundation

struct StoreModel: Hashable, Codable {
    let storeName: String
    let date: String
    let category: String
    let storeTotalPrice : Int
    var productNames: [Product]
}

struct Product: Hashable, Codable {
    var name: String
    var price: Int
    var count: Int
    var totalPrice: Int
}

enum ConfirmMode {
    case fromScan
    case fromEmpty
}

enum ReviewTone: String, CaseIterable {
    case friendly = "친근한 말투"
    case cute = "귀여운 말투"
    case trustworthy = "믿음직한 말투"
    case uncle = "아저씨 말투"
    case twitter = "트위터 말투(140자 제한)"
    case blog = "블로그 말투"
}

extension ReviewTone {
    var infoText: String {
        switch self {
        case .friendly:
            return "친근한 반말 문어체"
        case .cute:
            return "이모지 가득 귀여운 말투"
        case .trustworthy:
            return "신뢰감 있는 서술형 문체"
        case .uncle:
            return "사투리 가득 구수한 아재 말투"
        case .twitter:
            return "140자 트위터 스타일"
        case .blog:
            return "네이버 블로그 말투"
        }
    }
    
    var example: String {
        switch self {
        case .friendly:
            return """
                오늘은 새로운 카페를 방문했다. 전체적으로 분위기가 아늑하고, 부드러운 조명 덕분에 오래 머무르기에 적합했다. 주문한 바닐라라떼는 적당한 달콤함과 부드러운 풍미가 조화를 이루어 만족스러웠다. 디저트로 선택한 티라미수는 촉촉하고 깔끔한 맛을 가지고 있어 커피와 함께 즐기기에 좋았다. 좌석 간 간격이 넓어 조용히 공부하거나 업무를 보기에도 무리가 없을 것으로 보인다.
                """
        case .cute:
            return """
                오늘 다녀온 카페 너무너무 만족했어요🫶🏻 내부가 아늑하고 조명도 은은해서 진짜 분위기 최고였어요✨ 바닐라라떼 주문했는데, 달콤하고 부드러워서 한 모금 마시자마자 기분 좋아졌어요ㅎㅎ 티라미수도 먹었는데 촉촉하고 부드러워서 커피랑 찰떡 조합이었어요🍰☕️ 자리도 넓직해서 노트북 가져와서 공부하거나 책 읽기에도 좋을 것 같아요📚 다음에 또 방문하고 싶은 카페에요❣️ 완전 추천합니다💖
                """
        case .trustworthy:
            return """
                오늘 방문한 카페는 전체적으로 안정감 있는 분위기와 쾌적한 환경이 인상적이었다. 실내는 조도가 낮은 조명과 차분한 인테리어로 꾸며져 있어, 오랜 시간 머물러도 편안함을 느낄 수 있었다. 주문한 바닐라라떼는 단맛과 고소한 맛이 균형을 이루어, 부담 없이 즐기기에 적합했다. 함께 주문한 티라미수 역시 부드러운 식감과 깔끔한 맛이 돋보였으며, 커피와의 궁합도 매우 우수했다. 좌석 간 간격이 충분히 확보되어 있어, 개인 작업이나 대화를 나누기에도 좋은 환경이었다. 종합적으로 볼 때, 분위기와 메뉴 품질 모두 만족스러운 수준이며, 재방문 의사가 충분히 생기는 곳이었다.
                """
        case .uncle:
            return """
                오늘.카페를.한번.가봤시유.. 에이.거.분위기.끝내주드만유..조명도.딱.기냥.눈에.편허구먼유.. 바닐라라떼를.한잔.했는디.요것이.달지도.않고.고소허니.입에.착.붙드만유.. 티라미슈도.시켜봤는디.캬..입에서.녹아부러..이거.한입.먹으니.기분이.확.풀려부렀슈.. 자리도.허벌나게.널찍허니.노트북.펴놓고.일할라믄.아주.딱이유.. 담에.또.꼭.갈끼라.마음.단디.먹어부렀슈..
                """
        case .twitter:
            return """
                카페 다녀왔는데 진짜 미쳤다ㅋㅋㅋㅋ 분위기 무드 대폭발ㅋㅋㅋ 바닐라라떼 내 인생 라떼 됨ㅋㅋ 티라미수 먹고 기절함ㅠㅠ 또 감
                """
        case .blog:
            return """
                ✍️ 내돈내산 성수 카페 리뷰 / 작업하기 좋은 조용한 감성카페 추천
                오늘은 제가 직접 다녀온 성수동 카페 하나 소개해보려고 해요. 요즘 SNS에서 종종 보이길래 궁금해서 방문해봤고, 전체적으로 만족도가 높았던 곳이라 이렇게 글로 남겨봅니다.
                
                📍위치 정보
                서울 성동구 성수이로 ○○길 12
                성수역 3번 출구에서 도보 약 5분 정도 걸렸어요. 지도 앱에 ‘○○카페’라고 검색하면 바로 뜹니다.
                
                🕒 영업시간
                월~일 10:00 ~ 21:00 (Last order 20:30)
                저는 평일 오후 2시쯤 방문했는데, 사람 많지 않고 조용해서 좋았어요. 주말은 웨이팅 있을 수도 있을 것 같아요.
                
                ✔️ 주문 메뉴 & 가격 (내돈내산 기준)
                - 바닐라라떼 (5,500원)
                - 티라미수 (6,000원)
                커피는 고소하고 부드러워서 단맛 싫어하는 분들도 괜찮게 드실 수 있을 것 같아요. 디저트는 부드럽고 촉촉한 티라미수 추천드려요.
                
                🪑 좌석 & 작업 환경
                전체적으로 조용하고 좌석 간 간격이 넓어서 공부하거나 노트북 작업용으로도 좋았어요. 콘센트 있는 자리도 몇 개 있었고, 창가 자리는 햇살이 잘 들어서 분위기 내기에도 딱입니다.
                
                💳 영수증 정보
                총 결제 금액: 11,500원
                방문일시: 2025.04.28 (월) 14:12
                
                📷 사진 찍기 좋은 포인트
                창가 쪽 테이블 + 노란 조명 아래가 제일 예쁘게 나왔어요. 바닥 타일이랑 의자 컬러도 잘 어울려서 디저트 컷 찍기 좋아요.
                
                🔁 총평
                가격 대비 분위기, 커피 맛, 디저트 퀄리티까지 모두 만족스러웠어요. 조용한 평일 오후에 혼자 가서 시간 보내기에도 딱이었고요. 작업하러 가기에도 부담 없어서 앞으로 종종 방문할 것 같아요.
                
                성수 근처 조용하고 예쁜 카페 찾고 계셨다면, 이곳 한 번 방문해보시는 것도 좋을 것 같아요. 내돈내산 후기니까 참고하시고요 :)
                """
        }
    }
}

enum PromptData: CaseIterable {
    case greatInterior
    case goodPhotoSpot
    case goodForConversation
    case goodForFocus
    case niceView
    case friendlyStaff
    case cleanStore
    case cleanRestroom
    case easyParking
    case comfySeats
    case largePortions
    case deliciousFood
    case goodValue
    case hasSignatureMenu
    case goodForSpecialDay
    case goodWithParents
    case goodWithFriends
    case goodWithPartner
    case goodForGroupMeeting
}

extension PromptData {
    var desc: String {
        switch self {
        case .greatInterior: return "인테리어가 멋져요"
        case .goodPhotoSpot: return "사진이 잘 나와요"
        case .goodForConversation: return "대화하기 좋아요"
        case .goodForFocus: return "집중하기 좋아요"
        case .niceView: return "뷰가 좋아요"
        case .friendlyStaff: return "직원들이 친절해요"
        case .cleanStore: return "매장이 청결해요"
        case .cleanRestroom: return "화장실이 깨끗해요"
        case .easyParking: return "주차하기가 편해요"
        case .comfySeats: return "좌석이 편해요"
        case .largePortions: return "양이 많아요"
        case .deliciousFood: return "음식이 맛있어요"
        case .goodValue: return "가성비가 좋아요"
        case .hasSignatureMenu: return "시그니처 메뉴가 있어요"
        case .goodForSpecialDay: return "특별한 날 가기 좋아요"
        case .goodWithParents: return "부모님과 함께 가기 좋아요"
        case .goodWithFriends: return "친구들과 함께 가기 좋아요"
        case .goodWithPartner: return "연인과 함께 가기 좋아요"
        case .goodForGroupMeeting: return "단체로 모임하기 좋아요"
        }
    }
}
