getgenv().decompilereal = function(scriptInstance, useBetter, customUrl)
    local HttpService = game:GetService("HttpService")
    local url = customUrl or "https://luaudecompilerai.vercel.app/api"
    local originalDecompile = decompile
    
    local success, srcScript = pcall(originalDecompile, scriptInstance)
    
    if success and useBetter then
        local requestBody = HttpService:JSONEncode({script = srcScript})
        local headers = {["Content-Type"] = "application/json"}
        
        local success, result = pcall(function()
            return HttpService:RequestAsync({
                Url = url,
                Method = "POST",
                Headers = headers,
                Body = requestBody
            })
        end)
        
        if success and result.StatusCode == 200 then
            local resultData = HttpService:JSONDecode(result.Body)
            srcScript = resultData.fixed_script
        end
    end
    
    return srcScript
end
