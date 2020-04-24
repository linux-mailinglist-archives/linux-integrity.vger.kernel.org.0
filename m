Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78F71B7223
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2020 12:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgDXKkA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Apr 2020 06:40:00 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2095 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726778AbgDXKkA (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Apr 2020 06:40:00 -0400
Received: from lhreml731-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 08733653FF91A7DEF629;
        Fri, 24 Apr 2020 11:39:58 +0100 (IST)
Received: from fraeml706-chm.china.huawei.com (10.206.15.55) by
 lhreml731-chm.china.huawei.com (10.201.108.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Fri, 24 Apr 2020 11:39:57 +0100
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 24 Apr 2020 12:39:56 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1913.007;
 Fri, 24 Apr 2020 12:39:56 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "mjg59@google.com" <mjg59@google.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: RE: [PATCH] ima: Allow imasig requirement to be satisfied by EVM
 portable signatures
Thread-Topic: [PATCH] ima: Allow imasig requirement to be satisfied by EVM
 portable signatures
Thread-Index: AQHWF772Ra31Za7Rnki0v4dh4iikmaiHEPYAgAEEbgA=
Date:   Fri, 24 Apr 2020 10:39:56 +0000
Message-ID: <735d0814399f430a8809af8c28b1a62d@huawei.com>
References: <20200421092418.25151-1-roberto.sassu@huawei.com>
 <1587675102.5610.66.camel@linux.ibm.com>
In-Reply-To: <1587675102.5610.66.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.14.239]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaW1pIFpvaGFyIFttYWlsdG86
em9oYXJAbGludXguaWJtLmNvbV0NCj4gU2VudDogVGh1cnNkYXksIEFwcmlsIDIzLCAyMDIwIDEw
OjUyIFBNDQo+IFRvOiBSb2JlcnRvIFNhc3N1IDxyb2JlcnRvLnNhc3N1QGh1YXdlaS5jb20+OyBt
amc1OUBnb29nbGUuY29tDQo+IENjOiBsaW51eC1pbnRlZ3JpdHlAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1zZWN1cml0eS1tb2R1bGVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBTaWx2aXUgVmxhc2NlYW51DQo+IDxTaWx2aXUuVmxhc2NlYW51QGh1YXdl
aS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGltYTogQWxsb3cgaW1hc2lnIHJlcXVpcmVt
ZW50IHRvIGJlIHNhdGlzZmllZCBieSBFVk0NCj4gcG9ydGFibGUgc2lnbmF0dXJlcw0KPiANCj4g
T24gVHVlLCAyMDIwLTA0LTIxIGF0IDExOjI0ICswMjAwLCBSb2JlcnRvIFNhc3N1IHdyb3RlOg0K
PiA+IFN5c3RlbSBhZG1pbmlzdHJhdG9ycyBjYW4gcmVxdWlyZSB0aGF0IGFsbCBhY2Nlc3NlZCBm
aWxlcyBoYXZlIGEgc2lnbmF0dXJlDQo+ID4gYnkgc3BlY2lmeWluZyBhcHByYWlzZV90eXBlPWlt
YXNpZyBpbiBhIHBvbGljeSBydWxlLg0KPiA+DQo+ID4gQ3VycmVudGx5LCBvbmx5IElNQSBzaWdu
YXR1cmVzIHNhdGlzZnkgdGhpcyByZXF1aXJlbWVudC4gSG93ZXZlciwgYWxzbw0KPiBFVk0NCj4g
PiBwb3J0YWJsZSBzaWduYXR1cmVzIGNhbiBzYXRpc2Z5IGl0LiBNZXRhZGF0YSwgaW5jbHVkaW5n
IHNlY3VyaXR5LmltYSwgYXJlDQo+ID4gc2lnbmVkIGFuZCBjYW5ub3QgY2hhbmdlLg0KPiANCj4g
UGxlYXNlIGV4cGFuZCB0aGlzIHBhcmFncmFwaCB3aXRoIGEgc2hvcnQgY29tcGFyaXNvbiBvZiB0
aGUgc2VjdXJpdHkNCj4gZ3VhcmFudGVlcyBwcm92aWRlZCBieSBFVk0gaW1tdXRhYmxlLCBwb3J0
YWJsZSBzaWduYXR1cmVzIHZlcnN1cyBpbWEtDQo+IHNpZy4NCj4gDQo+ID4NCj4gPiBUaGlzIHBh
dGNoIGhlbHBzIGluIHRoZSBzY2VuYXJpb3Mgd2hlcmUgc3lzdGVtIGFkbWluaXN0cmF0b3JzIHdh
bnQgdG8NCj4gPiBlbmZvcmNlIHRoaXMgcmVzdHJpY3Rpb24gYnV0IG9ubHkgRVZNIHBvcnRhYmxl
IHNpZ25hdHVyZXMgYXJlIGF2YWlsYWJsZS4NCj4gDQo+IFllcywgSSBhZ3JlZSBpdCAiaGVscHMi
LCBidXQgd2Ugc3RpbGwgbmVlZCB0byBhZGRyZXNzIHRoZSBhYmlsaXR5IG9mDQo+IHNldHRpbmcv
cmVtb3Zpbmcgc2VjdXJpdHkuaW1hLCB3aGljaCBpc24ndCBwb3NzaWJsZSB3aXRoIGFuIElNQQ0K
PiBzaWduYXR1cmUuIMKgVGhpcyBzb3VuZHMgbGlrZSB3ZSBuZWVkIHRvIGRlZmluZSBhbiBpbW11
dGFibGUgZmlsZSBoYXNoLg0KDQpJIGRpZG4ndCB1bmRlcnN0YW5kLiBDYW4geW91IGV4cGxhaW4g
YmV0dGVyPw0KDQpUaGFua3MNCg0KUm9iZXJ0bw0KDQpIVUFXRUkgVEVDSE5PTE9HSUVTIER1ZXNz
ZWxkb3JmIEdtYkgsIEhSQiA1NjA2Mw0KTWFuYWdpbmcgRGlyZWN0b3I6IExpIFBlbmcsIExpIEpp
YW4sIFNoaSBZYW5saQ0KDQoNCj4gwqBXaGF0IGRvIHlvdSB0aGluaz8NCj4gDQo+ID4gVGhlIHBh
dGNoIG1ha2VzIHRoZSBmb2xsb3dpbmcgY2hhbmdlczoNCj4gPg0KPiA+IGZpbGUgeGF0dHIgdHlw
ZXM6DQo+ID4gc2VjdXJpdHkuaW1hOiBJTUFfWEFUVFJfRElHRVNUL0lNQV9YQVRUUl9ESUdFU1Rf
TkcNCj4gPiBzZWN1cml0eS5ldm06IEVWTV9YQVRUUl9QT1JUQUJMRV9ESUdTSUcNCj4gPg0KPiA+
IGV4ZWN2ZSgpLCBtbWFwKCksIG9wZW4oKSBiZWhhdmlvciAod2l0aCBhcHByYWlzZV90eXBlPWlt
YXNpZyk6DQo+ID4gYmVmb3JlOiBkZW5pZWQgKGZpbGUgd2l0aG91dCBJTUEgc2lnbmF0dXJlLCBp
bWFzaWcgcmVxdWlyZW1lbnQgbm90IG1ldCkNCj4gPiBhZnRlcjogYWxsb3dlZCAoZmlsZSB3aXRo
IEVWTSBwb3J0YWJsZSBzaWduYXR1cmUsIGltYXNpZyByZXF1aXJlbWVudCBtZXQpDQo+ID4NCj4g
PiBvcGVuKE9fV1JPTkxZKSBiZWhhdmlvciAod2l0aG91dCBhcHByYWlzZV90eXBlPWltYXNpZyk6
DQo+ID4gYmVmb3JlOiBhbGxvd2VkIChmaWxlIHdpdGhvdXQgSU1BIHNpZ25hdHVyZSwgbm90IGlt
bXV0YWJsZSkNCj4gPiBhZnRlcjogZGVuaWVkIChmaWxlIHdpdGggRVZNIHBvcnRhYmxlIHNpZ25h
dHVyZSwgaW1tdXRhYmxlKQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUm9iZXJ0byBTYXNzdSA8
cm9iZXJ0by5zYXNzdUBodWF3ZWkuY29tPg0KPiA+IC0tLQ0KPiA+ICBzZWN1cml0eS9pbnRlZ3Jp
dHkvaW1hL2ltYV9hcHByYWlzZS5jIHwgMTQgKysrKysrKysrLS0tLS0NCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9hcHByYWlzZS5jDQo+IGIvc2VjdXJpdHkv
aW50ZWdyaXR5L2ltYS9pbWFfYXBwcmFpc2UuYw0KPiA+IGluZGV4IGE5NjQ5YjA0YjlmMS4uNjlh
NmE5NThmODExIDEwMDY0NA0KPiA+IC0tLSBhL3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX2Fw
cHJhaXNlLmMNCj4gPiArKysgYi9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9hcHByYWlzZS5j
DQo+ID4gQEAgLTIxOSwxMiArMjE5LDE2IEBAIHN0YXRpYyBpbnQgeGF0dHJfdmVyaWZ5KGVudW0g
aW1hX2hvb2tzIGZ1bmMsDQo+IHN0cnVjdCBpbnRlZ3JpdHlfaWludF9jYWNoZSAqaWludCwNCj4g
PiAgCQloYXNoX3N0YXJ0ID0gMTsNCj4gPiAgCQkvKiBmYWxsIHRocm91Z2ggKi8NCj4gPiAgCWNh
c2UgSU1BX1hBVFRSX0RJR0VTVDoNCj4gPiAtCQlpZiAoaWludC0+ZmxhZ3MgJiBJTUFfRElHU0lH
X1JFUVVJUkVEKSB7DQo+ID4gLQkJCSpjYXVzZSA9ICJJTUEtc2lnbmF0dXJlLXJlcXVpcmVkIjsN
Cj4gPiAtCQkJKnN0YXR1cyA9IElOVEVHUklUWV9GQUlMOw0KPiA+IC0JCQlicmVhazsNCj4gPiAr
CQlpZiAoKnN0YXR1cyAhPSBJTlRFR1JJVFlfUEFTU19JTU1VVEFCTEUpIHsNCj4gPiArCQkJaWYg
KGlpbnQtPmZsYWdzICYgSU1BX0RJR1NJR19SRVFVSVJFRCkgew0KPiA+ICsJCQkJKmNhdXNlID0g
IklNQS1zaWduYXR1cmUtcmVxdWlyZWQiOw0KPiA+ICsJCQkJKnN0YXR1cyA9IElOVEVHUklUWV9G
QUlMOw0KPiA+ICsJCQkJYnJlYWs7DQo+ID4gKwkJCX0NCj4gPiArCQkJY2xlYXJfYml0KElNQV9E
SUdTSUcsICZpaW50LT5hdG9taWNfZmxhZ3MpOw0KPiA+ICsJCX0gZWxzZSB7DQo+ID4gKwkJCXNl
dF9iaXQoSU1BX0RJR1NJRywgJmlpbnQtPmF0b21pY19mbGFncyk7DQo+ID4gIAkJfQ0KPiA+IC0J
CWNsZWFyX2JpdChJTUFfRElHU0lHLCAmaWludC0+YXRvbWljX2ZsYWdzKTsNCj4gPiAgCQlpZiAo
eGF0dHJfbGVuIC0gc2l6ZW9mKHhhdHRyX3ZhbHVlLT50eXBlKSAtIGhhc2hfc3RhcnQgPj0NCj4g
PiAgCQkJCWlpbnQtPmltYV9oYXNoLT5sZW5ndGgpDQo+ID4gIAkJCS8qDQo+IA0KPiBOaWNlIQ0K
PiANCj4gTWltaQ0KDQo=
