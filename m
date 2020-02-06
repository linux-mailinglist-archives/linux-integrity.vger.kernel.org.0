Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 746C615491F
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Feb 2020 17:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgBFQ1c (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Feb 2020 11:27:32 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2389 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727654AbgBFQ1b (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Feb 2020 11:27:31 -0500
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id C4144856613477B90F86;
        Thu,  6 Feb 2020 16:27:29 +0000 (GMT)
Received: from fraeml701-chm.china.huawei.com (10.206.15.50) by
 LHREML714-CAH.china.huawei.com (10.201.108.37) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 6 Feb 2020 16:27:29 +0000
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Thu, 6 Feb 2020 17:27:28 +0100
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1713.004;
 Thu, 6 Feb 2020 17:27:28 +0100
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
Thread-Index: AQHV3A/+rAKtbF80BkqxEfHd/18hO6gORlUAgAAVOaA=
Date:   Thu, 6 Feb 2020 16:27:28 +0000
Message-ID: <0b91e6977bac4cd5a638041adb3e76eb@huawei.com>
References: <20200205103317.29356-1-roberto.sassu@huawei.com>
         <20200205103317.29356-6-roberto.sassu@huawei.com>
 <1581005284.5585.422.camel@linux.ibm.com>
In-Reply-To: <1581005284.5585.422.camel@linux.ibm.com>
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
em9oYXJAbGludXguaWJtLmNvbV0NCj4gU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDYsIDIwMjAg
NTowOCBQTQ0KPiBUbzogUm9iZXJ0byBTYXNzdSA8cm9iZXJ0by5zYXNzdUBodWF3ZWkuY29tPjsN
Cj4gSmFtZXMuQm90dG9tbGV5QEhhbnNlblBhcnRuZXJzaGlwLmNvbTsNCj4gamFya2tvLnNha2tp
bmVuQGxpbnV4LmludGVsLmNvbQ0KPiBDYzogbGludXgtaW50ZWdyaXR5QHZnZXIua2VybmVsLm9y
ZzsgbGludXgtc2VjdXJpdHktbW9kdWxlQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgU2lsdml1IFZsYXNjZWFudQ0KPiA8U2lsdml1LlZsYXNjZWFudUBo
dWF3ZWkuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDUvOF0gaW1hOiBTd2l0Y2ggdG8g
ZHluYW1pY2FsbHkgYWxsb2NhdGVkIGJ1ZmZlciBmb3INCj4gdGVtcGxhdGUgZGlnZXN0cw0KPiAN
Cj4gSGkgUm9iZXJ0bywNCj4gDQo+IE9uIFdlZCwgMjAyMC0wMi0wNSBhdCAxMTozMyArMDEwMCwg
Um9iZXJ0byBTYXNzdSB3cm90ZToNCj4gPiBUaGlzIHBhdGNoIGR5bmFtaWNhbGx5IGFsbG9jYXRl
cyB0aGUgYXJyYXkgb2YgdHBtX2RpZ2VzdCBzdHJ1Y3R1cmVzIGluDQo+ID4gaW1hX2FsbG9jX2lu
aXRfdGVtcGxhdGUoKSBhbmQgaW1hX3Jlc3RvcmVfdGVtcGxhdGVfZGF0YSgpLiBUaGUgc2l6ZSBv
Zg0KPiB0aGUNCj4gPiBhcnJheSwgc3RvcmVkIGluIGltYV9udW1fdGVtcGxhdGVfZGlnZXN0cywg
aXMgaW5pdGlhbGx5IGVxdWFsIHRvIDEgKFNIQTEpDQo+ID4gYW5kIHdpbGwgYmUgZGV0ZXJtaW5l
ZCBpbiB0aGUgdXBjb21pbmcgcGF0Y2hlcyBkZXBlbmRpbmcgb24gdGhlDQo+IGFsbG9jYXRlZA0K
PiA+IFBDUiBiYW5rcyBhbmQgdGhlIGNob3NlbiBkZWZhdWx0IElNQSBhbGdvcml0aG0uDQo+ID4N
Cj4gPiBDYWxjdWxhdGluZyB0aGUgU0hBMSBkaWdlc3QgaXMgbWFuZGF0b3J5LCBhcyBTSEExIHN0
aWxsIHJlbWFpbnMgdGhlIGRlZmF1bHQNCj4gPiBoYXNoIGFsZ29yaXRobSBmb3IgdGhlIG1lYXN1
cmVtZW50IGxpc3QuIFdoZW4gSU1BIHdpbGwgc3VwcG9ydCB0aGUNCj4gQ3J5cHRvDQo+ID4gQWdp
bGUgZm9ybWF0LCByZW1haW5pbmcgZGlnZXN0cyB3aWxsIGJlIGFsc28gcHJvdmlkZWQuDQo+ID4N
Cj4gPiBUaGUgcG9zaXRpb24gaW4gdGhlIGFycmF5IG9mIHRoZSBTSEExIGRpZ2VzdCBpcyBzdG9y
ZWQgaW4gdGhlIGltYV9zaGExX2lkeA0KPiA+IGdsb2JhbCB2YXJpYWJsZSBhbmQgaXQgaXMgZGV0
ZXJtaW5lZCBhdCBJTUEgaW5pdGlhbGl6YXRpb24gdGltZS4NCj4gPg0KPiA+IENoYW5nZWxvZw0K
PiA+DQo+ID4gdjE6DQo+ID4gLSBtb3ZlIGltYV9zaGExX2lkeCB0byBpbWFfY3J5cHRvLmMNCj4g
PiAtIGludHJvZHVjZSBpbWFfbnVtX3RlbXBsYXRlX2RpZ2VzdHMgKHN1Z2dlc3RlZCBieSBNaW1p
KQ0KPiANCj4gSW5zdGVhZCBvZiBoYXJkY29kaW5nICJucl9hbGxvY2F0ZWRfYmFua3MgKyAxIiBv
ciBucl9hbGxvY2F0ZWRfYmFua3MgKw0KPiAyIiwgSSBzdWdnZXN0ZWQgZGVmaW5pbmcgIm5yX2Fs
bG9jYXRlZF9iYW5rcyArIGV4dHJhIiwgd2hlcmUgImV4dHJhIg0KPiBjb3VsZCBiZSAwLCAxLCBv
ciAyLg0KPiANCj4gVGhlIHJlc3Qgb2YgdGhlIGNvZGUgd291bGQgcmVtYWluIGV4YWN0bHkgdGhl
IHNhbWUgYXMgeW91IGhhZC4NCg0KT2suIEkgZGlkIGEgc21hbGwgaW1wcm92ZW1lbnQuIFNpbmNl
IHdlIGRldGVybWluZSB0aGUgbnVtYmVyIG9mDQpyZXF1aXJlZCBlbGVtZW50cyBvZiBpbWFfYWxn
b19hcnJheSBiZWZvcmUga21hbGxvYygpIEkgdGhvdWdodCBpdA0Kd2FzIG9rIHRvIGRpcmVjdGx5
IHNldCB0aGF0IG51bWJlciBvZiBlbGVtZW50cyBpbiBhIHNpbmdsZSB2YXJpYWJsZS4NCg0KSWYg
eW91IHRoaW5rIHRoYXQgaGF2aW5nIHR3byB2YXJpYWJsZXMgaXMgYmV0dGVyLCBJIHdpbGwgY2hh
bmdlIGl0Lg0KDQpUaGFua3MNCg0KUm9iZXJ0bw0KDQpIVUFXRUkgVEVDSE5PTE9HSUVTIER1ZXNz
ZWxkb3JmIEdtYkgsIEhSQiA1NjA2Mw0KTWFuYWdpbmcgRGlyZWN0b3I6IExpIFBlbmcsIExpIEpp
YW4sIFNoaSBZYW5saQ0K
