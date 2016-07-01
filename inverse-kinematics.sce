exec('utilities.sci', -1)

// 目標のハンド座標
px= 2
py= 1
pz=-1


function output = calc_theta123_from_hand_pos(px,py,pz)
    // 計算結果のみを計算する。
    // 計算式の導出は下記書籍を参照のこと
    // ロボット工学の基礎
    // 著者: 川崎 晴久
    // ISBN: 978-4-627-91382-0
    // pp.60-64

    theta1(1) = atan(-px, py) - atan(+sqrt(px*px + py*py - d(2)*d(2)), d(2))
    theta1(2) = atan(-px, py) - atan(-sqrt(px*px + py*py - d(2)*d(2)), d(2))
    
    k = (...
        px*px + py*py + pz*pz ... 
        - d(2)*d(2) - d(4)*d(4) - a(3)*a(3) - a(4)*a(4) ...
        )/(2*a(3))
    
    theta3(1) = atan(-d(4), a(4)) - atan(+sqrt(d(4)*d(4) + a(4)*a(4) - k*k), k)
    theta3(2) = atan(-d(4), a(4)) - atan(-sqrt(d(4)*d(4) + a(4)*a(4) - k*k), k)
    
    for t1 = list(theta1(1), theta1(2)) do
        for t3 = list(theta3(1), theta3(2)) do
            t2 = ...
               atan(...
                    -pz*(a(4)*cos(t3) - d(4)*sin(t3) + a(3)) ...
                    -(px*cos(t1) + py*sin(t1)) * (a(4)*sin(t3) + d(4)*cos(t3))...
                    ,...
                    -pz*(a(4)*sin(t3) + d(4)*cos(t3)) ...
                    +(px * cos(t1) + py * sin(t1)) * (a(4)*cos(t3) - d(4)*sin(t3) + a(3))...
                    )
            output($+1,:) = [t1, t2, t3]
        end
    end
endfunction

function output = rotation_matrix_from_euler_angle(phi, theta, psi)
    output = Rotz(phi) * Rotx(theta) * Rotz(psi)
endfunction


//disp(calc_theta123_from_hand_pos(px,py,pz)*180/%pi)

disp(rotation_matrix_from_euler_angle( 0, 0, 0))
disp(rotation_matrix_from_euler_angle(90, 0, 0))

