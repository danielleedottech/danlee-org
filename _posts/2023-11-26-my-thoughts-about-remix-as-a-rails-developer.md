<!--

*

* 

-->

## Introduction

I started live streaming on my YouTube channel, trying to create a Remix/Rails app as I learned Remix for the first during the stream. So, I am not an experienced or knowledgeable Remix JS developer. However, after spending four to five hours with it during my live stream and a few hours just researching and learning the technology, I have some thoughts.

A quick introduction to my background is that I have been developing web applications using Rails/Django/and mostly client-rendered react (with some server-rendered configurations). This post is an opinion piece about Remix from the mental model of mainly using Rails in production.

## Pros of Remix

Remix is actually a great framework. I do see a lot of benefits of using Remix in production. Remix's greatest strength is its elegant mental model that builds upon fundamental react knowledge and browser/HTTP standards. One of the things I want to highlight about this elegance is the ability to conduct progressive enhancement in your Remix applications. Because it builds upon HTTP form posts and server-rendered UI, you can create applications without client-side JavaScript. This meshes well if your mental model heavily prefers writing applications in JSX and NodeJS.

**Note**: Not running any client-side javascript is a real constraint, especially regarding security and privacy concerns. (Think of applications that exist on the dark web.)

I also want to highlight Remix's default configuration regarding the server rendering of React UI. I have worked in different companies where they tried to roll out their own server-side rendered configuration, and it usually takes time to understand, is inelegant, and is hard to extend with new features and behavior. It's tough to write server-rendered react configuration elegantly, and it is really freeing not having to deal with it by using Remix.

**Note:** Server-rendered UI mostly has "won" over client-rendered UI. This is why these frameworks like NextJS and Remix are needed in the current React landscape. Most applications in the wild do not need the crazy interactivity promised by client-only UI libraries/frameworks.

I believe that Remix will do really well in enterprise level projects where there are a plethora of backend teams at your organization and the backend for your UI only serves as a thin proxy/middleware layer, like mentioned orthogonally here: https://remix.run/docs/en/main/guides/bff (More on this in the con section of remix)

## Cons of Remix

As a massive fan of Rails and frameworks of its kind, Remix lacks backend conventions and mental models. This is understandable because, in today's day and age, there are a variety of different backend architectures, technologies, and mental models (SQL vs. NoSQL, tables, documents vs graph databases, monoliths vs. microservices, rest vs. graphql vs grpc, backend as a service (firebase), lambda functions/serverless)

**Note:** That being said, I think most thought leaders in the space have agreed that SQL-backed applications have "won," it would have been nice if Remix had some conventions around this. However, I want to highlight that Remix is excellent as a server-side rendering framework but lacking as a full-stack framework. I think it is intentional that the Remix team has no conventions regarding databases and backend engineering.


Remix is excellent if you like writing JSX, but it's lackluster if you don't like writing JSX. Unlike the conversations about server-rendered UI vs client-rendered UI, it's not clear that JSX is the best templating engine to write your markup (it's not clear it has "won" the debate). We assume it's the best way to write your markup because it's tied to the most popular UI library, but there might be a strong argument that different templating engines are better (Svelte, ERB, HAML, Blade).

Suppose I am going to write a server-rendered UI HTML-based client, and I also have to write my backend logic myself. In that case, I don't see the point of not using a more fully featured and opinionated server-side framework like Rails/Phoenix/Laravel. I think, if anything, the developer experience of these frameworks  is way better (ESPECIALLY if the team writing the UI is also writing the backend/database logic). I think this point holds doubly true if you know for a fact that there is a tight coupling between your backend logic, your data, and your UI.

## Conclusion

These are my thoughts on Remix as of right now, with 8 hours of experience. I will keep trying this framework for my personal live stream project because it holds promise as a server-rendered UI framework. In today's engineering landscape, being familiar with server-rendered React UI development is an asset. Even though I believe that conventional full-stack frameworks with opinionated Javascript setups are superior for smaller companies, Remix has a promising future in enterprise-level UI development where there are multiple backends, and the backends are loosely coupled with your UI.

