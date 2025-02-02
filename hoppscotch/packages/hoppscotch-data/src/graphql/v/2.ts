import { z } from "zod"
import { defineVersion } from "verzod"
import { GQLHeader, V1_SCHEMA } from "./1"

export const HoppGQLAuthNone = z.object({
  authType: z.literal("none")
})

export type HoppGQLAuthNone = z.infer<typeof HoppGQLAuthNone>

export const HoppGQLAuthBasic = z.object({
  authType: z.literal("basic"),

  username: z.string(),
  password: z.string()
})

export type HoppGQLAuthBasic = z.infer<typeof HoppGQLAuthBasic>

export const HoppGQLAuthBearer = z.object({
  authType: z.literal("bearer"),

  token: z.string()
})

export type HoppGQLAuthBearer = z.infer<typeof HoppGQLAuthBearer>

export const HoppGQLAuthOAuth2 = z.object({
  authType: z.literal("oauth-2"),

  token: z.string(),
  oidcDiscoveryURL: z.string(),
  authURL: z.string(),
  accessTokenURL: z.string(),
  clientID: z.string(),
  scope: z.string()
})

export type HoppGQLAuthOAuth2 = z.infer<typeof HoppGQLAuthOAuth2>

export const HoppGQLAuthAPIKey = z.object({
  authType: z.literal("api-key"),

  key: z.string(),
  value: z.string(),
  addTo: z.string()
})

export type HoppGQLAuthAPIKey = z.infer<typeof HoppGQLAuthAPIKey>

export const HoppGQLAuth = z.discriminatedUnion("authType", [
  HoppGQLAuthNone,
  HoppGQLAuthBasic,
  HoppGQLAuthBearer,
  HoppGQLAuthOAuth2,
  HoppGQLAuthAPIKey
]).and(
  z.object({
    authActive: z.boolean()
  })
)

export type HoppGQLAuth = z.infer<typeof HoppGQLAuth>

const V2_SCHEMA = z.object({
  id: z.optional(z.string()),
  v: z.literal(2),

  name: z.string(),
  url: z.string(),
  headers: z.array(GQLHeader),
  query: z.string(),
  variables: z.string(),

  auth: HoppGQLAuth
})

export default defineVersion({
  initial: false,
  schema: V2_SCHEMA,
  up(old: z.infer<typeof V1_SCHEMA>) {
    return <z.infer<typeof V2_SCHEMA>>{
      ...old,
      v: 2,
      auth: {
        authActive: true,
        authType: "none",
      }
    }
  }
})
