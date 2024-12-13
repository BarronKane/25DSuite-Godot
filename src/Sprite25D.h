#pragma once

#include <godot_cpp/classes/sprite3d.hpp>

namespace godot {
    class Sprite25D : public Sprite3D {
        GDCLASS(Sprite25D, Sprite3D)

private:

protected:

    static void _bind_methods();

public:

    Sprite25D();
    ~Sprite25D();

    void _process(double delta) override;
    };
}
