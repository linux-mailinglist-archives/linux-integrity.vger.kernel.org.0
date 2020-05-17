Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69DF91D668B
	for <lists+linux-integrity@lfdr.de>; Sun, 17 May 2020 10:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgEQIRx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 17 May 2020 04:17:53 -0400
Received: from mga01.intel.com ([192.55.52.88]:58790 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726982AbgEQIRw (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 17 May 2020 04:17:52 -0400
IronPort-SDR: X4tb/vKMrnDb/up8r0l1vNwe8kHWxiO/O6146SMZzw8eCqBnMR2RDN0j7f0rFW+rfIVmA2vUC7
 q0PDcqOjVBgQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2020 01:17:52 -0700
IronPort-SDR: XvpyftoUBL4VNNQlP2Ptk49BgneHdFBB3a5XoVP/r0o96vH7cD8yfayQSYigVRolM5leuviZ1Z
 l8Vt9ndqVMxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,402,1583222400"; 
   d="scan'208";a="281680173"
Received: from irsmsx107.ger.corp.intel.com ([163.33.3.99])
  by orsmga002.jf.intel.com with ESMTP; 17 May 2020 01:17:50 -0700
Received: from irsmsx603.ger.corp.intel.com (163.33.146.9) by
 IRSMSX107.ger.corp.intel.com (163.33.3.99) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 17 May 2020 09:17:49 +0100
Received: from irsmsx605.ger.corp.intel.com (163.33.146.138) by
 irsmsx603.ger.corp.intel.com (163.33.146.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 17 May 2020 09:17:49 +0100
Received: from irsmsx605.ger.corp.intel.com ([163.33.146.138]) by
 IRSMSX605.ger.corp.intel.com ([163.33.146.138]) with mapi id 15.01.1713.004;
 Sun, 17 May 2020 09:17:49 +0100
From:   "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>
To:     "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
CC:     "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>
Subject: Re: [PATCH v9 1/8] lib: add ASN.1 encoder
Thread-Topic: [PATCH v9 1/8] lib: add ASN.1 encoder
Thread-Index: AQHWLCMzaVc35X/kI0Sfm7Wx23x2nqir3kIA
Date:   Sun, 17 May 2020 08:17:49 +0000
Message-ID: <49e454ea4fbcf53962d62f806a77497d9f0c6c0d.camel@intel.com>
References: <20200507231147.27025-1-James.Bottomley@HansenPartnership.com>
         <20200507231147.27025-2-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20200507231147.27025-2-James.Bottomley@HansenPartnership.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.252.40.19]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3910F01A7A8654C928C1281CE83F4FF@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

T24gVGh1LCAyMDIwLTA1LTA3IGF0IDE2OjExIC0wNzAwLCBKYW1lcyBCb3R0b21sZXkgd3JvdGU6
DQo+IFdlIGhhdmUgYSBuZWVkIGluIHRoZSBUUE0yIHRydXN0ZWQga2V5cyB0byByZXR1cm4gdGhl
IEFTTi4xIGZvcm0gb2YNCj4gdGhlIFRQTSBrZXkgYmxvYiBzbyBpdCBjYW4gYmUgb3BlcmF0ZWQg
b24gYnkgdG9vbHMgb3V0c2lkZSBvZiB0aGUNCj4ga2VybmVsLiAgVGhlIHNwZWNpZmljIHRvb2xz
IGFyZSB0aGUgb3BlbnNzbF90cG0yX2VuZ2luZSwgb3BlbmNvbm5lY3QNCj4gYW5kIHRoZSBJbnRl
bCB0cG0yLXRzcy1lbmdpbmUuICBUbyBkbyB0aGF0LCB3ZSBoYXZlIHRvIGJlIGFibGUgdG8gcmVh
ZA0KPiBhbmQgd3JpdGUgdGhlIHNhbWUgYmluYXJ5IGtleSBmb3JtYXQgdGhlIHRvb2xzIHVzZS4g
IFRoZSBjdXJyZW50IEFTTi4xDQo+IGRlY29kZXIgZG9lcyBmaW5lIGZvciByZWFkaW5nLCBidXQg
d2UgbmVlZCBwaWVjZXMgb2YgYW4gQVNOLjEgZW5jb2Rlcg0KPiB0byB3cml0ZSB0aGUga2V5IGJs
b2IgaW4gYmluYXJ5IGNvbXBhdGlibGUgZm9ybS4NCj4gDQo+IEZvciBiYWNrd2FyZHMgY29tcGF0
aWJpbGl0eSwgdGhlIHRydXN0ZWQga2V5IHJlYWRlciBjb2RlIHdpbGwgc3RpbGwNCj4gYWNjZXB0
IHRoZSB0d28gVFBNMkIgcXVhbnRpdGllcyB0aGF0IGl0IHVzZXMgdG9kYXksIGJ1dCB0aGUgd3Jp
dGVyDQo+IHdpbGwgb25seSBvdXRwdXQgdGhlIEFTTi4xIGZvcm0uDQo+IA0KPiBUaGUgY3VycmVu
dCBpbXBsZW1lbnRhdGlvbiBvbmx5IGVuY29kZXMgdGhlIEFTTi4xIGJpdHMgd2UgYWN0dWFsbHkg
bmVlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEphbWVzIEJvdHRvbWxleSA8SmFtZXMuQm90dG9t
bGV5QEhhbnNlblBhcnRuZXJzaGlwLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEphcmtrbyBTYWtraW5l
biA8amFya2tvLnNha2tpbmVuQGxpbnV4LmludGVsLmNvbT4NCg0KVGVzdGVkLWJ5OiBKYXJra28g
U2Fra2luZW4gPGphcmtrby5zYWtraW5lbkBsaW51eC5pbnRlbC5jb20+DQoNCi9KYXJra28NCg==
