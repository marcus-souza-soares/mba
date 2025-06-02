# Exercício: HtmlBuilder com tags
# aninhadas
# Objetivo:
# Modificar a classe HtmlBuilder vista em aula a fim de
# permitir a construção de HTMLs mais complexos.
# Enunciado:
# Altere a classe abaixo:

class HtmlBuilder
  def initialize(&block)
    @html = ""
    instance_eval(&block) if block_given?
  end

  def div(content = nil, &block)
    if block_given?
      @html << "<div>\n"
      block.call
      @html << "</div>\n"
    else
      @html << "<div>#{content}</div>\n"
    end
  end

  def span(content = nil, &block)
    if block_given?
      @html << "<span>\n"
      block.call
      @html << "</span>\n"
    else
      @html << "<span>#{content}</span>\n"
    end
  end

  def result
    @html
  end
end

=begin
Após alterar, a classe deve ser capaz de executar
corretamente o seguinte input:
builder = HtmlBuilder.new do
  div do
  div "Conteúdo em div"
  span "Nota em div"
  end
  span "Nota de rodapé"
end
Obs.: não precisa se preocupar em formatar corretamente o
HTML gerado, então uma saída assim:
<div><div></div><span></span></div>
será aceita sem problemas.
=end

builder = HtmlBuilder.new do
  div do
    div "Conteúdo em div"
    span "Nota em div"
  end
  span "Nota de rodapé"
end
puts builder.result
