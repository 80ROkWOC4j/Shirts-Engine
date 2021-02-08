#version 460 core
layout (location = 0) in vec3 aPos;
layout (location = 1) in vec3 aNormal;
layout (location = 2) in vec2 aTexCoords;
layout (location = 5) in ivec4 vertexBoneID[2];
layout (location = 6) in vec4 vertexBoneWeights[2];

const int MAX_BONES = 100;

out vec2 TexCoords;
out vec3 worldNormal;
out vec3 worldPos;
out vec3 viewPos;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;
uniform mat4 bones[MAX_BONES];


void main()
{
    mat4 boneTransform = mat4(1.0);
    
    // �ִϸ��̼� ������ �ִٸ�
    if(vertexBoneWeights[0][0] != 0.0)
    {
        boneTransform = bones[vertexBoneID[0][0]] * vertexBoneWeights[0][0];
        boneTransform += bones[vertexBoneID[0][1]] * vertexBoneWeights[0][1];
        boneTransform += bones[vertexBoneID[0][2]] * vertexBoneWeights[0][2];
        boneTransform += bones[vertexBoneID[0][3]] * vertexBoneWeights[0][3];
        boneTransform += bones[vertexBoneID[1][0]] * vertexBoneWeights[1][0];
    }
    // �ִϸ��̼� ������ ���ٸ� boneTransform�� Identity Matrix
 
    vec3 modelPos = vec3(boneTransform * vec4(aPos, 1.0));
 
    // normal�� ���� �����̹Ƿ� vec4(vertexNormal, 0.0f)�� �̿��� translate ���� ����
    // ���� scale ������ ���� �����Ƿ� transpose�� inverse�� �̿��� scale ���� ����
    worldNormal = vec3(transpose(inverse(model)) * vec4(aNormal, 0.0));
    worldNormal = normalize(worldNormal);
 
    worldPos = vec3(model * vec4(modelPos, 1.0));
    viewPos = vec3(view * vec4(worldPos, 1.0));
    TexCoords = aTexCoords;
 
    gl_Position = projection * vec4(viewPos, 1.0);
}