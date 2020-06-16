Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29471FBCF6
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jun 2020 19:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbgFPR3Z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jun 2020 13:29:25 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2316 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729272AbgFPR3Z (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jun 2020 13:29:25 -0400
Received: from lhreml743-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id A3232E4DF5FCCA6C7633;
        Tue, 16 Jun 2020 18:29:22 +0100 (IST)
Received: from fraeml701-chm.china.huawei.com (10.206.15.50) by
 lhreml743-chm.china.huawei.com (10.201.108.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Tue, 16 Jun 2020 18:29:22 +0100
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 16 Jun 2020 19:29:21 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1913.007;
 Tue, 16 Jun 2020 19:29:21 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        Maurizio Drocco <maurizio.drocco@ibm.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>
CC:     "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: RE: [PATCH] extend IMA boot_aggregate with kernel measurements
Thread-Topic: [PATCH] extend IMA boot_aggregate with kernel measurements
Thread-Index: AQHWQCo8nqt7HKCznkGnNWX+y9c+NajT/1SAgADtAgCAACbgMIAABL+AgAZlbjA=
Date:   Tue, 16 Jun 2020 17:29:21 +0000
Message-ID: <8c44ed75fb884cad9f33c86c2d4e8a27@huawei.com>
References: <1591921795.11061.12.camel@linux.ibm.com>
         <20200612143812.1609-1-maurizio.drocco@ibm.com>
         <380af929b2d2440a9dc35ba0b374247d@huawei.com>
 <1591982059.7235.29.camel@linux.ibm.com>
In-Reply-To: <1591982059.7235.29.camel@linux.ibm.com>
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

PiBGcm9tOiBKYW1lcyBCb3R0b21sZXkgW21haWx0bzpqZWpiQGxpbnV4LmlibS5jb21dDQo+IFNl
bnQ6IEZyaWRheSwgSnVuZSAxMiwgMjAyMCA3OjE0IFBNDQo+IE9uIEZyaSwgMjAyMC0wNi0xMiBh
dCAxNToxMSArMDAwMCwgUm9iZXJ0byBTYXNzdSB3cm90ZToNCj4gPiB3aXRoIHJlY2VudCBwYXRj
aGVzLCBib290X2FnZ3JlZ2F0ZSBjYW4gYmUgY2FsY3VsYXRlZCBmcm9tIG5vbi1TSEExDQo+ID4g
UENSIGJhbmtzLiBJIHdvdWxkIHJlcGxhY2Ugd2l0aDoNCj4gPg0KPiA+IEV4dGVuZCBjdW11bGF0
aXZlIGRpZ2VzdCBvdmVyIC4uLg0KPiA+DQo+ID4gR2l2ZW4gdGhhdCB3aXRoIHRoaXMgcGF0Y2gg
Ym9vdF9hZ2dyZWdhdGUgaXMgY2FsY3VsYXRlZCBkaWZmZXJlbnRseSwNCj4gPiBzaG91bGRuJ3Qg
d2UgY2FsbCBpdCBib290X2FnZ3JlZ2F0ZV92MiBhbmQgZW5hYmxlIGl0IHdpdGggYSBuZXcNCj4g
PiBvcHRpb24/DQo+IA0KPiBTbyBoZXJlJ3MgdGhlIHByb2JsZW06IGlmIHlvdXIgY3VycmVudCBn
cnViIGRvZXNuJ3QgZG8gYW55IFRQTQ0KPiBleHRlbnNpb25zIChhcyBtb3N0IGRvbid0KSwgdGhl
biB0aGUgdHdvIGJvb3QgYWdncmVnYXRlcyBhcmUgdGhlIHNhbWUNCj4gYmVjYXVzZSBQQ1JzIDgg
YW5kIDkgYXJlIHplcm8gYW5kIHRoZXJlJ3MgYSB0ZXN0IHRoYXQgZG9lc24ndCBhZGQgdGhlbQ0K
PiB0byB0aGUgYWdncmVnYXRlIGlmIHRoZXkgYXJlIHplcm8uICBGb3IgdGhlc2UgcGVvcGxlIGl0
cyBhIG5vcCBzbyB3ZQ0KPiBzaG91bGRuJ3QgZm9yY2UgdGhlbSB0byBjaG9vc2UgYSBkaWZmZXJl
bnQgdmVyc2lvbiBvZiB0aGUgc2FtZSB0aGluZy4NCj4gDQo+IElmLCBob3dldmVyLCB5b3UncmUg
b24gYSBkaXN0cmlidXRpb24gd2hlcmUgZ3J1YiBpcyBhdXRvbWF0aWNhbGx5DQo+IG1lYXN1cmlu
ZyB0aGUga2VybmVsIGFuZCBjb21tYW5kIGxpbmUgaW50byBQQ1JzIDggYW5kIDkgKEkgdGhpbmsg
RmVkb3JhDQo+IDMyIGRvZXMgdGhpcyksIHlvdXIgYm9vdCBhZ2dyZWdhdGUgd2lsbCBjaGFuZ2Uu
ICBJdCBzdHJpa2VzIG1lIGluIHRoYXQNCj4gY2FzZSB3ZSBjYW4gY2FsbCB0aGlzIGEgYnVnIGZp
eCwgc2luY2UgdGhlIGJvb3QgYWdncmVnYXRlIGlzbid0DQo+IHByb3Blcmx5IGJpbmRpbmcgdG8g
dGhlIHByZXZpb3VzIG1lYXN1cmVtZW50cyB3aXRob3V0IFBDUnMgOCBhbmQgOS4gIEluDQo+IHRo
aXMgY2FzZSwgZG8gd2Ugd2FudCB0byBhbGxvdyBwZW9wbGUgdG8gc2VsZWN0IGFuIG9wdGlvbiB3
aGljaCBkb2Vzbid0DQo+IHByb3Blcmx5IGJpbmQgdGhlIElNQSBsb2cgdG8gdGhlIGJvb3QgbWVh
c3VyZW1lbnRzPyAgVGhhdCBzb3VuZHMgbGlrZSBhDQo+IHNlY3VyaXR5IGhvbGUgdG8gbWUuDQo+
IA0KPiBIb3dldmVyLCBzaW5jZSBpdCBjYXVzZXMgYSB1c2VyIHZpc2libGUgZGlmZmVyZW5jZSBp
biB0aGUgZ3J1YiBhbHJlYWR5DQo+IG1lYXN1cmVzIGNhc2UsIGRvIHlvdSBoYXZlIGEgY3VycmVu
dCB1c2UgY2FzZSB0aGF0IHdvdWxkIGJlIGFmZmVjdGVkPw0KPiBBcyBpbiBhcmUgbG90cyBvZiBw
ZW9wbGUgYWxyZWFkeSBydW5uaW5nIGEgZGlzdHJvIHdpdGggdGhlIFRQTSBncnViDQo+IHVwZGF0
ZXMgYW5kIHJlbHlpbmcgb24gdGhlIG9sZCBib290IGFnZ3JlZ2F0ZT8NCg0KSSBkb24ndCBrbm93
IGhvdyBtYW55IHBlb3BsZSB3b3VsZCBiZSBhZmZlY3RlZC4gSG93ZXZlciwgaWYgYW4NCmF0dGVz
dGF0aW9uIHRvb2wgcHJvY2Vzc2VzIGJvdGggbWVhc3VyZW1lbnQgbGlzdHMgZnJvbSB1bnBhdGNo
ZWQga2VybmVscw0KYW5kIHBhdGNoZWQga2VybmVscywga2VlcGluZyB0aGUgc2FtZSBuYW1lIHdv
dWxkIGJlIGEgcHJvYmxlbSBhcyBpdA0KY2Fubm90IGJlIGRldGVybWluZWQgZnJvbSB0aGUgbWVh
c3VyZW1lbnQgbGlzdCBob3cgYm9vdF9hZ2dyZWdhdGUNCndhcyBjYWxjdWxhdGVkLg0KDQpBbnl3
YXksIEkgYWdyZWUgdGhpcyBzaG91bGQgYmUgZml4ZWQuIEF0IGxlYXN0LCBJIHN1Z2dlc3QgdG8g
YWRkIGEgRml4ZXMgdGFnLA0KdG8gZW5zdXJlIHRoYXQgdGhpcyBwYXRjaCBpcyBhcHBsaWVkIHRv
IGFsbCBzdGFibGUga2VybmVscy4NCg0KUm9iZXJ0bw0KDQpIVUFXRUkgVEVDSE5PTE9HSUVTIER1
ZXNzZWxkb3JmIEdtYkgsIEhSQiA1NjA2Mw0KTWFuYWdpbmcgRGlyZWN0b3I6IExpIFBlbmcsIExp
IEppYW4sIFNoaSBZYW5saQ0K
