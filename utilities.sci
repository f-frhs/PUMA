function output=Trans(x,y,z)
    output = [...
        1, 0, 0, x;
        0, 1, 0, y;
        0, 0, 1, z;
        0, 0, 0, 1]
endfunction

function output=Rotx(alpha_deg)
    alpha = alpha_deg * %pi / 180
    output = [...
        1,          0,           0, 0;
        0, cos(alpha), -sin(alpha), 0;
        0, sin(alpha),  cos(alpha), 0;
        0,          0,           0, 1]
endfunction

function output=Rotz(theta_deg)
    theta = theta_deg * %pi / 180
    output = [...
        cos(theta), -sin(theta), 0, 0;
        sin(theta),  cos(theta), 0, 0;
                 0,           0, 1, 0;
                 0,           0, 0, 1]
endfunction

function output=Tn_1n(a, alpha, d, theta)
    output = Trans(a,0,0) * Rotx(alpha) * Trans(0,0,d) * Rotz(theta)
endfunction

function T=T06(t1, t2, t3, t4, t5, t6)
//          a, alpha, d, theta
  T = Tn_1n(0,     0, 0,    t1) ... // T01
    * Tn_1n(0,   -90, 1,    t2) ... // T12
    * Tn_1n(1,     0, 0,    t3) ... // T23
    * Tn_1n(1,   -90, 1,    t4) ... // T34
    * Tn_1n(0,    90, 0,    t5) ... // T45
    * Tn_1n(0,   -90, 0,    t6);    // T56
endfunction

function R=zyz_euler2R(phi, theta, psi)
    R = Rotz(phi) * Rotx(theta) * Rotz(psi)
endfunction


// リンクパラメーター
// i       1    2    3    4    5    6
//-------------------------------------
a     = [  0,   0,   1,   1,   0,   0]
alpha = [  0, -90,   0, -90,  90, -90]
d     = [  0,   1,   0,   1,   0,   0]
