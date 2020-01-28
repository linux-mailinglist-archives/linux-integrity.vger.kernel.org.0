Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9031214BDC1
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Jan 2020 17:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgA1QbM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 28 Jan 2020 11:31:12 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2321 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726257AbgA1QbM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 28 Jan 2020 11:31:12 -0500
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id D57BD114EA464F2BBF81;
        Tue, 28 Jan 2020 16:31:09 +0000 (GMT)
Received: from fraeml703-chm.china.huawei.com (10.206.15.52) by
 lhreml702-cah.china.huawei.com (10.201.108.43) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 28 Jan 2020 16:31:09 +0000
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Tue, 28 Jan 2020 17:31:08 +0100
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1713.004;
 Tue, 28 Jan 2020 17:31:08 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
CC:     Jerry Snitselaar <jsnitsel@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: RE: [PATCH 2/2] ima: support calculating the boot_aggregate based on
 different TPM banks
Thread-Topic: [PATCH 2/2] ima: support calculating the boot_aggregate based on
 different TPM banks
Thread-Index: AQHV1SsuUuwpXjLewk6D/BEn4qmmH6gAHIeggAAK9wCAAB1bAA==
Date:   Tue, 28 Jan 2020 16:31:08 +0000
Message-ID: <7dac65691a5848c69009aff7db7fdb2d@huawei.com>
References: <1580140919-6127-1-git-send-email-zohar@linux.ibm.com>
         <1580140919-6127-2-git-send-email-zohar@linux.ibm.com>
         <465015d0c9ca4e278ed32f78eb3eb4a4@huawei.com>
 <1580226042.5088.90.camel@linux.ibm.com>
In-Reply-To: <1580226042.5088.90.camel@linux.ibm.com>
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
em9oYXJAbGludXguaWJtLmNvbV0NCj4gU2VudDogVHVlc2RheSwgSmFudWFyeSAyOCwgMjAyMCA0
OjQxIFBNDQo+IFRvOiBSb2JlcnRvIFNhc3N1IDxyb2JlcnRvLnNhc3N1QGh1YXdlaS5jb20+OyBs
aW51eC0NCj4gaW50ZWdyaXR5QHZnZXIua2VybmVsLm9yZw0KPiBDYzogSmVycnkgU25pdHNlbGFh
ciA8anNuaXRzZWxAcmVkaGF0LmNvbT47IEphbWVzIEJvdHRvbWxleQ0KPiA8SmFtZXMuQm90dG9t
bGV5QEhhbnNlblBhcnRuZXJzaGlwLmNvbT47IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBTaWx2aXUgVmxhc2NlYW51IDxTaWx2aXUuVmxhc2NlYW51QGh1YXdlaS5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggMi8yXSBpbWE6IHN1cHBvcnQgY2FsY3VsYXRpbmcgdGhlIGJvb3Rf
YWdncmVnYXRlIGJhc2VkDQo+IG9uIGRpZmZlcmVudCBUUE0gYmFua3MNCj4gDQo+IE9uIFR1ZSwg
MjAyMC0wMS0yOCBhdCAxNDoxOSArMDAwMCwgUm9iZXJ0byBTYXNzdSB3cm90ZToNCj4gPiA+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBsaW51eC1pbnRlZ3JpdHktb3du
ZXJAdmdlci5rZXJuZWwub3JnIFttYWlsdG86bGludXgtaW50ZWdyaXR5LQ0KPiA+ID4gb3duZXJA
dmdlci5rZXJuZWwub3JnXSBPbiBCZWhhbGYgT2YgTWltaSBab2hhcg0KPiA+ID4gU2VudDogTW9u
ZGF5LCBKYW51YXJ5IDI3LCAyMDIwIDU6MDIgUE0NCj4gPiA+IFRvOiBsaW51eC1pbnRlZ3JpdHlA
dmdlci5rZXJuZWwub3JnDQo+ID4gPiBDYzogSmVycnkgU25pdHNlbGFhciA8anNuaXRzZWxAcmVk
aGF0LmNvbT47IEphbWVzIEJvdHRvbWxleQ0KPiA+ID4gPEphbWVzLkJvdHRvbWxleUBIYW5zZW5Q
YXJ0bmVyc2hpcC5jb20+OyBsaW51eC0NCj4gPiA+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IE1p
bWkgWm9oYXIgPHpvaGFyQGxpbnV4LmlibS5jb20+DQo+ID4gPiBTdWJqZWN0OiBbUEFUQ0ggMi8y
XSBpbWE6IHN1cHBvcnQgY2FsY3VsYXRpbmcgdGhlIGJvb3RfYWdncmVnYXRlIGJhc2VkDQo+IG9u
DQo+ID4gPiBkaWZmZXJlbnQgVFBNIGJhbmtzDQo+ID4gPg0KPiA+ID4gQ2FsY3VsYXRpbmcgdGhl
IGJvb3RfYWdncmVnYXRlIGF0dGVtcHRzIHRvIHJlYWQgdGhlIFRQTSBTSEExIGJhbmssDQo+ID4g
PiBhc3N1bWluZyBpdCBpcyBhbHdheXMgZW5hYmxlZC4gIFdpdGggVFBNIDIuMCBoYXNoIGFnaWxp
dHksIFRQTSBjaGlwcw0KPiA+ID4gY291bGQgc3VwcG9ydCBtdWx0aXBsZSBUUE0gUENSIGJhbmtz
LCBhbGxvd2luZyBmaXJtd2FyZSB0byBjb25maWd1cmUNCj4gYW5kDQo+ID4gPiBlbmFibGUgZGlm
ZmVyZW50IGJhbmtzLg0KPiA+ID4NCj4gPiA+IEluc3RlYWQgb2YgaGFyZCBjb2RpbmcgdGhlIFRQ
TSAyLjAgYmFuayBoYXNoIGFsZ29yaXRobSB1c2VkIGZvcg0KPiBjYWxjdWxhdGluZw0KPiA+ID4g
dGhlIGJvb3QtYWdncmVnYXRlLCBzZWUgaWYgdGhlIGNvbmZpZ3VyZWQgSU1BX0RFRkFVTFRfSEFT
SA0KPiBhbGdvcml0aG0gaXMNCj4gPiA+IGFuIGFsbG9jYXRlZCBUUE0gYmFuaywgb3RoZXJ3aXNl
IHVzZSB0aGUgZmlyc3QgYWxsb2NhdGVkIFRQTSBiYW5rLg0KPiA+ID4NCj4gPiA+IEZvciBUUE0g
MS4yIFNIQTEgaXMgdGhlIG9ubHkgc3VwcG9ydGVkIGhhc2ggYWxnb3JpdGhtLg0KPiA+ID4NCj4g
PiA+IFJlcG9ydGVkLWJ5OiBKZXJyeSBTbml0c2VsYWFyIDxqc25pdHNlbEByZWRoYXQuY29tPg0K
PiA+ID4gU2lnbmVkLW9mZi1ieTogTWltaSBab2hhciA8em9oYXJAbGludXguaWJtLmNvbT4NCj4g
PiA+IC0tLQ0KPiA+ID4gIHNlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX2NyeXB0by5jIHwgMzcN
Cj4gPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gPiA+ICAxIGZp
bGUgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4NCj4gPiA+
IGRpZmYgLS1naXQgYS9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9jcnlwdG8uYw0KPiA+ID4g
Yi9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9jcnlwdG8uYw0KPiA+ID4gaW5kZXggNzk2N2E2
OTA0ODUxLi5iMWIyNmQ2MWYxNzQgMTAwNjQ0DQo+ID4gPiAtLS0gYS9zZWN1cml0eS9pbnRlZ3Jp
dHkvaW1hL2ltYV9jcnlwdG8uYw0KPiA+ID4gKysrIGIvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9p
bWFfY3J5cHRvLmMNCj4gPiA+IEBAIC02NTYsOCArNjU2LDI1IEBAIHN0YXRpYyB2b2lkIF9faW5p
dCBpbWFfcGNycmVhZCh1MzIgaWR4LCBzdHJ1Y3QNCj4gPiA+IHRwbV9kaWdlc3QgKmQpDQo+ID4g
PiAgCQlwcl9lcnIoIkVycm9yIENvbW11bmljYXRpbmcgdG8gVFBNIGNoaXBcbiIpOw0KPiA+ID4g
IH0NCj4gPiA+DQo+ID4gPiArLyogdHBtMl9oYXNoX21hcCBpcyB0aGUgc2FtZSBhcyBkZWZpbmVk
IGluIHRwbTItY21kLmMgYW5kDQo+ID4gPiB0cnVzdGVkX3RwbTIuYyAqLw0KPiA+ID4gK3N0YXRp
YyBzdHJ1Y3QgdHBtMl9oYXNoIHRwbTJfaGFzaF9tYXBbXSA9IHsNCj4gPiA+ICsJe0hBU0hfQUxH
T19TSEExLCBUUE1fQUxHX1NIQTF9LA0KPiA+ID4gKwl7SEFTSF9BTEdPX1NIQTI1NiwgVFBNX0FM
R19TSEEyNTZ9LA0KPiA+ID4gKwl7SEFTSF9BTEdPX1NIQTM4NCwgVFBNX0FMR19TSEEzODR9LA0K
PiA+ID4gKwl7SEFTSF9BTEdPX1NIQTUxMiwgVFBNX0FMR19TSEE1MTJ9LA0KPiA+ID4gKwl7SEFT
SF9BTEdPX1NNM18yNTYsIFRQTV9BTEdfU00zXzI1Nn0sDQo+ID4gPiArfTsNCj4gPiA+ICsNCj4g
PiA+ICAvKg0KPiA+ID4gLSAqIENhbGN1bGF0ZSB0aGUgYm9vdCBhZ2dyZWdhdGUgaGFzaA0KPiA+
ID4gKyAqIFRoZSBib290X2FnZ3JlZ2F0ZSBpcyBhIGN1bXVsYXRpdmUgaGFzaCBvdmVyIFRQTSBy
ZWdpc3RlcnMgMCAtIDcuDQo+IFdpdGgNCj4gPiA+ICsgKiBUUE0gMi4wIGhhc2ggYWdpbGl0eSwg
VFBNIGNoaXBzIGNvdWxkIHN1cHBvcnQgbXVsdGlwbGUgVFBNIFBDUg0KPiBiYW5rcywNCj4gPiA+
ICsgKiBhbGxvd2luZyBmaXJtd2FyZSB0byBjb25maWd1cmUgYW5kIGVuYWJsZSBkaWZmZXJlbnQg
YmFua3MuDQo+ID4gPiArICoNCj4gPiA+ICsgKiBJbnN0ZWFkIG9mIGhhcmQgY29kaW5nIHRoZSBU
UE0gYmFuayBoYXNoIGFsZ29yaXRobSB1c2VkIGZvcg0KPiBjYWxjdWxhdGluZw0KPiA+ID4gKyAq
IHRoZSBib290LWFnZ3JlZ2F0ZSwgc2VlIGlmIHRoZSBjb25maWd1cmVkIElNQV9ERUZBVUxUX0hB
U0gNCj4gPiA+IGFsZ29yaXRobSBpcw0KPiA+ID4gKyAqIGFuIGFsbG9jYXRlZCBUUE0gYmFuaywg
b3RoZXJ3aXNlIHVzZSB0aGUgZmlyc3QgYWxsb2NhdGVkIFRQTSBiYW5rLg0KPiA+ID4gKyAqDQo+
ID4gPiArICogRm9yIFRQTSAxLjIgU0hBMSBpcyB0aGUgb25seSBoYXNoIGFsZ29yaXRobS4NCj4g
PiA+ICAgKi8NCj4gPiA+ICBzdGF0aWMgaW50IF9faW5pdCBpbWFfY2FsY19ib290X2FnZ3JlZ2F0
ZV90Zm0oY2hhciAqZGlnZXN0LA0KPiA+ID4gIAkJCQkJICAgICAgc3RydWN0IGNyeXB0b19zaGFz
aCAqdGZtKQ0KPiA+ID4gQEAgLTY3Myw2ICs2OTAsMjQgQEAgc3RhdGljIGludCBfX2luaXQNCj4g
aW1hX2NhbGNfYm9vdF9hZ2dyZWdhdGVfdGZtKGNoYXINCj4gPiA+ICpkaWdlc3QsDQo+ID4gPiAg
CWlmIChyYyAhPSAwKQ0KPiA+ID4gIAkJcmV0dXJuIHJjOw0KPiA+ID4NCj4gPiA+ICsJZm9yIChp
ID0gMDsgaSA8IEFSUkFZX1NJWkUodHBtMl9oYXNoX21hcCk7IGkrKykgew0KPiA+ID4gKwkJaWYg
KHRwbTJfaGFzaF9tYXBbaV0uY3J5cHRvX2lkID09IGltYV9oYXNoX2FsZ28pIHsNCj4gPg0KPiA+
IEl0IGlzIG5vdCBuZWNlc3NhcnkgdG8gZGVmaW5lIGEgbmV3IG1hcC4gaW1hX3RwbV9jaGlwLT5h
bGxvY2F0ZWRfYmFua3MNCj4gPiBoYXMgYSBjcnlwdG9faWQgZmllbGQuDQo+IA0KPiBPaywgdGhh
bmtzLg0KDQpXaGVuIHlvdSBzZW5kIHRoZSBuZXcgdmVyc2lvbiwgcGxlYXNlIGluY2x1ZGUgcGF0
Y2ggMS84IG9mIG15IHBhdGNoIHNldCwNCnRoYXQgc2V0cyBjcnlwdG9faWQgdG8gSEFTSF9BTEdP
X19MQVNUIGlmIHRoZXJlIGlzIG5vIG1hcHBpbmcgYmV0d2Vlbg0KVFBNIElEIGFuZCBjcnlwdG8g
SUQuDQoNClRoYW5rcw0KDQpSb2JlcnRvDQoNCkhVQVdFSSBURUNITk9MT0dJRVMgRHVlc3NlbGRv
cmYgR21iSCwgSFJCIDU2MDYzDQpNYW5hZ2luZyBEaXJlY3RvcjogTGkgUGVuZywgTGkgSmlhbiwg
U2hpIFlhbmxpDQo=
