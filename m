Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD20E198C9C
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Mar 2020 08:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgCaG4r (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Mar 2020 02:56:47 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2621 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726216AbgCaG4r (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Mar 2020 02:56:47 -0400
Received: from lhreml741-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 30E065A3EC3E170221CE;
        Tue, 31 Mar 2020 07:56:46 +0100 (IST)
Received: from fraeml705-chm.china.huawei.com (10.206.15.54) by
 lhreml741-chm.china.huawei.com (10.201.108.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1713.5; Tue, 31 Mar 2020 07:56:45 +0100
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 31 Mar 2020 08:56:45 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1913.007;
 Tue, 31 Mar 2020 08:56:44 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "matthewgarrett@google.com" <matthewgarrett@google.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: RE: Immutable metadata
Thread-Topic: Immutable metadata
Thread-Index: AdYE5l5uAUZNHIlESc2JQvQGvX4yuwBQTyyAAByCloAABDn24AABtkKAAB2UQIA=
Date:   Tue, 31 Mar 2020 06:56:44 +0000
Message-ID: <a6e429a09f6c4349ba2e2dc04acd89ee@huawei.com>
References: <ff12bbbd945545a988ef84d6e4d3b83d@huawei.com>
         <1585534223.5188.408.camel@linux.ibm.com>
         <1585583203.5188.418.camel@linux.ibm.com>
         <378d0dea0ccb49b8a0f0e58301328b5a@huawei.com>
 <1585593405.5188.450.camel@linux.ibm.com>
In-Reply-To: <1585593405.5188.450.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.210.166.15]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaW1pIFpvaGFyIFttYWlsdG86
em9oYXJAbGludXguaWJtLmNvbV0NCj4gU2VudDogTW9uZGF5LCBNYXJjaCAzMCwgMjAyMCA4OjM3
IFBNDQo+IFRvOiBSb2JlcnRvIFNhc3N1IDxyb2JlcnRvLnNhc3N1QGh1YXdlaS5jb20+Ow0KPiBt
YXR0aGV3Z2FycmV0dEBnb29nbGUuY29tDQo+IENjOiBsaW51eC1pbnRlZ3JpdHlAdmdlci5rZXJu
ZWwub3JnOyBTaWx2aXUgVmxhc2NlYW51DQo+IDxTaWx2aXUuVmxhc2NlYW51QGh1YXdlaS5jb20+
DQo+IFN1YmplY3Q6IFJlOiBJbW11dGFibGUgbWV0YWRhdGENCj4gDQo+IE9uIE1vbiwgMjAyMC0w
My0zMCBhdCAxNTo1NiArMDAwMCwgUm9iZXJ0byBTYXNzdSB3cm90ZToNCj4gPiA+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBNaW1pIFpvaGFyIFttYWlsdG86em9oYXJA
bGludXguaWJtLmNvbV0NCj4gPiA+IFNlbnQ6IE1vbmRheSwgTWFyY2ggMzAsIDIwMjAgNTo0NyBQ
TQ0KPiA+ID4gVG86IFJvYmVydG8gU2Fzc3UgPHJvYmVydG8uc2Fzc3VAaHVhd2VpLmNvbT47DQo+
ID4gPiBtYXR0aGV3Z2FycmV0dEBnb29nbGUuY29tDQo+ID4gPiBDYzogbGludXgtaW50ZWdyaXR5
QHZnZXIua2VybmVsLm9yZzsgU2lsdml1IFZsYXNjZWFudQ0KPiA+ID4gPFNpbHZpdS5WbGFzY2Vh
bnVAaHVhd2VpLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFJlOiBJbW11dGFibGUgbWV0YWRhdGENCj4g
PiA+DQo+ID4gPiBPbiBTdW4sIDIwMjAtMDMtMjkgYXQgMjI6MTAgLTA0MDAsIE1pbWkgWm9oYXIg
d3JvdGU6DQo+ID4gPiA+IEhpIFJvYmVydG8sDQo+ID4gPiA+DQo+ID4gPiA+IE9uIFNhdCwgMjAy
MC0wMy0yOCBhdCAxMToxOCArMDAwMCwgUm9iZXJ0byBTYXNzdSB3cm90ZToNCj4gPiA+ID4gPiBI
aSBNYXR0aGV3LCBNaW1pDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBJIGhhdmUgYSBxdWVzdGlvbiBh
Ym91dCBwb3J0YWJsZSBzaWduYXR1cmVzLiBJcyB0aGVyZSBhbnkgcGFydGljdWxhcg0KPiA+ID4g
cmVhc29uDQo+ID4gPiA+ID4gd2h5IGEgd3JpdGUgdG8gYSBmaWxlIGlzIG5vdCBkZW5pZWQgYnkg
SU1BIGlmIG1ldGFkYXRhIGFyZSBpbW11dGFibGU/DQo+ID4gPiA+DQo+ID4gPiA+IEFzIG11Y2gg
YXMgcG9zc2libGUsIElNQSBhbmQgRVZNIHNob3VsZCBiZSBpbmRlcGVuZGVudCBvZiBlYWNoDQo+
IG90aGVyLg0KPiA+ID4gPiDCoEVWTSBpcyByZXNwb25zaWJsZSBmb3IgdGhlIGludGVncml0eSBv
ZiBmaWxlIG1ldGFkYXRhLCBzbyBpdCBuZWVkcyB0bw0KPiA+ID4gPiByZWFkIG90aGVyIHNlY3Vy
aXR5IHhhdHRycywgYnV0IElNQSBzaG91bGRuJ3QgYmUgbG9va2luZyBhdCB0aGUgRVZNDQo+ID4g
PiA+IHhhdHRyLg0KPiA+ID4gPg0KPiA+ID4gPiBMaWtlIGFueSBvdGhlciBzZWN1cml0eSB4YXR0
ciwgcmVzcG9uc2liaWxpdHkgZm9yIG1haW50YWluaW5nIHRoZQ0KPiA+ID4gPiB4YXR0ciBpcyBs
ZWZ0IHVwIHRvIHRoZSBwYXJ0aWN1bGFyIExTTS4gwqBJbiB0aGlzIGNhc2UsIEVWTSB3b3VsZCBu
ZWVkDQo+ID4gPiA+IHRvIHByZXZlbnQgdGhlIGZpbGUgZnJvbSBiZWluZyBvcGVuZWQgcncuIMKg
U2hvdWxkIHRoYXQgYmUgaGFyZCBjb2RlZA0KPiA+ID4gPiBvciBiYXNlZCBvbiBhbiBFVk0gcG9s
aWN5Pw0KPiA+ID4NCj4gPiA+IFRoaW5raW5nIGFib3V0IHRoaXMgYSBiaXQgbW9yZSwgZXZtX3Zl
cmlmeXhhdHRyKCkgaXMgYWxyZWFkeSByZXR1cm5pbmcNCj4gPiA+IElOVEVHUklUWV9QQVNTX0lN
TVVUQUJMRS4gwqBJIGd1ZXNzIElNQSBjb3VsZCBtYWtlIGRlY2lzaW9ucyBiYXNlZA0KPiBvbg0K
PiA+ID4gaXQuDQo+ID4NCj4gPiBZZXMsIHRoaXMgd2FzIHRoZSBpZGVhLg0KPiA+DQo+ID4gSSB3
b3VsZCBzYXkgYWxzbyB0aGF0IGZpbGVzIHdpdGggcG9ydGFibGUgc2lnbmF0dXJlcyBmdWxmaWxs
IHRoZQ0KPiBhcHByYWlzZV90eXBlPWltYXNpZw0KPiA+IHJlcXVpcmVtZW50LiBJIHdvdWxkIHNl
dCB0aGUgSU1BX0RJR1NJRyBiaXQgaW4gaWludC0+YXRvbWljX2ZsYWdzLiBJcyBpdCBvaz8NCj4g
DQo+IE9rLCBzbyBsb2NraW5nIGRvZXNuJ3Qgc2VlbSB0byBiZSBhbiBpc3N1ZSBoZXJlLiDCoEkn
bSBub3Qgc3VyZSBhYm91dA0KPiByZS11c2luZyB0aGUgZXhpc3RpbmcgYml0LiDCoEVWTV9YQVRU
Ul9QT1JUQUJMRV9ESUdTSUcgaXMgZGVwZW5kZW50IG9uDQo+IHRoZSBleGlzdGVuY2Ugb2YgYSBm
aWxlIGhhc2guIMKgVGhlIGV4aXN0aW5nIGJpdCBwcmV2ZW50cyBjYWxjdWxhdGluZw0KPiBhbmQg
d3JpdGluZyB0aGUgZmlsZSBoYXNoIGFzIGFuIHhhdHRyLiDCoFdvdWxkIHRoaXMgYWZmZWN0IGlu
c3RhbGxpbmcNCj4gbmV3IGZpbGVzPw0KDQpTaW5jZSBpdCBpcyBhIHBvcnRhYmxlIHNpZ25hdHVy
ZSwgc2VjdXJpdHkuaW1hIGlzIGtub3duIGluIGFkdmFuY2UuIElNQSBhYmlsaXR5DQp0byB1cGRh
dGUgc2VjdXJpdHkuaW1hIGlzIG5vdCBuZWNlc3NhcnkgaW4gdGhpcyBjYXNlLiBzZWN1cml0eS5p
bWEgd2lsbCBiZSBzZXQNCmJ5IHVzZXIgc3BhY2UgdG9vbHMuDQoNCkN1cnJlbnRseSwgdGhlcmUg
aXMgc3RpbGwgdGhlIGlzc3VlIG9mIGFkZGluZyBhbGwgeGF0dHJzIHRvIGEgZmlsZSB3aGVuIEVW
TSBpcw0KZW5mb3JjaW5nIChpdCByZWZ1c2VzIHRvIGNvcHkgYWxsIHhhdHRycywgYXMgdGhlIGlu
dGVncml0eSBvZiB0aGUgcGFydGlhbCBzZXQgY2Fubm90DQpiZSB2ZXJpZmllZCkuIEkgd2lsbCBh
ZGRyZXNzIHRoaXMgbGF0ZXIuDQoNClJvYmVydG8NCg0KSFVBV0VJIFRFQ0hOT0xPR0lFUyBEdWVz
c2VsZG9yZiBHbWJILCBIUkIgNTYwNjMNCk1hbmFnaW5nIERpcmVjdG9yOiBMaSBQZW5nLCBMaSBK
aWFuLCBTaGkgWWFubGkNCg==
