Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1621FF20D
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2020 14:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbgFRMil (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jun 2020 08:38:41 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2326 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726909AbgFRMik (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jun 2020 08:38:40 -0400
Received: from lhreml716-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 8BE30888CEFE3CD765AE;
        Thu, 18 Jun 2020 13:38:38 +0100 (IST)
Received: from fraeml704-chm.china.huawei.com (10.206.15.53) by
 lhreml716-chm.china.huawei.com (10.201.108.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Thu, 18 Jun 2020 13:38:38 +0100
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 18 Jun 2020 14:38:37 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1913.007;
 Thu, 18 Jun 2020 14:38:37 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        Maurizio Drocco <maurizio.drocco@ibm.com>
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
Thread-Index: AQHWQCo8nqt7HKCznkGnNWX+y9c+NajT/1SAgADtAgCAACbgMIAABL+AgAZlbjD///PFAIAC3lpA
Date:   Thu, 18 Jun 2020 12:38:37 +0000
Message-ID: <b744c1b79ba14a17a786f5de04c1f3c4@huawei.com>
References: <1591921795.11061.12.camel@linux.ibm.com>
         <20200612143812.1609-1-maurizio.drocco@ibm.com>
         <380af929b2d2440a9dc35ba0b374247d@huawei.com>
         <1591982059.7235.29.camel@linux.ibm.com>
         <8c44ed75fb884cad9f33c86c2d4e8a27@huawei.com>
 <1592331068.11061.218.camel@linux.ibm.com>
In-Reply-To: <1592331068.11061.218.camel@linux.ibm.com>
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

PiBGcm9tOiBNaW1pIFpvaGFyIFttYWlsdG86em9oYXJAbGludXguaWJtLmNvbV0NCj4gU2VudDog
VHVlc2RheSwgSnVuZSAxNiwgMjAyMCA4OjExIFBNDQo+IE9uIFR1ZSwgMjAyMC0wNi0xNiBhdCAx
NzoyOSArMDAwMCwgUm9iZXJ0byBTYXNzdSB3cm90ZToNCj4gPiA+IEZyb206IEphbWVzIEJvdHRv
bWxleSBbbWFpbHRvOmplamJAbGludXguaWJtLmNvbV0NCj4gPiA+IFNlbnQ6IEZyaWRheSwgSnVu
ZSAxMiwgMjAyMCA3OjE0IFBNDQo+ID4gPiBPbiBGcmksIDIwMjAtMDYtMTIgYXQgMTU6MTEgKzAw
MDAsIFJvYmVydG8gU2Fzc3Ugd3JvdGU6DQo+ID4gPiA+IHdpdGggcmVjZW50IHBhdGNoZXMsIGJv
b3RfYWdncmVnYXRlIGNhbiBiZSBjYWxjdWxhdGVkIGZyb20gbm9uLVNIQTENCj4gPiA+ID4gUENS
IGJhbmtzLiBJIHdvdWxkIHJlcGxhY2Ugd2l0aDoNCj4gPiA+ID4NCj4gPiA+ID4gRXh0ZW5kIGN1
bXVsYXRpdmUgZGlnZXN0IG92ZXIgLi4uDQo+ID4gPiA+DQo+ID4gPiA+IEdpdmVuIHRoYXQgd2l0
aCB0aGlzIHBhdGNoIGJvb3RfYWdncmVnYXRlIGlzIGNhbGN1bGF0ZWQgZGlmZmVyZW50bHksDQo+
ID4gPiA+IHNob3VsZG4ndCB3ZSBjYWxsIGl0IGJvb3RfYWdncmVnYXRlX3YyIGFuZCBlbmFibGUg
aXQgd2l0aCBhIG5ldw0KPiA+ID4gPiBvcHRpb24/DQo+ID4gPg0KPiA+ID4gU28gaGVyZSdzIHRo
ZSBwcm9ibGVtOiBpZiB5b3VyIGN1cnJlbnQgZ3J1YiBkb2Vzbid0IGRvIGFueSBUUE0NCj4gPiA+
IGV4dGVuc2lvbnMgKGFzIG1vc3QgZG9uJ3QpLCB0aGVuIHRoZSB0d28gYm9vdCBhZ2dyZWdhdGVz
IGFyZSB0aGUgc2FtZQ0KPiA+ID4gYmVjYXVzZSBQQ1JzIDggYW5kIDkgYXJlIHplcm8gYW5kIHRo
ZXJlJ3MgYSB0ZXN0IHRoYXQgZG9lc24ndCBhZGQgdGhlbQ0KPiA+ID4gdG8gdGhlIGFnZ3JlZ2F0
ZSBpZiB0aGV5IGFyZSB6ZXJvLiAgRm9yIHRoZXNlIHBlb3BsZSBpdHMgYSBub3Agc28gd2UNCj4g
PiA+IHNob3VsZG4ndCBmb3JjZSB0aGVtIHRvIGNob29zZSBhIGRpZmZlcmVudCB2ZXJzaW9uIG9m
IHRoZSBzYW1lIHRoaW5nLg0KPiA+ID4NCj4gPiA+IElmLCBob3dldmVyLCB5b3UncmUgb24gYSBk
aXN0cmlidXRpb24gd2hlcmUgZ3J1YiBpcyBhdXRvbWF0aWNhbGx5DQo+ID4gPiBtZWFzdXJpbmcg
dGhlIGtlcm5lbCBhbmQgY29tbWFuZCBsaW5lIGludG8gUENScyA4IGFuZCA5IChJIHRoaW5rDQo+
IEZlZG9yYQ0KPiA+ID4gMzIgZG9lcyB0aGlzKSwgeW91ciBib290IGFnZ3JlZ2F0ZSB3aWxsIGNo
YW5nZS4gIEl0IHN0cmlrZXMgbWUgaW4gdGhhdA0KPiA+ID4gY2FzZSB3ZSBjYW4gY2FsbCB0aGlz
IGEgYnVnIGZpeCwgc2luY2UgdGhlIGJvb3QgYWdncmVnYXRlIGlzbid0DQo+ID4gPiBwcm9wZXJs
eSBiaW5kaW5nIHRvIHRoZSBwcmV2aW91cyBtZWFzdXJlbWVudHMgd2l0aG91dCBQQ1JzIDggYW5k
IDkuDQo+IEluDQo+ID4gPiB0aGlzIGNhc2UsIGRvIHdlIHdhbnQgdG8gYWxsb3cgcGVvcGxlIHRv
IHNlbGVjdCBhbiBvcHRpb24gd2hpY2ggZG9lc24ndA0KPiA+ID4gcHJvcGVybHkgYmluZCB0aGUg
SU1BIGxvZyB0byB0aGUgYm9vdCBtZWFzdXJlbWVudHM/ICBUaGF0IHNvdW5kcyBsaWtlDQo+IGEN
Cj4gPiA+IHNlY3VyaXR5IGhvbGUgdG8gbWUuDQo+ID4gPg0KPiA+ID4gSG93ZXZlciwgc2luY2Ug
aXQgY2F1c2VzIGEgdXNlciB2aXNpYmxlIGRpZmZlcmVuY2UgaW4gdGhlIGdydWIgYWxyZWFkeQ0K
PiA+ID4gbWVhc3VyZXMgY2FzZSwgZG8geW91IGhhdmUgYSBjdXJyZW50IHVzZSBjYXNlIHRoYXQg
d291bGQgYmUgYWZmZWN0ZWQ/DQo+ID4gPiBBcyBpbiBhcmUgbG90cyBvZiBwZW9wbGUgYWxyZWFk
eSBydW5uaW5nIGEgZGlzdHJvIHdpdGggdGhlIFRQTSBncnViDQo+ID4gPiB1cGRhdGVzIGFuZCBy
ZWx5aW5nIG9uIHRoZSBvbGQgYm9vdCBhZ2dyZWdhdGU/DQo+ID4NCj4gPiBJIGRvbid0IGtub3cg
aG93IG1hbnkgcGVvcGxlIHdvdWxkIGJlIGFmZmVjdGVkLiBIb3dldmVyLCBpZiBhbg0KPiA+IGF0
dGVzdGF0aW9uIHRvb2wgcHJvY2Vzc2VzIGJvdGggbWVhc3VyZW1lbnQgbGlzdHMgZnJvbSB1bnBh
dGNoZWQNCj4ga2VybmVscw0KPiA+IGFuZCBwYXRjaGVkIGtlcm5lbHMsIGtlZXBpbmcgdGhlIHNh
bWUgbmFtZSB3b3VsZCBiZSBhIHByb2JsZW0gYXMgaXQNCj4gPiBjYW5ub3QgYmUgZGV0ZXJtaW5l
ZCBmcm9tIHRoZSBtZWFzdXJlbWVudCBsaXN0IGhvdyBib290X2FnZ3JlZ2F0ZQ0KPiA+IHdhcyBj
YWxjdWxhdGVkLg0KPiA+DQo+ID4gQW55d2F5LCBJIGFncmVlIHRoaXMgc2hvdWxkIGJlIGZpeGVk
LiBBdCBsZWFzdCwgSSBzdWdnZXN0IHRvIGFkZCBhIEZpeGVzIHRhZywNCj4gPiB0byBlbnN1cmUg
dGhhdCB0aGlzIHBhdGNoIGlzIGFwcGxpZWQgdG8gYWxsIHN0YWJsZSBrZXJuZWxzLg0KPiANCj4g
VGhlIGJvb3QgYWdncmVnYXRlIG9uIGV4aXN0aW5nIHN5c3RlbXMgd291bGQgYmUgc2hhMS4gwqBE
b2VzIGl0IG1ha2UNCj4gc2Vuc2UgdG8gbGltaXQgdGhpcyBjaGFuZ2UgdG8gbGFyZ2VyIGRpZ2Vz
dHM/IMKgQW55b25lIGJhY2twb3J0aW5nDQo+IHN1cHBvcnQgZm9yIGxhcmdlciBkaWdlc3RzIHdv
dWxkIGFsc28gbmVlZCB0byBiYWNrcG9ydCB0aGlzIGNoYW5nZSBhcw0KPiB3ZWxsLg0KDQpZZXMs
IGl0IHdvdWxkIGJlIGEgc2FmZSBjaG9pY2UuDQoNClJvYmVydG8NCg0KSFVBV0VJIFRFQ0hOT0xP
R0lFUyBEdWVzc2VsZG9yZiBHbWJILCBIUkIgNTYwNjMNCk1hbmFnaW5nIERpcmVjdG9yOiBMaSBQ
ZW5nLCBMaSBKaWFuLCBTaGkgWWFubGkNCg==
