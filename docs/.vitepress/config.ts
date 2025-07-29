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
        text: 'Guide',
        items: [
          { text: 'Introduction', link: '/' },
          { text: 'Uniforms', link: '/#uniforms' },
          { text: 'Textures', link: '/#using-textures' },
          { text: 'Meshes', link: '/#using-meshes' }
        ]
      }
    ]
  }
})
