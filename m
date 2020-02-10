Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51446158083
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Feb 2020 18:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgBJRHX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Feb 2020 12:07:23 -0500
Received: from us-smtp-delivery-148.mimecast.com ([216.205.24.148]:54170 "EHLO
        us-smtp-delivery-148.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728022AbgBJRHW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Feb 2020 12:07:22 -0500
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Feb 2020 12:07:20 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rambus.com;
        s=mimecast20161209; t=1581354440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0XofL5vvXRStcbowIwqDf82LpUEhoqSzkWNW2o3wmr8=;
        b=gcGc407XVXsb0hUSoc8XF0bJRGK1INo3m3bJPBGFyf1jmm6ZAVM76ZOlWkmqWqDTUxOv0S
        mpyN700pnMjOdRJwNjHcO1xvix5dxWTTyemktrEL0NYMIDPJR58HrKsQQIMWJVYuiA0u4F
        mkV0Y+3cTqPIuNE7lFosG5iFvUBiKK8=
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
 (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-Vpcj3XSIMvisLz_mN0qV1A-1; Mon, 10 Feb 2020 12:01:05 -0500
Received: from CY4PR0401MB3652.namprd04.prod.outlook.com (52.132.97.155) by
 CY4PR0401MB3524.namprd04.prod.outlook.com (52.132.102.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Mon, 10 Feb 2020 17:01:02 +0000
Received: from CY4PR0401MB3652.namprd04.prod.outlook.com
 ([fe80::9486:c6fe:752d:5eda]) by CY4PR0401MB3652.namprd04.prod.outlook.com
 ([fe80::9486:c6fe:752d:5eda%3]) with mapi id 15.20.2707.028; Mon, 10 Feb 2020
 17:01:01 +0000
From:   "Van Leeuwen, Pascal" <pvanleeuwen@rambus.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Ken Goldman <kgold@linux.ibm.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
CC:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] crypto: sm3 - add a new alias name sm3-256
Thread-Topic: [PATCH 1/2] crypto: sm3 - add a new alias name sm3-256
Thread-Index: AQHV3ZghOpovmI7C7UCUiLL8Qi2t+6gTxgGAgADdmwCAAAKQgIAAAQJw
Date:   Mon, 10 Feb 2020 17:01:01 +0000
Message-ID: <CY4PR0401MB36523805F71721000F188F2FC3190@CY4PR0401MB3652.namprd04.prod.outlook.com>
References: <20200207092219.115056-1-tianjia.zhang@linux.alibaba.com>
         <20200207092219.115056-2-tianjia.zhang@linux.alibaba.com>
         <20200210031717.GA5198@sol.localdomain>
         <1a623251-e83a-3b70-9fbd-8e929a23f7d8@linux.ibm.com>
 <7a496bb15f264eab920bf081338d67af@MN2PR20MB2973.namprd20.prod.outlook.com>
In-Reply-To: <7a496bb15f264eab920bf081338d67af@MN2PR20MB2973.namprd20.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.204.2.113]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d01158e-c907-485c-64b2-08d7ae4acef6
x-ms-traffictypediagnostic: CY4PR0401MB3524:
x-microsoft-antispam-prvs: <CY4PR0401MB35241A631B9DDCF2D7723CCDC3190@CY4PR0401MB3524.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03094A4065
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(346002)(366004)(396003)(376002)(136003)(189003)(199004)(54906003)(110136005)(64756008)(86362001)(7416002)(66946007)(76116006)(66446008)(71200400001)(66556008)(2906002)(8936002)(81166006)(33656002)(66476007)(316002)(81156014)(8676002)(4326008)(55016002)(9686003)(52536014)(53546011)(6506007)(966005)(7696005)(26005)(478600001)(45080400002)(5660300002)(186003)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR0401MB3524;H:CY4PR0401MB3652.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KqqL6TDBQv/eop+VsSuiEvsmYLcamVJ9u6SHdyXGXGNVF7sLZefPNwcmnqzktpcsYsKk4IJM0bj4wAxcexnowKeTyjv5nTC1HPJrcJqh3X2akHvqbJUuhwjgfIu99UNhn6v2880kcvM2fKtYggzckQV8WsudqV9qWcrIr/euGusMAFqWY48Bf9jRZENwr0xgym/3yHORtpMrePMshxGw7njBnFknEL6wqoEl2cGRO7dpzNZ4DgZ5ACwrJYghYFJYm44JvQip9bF5ti344L2OkFKptnC+BmQVW1QB4Ntn3YCjDIejFT7DJ/K1c+jSRYN/AcQ2X4X9Op+3Mc5yejfNft592uhxLvh+bAs83N1f4aOsV4PFdxZJ5jjog3t3u7z24YfuCHdw4A7j/27Qffld45okX3DS21VwlIyt621YTyKzu+EvVJAerGX3xXSZlraZ4fhohexiZYnlxmZHMrv3EoUNj/3+MZ2lEtOn51gb6mi65MpbzUFQdB8FeChNtY0zT558yHXGcrhXBNetEVB9xXWYmJ2KhVskHxN94b/kJ4TG5EtPwo2sxGuz0AFKM6Hb
x-ms-exchange-antispam-messagedata: 1uhyUEcUxhXBod/d6EfYgoHn23Uy6Y8zdhiy4oF86TON40xOJp9XjgC9rWLNdaVQU4I7hAsLY/83/fulWFP9Fir4KJe6ONJxjs0SnVnJCOLFYH9+F3DcvEr3VlteSaICYZRBelM/3GM0ZCrQ6E+jJw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: rambus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d01158e-c907-485c-64b2-08d7ae4acef6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2020 17:01:01.7142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bd0ba799-c2b9-413c-9c56-5d1731c4827c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RZ9slJ+2r2Gk9t63ausK5/LbRsSygwbFzImapGQXR3YzMh7IGvrgUsExAnUUCF+q8gSfiHQuOQADAumJNHUVVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3524
X-MC-Unique: Vpcj3XSIMvisLz_mN0qV1A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: rambus.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1jcnlwdG8tb3duZXJA
dmdlci5rZXJuZWwub3JnIDxsaW51eC1jcnlwdG8tb3duZXJAdmdlci5rZXJuZWwub3JnPiBPbiBC
ZWhhbGYgT2YgSmFtZXMgQm90dG9tbGV5DQo+IFNlbnQ6IE1vbmRheSwgRmVicnVhcnkgMTAsIDIw
MjAgNTo0MCBQTQ0KPiBUbzogS2VuIEdvbGRtYW4gPGtnb2xkQGxpbnV4LmlibS5jb20+OyBFcmlj
IEJpZ2dlcnMgPGViaWdnZXJzQGtlcm5lbC5vcmc+OyBUaWFuamlhIFpoYW5nIDx0aWFuamlhLnpo
YW5nQGxpbnV4LmFsaWJhYmEuY29tPg0KPiBDYzogaGVyYmVydEBnb25kb3IuYXBhbmEub3JnLmF1
OyBkYXZlbUBkYXZlbWxvZnQubmV0OyB6b2hhckBsaW51eC5pYm0uY29tOyBkbWl0cnkua2FzYXRr
aW5AZ21haWwuY29tOyBqbW9ycmlzQG5hbWVpLm9yZzsNCj4gc2VyZ2VAaGFsbHluLmNvbTsgbGlu
dXgtY3J5cHRvQHZnZXIua2VybmVsLm9yZzsgbGludXgtaW50ZWdyaXR5QHZnZXIua2VybmVsLm9y
ZzsgbGludXgtc2VjdXJpdHktbW9kdWxlQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIGNyeXB0bzogc20z
IC0gYWRkIGEgbmV3IGFsaWFzIG5hbWUgc20zLTI1Ng0KPg0KPiA8PDwgRXh0ZXJuYWwgRW1haWwg
Pj4+DQo+IENBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgdGhl
IG9yZ2FuaXphdGlvbi4gRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5s
ZXNzIHlvdSByZWNvZ25pemUgdGhlDQo+IHNlbmRlci9zZW5kZXIgYWRkcmVzcyBhbmQga25vdyB0
aGUgY29udGVudCBpcyBzYWZlLg0KPg0KPg0KPiBPbiBNb24sIDIwMjAtMDItMTAgYXQgMTE6MzAg
LTA1MDAsIEtlbiBHb2xkbWFuIHdyb3RlOg0KPiA+IE9uIDIvOS8yMDIwIDEwOjE3IFBNLCBFcmlj
IEJpZ2dlcnMgd3JvdGU6DQo+ID4gPiBBY2NvcmRpbmcgdG8gaHR0cHM6Ly9uYW0xMi5zYWZlbGlu
a3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGdG9vbHMuaWV0Zi5v
cmclMkZpZCUyRmRyYWZ0LW9zY2NhLWNmcmctc20zLQ0KPiAwMS5odG1sJmFtcDtkYXRhPTAxJTdD
MDElN0NwdmFubGVldXdlbiU0MHZlcmltYXRyaXguY29tJTdDM2E1MWQwYzEzM2RkNGIwMGZkOWEw
OGQ3YWU0N2Q2ZDYlN0NkY2IyNjBmOTAyMmQ0NDk1ODYNCj4gMDJlYWU1MTAzNWEwZDAlN0MwJmFt
cDtzZGF0YT0wblE2dFdNZFZSNXVCME1UQ2dkTVhpT21rdlR2R0VLRFRMY01YZHp5WnBnJTNEJmFt
cDtyZXNlcnZlZD0wDQo+ID4gPiAsDQo+ID4gPiBTTTMgYWx3YXlzIHByb2R1Y2VzIGEgMjU2LWJp
dCBoYXNoIHZhbHVlLiAgRS5nLiwgaXQgc2F5czoNCj4gPiA+DQo+ID4gPiAgICAgIlNNMyBwcm9k
dWNlcyBhbiBvdXRwdXQgaGFzaCB2YWx1ZSBvZiAyNTYgYml0cyBsb25nIg0KPiA+ID4NCj4gPiA+
IGFuZA0KPiA+ID4NCj4gPiA+ICAgICAiU00zIGlzIGEgaGFzaCBmdW5jdGlvbiB0aGF0IGdlbmVy
YXRlcyBhIDI1Ni1iaXQgaGFzaCB2YWx1ZS4iDQo+ID4gPg0KPiA+ID4gSSBkb24ndCBzZWUgYW55
IG1lbnRpb24gb2YgIlNNMy0yNTYiLg0KPiA+ID4NCj4gPiA+IFNvIHdoeSBub3QganVzdCBrZWVw
IGl0IGFzICJzbTMiIGFuZCBjaGFuZ2UgaGFzaF9pbmZvLmMgaW5zdGVhZD8NCj4gPiA+IFNpbmNl
IHRoZSBuYW1lIHRoZXJlIGlzIGN1cnJlbnRseSB3cm9uZywgbm8gb25lIGNhbiBiZSB1c2luZyBp
dA0KPiA+ID4geWV0Lg0KPiA+DQo+ID4gUXVlc3Rpb246ICBJcyAyNTYgYml0cyBmdW5kYW1lbnRh
bCB0byBTTTM/DQo+DQo+IE5vLg0KPg0KV2VsbCwgdGhlIGN1cnJlbnQgc3BlY2lmaWNhdGlvbiBz
dXJlbHkgZG9lc24ndCBkZWZpbmUgYW55dGhpbmcgZWxzZSBhbmQgaXMNCmFscmVhZHkgb3ZlciBh
IGRlY2FkZSBvbGQuIFNvIHdoYXQgd291bGQgYmUgdGhlIG9kZHMgdGhhdCB0aGV5IGFkZCBhDQpk
aWZmZXJlbnQgYmxvY2tzaXplIHZhcmlhbnQgX25vd18gQU5EIHN0aWxsIGNhbGwgdGhhdCBTTTMt
c29tZXRoaW5nPw0KDQo+ID4gICBDb3VsZCB0aGVyZSBldmVyIGJlIGENCj4gPiB2YXJpYW50IGlu
IHRoZSBmdXR1cmUgdGhhdCdzIGUuZy4sIDUxMiBiaXRzPw0KPg0KPiBZZXMsIFNNMyBsaWtlIFNI
QS0zIGlzIGJhc2VkIG9uIGEgNTEyICBiaXQgaW5wdXQgYmxvY2tzLiAgSG93ZXZlciwNCj4gd2hh
dCdzIGxlZnQgb2YgdGhlIHN0YW5kYXJkOg0KPg0KU00zIGlzIGJhc2VkIG9uIDUxMiBiaXQgaW5w
dXQgYmxvY2tzLCBsaWtlIF9TSEEtMl8uDQpUaGUgU0hBLTMgdmFyaWFudHMgdXNlIGJsb2NrIHNp
emVzIGJldHdlZW4gNTc2IGFuZCAxMTUyIGJpdHMsDQpkZXBlbmRpbmcgb24gdGhlIG91dHB1dCAo
ZGlnZXN0KSBzaXplLg0KDQpUaGUgLXh4eCBpcyByZWZlcnJpbmcgdG8gb3V0cHV0IChkaWdlc3Qp
IHNpemUsIG5vdCBibG9jayBzaXplIGJ5IHRoZSB3YXkuDQpBbmQgU0hBLTMgaXMgaW5kZWVkIGRl
ZmluZWQgZm9yIDUxMiBiaXQgb3V0cHV0IHNpemUsIGFtb25nc3Qgb3RoZXJzLg0KDQo+IGh0dHBz
Oi8vbmFtMTIuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUy
RiUyRnd3dy5pZXRmLm9yZyUyRmFyY2hpdmUlMkZpZCUyRmRyYWZ0LXNjYS1jZnJnLXNtMy0NCj4g
MDIudHh0JmFtcDtkYXRhPTAxJTdDMDElN0NwdmFubGVldXdlbiU0MHZlcmltYXRyaXguY29tJTdD
M2E1MWQwYzEzM2RkNGIwMGZkOWEwOGQ3YWU0N2Q2ZDYlN0NkY2IyNjBmOTAyMmQ0NDk1ODYwMg0K
PiBlYWU1MTAzNWEwZDAlN0MwJmFtcDtzZGF0YT05cGZnTTBiRyUyQnAwelVhdnNrbnduOXZxdVdx
UHNxelBFTlYyb2ttZ0NPcUUlM0QmYW1wO3Jlc2VydmVkPTANCj4NCj4gQ3VycmVudGx5IG9ubHkg
ZGVmaW5lcyBhIDI1NiBvdXRwdXQgKHZpYSBjb21wcmVzc2lvbiBmcm9tIHRoZSBmaW5hbCA1MTIN
Cj4gYml0IG91dHB1dCkuDQo+DQpZZXMuIEFsdGhvdWdoIHRoYXQgaXMgbm90IHRoZSBvcmlnaW5h
bCAoQ2hpbmVzZSkgc3BlY2lmaWNhdGlvbi4NCg0KPiBJbiB0aGVvcnksIGxpa2UgU0hBLTMsIFNN
MyBjb3VsZCBzdXBwb3J0IDM4NCBhbmQgNTEyDQo+IG91dHB1dCB2YXJpYW50cy4gIEhvd2V2ZXIs
IHRoZXJlJ3Mgbm8gZXZpZGVuY2UgYW55b25lIGlzIHdvcmtpbmcgb24NCj4gYWRkaW5nIHRoaXMu
DQo+DQpIbW0gLi4uIG5vdCB3aXRob3V0IGNoYW5naW5nIHRoZSB3b3JkIHdpZHRoIChhcyBmb3Ig
U0hBLTUxMikgYW5kL29yDQppbmNyZWFzaW5nIHRoZSBudW1iZXIgb2Ygcm91bmRzIHBsdXMgb3Ro
ZXIgdHdlYWtpbmcsIEkgd291bGQgc2F5Lg0KSXQncyBub3QgYXMgc3RyYWlnaHRmb3J3YXJkIGFz
IHlvdSBhcmUgc3VnZ2VzdGluZyAoY3J5cHRvIHJhcmVseSBpcykuDQpJIHdvdWxkIGV2ZW4gZ28g
YXMgZmFyIGFzIHNheWluZyB0aGF0IGlzIGhpZ2hseSB1bmxpa2VseSB0byBoYXBwZW4uDQoNClJl
Z2FyZHMsDQpQYXNjYWwgdmFuIExlZXV3ZW4NClNpbGljb24gSVAgQXJjaGl0ZWN0IE11bHRpLVBy
b3RvY29sIEVuZ2luZXMsIFJhbWJ1cyBTZWN1cml0eQ0KUmFtYnVzIFJPVFcgSG9sZGluZyBCVg0K
KzMxLTczIDY1ODE5NTMNCg0KTm90ZTogVGhlIEluc2lkZSBTZWN1cmUvVmVyaW1hdHJpeCBTaWxp
Y29uIElQIHRlYW0gd2FzIHJlY2VudGx5IGFjcXVpcmVkIGJ5IFJhbWJ1cy4NClBsZWFzZSBiZSBz
byBraW5kIHRvIHVwZGF0ZSB5b3VyIGUtbWFpbCBhZGRyZXNzIGJvb2sgd2l0aCBteSBuZXcgZS1t
YWlsIGFkZHJlc3MuDQoNCg0KKiogVGhpcyBtZXNzYWdlIGFuZCBhbnkgYXR0YWNobWVudHMgYXJl
IGZvciB0aGUgc29sZSB1c2Ugb2YgdGhlIGludGVuZGVkIHJlY2lwaWVudChzKS4gSXQgbWF5IGNv
bnRhaW4gaW5mb3JtYXRpb24gdGhhdCBpcyBjb25maWRlbnRpYWwgYW5kIHByaXZpbGVnZWQuIElm
IHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQgb2YgdGhpcyBtZXNzYWdlLCB5b3Ug
YXJlIHByb2hpYml0ZWQgZnJvbSBwcmludGluZywgY29weWluZywgZm9yd2FyZGluZyBvciBzYXZp
bmcgaXQuIFBsZWFzZSBkZWxldGUgdGhlIG1lc3NhZ2UgYW5kIGF0dGFjaG1lbnRzIGFuZCBub3Rp
ZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseS4gKioNCg0KUmFtYnVzIEluYy48aHR0cDovL3d3dy5y
YW1idXMuY29tPg0K

