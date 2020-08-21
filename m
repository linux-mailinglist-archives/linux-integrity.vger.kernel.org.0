Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E46C24D8C5
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Aug 2020 17:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgHUPhk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Aug 2020 11:37:40 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2686 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728020AbgHUPhi (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Aug 2020 11:37:38 -0400
Received: from lhreml715-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 98A7062CF7245DA15360;
        Fri, 21 Aug 2020 16:37:34 +0100 (IST)
Received: from fraeml711-chm.china.huawei.com (10.206.15.60) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 21 Aug 2020 16:37:34 +0100
Received: from lhreml722-chm.china.huawei.com (10.201.108.73) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 21 Aug 2020 17:37:33 +0200
Received: from lhreml722-chm.china.huawei.com ([10.201.108.73]) by
 lhreml722-chm.china.huawei.com ([10.201.108.73]) with mapi id 15.01.1913.007;
 Fri, 21 Aug 2020 16:37:33 +0100
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
        Roberto Sassu <roberto.sassu@huawei.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "jannh@google.com" <jannh@google.com>
Subject: RE: [RFC PATCH 00/30] ima: Introduce IMA namespace
Thread-Topic: [RFC PATCH 00/30] ima: Introduce IMA namespace
Thread-Index: AQHWdXPBkpeRDLdh20+fyp1BiEOjYak+A3mAgASuOEA=
Date:   Fri, 21 Aug 2020 15:37:33 +0000
Message-ID: <1b706f78375f472988702f77d607f8f7@huawei.com>
References: <N> <20200818152037.11869-1-krzysztof.struczynski@huawei.com>
 <20200818164943.va3um7toztazcfud@wittgenstein>
In-Reply-To: <20200818164943.va3um7toztazcfud@wittgenstein>
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
PiANCj4gSU1BIGlzIGJyb3VnaHQgdXAgb24gYSByZWd1bGFyIGJhc2lzIHdpdGggIndlIHdhbnQg
dG8gaGF2ZSB0aGlzIiBmb3INCj4geWVhcnMgYW5kIHRoZW4gbm9uLW9uZSBzZWVtcyB0byByZWFs
bHkgY2FyZSBlbm91Z2guDQo+IA0KPiBJJ20gaGlnaGx5IHNrZXB0aWNhbCBvZiB0aGUgdmFsdWUg
b2YgfjI1MDAgbGluZXMgb2YgY29kZSBldmVuIGlmIGl0DQo+IGluY2x1ZGVzIGEgYnVuY2ggb2Yg
bmFtZXNwYWNlIGJvaWxlcnBsYXRlLiBJdCdzIHlldCBhbm90aGVyIG5hbWVzcGFjZSwNCj4gYW5k
IHlldCBhbm90aGVyIHNlY3VyaXR5IGZyYW1ld29yay4NCj4gV2h5IGRvZXMgSU1BIG5lZWQgdG8g
YmUgYSBzZXBhcmF0ZSBuYW1lc3BhY2U/IEtleXJpbmdzIGFyZSB0aWVkIHRvIHVzZXINCj4gbmFt
ZXNwYWNlcyB3aHkgY2FuJ3QgSU1BIGJlPyBJIGJlbGlldmUgRXJpYyBoYXMgZXZlbiBwb2ludGVk
IHRoYXQgb3V0DQo+IGJlZm9yZS4NCg0KVGhlIHVzZXIgbmFtZXNwYWNlIGhhcyBpdHMgd2VsbCBk
ZWZpbmVkIHB1cnBvc2UgdG8gaXNvbGF0ZQ0Kc2VjdXJpdHktcmVsYXRlZCBpZGVudGlmaWVycyBh
bmQgYXR0cmlidXRlcywgcGFydGljdWxhcmx5IFVJRHMgYW5kIEdJRHMuDQpJIHRoaW5rIHRoYXQg
SU1BIGdvYWxzIGFyZSBkaWZmZXJlbnQuDQoNCkEgdXNlciBtYXkgd2FudCB0byBpc29sYXRlIGUu
Zy4gVUlEcyBidXQgbm90IHRvIGNyZWF0ZSBhIHNlcGFyYXRlIElNTCBvcg0KZGVmaW5lIHRoZSBu
ZXcgSU1BIHBvbGljaWVzLiBPbiB0aGUgb3RoZXIgaGFuZCwgZXNwZWNpYWxseSBpbiB0aGUNCnNp
bmdsZS10ZW5hbnQgZW52aXJvbm1lbnQsIHRoZSB1c2VyIG1heSB3YW50IHRvIGhhdmUgYSBwZXIg
Y29udGFpbmVyIElNTCwNCmJ1dCBubyBVSUQvR0lEIG1hcHBpbmcgaXMgcmVxdWlyZWQuIElNQSBw
b2xpY3kgZGVmaW5lcyBzdWJqZWN0LWJhc2VkDQpydWxlcyAodWlkLCBldWlkLCBzdWJqXyosIC4u
LiksIGJ1dCBhbHNvIG9iamVjdC1iYXNlZCBydWxlcy4NCg0KSU1BIGhhcyB0byBiZSBwcmUtY29u
ZmlndXJlZCwgZS5nLiBhbGwgYWN0aW9ucyBvZiB0aGUgcHJvY2VzcyBoYXZlIHRvIGJlDQphcHBy
YWlzZWQvbWVhc3VyZWQvYXVkaXRlZCBhY2NvcmRpbmcgdG8gdGhlIHByZS1kZWZpbmVkIHBvbGlj
eSwgYXBwcmFpc2FsDQprZXkgaGFzIHRvIGJlIGF2YWlsYWJsZSBiZWZvcmUgdGhlIHByb2Nlc3Mg
aXMgY3JlYXRlZCwgZXRjLiBJZiBJTUEgaXMgdGllZA0KdG8gdGhlIHVzZXIgbmFtZXNwYWNlLCB3
aGVuIGlzIGEgZ29vZCBtb21lbnQgdG8gZG8gaXQ/DQoNCldoYXQncyB0aGUgYXJndW1lbnQgYWdh
aW5zdCBhZGRpbmcgYSBuZXcgbmFtZXNwYWNlPw0KDQo+IA0KPiBFcmljLCB0aG91Z2h0cz8NCj4g
DQo+IENocmlzdGlhbg0K
