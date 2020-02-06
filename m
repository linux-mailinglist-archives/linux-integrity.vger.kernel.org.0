Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69D23154957
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Feb 2020 17:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgBFQgd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Feb 2020 11:36:33 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2390 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727390AbgBFQgd (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Feb 2020 11:36:33 -0500
Received: from lhreml701-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id A1480820A3DE03E99300;
        Thu,  6 Feb 2020 16:36:29 +0000 (GMT)
Received: from fraeml706-chm.china.huawei.com (10.206.15.55) by
 lhreml701-cah.china.huawei.com (10.201.108.42) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 6 Feb 2020 16:36:28 +0000
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Thu, 6 Feb 2020 17:36:28 +0100
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1713.004;
 Thu, 6 Feb 2020 17:36:28 +0100
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
Subject: RE: [PATCH v2 5/8] ima: Switch to dynamically allocated buffer for
 template digests
Thread-Topic: [PATCH v2 5/8] ima: Switch to dynamically allocated buffer for
 template digests
Thread-Index: AQHV3A/+rAKtbF80BkqxEfHd/18hO6gORlUAgAAVOaD///H/AIAAEVJA
Date:   Thu, 6 Feb 2020 16:36:28 +0000
Message-ID: <5bbf950910db4a5a853aaaeba5b18529@huawei.com>
References: <20200205103317.29356-1-roberto.sassu@huawei.com>
         <20200205103317.29356-6-roberto.sassu@huawei.com>
         <1581005284.5585.422.camel@linux.ibm.com>
         <0b91e6977bac4cd5a638041adb3e76eb@huawei.com>
 <1581006834.5585.430.camel@linux.ibm.com>
In-Reply-To: <1581006834.5585.430.camel@linux.ibm.com>
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBvd25lci1saW51eC1zZWN1cml0
eS1tb2R1bGVAdmdlci5rZXJuZWwub3JnIFttYWlsdG86b3duZXItbGludXgtDQo+IHNlY3VyaXR5
LW1vZHVsZUB2Z2VyLmtlcm5lbC5vcmddIE9uIEJlaGFsZiBPZiBNaW1pIFpvaGFyDQo+IFNlbnQ6
IFRodXJzZGF5LCBGZWJydWFyeSA2LCAyMDIwIDU6MzQgUE0NCj4gVG86IFJvYmVydG8gU2Fzc3Ug
PHJvYmVydG8uc2Fzc3VAaHVhd2VpLmNvbT47DQo+IEphbWVzLkJvdHRvbWxleUBIYW5zZW5QYXJ0
bmVyc2hpcC5jb207DQo+IGphcmtrby5zYWtraW5lbkBsaW51eC5pbnRlbC5jb20NCj4gQ2M6IGxp
bnV4LWludGVncml0eUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXNlY3VyaXR5LW1vZHVsZUB2Z2Vy
Lmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFNpbHZpdSBWbGFz
Y2VhbnUNCj4gPFNpbHZpdS5WbGFzY2VhbnVAaHVhd2VpLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2MiA1LzhdIGltYTogU3dpdGNoIHRvIGR5bmFtaWNhbGx5IGFsbG9jYXRlZCBidWZmZXIg
Zm9yDQo+IHRlbXBsYXRlIGRpZ2VzdHMNCj4gDQo+IE9uIFRodSwgMjAyMC0wMi0wNiBhdCAxNjoy
NyArMDAwMCwgUm9iZXJ0byBTYXNzdSB3cm90ZToNCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+ID4gPiBGcm9tOiBNaW1pIFpvaGFyIFttYWlsdG86em9oYXJAbGludXguaWJtLmNv
bV0NCj4gPiA+IFNlbnQ6IFRodXJzZGF5LCBGZWJydWFyeSA2LCAyMDIwIDU6MDggUE0NCj4gPiA+
IFRvOiBSb2JlcnRvIFNhc3N1IDxyb2JlcnRvLnNhc3N1QGh1YXdlaS5jb20+Ow0KPiA+ID4gSmFt
ZXMuQm90dG9tbGV5QEhhbnNlblBhcnRuZXJzaGlwLmNvbTsNCj4gPiA+IGphcmtrby5zYWtraW5l
bkBsaW51eC5pbnRlbC5jb20NCj4gPiA+IENjOiBsaW51eC1pbnRlZ3JpdHlAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1zZWN1cml0eS0NCj4gbW9kdWxlQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFNpbHZpdSBWbGFzY2VhbnUNCj4gPiA+IDxTaWx2
aXUuVmxhc2NlYW51QGh1YXdlaS5jb20+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDUv
OF0gaW1hOiBTd2l0Y2ggdG8gZHluYW1pY2FsbHkgYWxsb2NhdGVkIGJ1ZmZlcg0KPiBmb3INCj4g
PiA+IHRlbXBsYXRlIGRpZ2VzdHMNCj4gPiA+DQo+ID4gPiBIaSBSb2JlcnRvLA0KPiA+ID4NCj4g
PiA+IE9uIFdlZCwgMjAyMC0wMi0wNSBhdCAxMTozMyArMDEwMCwgUm9iZXJ0byBTYXNzdSB3cm90
ZToNCj4gPiA+ID4gVGhpcyBwYXRjaCBkeW5hbWljYWxseSBhbGxvY2F0ZXMgdGhlIGFycmF5IG9m
IHRwbV9kaWdlc3Qgc3RydWN0dXJlcyBpbg0KPiA+ID4gPiBpbWFfYWxsb2NfaW5pdF90ZW1wbGF0
ZSgpIGFuZCBpbWFfcmVzdG9yZV90ZW1wbGF0ZV9kYXRhKCkuIFRoZSBzaXplDQo+IG9mDQo+ID4g
PiB0aGUNCj4gPiA+ID4gYXJyYXksIHN0b3JlZCBpbiBpbWFfbnVtX3RlbXBsYXRlX2RpZ2VzdHMs
IGlzIGluaXRpYWxseSBlcXVhbCB0byAxDQo+IChTSEExKQ0KPiA+ID4gPiBhbmQgd2lsbCBiZSBk
ZXRlcm1pbmVkIGluIHRoZSB1cGNvbWluZyBwYXRjaGVzIGRlcGVuZGluZyBvbiB0aGUNCj4gPiA+
IGFsbG9jYXRlZA0KPiA+ID4gPiBQQ1IgYmFua3MgYW5kIHRoZSBjaG9zZW4gZGVmYXVsdCBJTUEg
YWxnb3JpdGhtLg0KPiA+ID4gPg0KPiA+ID4gPiBDYWxjdWxhdGluZyB0aGUgU0hBMSBkaWdlc3Qg
aXMgbWFuZGF0b3J5LCBhcyBTSEExIHN0aWxsIHJlbWFpbnMgdGhlDQo+IGRlZmF1bHQNCj4gPiA+
ID4gaGFzaCBhbGdvcml0aG0gZm9yIHRoZSBtZWFzdXJlbWVudCBsaXN0LiBXaGVuIElNQSB3aWxs
IHN1cHBvcnQgdGhlDQo+ID4gPiBDcnlwdG8NCj4gPiA+ID4gQWdpbGUgZm9ybWF0LCByZW1haW5p
bmcgZGlnZXN0cyB3aWxsIGJlIGFsc28gcHJvdmlkZWQuDQo+ID4gPiA+DQo+ID4gPiA+IFRoZSBw
b3NpdGlvbiBpbiB0aGUgYXJyYXkgb2YgdGhlIFNIQTEgZGlnZXN0IGlzIHN0b3JlZCBpbiB0aGUN
Cj4gaW1hX3NoYTFfaWR4DQo+ID4gPiA+IGdsb2JhbCB2YXJpYWJsZSBhbmQgaXQgaXMgZGV0ZXJt
aW5lZCBhdCBJTUEgaW5pdGlhbGl6YXRpb24gdGltZS4NCj4gPiA+ID4NCj4gPiA+ID4gQ2hhbmdl
bG9nDQo+ID4gPiA+DQo+ID4gPiA+IHYxOg0KPiA+ID4gPiAtIG1vdmUgaW1hX3NoYTFfaWR4IHRv
IGltYV9jcnlwdG8uYw0KPiA+ID4gPiAtIGludHJvZHVjZSBpbWFfbnVtX3RlbXBsYXRlX2RpZ2Vz
dHMgKHN1Z2dlc3RlZCBieSBNaW1pKQ0KPiA+ID4NCj4gPiA+IEluc3RlYWQgb2YgaGFyZGNvZGlu
ZyAibnJfYWxsb2NhdGVkX2JhbmtzICsgMSIgb3IgbnJfYWxsb2NhdGVkX2JhbmtzICsNCj4gPiA+
IDIiLCBJIHN1Z2dlc3RlZCBkZWZpbmluZyAibnJfYWxsb2NhdGVkX2JhbmtzICsgZXh0cmEiLCB3
aGVyZSAiZXh0cmEiDQo+ID4gPiBjb3VsZCBiZSAwLCAxLCBvciAyLg0KPiA+ID4NCj4gPiA+IFRo
ZSByZXN0IG9mIHRoZSBjb2RlIHdvdWxkIHJlbWFpbiBleGFjdGx5IHRoZSBzYW1lIGFzIHlvdSBo
YWQuDQo+ID4NCj4gPiBPay4gSSBkaWQgYSBzbWFsbCBpbXByb3ZlbWVudC4gU2luY2Ugd2UgZGV0
ZXJtaW5lIHRoZSBudW1iZXIgb2YNCj4gPiByZXF1aXJlZCBlbGVtZW50cyBvZiBpbWFfYWxnb19h
cnJheSBiZWZvcmUga21hbGxvYygpIEkgdGhvdWdodCBpdA0KPiA+IHdhcyBvayB0byBkaXJlY3Rs
eSBzZXQgdGhhdCBudW1iZXIgb2YgZWxlbWVudHMgaW4gYSBzaW5nbGUgdmFyaWFibGUuDQo+ID4N
Cj4gPiBJZiB5b3UgdGhpbmsgdGhhdCBoYXZpbmcgdHdvIHZhcmlhYmxlcyBpcyBiZXR0ZXIsIEkg
d2lsbCBjaGFuZ2UgaXQuDQo+IA0KPiBUaGUgY29ubmVjdGlvbiB0byBucl9hbGxvY2F0ZWRfYmFu
a3MgaXMgdGhlbiBub3QgYXMgdmlzaWJsZS4gwqBVc2luZw0KPiB0d28gdmFyaWFibGVzIGlzIGNs
ZWFyZXIuDQoNCk9rLCBubyBwcm9ibGVtLiBJIHdpbGwgY2hhbmdlIGl0IGluIHRoZSBuZXh0IHZl
cnNpb24uDQoNClJvYmVydG8NCg0KSFVBV0VJIFRFQ0hOT0xPR0lFUyBEdWVzc2VsZG9yZiBHbWJI
LCBIUkIgNTYwNjMNCk1hbmFnaW5nIERpcmVjdG9yOiBMaSBQZW5nLCBMaSBKaWFuLCBTaGkgWWFu
bGkNCg==
