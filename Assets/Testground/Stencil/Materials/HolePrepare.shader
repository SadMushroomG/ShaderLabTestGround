Shader "Unlit/HolePrepare"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" "Queue"="Geometry+1"}
        ColorMask 0
        //stop write to depth buffer
        Zwrite off
        Stencil {
            Ref 1
            Comp Always
            Pass Replace
        }
        LOD 100

        CGINCLUDE
        struct appdata {
            fixed4 vertex : POSITION;
        };
        struct v2f {
            fixed4 pos:SV_POSITION;
        }; 
        v2f vert (appdata v)
        {
            v2f o;
            o.pos = UnityObjectToClipPos(v.vertex);
            return o;
        }
        fixed4 frag (v2f i) : SV_Target
        {
            return half4(1,0,0,1);
        }
        ENDCG 
        
        Pass
        {
            Cull Front
            //Everything less then it
            ZTest Less

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            ENDCG
        }
        Pass
        {
            Cull Back
            ZTest Greater

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            ENDCG
        }
    }
}
