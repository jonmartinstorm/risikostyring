import { NextRequest } from "next/server";

type Ctx = { params: Promise<{ path: string[] }> };

function backendTarget(req: NextRequest, path: string[]) {
  const backend = process.env.BACKEND_INTERNAL_URL ?? "http://backend:4001";
  const target = `${backend}/api/${path.join("/")}`;

  const url = new URL(req.url);
  const targetWithQuery =
    url.search ? `${target}?${url.searchParams.toString()}` : target;

  return targetWithQuery;
}

function passthroughHeaders(res: Response) {
  return {
    "content-type": res.headers.get("content-type") ?? "application/json",
  };
}

export async function GET(req: NextRequest, context: Ctx) {
  const { path } = await context.params;

  const res = await fetch(backendTarget(req, path), {
    headers: {
      accept: req.headers.get("accept") ?? "application/json",
    },
    cache: "no-store",
  });

  return new Response(res.body, {
    status: res.status,
    headers: passthroughHeaders(res),
  });
}

export async function POST(req: NextRequest, context: Ctx) {
  const { path } = await context.params;

  const res = await fetch(backendTarget(req, path), {
    method: "POST",
    headers: {
      "content-type": req.headers.get("content-type") ?? "application/json",
      accept: req.headers.get("accept") ?? "application/json",
    },
    body: await req.text(), // forward raw body
  });

  return new Response(res.body, {
    status: res.status,
    headers: passthroughHeaders(res),
  });
}
