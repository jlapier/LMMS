module LayoutHelper
  def rounded_corners(color_prefix = nil, wrapper_css_class = 'rounded_wrapper', hidden = false, inner_width = 355)
    color_prefix = color_prefix ? "#{color_prefix}_" : ''
    concat(<<-END
      <div class="#{wrapper_css_class}" style="#{hidden ? 'display:none' : ''}">
        <img src="#{image_path('interface/'+color_prefix+'UL_Corner.png')}" style="margin:0px; padding:0px; float:left;" alt="border"/>
        <div style="background: url(#{image_path('interface/'+color_prefix+'Border_Top.png')}); width: #{inner_width}px; height:25px; float:left;"></div>
        <img src="#{image_path('interface/'+color_prefix+'UR_Corner.png')}" style="margin:0px; padding:0px; float:left;" alt="border"/>

        <div style="clear:both; background: url(#{image_path('interface/'+color_prefix+'Border_Left.png')}) repeat-y center left;">
          <div style="background: url(#{image_path('interface/'+color_prefix+'Border_Right.png')}) repeat-y center right; margin-left:25px;" >
            <div style="margin-right:25px; background: url(/images/interface/#{color_prefix}Fill_82.png); width: #{inner_width}px; overflow:auto; height: 300px;">
      END
    )
    
    yield

    concat(<<-END
            </div>
          </div>
        </div>
        <img src="#{image_path('interface/'+color_prefix+'LL_Corner.png')}" style="margin:0px; padding:0px; float:left;" alt="border"/>
        <div style="background: url(#{image_path('interface/'+color_prefix+'Border_Btm.png')}); width: #{inner_width}px; height:25px; float:left;"></div>
        <img src="#{image_path('interface/'+color_prefix+'LR_Corner.png')}" style="margin:0px; padding:0px; float:left;" alt="border"/>
      </div>
    END
    )
    
  end

end