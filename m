Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6262714EEA7
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jan 2020 15:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbgAaOlz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 31 Jan 2020 09:41:55 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2341 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729020AbgAaOlz (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 31 Jan 2020 09:41:55 -0500
Received: from lhreml703-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 19BC214B40BF06C324D2;
        Fri, 31 Jan 2020 14:41:53 +0000 (GMT)
Received: from fraeml702-chm.china.huawei.com (10.206.15.51) by
 lhreml703-cah.china.huawei.com (10.201.108.44) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 31 Jan 2020 14:41:52 +0000
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Fri, 31 Jan 2020 15:41:52 +0100
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1713.004;
 Fri, 31 Jan 2020 15:41:52 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "james.bottomley@hansenpartnership.com" 
        <james.bottomley@hansenpartnership.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
CC:     "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: RE: [PATCH 7/8] ima: use ima_hash_algo for collision detection in the
 measurement list
Thread-Topic: [PATCH 7/8] ima: use ima_hash_algo for collision detection in
 the measurement list
Thread-Index: AQHV1TQ5RK/5lZCTqEyIMJscykTYuKgDvV6AgAETjcD///eIgIAAEqHw
Date:   Fri, 31 Jan 2020 14:41:52 +0000
Message-ID: <e299058034b94143af6fc1da4ae2c708@huawei.com>
References: <20200127170443.21538-1-roberto.sassu@huawei.com>
         <20200127170443.21538-8-roberto.sassu@huawei.com>
         <1580423169.6104.18.camel@linux.ibm.com>
         <44c1b3f6d3fe414e914317ef8e5c6f8f@huawei.com>
 <1580480525.6104.88.camel@linux.ibm.com>
In-Reply-To: <1580480525.6104.88.camel@linux.ibm.com>
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
em9oYXJAbGludXguaWJtLmNvbV0NCj4gU2VudDogRnJpZGF5LCBKYW51YXJ5IDMxLCAyMDIwIDM6
MjIgUE0NCj4gVG86IFJvYmVydG8gU2Fzc3UgPHJvYmVydG8uc2Fzc3VAaHVhd2VpLmNvbT47DQo+
IGphcmtrby5zYWtraW5lbkBsaW51eC5pbnRlbC5jb207DQo+IGphbWVzLmJvdHRvbWxleUBoYW5z
ZW5wYXJ0bmVyc2hpcC5jb207IGxpbnV4LWludGVncml0eUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6
IGxpbnV4LXNlY3VyaXR5LW1vZHVsZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7DQo+IFNpbHZpdSBWbGFzY2VhbnUgPFNpbHZpdS5WbGFzY2VhbnVAaHVhd2Vp
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCA3LzhdIGltYTogdXNlIGltYV9oYXNoX2FsZ28g
Zm9yIGNvbGxpc2lvbiBkZXRlY3Rpb24gaW4NCj4gdGhlIG1lYXN1cmVtZW50IGxpc3QNCj4gDQo+
IE9uIEZyaSwgMjAyMC0wMS0zMSBhdCAxNDowMiArMDAwMCwgUm9iZXJ0byBTYXNzdSB3cm90ZToN
Cj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBsaW51eC1pbnRl
Z3JpdHktb3duZXJAdmdlci5rZXJuZWwub3JnIFttYWlsdG86bGludXgtaW50ZWdyaXR5LQ0KPiA+
ID4gb3duZXJAdmdlci5rZXJuZWwub3JnXSBPbiBCZWhhbGYgT2YgTWltaSBab2hhcg0KPiA+ID4g
U2VudDogVGh1cnNkYXksIEphbnVhcnkgMzAsIDIwMjAgMTE6MjYgUE0NCj4gPiA+IFRvOiBSb2Jl
cnRvIFNhc3N1IDxyb2JlcnRvLnNhc3N1QGh1YXdlaS5jb20+Ow0KPiA+ID4gamFya2tvLnNha2tp
bmVuQGxpbnV4LmludGVsLmNvbTsNCj4gPiA+IGphbWVzLmJvdHRvbWxleUBoYW5zZW5wYXJ0bmVy
c2hpcC5jb207IGxpbnV4LQ0KPiBpbnRlZ3JpdHlAdmdlci5rZXJuZWwub3JnDQo+ID4gPiBDYzog
bGludXgtc2VjdXJpdHktbW9kdWxlQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiBTaWx2aXUgVmxhc2NlYW51IDxTaWx2aXUuVmxhc2NlYW51
QGh1YXdlaS5jb20+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIDcvOF0gaW1hOiB1c2UgaW1h
X2hhc2hfYWxnbyBmb3IgY29sbGlzaW9uIGRldGVjdGlvbg0KPiBpbg0KPiA+ID4gdGhlIG1lYXN1
cmVtZW50IGxpc3QNCj4gPiA+DQo+ID4gPiBPbiBNb24sIDIwMjAtMDEtMjcgYXQgMTg6MDQgKzAx
MDAsIFJvYmVydG8gU2Fzc3Ugd3JvdGU6DQo+ID4gPiA+IEJlZm9yZSBjYWxjdWxhdGluZyBhIGRp
Z2VzdCBmb3IgZWFjaCBQQ1IgYmFuaywgY29sbGlzaW9ucyB3ZXJlIGRldGVjdGVkDQo+ID4gPiA+
IHdpdGggYSBTSEExIGRpZ2VzdC4gVGhpcyBwYXRjaCBpbmNsdWRlcyBpbWFfaGFzaF9hbGdvIGFt
b25nIHRoZQ0KPiA+ID4gYWxnb3JpdGhtcw0KPiA+ID4gPiB1c2VkIHRvIGNhbGN1bGF0ZSB0aGUg
dGVtcGxhdGUgZGlnZXN0IGFuZCBjaGVja3MgY29sbGlzaW9ucyBvbiB0aGF0DQo+IGRpZ2VzdC4N
Cj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogUm9iZXJ0byBTYXNzdSA8cm9iZXJ0by5z
YXNzdUBodWF3ZWkuY29tPg0KPiA+ID4NCj4gPiA+IERlZmluaXRlbHkgbmVlZGVkIHRvIHByb3Rl
Y3QgYWdhaW5zdCBhIHNoYTEgY29sbGlzaW9uIGF0dGFjay4NCj4gPiA+DQo+ID4gPiA8c25pcD4N
Cj4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9zZWN1cml0eS9pbnRlZ3JpdHkv
aW1hL2ltYV9hcGkuYw0KPiA+ID4gYi9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9hcGkuYw0K
PiA+ID4gPiBpbmRleCBlYmFmMDA1NjczNWMuLmE5YmI0NWRlNmRiOSAxMDA2NDQNCj4gPiA+ID4g
LS0tIGEvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfYXBpLmMNCj4gPiA+ID4gKysrIGIvc2Vj
dXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfYXBpLmMNCj4gPiA+ID4gQEAgLTUxLDcgKzUxLDcgQEAg
aW50IGltYV9hbGxvY19pbml0X3RlbXBsYXRlKHN0cnVjdA0KPiBpbWFfZXZlbnRfZGF0YQ0KPiA+
ID4gKmV2ZW50X2RhdGEsDQo+ID4gPiA+ICAJaWYgKCEqZW50cnkpDQo+ID4gPiA+ICAJCXJldHVy
biAtRU5PTUVNOw0KPiA+ID4gPg0KPiA+ID4gPiAtCSgqZW50cnkpLT5kaWdlc3RzID0ga2NhbGxv
YyhpbWFfdHBtX2NoaXAtPm5yX2FsbG9jYXRlZF9iYW5rcyArIDEsDQo+ID4gPiA+ICsJKCplbnRy
eSktPmRpZ2VzdHMgPSBrY2FsbG9jKGltYV90cG1fY2hpcC0+bnJfYWxsb2NhdGVkX2JhbmtzICsg
MiwNCj4gPiA+ID4gIAkJCQkgICAgc2l6ZW9mKCooKmVudHJ5KS0+ZGlnZXN0cyksIEdGUF9OT0ZT
KTsNCj4gPiA+ID4gIAlpZiAoISgqZW50cnkpLT5kaWdlc3RzKSB7DQo+ID4gPiA+ICAJCXJlc3Vs
dCA9IC1FTk9NRU07DQo+ID4gPg0KPiA+ID4gSSB3b3VsZCBwcmVmZXIgbm90IGhhdmluZyB0byBh
bGxvY2F0ZSBhbmQgdXNlICJucl9hbGxvY2F0ZWRfYmFua3MgKyAxIg0KPiA+ID4gZXZlcnl3aGVy
ZSwgYnV0IEkgdW5kZXJzdGFuZCB0aGUgbmVlZCBmb3IgaXQuIMKgSSdtIG5vdCBzdXJlIHRoaXMg
cGF0Y2gNCj4gPiA+IHdhcnJhbnRzIGFsbG9jYXRpbmcgKzIuIMKgUGVyaGFwcywgaWYgYSBUUE0g
YmFuayBkb2Vzbid0IGV4aXN0IGZvciB0aGUNCj4gPiA+IElNQSBkZWZhdWx0IGhhc2ggYWxnb3Jp
dGhtLCB1c2UgYSBkaWZmZXJlbnQgYWxnb3JpdGhtIG9yLCB3b3JzdCBjYXNlLA0KPiA+ID4gY29u
dGludWUgdXNpbmcgdGhlIGltYV9zaGExX2lkeC4NCj4gPg0KPiA+IFdlIGNvdWxkIGludHJvZHVj
ZSBhIG5ldyBvcHRpb24gY2FsbGVkIGltYV9oYXNoX2FsZ29fdHBtIHRvIHNwZWNpZnkNCj4gPiB0
aGUgYWxnb3JpdGhtIG9mIGFuIGFsbG9jYXRlZCBiYW5rLiBXZSBjYW4gdXNlIHRoaXMgZm9yIGJv
b3RfYWdncmVnYXRlDQo+ID4gYW5kIGhhc2ggY29sbGlzaW9uIGRldGVjdGlvbi4NCj4gDQo+IEkg
ZG9uJ3QgdGhpbmsgdGhhdCB3b3VsZCB3b3JrIGluIHRoZSBjYXNlIHdoZXJlIHRoZSBJTUEgZGVm
YXVsdCBoYXNoDQo+IGlzIHNldCB0byBzaGEyNTYsIGJ1dCB0aGUgc3lzdGVtIGhhcyBhIFRQTSAx
LjIgY2hpcC4gwqBXZSB3b3VsZCBiZSBsZWZ0DQo+IHVzaW5nIFNIQTEgZm9yIHRoZSBmaWxlIGhh
c2ggY29sbGlzaW9uIGRldGVjdGlvbi4NCg0KSSB0aG91Z2h0IHRoYXQgdXNpbmcgYSBzdHJvbmdl
ciBhbGdvcml0aG0gZm9yIGhhc2ggY29sbGlzaW9uIGRldGVjdGlvbiBidXQNCmRvaW5nIHJlbW90
ZSBhdHRlc3RhdGlvbiB3aXRoIHRoZSB3ZWFrZXIgd291bGQgbm90IGJyaW5nIGFkZGl0aW9uYWwg
dmFsdWUuDQoNCklmIHRoZXJlIGlzIGEgaGFzaCBjb2xsaXNpb24gb24gU0hBMSwgYW4gYXR0YWNr
ZXIgY2FuIHN0aWxsIHJlcGxhY2UgdGhlIGRhdGEgb2YNCm9uZSBvZiB0aGUgdHdvIGVudHJpZXMg
aW4gdGhlIG1lYXN1cmVtZW50IGxpc3Qgd2l0aCB0aGUgZGF0YSBvZiB0aGUgb3RoZXINCndpdGhv
dXQgYmVpbmcgZGV0ZWN0ZWQgKHdpdGhvdXQgYWRkaXRpb25hbCBjb3VudGVybWVhc3VyZXMpLg0K
DQpJZiB0aGUgdmVyaWZpZXIgYWRkaXRpb25hbGx5IGNoZWNrcyBmb3IgZHVwbGljYXRlIHRlbXBs
YXRlIGRpZ2VzdHMsIGhlIGNvdWxkDQpkZXRlY3QgdGhlIGF0dGFjayAoSU1BIHdvdWxkIG5vdCBh
ZGQgYSBuZXcgbWVhc3VyZW1lbnQgZW50cnkgd2l0aCB0aGUNCnNhbWUgdGVtcGxhdGUgZGlnZXN0
IG9mIHByZXZpb3VzIGVudHJpZXMpLg0KDQpPaywgSSB3aWxsIHVzZSBpbWFfaGFzaF9hbGdvIGZv
ciBoYXNoIGNvbGxpc2lvbiBkZXRlY3Rpb24uDQoNClJvYmVydG8NCg0KSFVBV0VJIFRFQ0hOT0xP
R0lFUyBEdWVzc2VsZG9yZiBHbWJILCBIUkIgNTYwNjMNCk1hbmFnaW5nIERpcmVjdG9yOiBMaSBQ
ZW5nLCBMaSBKaWFuLCBTaGkgWWFubGkNCg==
