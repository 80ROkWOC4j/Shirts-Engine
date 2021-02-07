#pragma once
#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include "shader/Shader.h"
#include "render/VertexArray.h"
#include "render/Texture.h"
#include "render/Camera.h"
#include "render/Model.h"

namespace se
{
	//TODO : �޸� ������ ���߿� ������ �������� ���� �ٲ����, �ؽ��İ����� ���߿� ������Ʈ�� ������
	//TODO : ī�޶� �и� �����ؾ���
	class Game
	{
	public:
		Game();
		~Game();

		auto init()->bool;
		auto run()->void;
		auto terminate()->void;

	public:


	private:
		GLFWwindow* window;
		Shader shader;
		VertexArray* vao;
		Texture texture;
		Model* model;

		void processInput(GLFWwindow* window);
		void load(); //test for load shader, vertex
		bool isRunning = true;
	};
}