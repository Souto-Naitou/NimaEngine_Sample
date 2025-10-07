#include "Fullscreen.hlsli"

static const float PI = 3.14159265f;

Texture2D<float4> gTexture : register(t0);
Texture2D<float4> gBloomTexture : register(t1);
SamplerState gSampler : register(s0);

struct GaussianBloomOption
{
    float colorMultiply;
};

ConstantBuffer<GaussianBloomOption> gOption : register(b0);

struct PixelShaderOutput
{
    float4 color : SV_TARGET0;
};

PixelShaderOutput main(VertexShaderOutput input)
{   
    PixelShaderOutput output;
   
    float3 inputRGB = gTexture.Sample(gSampler, input.texcoord).rgb;
    float3 bloomRGB = gBloomTexture.Sample(gSampler, input.texcoord).rgb;
    
    output.color.rgb = inputRGB + bloomRGB * gOption.colorMultiply; // 入力の色とブロームの色を加算
    
    output.color.a = 1.0f; // アルファ値を1.0に設定
    return output;
}