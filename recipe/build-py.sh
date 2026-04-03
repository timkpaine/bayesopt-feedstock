export CXXFLAGS="${CXXFLAGS} -DBOOST_TIMER_ENABLE_DEPRECATED=1"
NUMPY_INCLUDE_DIR="$(python -c 'import numpy; print(numpy.get_include())')"

rm -f python/bayesopt.cpp
cython -3 python/bayesopt.pyx --cplus

cd build
cmake ${CMAKE_ARGS} \
  -DPYTHON_NUMPY_INCLUDE_DIR="${NUMPY_INCLUDE_DIR}" \
  -DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
  -DBAYESOPT_PYTHON_INTERFACE=ON \
  -DBAYESOPT_BUILD_TESTS=ON \
  -DBAYESOPT_BUILD_SHARED=ON \
  -DBAYESOPT_BUILD_SOBOL=ON \
  -DNLOPT_BUILD=OFF \
  ..

make -j${CPU_COUNT}
make install
