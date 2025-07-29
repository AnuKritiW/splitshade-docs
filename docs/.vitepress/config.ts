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
          { text: 'What is Splitshade?', link: '/introduction/what-is-splitshade' },
          { text: 'Getting Started', link: '/introduction/getting-started' }
        ]
      },
      {
        text: 'Uniforms',
        items: [
          { text: 'iTime', link: '/uniforms/iTime' },
          { text: 'iResolution', link: '/uniforms/iResolution' },
          { text: 'iMouse', link: '/uniforms/iMouse' },
          { text: 'iChannel0–iChannel3', link: '/uniforms/iChannel' }
        ]
      },
      {
        text: 'Textures',
        items: [
          { text: 'What Are Textures?', link: '/textures/what-are-textures' },
          { text: 'Usage', link: '/textures/usage' }
        ]
      },
      {
        text: 'Meshes',
        items: [
          { text: 'What Are Meshes?', link: '/meshes/what-are-meshes' },
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
