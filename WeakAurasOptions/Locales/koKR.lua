if not WeakAuras.IsCorrectVersion() then return end

if not(GetLocale() == "koKR") then
  return
end

local L = WeakAuras.L

-- WeakAuras/Options
	L["-- Do not remove this comment, it is part of this trigger: "] = "-- 이 주석을 삭제하지 마세요, 이 활성 조건의 일부입니다: "
	L["% of Progress"] = "진행 상태의 %"
	L["%i auras selected"] = "%i개 효과 선택됨"
	L["%i Matches"] = "%i개 일치"
	--[[Translation missing --]]
	L["%s - Option #%i has the key %s. Please choose a different option key."] = "%s - Option #%i has the key %s. Please choose a different option key."
	--[[Translation missing --]]
	L["%s %s, Lines: %d, Frequency: %0.2f, Length: %d, Thickness: %d"] = "%s %s, Lines: %d, Frequency: %0.2f, Length: %d, Thickness: %d"
	--[[Translation missing --]]
	L["%s %s, Particles: %d, Frequency: %0.2f, Scale: %0.2f"] = "%s %s, Particles: %d, Frequency: %0.2f, Scale: %0.2f"
	L["%s Alpha: %d%%"] = "%s 투명도: %d%%"
	L["%s Color"] = "%s 색상"
	--[[Translation missing --]]
	L["%s Default Alpha, Zoom, Icon Inset, Aspect Ratio"] = "%s Default Alpha, Zoom, Icon Inset, Aspect Ratio"
	--[[Translation missing --]]
	L["%s Inset: %d%%"] = "%s Inset: %d%%"
	--[[Translation missing --]]
	L["%s is not a valid SubEvent for COMBAT_LOG_EVENT_UNFILTERED"] = "%s is not a valid SubEvent for COMBAT_LOG_EVENT_UNFILTERED"
	L["%s Keep Aspect Ratio"] = "%s 종횡비 유지"
	L["%s total auras"] = "총 %s개 효과"
	L["%s Zoom: %d%%"] = "%s 확대: %d%%"
	L["%s, Border"] = "%s, 테두리"
	L["%s, Offset: %0.2f;%0.2f"] = "%s, 좌표: %0.2f;%0.2f"
	L["%s, offset: %0.2f;%0.2f"] = "%s, 좌표: %0.2f;%0.2f"
	--[[Translation missing --]]
	L["|c%02x%02x%02x%02xCustom Color|r"] = "|c%02x%02x%02x%02xCustom Color|r"
	--[[Translation missing --]]
	L["|cFFFF0000Note:|r The unit '%s' is not a trackable unit."] = "|cFFFF0000Note:|r The unit '%s' is not a trackable unit."
	--[[Translation missing --]]
	L["|cFFffcc00Anchors:|r Anchored |cFFFF0000%s|r to frame's |cFFFF0000%s|r"] = "|cFFffcc00Anchors:|r Anchored |cFFFF0000%s|r to frame's |cFFFF0000%s|r"
	--[[Translation missing --]]
	L["|cFFffcc00Anchors:|r Anchored |cFFFF0000%s|r to frame's |cFFFF0000%s|r with offset |cFFFF0000%s/%s|r"] = "|cFFffcc00Anchors:|r Anchored |cFFFF0000%s|r to frame's |cFFFF0000%s|r with offset |cFFFF0000%s/%s|r"
	--[[Translation missing --]]
	L["|cFFffcc00Anchors:|r Anchored to frame's |cFFFF0000%s|r"] = "|cFFffcc00Anchors:|r Anchored to frame's |cFFFF0000%s|r"
	--[[Translation missing --]]
	L["|cFFffcc00Anchors:|r Anchored to frame's |cFFFF0000%s|r with offset |cFFFF0000%s/%s|r"] = "|cFFffcc00Anchors:|r Anchored to frame's |cFFFF0000%s|r with offset |cFFFF0000%s/%s|r"
	L["|cFFffcc00Extra Options:|r"] = "|cFFffcc00추가 옵션:|r"
	--[[Translation missing --]]
	L["|cFFffcc00Font Flags:|r |cFFFF0000%s|r and shadow |c%sColor|r with offset |cFFFF0000%s/%s|r%s%s%s"] = "|cFFffcc00Font Flags:|r |cFFFF0000%s|r and shadow |c%sColor|r with offset |cFFFF0000%s/%s|r%s%s%s"
	L["1 Match"] = "1개 일치"
	L["A 20x20 pixels icon"] = "20x20 픽셀 아이콘"
	L["A 32x32 pixels icon"] = "32x32 픽셀 아이콘"
	L["A 40x40 pixels icon"] = "40x40 픽셀 아이콘"
	L["A 48x48 pixels icon"] = "48x48 픽셀 아이콘"
	L["A 64x64 pixels icon"] = "64x64 픽셀 아이콘"
	L["A group that dynamically controls the positioning of its children"] = "포함된 개체들의 배열을 유동적으로 조절하는 그룹"
	L["A Unit ID (e.g., party1)."] = "유닛 ID (예 : party1)."
	L["Actions"] = "동작"
	L["Add %s"] = "%s 추가"
	L["Add a new display"] = "새로운 디스플레이 추가"
	L["Add Condition"] = "조건 추가"
	L["Add Entry"] = "항목 추가"
	L["Add Extra Elements"] = "추가 요소 추가"
	L["Add Option"] = "옵션 추가"
	L["Add Overlay"] = "오버레이 추가"
	L["Add Property Change"] = "속성 변경 추가"
	L["Add Sub Option"] = "하위 옵션 추가"
	L["Add to group %s"] = "그룹 %s에 추가"
	L["Add to new Dynamic Group"] = "새 유동적 그룹에 추가"
	L["Add to new Group"] = "새 그룹에 추가"
	L["Add Trigger"] = "활성 조건 추가"
	L["Addon"] = "애드온"
	L["Addons"] = "애드온"
	L["Advanced"] = "고급"
	L["Align"] = "정렬"
	L["Alignment"] = "정렬"
	L["All of"] = "다음 모두"
	L["Allow Full Rotation"] = "전체 회전 허용"
	L["Alpha"] = "투명도"
	L["Anchor"] = "고정시키기"
	L["Anchor Point"] = "고정 지점"
	L["Anchored To"] = "다음에 고정:"
	--[[Translation missing --]]
	L["And "] = "And "
	--[[Translation missing --]]
	L["and aligned left"] = "and aligned left"
	--[[Translation missing --]]
	L["and aligned right"] = "and aligned right"
	--[[Translation missing --]]
	L["and rotated left"] = "and rotated left"
	--[[Translation missing --]]
	L["and rotated right"] = "and rotated right"
	--[[Translation missing --]]
	L["and Trigger %s"] = "and Trigger %s"
	--[[Translation missing --]]
	L["and with width |cFFFF0000%s|r and %s"] = "and with width |cFFFF0000%s|r and %s"
	L["Angle"] = "각도"
	L["Animate"] = "애니메이션"
	L["Animated Expand and Collapse"] = "확장 / 접기 애니메이션"
	L["Animates progress changes"] = "진행 변화 애니메이션"
	L["Animation relative duration description"] = [=[
디스플레이 지속시간의 비율로 애니메이션 지속시간을 설정합니다, 분수 (1/2), 백분율 (50%), 또는 소수 (0.5)로 표현합니다.
|cFFFF0000참고:|r 디스플레이가 진행 시간이 없으면 (비-지속적 이벤트 활성 조건, 지속시간이 없는 오라, 등등), 애니메이션은 재생되지 않습니다.

|cFF4444FF예제:|r
애니메이션의 지속시간을 |cFF00CC0010%|r로 설정하고, 디스플레이의 활성 조건이 20초 지속 강화 효과일 때, 시작 애니메이션은 2초 동안 재생됩니다.
애니메이션의 지속시간을 |cFF00CC0010%|r로 설정하고, 디스플레이의 활성 조건이 지속시간이 없는 강화 효과일 때, 시작 애니메이션은 재생되지 않습니다 (지속시간을 따로 설정했더라도)."
]=]
	L["Animation Sequence"] = "애니메이션 순서"
	L["Animations"] = "애니메이션"
	L["Any of"] = "다음 중 하나"
	L["Apply Template"] = "견본 적용"
	L["Arc Length"] = "호 길이"
	L["Arcane Orb"] = "비전 구슬"
	L["At a position a bit left of Left HUD position."] = "좌측 HUD 위치보다 약간 왼쪽에 위치시킵니다."
	L["At a position a bit left of Right HUD position"] = "우측 HUD 위치보다 약간 왼쪽에 위치시킵니다"
	L["At the same position as Blizzard's spell alert"] = "블리자드의 주문 경보와 같은 위치에 위치시킵니다"
	L["Aura Name"] = "효과 이름"
	L["Aura Name Pattern"] = "효과 이름 패턴"
	L["Aura Type"] = "효과 유형"
	L["Aura(s)"] = "효과"
	L["Author Options"] = "작성자 옵션"
	L["Auto"] = "자동"
	L["Auto-Clone (Show All Matches)"] = "자동 복제 (모든 일치 항목 표시)"
	L["Auto-cloning enabled"] = "자동 복제 활성화"
	L["Automatic"] = "자동"
	L["Automatic Icon"] = "자동 아이콘"
	L["Backdrop Color"] = "배경 색상"
	--[[Translation missing --]]
	L["Backdrop in Front"] = "Backdrop in Front"
	L["Backdrop Style"] = "배경 스타일"
	L["Background Color"] = "배경 색상"
	L["Background Offset"] = "배경 위치"
	L["Background Texture"] = "배경 텍스쳐"
	L["Bar"] = "바"
	L["Bar Alpha"] = "바 투명도"
	L["Bar Color"] = "바 색상"
	L["Bar Color Settings"] = "바 색상 설정"
	--[[Translation missing --]]
	L["Bar Inner"] = "Bar Inner"
	L["Bar Texture"] = "바 텍스쳐"
	L["Big Icon"] = "큰 아이콘"
	--[[Translation missing --]]
	L["Blacklisted Aura Name"] = "Blacklisted Aura Name"
	--[[Translation missing --]]
	L["Blacklisted Exact Spell ID(s)"] = "Blacklisted Exact Spell ID(s)"
	--[[Translation missing --]]
	L["Blacklisted Name(s)"] = "Blacklisted Name(s)"
	--[[Translation missing --]]
	L["Blacklisted Spell ID"] = "Blacklisted Spell ID"
	L["Blend Mode"] = "혼합 모드"
	L["Blue Rune"] = "푸른색 룬"
	L["Blue Sparkle Orb"] = "푸른 불꽃 구슬"
	L["Border"] = "테두리"
	L["Border %s"] = "테두리 %s"
	--[[Translation missing --]]
	L["Border Anchor"] = "Border Anchor"
	L["Border Color"] = "테두리 색상"
	--[[Translation missing --]]
	L["Border in Front"] = "Border in Front"
	L["Border Inset"] = "테두리 삽입"
	L["Border Offset"] = "테두리 위치"
	L["Border Settings"] = "테두리 설정"
	L["Border Size"] = "테두리 크기"
	L["Border Style"] = "테두리 모양"
	L["Bottom"] = "아래"
	L["Bottom Left"] = "왼쪽 아래"
	L["Bottom Right"] = "오른쪽 아래"
	L["Bracket Matching"] = "괄호 맞춤"
	L["Can be a Name or a Unit ID (e.g. party1). A name only works on friendly players in your group."] = "이름 또는 UID (예. party1)를 사용할 수 있습니다. 이름은 같은 파티에 속해 있는 우호적 플레이어에게만 작동합니다."
	--[[Translation missing --]]
	L["Can be a UID (e.g., party1)."] = "Can be a UID (e.g., party1)."
	L["Cancel"] = "취소"
	L["Center"] = "중앙"
	L["Channel Number"] = "채널 번호"
	L["Chat Message"] = "대화 메시지"
	L["Check On..."] = "확인..."
	L["Children:"] = "자식:"
	L["Choose"] = "선택"
	L["Choose Trigger"] = "활성 조건 선택"
	L["Choose whether the displayed icon is automatic or defined manually"] = "아이콘을 자동으로 표시할 지 또는 수동 지정할 지 선택하세요"
	--[[Translation missing --]]
	L["Class"] = "Class"
	--[[Translation missing --]]
	L["Clip Overlays"] = "Clip Overlays"
	--[[Translation missing --]]
	L["Clipped by Progress"] = "Clipped by Progress"
	L["Clone option enabled dialog"] = [=[
|cFFFF0000자동복제|r 옵션을 활성화 했습니다.

|cFFFF0000자동복제|r는 디스플레이를 자동으로 복사하여 여러 정보를 표시하게 합니다.
이 디스플레이를 |cFF22AA22유동적 그룹|r에 넣을 때까지, 복제된 모든 디스플레이가 표시됩니다.

이 디스플레이를 새로운 |cFF22AA22유동적 그룹|r으로 옮길까요?]=]
	L["Close"] = "닫기"
	L["Collapse"] = "접기"
	L["Collapse all loaded displays"] = "불러온 모든 디스플레이 접기"
	L["Collapse all non-loaded displays"] = "불러오지 않은 모든 디스플레이 접기"
	--[[Translation missing --]]
	L["Collapsible Group"] = "Collapsible Group"
	L["color"] = "색상"
	L["Color"] = "색상"
	--[[Translation missing --]]
	L["Column Height"] = "Column Height"
	--[[Translation missing --]]
	L["Column Space"] = "Column Space"
	L["Combinations"] = "조합"
	--[[Translation missing --]]
	L["Combine Matches Per Unit"] = "Combine Matches Per Unit"
	L["Common Text"] = "공통 문자"
	--[[Translation missing --]]
	L["Compare against the number of units affected."] = "Compare against the number of units affected."
	L["Compress"] = "누르기"
	L["Condition %i"] = "조건 %i"
	L["Conditions"] = "조건"
	--[[Translation missing --]]
	L["Configure what options appear on this panel."] = "Configure what options appear on this panel."
	L["Constant Factor"] = "고정 요소"
	L["Control-click to select multiple displays"] = "Ctrl+클릭 - 여러 디스플레이 선택"
	L["Controls the positioning and configuration of multiple displays at the same time"] = "동시에 여러 디스플레이의 위치와 설정을 조절합니다"
	L["Convert to New Aura Trigger"] = "신규 방식 효과 활성 조건으로 변환"
	L["Convert to..."] = "변환하기..."
	L["Cooldown Edge"] = "재사용 대기시간 경계"
	L["Cooldown Settings"] = "재사용 대기시간 설정"
	L["Cooldown Swipe"] = "재사용 대기시간 바늘"
	L["Copy"] = "복사"
	L["Copy settings..."] = "설정 복사..."
	L["Copy to all auras"] = "모든 효과에 복사"
	L["Copy URL"] = "URL 복사"
	L["Count"] = "횟수"
	L["Counts the number of matches over all units."] = "모든 유닛에 대해 일치 횟수를 계산합니다."
	L["Creating buttons: "] = "버튼 생성:"
	L["Creating options: "] = "옵션 생성:"
	L["Crop X"] = "X 자르기"
	L["Crop Y"] = "Y 자르기"
	L["Custom"] = "사용자 설정"
	--[[Translation missing --]]
	L["Custom Anchor"] = "Custom Anchor"
	L["Custom Code"] = "사용자 정의 코드"
	L["Custom Color"] = "사용자 설정 색상"
	L["Custom Configuration"] = "사용자 설정 구성"
	--[[Translation missing --]]
	L["Custom Frames"] = "Custom Frames"
	L["Custom Function"] = "사용자 설정 함수"
	L["Custom Grow"] = "사용자 설정 반짝임"
	L["Custom Options"] = "사용자 설정 옵션"
	L["Custom Sort"] = "사용자 설정 정렬"
	L["Custom Trigger"] = "사용자 설정 활성 조건"
	L["Custom trigger event tooltip"] = [=[
사용자 설정 활성 조건을 확인할 이벤트를 선택하세요.
콤마와 공백을 사용해 여러 이벤트를 선택할 수 있습니다.

|cFF4444FF예제:|r
UNIT_POWER, UNIT_AURA PLAYER_TARGET_CHANGED]=]
	L["Custom trigger status tooltip"] = [=[
사용자 설정 활성 조건을 확인할 이벤트를 선택하세요.
상태 형식 조건이면 특정 이벤트는 독립 변수없이 WeakAuras에 의해 불러와집니다.
콤마와 공백을 사용해 여러 이벤트를 선택할 수 있습니다.

|cFF4444FF예제:|r
UNIT_POWER, UNIT_AURA PLAYER_TARGET_CHANGED]=]
	L["Custom Untrigger"] = "사용자 설정 비활성 조건"
	L["Custom Variables"] = "사용자 설정 변수"
	L["Debuff Type"] = "약화 효과 유형"
	L["Default"] = "기본"
	L["Default Color"] = "기본 색상"
	L["Delete"] = "삭제"
	L["Delete all"] = "모두 삭제"
	L["Delete children and group"] = "자식과 그룹 삭제"
	L["Delete Entry"] = "항목 삭제"
	L["Delete Trigger"] = "활성 조건 삭제"
	L["Desaturate"] = "흑백"
	--[[Translation missing --]]
	L["Description Text"] = "Description Text"
	--[[Translation missing --]]
	L["Determines how many entries can be in the table."] = "Determines how many entries can be in the table."
	--[[Translation missing --]]
	L["Differences"] = "Differences"
	L["Disabled"] = "비활성화됨"
	--[[Translation missing --]]
	L["Disallow Entry Reordering"] = "Disallow Entry Reordering"
	L["Discrete Rotation"] = "90도 단위 회전"
	L["Display"] = "디스플레이"
	L["Display Icon"] = "디스플레이 아이콘"
	L["Display Name"] = "디스플레이 이름"
	L["Display Text"] = "디스플레이 문자"
	L["Displays a text, works best in combination with other displays"] = "문자를 표시합니다, 다른 디스플레이와 조합하여 사용하기 좋습니다"
	L["Distribute Horizontally"] = "가로로 퍼뜨리기"
	L["Distribute Vertically"] = "세로로 퍼뜨리기"
	L["Do not group this display"] = "이 디스플레이 그룹하지 않기"
	L["Done"] = "완료"
	L["Don't skip this Version"] = "이 버전을 건너 뛰지 마십시오."
	L["Down"] = "아래로"
	L["Drag to move"] = "끌기 - 이동"
	L["Duplicate"] = "복제"
	L["Duplicate All"] = "모두 복제"
	L["Duration (s)"] = "지속시간 (초)"
	L["Duration Info"] = "지속시간 정보"
	--[[Translation missing --]]
	L["Dynamic Duration"] = "Dynamic Duration"
	L["Dynamic Group"] = "유동적 그룹"
	L["Dynamic Group Settings"] = "유동적 그룹 셋팅"
	L["Dynamic Information"] = "유동적 정보"
	L["Dynamic information from first active trigger"] = "첫번째 활성화된 활성 조건의 유동적 정보"
	L["Dynamic information from Trigger %i"] = "활성 조건 %i의 유동적 정보"
	L["Dynamic text tooltip"] = [=[이 문자를 유동적으로 만들 수 있는 특별 코드들입니다:

|cFFFF0000%p|r - 진행 - 타이머의 남은 시간, 또는 비-타이머 값
|cFFFF0000%t|r - 전체 - 타이머의 최대 지속시간, 또는 최대 비-타이머 값
|cFFFF0000%n|r - 이름 - 디스플레이의 이름 (보통 오라 이름), 또는 유동적 이름이 없을 때 디스플레이의 ID
|cFFFF0000%i|r - 아이콘 - 디스플레이와 연관된 아이콘
|cFFFF0000%s|r - 중첩 - 오라의 중첩 횟수 (보통)
|cFFFF0000%c|r - 사용자 설정 - 표시할 string 값을 반환하는 사용자 설정 Lua 함수 정의를 허용합니다]=]
	--[[Translation missing --]]
	L["Ease Strength"] = "Ease Strength"
	--[[Translation missing --]]
	L["Ease type"] = "Ease type"
	--[[Translation missing --]]
	L["Edge"] = "Edge"
	--[[Translation missing --]]
	L["eliding"] = "eliding"
	L["Enabled"] = "활성화됨"
	L["End Angle"] = "종료 각도"
	--[[Translation missing --]]
	L["End of %s"] = "End of %s"
	L["Enter a Spell ID"] = "주문 ID 입력"
	L["Enter an aura name, partial aura name, or spell id"] = "효과 이름 / 효과 이름의 일부 / 주문 ID를 입력하세요"
	--[[Translation missing --]]
	L["Enter an Aura Name, partial Aura Name, or Spell ID. A Spell ID will match any spells with the same name."] = "Enter an Aura Name, partial Aura Name, or Spell ID. A Spell ID will match any spells with the same name."
	--[[Translation missing --]]
	L["Enter Author Mode"] = "Enter Author Mode"
	L["Enter User Mode"] = "사용자 모드 시작"
	L["Enter user mode."] = "사용자 모드를 시작합니다."
	L["Entry %i"] = "항목 %i"
	--[[Translation missing --]]
	L["Entry limit"] = "Entry limit"
	--[[Translation missing --]]
	L["Entry Name Source"] = "Entry Name Source"
	L["Event"] = "이벤트"
	L["Event Type"] = "이벤트 유형"
	L["Event(s)"] = "이벤트"
	L["Everything"] = "모두"
	L["Exact Spell ID(s)"] = "정확한 주문 ID"
	--[[Translation missing --]]
	L["Exact Spell Match"] = "Exact Spell Match"
	L["Expand"] = "확장"
	L["Expand all loaded displays"] = "불러온 모든 디스플레이 확장"
	L["Expand all non-loaded displays"] = "불러오지 않은 모드 디스플레이 확장"
	L["Expansion is disabled because this group has no children"] = "이 그룹에 자식이 없어 확장이 비활성되었습니다"
	L["Export to Lua table..."] = "Lua table로 내보내기..."
	L["Export to string..."] = "문자열로 내보내기..."
	L["External"] = "외부"
	L["Fade"] = "사라짐"
	L["Fade In"] = "서서히 나타남"
	L["Fade Out"] = "서서히 사라짐"
	L["False"] = "거짓"
	--[[Translation missing --]]
	L["Fetch Affected/Unaffected Names"] = "Fetch Affected/Unaffected Names"
	--[[Translation missing --]]
	L["Filter by Class"] = "Filter by Class"
	--[[Translation missing --]]
	L["Filter by Group Role"] = "Filter by Group Role"
	L["Finish"] = "종료"
	L["Fire Orb"] = "화염 구슬"
	L["Font"] = "글꼴"
	L["Font Size"] = "글꼴 크기"
	--[[Translation missing --]]
	L["Foreground"] = "Foreground"
	L["Foreground Color"] = "전경 색상"
	L["Foreground Texture"] = "전경 텍스쳐"
	L["Frame"] = "프레임"
	--[[Translation missing --]]
	L["Frame Selector"] = "Frame Selector"
	L["Frame Strata"] = "프레임 우선순위"
	--[[Translation missing --]]
	L["Frequency"] = "Frequency"
	L["From Template"] = "견본으로부터"
	--[[Translation missing --]]
	L["From version %s to version %s"] = "From version %s to version %s"
	L["Global Conditions"] = "전역 조건"
	L["Glow %s"] = "반짝임 %s"
	L["Glow Action"] = "반짝임 동작"
	--[[Translation missing --]]
	L["Glow Anchor"] = "Glow Anchor"
	L["Glow Color"] = "반짝임 색상"
	--[[Translation missing --]]
	L["Glow External Element"] = "Glow External Element"
	--[[Translation missing --]]
	L["Glow Frame Type"] = "Glow Frame Type"
	L["Glow Type"] = "반짝임 유형"
	L["Green Rune"] = "녹색 룬"
	--[[Translation missing --]]
	L["Grid direction"] = "Grid direction"
	L["Group"] = "그룹"
	L["Group (verb)"] = "그룹시키기"
	L["Group aura count description"] = [=[디스플레이 조건을 충족하기 위해 주어진 효과에 영향을 받는 한명 이상의 %s원의 숫자.
정수를 입력하면 (예. 5), 영향을 받는 공격대원의 숫자를 입력된 숫자와 비교합니다.
소수 (예. 0.5), 분수 (예. 1/2), 또는 백분율 (예. 50%%)을 입력하면, %s원 중 일부가 영향을 받아야 합니다.

|cFF4444FF예제:|r
|cFF00CC00> 0|r %s 중 아무나 영향 받을 때 발생
|cFF00CC00= 100%%|r %s 중 모두가 영향 받을 때 발생
|cFF00CC00!= 2|r 영향 받는 %s원의 숫자가 2가 아닐 때 발생
|cFF00CC00<= 0.8|r %s 중 80%% 이하가 영향 받을 때 발생 (5명 파티원중 4명, 10명 공격대원 중 8명 또는 25명 공격대원중 20명)
|cFF00CC00> 1/2|r %s의 절반 이상이 영향 받을 때 발생
|cFF00CC00>= 0|r 상관없이, 항상 발생]=]
	--[[Translation missing --]]
	L["Group by Frame"] = "Group by Frame"
	--[[Translation missing --]]
	L["Group contains updates from Wago"] = "Group contains updates from Wago"
	L["Group Icon"] = "그룹 아이콘"
	--[[Translation missing --]]
	L["Group key"] = "Group key"
	L["Group Member Count"] = "그룹원 수"
	L["Group Role"] = "그룹 역할"
	L["Group Scale"] = "그룹 크기 비율"
	L["Group Settings"] = "그룹 설정"
	L["Group Type"] = "그룹 유형"
	L["Grow"] = "성장"
	L["Hawk"] = "매"
	L["Height"] = "높이"
	--[[Translation missing --]]
	L["Help"] = "Help"
	L["Hide"] = "숨기기"
	L["Hide Cooldown Text"] = "재사용 대기시간 문자 숨기기"
	--[[Translation missing --]]
	L["Hide Glows applied by this aura"] = "Hide Glows applied by this aura"
	L["Hide on"] = "숨기기"
	L["Hide this group's children"] = "이 그룹의 자식 숨기기"
	L["Hide When Not In Group"] = "파티에 없을 때 숨기기"
	L["Horizontal Align"] = "가로 정렬"
	L["Horizontal Bar"] = "가로 바"
	L["Huge Icon"] = "거대한 아이콘"
	L["Hybrid Position"] = "복합 위치"
	L["Hybrid Sort Mode"] = "복합 정렬 모드"
	L["Icon"] = "아이콘"
	L["Icon Info"] = "아이콘 정보"
	L["Icon Inset"] = "아이템 축소"
	L["Icon Position"] = "아이콘 위치"
	L["Icon Settings"] = "아이콘 설정"
	--[[Translation missing --]]
	L["If"] = "If"
	--[[Translation missing --]]
	L["If checked, then the user will see a multi line edit box. This is useful for inputting large amounts of text."] = "If checked, then the user will see a multi line edit box. This is useful for inputting large amounts of text."
	--[[Translation missing --]]
	L["If checked, then this option group can be temporarily collapsed by the user."] = "If checked, then this option group can be temporarily collapsed by the user."
	--[[Translation missing --]]
	L["If checked, then this option group will start collapsed."] = "If checked, then this option group will start collapsed."
	--[[Translation missing --]]
	L["If checked, then this separator will include text. Otherwise, it will be just a horizontal line."] = "If checked, then this separator will include text. Otherwise, it will be just a horizontal line."
	--[[Translation missing --]]
	L["If checked, then this separator will not merge with other separators when selecting multiple auras."] = "If checked, then this separator will not merge with other separators when selecting multiple auras."
	--[[Translation missing --]]
	L["If checked, then this space will span across multiple lines."] = "If checked, then this space will span across multiple lines."
	--[[Translation missing --]]
	L["If Trigger %s"] = "If Trigger %s"
	L["If unchecked, then a default color will be used (usually yellow)"] = "체크하지 않으면 기본 색상(보통 노란색)이 사용됩니다."
	--[[Translation missing --]]
	L["If unchecked, then this space will fill the entire line it is on in User Mode."] = "If unchecked, then this space will fill the entire line it is on in User Mode."
	--[[Translation missing --]]
	L["Ignore all Updates"] = "Ignore all Updates"
	--[[Translation missing --]]
	L["Ignore Self"] = "Ignore Self"
	--[[Translation missing --]]
	L["Ignore self"] = "Ignore self"
	L["Ignored"] = "무시됨"
	L["Import"] = "가져오기"
	L["Import a display from an encoded string"] = "암호화된 문자열에서 디스플레이 가져오기"
	--[[Translation missing --]]
	L["Inner"] = "Inner"
	L["Invalid Item Name/ID/Link"] = "잘못된 아이템 이름/ID/링크"
	L["Invalid Spell ID"] = "잘못된 주문 ID"
	L["Invalid Spell Name/ID/Link"] = "잘못된 주문 이름/ID/링크"
	L["Inverse"] = "반대로"
	L["Inverse Slant"] = "역 경사"
	L["Is Stealable"] = "훔치기 가능할 때"
	L["Justify"] = "정렬"
	L["Keep Aspect Ratio"] = "종횡비 유지"
	--[[Translation missing --]]
	L["Large Input"] = "Large Input"
	L["Leaf"] = "잎"
	--[[Translation missing --]]
	L["Left"] = "Left"
	L["Left 2 HUD position"] = "좌측 2 HUD 위치"
	L["Left HUD position"] = "좌측 HUD 위치"
	L["Legacy Aura Trigger"] = "v2.9.0 이전 효과 활성 조건"
	L["Length"] = "길이"
	--[[Translation missing --]]
	L["Limit"] = "Limit"
	--[[Translation missing --]]
	L["Lines & Particles"] = "Lines & Particles"
	L["Load"] = "불러오기"
	L["Loaded"] = "불러옴"
	L["Loop"] = "반복"
	L["Low Mana"] = "마나 낮음"
	L["Magnetically Align"] = "자석 정렬"
	L["Main"] = "메인"
	L["Manage displays defined by Addons"] = "애드온에 의해 정의된 디스플레이 관리"
	L["Match Count"] = "일치 횟수"
	L["Max"] = "최대"
	L["Max Length"] = "최대 길이"
	L["Medium Icon"] = "보통 아이콘"
	L["Message"] = "메시지"
	L["Message Prefix"] = "메시지 접두사"
	L["Message Suffix"] = "메시지 접미사"
	L["Message Type"] = "메시지 유형"
	--[[Translation missing --]]
	L["Min"] = "Min"
	L["Mirror"] = "뒤집기"
	L["Model"] = "모델"
	--[[Translation missing --]]
	L["Model %s"] = "Model %s"
	L["Model Settings"] = "모델 설정"
	--[[Translation missing --]]
	L["Move Above Group"] = "Move Above Group"
	--[[Translation missing --]]
	L["Move Below Group"] = "Move Below Group"
	L["Move Down"] = "아래로 이동"
	--[[Translation missing --]]
	L["Move Entry Down"] = "Move Entry Down"
	--[[Translation missing --]]
	L["Move Entry Up"] = "Move Entry Up"
	--[[Translation missing --]]
	L["Move Into Above Group"] = "Move Into Above Group"
	--[[Translation missing --]]
	L["Move Into Below Group"] = "Move Into Below Group"
	L["Move this display down in its group's order"] = "이 디스플레이를 그룹 내 순서에서 아래로 이동"
	L["Move this display up in its group's order"] = "이 디스플레이를 그룹 내 순서에서 위로 이동"
	L["Move Up"] = "위로 이동"
	L["Multiple Displays"] = "다중 디스플레이"
	L["Multiple Triggers"] = "다중 활성 조건"
	L["Multiselect ignored tooltip"] = [=[
|cFFFF0000무시|r - |cFF777777단일|r - |cFF777777다중|r
디스플레이를 불러오는 데 영향을 주지 않습니다]=]
	L["Multiselect multiple tooltip"] = [=[
|cFF777777무시|r - |cFF777777단일|r - |cFF00FF00다중|r
선택한 것중 하나라도 일치할 때 불러옵니다]=]
	L["Multiselect single tooltip"] = [=[
|cFF777777무시|r - |cFF00FF00단일|r - |cFF777777다중|r
선택한 한가지만 일치할 때 불러옴]=]
	L["Name Info"] = "이름 정보"
	L["Name Pattern Match"] = "이름 패턴 일치"
	L["Name(s)"] = "이름(s)"
	--[[Translation missing --]]
	L["Negator"] = "Not"
	L["Never"] = "절대 안함"
	L["New Aura"] = "새 효과"
	L["New Value"] = "새 값"
	L["No"] = "아니오"
	L["No Children"] = "자식 없음"
	L["No tooltip text"] = "툴팁 문자 없음"
	L["None"] = "없음"
	L["Not all children have the same value for this option"] = "모든 자식의 이 옵션 값이 같지 않습니다"
	L["Not Loaded"] = "불러오지 않음"
	--[[Translation missing --]]
	L["Note: Automated Messages to SAY and YELL are blocked outside of Instances."] = "Note: Automated Messages to SAY and YELL are blocked outside of Instances."
	--[[Translation missing --]]
	L["Number of Entries"] = "Number of Entries"
	--[[Translation missing --]]
	L["Offer a guided way to create auras for your character"] = "Offer a guided way to create auras for your character"
	L["Okay"] = "확인"
	L["On Hide"] = "숨겨질 때"
	L["On Init"] = "초기 실행 시"
	L["On Show"] = "표시될 때"
	L["Only match auras cast by people other than the player"] = "플레이어가 아닌 다른 사람이 시전한 효과와 일치할 때만"
	L["Only match auras cast by people other than the player or his pet"] = "플레이어나 소환수 이외의 사람들이 시전한 효과와 일치할 때만"
	L["Only match auras cast by the player"] = "플레이어가 시전한 효과와 일치할 때만"
	L["Only match auras cast by the player or his pet"] = "플레이어나 소환수가 시전한 효과와 일치할 때만"
	L["Operator"] = "연산자"
	L["Option %i"] = "옵션 %i"
	L["Option key"] = "옵션 키"
	L["Option Type"] = "옵션 종류"
	L["Options will open after combat ends."] = "전투가 끝난 후 옵션이 열립니다."
	L["or"] = "혹은"
	--[[Translation missing --]]
	L["or Trigger %s"] = "or Trigger %s"
	L["Orange Rune"] = "오렌지색 룬"
	L["Orientation"] = "방향"
	--[[Translation missing --]]
	L["Outer"] = "Outer"
	L["Outline"] = "외곽선"
	--[[Translation missing --]]
	L["Overflow"] = "Overflow"
	L["Overlay %s Info"] = "오버레이 %s 정보"
	L["Overlays"] = "오버레이"
	L["Own Only"] = "내 것만"
	L["Paste Action Settings"] = "동작 설정 붙여넣기"
	L["Paste Animations Settings"] = "애니메이션 설정 붙여넣기"
	--[[Translation missing --]]
	L["Paste Author Options Settings"] = "Paste Author Options Settings"
	L["Paste Condition Settings"] = "조건 설정 붙여넣기"
	--[[Translation missing --]]
	L["Paste Custom Configuration"] = "Paste Custom Configuration"
	L["Paste Display Settings"] = "디스플레이 설정 붙여넣기"
	L["Paste Group Settings"] = "그룹 설정 붙여넣기"
	L["Paste Load Settings"] = "불러오기 설정 붙여넣기"
	L["Paste Settings"] = "붙여넣기 설정"
	L["Paste text below"] = "아래에 문자를 붙여 넣으세요."
	L["Paste Trigger Settings"] = "활성 조건 설정 붙여넣기"
	L["Play Sound"] = "소리 재생"
	L["Position Settings"] = "자리 설정"
	--[[Translation missing --]]
	L["Preferred Match"] = "Preferred Match"
	L["Preset"] = "프리셋"
	--[[Translation missing --]]
	L["Press Ctrl+C to copy"] = "Press Ctrl+C to copy"
	--[[Translation missing --]]
	L["Prevent Merging"] = "Prevent Merging"
	L["Processed %i chars"] = "%i 문자 복사됨"
	L["Progress Bar"] = "진행 바"
	L["Progress Bar Settings"] = "진행 바 설정"
	L["Progress Texture"] = "진행 텍스쳐"
	L["Progress Texture Settings"] = "진행 텍스쳐 설정"
	L["Purple Rune"] = "보라색 룬"
	L["Put this display in a group"] = "이 디스플레이를 그룹에 넣기"
	L["Radius"] = "반경"
	L["Re-center X"] = "내부 X 좌표"
	L["Re-center Y"] = "내부 Y 좌표"
	--[[Translation missing --]]
	L["Regions of type \"%s\" are not supported."] = "Regions of type \"%s\" are not supported."
	L["Remaining Time"] = "남은 시간"
	L["Remaining Time Precision"] = "남은 시간 정밀도"
	L["Remove"] = "제거"
	L["Remove this display from its group"] = "이 디스플레이를 그룹에서 제거하기"
	L["Remove this property"] = "이 속성 제거"
	L["Rename"] = "이름 변경"
	L["Repeat After"] = "반복 횟수"
	--[[Translation missing --]]
	L["Repeat every"] = "Repeat every"
	--[[Translation missing --]]
	L["Require unit from trigger"] = "Require unit from trigger"
	L["Required for Activation"] = "활성화에 필요"
	L["Reset all options to their default values."] = "모든 옵션을 기본값으로 재설정하십시오."
	--[[Translation missing --]]
	L["Reset Entry"] = "Reset Entry"
	L["Reset to Defaults"] = "기본값으로 재설정"
	--[[Translation missing --]]
	L["Right"] = "Right"
	L["Right 2 HUD position"] = "우측 2 HUD 위치"
	L["Right HUD position"] = "우측 HUD 위치"
	L["Right-click for more options"] = "우클릭 - 추가 옵션"
	L["Rotate"] = "회전"
	L["Rotate In"] = "시계방향 회전"
	L["Rotate Out"] = "반시계방향 회전"
	L["Rotate Text"] = "문자 회전"
	L["Rotation"] = "회전"
	L["Rotation Mode"] = "회전 모드"
	--[[Translation missing --]]
	L["Row Space"] = "Row Space"
	--[[Translation missing --]]
	L["Row Width"] = "Row Width"
	L["Same"] = "동일한"
	L["Scale"] = "크기 비율"
	L["Search"] = "검색"
	L["Select the auras you always want to be listed first"] = "목록에서 첫번째로 표시할 오라를 선택하세요"
	L["Send To"] = "보내기..."
	--[[Translation missing --]]
	L["Separator Text"] = "Separator Text"
	--[[Translation missing --]]
	L["Separator text"] = "Separator text"
	L["Set Parent to Anchor"] = "부모를 고정기로 설정"
	--[[Translation missing --]]
	L["Set Thumbnail Icon"] = "Set Thumbnail Icon"
	L["Set tooltip description"] = "툴팁 설명 설정"
	--[[Translation missing --]]
	L["Sets the anchored frame as the aura's parent, causing the aura to inherit attributes such as visiblility and scale."] = "Sets the anchored frame as the aura's parent, causing the aura to inherit attributes such as visiblility and scale."
	L["Settings"] = "설정"
	L["Shadow Color"] = "그림자 색상"
	L["Shadow X Offset"] = "그림자 X 좌표"
	L["Shadow Y Offset"] = "그림자 Y 좌표"
	L["Shift-click to create chat link"] = "Shift+클릭 - 대화 링크 만들기"
	L["Show all matches (Auto-clone)"] = "모든 일치 표시 (자동 복제)"
	L["Show Border"] = "테두리 표시"
	L["Show Cooldown"] = "재사용 대기시간 표시"
	L["Show Glow"] = "반짝임 표시"
	L["Show Icon"] = "아이콘 표시"
	L["Show If Unit Does Not Exist"] = "유닛이 존재하지 않는 경우 표시"
	L["Show If Unit Is Invalid"] = "유닛이 유효하지 않은 경우 표시"
	L["Show Matches for"] = "일치 항목 표시"
	--[[Translation missing --]]
	L["Show Matches for Units"] = "Show Matches for Units"
	L["Show Model"] = "모델 표시"
	L["Show model of unit "] = "유닛의 모델 표시"
	--[[Translation missing --]]
	L["Show On"] = "Show On"
	L["Show Spark"] = "섬광 표시"
	L["Show Text"] = "문자 표시"
	L["Show this group's children"] = "이 그룹의 자식 표시"
	L["Shows a 3D model from the game files"] = "게임 데이터의 3D 모델을 표시합니다"
	--[[Translation missing --]]
	L["Shows a border"] = "Shows a border"
	L["Shows a custom texture"] = "사용자 설정 텍스쳐 표시"
	--[[Translation missing --]]
	L["Shows a glow"] = "Shows a glow"
	--[[Translation missing --]]
	L["Shows a model"] = "Shows a model"
	L["Shows a progress bar with name, timer, and icon"] = "이름, 타이머, 아이콘과 함께 진행 바를 표시합니다"
	L["Shows a spell icon with an optional cooldown overlay"] = "재사용 대기시간 오버레이와 함께 주문 아이콘을 표시합니다"
	L["Shows a texture that changes based on duration"] = "지속시간에 따라 변화하는 텍스쳐를 표시합니다"
	L["Shows one or more lines of text, which can include dynamic information such as progress or stacks"] = "여러 줄의 문자를 표시합니다, 진행 시간 또는 중첩과 같은 여러 정보를 포함할 수 있습니다"
	L["Simple"] = "단순"
	L["Size"] = "크기"
	--[[Translation missing --]]
	L["Skip this Version"] = "Skip this Version"
	L["Slant Amount"] = "기울기 양"
	L["Slant Mode"] = "기울기 모드"
	L["Slanted"] = "기울임"
	L["Slide"] = "슬라이드"
	L["Slide In"] = "안으로 슬라이드"
	L["Slide Out"] = "바깥으로 슬라이드"
	--[[Translation missing --]]
	L["Slider Step Size"] = "Slider Step Size"
	L["Small Icon"] = "작은 아이콘"
	L["Smooth Progress"] = "부드러운 진행"
	--[[Translation missing --]]
	L["Soft Max"] = "Soft Max"
	--[[Translation missing --]]
	L["Soft Min"] = "Soft Min"
	L["Sort"] = "정렬"
	L["Sound"] = "소리"
	L["Sound Channel"] = "소리 채널"
	L["Sound File Path"] = "소리 파일 경로"
	L["Sound Kit ID"] = "소리 Kit ID"
	L["Space"] = "공간"
	L["Space Horizontally"] = "수평 공간"
	L["Space Vertically"] = "수직 공간"
	L["Spark"] = "섬광"
	L["Spark Settings"] = "섬광 설정"
	L["Spark Texture"] = "섬광 텍스쳐"
	L["Specific Unit"] = "특정 유닛"
	L["Spell ID"] = "주문 ID"
	L["Stack Count"] = "중첩 횟수"
	L["Stack Info"] = "중첩 정보"
	L["Stagger"] = "계단식 배치"
	L["Star"] = "별"
	L["Start"] = "시작"
	L["Start Angle"] = "시작 각도"
	--[[Translation missing --]]
	L["Start Collapsed"] = "Start Collapsed"
	--[[Translation missing --]]
	L["Start of %s"] = "Start of %s"
	L["Status"] = "상태"
	L["Stealable"] = "훔치기 가능"
	--[[Translation missing --]]
	L["Step Size"] = "Step Size"
	--[[Translation missing --]]
	L["Stop ignoring Updates"] = "Stop ignoring Updates"
	L["Stop Sound"] = "소리 중지"
	L["Sub Elements"] = "하위 요소"
	L["Sub Option %i"] = "하위 옵션 %i"
	L["Temporary Group"] = "임시 그룹"
	L["Text"] = "문자"
	L["Text %s"] = "문자 %s"
	L["Text Color"] = "문자 색상"
	L["Text Settings"] = "문자 설정"
	L["Texture"] = "텍스쳐"
	L["Texture Info"] = "텍스쳐 정보"
	L["Texture Settings"] = "텍스쳐 설정"
	L["Texture Wrap"] = "텍스쳐 줄바꿈"
	L["The duration of the animation in seconds."] = "애니메이션 지속시간 (초)"
	--[[Translation missing --]]
	L["The duration of the animation in seconds. The finish animation does not start playing until after the display would normally be hidden."] = "The duration of the animation in seconds. The finish animation does not start playing until after the display would normally be hidden."
	L["The type of trigger"] = "활성 조건의 유형"
	--[[Translation missing --]]
	L["Then "] = "Then "
	--[[Translation missing --]]
	L["Thickness"] = "Thickness"
	--[[Translation missing --]]
	L["This adds %tooltip, %tooltip1, %tooltip2, %tooltip3 as text replacements."] = "This adds %tooltip, %tooltip1, %tooltip2, %tooltip3 as text replacements."
	--[[Translation missing --]]
	L["This aura has legacy aura trigger(s). Convert them to the new system to benefit from enhanced performance and features"] = "This aura has legacy aura trigger(s). Convert them to the new system to benefit from enhanced performance and features"
	L["This display is currently loaded"] = "이 디스플레이는 불러온 상태입니다"
	L["This display is not currently loaded"] = "이 디스플레이는 불러오지 않았습니다"
	L["This region of type \"%s\" is not supported."] = "이 영역은 \"%s\" 유형을 지원하지 않습니다."
	L["This setting controls what widget is generated in user mode."] = "이 설정은 사용자 모드에서 생성된 위젯을 제어합니다."
	L["Time in"] = "시간 단위"
	L["Tiny Icon"] = "더 작은 아이콘"
	L["To Frame's"] = "프레임의 다음 지점:"
	--[[Translation missing --]]
	L["To Group's"] = "To Group's"
	L["To Personal Ressource Display's"] = "개인 자원 표시의 다음 지점:"
	L["To Screen's"] = "화면의 다음 지점:"
	L["Toggle the visibility of all loaded displays"] = "불러온 모든 디스플레이 표시 전환"
	L["Toggle the visibility of all non-loaded displays"] = "불러오지 않은 모든 디스플레이 표시 토글"
	L["Toggle the visibility of this display"] = "이 디스플레이의 표시 전환"
	L["Tooltip"] = "툴팁"
	L["Tooltip Content"] = "툴팁 내용"
	L["Tooltip on Mouseover"] = "마우스오버 툴팁"
	L["Tooltip Pattern Match"] = "툴팁 패턴 일치"
	L["Tooltip Text"] = "툴팁 문자"
	L["Tooltip Value"] = "툴팁 값"
	L["Tooltip Value #"] = "툴팁 값 #"
	L["Top"] = "위"
	L["Top HUD position"] = "상단 HUD 위치"
	L["Top Left"] = "왼쪽 위"
	L["Top Right"] = "오른쪽 위"
	L["Total Time"] = "전체 시간"
	L["Total Time Precision"] = "전체 시간 정밀도"
	L["Trigger"] = "활성 조건"
	L["Trigger %d"] = "%d 활성 조건"
	L["Trigger %s"] = "활성 조건 %s"
	L["True"] = "참"
	L["Type"] = "유형"
	L["Ungroup"] = "그룹 해제"
	L["Unit"] = "유닛"
	--[[Translation missing --]]
	L["Unit %s is not a valid unit for RegisterUnitEvent"] = "Unit %s is not a valid unit for RegisterUnitEvent"
	L["Unit Count"] = "유닛 수"
	--[[Translation missing --]]
	L["Unit Frame"] = "Unit Frame"
	--[[Translation missing --]]
	L["Unit Frames"] = "Unit Frames"
	L["Unlike the start or finish animations, the main animation will loop over and over until the display is hidden."] = "시작 또는 종료 애니메이션과 달리 메인 애니메이션은 디스플레이가 숨겨질 때까지 계속 반복됩니다."
	L["Up"] = "위로"
	--[[Translation missing --]]
	L["Update %s by %s"] = "Update %s by %s"
	L["Update Custom Text On..."] = "사용자 설정 문자 갱신 중..."
	--[[Translation missing --]]
	L["Update in Group"] = "Update in Group"
	--[[Translation missing --]]
	L["Update this Aura"] = "Update this Aura"
	L["Use Custom Color"] = "사용자 설정 색상 사용"
	--[[Translation missing --]]
	L["Use Display Info Id"] = "Use Display Info Id"
	L["Use Full Scan (High CPU)"] = "전체 스캔 사용 (높은 CPU 사용률)"
	--[[Translation missing --]]
	L["Use nth value from tooltip:"] = "Use nth value from tooltip:"
	L["Use SetTransform"] = "SetTransform 사용"
	L["Use tooltip \"size\" instead of stacks"] = "중첩 대신 툴팁 \"크기\" 사용"
	L["Use Tooltip Information"] = "툴팁 정보 사용"
	L["Used in Auras:"] = "사용되는 효과:"
	L["Used in auras:"] = "사용되는 효과:"
	L["Value %i"] = "값 %i"
	--[[Translation missing --]]
	L["Values are in normalized rgba format."] = "Values are in normalized rgba format."
	L["Values:"] = "값:"
	L["Version: "] = "버전:"
	L["Vertical Align"] = "수직 정렬"
	L["Vertical Bar"] = "수직 바"
	L["View"] = "보기"
	L["Wago Update"] = "Wago 업데이트"
	L["Whole Area"] = "전체 영역"
	L["Width"] = "너비"
	--[[Translation missing --]]
	L["wrapping"] = "wrapping"
	L["X Offset"] = "X 좌표"
	L["X Rotation"] = "X 회전"
	L["X Scale"] = "가로 크기"
	L["X-Offset"] = "X-좌표"
	L["Y Offset"] = "Y 좌표"
	L["Y Rotation"] = "Y 회전"
	L["Y Scale"] = "세로 크기"
	L["Yellow Rune"] = "노란색 룬"
	L["Yes"] = "네"
	L["Y-Offset"] = "Y-좌표"
	L["You are about to delete %d aura(s). |cFFFF0000This cannot be undone!|r Would you like to continue?"] = "효과 %d개를 삭제하려고 합니다. |cFFFF0000이는 취소할 수 없습니다!|r 계속할까요?"
	L["Z Offset"] = "Z 좌표"
	L["Z Rotation"] = "Z 회전"
	L["Zoom"] = "확대"
	L["Zoom In"] = "확대"
	L["Zoom Out"] = "축소"

