Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D16EA285F4D
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Oct 2020 14:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgJGMit (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Oct 2020 08:38:49 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2964 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727927AbgJGMit (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Oct 2020 08:38:49 -0400
Received: from lhreml737-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 51B82FE16407BB6B87D2;
        Wed,  7 Oct 2020 13:38:44 +0100 (IST)
Received: from fraeml702-chm.china.huawei.com (10.206.15.51) by
 lhreml737-chm.china.huawei.com (10.201.108.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Wed, 7 Oct 2020 13:38:44 +0100
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 7 Oct 2020 14:38:43 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1913.007;
 Wed, 7 Oct 2020 14:38:43 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Colin King <colin.king@canonical.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Roberto Sassu <roberto.sassu@polito.it>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Silviu Vlasceanu" <Silviu.Vlasceanu@huawei.com>
Subject: RE: [PATCH] ima: Fix sizeof mismatches
Thread-Topic: [PATCH] ima: Fix sizeof mismatches
Thread-Index: AQHWnJmhl+2ccdx8rkqE0F+MK/ZxlKmMEx7g
Date:   Wed, 7 Oct 2020 12:38:43 +0000
Message-ID: <cf66956ac2df49e6b51cacf94a8a31b9@huawei.com>
References: <20201007110243.19033-1-colin.king@canonical.com>
In-Reply-To: <20201007110243.19033-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.220.96.108]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

PiBGcm9tOiBDb2xpbiBLaW5nIFttYWlsdG86Y29saW4ua2luZ0BjYW5vbmljYWwuY29tXQ0KPiBT
ZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgNywgMjAyMCAxOjAzIFBNDQo+IEZyb206IENvbGluIElh
biBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+DQo+IA0KPiBBbiBpbmNvcnJlY3Qgc2l6
ZW9mIGlzIGJlaW5nIHVzZWQsIHNpemVvZigqZmllbGRzKSBpcyBub3QgY29ycmVjdCwNCj4gaXQg
c2hvdWxkIGJlIHNpemVvZigqKmZpZWxkcykuIFRoaXMgaXMgbm90IGNhdXNpbmcgYSBwcm9ibGVt
IHNpbmNlDQo+IHRoZSBzaXplIG9mIHRoZXNlIGlzIHRoZSBzYW1lLiBGaXggdGhpcyBpbiB0aGUg
a21hbGxvY19hcnJheSBhbmQNCj4gbWVtY3B5IGNhbGxzLg0KPiANCj4gQWRkcmVzc2VzLUNvdmVy
aXR5OiAoIlNpemVvZiBub3QgcG9ydGFibGUgKFNJWkVPRl9NSVNNQVRDSCkiKQ0KPiBGaXhlczog
MWJkN2ZhY2U3NDM5ICgiaW1hOiBhbGxvY2F0ZSBmaWVsZCBwb2ludGVycyBhcnJheSBvbiBkZW1h
bmQgaW4NCj4gdGVtcGxhdGVfZGVzY19pbml0X2ZpZWxkcygpIikNCj4gU2lnbmVkLW9mZi1ieTog
Q29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4NCg0KVGhhbmtzIENvbGlu
Lg0KDQpSZXZpZXdlZC1ieTogUm9iZXJ0byBTYXNzdSA8cm9iZXJ0by5zYXNzdUBodWF3ZWkuY29t
Pg0KDQpSb2JlcnRvDQoNCkhVQVdFSSBURUNITk9MT0dJRVMgRHVlc3NlbGRvcmYgR21iSCwgSFJC
IDU2MDYzDQpNYW5hZ2luZyBEaXJlY3RvcjogTGkgUGVuZywgTGkgSmlhbiwgU2hpIFlhbmxpDQoN
Cj4gLS0tDQo+ICBzZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV90ZW1wbGF0ZS5jIHwgNCArKy0t
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX3RlbXBsYXRlLmMNCj4g
Yi9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV90ZW1wbGF0ZS5jDQo+IGluZGV4IDFlODllMmQz
ODUxZi4uODg4NGJiZjAzYjQzIDEwMDY0NA0KPiAtLS0gYS9zZWN1cml0eS9pbnRlZ3JpdHkvaW1h
L2ltYV90ZW1wbGF0ZS5jDQo+ICsrKyBiL3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX3RlbXBs
YXRlLmMNCj4gQEAgLTIxNiwxMSArMjE2LDExIEBAIGludCB0ZW1wbGF0ZV9kZXNjX2luaXRfZmll
bGRzKGNvbnN0IGNoYXINCj4gKnRlbXBsYXRlX2ZtdCwNCj4gIAl9DQo+IA0KPiAgCWlmIChmaWVs
ZHMgJiYgbnVtX2ZpZWxkcykgew0KPiAtCQkqZmllbGRzID0ga21hbGxvY19hcnJheShpLCBzaXpl
b2YoKmZpZWxkcyksIEdGUF9LRVJORUwpOw0KPiArCQkqZmllbGRzID0ga21hbGxvY19hcnJheShp
LCBzaXplb2YoKipmaWVsZHMpLCBHRlBfS0VSTkVMKTsNCj4gIAkJaWYgKCpmaWVsZHMgPT0gTlVM
TCkNCj4gIAkJCXJldHVybiAtRU5PTUVNOw0KPiANCj4gLQkJbWVtY3B5KCpmaWVsZHMsIGZvdW5k
X2ZpZWxkcywgaSAqIHNpemVvZigqZmllbGRzKSk7DQo+ICsJCW1lbWNweSgqZmllbGRzLCBmb3Vu
ZF9maWVsZHMsIGkgKiBzaXplb2YoKipmaWVsZHMpKTsNCj4gIAkJKm51bV9maWVsZHMgPSBpOw0K
PiAgCX0NCj4gDQo+IC0tDQo+IDIuMjcuMA0KDQo=
