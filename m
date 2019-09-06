Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1531AB7EF
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Sep 2019 14:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391824AbfIFMQx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 Sep 2019 08:16:53 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:30186 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731749AbfIFMQx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Sep 2019 08:16:53 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x86C8ba8009176;
        Fri, 6 Sep 2019 14:16:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=k7X81TcO8CBiKa8vmOCGCKIHsezUow85BylAwFygC24=;
 b=hyGDkUqYUhY8wNpRHpS0dVq+k5CR1DsRZQFzW1141TvIfiC+XGhwl0pxG77BYkQ3LdPY
 Nr5GdQBbKseKIM6HT7ZNGVp5GSJTl/2p8KihXN0QcndvkWVP7tHt3khMvfUlOP9yaGku
 gQLz8W9uswHFaE46yaFiJ/lm9mlNwdDrd4sbxTU7dkMukC3u+lu8WZEnx5I8VmOCa0rc
 zmF5nPBpTcGei3oez4fUipJEDhWJFsdp3WwvImUqQAPOA93XGNtAY2LbmmVFCtwWrNPN
 LG0qQ/Zqyd6ftzEeCDb5zgxiNfpbrMHFDpzKIz2t30C83SLfYpMvWrafnVxWp6JQrpZu kw== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx07-00178001.pphosted.com with ESMTP id 2uqenvq203-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 06 Sep 2019 14:16:28 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9DA674D;
        Fri,  6 Sep 2019 12:16:23 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 82CEE2D78DA;
        Fri,  6 Sep 2019 14:16:22 +0200 (CEST)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 6 Sep
 2019 14:16:21 +0200
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Fri, 6 Sep 2019 14:16:21 +0200
From:   Benoit HOUYERE <benoit.houyere@st.com>
To:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        "Eyal.Cohen@nuvoton.com" <Eyal.Cohen@nuvoton.com>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "tmaimon77@gmail.com" <tmaimon77@gmail.com>
CC:     "oshrialkoby85@gmail.com" <oshrialkoby85@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "oshri.alkoby@nuvoton.com" <oshri.alkoby@nuvoton.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "gcwilson@us.ibm.com" <gcwilson@us.ibm.com>,
        "kgoldman@us.ibm.com" <kgoldman@us.ibm.com>,
        "nayna@linux.vnet.ibm.com" <nayna@linux.vnet.ibm.com>,
        "Dan.Morav@nuvoton.com" <Dan.Morav@nuvoton.com>,
        "oren.tanami@nuvoton.com" <oren.tanami@nuvoton.com>,
        "Christophe Ricard (christophe.ricard@gmail.com)" 
        <christophe.ricard@gmail.com>, Elena WILLIS <elena.willis@st.com>,
        "Olivier COLLART" <olivier.collart@st.com>
Subject: RE: [PATCH v2 0/2] char: tpm: add new driver for tpm i2c ptp
Thread-Topic: [PATCH v2 0/2] char: tpm: add new driver for tpm i2c ptp
Thread-Index: AQHVRv4ZSgWE27nyTEaW8YGKFQsC/6cexvSQ
Date:   Fri, 6 Sep 2019 12:16:21 +0000
Message-ID: <3f60b801f9684b939d93a4b900ff5d42@SFHDAG3NODE3.st.com>
References: <20190628151327.206818-1-oshrialkoby85@gmail.com>
 <8e6ca8796f229c5dc94355437351d7af323f0c56.camel@linux.intel.com>
 <79e8bfd2-2ed1-cf48-499c-5122229beb2e@infineon.com>
 <CAM9mBwJC2QD5-gV1eJUDzC2Fnnugr-oCZCoaH2sT_7ktFDkS-Q@mail.gmail.com>
 <45603af2fc8374a90ef9e81a67083395cc9c7190.camel@linux.intel.com>
 <6e7ff1b958d84f6e8e585fd3273ef295@NTILML02.nuvoton.com>
 <CAP6Zq1hPo9dG71YFyr7z9rjmi-DvoUZJOme4+2uqsfO+7nH+HQ@mail.gmail.com>
 <20190715094541.zjqxainggjuvjxd2@linux.intel.com>
 <9c8e216dbc4f43dbaa1701dc166b05e0@NTILML02.nuvoton.com>
 <548d3727-4a8f-38d4-2193-8a09cbae1e64@infineon.com>
 <2e86f1b6a3c04c9889d0f12f4eb079d4@SFHDAG3NODE3.st.com>
 <ef3e9f2f-9c8e-7cc1-dc4c-dc1833592238@infineon.com>
In-Reply-To: <ef3e9f2f-9c8e-7cc1-dc4c-dc1833592238@infineon.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-06_06:2019-09-04,2019-09-06 signatures=0
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

SGkgU3RlZmZlbiwNCg0KV2UgaGF2ZSBwZXJmb3JtZWQgdGVzdCBhZ2FpbnN0IHlvdXIgc2ltcGxl
IGltcGxlbWVudGF0aW9uLiBGb3IgYmFzaWMgdGVzdCBpdCB3YXMgb2ssIGhvd2V2ZXIgZm9yIHN0
cmVzcyB0ZXN0LCB5b3VyIGltcGxlbWVudGF0aW9uIGRvZXMgbm90IHRha2UgaW4gYWNjb3VudCBO
QUNLIGFuZCBpdCBmYWlsZWQuDQoNCkluIFBUUCBkb2N1bWVudCwgaW4gY2hhcHRlcjcuMi4yLjEu
MiAoUmVnaXN0ZXIgd3JpdGUgd2l0aCBhZGRyZXNzIE5BQ0spLCBpdCBpbmRpY2F0ZXMgOiAiaXQn
cyBhIGdvb2QgcHJhY3RpY2UgdG8gcmVwZWF0IHRoZSBjdXJyZW50IGN5Y2xlIHVzaW5nIHRoZSBj
b3JyZWN0IEkyQyBkZXZpY2UgYWRkcmVzcyIuDQoNCkluIG90aGVyIGltcGxlbWVudGF0aW9uLCAN
Cmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvODYyODY4MS8NCg0KdHBtX3Rpc19p
MmNfcmVhZF9ieXRlcyBhbmQgdHBtX3Rpc19pMmNfd3JpdGVfYnl0ZXMgaGFuZGxlIE5BQ0sgd2l0
aCBhIGZvciBsb29wLg0KDQorCWZvciAoaSA9IDA7IGkgPCBUUE1fUkVUUlkgJiYgcmV0IDwgMDsg
aSsrKSB7DQorCQl0cG1fdGlzX2kyY19zbGVlcF9ndWFyZF90aW1lKHBoeSwgVFBNX0kyQ19TRU5E
KTsNCisJCXJldCA9IGkyY19tYXN0ZXJfc2VuZChwaHktPmNsaWVudCwgJmkyY19yZWcsIDEpOw0K
KwkJbW9kX3RpbWVyKCZwaHktPmd1YXJkX3RpbWVyLCBwaHktPmd1YXJkX3RpbWUpOw0KKwl9DQor
DQorCWlmIChyZXQgPCAwKQ0KKwkJZ290byBleGl0Ow0KKw0KKwlyZXQgPSAtMTsNCisJZm9yIChp
ID0gMDsgaSA8IFRQTV9SRVRSWSAmJiByZXQgPCAwOyBpKyspIHsNCisJCXRwbV90aXNfaTJjX3Ns
ZWVwX2d1YXJkX3RpbWUocGh5LCBUUE1fSTJDX1JFQ1YpOw0KKwkJcmV0ID0gaTJjX21hc3Rlcl9y
ZWN2KHBoeS0+Y2xpZW50LCByZXN1bHQsIGxlbiAqIHNpemUpOw0KKwkJbW9kX3RpbWVyKCZwaHkt
Pmd1YXJkX3RpbWVyLCBwaHktPmd1YXJkX3RpbWUpOw0KKwl9DQoNCkkgdGhpbmsgdGhhdCB3ZSBz
aG91bGQgaW1wbGVtZW50IGl0IGJlZm9yZSB0byBpbmNsdWRlIHRwbV90aXNfaTJjLmMgb2ZmaWNp
YWxseS4NCg0KVGhhbmtzIGluIGFkdmFuY2UsDQoNCkJlc3QgUmVnYXJkcywNCg0KQmVub2l0DQoN
Ci0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBBbGV4YW5kZXIgU3RlZmZlbiA8QWxl
eGFuZGVyLlN0ZWZmZW5AaW5maW5lb24uY29tPiANClNlbnQ6IG1hcmRpIDMwIGp1aWxsZXQgMjAx
OSAxOTo0Mg0KVG86IEJlbm9pdCBIT1VZRVJFIDxiZW5vaXQuaG91eWVyZUBzdC5jb20+OyBFeWFs
LkNvaGVuQG51dm90b24uY29tOyBqYXJra28uc2Fra2luZW5AbGludXguaW50ZWwuY29tOyB0bWFp
bW9uNzdAZ21haWwuY29tDQpDYzogb3NocmlhbGtvYnk4NUBnbWFpbC5jb207IHJvYmgrZHRAa2Vy
bmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207IHBldGVyaHVld2VAZ214LmRlOyBqZ2dAemll
cGUuY2E7IGFybmRAYXJuZGIuZGU7IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBvc2hyaS5h
bGtvYnlAbnV2b3Rvbi5jb207IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1pbnRlZ3JpdHlAdmdlci5rZXJuZWwub3JnOyBnY3dp
bHNvbkB1cy5pYm0uY29tOyBrZ29sZG1hbkB1cy5pYm0uY29tOyBuYXluYUBsaW51eC52bmV0Lmli
bS5jb207IERhbi5Nb3JhdkBudXZvdG9uLmNvbTsgb3Jlbi50YW5hbWlAbnV2b3Rvbi5jb207IENo
cmlzdG9waGUgUmljYXJkIChjaHJpc3RvcGhlLnJpY2FyZEBnbWFpbC5jb20pIDxjaHJpc3RvcGhl
LnJpY2FyZEBnbWFpbC5jb20+OyBFbGVuYSBXSUxMSVMgPGVsZW5hLndpbGxpc0BzdC5jb20+OyBP
bGl2aWVyIENPTExBUlQgPG9saXZpZXIuY29sbGFydEBzdC5jb20+DQpTdWJqZWN0OiBSZTogW1BB
VENIIHYyIDAvMl0gY2hhcjogdHBtOiBhZGQgbmV3IGRyaXZlciBmb3IgdHBtIGkyYyBwdHANCg0K
SGkgQmVub2l0LA0KDQpnb29kIHRvIHNlZSB5b3UncmUgc3RpbGwgYXJvdW5kLg0KDQpPbiAzMC4w
Ny4yMDE5IDEwOjM5LCBCZW5vaXQgSE9VWUVSRSB3cm90ZToNCj4gSGkgQWxleGFuZGVyLCBKYXJr
a28gYW5kIEV5YWwsDQo+IA0KPiBBIGZpcnN0IEkyQyBUQ0cgcGF0Y2ggKHRwbV90aXNfaTJjLmMp
IGhhcyBiZWVuIHByb3Bvc2VkIGluIHRoZSBzYW1lIHRpbWUgYXMgdHBtX3Rpc19zcGkuYyBieSBD
aHJpc3RvcGhlIDMgeWVhcnMgYWdvLg0KPiANCj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9y
Zy9wYXRjaC84NjI4NjgxLw0KDQpUaGFua3MgZm9yIG1lbnRpb25pbmcgdGhpcy4gSSBmb3Jnb3Qg
aXQgZXhpc3RzLCBzaW5jZSBpdCB3YXMgc3RpbGwgb24gdGhlIG9sZCBtYWlsaW5nIGxpc3QuDQoN
Cj4gQXQgdGhlIHRpbWUsIHdlIGhhdmUgaGFkIHR3byBjb25jZXJucyA6DQo+IAkxKSBJMkMgVFBN
IGNvbXBvbmVudCBudW1iZXIsIGluIHRoZSBtYXJrZXQsIGNvbXBsaWFudCB3aXRoIG5ldyBJMkMg
VENHIHNwZWNpZmljYXRpb24gdG8gdmFsaWRhdGUgbmV3IEkyQyBkcml2ZXIuDQo+IAkyKSBMb3Rz
IGNoYW5naW5nICB3YXMgYWxyZWFkeSBwcm92aWRlZCBieSB0cG1fdGlzX3NwaS5jIG9uIDQuOC4N
Cj4gDQo+IFRoYXQncyB3aHkgVHBtX3Rpc19pMmMuYyBoYXMgYmVlbiBwb3N0cG9uZWQuDQo+IA0K
PiBUcG1fdGlzX3NwaSBMaW51eCBkcml2ZXIgaXMgbm93IHJvYnVzdCwgaWYgd2UgaGF2ZSBzZXZl
cmFsIGRpZmZlcmVudCBJMkMgVFBNIHNvbHV0aW9ucyB0b2RheSB0byB2YWxpZGF0ZSBhIHRwbV90
aXNfaTJjIGRyaXZlciwgSSAnbSByZWFkeSB0byBjb250cmlidXRlIHRvIGl0IGZvciB2YWxpZGF0
aW9uIChTVG1pY3JvIFRQTSkgb3IgcHJvcG9zZSBhIHNvbHV0aW9uIGNvbXBhdGlibGUgb24gNS4x
IGxpbnV4IGRyaXZlciBpZiBuZWVkZWQgdW5kZXIgdGltZWZyYW1lIHByb3Bvc2VkIChzZWNvbmQg
aGFsZiBvZiBhdWd1c3QpLg0KDQpDb3VsZCB5b3UgcnVuIHlvdXIgdGVzdHMgYWdhaW5zdCB0aGUg
c2ltcGxlIGltcGxlbWVudGF0aW9uIHRoYXQgSSBwb3N0ZWQgYSB3aGlsZSBhZ28gKGh0dHBzOi8v
cGF0Y2h3b3JrLmtlcm5lbC5vcmcvY292ZXIvMTEwNDkzNjUvKSBhbmQgcHJvdmlkZSB5b3VyIGZl
ZWRiYWNrPyBTaW5jZSBpdCBpcyBhbHJlYWR5IGJhc2VkIG9uIHRoZSBjdXJyZW50IHRwbV90aXNf
Y29yZSwgaXQgaXMgcHJvYmFibHkgZWFzaWVyIHRvIGludGVncmF0ZSBuZWNlc3NhcnkgY2hhbmdl
cyB0aGVyZS4NCg0KQnkgdGhlIHdheSwgaGFzIGl0IGdvdHRlbiBhbnkgZWFzaWVyIGluIHRoZSBt
ZWFudGltZSB0byBnZXQgaG9sZCBvZiB5b3VyIFRQTXMgdG8gdXNlIHRoZW0gZm9yIGtlcm5lbCB0
ZXN0cz8NCg0KQWxleGFuZGVyDQo=
