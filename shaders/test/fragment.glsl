#define PI  3.1415926535897932384626433832795

varying vec2 vUv;

float random (vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}

vec2 rotate(vec2 uv, float rotation, vec2 mid)
{
    return vec2(
      cos(rotation) * (uv.x - mid.x) + sin(rotation) * (uv.y - mid.y) + mid.x,
      cos(rotation) * (uv.y - mid.y) - sin(rotation) * (uv.x - mid.x) + mid.y
    );
}

vec4 permute(vec4 x)
{
    return mod(((x*34.0)+1.0)*x, 289.0);
}

//	Classic Perlin 2D Noise 
//	by Stefan Gustavson
//
vec2 fade(vec2 t)
{
    return t*t*t*(t*(t*6.0-15.0)+10.0);
}

float cnoise(vec2 P)
{
    vec4 Pi = floor(P.xyxy) + vec4(0.0, 0.0, 1.0, 1.0);
    vec4 Pf = fract(P.xyxy) - vec4(0.0, 0.0, 1.0, 1.0);
    Pi = mod(Pi, 289.0); // To avoid truncation effects in permutation
    vec4 ix = Pi.xzxz;
    vec4 iy = Pi.yyww;
    vec4 fx = Pf.xzxz;
    vec4 fy = Pf.yyww;
    vec4 i = permute(permute(ix) + iy);
    vec4 gx = 2.0 * fract(i * 0.0243902439) - 1.0; // 1/41 = 0.024...
    vec4 gy = abs(gx) - 0.5;
    vec4 tx = floor(gx + 0.5);
    gx = gx - tx;
    vec2 g00 = vec2(gx.x,gy.x);
    vec2 g10 = vec2(gx.y,gy.y);
    vec2 g01 = vec2(gx.z,gy.z);
    vec2 g11 = vec2(gx.w,gy.w);
    vec4 norm = 1.79284291400159 - 0.85373472095314 * vec4(dot(g00, g00), dot(g01, g01), dot(g10, g10), dot(g11, g11));
    g00 *= norm.x;
    g01 *= norm.y;
    g10 *= norm.z;
    g11 *= norm.w;
    float n00 = dot(g00, vec2(fx.x, fy.x));
    float n10 = dot(g10, vec2(fx.y, fy.y));
    float n01 = dot(g01, vec2(fx.z, fy.z));
    float n11 = dot(g11, vec2(fx.w, fy.w));
    vec2 fade_xy = fade(Pf.xy);
    vec2 n_x = mix(vec2(n00, n01), vec2(n10, n11), fade_xy.x);
    float n_xy = mix(n_x.x, n_x.y, fade_xy.y);
    return 2.3 * n_xy;
}

void main()
{   
    // // pattern 3
    // float strength = vUv.x;

    // // pattern 4
    // float strength = vUv.y;

    // // pattern 5
    // float strength = 1.0 - vUv.y;

    // // pattern 6
    // float strength =  vUv.y * 10.0;

    // // pattern 7
    // float strength =  mod(vUv.y * 10.0, 1.0);

    // // pattern 8
    // float strength =  mod((vUv.y * 10.0),1.0); 
    // strength = step( 0.5, strength);

    // // pattern 9
    // float strength =  mod((vUv.y * 10.0),1.0); 
    // strength = step( 0.8, strength);

    // pattern 10
    // float strength =  mod((vUv.x * 10.0),1.0); 
    // strength = step( 0.8, strength);

    // // pattern 12
    // float strength =  step( .80,mod(vUv.x * 10.0,1.0));
    // strength *=  step( 0.8,mod(vUv.y * 10.0,1.0));

    // gl_FragColor = vec4( strength, strength, strength, 1.0);

    // // pattern 13
    // float strength =  - step( .80,mod(vUv.x * 10.0,1.0));
    // strength +=  step( 0.8,mod(vUv.y * 10.0,1.0));


    // // pattern 14

    // float horizontal = step( .40,mod(vUv.x * 10.0,1.0));
    // horizontal *=  step( 0.8,mod(vUv.y * 10.0,1.0));

    // float vertical = step( .80,mod(vUv.x * 10.0,1.0));
    // vertical *=  step( 0.4,mod(vUv.y * 10.0,1.0));

    // float strength =  horizontal + vertical;

    // // pattern 15
    // float horizontal = step( .40,mod(vUv.x * 10.0 - 0.2,1.0));
    // horizontal *=  step( 0.8,mod(vUv.y * 10.0 ,1.0));

    // float vertical = step( .80,mod(vUv.x * 10.0 ,1.0));
    // vertical *=  step( 0.40,mod(vUv.y * 10.0 - 0.2,1.0));
    // float strength =  horizontal + vertical;

    // //pattern 16
    // float strength = min(abs(vUv.x -0.5),  abs( vUv.y -0.5)) ;


    // //pattern 17
    // float strength = max(abs(vUv.x -0.5),  abs( vUv.y -0.5)) ;

    // //pattern 18
    // float strength = step(0.2, max(abs(vUv.x -.5),  abs( vUv.y - .5))) ;

    // //pattern 19
    // float strength = step(.4, max(abs(vUv.x -.5),  abs( vUv.y - .5))) ;

    // //pattern 20
    // float pattern1 = step(.2, max(abs(vUv.x -.5),  abs( vUv.y - .5)));
    // float pattern2 = 1.0 - step(.25, max(abs(vUv.x -.5),  abs( vUv.y - .5)));
    // float strength = pattern1 * pattern2; 
    //  // or 
    // float strength = step(.4, max(abs(vUv.x -.5),  abs( vUv.y - .5)));

    // //pattern 21
    // float strength = floor(vUv.x * 10.0) / 10.0 ;

    // //pattern 22
    // float pattern1 = floor(vUv.x * 10.0) / 10.0 ;
    // float pattern2 = floor( vUv.y * 10.0)/ 10.0;
    // float strength = pattern1 * pattern2;

    // //pattern 23
    // float strength = random(vUv);

    // //pattern 24
    // vec2 griduV = vec2(
    //     floor(vUv.x * 10.0) / 10.0,
    //     floor( vUv.y * 10.0)/ 10.0
    // );
    // float strength = random(griduV);

    // //pattern 25
    // vec2 griduV = vec2(
    //     floor(vUv.x * 10.0) / 10.0,
    //     floor( (vUv.y + vUv.x * .5) * 10.0)/ 10.0
    // );
    // float strength = random(griduV);

    //pattern 26
    // float strength = length(vUv - .5);
        //or
    // float strength = distance( vUv, vec2( .5, .5));

    //pattern 27
    // float strength = 1. - distance( vUv , vec2( .5, .5));

    //pattern 28
        // my solution
    // float strength = 1.5 - distance( vUv , vec2( .5, .5)) * 30.;
        // bruno's solution
    // float strength = .015 / distance( vUv, vec2( .5, .5));
    
    //pattern 30
        // my solution
    // float strength = 1.5 - distance( vUv , vec2( .5, .5)) * 30.;
    // vec2 light = vec2( 
    //     vUv.x * .2 + .40,
    //     vUv.y * 0.6 + .25
    // );
    // float strength = .015 / distance( light, vec2( .5, .5));

    
    //pattern 31
        //my solution
    // vec2 light1 = vec2(vUv.x * .2 + .40, vUv.y * 0.6 + .20 );
    // vec2 light2 = vec2(vUv.x * .62 + .19, vUv.y * 0.2 + .40 );
    // float strength = .005 / distance( light1, vec2( .5, .5));
    // strength += .005 / distance( light2, vec2( .5, .5));
        // bruno's solution

    // vec2 lightUvx = vec2( vUv.y * .1 + .45, vUv.x * 0.5 + .25);
    // float lightX = .015 / distance( lightUvx , vec2( .5, .5)) ;

    // vec2 lightUvy = vec2(  vUv.x * .1 + .45, vUv.y * 0.5 + .25);
    // float lightY = .015 / distance( lightUvy , vec2( .5, .5));

    // float strength = lightX * lightY;

    //  //pattern 32
    // vec2 rotateAxis = rotate( vUv, PI * 0.25,vec2(.5));
    // vec2 lightUvx = vec2( rotateAxis.y * .1 + .45, rotateAxis.x * 0.5 + .25);
    // float lightX = .015 / distance( lightUvx , vec2( .5, .5)) ;

    // vec2 lightUvy = vec2(  rotateAxis.x * .1 + .45, rotateAxis.y * 0.5 + .25);
    // float lightY = .015 / distance( lightUvy , vec2( .5, .5));

    // float strength = lightX * lightY;

    // //pattern 33
    // float strength = step( .3, distance( vUv, vec2(.5, .5)));

    // //pattern 33
    // float strength =abs(distance( vUv , vec2(.5, .5)) - .25);

    // //pattern 34
    // float strength =abs(distance( vUv , vec2(.5, .5)) - .25);

    // //pattern 35
    // float strength =step(.01, abs(distance( vUv , vec2(.5, .5)) - .25));

    // //pattern 36
    // float strength = 1. - step(.01, abs(distance( vUv , vec2(.5, .5)) - .25));

    // //pattern 37
    // vec2 rad = vec2( vUv.x , vUv.y + sin(vUv.x * 30.) * 0.1);
    // float strength = 1. - step(.01, abs(distance( rad , vec2(.5, .5)) - .25));

    // //pattern 38
    // vec2 rad = vec2( vUv.y + sin(vUv.x * 30.) * .1 , vUv.x + sin(vUv.y * 30.) * 0.1);
    // float strength = 1. - step(.01, abs(distance( rad , vec2(.5, .5)) - .25));

    // //pattern 39
    // vec2 rad = vec2( vUv.y + sin(vUv.x * 100.) * .1 , vUv.x + sin(vUv.y * 100.) * 0.1);
    // float strength = 1. - step(.01, abs(distance( rad , vec2(.5, .5)) - .25));

    // //pattern 40
    // float angle = atan(vUv.x, vUv.y);
    // float strength = angle;

    // //pattern 41
    // float angle = atan(vUv.x - .5 , vUv.y -.5);
    // float strength = angle;

    // //pattern 42
    // float angle = atan(vUv.x - .5 , vUv.y -.5 );
    // float strength = (angle + PI) *  0.2;

    // //pattern 43
    // float angle = atan(vUv.x - .5 , vUv.y -.5 );
    // float strength = mod((angle + 0.1) *  PI * 1., 1.);

    // //pattern 44
    // float angle = atan(vUv.x - .5 , vUv.y -.5 );
    // float strength = sin(((angle / PI * 2.) + .5) * 20.);

    // //pattern 45
    // float angle = atan(vUv.x - .5 , vUv.y -.5 );
    // float sinousoid = sin(((angle / PI * 2.) + .5) * 34.6);
    // float radius = .25 + sinousoid * .02;
    // float strength = 1. - step(.01, abs(distance( vUv , vec2(.5, .5)) - radius));

    // //pattern 46
    // float strength = cnoise(vUv *  10.);

    // //pattern 47
    // float strength = step( 0.1, cnoise(vUv *  10.));

    // //pattern 48
    // float strength = 1. - abs(cnoise(vUv *  10.));

    //  //pattern 49
    // float strength = sin(cnoise(vUv *  10.) * 20.);

    //pattern 50
    float strength = step( .89, sin(cnoise(vUv *  10.) * 20.));


    // clamp Strength

    float clampedStrength = clamp(strength, 0.0, 1.0);
    //colored version
    vec3 blackColor = vec3( .0, .0, .0);
    vec3 uvColor = vec3(vUv, .5);
    vec3 mixColor = mix( blackColor, uvColor, clampedStrength);

    gl_FragColor = vec4(mixColor, 1.0);

    // black and white version
    // gl_FragColor = vec4( vec3(clampedStrength), 1.);
} 