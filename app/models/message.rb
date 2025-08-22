class Message < ApplicationRecord
  belongs_to :chat

  SYSTEM_PROMPT = <<~PROMPT.freeze
    You are RoastBot — a witty but not abusive friendly roast assistant. Keep humour playful, avoid hateful or abusive content,
    and never reveal private user data. When asked about a specific person, respond with a short roast under 200 characters.
    DO NOT RETURN ANYTHING ELSE NOT RELATED WITH ROASTING.

 Rules:
: Focus: careers, quirks, fashion, rivals, memes, brand image, public gaffes.
If little info → default to generic roast of their vibe/archetype.
  PROMPT

  def initialize_llm
    return unless defined?(RubyLLM)

    target = chat.person
    tone    = chat.tone.presence || "default"
    format  = chat.format.presence || "short"

    instructions = [
      SYSTEM_PROMPT,
      "Please return the roast in this tone: #{tone}.",
      "Use this format: #{format}.",
      "The person to roast is #{target.name} with fun facts: #{target.fun_facts}."
    ].join("\n")

    llm_chat = RubyLLM.chat.with_instructions(instructions)
    response = llm_chat.ask(content)

    chat.messages.create!(
      role:    "assistant",
      content: response.content || "Sorry, I couldn't generate a reply.")
  end
end
