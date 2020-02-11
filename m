Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96F0C158AC2
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Feb 2020 08:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgBKHrm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Feb 2020 02:47:42 -0500
Received: from us-smtp-delivery-148.mimecast.com ([216.205.24.148]:37491 "EHLO
        us-smtp-delivery-148.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727789AbgBKHrm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Feb 2020 02:47:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rambus.com;
        s=mimecast20161209; t=1581407260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yi69RZrYM5y2k1f16rw/mtrnHWssfjhZ7X5ko5PeHLo=;
        b=M/7iS8TAyuran9WHnlNNM80zy6r+dSbTFkT/3TKZxoShZXQzsCKKtFbQ1JyIj0SRVuhLr7
        2jC7nlGa2Ql62lcstVUK5DRZHQJ89o9frx1ys44VKK7xFVfQGaz4JfPr8KjjwuaLpQIv8m
        gewZPdRy+MT1T4NFhEbKU0CN4WqHSYc=
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
 (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-tZ2jPCVePsGkWv7OxJz_kg-1; Tue, 11 Feb 2020 02:47:38 -0500
Received: from SN4PR0401MB3663.namprd04.prod.outlook.com (10.167.133.19) by
 SN4PR0401MB3551.namprd04.prod.outlook.com (10.167.129.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Tue, 11 Feb 2020 07:47:36 +0000
Received: from SN4PR0401MB3663.namprd04.prod.outlook.com
 ([fe80::c071:99a5:6da8:924e]) by SN4PR0401MB3663.namprd04.prod.outlook.com
 ([fe80::c071:99a5:6da8:924e%7]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 07:47:35 +0000
From:   "Van Leeuwen, Pascal" <pvanleeuwen@rambus.com>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>
CC:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] crypto: rename sm3-256 to sm3 in hash_algo_name
Thread-Topic: [PATCH 1/2] crypto: rename sm3-256 to sm3 in hash_algo_name
Thread-Index: AQHV4A/19AwGoOkcZEG8ivP2s3l+UKgVnvzA
Date:   Tue, 11 Feb 2020 07:47:35 +0000
Message-ID: <SN4PR0401MB366384487DB71207FD64A89FC3180@SN4PR0401MB3663.namprd04.prod.outlook.com>
References: <20200210124440.23929-1-tianjia.zhang@linux.alibaba.com>
 <42b6db00b1864da9ad76a8d5964fdb74@MN2PR20MB2973.namprd20.prod.outlook.com>
In-Reply-To: <42b6db00b1864da9ad76a8d5964fdb74@MN2PR20MB2973.namprd20.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.204.2.113]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd9b058a-f7bd-4f6e-6607-08d7aec6a908
x-ms-traffictypediagnostic: SN4PR0401MB3551:
x-microsoft-antispam-prvs: <SN4PR0401MB35518A8AAF4427B24D6BDA5CC3180@SN4PR0401MB3551.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0310C78181
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39850400004)(346002)(376002)(366004)(199004)(189003)(71200400001)(316002)(7696005)(478600001)(2906002)(6506007)(53546011)(54906003)(26005)(110136005)(8936002)(4326008)(186003)(8676002)(86362001)(55016002)(66476007)(9686003)(81156014)(81166006)(66446008)(64756008)(66946007)(76116006)(66556008)(7416002)(52536014)(33656002)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0401MB3551;H:SN4PR0401MB3663.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +pnP7vcaX2z3G5aubULp+UgF6yEoOFoVVojpcyr+kE8DV8+7XDAA0bs34soNivbyrVlLaKN5GSt8V1CwVnfcAU49nF3BO2JpC4JkgoeSx/3oh8OmWqHHvj0DKbuiURNMHDedwgJydFavxkllgMjGS/F5k5MtdRkyLNW8cfqtI6Azm3qOomYU41WB2j7WlZJzJPBFqEoMRzOZSXFQ69/pBlTnr/lLUGJQ85Sh/D3t6S2+k5UQn4XO/rIolfhEXD//sYVmPxodTY46o3WyaNMVvCfNkKhH+5xgzAJSB76LTFbzUR61AbV10Ddu2ROU+QXhbD58O0TdCFQb+49JVx/f/m4rsU9OFDNG9OYSxP57POUA31nQvmZAspZIKVpDGM9W35co9gpQrylVV3HO2hu0CeI1XAWorrdg9PLSWiKtml5A2QWzVutesRsrKVwcxkrD
x-ms-exchange-antispam-messagedata: OPG8b6RSwKoAi7prNlTpxNR9PjI2pCjOJWONc8HdlwTJFJCj+dXfq7Vv2o75kr6RNuKxsY7kV2ZvxVm/kFwLkrNPon7RhI+WjURPyg5x+l5bbfULQf8SVTV8U4OofUW0uG/tgSuHqkO7kBNx6wO63g==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: rambus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9b058a-f7bd-4f6e-6607-08d7aec6a908
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2020 07:47:35.6413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bd0ba799-c2b9-413c-9c56-5d1731c4827c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l8HW6al+ehDCyyVzGEcoEhJJQOjdntOBPzxaU6P/6TTAaobtMhM9YwwFnuNIF2YxkZ6FFpAhcg1bpOpbdX0Leg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3551
X-MC-Unique: tZ2jPCVePsGkWv7OxJz_kg-1
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
ZWhhbGYgT2YgVGlhbmppYSBaaGFuZw0KPiBTZW50OiBNb25kYXksIEZlYnJ1YXJ5IDEwLCAyMDIw
IDE6NDUgUE0NCj4gVG86IGhlcmJlcnRAZ29uZG9yLmFwYW5hLm9yZy5hdTsgZGF2ZW1AZGF2ZW1s
b2Z0Lm5ldDsgem9oYXJAbGludXguaWJtLmNvbTsgZG1pdHJ5Lmthc2F0a2luQGdtYWlsLmNvbTsg
am1vcnJpc0BuYW1laS5vcmc7DQo+IHNlcmdlQGhhbGx5bi5jb207IGViaWdnZXJzQGtlcm5lbC5v
cmcNCj4gQ2M6IGxpbnV4LWNyeXB0b0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWludGVncml0eUB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXNlY3VyaXR5LW1vZHVsZUB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtQQVRDSCAxLzJdIGNy
eXB0bzogcmVuYW1lIHNtMy0yNTYgdG8gc20zIGluIGhhc2hfYWxnb19uYW1lDQo+DQo+IDw8PCBF
eHRlcm5hbCBFbWFpbCA+Pj4NCj4gQ0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20g
b3V0c2lkZSBvZiB0aGUgb3JnYW5pemF0aW9uLiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUNCj4gc2VuZGVyL3NlbmRlciBhZGRy
ZXNzIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+DQo+DQo+IFRoZSBuYW1lIHNtMy0y
NTYgaXMgZGVmaW5lZCBpbiBoYXNoX2FsZ29fbmFtZSBpbiBoYXNoX2luZm8sIGJ1dCB0aGUNCj4g
YWxnb3JpdGhtIG5hbWUgaW1wbGVtZW50ZWQgaW4gc20zX2dlbmVyaWMuYyBpcyBzbTMsIHdoaWNo
IHdpbGwgY2F1c2UNCj4gdGhlIHNtMy0yNTYgYWxnb3JpdGhtIHRvIGJlIG5vdCBmb3VuZCBpbiBz
b21lIGFwcGxpY2F0aW9uIHNjZW5hcmlvcyBvZg0KPiB0aGUgaGFzaCBhbGdvcml0aG0sIGFuZCBh
biBFTk9FTlQgZXJyb3Igd2lsbCBvY2N1ci4gRm9yIGV4YW1wbGUsDQo+IElNQSwga2V5cywgYW5k
IG90aGVyIHN1YnN5c3RlbXMgdGhhdCByZWZlcmVuY2UgaGFzaF9hbGdvX25hbWUgYWxsIHVzZQ0K
PiB0aGUgaGFzaCBhbGdvcml0aG0gb2Ygc20zLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBUaWFuamlh
IFpoYW5nIDx0aWFuamlhLnpoYW5nQGxpbnV4LmFsaWJhYmEuY29tPg0KUmV2aWV3ZWQtYnk6IFBh
c2NhbCB2YW4gTGVldXdlbiA8cHZhbmxlZXV3ZW5AcmFtYnVzLmNvbT4NCg0KPiAtLS0NCj4gIGNy
eXB0by9oYXNoX2luZm8uYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvY3J5cHRvL2hhc2hfaW5mby5jIGIv
Y3J5cHRvL2hhc2hfaW5mby5jDQo+IGluZGV4IGM3NTRjYjc1ZGQxYS4uYTQ5ZmY5NmJkZTc3IDEw
MDY0NA0KPiAtLS0gYS9jcnlwdG8vaGFzaF9pbmZvLmMNCj4gKysrIGIvY3J5cHRvL2hhc2hfaW5m
by5jDQo+IEBAIC0yNiw3ICsyNiw3IEBAIGNvbnN0IGNoYXIgKmNvbnN0IGhhc2hfYWxnb19uYW1l
W0hBU0hfQUxHT19fTEFTVF0gPSB7DQo+ICAgICAgICAgW0hBU0hfQUxHT19UR1JfMTI4XSAgICAg
PSAidGdyMTI4IiwNCj4gICAgICAgICBbSEFTSF9BTEdPX1RHUl8xNjBdICAgICA9ICJ0Z3IxNjAi
LA0KPiAgICAgICAgIFtIQVNIX0FMR09fVEdSXzE5Ml0gICAgID0gInRncjE5MiIsDQo+IC0gICAg
ICAgW0hBU0hfQUxHT19TTTNfMjU2XSAgICAgPSAic20zLTI1NiIsDQo+ICsgICAgICAgW0hBU0hf
QUxHT19TTTNfMjU2XSAgICAgPSAic20zIiwNCj4gICAgICAgICBbSEFTSF9BTEdPX1NUUkVFQk9H
XzI1Nl0gPSAic3RyZWVib2cyNTYiLA0KPiAgICAgICAgIFtIQVNIX0FMR09fU1RSRUVCT0dfNTEy
XSA9ICJzdHJlZWJvZzUxMiIsDQo+ICB9Ow0KPiAtLQ0KPiAyLjE3LjENCg0KUmVnYXJkcywNClBh
c2NhbCB2YW4gTGVldXdlbg0KU2lsaWNvbiBJUCBBcmNoaXRlY3QgTXVsdGktUHJvdG9jb2wgRW5n
aW5lcywgUmFtYnVzIFNlY3VyaXR5DQpSYW1idXMgUk9UVyBIb2xkaW5nIEJWDQorMzEtNzMgNjU4
MTk1Mw0KDQpOb3RlOiBUaGUgSW5zaWRlIFNlY3VyZS9WZXJpbWF0cml4IFNpbGljb24gSVAgdGVh
bSB3YXMgcmVjZW50bHkgYWNxdWlyZWQgYnkgUmFtYnVzLg0KUGxlYXNlIGJlIHNvIGtpbmQgdG8g
dXBkYXRlIHlvdXIgZS1tYWlsIGFkZHJlc3MgYm9vayB3aXRoIG15IG5ldyBlLW1haWwgYWRkcmVz
cy4NCg0KDQoqKiBUaGlzIG1lc3NhZ2UgYW5kIGFueSBhdHRhY2htZW50cyBhcmUgZm9yIHRoZSBz
b2xlIHVzZSBvZiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50KHMpLiBJdCBtYXkgY29udGFpbiBpbmZv
cm1hdGlvbiB0aGF0IGlzIGNvbmZpZGVudGlhbCBhbmQgcHJpdmlsZWdlZC4gSWYgeW91IGFyZSBu
b3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCBvZiB0aGlzIG1lc3NhZ2UsIHlvdSBhcmUgcHJvaGli
aXRlZCBmcm9tIHByaW50aW5nLCBjb3B5aW5nLCBmb3J3YXJkaW5nIG9yIHNhdmluZyBpdC4gUGxl
YXNlIGRlbGV0ZSB0aGUgbWVzc2FnZSBhbmQgYXR0YWNobWVudHMgYW5kIG5vdGlmeSB0aGUgc2Vu
ZGVyIGltbWVkaWF0ZWx5LiAqKg0KDQpSYW1idXMgSW5jLjxodHRwOi8vd3d3LnJhbWJ1cy5jb20+
DQo=

