const PyJuliaNumberValue_Type__ref = Ref(PyNULL)
PyJuliaNumberValue_Type() = begin
    ptr = PyJuliaNumberValue_Type__ref[]
    if isnull(ptr)
        c = []
        base = PyJuliaAnyValue_Type()
        isnull(base) && return PyNULL
        t = fill(
            PyType_Create(
                c,
                name = "juliacall.NumberValue",
                base = base,
                as_number = (
                    bool = pyjlnumber_bool,
                    positive = pyjlnumber_positive,
                    negative = pyjlnumber_negative,
                    absolute = pyjlnumber_absolute,
                    power = pyjlnumber_power,
                    add = pyjlnumber_binop(+),
                    subtract = pyjlnumber_binop(-),
                    multiply = pyjlnumber_binop(*),
                    truedivide = pyjlnumber_binop(/),
                    divmod = pyjlnumber_binop((x, y) -> (fld(x, y), mod(x, y))),
                    floordivide = pyjlnumber_binop(fld),
                    remainder = pyjlnumber_binop(mod),
                    lshift = pyjlnumber_binop(<<),
                    rshift = pyjlnumber_binop(>>),
                    and = pyjlnumber_binop(&),
                    xor = pyjlnumber_binop(xor),
                    or = pyjlnumber_binop(|),
                ),
            ),
        )
        ptr = PyPtr(pointer(t))
        err = PyType_Ready(ptr)
        ism1(err) && return PyNULL
        abc = PyNumberABC_Type()
        isnull(abc) && return PyNULL
        ism1(PyABC_Register(ptr, abc)) && return PyNULL
        PYJLGCCACHE[ptr] = push!(c, t)
        PyJuliaNumberValue_Type__ref[] = ptr
    end
    ptr
end

PyJuliaNumberValue_New(x::Number) = PyJuliaValue_New(PyJuliaNumberValue_Type(), x)
PyJuliaValue_From(x::Number) = PyJuliaNumberValue_New(x)

const PyJuliaComplexValue_Type__ref = Ref(PyNULL)
PyJuliaComplexValue_Type() = begin
    ptr = PyJuliaComplexValue_Type__ref[]
    if isnull(ptr)
        c = []
        base = PyJuliaNumberValue_Type()
        isnull(base) && return PyNULL
        t = fill(
            PyType_Create(
                c,
                name = "juliacall.ComplexValue",
                base = base,
                getset = [
                    (name = "real", get = pyjlcomplex_real),
                    (name = "imag", get = pyjlcomplex_imag),
                ],
                methods = [
                    (
                        name = "conjugate",
                        flags = Py_METH_NOARGS,
                        meth = pyjlcomplex_conjugate,
                    ),
                    (
                        name = "__complex__",
                        flags = Py_METH_NOARGS,
                        meth = pyjlcomplex_complex,
                    ),
                ],
            ),
        )
        ptr = PyPtr(pointer(t))
        err = PyType_Ready(ptr)
        ism1(err) && return PyNULL
        abc = PyComplexABC_Type()
        isnull(abc) && return PyNULL
        ism1(PyABC_Register(ptr, abc)) && return PyNULL
        PYJLGCCACHE[ptr] = push!(c, t)
        PyJuliaComplexValue_Type__ref[] = ptr
    end
    ptr
end

PyJuliaComplexValue_New(x::Complex) = PyJuliaValue_New(PyJuliaComplexValue_Type(), x)
PyJuliaValue_From(x::Complex) = PyJuliaComplexValue_New(x)

const PyJuliaRealValue_Type__ref = Ref(PyNULL)
PyJuliaRealValue_Type() = begin
    ptr = PyJuliaRealValue_Type__ref[]
    if isnull(ptr)
        c = []
        base = PyJuliaNumberValue_Type()
        isnull(base) && return PyNULL
        t = fill(
            PyType_Create(
                c,
                name = "juliacall.RealValue",
                base = base,
                as_number = (float = pyjlreal_float,),
                getset = [
                    (name = "real", get = pyjlreal_real),
                    (name = "imag", get = pyjlreal_imag),
                ],
                methods = [
                    (name = "conjugate", flags = Py_METH_NOARGS, meth = pyjlreal_conjugate),
                    (name = "__complex__", flags = Py_METH_NOARGS, meth = pyjlreal_complex),
                    (name = "__trunc__", flags = Py_METH_NOARGS, meth = pyjlreal_trunc),
                    (name = "__floor__", flags = Py_METH_NOARGS, meth = pyjlreal_floor),
                    (name = "__ceil__", flags = Py_METH_NOARGS, meth = pyjlreal_ceil),
                    (name = "__round__", flags = Py_METH_VARARGS, meth = pyjlreal_round),
                ],
            ),
        )
        ptr = PyPtr(pointer(t))
        err = PyType_Ready(ptr)
        ism1(err) && return PyNULL
        abc = PyRealABC_Type()
        isnull(abc) && return PyNULL
        ism1(PyABC_Register(ptr, abc)) && return PyNULL
        PYJLGCCACHE[ptr] = push!(c, t)
        PyJuliaRealValue_Type__ref[] = ptr
    end
    ptr
end

PyJuliaRealValue_New(x::Real) = PyJuliaValue_New(PyJuliaRealValue_Type(), x)
PyJuliaValue_From(x::Real) = PyJuliaRealValue_New(x)

const PyJuliaRationalValue_Type__ref = Ref(PyNULL)
PyJuliaRationalValue_Type() = begin
    ptr = PyJuliaRationalValue_Type__ref[]
    if isnull(ptr)
        c = []
        base = PyJuliaRealValue_Type()
        isnull(base) && return PyNULL
        t = fill(
            PyType_Create(
                c,
                name = "juliacall.RationalValue",
                base = base,
                getset = [
                    (name = "numerator", get = pyjlrational_numerator),
                    (name = "denominator", get = pyjlrational_denominator),
                ],
            ),
        )
        ptr = PyPtr(pointer(t))
        err = PyType_Ready(ptr)
        ism1(err) && return PyNULL
        abc = PyRationalABC_Type()
        isnull(abc) && return PyNULL
        ism1(PyABC_Register(ptr, abc)) && return PyNULL
        PYJLGCCACHE[ptr] = push!(c, t)
        PyJuliaRationalValue_Type__ref[] = ptr
    end
    ptr
end

PyJuliaRationalValue_New(x::Rational) = PyJuliaValue_New(PyJuliaRationalValue_Type(), x)
PyJuliaValue_From(x::Rational) = PyJuliaRationalValue_New(x)

const PyJuliaIntegerValue_Type__ref = Ref(PyNULL)
PyJuliaIntegerValue_Type() = begin
    ptr = PyJuliaIntegerValue_Type__ref[]
    if isnull(ptr)
        c = []
        base = PyJuliaRealValue_Type()
        isnull(base) && return PyNULL
        t = fill(
            PyType_Create(
                c,
                name = "juliacall.IntegerValue",
                base = base,
                as_number = (
                    int = pyjlinteger_int,
                    index = pyjlinteger_index,
                    invert = pyjlinteger_invert,
                ),
                getset = [
                    (name = "numerator", get = pyjlinteger_numerator),
                    (name = "denominator", get = pyjlinteger_denominator),
                ],
            ),
        )
        ptr = PyPtr(pointer(t))
        err = PyType_Ready(ptr)
        ism1(err) && return PyNULL
        abc = PyIntegralABC_Type()
        isnull(abc) && return PyNULL
        ism1(PyABC_Register(ptr, abc)) && return PyNULL
        PYJLGCCACHE[ptr] = push!(c, t)
        PyJuliaIntegerValue_Type__ref[] = ptr
    end
    ptr
end

PyJuliaIntegerValue_New(x::Integer) = PyJuliaValue_New(PyJuliaIntegerValue_Type(), x)
PyJuliaValue_From(x::Integer) = PyJuliaIntegerValue_New(x)

pyjlnumber_bool(xo::PyPtr) =
    try
        iszero(PyJuliaValue_GetValue(xo)::Number) ? Cint(0) : Cint(1)
    catch err
        PyErr_SetJuliaError(err)
        Cint(-1)
    end

pyjlnumber_positive(xo::PyPtr) =
    try
        PyObject_From(+(PyJuliaValue_GetValue(xo)::Number))
    catch err
        PyErr_SetJuliaError(err)
        PyNULL
    end

pyjlnumber_negative(xo::PyPtr) =
    try
        PyObject_From(-(PyJuliaValue_GetValue(xo)::Number))
    catch err
        PyErr_SetJuliaError(err)
        PyNULL
    end

pyjlnumber_absolute(xo::PyPtr) =
    try
        PyObject_From(abs(PyJuliaValue_GetValue(xo)::Number))
    catch err
        PyErr_SetJuliaError(err)
        PyNULL
    end

struct pyjlnumber_binop{F}
    f::F
end
(f::pyjlnumber_binop)(xo::PyPtr, yo::PyPtr) = begin
    r = PyObject_TryConvert(xo, Number)
    r == -1 && return PyNULL
    r == 0 && return PyNotImplemented_New()
    x = takeresult(Number)
    r = PyObject_TryConvert(yo, Number)
    r == -1 && return PyNULL
    r == 0 && return PyNotImplemented_New()
    y = takeresult(Number)
    try
        PyObject_From(f.f(x, y))
    catch err
        if err isa MethodError && err.f === f.f
            PyNotImplemented_New()
        else
            PyErr_SetJuliaError(err)
            PyNULL
        end
    end
end

pyjlnumber_power(xo::PyPtr, yo::PyPtr, zo::PyPtr) = begin
    r = PyObject_TryConvert(xo, Number)
    r == -1 && return PyNULL
    r == 0 && return PyNotImplemented_New()
    x = takeresult(Number)
    r = PyObject_TryConvert(yo, Number)
    r == -1 && return PyNULL
    r == 0 && return PyNotImplemented_New()
    y = takeresult(Number)
    if PyNone_Check(zo)
        try
            PyObject_From(x^y)
        catch err
            if err isa MethodError && err.f === ^
                PyNotImplemented_New()
            else
                PyErr_SetJuliaError(err)
                PyNULL
            end
        end
    else
        r = PyObject_TryConvert(zo, Number)
        r == -1 && return PyNULL
        r == 0 && return PyNotImplemented_New()
        z = takeresult(Number)
        try
            PyObject_From(powermod(x, y, z))
        catch err
            if err isa MethodError && err.f === powermod
                PyNotImplemented_New()
            else
                PyErr_SetJuliaError(err)
                PyNULL
            end
        end
    end
end

pyjlcomplex_real(xo::PyPtr, ::Ptr{Cvoid}) =
    try
        PyObject_From(real(PyJuliaValue_GetValue(xo)::Complex))
    catch err
        PyErr_SetJuliaError(err)
        PyNULL
    end

pyjlcomplex_imag(xo::PyPtr, ::Ptr{Cvoid}) =
    try
        PyObject_From(imag(PyJuliaValue_GetValue(xo)::Complex))
    catch err
        PyErr_SetJuliaError(err)
        PyNULL
    end

pyjlcomplex_conjugate(xo::PyPtr, ::PyPtr) =
    try
        PyObject_From(conj(PyJuliaValue_GetValue(xo)::Complex))
    catch err
        PyErr_SetJuliaError(err)
        PyNULL
    end

pyjlcomplex_complex(xo::PyPtr, ::PyPtr) =
    try
        PyComplex_From(convert(Complex{Float64}, PyJuliaValue_GetValue(xo)::Complex))
    catch err
        PyErr_SetJuliaError(err)
        PyNULL
    end

pyjlreal_real(xo::PyPtr, ::Ptr{Cvoid}) = (Py_IncRef(xo); xo)

pyjlreal_imag(xo::PyPtr, ::Ptr{Cvoid}) = PyLong_From(0)

pyjlreal_conjugate(xo::PyPtr, ::PyPtr) = (Py_IncRef(xo); xo)

pyjlreal_complex(xo::PyPtr, ::PyPtr) =
    try
        PyComplex_From(convert(Float64, PyJuliaValue_GetValue(xo)::Real))
    catch err
        PyErr_SetJuliaError(err)
        PyNULL
    end

pyjlreal_float(xo::PyPtr) =
    try
        PyFloat_From(convert(Float64, PyJuliaValue_GetValue(xo)::Real))
    catch err
        PyErr_SetJuliaError(err)
        PyNULL
    end

pyjlreal_trunc(xo::PyPtr, ::PyPtr) =
    try
        PyObject_From(trunc(Integer, PyJuliaValue_GetValue(xo)::Real))
    catch err
        PyErr_SetJuliaError(err)
        PyNULL
    end

pyjlreal_floor(xo::PyPtr, ::PyPtr) =
    try
        PyObject_From(floor(Integer, PyJuliaValue_GetValue(xo)::Real))
    catch err
        PyErr_SetJuliaError(err)
        PyNULL
    end

pyjlreal_ceil(xo::PyPtr, ::PyPtr) =
    try
        PyObject_From(ceil(Integer, PyJuliaValue_GetValue(xo)::Real))
    catch err
        PyErr_SetJuliaError(err)
        PyNULL
    end

pyjlreal_round(xo::PyPtr, args::PyPtr) = begin
    ism1(PyArg_CheckNumArgsLe("round", args, 1)) && return PyNULL
    ism1(PyArg_GetArg(Union{Int,Nothing}, "round", args, 0, nothing)) && return PyNULL
    ndigits = takeresult(Union{Int,Nothing})
    x = PyJuliaValue_GetValue(xo)::Real
    try
        if ndigits === nothing
            PyObject_From(round(Integer, x))
        else
            PyObject_From(round(x; digits = ndigits))
        end
    catch err
        PyErr_SetJuliaError(err)
        PyNULL
    end
end

pyjlrational_numerator(xo::PyPtr, ::Ptr{Cvoid}) =
    try
        PyObject_From(numerator(PyJuliaValue_GetValue(xo)::Rational))
    catch err
        PyErr_SetJuliaError(err)
        PyNULL
    end

pyjlrational_denominator(xo::PyPtr, ::Ptr{Cvoid}) =
    try
        PyObject_From(denominator(PyJuliaValue_GetValue(xo)::Rational))
    catch err
        PyErr_SetJuliaError(err)
        PyNULL
    end

pyjlinteger_numerator(xo::PyPtr, ::Ptr{Cvoid}) = (Py_IncRef(xo); xo)

pyjlinteger_denominator(xo::PyPtr, ::Ptr{Cvoid}) = PyLong_From(1)

pyjlinteger_int(xo::PyPtr) = PyLong_From(PyJuliaValue_GetValue(xo)::Integer)

pyjlinteger_index(xo::PyPtr) = PyLong_From(PyJuliaValue_GetValue(xo)::Integer)

pyjlinteger_invert(xo::PyPtr) =
    try
        PyObject_From(~(PyJuliaValue_GetValue(xo)::Integer))
    catch err
        PyErr_SetJuliaError(err)
        PyNULL
    end
