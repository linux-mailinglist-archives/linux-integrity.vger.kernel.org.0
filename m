Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B82310E59F
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Dec 2019 06:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfLBFzx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Dec 2019 00:55:53 -0500
Received: from mga07.intel.com ([134.134.136.100]:11360 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbfLBFzx (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Dec 2019 00:55:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Dec 2019 21:55:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,268,1571727600"; 
   d="scan'208";a="200488128"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga007.jf.intel.com with ESMTP; 01 Dec 2019 21:55:52 -0800
Received: from fmsmsx113.amr.corp.intel.com (10.18.116.7) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 1 Dec 2019 21:55:52 -0800
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 FMSMSX113.amr.corp.intel.com (10.18.116.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 1 Dec 2019 21:55:51 -0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.109]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.222]) with mapi id 14.03.0439.000;
 Mon, 2 Dec 2019 13:55:49 +0800
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
Thread-Index: AdWZwFKzDBwFOydYTGGk+Aqs+6BIxAANhxEAAoxRZMAAOKaagABSSevwABZzFQAAgRP1kP//pW0A//9ftMA=
Date:   Mon, 2 Dec 2019 05:55:49 +0000
Message-ID: <A888B25CD99C1141B7C254171A953E8E4909D360@shsmsx102.ccr.corp.intel.com>
References: <A888B25CD99C1141B7C254171A953E8E49094313@shsmsx102.ccr.corp.intel.com>
         <1573659978.17949.83.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E49095F9B@shsmsx102.ccr.corp.intel.com>
         <1574877977.3551.5.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E49096521@shsmsx102.ccr.corp.intel.com>
         <1575057916.6220.7.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E4909BA3B@shsmsx102.ccr.corp.intel.com>
 <1575260220.4080.17.camel@linux.ibm.com>
In-Reply-To: <1575260220.4080.17.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTc0N2FlZWQtYWMzZS00ZmUyLWEwNWMtN2I3MmVlOWUzZTM1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoia0ZMR3V0SUI3U3pjS3JldnFlUzg1ZnVYS3M2WnA2S09rdkdWWFAzemVkRE5DXC8xN2hVRDkrclk4VmNaRXR3RmkifQ==
x-ctpclassification: CTP_NT
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

VGhhbmtzIGZvciB5b3VyIGZlZWRiYWNrLCBKYW1lcy4NCg0KVGhlIHBvbGljeSBpcyBnZW5lcmF0
ZWQgYnkgVFBNIGNvbW1hbmQsIHRwbTJfY3JlYXRlcG9saWN5LCBpdCBqdXN0IHVzZSB0aGUgYWxn
b3JpdGhtIHlvdSBtZW50aW9uZWQsIHdoaWNoIGlzIGRlZmluZWQgaW4gVFBNIHNwZWMuIA0KSSBy
ZS1hdHRhY2ggbXkgdGVzdCBzdGVwcyBhcyBiZWxvdy4gDQpQbGVhc2UgaGVscCBjaGVjayBpdCwg
aXMgdGhlcmUgYW55dGhpbmcgd3JvbmcsIGVzcGVjaWFsbHkgdGhlIGZvcm1hdCBvZiBrZXljdGwg
Y29tbWFuZC4gDQoNCkZpcnN0bHksIHRoZSBwY3IgcG9saWN5IGlzIGdlbmVyYXRlZCBhcyBiZWxv
dzogDQokIHRwbTJfY3JlYXRlcG9saWN5IC0tcG9saWN5LXBjciAtLXBjci1saXN0IHNoYTI1Njo3
IC0tcG9saWN5IHBjcjdfYmluLnBvbGljeSA+IHBjcjcucG9saWN5DQoNClBjcjcucG9saWN5IGlz
IHRoZSBhc2NpaSBoZXggb2YgcG9saWN5Og0KJCBjYXQgcGNyNy5wb2xpY3kNCjMyMWZiZDI4YjYw
ZmNjMjMwMTdkNTAxYjEzM2JkNWRiZjI4ODk4MTQ1ODhlOGEyMzUxMGZlMTAxMDVjYjJjYzkNCg0K
VGhlbiBnZW5lcmF0ZSB0aGUgdHJ1c3RlZCBrZXkgYW5kIGNvbmZpZ3VyZSBwb2xpY3lkaWdlc3Qg
YW5kIGdldCB0aGUga2V5IElEOiANCiQga2V5Y3RsIGFkZCB0cnVzdGVkIGttayAibmV3IDMyIGtl
eWhhbmRsZT0weDgxMDAwMDAxIGhhc2g9c2hhMjU2IHBvbGljeWRpZ2VzdD1gY2F0IHBjcjcucG9s
aWN5YCIgQHUNCjg3NDExNzA0NQ0KDQpTYXZlIHRoZSB0cnVzdGVkIGtleS4gDQokIGtleWN0bCBw
aXBlIDg3NDExNzA0NSA+IGttay5ibG9iDQoNClJlYm9vdCBhbmQgbG9hZCB0aGUga2V5LiANClN0
YXJ0IGEgYXV0aCBzZXNzaW9uIHRvIGdlbmVyYXRlIHRoZSBwb2xpY3k6DQokIHRwbTJfc3RhcnRh
dXRoc2Vzc2lvbiAtUyBzZXNzaW9uLmN0eA0Kc2Vzc2lvbi1oYW5kbGU6IDB4MzAwMDAwMA0KJCB0
cG0yX3Bjcmxpc3QgLUwgc2hhMjU2OjcgLW8gcGNyNy5zaGEyNTYgJCB0cG0yX3BvbGljeXBjciAt
UyBzZXNzaW9uLmN0eCAtTCBzaGEyNTY6NyAtRiBwY3I3LnNoYTI1NiAtZiBwY3I3LnBvbGljeQ0K
cG9saWN5LWRpZ2VzdDogMHgzMjFGQkQyOEI2MEZDQzIzMDE3RDUwMUIxMzNCRDVEQkYyODg5ODE0
NTg4RThBMjM1MTBGRTEwMTA1Q0IyQ0M5DQoNCklucHV0IHRoZSBwb2xpY3kgaGFuZGxlIHRvIGxv
YWQgdHJ1c3RlZCBrZXk6DQokIGtleWN0bCBhZGQgdHJ1c3RlZCBrbWsgImxvYWQgYGNhdCBrbWsu
YmxvYmAga2V5aGFuZGxlPTB4ODEwMDAwMDEgcG9saWN5aGFuZGxlPTB4MzAwMDAwMCIgQHUNCmFk
ZF9rZXk6IE9wZXJhdGlvbiBub3QgcGVybWl0dGVkDQoNClRoZSBlcnJvciBzaG91bGQgYmUgcG9s
aWN5IGNoZWNrIGZhaWxlZCwgYmVjYXVzZSBJIHVzZSBUUE0gY29tbWFuZCB0byB1bnNlYWwgZGly
ZWN0bHkgd2l0aCBlcnJvciBvZiBwb2xpY3kgY2hlY2sgZmFpbGVkLiANCiQgdHBtMl91bnNlYWwg
LWMgMHg4MTAwMDAwMSAtTCBzaGEyNTY6Nw0KRVJST1Igb24gbGluZTogIjgxIiBpbiBmaWxlOiAi
Li9saWIvbG9nLmgiOiBUc3MyX1N5c19VbnNlYWwoMHg5OUQpIC0gdHBtOnNlc3Npb24oMSk6YSBw
b2xpY3kgY2hlY2sgZmFpbGVkIEVSUk9SIG9uIGxpbmU6ICIyMTMiIGluIGZpbGU6ICJ0b29scy90
cG0yX3Vuc2VhbC5jIjogVW5zZWFsIGZhaWxlZCENCkVSUk9SIG9uIGxpbmU6ICIxNjYiIGluIGZp
bGU6ICJ0b29scy90cG0yX3Rvb2wuYyI6IFVuYWJsZSB0byBydW4gdHBtMl91bnNlYWwNCg0KLSBT
aGlybGV5IA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogSmFtZXMgQm90dG9t
bGV5IDxqZWpiQGxpbnV4LmlibS5jb20+IA0KU2VudDogTW9uZGF5LCBEZWNlbWJlciAyLCAyMDE5
IDEyOjE3IFBNDQpUbzogWmhhbywgU2hpcmxleSA8c2hpcmxleS56aGFvQGludGVsLmNvbT47IE1p
bWkgWm9oYXIgPHpvaGFyQGxpbnV4LmlibS5jb20+OyBKYXJra28gU2Fra2luZW4gPGphcmtrby5z
YWtraW5lbkBsaW51eC5pbnRlbC5jb20+OyBKb25hdGhhbiBDb3JiZXQgPGNvcmJldEBsd24ubmV0
Pg0KQ2M6IGxpbnV4LWludGVncml0eUB2Z2VyLmtlcm5lbC5vcmc7IGtleXJpbmdzQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtZG9jQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgJ01hdXJvIENhcnZhbGhvIENoZWhhYicgPG1jaGVoYWIrc2Ftc3VuZ0BrZXJuZWwu
b3JnPjsgWmh1LCBCaW5nIDxiaW5nLnpodUBpbnRlbC5jb20+OyBDaGVuLCBMdWhhaSA8bHVoYWku
Y2hlbkBpbnRlbC5jb20+DQpTdWJqZWN0OiBSZTogT25lIHF1ZXN0aW9uIGFib3V0IHRydXN0ZWQg
a2V5IG9mIGtleXJpbmcgaW4gTGludXgga2VybmVsLg0KDQpPbiBNb24sIDIwMTktMTItMDIgYXQg
MDE6NDQgKzAwMDAsIFpoYW8sIFNoaXJsZXkgd3JvdGU6DQo+IEhpLCBKYW1lcywNCj4gDQo+IFRo
ZSB2YWx1ZSBvZiBQQ1I3IGlzIG5vdCBjaGFuZ2VkLiBJIGhhdmUgY2hlY2tlZCBpdCB3aXRoIFRQ
TSBjb21tYW5kIA0KPiB0cG1fcGNybGlzdC4NCj4gDQo+IFNvIEkgdGhpbmsgdGhlIHByb2JsZW0g
aXMgaG93IHRvIHVzZSB0aGUgb3B0aW9uIHBvbGljeWRpZ2VzdCBhbmQgDQo+IHBvbGljeWhhbmRs
ZT8gSXMgdGhlcmUgYW55IGV4YW1wbGU/DQo+IE1heWJlIHRoZSBmb3JtYXQgaW4gbXkgY29tbWFu
ZCBpcyBub3QgY29ycmVjdC4gDQoNCk9LLCBzbyBwcmV2aW91c2x5IHlvdSBzYWlkIHRoYXQgdXNp
bmcgdGhlIEludGVsIFRTUyB0aGUgcG9saWN5IGFsc28gZmFpbGVkIGFmdGVyIGEgcmVib290Og0K
DQo+IFRoZSBlcnJvciBzaG91bGQgYmUgcG9saWN5IGNoZWNrIGZhaWxlZCwgYmVjYXVzZSBJIHVz
ZSBUUE0gY29tbWFuZCB0byANCj4gdW5zZWFsIGRpcmVjdGx5IHdpdGggZXJyb3Igb2YgcG9saWN5
IGNoZWNrIGZhaWxlZC4NCj4gJCB0cG0yX3Vuc2VhbCAtYyAweDgxMDAwMDAxIC1MIHNoYTI1Njo3
IEVSUk9SIG9uIGxpbmU6ICI4MSIgaW4gZmlsZTogDQo+ICIuL2xpYi9sb2cuaCI6IFRzczJfU3lz
X1Vuc2VhbCgweDk5RCkgLSB0cG06c2Vzc2lvbigxKTphIHBvbGljeSBjaGVjayANCj4gZmFpbGVk
IEVSUk9SIG9uIGxpbmU6ICIyMTMiIGluIGZpbGU6ICJ0b29scy90cG0yX3Vuc2VhbC5jIjogVW5z
ZWFsIA0KPiBmYWlsZWQhDQo+IEVSUk9SIG9uIGxpbmU6ICIxNjYiIGluIGZpbGU6ICJ0b29scy90
cG0yX3Rvb2wuYyI6IFVuYWJsZSB0byBydW4gDQo+IHRwbTJfdW5zZWFsDQoNClNvIHRoaXMgbXVz
dCBtZWFuIHRoZSBhY3R1YWwgcG9saWN5IGhhc2ggeW91IGNvbnN0cnVjdGVkIHdhcyB3cm9uZyBp
biBzb21lIHdheTogaXQgZGlkbid0IGNvcnJlc3BvbmQgc2ltcGx5IHRvIGEgdmFsdWUgb2YgcGNy
NyAuLi4gd2VsbCBhc3N1bWluZyB0aGUgLUwgc2hhMjU2OjcgbWVhbnMgY29uc3RydWN0IGEgcG9s
aWN5IG9mIHRoZSBzaGEyNTYgdmFsdWUgb2YgcGNyNyBhbmQgdXNlIGl0IGluIHRoZSB1bnNlYWwu
DQoNCkkgY2FuIHRlbGwgeW91IGhvdyB0byBjb25zdHJ1Y3QgcG9saWNpZXMgdXNpbmcgVFBNMiBj
b21tYW5kcywgYnV0IEkgdGhpbmsgeW91IHdhbnQgdG8ga25vdyBob3cgdG8gZG8gaXQgdXNpbmcg
dGhlIEludGVsIFRTUz8gIEluIHdoaWNoIGNhc2UgeW91IHJlYWxseSBuZWVkIHRvIGNvbnN1bHQg
dGhlIGV4cGVydHMgaW4gdGhhdCBUU1MsIGxpa2UgUGhpbCBUcmljY2EuDQoNCkZvciB0aGUgcGxh
aW4gVFBNMiBjYXNlLCB0aGUgcG9saWN5IGxvb2tzIGxpa2UNCg0KVFBNX0NDX1BvbGljeVBDUiB8
fCBwY3JzIHx8IHBjckRpZ2VzdA0KDQpXaGVyZSBUUE1fQ0NfUG9saWN5UENSID0gMDAwMDAxN2Yg
YW5kIGZvciBzZWxlY3RpbmcgcGNyNyBvbmx5LiAgcGNycyBpcyBhIGNvbXBsaWNhdGVkIGVudGl0
eTogaXQncyBhIGNvdW50ZWQgYXJyYXkgb2YgcGNyIHNlbGVjdGlvbnMuICBGb3IgeW91ciBwb2xp
Y3kgeW91IG9ubHkgbmVlZCBvbmUgZW50cnksIHNvIGl0IHdvdWxkIGJlIDAwMDAwMDAxIGZvbGxv
d2VkIGJ5IGEgc2luZ2xlIHBjclNlbGVjdGlvbiBlbnRyeS4gIHBjclNlbGVjdGlvbiBpcyB0aGUg
aGFzaCBhbGdvcml0aG0sIHRoZSBzaXplIG9mIHRoZSBzZWxlY3Rpb24gYml0bWFwIChhbHdheXMg
MyBzaW5jZSBldmVyeSBjdXJyZW50IFRQTSBvbmx5IGhhcw0KMjQgUENScykgYW5kIGEgYml0bWFw
IHNlbGVjdGluZyB0aGUgUENScyBpbiBiaWcgZW5kaWFuIGZvcm1hdCwgc28gZm9yDQpQQ1I3IHVz
aW5nIHNoYTI1NiAoYWxnb3JpdGhtIDAwMGIpLCBwY3JTZWxlY3Rpb24gPSAwMDBiIDAzIDgwIDAw
IDAwLiANCkFuZCB0aGVuIHlvdSBmb2xsb3cgdGhpcyBieSB0aGUgaGFzaCBvZiB0aGUgUENSIHZh
bHVlIHlvdSdyZSBsb29raW5nIGZvci4gIFRoZSBwb2xpY3loYXNoIGJlY29tZXMgdGhlIGluaXRp
YWwgcG9saWN5IChhbGwgemVyb3MgZm9yIHRoZSBzdGFydCBvZiB0aGUgcG9saWN5IGNoYWluKSBo
YXNoZWQgd2l0aCB0aGlzLg0KDQpSZWdhcmRzLA0KDQpKYW1lcw0KDQo=
