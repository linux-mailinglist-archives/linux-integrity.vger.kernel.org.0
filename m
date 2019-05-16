Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A53120F2D
	for <lists+linux-integrity@lfdr.de>; Thu, 16 May 2019 21:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfEPTYG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 May 2019 15:24:06 -0400
Received: from mail-eopbgr750137.outbound.protection.outlook.com ([40.107.75.137]:40712
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726586AbfEPTYG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 May 2019 15:24:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=nVPpp3fJ6zTTaH548r4W8q0KFsYCY9NnAMf7qoIGZNow21yWOKPAVbZFIg+KTqBc7nXWQVuYsIP71NpXbhWRpW9XsJRez+ofzC3g4N7K6j+CRW/Ah14jL7RqjxL0hpPgIOfw2jEc1jyxPVHxk9uDassjeRCZD8Nfgqse0wEzmJA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ktw+mgSbixirXvie1u7afhpQNYgn2zWtl8ql0bp8deo=;
 b=VeIJDfPsyKMf3l9HDLMc90U2Qm5w3Jjn9jidquOYsBpsnrO28eox9oKQ4NpDE3lpd6p9dAkvKV2/Wn1guURAqyzmrTQS0xZJTKvXJeioHES5vP9mcNSymLEjdqR1lx9tOp3LxyZYl/9uHOezQ/Y/Vb2Uc93gemWkJe7rESoLXx4=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ktw+mgSbixirXvie1u7afhpQNYgn2zWtl8ql0bp8deo=;
 b=fDpTOARYKfiXyWHxrgaMTwgowGvD2NdZUlqPTUZVeoAi7myDVFvpge6p1kWBzV7tkwkpdbJvQWBz2S9Q62Z8PGN0QKdiCjQdxoYTHp/TM6RWTbwOguU67rA5pnJTpflN1/MvpzQzMq9svRRs71YliZqDkpX1RFgASkjQNW8VyL0=
Received: from CY4PR21MB0279.namprd21.prod.outlook.com (2603:10b6:903:bb::17)
 by CY4PR21MB0760.namprd21.prod.outlook.com (2603:10b6:903:bf::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.1922.4; Thu, 16
 May 2019 19:24:00 +0000
Received: from CY4PR21MB0279.namprd21.prod.outlook.com
 ([fe80::9843:add4:f5b:8fc1]) by CY4PR21MB0279.namprd21.prod.outlook.com
 ([fe80::9843:add4:f5b:8fc1%5]) with mapi id 15.20.1922.002; Thu, 16 May 2019
 19:24:00 +0000
From:   Thirupathaiah Annapureddy <thiruan@microsoft.com>
To:     Sumit Garg <sumit.garg@linaro.org>
CC:     Sasha Levin <sashal@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "corbet@lwn.net" <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Microsoft Linux Kernel List <linux-kernel@microsoft.com>,
        "Bryan Kelly (CSI)" <bryankel@microsoft.com>
Subject: RE: [PATCH v3 0/2] ftpm: a firmware based TPM driver
Thread-Topic: [PATCH v3 0/2] ftpm: a firmware based TPM driver
Thread-Index: AQHU86PZuIUdaSF7RUeiIyc+iLswraZgEJkAgAE/tQCACd+EAIAAbVeAgAFpYfCAAH3WgIAAvtYw
Date:   Thu, 16 May 2019 19:24:00 +0000
Message-ID: <CY4PR21MB02790D399645EFCA02FBE124BC0A0@CY4PR21MB0279.namprd21.prod.outlook.com>
References: <20190415155636.32748-1-sashal@kernel.org>
 <20190507174020.GH1747@sasha-vm> <20190508124436.GE7642@linux.intel.com>
 <20190514193056.GN11972@sasha-vm>
 <CAFA6WYM06E0y9o6+CLNPe48spiL=UDEqoGsidMbk1dBa5Rbmkg@mail.gmail.com>
 <CY4PR21MB0279339E8B0A15414C8F9E14BC0A0@CY4PR21MB0279.namprd21.prod.outlook.com>
 <CAFA6WYMvuF+tAA_GmkVg=FTvuuAhMuM=um7kakq=YARaP8un5Q@mail.gmail.com>
In-Reply-To: <CAFA6WYMvuF+tAA_GmkVg=FTvuuAhMuM=um7kakq=YARaP8un5Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thiruan@microsoft.com; 
x-originating-ip: [2001:4898:80e8:8:2998:283e:e43d:2152]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76185617-86d0-4336-2926-08d6da340c97
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0760;
x-ms-traffictypediagnostic: CY4PR21MB0760:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <CY4PR21MB0760B84FB7477C791FC3380FBC0A0@CY4PR21MB0760.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(136003)(39860400002)(366004)(199004)(13464003)(189003)(46003)(476003)(11346002)(73956011)(86612001)(86362001)(99286004)(76116006)(316002)(6306002)(446003)(6436002)(8936002)(229853002)(6506007)(66946007)(64756008)(66446008)(66556008)(2906002)(8676002)(55016002)(81156014)(76176011)(486006)(66476007)(256004)(7696005)(52396003)(186003)(102836004)(6116002)(53546011)(81166006)(478600001)(54906003)(4326008)(966005)(25786009)(107886003)(68736007)(53936002)(6916009)(9686003)(7736002)(10090500001)(52536014)(33656002)(10290500003)(305945005)(74316002)(22452003)(71200400001)(14454004)(71190400001)(6246003)(5660300002)(8990500004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0760;H:CY4PR21MB0279.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: r7zpdwwBLgsjab9sR4TkW7VItNG2Wgm3iB+UTC7h4JSU9AE+LpOVrAJprwlq84RhbZ+SuQtwdoXSWPaUCmi8Je1fmPqArMNwUD3j0r27dTBDCMGJEOYI60tLX57ia/zZn3yLwQAkNrSSBF3YbaWDQp9AfdiNnxL/q1kGz/bR3TfWMO4gKMV+3BXdGVLSgkQP9ls8/G9zHc2qtXTyaFq0IfRiq3LLD5h+aDpTJLXkosGxo7t3CWVCkfsYPraXnxpKuTOqhosDYGhMLiMJgtnHSR/0EuRlxiZ/Rb+82G1hzA4e1DA85nHkb/0n+Kgo/JA1pIvVPjRJKI05rG9IsiXepKLLyTeM4d5O5jZbKzq9/EKJzULfvfp0HPIpyz4EyoZR5iYIydmdAJFOHtYM6Pyz7rpC2BbLrf67jUj0m+SYVoQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76185617-86d0-4336-2926-08d6da340c97
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 19:24:00.2170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: thiruan@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0760
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3VtaXQgR2FyZyA8c3Vt
aXQuZ2FyZ0BsaW5hcm8ub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgTWF5IDE2LCAyMDE5IDEyOjA2
IEFNDQo+IFRvOiBUaGlydXBhdGhhaWFoIEFubmFwdXJlZGR5IDx0aGlydWFuQG1pY3Jvc29mdC5j
b20+DQo+IENjOiBTYXNoYSBMZXZpbiA8c2FzaGFsQGtlcm5lbC5vcmc+OyBKYXJra28gU2Fra2lu
ZW4NCj4gPGphcmtrby5zYWtraW5lbkBsaW51eC5pbnRlbC5jb20+OyBwZXRlcmh1ZXdlQGdteC5k
ZTsgamdnQHppZXBlLmNhOw0KPiBjb3JiZXRAbHduLm5ldDsgTGludXggS2VybmVsIE1haWxpbmcg
TGlzdCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47DQo+IGxpbnV4LWRvY0B2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWludGVncml0eUB2Z2VyLmtlcm5lbC5vcmc7IE1pY3Jvc29mdCBMaW51
eA0KPiBLZXJuZWwgTGlzdCA8bGludXgta2VybmVsQG1pY3Jvc29mdC5jb20+OyBCcnlhbiBLZWxs
eSAoQ1NJKQ0KPiA8YnJ5YW5rZWxAbWljcm9zb2Z0LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2MyAwLzJdIGZ0cG06IGEgZmlybXdhcmUgYmFzZWQgVFBNIGRyaXZlcg0KPiANCj4gT24gVGh1
LCAxNiBNYXkgMjAxOSBhdCAwNjozMCwgVGhpcnVwYXRoYWlhaCBBbm5hcHVyZWRkeQ0KPiA8dGhp
cnVhbkBtaWNyb3NvZnQuY29tPiB3cm90ZToNCj4gPg0KPiA+DQo+ID4NCj4gPiA+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBTdW1pdCBHYXJnIDxzdW1pdC5nYXJnQGxp
bmFyby5vcmc+DQo+ID4gPiBTZW50OiBUdWVzZGF5LCBNYXkgMTQsIDIwMTkgNzowMiBQTQ0KPiA+
ID4gVG86IFNhc2hhIExldmluIDxzYXNoYWxAa2VybmVsLm9yZz4NCj4gPiA+IENjOiBKYXJra28g
U2Fra2luZW4gPGphcmtrby5zYWtraW5lbkBsaW51eC5pbnRlbC5jb20+Ow0KPiBwZXRlcmh1ZXdl
QGdteC5kZTsNCj4gPiA+IGpnZ0B6aWVwZS5jYTsgY29yYmV0QGx3bi5uZXQ7IExpbnV4IEtlcm5l
bCBNYWlsaW5nIExpc3QgPGxpbnV4LQ0KPiA+ID4ga2VybmVsQHZnZXIua2VybmVsLm9yZz47IGxp
bnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiA+ID4gaW50ZWdyaXR5QHZnZXIua2Vy
bmVsLm9yZzsgTWljcm9zb2Z0IExpbnV4IEtlcm5lbCBMaXN0IDxsaW51eC0NCj4gPiA+IGtlcm5l
bEBtaWNyb3NvZnQuY29tPjsgVGhpcnVwYXRoYWlhaCBBbm5hcHVyZWRkeQ0KPiA8dGhpcnVhbkBt
aWNyb3NvZnQuY29tPjsNCj4gPiA+IEJyeWFuIEtlbGx5IChDU0kpIDxicnlhbmtlbEBtaWNyb3Nv
ZnQuY29tPg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAwLzJdIGZ0cG06IGEgZmlybXdh
cmUgYmFzZWQgVFBNIGRyaXZlcg0KPiA+ID4NCj4gPiA+IE9uIFdlZCwgMTUgTWF5IDIwMTkgYXQg
MDE6MDAsIFNhc2hhIExldmluIDxzYXNoYWxAa2VybmVsLm9yZz4gd3JvdGU6DQo+ID4gPiA+DQo+
ID4gPiA+IE9uIFdlZCwgTWF5IDA4LCAyMDE5IGF0IDAzOjQ0OjM2UE0gKzAzMDAsIEphcmtrbyBT
YWtraW5lbiB3cm90ZToNCj4gPiA+ID4gPk9uIFR1ZSwgTWF5IDA3LCAyMDE5IGF0IDAxOjQwOjIw
UE0gLTA0MDAsIFNhc2hhIExldmluIHdyb3RlOg0KPiA+ID4gPiA+PiBPbiBNb24sIEFwciAxNSwg
MjAxOSBhdCAxMTo1NjozNEFNIC0wNDAwLCBTYXNoYSBMZXZpbiB3cm90ZToNCj4gPiA+ID4gPj4g
PiBGcm9tOiAiU2FzaGEgTGV2aW4gKE1pY3Jvc29mdCkiIDxzYXNoYWxAa2VybmVsLm9yZz4NCj4g
PiA+ID4gPj4gPg0KPiA+ID4gPiA+PiA+IENoYW5nZXMgc2luY2UgdjI6DQo+ID4gPiA+ID4+ID4N
Cj4gPiA+ID4gPj4gPiAtIERyb3AgdGhlIGRldmljZXRyZWUgYmluZGluZ3MgcGF0Y2ggKHdlIGRv
bid0IGFkZCBhbnkgbmV3DQo+IG9uZXMpLg0KPiA+ID4gPiA+PiA+IC0gTW9yZSBjb2RlIGNsZWFu
dXBzIGJhc2VkIG9uIEphc29uIEd1bnRob3JwZSdzIHJldmlldy4NCj4gPiA+ID4gPj4gPg0KPiA+
ID4gPiA+PiA+IFNhc2hhIExldmluICgyKToNCj4gPiA+ID4gPj4gPiAgZnRwbTogZmlybXdhcmUg
VFBNIHJ1bm5pbmcgaW4gVEVFDQo+ID4gPiA+ID4+ID4gIGZ0cG06IGFkZCBkb2N1bWVudGF0aW9u
IGZvciBmdHBtIGRyaXZlcg0KPiA+ID4gPiA+Pg0KPiA+ID4gPiA+PiBQaW5nPyBEb2VzIGFueW9u
ZSBoYXZlIGFueSBvYmplY3Rpb25zIHRvIHRoaXM/DQo+ID4gPiA+ID4NCj4gPiA+ID4gPlNvcnJ5
IEkndmUgYmVlbiBvbiB2YWNhdGlvbiB3ZWVrIGJlZm9yZSBsYXN0IHdlZWsgYW5kIGxhc3Qgd2Vl
aw0KPiA+ID4gPiA+SSB3YXMgZXh0cmVtZWx5IGJ1c3kgYmVjYXVzZSBJIGhhZCBiZWVuIG9uIHZh
Y2F0aW9uLiBUaGlzIGluDQo+ID4gPiA+ID5teSBUT0RPIGxpc3QuIFdpbGwgbG9vayBpbnRvIGl0
IHRvbW9ycm93IGluIGRldGFpbC4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+QXBvbG9naWVzIGZvciB0
aGUgZGVsYXkgd2l0aCB0aGlzIQ0KPiA+ID4gPg0KPiA+ID4gPiBIaSBKYXJra28sDQo+ID4gPiA+
DQo+ID4gPiA+IElmIHRoZXJlIGFyZW4ndCBhbnkgYmlnIG9iamVjdGlvbnMgdG8gdGhpcywgY2Fu
IHdlIGdldCBpdCBtZXJnZWQgaW4/DQo+ID4gPiA+IFdlJ2xsIGJlIGhhcHB5IHRvIGFkZHJlc3Mg
YW55IGNvbW1lbnRzIHRoYXQgY29tZSB1cC4NCj4gPiA+DQo+ID4gPiBJIGd1ZXNzIHlvdSBoYXZl
IG1pc3NlZCBvciBpZ25vcmVkIHRoaXMgY29tbWVudCBbMV0uIFBsZWFzZSBhZGRyZXNzIGl0Lg0K
PiA+ID4NCj4gPiA+IFsxXQ0KPiA+ID4NCj4gaHR0cHM6Ly9uYW0wNi5zYWZlbGlua3MucHJvdGVj
dGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGttbC5vcmclDQo+ID4gPg0KPiAy
RmxrbWwlMkYyMDE5JTJGNSUyRjglMkYxMSZhbXA7ZGF0YT0wMSU3QzAxJTdDdGhpcnVhbiU0MG1p
Y3Jvc29mdC5jb20lN0NmMmENCj4gPiA+DQo+IDgwYzdiOTQ0MzQzMjllYWVlMDhkNmQ4ZDk2MmIx
JTdDNzJmOTg4YmY4NmYxNDFhZjkxYWIyZDdjZDAxMWRiNDclN0MxJmFtcDtzZA0KPiA+ID4gYXRh
PWh5SlJjMjNOd0VGTER1YUlNa2JTQ0dldGQlMkJPYlFXaUFnJTJCSnRNTVI2ejlVJTNEJmFtcDty
ZXNlcnZlZD0wDQo+ID4gPg0KPiA+ID4gLVN1bWl0DQo+ID4NCj4gPiBUaGFua3MgZm9yIHJldmll
d2luZyBhbmQgYWRkaW5nIGNvbW1lbnRzLg0KPiA+DQo+ID4gV2UgdHJpZWQgdG8gdXNlIFRFRSBi
dXMgZnJhbWV3b3JrIHlvdSBzdWdnZXN0ZWQgZm9yIGZUUE0gZW51bWVyYXRpb24uDQo+ID4gV2Ug
d2VyZSBub3QgYWJsZSB0byBwYXNzIHRoZSBUQ0cgTG9ncyBjb2xsZWN0ZWQgYnkgdGhlIGJvb3Qg
bG9hZGVycy4NCj4gPg0KPiA+IEN1cnJlbnRseSB0aGVyZSBhcmUgMyB3YXlzIHRvIHBhc3MgVENH
IExvZ3MgYmFzZWQgb24gdGhlIGNvZGUNCj4gPiBpbiBkcml2ZXJzL2NoYXIvdHBtL2V2ZW50bG9n
Og0KPiA+DQo+ID4gMS4gQUNQSSBUYWJsZQ0KPiA+IDIuIEVGSSBUYWJsZQ0KPiA+IDMuIE9GIERl
dmljZSBub2RlIHByb3BlcnRpZXMNCj4gPg0KPiA+IE91ciBBUk0gc3lzdGVtIGlzIGJvb3Rpbmcg
dXNpbmcgVS1ib290IGFuZCBEZXZpY2UgVHJlZS4NCj4gPiBTbyBBQ1BJL0VGSSB0YWJsZSBtZWNo
YW5pc20gdG8gcGFzcyBUQ0cyIGxvZ3Mgd29uJ3QgYmUgYXBwbGljYWJsZS4NCj4gPiBXZSBuZWVk
ZWQgdG8gdXNlIE9GIGRldmljZSBub2RlIHByb3BlcnRpZXMgdG8gcGFzcyBUQ0cyIExvZ3MuDQo+
ID4gVEVFIGJ1cyBlbnVtZXJhdGlvbiBmcmFtZXdvcmsgZG9lcyBub3Qgd29yayBmb3Igb3VyIHVz
ZSBjYXNlIGR1ZSB0byB0aGUNCj4gYWJvdmUuDQo+IA0KPiBGaXJzdGx5IGxldCBtZSBjbGFyaWZ5
IHRoYXQgdGhpcyBmcmFtZXdvcmsgaXMgaW50ZW5kZWQgdG8gY29tbXVuaWNhdGUNCj4gd2l0aCBU
RUUgYmFzZWQgc2VydmljZXMvZGV2aWNlcyByYXRoZXIgdGhhbiBib290IGxvYWRlci4gQW5kIGlu
IHRoaXMNCj4gY2FzZSBmVFBNIGJlaW5nIGEgVEVFIGJhc2VkIHNlcnZpY2UsIHNvIHRoaXMgZnJh
bWV3b3JrIHNob3VsZCBiZSB1c2VkLg0KPiANCkl0IGRvZXMgbm90IHdvcmsgZm9yIG91ciB1c2Ug
Y2FzZS4gV2UgZ2F2ZSBlbm91Z2gganVzdGlmaWNhdGlvbiBzbyBmYXIuIA0KVEVFIGJ1cyBlbnVt
ZXJhdGlvbiBuZWVkcyB0byBiZSBmbGV4aWJsZSB0byBzdXBwb3J0IG91ciB1c2UgY2FzZSBhbmQg
DQptb3JlIGZ1dHVyZSB1c2UgY2FzZXMuIA0KDQo+ID4NCj4gPiBJcyBpdCBwb3NzaWJsZSB0byBh
ZGQgZmxleGliaWxpdHkgaW4gVEVFIGJ1cyBlbnVtZXJhdGlvbiBmcmFtZXdvcmsgdG8NCj4gc3Vw
cG9ydA0KPiA+IHBsYXRmb3JtIHNwZWNpZmljIHByb3BlcnRpZXMgdGhyb3VnaCBPRiBub2RlcyBv
ciBBQ1BJPw0KPiA+DQo+IA0KPiBBcyB5b3UgbWVudGlvbmVkIGFib3ZlLCBUQ0cgbG9ncyBhcmUg
Y29sbGVjdGVkIGJ5IGJvb3QgbG9hZGVyLiBTbyBpdA0KPiBzaG91bGQgZmluZCBhIHdheSB0byBw
YXNzIHRoZW0gdG8gTGludXguDQo+IA0KPiBIb3cgYWJvdXQgaWYgYm9vdCBsb2FkZXIgcmVnaXN0
ZXIgdGhlc2UgVENHIGxvZ3Mgd2l0aCBmVFBNIFRBIHdoaWNoDQo+IGNvdWxkIGJlIGZldGNoZWQg
ZHVyaW5nIGZUUE0gZHJpdmVyIHByb2JlIG9yIG5ldyBhcGkgbGlrZQ0KPiB0cG1fcmVhZF9sb2df
dGVlKCk/IA0KDQpBbmQgdGhlbiBob3cgZG9lcyBmVFBNIGRyaXZlciBwYXNzIFRDRyBMb2dzIHRv
IHRoZSBUUE0gZnJhbWV3b3JrPyANCkl0IHJlcXVpcmVzIGNoYW5nZXMgdG8gdGhlIHVwc3RyZWFt
IFRQTSBmcmFtZXdvcmsgdG8gYXNrIHRoZSBkcml2ZXINCmV4cGxpY2l0bHkgZm9yIHRoZSBUQ0cg
TG9ncy4gDQoNCk5vdGUgdGhhdCB0aGlzIGFsc28gcmVxdWlyZXMgY2hhbmdlcyB0byB0aGUgZlRQ
TSBUQSB0aGF0IGhhcyBiZWVuIGV4aXN0aW5nIGZvciBmZXcgeWVhcnMuDQoNCklzIGl0IG5vdCBw
b3NzaWJsZSB0byBhZGQgZmxleGliaWxpdHkgaW4gVEVFIGJ1cyBlbnVtZXJhdGlvbiBmcmFtZXdv
cmsgdG8NCnN1cHBvcnQgcGxhdGZvcm0gc3BlY2lmaWMgcHJvcGVydGllcyB0aHJvdWdoIE9GIG5v
ZGVzIG9yIEFDUEk/DQoNCkRldmljZXMgZW51bWVyYXRlZCBieSBidXNlcyBzdWNoIGFzIGkyYyBj
YW4gcmVhZCBwbGF0Zm9ybSBzcGVjaWZpYyBwcm9wZXJ0aWVzLg0KV2l0aCB0aGlzIGZsZXhpYmls
aXR5IGFkZGVkLCBtb3JlIGZ1dHVyZSB1c2UgY2FzZXMgdGhyb3VnaCBURUUgYnVzLg0KDQoNCj4g
VGhpcyBpcyBzb21ldGhpbmcgc2ltaWxhciB0byB3aGF0IEkgdXNlZCBpbg0KPiBvcHRlZS1ybmcg
WzFdIGRyaXZlciB0byBmZXRjaCBSTkcgcHJvcGVydGllcy4NCj4gDQo+IFsxXQ0KPiBodHRwczov
L25hbTA2LnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYl
MkZnaXRodWIuY28NCj4gbSUyRnRvcnZhbGRzJTJGbGludXglMkZibG9iJTJGbWFzdGVyJTJGZHJp
dmVycyUyRmNoYXIlMkZod19yYW5kb20lMkZvcHRlZS0NCj4gcm5nLmMlMjNMMTc2JmFtcDtkYXRh
PTAyJTdDMDElN0N0aGlydWFuJTQwbWljcm9zb2Z0LmNvbSU3Q2QzNzQzOGVhZjRmOTQ4M2U0DQo+
IDBjNzA4ZDZkOWNjZmUwYyU3QzcyZjk4OGJmODZmMTQxYWY5MWFiMmQ3Y2QwMTFkYjQ3JTdDMSU3
QzAlN0M2MzY5MzU4NzE3OTU0OQ0KPiAzMDA2JmFtcDtzZGF0YT1BczlzQzQ1Qmw3c1pkSktPcTBz
SHo2R21YdHRNeFM4ME5uNXl2TjR2cW5nJTNEJmFtcDtyZXNlcnZlZD0NCj4gMA0KPiANCj4gLVN1
bWl0DQo+IA0KPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gLS0NCj4gPiA+ID4gVGhhbmtzLA0KPiA+
ID4gPiBTYXNoYQ0K
