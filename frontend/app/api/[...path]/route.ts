import { NextRequest } from "next/server";

export async function GET(
  req: NextRequest,
  context: { params: Promise<{ path: string[] }> }
) {
  const { path } = await context.params;

  const backend = process.env.BACKEND_INTERNAL_URL ?? "http://backend:4001";
  const target = `${backend}/api/${path.join("/")}`;

  // Forward querystring også
  const url = new URL(req.url);
  const targetWithQuery =
    url.search ? `${target}?${url.searchParams.toString()}` : target;

  const res = await fetch(targetWithQuery, {
    headers: {
      // forward litt nyttig info
      accept: req.headers.get("accept") ?? "application/json",
    },
    cache: "no-store",
  });

  return new Response(res.body, {
    status: res.status,
    headers: {
      // Behold content-type om backend setter det
      "content-type": res.headers.get("content-type") ?? "application/json",
    },
  });
}
