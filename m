Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 511EE132D9C
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jan 2020 18:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgAGRxT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Jan 2020 12:53:19 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2234 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728348AbgAGRxT (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Jan 2020 12:53:19 -0500
Received: from lhreml709-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id BFC26D4BCCE41A065C63;
        Tue,  7 Jan 2020 17:53:16 +0000 (GMT)
Received: from fraeml702-chm.china.huawei.com (10.206.15.51) by
 lhreml709-cah.china.huawei.com (10.201.108.32) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 7 Jan 2020 17:53:16 +0000
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Tue, 7 Jan 2020 18:53:16 +0100
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1713.004;
 Tue, 7 Jan 2020 18:53:15 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Ken Goldman <kgold@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>,
        Ken Goldman <kgoldman@us.ibm.com>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: RE: Spec needed for ima-modsig template
Thread-Topic: Spec needed for ima-modsig template
Thread-Index: AQHVwajDjTo9n9gJ7UasdKj/Cb2NzafXwXKAgAAhPYCAABAcAIABP/OAgAHnuwCAAo7BAIAAFLGAgAADNICAASRFoIAAaB4AgAAYkKA=
Date:   Tue, 7 Jan 2020 17:53:15 +0000
Message-ID: <191aee7d3b5c491ebd0a19850563cb5d@huawei.com>
References: <e2e2863e-9908-5156-8aca-32f8e583f0e3@linux.ibm.com>
 <1577996725.5874.114.camel@linux.ibm.com>
 <584145d6-bf12-e5ee-972f-91283aa66f74@linux.ibm.com>
 <1578007322.5874.128.camel@linux.ibm.com>
 <69ef3bb7-abdd-8c18-1afc-722d35a807c1@linux.ibm.com>
 <1578180770.5152.30.camel@linux.ibm.com>
 <748a5aaf-8537-4313-a020-18c57a6056bb@linux.ibm.com>
 <1578325821.5222.42.camel@linux.ibm.com>
 <7415a1ba-7fa9-4e86-f143-a3bc1bfdc80f@linux.ibm.com>
 <249898ce999b4385927a076aa2679726@huawei.com>
 <0cdf74d5-671f-7958-c74f-6dc82bf3077e@linux.ibm.com>
In-Reply-To: <0cdf74d5-671f-7958-c74f-6dc82bf3077e@linux.ibm.com>
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLZW4gR29sZG1hbiBbbWFpbHRv
Omtnb2xkQGxpbnV4LmlibS5jb21dDQo+IFNlbnQ6IFR1ZXNkYXksIEphbnVhcnkgNywgMjAyMCA0
OjQxIFBNDQo+IFRvOiBSb2JlcnRvIFNhc3N1IDxyb2JlcnRvLnNhc3N1QGh1YXdlaS5jb20+OyBN
aW1pIFpvaGFyDQo+IDx6b2hhckBsaW51eC5pYm0uY29tPjsgTGludXggSW50ZWdyaXR5IDxsaW51
eC1pbnRlZ3JpdHlAdmdlci5rZXJuZWwub3JnPjsNCj4gS2VuIEdvbGRtYW4gPGtnb2xkbWFuQHVz
LmlibS5jb20+OyBTaWx2aXUgVmxhc2NlYW51DQo+IDxTaWx2aXUuVmxhc2NlYW51QGh1YXdlaS5j
b20+DQo+IFN1YmplY3Q6IFJlOiBTcGVjIG5lZWRlZCBmb3IgaW1hLW1vZHNpZyB0ZW1wbGF0ZQ0K
PiANCj4gT24gMS83LzIwMjAgMzo1MyBBTSwgUm9iZXJ0byBTYXNzdSB3cm90ZToNCj4gPiBEZWZp
bmluZyBhIHNwZWNpZmljYXRpb24gZm9yIHdoaWNoIGNvbWJpbmF0aW9ucw0KPiA+IGFyZSBsZWdp
dGltYXRlIHdvdWxkIGRlZmluaXRlbHkgaGVscC4NCj4gDQo+IFRoYXQncyBteSBnb2FsLg0KPiAN
Cj4gPj4gVGhlcmUgYXJlIDgtOSBkaWZmZXJlbnQgcG9zc2libGUgSU1BIGxvZyBmaWVsZHMsIGFu
ZCB3ZSBoYXZlIHRvIGFzc3VtZQ0KPiA+PiB0aGUgYXR0YWNrZXIgd2lsbCBjb3JydXB0IGFueSBv
ciBhbGwgb2YgdGhlbS4NCj4gPg0KPiA+IFRlbXBsYXRlIGRhdGEgaXMgcHJvdGVjdGVkIGJ5IHRo
ZSBUUE0uIEFueSBjb3JydXB0aW9uIGNhbiBiZSBkZXRlY3RlZA0KPiA+IGJ5IGNvbXBhcmluZyB0
aGUgcXVvdGVkIFBDUnMgd2l0aCB0aGUgUENScyBjYWxjdWxhdGVkIGZyb20gdGhlDQo+IHRlbXBs
YXRlDQo+ID4gZGlnZXN0Lg0KPiANCj4gQW4gYXR0YWNrZXIgY2FuIGNyZWF0ZSBhIGN1c3RvbSB0
ZW1wbGF0ZSBvciBldmVuIG1vZGlmeSB0aGUgSU1BIHNvdXJjZQ0KPiBzbyB0aGF0IHRoZSBoYXNo
ZXMgYW5kIFBDUnMgbWF0Y2guICBUaGVuIHRoZXkgc2VuZCB0aGUgbWFsZm9ybWVkIGxvZyB0bw0K
PiB0aGUgdmVyaWZpZXIgdG8gdHJ5IHRvIGV4cGxvaXQgYSB2dWxuZXJhYmlsaXR5Lg0KDQpNb2Rp
ZnlpbmcgdGhlIElNQSBzb3VyY2UgY2FuIGJlIGV4Y2x1ZGVkIGZyb20gcG9zc2libGUgYXR0YWNr
cy4gVGhlDQptb2RpZmllZCBrZXJuZWwgY2FuIGJlIGRldGVjdGVkIGZyb20gdGhlIEJJT1MgZXZl
bnQgbG9nLg0KDQo+IEUuZy4sIHRoZSBjdXN0b20gdGVtcGxhdGUgJ2Qtbmd8ZC1uZ3wgLi4uJyBy
ZXBlYXRlZCAxLDAwMCwwMDAsMDAwIHRpbWVzLg0KDQpDdXJyZW50bHksIHRoZSBudW1iZXIgb2Yg
ZmllbGRzIGluIGEgdGVtcGxhdGUgZm9ybWF0IGNhbiBiZSBhdCBtb3N0DQpJTUFfVEVNUExBVEVf
TlVNX0ZJRUxEU19NQVguIEkgZG9uJ3Qga25vdyBpZiByZXBlYXRpbmcgdGhlIHNhbWUNCnRlbXBs
YXRlIGZpZWxkIGNvdWxkIGludHJvZHVjZSBtb3JlIHJpc2tzLg0KDQo+ID4gV2hhdCBpdCByZW1h
aW5zIHRvIGJlIGRvbmUgaXMgdG8gaW5jbHVkZSB0aGUgdGVtcGxhdGUgbmFtZSBpbiB0aGUNCj4g
PiBjYWxjdWxhdGlvbiBvZiB0aGUgdGVtcGxhdGUgZGlnZXN0Lg0KPiANCj4gVGhlcmUncyBhIGJh
Y2t3YXJkIGNvbXBhdGliaWxpdHkgaXNzdWUgZm9yIG9sZCB0ZW1wbGF0ZXMuICBJcyBpdA0KPiBm
ZWFzaWJsZSBmb3IgbmV3IHRlbXBsYXRlcyBhbmQgbmV3IG5hbWVzIC0gc3RhcnQgY3JlYXRpbmcg
dGFncyBhbmQNCj4gaW5jbHVkZSB0aGVtIGluIHRoZSB0ZW1wbGF0ZSBkYXRhIHNvIHRoZXkgZ2V0
cyBoYXNoZWQ/DQoNCkkgd291bGQgc3VnZ2VzdCB0aGUgZm9sbG93aW5nIGZvcm1hdHMgKHdpdGhv
dXQgYW5kIHdpdGggdGFncyksIHRvIG1ha2UNCml0IGVhc2llciBmb3IgdGhlIHBhcnNlcnMgdG8g
ZGlzdGluZ3Vpc2ggYmV0d2VlbiB0aGUgb2xkIGFuZCB0aGUgbmV3IGZvcm1hdC4NCg0KQXNzdW1p
bmcgdGhhdCB0aGUgdGVtcGxhdGUgZm9ybWF0IGlzICdmaWVsZCMwfC4uLnxmaWVsZCNOJywgdGhl
IGJpbmFyeQ0KZm9ybWF0IG9mIGVhY2ggbWVhc3VyZW1lbnQgZW50cnkgd2l0aG91dCB0YWdzIGJl
Y29tZXM6DQoNCjxQQ1I+PHRlbXBsYXRlIGRpZ2VzdD48dG90YWwgbGVuPlwwPHRlbXBsYXRlIG5h
bWUgbGVuPjx0ZW1wbGF0ZSBuYW1lPg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8bGVuIzA+PGRhdGEj
MD4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgPGxlbiNOPjxkYXRhI04+DQoNClRlbXBsYXRlIG5hbWUg
Y2FuIGJlIG9uZSBvZiB0aGUgZGVmaW5lZCB0ZW1wbGF0ZXMgb3IgJ2ZpZWxkIzB8Li4ufGZpZWxk
I04nLA0KaWYgdGhlIHVzZXIgc3BlY2lmaWVzIGEgY3VzdG9tIGZvcm1hdC4NCg0KVGhlIGJpbmFy
eSBmb3JtYXQgd2l0aCB0YWdzIGJlY29tZXM6DQoNCjxQQ1I+PHRlbXBsYXRlIGRpZ2VzdD48dG90
YWwgbGVuPlwwPHRhZyMwPjxsZW4jMD48ZGF0YSMwPg0KICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8dGFn
I04+PGxlbiNOPjxkYXRhI04+DQoNClRhZyBkZWZpbml0aW9uIG11c3QgYmUgYXZhaWxhYmxlIGZv
ciB1c2VyIHNwYWNlIGFwcGxpY2F0aW9ucy4NCg0KVGhlIFwwIGFmdGVyIDx0b3RhbCBsZW4+IGFs
bG93cyBwYXJzZXJzIHRvIGRpc3Rpbmd1aXNoIGJldHdlZW4gdGhlIG9sZCBhbmQNCnRoZSBuZXcg
Zm9ybWF0LiBJZiB0aGVyZSBpcyBubyBcMCwgcGFyc2VycyBhc3N1bWUgdGhhdCA8dG90YWwgbGVu
PiBpcyB0aGUNCnRlbXBsYXRlIG5hbWUgbGVuZ3RoIG9mIHRoZSBvbGQgZm9ybWF0Lg0KDQpGb3Ig
dGhlIG5ldyBmb3JtYXQsIHRlbXBsYXRlIGRpZ2VzdCBpcyBjYWxjdWxhdGVkIG9uIGRhdGEgYWZ0
ZXIgPHRvdGFsIGxlbj4uDQoNClJvYmVydG8NCg==
