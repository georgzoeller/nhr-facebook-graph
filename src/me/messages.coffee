# https://developers.facebook.com/docs/messenger-platform/send-api-reference
MAX_TEXT_LENGTH   = 639
MAX_TITLE_LENGTH  = 20
MAX_QUICK_REPLIES = 11
# VALID_QUICK_REPLY_CONTENT_TYPES = ['text','location']

clampString = (text, limit) ->
  return text if text.length <= limit
  text.substr 0, limit-1

module.exports  = (context) ->

  ChatMessageBuilder: class ChatMessageBuilder extends context.RequestBuilder

    constructor: (context, opts) ->
      super context, opts
      @addJson 'message', {}
      @message = @opts.json.message

    setRecipient: (user_id) ->
      @addJson 'recipient', {id: user_id}
      @

    setText: (text) ->
      @message.text = clampString text, MAX_TEXT_LENGTH
      @

    setAttachment: (type, payload) ->
      #throw new Error("Both type and payload must be set") if not type? or not payload?
      @message.attachment = {type: type, payload: payload}
      @

    attachImageUrl: (url) ->
      @setAttachment 'image', {url: url}
      @

    attachVideoUrl: (url) ->
      @setAttachment 'video', {url: url}
      @

    attachFileUrl: (url) ->
      @setAttachment 'file', {url: url}
      @


    attachAudioUrl: (url) ->
      @setAttachment 'audio', {url: url}
      @

    addLocationQuickReply: (title = 'Send location') ->
      @message.quick_replies ?= []
      @message.quick_replies.push {title: clampString(title, MAX_TITLE_LENGTH), content_type: 'location'}
      @


    addQuickReplies: (replies = []) ->
      @addQuickReply reply.title, reply.payload, reply.image for reply in replies
      @

    # add a quick reply. If payload is not defined, it will default to title
    addQuickReply: (title, payload, image) ->
      @message.quick_replies ?= []
      if @message.quick_replies.length >= MAX_QUICK_REPLIES
        @debug "Warning: Quick Reply Limit is 11, not adding #{title}"
        return @
      qr =  {content_type: 'text', title: clampString(title, MAX_TITLE_LENGTH), payload: payload || title}

      qr.image_url = image if image?
      @message.quick_replies.push qr
      @


  createMessage: (opts) ->
    new ChatMessageBuilder(context, opts)


  sendMessageJson:  (recipient, messageJson) ->
    context.createCall endpoint: 'me/messages'
      .describe "Sending chat message to #{recipient}: #{messageJson}"
      .setMethod 'POST'
      .authorizeByToken()
      .setJson {recipient: {id: recipient}, message: messageJson}


  sendText: (recipient, text, quick_replies) ->
    context.customCall ChatMessageBuilder, endpoint: 'me/messages'
      .describe "Sending chat message to #{recipient}: #{text}"
      .setMethod 'POST'
      .authorizeByToken()
      .setRecipient recipient
      .setText text
      .addQuickReplies quick_replies

  sendImage: (recipient, url) ->
    context.customCall ChatMessageBuilder, endpoint: 'me/messages'
      .describe "Sending image to #{recipient}: #{url}"
      .setMethod 'POST'
      .authorizeByToken()
      .setRecipient recipient
      .attachImageUrl url

  sendVideo: (recipient, url) ->
    context.customCall ChatMessageBuilder, endpoint: 'me/messages'
      .describe "Sending video to #{recipient}: #{url}"
      .setMethod 'POST'
      .authorizeByToken()
      .setRecipient recipient
      .attachVideoUrl url

  sendTemplate: (recipient, payload) ->
    context.customCall ChatMessageBuilder, endpoint: 'me/messages'
      .describe "Sending template to #{recipient}: #{payload}"
      .setMethod 'POST'
      .authorizeByToken()
      .setRecipient recipient
      .setAttachment 'template', payload


  setTypingIndicator: (recipient, turnOn = true) ->
    if turnOn then state = 'on' else state = 'off'
    context.createCall endpoint: 'me/messages'
      .describe "Setting typing indicator for #{recipient} to #{state}"
      .setMethod 'POST'
      .authorizeByToken()
      .setJson {recipient: {id: recipient}, sender_action: "typing_#{state}"}

