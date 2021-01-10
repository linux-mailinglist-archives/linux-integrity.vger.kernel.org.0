Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC692F055D
	for <lists+linux-integrity@lfdr.de>; Sun, 10 Jan 2021 06:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725270AbhAJF2J (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 10 Jan 2021 00:28:09 -0500
Received: from spam.zju.edu.cn ([61.164.42.155]:5440 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725267AbhAJF2I (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 10 Jan 2021 00:28:08 -0500
Received: by ajax-webmail-mail-app4 (Coremail) ; Sun, 10 Jan 2021 13:27:09
 +0800 (GMT+08:00)
X-Originating-IP: [222.205.25.254]
Date:   Sun, 10 Jan 2021 13:27:09 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Eric Biggers" <ebiggers@kernel.org>
Cc:     kjlu@umn.edu, "Mimi Zohar" <zohar@linux.ibm.com>,
        "James Morris" <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Dmitry Kasatkin" <dmitry.kasatkin@nokia.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] evm: Fix memleak in init_desc
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20200917(3e19599d)
 Copyright (c) 2002-2021 www.mailtech.cn zju.edu.cn
In-Reply-To: <X/nixOkNqQdWUAv8@sol.localdomain>
References: <20210109113305.11035-1-dinghao.liu@zju.edu.cn>
 <X/nixOkNqQdWUAv8@sol.localdomain>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <5a36a73a.2e704.176eac332ca.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgC3mR4tkPpfPao_AA--.10866W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgEBBlZdtR6iegABs9
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

PiBPbiBTYXQsIEphbiAwOSwgMjAyMSBhdCAwNzozMzowNVBNICswODAwLCBEaW5naGFvIExpdSB3
cm90ZToKPiA+IFdoZW4ga21hbGxvYygpIGZhaWxzLCB0bXBfdGZtIGFsbG9jYXRlZCBieQo+ID4g
Y3J5cHRvX2FsbG9jX3NoYXNoKCkgaGFzIG5vdCBiZWVuIGZyZWVkLCB3aGljaAo+ID4gbGVhZHMg
dG8gbWVtbGVhay4KPiA+IAo+ID4gRml4ZXM6IGQ0NmViMzY5OTUwMmIgKCJldm06IGNyeXB0byBo
YXNoIHJlcGxhY2VkIGJ5IHNoYXNoIikKPiA+IFNpZ25lZC1vZmYtYnk6IERpbmdoYW8gTGl1IDxk
aW5naGFvLmxpdUB6anUuZWR1LmNuPgo+ID4gLS0tCj4gPiAgc2VjdXJpdHkvaW50ZWdyaXR5L2V2
bS9ldm1fY3J5cHRvLmMgfCA5ICsrKysrKystLQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9zZWN1cml0eS9p
bnRlZ3JpdHkvZXZtL2V2bV9jcnlwdG8uYyBiL3NlY3VyaXR5L2ludGVncml0eS9ldm0vZXZtX2Ny
eXB0by5jCj4gPiBpbmRleCAxNjhjM2I3OGFjNDcuLjM5ZmIzMWE2MzhhYyAxMDA2NDQKPiA+IC0t
LSBhL3NlY3VyaXR5L2ludGVncml0eS9ldm0vZXZtX2NyeXB0by5jCj4gPiArKysgYi9zZWN1cml0
eS9pbnRlZ3JpdHkvZXZtL2V2bV9jcnlwdG8uYwo+ID4gQEAgLTczLDcgKzczLDcgQEAgc3RhdGlj
IHN0cnVjdCBzaGFzaF9kZXNjICppbml0X2Rlc2MoY2hhciB0eXBlLCB1aW50OF90IGhhc2hfYWxn
bykKPiA+ICB7Cj4gPiAgCWxvbmcgcmM7Cj4gPiAgCWNvbnN0IGNoYXIgKmFsZ287Cj4gPiAtCXN0
cnVjdCBjcnlwdG9fc2hhc2ggKip0Zm0sICp0bXBfdGZtOwo+ID4gKwlzdHJ1Y3QgY3J5cHRvX3No
YXNoICoqdGZtLCAqdG1wX3RmbSA9IE5VTEw7Cj4gPiAgCXN0cnVjdCBzaGFzaF9kZXNjICpkZXNj
Owo+ID4gIAo+ID4gIAlpZiAodHlwZSA9PSBFVk1fWEFUVFJfSE1BQykgewo+ID4gQEAgLTExOCwx
MyArMTE4LDE4IEBAIHN0YXRpYyBzdHJ1Y3Qgc2hhc2hfZGVzYyAqaW5pdF9kZXNjKGNoYXIgdHlw
ZSwgdWludDhfdCBoYXNoX2FsZ28pCj4gPiAgYWxsb2M6Cj4gPiAgCWRlc2MgPSBrbWFsbG9jKHNp
emVvZigqZGVzYykgKyBjcnlwdG9fc2hhc2hfZGVzY3NpemUoKnRmbSksCj4gPiAgCQkJR0ZQX0tF
Uk5FTCk7Cj4gPiAtCWlmICghZGVzYykKPiA+ICsJaWYgKCFkZXNjKSB7Cj4gPiArCQlpZiAodG1w
X3RmbSkKPiA+ICsJCQljcnlwdG9fZnJlZV9zaGFzaCh0bXBfdGZtKTsKPiA+ICAJCXJldHVybiBF
UlJfUFRSKC1FTk9NRU0pOwo+ID4gKwl9Cj4gPiAgCj4gPiAgCWRlc2MtPnRmbSA9ICp0Zm07Cj4g
PiAgCj4gPiAgCXJjID0gY3J5cHRvX3NoYXNoX2luaXQoZGVzYyk7Cj4gPiAgCWlmIChyYykgewo+
ID4gKwkJaWYgKHRtcF90Zm0pCj4gPiArCQkJY3J5cHRvX2ZyZWVfc2hhc2godG1wX3RmbSk7Cj4g
PiAgCQlrZnJlZShkZXNjKTsKPiA+ICAJCXJldHVybiBFUlJfUFRSKHJjKTsKPiA+ICAJfQo+IAo+
IFRoZXJlJ3Mgbm8gbmVlZCB0byBjaGVjayBmb3IgTlVMTCBiZWZvcmUgY2FsbGluZyBjcnlwdG9f
ZnJlZV9zaGFzaCgpLgo+IAoKSSBmaW5kIHRoZXJlIGlzIGEgY3J5cHRvX3NoYXNoX3RmbSgpIGlu
IHRoZSBkZWZpbml0aW9uIG9mIApjcnlwdG9fZnJlZV9zaGFzaCgpLiBXaWxsIHRoaXMgbGVhZCB0
byBudWxsIHBvaW50ZXIgZGVyZWZlcmVuY2UKd2hlbiB3ZSB1c2UgaXQgdG8gZnJlZSBhIE5VTEwg
cG9pbnRlcj8KClJlZ2FyZHMsCkRpbmdoYW8=
