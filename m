Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8102F05C5
	for <lists+linux-integrity@lfdr.de>; Sun, 10 Jan 2021 08:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725385AbhAJHCW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 10 Jan 2021 02:02:22 -0500
Received: from mail.zju.edu.cn ([61.164.42.155]:10710 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725270AbhAJHCW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 10 Jan 2021 02:02:22 -0500
Received: by ajax-webmail-mail-app4 (Coremail) ; Sun, 10 Jan 2021 15:01:02
 +0800 (GMT+08:00)
X-Originating-IP: [222.205.25.254]
Date:   Sun, 10 Jan 2021 15:01:02 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Eric Biggers" <ebiggers@kernel.org>
Cc:     kjlu@umn.edu, "Mimi Zohar" <zohar@linux.ibm.com>,
        "James Morris" <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Dmitry Kasatkin" <dmitry.kasatkin@nokia.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: Re: [PATCH] evm: Fix memleak in init_desc
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20200917(3e19599d)
 Copyright (c) 2002-2021 www.mailtech.cn zju.edu.cn
In-Reply-To: <X/qkcgLg2h8Yxn3a@sol.localdomain>
References: <20210109113305.11035-1-dinghao.liu@zju.edu.cn>
 <X/nixOkNqQdWUAv8@sol.localdomain>
 <5a36a73a.2e704.176eac332ca.Coremail.dinghao.liu@zju.edu.cn>
 <X/qkcgLg2h8Yxn3a@sol.localdomain>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <9626978.2e99b.176eb1925c4.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgC3mR4upvpfClhAAA--.10948W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgoBBlZdtR6iiAACsH
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

PiBPbiBTdW4sIEphbiAxMCwgMjAyMSBhdCAwMToyNzowOVBNICswODAwLCBkaW5naGFvLmxpdUB6
anUuZWR1LmNuIHdyb3RlOgo+ID4gPiBPbiBTYXQsIEphbiAwOSwgMjAyMSBhdCAwNzozMzowNVBN
ICswODAwLCBEaW5naGFvIExpdSB3cm90ZToKPiA+ID4gPiBXaGVuIGttYWxsb2MoKSBmYWlscywg
dG1wX3RmbSBhbGxvY2F0ZWQgYnkKPiA+ID4gPiBjcnlwdG9fYWxsb2Nfc2hhc2goKSBoYXMgbm90
IGJlZW4gZnJlZWQsIHdoaWNoCj4gPiA+ID4gbGVhZHMgdG8gbWVtbGVhay4KPiA+ID4gPiAKPiA+
ID4gPiBGaXhlczogZDQ2ZWIzNjk5NTAyYiAoImV2bTogY3J5cHRvIGhhc2ggcmVwbGFjZWQgYnkg
c2hhc2giKQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IERpbmdoYW8gTGl1IDxkaW5naGFvLmxpdUB6
anUuZWR1LmNuPgo+ID4gPiA+IC0tLQo+ID4gPiA+ICBzZWN1cml0eS9pbnRlZ3JpdHkvZXZtL2V2
bV9jcnlwdG8uYyB8IDkgKysrKysrKy0tCj4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gPiA+ID4gCj4gPiA+ID4gZGlmZiAtLWdpdCBhL3Nl
Y3VyaXR5L2ludGVncml0eS9ldm0vZXZtX2NyeXB0by5jIGIvc2VjdXJpdHkvaW50ZWdyaXR5L2V2
bS9ldm1fY3J5cHRvLmMKPiA+ID4gPiBpbmRleCAxNjhjM2I3OGFjNDcuLjM5ZmIzMWE2MzhhYyAx
MDA2NDQKPiA+ID4gPiAtLS0gYS9zZWN1cml0eS9pbnRlZ3JpdHkvZXZtL2V2bV9jcnlwdG8uYwo+
ID4gPiA+ICsrKyBiL3NlY3VyaXR5L2ludGVncml0eS9ldm0vZXZtX2NyeXB0by5jCj4gPiA+ID4g
QEAgLTczLDcgKzczLDcgQEAgc3RhdGljIHN0cnVjdCBzaGFzaF9kZXNjICppbml0X2Rlc2MoY2hh
ciB0eXBlLCB1aW50OF90IGhhc2hfYWxnbykKPiA+ID4gPiAgewo+ID4gPiA+ICAJbG9uZyByYzsK
PiA+ID4gPiAgCWNvbnN0IGNoYXIgKmFsZ287Cj4gPiA+ID4gLQlzdHJ1Y3QgY3J5cHRvX3NoYXNo
ICoqdGZtLCAqdG1wX3RmbTsKPiA+ID4gPiArCXN0cnVjdCBjcnlwdG9fc2hhc2ggKip0Zm0sICp0
bXBfdGZtID0gTlVMTDsKPiA+ID4gPiAgCXN0cnVjdCBzaGFzaF9kZXNjICpkZXNjOwo+ID4gPiA+
ICAKPiA+ID4gPiAgCWlmICh0eXBlID09IEVWTV9YQVRUUl9ITUFDKSB7Cj4gPiA+ID4gQEAgLTEx
OCwxMyArMTE4LDE4IEBAIHN0YXRpYyBzdHJ1Y3Qgc2hhc2hfZGVzYyAqaW5pdF9kZXNjKGNoYXIg
dHlwZSwgdWludDhfdCBoYXNoX2FsZ28pCj4gPiA+ID4gIGFsbG9jOgo+ID4gPiA+ICAJZGVzYyA9
IGttYWxsb2Moc2l6ZW9mKCpkZXNjKSArIGNyeXB0b19zaGFzaF9kZXNjc2l6ZSgqdGZtKSwKPiA+
ID4gPiAgCQkJR0ZQX0tFUk5FTCk7Cj4gPiA+ID4gLQlpZiAoIWRlc2MpCj4gPiA+ID4gKwlpZiAo
IWRlc2MpIHsKPiA+ID4gPiArCQlpZiAodG1wX3RmbSkKPiA+ID4gPiArCQkJY3J5cHRvX2ZyZWVf
c2hhc2godG1wX3RmbSk7Cj4gPiA+ID4gIAkJcmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7Cj4gPiA+
ID4gKwl9Cj4gPiA+ID4gIAo+ID4gPiA+ICAJZGVzYy0+dGZtID0gKnRmbTsKPiA+ID4gPiAgCj4g
PiA+ID4gIAlyYyA9IGNyeXB0b19zaGFzaF9pbml0KGRlc2MpOwo+ID4gPiA+ICAJaWYgKHJjKSB7
Cj4gPiA+ID4gKwkJaWYgKHRtcF90Zm0pCj4gPiA+ID4gKwkJCWNyeXB0b19mcmVlX3NoYXNoKHRt
cF90Zm0pOwo+ID4gPiA+ICAJCWtmcmVlKGRlc2MpOwo+ID4gPiA+ICAJCXJldHVybiBFUlJfUFRS
KHJjKTsKPiA+ID4gPiAgCX0KPiA+ID4gCj4gPiA+IFRoZXJlJ3Mgbm8gbmVlZCB0byBjaGVjayBm
b3IgTlVMTCBiZWZvcmUgY2FsbGluZyBjcnlwdG9fZnJlZV9zaGFzaCgpLgo+ID4gPiAKPiA+IAo+
ID4gSSBmaW5kIHRoZXJlIGlzIGEgY3J5cHRvX3NoYXNoX3RmbSgpIGluIHRoZSBkZWZpbml0aW9u
IG9mIAo+ID4gY3J5cHRvX2ZyZWVfc2hhc2goKS4gV2lsbCB0aGlzIGxlYWQgdG8gbnVsbCBwb2lu
dGVyIGRlcmVmZXJlbmNlCj4gPiB3aGVuIHdlIHVzZSBpdCB0byBmcmVlIGEgTlVMTCBwb2ludGVy
Pwo+ID4gCj4gCj4gTm8uICBJdCBkb2VzICZ0Zm0tPmJhc2UsIG5vdCB0Zm0tPmJhc2UuCj4gCgpU
aGFuayB5b3UgZm9yIHlvdXIgYWR2aWNlISBJIHdpbGwgcmVzZW5kIGEgbmV3IHBhdGNoIHNvb24u
CgpSZWdhcmRzLApEaW5naGFv
