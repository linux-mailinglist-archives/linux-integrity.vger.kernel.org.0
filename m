Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6385524D856
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Aug 2020 17:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgHUPSN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Aug 2020 11:18:13 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2685 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728138AbgHUPSM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Aug 2020 11:18:12 -0400
Received: from lhreml716-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 30BAF2E228F8D53A3CF8;
        Fri, 21 Aug 2020 16:18:10 +0100 (IST)
Received: from fraeml701-chm.china.huawei.com (10.206.15.50) by
 lhreml716-chm.china.huawei.com (10.201.108.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Fri, 21 Aug 2020 16:18:09 +0100
Received: from lhreml722-chm.china.huawei.com (10.201.108.73) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 21 Aug 2020 17:18:09 +0200
Received: from lhreml722-chm.china.huawei.com ([10.201.108.73]) by
 lhreml722-chm.china.huawei.com ([10.201.108.73]) with mapi id 15.01.1913.007;
 Fri, 21 Aug 2020 16:18:08 +0100
From:   Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
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
Thread-Index: AQHWdXPBkpeRDLdh20+fyp1BiEOjYak989wAgAS8adA=
Date:   Fri, 21 Aug 2020 15:18:08 +0000
Message-ID: <8fe0d5c879af46cc8ec64d429c601b3d@huawei.com>
References: <N> <20200818152037.11869-1-krzysztof.struczynski@huawei.com>
 <20200818155350.oy3axodt3vj5k7ij@wittgenstein>
In-Reply-To: <20200818155350.oy3axodt3vj5k7ij@wittgenstein>
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

PiBGcm9tOiBDaHJpc3RpYW4gQnJhdW5lciBbbWFpbHRvOmNocmlzdGlhbi5icmF1bmVyQHVidW50
dS5jb21dDQo+IE9uIFR1ZSwgQXVnIDE4LCAyMDIwIGF0IDA1OjIwOjA3UE0gKzAyMDAsIGtyenlz
enRvZi5zdHJ1Y3p5bnNraUBodWF3ZWkuY29tDQo+IHdyb3RlOg0KPiA+IEZyb206IEtyenlzenRv
ZiBTdHJ1Y3p5bnNraSA8a3J6eXN6dG9mLnN0cnVjenluc2tpQGh1YXdlaS5jb20+DQo+ID4NCj4g
PiBJTUEgaGFzIG5vdCBiZWVuIGRlc2lnbmVkIHRvIHdvcmsgd2l0aCBjb250YWluZXJzLiBJdCBo
YW5kbGVzIGV2ZXJ5DQo+ID4gcHJvY2VzcyBpbiB0aGUgc2FtZSB3YXksIGFuZCBpdCBjYW5ub3Qg
ZGlzdGluZ3Vpc2ggaWYgYSBwcm9jZXNzIGJlbG9uZ3MgdG8NCj4gPiBhIGNvbnRhaW5lciBvciBu
b3QuDQo+ID4NCj4gPiBDb250YWluZXJzIHVzZSBuYW1lc3BhY2VzIHRvIG1ha2UgaXQgYXBwZWFy
IHRvIHRoZSBwcm9jZXNzZXMgaW4gdGhlDQo+ID4gY29udGFpbmVycyB0aGF0IHRoZXkgaGF2ZSB0
aGVpciBvd24gaXNvbGF0ZWQgaW5zdGFuY2Ugb2YgdGhlIGdsb2JhbA0KPiA+IHJlc291cmNlLiBG
b3IgSU1BIGFzIHdlbGwsIGl0IGlzIGRlc2lyYWJsZSB0byBsZXQgcHJvY2Vzc2VzIGluIHRoZQ0K
PiA+IGNvbnRhaW5lcnMgaGF2ZSBJTUEgZnVuY3Rpb25hbGl0eSBpbmRlcGVuZGVudCBmcm9tIG90
aGVyIGNvbnRhaW5lcnM6DQo+ID4gc2VwYXJhdGUgcG9saWN5IHJ1bGVzLCBtZWFzdXJlbWVudCBs
aXN0LCBhZGRpdGlvbmFsIGFwcHJhaXNhbCBrZXlzIHRvDQo+ID4gdmVyaWZ5IHRoZSBjb250YWlu
ZXIgaW1hZ2UsIHNlcGFyYXRlIGF1ZGl0IGxvZ3MuDQo+ID4NCj4gPiBBcyBwcmV2aW91cyB3b3Jr
IGRvbmUgaW4gdGhpcyBhcmVhLCB0aGlzIHBhdGNoIHNlcmllcyBpbnRyb2R1Y2VzIHRoZSBJTUEN
Cj4gPiBuYW1lc3BhY2UsIHdoaWNoIGlzIGEgc2VwYXJhdGUgaW5zdGFuY2Ugb2YgSU1BIHRvIGhh
bmRsZSBhIHN1YnNldCBvZg0KPiA+IHByb2Nlc3NlcyB0aGF0IGJlbG9uZyB0byBhIGNvbnRhaW5l
ci4NCj4gPg0KPiA+IFRoZSBJTUEgbmFtZXNwYWNlIGlzIGNyZWF0ZWQgdXNpbmcgY2xvbmUzKCkg
b3IgdW5zaGFyZSgpIHN5c3RlbSBjYWxscy4gSXQNCj4gPiBpcyBpbXBvcnRhbnQgdG8gY29uZmln
dXJlIHRoZSBuYW1lc3BhY2UgYmVmb3JlIGFueSBwcm9jZXNzIGFwcGVhcnMgaW4gaXQsDQo+ID4g
c28gdGhhdCB0aGUgbmV3IHBvbGljeSBydWxlcyBhcHBseSB0byB0aGUgdmVyeSBmaXJzdCBwcm9j
ZXNzIGluIHRoZQ0KPiA+IG5hbWVzcGFjZS4gVG8gYWNoaWV2ZSB0aGF0LCB0aGUgaW50ZXJtZWRp
YXRlIG5hbWVzcGFjZQ0KPiBpbWFfbnNfZm9yX2NoaWxkcmVuDQo+ID4gaXMgdXNlZC4gSXQgc3Rv
cmVzIHRoZSBjb25maWd1cmF0aW9uIGFuZCBiZWNvbWVzIGFjdGl2ZSBvbiB0aGUgbmV4dCBmb3Jr
DQo+ID4gb3Igd2hlbiB0aGUgZmlyc3QgcHJvY2VzcyBlbnRlcnMgaXQgdXNpbmcgdGhlIHNldG5z
KCkgc3lzdGVtIGNhbGwuIFRoZQ0KPiA+IHNpbWlsYXIgcHJvY2VzcyBpcyB1c2VkIGZvciB0aGUg
dGltZSBuYW1lc3BhY2UuDQo+ID4NCj4gPiBUaGUgSU1BIG5hbWVzcGFjZSBjYW4gYmUgY29uZmln
dXJlZCB1c2luZyB0aGUgbmV3IHNlY3VyaXR5ZnMgZGlyZWN0b3J5DQo+ID4gZW50cmllcyB0aGF0
IGFsbG93IHRoZSB1c2VyIHRvIHNldCB0aGUgcG9saWN5IHJ1bGVzLCB4NTA5IGNlcnRpZmljYXRl
IGZvcg0KPiA+IGFwcHJhaXNhbCBhbmQgcGFzcyBJTUEgY29uZmlndXJhdGlvbiBwYXJhbWV0ZXJz
IG5vcm1hbGx5IGluY2x1ZGVkIGluIHRoZQ0KPiA+IGtlcm5lbCBjb21tYW5kIGxpbmUgcGFyYW1l
dGVycy4gSXQgaXMgaW50ZW5kZWQgdG8gZXh0ZW5kIHRoZSBjbG9uZV9hcmdzIHRvDQo+ID4gYWxs
b3cgY29uZmlndXJhdGlvbiBmcm9tIGNsb25lMygpIHN5c2NhbGwuDQo+IA0KPiBOb3QgdG8gYmUg
dGhlIGRvd25lciByaWdodCBhd2F5IGJ1dCBqdXN0IGFzIGFuIGZ5aSwgaWYgdGhpcyBwYXRjaHNl
dA0KPiBtYWtlcyBpdCwgY2xvbmUzKCkgd2lsbCBub3QgYWxsb3cgdG8gYmUgZXh0ZW5kZWQgd2l0
aCBhbnkgcmVhbA0KPiBzZWNvbmQtbGV2ZWwgcG9pbnRlcnMuIFRoYXQgd2lsbCBzZWUgYSBoYXJk
IE5BSyBmcm9tIG1lIGFuZCBzZXZlcmFsDQo+IG90aGVyIG1haW50YWluZXJzLg0KDQpPaywgdGhh
dCdzIGEgZ29vZCBwb2ludC4gSXQgY2FuIGJlIGRvbmUgd2l0aG91dCB0aGUgc2Vjb25kLWxldmVs
IHBvaW50ZXJzDQpidXQgaWYgdGhhdCdzIG5vdCBkZXNpcmFibGUgdGhlbiBJTUEgbmFtZXNwYWNl
IGNyZWF0aW9uIHZpYSBhIGRpcmVjdA0KY2xvbmUzKCkgY2FsbCBjYW4gYmUgcmVtb3ZlZC4gSXQg
d2lsbCBtYWtlIHRoZSBwcm9jZXNzIGxlc3MgZmxleGlibGUgYnV0DQppdCB3aWxsIHN0aWxsIHdv
cmsgd2l0aCB1bnNoYXJlKCkgYW5kIGNsb25lMygpIG9yIHVuc2hhcmUoKSBhbmQgc2V0bnMoKQ0K
Y2FsbHMuDQoNCj4gDQo+IENocmlzdGlhbg0K
