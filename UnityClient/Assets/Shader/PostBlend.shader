// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "GameShader/PostBlend"
{
	Properties
	{
		_MainTex ("Base (RGB), Alpha (A)", 2D) = "white" {} 
	    _MainColor ("Base (RGB) Color", Color) = (0,0,0,0)	
        Lighty("Vertex Lighty", float) =1.1
	}
	
	SubShader
	{
		LOD 300

		Tags
		{
			//"Queue" = "Geometry+5"
			"Queue" = "AlphaTest+5"
			
			"IgnoreProjector" = "True"
			"RenderType" = "Transparent"
		}
		
		Pass
		{
		    Cull Off
		    Lighting Off
		    ZWrite off
	        Blend  DstColor srccolor 	  
		    Fog {Mode Off} 	    
	        
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
	
			struct appdata_t
			{
				float4 vertex : POSITION;
				float2 texcoord : TEXCOORD0;
			};
	
			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 texcoord : TEXCOORD0;
			};
	
			sampler2D _MainTex;		
			half4 _MainColor;
			half  Lighty;
			v2f vert (appdata_t v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
			    o.texcoord = v.texcoord;
				return o;
			}
			
			fixed4 frag (v2f i) : COLOR
			{
				float4 col = tex2D(_MainTex, i.texcoord) ;
				col.rgb*=_MainColor*Lighty;
				return col;
			}
			ENDCG
		}
	}

}
