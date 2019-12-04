Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4077E112300
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Dec 2019 07:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfLDGjz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Dec 2019 01:39:55 -0500
Received: from mga11.intel.com ([192.55.52.93]:60765 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfLDGjy (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Dec 2019 01:39:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2019 22:39:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,276,1571727600"; 
   d="scan'208";a="236171027"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga004.fm.intel.com with ESMTP; 03 Dec 2019 22:39:54 -0800
Received: from fmsmsx154.amr.corp.intel.com (10.18.116.70) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 3 Dec 2019 22:39:53 -0800
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 FMSMSX154.amr.corp.intel.com (10.18.116.70) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 3 Dec 2019 22:39:53 -0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.109]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.214]) with mapi id 14.03.0439.000;
 Wed, 4 Dec 2019 14:39:51 +0800
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
Thread-Index: AdWZwFKzDBwFOydYTGGk+Aqs+6BIxAANhxEAAoxRZMAAOKaagABSSevwABZzFQAAgRP1kP//pW0A//9ftMCAAMH6gP//eLrAgACO1ID//3k2UAAqYIQA//8FitD//nrPAP/64XgQ//Y+3YD/68PYUA==
Date:   Wed, 4 Dec 2019 06:39:50 +0000
Message-ID: <A888B25CD99C1141B7C254171A953E8E4909E8B8@shsmsx102.ccr.corp.intel.com>
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
         <A888B25CD99C1141B7C254171A953E8E4909E399@shsmsx102.ccr.corp.intel.com>
         <1575312932.24227.13.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E4909E62E@shsmsx102.ccr.corp.intel.com>
         <1575342724.24227.41.camel@linux.ibm.com>
         <A888B25CD99C1141B7C254171A953E8E4909E877@shsmsx102.ccr.corp.intel.com>
 <1575430389.14163.27.camel@linux.ibm.com>
In-Reply-To: <1575430389.14163.27.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTcxOWVjYTMtN2VlYS00NmVjLTkwYTMtZWYxYzQ3ZmU4OWEyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiWURiU25iYSs0RmZ5Q3VwUG9LRUFwemtiQlwvMVRWUnRKeExrcVlKZEF4NW5WdUZMTXRwcWpsb2hra1U5Q2R6azMifQ==
x-ctpclassification: CTP_NT
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

T2gsIGdldCB5b3UsIEphbWVzLiANClVuZGVyc3RhbmQsIHRoYW5rcyBmb3IgeW91ciBmZWVkYmFj
ay4gDQpMb29raW5nIGZvcndhcmQgZm9yIHlvdXIgcHJvcG9zZWQgQVBJLiANCg0KLSBTaGlybGV5
IA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogSmFtZXMgQm90dG9tbGV5IDxq
ZWpiQGxpbnV4LmlibS5jb20+IA0KU2VudDogV2VkbmVzZGF5LCBEZWNlbWJlciA0LCAyMDE5IDEx
OjMzIEFNDQpUbzogWmhhbywgU2hpcmxleSA8c2hpcmxleS56aGFvQGludGVsLmNvbT47IE1pbWkg
Wm9oYXIgPHpvaGFyQGxpbnV4LmlibS5jb20+OyBKYXJra28gU2Fra2luZW4gPGphcmtrby5zYWtr
aW5lbkBsaW51eC5pbnRlbC5jb20+OyBKb25hdGhhbiBDb3JiZXQgPGNvcmJldEBsd24ubmV0Pg0K
Q2M6IGxpbnV4LWludGVncml0eUB2Z2VyLmtlcm5lbC5vcmc7IGtleXJpbmdzQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtZG9jQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgJ01hdXJvIENhcnZhbGhvIENoZWhhYicgPG1jaGVoYWIrc2Ftc3VuZ0BrZXJuZWwub3Jn
PjsgWmh1LCBCaW5nIDxiaW5nLnpodUBpbnRlbC5jb20+OyBDaGVuLCBMdWhhaSA8bHVoYWkuY2hl
bkBpbnRlbC5jb20+DQpTdWJqZWN0OiBSZTogT25lIHF1ZXN0aW9uIGFib3V0IHRydXN0ZWQga2V5
IG9mIGtleXJpbmcgaW4gTGludXgga2VybmVsLg0KDQpPbiBXZWQsIDIwMTktMTItMDQgYXQgMDM6
MDEgKzAwMDAsIFpoYW8sIFNoaXJsZXkgd3JvdGU6DQo+IEhpLCBKYW1lcywNCj4gDQo+IFVzaW5n
IHBvbGljeSBkaWdlc3QgdG8gcmVsb2FkIHRydXN0ZWQga2V5LCBkb2Vzbid0IHdvcmssIGVpdGhl
ci4gDQo+IFBsZWFzZSBjaGVjayB0aGUgc3RlcHMgYmVsb3cuIA0KPiBJIHRoaW5rIHBvbGljeSBk
aWdlc3Qgc2hvdWxkIGJlIGNhbGN1bGF0ZWQgYnkgVFBNIHdoZW4gdmVyaWZ5aW5nIHRoZSANCj4g
cG9saWN5IHRvIHJlbG9hZCBrZXkuDQoNCllvdSBtaXN1bmRlcnN0YW5kIG15IG1lYW5pbmc6IHRo
ZSBBUEkgd2UgaGF2ZSBub3cgZG9lc24ndCB3b3JrOyB0aGUga2V5IGJsb2IgdGhlIGtlcm5lbCBy
ZXR1cm5zIGN1cnJlbnRseSBhZnRlciBrZXkgY3JlYXRlIHdvbid0IHJlbG9hZCBiZWNhdXNlIGl0
IGNvbnRhaW5zIGV4dHJhbmVvdXMgZGF0YS4gIEkgd2FzIHByb3Bvc2luZyBhIHdvcmtpbmcgQVBJ
IEkgdGhvdWdodCBtaWdodCByZXBsYWNlIGl0LCBidXQgb2J2aW91c2x5IGl0IGhhcyB0byBiZSBj
b2RlZCB1cCBhbmQgYWNjZXB0ZWQgaW50byBhIGtlcm5lbCB2ZXJzaW9uIGJlZm9yZSB5b3UgY2Fu
IHVzZSBpdC4NCg0KSWYgeW91IHdhbnQgdG8gZ2V0IHRydXN0ZWQga2V5cyB3b3JraW5nIHRvZGF5
LCBJIHRoaW5rIHRoZSBUUE0gMS4yIEFQSSBzdGlsbCB3b3JrcyBpZiB5b3UgaGF2ZSBhIFRQTSAx
LjIgc3lzdGVtLg0KDQpKYW1lcw0KDQo=
