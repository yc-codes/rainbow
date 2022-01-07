import { FC } from "react";

export interface sectionProps {
  title?: string
}

const Section: FC<sectionProps> = ({
  title,
  children
}) => {
  return (
    <section className="mt-16 px-6">
      {!!title &&
        <h3 className="font-lexend text-2xl mb-4">{title}</h3>
      }
      <div className="text-gray-800 dark:text-gray-300">
        {children}
      </div>
    </section>
  );
}

export default Section;