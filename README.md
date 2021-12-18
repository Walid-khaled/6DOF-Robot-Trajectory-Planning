## 6DOF-Robot-Trajectory-Planning


Task:
1) Calculate and plot position, velocity, and acceleration trajectories of driving your robot model
from configuration q0 to configuration qf in joint space.
2) Synchronize your 6 joints to start and end motion at the same time.
3) Redefine synchronized trajectories for numerical control
4) Calculate propagated error in end-effector position.
5) Drive your robot model between 3 consequent points. (solve polynomial)
6) Perform trajectory junction.

---
### Table of Content 
```
├── src                            <- directory for source files 
|    ├── main.m                    <- contains python code main script (to be run)
|    ├── Trajectory.m              <- contains concept for single joint trajectory (position-velocity-acceleration)
|    ├── TrajectoryTimePlanning.m  <- contains trajectory function to be called for each joint
|    ├── NumericalTrajectory.m     <- contains numerical control function
|    ├── FK.m                      <- contains forward kinematics function to get end-effector position
|    ├── Polynomial.m              <- contains polynomial solution function
|
├── Report 
└── Readme.md
```
