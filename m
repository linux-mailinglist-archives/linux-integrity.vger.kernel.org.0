Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7736158AEF
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Feb 2020 08:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbgBKH56 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Feb 2020 02:57:58 -0500
Received: from us-smtp-delivery-148.mimecast.com ([216.205.24.148]:25420 "EHLO
        us-smtp-delivery-148.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727613AbgBKH56 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Feb 2020 02:57:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rambus.com;
        s=mimecast20161209; t=1581407875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mBgaaOr9ApaqiTUqZfIBj4ftiMLPH+ejc1ysarFIJ3E=;
        b=HluC1yNwbQt7P0ZeKxPG4jENidreI3Rz7+yQHUInkBHNcP7w+w13wiFWX2gVLSbwLu1WxK
        ys806oPFUVdKXWN78T9R0u2VtKZHXMxK4FhDr8eHJxB30Dj62h6oxY/h5kjMS5Y2X6NOOv
        X0xDUWcHmXS/z0hSbTreddHgQLu+Kls=
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-c3Av0bl4MUyNuJHQS-QQvQ-1; Tue, 11 Feb 2020 02:56:07 -0500
Received: from SN4PR0401MB3663.namprd04.prod.outlook.com (10.167.133.19) by
 SN4PR0401MB3535.namprd04.prod.outlook.com (10.167.150.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Tue, 11 Feb 2020 07:56:04 +0000
Received: from SN4PR0401MB3663.namprd04.prod.outlook.com
 ([fe80::c071:99a5:6da8:924e]) by SN4PR0401MB3663.namprd04.prod.outlook.com
 ([fe80::c071:99a5:6da8:924e%7]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 07:56:04 +0000
From:   "Van Leeuwen, Pascal" <pvanleeuwen@rambus.com>
To:     Ken Goldman <kgold@linux.ibm.com>
CC:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] crypto: sm3 - add a new alias name sm3-256
Thread-Topic: [PATCH 1/2] crypto: sm3 - add a new alias name sm3-256
Thread-Index: AQHV3ZghOpovmI7C7UCUiLL8Qi2t+6gTxgGAgADdmwCAAAKQgIAAAQJwgAAWNQCAAOe3kA==
Date:   Tue, 11 Feb 2020 07:56:04 +0000
Message-ID: <SN4PR0401MB36637D914CAB78B2B104A73EC3180@SN4PR0401MB3663.namprd04.prod.outlook.com>
References: <20200207092219.115056-1-tianjia.zhang@linux.alibaba.com>
 <20200207092219.115056-2-tianjia.zhang@linux.alibaba.com>
 <20200210031717.GA5198@sol.localdomain>
 <1a623251-e83a-3b70-9fbd-8e929a23f7d8@linux.ibm.com>
 <7a496bb15f264eab920bf081338d67af@MN2PR20MB2973.namprd20.prod.outlook.com>
 <CY4PR0401MB36523805F71721000F188F2FC3190@CY4PR0401MB3652.namprd04.prod.outlook.com>
 <3b21122352a44cb9a20030a32f07e38a@MN2PR20MB2973.namprd20.prod.outlook.com>
In-Reply-To: <3b21122352a44cb9a20030a32f07e38a@MN2PR20MB2973.namprd20.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.204.2.113]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae7ca0bf-2d78-4fb2-75c8-08d7aec7d861
x-ms-traffictypediagnostic: SN4PR0401MB3535:
x-microsoft-antispam-prvs: <SN4PR0401MB3535D0DC6766B9512E14CBC4C3180@SN4PR0401MB3535.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0310C78181
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(376002)(346002)(39850400004)(199004)(189003)(86362001)(64756008)(2906002)(66556008)(66946007)(66476007)(66446008)(76116006)(316002)(186003)(5660300002)(54906003)(6916009)(71200400001)(8676002)(478600001)(81156014)(9686003)(53546011)(6506007)(81166006)(52536014)(4326008)(26005)(55016002)(8936002)(33656002)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0401MB3535;H:SN4PR0401MB3663.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ypAjPRCYAOO2PiBRW88lCy83ZSAfvl13Ab2xON9a8j+ZhSrsokzkV/Rb0PDvA1M/pfYE1gOEoPKISj/Q2ktH/aDipP8Ae9Pg7j/apk7DL4i6/+CTpHdbhlDTrqXBsf6qL1fGqmfRO9uzkPlmOn3jLyg65zBDQ//cgCajxqWLhQihvWbXmayqXklo14tklEYxzX6FDUoeX1aaceTtZNe+HOBDFKSTXXKp2OUEbscum4NdJU55dH7j69MOInpfRj5/A1YgF/9Lu4p81yNpsZqxa1OVq1R4ba1AO+fZUHXYnZY2XLr2WwrpJxmZZuV3C9415PDpOpDSEr6YseWOVqbGfJ+q5mNP6gdf9Os/miwUDVEFuoevI/SOwoWnT2pJncDd5jnYcNhW2rrP1wCd7nnvnybHBXS3jKDm+pEIYw+BZj/5Uo2Y7b1O56kc6//E5KUH
x-ms-exchange-antispam-messagedata: yP9JTU4ai/qunQUnSGCRJeQ6Y6G0xPTZHrH17pJ2bBfrxoZl//TaWg0i7w/oYMVOqPXEKGht8fEOuQPQ8lQecONUqQVEUlgjUUGZ8tCBUgVyslNDIir/F5PtRz96ATElL4Pf/9XC7G3q1zSsdrZanA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: rambus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7ca0bf-2d78-4fb2-75c8-08d7aec7d861
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2020 07:56:04.6906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bd0ba799-c2b9-413c-9c56-5d1731c4827c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P0HSWzEqOeWZLXwu4+jNag870tJg9ps/vfTTATY27NUncvUt1uZf0HLvKxdhdd19dqBZXS6nK++hO1UCqAqNEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3535
X-MC-Unique: c3Av0bl4MUyNuJHQS-QQvQ-1
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
ZWhhbGYgT2YgS2VuIEdvbGRtYW4NCj4gU2VudDogTW9uZGF5LCBGZWJydWFyeSAxMCwgMjAyMCA3
OjAzIFBNDQo+IENjOiBsaW51eC1jcnlwdG9Admdlci5rZXJuZWwub3JnOyBsaW51eC1pbnRlZ3Jp
dHlAdmdlci5rZXJuZWwub3JnOyBsaW51eC1zZWN1cml0eS1tb2R1bGVAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IDEvMl0gY3J5cHRvOiBzbTMgLSBhZGQgYSBuZXcgYWxpYXMgbmFtZSBzbTMtMjU2DQo+DQo+IDw8
PCBFeHRlcm5hbCBFbWFpbCA+Pj4NCj4gQ0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZy
b20gb3V0c2lkZSBvZiB0aGUgb3JnYW5pemF0aW9uLiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUNCj4gc2VuZGVyL3NlbmRlciBh
ZGRyZXNzIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+DQo+DQo+IE9uIDIvMTAvMjAy
MCAxMjowMSBQTSwgVmFuIExlZXV3ZW4sIFBhc2NhbCB3cm90ZToNCj4gPiBXZWxsLCB0aGUgY3Vy
cmVudCBzcGVjaWZpY2F0aW9uIHN1cmVseSBkb2Vzbid0IGRlZmluZSBhbnl0aGluZyBlbHNlIGFu
ZCBpcw0KPiA+IGFscmVhZHkgb3ZlciBhIGRlY2FkZSBvbGQuIFNvIHdoYXQgd291bGQgYmUgdGhl
IG9kZHMgdGhhdCB0aGV5IGFkZCBhDQo+ID4gZGlmZmVyZW50IGJsb2Nrc2l6ZSB2YXJpYW50X25v
d18gIEFORCBzdGlsbCBjYWxsIHRoYXQgU00zLXNvbWV0aGluZz8NCj4NCj4gSSBqdXN0IGdvdCBh
IG5vdGUgZnJvbSBhIGNyeXB0b2dyYXBoZXIgd2hvIHNhaWQgdGhlcmUgd2VyZSBkaXNjdXNzaW9u
cw0KPiBsYXN0IHllYXIgYWJvdXQgYSBmdXR1cmUgU00zIHdpdGggNTEyIGJpdCBvdXRwdXQuDQo+
DQo+IEdpdmVuIHRoYXQsIHdoeSBub3QgcGxhbiBhaGVhZCBhbmQgdXNlIHNtMy0yNTY/ICBJcyB0
aGVyZSBhbnkgZG93bnNpZGU/DQo+IElzIHRoZSBjb3N0IGFueSBtb3JlIHRoYW4gNCBieXRlcyBp
biBzb21lIHNvdXJjZSBjb2RlPw0KPg0KDQpJdCBpcyBhY3R1YWxseSBleHBvcnRlZCBhcyAic20z
IiBieSBhbGwgaW1wbGVtZW50YXRpb25zLCBpdCdzIGp1c3QgdGhpcyBvbmUgcmVmZXJlbmNlIHRo
YXQgd2FzIG9mZi4NClNvIGZpeGluZyB0aGF0IG9uZSByZWZlcmVuY2UgaXMgbGVzcyBlZmZvcnQg
dGhhbiBmaXhpbmcgYWxsIGltcGxlbWVudGF0aW9ucy4NCkkgZG9uJ3QgdGhpbmsgYW55b25lIGNh
cmVzIGFib3V0IHRoZSA0IGJ5dGVzIG9mIHNvdXJjZSBjb2RlIC4uLg0KDQpBcyBmb3IgU00zLTUx
MjogdGhhdCB3b3VsZCBieSBzaWxseSwgY29uc2lkZXJpbmcgcmVjZW50IGF0dGFja3MgZm91bmQg
YWdhaW5zdCBzaW1pbGFyDQpNZXJrbGUtRGFybWdhcmQgc3RydWN0dXJlcy4gIFRoZW4gYWdhaW4s
IEknbSBub3QgdGFsa2luZyB0byBDaGluZXNlIGNyeXB0b2dyYXBoZXJzLg0KSW4gYW55IGNhc2Us
IHdoYXQgd291bGQgYmUgdGhlIHByb2JsZW0gd2l0aCBoYXZpbmcgInNtMyIgYW5kICJzbTMtNTEy
Ij8NCk5vdGUgdGhhdCBub2JvZHkgaW4gdGhlIHdvcmxkIHJlZmVycyB0byB0aGUgY3VycmVudCBT
TTMgYXMgIlNNMy0yNTYiLg0KDQpSZWdhcmRzLA0KUGFzY2FsIHZhbiBMZWV1d2VuDQpTaWxpY29u
IElQIEFyY2hpdGVjdCBNdWx0aS1Qcm90b2NvbCBFbmdpbmVzLCBSYW1idXMgU2VjdXJpdHkNClJh
bWJ1cyBST1RXIEhvbGRpbmcgQlYNCiszMS03MyA2NTgxOTUzDQoNCk5vdGU6IFRoZSBJbnNpZGUg
U2VjdXJlL1ZlcmltYXRyaXggU2lsaWNvbiBJUCB0ZWFtIHdhcyByZWNlbnRseSBhY3F1aXJlZCBi
eSBSYW1idXMuDQpQbGVhc2UgYmUgc28ga2luZCB0byB1cGRhdGUgeW91ciBlLW1haWwgYWRkcmVz
cyBib29rIHdpdGggbXkgbmV3IGUtbWFpbCBhZGRyZXNzLg0KDQoNCioqIFRoaXMgbWVzc2FnZSBh
bmQgYW55IGF0dGFjaG1lbnRzIGFyZSBmb3IgdGhlIHNvbGUgdXNlIG9mIHRoZSBpbnRlbmRlZCBy
ZWNpcGllbnQocykuIEl0IG1heSBjb250YWluIGluZm9ybWF0aW9uIHRoYXQgaXMgY29uZmlkZW50
aWFsIGFuZCBwcml2aWxlZ2VkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50
IG9mIHRoaXMgbWVzc2FnZSwgeW91IGFyZSBwcm9oaWJpdGVkIGZyb20gcHJpbnRpbmcsIGNvcHlp
bmcsIGZvcndhcmRpbmcgb3Igc2F2aW5nIGl0LiBQbGVhc2UgZGVsZXRlIHRoZSBtZXNzYWdlIGFu
ZCBhdHRhY2htZW50cyBhbmQgbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkuICoqDQoNClJh
bWJ1cyBJbmMuPGh0dHA6Ly93d3cucmFtYnVzLmNvbT4NCg==

