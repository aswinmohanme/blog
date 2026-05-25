%{
  title: "AI is turning Engineers into Farmers, Doctors and Gardeners",
  tags: ~w(ai),
  description: "Unlike engineers who create every intricate function of a codebase, we are now akin to farmers who grow codebases, doctors who make changes on these systems which they have not created and gardeners who try to the same process of farming to make the change.",
  draft: false
}

---

Think about software engineering before 2022. We were building systems from the ground up. We knew how complex systems worked because we were the ones building it. Even if we didn't have an idea about the entirety of the system, we knew people who we could ask. Even if we took years to interact with the codebase again, a few hours of digging around would bring back the fond memories of its creation.

When dealing with legacy codebases, we would experiment, we would observe its results and then make more changes. But every subsequent change was ours, every change would improve our comprehension of the codebase and our command over the codebase. Like Theseus's ship, every change made this foreign object closer to us, closer to something we created. We were literal gods, reveling in the art of creation.

We now grow codebases from the seeds of a single prompt. Big complex trees, small personal plants, everything is grown instead of created. We throw the seeds and pay tax to magic AI entities to accelerate the process. The entities could only make funny looking weeds first, but they scaled themselves to produce trees that produce fruits that we can sell for money. The part of creation of these plants accelerated. And the magic entities became in such high demand that the village is skewing its own economy to pay them to grow more trees.

Generating code is an order of magnitude faster than writing it by hand, constrained only by the amount of money you can spend on tokens. The amount of time and conscious effort required also fell by a magnitude, seen by the rise of brain rot IDEs that play short form video content while agents do the farming.

This would have been great, if the output exactly matched the spec of what was required. But that isn't the case as a sufficiently detailed spec is the code itself. So we have prompts which are an approximation of the requirements. Since the code is generated from an approximate prompt, we require change to make it conform to our requirements.

If we had expended the engineering effort to create the system by hand, we would have been rewarded with the comprehension required to make the change. But the generated code is foreign to us in the same way legacy code is. There we turn from farmers into doctors.

Doctors who work on the human body, work on a complex system they did not create. They do not have access to colleagues who have created the system. So they learn about the system and then experiment. They make the best effort changes, observe the effects of those changes, tune their future experiments based on the results and share the learnings with themselves and their peers. This is the same process we go through when we create changes in codebases that we did not create. We learn about the system and then we experiment. We make changes, observe the effects and improve the change and if the effect was not to be expected, revert the change and try again.

Contrast this to us making the change in a system we created. We would have an idea about the different parts, how they interact, the warts of the system, its breaking points. All this because we were gifted this comprehension as a result of the work we put into the system. We would know what change to do, how the change would affect the other parts of the system and what's the most sensible part for this change to be. Even if a significant amount of time has passed between the act of creation and our revisit, we would still be in a much better place served by our fuzzy memory. Rather than wandering around in a new place without a map in the night, we would be wandering around in a place at night we have visited at least one time, and sometimes more. This makes making changes in a system you created a much more enjoyable process aided by a continuous improvement in capability. Instead we have to traverse a new unknown system.

What if we use AI to make the change instead of doing it ourselves? If we try to make the change by ourselves, our comprehension of the system improves on every subsequent change. If we offload that to the AI system that grew the codebase, we become much more similar to gardeners. Gardeners try to change the plants, by trimming, tending, and budding. If we want blue flowers instead of yellow, we bud the branch of the system and hope the forces that govern the growth of the system pushes into the direction where we want the change to happen. We lose much more control, effectively curtailing our ability to change the system to our nuanced requirement to a process similar to praying, effectively requesting our AI models again and again to generate a feasible output that we require.

AI based code generation is incredible. The fact that we could replicate a highly specialized comprehension heavy endeavour of coding into a repeatable easily generatable commodity speaks to the entire capability of humans as a whole. But every change has a price, we are paying it with a loss of capability. We were gods once and we are mere mortals now, which kind of made the act of coding far less enjoyable.

If we expand this across a team who leans heavily towards code-generation, in a while we end up with a foreign codebase that is maintained by a development team with zero comprehension about it, with sufficiently degraded coding ability. This would make for a brittle system, that is grown instead of built, and changed by experimentation and not a thorough understanding of the whole. This would lead to slower change velocity down the line, and much more security issues and hard to fix bugs. The only solution is hand-writing code. 

I am building [Cycle](https://usecycle.co), an all-in-one financial platform for SMBs. Instead of code farming, 95% of the code is written by hand, with claude code chipping in to help with mundane tasks such as splitting a react component into better components. This has given me much higher comprehension in a complex system that would handle the financial aspects of our customers. Also this has made the whole process of coding much more enjoyable, to pre-AI levels. Is it the right thing to do? I do think so. 

The tech-stack is Elixir, Phoenix and Inertia, which gives an incredible velocity for a solo-developer working on this part-time. But at the same time writing by hand gives more ideas about the system as a whole, where improvements could be made, and how the system could be improved, both as a coding artifact and as a business product. It also improves me as a developer. It also helps me design much more coherent features. I consider that an earned competitive advantage that would make every subsequent change easier.


This opinion might change with the advent of truly capable AI agents which can generate a system that would be perfect from the start, which would require no changes. Until then I think the loss of comprehension is an incredibly high price to pay for product velocity. I do not want to work with a process that reduces my comprehension every time I use it making future changes incredibly hard to do. Until that day I am going with artisanal, free range code.

## Footnotes
* Reading this might give you the impression that I hold farmers and gardeners in less regard to engineers, which is untrue. I feel gratitude for farmers every time I have a hearty meal and my mother is an extensive gardener. This is more of a piece on the loss of capability of engineers.
