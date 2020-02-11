Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C72F158C62
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Feb 2020 11:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgBKKJb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Feb 2020 05:09:31 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2405 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727805AbgBKKJb (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Feb 2020 05:09:31 -0500
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 9FD8776429BD6D5698F8;
        Tue, 11 Feb 2020 10:09:28 +0000 (GMT)
Received: from fraeml702-chm.china.huawei.com (10.206.15.51) by
 LHREML711-CAH.china.huawei.com (10.201.108.34) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 11 Feb 2020 10:09:28 +0000
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Tue, 11 Feb 2020 11:09:27 +0100
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1713.004;
 Tue, 11 Feb 2020 11:09:27 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v3 2/8] ima: Switch to ima_hash_algo for boot aggregate
Thread-Topic: [PATCH v3 2/8] ima: Switch to ima_hash_algo for boot aggregate
Thread-Index: AQHV3/kpNT3OoKRF00CRxabm/9u1E6gU8McAgADT8jA=
Date:   Tue, 11 Feb 2020 10:09:27 +0000
Message-ID: <6955307747034265bd282bf68c368f34@huawei.com>
References: <20200210100048.21448-1-roberto.sassu@huawei.com>
         <20200210100048.21448-3-roberto.sassu@huawei.com>
 <1581373420.5585.920.camel@linux.ibm.com>
In-Reply-To: <1581373420.5585.920.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.220.96.108]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaW1pIFpvaGFyIFttYWlsdG86
em9oYXJAbGludXguaWJtLmNvbV0NCj4gU2VudDogTW9uZGF5LCBGZWJydWFyeSAxMCwgMjAyMCAx
MToyNCBQTQ0KPiBUbzogUm9iZXJ0byBTYXNzdSA8cm9iZXJ0by5zYXNzdUBodWF3ZWkuY29tPjsN
Cj4gSmFtZXMuQm90dG9tbGV5QEhhbnNlblBhcnRuZXJzaGlwLmNvbTsNCj4gamFya2tvLnNha2tp
bmVuQGxpbnV4LmludGVsLmNvbQ0KPiBDYzogbGludXgtaW50ZWdyaXR5QHZnZXIua2VybmVsLm9y
ZzsgbGludXgtc2VjdXJpdHktbW9kdWxlQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgU2lsdml1IFZsYXNjZWFudQ0KPiA8U2lsdml1LlZsYXNjZWFudUBo
dWF3ZWkuY29tPjsgc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHYzIDIvOF0gaW1hOiBTd2l0Y2ggdG8gaW1hX2hhc2hfYWxnbyBmb3IgYm9vdA0KPiBhZ2dyZWdh
dGUNCj4gDQo+IE9uIE1vbiwgMjAyMC0wMi0xMCBhdCAxMTowMCArMDEwMCwgUm9iZXJ0byBTYXNz
dSB3cm90ZToNCj4gPiBib290X2FnZ3JlZ2F0ZSBpcyB0aGUgZmlyc3QgZW50cnkgb2YgSU1BIG1l
YXN1cmVtZW50IGxpc3QuIEl0cyBwdXJwb3NlIGlzDQo+ID4gdG8gbGluayBwcmUtYm9vdCBtZWFz
dXJlbWVudHMgdG8gSU1BIG1lYXN1cmVtZW50cy4gQXMgSU1BIHdhcw0KPiBkZXNpZ25lZCB0bw0K
PiA+IHdvcmsgd2l0aCBhIFRQTSAxLjIsIHRoZSBTSEExIFBDUiBiYW5rIHdhcyBhbHdheXMgc2Vs
ZWN0ZWQuDQo+ID4NCj4gPiBDdXJyZW50bHksIGV2ZW4gaWYgYSBUUE0gMi4wIGlzIHVzZWQsIHRo
ZSBTSEExIFBDUiBiYW5rIGlzIHNlbGVjdGVkLg0KPiA+IEhvd2V2ZXIsIHRoZSBhc3N1bXB0aW9u
IHRoYXQgdGhlIFNIQTEgUENSIGJhbmsgaXMgYWx3YXlzIGF2YWlsYWJsZSBpcyBub3QNCj4gPiBj
b3JyZWN0LCBhcyBQQ1IgYmFua3MgY2FuIGJlIHNlbGVjdGVkIHdpdGggdGhlIFBDUl9BbGxvY2F0
ZSgpIFRQTQ0KPiBjb21tYW5kLg0KPiA+DQo+ID4gVGhpcyBwYXRjaCB0cmllcyB0byB1c2UgaW1h
X2hhc2hfYWxnbyBhcyBoYXNoIGFsZ29yaXRobSBmb3INCj4gYm9vdF9hZ2dyZWdhdGUuDQo+ID4g
SWYgbm8gUENSIGJhbmsgdXNlcyB0aGF0IGFsZ29yaXRobSwgdGhlIHBhdGNoIHRyaWVzIHRvIGZp
bmQgdGhlIFNIQTI1NiBQQ1INCj4gPiBiYW5rICh3aGljaCBpcyBtYW5kYXRvcnkgaW4gdGhlIFRD
RyBQQyBDbGllbnQgc3BlY2lmaWNhdGlvbikuDQo+IA0KPiBVcCB0byBoZXJlLCB0aGUgcGF0Y2gg
ZGVzY3JpcHRpb24gbWF0Y2hlcyB0aGUgY29kZS4NCj4gPiBJZiBhbHNvIHRoaXMNCj4gPiBiYW5r
IGlzIG5vdCBmb3VuZCwgdGhlIHBhdGNoIHNlbGVjdHMgdGhlIGZpcnN0IG9uZS4gSWYgdGhlIFRQ
TSBhbGdvcml0aG0NCj4gPiBvZiB0aGF0IGJhbmsgaXMgbm90IG1hcHBlZCB0byBhIGNyeXB0byBJ
RCwgYm9vdF9hZ2dyZWdhdGUgaXMgc2V0IHRvIHplcm8uDQo+IA0KPiBUaGlzIGNvbW1lbnQgYW5k
IHRoZSBvbmUgaW5saW5lIGFyZSBsZWZ0IG92ZXIgZnJvbSBwcmV2aW91cyB2ZXJzaW9uLg0KDQpI
aSBNaW1pDQoNCmFjdHVhbGx5IHRoZSBjb2RlIGRvZXMgd2hhdCBpcyBkZXNjcmliZWQgYWJvdmUu
IGJhbmtfaWR4IGlzIGluaXRpYWxseQ0Kc2V0IHRvIHplcm8gYW5kIHJlbWFpbnMgYXMgaXQgaXMg
aWYgdGhlcmUgaXMgbm8gUENSIGJhbmsgZm9yIHRoZSBkZWZhdWx0DQpJTUEgYWxnb3JpdGhtIG9y
IFNIQTI1Ni4NCg0KUm9iZXJ0bw0KDQpIVUFXRUkgVEVDSE5PTE9HSUVTIER1ZXNzZWxkb3JmIEdt
YkgsIEhSQiA1NjA2Mw0KTWFuYWdpbmcgRGlyZWN0b3I6IExpIFBlbmcsIExpIEppYW4sIFNoaSBZ
YW5saQ0KDQo+ID4gQ2hhbmdlbG9nDQo+ID4NCj4gPiB2MToNCj4gPiAtIGFkZCBNaW1pJ3MgY29t
bWVudHMNCj4gPiAtIGlmIHRoZXJlIGlzIG5vIFBDUiBiYW5rIGZvciB0aGUgSU1BIGRlZmF1bHQg
YWxnb3JpdGhtIHVzZSBTSEEyNTYNCj4gPiAgIChzdWdnZXN0ZWQgYnkgSmFtZXMgQm90dG9tbGV5
KQ0KPiA+DQo+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcgIyA1LjEueA0KPiA+IEZpeGVz
OiA4NzliNTg5MjEwYTkgKCJ0cG06IHJldHJpZXZlIGRpZ2VzdCBzaXplIG9mIHVua25vd24gYWxn
b3JpdGhtcw0KPiB3aXRoIFBDUiByZWFkIikNCj4gPiBSZXBvcnRlZC1ieTogSmVycnkgU25pdHNl
bGFhciA8anNuaXRzZWxAcmVkaGF0LmNvbT4NCj4gPiBTdWdnZXN0ZWQtYnk6IEphbWVzIEJvdHRv
bWxleQ0KPiA8SmFtZXMuQm90dG9tbGV5QEhhbnNlblBhcnRuZXJzaGlwLmNvbT4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBSb2JlcnRvIFNhc3N1IDxyb2JlcnRvLnNhc3N1QGh1YXdlaS5jb20+DQo+IA0K
PiBUaGFua3MsIFJvYmVydG8uIMKgVGhpcyBwYXRjaCBpcyBkZXBlbmRlbnQgb24gMS84LiDCoEFz
IHNvb24gYXMgdGhlcmUncw0KPiBhIHRvcGljIGJyYW5jaCwgSSdsbCBxdWV1ZSB0aGlzLCByZW1v
dmluZyB0aGUgZXh0cmFuZW91cyBjb21tZW50cy4NCj4gDQo+IE1pbWkNCj4gDQo+ID4gLS0tDQo+
ID4gIHNlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX2NyeXB0by5jIHwgNDUNCj4gKysrKysrKysr
KysrKysrKysrKysrKysrKy0tLS0NCj4gPiAgc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfaW5p
dC5jICAgfCAyMiArKysrKysrKysrLS0tLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDU2IGluc2Vy
dGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL3NlY3VyaXR5
L2ludGVncml0eS9pbWEvaW1hX2NyeXB0by5jDQo+IGIvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9p
bWFfY3J5cHRvLmMNCj4gPiBpbmRleCA3MzA0NGZjNmE5NTIuLmYyZjQxYTJiYzNkNCAxMDA2NDQN
Cj4gPiAtLS0gYS9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9jcnlwdG8uYw0KPiA+ICsrKyBi
L3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX2NyeXB0by5jDQo+ID4gQEAgLTY1NSwxOCArNjU1
LDI5IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBpbWFfcGNycmVhZCh1MzIgaWR4LCBzdHJ1Y3QNCj4g
dHBtX2RpZ2VzdCAqZCkNCj4gPiAgfQ0KPiA+DQo+ID4gIC8qDQo+ID4gLSAqIENhbGN1bGF0ZSB0
aGUgYm9vdCBhZ2dyZWdhdGUgaGFzaA0KPiA+ICsgKiBUaGUgYm9vdF9hZ2dyZWdhdGUgaXMgYSBj
dW11bGF0aXZlIGhhc2ggb3ZlciBUUE0gcmVnaXN0ZXJzIDAgLSA3Lg0KPiBXaXRoDQo+ID4gKyAq
IFRQTSAxLjIgdGhlIGJvb3RfYWdncmVnYXRlIHdhcyBiYXNlZCBvbiByZWFkaW5nIHRoZSBTSEEx
IFBDUnMsIGJ1dA0KPiB3aXRoDQo+ID4gKyAqIFRQTSAyLjAgaGFzaCBhZ2lsaXR5LCBUUE0gY2hp
cHMgY291bGQgc3VwcG9ydCBtdWx0aXBsZSBUUE0gUENSIGJhbmtzLA0KPiA+ICsgKiBhbGxvd2lu
ZyBmaXJtd2FyZSB0byBjb25maWd1cmUgYW5kIGVuYWJsZSBkaWZmZXJlbnQgYmFua3MuDQo+ID4g
KyAqDQo+ID4gKyAqIEtub3dpbmcgd2hpY2ggVFBNIGJhbmsgaXMgcmVhZCB0byBjYWxjdWxhdGUg
dGhlIGJvb3RfYWdncmVnYXRlDQo+IGRpZ2VzdA0KPiA+ICsgKiBuZWVkcyB0byBiZSBjb252ZXll
ZCB0byBhIHZlcmlmaWVyLiAgRm9yIHRoaXMgcmVhc29uLCB1c2UgdGhlIHNhbWUNCj4gPiArICog
aGFzaCBhbGdvcml0aG0gZm9yIHJlYWRpbmcgdGhlIFRQTSBQQ1JzIGFzIGZvciBjYWxjdWxhdGlu
ZyB0aGUgYm9vdA0KPiA+ICsgKiBhZ2dyZWdhdGUgZGlnZXN0IGFzIHN0b3JlZCBpbiB0aGUgbWVh
c3VyZW1lbnQgbGlzdC4NCj4gPiAgICovDQo+ID4gLXN0YXRpYyBpbnQgX19pbml0IGltYV9jYWxj
X2Jvb3RfYWdncmVnYXRlX3RmbShjaGFyICpkaWdlc3QsDQo+ID4gK3N0YXRpYyBpbnQgX19pbml0
IGltYV9jYWxjX2Jvb3RfYWdncmVnYXRlX3RmbShjaGFyICpkaWdlc3QsIHUxNiBhbGdfaWQsDQo+
ID4gIAkJCQkJICAgICAgc3RydWN0IGNyeXB0b19zaGFzaCAqdGZtKQ0KPiA+ICB7DQo+ID4gLQlz
dHJ1Y3QgdHBtX2RpZ2VzdCBkID0geyAuYWxnX2lkID0gVFBNX0FMR19TSEExLCAuZGlnZXN0ID0g
ezB9IH07DQo+ID4gKwlzdHJ1Y3QgdHBtX2RpZ2VzdCBkID0geyAuYWxnX2lkID0gYWxnX2lkLCAu
ZGlnZXN0ID0gezB9IH07DQo+ID4gIAlpbnQgcmM7DQo+ID4gIAl1MzIgaTsNCj4gPiAgCVNIQVNI
X0RFU0NfT05fU1RBQ0soc2hhc2gsIHRmbSk7DQo+ID4NCj4gPiAgCXNoYXNoLT50Zm0gPSB0Zm07
DQo+ID4NCj4gPiArCXByX2RldmVsKCJjYWxjdWxhdGluZyB0aGUgYm9vdC1hZ2dyZWdhdGUgYmFz
ZWQgb24gVFBNDQo+IGJhbms6ICUwNHhcbiIsDQo+ID4gKwkJIGQuYWxnX2lkKTsNCj4gPiArDQo+
ID4gIAlyYyA9IGNyeXB0b19zaGFzaF9pbml0KHNoYXNoKTsNCj4gPiAgCWlmIChyYyAhPSAwKQ0K
PiA+ICAJCXJldHVybiByYzsNCj4gPiBAQCAtNjc1LDcgKzY4Niw4IEBAIHN0YXRpYyBpbnQgX19p
bml0IGltYV9jYWxjX2Jvb3RfYWdncmVnYXRlX3RmbShjaGFyDQo+ICpkaWdlc3QsDQo+ID4gIAlm
b3IgKGkgPSBUUE1fUENSMDsgaSA8IFRQTV9QQ1I4OyBpKyspIHsNCj4gPiAgCQlpbWFfcGNycmVh
ZChpLCAmZCk7DQo+ID4gIAkJLyogbm93IGFjY3VtdWxhdGUgd2l0aCBjdXJyZW50IGFnZ3JlZ2F0
ZSAqLw0KPiA+IC0JCXJjID0gY3J5cHRvX3NoYXNoX3VwZGF0ZShzaGFzaCwgZC5kaWdlc3QsDQo+
IFRQTV9ESUdFU1RfU0laRSk7DQo+ID4gKwkJcmMgPSBjcnlwdG9fc2hhc2hfdXBkYXRlKHNoYXNo
LCBkLmRpZ2VzdCwNCj4gPiArCQkJCQkgY3J5cHRvX3NoYXNoX2RpZ2VzdHNpemUodGZtKSk7DQo+
ID4gIAl9DQo+ID4gIAlpZiAoIXJjKQ0KPiA+ICAJCWNyeXB0b19zaGFzaF9maW5hbChzaGFzaCwg
ZGlnZXN0KTsNCj4gPiBAQCAtNjg1LDE0ICs2OTcsMzUgQEAgc3RhdGljIGludCBfX2luaXQNCj4g
aW1hX2NhbGNfYm9vdF9hZ2dyZWdhdGVfdGZtKGNoYXIgKmRpZ2VzdCwNCj4gPiAgaW50IF9faW5p
dCBpbWFfY2FsY19ib290X2FnZ3JlZ2F0ZShzdHJ1Y3QgaW1hX2RpZ2VzdF9kYXRhICpoYXNoKQ0K
PiA+ICB7DQo+ID4gIAlzdHJ1Y3QgY3J5cHRvX3NoYXNoICp0Zm07DQo+ID4gLQlpbnQgcmM7DQo+
ID4gKwl1MTYgY3J5cHRvX2lkLCBhbGdfaWQ7DQo+ID4gKwlpbnQgcmMsIGksIGJhbmtfaWR4ID0g
MDsNCj4gPiArDQo+ID4gKwlmb3IgKGkgPSAwOyBpIDwgaW1hX3RwbV9jaGlwLT5ucl9hbGxvY2F0
ZWRfYmFua3M7IGkrKykgew0KPiA+ICsJCWNyeXB0b19pZCA9IGltYV90cG1fY2hpcC0+YWxsb2Nh
dGVkX2JhbmtzW2ldLmNyeXB0b19pZDsNCj4gPiArCQlpZiAoY3J5cHRvX2lkID09IGhhc2gtPmFs
Z28pIHsNCj4gPiArCQkJYmFua19pZHggPSBpOw0KPiA+ICsJCQlicmVhazsNCj4gPiArCQl9DQo+
ID4gKw0KPiA+ICsJCWlmIChjcnlwdG9faWQgPT0gSEFTSF9BTEdPX1NIQTI1NikNCj4gPiArCQkJ
YmFua19pZHggPSBpOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCWlmIChiYW5rX2lkeCA9PSAwICYm
DQo+ID4gKwkgICAgaW1hX3RwbV9jaGlwLT5hbGxvY2F0ZWRfYmFua3NbMF0uY3J5cHRvX2lkID09
DQo+IEhBU0hfQUxHT19fTEFTVCkgew0KPiA+ICsJCXByX2VycigiTm8gc3VpdGFibGUgVFBNIGFs
Z29yaXRobSBmb3IgYm9vdCBhZ2dyZWdhdGVcbiIpOw0KPiA+ICsJCXJldHVybiAwOw0KPiA+ICsJ
fQ0KPiA+ICsNCj4gPiArCWhhc2gtPmFsZ28gPSBpbWFfdHBtX2NoaXAtPmFsbG9jYXRlZF9iYW5r
c1tiYW5rX2lkeF0uY3J5cHRvX2lkOw0KPiA+DQo+ID4gIAl0Zm0gPSBpbWFfYWxsb2NfdGZtKGhh
c2gtPmFsZ28pOw0KPiA+ICAJaWYgKElTX0VSUih0Zm0pKQ0KPiA+ICAJCXJldHVybiBQVFJfRVJS
KHRmbSk7DQo+ID4NCj4gPiAgCWhhc2gtPmxlbmd0aCA9IGNyeXB0b19zaGFzaF9kaWdlc3RzaXpl
KHRmbSk7DQo+ID4gLQlyYyA9IGltYV9jYWxjX2Jvb3RfYWdncmVnYXRlX3RmbShoYXNoLT5kaWdl
c3QsIHRmbSk7DQo+ID4gKwlhbGdfaWQgPSBpbWFfdHBtX2NoaXAtPmFsbG9jYXRlZF9iYW5rc1ti
YW5rX2lkeF0uYWxnX2lkOw0KPiA+ICsJcmMgPSBpbWFfY2FsY19ib290X2FnZ3JlZ2F0ZV90Zm0o
aGFzaC0+ZGlnZXN0LCBhbGdfaWQsIHRmbSk7DQo+ID4NCj4gPiAgCWltYV9mcmVlX3RmbSh0Zm0p
Ow0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX2luaXQu
Yw0KPiBiL3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX2luaXQuYw0KPiA+IGluZGV4IDVkNTVh
ZGU1ZjNiOS4uZmJkN2E4ZTI4YTZiIDEwMDY0NA0KPiA+IC0tLSBhL3NlY3VyaXR5L2ludGVncml0
eS9pbWEvaW1hX2luaXQuYw0KPiA+ICsrKyBiL3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX2lu
aXQuYw0KPiA+IEBAIC0yNyw3ICsyNyw3IEBAIHN0cnVjdCB0cG1fY2hpcCAqaW1hX3RwbV9jaGlw
Ow0KPiA+ICAvKiBBZGQgdGhlIGJvb3QgYWdncmVnYXRlIHRvIHRoZSBJTUEgbWVhc3VyZW1lbnQg
bGlzdCBhbmQgZXh0ZW5kDQo+ID4gICAqIHRoZSBQQ1IgcmVnaXN0ZXIuDQo+ID4gICAqDQo+ID4g
LSAqIENhbGN1bGF0ZSB0aGUgYm9vdCBhZ2dyZWdhdGUsIGEgU0hBMSBvdmVyIHRwbSByZWdpc3Rl
cnMgMC03LA0KPiA+ICsgKiBDYWxjdWxhdGUgdGhlIGJvb3QgYWdncmVnYXRlLCBhIGhhc2ggb3Zl
ciB0cG0gcmVnaXN0ZXJzIDAtNywNCj4gPiAgICogYXNzdW1pbmcgYSBUUE0gY2hpcCBleGlzdHMs
IGFuZCB6ZXJvZXMgaWYgdGhlIFRQTSBjaGlwIGRvZXMgbm90DQo+ID4gICAqIGV4aXN0LiAgQWRk
IHRoZSBib290IGFnZ3JlZ2F0ZSBtZWFzdXJlbWVudCB0byB0aGUgbWVhc3VyZW1lbnQNCj4gPiAg
ICogbGlzdCBhbmQgZXh0ZW5kIHRoZSBQQ1IgcmVnaXN0ZXIuDQo+ID4gQEAgLTUxLDE1ICs1MSwy
NyBAQCBzdGF0aWMgaW50IF9faW5pdCBpbWFfYWRkX2Jvb3RfYWdncmVnYXRlKHZvaWQpDQo+ID4g
IAlpbnQgdmlvbGF0aW9uID0gMDsNCj4gPiAgCXN0cnVjdCB7DQo+ID4gIAkJc3RydWN0IGltYV9k
aWdlc3RfZGF0YSBoZHI7DQo+ID4gLQkJY2hhciBkaWdlc3RbVFBNX0RJR0VTVF9TSVpFXTsNCj4g
PiArCQljaGFyIGRpZ2VzdFtUUE1fTUFYX0RJR0VTVF9TSVpFXTsNCj4gPiAgCX0gaGFzaDsNCj4g
Pg0KPiA+ICAJbWVtc2V0KGlpbnQsIDAsIHNpemVvZigqaWludCkpOw0KPiA+ICAJbWVtc2V0KCZo
YXNoLCAwLCBzaXplb2YoaGFzaCkpOw0KPiA+ICAJaWludC0+aW1hX2hhc2ggPSAmaGFzaC5oZHI7
DQo+ID4gLQlpaW50LT5pbWFfaGFzaC0+YWxnbyA9IEhBU0hfQUxHT19TSEExOw0KPiA+IC0JaWlu
dC0+aW1hX2hhc2gtPmxlbmd0aCA9IFNIQTFfRElHRVNUX1NJWkU7DQo+ID4gLQ0KPiA+ICsJaWlu
dC0+aW1hX2hhc2gtPmFsZ28gPSBpbWFfaGFzaF9hbGdvOw0KPiA+ICsJaWludC0+aW1hX2hhc2gt
Pmxlbmd0aCA9IGhhc2hfZGlnZXN0X3NpemVbaW1hX2hhc2hfYWxnb107DQo+ID4gKw0KPiA+ICsJ
LyoNCj4gPiArCSAqIFdpdGggVFBNIDIuMCBoYXNoIGFnaWxpdHksIFRQTSBjaGlwcyBjb3VsZCBz
dXBwb3J0IG11bHRpcGxlIFRQTQ0KPiA+ICsJICogUENSIGJhbmtzLCBhbGxvd2luZyBmaXJtd2Fy
ZSB0byBjb25maWd1cmUgYW5kIGVuYWJsZSBkaWZmZXJlbnQNCj4gPiArCSAqIGJhbmtzLiAgVGhl
IFNIQTEgYmFuayBpcyBub3QgbmVjZXNzYXJpbHkgZW5hYmxlZC4NCj4gPiArCSAqDQo+ID4gKwkg
KiBVc2UgdGhlIHNhbWUgaGFzaCBhbGdvcml0aG0gZm9yIHJlYWRpbmcgdGhlIFRQTSBQQ1JzIGFz
IGZvcg0KPiA+ICsJICogY2FsY3VsYXRpbmcgdGhlIGJvb3QgYWdncmVnYXRlIGRpZ2VzdC4gIFBy
ZWZlcmVuY2UgaXMgZ2l2ZW4gdG8NCj4gPiArCSAqIHRoZSBjb25maWd1cmVkIElNQSBkZWZhdWx0
IGhhc2ggYWxnb3JpdGhtLiAgT3RoZXJ3aXNlLCB1c2UgdGhlDQo+ID4gKwkgKiBUUE0gcmVxdWly
ZWQgYmFua3MgLSBTSEEyNTYgZm9yIFRQTSAyLjAsIFNIQTEgZm9yIFRQTSAxLjIuIElmDQo+ID4g
KwkgKiBTSEEyNTYgaXMgbm90IGF2YWlsYWJsZSwgdXNlIHRoZSBmaXJzdCBQQ1IgYmFuayBhbmQg
aWYgdGhhdCBpcw0KPiA+ICsJICogbm90IG1hcHBlZCB0byBhIGNyeXB0byBJRCwgc2V0IGJvb3Rf
YWdncmVnYXRlIHRvIHplcm8uDQo+IA0KPiBUaGUgbGFzdCBsaW5lIG9mIHRoZSBhYm92ZSBjb21t
ZW50IGlzIGxlZnQgb3ZlciBmcm9tIHRoZSBwcmV2aW91cw0KPiB2ZXJzaW9uLg0KPiANCj4gPiAr
CSAqLw0KPiA+ICAJaWYgKGltYV90cG1fY2hpcCkgew0KPiA+ICAJCXJlc3VsdCA9IGltYV9jYWxj
X2Jvb3RfYWdncmVnYXRlKCZoYXNoLmhkcik7DQo+ID4gIAkJaWYgKHJlc3VsdCA8IDApIHsNCg0K
