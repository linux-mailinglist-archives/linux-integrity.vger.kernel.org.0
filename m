Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866131E2DB6
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2020 21:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404496AbgEZTXi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 May 2020 15:23:38 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:34624 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404494AbgEZTXh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 May 2020 15:23:37 -0400
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04QJGl8P013259;
        Tue, 26 May 2020 15:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=UF0b9vzgjoGA/TxDHjFty03aH3x5lf3r1PDB0hOx0YY=;
 b=W/CDq0sqoSOSUtm24RwBTq3QE0cKxHFzk26/nzX9xd96zjRii0vyhURpG09lEUGsOz/s
 TPT8aSxMluerBQIj/qoHOmKtE97rzTweBxF6jOke/7P2dRhmxEfcRN3NJi+Q3pmAaSuw
 juLtwERKo7HvAXyoS2nOmwlq2nmdPtAOjdwYjkykp13RN2HTTJakjrvAUhz/fQw94gyC
 IEFWZnvvHG5TG813KZLbs/I9HakbGOyViDHcrrvrdBcgCHtpx3TaseiOH2AxfPx4AWBU
 HwJZbycI1Tn8QmgVSPhvoZSTE4+FP3WvR0i6bjCI+nPx3EqEr5cpYaFUpk8ASexm6sQf pg== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 316yukghrg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 May 2020 15:23:36 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04QJIGD9085892;
        Tue, 26 May 2020 15:23:36 -0400
Received: from ausc60pc101.us.dell.com (ausc60pc101.us.dell.com [143.166.85.206])
        by mx0a-00154901.pphosted.com with ESMTP id 318u1nkqwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 May 2020 15:23:36 -0400
X-LoopCount0: from 10.166.132.133
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="1559551251"
From:   <Mario.Limonciello@dell.com>
To:     <James.Bottomley@HansenPartnership.com>, <peterhuewe@gmx.de>,
        <jarkko.sakkinen@linux.intel.com>, <jgg@ziepe.ca>
CC:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jeffrin@rajagiritech.edu.in>, <alex@guzman.io>
Subject: RE: [PATCH] tpm: Revert "tpm: fix invalid locking in NONBLOCKING
 mode"
Thread-Topic: [PATCH] tpm: Revert "tpm: fix invalid locking in NONBLOCKING
 mode"
Thread-Index: AQHWM4wIzxc0OpiDwkyMUhr0qx5qZ6i7EGkA//+sw5A=
Date:   Tue, 26 May 2020 19:23:33 +0000
Message-ID: <ccf055cbf1a14f28bc95a6b02e29a2f6@AUSX13MPC105.AMER.DELL.COM>
References: <20200526183213.20720-1-mario.limonciello@dell.com>
 <1590520454.11810.40.camel@HansenPartnership.com>
In-Reply-To: <1590520454.11810.40.camel@HansenPartnership.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-05-26T19:21:31.0930081Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=8768ed6e-ec87-4f22-bbd6-37850e26d1a1;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.60]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-26_02:2020-05-26,2020-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 cotscore=-2147483648
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 suspectscore=0 impostorscore=0 clxscore=1011
 priorityscore=1501 mlxscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005260149
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005260149
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

PiBPbiBUdWUsIDIwMjAtMDUtMjYgYXQgMTM6MzIgLTA1MDAsIE1hcmlvIExpbW9uY2llbGxvIHdy
b3RlOg0KPiA+IFRoaXMgcmV2ZXJ0cyBjb21taXQgZDIzZDEyNDg0MzA3YjQwZWVhNTQ5YjhhODU4
ZjVmZmZhZDkxMzg5Ny4NCj4gPg0KPiA+IFRoaXMgY29tbWl0IGhhcyBjYXVzZWQgcmVncmVzc2lv
bnMgZm9yIHRoZSBYUFMgOTU2MCBjb250YWluaW5nDQo+ID4gYSBOdXZvdG9uIFRQTS4NCj4gDQo+
IFByZXN1bWFibHkgdGhpcyBpcyB1c2luZyB0aGUgdGlzIGRyaXZlcj8NCg0KQ29ycmVjdC4NCg0K
PiANCj4gPiBBcyBtZW50aW9uZWQgYnkgdGhlIHJlcG9ydGVyIGFsbCBUUE0yIGNvbW1hbmRzIGFy
ZSBmYWlsaW5nIHdpdGg6DQo+ID4gICBFUlJPUjp0Y3RpOnNyYy90c3MyLXRjdGkvdGN0aS1kZXZp
Y2UuYzoyOTA6dGN0aV9kZXZpY2VfcmVjZWl2ZSgpDQo+ID4gICBGYWlsZWQgdG8gcmVhZCByZXNw
b25zZSBmcm9tIGZkIDMsIGdvdCBlcnJubyAxOiBPcGVyYXRpb24gbm90DQo+ID4gcGVybWl0dGVk
DQo+ID4NCj4gPiBUaGUgcmVwb3J0ZXIgYmlzZWN0ZWQgdGhpcyBpc3N1ZSBiYWNrIHRvIHRoaXMg
Y29tbWl0IHdoaWNoIHdhcw0KPiA+IGJhY2twb3J0ZWQgdG8gc3RhYmxlIGFzIGNvbW1pdCA0ZDZl
YmM0Lg0KPiANCj4gSSB0aGluayB0aGUgcHJvYmxlbSBpcyByZXF1ZXN0X2xvY2FsaXR5IC4uLiBm
b3Igc29tZSBpbmV4cGxpY2FibGUNCj4gcmVhc29uIGEgZmFpbHVyZSB0aGVyZSByZXR1cm5zIC0x
LCB3aGljaCBpcyBFUEVSTSB0byB1c2VyIHNwYWNlLg0KPiANCj4gVGhhdCBzZWVtcyB0byBiZSBh
IGJ1ZyBpbiB0aGUgYXN5bmMgY29kZSBzaW5jZSBldmVyeXRoaW5nIGVsc2UgZ2l2ZXMgYQ0KPiBF
U1BJUEUgZXJyb3IgaWYgdHBtX3RyeV9nZXRfb3BzIGZhaWxzIC4uLiBhdCBsZWFzdCBuby1vbmUg
YXNzdW1lcyBpdA0KPiBnaXZlcyBiYWNrIGEgc2Vuc2libGUgcmV0dXJuIGNvZGUuDQo+IA0KPiBX
aGF0IEkgdGhpbmsgaXMgaGFwcGVuaW5nIGlzIHRoYXQgd2l0aCB0aGUgcGF0Y2ggdGhlIFRQTSBn
b2VzIHRocm91Z2ggYQ0KPiBxdWljayBzZXF1ZW5jZSBvZiByZXF1ZXN0LCByZWxpbnF1aXNoLCBy
ZXF1ZXN0LCByZWxpbnF1aXNoIGFuZCBpdCdzIHRoZQ0KPiB0aGlyZCByZXF1ZXN0IHdoaWNoIGlz
IGZhaWxpbmcgKGxpa2VseSB0aW1pbmcgb3V0KS4gIFdpdGhvdXQgdGhlIHBhdGNoLA0KPiB0aGUg
cGF0Y2ggdGhlcmUncyBvbmx5IG9uZSByZXF1ZXN0LHJlbGlucXVpc2ggY3ljbGUgYmVjYXVzZSB0
aGUgb3BzIGFyZQ0KPiBoZWxkIHdoaWxlIHRoZSBhc3luYyB3b3JrIGlzIGV4ZWN1dGVkLiAgSSBo
YXZlIGEgdmFndWUgcmVjb2xsZWN0aW9uDQo+IHRoYXQgdGhlcmUgaXMgYSBwcm9ibGVtIHdpdGgg
dG9vIG1hbnkgbG9jYWxpdHkgcmVxdWVzdCBpbiBxdWljaw0KPiBzdWNjZXNzaW9uLCBidXQgSSds
bCBkZWZlciB0byBKYXNvbiwgd2hvIEkgdGhpbmsgdW5kZXJzdGFuZHMgdGhlDQo+IGludHJpY2Fj
aWVzIG9mIGxvY2FsaXRpZXMgYmV0dGVyIHRoYW4gSSBkby4NCg0KVGhhbmtzLCBJIGRvbid0IHBy
ZXRlbmQgdG8gdW5kZXJzdGFuZCB0aGUgbnVhbmNlcyBvZiB0aGlzIHBhcnRpY3VsYXIgY29kZSwN
CmJ1dCBJIHdhcyBob3BpbmcgdGhhdCB0aGUgcmVxdWVzdCB0byByZXZlcnQgZ290IHNvbWUgYXR0
ZW50aW9uIHNpbmNlIEFsZXgncw0Ka2VybmVsIEJ1Z3ppbGxhIGFuZCBtZXNzYWdlIGEgZmV3IG1v
bnRocyBhZ28gdG8gbGludXggaW50ZWdyaXR5IHdlcmVuJ3QuDQoNCj4gDQo+IElmIHRoYXQncyB0
aGUgcHJvYmxlbSwgdGhlIHNvbHV0aW9uIGxvb2tzIHNpbXBsZSBlbm91Z2g6IGp1c3QgbW92ZSB0
aGUNCj4gb3BzIGdldCBkb3duIGJlY2F1c2UgdGhlIHByaXYgc3RhdGUgaXMgYWxyZWFkeSBwcm90
ZWN0ZWQgYnkgdGhlIGJ1ZmZlcg0KPiBtdXRleA0KDQpZZWFoLCBpZiB0aGF0IHdvcmtzIGZvciBB
bGV4J3Mgc2l0dWF0aW9uIGl0IGNlcnRhaW5seSBzb3VuZHMgbGlrZSBhIGJldHRlcg0Kc29sdXRp
b24gdGhhbiByZXZlcnRpbmcgdGhpcyBwYXRjaCBhcyB0aGlzIHBhdGNoIGFjdHVhbGx5IGRvZXMg
Zml4IGEgcHJvYmxlbQ0KcmVwb3J0ZWQgYnkgSmVmZnJpbiBvcmlnaW5hbGx5Lg0KDQpDb3VsZCB5
b3UgcHJvcG9zZSBhIHNwZWNpZmljIHBhdGNoIHRoYXQgQWxleCBhbmQgSmVmZnJpbiBjYW4gcGVy
aGFwcyBib3RoIHRyeT8NCg0KPiANCj4gSmFtZXMNCj4gDQo+IC0tLQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvY2hhci90cG0vdHBtLWRldi1jb21tb24uYyBiL2RyaXZlcnMvY2hhci90cG0v
dHBtLWRldi0NCj4gY29tbW9uLmMNCj4gaW5kZXggODdmNDQ5MzQwMjAyLi4xNzg0NTMwYjgzODcg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY2hhci90cG0vdHBtLWRldi1jb21tb24uYw0KPiArKysg
Yi9kcml2ZXJzL2NoYXIvdHBtL3RwbS1kZXYtY29tbW9uLmMNCj4gQEAgLTE4OSwxNSArMTg5LDYg
QEAgc3NpemVfdCB0cG1fY29tbW9uX3dyaXRlKHN0cnVjdCBmaWxlICpmaWxlLCBjb25zdCBjaGFy
DQo+IF9fdXNlciAqYnVmLA0KPiAgCQlnb3RvIG91dDsNCj4gIAl9DQo+IA0KPiAtCS8qIGF0b21p
YyB0cG0gY29tbWFuZCBzZW5kIGFuZCByZXN1bHQgcmVjZWl2ZS4gV2Ugb25seSBob2xkIHRoZSBv
cHMNCj4gLQkgKiBsb2NrIGR1cmluZyB0aGlzIHBlcmlvZCBzbyB0aGF0IHRoZSB0cG0gY2FuIGJl
IHVucmVnaXN0ZXJlZCBldmVuIGlmDQo+IC0JICogdGhlIGNoYXIgZGV2IGlzIGhlbGQgb3Blbi4N
Cj4gLQkgKi8NCj4gLQlpZiAodHBtX3RyeV9nZXRfb3BzKHByaXYtPmNoaXApKSB7DQo+IC0JCXJl
dCA9IC1FUElQRTsNCj4gLQkJZ290byBvdXQ7DQo+IC0JfQ0KPiAtDQo+ICAJcHJpdi0+cmVzcG9u
c2VfbGVuZ3RoID0gMDsNCj4gIAlwcml2LT5yZXNwb25zZV9yZWFkID0gZmFsc2U7DQo+ICAJKm9m
ZiA9IDA7DQo+IEBAIC0yMTEsMTEgKzIwMiwxOSBAQCBzc2l6ZV90IHRwbV9jb21tb25fd3JpdGUo
c3RydWN0IGZpbGUgKmZpbGUsIGNvbnN0IGNoYXINCj4gX191c2VyICpidWYsDQo+ICAJaWYgKGZp
bGUtPmZfZmxhZ3MgJiBPX05PTkJMT0NLKSB7DQo+ICAJCXByaXYtPmNvbW1hbmRfZW5xdWV1ZWQg
PSB0cnVlOw0KPiAgCQlxdWV1ZV93b3JrKHRwbV9kZXZfd3EsICZwcml2LT5hc3luY193b3JrKTsN
Cj4gLQkJdHBtX3B1dF9vcHMocHJpdi0+Y2hpcCk7DQo+ICAJCW11dGV4X3VubG9jaygmcHJpdi0+
YnVmZmVyX211dGV4KTsNCj4gIAkJcmV0dXJuIHNpemU7DQo+ICAJfQ0KPiANCj4gKwkvKiBhdG9t
aWMgdHBtIGNvbW1hbmQgc2VuZCBhbmQgcmVzdWx0IHJlY2VpdmUuIFdlIG9ubHkgaG9sZCB0aGUg
b3BzDQo+ICsJICogbG9jayBkdXJpbmcgdGhpcyBwZXJpb2Qgc28gdGhhdCB0aGUgdHBtIGNhbiBi
ZSB1bnJlZ2lzdGVyZWQgZXZlbiBpZg0KPiArCSAqIHRoZSBjaGFyIGRldiBpcyBoZWxkIG9wZW4u
DQo+ICsJICovDQo+ICsJaWYgKHRwbV90cnlfZ2V0X29wcyhwcml2LT5jaGlwKSkgew0KPiArCQly
ZXQgPSAtRVBJUEU7DQo+ICsJCWdvdG8gb3V0Ow0KPiArCX0NCj4gKw0KPiAgCXJldCA9IHRwbV9k
ZXZfdHJhbnNtaXQocHJpdi0+Y2hpcCwgcHJpdi0+c3BhY2UsIHByaXYtPmRhdGFfYnVmZmVyLA0K
PiAgCQkJICAgICAgIHNpemVvZihwcml2LT5kYXRhX2J1ZmZlcikpOw0KPiAgCXRwbV9wdXRfb3Bz
KHByaXYtPmNoaXApOw0K
