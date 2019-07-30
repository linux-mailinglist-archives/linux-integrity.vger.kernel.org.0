Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 893CE7A33D
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Jul 2019 10:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfG3IlS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Jul 2019 04:41:18 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:21960 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726255AbfG3IlR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Jul 2019 04:41:17 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6U8atZj025754;
        Tue, 30 Jul 2019 10:39:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=kkYVmzU2G79MWlienOnwLFNq3rDtebO7lrkP/5ufdRE=;
 b=A8j/4p7vPntTeJcf5GkehS8rNDbwm4/v1lx8QLR/TU59xoHRZlUYbGz7in196He7aS2A
 OB1UrOC18FxZhlfimyFg3cT8Has8ahHDs/SZSQIebZcdYSTxblEE6ETwIJ4ZhVp2qnGy
 GDWQ/6rb/fVS+Fj/2OJ4TZwFxoCu7KdvA2iECdIr7Sm8ZvQ3A8iz6DCC522fHIDl3RO8
 Ejhc9S8zzBiKosdjmf9foGY4IHIMnS0vyP8GkxftYztWXiAns5rNBvI6CyCS2FhkL+un
 W8dl9mQREuerUfn72GrxHywifo1Q0iUB1JHt7aQwXL0WlwFPOJqvJJP03s6hRddp07eM nw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2u0c2y9949-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 30 Jul 2019 10:39:38 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5E47438;
        Tue, 30 Jul 2019 08:39:36 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 09FBB16A1;
        Tue, 30 Jul 2019 08:39:36 +0000 (GMT)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jul
 2019 10:39:35 +0200
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Tue, 30 Jul 2019 10:39:35 +0200
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
Thread-Index: AQHVPYumSgWE27nyTEaW8YGKFQsC/6bi0PyQ
Date:   Tue, 30 Jul 2019 08:39:35 +0000
Message-ID: <2e86f1b6a3c04c9889d0f12f4eb079d4@SFHDAG3NODE3.st.com>
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
In-Reply-To: <548d3727-4a8f-38d4-2193-8a09cbae1e64@infineon.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-30_04:,,
 signatures=0
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

SGkgQWxleGFuZGVyLCBKYXJra28gYW5kIEV5YWwsDQoNCkEgZmlyc3QgSTJDIFRDRyBwYXRjaCAo
dHBtX3Rpc19pMmMuYykgaGFzIGJlZW4gcHJvcG9zZWQgaW4gdGhlIHNhbWUgdGltZSBhcyB0cG1f
dGlzX3NwaS5jIGJ5IENocmlzdG9waGUgMyB5ZWFycyBhZ28uDQoNCmh0dHBzOi8vcGF0Y2h3b3Jr
Lmtlcm5lbC5vcmcvcGF0Y2gvODYyODY4MS8NCg0KQXQgdGhlIHRpbWUsIHdlIGhhdmUgaGFkIHR3
byBjb25jZXJucyA6DQoJMSkgSTJDIFRQTSBjb21wb25lbnQgbnVtYmVyLCBpbiB0aGUgbWFya2V0
LCBjb21wbGlhbnQgd2l0aCBuZXcgSTJDIFRDRyBzcGVjaWZpY2F0aW9uIHRvIHZhbGlkYXRlIG5l
dyBJMkMgZHJpdmVyLg0KCTIpIExvdHMgY2hhbmdpbmcgIHdhcyBhbHJlYWR5IHByb3ZpZGVkIGJ5
IHRwbV90aXNfc3BpLmMgb24gNC44Lg0KDQpUaGF0J3Mgd2h5IFRwbV90aXNfaTJjLmMgaGFzIGJl
ZW4gcG9zdHBvbmVkLg0KDQpUcG1fdGlzX3NwaSBMaW51eCBkcml2ZXIgaXMgbm93IHJvYnVzdCwg
aWYgd2UgaGF2ZSBzZXZlcmFsIGRpZmZlcmVudCBJMkMgVFBNIHNvbHV0aW9ucyB0b2RheSB0byB2
YWxpZGF0ZSBhIHRwbV90aXNfaTJjIGRyaXZlciwgSSAnbSByZWFkeSB0byBjb250cmlidXRlIHRv
IGl0IGZvciB2YWxpZGF0aW9uIChTVG1pY3JvIFRQTSkgb3IgcHJvcG9zZSBhIHNvbHV0aW9uIGNv
bXBhdGlibGUgb24gNS4xIGxpbnV4IGRyaXZlciBpZiBuZWVkZWQgdW5kZXIgdGltZWZyYW1lIHBy
b3Bvc2VkIChzZWNvbmQgaGFsZiBvZiBhdWd1c3QpLg0KDQpCZXN0IFJlZ2FyZHMsDQoNCkJlbm9p
dA0KDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGxpbnV4LWludGVncml0
eS1vd25lckB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWludGVncml0eS1vd25lckB2Z2VyLmtlcm5l
bC5vcmc+IE9uIEJlaGFsZiBPZiBBbGV4YW5kZXIgU3RlZmZlbg0KU2VudDogamV1ZGkgMTgganVp
bGxldCAyMDE5IDE5OjEwDQpUbzogRXlhbC5Db2hlbkBudXZvdG9uLmNvbTsgamFya2tvLnNha2tp
bmVuQGxpbnV4LmludGVsLmNvbTsgdG1haW1vbjc3QGdtYWlsLmNvbQ0KQ2M6IG9zaHJpYWxrb2J5
ODVAZ21haWwuY29tOyByb2JoK2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOyBw
ZXRlcmh1ZXdlQGdteC5kZTsgamdnQHppZXBlLmNhOyBhcm5kQGFybmRiLmRlOyBncmVna2hAbGlu
dXhmb3VuZGF0aW9uLm9yZzsgb3NocmkuYWxrb2J5QG51dm90b24uY29tOyBkZXZpY2V0cmVlQHZn
ZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtaW50ZWdy
aXR5QHZnZXIua2VybmVsLm9yZzsgZ2N3aWxzb25AdXMuaWJtLmNvbTsga2dvbGRtYW5AdXMuaWJt
LmNvbTsgbmF5bmFAbGludXgudm5ldC5pYm0uY29tOyBEYW4uTW9yYXZAbnV2b3Rvbi5jb207IG9y
ZW4udGFuYW1pQG51dm90b24uY29tDQpTdWJqZWN0OiBSZTogW1BBVENIIHYyIDAvMl0gY2hhcjog
dHBtOiBhZGQgbmV3IGRyaXZlciBmb3IgdHBtIGkyYyBwdHANCg0KT24gMTguMDcuMjAxOSAxNDo1
MSwgRXlhbC5Db2hlbkBudXZvdG9uLmNvbSB3cm90ZToNCj4gSGkgSmFya2tvIGFuZCBBbGV4YW5k
ZXIsDQo+IA0KPiBXZSBoYXZlIG1hZGUgYW4gYWRkaXRpb25hbCBjb2RlIHJldmlldyBvbiB0aGUg
VFBNIFRJUyBjb3JlIGRyaXZlciwgaXQgbG9va3MgcXVpdGUgZ29vZCBhbmQgd2UgY2FuIGNvbm5l
Y3Qgb3VyIG5ldyBJMkMgZHJpdmVyIHRvIHRoaXMgbGF5ZXIuDQoNCkdyZWF0IDopIEluIHRoZSBt
ZWFudGltZSwgSSd2ZSBkb25lIHNvbWUgZXhwZXJpbWVudHMgY3JlYXRpbmcgYW4gSTJDIGRyaXZl
ciBiYXNlZCBvbiB0cG1fdGlzX2NvcmUsIHNlZSBodHRwczovL3BhdGNod29yay5rZXJuZWwub3Jn
L3BhdGNoLzExMDQ5MzYzLyBQbGVhc2UgaGF2ZSBhIGxvb2sgYXQgdGhhdCBhbmQgcHJvdmlkZSB5
b3VyIGZlZWRiYWNrIChhbmQvb3IgdXNlIGl0IGFzIGEgYmFzaXMgZm9yIGZ1cnRoZXIgaW1wbGVt
ZW50YXRpb25zKS4NCg0KPiBIb3dldmVyLCB0aGVyZSBhcmUgc2V2ZXJhbCBkaWZmZXJlbmNlcyBi
ZXR3ZWVuIHRoZSBTUEkgaW50ZXJmYWNlIGFuZCB0aGUgSTJDIGludGVyZmFjZSB0aGF0IHdpbGwg
cmVxdWlyZSBjaGFuZ2VzIHRvIHRoZSBUSVMgY29yZS4NCj4gQXQgYSBtaW5pbXVtIHdlIHRob3Vn
aHQgb2Y6DQo+IDEuIEhhbmRsaW5nIFRQTSBMb2NhbGl0aWVzIGluIEkyQyBpcyBkaWZmZXJlbnQN
Cg0KSXQgdHVybmVkIG91dCBub3QgdG8gYmUgdGhhdCBkaWZmZXJlbnQgaW4gdGhlIGVuZCwgc2Vl
IHRoZSBjb2RlIG1lbnRpb25lZCBhYm92ZSBhbmQgbXkgY29tbWVudCBoZXJlOiANCmh0dHBzOi8v
cGF0Y2h3b3JrLmtlcm5lbC5vcmcvY292ZXIvMTEwNDkzNjUvDQoNCj4gMi4gSGFuZGxpbmcgSTJD
IENSQyAtIHJlbGV2YW50IG9ubHkgdG8gSTJDIGJ1cyBoZW5jZSBub3Qgc3VwcG9ydGVkIA0KPiB0
b2RheSBieSBUSVMgY29yZQ0KDQpUaGF0IGlzIGNvbXBsZXRlbHkgb3B0aW9uYWwsIHNvIHRoZXJl
IGlzIG5vIG5lZWQgdG8gaW1wbGVtZW50IGl0IGluIHRoZSBiZWdpbm5pbmcuIEFsc28sIGRvIHlv
dSBleHBlY3QgYSBodWdlIGJlbmVmaXQgZnJvbSB0aGF0IGZ1bmN0aW9uYWxpdHk/IA0KQXJlIGJp
dCBmbGlwcyB0aGF0IG11Y2ggbW9yZSBsaWtlbHkgb24gSTJDIGNvbXBhcmVkIHRvIFNQSSwgd2hp
Y2ggaGFzIG5vIENSQyBhdCBhbGwsIGJ1dCBzdGlsbCB3b3JrcyBmaW5lPw0KDQo+IDMuIEhhbmRs
aW5nIENoaXAgc3BlY2lmaWMgaXNzdWVzLCBzaW5jZSBJMkMgaW1wbGVtZW50YXRpb24gbWlnaHQg
YmUgDQo+IHNsaWdodGx5IGRpZmZlcmVudCBhY3Jvc3MgdGhlIHZhcmlvdXMgVFBNIHZlbmRvcnMN
Cg0KUmlnaHQsIHRoYXQgc2VlbXMgc2ltaWxhciB0byB0aGUgY3I1MCBpc3N1ZXMgKGh0dHBzOi8v
bGttbC5vcmcvbGttbC8yMDE5LzcvMTcvNjc3KSwgc28gdGhlcmUgc2hvdWxkIHByb2JhYmx5IGJl
IGEgc2ltaWxhciB3YXkgdG8gZG8gaXQuDQoNCj4gNC4gTW9kaWZ5IHRwbV90aXNfc2VuZF9kYXRh
IGFuZCB0cG1fdGlzX3JlY3ZfZGF0YSB0byB3b3JrIGFjY29yZGluZyANCj4gdGhlIFRDRyBEZXZp
Y2UgRHJpdmVyIEd1aWRlIChvcHRpbWl6YXRpb24gb24gVFBNX1NUUyBhY2Nlc3MgYW5kIA0KPiBz
ZW5kL3JlY3YgcmV0cnkpDQoNCk9wdGltaXphdGlvbnMgYXJlIGFsd2F5cyB3ZWxjb21lLCBidXQg
SSdkIGV4cGVjdCBiYXNpYyBjb21tdW5pY2F0aW9uIHRvIHdvcmsgYWxyZWFkeSB3aXRoIHRoZSBj
dXJyZW50IGNvZGUgKHRob3VnaCBtYXliZSBub3QgYXMgZWZmaWNpZW50bHkgYXMgcG9zc2libGUp
Lg0KDQo+IEJlc2lkZXMgdGhpcywgZHVyaW5nIGRldmVsb3BtZW50IHdlIG1pZ2h0IGVuY291bnRl
ciBhZGRpdGlvbmFsIGRpZmZlcmVuY2VzIGJldHdlZW4gU1BJIGFuZCBJMkMuDQo+IA0KPiBXZSBj
dXJyZW50bHkgdGFyZ2V0IHRvIGFsbG9jYXRlIGFuIGVuZy4gdG8gd29yayBvbiB0aGlzIG9uIHRo
ZSBzZWNvbmQgaGFsZiBvZiBBdWd1c3Qgd2l0aCBhIGdvYWwgdG8gaGF2ZSB0aGUgZHJpdmVyIHJl
YWR5IGZvciB0aGUgbmV4dCBrZXJuZWwgbWVyZ2Ugd2luZG93Lg0KPiANCj4gUmVnYXJkcywNCj4g
RXlhbC4NCg==
