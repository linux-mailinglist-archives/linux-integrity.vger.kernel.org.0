Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F129D13A954
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2020 13:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgANMcl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Jan 2020 07:32:41 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2558 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726197AbgANMcl (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Jan 2020 07:32:41 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 9E712B09CA36511E155E;
        Tue, 14 Jan 2020 20:32:39 +0800 (CST)
Received: from dggeme704-chm.china.huawei.com (10.1.199.100) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 14 Jan 2020 20:32:39 +0800
Received: from dggeme758-chm.china.huawei.com (10.3.19.104) by
 dggeme704-chm.china.huawei.com (10.1.199.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Tue, 14 Jan 2020 20:32:39 +0800
Received: from dggeme758-chm.china.huawei.com ([10.6.80.69]) by
 dggeme758-chm.china.huawei.com ([10.6.80.69]) with mapi id 15.01.1713.004;
 Tue, 14 Jan 2020 20:32:38 +0800
From:   wanghongzhe <wanghongzhe@huawei.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
CC:     "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhangchenfeng (EulerOS)" <zhangchenfeng1@huawei.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIHRwbTogdHBtX3Rpc19zcGk6IHNldCBjc19jaGFu?=
 =?utf-8?Q?ge_=3D_0_when_timesout?=
Thread-Topic: [PATCH] tpm: tpm_tis_spi: set cs_change = 0 when timesout
Thread-Index: AQHVytGyX2EFNqtnOEyuh2t0MfGBXafpjBcAgACHZmA=
Date:   Tue, 14 Jan 2020 12:32:38 +0000
Message-ID: <6ab9e1f1f59c4f5ba04570bc870515aa@huawei.com>
References: <1579005119-16318-1-git-send-email-wanghongzhe@huawei.com>
 <6671d791-e92b-8bfc-0f4f-d80f7e2b2fc2@molgen.mpg.de>
In-Reply-To: <6671d791-e92b-8bfc-0f4f-d80f7e2b2fc2@molgen.mpg.de>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.184.190.130]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

U29ycnksIEkgaGF2ZSBjaGFuZ2UgdGhlc2UgbWlzdGFrZXMgaW4gYW5vdGhlciBlbWFpbHMNCg0K
LS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0K5Y+R5Lu25Lq6OiBQYXVsIE1lbnplbCBbbWFpbHRvOnBt
ZW56ZWxAbW9sZ2VuLm1wZy5kZV0gDQrlj5HpgIHml7bpl7Q6IDIwMjDlubQx5pyIMTTml6UgMjA6
MTMNCuaUtuS7tuS6ujogd2FuZ2hvbmd6aGUgPHdhbmdob25nemhlQGh1YXdlaS5jb20+DQrmioTp
gIE6IHBldGVyaHVld2VAZ214LmRlOyBsaW51eC1pbnRlZ3JpdHlAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBaaGFuZ2NoZW5mZW5nIChFdWxlck9TKSA8emhh
bmdjaGVuZmVuZzFAaHVhd2VpLmNvbT4NCuS4u+mimDogUmU6IFtQQVRDSF0gdHBtOiB0cG1fdGlz
X3NwaTogc2V0IGNzX2NoYW5nZSA9IDAgd2hlbiB0aW1lc291dA0KDQpEZWFyIHdhbmdob25nemhl
LA0KDQoNCk9uIDIwMjAtMDEtMTQgMTM6MzEsIHdhbmdob25nemhlIHdyb3RlOg0KDQpZb3VyIG1l
c3NhZ2UgaXMgZnJvbSB0aGUgZnV0dXJlIChEYXRlOiAgIFR1ZSwgMTQgSmFuIDIwMjAgMjA6MzE6
NTkgKzA4MDApLg0KDQpQbGVhc2UgZml4IHlvdXIgY2xvY2suIDstKQ0KDQpTdWJqZWN0OiBTZXQg
Y3NfY2hhbmdlIHRvIDAgaW4gY2FzZSBvZiB0aW1lLW91dA0KDQo+IHdoZW4gaSByZWFjaCBUUE1f
UkVUUlksIHRoZSBjcyBjYW5ub3QgIGNoYW5nZSBiYWNrIHRvICdoaWdoJy5TbyB0aGUgVFBNIGNo
aXBzIHRoaW5rcyB0aGlzIGNvbW11bmljYXRpb24gaXMgbm90IG92ZXIuIA0KDQpTcGFjZSBhZnRl
ciB0aGUgZG90L3BlcmlvZC4NCg0KPiBBbmQgbmV4dCB0aW1lcyBjb21tdW5pY2F0aW9uIGNhbm5v
dCBiZSBlZmZlY3RpdmUgYmVjYXVzZSB0aGUgY29tbXVuaWNhdGlvbnMgbWl4ZWQgdXAgd2l0aCB0
aGUgbGFzdCB0aW1lLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogd2FuZ2hvbmd6aGUgPHdhbmdob25n
emhlQGh1YXdlaS5jb20+DQoNCklmIHlvdeKAmWQgY29uZmlndXJlIHlvdXIgbmFtZSBhcyBXYW5n
IEhvbmd6aGUgKG9yIHNpbWlsYXIpIGl04oCZZCBiZSBtdWNoDQphcHByZWNpYXRlZCAoYGdpdCBj
b25maWcgLS1nbG9iYWwgdXNlci5uYW1lICJXYW5nIOKApiIpLg0KDQpb4oCmXQ0KDQoNCktpbmQg
cmVnYXJkcywNCg0KUGF1bA0KDQo=
