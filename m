Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5927D279485
	for <lists+linux-integrity@lfdr.de>; Sat, 26 Sep 2020 01:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbgIYXG1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Sep 2020 19:06:27 -0400
Received: from mail-dm6nam10on2060.outbound.protection.outlook.com ([40.107.93.60]:2720
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729318AbgIYXG0 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Sep 2020 19:06:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoQ8WWHRvlppk9p6OIgE47zPK5dITsnlAhcrLx7ZcHp3oMEvmnq4UHM2y4sWTiLwYLvV231202DjJcuArUFRLmk8UFyrbkc+dqCdtpcXFjk1e3w6xW7oiLrcegUTTZJsBO9pxIIerA3QhrrAazOzt2qEnrJOj/mMAwYWOyEvr472A4MS4S5O3P0StvgLbShAd7P+x+luJyE2ekASUS15XaRxzd4xIUOfentT/HCvOuFHsb7B5X5HyOPwsFvf9meOyCiX1xOudoCqyMqm3BLOYXDSrAC3uFMozbIJwbkdvUpT0M+A483e3/knWKezLObKPjOW0yfBfFzzXY2M83ugZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwjItsUoy+iWXg6QoUpN7+XUpU0aFKSZD2UaZlE8rHY=;
 b=Inn+hD5EGjampkFXcc6I/7qhVVpyiE/K9PZNNZGxRGuH6IED9xzt1Ujfni7Fkk6mdN2m91uMjZ58OzqtPXIEOAJABmUy0jkoBMg9bwuSJyh9HSrJLDoCNBjuOe8LAz8vzdETqfnrrM29o3PAFwdu4e1fjzssYk2sVYqayuoQbTdonzZI2Bbx/H/DwgbWP9dHRKng0mcgOQRgEgm0RAiUJYr9fO+Yo1NIjYe12AoTdRxWyKklQbZkdwnZ0bavOiNyoANnU12VuebxQsePbSuF+QLg2WGBzIaQMf6XgFPAXcgKJdWSnxGmExbwE1lSnvKwBmZBK9eKit8dAriuRuFBsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=unh.edu; dmarc=pass action=none header.from=unh.edu; dkim=pass
 header.d=unh.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unh.edu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwjItsUoy+iWXg6QoUpN7+XUpU0aFKSZD2UaZlE8rHY=;
 b=FmjjrhfaT0D+u04nmXZkGL3wZBCkee6rRzY3Jblk9eRUYd1pgFSx06oSKe6fXFHAmdk/VWjnf0uarWp11gyaFFw9z+jNi2fkfbvfVFZCU18AYK2AwNjHb7HVEEDko9qz79F+XT/QH+GepvCNmvH3m2OCcZgg90gO2tFEg2jYxNc=
Received: from BL0PR04MB4723.namprd04.prod.outlook.com (2603:10b6:208:4c::28)
 by BL0PR04MB6564.namprd04.prod.outlook.com (2603:10b6:208:17d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.24; Fri, 25 Sep
 2020 23:06:24 +0000
Received: from BL0PR04MB4723.namprd04.prod.outlook.com
 ([fe80::b5f6:f1b4:4060:c220]) by BL0PR04MB4723.namprd04.prod.outlook.com
 ([fe80::b5f6:f1b4:4060:c220%6]) with mapi id 15.20.3412.024; Fri, 25 Sep 2020
 23:06:24 +0000
From:   "Kayaalp, Mehmet" <Mehmet.Kayaalp@unh.edu>
To:     Raphael Gianotti <raphgi@linux.microsoft.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: Fwd: How to extract linux kernel version information from a
 kernel image?
Thread-Topic: Fwd: How to extract linux kernel version information from a
 kernel image?
Thread-Index: AQHWkq4YuYoD2aiBkkqaSuDKTZR0l6l5+5QA
Date:   Fri, 25 Sep 2020 23:06:24 +0000
Message-ID: <a1c877b3-9f99-04a6-2f21-495fc62d0591@unh.edu>
References: <b8e9ee52-c0fd-a6cf-3054-4220636a60e9@linux.microsoft.com>
 <8bc330b9-d680-c00a-4bc1-c35cb21d2b34@linux.microsoft.com>
In-Reply-To: <8bc330b9-d680-c00a-4bc1-c35cb21d2b34@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: linux.microsoft.com; dkim=none (message not signed)
 header.d=none;linux.microsoft.com; dmarc=none action=none
 header.from=unh.edu;
x-originating-ip: [132.177.206.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1976e990-ae5d-444b-73e3-08d861a79fff
x-ms-traffictypediagnostic: BL0PR04MB6564:
x-microsoft-antispam-prvs: <BL0PR04MB656457F234143718CBA48A938E360@BL0PR04MB6564.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GVqAjLn4qH0XIUM1zk2r08YuCJaFEKsya5aEgS/+NSt30rEc7SQa9xrqBm71O6Pcp6/0WZWXhU71Uts+YfzTWOf/zcSF66lJlJEuNRhBe7ZTuVPiV2sBs4hhQVgg65+pHZCOFmis3zUr7IUyz679XN6pIep4o5pWAAAv8KNtBhqRa7qpiC2O+G5a1zDVklvjRJ+p4/CHbUKAecpcirs6a4SbqMra93ZCNGnwrVKPWLZRQ1E3MR3Cn4/MhQBtUFWLTh2/o8JfiZwoHZexXEOsdn3M5c/20BIIm1R/se3PzA/ETsbX4NDF6I82S4aFvEBSWvkL1nIeDcpqYhfPJwEm4Mo17o09cKHaSG0aiITMAnBsc+BqOKw6a2HXdQRC63e8z3Dsw5/jhGSL8T6+3jklWQT5RMWsKvAnpMyEsjMyaKFdk3sG71LmHlgWLAiT2/Ordc4zNaH+WakY5PEJ0+ZghN5H0U7ADikKZJzFQrdWyFaKPD+u/p+V1FPcL1g25tnG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB4723.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(86362001)(966005)(110136005)(36756003)(76116006)(83380400001)(31686004)(71200400001)(66946007)(2616005)(6486002)(8936002)(75432002)(26005)(6512007)(8676002)(186003)(5660300002)(6506007)(64756008)(53546011)(66556008)(66476007)(31696002)(66446008)(2906002)(316002)(478600001)(786003)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: JQ/uOXSL7akTJ4fE5QEpQyFk2iDdSW+YJIcPKrqShqcepEm35w0ubhz4116amUKsZJfYwYiTBczFg1c6jKDRYBKe9x5vm1ocKUzTDI/mV0ldV83CguOv8ZB6MeTNyIHeM+vQE5e9Y3PQTLnNh9+XMblHz5y8SyJQ11vQRk/oaEWmiG7b/z/kSsC30ywBd7WYroh/g6oehyiRqTLL9iQ6LjC5bmWNNFVKOs79nXUrc0jo2ZfgsHufv0lt0BLbJCCHwNrKhQxdEnOPSYAhNUzFu7b4PEAwiXw1ylUQM9t6o+RgwDFgNB9yGSRbBe86uwN5RQxRCxIDUkgTFZipakXjBrP3iubn4qjGBBqCoQi+nndSFYvKf90Sd4ihxd7luAy+dQjyhgRrwP4Ae1DjxeeDLTpPCwaR9bK+YKBEUoCtLcApSnY4H2YTmHtyRMQbDAKRhfDdxKbjQT7DI/Epc470biCY+l7ith4q2NpdiOJtevf1R3kADcuykpM265fzAIeEhXdSWYzhchbNFV3J8z6pTOCOKehRSRgnke84kUnZ44f8dKldt6R5FyRlleI2uXvl88yZncf71hQX0dxr8TD6QewGC1c9FhwSFYRNjiDtrinioBnbz7zLXgRcdDRGnaXDTOsmapa3lJ67VEo87l+wCQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C38E1E79F4A4A94EBDA75EDC988696E5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: unh.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB4723.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1976e990-ae5d-444b-73e3-08d861a79fff
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2020 23:06:24.4156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d6241893-512d-46dc-8d2b-be47e25f5666
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FUNl+F76l1ovblpR5AVYoeZI8aLvln6JCQFC61wBSaduRAmoAea/HhP3vEFopm/i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6564
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

T24gOS8yNC8yMCA0OjA1IFBNLCBSYXBoYWVsIEdpYW5vdHRpIHdyb3RlOg0KPiANCj4gRm9yd2Fy
ZGluZyB0aGlzIGhlcmUgc2luY2UgdGhlIGZpbmFsIGludGVudCBoZXJlIGlzIGFuIElNQSByZWxh
dGVkDQo+IGNoYW5nZSB0byBzZWUgaWYgYW55b25lIGhhcyBhbnkgc3VnZ2VzdGlvbnMuDQo+IA0K
PiANCj4gLS0tLS0tLS0gRm9yd2FyZGVkIE1lc3NhZ2UgLS0tLS0tLS0NCj4gU3ViamVjdDrCoMKg
wqDCoMKgwqDCoCBIb3cgdG8gZXh0cmFjdCBsaW51eCBrZXJuZWwgdmVyc2lvbiBpbmZvcm1hdGlv
biBmcm9tIGEgDQo+IGtlcm5lbA0KPiBpbWFnZT8NCj4gRGF0ZTrCoMKgIEZyaSwgMTggU2VwIDIw
MjAgMTI6NDc6MTMgLTA3MDANCj4gRnJvbTrCoMKgIFJhcGhhZWwgR2lhbm90dGkgPHJhcGhnaUBs
aW51eC5taWNyb3NvZnQuY29tPg0KPiBUbzrCoMKgwqDCoCBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnDQo+IA0KPiANCj4gDQo+IEhpLA0KPiANCj4gSSBoYXZlIGJlZW4gaW52ZXN0aWdhdGlu
ZyBhIHdheSB0byBleHRyYWN0IHRoZSB2ZXJzaW9uIHN0cm9uZyBmcm9tIGENCj4ga2VybmVsIGlt
YWdlIChlLmcuLCB2bWxpbnV4KS4gVGhlIHZlcnNpb24gc3RyaW5nIEkndmUgYmVlbiBsb29raW5n
IGF0IGlzDQo+IGVzc2VudGlhbGx5IHRoZSBsaW51eF9iYW5uZXIgc3ltYm9sLg0KPiANCj4gV2Un
bGwgdXNlIElNQSB0byBtZWFzdXJlIHRoZSB2ZXJzaW9uIHN0cmluZyBvbiB0aGUga2V4ZWMgc3lz
dGVtIGNhbGwsDQo+IHByb3ZpZGluZyBhIHdheSBmb3IgYW4gYXR0ZXN0YXRpb24gc2VydmljZSwg
Zm9yIGluc3RhbmNlLCB0byBhdHRlc3QgdG8NCj4gd2hhdCB2ZXJzaW9uIG9mIHRoZSBrZXJuZWwg
aXMgcnVubmluZyBvbiB0aGUgY2xpZW50Lg0KPiANCj4gSSBoYXZlbid0IGZvdW5kIGEgd2F5IHRv
IGV4dHJhY3QgdGhlIHZlcnNpb24gZnJvbSB0aGUgaW1hZ2UgdGhhdCBpc24ndA0KPiBzaW1wbHkg
c2VhcmNoaW5nIHRoZSB3aG9sZSBpbWFnZSBmb3IgaXQuIEkgd2FzIGhvcGluZyBzb21lb25lIGhl
cmUgbWF5DQo+IGJlIGFibGUgdG8gcG9pbnQgbWUgdG8gYSBiZXR0ZXIgYXBwcm9hY2ggdG8gcmV0
cmlldmUgdGhlIGxpbnV4X2Jhbm5lcg0KPiBzeW1ib2wgdmFsdWUgZnJvbSBhbiBpbWFnZSBvcsKg
IGFueSBleGlzdGluZyBrZXJuZWwgY29kZSB0aGF0IGRvZXMNCj4gc2ltaWxhciBwYXJzaW5nLg0K
PiANCj4gSWYgdGhhdCBtYXR0ZXJzIGZvciBhbnkgc3VnZ2VzdGlvbnMsIG15IGN1cnJlbnQgZm9j
dXMgaXMgb24gQVJNNjQgaW1hZ2VzDQo+IChpZiB0aGUgY29kZSBlbmRzIHVwIGhhdmluZyB0byBi
ZSBhcmNoIHNwZWNpZmljKS4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IC1SYXBoYWVsDQo+IA0KDQpJ
biBMaW51eC94ODYgQm9vdCBQcm90b2NvbCBbMV0sIHRoZSBrZXJuZWwgaGVhZGVyIGNvbnRhaW5z
IGEgcG9pbnRlciB0byANCnRoZSBrZXJuZWxfdmVyc2lvbiBzdHJpbmcgYXQgb2Zmc2V0IDAyMEUg
KDItYnl0ZSB2YWx1ZSk6DQoNCiAgICAgIyBoZXhkdW1wIC1zIDB4MDIwRSAtbiAyIC1lICcvMiAi
JXgiJyANCi9ib290L3ZtbGludXotNS40LjAtNDgtZ2VuZXJpYzsgZWNobw0KICAgICAzOTAwDQoN
ClN0YXJ0aW5nIGFmdGVyIHRoZSBoZWFkZXIgKDUxMiBieXRlcyksIHRoZSBzdHJpbmcgaXMgMHgz
OTAwIGJ5dGVzIGludG8gDQp0aGUgdm1saW51eiBmaWxlOg0KDQogICAgICMgZGQgYnM9MSBza2lw
PSQoKDB4MzkwMCs1MTIpKSBpZj0vYm9vdC92bWxpbnV6LTUuNC4wLTQ4LWdlbmVyaWMgDQp8dHIg
LXMgJ1wwMDAnICdcbid8aGVhZCAtbiAxDQogICAgIDUuNC4wLTQ4LWdlbmVyaWMgKGJ1aWxkZEBs
Y3kwMS1hbWQ2NC0wMTApICM1Mi1VYnVudHUgU01QIFRodSBTZXAgMTAgDQoxMDo1ODo0OSBVVEMg
MjAyMA0KDQpJbiBBUk02NCwgdGhlIHZtbGludXggaXMgc3RyaXBwZWQgb2Ygc3ltYm9scyBhbmQg
Y29tcHJlc3NlZCBpbnRvIHRoZSANCmJ6SW1hZ2UuIFRvIGZpbmQgdGhlIGxpbnV4X2Jhbm5lciwg
U3lzdGVtLm1hcCBmaWxlIGlzIG5lZWRlZDoNCg0KICAgICAjIGdyZXAgJyBsaW51eF9iYW5uZXIk
JyAvYm9vdC9TeXN0ZW0ubWFwLTUuNC4wLTQ4LWdlbmVyaWMNCiAgICAgZmZmZjgwMDAxMGRmMDBk
MCBSIGxpbnV4X2Jhbm5lcg0KDQpUaGUgb2Zmc2V0IGludG8gdGhlIGZpbGUgY2FuIGJlIGZvdW5k
IGJ5IHN1YnRyYWN0aW5nIHRoZSBsb2FkIGFkZHJlc3M6DQoNCiAgICAgIyBncmVwICcgX2hlYWQk
JyAvYm9vdC9TeXN0ZW0ubWFwLTUuNC4wLTQ4LWdlbmVyaWMNCiAgICAgZmZmZjgwMDAxMDA4MDAw
MCB0IF9oZWFkDQoNCiAgICAgIyB6Y2F0IC9ib290L3ZtbGludXotNS40LjAtNDgtZ2VuZXJpYyB8
IGRkIGJzPTEgDQpza2lwPSQoKDB4ZmZmZjgwMDAxMGRmMDBkMC0weGZmZmY4MDAwMTAwODAwMDAp
KSB8IHRyIC1zICdcMDAwJyAnXG4nIHwgDQpoZWFkIC1uIDENCiAgICAgTGludXggdmVyc2lvbiA1
LjQuMC00OC1nZW5lcmljIChidWlsZGRAYm9zMDItYXJtNjQtMDUzKSAoZ2NjIA0KdmVyc2lvbiA5
LjMuMCAoVWJ1bnR1IDkuMy4wLTEwdWJ1bnR1MikpICM1Mi1VYnVudHUgU01QIFRodSBTZXAgMTAg
DQoxMTowMTo1MCBVVEMgMjAyMCAoVWJ1bnR1IDUuNC4wLTQ4LjUyLWdlbmVyaWMgNS40LjYwKQ0K
DQpbMV06IGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwvbGF0ZXN0L3g4Ni9ib290Lmh0
bWwNCg0KTWVobWV0
