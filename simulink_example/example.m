% Example script on how to use the MATLAB Robotics Toolbox for a trajectory tracking control task in joint space

%% Load the robot
robot_model = importrobot('iiwa14.urdf', 'DataFormat', 'column');
n           = 7; % Number of DOFs

%% Simulation parameters
simulation_time = 10;
q_0             = randn(n, 1); % Initial configuration
dq_0            = zeros(n, 1); % Initial velocity

%% Define a joint trajectory as a cubic spline from q_start to q_end with zero velocities
q_d_start           = zeros(n, 1);
q_d_end             = [pi/2; pi/4; -pi/3; pi/4; -3*pi/4; pi/4; -pi/8];

% Rest-to-rest motion in configuration space
[a, b, c, delta_q]  = CubicPolynomial(q_d_start, q_d_end, zeros(n, 1), zeros(n, 1));

% Store the interpolated trajectory as function handle to use in Simulink
q_d                 = @(t) q_d_start + delta_q.*(a*(t/simulation_time)^3 + b*(t/simulation_time)^2 + c*t/simulation_time);
dq_d                = @(t) (delta_q/simulation_time).*(3*a*(t/simulation_time)^2 + 2*b*(t/simulation_time) + c);
ddq_d               = @(t) (delta_q/simulation_time^2).*(6*a*(t/simulation_time) + 2*b);


%% Open the simulink model, simulate it and store the results for plotting purposes
open('model.slx');
out = sim('model.slx');
save("simulation_results", "out");

%% Plotting the results
load("simulation_results.mat");

% Configuration
f1 = figure; grid on; box on; hold on;
plot(out.q.Time, out.q.Data, "LineWidth", 2);
pbaspect([2, 1, 1]);
xlabel("Time [s]", "Interpreter", "latex", "FontSize", 14);
ylabel("Configuration [rad]", "Interpreter", "latex", "FontSize", 14);
pl = plot(out.q_d.Time, out.q_d.Data, "k--", "LineWidth", 2);
set(pl, {'HandleVisibility'},  [{"on"}; repmat({"off"}, n-1, 1)]); % Keep the visibility in the legend of only one reference
legend([arrayfun(@(i) sprintf("$q_{%d}$", i), 1:n, "UniformOutput", false)'; {"$q_{d}$"}], ...
        "Interpreter", "latex", ...
       "FontSize", 14, ...
       "NumColumns", 6, ...
       "Location", "northoutside");

% Control action
f2 = figure; grid on; box on; hold on;
plot(out.tau.Time, out.tau.Data, "LineWidth", 2);
pbaspect([2, 1, 1]);
xlabel("Time [s]", "Interpreter", "latex", "FontSize", 14);
ylabel("Torque [Nm]", "Interpreter", "latex", "FontSize", 14);
grid on; box on;
ylim([-2, 2]);


% Save the figures
exportgraphics(f1, "./fig/q.pdf");
exportgraphics(f2, "./fig/u.pdf");