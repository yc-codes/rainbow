/* eslint-disable @next/next/no-img-element */
import type { NextPage } from 'next'
import Logo from '../components/icons/logo'
import Section from '../components/section/section'

const Home: NextPage = () => {
  return (
    <div className='overflow-hidden relative'>
      <img src='/bg-blur.png' alt='Rainbow background blur' className='absolute max-w-xl -top-1/4 md:-top-1/4 left-1/2 -translate-x-1/2 dark:opacity-80' style={{ zIndex: -1 }} />
      <main className='w-screen max-w-xl mx-auto'>
        <section className='px-4'>
          <div className="mt-24 py-8 text-center">
            <Logo className='h-32 w-32 bg-white mx-auto shadow-lg rounded-full' style={{ zIndex: 2 }} />
            <h1 className='mt-6 text-4xl font-lexend'>Rainbow</h1>
            <p className='text-gray-600 dark:text-gray-400 mt-1'>Beautiful color palette generator</p>
          </div>
          <div className="text-center mt-4">
            <a href="https://play.google.com/store/apps/details?id=dev.bsteps.rainbow" target="_blank" rel="noreferrer">
              <img src="/play-store.png" alt="download icon" className='inline h-16' />
            </a>
          </div>
        </section>
        <Section title='Features'>
          <ul className='space-y-2 list-disc pl-6'>
            <li><p>🌈 Create beautiful palettes right from your device</p></li>
            <li><p>📕 Save Palettes for later use</p></li>
            <li><p>🎨 Color shades</p></li>
            <li><p>✨ New Animations</p></li>
            <li><p>🏳️‍🌈 RGB and HEX support, more coming on the way</p></li>
            <li><p>📖 Open source</p></li>
            <li><p>🎨 More coming right this weekend</p></li>
          </ul>
        </Section>
        <Section title='Screenshots'>
          <ul className='space-y-2'>
            <li><p>🎨 Create beautiful palettes right from your device</p></li>
            <li><p>🎨 Create beautiful palettes</p></li>
            <li><p>🎨 Create beautiful palettes right from your device</p></li>
            <li><p>🎨 Create beautiful palettes device</p></li>
            <li><p>🎨 right from your device</p></li>
          </ul>
        </Section>
        <Section title='Links'>
          <ul className='space-y-2'>
            <li><p>🎨 Create beautiful palettes right from your device</p></li>
            <li><p>🎨 Create beautiful palettes</p></li>
            <li><p>🎨 Create beautiful palettes right from your device</p></li>
            <li><p>🎨 Create beautiful palettes device</p></li>
            <li><p>🎨 right from your device</p></li>
          </ul>
        </Section>
        <Section title='Socials'>
          <ul className='space-y-2'>
            <li><p>🎨 Create beautiful palettes right from your device</p></li>
            <li><p>🎨 Create beautiful palettes</p></li>
            <li><p>🎨 Create beautiful palettes right from your device</p></li>
            <li><p>🎨 Create beautiful palettes device</p></li>
            <li><p>🎨 right from your device</p></li>
          </ul>
        </Section>
      </main>
      <footer className='mt-80 text-center text-sm text-gray-500 py-4'>
        <p>Copyright &copy; {new Date().getFullYear()} Rainbow. All rights reserved.</p>
      </footer>
    </div>
  )
}

export default Home
