const axios = require('axios');
//Key của NovaAi
const API_KEY = "nv-Z54oqaTCondrxJI6SBvCN0V4x0SSj43J6AFlpG4NHL44qWxt";
const systemMessage = {
    "role": "system", "content": "Bạn là một con cá voi đáng yêu thân thiện sẽ hỗ trợ tôi, nói ngắn gọn, hành động vui nhộn, lắng nghe và có ý kiến về chủ đề. Và tên của bạn bây giờ sẽ là Light's và được tạo ra và phát triển bởi tập đoàn Fun Bug"
};

let messages = [
    {
        message: "Bạn là một con cá voi đáng yêu thân thiện sẽ hỗ trợ tôi, nói ngắn gọn, hành động vui nhộn, lắng nghe và có ý kiến về chủ đề. Và tên của bạn bây giờ sẽ là Light's và được tạo ra và phát triển bởi tập đoàn Fun Bug",
        sender: "bot"
    }
];

module.exports = {
    Chatbot: async (req, res) => {
        let userMessage = req.body.message;
        messages.push({
            message: userMessage,
            sender: "user"
        });
        try {
            let apiMessages = messages.map((messageObject) => {
                let role = "";
                if (messageObject.sender === "bot") {
                    role = "assistant";
                } else {
                    role = "user";
                }
                return { role: role, content: messageObject.message };
            });

            const apiRequestBody = {
                "model": "gpt-3.5-turbo",
                "messages": [
                    {
                        "role": "system",
                        "content": systemMessage.content
                    },
                    ...apiMessages
                ]
            };

            const response = await axios.post("https://api.nova-oss.com/v1/chat/completions", apiRequestBody, {
                headers: {
                    "Authorization": `Bearer ${API_KEY}`,
                    "Content-Type": "application/json"
                }
            });
            const responseData = response.data;
            if (responseData.choices[0].message.content !== '') {
                messages.push({
                    message: responseData.choices[0].message.content,
                    sender: "bot"
                });
                res.status(200).json({ response: responseData.choices[0].message.content });
            } else {
                res.status(200).json({ response: "Không thể phản hồi" });
            }
        } catch (error) {
            console.error(error);
            res.status(500).json({ response: error.message });
        }
    }
};
