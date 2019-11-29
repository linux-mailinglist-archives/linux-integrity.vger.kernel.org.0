Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4C8410D064
	for <lists+linux-integrity@lfdr.de>; Fri, 29 Nov 2019 02:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfK2BkL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 28 Nov 2019 20:40:11 -0500
Received: from mga12.intel.com ([192.55.52.136]:63234 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbfK2BkK (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Nov 2019 20:40:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2019 17:40:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,255,1571727600"; 
   d="scan'208";a="383951374"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga005.jf.intel.com with ESMTP; 28 Nov 2019 17:40:09 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 28 Nov 2019 17:40:08 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 28 Nov 2019 17:40:08 -0800
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 28 Nov 2019 17:40:07 -0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.108]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.149]) with mapi id 14.03.0439.000;
 Fri, 29 Nov 2019 09:40:06 +0800
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
Thread-Index: AdWZwFKzDBwFOydYTGGk+Aqs+6BIxAANhxEAAoxRZMAAOKaagABSSevw
Date:   Fri, 29 Nov 2019 01:40:05 +0000
Message-ID: <A888B25CD99C1141B7C254171A953E8E49096521@shsmsx102.ccr.corp.intel.com>
References: <A888B25CD99C1141B7C254171A953E8E49094313@shsmsx102.ccr.corp.intel.com>
         <1573659978.17949.83.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E49095F9B@shsmsx102.ccr.corp.intel.com>
 <1574877977.3551.5.camel@linux.ibm.com>
In-Reply-To: <1574877977.3551.5.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNGI3ZjAwMWItZTVhYi00MzY4LWJmZGMtNjlkODE3OTk1YTMwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRWdcL1wvS2VcL1F2bUVpM0dZeE02YnUzNzFJN1dieWlQWHJQWFE0V0lyY3BVUVlvQjA2UzNkTXdqQ1pSYWV1Skw1SyJ9
x-ctpclassification: CTP_NT
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

SGksIEphbWVzLCANCg0KTWF5YmUgdGhlIFRQTSBjb21tYW5kIGNvbmZ1c2VkIHlvdS4gDQoNClRo
ZSBxdWVzdGlvbiBpcyBJIHVzZSBrZXljdGwgY29tbWFuZCBzZWFsZWQgYSB0cnVzdGVkIGtleSB3
aXRoIFBDUiBwb2xpY3ksIGJ1dCBsb2FkIGl0IGZhaWxlZCBhZnRlciByZWJvb3QuIA0KSSBkb24n
dCBrbm93IHdoeSBpdCB3YXMgbG9hZGVkIGZhaWxlZC4gSSB1c2UgVFBNIGNvbW1hbmQgdG8gaGVs
cCBmaW5kIGl0LCBpdCByZXBvcnQgcG9saWN5IGNoZWNrIGZhaWxlZC4gDQoNClNvIG15IHF1ZXN0
aW9uIGlzIGhvdyB0byBsb2FkIHRoZSBQQ1IgcG9saWN5IHNlYWxlZCB0cnVzdGVkIGtleSBjb3Jy
ZWN0bHk/IA0KSG93IHRvIHVzZSBwb2xpY3lkaWdlc3QgYW5kIHBvbGljeWhhbmRsZSBjb3JyZWN0
bHkuIA0KDQpUaGFua3MuIA0KDQotIFNoaXJsZXkgDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQpGcm9tOiBKYW1lcyBCb3R0b21sZXkgPGplamJAbGludXguaWJtLmNvbT4gDQpTZW50OiBU
aHVyc2RheSwgTm92ZW1iZXIgMjgsIDIwMTkgMjowNiBBTQ0KVG86IFpoYW8sIFNoaXJsZXkgPHNo
aXJsZXkuemhhb0BpbnRlbC5jb20+OyBNaW1pIFpvaGFyIDx6b2hhckBsaW51eC5pYm0uY29tPjsg
SmFya2tvIFNha2tpbmVuIDxqYXJra28uc2Fra2luZW5AbGludXguaW50ZWwuY29tPjsgSm9uYXRo
YW4gQ29yYmV0IDxjb3JiZXRAbHduLm5ldD4NCkNjOiBsaW51eC1pbnRlZ3JpdHlAdmdlci5rZXJu
ZWwub3JnOyBrZXlyaW5nc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7ICdNYXVybyBDYXJ2YWxobyBDaGVoYWIn
IDxtY2hlaGFiK3NhbXN1bmdAa2VybmVsLm9yZz47IFpodSwgQmluZyA8YmluZy56aHVAaW50ZWwu
Y29tPjsgQ2hlbiwgTHVoYWkgPGx1aGFpLmNoZW5AaW50ZWwuY29tPg0KU3ViamVjdDogUmU6IE9u
ZSBxdWVzdGlvbiBhYm91dCB0cnVzdGVkIGtleSBvZiBrZXlyaW5nIGluIExpbnV4IGtlcm5lbC4N
Cg0KT24gVHVlLCAyMDE5LTExLTI2IGF0IDA3OjMyICswMDAwLCBaaGFvLCBTaGlybGV5IHdyb3Rl
Og0KPiBUaGFua3MgZm9yIHlvdXIgZmVlZGJhY2ssIE1pbWkuIA0KPiBCdXQgdGhlIGRvY3VtZW50
IG9mIGRyYWN1dCBjYW4ndCBzb2x2ZSBteSBwcm9ibGVtLiANCj4gDQo+IEkgZGlkIG1vcmUgdGVz
dCB0aGVzZSBkYXlzIGFuZCB0cnkgdG8gZGVzY3JpcHQgbXkgcXVlc3Rpb24gaW4gbW9yZSANCj4g
ZGV0YWlsLg0KPiANCj4gSW4gbXkgc2NlbmFyaW8sIHRoZSB0cnVzdGVkIGtleSB3aWxsIGJlIHNl
YWxlZCBpbnRvIFRQTSB3aXRoIFBDUiANCj4gcG9saWN5Lg0KPiBBbmQgdGhlcmUgYXJlIHNvbWUg
cmVsYXRlZCBvcHRpb25zIGluIG1hbnVhbCBsaWtlIA0KPiAgICAgICAgaGFzaD0gICAgICAgICBo
YXNoIGFsZ29yaXRobSBuYW1lIGFzIGEgc3RyaW5nLiBGb3IgVFBNIDEueCB0aGUNCj4gb25seQ0K
PiAgICAgICAgICAgICAgICAgICAgICBhbGxvd2VkIHZhbHVlIGlzIHNoYTEuIEZvciBUUE0gMi54
IHRoZSBhbGxvd2VkIA0KPiB2YWx1ZXMNCj4gICAgICAgICAgICAgICAgICAgICAgYXJlIHNoYTEs
IHNoYTI1Niwgc2hhMzg0LCBzaGE1MTIgYW5kIHNtMy0yNTYuDQo+ICAgICAgICBwb2xpY3lkaWdl
c3Q9IGRpZ2VzdCBmb3IgdGhlIGF1dGhvcml6YXRpb24gcG9saWN5LiBtdXN0IGJlIA0KPiBjYWxj
dWxhdGVkDQo+ICAgICAgICAgICAgICAgICAgICAgIHdpdGggdGhlIHNhbWUgaGFzaCBhbGdvcml0
aG0gYXMgc3BlY2lmaWVkIGJ5IHRoZSANCj4gJ2hhc2g9Jw0KPiAgICAgICAgICAgICAgICAgICAg
ICBvcHRpb24uDQo+ICAgICAgICBwb2xpY3loYW5kbGU9IGhhbmRsZSB0byBhbiBhdXRob3JpemF0
aW9uIHBvbGljeSBzZXNzaW9uIHRoYXQgDQo+IGRlZmluZXMgdGhlDQo+ICAgICAgICAgICAgICAg
ICAgICAgIHNhbWUgcG9saWN5IGFuZCB3aXRoIHRoZSBzYW1lIGhhc2ggYWxnb3JpdGhtIGFzIA0K
PiB3YXMgdXNlZCB0bw0KPiAgICAgICAgICAgICAgICAgICAgICBzZWFsIHRoZSBrZXkuIA0KPiAN
Cj4gSGVyZSBpcyBteSB0ZXN0IHN0ZXAuIA0KPiBGaXJzdGx5LCB0aGUgcGNyIHBvbGljeSBpcyBn
ZW5lcmF0ZWQgYXMgYmVsb3c6IA0KPiAkIHRwbTJfY3JlYXRlcG9saWN5IC0tcG9saWN5LXBjciAt
LXBjci1saXN0IHNoYTI1Njo3IC0tcG9saWN5IA0KPiBwY3I3X2Jpbi5wb2xpY3kgPiBwY3I3LnBv
bGljeQ0KPiANCj4gUGNyNy5wb2xpY3kgaXMgdGhlIGFzY2lpIGhleCBvZiBwb2xpY3k6DQo+ICQg
Y2F0IHBjcjcucG9saWN5DQo+IDMyMWZiZDI4YjYwZmNjMjMwMTdkNTAxYjEzM2JkNWRiZjI4ODk4
MTQ1ODhlOGEyMzUxMGZlMTAxMDVjYjJjYzkNCj4gDQo+IFRoZW4gZ2VuZXJhdGUgdGhlIHRydXN0
ZWQga2V5IGFuZCBjb25maWd1cmUgcG9saWN5ZGlnZXN0IGFuZCBnZXQgdGhlIA0KPiBrZXkgSUQ6
DQo+ICQga2V5Y3RsIGFkZCB0cnVzdGVkIGttayAibmV3IDMyIGtleWhhbmRsZT0weDgxMDAwMDAx
IGhhc2g9c2hhMjU2IA0KPiBwb2xpY3lkaWdlc3Q9YGNhdCBwY3I3LnBvbGljeWAiIEB1DQo+IDg3
NDExNzA0NQ0KPiANCj4gU2F2ZSB0aGUgdHJ1c3RlZCBrZXkuIA0KPiAkIGtleWN0bCBwaXBlIDg3
NDExNzA0NSA+IGttay5ibG9iDQo+IA0KPiBSZWJvb3QgYW5kIGxvYWQgdGhlIGtleS4gDQo+IFN0
YXJ0IGEgYXV0aCBzZXNzaW9uIHRvIGdlbmVyYXRlIHRoZSBwb2xpY3k6DQo+ICQgdHBtMl9zdGFy
dGF1dGhzZXNzaW9uIC1TIHNlc3Npb24uY3R4DQo+IHNlc3Npb24taGFuZGxlOiAweDMwMDAwMDAN
Cj4gJCB0cG0yX3Bjcmxpc3QgLUwgc2hhMjU2OjcgLW8gcGNyNy5zaGEyNTYgJCB0cG0yX3BvbGlj
eXBjciAtUyANCj4gc2Vzc2lvbi5jdHggLUwgc2hhMjU2OjcgLUYgcGNyNy5zaGEyNTYgLWYgcGNy
Ny5wb2xpY3kNCj4gcG9saWN5LWRpZ2VzdDoNCj4gMHgzMjFGQkQyOEI2MEZDQzIzMDE3RDUwMUIx
MzNCRDVEQkYyODg5ODE0NTg4RThBMjM1MTBGRTEwMTA1Q0IyQ0M5DQo+IA0KPiBJbnB1dCB0aGUg
cG9saWN5IGhhbmRsZSB0byBsb2FkIHRydXN0ZWQga2V5Og0KPiAkIGtleWN0bCBhZGQgdHJ1c3Rl
ZCBrbWsgImxvYWQgYGNhdCBrbWsuYmxvYmAga2V5aGFuZGxlPTB4ODEwMDAwMDEgDQo+IHBvbGlj
eWhhbmRsZT0weDMwMDAwMDAiIEB1DQo+IGFkZF9rZXk6IE9wZXJhdGlvbiBub3QgcGVybWl0dGVk
DQo+IA0KPiBUaGUgZXJyb3Igc2hvdWxkIGJlIHBvbGljeSBjaGVjayBmYWlsZWQsIGJlY2F1c2Ug
SSB1c2UgVFBNIGNvbW1hbmQgdG8gDQo+IHVuc2VhbCBkaXJlY3RseSB3aXRoIGVycm9yIG9mIHBv
bGljeSBjaGVjayBmYWlsZWQuDQo+ICQgdHBtMl91bnNlYWwgLWMgMHg4MTAwMDAwMSAtTCBzaGEy
NTY6NyBFUlJPUiBvbiBsaW5lOiAiODEiIGluIGZpbGU6IA0KPiAiLi9saWIvbG9nLmgiOiBUc3My
X1N5c19VbnNlYWwoMHg5OUQpIC0gdHBtOnNlc3Npb24oMSk6YSBwb2xpY3kgY2hlY2sgDQo+IGZh
aWxlZCBFUlJPUiBvbiBsaW5lOiAiMjEzIiBpbiBmaWxlOiAidG9vbHMvdHBtMl91bnNlYWwuYyI6
IFVuc2VhbCANCj4gZmFpbGVkIQ0KPiBFUlJPUiBvbiBsaW5lOiAiMTY2IiBpbiBmaWxlOiAidG9v
bHMvdHBtMl90b29sLmMiOiBVbmFibGUgdG8gcnVuIA0KPiB0cG0yX3Vuc2VhbA0KDQpJIHRoaW5r
IHRoZXJlJ3MgYSBtaXNjb21tdW5pY2F0aW9uIGhlcmU6IHlvdSdyZSBjb21wbGFpbmluZyBhYm91
dCB0aGUgZXJyb3IgcmV0dXJuZWQgZnJvbSBhIHRydXN0ZWQga2V5IHVuc2VhbCBvcGVyYXRpb24g
dGhhdCAqc2hvdWxkKiBmYWlsLCBjb3JyZWN0PyAgWW91IHRoaW5rIGl0IHNob3VsZCByZXR1cm4g
YSBUUE0gZXJyb3IgYnV0IGluc3RlYWQgaXQgcmV0dXJucyAtRVBFUk0uICBUaGF0J3MgY29tcGxl
dGVseSBjb3JyZWN0OiB3ZSB0cmFuc2xhdGUgYWxsIFRQTSBlcnJvcnMgaW50byBsaW51eCBvbmVz
IGFzIHdlIHBhc3MgdGhlbSB1cCB0byB1c2Vyc3BhY2UsIHNvIHRoZSBiZXN0IHdlIGNhbiBkbyBp
cyBvcGVyYXRpb24gbm90IHBlcm1pdHRlZC4NCg0KSmFtZXMNCg0K
