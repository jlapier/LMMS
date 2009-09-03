
var HtmElement = Class.create({
  
  initialize: function(tagString, attribs, content) {
    parts = tagString.split(' ');
    attribs = attribs || {}
    _csses = parts.findAll(function(part) { return part[0] == '.'; });
    csses = _csses.collect(function(css) { return css.substring(1); })
    id = parts.find(function(part) { return part[0] == '#'; });
    if(id) { id = id.substring(1); }
    tag = parts.find(function(part) { return part[0].match(/^\w+/) });

    if (attribs['class']) { csses.push(attribs['class']); }
    attribs['class'] = csses.join(" ");
    attribs['id'] = attribs['id'] || id;
    this.element = new Element(tag || 'div', attribs)
    
    if (Object.isArray(content)) {
      //alert(content)
      for (var i = 0, length = content.length; i < length; i++) this.element.insert(content[i].element);
    } else {      
      this.element.insert(content.element || content);
    }
  },
  
  render: function(parent) {
    $(parent || document.body).insert(this.element);
  }
})

function $E(tagString, attribs, content, children, parent) { 
  return new HtmElement(tagString, attribs, content, children, parent);
}
