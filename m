Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6017C347414
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Mar 2021 10:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbhCXJBG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Mar 2021 05:01:06 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3384 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbhCXJAf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Mar 2021 05:00:35 -0400
Received: from DGGEML402-HUB.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4F52FK70T5z5g3B;
        Wed, 24 Mar 2021 16:57:57 +0800 (CST)
Received: from dggema751-chm.china.huawei.com (10.1.198.193) by
 DGGEML402-HUB.china.huawei.com (10.3.17.38) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Wed, 24 Mar 2021 17:00:28 +0800
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 dggema751-chm.china.huawei.com (10.1.198.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Wed, 24 Mar 2021 17:00:27 +0800
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2106.013;
 Wed, 24 Mar 2021 10:00:25 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     lihuafei <lihuafei1@huawei.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        yangjihong <yangjihong1@huawei.com>,
        Zhangjinhao <zhangjinhao2@huawei.com>
Subject: RE: [PATCH] ima: Fix the error code for restoring the PCR value
Thread-Topic: [PATCH] ima: Fix the error code for restoring the PCR value
Thread-Index: AQHXD91Wj9SbBJTtDEeMf5FsP/azT6qRo7OAgAFTVaA=
Date:   Wed, 24 Mar 2021 09:00:25 +0000
Message-ID: <0764ed04a7e84546a8b31fc13b264c47@huawei.com>
References: <20210303032824.124112-1-lihuafei1@huawei.com>
 <9df8d712-0e58-f95d-8f95-5feae2150b42@huawei.com>
In-Reply-To: <9df8d712-0e58-f95d-8f95-5feae2150b42@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.9.172]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

PiBGcm9tOiBsaWh1YWZlaQ0KPiBTZW50OiBUdWVzZGF5LCBNYXJjaCAyMywgMjAyMSAyOjQxIFBN
DQo+IHBpbmcuIDotKQ0KPiANCj4gT24gMjAyMS8zLzMgMTE6MjgsIExpIEh1YWZlaSB3cm90ZToN
Cj4gPiBJbiBpbWFfcmVzdG9yZV9tZWFzdXJlbWVudF9saXN0KCksIGhkcltIRFJfUENSXS5kYXRh
IGlzIHBvaW50aW5nIHRvIGENCj4gPiBidWZmZXIgb2YgdHlwZSB1OCwgd2hpY2ggY29udGFpbnMg
dGhlIGR1bXBlZCAzMi1iaXQgcGNyIHZhbHVlLg0KPiA+IEN1cnJlbnRseSwgb25seSB0aGUgbGVh
c3Qgc2lnbmlmaWNhbnQgYnl0ZSBpcyB1c2VkIHRvIHJlc3RvcmUgdGhlIHBjcg0KPiA+IHZhbHVl
LiBXZSBzaG91bGQgY29udmVydCBoZHJbSERSX1BDUl0uZGF0YSB0byBhIHBvaW50ZXIgb2YgdHlw
ZSB1MzINCj4gPiBiZWZvcmUgZmV0Y2hpbmcgdGhlIHZhbHVlIHRvIHJlc3RvcmUgdGhlIGNvcnJl
Y3QgcGNyIHZhbHVlLg0KPiA+DQo+ID4gRml4ZXM6IDQ3ZmRlZTYwYjQ3ZiAoImltYTogdXNlIGlt
YV9wYXJzZV9idWYoKSB0byBwYXJzZSBtZWFzdXJlbWVudHMNCj4gaGVhZGVycyIpDQo+ID4gU2ln
bmVkLW9mZi1ieTogTGkgSHVhZmVpIDxsaWh1YWZlaTFAaHVhd2VpLmNvbT4NCg0KSGkgTGkgSHVh
ZmVpDQoNCnllcywgY29ycmVjdC4gVGhhbmtzIGZvciB0aGUgcGF0Y2guDQoNClJldmlld2VkLWJ5
OiBSb2JlcnRvIFNhc3N1IDxyb2JlcnRvLnNhc3N1QGh1YXdlaS5jb20+DQoNClJvYmVydG8NCg0K
SFVBV0VJIFRFQ0hOT0xPR0lFUyBEdWVzc2VsZG9yZiBHbWJILCBIUkIgNTYwNjMNCk1hbmFnaW5n
IERpcmVjdG9yOiBMaSBQZW5nLCBMaSBKaWFuLCBTaGkgWWFubGkNCg0KPiA+IC0tLQ0KPiA+ICAg
c2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfdGVtcGxhdGUuYyB8IDQgKystLQ0KPiA+ICAgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV90ZW1wbGF0ZS5jDQo+IGIvc2Vj
dXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfdGVtcGxhdGUuYw0KPiA+IGluZGV4IGUyMmU1MTBhZTky
ZC4uNGUwODFlNjUwMDQ3IDEwMDY0NA0KPiA+IC0tLSBhL3NlY3VyaXR5L2ludGVncml0eS9pbWEv
aW1hX3RlbXBsYXRlLmMNCj4gPiArKysgYi9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV90ZW1w
bGF0ZS5jDQo+ID4gQEAgLTQ5NCw4ICs0OTQsOCBAQCBpbnQgaW1hX3Jlc3RvcmVfbWVhc3VyZW1l
bnRfbGlzdChsb2ZmX3Qgc2l6ZSwgdm9pZA0KPiAqYnVmKQ0KPiA+ICAgCQkJfQ0KPiA+ICAgCQl9
DQo+ID4NCj4gPiAtCQllbnRyeS0+cGNyID0gIWltYV9jYW5vbmljYWxfZm10ID8gKihoZHJbSERS
X1BDUl0uZGF0YSkgOg0KPiA+IC0JCQkgICAgIGxlMzJfdG9fY3B1KCooaGRyW0hEUl9QQ1JdLmRh
dGEpKTsNCj4gPiArCQllbnRyeS0+cGNyID0gIWltYV9jYW5vbmljYWxfZm10ID8gKih1MzINCj4g
KikoaGRyW0hEUl9QQ1JdLmRhdGEpIDoNCj4gPiArCQkJICAgICBsZTMyX3RvX2NwdSgqKHUzMiAq
KShoZHJbSERSX1BDUl0uZGF0YSkpOw0KPiA+ICAgCQlyZXQgPSBpbWFfcmVzdG9yZV9tZWFzdXJl
bWVudF9lbnRyeShlbnRyeSk7DQo+ID4gICAJCWlmIChyZXQgPCAwKQ0KPiA+ICAgCQkJYnJlYWs7
DQo+ID4NCg==
