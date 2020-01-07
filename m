Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E88D1321BE
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jan 2020 09:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgAGI6E (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Jan 2020 03:58:04 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2230 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725801AbgAGI6E (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Jan 2020 03:58:04 -0500
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 828A1920E8E94F87857C;
        Tue,  7 Jan 2020 08:58:03 +0000 (GMT)
Received: from fraeml701-chm.china.huawei.com (10.206.15.50) by
 LHREML710-CAH.china.huawei.com (10.201.108.33) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 7 Jan 2020 08:58:03 +0000
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Tue, 7 Jan 2020 09:58:02 +0100
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1713.004;
 Tue, 7 Jan 2020 09:58:02 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Ken Goldman <kgold@linux.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: RE: Does IMA support SHA-256 PCR banks?
Thread-Topic: Does IMA support SHA-256 PCR banks?
Thread-Index: AQHVr6ptwzBz7E0SPkqTsqbIGjKxw6e0me/wgBZ7wgCAE/sNUA==
Date:   Tue, 7 Jan 2020 08:58:02 +0000
Message-ID: <522220614fab4beeb5797dd824dddf10@huawei.com>
References: <62e91411-d38d-8b75-bf0e-849fdd3c447f@linux.microsoft.com>
 <36fb73d7534f47b6906c348792bd5d96@huawei.com>
 <1de18a3c-ec1f-3654-0c33-3faa26e4b286@linux.ibm.com>
In-Reply-To: <1de18a3c-ec1f-3654-0c33-3faa26e4b286@linux.ibm.com>
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLZW4gR29sZG1hbiBbbWFpbHRv
Omtnb2xkQGxpbnV4LmlibS5jb21dDQo+IFNlbnQ6IFdlZG5lc2RheSwgRGVjZW1iZXIgMjUsIDIw
MTkgNTo0NyBQTQ0KPiBUbzogUm9iZXJ0byBTYXNzdSA8cm9iZXJ0by5zYXNzdUBodWF3ZWkuY29t
PjsgbGludXgtDQo+IGludGVncml0eUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IERv
ZXMgSU1BIHN1cHBvcnQgU0hBLTI1NiBQQ1IgYmFua3M/DQo+IA0KPiBPbiAxMi8xMS8yMDE5IDM6
NDUgQU0sIFJvYmVydG8gU2Fzc3Ugd3JvdGU6DQo+ID4NCj4gPiBGb3IgdGhlIGZpcnN0IHBhcnQs
IHRoZSBwYXRjaCB3aWxsIGJlIHZlcnkgc2ltcGxlLCBhcyBJTUEgd2lsbCBqdXN0IHF1ZXJ5IHRo
ZQ0KPiBUUE0NCj4gPiB0byBnZXQgdGhlIGxpc3Qgb2YgaGFzaCBhbGdvcml0aG1zIGFuZCB3aWxs
IGNhbGN1bGF0ZSBhbGwgdGhlIGRpZ2VzdHMgaW4NCj4gPiBpbWFfY2FsY19maWVsZF9hcnJheV9o
YXNoKCkuDQo+IA0KPiBUaGlzIHF1ZXJ5IGlzIHByb2JhYmx5IGZvciB0aGUgYWxsb2NhdGVkIFBD
UiBiYW5rcy4gIEkuZS4sIGEgVFBNIG1heQ0KPiBpbXBsZW1lbnQgbW9yZSBoYXNoIGFsZ29yaXRo
bXMgdGhhbiBpdCBhbGxvY2F0ZXMgUENSIGJhbmtzLg0KDQpZZXMsIGNvcnJlY3QuIFRoZSBUUE0g
ZHJpdmVyIGRldGVybWluZXMgdGhlIGFsbG9jYXRlZCBiYW5rcyBhdCBpbml0aWFsaXphdGlvbg0K
dGltZSBhbmQgc3RvcmVzIHRoZW0gaW4gdGhlIHRwbV9jaGlwIHN0cnVjdHVyZSB3aGljaCBpcyBy
ZXRyaWV2ZWQgYnkgSU1BLg0KDQpSb2JlcnRvDQo=
