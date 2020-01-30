Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB96A14DE87
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jan 2020 17:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbgA3QLR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Jan 2020 11:11:17 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2331 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727107AbgA3QLQ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Jan 2020 11:11:16 -0500
Received: from lhreml707-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id BAA1C81DE1A523018B18;
        Thu, 30 Jan 2020 16:11:14 +0000 (GMT)
Received: from fraeml701-chm.china.huawei.com (10.206.15.50) by
 lhreml707-cah.china.huawei.com (10.201.108.48) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 30 Jan 2020 16:11:13 +0000
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Thu, 30 Jan 2020 17:11:13 +0100
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1713.004;
 Thu, 30 Jan 2020 17:11:13 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "james.bottomley@hansenpartnership.com" 
        <james.bottomley@hansenpartnership.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
CC:     "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: RE: [PATCH 1/8] tpm: initialize crypto_id of allocated_banks to
 HASH_ALGO__LAST
Thread-Topic: [PATCH 1/8] tpm: initialize crypto_id of allocated_banks to
 HASH_ALGO__LAST
Thread-Index: AQHV1TQUqrSCCRsJMUCD8Unf5gKCoagC2LQAgACMVSA=
Date:   Thu, 30 Jan 2020 16:11:12 +0000
Message-ID: <8c15cf66708a4d38916b8ca39f26b5f6@huawei.com>
References: <20200127170443.21538-1-roberto.sassu@huawei.com>
         <20200127170443.21538-2-roberto.sassu@huawei.com>
 <50afe1f50297b02af52621b6738ffff0c24f1bdf.camel@linux.intel.com>
In-Reply-To: <50afe1f50297b02af52621b6738ffff0c24f1bdf.camel@linux.intel.com>
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYXJra28gU2Fra2luZW4gW21h
aWx0bzpqYXJra28uc2Fra2luZW5AbGludXguaW50ZWwuY29tXQ0KPiBTZW50OiBUaHVyc2RheSwg
SmFudWFyeSAzMCwgMjAyMCA5OjQ4IEFNDQo+IFRvOiBSb2JlcnRvIFNhc3N1IDxyb2JlcnRvLnNh
c3N1QGh1YXdlaS5jb20+OyB6b2hhckBsaW51eC5pYm0uY29tOw0KPiBqYW1lcy5ib3R0b21sZXlA
aGFuc2VucGFydG5lcnNoaXAuY29tOyBsaW51eC1pbnRlZ3JpdHlAdmdlci5rZXJuZWwub3JnDQo+
IENjOiBsaW51eC1zZWN1cml0eS1tb2R1bGVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOw0KPiBTaWx2aXUgVmxhc2NlYW51IDxTaWx2aXUuVmxhc2NlYW51QGh1
YXdlaS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS84XSB0cG06IGluaXRpYWxpemUgY3J5
cHRvX2lkIG9mIGFsbG9jYXRlZF9iYW5rcyB0bw0KPiBIQVNIX0FMR09fX0xBU1QNCj4gDQo+IE9u
IE1vbiwgMjAyMC0wMS0yNyBhdCAxODowNCArMDEwMCwgUm9iZXJ0byBTYXNzdSB3cm90ZToNCj4g
PiBjaGlwLT5hbGxvY2F0ZWRfYmFua3MgY29udGFpbnMgdGhlIGxpc3Qgb2YgVFBNIGFsZ29yaXRo
bSBJRHMgb2YgYWxsb2NhdGVkDQo+ID4gUENSIGJhbmtzLiBJdCBhbHNvIGNvbnRhaW5zIHRoZSBj
b3JyZXNwb25kaW5nIElEIG9mIHRoZSBjcnlwdG8gc3Vic3lzdGVtLA0KPiA+IHNvIHRoYXQgdXNl
cnMgb2YgdGhlIFRQTSBkcml2ZXIgY2FuIGNhbGN1bGF0ZSBhIGRpZ2VzdCBmb3IgYSBQQ1IgZXh0
ZW5kDQo+ID4gb3BlcmF0aW9uLg0KPiA+DQo+ID4gSG93ZXZlciwgaWYgdGhlcmUgaXMgbm8gbWFw
cGluZyBiZXR3ZWVuIFRQTSBhbGdvcml0aG0gSUQgYW5kIGNyeXB0byBJRCwNCj4gdGhlDQo+ID4g
Y3J5cHRvX2lkIGZpZWxkIGluIGNoaXAtPmFsbG9jYXRlZF9iYW5rcyByZW1haW5zIHNldCB0byB6
ZXJvICh0aGUgYXJyYXkgaXMNCj4gPiBhbGxvY2F0ZWQgYW5kIGluaXRpYWxpemVkIHdpdGgga2Nh
bGxvYygpIGluIHRwbTJfZ2V0X3Bjcl9hbGxvY2F0aW9uKCkpLg0KPiA+IFplcm8gc2hvdWxkIG5v
dCBiZSB1c2VkIGFzIHZhbHVlIGZvciB1bmtub3duIG1hcHBpbmdzLCBhcyBpdCBpcyBhIHZhbGlk
DQo+ID4gY3J5cHRvIElEIChIQVNIX0FMR09fTUQ0KS4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggaW5p
dGlhbGl6ZXMgY3J5cHRvX2lkIHRvIEhBU0hfQUxHT19fTEFTVC4NCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFJvYmVydG8gU2Fzc3UgPHJvYmVydG8uc2Fzc3VAaHVhd2VpLmNvbT4tLS0NCj4gDQo+
IFJlbWFya3M6DQo+IA0KPiAqIEFmdGVyIHRoZSBzdWJzeXN0ZW0gdGFnLCBzaG9ydCBzdW1tYXJ5
IHN0YXJ0cyB3aXRoIGEgY2FwaXRhbCBsZXR0dGVyLg0KPiAqIE1pc3NpbmcgZml4ZXMgdGFnIGFu
ZCBjYyB0YWcgdG8gc3RhYmxlLg0KPiAqIEEgc3RydWN0IGNhbGxlZCBhbGxvY2F0ZWRfYmFua3Mg
ZG9lcyBub3QgZXhpc3QuDQo+ICogUGxlYXNlIHByZWZlciB1c2luZyBhbiBpbXBlcmF0aXZlIHNl
bnRlbmNlIHdoZW4gZGVzY3JpYmluZyB0aGUgYWN0aW9uDQo+ICAgdG8gdGFrZSBlLmcuICJUaHVz
LCBpbml0aWFsaXplIGNyeXB0b19pZCB0byBIQVNIX0FMR09fX0xBU1QiLg0KDQpUaGFua3MuIEkg
d2lsbCBmaXggdGhlc2UgaXNzdWVzIGluIHRoZSBuZXh0IHZlcnNpb24gb2YgdGhlIHBhdGNoIHNl
dC4NCg0KUm9iZXJ0bw0KDQpIVUFXRUkgVEVDSE5PTE9HSUVTIER1ZXNzZWxkb3JmIEdtYkgsIEhS
QiA1NjA2Mw0KTWFuYWdpbmcgRGlyZWN0b3I6IExpIFBlbmcsIExpIEppYW4sIFNoaSBZYW5saQ0K
