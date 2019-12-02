Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5F1510E444
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Dec 2019 02:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfLBBoE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 1 Dec 2019 20:44:04 -0500
Received: from mga06.intel.com ([134.134.136.31]:60711 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727279AbfLBBoE (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 1 Dec 2019 20:44:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Dec 2019 17:44:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,267,1571727600"; 
   d="scan'208";a="200437555"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga007.jf.intel.com with ESMTP; 01 Dec 2019 17:44:02 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 1 Dec 2019 17:44:01 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 1 Dec 2019 17:44:01 -0800
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 1 Dec 2019 17:44:01 -0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.109]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.29]) with mapi id 14.03.0439.000;
 Mon, 2 Dec 2019 09:44:00 +0800
From:   "Zhao, Shirley" <shirley.zhao@intel.com>
To:     James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'Mauro Carvalho Chehab'" <mchehab+samsung@kernel.org>,
        "Zhu, Bing" <bing.zhu@intel.com>,
        "Chen, Luhai" <luhai.chen@intel.com>
Subject: RE: One question about trusted key of keyring in Linux kernel.
Thread-Topic: One question about trusted key of keyring in Linux kernel.
Thread-Index: AdWZwFKzDBwFOydYTGGk+Aqs+6BIxAANhxEAAoxRZMAAOKaagABSSevwABZzFQAAgRP1kA==
Date:   Mon, 2 Dec 2019 01:44:00 +0000
Message-ID: <A888B25CD99C1141B7C254171A953E8E4909BA3B@shsmsx102.ccr.corp.intel.com>
References: <A888B25CD99C1141B7C254171A953E8E49094313@shsmsx102.ccr.corp.intel.com>
         <1573659978.17949.83.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E49095F9B@shsmsx102.ccr.corp.intel.com>
         <1574877977.3551.5.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E49096521@shsmsx102.ccr.corp.intel.com>
 <1575057916.6220.7.camel@linux.ibm.com>
In-Reply-To: <1575057916.6220.7.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTYxYWJjZjgtYmU3NC00NTFkLWE0NzEtZTRlMzBlMzQyNTUzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZjQxZVhoaCt5bUxRMnN5cElyR2orNHVVclo4SzJZRDBMQmJKZmoyYVE0UUxhd1RJQzZxWFgwNjFYZXJPM2RjOSJ9
x-ctpclassification: CTP_NT
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

SGksIEphbWVzLCANCg0KVGhlIHZhbHVlIG9mIFBDUjcgaXMgbm90IGNoYW5nZWQuIEkgaGF2ZSBj
aGVja2VkIGl0IHdpdGggVFBNIGNvbW1hbmQgdHBtX3Bjcmxpc3QuIA0KDQpTbyBJIHRoaW5rIHRo
ZSBwcm9ibGVtIGlzIGhvdyB0byB1c2UgdGhlIG9wdGlvbiBwb2xpY3lkaWdlc3QgYW5kIHBvbGlj
eWhhbmRsZT8gSXMgdGhlcmUgYW55IGV4YW1wbGU/DQpNYXliZSB0aGUgZm9ybWF0IGluIG15IGNv
bW1hbmQgaXMgbm90IGNvcnJlY3QuIA0KDQpUaGFua3MuIA0KDQotIFNoaXJsZXkgDQoNCi0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBKYW1lcyBCb3R0b21sZXkgPGplamJAbGludXgu
aWJtLmNvbT4gDQpTZW50OiBTYXR1cmRheSwgTm92ZW1iZXIgMzAsIDIwMTkgNDowNSBBTQ0KVG86
IFpoYW8sIFNoaXJsZXkgPHNoaXJsZXkuemhhb0BpbnRlbC5jb20+OyBNaW1pIFpvaGFyIDx6b2hh
ckBsaW51eC5pYm0uY29tPjsgSmFya2tvIFNha2tpbmVuIDxqYXJra28uc2Fra2luZW5AbGludXgu
aW50ZWwuY29tPjsgSm9uYXRoYW4gQ29yYmV0IDxjb3JiZXRAbHduLm5ldD4NCkNjOiBsaW51eC1p
bnRlZ3JpdHlAdmdlci5rZXJuZWwub3JnOyBrZXlyaW5nc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWRvY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7ICdNYXVy
byBDYXJ2YWxobyBDaGVoYWInIDxtY2hlaGFiK3NhbXN1bmdAa2VybmVsLm9yZz47IFpodSwgQmlu
ZyA8YmluZy56aHVAaW50ZWwuY29tPjsgQ2hlbiwgTHVoYWkgPGx1aGFpLmNoZW5AaW50ZWwuY29t
Pg0KU3ViamVjdDogUmU6IE9uZSBxdWVzdGlvbiBhYm91dCB0cnVzdGVkIGtleSBvZiBrZXlyaW5n
IGluIExpbnV4IGtlcm5lbC4NCg0KT24gRnJpLCAyMDE5LTExLTI5IGF0IDAxOjQwICswMDAwLCBa
aGFvLCBTaGlybGV5IHdyb3RlOg0KPiBIaSwgSmFtZXMsDQo+IA0KPiBNYXliZSB0aGUgVFBNIGNv
bW1hbmQgY29uZnVzZWQgeW91LiANCg0KV2VsbCB5b3UgZGlkIHNlZW0gdG8gYmUgc2F5aW5nIHdl
IGhhZCBhIHByb2JsZW0gaW4gdGhlIFRQTSBzZWFsZWQga2V5IHN1YnN5c3RlbS4NCg0KPiBUaGUg
cXVlc3Rpb24gaXMgSSB1c2Uga2V5Y3RsIGNvbW1hbmQgc2VhbGVkIGEgdHJ1c3RlZCBrZXkgd2l0
aCBQQ1IgDQo+IHBvbGljeSwgYnV0IGxvYWQgaXQgZmFpbGVkIGFmdGVyIHJlYm9vdC4NCj4gSSBk
b24ndCBrbm93IHdoeSBpdCB3YXMgbG9hZGVkIGZhaWxlZC4gSSB1c2UgVFBNIGNvbW1hbmQgdG8g
aGVscCBmaW5kIA0KPiBpdCwgaXQgcmVwb3J0IHBvbGljeSBjaGVjayBmYWlsZWQuDQoNClJpZ2h0
LCBzbyB5b3VyIHF1ZXN0aW9uIHNlZW1zIHRvIGJlIHdoeSBhZnRlciBhIHJlYm9vdCwgdGhlIFRQ
TSBwb2xpY3kgbm8gbG9uZ2VyIHdvcmtzIHRvIGF1dGhvcml6ZSB0aGUga2V5IGV2ZW4gZnJvbSB1
c2VyIHNwYWNlPyAgTXkgYmVzdCBndWVzcyB3b3VsZCBiZSB0aGUgUENSIHZhbHVlIHlvdSd2ZSBz
ZWFsZWQgaXQgdG8gY2hhbmdlZCBvdmVyIHRoZSByZWJvb3QgZm9yIHNvbWUgcmVhc29uLg0KDQo+
IFNvIG15IHF1ZXN0aW9uIGlzIGhvdyB0byBsb2FkIHRoZSBQQ1IgcG9saWN5IHNlYWxlZCB0cnVz
dGVkIGtleSANCj4gY29ycmVjdGx5Pw0KDQpZb3UgaGF2ZSB0byBzZXQgdGhlIHNlYWxpbmcgcmVs
ZWFzZSBwb2xpY3kgdG8gc29tZXRoaW5nIHlvdSBrbm93IHdpbGwgYmUgaW52YXJpYW50IGFjcm9z
cyByZWJvb3RzIGZvciBhbiB1bnNlYWwgdG8gaGFwcGVuIHJlbGlhYmx5LiAgSG93ZXZlciwgdXN1
YWxseSB5b3UgYWxzbyB3YW50IHRoZSB1bnNlYWwgdG8gZmFpbCBpZiBzb21ldGhpbmcgeW91IGRv
bid0IGxpa2UgY2hhbmdlcywgc28geW91IHNldCB0aGUgcG9saWN5IHRvIGJlIHNvbWV0aGluZyB0
aGF0J3MgaW52YXJpYW50IHVubGVzcyB0aGF0IGhhcHBlbnMuICBOb3QgcmVhbGx5IGtub3dpbmcg
d2hhdCB5b3VyIGNvbmRpdGlvbnMgYXJlIHdlIGNhbid0IHJlYWxseSB0ZWxsIHlvdSB3aGF0IHlv
dXIgcG9saWN5IHNob3VsZCBsb29rIGxpa2UuDQoNCj4gSG93IHRvIHVzZSBwb2xpY3lkaWdlc3Qg
YW5kIHBvbGljeWhhbmRsZSBjb3JyZWN0bHkuIA0KDQpJJ3ZlIG5vIHJlYWwgaWRlYSBob3cgdGhl
IHRwbTJfIGNvbW1hbmRzIHdvcmssIGJ1dCB0aGUgdHNzcG9saWN5IGNvbW1hbmRzIGFsbCBoYXZl
IG1hbiBwYWdlcyB3aGljaCBkbyBhIHByZXR0eSBnb29kIGV4cGxhbmF0aW9uLiAgSWYgSSBpbmZl
ciBob3cgeW91ciB0cG0yXyBjb21tYW5kcyBzZWVtIHRvIGJlIHdvcmtpbmcsIEkgdGhpbmsgeW91
J3JlIHNlYWxpbmcgdG8gYSBwY3I3IGhhc2g/ICBwY3I3IGlzIHRoZSBvbmUgdGhhdCdzIHN1cHBv
c2VkIHRvIG1lYXN1cmUgdGhlIHNlY3VyZSBib290IHBhdGggYW5kIHByb3BlcnRpZXMgYW5kIGFz
IHN1Y2ggc2hvdWxkbid0IGNoYW5nZSBhY3Jvc3MgcmVib290cywgc28gSSB0aGluayB5b3VyIHBy
b2JsZW0gYmVjb21lcyBmaW5kaW5nIG91dCB3aHkgaXQgY2hhbmdlZC4NCg0KSmFtZXMNCg0K
