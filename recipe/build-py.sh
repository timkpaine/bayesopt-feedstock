export CXXFLAGS="${CXXFLAGS} -DBOOST_TIMER_ENABLE_DEPRECATED=1"

# Cython 3 rejects np.int_t in this legacy source; use np.intp_t for compatibility.
sed -i 's/np\.int_t/np.intp_t/g' python/bayesopt.pyx
rm -f python/bayesopt.cpp
cython python/bayesopt.pyx --cplus

cd build
cmake ${CMAKE_ARGS} \
  -DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
  -DBAYESOPT_PYTHON_INTERFACE=ON \
  -DBAYESOPT_BUILD_TESTS=ON \
  -DBAYESOPT_BUILD_SHARED=ON \
  -DBAYESOPT_BUILD_SOBOL=ON \
  -DNLOPT_BUILD=OFF \
  ..

make -j${CPU_COUNT}
make install
