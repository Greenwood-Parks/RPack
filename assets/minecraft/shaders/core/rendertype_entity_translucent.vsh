#version 150

#moj_import <light.glsl>
#moj_import <fog.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV1;
in ivec2 UV2;
in vec3 Normal;

uniform sampler2D Sampler0;
uniform sampler2D Sampler1;
uniform sampler2D Sampler2;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform mat3 IViewRotMat;
uniform int FogShape;

uniform vec3 Light0_Direction;
uniform vec3 Light1_Direction;

out float vertexDistance;
out vec4 vertexColor;
out vec4 lightMapColor;
out vec4 overlayColor;
out vec2 texCoord0;
out vec4 normal;

void main() {
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);

    vertexDistance = fog_distance(ModelViewMat, IViewRotMat * Position, FogShape);
    vertexColor = minecraft_mix_light(Light0_Direction, Light1_Direction, Normal, Color);
    lightMapColor = texelFetch(Sampler2, UV2 / 16, 0);
    overlayColor = texelFetch(Sampler1, UV1, 0);
    normal = ProjMat * ModelViewMat * vec4(Normal, 0.0);
    vec4 marker = texture(Sampler0, vec2(63.5/64, 0));
    bool slim = false;

    // red: enable
    if (marker != vec4(1, 0, 0, 1)) {
        // green: enable (slim)
        if (marker != vec4(0, 1, 0, 1)) {
            // anything else: disable
            texCoord0 = UV0;
            return;
        }
        slim = true;
    }

    int id = (gl_VertexID / 4) % 72;

    switch (id) {
        case 0:
            texCoord0 = vec2(0.3125, 0.125) + UV0 * vec2(0.5, 1.5);
            break;
        case 1:
            texCoord0 = vec2(0.25, 0.125) + UV0 * vec2(0.5, 1.5);
            break;
        case 2:
        case 3:
            texCoord0 = vec2(0.1875, 0.25) + UV0 * vec2(1.0, 0.5);
            break;
        case 4:
            texCoord0 = vec2(0.1875, 0.125) + UV0 * vec2(1.0, 1.5);
            break;
        case 5:
            texCoord0 = vec2(0.125, 0.125) + UV0 * vec2(1.0, 1.5);
            break;
        case 6:
            texCoord0 = vec2(0.0625, 0.375) + UV0 * vec2(0.5, 1.5);
            break;
        case 7:
            texCoord0 = vec2(0.0, 0.375) + UV0 * vec2(0.5, 1.5);
            break;
        case 8:
        case 9:
            texCoord0 = vec2(-0.3125, 0.5) + UV0 * vec2(1.0, 0.5);
            break;
        case 10:
            texCoord0 = vec2(-0.3125, 0.375) + UV0 * vec2(1.0, 1.5);
            break;
        case 11:
            texCoord0 = vec2(-0.375, 0.375) + UV0 * vec2(1.0, 1.5);
            break;
        case 24:
        case 25:
        case 28:
        case 29:
        case 30:
        case 31:
        case 34:
        case 35:
            texCoord0 = vec2(0.5, 0.625) + UV0 * vec2(0.5, 1.5);
            break;
        case 26:
        case 27:
        case 32:
        case 33:
            texCoord0 = vec2(0.5, 0.75) + UV0 * vec2(0.5, 0.5);
            break;
        case 36:
        case 37:
        case 40:
        case 41:
            texCoord0 = vec2(0.625, 0.125) + UV0 * vec2(0.5, 1.5);
            break;
        case 38:
        case 39:
            texCoord0 = vec2(0.625, 0.25) + UV0 * vec2(0.5, 0.5);
            break;
        case 42:
        case 43:
        case 46:
        case 47:
            texCoord0 = vec2(0.375, 0.375) + UV0 * vec2(0.5, 1.5);
            break;
        case 44:
        case 45:
            texCoord0 = vec2(0.375, 0.5) + UV0 * vec2(0.5, 0.5);
            break;
        case 48:
        case 49:
        case 52:
        case 53:
            texCoord0 = vec2(0.25, 0.625) + UV0 * vec2(0.5, 1.5);
            break;
        case 50:
        case 51:
            texCoord0 = vec2(0.25, 0.75) + UV0 * vec2(0.5, 0.5);
            break;
        case 54:
        case 55:
        case 58:
        case 59:
            texCoord0 = vec2(-0.25, 0.625) + UV0 * vec2(0.5, 1.5);
            break;
        case 56:
        case 57:
            texCoord0 = vec2(-0.25, 0.75) + UV0 * vec2(0.5, 0.5);
            break;
        case 60:
        case 61:
        case 64:
        case 65:
            texCoord0 = vec2(0.0, 0.125) + UV0 * vec2(0.5, 1.5);
            break;
        case 62:
        case 63:
            texCoord0 = vec2(0.0, 0.25) + UV0 * vec2(0.5, 0.5);
            break;
        case 66:
        case 67:
        case 70:
        case 71:
            texCoord0 = vec2(-0.25, 0.375) + UV0 * vec2(0.5, 1.5);
            break;
        case 68:
        case 69:
            texCoord0 = vec2(-0.25, 0.5) + UV0 * vec2(0.5, 0.5);
            break;
        default:
            texCoord0 = UV0;
            break;
    }

    if (slim) {
        switch (id) {
            case 24:
            case 30:
                texCoord0 = vec2(0.484375, 0.625) + UV0 * vec2(0.5, 1.5);
                break;
            case 25:
            case 31:
                texCoord0 = vec2(0.5, 0.625) + UV0 * vec2(0.5, 1.5);
                break;
            case 26:
            case 27:
                texCoord0 = vec2(0.515625, 0.75) + UV0 * vec2(0.375, 0.5);
                break;
            case 28:
                texCoord0 = vec2(0.515625, 0.625) + UV0 * vec2(0.375, 1.5);
                break;
            case 29:
                texCoord0 = vec2(0.53125, 0.625) + UV0 * vec2(0.375, 1.5);
                break;
            case 32:
            case 33:
                texCoord0 = vec2(0.578125, 0.75) + UV0 * vec2(0.375, 0.5);
                break;
            case 34:
                texCoord0 = vec2(0.578125, 0.625) + UV0 * vec2(0.375, 1.5);
                break;
            case 35:
                texCoord0 = vec2(0.59375, 0.625) + UV0 * vec2(0.375, 1.5);
                break;
            case 36:
                texCoord0 = vec2(0.609375, 0.125) + UV0 * vec2(0.5, 1.5);
                break;
            case 37:
                texCoord0 = vec2(0.625, 0.125) + UV0 * vec2(0.5, 1.5);
                break;
            case 38:
            case 39:
                texCoord0 = vec2(0.640625, 0.25) + UV0 * vec2(0.375, 0.5);
                break;
            case 40:
                texCoord0 = vec2(0.640625, 0.125) + UV0 * vec2(0.375, 1.5);
                break;
            case 41:
                texCoord0 = vec2(0.65625, 0.125) + UV0 * vec2(0.375, 1.5);
                break;
            case 42:
                texCoord0 = vec2(0.359375, 0.375) + UV0 * vec2(0.5, 1.5);
                break;
            case 43:
                texCoord0 = vec2(0.375, 0.375) + UV0 * vec2(0.5, 1.5);
                break;
            case 44:
            case 45:
                texCoord0 = vec2(0.453125, 0.5) + UV0 * vec2(0.375, 0.5);
                break;
            case 46:
                texCoord0 = vec2(0.453125, 0.375) + UV0 * vec2(0.375, 1.5);
                break;
            case 47:
                texCoord0 = vec2(0.46875, 0.375) + UV0 * vec2(0.375, 1.5);
                break;
            default:
                break;
        }
    }
}
