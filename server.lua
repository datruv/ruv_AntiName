local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")

-- 화이트리스트 이모지 ( 팩션 이모지 넣어주세요 ) --
local allowed_emoji = {"🌟", "🐣", "🎓", "👮", "🎓", "💊", "🚘", "🍀", "🐧", "🔥", "🪓", "⚔"}
-------------------------------------------------


function card_menu(name, errorMessage)
    return {
        type = "AdaptiveCard",
        ["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
        version = "1.2",
        body = {
            {
                type = "Container",
                items = {
                    {
                        type = "ColumnSet",
                        columns = {
                            {
                                type = "Column",
                                width = "stretch",
                                items = {
                                    {
                                        type = "TextBlock",
                                        text = name .. "님, " .. errorMessage,
                                        wrap = true,
                                        horizontalAlignment = "Center",
                                        size = "Medium",
                                        weight = "Bolder",
                                        color = "Attention"
                                    },
                                    {
                                        type = "TextBlock",
                                        text = "이 메세지의 지원이 필요하거나 부적절하다고 생각되는 경우 서버 디스코드에 고객센터로 문의 남겨주세요.",
                                        wrap = true,
                                        horizontalAlignment = "Center",
                                        size = "Small",
                                        color = "Warning"
                                    },
                                    {
                                        type = "TextBlock",
                                        text = "닉네임은 한글만 포함하거나, 허가된 이모지만 사용 가능합니다. ( 파이브엠 설정에서 닉네임 바꾸고 접속해주세요! )",
                                        wrap = true,
                                        horizontalAlignment = "Center",
                                        size = "Small",
                                        color = "Good"
                                    },
                                    {
                                        type = "ActionSet",
                                        actions = {
                                            {
                                                type = "Action.OpenUrl",
                                                title = "디스코드 접속하기",
                                                url = "https://discord.gg/"
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
end

AddEventHandler("playerConnecting", function(name, setMessage, deferrals)
    deferrals.defer()

    local isValid = true
    local errorMessage = ""

    if name:match("^[%a]+$") then
        isValid = false
        errorMessage = "영어로만 된 닉네임은 사용할 수 없습니다."
    else
        for char in name:gmatch(".") do
            if not char:match("[%w가-힣]") and not table.concat(allowed_emoji):find(char) then
                isValid = false
                errorMessage = "부적절한 닉네임/이모지를 사용하고 있습니다."
                break
            end
        end
    end

    if isValid then
        deferrals.done()
    else
        local card = card_menu(name, errorMessage)
        deferrals.presentCard(card)
        Wait(5000)
        deferrals.done(errorMessage)
    end
end)
