import { defineConfig } from 'vitepress'

export default defineConfig({
  base: '/splitshade-docs/',
  title: 'Splitshade Docs',
  description: 'Guide to using Splitshade WebGPU playground',
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
          { text: 'Usage', link: '/textures/usage' }
        ]
      },
      {
        text: 'Meshes',
        items: [
          { text: 'What Are Meshes?', link: '/meshes/what-are' },
          { text: 'Usage', link: '/meshes/usage' }
        ]
      },
      {
        text: 'Shader Examples',
        link: '/examples/index'
      }
    ]
  }
})
