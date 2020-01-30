Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5C814DE0E
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jan 2020 16:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgA3PlA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Jan 2020 10:41:00 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2330 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727107AbgA3PlA (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Jan 2020 10:41:00 -0500
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id BCAF478D3962AD087CBC;
        Thu, 30 Jan 2020 15:40:58 +0000 (GMT)
Received: from fraeml707-chm.china.huawei.com (10.206.15.35) by
 lhreml702-cah.china.huawei.com (10.201.108.43) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 30 Jan 2020 15:40:59 +0000
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 30 Jan 2020 16:40:57 +0100
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1713.004;
 Thu, 30 Jan 2020 16:40:57 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>
CC:     Jerry Snitselaar <jsnitsel@redhat.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: RE: [PATCH 1/2] ima: use the IMA configured hash algo to calculate
 the boot aggregate
Thread-Topic: [PATCH 1/2] ima: use the IMA configured hash algo to calculate
 the boot aggregate
Thread-Index: AQHV1SsskZfHgOFdME+uHgUEG6qPTKf+632AgAALuoCAAkpuAIAA8HoAgADpZbCAAEAyAA==
Date:   Thu, 30 Jan 2020 15:40:57 +0000
Message-ID: <43d93cbe8ab04182bb6d8579e8499634@huawei.com>
References: <1580140919-6127-1-git-send-email-zohar@linux.ibm.com>
         <20200127204941.2ewman4y5nzvkjqe@cantor>
         <1580160699.5088.64.camel@linux.ibm.com>
 <20200129083034.GA387@dell5510> <1580338276.4790.8.camel@linux.ibm.com>
 <2e3ec5f5a4e748a898baeac8a88487ab@huawei.com>
In-Reply-To: <2e3ec5f5a4e748a898baeac8a88487ab@huawei.com>
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
Lmtlcm5lbC5vcmddIE9uIEJlaGFsZiBPZiBSb2JlcnRvIFNhc3N1DQo+IFNlbnQ6IFRodXJzZGF5
LCBKYW51YXJ5IDMwLCAyMDIwIDQ6MjcgUE0NCj4gVG86IE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4
LmlibS5jb20+OyBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4NCj4gQ2M6IEplcnJ5IFNuaXRz
ZWxhYXIgPGpzbml0c2VsQHJlZGhhdC5jb20+OyBsaW51eC1pbnRlZ3JpdHlAdmdlci5rZXJuZWwu
b3JnOw0KPiBKYW1lcyBCb3R0b21sZXkgPEphbWVzLkJvdHRvbWxleUBoYW5zZW5wYXJ0bmVyc2hp
cC5jb20+OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSRTog
W1BBVENIIDEvMl0gaW1hOiB1c2UgdGhlIElNQSBjb25maWd1cmVkIGhhc2ggYWxnbyB0byBjYWxj
dWxhdGUNCj4gdGhlIGJvb3QgYWdncmVnYXRlDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+ID4gRnJvbTogbGludXgtaW50ZWdyaXR5LW93bmVyQHZnZXIua2VybmVsLm9yZyBb
bWFpbHRvOmxpbnV4LWludGVncml0eS0NCj4gPiBvd25lckB2Z2VyLmtlcm5lbC5vcmddIE9uIEJl
aGFsZiBPZiBNaW1pIFpvaGFyDQo+ID4gU2VudDogV2VkbmVzZGF5LCBKYW51YXJ5IDI5LCAyMDIw
IDExOjUxIFBNDQo+ID4gVG86IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pg0KPiA+IENjOiBK
ZXJyeSBTbml0c2VsYWFyIDxqc25pdHNlbEByZWRoYXQuY29tPjsgbGludXgtDQo+IGludGVncml0
eUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gSmFtZXMgQm90dG9tbGV5IDxKYW1lcy5Cb3R0b21sZXlA
aGFuc2VucGFydG5lcnNoaXAuY29tPjsgbGludXgtDQo+ID4ga2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgUm9iZXJ0byBTYXNzdSA8cm9iZXJ0by5zYXNzdUBodWF3ZWkuY29tPg0KPiA+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggMS8yXSBpbWE6IHVzZSB0aGUgSU1BIGNvbmZpZ3VyZWQgaGFzaCBhbGdvIHRv
DQo+IGNhbGN1bGF0ZQ0KPiA+IHRoZSBib290IGFnZ3JlZ2F0ZQ0KPiA+DQo+ID4gT24gV2VkLCAy
MDIwLTAxLTI5IGF0IDA5OjMwICswMTAwLCBQZXRyIFZvcmVsIHdyb3RlOg0KPiA+ID4gSGkgTWlt
aSwNCj4gPiA+DQo+ID4gPiBSZXZpZXdlZC1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+
DQo+ID4gPg0KPiA+ID4gPiBUaGUgb3JpZ2luYWwgTFRQIGltYV9ib290X2FnZ3JlZ2F0ZS5jIHRl
c3QgbmVlZGVkIHRvIGJlIHVwZGF0ZWQgdG8NCj4gPiA+ID4gc3VwcG9ydCBUUE0gMi4wIGJlZm9y
ZSB0aGlzIGNoYW5nZS4gwqBGb3IgVFBNIDIuMCwgdGhlIFBDUnMgYXJlIG5vdA0KPiA+ID4gPiBl
eHBvcnRlZC4gwqBXaXRoIHRoaXMgY2hhbmdlLCB0aGUga2VybmVsIGNvdWxkIGJlIHJlYWRpbmcg
UENScyBmcm9tIGENCj4gPiA+ID4gVFBNIGJhbmsgb3RoZXIgdGhhbiBTSEExIGFuZCBjYWxjdWxh
dGluZyB0aGUgYm9vdF9hZ2dyZWdhdGUgYmFzZWQNCj4gb24NCj4gPiBhDQo+ID4gPiA+IGRpZmZl
cmVudCBoYXNoIGFsZ29yaXRobSBhcyB3ZWxsLiDCoEknbSBub3Qgc3VyZSBob3cgYSByZW1vdGUg
dmVyaWZpZXINCj4gPiA+ID4gd291bGQga25vdyB3aGljaCBUUE0gYmFuayB3YXMgcmVhZCwgd2hl
biBjYWxjdWxhdGluZyB0aGUgYm9vdC0NCj4gPiA+ID4gYWdncmVnYXRlLg0KPiA+ID4gTWltaSwg
ZG8geW91IHBsYW4gdG8gZG8gdXBkYXRlIExUUCB0ZXN0Pw0KPiA+DQo+ID4gSW4gb3JkZXIgdG8g
dGVzdCBSb2JlcnRvJ3MgcGF0Y2hlcyB0aGF0IGNhbGN1bGF0ZXMgYW5kIGV4dGVuZHMgdGhlDQo+
ID4gZGlmZmVyZW50IFRQTSBiYW5rcyB3aXRoIHRoZSBhcHByb3ByaWF0ZSBoYXNoZXMsIHdlJ2xs
IG5lZWQgc29tZSB0ZXN0DQo+ID4gdG8gdmVyaWZ5IHRoYXQgaXQgaXMgd29ya2luZyBwcm9wZXJs
eS4gwqBBcyB0byB3aGV0aGVyIHRoaXMgd2lsbCBiZSBpbg0KPiA+IExUUCBvciBpbWEtZXZtLXV0
aWxzLCBJJ20gbm90IHN1cmUuDQo+IA0KPiBhdHRlc3QtdG9vbHMgKGh0dHBzOi8vZ2l0aHViLmNv
bS9ldWxlcm9zL2F0dGVzdC10b29scywgYnJhbmNoIDAuMi1kZXZlbCkgaGFzDQo+IHRoZQ0KPiBh
YmlsaXR5IHRvIHBhcnNlIHRoZSBCSU9TIGFuZCBJTUEgZXZlbnQgbG9ncywgYW5kIHRvIGNvbXBh
cmUNCj4gYm9vdF9hZ2dyZWdhdGUNCj4gd2l0aCB0aGUgZGlnZXN0IG9mIGZpbmFsIFBDUiB2YWx1
ZXMgb2J0YWluZWQgYnkgcGVyZm9ybWluZyBpbiBzb2Z0d2FyZSB0aGUNCj4gUENSDQo+IGV4dGVu
ZCBvcGVyYXRpb24gd2l0aCBkaWdlc3RzIGluIHRoZSBCSU9TIGV2ZW50IGxvZy4NCj4gDQo+IFRv
IHBlcmZvcm0gdGhlIHRlc3QsIGl0IGlzIG5lY2Vzc2FyeSB0byBoYXZlIGEgY29tcGxldGUgQklP
UyBldmVudCBsb2cuDQo+IA0KPiBDcmVhdGUgcmVxLmpzb24gd2l0aCB0aGlzIGNvbnRlbnQ6DQo+
IC0tLQ0KPiB7DQo+ICAgInJlcXMiOnsNCj4gICAgICJkdW1teXx2ZXJpZnkiOiIiLA0KPiAgICAg
ImltYV9ib290X2FnZ3JlZ2F0ZXx2ZXJpZnkiOiIiDQo+ICAgfQ0KPiB9DQo+IC0tLQ0KPiANCj4g
V2l0aCB0aGUgcmVxdWlyZW1lbnRzIGFib3ZlLCB3ZSBhcmUgdGVsbGluZyBhdHRlc3QtdG9vbHMg
dG8gdmVyaWZ5IG9ubHkNCj4gYm9vdF9hZ2dyZWdhdGUuIFdpdGhvdXQgdGhlIGR1bW15IHJlcXVp
cmVtZW50LCB2ZXJpZmljYXRpb24gd291bGQNCj4gZmFpbCAoQklPUyBhbmQgcmVtYWluaW5nIElN
QSBtZWFzdXJlbWVudCBlbnRyaWVzIGFyZSBub3QgcHJvY2Vzc2VkKS4NCj4gDQo+IE9uIHNlcnZl
ciBzaWRlIHJ1bjoNCj4gIyBhdHRlc3RfcmFfc2VydmVyIC1wIDEwIC1yIHJlcS5qc29uIC1zIC1p
DQo+IA0KPiAtcyBkaXNhYmxlcyBUUE0gc2lnbmF0dXJlIHZlcmlmaWNhdGlvbg0KPiAtaSBhbGxv
d3MgSU1BIHZpb2xhdGlvbnMNCj4gDQo+IFRvIGVuYWJsZSBUUE0gc2lnbmF0dXJlIHZlcmlmaWNh
dGlvbiBpdCBpcyBuZWNlc3NhcnkgdG8gaGF2ZSBhIHZhbGlkIEFLDQo+IGNlcnRpZmljYXRlLiBJ
dCBjYW4gYmUgb2J0YWluZWQgYnkgZm9sbG93aW5nIHRoZSBpbnN0cnVjdGlvbnMgYXQ6DQo+IA0K
PiBodHRwczovL2dpdGh1Yi5jb20vZXVsZXJvcy9hdHRlc3QtdG9vbHMvYmxvYi8wLjItZGV2ZWwv
UkVBRE1FDQo+IA0KPiBPbiBjbGllbnQgc2lkZSBydW46DQo+ICMgZWNobyB0ZXN0ID4gYWlrX2Nl
cnQucGVtDQo+ICMgZWNobyBhaWtfY2VydC5wZW0gPiBsaXN0X3ByaXZhY3lfY2ENCj4gIyBhdHRl
c3RfcmFfY2xpZW50IC1BDQo+IA0KPiBUaGUgY29tbWFuZCBhYm92ZSBnZW5lcmF0ZXMgYW4gQUsu
DQo+IA0KPiAjIGF0dGVzdF9yYV9jbGllbnQgLXMgPHNlcnZlciBJUD4gLXEgLXAgMTAgLVAgPFBD
UiBhbGdvPiAtYiAtaQ0KPiANCj4gVGhlIGNvbW1hbmQgYWJvdmUgc2VuZHMgdGhlIFRQTSBxdW90
ZSBhbmQgdGhlIGV2ZW50IGxvZ3MNCj4gdG8gdGhlIFJBIHNlcnZlciBhbmQgZ2V0cyB0aGUgcmVz
cG9uc2UgKHN1Y2Nlc3NmdWwvZmFpbGVkDQo+IHZlcmlmaWNhdGlvbikuDQo+IA0KPiAtYiBpbmNs
dWRlcyB0aGUgQklPUyBldmVudCBsb2cgZnJvbSBzZWN1cml0eWZzDQo+IC1pIGluY2x1ZGVzIHRo
ZSBJTUEgZXZlbnQgbG9nIGZyb20gc2VjdXJpdHlmcw0KPiANCj4gVG8gY2hlY2sgdGhhdCBib290
X2FnZ3JlZ2F0ZSBpcyBjYWxjdWxhdGVkIHByb3Blcmx5LCB1c2UgLVAgc2hhMjU2DQoNCmFuZCB0
byBjaGVjayB0aGF0IElNQSBleHRlbmRzIG5vbi1TSEExIFBDUiBiYW5rcyB3aXRoIGFuIGFwcHJv
cHJpYXRlDQpkaWdlc3QsDQoNCj4gaW4gYXR0ZXN0X3JhX2NsaWVudCBhbmQgc2V0IGltYV9oYXNo
PXNoYTI1NiBpbiB0aGUga2VybmVsIGNvbW1hbmQNCj4gbGluZS4NCg0KUm9iZXJ0bw0KDQpIVUFX
RUkgVEVDSE5PTE9HSUVTIER1ZXNzZWxkb3JmIEdtYkgsIEhSQiA1NjA2Mw0KTWFuYWdpbmcgRGly
ZWN0b3I6IExpIFBlbmcsIExpIEppYW4sIFNoaSBZYW5saQ0K
