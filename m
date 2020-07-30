Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33FA232C12
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jul 2020 08:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgG3Guu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Jul 2020 02:50:50 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2549 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725892AbgG3Guu (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Jul 2020 02:50:50 -0400
Received: from lhreml721-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 3311F5EC5D86FCE7C827;
        Thu, 30 Jul 2020 07:50:48 +0100 (IST)
Received: from fraeml702-chm.china.huawei.com (10.206.15.51) by
 lhreml721-chm.china.huawei.com (10.201.108.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Thu, 30 Jul 2020 07:50:47 +0100
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 30 Jul 2020 08:50:47 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1913.007;
 Thu, 30 Jul 2020 08:50:47 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     "efremov@linux.com" <efremov@linux.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>
CC:     Dmitry Vyukov <dvyukov@google.com>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: RE: IMA/EVM interfaces
Thread-Topic: IMA/EVM interfaces
Thread-Index: AQHWZMpr83sXYkAPt0yzElAzGYKB66kdIV3QgAHagACAALU/0A==
Date:   Thu, 30 Jul 2020 06:50:46 +0000
Message-ID: <425db984e96241f0a28a0b650aaa0b1d@huawei.com>
References: <bf04bf15-cddd-ce22-926a-8459c1f92779@linux.com>
 <ef2745fddaec4f859cf9852028f650df@huawei.com>
 <b3d93ebd-80a0-4aea-15ef-8bd22241e19f@linux.com>
In-Reply-To: <b3d93ebd-80a0-4aea-15ef-8bd22241e19f@linux.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.220.96.108]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

PiBGcm9tOiBEZW5pcyBFZnJlbW92IFttYWlsdG86ZWZyZW1vdkBsaW51eC5jb21dDQo+IFNlbnQ6
IFdlZG5lc2RheSwgSnVseSAyOSwgMjAyMCAxMTo1OSBQTQ0KPiANCj4gDQo+IA0KPiBPbiA3LzI4
LzIwIDY6NDMgUE0sIFJvYmVydG8gU2Fzc3Ugd3JvdGU6DQo+ID4+IEZyb206IGxpbnV4LWludGVn
cml0eS1vd25lckB2Z2VyLmtlcm5lbC5vcmcgW21haWx0bzpsaW51eC1pbnRlZ3JpdHktDQo+ID4+
IG93bmVyQHZnZXIua2VybmVsLm9yZ10gT24gQmVoYWxmIE9mIERlbmlzIEVmcmVtb3YNCj4gPj4g
U2VudDogVHVlc2RheSwgSnVseSAyOCwgMjAyMCAxMjozMiBQTQ0KPiA+PiBIaSwNCj4gPj4NCj4g
Pj4gSSd2ZSBzdGFydGVkIHRvIGFkZCBpbnRlZ3JpdHkgaW50ZXJmYWNlcyBkZXNjcmlwdGlvbnMg
dG8gc3l6a2FsbGVyDQo+ID4+IChodHRwczovL2dpdGh1Yi5jb20vZ29vZ2xlL3N5emthbGxlci9w
dWxsLzE5NzApLg0KPiA+Pg0KPiA+PiBJJ3ZlIGdvdCBhIHF1ZXN0aW9uLCBpZiB5b3UgZG9uJ3Qg
bWluZDoNCj4gPj4NCj4gPj4gSWYgSSB3cml0ZSAyIHRvIC9zeXMva2VybmVsL3NlY3VyaXR5L2lu
dGVncml0eS9ldm0vZXZtIGJlZm9yZSBsb2FkaW5nDQo+IGtleXMsDQo+ID4+IHN1YnNlcXVlbnQg
ZnMgb3BlcmF0aW9ucyB3aWxsIGZhaWwgd2l0aCAtRU5PS0VZLg0KPiA+Pg0KPiA+PiAkIGVjaG8g
MiA+IC9zeXMva2VybmVsL3NlY3VyaXR5L2ludGVncml0eS9ldm0vZXZtDQo+ID4+ICQgdG91Y2gg
dGVzdC50eHQNCg0KTG9va3MgZ29vZC4gTWltaSwgY291bGQgeW91IHBsZWFzZSB0YWtlIHRoaXMg
cGF0Y2gsIGFuZCBpZg0KcG9zc2libGUsIHRoZSBvdGhlcnMgaW4gdGhlIHBhdGNoIHNldD8NCg0K
VGhhbmtzDQoNClJvYmVydG8NCg0KSFVBV0VJIFRFQ0hOT0xPR0lFUyBEdWVzc2VsZG9yZiBHbWJI
LCBIUkIgNTYwNjMNCk1hbmFnaW5nIERpcmVjdG9yOiBMaSBQZW5nLCBMaSBKaWFuLCBTaGkgWWFu
bGkNCg0KPiA+PiBbICA1MjYuOTc2ODU1XVsgVDU3NzFdIGV2bTogSE1BQyBrZXkgaXMgbm90IHNl
dA0KPiA+PiBbICA1MjYuOTc3ODkyXVsgVDU3NzFdIGV2bTogaW5pdF9kZXNjIGZhaWxlZA0KPiA+
PiB0b3VjaDogY2Fubm90IHRvdWNoICd0ZXN0LnR4dCc6IFJlcXVpcmVkIGtleSBub3QgYXZhaWxh
YmxlDQo+ID4+DQo+ID4+IElzIHRoaXMgYSBkZXNpcmVkIGJlaGF2aW9yPyBTaG91bGQgdGhlcmUg
YmUgYSBjaGVjayBpbiBldm1fd3JpdGVfa2V5KCkNCj4gPj4gZm9yIGxvYWRlZCBrZXlzIChlbmNy
eXB0ZWQgZXZtLWtleSwga2V5cyBpbiBfZXZtLCBfaW1hIGtleXJpbmdzKQ0KPiBiZWZvcmUNCj4g
Pj4gY2hhbmdpbmcgdGhlIGV2bV9pbml0aWFsaXplZCBiaXQ/IElzIGl0IGNvcnJlY3QgdG8gc2V0
IHNlY29uZCBiaXQgd2l0aG91dA0KPiA+PiBmaXJzdCBiaXQ/DQo+ID4NCj4gPiBIaSBEZW5pcw0K
PiA+DQo+ID4gY2FuIHlvdSBwbGVhc2UgdHJ5IHRoaXMgcGF0Y2g/DQo+ID4NCj4gPiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9saW51eC1pbnRlZ3JpdHkvMjAyMDA2MTgxNjAxMzMuOTM3LTEtDQo+
IHJvYmVydG8uc2Fzc3VAaHVhd2VpLmNvbS8NCj4gPg0KPiA+DQo+IA0KPiAkIGNhdCAvcHJvYy9j
bWRsaW5lDQo+IGNvbnNvbGU9dHR5UzAgcm9vdD0vZGV2L3NkYSBlYXJseXByaW50az1zZXJpYWwg
aW1hX2FwcHJhaXNlPWZpeCBldm09Zml4DQo+ICQgZWNobyAyID4gL3N5cy9rZXJuZWwvc2VjdXJp
dHkvaW50ZWdyaXR5L2V2bS9ldm0NCj4gWyAgIDQ0LjExNjA4NF1bIFQ0MTA4XSBldm06IEhNQUMg
a2V5IGlzIG5vdCBzZXQNCj4gJCB0b3VjaCB0ZXN0LnR4dA0KPiAkIGNhdCAvc3lzL2tlcm5lbC9z
ZWN1cml0eS9pbnRlZ3JpdHkvZXZtL2V2bQ0KPiAyDQo+ICQga2V5Y3RsIGFkZCB1c2VyIGttay11
c2VyICJgY2F0IC9ldGMva2V5cy9rbWstdXNlci5ibG9iYCIgQHUNCj4gJCBrZXljdGwgYWRkIGVu
Y3J5cHRlZCBldm0ta2V5ICJsb2FkIGBjYXQgL2V0Yy9rZXlzL2V2bS11c2VyLmJsb2JgIiBAdQ0K
PiAkIGVjaG8gMSA+IC9zeXMva2VybmVsL3NlY3VyaXR5L2ludGVncml0eS9ldm0vZXZtDQo+IFsg
IDU3NC4zMjgyNjJdIGV2bToga2V5IGluaXRpYWxpemVkDQo+IA0KPiBSZWdhcmRzLA0KPiBEZW5p
cw0K
