# frozen_string_literal: true
class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat

  SYSTEM_PROMPT = <<~PROMPT.freeze
    You are RoastBot — a witty but not abusive friendly roast assistant. Keep humour playful, avoid hateful or abusive content,
    and never reveal private user data. When asked about a specific person, respond with a short roast under 200 characters.
  PROMPT

  def new
    @message = @chat.messages.new
  end

  def create
    @message = @chat.messages.build(message_params.merge(role: 'user'))
    if @message.save
      handle_llm_reply(@message)
      redirect_to chat_path(@chat)
    else
      flash.now[:alert] = 'Message could not be saved.'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_chat
    @chat = current_user.chats.find(params[:chat_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: 'Chat not found'
  end

  def message_params
    params.require(:message).permit(:content)
  end

  # Core LLM integration — defensive: it will not crash the app when RubyLLM/API key missing
  def handle_llm_reply(user_message)
    return unless defined?(RubyLLM)

    instructions = [SYSTEM_PROMPT, (@chat.challenge&.system_prompt)].compact.join("\n\n")
    llm_chat = RubyLLM.chat
    llm_chat = llm_chat.with_instructions(instructions) if instructions.present?

    begin
      # ask will append user and assistant messages on the RubyLLM side and returns a RubyLLM::Message
      response = llm_chat.ask(user_message.content)
      assistant_text = response&.content || "Sorry, I couldn't generate a reply."
    rescue StandardError => e
      Rails.logger.error("RubyLLM ask failed: \#{e.message}\n\\#{e.backtrace.join("\n")}")
      assistant_text = "Sorry — AI generation failed (#{e.class}): #{e.message}"
    end

    # persist assistant reply (defensive)
    begin
      @chat.messages.create!(content: assistant_text, role: 'assistant')
    rescue StandardError => e
      Rails.logger.error("Failed to save assistant message: \#{e.message}")
    end

    # try to generate a short title from the first message (best-effort)
    begin
      @chat.generate_title_from_first_message!
    rescue StandardError => e
      Rails.logger.warn("Title generation failed: \#{e.message}")
    end
  end
end
