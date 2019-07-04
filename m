Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC335F2CE
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2019 08:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfGDG2Z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Jul 2019 02:28:25 -0400
Received: from mail-eopbgr780120.outbound.protection.outlook.com ([40.107.78.120]:6167
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725879AbfGDG2Z (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Jul 2019 02:28:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PUQHcD9tU2iHnkTz2bt/aslNhwgwzpTwNql+v8f0UXQlcPzYxqukLm/5pttgOf68N0lMxQ8LXP2wC2jtfHs/mvxJ/vvvtc12W4+2tl6NW1cmvUpbZaOtrmTzOmpqVWPEnI4HMwB8iIK/d7MXDzbVjJn/HH/B/utqcXYpgZvnJoW8TIuZYLddA80UsIHjQYMYw/Y1f8mztEa6OoEU6LenteL/UljjF/tAo3JDQ3fFgKBCMyugkWFw+pP+LanGQZjOpa+OG++tSdkDFTm827m4h/J+RXl0hmd/0i+kuNwQDW0LTiH8SBhV9JWRHprZjIoGvBfsy86BZuXU82E51/atnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmPws/wzK1tVPuzX4xOymGLGWxrYEUjAIZjuPeKrvB4=;
 b=G4Y89VC2T8RUFCaeYxcYrTMzgFAuTN1HM1mInOW1JB4Jo7PUTTsPzQBgGMl4oWwqL7E0wSHycheOh9A52mZ1ivAA/X/fIz12shS9U0GkqQxgWfs5wg8Mi6+zNpBzZVCTlFpc+4fV9Db5taz3grB5nz8j9/XQ6lAfWWqFFTP728Wf2adDG2pcnlhuugzGbbMaWu449mn8vbI1o/lteyS1ZpECSd+73pnYB4/kGU3xCbPkxEs+ZGfEojcdIDVfei3D75gBgrbdXLkjT7my1DI7tRb6n9olLUHxZdIisrmU/xiV3MbPxk1hnhHlYOU9EW0Gz0WTL2AP8mwZBb+whgcz3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microsoft.com;dmarc=pass action=none
 header.from=microsoft.com;dkim=pass header.d=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmPws/wzK1tVPuzX4xOymGLGWxrYEUjAIZjuPeKrvB4=;
 b=ltgiulkxb+LfQ4fUy6tIILBo5CVdBzJysM9xb61ZHmz4+XLcH4yOKjcvXH0RHOjhNCdcDj0eFYS41lqed2/bmE1OwwlPiRTS2cGf/jju2akTBmTnzIq2W4JHAZvHDO6ZLdooZ3NFJV9xjSR0YFaCun778B5I3FJ4fT7IlGsNVgQ=
Received: from CY4PR21MB0279.namprd21.prod.outlook.com (10.173.193.145) by
 CY4PR21MB0501.namprd21.prod.outlook.com (10.172.122.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.2; Thu, 4 Jul 2019 06:28:21 +0000
Received: from CY4PR21MB0279.namprd21.prod.outlook.com
 ([fe80::543b:4f31:c610:468d]) by CY4PR21MB0279.namprd21.prod.outlook.com
 ([fe80::543b:4f31:c610:468d%7]) with mapi id 15.20.2073.001; Thu, 4 Jul 2019
 06:28:21 +0000
From:   Thirupathaiah Annapureddy <thiruan@microsoft.com>
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Microsoft Linux Kernel List <linux-kernel@microsoft.com>,
        "Bryan Kelly (CSI)" <bryankel@microsoft.com>,
        "tee-dev@lists.linaro.org" <tee-dev@lists.linaro.org>,
        "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        Joakim Bech <joakim.bech@linaro.org>
Subject: RE: [PATCH v7 1/2] fTPM: firmware TPM running in TEE
Thread-Topic: [PATCH v7 1/2] fTPM: firmware TPM running in TEE
Thread-Index: AQHVK5KBxkypLT05X0KOGP9E2DZ32Kaul3GAgAAHEYCAAN+wgIAAA4QAgAAzCoCAB7bkgIAAJOcggADxrICAABS/AIABZouA
Date:   Thu, 4 Jul 2019 06:28:21 +0000
Message-ID: <CY4PR21MB02791B5EF653514DC0223694BCFA0@CY4PR21MB0279.namprd21.prod.outlook.com>
References: <20190625201341.15865-1-sashal@kernel.org>
 <20190625201341.15865-2-sashal@kernel.org>
 <673dd30d03e8ed9825bb46ef21b2efef015f6f2a.camel@linux.intel.com>
 <20190626235653.GL7898@sasha-vm>
 <b688e845ccbe011c54b10043fbc3c0de8f0befc2.camel@linux.intel.com>
 <20190627133004.GA3757@apalos>
 <0893dc429d4c3f3b52d423f9e61c08a5012a7519.camel@linux.intel.com>
 <20190702142109.GA32069@apalos>
 <CY4PR21MB0279B99FB0097309ADE83809BCF80@CY4PR21MB0279.namprd21.prod.outlook.com>
 <20190703065813.GA12724@apalos>
 <CAC_iWjK2F13QxjuvqzqNLx00SiGz_FQ5X=MQxJyDev57bo3=LQ@mail.gmail.com>
In-Reply-To: <CAC_iWjK2F13QxjuvqzqNLx00SiGz_FQ5X=MQxJyDev57bo3=LQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thiruan@microsoft.com; 
x-originating-ip: [2001:4898:80e8:f:e9b5:5e6a:92ce:7feb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1a6df5a-f5e8-4d59-3af5-08d70048cf8d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0501;
x-ms-traffictypediagnostic: CY4PR21MB0501:|CY4PR21MB0501:
x-microsoft-antispam-prvs: <CY4PR21MB05011DDCFE9D7F9C8CAE8B8FBCFA0@CY4PR21MB0501.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(199004)(189003)(13464003)(31014005)(8936002)(8676002)(22452003)(81166006)(66946007)(73956011)(68736007)(6116002)(25786009)(52536014)(10090500001)(81156014)(54906003)(33656002)(7416002)(6916009)(86362001)(316002)(76116006)(46003)(8990500004)(2906002)(6246003)(74316002)(5660300002)(66556008)(478600001)(305945005)(486006)(14454004)(99286004)(256004)(53936002)(14444005)(9686003)(55016002)(11346002)(476003)(64756008)(446003)(66476007)(4326008)(7736002)(229853002)(66446008)(102836004)(10290500003)(186003)(76176011)(71200400001)(53546011)(71190400001)(6506007)(6436002)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0501;H:CY4PR21MB0279.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kiXeAk3tYTcnRD5Wjx45IgXvClKH2kzYNMk/NRqnJT79cFffXvgrWemL8zKW6SGqs4TqXa91DFusaaOT+tsyAHUiOE5o7+ASaG4T42Wn+N9wgp4+vhXw5MzLOpXheKmXZOTXB9R5b75i7ZeSlbGw3P3FoO3CmXrtGna9FHKPv7rsX2QIWIOwWQ9wjN4A0wIGxQDhItP62D6W2a/kTDqYt7kCG9VusbglDcBcvQl9BwKP3yb/Exc3CJMmKDHHdyk74zyHVhDFfgNspw7JXjs2FDNf4nLuioVdi+L5/gymV4DpccD4gNETGfZgn8cVxe0C8fPaNvQobOhgQwBRG9rA3cow3IjKBdfE+GLJFKrwjpjKjEDrTxvzinqOTbp1xljWbuDq8F69lKW6wCZyuvzE79lh9jD7MunQR72gqFm8x5w=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a6df5a-f5e8-4d59-3af5-08d70048cf8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 06:28:21.4749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: thiruan@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0501
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

SGkgSWxpYXMsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSWxpYXMg
QXBhbG9kaW1hcyA8aWxpYXMuYXBhbG9kaW1hc0BsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNk
YXksIEp1bHkgMywgMjAxOSAxOjEyIEFNDQo+IFRvOiBUaGlydXBhdGhhaWFoIEFubmFwdXJlZGR5
IDx0aGlydWFuQG1pY3Jvc29mdC5jb20+DQo+IENjOiBKYXJra28gU2Fra2luZW4gPGphcmtrby5z
YWtraW5lbkBsaW51eC5pbnRlbC5jb20+OyBTYXNoYSBMZXZpbg0KPiA8c2FzaGFsQGtlcm5lbC5v
cmc+OyBwZXRlcmh1ZXdlQGdteC5kZTsgamdnQHppZXBlLmNhOyBjb3JiZXRAbHduLm5ldDsgbGlu
dXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LQ0KPiBpbnRlZ3JpdHlAdmdlci5rZXJuZWwub3JnOyBNaWNyb3NvZnQgTGludXggS2Vy
bmVsIExpc3QgPGxpbnV4LQ0KPiBrZXJuZWxAbWljcm9zb2Z0LmNvbT47IEJyeWFuIEtlbGx5IChD
U0kpIDxicnlhbmtlbEBtaWNyb3NvZnQuY29tPjsgdGVlLQ0KPiBkZXZAbGlzdHMubGluYXJvLm9y
Zzsgc3VtaXQuZ2FyZ0BsaW5hcm8ub3JnOyByZHVubGFwQGluZnJhZGVhZC5vcmc7IEpvYWtpbSBC
ZWNoDQo+IDxqb2FraW0uYmVjaEBsaW5hcm8ub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY3
IDEvMl0gZlRQTTogZmlybXdhcmUgVFBNIHJ1bm5pbmcgaW4gVEVFDQo+IA0KPiBIaSBUaGlydXBh
dGhhaWFoLA0KPiANCj4gKCtKb2FraW0pDQo+IA0KPiBPbiBXZWQsIDMgSnVsIDIwMTkgYXQgMDk6
NTgsIElsaWFzIEFwYWxvZGltYXMNCj4gPGlsaWFzLmFwYWxvZGltYXNAbGluYXJvLm9yZz4gd3Jv
dGU6DQo+ID4NCj4gPiBIaSBUaGlydXBhdGhhaWFoLA0KPiA+ID4NCj4gPiA+IEZpcnN0IG9mIGFs
bCwgVGhhbmtzIGEgbG90IGZvciB0cnlpbmcgdG8gdGVzdCB0aGUgZHJpdmVyLg0KPiA+ID4NCj4g
PiBucA0KPiA+DQo+ID4gWy4uLl0NCj4gPiA+ID4gSSBtYW5hZ2VkIHRvIGRvIHNvbWUgcXVpY2sg
dGVzdGluZyBpbiBRRU1VLg0KPiA+ID4gPiBFdmVyeXRoaW5nIHdvcmtzIGZpbmUgd2hlbiBpIGJ1
aWxkIHRoaXMgYXMgYSBtb2R1bGUgKHVzaW5nIElCTSdzIFRQTSAyLjANCj4gPiA+ID4gVFNTKQ0K
PiA+ID4gPg0KPiA+ID4gPiAtIEFzIG1vZHVsZQ0KPiA+ID4gPiAjIGluc21vZCAvbGliL21vZHVs
ZXMvNS4yLjAtcmMxL2tlcm5lbC9kcml2ZXJzL2NoYXIvdHBtL3RwbV9mdHBtX3RlZS5rbw0KPiA+
ID4gPiAjIGdldHJhbmRvbSAtYnkgOA0KPiA+ID4gPiByYW5kb21CeXRlcyBsZW5ndGggOA0KPiA+
ID4gPiAyMyBiOSAzZCBjMyA5MCAxMyBkOSA2Yg0KPiA+ID4gPg0KPiA+ID4gPiAtIEJ1aWx0LWlu
DQo+ID4gPiA+ICMgZG1lc2cgfCBncmVwIG9wdGVlDQo+ID4gPiA+IGZ0cG0tdGVlIGZpcm13YXJl
Om9wdGVlOiBmdHBtX3RlZV9wcm9iZTp0ZWVfY2xpZW50X29wZW5fc2Vzc2lvbiBmYWlsZWQsDQo+
ID4gPiA+IGVycj1mZmZmMDAwOA0KPiA+ID4gVGhpcyAoMHhmZmZmMDAwOCkgdHJhbnNsYXRlcyB0
byBURUVfRVJST1JfSVRFTV9OT1RfRk9VTkQuDQo+ID4gPg0KPiA+ID4gV2hlcmUgaXMgZlRQTSBU
QSBsb2NhdGVkIGluIHRoZSB5b3VyIHRlc3Qgc2V0dXA/DQo+ID4gPiBJcyBpdCBzdGl0Y2hlZCBp
bnRvIFRFRSBiaW5hcnkgYXMgYW4gRUFSTFlfVEEgb3INCj4gPiA+IElzIGl0IGV4cGVjdGVkIHRv
IGJlIGxvYWRlZCBkdXJpbmcgcnVuLXRpbWUgd2l0aCB0aGUgaGVscCBvZiB1c2VyIG1vZGUgT1At
DQo+IFRFRSBzdXBwbGljYW50Pw0KPiA+ID4NCj4gPiA+IE15IGd1ZXNzIGlzIHRoYXQgeW91IGFy
ZSB0cnlpbmcgdG8gbG9hZCBmVFBNIFRBIHRocm91Z2ggdXNlciBtb2RlIE9QLVRFRQ0KPiBzdXBw
bGljYW50Lg0KPiA+ID4gQ2FuIHlvdSBjb25maXJtPw0KPiA+IEkgdHJpZWQgYm90aA0KPiA+DQo+
IA0KPiBPayBhcHBhcmVudGx5IHRoZXJlIHdhcyBhIGZhaWx1cmUgd2l0aCBteSBidWlsdC1pbiBi
aW5hcnkgd2hpY2ggaQ0KPiBkaWRuJ3Qgbm90aWNlLiBJIGRpZCBhIGZ1bGwgcmVidWlsdCBhbmQg
Y2hlY2tlZCB0aGUgZWxmIHRoaXMgdGltZSA6KQ0KPiANCj4gQnVpbHQgYXMgYW4gZWFybHlUQSBt
eSBlcnJvciBub3cgaXM6DQo+IGZ0cG0tdGVlIGZpcm13YXJlOm9wdGVlOiBmdHBtX3RlZV9wcm9i
ZTp0ZWVfY2xpZW50X29wZW5fc2Vzc2lvbg0KPiBmYWlsZWQsIGVycj1mZmZmMzAyNCAodHJhbnNs
YXRlcyB0byBURUVfRVJST1JfVEFSR0VUX0RFQUQpDQo+IFNpbmNlIHlvdSB0ZXN0ZWQgaXQgb24g
cmVhbCBoYXJkd2FyZSBpIGd1ZXNzIHlvdSB0cmllZCBib3RoDQo+IG1vZHVsZS9idWlsdC1pbi4g
V2hpY2ggVEVFIHZlcnNpb24gYXJlIHlvdSB1c2luZz8NCg0KSSBhbSBnbGFkIHRoYXQgdGhlIGZp
cnN0IGlzc3VlIChURUVfRVJST1JfSVRFTV9OT1RfRk9VTkQpIGlzIHJlc29sdmVkIGFmdGVyIHN0
aXRjaGluZw0KZlRQTSBUQSBhcyBhbiBFQVJMWV9UQS4gDQoNClJlZ2FyZGluZyBURUVfRVJST1Jf
VEFSR0VUX0RFQUQgZXJyb3IsIG1heSBJIGtub3cgd2hpY2ggSFcgcGxhdGZvcm0geW91IGFyZSB1
c2luZyB0byB0ZXN0PyANCldoYXQgaXMgdGhlIHByZWJvb3QgZW52aXJvbm1lbnQgKFVFRkkgb3Ig
VS1ib290KT8gDQpXaGVyZSBpcyB0aGUgc2VjdXJlIHN0b3JhZ2UgaW4gdGhhdCBIVyBwbGF0Zm9y
bT8gDQpJIGNvdWxkIHRoaW5rIG9mIHR3byBjbGFzc2VzIG9mIHNlY3VyZSBzdG9yYWdlLiANCjEu
IFVGUy9lTU1DIFJQTUIgOiBJZiBTdXBwbGljYW50IGluIFUtYm9vdC9VRUZJIGluaXRpYWxpemVz
IHRoZSANCmZUUE0gVEEgTlYgU3RvcmFnZSwgdGhlcmUgc2hvdWxkIGJlIG5vIGlzc3VlLiANCklm
IGZUUE0gVEEgTlYgc3RvcmFnZSBpcyBub3QgaW5pdGlhbGl6ZWQgaW4gcHJlLWJvb3QgZW52aXJv
bm1lbnQgYW5kIHlvdSBhcmUgdXNpbmcNCmJ1aWx0LWluIGZUUE0gTGludXggZHJpdmVyLCB5b3Ug
Y2FuIHJ1biBpbnRvIHRoaXMgaXNzdWUgYXMgVEEgd2lsbCB0cnkgdG8gaW5pdGlhbGl6ZQ0KTlYg
c3RvcmUgYW5kIGZhaWwuIA0KDQoyLiBvdGhlciBzdG9yYWdlIGRldmljZXMgbGlrZSBRU1BJIGFj
Y2Vzc2libGUgdG8gb25seSBzZWN1cmUgbW9kZSBhZnRlcg0KRUJTL1JlYWR5VG9Cb290IG1pbGUg
cG9zdHMgZHVyaW5nIGJvb3QuIEluIHRoaXMgY2FzZSwgdGhlcmUgc2hvdWxkIGJlIG5vIGlzc3Vl
IGF0IGFsbA0KYXMgdGhlcmUgaXMgbm8gZGVwZW5kZW5jeSBvbiBub24tc2VjdXJlIHNpZGUgc2Vy
dmljZXMgcHJvdmlkZWQgYnkgc3VwcGxpY2FudC4gDQoNCklmIHlvdSBsZXQgbWUga25vdyB0aGUg
SFcgcGxhdGZvcm0gZGV0YWlscywgSSBhbSBoYXBweSB0byB3b3JrIHdpdGggeW91IHRvIGVuYWJs
ZS9pbnRlZ3JhdGUNCmZUUE0gVEEgb24gdGhhdCBIVyBwbGF0Zm9ybS4gDQoNCg0KQmVzdCBSZWdh
cmRzLA0KVGhpcnUNCg0KDQo=
