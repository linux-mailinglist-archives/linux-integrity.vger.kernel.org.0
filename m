Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B002A3BE36E
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jul 2021 09:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhGGHSL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Jul 2021 03:18:11 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3370 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbhGGHSL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Jul 2021 03:18:11 -0400
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GKVhM3gDwz6H8Hd;
        Wed,  7 Jul 2021 15:01:23 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 7 Jul 2021 09:15:29 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2176.012;
 Wed, 7 Jul 2021 09:15:29 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>
CC:     "tusharsu@linux.microsoft.com" <tusharsu@linux.microsoft.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ima: Support euid keyword for buffer measurement
Thread-Topic: [PATCH] ima: Support euid keyword for buffer measurement
Thread-Index: AQHXcZTiYWuli3uSt0eEvrRscw2zRas2Nd6AgADj8nA=
Date:   Wed, 7 Jul 2021 07:15:29 +0000
Message-ID: <35a1ef50bf534933a10fd350aee9baa2@huawei.com>
References: <20210705115650.3373599-1-roberto.sassu@huawei.com>
 <2996f5ae-d76f-5fc9-bf90-857d4fc6644a@linux.microsoft.com>
In-Reply-To: <2996f5ae-d76f-5fc9-bf90-857d4fc6644a@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.221.98.153]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

PiBGcm9tOiBMYWtzaG1pIFJhbWFzdWJyYW1hbmlhbiBbbWFpbHRvOm5yYW1hc0BsaW51eC5taWNy
b3NvZnQuY29tXQ0KPiBTZW50OiBUdWVzZGF5LCBKdWx5IDYsIDIwMjEgOTozMCBQTQ0KPiBPbiA3
LzUvMjAyMSA0OjU2IEFNLCBSb2JlcnRvIFNhc3N1IHdyb3RlOg0KPiANCj4gSGkgUm9iZXJ0bywN
Cj4gDQo+ID4gVGhpcyBwYXRjaCBtYWtlcyB0aGUgJ2V1aWQnIGtleXdvcmQgYXZhaWxhYmxlIGZv
ciBidWZmZXIgbWVhc3VyZW1lbnQgcnVsZXMsDQo+ID4gaW4gdGhlIHNhbWUgd2F5IGFzIGZvciBv
dGhlciBydWxlcy4gQ3VycmVudGx5LCB0aGVyZSBpcyBvbmx5IHN1cHBvcnQgZm9yDQo+ID4gdGhl
ICd1aWQnIGtleXdvcmQuDQo+ID4NCj4gPiBXaXRoIHRoaXMgY2hhbmdlLCBidWZmZXIgbWVhc3Vy
ZW1lbnQgKG9yIG5vbi1tZWFzdXJlbWVudCkgY2FuIGRlcGVuZA0KPiBhbHNvDQo+ID4gb24gdGhl
IHByb2Nlc3MgZWZmZWN0aXZlIFVJRC4NCj4gDQo+IFdobyAoa2VybmVsIGNvbXBvbmVudCkgd2ls
bCBiZSB1c2luZyB0aGlzPw0KDQpIaSBMYWtzaG1pDQoNCkknbSB1c2luZyBpdCBpbiBhIChub3Qg
eWV0IHN1Ym1pdHRlZCkgdGVzdCBmb3IgZGlnZXN0IGxpc3RzLg0KDQpJdCBpcyBpbiBhIGRvbnRf
bWVhc3VyZSBydWxlIHRvIHRyeSB0byB1bmxvYWQgYSBkaWdlc3QgbGlzdA0Kd2l0aG91dCBtZWFz
dXJlbWVudCBhbmQgdG8gY2hlY2sgdGhhdCB0aGlzIGlzIG5vdCBhbGxvd2VkDQppZiB0aGUgZGln
ZXN0IGxpc3Qgd2FzIG1lYXN1cmVkIGF0IGFkZGl0aW9uIHRpbWUgKHRvIGVuc3VyZQ0KY29tcGxl
dGVuZXNzIG9mIGluZm9ybWF0aW9uKS4NCg0KPiBNYXliZSB5b3UgY291bGQgbWFrZSB0aGlzIGNo
YW5nZSBhcyBwYXJ0IG9mIHRoZSBwYXRjaCBzZXQgaW4gd2hpY2ggdGhlDQo+IGFib3ZlICJldWlk
IiBzdXBwb3J0IHdpbGwgYmUgdXNlZC4NCg0KSSB3YW50ZWQgdG8gc2VuZCB0aGUgZGlnZXN0IGxp
c3RzIHBhdGNoIHNldCB3aXRob3V0IGFueXRoaW5nDQplbHNlLiBJIGNvdWxkIHJlc2VuZCB0aGUg
cGF0Y2ggYXMgcGFydCBvZiB0aGF0IHBhdGNoIHNldCBpZiBpdCBpcw0KcHJlZmVycmVkLg0KDQpU
aGFua3MNCg0KUm9iZXJ0bw0KDQpIVUFXRUkgVEVDSE5PTE9HSUVTIER1ZXNzZWxkb3JmIEdtYkgs
IEhSQiA1NjA2Mw0KTWFuYWdpbmcgRGlyZWN0b3I6IExpIFBlbmcsIExpIEppYW4sIFNoaSBZYW5s
aQ0KDQo+IHRoYW5rcywNCj4gICAtbGFrc2htaQ0KPiANCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IFJvYmVydG8gU2Fzc3UgPHJvYmVydG8uc2Fzc3VAaHVhd2VpLmNvbT4NCj4gPiAtLS0NCj4gPiAg
IHNlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX3BvbGljeS5jIHwgMTIgKysrKysrKysrKystDQo+
ID4gICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX3BvbGljeS5jDQo+
IGIvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfcG9saWN5LmMNCj4gPiBpbmRleCBmZDVkNDZl
NTExZjEuLmZkYWEwMzBmYjA0YiAxMDA2NDQNCj4gPiAtLS0gYS9zZWN1cml0eS9pbnRlZ3JpdHkv
aW1hL2ltYV9wb2xpY3kuYw0KPiA+ICsrKyBiL3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX3Bv
bGljeS5jDQo+ID4gQEAgLTQ4MCw2ICs0ODAsMTYgQEAgc3RhdGljIGJvb2wgaW1hX21hdGNoX3J1
bGVfZGF0YShzdHJ1Y3QNCj4gaW1hX3J1bGVfZW50cnkgKnJ1bGUsDQo+ID4gICAJaWYgKChydWxl
LT5mbGFncyAmIElNQV9VSUQpICYmICFydWxlLT51aWRfb3AoY3JlZC0+dWlkLCBydWxlLT51aWQp
KQ0KPiA+ICAgCQlyZXR1cm4gZmFsc2U7DQo+ID4NCj4gPiArCWlmIChydWxlLT5mbGFncyAmIElN
QV9FVUlEKSB7DQo+ID4gKwkJaWYgKGhhc19jYXBhYmlsaXR5X25vYXVkaXQoY3VycmVudCwgQ0FQ
X1NFVFVJRCkpIHsNCj4gPiArCQkJaWYgKCFydWxlLT51aWRfb3AoY3JlZC0+ZXVpZCwgcnVsZS0+
dWlkKQ0KPiA+ICsJCQkgICAgJiYgIXJ1bGUtPnVpZF9vcChjcmVkLT5zdWlkLCBydWxlLT51aWQp
DQo+ID4gKwkJCSAgICAmJiAhcnVsZS0+dWlkX29wKGNyZWQtPnVpZCwgcnVsZS0+dWlkKSkNCj4g
PiArCQkJCXJldHVybiBmYWxzZTsNCj4gPiArCQl9IGVsc2UgaWYgKCFydWxlLT51aWRfb3AoY3Jl
ZC0+ZXVpZCwgcnVsZS0+dWlkKSkNCj4gPiArCQkJcmV0dXJuIGZhbHNlOw0KPiA+ICsJfQ0KPiA+
ICsNCj4gPiAgIAlzd2l0Y2ggKHJ1bGUtPmZ1bmMpIHsNCj4gPiAgIAljYXNlIEtFWV9DSEVDSzoN
Cj4gPiAgIAkJaWYgKCFydWxlLT5rZXlyaW5ncykNCj4gPiBAQCAtMTE1Myw3ICsxMTYzLDcgQEAg
c3RhdGljIGJvb2wgaW1hX3ZhbGlkYXRlX3J1bGUoc3RydWN0DQo+IGltYV9ydWxlX2VudHJ5ICpl
bnRyeSkNCj4gPiAgIAkJaWYgKGVudHJ5LT5hY3Rpb24gJiB+KE1FQVNVUkUgfCBET05UX01FQVNV
UkUpKQ0KPiA+ICAgCQkJcmV0dXJuIGZhbHNlOw0KPiA+DQo+ID4gLQkJaWYgKGVudHJ5LT5mbGFn
cyAmIH4oSU1BX0ZVTkMgfCBJTUFfVUlEIHwgSU1BX1BDUiB8DQo+ID4gKwkJaWYgKGVudHJ5LT5m
bGFncyAmIH4oSU1BX0ZVTkMgfCBJTUFfVUlEIHwgSU1BX0VVSUQgfA0KPiBJTUFfUENSIHwNCj4g
PiAgIAkJCQkgICAgIElNQV9MQUJFTCkpDQo+ID4gICAJCQlyZXR1cm4gZmFsc2U7DQo+ID4NCj4g
Pg0K
