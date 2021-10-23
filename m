Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA77438129
	for <lists+linux-integrity@lfdr.de>; Sat, 23 Oct 2021 02:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhJWAui (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 22 Oct 2021 20:50:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbhJWAui (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Oct 2021 20:50:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADB5F6101C;
        Sat, 23 Oct 2021 00:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634950100;
        bh=kbtNHfGbGhSMTAw0+cA9930pf9e1d4ODVtDxLJB8ts0=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=Eo8NRWz4J4aoPfPJ2sLX/Xrbd8+vVzacRcBGYaC9WBuZFnUcrew6/6//GZeuq8O2C
         htN23e6J3Q39RBFAS1DqXxIkQZHS0Y3YFPwj35yEkRbXfwq18VaLc4+akTbmegKa61
         QFkDW3igonoSEBFsbbIKyixv6VOIKcSmE0CUPd5UUqDAIbg46od8rLrcDXwIfEYzxP
         M31o7JQvj69xmboEk2A1IIfALhcDrpiV4q7usN9F8+IfUKLw4hwQkubO4xQNHuxpz+
         ekIbOSY7ZPdDliovD/MLBeP08CcI1j1Jb8gQrRZIUZ2+EzRhs7V2Dz1MblFasLw//m
         xF89ZSZqBo7+Q==
Message-ID: <f5c87a233027c8026ae8574f3e25c9162da3bfff.camel@kernel.org>
Subject: Re: [PATCH v2 1/2] crypto: use SM3 instead of SM3_256
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
Date:   Sat, 23 Oct 2021 03:48:17 +0300
In-Reply-To: <20211019100423.43615-2-tianjia.zhang@linux.alibaba.com>
References: <20211019100423.43615-1-tianjia.zhang@linux.alibaba.com>
         <20211019100423.43615-2-tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

T24gVHVlLCAyMDIxLTEwLTE5IGF0IDE4OjA0ICswODAwLCBUaWFuamlhIFpoYW5nIHdyb3RlOgo+
IEFjY29yZGluZyB0byBodHRwczovL3Rvb2xzLmlldGYub3JnL2lkL2RyYWZ0LW9zY2NhLWNmcmct
c20zLTAxLmh0bWwsCj4gU00zIGFsd2F5cyBwcm9kdWNlcyBhIDI1Ni1iaXQgaGFzaCB2YWx1ZSBh
bmQgdGhlcmUgYXJlIG5vIHBsYW5zIGZvcgo+IG90aGVyIGxlbmd0aCBkZXZlbG9wbWVudCwgc28g
dGhlcmUgaXMgbm8gYW1iaWd1aXR5IGluIHRoZSBuYW1lIG9mIHNtMy4KPiAKPiBTdWdnZXN0ZWQt
Ynk6IEphbWVzIEJvdHRvbWxleSA8amVqYkBsaW51eC5pYm0uY29tPgo+IFNpZ25lZC1vZmYtYnk6
IFRpYW5qaWEgWmhhbmcgPHRpYW5qaWEuemhhbmdAbGludXguYWxpYmFiYS5jb20+Cj4gLS0tCj4g
wqBEb2N1bWVudGF0aW9uL3NlY3VyaXR5L2tleXMvdHJ1c3RlZC1lbmNyeXB0ZWQucnN0IHwgMiAr
LQo+IMKgY3J5cHRvL2hhc2hfaW5mby5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA0ICsrLS0KPiDCoGRyaXZlcnMvY2hhci90
cG0vdHBtMi1jbWQuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHwgMiArLQo+IMKgaW5jbHVkZS9jcnlwdG8vaGFzaF9pbmZvLmjCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMiArLQo+IMKgaW5jbHVkZS91YXBpL2xpbnV4
L2hhc2hfaW5mby5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAzICsr
LQo+IMKgc2VjdXJpdHkva2V5cy90cnVzdGVkLWtleXMvdHJ1c3RlZF90cG0yLmPCoMKgwqDCoMKg
wqDCoMKgIHwgMiArLQo+IMKgNiBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDcgZGVs
ZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vc2VjdXJpdHkva2V5cy90
cnVzdGVkLWVuY3J5cHRlZC5yc3QgYi9Eb2N1bWVudGF0aW9uL3NlY3VyaXR5L2tleXMvdHJ1c3Rl
ZC1lbmNyeXB0ZWQucnN0Cj4gaW5kZXggODBkNWE1YWY2MmExLi4zMjkyNDYxNTE3ZjYgMTAwNjQ0
Cj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9zZWN1cml0eS9rZXlzL3RydXN0ZWQtZW5jcnlwdGVkLnJz
dAo+ICsrKyBiL0RvY3VtZW50YXRpb24vc2VjdXJpdHkva2V5cy90cnVzdGVkLWVuY3J5cHRlZC5y
c3QKPiBAQCAtMTYyLDcgKzE2Miw3IEBAIFVzYWdlOjoKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZGVmYXVsdCAxIChyZXNlYWxpbmcgYWxsb3dlZCkKPiDCoMKg
wqDCoMKgwqDCoCBoYXNoPcKgwqDCoMKgwqDCoMKgwqAgaGFzaCBhbGdvcml0aG0gbmFtZSBhcyBh
IHN0cmluZy4gRm9yIFRQTSAxLnggdGhlIG9ubHkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgYWxsb3dlZCB2YWx1ZSBpcyBzaGExLiBGb3IgVFBNIDIueCB0aGUg
YWxsb3dlZCB2YWx1ZXMKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBhcmUgc2hhMSwgc2hhMjU2LCBzaGEzODQsIHNoYTUxMiBhbmQgc20zLTI1Ni4KPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhcmUgc2hhMSwgc2hhMjU2LCBzaGEz
ODQsIHNoYTUxMiBhbmQgc20zLgoKWW91IGNhbm5vdCByZW1vdmUgc20zLTI1NiBmcm9tIHVhcGku
CgovSmFya2tvCgo=

