package shaders;

// STOLEN FROM HAXEFLIXEL DEMO AND FROM PSYCH ENGINE 0.5.1 WITH SHADERS LOL
import flixel.system.FlxAssets.FlxShader;
import openfl.display.BitmapData;
import openfl.display.Shader;
import openfl.display.ShaderInput;
import openfl.utils.Assets;
import flixel.FlxG;
import openfl.Lib;
using StringTools;

class HealthIconGlitchEffect {
    public var shader:HealthIconGlitchShader = new HealthIconGlitchShader();
    public function new(){
      shader.useEffect.value = [false];
      shader.iTime.value = [0];
    }
    public function useEffectSet(targetBool:Bool){
        shader.useEffect.value[0] = targetBool;
    }
    public function update(elapsed:Float)
    {
        shader.iTime.value[0] += elapsed;
    }
  }
  
  class HealthIconGlitchShader extends FlxShader
  {
    @:glFragmentSource('
    #pragma header
    vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
    vec2 iResolution = openfl_TextureSize;
    uniform float iTime;
    #define iChannel0 bitmap
    #define texture flixel_texture2D
    #define fragColor gl_FragColor
    
    #define toOne 0
    #define PI 3.14159265359
    
    uniform bool useEffect;
    
    vec2 glitchEfect(vec2 uv, float shift) {
        float glitchBlock = 3.0;
        vec2 uv2 = fract(uv*glitchBlock)-0.5;
        vec2 id = floor(uv2);
        
        vec2 n2 = fract(sin(id*123.456)*789.125);
        n2+=dot(id.x,id.y*567.89);
        float n = fract(n2.x+n2.y);
        
        if(mod(iTime,1.0)<0.5){
            float glitchDist = 0.01;
            float glitchTime = iTime*19.0;
            uv.x-=(fract(floor(uv.y+n2.y*glitchBlock)*glitchTime)*glitchDist/2);
            uv.y-=(fract(floor(uv.x+n2.x*glitchBlock)*glitchTime)*glitchDist/2);
            uv.x+=sin(glitchTime*2.0)*shift/2;
            uv.x+=sin(floor(uv.y*glitchBlock*1.2)*iTime*20.)*glitchDist/2;
            uv.y+=sin(floor(uv.x*glitchBlock*1.2)*iTime*21.)*glitchDist/2;
        }
        return uv;
    }
    
    void main()
    {
        vec2 uv = fragCoord/iResolution.xy;
        if(useEffect == true) {
        vec2 p = (fragCoord-0.5*iResolution.xy)/iResolution.y;
        
        vec2 r_uv = glitchEfect(uv,0.0);
        vec2 g_uv = glitchEfect(uv,0.015);
        vec2 b_uv = glitchEfect(uv,0.025);
        vec2 a_uv = glitchEfect(uv,0.015);
        
    
        float r = texture(iChannel0,r_uv).r;
        float g = texture(iChannel0,g_uv).g;
        float b = texture(iChannel0,b_uv).b;
        float a = texture(iChannel0,a_uv).a;
        
        vec3 col = vec3(r,g,b);
        vec2 size = vec2(1.0,0.03);
        
        float t = mod(iTime,1.0);
        if(t<0.5){
            for(float i = 1.;i<6.0; i++){
                vec2 pos = p;
                pos.y+=sin(floor(iTime*2.1*i))*1.0;
                size.x = 0.5+abs(cos(floor(iTime*2.1*i))*1.5);
                size.y = 0.02+sin(floor(iTime*2.1*i))*0.03;
                float d = smoothstep(0.,0.001,-max(abs(pos.x)-size.x,abs(pos.y)-size.y));
                col = mix(col,vec3(b,r,g)*1.05,d); 
            }
        }
        
        fragColor = vec4(col,a);
        }
        else{
            fragColor = texture(iChannel0, uv);
        }
    }
    ')
    public function new()
    {
      super();
    }
  }