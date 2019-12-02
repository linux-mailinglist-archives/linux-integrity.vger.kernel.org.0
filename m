Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 716E710E62C
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Dec 2019 07:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfLBGuV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Dec 2019 01:50:21 -0500
Received: from mga06.intel.com ([134.134.136.31]:47608 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfLBGuV (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Dec 2019 01:50:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Dec 2019 22:50:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,268,1571727600"; 
   d="scan'208";a="241823695"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga002.fm.intel.com with ESMTP; 01 Dec 2019 22:50:20 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 1 Dec 2019 22:50:20 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 1 Dec 2019 22:50:19 -0800
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 1 Dec 2019 22:50:19 -0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.109]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.222]) with mapi id 14.03.0439.000;
 Mon, 2 Dec 2019 14:50:18 +0800
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
Thread-Index: AdWZwFKzDBwFOydYTGGk+Aqs+6BIxAANhxEAAoxRZMAAOKaagABSSevwABZzFQAAgRP1kP//pW0A//9ftMCAAMH6gP//eLrAgACO1ID//3k2UA==
Date:   Mon, 2 Dec 2019 06:50:17 +0000
Message-ID: <A888B25CD99C1141B7C254171A953E8E4909E399@shsmsx102.ccr.corp.intel.com>
References: <A888B25CD99C1141B7C254171A953E8E49094313@shsmsx102.ccr.corp.intel.com>
         <1573659978.17949.83.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E49095F9B@shsmsx102.ccr.corp.intel.com>
         <1574877977.3551.5.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E49096521@shsmsx102.ccr.corp.intel.com>
         <1575057916.6220.7.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E4909BA3B@shsmsx102.ccr.corp.intel.com>
         <1575260220.4080.17.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E4909D360@shsmsx102.ccr.corp.intel.com>
         <1575267453.4080.26.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E4909E381@shsmsx102.ccr.corp.intel.com>
 <1575269075.4080.31.camel@linux.ibm.com>
In-Reply-To: <1575269075.4080.31.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjg5OTM2NjItYjQ4My00MmU0LTkzNDctYWJhNTJjZWZhNjUyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVjRqSThcL3RhbTg1bnVcL3FxY3NZWkZDczV4SEc4VHhMbThBREZlbjc2VzZaWTRLY0tCMkpHWmhoWFJFVmVpdnpTIn0=
x-ctpclassification: CTP_NT
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

U28gSSBndWVzcyBtb3N0bHkgbGlrZSwgaXQgaXMgdGhlIGZvcm1hdCBvZiBwb2xpY3lkaWdlc3Qs
IHBvbGljeWhhbmRsZSBpcyBub3QgY29ycmVjdGx5IGluIG15IGtleWN0bCBjb21tYW5kLiANCkJ1
dCB3aGF0IGlzIHRoZSBjb3JyZWN0IHVzaW5nPw0KDQpNeSBrZXljdGwgY29tbWFuZHMgYXJlIGF0
dGFjaGVkIGFzIGJlbG93OiANCiQga2V5Y3RsIGFkZCB0cnVzdGVkIGttayAibmV3IDMyIGtleWhh
bmRsZT0weDgxMDAwMDAxIGhhc2g9c2hhMjU2IHBvbGljeWRpZ2VzdD1gY2F0IHBjcjcucG9saWN5
YCIgQHUNCjg3NDExNzA0NQ0KDQpTYXZlIHRoZSB0cnVzdGVkIGtleS4gDQokIGtleWN0bCBwaXBl
IDg3NDExNzA0NSA+IGttay5ibG9iDQoNClJlYm9vdCBhbmQgbG9hZCB0aGUga2V5LiANClN0YXJ0
IGEgYXV0aCBzZXNzaW9uIHRvIGdlbmVyYXRlIHRoZSBwb2xpY3k6DQokIHRwbTJfc3RhcnRhdXRo
c2Vzc2lvbiAtUyBzZXNzaW9uLmN0eA0Kc2Vzc2lvbi1oYW5kbGU6IDB4MzAwMDAwMA0KJCB0cG0y
X3Bjcmxpc3QgLUwgc2hhMjU2OjcgLW8gcGNyNy5zaGEyNTYgJCB0cG0yX3BvbGljeXBjciAtUyBz
ZXNzaW9uLmN0eCAtTCBzaGEyNTY6NyAtRiBwY3I3LnNoYTI1NiAtZiBwY3I3LnBvbGljeQ0KcG9s
aWN5LWRpZ2VzdDogMHgzMjFGQkQyOEI2MEZDQzIzMDE3RDUwMUIxMzNCRDVEQkYyODg5ODE0NTg4
RThBMjM1MTBGRTEwMTA1Q0IyQ0M5DQoNCklucHV0IHRoZSBwb2xpY3kgaGFuZGxlIHRvIGxvYWQg
dHJ1c3RlZCBrZXk6DQokIGtleWN0bCBhZGQgdHJ1c3RlZCBrbWsgImxvYWQgYGNhdCBrbWsuYmxv
YmAga2V5aGFuZGxlPTB4ODEwMDAwMDEgcG9saWN5aGFuZGxlPTB4MzAwMDAwMCIgQHUNCmFkZF9r
ZXk6IE9wZXJhdGlvbiBub3QgcGVybWl0dGVkDQoNCg0KVGhhbmtzLiANCg0KLSBTaGlybGV5IA0K
DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBKYW1lcyBCb3R0b21sZXkgPGpl
amJAbGludXguaWJtLmNvbT4gDQpTZW50OiBNb25kYXksIERlY2VtYmVyIDIsIDIwMTkgMjo0NSBQ
TQ0KVG86IFpoYW8sIFNoaXJsZXkgPHNoaXJsZXkuemhhb0BpbnRlbC5jb20+OyBNaW1pIFpvaGFy
IDx6b2hhckBsaW51eC5pYm0uY29tPjsgSmFya2tvIFNha2tpbmVuIDxqYXJra28uc2Fra2luZW5A
bGludXguaW50ZWwuY29tPjsgSm9uYXRoYW4gQ29yYmV0IDxjb3JiZXRAbHduLm5ldD4NCkNjOiBs
aW51eC1pbnRlZ3JpdHlAdmdlci5rZXJuZWwub3JnOyBrZXlyaW5nc0B2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
ICdNYXVybyBDYXJ2YWxobyBDaGVoYWInIDxtY2hlaGFiK3NhbXN1bmdAa2VybmVsLm9yZz47IFpo
dSwgQmluZyA8YmluZy56aHVAaW50ZWwuY29tPjsgQ2hlbiwgTHVoYWkgPGx1aGFpLmNoZW5AaW50
ZWwuY29tPg0KU3ViamVjdDogUmU6IE9uZSBxdWVzdGlvbiBhYm91dCB0cnVzdGVkIGtleSBvZiBr
ZXlyaW5nIGluIExpbnV4IGtlcm5lbC4NCg0KT24gTW9uLCAyMDE5LTEyLTAyIGF0IDA2OjIzICsw
MDAwLCBaaGFvLCBTaGlybGV5IHdyb3RlOg0KPiBIaSwgSmFtZXMsDQo+IA0KPiBUaGUgUENSNyB2
YWx1ZSBhbmQgUENSNyBwb2xpY3kgaXMgYXMgYmVsb3csIHBsZWFzZSByZXZpZXcsIHRoYW5rcy4g
DQo+IA0KPiAjIHRwbTJfcGNybGlzdCAtTCBzaGEyNTY6NyAtbyBwY3I3XzIuc2hhMjU2DQo+IHNo
YTI1NjoNCj4gICA3IDoNCj4gMHgwNjFBQUQwNzA1QTYyMzYxQUQxOEU1OEI2NUQzRDczODNGNEQx
MEY3RjVBN0U3ODkyNEJFMDU3QUM2Nzk3NDA4DQo+IA0KPiAjIHRwbTJfY3JlYXRlcG9saWN5IC0t
cG9saWN5LXBjciAtLXBjci1saXN0IHNoYTI1Njo3IC0tcG9saWN5IA0KPiBwY3I3X2Jpbi5wb2xp
Y3kgPiBwY3I3LnBvbGljeQ0KPiAzMjFmYmQyOGI2MGZjYzIzMDE3ZDUwMWIxMzNiZDVkYmYyODg5
ODE0NTg4ZThhMjM1MTBmZTEwMTA1Y2IyY2M5DQo+IA0KPiAjIGNhdCBwY3I3LnBvbGljeQ0KPiAz
MjFmYmQyOGI2MGZjYzIzMDE3ZDUwMWIxMzNiZDVkYmYyODg5ODE0NTg4ZThhMjM1MTBmZTEwMTA1
Y2IyY2M5DQoNCldlbGwsIHRoZSBJQk0gVFNTIHNheXMgdGhhdCdzIHRoZSBjb3JyZWN0IHBvbGlj
eS4gIFlvdXIgcG9saWN5IGNvbW1hbmQgaXMNCg0KamVqYkBqYXJ2aXM6fj4gdHNzcG9saWN5bWFr
ZXJwY3IgLWJtIDAwMDA4MCAtaWYgfi9wY3I3LnR4dCAtcHIgfCB0ZWUgdG1wLnBvbGljeSAwMDAw
MDE3ZjAwMDAwMDAxMDAwYjAzODAwMDAwOWE0NzM1MGZkYmNjNzdlYmVhZGNiNGI0ODE4ZDhlODJh
MjE3MTdlYTI0NDM0MzMzYzc5MWMwY2QwZDFkYzE0ZQ0KDQpBbmQgdGhhdCBoYXNoZXMgdG8NCmpl
amJAamFydmlzOn4+IHRzc3BvbGljeW1ha2VyIC1pZiB+L3RtcC5wb2xpY3kgIC1wciAgcG9saWN5
IGRpZ2VzdCBsZW5ndGggMzINCiAzMiAxZiBiZCAyOCBiNiAwZiBjYyAyMyAwMSA3ZCA1MCAxYiAx
MyAzYiBkNSBkYg0KIGYyIDg4IDk4IDE0IDU4IDhlIDhhIDIzIDUxIDBmIGUxIDAxIDA1IGNiIDJj
IGM5IA0KDQpTbyBJIGRvbid0IHVuZGVyc3RhbmQgd2h5IHRoZSB1c2Vyc3BhY2UgSW50ZWwgVFNT
IGNvbW1hbmQgaXMgZmFpbGluZyB0byBkbyB0aGUgdW5zZWFsLg0KDQpKYW1lcw0KDQo=
