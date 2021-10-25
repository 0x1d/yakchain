/* eslint-disable */
import { Reader, Writer } from 'protobufjs/minimal'

export const protobufPackage = '_0x1d.yakchain.yakchain'

export interface QueryPostsRequest {}

export interface QueryPostsResponse {
  title: string
  body: string
}

const baseQueryPostsRequest: object = {}

export const QueryPostsRequest = {
  encode(_: QueryPostsRequest, writer: Writer = Writer.create()): Writer {
    return writer
  },

  decode(input: Reader | Uint8Array, length?: number): QueryPostsRequest {
    const reader = input instanceof Uint8Array ? new Reader(input) : input
    let end = length === undefined ? reader.len : reader.pos + length
    const message = { ...baseQueryPostsRequest } as QueryPostsRequest
    while (reader.pos < end) {
      const tag = reader.uint32()
      switch (tag >>> 3) {
        default:
          reader.skipType(tag & 7)
          break
      }
    }
    return message
  },

  fromJSON(_: any): QueryPostsRequest {
    const message = { ...baseQueryPostsRequest } as QueryPostsRequest
    return message
  },

  toJSON(_: QueryPostsRequest): unknown {
    const obj: any = {}
    return obj
  },

  fromPartial(_: DeepPartial<QueryPostsRequest>): QueryPostsRequest {
    const message = { ...baseQueryPostsRequest } as QueryPostsRequest
    return message
  }
}

const baseQueryPostsResponse: object = { title: '', body: '' }

export const QueryPostsResponse = {
  encode(message: QueryPostsResponse, writer: Writer = Writer.create()): Writer {
    if (message.title !== '') {
      writer.uint32(10).string(message.title)
    }
    if (message.body !== '') {
      writer.uint32(18).string(message.body)
    }
    return writer
  },

  decode(input: Reader | Uint8Array, length?: number): QueryPostsResponse {
    const reader = input instanceof Uint8Array ? new Reader(input) : input
    let end = length === undefined ? reader.len : reader.pos + length
    const message = { ...baseQueryPostsResponse } as QueryPostsResponse
    while (reader.pos < end) {
      const tag = reader.uint32()
      switch (tag >>> 3) {
        case 1:
          message.title = reader.string()
          break
        case 2:
          message.body = reader.string()
          break
        default:
          reader.skipType(tag & 7)
          break
      }
    }
    return message
  },

  fromJSON(object: any): QueryPostsResponse {
    const message = { ...baseQueryPostsResponse } as QueryPostsResponse
    if (object.title !== undefined && object.title !== null) {
      message.title = String(object.title)
    } else {
      message.title = ''
    }
    if (object.body !== undefined && object.body !== null) {
      message.body = String(object.body)
    } else {
      message.body = ''
    }
    return message
  },

  toJSON(message: QueryPostsResponse): unknown {
    const obj: any = {}
    message.title !== undefined && (obj.title = message.title)
    message.body !== undefined && (obj.body = message.body)
    return obj
  },

  fromPartial(object: DeepPartial<QueryPostsResponse>): QueryPostsResponse {
    const message = { ...baseQueryPostsResponse } as QueryPostsResponse
    if (object.title !== undefined && object.title !== null) {
      message.title = object.title
    } else {
      message.title = ''
    }
    if (object.body !== undefined && object.body !== null) {
      message.body = object.body
    } else {
      message.body = ''
    }
    return message
  }
}

/** Query defines the gRPC querier service. */
export interface Query {
  /** Queries a list of posts items. */
  Posts(request: QueryPostsRequest): Promise<QueryPostsResponse>
}

export class QueryClientImpl implements Query {
  private readonly rpc: Rpc
  constructor(rpc: Rpc) {
    this.rpc = rpc
  }
  Posts(request: QueryPostsRequest): Promise<QueryPostsResponse> {
    const data = QueryPostsRequest.encode(request).finish()
    const promise = this.rpc.request('_0x1d.yakchain.yakchain.Query', 'Posts', data)
    return promise.then((data) => QueryPostsResponse.decode(new Reader(data)))
  }
}

interface Rpc {
  request(service: string, method: string, data: Uint8Array): Promise<Uint8Array>
}

type Builtin = Date | Function | Uint8Array | string | number | undefined
export type DeepPartial<T> = T extends Builtin
  ? T
  : T extends Array<infer U>
  ? Array<DeepPartial<U>>
  : T extends ReadonlyArray<infer U>
  ? ReadonlyArray<DeepPartial<U>>
  : T extends {}
  ? { [K in keyof T]?: DeepPartial<T[K]> }
  : Partial<T>
