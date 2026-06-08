import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig(({ mode }) => ({
  plugins: [react()],
  define: {
    'process.env.NODE_ENV': JSON.stringify(mode),
  },
  build: {
    lib: {
      entry: 'src/index.ts',
      formats: ['iife'],
      name: 'gpmodelt',
      fileName: () => 'bundle.js',
    },
    outDir: 'dist',
    sourcemap: false,
  },
}));
