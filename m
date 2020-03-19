Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1892518AE56
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Mar 2020 09:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgCSIbL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Mar 2020 04:31:11 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2579 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726063AbgCSIbL (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Mar 2020 04:31:11 -0400
Received: from lhreml706-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 3B78CAEE143F21C7708F;
        Thu, 19 Mar 2020 08:31:09 +0000 (GMT)
Received: from fraeml706-chm.china.huawei.com (10.206.15.55) by
 lhreml706-cah.china.huawei.com (10.201.108.47) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 19 Mar 2020 08:31:08 +0000
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Thu, 19 Mar 2020 09:31:08 +0100
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1713.004;
 Thu, 19 Mar 2020 09:31:08 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: RE: [PATCH v3 7/8] ima: Calculate and extend PCR with digests in
 ima_template_entry
Thread-Topic: [PATCH v3 7/8] ima: Calculate and extend PCR with digests in
 ima_template_entry
Thread-Index: AQHV3/maB4b2w9bxIkSFxAC0vgzFrag2UL0AgBgzWHCAAIroAIAAvEow
Date:   Thu, 19 Mar 2020 08:31:07 +0000
Message-ID: <7df041fd4cd64a5bb61beb4eb8276819@huawei.com>
References: <20200210100418.22049-1-roberto.sassu@huawei.com>
         <1583208222.8544.168.camel@linux.ibm.com>
         <fecf59c1880045769bfecc17b5670ac5@huawei.com>
 <1584568492.5188.200.camel@linux.ibm.com>
In-Reply-To: <1584568492.5188.200.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.0.250]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1pbnRlZ3JpdHktb3du
ZXJAdmdlci5rZXJuZWwub3JnIFttYWlsdG86bGludXgtaW50ZWdyaXR5LQ0KPiBvd25lckB2Z2Vy
Lmtlcm5lbC5vcmddIE9uIEJlaGFsZiBPZiBNaW1pIFpvaGFyDQo+IFNlbnQ6IFdlZG5lc2RheSwg
TWFyY2ggMTgsIDIwMjAgMTA6NTUgUE0NCj4gVG86IFJvYmVydG8gU2Fzc3UgPHJvYmVydG8uc2Fz
c3VAaHVhd2VpLmNvbT47DQo+IEphbWVzLkJvdHRvbWxleUBIYW5zZW5QYXJ0bmVyc2hpcC5jb207
DQo+IGphcmtrby5zYWtraW5lbkBsaW51eC5pbnRlbC5jb20NCj4gQ2M6IGxpbnV4LWludGVncml0
eUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXNlY3VyaXR5LW1vZHVsZUB2Z2VyLmtlcm5lbC5vcmc7
DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFNpbHZpdSBWbGFzY2VhbnUNCj4gPFNp
bHZpdS5WbGFzY2VhbnVAaHVhd2VpLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyA3Lzhd
IGltYTogQ2FsY3VsYXRlIGFuZCBleHRlbmQgUENSIHdpdGggZGlnZXN0cyBpbg0KPiBpbWFfdGVt
cGxhdGVfZW50cnkNCj4gDQo+IE9uIFdlZCwgMjAyMC0wMy0xOCBhdCAxMjo0MiArMDAwMCwgUm9i
ZXJ0byBTYXNzdSB3cm90ZToNCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4g
PiBGcm9tOiBvd25lci1saW51eC1zZWN1cml0eS1tb2R1bGVAdmdlci5rZXJuZWwub3JnIFttYWls
dG86b3duZXItDQo+IGxpbnV4LQ0KPiA+ID4gc2VjdXJpdHktbW9kdWxlQHZnZXIua2VybmVsLm9y
Z10gT24gQmVoYWxmIE9mIE1pbWkgWm9oYXINCj4gPiA+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDMs
IDIwMjAgNTowNCBBTQ0KPiA+ID4gVG86IFJvYmVydG8gU2Fzc3UgPHJvYmVydG8uc2Fzc3VAaHVh
d2VpLmNvbT47DQo+ID4gPiBKYW1lcy5Cb3R0b21sZXlASGFuc2VuUGFydG5lcnNoaXAuY29tOw0K
PiA+ID4gamFya2tvLnNha2tpbmVuQGxpbnV4LmludGVsLmNvbQ0KPiA+ID4gQ2M6IGxpbnV4LWlu
dGVncml0eUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXNlY3VyaXR5LQ0KPiBtb2R1bGVAdmdlci5r
ZXJuZWwub3JnOw0KPiA+ID4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgU2lsdml1IFZs
YXNjZWFudQ0KPiA+ID4gPFNpbHZpdS5WbGFzY2VhbnVAaHVhd2VpLmNvbT4NCj4gPiA+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjMgNy84XSBpbWE6IENhbGN1bGF0ZSBhbmQgZXh0ZW5kIFBDUiB3aXRo
IGRpZ2VzdHMNCj4gaW4NCj4gPiA+IGltYV90ZW1wbGF0ZV9lbnRyeQ0KPiA+ID4NCj4gPiA+IE9u
IE1vbiwgMjAyMC0wMi0xMCBhdCAxMTowNCArMDEwMCwgUm9iZXJ0byBTYXNzdSB3cm90ZToNCj4g
PiA+DQo+ID4gPiA+IEBAIC0yMTksNiArMjE0LDggQEAgaW50IGltYV9yZXN0b3JlX21lYXN1cmVt
ZW50X2VudHJ5KHN0cnVjdA0KPiA+ID4gaW1hX3RlbXBsYXRlX2VudHJ5ICplbnRyeSkNCj4gPiA+
ID4NCj4gPiA+ID4gIGludCBfX2luaXQgaW1hX2luaXRfZGlnZXN0cyh2b2lkKQ0KPiA+ID4gPiAg
ew0KPiA+ID4gPiArCXUxNiBkaWdlc3Rfc2l6ZTsNCj4gPiA+ID4gKwl1MTYgY3J5cHRvX2lkOw0K
PiA+ID4gPiAgCWludCBpOw0KPiA+ID4gPg0KPiA+ID4gPiAgCWlmICghaW1hX3RwbV9jaGlwKQ0K
PiA+ID4gPiBAQCAtMjI5LDggKzIyNiwxNyBAQCBpbnQgX19pbml0IGltYV9pbml0X2RpZ2VzdHMo
dm9pZCkNCj4gPiA+ID4gIAlpZiAoIWRpZ2VzdHMpDQo+ID4gPiA+ICAJCXJldHVybiAtRU5PTUVN
Ow0KPiA+ID4gPg0KPiA+ID4gPiAtCWZvciAoaSA9IDA7IGkgPCBpbWFfdHBtX2NoaXAtPm5yX2Fs
bG9jYXRlZF9iYW5rczsgaSsrKQ0KPiA+ID4gPiArCWZvciAoaSA9IDA7IGkgPCBpbWFfdHBtX2No
aXAtPm5yX2FsbG9jYXRlZF9iYW5rczsgaSsrKSB7DQo+ID4gPiA+ICAJCWRpZ2VzdHNbaV0uYWxn
X2lkID0gaW1hX3RwbV9jaGlwLT5hbGxvY2F0ZWRfYmFua3NbaV0uYWxnX2lkOw0KPiA+ID4gPiAr
CQlkaWdlc3Rfc2l6ZSA9IGltYV90cG1fY2hpcC0+YWxsb2NhdGVkX2JhbmtzW2ldLmRpZ2VzdF9z
aXplOw0KPiA+ID4gPiArCQljcnlwdG9faWQgPSBpbWFfdHBtX2NoaXAtPmFsbG9jYXRlZF9iYW5r
c1tpXS5jcnlwdG9faWQ7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwkJLyogZm9yIHVubWFwcGVkIFRQ
TSBhbGdvcml0aG1zIGRpZ2VzdCBpcyBzdGlsbCBhIHBhZGRlZA0KPiA+ID4gU0hBMSAqLw0KPiA+
ID4gPiArCQlpZiAoY3J5cHRvX2lkID09IEhBU0hfQUxHT19fTEFTVCkNCj4gPiA+ID4gKwkJCWRp
Z2VzdF9zaXplID0gU0hBMV9ESUdFU1RfU0laRTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCQltZW1z
ZXQoZGlnZXN0c1tpXS5kaWdlc3QsIDB4ZmYsIGRpZ2VzdF9zaXplKTsNCj4gPiA+DQo+ID4gPiBT
aG91bGRuJ3QgdGhlIG1lbXNldCBoZXJlIGJlIG9mIHRoZSBhY3R1YWwgZGlnZXN0IHNpemUgZXZl
biBmb3INCj4gPiA+IHVubWFwcGVkIFRQTSBhbGdvcml0aG1zLg0KPiA+DQo+ID4gVGhpcyBpcyBj
b25zaXN0ZW50IHdpdGggaW1hX2NhbGNfZmllbGRfYXJyYXlfaGFzaCgpLCBzbyB0aGF0IGEgdmVy
aWZpZXINCj4gPiB3aWxsIGFsd2F5cyBwYWQgdGhlIFNIQTEgZGlnZXN0IHdpdGggemVyb3MgdG8g
b2J0YWluIHRoZSBmaW5hbCBQQ1IgdmFsdWUuDQo+ID4NCj4gPiBJIGNhbiBzZXQgYWxsIGJ5dGVz
IGlmIHlvdSBwcmVmZXIuDQo+IA0KPiBNeSBjb25jZXJuIGlzIHdpdGggdmlvbGF0aW9ucy4gwqBU
aGUgbWVhc3VyZW1lbnQgbGlzdCB3aWxsIGJlIHBhZGRlZA0KPiB3aXRoIDAncywgYnV0IHRoZSB2
YWx1ZSBiZWluZyBleHRlbmRlZCBpbnRvIHRoZSBUUE0gd2lsbCBvbmx5DQo+IHBhcnRpYWxseSBi
ZSAweEZGJ3MuIMKgV2hlbiB2ZXJpZnlpbmcgdGhlIG1lYXN1cmVtZW50IGxpc3QsIHJlcGxhY2lu
Zw0KPiBhbGwgMHgwMCdzIHdpdGggYWxsIDB4RkYncyBpcyBzaW1wbGVyLg0KDQpJZiB0aGUgVFBN
IGFsZ29yaXRobSBpcyB1bmtub3duLCB0aGUgc3RhcnRpbmcgcG9pbnQgaXMgdGhlIFNIQTEgZGln
ZXN0Lg0KSWYgdGhlcmUgaXMgYSB2aW9sYXRpb24sIHRoaXMgc2hvdWxkIGJlIHRoZSBvbmUgdG8g
YmUgbW9kaWZpZWQuIFRoZW4sIGFmdGVyDQp0aGF0LCBwYWRkaW5nIGlzIGRvbmUgZm9yIGFsbCBl
bnRyaWVzIGluIHRoZSBzYW1lIHdheSwgcmVnYXJkbGVzcyBvZg0Kd2hldGhlciB0aGUgZW50cnkg
aXMgYSB2aW9sYXRpb24gb3Igbm90Lg0KDQpSb2JlcnRvDQoNCkhVQVdFSSBURUNITk9MT0dJRVMg
RHVlc3NlbGRvcmYgR21iSCwgSFJCIDU2MDYzDQpNYW5hZ2luZyBEaXJlY3RvcjogTGkgUGVuZywg
TGkgSmlhbiwgU2hpIFlhbmxpDQo=
