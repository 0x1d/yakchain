/* eslint-disable */
import { Reader, Writer } from 'protobufjs/minimal';
export const protobufPackage = '_0x1d.yakchain.yakchain';
const baseQueryPostsRequest = {};
export const QueryPostsRequest = {
    encode(_, writer = Writer.create()) {
        return writer;
    },
    decode(input, length) {
        const reader = input instanceof Uint8Array ? new Reader(input) : input;
        let end = length === undefined ? reader.len : reader.pos + length;
        const message = { ...baseQueryPostsRequest };
        while (reader.pos < end) {
            const tag = reader.uint32();
            switch (tag >>> 3) {
                default:
                    reader.skipType(tag & 7);
                    break;
            }
        }
        return message;
    },
    fromJSON(_) {
        const message = { ...baseQueryPostsRequest };
        return message;
    },
    toJSON(_) {
        const obj = {};
        return obj;
    },
    fromPartial(_) {
        const message = { ...baseQueryPostsRequest };
        return message;
    }
};
const baseQueryPostsResponse = { title: '', body: '' };
export const QueryPostsResponse = {
    encode(message, writer = Writer.create()) {
        if (message.title !== '') {
            writer.uint32(10).string(message.title);
        }
        if (message.body !== '') {
            writer.uint32(18).string(message.body);
        }
        return writer;
    },
    decode(input, length) {
        const reader = input instanceof Uint8Array ? new Reader(input) : input;
        let end = length === undefined ? reader.len : reader.pos + length;
        const message = { ...baseQueryPostsResponse };
        while (reader.pos < end) {
            const tag = reader.uint32();
            switch (tag >>> 3) {
                case 1:
                    message.title = reader.string();
                    break;
                case 2:
                    message.body = reader.string();
                    break;
                default:
                    reader.skipType(tag & 7);
                    break;
            }
        }
        return message;
    },
    fromJSON(object) {
        const message = { ...baseQueryPostsResponse };
        if (object.title !== undefined && object.title !== null) {
            message.title = String(object.title);
        }
        else {
            message.title = '';
        }
        if (object.body !== undefined && object.body !== null) {
            message.body = String(object.body);
        }
        else {
            message.body = '';
        }
        return message;
    },
    toJSON(message) {
        const obj = {};
        message.title !== undefined && (obj.title = message.title);
        message.body !== undefined && (obj.body = message.body);
        return obj;
    },
    fromPartial(object) {
        const message = { ...baseQueryPostsResponse };
        if (object.title !== undefined && object.title !== null) {
            message.title = object.title;
        }
        else {
            message.title = '';
        }
        if (object.body !== undefined && object.body !== null) {
            message.body = object.body;
        }
        else {
            message.body = '';
        }
        return message;
    }
};
export class QueryClientImpl {
    constructor(rpc) {
        this.rpc = rpc;
    }
    Posts(request) {
        const data = QueryPostsRequest.encode(request).finish();
        const promise = this.rpc.request('_0x1d.yakchain.yakchain.Query', 'Posts', data);
        return promise.then((data) => QueryPostsResponse.decode(new Reader(data)));
    }
}
