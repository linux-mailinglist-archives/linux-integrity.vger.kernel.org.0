Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841B8309850
	for <lists+linux-integrity@lfdr.de>; Sat, 30 Jan 2021 21:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbhA3Umk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 30 Jan 2021 15:42:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:52266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231969AbhA3Umj (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 30 Jan 2021 15:42:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 490DC64E15;
        Sat, 30 Jan 2021 20:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612039318;
        bh=9mhbseMDeeEPJLa7m3ZtmYfGwikz5Yei33edIsU/u2E=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=U6PbDMYYw8jqrFViOUAxXUtDn74/zqRZpzWAR2YSHQtk4ggv33JrZu9qeZIipTC+f
         iLr0L8PrJNWcUC74SEouluR3iSuWLxsjWHgjceV2KMw6HR46TfNL0poszXDmACZ/FN
         rCkVaPd0EqMvvRmk4gSTieYvWEzuspmzpsmM8IYjMk5LbmWAY7qFYgCc2/epJxL9FL
         CIuGrSWiClvf+l4BGfXlkQRYD1W75aOPimZBnwm638d39+FVbS87RYmSnvAM0MG+lB
         /5mCvuUAU3Zm+EWdSCN+r3NW5PbXHFnkigJPWmyV+I2U7acdl51BzfHaQ+hgdR/6wx
         +8qcPUA/A80bQ==
Message-ID: <aeed663344d3f777780ded82a9b1572c4b6c20d2.camel@kernel.org>
Subject: Re: [PATCH v5 0/5] Enable root to update the blacklist keyring
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Sat, 30 Jan 2021 22:41:54 +0200
In-Reply-To: <20210128191705.3568820-1-mic@digikod.net>
References: <20210128191705.3568820-1-mic@digikod.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.38.3 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

T24gVGh1LCAyMDIxLTAxLTI4IGF0IDIwOjE3ICswMTAwLCBNaWNrYcOrbCBTYWxhw7xuIHdyb3Rl
Ogo+IFRoaXMgZmlmdGggcGF0Y2ggc2VyaWVzIGlzIGEgcmViYXNlIG9uIERhdmlkIEhvd2VsbHMn
cyBrZXlzLW1pc2MgYnJhbmNoLgo+IFRoZSBmaXggcGF0Y2hlcyBhcmUgYWxyZWFkeSBpbiB0aGlz
IGJyYW5jaCBhbmQgdGhlbiByZW1vdmVkIGZyb20gdGhpcwo+IHNlcmllcywgb3RoZXIgcGF0Y2hl
cyBhcmUgdW5jaGFuZ2VkLgo+IAo+IFRoZSBnb2FsIG9mIHRoZXNlIHBhdGNoZXMgaXMgdG8gYWRk
IGEgbmV3IGNvbmZpZ3VyYXRpb24gb3B0aW9uIHRvIGVuYWJsZSB0aGUKPiByb290IHVzZXIgdG8g
bG9hZCBzaWduZWQga2V5cyBpbiB0aGUgYmxhY2tsaXN0IGtleXJpbmcuwqAgVGhpcyBrZXlyaW5n
IGlzIHVzZWZ1bAo+IHRvICJ1bnRydXN0IiBjZXJ0aWZpY2F0ZXMgb3IgZmlsZXMuwqAgRW5hYmxp
bmcgdG8gc2FmZWx5IHVwZGF0ZSB0aGlzIGtleXJpbmcKPiB3aXRob3V0IHJlY29tcGlsaW5nIHRo
ZSBrZXJuZWwgbWFrZXMgaXQgbW9yZSB1c2FibGUuCj4gCj4gUHJldmlvdXMgcGF0Y2ggc2VyaWVz
Ogo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMTAxMjExNTU1MTMuNTM5NTE5LTEt
bWljQGRpZ2lrb2QubmV0Lwo+IAo+IFJlZ2FyZHMsCj4gCj4gTWlja2HDq2wgU2FsYcO8biAoNSk6
Cj4gwqAgdG9vbHMvY2VydHM6IEFkZCBwcmludC1jZXJ0LXRicy1oYXNoLnNoCj4gwqAgY2VydHM6
IENoZWNrIHRoYXQgYnVpbHRpbiBibGFja2xpc3QgaGFzaGVzIGFyZSB2YWxpZAo+IMKgIGNlcnRz
OiBNYWtlIGJsYWNrbGlzdF92ZXRfZGVzY3JpcHRpb24oKSBtb3JlIHN0cmljdAo+IMKgIGNlcnRz
OiBGYWN0b3Igb3V0IHRoZSBibGFja2xpc3QgaGFzaCBjcmVhdGlvbgo+IMKgIGNlcnRzOiBBbGxv
dyByb290IHVzZXIgdG8gYXBwZW5kIHNpZ25lZCBoYXNoZXMgdG8gdGhlIGJsYWNrbGlzdAo+IMKg
wqDCoCBrZXlyaW5nCj4gCj4gwqBNQUlOVEFJTkVSU8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDIgKwo+IMKg
Y2VydHMvLmdpdGlnbm9yZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMSArCj4gwqBjZXJ0cy9LY29uZmlnwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAg
MTcgKy0KPiDCoGNlcnRzL01ha2VmaWxlwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDE1ICstCj4gwqBjZXJ0cy9ibGFja2xp
c3QuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHwgMjA3ICsrKysrKysrKysrKysrLS0tLQo+IMKgY3J5cHRvL2FzeW1tZXRyaWNfa2V5cy94
NTA5X3B1YmxpY19rZXkuY8KgwqDCoMKgwqAgfMKgwqAgMyArLQo+IMKgaW5jbHVkZS9rZXlzL3N5
c3RlbV9rZXlyaW5nLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMTQgKy0K
PiDCoHNjcmlwdHMvY2hlY2stYmxhY2tsaXN0LWhhc2hlcy5hd2vCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHzCoCAzNyArKysrCj4gwqAuLi4vcGxhdGZvcm1fY2VydHMva2V5cmluZ19oYW5kbGVyLmPC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgIDI2ICstLQo+IMKgdG9vbHMvY2VydHMvcHJpbnQtY2VydC10
YnMtaGFzaC5zaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDkxICsrKysrKysrCj4gwqAxMCBm
aWxlcyBjaGFuZ2VkLCAzMzYgaW5zZXJ0aW9ucygrKSwgNzcgZGVsZXRpb25zKC0pCj4gwqBjcmVh
dGUgbW9kZSAxMDA3NTUgc2NyaXB0cy9jaGVjay1ibGFja2xpc3QtaGFzaGVzLmF3awo+IMKgY3Jl
YXRlIG1vZGUgMTAwNzU1IHRvb2xzL2NlcnRzL3ByaW50LWNlcnQtdGJzLWhhc2guc2gKPiAKPiAK
PiBiYXNlLWNvbW1pdDogOGYwYmZjMjVjOTA3ZjM4ZTdmOWRjNDk4ZThmNDMwMDBkNzczMjdlZgoK
SSB0ZXN0ZWQgdGhlc2UsIHNvIHlvdSBib3RoIHJldmlld2VkLWJ5IGFuZCB0ZXN0ZWQtYnkKZnJv
bSBzaWRlIHRvIGFsbC4KCi9KYXJra28KCg==

