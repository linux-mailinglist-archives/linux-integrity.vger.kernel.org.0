Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 487F714EE25
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jan 2020 15:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgAaOCj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 31 Jan 2020 09:02:39 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2339 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728500AbgAaOCj (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 31 Jan 2020 09:02:39 -0500
Received: from lhreml705-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id A6AAC28EB21CA5E317E2;
        Fri, 31 Jan 2020 14:02:37 +0000 (GMT)
Received: from fraeml702-chm.china.huawei.com (10.206.15.51) by
 lhreml705-cah.china.huawei.com (10.201.108.46) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 31 Jan 2020 14:02:37 +0000
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Fri, 31 Jan 2020 15:02:36 +0100
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1713.004;
 Fri, 31 Jan 2020 15:02:36 +0100
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
Thread-Index: AQHV1TQ5RK/5lZCTqEyIMJscykTYuKgDvV6AgAETjcA=
Date:   Fri, 31 Jan 2020 14:02:36 +0000
Message-ID: <44c1b3f6d3fe414e914317ef8e5c6f8f@huawei.com>
References: <20200127170443.21538-1-roberto.sassu@huawei.com>
         <20200127170443.21538-8-roberto.sassu@huawei.com>
 <1580423169.6104.18.camel@linux.ibm.com>
In-Reply-To: <1580423169.6104.18.camel@linux.ibm.com>
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1pbnRlZ3JpdHktb3du
ZXJAdmdlci5rZXJuZWwub3JnIFttYWlsdG86bGludXgtaW50ZWdyaXR5LQ0KPiBvd25lckB2Z2Vy
Lmtlcm5lbC5vcmddIE9uIEJlaGFsZiBPZiBNaW1pIFpvaGFyDQo+IFNlbnQ6IFRodXJzZGF5LCBK
YW51YXJ5IDMwLCAyMDIwIDExOjI2IFBNDQo+IFRvOiBSb2JlcnRvIFNhc3N1IDxyb2JlcnRvLnNh
c3N1QGh1YXdlaS5jb20+Ow0KPiBqYXJra28uc2Fra2luZW5AbGludXguaW50ZWwuY29tOw0KPiBq
YW1lcy5ib3R0b21sZXlAaGFuc2VucGFydG5lcnNoaXAuY29tOyBsaW51eC1pbnRlZ3JpdHlAdmdl
ci5rZXJuZWwub3JnDQo+IENjOiBsaW51eC1zZWN1cml0eS1tb2R1bGVAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBTaWx2aXUgVmxhc2NlYW51IDxTaWx2
aXUuVmxhc2NlYW51QGh1YXdlaS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNy84XSBpbWE6
IHVzZSBpbWFfaGFzaF9hbGdvIGZvciBjb2xsaXNpb24gZGV0ZWN0aW9uIGluDQo+IHRoZSBtZWFz
dXJlbWVudCBsaXN0DQo+IA0KPiBPbiBNb24sIDIwMjAtMDEtMjcgYXQgMTg6MDQgKzAxMDAsIFJv
YmVydG8gU2Fzc3Ugd3JvdGU6DQo+ID4gQmVmb3JlIGNhbGN1bGF0aW5nIGEgZGlnZXN0IGZvciBl
YWNoIFBDUiBiYW5rLCBjb2xsaXNpb25zIHdlcmUgZGV0ZWN0ZWQNCj4gPiB3aXRoIGEgU0hBMSBk
aWdlc3QuIFRoaXMgcGF0Y2ggaW5jbHVkZXMgaW1hX2hhc2hfYWxnbyBhbW9uZyB0aGUNCj4gYWxn
b3JpdGhtcw0KPiA+IHVzZWQgdG8gY2FsY3VsYXRlIHRoZSB0ZW1wbGF0ZSBkaWdlc3QgYW5kIGNo
ZWNrcyBjb2xsaXNpb25zIG9uIHRoYXQgZGlnZXN0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
Um9iZXJ0byBTYXNzdSA8cm9iZXJ0by5zYXNzdUBodWF3ZWkuY29tPg0KPiANCj4gRGVmaW5pdGVs
eSBuZWVkZWQgdG8gcHJvdGVjdCBhZ2FpbnN0IGEgc2hhMSBjb2xsaXNpb24gYXR0YWNrLg0KPiAN
Cj4gPHNuaXA+DQo+IA0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL3NlY3VyaXR5L2ludGVncml0eS9p
bWEvaW1hX2FwaS5jDQo+IGIvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfYXBpLmMNCj4gPiBp
bmRleCBlYmFmMDA1NjczNWMuLmE5YmI0NWRlNmRiOSAxMDA2NDQNCj4gPiAtLS0gYS9zZWN1cml0
eS9pbnRlZ3JpdHkvaW1hL2ltYV9hcGkuYw0KPiA+ICsrKyBiL3NlY3VyaXR5L2ludGVncml0eS9p
bWEvaW1hX2FwaS5jDQo+ID4gQEAgLTUxLDcgKzUxLDcgQEAgaW50IGltYV9hbGxvY19pbml0X3Rl
bXBsYXRlKHN0cnVjdCBpbWFfZXZlbnRfZGF0YQ0KPiAqZXZlbnRfZGF0YSwNCj4gPiAgCWlmICgh
KmVudHJ5KQ0KPiA+ICAJCXJldHVybiAtRU5PTUVNOw0KPiA+DQo+ID4gLQkoKmVudHJ5KS0+ZGln
ZXN0cyA9IGtjYWxsb2MoaW1hX3RwbV9jaGlwLT5ucl9hbGxvY2F0ZWRfYmFua3MgKyAxLA0KPiA+
ICsJKCplbnRyeSktPmRpZ2VzdHMgPSBrY2FsbG9jKGltYV90cG1fY2hpcC0+bnJfYWxsb2NhdGVk
X2JhbmtzICsgMiwNCj4gPiAgCQkJCSAgICBzaXplb2YoKigqZW50cnkpLT5kaWdlc3RzKSwgR0ZQ
X05PRlMpOw0KPiA+ICAJaWYgKCEoKmVudHJ5KS0+ZGlnZXN0cykgew0KPiA+ICAJCXJlc3VsdCA9
IC1FTk9NRU07DQo+IA0KPiBJIHdvdWxkIHByZWZlciBub3QgaGF2aW5nIHRvIGFsbG9jYXRlIGFu
ZCB1c2UgIm5yX2FsbG9jYXRlZF9iYW5rcyArIDEiDQo+IGV2ZXJ5d2hlcmUsIGJ1dCBJIHVuZGVy
c3RhbmQgdGhlIG5lZWQgZm9yIGl0LiDCoEknbSBub3Qgc3VyZSB0aGlzIHBhdGNoDQo+IHdhcnJh
bnRzIGFsbG9jYXRpbmcgKzIuIMKgUGVyaGFwcywgaWYgYSBUUE0gYmFuayBkb2Vzbid0IGV4aXN0
IGZvciB0aGUNCj4gSU1BIGRlZmF1bHQgaGFzaCBhbGdvcml0aG0sIHVzZSBhIGRpZmZlcmVudCBh
bGdvcml0aG0gb3IsIHdvcnN0IGNhc2UsDQo+IGNvbnRpbnVlIHVzaW5nIHRoZSBpbWFfc2hhMV9p
ZHguDQoNCldlIGNvdWxkIGludHJvZHVjZSBhIG5ldyBvcHRpb24gY2FsbGVkIGltYV9oYXNoX2Fs
Z29fdHBtIHRvIHNwZWNpZnkNCnRoZSBhbGdvcml0aG0gb2YgYW4gYWxsb2NhdGVkIGJhbmsuIFdl
IGNhbiB1c2UgdGhpcyBmb3IgYm9vdF9hZ2dyZWdhdGUNCmFuZCBoYXNoIGNvbGxpc2lvbiBkZXRl
Y3Rpb24uDQoNClJvYmVydG8NCg0KSFVBV0VJIFRFQ0hOT0xPR0lFUyBEdWVzc2VsZG9yZiBHbWJI
LCBIUkIgNTYwNjMNCk1hbmFnaW5nIERpcmVjdG9yOiBMaSBQZW5nLCBMaSBKaWFuLCBTaGkgWWFu
bGkNCg==
