import { defineConfig } from 'vitepress'

export default defineConfig({
  base: '/splitshade-docs/',
  title: 'Splitshade Docs',
  description: 'Guide to using Splitshade WebGPU playground',
  head: [
    ['link', { rel: 'icon', type: 'image/png', href: '/splitshade-docs/icons/shadow.png' }]
  ],
  markdown: {
    lineNumbers: true
  },
  themeConfig: {
    nav: [
      { text: 'Home', link: '/' },
      { text: 'GitHub', link: 'https://github.com/AnuKritiW/splitshade' }
    ],
    sidebar: [
      {
        text: 'Introduction',
        items: [
          { text: 'What is Splitshade?', link: '/introduction/what-is' },
          { text: 'Getting Started', link: '/introduction/getting-started' }
        ]
      },
      {
        text: 'Shaders',
        items: [
          { text: 'Fragment Shaders', link: '/shaders/fragment' },
          { text: 'Vertex Shaders', link: '/shaders/vertex' },
        ]
      },
      {
        text: 'Uniforms',
        items: [
          { text: 'What Are Uniforms?', link: '/uniforms/what-are' },
          { text: 'iResolution', link: '/uniforms/iResolution' },
          { text: 'iMouse', link: '/uniforms/iMouse' },
          { text: 'iTime', link: '/uniforms/iTime' },
          { text: 'iChannel0–iChannel3', link: '/uniforms/iChannel' }
        ]
      },
      {
        text: 'Textures',
        items: [
          { text: 'What Are Textures?', link: '/textures/what-are' },
          { text: 'Texture Usage', link: '/textures/usage' }
        ]
      },
      {
        text: 'Meshes',
        items: [
          { text: 'What is a Mesh?', link: '/meshes/what-is' },
          { text: 'Mesh Usage', link: '/meshes/usage' }
        ]
      },
      {
        text: 'Shader Examples',
        link: '/examples/index'
      }
    ]
  }
})
