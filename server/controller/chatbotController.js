const axios = require('axios');
//Key của GPT
// const API_KEY = "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";
//Key của NovaAi
const API_KEY = "nv-Z54oqaTCondrxJI6SBvCN0V4x0SSj43J6AFlpG4NHL44qWxt";
const systemMessage = {
    "role": "system", "content": "Explain things like you're talking to a software professional with 2 years of experience."
};

let messages = [
    {
        message: "Hi",
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
            if (responseData !== '') {
                res.status(200).json({ response: responseData.choices[0].message.content });
            } else {
                res.status(200).json({ response: "Không thể phản hồi" });
            }
        } catch (error) {
            console.error(error);
            res.status(500).json({ error: error.message });
        }
    }
};
