/* eslint-disable @next/next/no-img-element */
import type { NextPage } from 'next'
import Logo from '../components/icons/logo'

const Home: NextPage = () => {
  return (
    <div>
      <main className='w-screen overflow-hidden relative'>
        <img src='/bg-blur.png' alt='Rainbow background blur abs' className='absolute top-0 -right-2' style={{ zIndex: -1 }} />
        <section className='px-4'>
          <div className="mt-24 py-8 text-center">
            <Logo className='h-32 w-32 bg-white mx-auto shadow-lg rounded-full' />
            <h1 className='mt-6 text-4xl font-lexend'>Rainbow</h1>
            <p className='text-gray-600 mt-1'>Beautiful color palette generator</p>
          </div>
        </section>
      </main>
      <footer className='pt-80 text-center'>All right reserved</footer>
    </div>
  )
}

export default Home
