Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9C81321B2
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jan 2020 09:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgAGIxD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Jan 2020 03:53:03 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2229 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725801AbgAGIxD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Jan 2020 03:53:03 -0500
Received: from lhreml709-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id AFA7124492D8B3AE3416;
        Tue,  7 Jan 2020 08:53:01 +0000 (GMT)
Received: from fraeml701-chm.china.huawei.com (10.206.15.50) by
 lhreml709-cah.china.huawei.com (10.201.108.32) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 7 Jan 2020 08:53:01 +0000
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Tue, 7 Jan 2020 09:53:01 +0100
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1713.004;
 Tue, 7 Jan 2020 09:53:00 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Ken Goldman <kgold@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>,
        Ken Goldman <kgoldman@us.ibm.com>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: RE: Spec needed for ima-modsig template
Thread-Topic: Spec needed for ima-modsig template
Thread-Index: AQHVwajDjTo9n9gJ7UasdKj/Cb2NzafXwXKAgAAhPYCAABAcAIABP/OAgAHnuwCAAo7BAIAAFLGAgAADNICAASRFoA==
Date:   Tue, 7 Jan 2020 08:53:00 +0000
Message-ID: <249898ce999b4385927a076aa2679726@huawei.com>
References: <e2e2863e-9908-5156-8aca-32f8e583f0e3@linux.ibm.com>
 <1577996725.5874.114.camel@linux.ibm.com>
 <584145d6-bf12-e5ee-972f-91283aa66f74@linux.ibm.com>
 <1578007322.5874.128.camel@linux.ibm.com>
 <69ef3bb7-abdd-8c18-1afc-722d35a807c1@linux.ibm.com>
 <1578180770.5152.30.camel@linux.ibm.com>
 <748a5aaf-8537-4313-a020-18c57a6056bb@linux.ibm.com>
 <1578325821.5222.42.camel@linux.ibm.com>
 <7415a1ba-7fa9-4e86-f143-a3bc1bfdc80f@linux.ibm.com>
In-Reply-To: <7415a1ba-7fa9-4e86-f143-a3bc1bfdc80f@linux.ibm.com>
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
Lmtlcm5lbC5vcmddIE9uIEJlaGFsZiBPZiBLZW4gR29sZG1hbg0KPiBTZW50OiBNb25kYXksIEph
bnVhcnkgNiwgMjAyMCA1OjAyIFBNDQo+IFRvOiBNaW1pIFpvaGFyIDx6b2hhckBsaW51eC5pYm0u
Y29tPjsgTGludXggSW50ZWdyaXR5IDxsaW51eC0NCj4gaW50ZWdyaXR5QHZnZXIua2VybmVsLm9y
Zz47IEtlbiBHb2xkbWFuIDxrZ29sZG1hbkB1cy5pYm0uY29tPg0KPiBTdWJqZWN0OiBSZTogU3Bl
YyBuZWVkZWQgZm9yIGltYS1tb2RzaWcgdGVtcGxhdGUNCj4gDQo+IE9uIDEvNi8yMDIwIDEwOjUw
IEFNLCBNaW1pIFpvaGFyIHdyb3RlOg0KPiA+PiBJIGRpZCBoYXZlIGEgcXVlc3Rpb24gYWJvdXQg
dGhlICdkLW5nIHwgc2lnIHwgc2lnJyB0ZW1wbGF0ZS4gIElzIHRoYXQgYW4NCj4gPj4gZXJyb3Ig
b3IgY291bGQgYSBmaWxlIGJlIHNpZ25lZCB3aXRoIGUuZy4gYm90aCBSU0EtMjA0OCBhbmQgUlNB
LTMwNzI/DQo+ID4+DQo+ID4+IEV0Yy4gIFlvdSBjYW4gc2VlIHdoZXJlIEknbSBnb2luZyAtIHBy
ZWNpc2UgcnVsZXMgZm9yIGFuIElNQSBsb2cgdmVyaWZpZXIuDQo+ID4gVGhlICJzaWciIGZpZWxk
IGlzIHRoZSBvcmlnaW5hbCBJTUEgc2lnbmF0dXJlLCBzdG9yZWQgYXMgYW4gZXh0ZW5kZWQNCj4g
PiBhdHRyaWJ1dGUuIMKgSWYvd2hlbiBJTUEgZnMtdmVyaXR5IHN1cHBvcnQgaXMgYWRkZWQsIHRo
YXQgc2lnbmF0dXJlDQo+ID4gd291bGQgcmVxdWlyZSBkZWZpbmluZyBuZXcgZGlnZXN0IGFuZCBz
aWduYXR1cmUgZmllbGQgdHlwZXMuIMKgQQ0KPiA+IHRlbXBsYXRlIHdpdGggdHdvICJzaWciIGZp
ZWxkcyBkb2Vzbid0IG1ha2Ugc2Vuc2UuDQo+IA0KPiBXZSBjYW5ub3QgcHJldmVudCBhbiBhdHRh
Y2tlciBmcm9tIGNyZWF0aW5nIHRoZSBjdXN0b20gdGVtcGxhdGUgJ2QtbmcgfA0KPiBzaWcgfCBz
aWcnLCBub3IgY2FuIHdlIHByZXZlbnQgYW4gYXR0YWNrZXIgZnJvbSBzZW5kaW5nIHN1Y2ggYSBs
b2cgdG8gYQ0KPiB2ZXJpZmllci4gIFRodXMsIHdlIGhhdmUgdG8gc3BlY2lmeSB0byBhIHZlcmlm
aWVyIHdoYXQgbG9ncyBhcmUgdmFsaWQNCj4gYW5kIHdoYXQgbG9ncyBzaG91bGQgYmUgcmVqZWN0
ZWQgYW5kIGZsYWdnZWQgYXMgYW4gYXR0YWNrLg0KDQpUaGF0J3MgY29ycmVjdC4gQSB1c2VyIGNh
biBkZWZpbmUgYSB0ZW1wbGF0ZSB3aXRoIGFueSBmaWVsZCBoZSB3YW50cy4NCg0KV2hldGhlciB0
aGUgdGVtcGxhdGUgaXMgYWNjZXB0YWJsZSwgaXQgZGVwZW5kcyBvbiB0aGUgdmVyaWZpZXIgYW5k
IG9uDQpoaXMgcmVxdWlyZW1lbnRzLiBJZiB0aGUgdGVtcGxhdGUgY29udGFpbnMgYWxsIGZpZWxk
cyBuZWNlc3NhcnkgZm9yIHRoZQ0KdmVyaWZpY2F0aW9uLCB0aGF0IHNob3VsZCBiZSBmaW5lIGV2
ZW4gaWYgdGhhdCB0ZW1wbGF0ZSBjb250YWlucyByZWR1bmRhbnQNCmluZm9ybWF0aW9uLiBJZiB0
aGVyZSBhcmUgaW5jb25zaXN0ZW5jaWVzLCB0aGUgdmVyaWZpZXIgd291bGQgc2ltcGx5IHJldHVy
bg0KYW4gZXJyb3IgYXMgdmVyaWZpY2F0aW9uIHJlc3VsdC4gRGVmaW5pbmcgYSBzcGVjaWZpY2F0
aW9uIGZvciB3aGljaCBjb21iaW5hdGlvbnMNCmFyZSBsZWdpdGltYXRlIHdvdWxkIGRlZmluaXRl
bHkgaGVscC4NCg0KDQo+IFRoZXJlIGFyZSA4LTkgZGlmZmVyZW50IHBvc3NpYmxlIElNQSBsb2cg
ZmllbGRzLCBhbmQgd2UgaGF2ZSB0byBhc3N1bWUNCj4gdGhlIGF0dGFja2VyIHdpbGwgY29ycnVw
dCBhbnkgb3IgYWxsIG9mIHRoZW0uDQoNClRlbXBsYXRlIGRhdGEgaXMgcHJvdGVjdGVkIGJ5IHRo
ZSBUUE0uIEFueSBjb3JydXB0aW9uIGNhbiBiZSBkZXRlY3RlZA0KYnkgY29tcGFyaW5nIHRoZSBx
dW90ZWQgUENScyB3aXRoIHRoZSBQQ1JzIGNhbGN1bGF0ZWQgZnJvbSB0aGUgdGVtcGxhdGUNCmRp
Z2VzdC4NCg0KV2hhdCBpdCByZW1haW5zIHRvIGJlIGRvbmUgaXMgdG8gaW5jbHVkZSB0aGUgdGVt
cGxhdGUgbmFtZSBpbiB0aGUNCmNhbGN1bGF0aW9uIG9mIHRoZSB0ZW1wbGF0ZSBkaWdlc3QuDQoN
ClJvYmVydG8NCg==
