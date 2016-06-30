
// リンクパラメータ a, alpha, d は定義済み

step = 45
theta = [...
    0:step:360;  // q1
    zeros(1, 9); // q2
    zeros(1, 9); // q3
    zeros(1, 9); // q4
    zeros(1, 9); // q5
    zeros(1, 9)  // q6
]

// 変数の初期化
clear([...
    'x',
    'y,',
    'z',
    'T'])

// リンクiの関節部座標を計算する
for t= 1:size(theta,2) do
    T = eye(4)
    for i = 1:6 do
        T = T * Tn_1n(a(i), alpha(i), d(i), theta(i, t))
        x(i, t) = T(1,4)
        y(i, t) = T(2,4)
        z(i, t) = T(3,4)
    end
end

// グラフを描画
clf()
set(gca(), "isoview", "on")
xlabel("x")
ylabel("y")
zlabel("z")
param3d1(x, y, z)

// グラフの装飾
a = gca();
g = a.children.children(:,1)
g.mark_style=5

// グラフにテキストを描画
for t=1:size(theta,2) do
    xstring(x(6,t), y(6,t), "$\theta =" + string((t-1)*step) + "^{\circ} $")
end
