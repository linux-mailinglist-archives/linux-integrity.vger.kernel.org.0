Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A733F5B4B
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Aug 2021 11:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbhHXJvR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 Aug 2021 05:51:17 -0400
Received: from mail-eopbgr50099.outbound.protection.outlook.com ([40.107.5.99]:46194
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235758AbhHXJvQ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Aug 2021 05:51:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PrQd5c+F0jdJTZJ5IVXoxzJjmTkysZBq9lr/zDIZm9UqcXOaUdYo/x+Nol53YSvxFC1yfqc8zQ39EI3FJEH6Krj8Rp4VUbTq/517ONuFJm7RZYo02CjzB1VRmaHn2uEpvqFZeQq7ZJDCNWsgH/1qr8BTSpK8rTciJTpviMi4QgD7xmVhSCcJuDxOB2cOKZ/WMZLc3UfhAuq9k6VB3OL/uDmqX9RudoxTICCTS7KIUmV/sHkh5wW7xrlfqr4o2ORSPY4Gr0ywUY3eUTSwBXgytsJ2DyVt1nE5yDgCCW8o0SET7JIHmIuOwbz8wBi8zD+q5yg7RQ05j6ttMB+TCs4IyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpHkjONAqVlmbW6DqDAJFET8toAnexYnWA17xBv+CMM=;
 b=dh38T+dPlGKc5w7QXlSJov4TpkuaHrBC42xYD2K/n19l3y05vRXpJepzpIjg2uvj9d4rsNgL6ndj+WK5DGUutlKRioPM19fNvrqefDNBIUnANWLgMg1c3vO0EgfrFi5ohpRu16Cs+qzyzuuuXgmk+urm1qrw/SQlvSNfpWCFmTmMVsVynFTublDqe49ZRXrFBazWfn/vHxdZdcO8XReIREgPPLi4KJ/L+meGzNNlEUaC16QxUO4P6RsWB1m2VaCa5soM3GCvpByuzp485U78tBYGMvsAoO8yoC9ZMoyPACxcVIFjRvX4hzMWFt434SzEaT8fg8mKyueulTDixqSqIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpHkjONAqVlmbW6DqDAJFET8toAnexYnWA17xBv+CMM=;
 b=HZjrH4KKi7S5sCZ5Qxum7Rh9kW+/aUhrCWNQVre1rozSo0piWFCU3WLojGRItlkIhwi7aK0t/sGiB3Tk9OoRKqT9uS/BPSRcfgd05aQK5thHYpwB5BOKp9DenW7Cxh6AY9JA0G0DIylLcORI/pik95Xr3zCR0lwtjXz4VzrYCME=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM9PR09MB5154.eurprd09.prod.outlook.com
 (2603:10a6:20b:30d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Tue, 24 Aug
 2021 09:50:30 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4436.025; Tue, 24 Aug 2021
 09:50:30 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     liqiong <liqiong@nfschina.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>
CC:     "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ima: fix deadlock within "ima_match_policy" function.
Thread-Topic: [PATCH] ima: fix deadlock within "ima_match_policy" function.
Thread-Index: AQHXmMZhoZvF6mt0r0yBn96FQ0LRM6uCaWSA
Date:   Tue, 24 Aug 2021 09:50:30 +0000
Message-ID: <e720e88e-ebfa-56df-6048-f2da0b8fa2a0@viveris.fr>
References: <20210819101529.28001-1-liqiong@nfschina.com>
 <20210824085747.23604-1-liqiong@nfschina.com>
In-Reply-To: <20210824085747.23604-1-liqiong@nfschina.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nfschina.com; dkim=none (message not signed)
 header.d=none;nfschina.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4181788f-9df5-4296-ffae-08d966e49be2
x-ms-traffictypediagnostic: AM9PR09MB5154:
x-microsoft-antispam-prvs: <AM9PR09MB5154DC8A686BE37676D0341994C59@AM9PR09MB5154.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:204;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X6h+EJsJMqY3RflgNnYghpRbsaZqPLo36ZUk4kQjkzvEb4gL6eSrdqqyTPl82slX+wQAVeimwtQnupU9SRt+bRrtB1bkfsMUdg4MBYdyOqvFdGSgR3s5y/0OazxB9GH6x4lK3iIlItTtp77MjppKz3RioQVxeGVl5ldV23a+xsL9zPcrH5LmT0ILj+PMo+ysFVrtX8zoyzVA+DhrB83ERJ17knCGWP3CwB9+rYFoekeKtkadJ5f1re0Y2xgou80fBuam4+wqwK/v5UdYCmlKtsy82MsCY6g8B9Uv0Hlf8gQmFqcJfVIPfrpCXAFFNtbOIpmDPRQrPE6eylacvf5jJCgQzUGbjvsc/uovn/k7CLhE6HvqwaeiQINJLKPYFTwnzpS5bY5bnLn9e1trdei/Q/HWVGyca8d4Ulp7LOTe4iB4AlFQKEALYXJs6cvlJ/CLKUysnNhw7KXhtXe85hlWYYNkjHkw1imtbMBKXz3hHo5xRrzZivB0bRo55tfCZnIRZ1EuNpLy8mBGnPT/YR/x34xW6CCndjP+xhahqJaOb+69fAMJs5P0blTvfcfAkaeGPgB5/TjQ1E8kIqRCiCZxB6Uie4tDfIO4b7SUMB/gSy5eferlCTXnzZLHVpmV/C/3hzpX/jQpRCm/bJ15V3iEa5a6zzHty9j1BOpqgqrqPSHntqySeiYLk8ilvGIq4RqPc6k/L3x6eMCLrCy4dorRZWDC5qqyKLG00hz9oLnBuII=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(39840400004)(376002)(346002)(66446008)(64756008)(66556008)(66476007)(66946007)(86362001)(54906003)(76116006)(110136005)(478600001)(91956017)(6506007)(4326008)(36756003)(71200400001)(316002)(38100700002)(2616005)(122000001)(31686004)(83380400001)(186003)(8936002)(2906002)(31696002)(5660300002)(6512007)(6486002)(26005)(8676002)(53546011)(38070700005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWppeHRKTUMvUU9aQk9RQllTVFBKMzRXOTM4Z1B1RkZmU1JhR2pvak1UWmZM?=
 =?utf-8?B?VG1XKzZVNi9DWHkyb0RaYndGaUt3SW1TNW9YcXpUZitwbWhZcDRLdVlFZDFG?=
 =?utf-8?B?Ny8rR3E1cHpNUXphVk9wcTBuTGdHYTFtdEZPNnc0M0wwd3dWOExwSGZWR3B1?=
 =?utf-8?B?T1hUTUN6Q0NYMElUeTZXK1N5a00vcjRLRkNNVzJmWlJGRHByT2I0SEFscTNn?=
 =?utf-8?B?Y1U2OTA2TUIrNWtpUGRlK3dCbWR6OUYzcjZyRlpmVnplUlkxalhmVTdpLy9h?=
 =?utf-8?B?K1NoNjhITU9UZHl6YkpnNGFSYStSQTRwbmxRRlFDRGhmdWR4Wkx5a2NrSWtV?=
 =?utf-8?B?cnRTb1lSUmhscTUvZTFPbGVsSDdjc2k4cS9qSzFyRVdmR0gwaUo4NzNjSFUv?=
 =?utf-8?B?b0ZaMk8zMENzTXo0TGZCVzA0NGV1M3hOblNLNEJaeklabjVFakFtbUVGMG0w?=
 =?utf-8?B?cm9ETkpySFVad1NtRDQ0ZTN3dG5rSjJqS2ZkbENxa0l1RHYyd1UxOWdacVJB?=
 =?utf-8?B?QUNselhBdTMwajlUU1paVWFpckxsT25pdzVGazZUNXpBY2xiVkREY1J1RUk2?=
 =?utf-8?B?QTk4NEZCWXdkUkZydTVMSXl2b1N1MnZ6T3BuelFieXpaQVNCd2JsZ0FzY3ZS?=
 =?utf-8?B?aE5LaThzUzlvSllOMmJ3ZHdUd1VGamkvNUYzbzh5K1R1WDBMYzBLbWYvMGJI?=
 =?utf-8?B?ZHNxZWQ4aE55TFMvd3lVVWxEYVdQKys2azNtMFhsTktGaFc4MTV3S0ZPcUgr?=
 =?utf-8?B?elFtN0pxWDFFQVdBYWtqbzdGazd2UTNUZDlvS1dmZ2tLYzZ5MndBdjk3cG5V?=
 =?utf-8?B?cXk4aGRUOXdUMUhYWHV3Vy96Uy9wTFdZTUdBZlJsdzlNY1FFKzROOVhXWmpJ?=
 =?utf-8?B?dDdvNjJDRytYMG12Z0ptbGE3TGxsZGpLOHV2dVc4bHRRWHp2ZXRvUkZkQldv?=
 =?utf-8?B?QklKSFVuVFlTbDBFbVVaa0x1NkJkN0xLYy9wajkxWlljKzJDZFE3ZEJEV08r?=
 =?utf-8?B?WTJaYnp6UXl3N2ZOUldUVWJwU1JrVjFzY1ptUHVPb3pTSi92SGpDM2kyQnFs?=
 =?utf-8?B?MklWUHdNM29VK3VEUnZ0SmF1NFZuOHY2N3N3S3JiSU1FNmlZamN4U0JsWXlk?=
 =?utf-8?B?V0tWSk8wQkF3QVBLTnhjQUtoWUF4QVg4YXVnaDlGWUZ3ZGp0ekJiV3BMUms5?=
 =?utf-8?B?Y1BvRjNtZysrdXUrSDdNNHVyS3JnSjJ5N3FEOVNoL1VSZlJ1M3NReVJKOUdv?=
 =?utf-8?B?YXVBNDZ3VDlhZ1c1OStZZ0g5SjhQNXdWN0NMTkgwZlFKS1BHTTdlZG5LbTRw?=
 =?utf-8?B?WWFBNDMxeHV0SjJlUkZ6ZTdJZFhyNWpaZS9ZYU9RWUxnbjZHazQ1THZ3aWhF?=
 =?utf-8?B?UFVPYTkwUlEyeVN1bUhmb0FabFJTdE1SZzJCOWJKVHZzQkkyMGJLY3ZPWnJw?=
 =?utf-8?B?MTVubkJlSk4wbWRjYzRPMGN2OWk5T2tTWENJMU9LTDUzeWpwNXpYNm5jdGor?=
 =?utf-8?B?aFNydjc2Vnp1TDg0NnA3TVJlSGF3aTlla1VEc2RZTkgrVTl3dW05RnVuK1Vv?=
 =?utf-8?B?Z0RobWEyeHJ5L0htK3RPRGRYUEhJU3FQdzVEKzEraS93RnZyc3BCdTBpcmll?=
 =?utf-8?B?V0xvQ29pUW4yUFZIclhXbGFOeWZEN3d0ZFFhZnlSRGRDL0xvSVgvcWVTSDQr?=
 =?utf-8?B?QW9sb0U3UFh5a3p0MitZWDlvRzZpcWdIdjEvRi9uN0VFckZzY2hVNjQya0ZL?=
 =?utf-8?Q?ceksBWn1tn+McZr3bIAY+I9KNJKP2U9UUcf2bVI?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE46762D561D4543A860840591EEFBE0@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4181788f-9df5-4296-ffae-08d966e49be2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2021 09:50:30.2538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lcp2aRAuu2YVU6j0FdXo3e804KH4N9iZa+YSafki/fKGEH7mvMOfDw0iP+cgsXkOyqfnCZ4yLnsMdL+uzIMqZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR09MB5154
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

SGkgbGlxaW9uZywNCg0KT24gOC8yNC8yMSAxMDo1NyBBTSwgbGlxaW9uZyB3cm90ZToNCj4gV2hl
biAiaW1hX21hdGNoX3BvbGljeSIgaXMgbG9vcGluZyB3aGlsZSAiaW1hX3VwZGF0ZV9wb2xpY3ki
IGNoYW5ncw0KDQpTbWFsbCB0eXBvOiAiY2hhbmdlcyIvInVwZGF0ZXMiDQoNCj4gdGhlIHZhcmlh
YmxlICJpbWFfcnVsZXMiLCB0aGVuICJpbWFfbWF0Y2hfcG9saWN5IiBtYXkgY2FuJ3QgZXhpdA0K
PiBsb29wLCBGaW5hbGx5IGNhdXNlIFJDVSBDUFUgU3RhbGwgV2FybmluZ3M6ICJyY3Vfc2NoZWQg
ZGV0ZWN0ZWQNCj4gc3RhbGwgb24gQ1BVIC4uLiIuDQoNClRoaXMgY291bGQgcGVyaGFwcyBiZSBy
ZXBocmFzZWQgdG8gc29tZXRoaW5nIGxpa2U6DQoiIiINCmltYV9tYXRjaF9wb2xpY3koKSBjYW4g
bG9vcCBvbiB0aGUgcG9saWN5IHJ1bGVzZXQgd2hpbGUNCmltYV91cGRhdGVfcG9saWN5KCkgdXBk
YXRlcyB0aGUgdmFyaWFibGUgImltYV9ydWxlcyIuDQpUaGlzIGNhbiBsZWFkIHRvIGEgc2l0dWF0
aW9uIHdoZXJlIGltYV9tYXRjaF9wb2xpY3koKQ0KY2FuJ3QgZXhpdCB0aGUgJ2xpc3RfZm9yX2Vh
Y2hfZW50cnlfcmN1JyBsb29wLCBjYXVzaW5nDQpSQ1Ugc3RhbGxzICgicmN1X3NjaGVkIGRldGVj
dGVkIHN0YWxsIG9uIENQVSAuLi4iKS4NCiIiIg0KDQoNCj4gDQo+IFRoZSBwcm9ibGVtIGlzIGxp
bWl0ZWQgdG8gdHJhbnNpdGlvbmluZyBmcm9tIHRoZSBidWlsdGluIHBvbGljeSB0bw0KPiB0aGUg
Y3VzdG9tIHBvbGljeS4gRWcuIEF0IGJvb3QgdGltZSwgc3lzdGVtZC1zZXJ2aWNlcyBhcmUgYmVp
bmcNCj4gY2hlY2tlZCB3aXRoaW4gImltYV9tYXRjaF9wb2xpY3kiLCBhdCB0aGUgc2FtZSB0aW1l
LCB0aGUgdmFyaWFibGUNCj4gImltYV9ydWxlcyIgaXMgY2hhbmdlZCBieSBhbm90aGVyIHNlcnZp
Y2UuDQoNCkZvciB0aGUgc2Vjb25kIHNlbnRlbmNlLCBjb25zaWRlciBzb21ldGhpbmcgaW4gdGhl
IGxpa2VzIG9mOg0KIlRoaXMgcHJvYmxlbSBjYW4gaGFwcGVuIGluIHByYWN0aWNlOiB1cGRhdGlu
ZyB0aGUgSU1BIHBvbGljeQ0KaW4gdGhlIGJvb3QgcHJvY2VzcyB3aGlsZSBzeXN0ZW1kLXNlcnZp
Y2VzIGFyZSBiZWluZyBjaGVja2VkDQpoYXZlIGJlZW4gb2JzZXJ2ZWQgdG8gdHJpZ2dlciB0aGlz
IGlzc3VlLiIuDQoNCg0KWW91ciBjb21taXQgbWVzc2FnZSBpcyBhbHNvIHN1cHBvc2VkIHRvIGV4
cGxhaW4gd2hhdCB5b3UgYXJlIGRvaW5nLA0KdXNpbmcgdGhlIGltcGVyYXRpdmUgZm9ybSAoKHNl
ZSAnRG9jdW1lbnRhdGlvbi9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5yc3QnKToNCiIiIg0K
RGVzY3JpYmUgeW91ciBjaGFuZ2VzIGluIGltcGVyYXRpdmUgbW9vZCwgZS5nLiAibWFrZSB4eXp6
eSBkbyBmcm90eiINCmluc3RlYWQgb2YgIltUaGlzIHBhdGNoXSBtYWtlcyB4eXp6eSBkbyBmcm90
eiIgb3IgIltJXSBjaGFuZ2VkIHh5enp5DQp0byBkbyBmcm90eiIsIGFzIGlmIHlvdSBhcmUgZ2l2
aW5nIG9yZGVycyB0byB0aGUgY29kZWJhc2UgdG8gY2hhbmdlDQppdHMgYmVoYXZpb3VyLg0KIiIi
DQoNCk1heWJlIGFkZCBhIHBhcmFncmFwaCB3aXRoIHNvbWV0aGluZyBsaWtlICJGaXggbG9ja2lu
ZyBieSBpbnRyb2R1Y2luZyAuLi4uIj8NCg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBsaXFpb25n
IDxsaXFpb25nQG5mc2NoaW5hLmNvbT4NCj4gLS0tDQo+ICBzZWN1cml0eS9pbnRlZ3JpdHkvaW1h
L2ltYV9wb2xpY3kuYyB8IDE3ICsrKysrKysrKysrKy0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MTIgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9zZWN1
cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9wb2xpY3kuYyBiL3NlY3VyaXR5L2ludGVncml0eS9pbWEv
aW1hX3BvbGljeS5jDQo+IGluZGV4IGZkNWQ0NmU1MTFmMS4uZTkyYjE5N2JmZDNjIDEwMDY0NA0K
PiAtLS0gYS9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9wb2xpY3kuYw0KPiArKysgYi9zZWN1
cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9wb2xpY3kuYw0KPiBAQCAtNjYyLDEyICs2NjIsMTQgQEAg
aW50IGltYV9tYXRjaF9wb2xpY3koc3RydWN0IHVzZXJfbmFtZXNwYWNlICptbnRfdXNlcm5zLCBz
dHJ1Y3QgaW5vZGUgKmlub2RlLA0KPiAgew0KPiAgCXN0cnVjdCBpbWFfcnVsZV9lbnRyeSAqZW50
cnk7DQo+ICAJaW50IGFjdGlvbiA9IDAsIGFjdG1hc2sgPSBmbGFncyB8IChmbGFncyA8PCAxKTsN
Cj4gKwlzdHJ1Y3QgbGlzdF9oZWFkICppbWFfcnVsZXNfdG1wOw0KPiAgDQo+ICAJaWYgKHRlbXBs
YXRlX2Rlc2MgJiYgISp0ZW1wbGF0ZV9kZXNjKQ0KPiAgCQkqdGVtcGxhdGVfZGVzYyA9IGltYV90
ZW1wbGF0ZV9kZXNjX2N1cnJlbnQoKTsNCj4gIA0KPiAgCXJjdV9yZWFkX2xvY2soKTsNCj4gLQls
aXN0X2Zvcl9lYWNoX2VudHJ5X3JjdShlbnRyeSwgaW1hX3J1bGVzLCBsaXN0KSB7DQo+ICsJaW1h
X3J1bGVzX3RtcCA9IHJjdV9kZXJlZmVyZW5jZShpbWFfcnVsZXMpOw0KPiArCWxpc3RfZm9yX2Vh
Y2hfZW50cnlfcmN1KGVudHJ5LCBpbWFfcnVsZXNfdG1wLCBsaXN0KSB7DQo+ICANCj4gIAkJaWYg
KCEoZW50cnktPmFjdGlvbiAmIGFjdG1hc2spKQ0KPiAgCQkJY29udGludWU7DQo+IEBAIC05MTks
OCArOTIxLDggQEAgdm9pZCBpbWFfdXBkYXRlX3BvbGljeSh2b2lkKQ0KPiAgDQo+ICAJaWYgKGlt
YV9ydWxlcyAhPSBwb2xpY3kpIHsNCj4gIAkJaW1hX3BvbGljeV9mbGFnID0gMDsNCj4gLQkJaW1h
X3J1bGVzID0gcG9saWN5Ow0KPiAgDQo+ICsJCXJjdV9hc3NpZ25fcG9pbnRlcihpbWFfcnVsZXMs
IHBvbGljeSk7DQo+ICAJCS8qDQo+ICAJCSAqIElNQSBhcmNoaXRlY3R1cmUgc3BlY2lmaWMgcG9s
aWN5IHJ1bGVzIGFyZSBzcGVjaWZpZWQNCj4gIAkJICogYXMgc3RyaW5ncyBhbmQgY29udmVydGVk
IHRvIGFuIGFycmF5IG9mIGltYV9lbnRyeV9ydWxlcw0KPiBAQCAtMTY0OSw5ICsxNjUxLDExIEBA
IHZvaWQgKmltYV9wb2xpY3lfc3RhcnQoc3RydWN0IHNlcV9maWxlICptLCBsb2ZmX3QgKnBvcykN
Cj4gIHsNCj4gIAlsb2ZmX3QgbCA9ICpwb3M7DQo+ICAJc3RydWN0IGltYV9ydWxlX2VudHJ5ICpl
bnRyeTsNCj4gKwlzdHJ1Y3QgbGlzdF9oZWFkICppbWFfcnVsZXNfdG1wOw0KPiAgDQo+ICAJcmN1
X3JlYWRfbG9jaygpOw0KPiAtCWxpc3RfZm9yX2VhY2hfZW50cnlfcmN1KGVudHJ5LCBpbWFfcnVs
ZXMsIGxpc3QpIHsNCj4gKwlpbWFfcnVsZXNfdG1wID0gcmN1X2RlcmVmZXJlbmNlKGltYV9ydWxl
cyk7DQo+ICsJbGlzdF9mb3JfZWFjaF9lbnRyeV9yY3UoZW50cnksIGltYV9ydWxlc190bXAsIGxp
c3QpIHsNCj4gIAkJaWYgKCFsLS0pIHsNCj4gIAkJCXJjdV9yZWFkX3VubG9jaygpOw0KPiAgCQkJ
cmV0dXJuIGVudHJ5Ow0KPiBAQCAtMTY3MCw3ICsxNjc0LDggQEAgdm9pZCAqaW1hX3BvbGljeV9u
ZXh0KHN0cnVjdCBzZXFfZmlsZSAqbSwgdm9pZCAqdiwgbG9mZl90ICpwb3MpDQo+ICAJcmN1X3Jl
YWRfdW5sb2NrKCk7DQo+ICAJKCpwb3MpKys7DQo+ICANCj4gLQlyZXR1cm4gKCZlbnRyeS0+bGlz
dCA9PSBpbWFfcnVsZXMpID8gTlVMTCA6IGVudHJ5Ow0KPiArCXJldHVybiAoJmVudHJ5LT5saXN0
ID09ICZpbWFfZGVmYXVsdF9ydWxlcyB8fA0KPiArCQkmZW50cnktPmxpc3QgPT0gJmltYV9wb2xp
Y3lfcnVsZXMpID8gTlVMTCA6IGVudHJ5Ow0KPiAgfQ0KPiAgDQo+ICB2b2lkIGltYV9wb2xpY3lf
c3RvcChzdHJ1Y3Qgc2VxX2ZpbGUgKm0sIHZvaWQgKnYpDQo+IEBAIC0xODcyLDYgKzE4NzcsNyBA
QCBib29sIGltYV9hcHByYWlzZV9zaWduYXR1cmUoZW51bSBrZXJuZWxfcmVhZF9maWxlX2lkIGlk
KQ0KPiAgCXN0cnVjdCBpbWFfcnVsZV9lbnRyeSAqZW50cnk7DQo+ICAJYm9vbCBmb3VuZCA9IGZh
bHNlOw0KPiAgCWVudW0gaW1hX2hvb2tzIGZ1bmM7DQo+ICsJc3RydWN0IGxpc3RfaGVhZCAqaW1h
X3J1bGVzX3RtcDsNCj4gIA0KPiAgCWlmIChpZCA+PSBSRUFESU5HX01BWF9JRCkNCj4gIAkJcmV0
dXJuIGZhbHNlOw0KPiBAQCAtMTg3OSw3ICsxODg1LDggQEAgYm9vbCBpbWFfYXBwcmFpc2Vfc2ln
bmF0dXJlKGVudW0ga2VybmVsX3JlYWRfZmlsZV9pZCBpZCkNCj4gIAlmdW5jID0gcmVhZF9pZG1h
cFtpZF0gPzogRklMRV9DSEVDSzsNCj4gIA0KPiAgCXJjdV9yZWFkX2xvY2soKTsNCj4gLQlsaXN0
X2Zvcl9lYWNoX2VudHJ5X3JjdShlbnRyeSwgaW1hX3J1bGVzLCBsaXN0KSB7DQo+ICsJaW1hX3J1
bGVzX3RtcCA9IHJjdV9kZXJlZmVyZW5jZShpbWFfcnVsZXMpOw0KPiArCWxpc3RfZm9yX2VhY2hf
ZW50cnlfcmN1KGVudHJ5LCBpbWFfcnVsZXNfdG1wLCBsaXN0KSB7DQo+ICAJCWlmIChlbnRyeS0+
YWN0aW9uICE9IEFQUFJBSVNFKQ0KPiAgCQkJY29udGludWU7DQo+ICANCj4gDQoNCkkgaGF2ZW4n
dCB0ZXN0ZWQgdGhlIHBhdGNoIG15c2VsZiwgYnV0IHRoZSBjb2RlIGRpZmYgbG9va3MgZmluZSB0
byBtZS4NCg0KVGhhbmtzLA0KU2ltb24=
