Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1481C1D668D
	for <lists+linux-integrity@lfdr.de>; Sun, 17 May 2020 10:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgEQISz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 17 May 2020 04:18:55 -0400
Received: from mga14.intel.com ([192.55.52.115]:40981 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726982AbgEQISz (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 17 May 2020 04:18:55 -0400
IronPort-SDR: Ccl0c6SBDsCdYOKV73Wboa6zYrlEr/vkXt8ffLgnj/1tEzwO1nQ003bJ0oHCtCXZPGBT/VdDha
 o0JKGL5AN3YQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2020 01:18:54 -0700
IronPort-SDR: o2+kvvA3gE5+tRFGme8IQtu8j/BZnRjmFO2mwvzoHdvf5j7257JfC/MhoMau80W2y8Uxq1wCnF
 HKMRzq/BbfNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,402,1583222400"; 
   d="scan'208";a="267204236"
Received: from irsmsx102.ger.corp.intel.com ([163.33.3.155])
  by orsmga006.jf.intel.com with ESMTP; 17 May 2020 01:18:53 -0700
Received: from irsmsx606.ger.corp.intel.com (163.33.146.139) by
 IRSMSX102.ger.corp.intel.com (163.33.3.155) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 17 May 2020 09:18:52 +0100
Received: from irsmsx605.ger.corp.intel.com (163.33.146.138) by
 IRSMSX606.ger.corp.intel.com (163.33.146.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 17 May 2020 09:18:52 +0100
Received: from irsmsx605.ger.corp.intel.com ([163.33.146.138]) by
 IRSMSX605.ger.corp.intel.com ([163.33.146.138]) with mapi id 15.01.1713.004;
 Sun, 17 May 2020 09:18:52 +0100
From:   "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>
To:     "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
CC:     "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>
Subject: Re: [PATCH v9 4/8] security: keys: trusted: use ASN.1 TPM2 key format
 for the blobs
Thread-Topic: [PATCH v9 4/8] security: keys: trusted: use ASN.1 TPM2 key
 format for the blobs
Thread-Index: AQHWLCM0w4ZMJjuk0EGdrC/uJdSyM6ir3o2A
Date:   Sun, 17 May 2020 08:18:51 +0000
Message-ID: <742880c1bcbdd2ae116c049908bfe079619aed34.camel@intel.com>
References: <20200507231147.27025-1-James.Bottomley@HansenPartnership.com>
         <20200507231147.27025-5-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20200507231147.27025-5-James.Bottomley@HansenPartnership.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.252.40.19]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A07B6C3CD3855B4F88D4C64B2B15D907@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

T24gVGh1LCAyMDIwLTA1LTA3IGF0IDE2OjExIC0wNzAwLCBKYW1lcyBCb3R0b21sZXkgd3JvdGU6
DQo+IE1vZGlmeSB0aGUgVFBNMiBrZXkgZm9ybWF0IGJsb2Igb3V0cHV0IHRvIGV4cG9ydCBhbmQg
aW1wb3J0IGluIHRoZQ0KPiBBU04uMSBmb3JtIGZvciBUUE0yIHNlYWxlZCBvYmplY3Qga2V5cy4g
IEZvciBjb21wYXRpYmlsaXR5IHdpdGggcHJpb3INCj4gdHJ1c3RlZCBrZXlzLCB0aGUgaW1wb3J0
ZXIgd2lsbCBhbHNvIGFjY2VwdCB0d28gVFBNMkIgcXVhbnRpdGllcw0KPiByZXByZXNlbnRpbmcg
dGhlIHB1YmxpYyBhbmQgcHJpdmF0ZSBwYXJ0cyBvZiB0aGUga2V5LiAgSG93ZXZlciwgdGhlDQo+
IGV4cG9ydCB2aWEga2V5Y3RsIHBpcGUgd2lsbCBvbmx5IG91dHB1dCB0aGUgQVNOLjEgZm9ybWF0
Lg0KPiANCj4gVGhlIGJlbmVmaXQgb2YgdGhlIEFTTi4xIGZvcm1hdCBpcyB0aGF0IGl0J3MgYSBz
dGFuZGFyZCBhbmQgdGh1cyB0aGUNCj4gZXhwb3J0ZWQga2V5IGNhbiBiZSB1c2VkIGJ5IHVzZXJz
cGFjZSB0b29scyAob3BlbnNzbF90cG0yX2VuZ2luZSwNCj4gb3BlbmNvbm5lY3QgYW5kIHRwbTIt
dHNzLWVuZ2luZSkuICBUaGUgZm9ybWF0IGluY2x1ZGVzIHBvbGljeQ0KPiBzcGVjaWZpY2F0aW9u
cywgdGh1cyBpdCBnZXRzIHVzIG91dCBvZiBoYXZpbmcgdG8gY29uc3RydWN0IHBvbGljeQ0KPiBo
YW5kbGVzIGluIHVzZXJzcGFjZSBhbmQgdGhlIGZvcm1hdCBpbmNsdWRlcyB0aGUgcGFyZW50IG1l
YW5pbmcgeW91DQo+IGRvbid0IGhhdmUgdG8ga2VlcCBwYXNzaW5nIGl0IGluIGVhY2ggdGltZS4N
Cj4gDQo+IFRoaXMgcGF0Y2ggb25seSBpbXBsZW1lbnRzIGJhc2ljIGhhbmRsaW5nIGZvciB0aGUg
QVNOLjEgZm9ybWF0LCBzbw0KPiBrZXlzIHdpdGggcGFzc3dvcmRzIGJ1dCBubyBwb2xpY3kuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBKYW1lcyBCb3R0b21sZXkgPEphbWVzLkJvdHRvbWxleUBIYW5z
ZW5QYXJ0bmVyc2hpcC5jb20+DQoNClJldmlld2VkLWJ5OiBKYXJra28gU2Fra2luZW4gPGphcmtr
by5zYWtraW5lbkBsaW51eC5pbnRlbC5jb20+DQpUZXN0ZWQtYnk6IEphcmtrbyBTYWtraW5lbiA8
amFya2tvLnNha2tpbmVuQGxpbnV4LmludGVsLmNvbT4NCg0KL0phcmtrbw0K
