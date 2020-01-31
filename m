Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B048B14EDA2
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jan 2020 14:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAaNmR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 31 Jan 2020 08:42:17 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2338 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728845AbgAaNmR (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 31 Jan 2020 08:42:17 -0500
Received: from lhreml703-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 80319B94385C5CAE7D7D;
        Fri, 31 Jan 2020 13:42:14 +0000 (GMT)
Received: from fraeml701-chm.china.huawei.com (10.206.15.50) by
 lhreml703-cah.china.huawei.com (10.201.108.44) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 31 Jan 2020 13:42:14 +0000
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Fri, 31 Jan 2020 14:42:13 +0100
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1713.004;
 Fri, 31 Jan 2020 14:42:13 +0100
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
Subject: RE: [PATCH 5/8] ima: allocate and initialize tfm for each PCR bank
Thread-Topic: [PATCH 5/8] ima: allocate and initialize tfm for each PCR bank
Thread-Index: AQHV1TQt9zbbMDf1LU6ofpxaGSDeiKgEpgeAgAAhG0A=
Date:   Fri, 31 Jan 2020 13:42:13 +0000
Message-ID: <17b00b78aa2249f19ba376c7613cfb38@huawei.com>
References: <20200127170443.21538-1-roberto.sassu@huawei.com>
         <20200127170443.21538-6-roberto.sassu@huawei.com>
 <1580473133.6104.48.camel@linux.ibm.com>
In-Reply-To: <1580473133.6104.48.camel@linux.ibm.com>
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
Lmtlcm5lbC5vcmddIE9uIEJlaGFsZiBPZiBNaW1pIFpvaGFyDQo+IFNlbnQ6IEZyaWRheSwgSmFu
dWFyeSAzMSwgMjAyMCAxOjE5IFBNDQo+IFRvOiBSb2JlcnRvIFNhc3N1IDxyb2JlcnRvLnNhc3N1
QGh1YXdlaS5jb20+Ow0KPiBqYXJra28uc2Fra2luZW5AbGludXguaW50ZWwuY29tOw0KPiBqYW1l
cy5ib3R0b21sZXlAaGFuc2VucGFydG5lcnNoaXAuY29tOyBsaW51eC1pbnRlZ3JpdHlAdmdlci5r
ZXJuZWwub3JnDQo+IENjOiBsaW51eC1zZWN1cml0eS1tb2R1bGVAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBTaWx2aXUgVmxhc2NlYW51IDxTaWx2aXUu
Vmxhc2NlYW51QGh1YXdlaS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNS84XSBpbWE6IGFs
bG9jYXRlIGFuZCBpbml0aWFsaXplIHRmbSBmb3IgZWFjaCBQQ1IgYmFuaw0KPiANCj4gT24gTW9u
LCAyMDIwLTAxLTI3IGF0IDE4OjA0ICswMTAwLCBSb2JlcnRvIFNhc3N1IHdyb3RlOg0KPiA+IFRo
aXMgcGF0Y2ggY3JlYXRlcyBhIGNyeXB0b19zaGFzaCBzdHJ1Y3R1cmUgZm9yIGVhY2ggYWxsb2Nh
dGVkIFBDUiBiYW5rDQo+IGFuZA0KPiA+IGZvciBTSEExIGlmIGEgYmFuayB3aXRoIHRoYXQgYWxn
b3JpdGhtIGlzIG5vdCBjdXJyZW50bHkgYWxsb2NhdGVkLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogUm9iZXJ0byBTYXNzdSA8cm9iZXJ0by5zYXNzdUBodWF3ZWkuY29tPg0KPiANCj4gPHNuaXA+
DQo+IA0KPiA+ICtpbnQgX19pbml0IGltYV9pbml0X2NyeXB0byh2b2lkKQ0KPiA+ICt7DQo+ID4g
KwllbnVtIGhhc2hfYWxnbyBhbGdvOw0KPiA+ICsJbG9uZyByYzsNCj4gPiArCWludCBpOw0KPiA+
ICsNCj4gPiArCXJjID0gaW1hX2luaXRfaW1hX2NyeXB0bygpOw0KPiA+ICsJaWYgKHJjKQ0KPiA+
ICsJCXJldHVybiByYzsNCj4gPiArDQo+ID4gKwlpbWFfYWxnb19hcnJheSA9IGttYWxsb2NfYXJy
YXkoaW1hX3RwbV9jaGlwLQ0KPiA+bnJfYWxsb2NhdGVkX2JhbmtzICsgMSwNCj4gPiArCQkJCSAg
ICAgICBzaXplb2YoKmltYV9hbGdvX2FycmF5KSwgR0ZQX0tFUk5FTCk7DQo+IA0KPiBQZXJoYXBz
IGluc3RlYWQgb2YgaGFyZCBjb2RpbmcgIm5yX2FsbG9jYXRlZF9iYW5rcyArIDEiLCBjcmVhdGUg
YQ0KPiB2YXJpYWJsZSBmb3Igc3RvcmluZyB0aGUgbnVtYmVyIG9mICJleHRyYSIgYmFua3MuIMKg
V2FsayB0aGUgYmFua3MNCj4gc2V0dGluZyBpbWFfc2hhMV9pZHggYW5kLCBsYXRlciwgaW4gYSBz
dWJzZXF1ZW50IHBhdGNoIHNldA0KPiBpbWFfaGFzaF9hbGdvX2lkeC4NCg0KSSBjb3VsZCBzdG9y
ZSB0aGUgaW5kZXhlcyBpbiBhbiBhcnJheSBhbmQgYWRkIEFSUkFZX1NJWkUgb2YgdGhhdCBhcnJh
eS4NCg0KPiA+ICsJaWYgKCFpbWFfYWxnb19hcnJheSkgew0KPiA+ICsJCXJjID0gLUVOT01FTTsN
Cj4gPiArCQlnb3RvIG91dDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlmb3IgKGkgPSAwOyBpIDwg
aW1hX3RwbV9jaGlwLT5ucl9hbGxvY2F0ZWRfYmFua3MgKyAxOyBpKyspIHsNCj4gPiArCQlpbWFf
YWxnb19hcnJheVtpXS50Zm0gPSBOVUxMOw0KPiA+ICsJCWltYV9hbGdvX2FycmF5W2ldLmFsZ28g
PSBIQVNIX0FMR09fX0xBU1Q7DQo+ID4gKwl9DQo+IA0KPiBpbWFfaW5pdF9jcnlwdG8oKSBpcyBl
eGVjdXRlZCBvbmNlIG9uIGluaXRpYWxpemF0aW9uLiDCoEknbSBub3Qgc3VyZSBpZg0KPiBpdCBt
YWtlcyBhIGRpZmZlcmVuY2UsIGJ1dCBpZiB5b3UncmUgcmVhbGx5IGNvbmNlcm5lZCBhYm91dCBh
bg0KPiBhZGRpdGlvbmFsIGxvb3AsIHRoZSBpbml0aWFsaXphdGlvbiwgaGVyZSwgY291bGQgYmUg
bGltaXRlZCB0byB0aGUNCj4gImV4dHJhIiBiYW5rcy4gwqBUaGUgb3RoZXIgYmFua3MgY291bGQg
YmUgaW5pdGlhbGl6ZWQgYXQgdGhlIGJlZ2lubmluZw0KPiBvZiB0aGUgbmV4dCBsb29wLg0KDQpJ
IHNldCBhbGdvIHRvIEhBU0hfQUxHT19fTEFTVCB0byBtYXJrIHRoZSBpbWFfYWxnb19hcnJheSBl
bnRyaWVzIGFzDQp1bmluaXRpYWxpemVkLiBpbWFfYWxsb2NfdGZtKCkgdXNlcyBpbWFfYWxnb19h
cnJheSBpbiB0aGUgbmV4dCBsb29wLg0KUmVwbGFjaW5nIGttYWxsb2NfYXJyYXkoKSB3aXRoIGtj
YWxsb2MoKSB3b3VsZCBjYXVzZSBhbGdvIHRvIGJlIHNldCB0bw0KSEFTSF9BTEdPX01ENC4NCg0K
SSBjb3VsZCBjaGVjayB0Zm0gZmlyc3QsIHdoaWNoIGVuc3VyZXMgdGhhdCBhbHNvIGFsZ28gd2Fz
IGluaXRpYWxpemVkLg0KDQpSb2JlcnRvDQoNCj4gPiArCWltYV9zaGExX2lkeCA9IC0xOw0KPiA+
ICsNCj4gPiArCWZvciAoaSA9IDA7IGkgPCBpbWFfdHBtX2NoaXAtPm5yX2FsbG9jYXRlZF9iYW5r
czsgaSsrKSB7DQo+ID4gKwkJYWxnbyA9IGltYV90cG1fY2hpcC0+YWxsb2NhdGVkX2JhbmtzW2ld
LmNyeXB0b19pZDsNCj4gPiArCQlpbWFfYWxnb19hcnJheVtpXS5hbGdvID0gYWxnbzsNCj4gPiAr
DQo+ID4gKwkJLyogdW5rbm93biBUUE0gYWxnb3JpdGhtICovDQo+ID4gKwkJaWYgKGFsZ28gPT0g
SEFTSF9BTEdPX19MQVNUKQ0KPiA+ICsJCQljb250aW51ZTsNCj4gPiArDQo+ID4gKwkJaWYgKGFs
Z28gPT0gSEFTSF9BTEdPX1NIQTEpDQo+ID4gKwkJCWltYV9zaGExX2lkeCA9IGk7DQo+ID4gKw0K
PiA+ICsJCWlmIChhbGdvID09IGltYV9oYXNoX2FsZ28pIHsNCj4gPiArCQkJaW1hX2FsZ29fYXJy
YXlbaV0udGZtID0gaW1hX3NoYXNoX3RmbTsNCj4gPiArCQkJY29udGludWU7DQo+ID4gKwkJfQ0K
PiA+ICsNCj4gPiArCQlpbWFfYWxnb19hcnJheVtpXS50Zm0gPSBpbWFfYWxsb2NfdGZtKGFsZ28p
Ow0KPiA+ICsJCWlmIChJU19FUlIoaW1hX2FsZ29fYXJyYXlbaV0udGZtKSkgew0KPiA+ICsJCQlp
ZiAoYWxnbyA9PSBIQVNIX0FMR09fU0hBMSkgew0KPiA+ICsJCQkJcmMgPSBQVFJfRVJSKGltYV9h
bGdvX2FycmF5W2ldLnRmbSk7DQo+ID4gKwkJCQlpbWFfYWxnb19hcnJheVtpXS50Zm0gPSBOVUxM
Ow0KPiA+ICsJCQkJZ290byBvdXRfYXJyYXk7DQo+ID4gKwkJCX0NCj4gPiArDQo+ID4gKwkJCWlt
YV9hbGdvX2FycmF5W2ldLnRmbSA9IE5VTEw7DQo+ID4gKwkJfQ0KPiA+ICsJfQ0KPiA+ICsNCj4g
PiArCWlmIChpbWFfc2hhMV9pZHggPCAwKSB7DQo+ID4gKwkJaW1hX2FsZ29fYXJyYXlbaV0udGZt
ID0gaW1hX2FsbG9jX3RmbShIQVNIX0FMR09fU0hBMSk7DQo+ID4gKwkJaWYgKElTX0VSUihpbWFf
YWxnb19hcnJheVtpXS50Zm0pKSB7DQo+ID4gKwkJCXJjID0gUFRSX0VSUihpbWFfYWxnb19hcnJh
eVtpXS50Zm0pOw0KPiA+ICsJCQlnb3RvIG91dF9hcnJheTsNCj4gPiArCQl9DQo+ID4gKw0KPiA+
ICsJCWltYV9zaGExX2lkeCA9IGk7DQo+ID4gKwkJaW1hX2FsZ29fYXJyYXlbaV0uYWxnbyA9IEhB
U0hfQUxHT19TSEExOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXJldHVybiAwOw0KPiA+ICtvdXRf
YXJyYXk6DQo+ID4gKwlmb3IgKGkgPSAwOyBpIDwgaW1hX3RwbV9jaGlwLT5ucl9hbGxvY2F0ZWRf
YmFua3MgKyAxOyBpKyspIHsNCj4gPiArCQlpZiAoIWltYV9hbGdvX2FycmF5W2ldLnRmbSB8fA0K
PiA+ICsJCSAgICBpbWFfYWxnb19hcnJheVtpXS50Zm0gPT0gaW1hX3NoYXNoX3RmbSkNCj4gPiAr
CQkJY29udGludWU7DQo+ID4gKw0KPiA+ICsJCWNyeXB0b19mcmVlX3NoYXNoKGltYV9hbGdvX2Fy
cmF5W2ldLnRmbSk7DQo+ID4gKwl9DQo+ID4gK291dDoNCj4gPiArCWNyeXB0b19mcmVlX3NoYXNo
KGltYV9zaGFzaF90Zm0pOw0KPiA+ICsJcmV0dXJuIHJjOw0KPiA+ICt9DQoNCg==
