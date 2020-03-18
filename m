Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE018189C28
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Mar 2020 13:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgCRMmo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Mar 2020 08:42:44 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2574 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726821AbgCRMmo (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Mar 2020 08:42:44 -0400
Received: from lhreml706-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id E0E895703F321FCD68A4;
        Wed, 18 Mar 2020 12:42:41 +0000 (GMT)
Received: from fraeml703-chm.china.huawei.com (10.206.15.52) by
 lhreml706-cah.china.huawei.com (10.201.108.47) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 18 Mar 2020 12:42:41 +0000
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Wed, 18 Mar 2020 13:42:40 +0100
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1713.004;
 Wed, 18 Mar 2020 13:42:40 +0100
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
Subject: RE: [PATCH v3 7/8] ima: Calculate and extend PCR with digests in
 ima_template_entry
Thread-Topic: [PATCH v3 7/8] ima: Calculate and extend PCR with digests in
 ima_template_entry
Thread-Index: AQHV3/maB4b2w9bxIkSFxAC0vgzFrag2UL0AgBgzWHA=
Date:   Wed, 18 Mar 2020 12:42:40 +0000
Message-ID: <fecf59c1880045769bfecc17b5670ac5@huawei.com>
References: <20200210100418.22049-1-roberto.sassu@huawei.com>
 <1583208222.8544.168.camel@linux.ibm.com>
In-Reply-To: <1583208222.8544.168.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.210.172.87]
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
IFR1ZXNkYXksIE1hcmNoIDMsIDIwMjAgNTowNCBBTQ0KPiBUbzogUm9iZXJ0byBTYXNzdSA8cm9i
ZXJ0by5zYXNzdUBodWF3ZWkuY29tPjsNCj4gSmFtZXMuQm90dG9tbGV5QEhhbnNlblBhcnRuZXJz
aGlwLmNvbTsNCj4gamFya2tvLnNha2tpbmVuQGxpbnV4LmludGVsLmNvbQ0KPiBDYzogbGludXgt
aW50ZWdyaXR5QHZnZXIua2VybmVsLm9yZzsgbGludXgtc2VjdXJpdHktbW9kdWxlQHZnZXIua2Vy
bmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgU2lsdml1IFZsYXNjZWFu
dQ0KPiA8U2lsdml1LlZsYXNjZWFudUBodWF3ZWkuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHYzIDcvOF0gaW1hOiBDYWxjdWxhdGUgYW5kIGV4dGVuZCBQQ1Igd2l0aCBkaWdlc3RzIGluDQo+
IGltYV90ZW1wbGF0ZV9lbnRyeQ0KPiANCj4gT24gTW9uLCAyMDIwLTAyLTEwIGF0IDExOjA0ICsw
MTAwLCBSb2JlcnRvIFNhc3N1IHdyb3RlOg0KPiANCj4gPiBAQCAtMjE5LDYgKzIxNCw4IEBAIGlu
dCBpbWFfcmVzdG9yZV9tZWFzdXJlbWVudF9lbnRyeShzdHJ1Y3QNCj4gaW1hX3RlbXBsYXRlX2Vu
dHJ5ICplbnRyeSkNCj4gPg0KPiA+ICBpbnQgX19pbml0IGltYV9pbml0X2RpZ2VzdHModm9pZCkN
Cj4gPiAgew0KPiA+ICsJdTE2IGRpZ2VzdF9zaXplOw0KPiA+ICsJdTE2IGNyeXB0b19pZDsNCj4g
PiAgCWludCBpOw0KPiA+DQo+ID4gIAlpZiAoIWltYV90cG1fY2hpcCkNCj4gPiBAQCAtMjI5LDgg
KzIyNiwxNyBAQCBpbnQgX19pbml0IGltYV9pbml0X2RpZ2VzdHModm9pZCkNCj4gPiAgCWlmICgh
ZGlnZXN0cykNCj4gPiAgCQlyZXR1cm4gLUVOT01FTTsNCj4gPg0KPiA+IC0JZm9yIChpID0gMDsg
aSA8IGltYV90cG1fY2hpcC0+bnJfYWxsb2NhdGVkX2JhbmtzOyBpKyspDQo+ID4gKwlmb3IgKGkg
PSAwOyBpIDwgaW1hX3RwbV9jaGlwLT5ucl9hbGxvY2F0ZWRfYmFua3M7IGkrKykgew0KPiA+ICAJ
CWRpZ2VzdHNbaV0uYWxnX2lkID0gaW1hX3RwbV9jaGlwLT5hbGxvY2F0ZWRfYmFua3NbaV0uYWxn
X2lkOw0KPiA+ICsJCWRpZ2VzdF9zaXplID0gaW1hX3RwbV9jaGlwLT5hbGxvY2F0ZWRfYmFua3Nb
aV0uZGlnZXN0X3NpemU7DQo+ID4gKwkJY3J5cHRvX2lkID0gaW1hX3RwbV9jaGlwLT5hbGxvY2F0
ZWRfYmFua3NbaV0uY3J5cHRvX2lkOw0KPiA+ICsNCj4gPiArCQkvKiBmb3IgdW5tYXBwZWQgVFBN
IGFsZ29yaXRobXMgZGlnZXN0IGlzIHN0aWxsIGEgcGFkZGVkDQo+IFNIQTEgKi8NCj4gPiArCQlp
ZiAoY3J5cHRvX2lkID09IEhBU0hfQUxHT19fTEFTVCkNCj4gPiArCQkJZGlnZXN0X3NpemUgPSBT
SEExX0RJR0VTVF9TSVpFOw0KPiA+ICsNCj4gPiArCQltZW1zZXQoZGlnZXN0c1tpXS5kaWdlc3Qs
IDB4ZmYsIGRpZ2VzdF9zaXplKTsNCj4gDQo+IFNob3VsZG4ndCB0aGUgbWVtc2V0IGhlcmUgYmUg
b2YgdGhlIGFjdHVhbCBkaWdlc3Qgc2l6ZSBldmVuIGZvcg0KPiB1bm1hcHBlZCBUUE0gYWxnb3Jp
dGhtcy4NCg0KVGhpcyBpcyBjb25zaXN0ZW50IHdpdGggaW1hX2NhbGNfZmllbGRfYXJyYXlfaGFz
aCgpLCBzbyB0aGF0IGEgdmVyaWZpZXINCndpbGwgYWx3YXlzIHBhZCB0aGUgU0hBMSBkaWdlc3Qg
d2l0aCB6ZXJvcyB0byBvYnRhaW4gdGhlIGZpbmFsIFBDUiB2YWx1ZS4NCg0KSSBjYW4gc2V0IGFs
bCBieXRlcyBpZiB5b3UgcHJlZmVyLg0KDQpUaGFua3MNCg0KUm9iZXJ0bw0KDQpIVUFXRUkgVEVD
SE5PTE9HSUVTIER1ZXNzZWxkb3JmIEdtYkgsIEhSQiA1NjA2Mw0KTWFuYWdpbmcgRGlyZWN0b3I6
IExpIFBlbmcsIExpIEppYW4sIFNoaSBZYW5saQ0KDQo+ID4gKwl9DQo+ID4NCj4gPiAgCXJldHVy
biAwOw0KPiA+ICB9DQoNCg==
