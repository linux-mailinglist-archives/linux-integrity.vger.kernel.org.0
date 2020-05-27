Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D141E4F12
	for <lists+linux-integrity@lfdr.de>; Wed, 27 May 2020 22:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbgE0UTA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 May 2020 16:19:00 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:50148 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727090AbgE0UTA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 May 2020 16:19:00 -0400
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04RKBvet019670;
        Wed, 27 May 2020 16:18:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=/SUvSUcYEZAaJQAoQa6QA7tQg6WWYeQ9EUOEJ0uc4v8=;
 b=wzuPb5HeYlYxp0nPSpjYE/98yXBgmiWMvM6veeoCjt9gH0SqH3rhAbYFMDQCZrUBVHYd
 gupLWusdsCzGr7Rd3xGS8dfiR0A9LL5iK14M1059TVPXgl7Ex365875SoVKuQY2xHwxf
 zjoHRwEmnVikrn4KGpVo1wzjtanqvOsGOwLXb8nEcka0z6SSicUB2pdMx9kG/jqvCIWt
 9erQVKaPj+Oau1uTjet1/cQ2OExx7eR3UsZDluK7c11CgDNr4ldIdiE2UxIuh0SsrY3Q
 nv84q7vweH6mpmjG7iG3UirROzKrLubfkAiWJjkRr8vWboQezpj6CwW5Y3ULDuHSLc0x Zg== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 316xw4w8p6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 May 2020 16:18:59 -0400
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04RKA9EA179873;
        Wed, 27 May 2020 16:18:58 -0400
Received: from ausxippc101.us.dell.com (ausxippc101.us.dell.com [143.166.85.207])
        by mx0b-00154901.pphosted.com with ESMTP id 318rae73vx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 May 2020 16:18:58 -0400
X-LoopCount0: from 10.166.132.129
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,346,1549951200"; 
   d="scan'208";a="1391851612"
From:   <Mario.Limonciello@dell.com>
To:     <jarkko.sakkinen@linux.intel.com>,
        <James.Bottomley@HansenPartnership.com>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>
CC:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jeffrin@rajagiritech.edu.in>, <alex@guzman.io>
Subject: RE: [PATCH] tpm: Revert "tpm: fix invalid locking in NONBLOCKING
 mode"
Thread-Topic: [PATCH] tpm: Revert "tpm: fix invalid locking in NONBLOCKING
 mode"
Thread-Index: AQHWM4wIzxc0OpiDwkyMUhr0qx5qZ6i7EGkA//+sw5CAAFoVAIABmusA//+ulgA=
Date:   Wed, 27 May 2020 20:18:56 +0000
Message-ID: <4d1a53596af44c7b84f97aa4ce04a53c@AUSX13MPC105.AMER.DELL.COM>
References: <20200526183213.20720-1-mario.limonciello@dell.com>
         <1590520454.11810.40.camel@HansenPartnership.com>
         <ccf055cbf1a14f28bc95a6b02e29a2f6@AUSX13MPC105.AMER.DELL.COM>
         <1590521924.15108.1.camel@HansenPartnership.com>
 <37da2695fe6de09d69e27b77f3e29e068596205f.camel@linux.intel.com>
In-Reply-To: <37da2695fe6de09d69e27b77f3e29e068596205f.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-05-27T20:18:54.4742696Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=796ffd79-2d4d-44fc-badf-ebe47214f41d;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.60]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-27_03:2020-05-27,2020-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 adultscore=0 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 cotscore=-2147483648 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005270154
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005270155
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYXJra28gU2Fra2luZW4gPGph
cmtrby5zYWtraW5lbkBsaW51eC5pbnRlbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWF5IDI3
LCAyMDIwIDM6MDkgUE0NCj4gVG86IEphbWVzIEJvdHRvbWxleTsgTGltb25jaWVsbG8sIE1hcmlv
OyBwZXRlcmh1ZXdlQGdteC5kZTsgamdnQHppZXBlLmNhDQo+IENjOiBhcm5kQGFybmRiLmRlOyBn
cmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgbGludXgtaW50ZWdyaXR5QHZnZXIua2VybmVsLm9y
ZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgamVmZnJpbkByYWphZ2lyaXRlY2gu
ZWR1LmluOyBhbGV4QGd1em1hbi5pbw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSB0cG06IFJldmVy
dCAidHBtOiBmaXggaW52YWxpZCBsb2NraW5nIGluIE5PTkJMT0NLSU5HIG1vZGUiDQo+IA0KPiAN
Cj4gW0VYVEVSTkFMIEVNQUlMXQ0KPiANCj4gT24gVHVlLCAyMDIwLTA1LTI2IGF0IDEyOjM4IC0w
NzAwLCBKYW1lcyBCb3R0b21sZXkgd3JvdGU6DQo+ID4gT24gVHVlLCAyMDIwLTA1LTI2IGF0IDE5
OjIzICswMDAwLCBNYXJpby5MaW1vbmNpZWxsb0BkZWxsLmNvbSB3cm90ZToNCj4gPiA+ID4gT24g
VHVlLCAyMDIwLTA1LTI2IGF0IDEzOjMyIC0wNTAwLCBNYXJpbyBMaW1vbmNpZWxsbyB3cm90ZToN
Cj4gPiA+ID4gPiBUaGlzIHJldmVydHMgY29tbWl0IGQyM2QxMjQ4NDMwN2I0MGVlYTU0OWI4YTg1
OGY1ZmZmYWQ5MTM4OTcuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGlzIGNvbW1pdCBoYXMgY2F1
c2VkIHJlZ3Jlc3Npb25zIGZvciB0aGUgWFBTIDk1NjAgY29udGFpbmluZw0KPiA+ID4gPiA+IGEg
TnV2b3RvbiBUUE0uDQo+ID4gPiA+DQo+ID4gPiA+IFByZXN1bWFibHkgdGhpcyBpcyB1c2luZyB0
aGUgdGlzIGRyaXZlcj8NCj4gPiA+DQo+ID4gPiBDb3JyZWN0Lg0KPiA+ID4NCj4gPiA+ID4gPiBB
cyBtZW50aW9uZWQgYnkgdGhlIHJlcG9ydGVyIGFsbCBUUE0yIGNvbW1hbmRzIGFyZSBmYWlsaW5n
IHdpdGg6DQo+ID4gPiA+ID4gICBFUlJPUjp0Y3RpOnNyYy90c3MyLXRjdGkvdGN0aS0NCj4gPiA+
ID4gPiBkZXZpY2UuYzoyOTA6dGN0aV9kZXZpY2VfcmVjZWl2ZSgpDQo+ID4gPiA+ID4gICBGYWls
ZWQgdG8gcmVhZCByZXNwb25zZSBmcm9tIGZkIDMsIGdvdCBlcnJubyAxOiBPcGVyYXRpb24gbm90
DQo+ID4gPiA+ID4gcGVybWl0dGVkDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGUgcmVwb3J0ZXIg
YmlzZWN0ZWQgdGhpcyBpc3N1ZSBiYWNrIHRvIHRoaXMgY29tbWl0IHdoaWNoIHdhcw0KPiA+ID4g
PiA+IGJhY2twb3J0ZWQgdG8gc3RhYmxlIGFzIGNvbW1pdCA0ZDZlYmM0Lg0KPiA+ID4gPg0KPiA+
ID4gPiBJIHRoaW5rIHRoZSBwcm9ibGVtIGlzIHJlcXVlc3RfbG9jYWxpdHkgLi4uIGZvciBzb21l
IGluZXhwbGljYWJsZQ0KPiA+ID4gPiByZWFzb24gYSBmYWlsdXJlIHRoZXJlIHJldHVybnMgLTEs
IHdoaWNoIGlzIEVQRVJNIHRvIHVzZXIgc3BhY2UuDQo+ID4gPiA+DQo+ID4gPiA+IFRoYXQgc2Vl
bXMgdG8gYmUgYSBidWcgaW4gdGhlIGFzeW5jIGNvZGUgc2luY2UgZXZlcnl0aGluZyBlbHNlDQo+
ID4gPiA+IGdpdmVzIGEgRVNQSVBFIGVycm9yIGlmIHRwbV90cnlfZ2V0X29wcyBmYWlscyAuLi4g
YXQgbGVhc3Qgbm8tb25lDQo+ID4gPiA+IGFzc3VtZXMgaXQgZ2l2ZXMgYmFjayBhIHNlbnNpYmxl
IHJldHVybiBjb2RlLg0KPiA+ID4gPg0KPiA+ID4gPiBXaGF0IEkgdGhpbmsgaXMgaGFwcGVuaW5n
IGlzIHRoYXQgd2l0aCB0aGUgcGF0Y2ggdGhlIFRQTSBnb2VzDQo+ID4gPiA+IHRocm91Z2ggYSBx
dWljayBzZXF1ZW5jZSBvZiByZXF1ZXN0LCByZWxpbnF1aXNoLCByZXF1ZXN0LA0KPiA+ID4gPiBy
ZWxpbnF1aXNoIGFuZCBpdCdzIHRoZSB0aGlyZCByZXF1ZXN0IHdoaWNoIGlzIGZhaWxpbmcgKGxp
a2VseQ0KPiA+ID4gPiB0aW1pbmcgb3V0KS4gIFdpdGhvdXQgdGhlIHBhdGNoLCB0aGUgcGF0Y2gg
dGhlcmUncyBvbmx5IG9uZQ0KPiA+ID4gPiByZXF1ZXN0LHJlbGlucXVpc2ggY3ljbGUgYmVjYXVz
ZSB0aGUgb3BzIGFyZSBoZWxkIHdoaWxlIHRoZSBhc3luYw0KPiA+ID4gPiB3b3JrIGlzIGV4ZWN1
dGVkLiAgSSBoYXZlIGEgdmFndWUgcmVjb2xsZWN0aW9uIHRoYXQgdGhlcmUgaXMgYQ0KPiA+ID4g
PiBwcm9ibGVtIHdpdGggdG9vIG1hbnkgbG9jYWxpdHkgcmVxdWVzdCBpbiBxdWljayBzdWNjZXNz
aW9uLCBidXQNCj4gPiA+ID4gSSdsbCBkZWZlciB0byBKYXNvbiwgd2hvIEkgdGhpbmsgdW5kZXJz
dGFuZHMgdGhlIGludHJpY2FjaWVzIG9mDQo+ID4gPiA+IGxvY2FsaXRpZXMgYmV0dGVyIHRoYW4g
SSBkby4NCj4gPiA+DQo+ID4gPiBUaGFua3MsIEkgZG9uJ3QgcHJldGVuZCB0byB1bmRlcnN0YW5k
IHRoZSBudWFuY2VzIG9mIHRoaXMgcGFydGljdWxhcg0KPiA+ID4gY29kZSwgYnV0IEkgd2FzIGhv
cGluZyB0aGF0IHRoZSByZXF1ZXN0IHRvIHJldmVydCBnb3Qgc29tZSBhdHRlbnRpb24NCj4gPiA+
IHNpbmNlIEFsZXgncyBrZXJuZWwgQnVnemlsbGEgYW5kIG1lc3NhZ2UgYSBmZXcgbW9udGhzIGFn
byB0byBsaW51eA0KPiA+ID4gaW50ZWdyaXR5IHdlcmVuJ3QuDQo+ID4gPg0KPiA+ID4gPiBJZiB0
aGF0J3MgdGhlIHByb2JsZW0sIHRoZSBzb2x1dGlvbiBsb29rcyBzaW1wbGUgZW5vdWdoOiBqdXN0
IG1vdmUNCj4gPiA+ID4gdGhlIG9wcyBnZXQgZG93biBiZWNhdXNlIHRoZSBwcml2IHN0YXRlIGlz
IGFscmVhZHkgcHJvdGVjdGVkIGJ5IHRoZQ0KPiA+ID4gPiBidWZmZXIgbXV0ZXgNCj4gPiA+DQo+
ID4gPiBZZWFoLCBpZiB0aGF0IHdvcmtzIGZvciBBbGV4J3Mgc2l0dWF0aW9uIGl0IGNlcnRhaW5s
eSBzb3VuZHMgbGlrZSBhDQo+ID4gPiBiZXR0ZXIgc29sdXRpb24gdGhhbiByZXZlcnRpbmcgdGhp
cyBwYXRjaCBhcyB0aGlzIHBhdGNoIGFjdHVhbGx5IGRvZXMNCj4gPiA+IGZpeCBhIHByb2JsZW0g
cmVwb3J0ZWQgYnkgSmVmZnJpbiBvcmlnaW5hbGx5Lg0KPiA+ID4NCj4gPiA+IENvdWxkIHlvdSBw
cm9wb3NlIGEgc3BlY2lmaWMgcGF0Y2ggdGhhdCBBbGV4IGFuZCBKZWZmcmluIGNhbiBwZXJoYXBz
DQo+ID4gPiBib3RoIHRyeT8NCj4gPg0KPiA+IFVtLCB3aGF0J3Mgd3Jvbmcgd2l0aCB0aGUgb25l
IEkgb3JpZ2luYWxseSBhdHRhY2hlZCBhbmQgd2hpY2ggeW91IHF1b3RlDQo+ID4gYmVsb3c/ICBJ
dCdzIG9ubHkgY29tcGlsZSB0ZXN0ZWQsIGJ1dCBJIHRoaW5rIGl0IHdpbGwgd29yaywgaWYgdGhl
DQo+ID4gdGhlb3J5IGlzIGNvcnJlY3QuDQo+IA0KPiBQbGVhc2Ugc2VuZCBhIGxlZ2l0IHBhdGNo
LCB0aGFua3MuDQo+IA0KPiAvSmFya2tvDQoNCkphcmtrbywNCg0KQWZ0ZXIgdGhlIGNvbmZpcm1h
dGlvbiBmcm9tIEFsZXggdGhhdCB0aGlzIHBhdGNoIGF0dGFjaGVkIHRvIHRoZSBlbmQgb2YgdGhl
IHRocmVhZA0Kd29ya2VkLCBKYW1lcyBkaWQgc2VuZCBhIHByb3BlciBwYXRjaCB0aGF0IGNhbiBi
ZSBhY2Nlc3NlZCBoZXJlOg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaW50ZWdyaXR5
LzIwMjAwNTI3MTU1ODAwLnlhNDN4bTJsdHV3ZHV3amdAY2FudG9yL1QvI3QNCg0KVGhhbmtzLA0K
