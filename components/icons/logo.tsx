import * as React from "react"
import { SVGProps } from "react"

const Logo = (props: SVGProps<SVGSVGElement>) => (
  <svg
    width="1em"
    height="1em"
    fill="none"
    viewBox="0 0 256 256"
    xmlns="http://www.w3.org/2000/svg"
    {...props}
  >
    {/* <path fill="#fff" d="M0 0h256v256H0z" /> */}
    <mask
      id="a"
      style={{
        maskType: "alpha",
      }}
      maskUnits="userSpaceOnUse"
      x={40}
      y={40}
      width={176}
      height={176}
    >
      <path
        d="M216 128c0 48.601-29.399 88-78 88s-98-39.399-98-88 29.399-88 78-88 98 39.399 98 88Z"
        fill="#C4C4C4"
      />
    </mask>
    <g mask="url(#a)">
      <path fill="#EF3A3A" d="M220 217H36v-25h184z" />
      <path fill="#FF7F00" d="M220 192H36v-26h184z" />
      <path fill="#FF0" d="M220 166H36v-25h184z" />
      <path fill="#0F0" d="M220 141H36v-25h184z" />
      <path fill="#00F" d="M220 116H36V91h184z" />
      <path fill="#2E2B5F" d="M220 91H36V65h184z" />
      <path fill="#8B00FF" d="M220 65H36V40h184z" />
    </g>
  </svg>
)

export default Logo
