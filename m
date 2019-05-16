Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0461FD06
	for <lists+linux-integrity@lfdr.de>; Thu, 16 May 2019 03:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfEPBqk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 May 2019 21:46:40 -0400
Received: from mail-eopbgr800099.outbound.protection.outlook.com ([40.107.80.99]:33463
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726878AbfEPBAS (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 May 2019 21:00:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=TDhBOZQYZcgMY3BrZ051d/Z0ZspZgL7N0/Qg2GypJ6K7DWxd0cW/xABvQB9RKXmUgTmZ8oSK7yVh57FbW7xRyClv4mqbtasBFqUgmLsZBzYyVWHwqkaYwwVwrWbH1LG0nutYA4EufSLMKtGrLujfVnMckMO8+cvJSC4DyX4HIC4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uS3ZLtcUf5PHhSuvLuh1Z04+j72FbftBKfsh0TfueXo=;
 b=Wtr5U2r+o117SwJo7EhbFJMhbq0TiJjlnm0eaOAqsTqbDuiS9ocJ/74J2UxXz5Dv0dcJWoI5yMEE+79L5vga2sfNuNrWHSJZepLqKcQW2g9KGoEb/h8cj7p5IfUXazURZRHgEgAmLglDSCokd2Z8Q6cebhgFHGg7SbrQSMfEBLk=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uS3ZLtcUf5PHhSuvLuh1Z04+j72FbftBKfsh0TfueXo=;
 b=Dnp/7aNiG0OSyikzaXxxpE3hPzfRYIv4Rjw0W9094WAa7KV52ovnoG4ipOe0mUP/UdYYHu7/ZRsc8sSg8mnA0GERoahULnf1SxlaxWqBBz5wqGqTPbWk+s7bDaypCDe/PLJEKj3RcViTnRD6menB6sOWjFM9JtwMovcQa5l8hwc=
Received: from CY4PR21MB0279.namprd21.prod.outlook.com (2603:10b6:903:bb::17)
 by CY4PR21MB0694.namprd21.prod.outlook.com (2603:10b6:903:13b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1922.5; Thu, 16 May
 2019 01:00:12 +0000
Received: from CY4PR21MB0279.namprd21.prod.outlook.com
 ([fe80::9843:add4:f5b:8fc1]) by CY4PR21MB0279.namprd21.prod.outlook.com
 ([fe80::9843:add4:f5b:8fc1%5]) with mapi id 15.20.1922.002; Thu, 16 May 2019
 01:00:12 +0000
From:   Thirupathaiah Annapureddy <thiruan@microsoft.com>
To:     Sumit Garg <sumit.garg@linaro.org>, Sasha Levin <sashal@kernel.org>
CC:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "corbet@lwn.net" <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Microsoft Linux Kernel List <linux-kernel@microsoft.com>,
        "Bryan Kelly (CSI)" <bryankel@microsoft.com>
Subject: RE: [PATCH v3 0/2] ftpm: a firmware based TPM driver
Thread-Topic: [PATCH v3 0/2] ftpm: a firmware based TPM driver
Thread-Index: AQHU86PZuIUdaSF7RUeiIyc+iLswraZgEJkAgAE/tQCACd+EAIAAbVeAgAFpYfA=
Date:   Thu, 16 May 2019 01:00:12 +0000
Message-ID: <CY4PR21MB0279339E8B0A15414C8F9E14BC0A0@CY4PR21MB0279.namprd21.prod.outlook.com>
References: <20190415155636.32748-1-sashal@kernel.org>
 <20190507174020.GH1747@sasha-vm> <20190508124436.GE7642@linux.intel.com>
 <20190514193056.GN11972@sasha-vm>
 <CAFA6WYM06E0y9o6+CLNPe48spiL=UDEqoGsidMbk1dBa5Rbmkg@mail.gmail.com>
In-Reply-To: <CAFA6WYM06E0y9o6+CLNPe48spiL=UDEqoGsidMbk1dBa5Rbmkg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thiruan@microsoft.com; 
x-originating-ip: [2001:4898:80e8:b:320a:2187:ff1a:ca0b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7772ecb2-757d-4f2c-f938-08d6d999d99d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0694;
x-ms-traffictypediagnostic: CY4PR21MB0694:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <CY4PR21MB069475AE03DC4D3BD8FFE108BC0A0@CY4PR21MB0694.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(376002)(39860400002)(346002)(13464003)(189003)(199004)(54906003)(25786009)(5660300002)(68736007)(81156014)(2906002)(110136005)(86612001)(71200400001)(71190400001)(229853002)(52536014)(86362001)(6116002)(7736002)(305945005)(966005)(8936002)(9686003)(107886003)(186003)(10290500003)(6246003)(6306002)(478600001)(76176011)(8990500004)(99286004)(53936002)(256004)(486006)(74316002)(102836004)(53546011)(33656002)(476003)(11346002)(6506007)(446003)(76116006)(81166006)(73956011)(66946007)(10090500001)(4326008)(46003)(8676002)(14454004)(6436002)(7696005)(55016002)(316002)(52396003)(66446008)(66476007)(66556008)(22452003)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0694;H:CY4PR21MB0279.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XyX95+XjGx/VPXlqa3OVHgCa7bRp85GAbU4MYEISr6eWfyujFmanft55YK0XRnxLkn0bobPxyBtFctXl/ZTp2R4G9fM5f3N9zEJZvXMjcKpq5BZqOciPX/6pbxNKRSI2MFZNtH14QE4TodD6UKYwt0DrrDaC6xlmrPMofC53KRVvQ0dHXPFSfW7TQFknC68VgbevGxZs1x/tYNIV1DNcCNFb0c0qONODkThOo1Ql+EbA0gHXogHerzFzjmjd1MeHUsi/r0MRqI7NkVg8dp/T1z7Mh2ZvbgWb3JR00hXvvN5LVwKuTelr64UqaMuRzpQc14TAuRFhUiU0bz+RzF2o5v9omAuIFrJtRahCE8SO/w8LzbnuY4jUSiGOLZMvOx8iBPS9hicIFiYPkt8Cd4srXzAWzswCYrjBI95V2DbAbog=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7772ecb2-757d-4f2c-f938-08d6d999d99d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 01:00:12.1794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: thiruan@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0694
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3VtaXQgR2FyZyA8c3Vt
aXQuZ2FyZ0BsaW5hcm8ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBNYXkgMTQsIDIwMTkgNzowMiBQ
TQ0KPiBUbzogU2FzaGEgTGV2aW4gPHNhc2hhbEBrZXJuZWwub3JnPg0KPiBDYzogSmFya2tvIFNh
a2tpbmVuIDxqYXJra28uc2Fra2luZW5AbGludXguaW50ZWwuY29tPjsgcGV0ZXJodWV3ZUBnbXgu
ZGU7DQo+IGpnZ0B6aWVwZS5jYTsgY29yYmV0QGx3bi5uZXQ7IExpbnV4IEtlcm5lbCBNYWlsaW5n
IExpc3QgPGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgbGludXgtZG9jQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtDQo+IGludGVncml0eUB2Z2VyLmtlcm5lbC5vcmc7IE1pY3Jvc29m
dCBMaW51eCBLZXJuZWwgTGlzdCA8bGludXgtDQo+IGtlcm5lbEBtaWNyb3NvZnQuY29tPjsgVGhp
cnVwYXRoYWlhaCBBbm5hcHVyZWRkeSA8dGhpcnVhbkBtaWNyb3NvZnQuY29tPjsNCj4gQnJ5YW4g
S2VsbHkgKENTSSkgPGJyeWFua2VsQG1pY3Jvc29mdC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjMgMC8yXSBmdHBtOiBhIGZpcm13YXJlIGJhc2VkIFRQTSBkcml2ZXINCj4gDQo+IE9uIFdl
ZCwgMTUgTWF5IDIwMTkgYXQgMDE6MDAsIFNhc2hhIExldmluIDxzYXNoYWxAa2VybmVsLm9yZz4g
d3JvdGU6DQo+ID4NCj4gPiBPbiBXZWQsIE1heSAwOCwgMjAxOSBhdCAwMzo0NDozNlBNICswMzAw
LCBKYXJra28gU2Fra2luZW4gd3JvdGU6DQo+ID4gPk9uIFR1ZSwgTWF5IDA3LCAyMDE5IGF0IDAx
OjQwOjIwUE0gLTA0MDAsIFNhc2hhIExldmluIHdyb3RlOg0KPiA+ID4+IE9uIE1vbiwgQXByIDE1
LCAyMDE5IGF0IDExOjU2OjM0QU0gLTA0MDAsIFNhc2hhIExldmluIHdyb3RlOg0KPiA+ID4+ID4g
RnJvbTogIlNhc2hhIExldmluIChNaWNyb3NvZnQpIiA8c2FzaGFsQGtlcm5lbC5vcmc+DQo+ID4g
Pj4gPg0KPiA+ID4+ID4gQ2hhbmdlcyBzaW5jZSB2MjoNCj4gPiA+PiA+DQo+ID4gPj4gPiAtIERy
b3AgdGhlIGRldmljZXRyZWUgYmluZGluZ3MgcGF0Y2ggKHdlIGRvbid0IGFkZCBhbnkgbmV3IG9u
ZXMpLg0KPiA+ID4+ID4gLSBNb3JlIGNvZGUgY2xlYW51cHMgYmFzZWQgb24gSmFzb24gR3VudGhv
cnBlJ3MgcmV2aWV3Lg0KPiA+ID4+ID4NCj4gPiA+PiA+IFNhc2hhIExldmluICgyKToNCj4gPiA+
PiA+ICBmdHBtOiBmaXJtd2FyZSBUUE0gcnVubmluZyBpbiBURUUNCj4gPiA+PiA+ICBmdHBtOiBh
ZGQgZG9jdW1lbnRhdGlvbiBmb3IgZnRwbSBkcml2ZXINCj4gPiA+Pg0KPiA+ID4+IFBpbmc/IERv
ZXMgYW55b25lIGhhdmUgYW55IG9iamVjdGlvbnMgdG8gdGhpcz8NCj4gPiA+DQo+ID4gPlNvcnJ5
IEkndmUgYmVlbiBvbiB2YWNhdGlvbiB3ZWVrIGJlZm9yZSBsYXN0IHdlZWsgYW5kIGxhc3Qgd2Vl
aw0KPiA+ID5JIHdhcyBleHRyZW1lbHkgYnVzeSBiZWNhdXNlIEkgaGFkIGJlZW4gb24gdmFjYXRp
b24uIFRoaXMgaW4NCj4gPiA+bXkgVE9ETyBsaXN0LiBXaWxsIGxvb2sgaW50byBpdCB0b21vcnJv
dyBpbiBkZXRhaWwuDQo+ID4gPg0KPiA+ID5BcG9sb2dpZXMgZm9yIHRoZSBkZWxheSB3aXRoIHRo
aXMhDQo+ID4NCj4gPiBIaSBKYXJra28sDQo+ID4NCj4gPiBJZiB0aGVyZSBhcmVuJ3QgYW55IGJp
ZyBvYmplY3Rpb25zIHRvIHRoaXMsIGNhbiB3ZSBnZXQgaXQgbWVyZ2VkIGluPw0KPiA+IFdlJ2xs
IGJlIGhhcHB5IHRvIGFkZHJlc3MgYW55IGNvbW1lbnRzIHRoYXQgY29tZSB1cC4NCj4gDQo+IEkg
Z3Vlc3MgeW91IGhhdmUgbWlzc2VkIG9yIGlnbm9yZWQgdGhpcyBjb21tZW50IFsxXS4gUGxlYXNl
IGFkZHJlc3MgaXQuDQo+IA0KPiBbMV0NCj4gaHR0cHM6Ly9uYW0wNi5zYWZlbGlua3MucHJvdGVj
dGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGttbC5vcmclDQo+IDJGbGttbCUy
RjIwMTklMkY1JTJGOCUyRjExJmFtcDtkYXRhPTAxJTdDMDElN0N0aGlydWFuJTQwbWljcm9zb2Z0
LmNvbSU3Q2YyYQ0KPiA4MGM3Yjk0NDM0MzI5ZWFlZTA4ZDZkOGQ5NjJiMSU3QzcyZjk4OGJmODZm
MTQxYWY5MWFiMmQ3Y2QwMTFkYjQ3JTdDMSZhbXA7c2QNCj4gYXRhPWh5SlJjMjNOd0VGTER1YUlN
a2JTQ0dldGQlMkJPYlFXaUFnJTJCSnRNTVI2ejlVJTNEJmFtcDtyZXNlcnZlZD0wDQo+IA0KPiAt
U3VtaXQNCg0KVGhhbmtzIGZvciByZXZpZXdpbmcgYW5kIGFkZGluZyBjb21tZW50cy4NCg0KV2Ug
dHJpZWQgdG8gdXNlIFRFRSBidXMgZnJhbWV3b3JrIHlvdSBzdWdnZXN0ZWQgZm9yIGZUUE0gZW51
bWVyYXRpb24uDQpXZSB3ZXJlIG5vdCBhYmxlIHRvIHBhc3MgdGhlIFRDRyBMb2dzIGNvbGxlY3Rl
ZCBieSB0aGUgYm9vdCBsb2FkZXJzLg0KDQpDdXJyZW50bHkgdGhlcmUgYXJlIDMgd2F5cyB0byBw
YXNzIFRDRyBMb2dzIGJhc2VkIG9uIHRoZSBjb2RlIA0KaW4gZHJpdmVycy9jaGFyL3RwbS9ldmVu
dGxvZzoNCg0KMS4gQUNQSSBUYWJsZQ0KMi4gRUZJIFRhYmxlDQozLiBPRiBEZXZpY2Ugbm9kZSBw
cm9wZXJ0aWVzDQoNCk91ciBBUk0gc3lzdGVtIGlzIGJvb3RpbmcgdXNpbmcgVS1ib290IGFuZCBE
ZXZpY2UgVHJlZS4gDQpTbyBBQ1BJL0VGSSB0YWJsZSBtZWNoYW5pc20gdG8gcGFzcyBUQ0cyIGxv
Z3Mgd29uJ3QgYmUgYXBwbGljYWJsZS4NCldlIG5lZWRlZCB0byB1c2UgT0YgZGV2aWNlIG5vZGUg
cHJvcGVydGllcyB0byBwYXNzIFRDRzIgTG9ncy4NClRFRSBidXMgZW51bWVyYXRpb24gZnJhbWV3
b3JrIGRvZXMgbm90IHdvcmsgZm9yIG91ciB1c2UgY2FzZSBkdWUgdG8gdGhlIGFib3ZlLg0KDQpJ
cyBpdCBwb3NzaWJsZSB0byBhZGQgZmxleGliaWxpdHkgaW4gVEVFIGJ1cyBlbnVtZXJhdGlvbiBm
cmFtZXdvcmsgdG8gc3VwcG9ydCANCnBsYXRmb3JtIHNwZWNpZmljIHByb3BlcnRpZXMgdGhyb3Vn
aCBPRiBub2RlcyBvciBBQ1BJPw0KDQo+IA0KPiA+DQo+ID4gLS0NCj4gPiBUaGFua3MsDQo+ID4g
U2FzaGENCg==
