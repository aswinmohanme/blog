%{
  title: "How I built a LateX based resume builder in Phoenix LiveView",
  tags: ~w(elixir phoenix latex),
  description: "This post outlines my experience building out modernresume.io in Phoenix LiveView.",
  draft: true
}
---

I had been in a builder rut for over a year and wanted to get out of it. I decided to build and release a simple product that solves a real need of the hour. A lot of friends were sending me their resumes to share with my network and even though the resume and the career path had enough content, it was not presented beautifully. That's when I thought I could build a replacement using the LaTeX rendering engine I had built for IndiePaper. Thus came the idea of [ModernResume](https://modernresume.io), where you enter your credentials and we typeset a beautiful PDF resume using LaTeX with best practices in mind.

![Screenshot of ModernResume](./images/building-modernresume-demo.png)


## Requirements
