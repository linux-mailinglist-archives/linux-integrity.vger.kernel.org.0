Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E99066EF0
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Jul 2019 14:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfGLMmF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Jul 2019 08:42:05 -0400
Received: from mx0b-00176a03.pphosted.com ([67.231.157.48]:31880 "EHLO
        mx0a-00176a03.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727276AbfGLMmE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Jul 2019 08:42:04 -0400
Received: from pps.filterd (m0048204.ppops.net [127.0.0.1])
        by m0048204.ppops.net-00176a03. (8.16.0.27/8.16.0.27) with SMTP id x6CCdoYf043010
        for <linux-integrity@vger.kernel.org>; Fri, 12 Jul 2019 08:42:02 -0400
From:   "Safford, David (GE Global Research, US)" <david.safford@ge.com>
To:     Matthew Garrett <mjg59@google.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "Wiseman, Monty (GE Global Research, US)" <monty.wiseman@ge.com>
Thread-Topic: Re: [PATCH] tpm_crb - workaround broken ACPI tables
Thread-Index: AdU34krwvcnCVlC5RnKeY3i0fswIjwAOGIMAAAVMYtAAAspvgAAHp5Mg///fewD//z0RQA==
Date:   Fri, 12 Jul 2019 12:41:58 +0000
Message-ID: <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7E2A@ALPMBAPA12.e2k.ad.ge.com>
References: <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7BC7@ALPMBAPA12.e2k.ad.ge.com>
 <20190711145850.GC25807@ziepe.ca>
 <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7C56@ALPMBAPA12.e2k.ad.ge.com>
 <20190711185027.GG25807@ziepe.ca>
 <BCA04D5D9A3B764C9B7405BBA4D4A3C035EF7CFE@ALPMBAPA12.e2k.ad.ge.com>
 <CACdnJutS4-N0GgtYPy9GGJ8dVf48VZGF5AFL2raB55bSPKUpNw@mail.gmail.com>
In-Reply-To: <CACdnJutS4-N0GgtYPy9GGJ8dVf48VZGF5AFL2raB55bSPKUpNw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcMjEyNDczOTUwXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNmVmNDZkNWEtYTRhMi0xMWU5LThkZmUtYTRjM2YwYjU5OGE2XGFtZS10ZXN0XDZlZjQ2ZDViLWE0YTItMTFlOS04ZGZlLWE0YzNmMGI1OThhNmJvZHkudHh0IiBzej0iMjU2OSIgdD0iMTMyMDc0MDg5MTc2MDIwOTcwIiBoPSJUbDBoWnZQbXFKV0hDK210c3pTb2VDc2ZPTVU9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: 
x-originating-ip: [3.159.19.191]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [PATCH] tpm_crb - workaround broken ACPI tables
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-12_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907120137
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

DQo+IFRoZSBpc3N1ZSBpcyB0aGF0IHRoZSBDUkIgcmVnaW9uIGlzIG1hcHBlZCBpbnRvIGEgcmVn
aW9uIG1hcmtlZCBhcyBBQ1BJIE5WUy4NCj4gZHJpdmVycy9hY3BpL252cy5jIGNsYWltcyB0aGlz
IHJlZ2lvbiBhbmQgYXMgYSByZXN1bHQgYSByZXNvdXJjZSBjb25mbGljdCBpcw0KPiBnZW5lcmF0
ZWQuIFNpbmNlIFdpbmRvd3MgaXMgY2xlYXJseSBmaW5lIHdpdGggb3RoZXIgZHJpdmVycyB1c2lu
ZyBBQ1BJIE5WUw0KPiByZWdpb25zLCB0aGUgY29ycmVjdCBmaXggaW52b2x2ZXMgZmlndXJpbmcg
b3V0IGEgd2F5IHRvIGVpdGhlciBzaGFyZSB0aGVzZQ0KPiByZXNvdXJjZXMgb3IgYWxsb3cgdHBt
X2NyYiB0byByZWNsYWltIHRoZSByZWdpb24gZnJvbSB0aGUgTlZTIGRyaXZlci4gTm90ZQ0KPiB0
aGF0IHRoZSBOVlMgZHJpdmVyJ3MgYmVoYXZpb3VyIGlzIHRvIHNhdmUgYW5kIHJlc3RvcmUgTlZT
IHJlZ2lvbnMgb3Zlcg0KPiBzdXNwZW5kL3Jlc3VtZSwgc28gc2ltcGx5IGZvcmNpYmx5IGFsbG9j
YXRpbmcgdGhlIHJlc291cmNlIHdpbGwgcmVzdWx0IGluIHR3bw0KPiBzZXBhcmF0ZSBjb2RlcGF0
aHMgdG91Y2hpbmcgdGhlIHJlZ2lvbiBvbiByZXN1bWUgLSB0aGlzIHNlZW1zIGxpa2UgYSBiYWQN
Cj4gb3V0Y29tZS4gSWRlYWxseSB0aGlzIGNvdWxkIGJlIHNvbHZlZCBnZW5lcmljYWxseSwgYnV0
IHByYWN0aWNhbGx5IChnaXZlbiB3ZSd2ZQ0KPiBvbmx5IHNlZW4gdGhpcyBhcm91bmQgVFBNcywg
YXMgZmFyIGFzIEkgY2FuIHRlbGwpIGFkZGluZyBhIGhvb2sgdG8gbnZzLmMgdGhhdA0KPiBhbGxv
d2VkIGRyaXZlcnMgYXdhcmUgb2YgdGhlIGlzc3VlIHRvIGhhdmUgdGhlIHNwYWNlIGhhbmRlZCBv
ZmYgdG8gdGhlbQ0KPiBtaWdodCBiZSBlYXNpZXIuDQo+IA0KPiBIYXZlIHlvdSBzZWVuIHRoaXMg
b24gYW55IG5vbi1BTUQgc3lzdGVtcz8NCg0KVGhhbmtzIC0gdGhhdCB3YXMgdmVyeSBoZWxwZnVs
Lg0KQWxsIG9mIG15IG1pc2JlaGF2aW5nIHN5c3RlbXMgYXJlIEFNRCAtIG1vc3RseSBSeXplbiBh
bmQgVGhyZWFkcmlwcGVyIHRvd2VycywNCm9mIHZhcmlvdXMgbW90aGVyYm9hcmQgT0VNcy4gT25l
IHN5c3RlbSBpcyBhIDNyZCBnZW4gUnl6ZW4gbGFwdG9wIChBc3VzIEZYNTA1ZHkpLg0KDQpJbnRl
cmVzdGluZ2x5LCBhbGwgb2YgdGhlIHRvd2VycyBzaG93IHRoZSBzaXR1YXRpb24geW91IGRlc2Ny
aWJlOg0KWyAgICAxLjc2MDg1NV0gdHBtX2NyYiBNU0ZUMDEwMTowMDogY2FuJ3QgcmVxdWVzdCBy
ZWdpb24gZm9yIHJlc291cmNlIA0KW21lbSAweDc4ZWRmMDAwLTB4NzhlZGZmZmZdDQpbICAgIDEu
NzYwODU2XSB0cG1fY3JiOiBwcm9iZSBvZiBNU0ZUMDEwMTowMCBmYWlsZWQgd2l0aCBlcnJvciAt
MTYNClsgICAgMS44ODQ1NDBdIGltYTogTm8gVFBNIGNoaXAgZm91bmQsIGFjdGl2YXRpbmcgVFBN
LWJ5cGFzcyENCg0KNzhhYjYwMDAtNzhlZmFmZmYgOiBBQ1BJIE5vbi12b2xhdGlsZSBTdG9yYWdl
DQogIDc4ZWRiMDAwLTc4ZWRiZmZmIDogTVNGVDAxMDE6MDANCiAgNzhlZGYwMDAtNzhlZGZmZmYg
OiBNU0ZUMDEwMTowMA0KNzhlZmIwMDAtNzljZmNmZmYgOiBSZXNlcnZlZA0KDQpCdXQgdGhlIGxh
cHRvcCBzaG93cyBhIG5ldyBsYXlvdXQ6DQpbICAgIDIuMDY5NTM5XSB0cG1fY3JiIE1TRlQwMTAx
OjAwOiBjYW4ndCByZXF1ZXN0IHJlZ2lvbiBmb3IgcmVzb3VyY2UgDQpbbWVtIDB4YmQxMWYwMDAt
MHhiZDEyMmZmZl0NClsgICAgMi4wNjk1NDNdIHRwbV9jcmI6IHByb2JlIG9mIE1TRlQwMTAxOjAw
IGZhaWxlZCB3aXRoIGVycm9yIC0xNg0KWyAgICAyLjE3NzY2M10gaW1hOiBObyBUUE0gY2hpcCBm
b3VuZCwgYWN0aXZhdGluZyBUUE0tYnlwYXNzIQ0KDQpiYmM2NDAwMC1iZDE0YWZmZiA6IFJlc2Vy
dmVkDQogIGJkMTFmMDAwLWJkMTFmZmZmIDogTVNGVDAxMDE6MDANCiAgYmQxMjMwMDAtYmQxMjNm
ZmYgOiBNU0ZUMDEwMTowMA0KYmQxNGIwMDAtYmQxNzlmZmYgOiBBQ1BJIFRhYmxlcw0KYmQxN2Ew
MDAtYmQzMjhmZmYgOiBBQ1BJIE5vbi12b2xhdGlsZSBTdG9yYWdlDQoNCkkgbmV2ZXIgc3VzcGVu
ZC9yZXN1bWUgdGhlIHRvd2VycywgYW5kIGFwcGFyZW50bHkgdGhlcmVmb3JlIGF2b2lkDQpBQ1BJ
LU5WUyBtYXloZW0uIE9uIHRoZSBsYXB0b3AsIEkgc3VzcGVuZCBhbmQgcmVzdW1lIGFsbCB0aGUg
dGltZSwNCmFuZCBhcHBhcmVudGx5IGhhdmUgbm8gY29uZmxpY3QgYXMgdGhlIHJlZ2lvbiBpcyBu
b3QgbGFiZWxlZCBBQ1BJLU5WUy4NCg0KSGF2ZSB5b3UgbG9va2VkIGF0IHRoZSBzZXF1ZW5jaW5n
IGR1cmluZyBzdXNwZW5kL3Jlc3RvcmU/DQpJZiBBQ1BJIGlzIHRoZSBsYXN0IHRvIHNhdmUsIGFu
ZCBmaXJzdCB0byByZXN0b3JlLCB0aGUgVFBNJ3MgdXNlIG1heQ0Kc3RpbGwgYmUgc2FmZS4gSSds
bCB0cnkgdG8gcnVuIHNvbWUgdGVzdHMgYWxvbmcgdGhvc2UgbGluZXMsIGFuZCBsb29rDQphdCB0
aGUgbnZzIGRyaXZlci4NCg0KdGhhbmtzLA0KZGF2ZQ0K
