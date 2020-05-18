// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:1,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.1280277,fgcg:0.1953466,fgcb:0.2352941,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9461,x:32720,y:32714,varname:node_9461,prsc:2|emission-4465-RGB,alpha-7892-OUT;n:type:ShaderForge.SFN_Color,id:4465,x:31728,y:32582,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_4465,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0,c2:0.8758624,c3:1,c4:1;n:type:ShaderForge.SFN_Fresnel,id:9810,x:31935,y:32653,varname:node_9810,prsc:2|EXP-4465-A;n:type:ShaderForge.SFN_Tex2d,id:1381,x:31878,y:32954,ptovrint:False,ptlb:Texture,ptin:_Texture,varname:node_1381,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:b79aae2bf6449a34fb0caeacd42d6a50,ntxv:0,isnm:False|UVIN-4207-UVOUT;n:type:ShaderForge.SFN_Add,id:7892,x:32362,y:32868,varname:node_7892,prsc:2|A-5677-OUT,B-7948-OUT;n:type:ShaderForge.SFN_TexCoord,id:9031,x:31463,y:32942,varname:node_9031,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Panner,id:4207,x:31675,y:32926,varname:node_4207,prsc:2,spu:0,spv:-0.3|UVIN-9031-UVOUT;n:type:ShaderForge.SFN_Multiply,id:7948,x:32081,y:33017,varname:node_7948,prsc:2|A-1381-R,B-3811-OUT;n:type:ShaderForge.SFN_Slider,id:3811,x:31609,y:33281,ptovrint:False,ptlb:XianTiao,ptin:_XianTiao,varname:node_3811,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.4615385,max:1;n:type:ShaderForge.SFN_Multiply,id:5677,x:32081,y:32713,varname:node_5677,prsc:2|A-9810-OUT,B-6145-OUT;n:type:ShaderForge.SFN_Slider,id:6145,x:31789,y:32833,ptovrint:False,ptlb:Feresnel,ptin:_Feresnel,varname:node_6145,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;proporder:4465-1381-3811-6145;pass:END;sub:END;*/

Shader "Custom/SF_Fenier" {
    Properties {
        _Color ("Color", Color) = (0,0.8758624,1,1)
        _Texture ("Texture", 2D) = "white" {}
		_XianTiao( "XianTiao", Range( 0, 1 ) ) = 0.4615385
		_Feresnel( "Feresnel", Range( 0, 1 ) ) = 1
		_Textruecolo( "TestColor",Color ) = ( 1,1,1,1 )
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        LOD 200
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend SrcAlpha OneMinusSrcAlpha
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float4 _Color;
			uniform float4 _Textruecolo;
            uniform sampler2D _Texture; uniform float4 _Texture_ST;
            uniform float _XianTiao;
            uniform float _Feresnel;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                UNITY_FOG_COORDS(3)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
////// Lighting:
////// Emissive:
                float3 emissive = _Color.rgb;
                float3 finalColor = emissive;
                float4 node_8766 = _Time;
                float2 node_4207 = (i.uv0+node_8766.g*float2( 0.4,0));
                float4 _Texture_var = tex2D(_Texture,TRANSFORM_TEX(node_4207, _Texture));
				
                fixed4 tempcolor = fixed4(finalColor,((pow(1.0-max(0,dot(normalDirection, viewDirection)),_Color.a)*_Feresnel)+(_Texture_var.r*_XianTiao)));
				fixed4 finalRGBA = tempcolor * _Textruecolo;
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
