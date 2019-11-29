Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49A3B10D070
	for <lists+linux-integrity@lfdr.de>; Fri, 29 Nov 2019 02:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfK2ByE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 28 Nov 2019 20:54:04 -0500
Received: from mga11.intel.com ([192.55.52.93]:51505 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbfK2ByE (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Nov 2019 20:54:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2019 17:54:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,255,1571727600"; 
   d="scan'208";a="359938553"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga004.jf.intel.com with ESMTP; 28 Nov 2019 17:54:03 -0800
Received: from fmsmsx121.amr.corp.intel.com (10.18.125.36) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 28 Nov 2019 17:54:03 -0800
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 fmsmsx121.amr.corp.intel.com (10.18.125.36) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 28 Nov 2019 17:54:02 -0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.108]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.127]) with mapi id 14.03.0439.000;
 Fri, 29 Nov 2019 09:54:01 +0800
From:   "Zhao, Shirley" <shirley.zhao@intel.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
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
Thread-Index: AdWZwFKzDBwFOydYTGGk+Aqs+6BIxAANhxEAAoxRZMAACTMHAAAdE3MAAA0/ewAAWA260A==
Date:   Fri, 29 Nov 2019 01:54:00 +0000
Message-ID: <A888B25CD99C1141B7C254171A953E8E49096540@shsmsx102.ccr.corp.intel.com>
References: <A888B25CD99C1141B7C254171A953E8E49094313@shsmsx102.ccr.corp.intel.com>
         <1573659978.17949.83.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E49095F9B@shsmsx102.ccr.corp.intel.com>
         <1574796456.4793.248.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E490961E5@shsmsx102.ccr.corp.intel.com>
 <1574869168.4793.282.camel@linux.ibm.com>
In-Reply-To: <1574869168.4793.282.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjBkMDY4ZmUtOGYyOC00ODY3LTk2ZDUtODk1ZTU1MGQ4MDgxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRnVIVTd0YVRFdExGWFQ1MktiQzE2WHBmZkNTZ1VBM2gwRlQ0VTFPVWg2aTMrOTVWM3ZnYTNYQkc2T2hiSVFJWSJ9
x-ctpclassification: CTP_NT
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

SGksIE1pbWksIA0KDQpNeSB0ZXN0IGVudmlyb25tZW50IGlzIFVidW50dSAxOC4wNC4zLCBrZXJu
ZWwgdmVyc2lvbiBpcyA1LjAuMC0zNi1nZW5lcmljLiANCiQgY2F0IC9wcm9jL3ZlcnNpb24NCkxp
bnV4IHZlcnNpb24gNS4wLjAtMzYtZ2VuZXJpYyAoYnVpbGRkQGxndzAxLWFtZDY0LTA2MCkgKGdj
YyB2ZXJzaW9uIDcuNC4wIChVYnVudHUgNy40LjAtMXVidW50dTF+MTguMDQuMSkpICMzOX4xOC4w
NC4xLVVidW50dSBTTVAgVHVlIE5vdiAxMiAxMTowOTo1MCBVVEMgMjAxOQ0KJCBsc2JfcmVsZWFz
ZSAtYQ0KTm8gTFNCIG1vZHVsZXMgYXJlIGF2YWlsYWJsZS4NCkRpc3RyaWJ1dG9yIElEOiBVYnVu
dHUNCkRlc2NyaXB0aW9uOiAgICBVYnVudHUgMTguMDQuMyBMVFMNClJlbGVhc2U6ICAgICAgICAx
OC4wNA0KQ29kZW5hbWU6ICAgICAgIGJpb25pYw0KDQpJdCBpcyBUUE0yLjAsIGRUUE0uIA0KDQpB
bmQgSSBkaWRu4oCZdCBydW4gaXQgb24gb3RoZXIgdmVyc2lvbi4gDQoNCkl0IGhhcyBubyByZWxh
dGlvbnNoaXAgd2l0aCBUUE0gY29tbWFuZCwgaXQgaXMganVzdCB1c2VkIHRvIGhlbHAgZmluZCB0
aGUgZmFpbCByZWFzb24uIA0KTXkgcXVlc3Rpb24gaXMgaG93IHRvIGxvYWQgYSB0cnVzdGVkIGtl
eSB3aGljaCBpcyBzZWFsZWQgd2l0aCBQQ1IgcG9saWN5IGNvcnJlY3RseSBhZnRlciByZWJvb3Qu
DQpUaGF0IGlzIGJldHRlciBpZiB0aGVyZSBpcyBzb21lIGV4YW1wbGUgYWJvdXQgaG93IHRvIHVz
ZSAicG9saWN5ZGlnZXN0IiwgInBvbGljeWhhbmRsZSIgdG8gc2VhbC91bnNlYWwgYSB0cnVzdGVk
IGtleS4gDQoNClRoYW5rcy4gDQoNCi0gU2hpcmxleSANCg0KDQoNCi0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQpGcm9tOiBNaW1pIFpvaGFyIDx6b2hhckBsaW51eC5pYm0uY29tPiANClNlbnQ6
IFdlZG5lc2RheSwgTm92ZW1iZXIgMjcsIDIwMTkgMTE6MzkgUE0NClRvOiBaaGFvLCBTaGlybGV5
IDxzaGlybGV5LnpoYW9AaW50ZWwuY29tPjsgSmFtZXMgQm90dG9tbGV5IDxqZWpiQGxpbnV4Lmli
bS5jb20+OyBKYXJra28gU2Fra2luZW4gPGphcmtrby5zYWtraW5lbkBsaW51eC5pbnRlbC5jb20+
OyBKb25hdGhhbiBDb3JiZXQgPGNvcmJldEBsd24ubmV0Pg0KQ2M6IGxpbnV4LWludGVncml0eUB2
Z2VyLmtlcm5lbC5vcmc7IGtleXJpbmdzQHZnZXIua2VybmVsLm9yZzsgbGludXgtZG9jQHZnZXIu
a2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgJ01hdXJvIENhcnZhbGhv
IENoZWhhYicgPG1jaGVoYWIrc2Ftc3VuZ0BrZXJuZWwub3JnPjsgWmh1LCBCaW5nIDxiaW5nLnpo
dUBpbnRlbC5jb20+OyBDaGVuLCBMdWhhaSA8bHVoYWkuY2hlbkBpbnRlbC5jb20+DQpTdWJqZWN0
OiBSZTogT25lIHF1ZXN0aW9uIGFib3V0IHRydXN0ZWQga2V5IG9mIGtleXJpbmcgaW4gTGludXgg
a2VybmVsLg0KDQpIaSBTaGlybGV5LA0KDQpPbiBXZWQsIDIwMTktMTEtMjcgYXQgMDI6NDYgKzAw
MDAsIFpoYW8sIFNoaXJsZXkgd3JvdGU6DQo+IEhpLCBNaW1pLA0KPiANCj4gQW5zd2VyIHlvdXIg
dHdvIHF1ZXN0aW9uczoNCj4gDQo+IDEuIFllcywgSSBoYXZlIHZlcmlmaWVkIHRydXN0ZWQga2V5
IHdvcmtzIHdlbGwgd2l0aG91dCBQQ1IgcG9saWN5IA0KPiBwcm90ZWN0aW9uIGFzIGJlbG93Og0K
PiAkIGtleWN0bCBhZGQgdHJ1c3RlZCBrbWsgIm5ldyAzMiBrZXloYW5kbGU9MHg4MTAwMDAwMSIg
QHUNCj4gMTA1NTI0MDkyOA0KPiAkIGtleWN0bCBsaXN0IEB1DQo+IDEga2V5cyBpbiBrZXlyaW5n
Og0KPiAxMDU1MjQwOTI4OiAtLWFsc3dydiAgICAgMCAgICAgMCB0cnVzdGVkOiBrbWsNCj4gJCBr
ZXljdGwgcGlwZSAxMDU1MjQwOTI4ID4ga21rLmJsb2INCj4gJCBjYXQga21rLmJsb2INCj4gMDA3
ZjAwMjBmZjgwOGJkOGI3MjM5MTk0ZTg5YWFjNmE5NWI0ZDIxMDExNDc0MmMyMGFmYTMzNDkzZjAw
MmRmZmQwNjgNCj4gNWQ1MTAwMTBjMTJkN2FkNTFlYjgzZDZkOTM4OTVkZTA2NmJmM2QzOTcxOGNj
NTAzYWRiNDgwMmNiMDg3Yjg4YjJmZmYNCj4gNGIwNDBmZTNhMmJlNmEzZjg3YzY3NDlkMDg3Yzlm
YjZlODczNGNiMjNmNDM4ZDY0MDg3NTgxYTEzYmM4M2Q1ZGMzYjANCj4gMjZlNzdhODk0ZWNlNjYy
MGQwZWI4NWRmNjQ0OWZmM2M2MDlmZDc3ZDVmMGNhZjc5YjQ1MzViMDAyZTAwMDgwMDBiMDANCj4g
MDAwMDQwMDAwMDAwMTAwMDIwOWE1YjAwYjBkNTU4ZmNmOWU4YzAyOTUyMjcxNWU2YjU5MDYzNjZl
YWVjNWYzNDM2N2INCj4gOGFiMTZjMGZiOTAwOWEwMDczMDAwMDAwMDAwMDIwZTNiMGM0NDI5OGZj
MWMxNDlhZmJmNGM4OTk2ZmI5MjQyN2FlNDENCj4gZTQ2NDliOTM0Y2E0OTU5OTFiNzg1MmI4NTUw
MTAwMGIwMDIyMDAwYmRjZGI2OTRlMTAyZTEzYTBmYmE1MTExMDgxY2INCj4gNmNmNjE2YzExOGQ0
MDQ5MzZjYWMzZTg0ZGIyNGM3MWU0N2Q1MDAyMjAwMGIwNGI1ZGIxYWE1MjYzNWRmYjI0MmU3NmYN
Cj4gNmJkZThlMjE3NmFlNDhmYzY4Mjk0NmM2Yzc2ZDk2ZjYwODA3OWQxZjAwMDAwMDIwMzZiNmZj
Y2E4MjA2YzdmNzIyZGUNCj4gODU4MjFkN2VjYjQ3ODU5NzZmZGQ2NDJiYzc1Mzg1MDVhMmE4MThj
OGEyMzg4MDIxNDAwMDAwMDEwMDIwMmFlZGRlNDUNCj4gMDhmNTQ4ZDEwODE5M2VjOGZlMTY2YTdi
ZWZkZTE5MTEzZmU3MjdhZTJiMjk5MDFiZGVjZTk2ZTUNCj4gJCBrZXljdGwgY2xlYXIgQHUNCj4g
JCBrZXljdGwgbGlzdCBAdQ0KPiBrZXlyaW5nIGlzIGVtcHR5DQo+ICQga2V5Y3RsIGFkZCB0cnVz
dGVkIGttayAibG9hZCBgY2F0IGttay5ibG9iYCBrZXloYW5kbGU9MHg4MTAwMDAwMSINCj4gQHUN
Cj4gMTAyMjk2MzczMQ0KPiAkIGtleWN0bCBwcmludCAxMDIyOTYzNzMxDQo+IDAwN2YwMDIwZmY4
MDhiZDhiNzIzOTE5NGU4OWFhYzZhOTViNGQyMTAxMTQ3NDJjMjBhZmEzMzQ5M2YwMDJkZmZkMDY4
DQo+IDVkNTEwMDEwYzEyZDdhZDUxZWI4M2Q2ZDkzODk1ZGUwNjZiZjNkMzk3MThjYzUwM2FkYjQ4
MDJjYjA4N2I4OGIyZmZmDQo+IDRiMDQwZmUzYTJiZTZhM2Y4N2M2NzQ5ZDA4N2M5ZmI2ZTg3MzRj
YjIzZjQzOGQ2NDA4NzU4MWExM2JjODNkNWRjM2IwDQo+IDI2ZTc3YTg5NGVjZTY2MjBkMGViODVk
ZjY0NDlmZjNjNjA5ZmQ3N2Q1ZjBjYWY3OWI0NTM1YjAwMmUwMDA4MDAwYjAwDQo+IDAwMDA0MDAw
MDAwMDEwMDAyMDlhNWIwMGIwZDU1OGZjZjllOGMwMjk1MjI3MTVlNmI1OTA2MzY2ZWFlYzVmMzQz
NjdiDQo+IDhhYjE2YzBmYjkwMDlhMDA3MzAwMDAwMDAwMDAyMGUzYjBjNDQyOThmYzFjMTQ5YWZi
ZjRjODk5NmZiOTI0MjdhZTQxDQo+IGU0NjQ5YjkzNGNhNDk1OTkxYjc4NTJiODU1MDEwMDBiMDAy
MjAwMGJkY2RiNjk0ZTEwMmUxM2EwZmJhNTExMTA4MWNiDQo+IDZjZjYxNmMxMThkNDA0OTM2Y2Fj
M2U4NGRiMjRjNzFlNDdkNTAwMjIwMDBiMDRiNWRiMWFhNTI2MzVkZmIyNDJlNzZmDQo+IDZiZGU4
ZTIxNzZhZTQ4ZmM2ODI5NDZjNmM3NmQ5NmY2MDgwNzlkMWYwMDAwMDAyMDM2YjZmY2NhODIwNmM3
ZjcyMmRlDQo+IDg1ODIxZDdlY2I0Nzg1OTc2ZmRkNjQyYmM3NTM4NTA1YTJhODE4YzhhMjM4ODAy
MTQwMDAwMDAxMDAyMDJhZWRkZTQ1DQo+IDA4ZjU0OGQxMDgxOTNlYzhmZTE2NmE3YmVmZGUxOTEx
M2ZlNzI3YWUyYjI5OTAxYmRlY2U5NmU1DQo+IA0KPiAyLiBUaGUgZm9sbG93aW5nIGtlcm5lbCBm
aWxlIGlzIHJlbGF0ZWQgd2l0aCB0aGlzIHByb2JsZW0uIA0KPiAvc2VjdXJpdHkva2V5cy9rZXlj
dGwuYyAvc2VjdXJpdHkva2V5cy9rZXkuYyANCj4gL3NlY3VyaXR5L2tleXMvdHJ1c3RlZC1rZXlz
L3RydXN0ZWRfdHBtMS5jDQo+IC9zZWN1cml0eS9rZXlzL3RydXN0ZWQta2V5cy90cnVzdGVkX3Rw
bTIuYw0KPiANCj4gVG8gbG9hZCB0aGUgUENSIHBvbGljeSBwcm90ZWN0aW9uIHRydXN0ZWQga2V5
LCB0aGUgY2FsbCBzdGFjayBpczoNCj4gU1lTQ0FMTF9ERUZJTkU1KGFkZF9rZXksLi4uKSAtLT4g
a2V5X2NyZWF0ZV9vcl91cGRhdGUoKSAtLT4NCj4gX19rZXlfaW5zdGFudGlhdGVfYW5kX2xpbmso
KSAtLT4gIHRydXN0ZWRfaW5zdGFudGlhdGUoKSAtLT4NCj4gdHBtMl91bnNlYWxfdHJ1c3RlZCgp
IC0tPiB0cG0yX3Vuc2VhbF9jbWQoKS4NCj4gDQo+IENoZWNrIGRtZXNnLCB0aGVyZSB3aWxsIGJl
IGVycm9yOg0KPiBbNzMzMzYuMzUxNTk2XSB0cnVzdGVkX2tleToga2V5X3Vuc2VhbCBmYWlsZWQg
KC0xKQ0KDQpMaWtlIHRoZSBvdGhlciBrZXJuZWwgbWFpbGluZyBsaXN0cywgcGxlYXNlIGJvdHRv
bSBwb3N0LiDCoFdoZW4gcmVwb3J0aW5nIGEgcHJvYmxlbSwgcGxlYXNlIGluY2x1ZGUgdGhlIGtl
cm5lbCB2ZXJzaW9uIGFuZCBvdGhlciByZWxldmFudCBkZXRhaWxzLiDCoEZvciBleGFtcGxlLCB0
aGUgVFBNIHZlcnNpb24gYW5kIHR5cGUgKGVnLiBoYXJkd2FyZSB2ZW5kb3IsIHNvZnR3YXJlIFRQ
TSwgZXRjKS4gwqBQbGVhc2UgaW5kaWNhdGUgaWYgdGhpcyBpcyBhIG5ldyBwcm9ibGVtIGFuZCB3
aGljaCBrZXJuZWwgcmVsZWFzZSBpdCBmaXJzdCBzdGFydCBoYXBwZW5pbmc/DQoNCkkgaGF2ZSBu
byBleHBlcmllbmNlIHdpdGggdGhlIHRwbTJfIGNvbW1hbmRzLCDCoEkgc3VnZ2VzdCB0cnlpbmcg
dG8gZXh0ZW5kIGEgc2luZ2xlIG1lYXN1cmVtZW50IHRvIGEgUENSIGFuZCBzZWFsaW5nIHRvIHRo
YXQgdmFsdWUuDQoNCk1pbWkNCg0K
