Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6554B230E36
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Jul 2020 17:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbgG1PnR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 28 Jul 2020 11:43:17 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2544 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730679AbgG1PnR (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 28 Jul 2020 11:43:17 -0400
Received: from lhreml709-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id DBDA3C4D094C9F017F1A;
        Tue, 28 Jul 2020 16:43:15 +0100 (IST)
Received: from fraeml705-chm.china.huawei.com (10.206.15.54) by
 lhreml709-chm.china.huawei.com (10.201.108.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 28 Jul 2020 16:43:15 +0100
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 28 Jul 2020 17:43:14 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1913.007;
 Tue, 28 Jul 2020 17:43:14 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     "efremov@linux.com" <efremov@linux.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>
CC:     Dmitry Vyukov <dvyukov@google.com>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: RE: IMA/EVM interfaces
Thread-Topic: IMA/EVM interfaces
Thread-Index: AQHWZMpr83sXYkAPt0yzElAzGYKB66kdIV3Q
Date:   Tue, 28 Jul 2020 15:43:14 +0000
Message-ID: <ef2745fddaec4f859cf9852028f650df@huawei.com>
References: <bf04bf15-cddd-ce22-926a-8459c1f92779@linux.com>
In-Reply-To: <bf04bf15-cddd-ce22-926a-8459c1f92779@linux.com>
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

PiBGcm9tOiBsaW51eC1pbnRlZ3JpdHktb3duZXJAdmdlci5rZXJuZWwub3JnIFttYWlsdG86bGlu
dXgtaW50ZWdyaXR5LQ0KPiBvd25lckB2Z2VyLmtlcm5lbC5vcmddIE9uIEJlaGFsZiBPZiBEZW5p
cyBFZnJlbW92DQo+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMjgsIDIwMjAgMTI6MzIgUE0NCj4gSGks
DQo+IA0KPiBJJ3ZlIHN0YXJ0ZWQgdG8gYWRkIGludGVncml0eSBpbnRlcmZhY2VzIGRlc2NyaXB0
aW9ucyB0byBzeXprYWxsZXINCj4gKGh0dHBzOi8vZ2l0aHViLmNvbS9nb29nbGUvc3l6a2FsbGVy
L3B1bGwvMTk3MCkuDQo+IA0KPiBJJ3ZlIGdvdCBhIHF1ZXN0aW9uLCBpZiB5b3UgZG9uJ3QgbWlu
ZDoNCj4gDQo+IElmIEkgd3JpdGUgMiB0byAvc3lzL2tlcm5lbC9zZWN1cml0eS9pbnRlZ3JpdHkv
ZXZtL2V2bSBiZWZvcmUgbG9hZGluZyBrZXlzLA0KPiBzdWJzZXF1ZW50IGZzIG9wZXJhdGlvbnMg
d2lsbCBmYWlsIHdpdGggLUVOT0tFWS4NCj4gDQo+ICQgZWNobyAyID4gL3N5cy9rZXJuZWwvc2Vj
dXJpdHkvaW50ZWdyaXR5L2V2bS9ldm0NCj4gJCB0b3VjaCB0ZXN0LnR4dA0KPiBbICA1MjYuOTc2
ODU1XVsgVDU3NzFdIGV2bTogSE1BQyBrZXkgaXMgbm90IHNldA0KPiBbICA1MjYuOTc3ODkyXVsg
VDU3NzFdIGV2bTogaW5pdF9kZXNjIGZhaWxlZA0KPiB0b3VjaDogY2Fubm90IHRvdWNoICd0ZXN0
LnR4dCc6IFJlcXVpcmVkIGtleSBub3QgYXZhaWxhYmxlDQo+IA0KPiBJcyB0aGlzIGEgZGVzaXJl
ZCBiZWhhdmlvcj8gU2hvdWxkIHRoZXJlIGJlIGEgY2hlY2sgaW4gZXZtX3dyaXRlX2tleSgpDQo+
IGZvciBsb2FkZWQga2V5cyAoZW5jcnlwdGVkIGV2bS1rZXksIGtleXMgaW4gX2V2bSwgX2ltYSBr
ZXlyaW5ncykgYmVmb3JlDQo+IGNoYW5naW5nIHRoZSBldm1faW5pdGlhbGl6ZWQgYml0PyBJcyBp
dCBjb3JyZWN0IHRvIHNldCBzZWNvbmQgYml0IHdpdGhvdXQNCj4gZmlyc3QgYml0Pw0KDQpIaSBE
ZW5pcw0KDQpjYW4geW91IHBsZWFzZSB0cnkgdGhpcyBwYXRjaD8NCg0KaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGludXgtaW50ZWdyaXR5LzIwMjAwNjE4MTYwMTMzLjkzNy0xLXJvYmVydG8uc2Fz
c3VAaHVhd2VpLmNvbS8NCg0KVGhhbmtzDQoNClJvYmVydG8NCg0KSFVBV0VJIFRFQ0hOT0xPR0lF
UyBEdWVzc2VsZG9yZiBHbWJILCBIUkIgNTYwNjMNCk1hbmFnaW5nIERpcmVjdG9yOiBMaSBQZW5n
LCBMaSBKaWFuLCBTaGkgWWFubGkNCg==
