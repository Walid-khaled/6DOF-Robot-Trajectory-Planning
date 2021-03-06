## 6DOF-Robot-Trajectory-Planning
In this repository, trajectory planning for a 6DOF manipulator is implemented. Synchronization and numerical control are applied. In addition, propagated error in end-effector position is calculated. Finally, polynomial trajectory and trajectory junction are solved. The repository is also a solution for Assignment3 in Dynamics of Nonlinear Robotics Systems course for ROCV master's program at Innopolis University.

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
|    ├── main.m                    <- contains MATLAB code main script (to be run)
|    ├── Trajectory.m              <- contains concept for single joint trajectory (position-velocity-acceleration)
|    ├── TrajectoryTimePlanning.m  <- contains trajectory function to be called for each joint
|    ├── NumericalTrajectory.m     <- contains numerical control function
|    ├── FK.m                      <- contains forward kinematics function to get end-effector position
|    ├── Polynomial.m              <- contains polynomial solution function
|
├── Report.pdf 
└── Readme.md
```
