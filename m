Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33BE024D83A
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Aug 2020 17:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgHUPOT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Aug 2020 11:14:19 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2684 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728208AbgHUPNG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Aug 2020 11:13:06 -0400
Received: from lhreml731-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id E15F6F47F83830D67917;
        Fri, 21 Aug 2020 16:13:03 +0100 (IST)
Received: from fraeml706-chm.china.huawei.com (10.206.15.55) by
 lhreml731-chm.china.huawei.com (10.201.108.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Fri, 21 Aug 2020 16:13:03 +0100
Received: from lhreml722-chm.china.huawei.com (10.201.108.73) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 21 Aug 2020 17:13:02 +0200
Received: from lhreml722-chm.china.huawei.com ([10.201.108.73]) by
 lhreml722-chm.china.huawei.com ([10.201.108.73]) with mapi id 15.01.1913.007;
 Fri, 21 Aug 2020 16:13:02 +0100
From:   Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
CC:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "stefanb@linux.vnet.ibm.com" <stefanb@linux.vnet.ibm.com>,
        "sunyuqiong1988@gmail.com" <sunyuqiong1988@gmail.com>,
        "mkayaalp@cs.binghamton.edu" <mkayaalp@cs.binghamton.edu>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "christian@brauner.io" <christian@brauner.io>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: RE: [RFC PATCH 00/30] ima: Introduce IMA namespace
Thread-Topic: [RFC PATCH 00/30] ima: Introduce IMA namespace
Thread-Index: AQHWdXPBkpeRDLdh20+fyp1BiEOjYak9+wmAgASx5lA=
Date:   Fri, 21 Aug 2020 15:13:01 +0000
Message-ID: <401a2f36149f450291d1742aeb6c2260@huawei.com>
References: <N> <20200818152037.11869-1-krzysztof.struczynski@huawei.com>
 <1597767571.3898.15.camel@HansenPartnership.com>
In-Reply-To: <1597767571.3898.15.camel@HansenPartnership.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.215.114]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

PiBGcm9tOiBKYW1lcyBCb3R0b21sZXkgW21haWx0bzpKYW1lcy5Cb3R0b21sZXlASGFuc2VuUGFy
dG5lcnNoaXAuY29tXQ0KPiBPbiBUdWUsIDIwMjAtMDgtMTggYXQgMTc6MjAgKzAyMDAsIGtyenlz
enRvZi5zdHJ1Y3p5bnNraUBodWF3ZWkuY29tDQo+IHdyb3RlOg0KPiA+IFRoZSBtZWFzdXJlbWVu
dCBsaXN0IHJlbWFpbnMgZ2xvYmFsLCB3aXRoIHRoZSBhc3N1bXB0aW9uIHRoYXQgdGhlcmUNCj4g
PiBpcyBvbmx5IG9uZSBUUE0gaW4gdGhlIHN5c3RlbS4gRWFjaCBJTUEgbmFtZXNwYWNlIGhhcyBh
IHVuaXF1ZSBJRCwNCj4gPiB0aGF0IGFsbG93cyB0byB0cmFjayBtZWFzdXJlbWVudHMgcGVyIElN
QSBuYW1lc3BhY2UuIFByb2Nlc3NlcyBpbiBvbmUNCj4gPiBuYW1lc3BhY2UsIGhhdmUgYWNjZXNz
IG9ubHkgdG8gdGhlIG1lYXN1cmVtZW50cyBmcm9tIHRoYXQgbmFtZXNwYWNlLg0KPiA+IFRoZSBl
eGNlcHRpb24gaXMgbWFkZSBmb3IgdGhlIGluaXRpYWwgSU1BIG5hbWVzcGFjZSwgd2hvc2UgcHJv
Y2Vzc2VzDQo+ID4gaGF2ZSBhY2Nlc3MgdG8gYWxsIGVudHJpZXMuDQo+IA0KPiBTbyBJIHRoaW5r
IHRoaXMgY2FuIHdvcmsgaW4gdGhlIHVzZSBjYXNlIHdoZXJlIHRoZSBzeXN0ZW0gb3duZXIgaXMN
Cj4gcmVzcG9uc2libGUgZm9yIGRvaW5nIHRoZSBsb2dnaW5nIGFuZCBhdHRlc3RhdGlvbiBhbmQg
dGhlIHRlbmFudHMganVzdA0KPiB0cnVzdCB0aGUgb3duZXIgd2l0aG91dCByZXF1aXJpbmcgYW4g
YXR0ZXN0YXRpb24uICBIb3dldmVyLCBpbiBhIG11bHRpLQ0KPiB0ZW5hbnQgc3lzdGVtIHlvdSBu
ZWVkIGEgd2F5IGZvciB0aGUgYXR0ZXN0YXRpb24gdG8gYmUgcGVyLWNvbnRhaW5lcg0KPiAoYmVj
YXVzZSB0aGUgY29tYmluZWQgbGlzdCBvZiB3aG8gZXhlY3V0ZWQgd2hhdCB3b3VsZCBiZSBhIHNl
Y3VyaXR5DQo+IGxlYWsgYmV0d2VlbiB0ZW5hbnRzKS4gIFNpbmNlIHdlIGNhbid0IHZpcnR1YWxp
c2UgdGhlIFBDUnMgd2l0aG91dA0KPiBpbnRyb2R1Y2luZyBhIHZ0cG0gdGhpcyBpcyBnb2luZyB0
byByZXF1aXJlIGEgdnRwbSBpbmZyYXN0cnVjdHVyZSBsaWtlDQo+IHRoYXQgdXNlZCBmb3Igdmly
dHVhbCBtYWNoaW5lcyBhbmQgdGhlbiB3ZSBjYW4gZG8gSU1BIGxvZ2dpbmcgcGVyDQo+IGNvbnRh
aW5lci4NCg0KSSBhZ3JlZSBhbmQgd29uZGVyIGlmIHdlIHNob3VsZCBkZWNvdXBsZSB0aGUgYXR0
ZXN0YXRpb24gdHJ1c3QgbW9kZWwsDQp3aGljaCBkZXBlbmRzIG9uIHRoZSBzcGVjaWZpYyB1c2Ug
Y2FzZSAoZS5nLiBtdWx0aS9zaW5nbGUgdGVuYW50LA0KcHVibGljL3ByaXZhdGUgY2xvdWQpLCBm
cm9tIHRoZSBJTUEgbG9naWMgb2YgbGlua2luZyB0aGUgbWVhc3VyZW1lbnRzIHRvDQp0aGUgY29u
dGFpbmVyLiBJbmRlZWQsIGF0dGVzdGF0aW9uIGZyb20gd2l0aGluIHRoZSBjb250YWluZXIgbWln
aHQgcmVxdWlyZQ0KYW5jaG9yaW5nIHRvIGEgdlRQTS92UENSIGFuZCB0aGUgY3VycmVudCBtZWFz
dXJlbWVudCB0YWdnaW5nIG1lY2hhbmlzbSBjYW4NCnN1cHBvcnQgc2V2ZXJhbCB3YXlzIG9mIGFu
Y2hvcmluZyB0aGVtIHRvIGEgKHZpcnR1YWwpIHJvb3Qgb2YgdHJ1c3QuDQoNCj4gSSBkb24ndCB0
aGluayB0aGUgYWJvdmUgaGFzIHRvIGJlIGluIHlvdXIgZmlyc3QgcGF0Y2ggc2V0LCB3ZSBqdXN0
IGhhdmUNCj4gdG8gaGF2ZSBhbiBpZGVhIG9mIGhvdyBpdCBjb3VsZCBiZSBkb25lIHRvIHNob3cg
dGhhdCBub3RoaW5nIGluIHRoaXMNCj4gcGF0Y2ggc2V0IHByZWNsdWRlcyBhIGZvbGxvdyBvbiBm
cm9tIGRvaW5nIHRoaXMuDQoNCkdpdmVuIHRoYXQgdmlydHVhbGl6aW5nIHRydXN0IGFuY2hvcnMg
c2VlbXMgbGlrZSBhIHNlcGFyYXRlIHByb2JsZW0gaW4NCndoaWNoIGluZHVzdHJ5IGNvbnNlbnN1
cyBpcyBub3QgZWFzeSB0byByZWFjaCBmb3IgYWxsIHVzZSBjYXNlcywgYW4NCmFuY2hvcmluZyBt
ZWNoYW5pc20gc2hvdWxkIHByb2JhYmx5IGJlIGEgc2VwYXJhdGUgSU1BIGZlYXR1cmUuDQoNCj4g
DQo+IEphbWVzDQoNCg==
