set "CXXFLAGS=%CXXFLAGS% -DBOOST_TIMER_ENABLE_DEPRECATED=1"
for /f "delims=" %%i in ('python -c "import numpy; print(numpy.get_include())"') do set "NUMPY_INCLUDE_DIR=%%i"

cd build
cmake %CMAKE_ARGS% ^
  -G Ninja ^
  -DPYTHON_NUMPY_INCLUDE_DIR="%NUMPY_INCLUDE_DIR%" ^
  -DCMAKE_POLICY_VERSION_MINIMUM=3.5 ^
  -DBAYESOPT_PYTHON_INTERFACE=ON ^
  -DBAYESOPT_BUILD_TESTS=ON ^
  -DBAYESOPT_BUILD_SHARED=ON ^
  -DBAYESOPT_BUILD_SOBOL=ON ^
  -DNLOPT_BUILD=OFF ^
  ..

ninja -j%CPU_COUNT%
ninja install
