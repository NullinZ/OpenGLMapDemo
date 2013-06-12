//
//  Shader.vsh
//  OpenglESDemo
//
//  Created by Nullin on 11-7-30.
//  Copyright 2011年 Innovation Workshop. All rights reserved.
//

attribute vec4 position;
attribute vec4 color;

varying vec4 colorVarying;

uniform float translate;

void main()
{
    gl_Position = position;
    gl_Position.y += sin(translate) / 2.0;

    colorVarying = color;
}
