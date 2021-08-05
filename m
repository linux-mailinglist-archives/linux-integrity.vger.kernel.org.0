Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF91D3E0F72
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Aug 2021 09:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbhHEHms (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 Aug 2021 03:42:48 -0400
Received: from mail-am6eur05on2105.outbound.protection.outlook.com ([40.107.22.105]:6464
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230298AbhHEHmr (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Aug 2021 03:42:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avD+DImciNt8fcUP87bn8f+I24RYgEJzYnQxRPcshjp+Y7e2xAI/X0QyexNUeoWQxnkk5yGcu9IMWN62Atb8t0n7ZqMm2B4KxNQYZUJHFtwAeJD4H0/rzx5uZUj96lY8uePJYrR1tnqTUId4FjXoV6u7vt2hvk5IrvR4C7V83vKlWbh93yvUq+mJGS74RDetjw9ZDg3+dT0SiqPavz8MukfUsUCOGHSOhjd+Lob7xnJBLtavZLd0GpK3QrH3e4gUzRNyJZxGOpDeXP2bwaZ6rc0whclPnaO6c8OtnyrySjK3QwUrX81fK5ZSVxtnc5EyAC76KmS2jjzgbY4BB25WDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/QSjp82xpSs9Qm1gn0W7fFSqIGkqnUthcRCiuI5OIo=;
 b=aZ+WaemxhjjpAcVhpa2gtboNqFIKR+34Huqjs/UEcMb4A8vKEoHihUiTkqnRhM2zqPDlQI0+QIhH6tSNkQDOAHlc2bozw/hnUx1/DiXhzMlOzFxzTQDWjV39+PJoNdudevOBqxIS8Ge0yHL5elu2TqZb+0Mp3Vjd2xl7/vexi+1+fkREUbavbcG8xdXeSKQtrns9dS6X4Z86hvYauajAqWWchfTGy0yTTiK86lwuQzMe6m3xI/BSVjErbj4pOL78Krfq1WZInzIJQqHXrZkVmFR0gTf1tjhKdeGFR+mN/hMNP8f+16z56oXxd3VwO0fG1lIDhi4gvGPePNWlsp9LqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/QSjp82xpSs9Qm1gn0W7fFSqIGkqnUthcRCiuI5OIo=;
 b=i9wnpzmWfvIwHGaEzuWC7cVIwAi0BFUz8CtVGroGjTu0zIfovAazAA1xit997oN0B5NB8rOjzv+IT1X40dbC+1Su8BDOKDg7KEKmG80J2X14akoovpuvCmbqmlSnD6uHoRO15Ey11eztpdQoKsPOcwAW600y3TLCfo38g/oMgIw=
Received: from HE1PR0902MB1755.eurprd09.prod.outlook.com (2603:10a6:3:f2::20)
 by HE1PR0901MB1594.eurprd09.prod.outlook.com (2603:10a6:3:51::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Thu, 5 Aug
 2021 07:42:30 +0000
Received: from HE1PR0902MB1755.eurprd09.prod.outlook.com
 ([fe80::dd95:456d:43e0:786f]) by HE1PR0902MB1755.eurprd09.prod.outlook.com
 ([fe80::dd95:456d:43e0:786f%10]) with mapi id 15.20.4394.016; Thu, 5 Aug 2021
 07:42:30 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
Subject: Re: [PATCH v6 4/5] IMA: add a policy option to restrict xattr hash
 algorithms on appraisal
Thread-Topic: [PATCH v6 4/5] IMA: add a policy option to restrict xattr hash
 algorithms on appraisal
Thread-Index: AQHXiRHwP4uH3YN0jEO3MuWIchehQ6tj00oAgAC1dIA=
Date:   Thu, 5 Aug 2021 07:42:30 +0000
Message-ID: <cd17a618-d0c6-d143-b520-0ae43564ff44@viveris.fr>
References: <20210804092010.350372-1-simon.thoby@viveris.fr>
 <20210804092010.350372-5-simon.thoby@viveris.fr>
 <a1cad70f-b146-988a-746f-6c64f9631848@linux.microsoft.com>
In-Reply-To: <a1cad70f-b146-988a-746f-6c64f9631848@linux.microsoft.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.microsoft.com; dkim=none (message not signed)
 header.d=none;linux.microsoft.com; dmarc=none action=none
 header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2dc94ea6-71a6-4b18-2a35-08d957e4946a
x-ms-traffictypediagnostic: HE1PR0901MB1594:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR0901MB15945B0BBEC443D02C397ED994F29@HE1PR0901MB1594.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:370;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HSfCzDvOXa/Xr2Q0xcAAuujWr0H8oCyEBtQgrjU2FEKsLezBiW00WWpyQ4eEk/pS7UItbI5wELDuBRczudMZgqbnzEl4iBVnv954OHkTxELgxMXuo0Gcz/3jPCQuac7BlKLzI3XLI+JNe23L19e4Yzoonx6d7kIcYz0bL8bWHzqrcfMe0tgvw/t+0L374tNm71R3wcJkX0DwJhBFRDSgPIsK2uuWh0xCMkrlgAiPjHOq0oFQcDRp9++zo1hV0843tekF72sf04rmGZgSmiLISCuUOm8eVI8kiyOfvti97Leg5EPGNeFtmgwpSylwG5QnieH+/U9ES1bu4VDr+YjfSPjKuagmpPQECmy64lTgQ+VU8lfWX1Es9pr4N9L2A2oemyFfAJgMzjCm3xtlj2qDe52JSC9wswDiDbs3Boxav5i1HNvk5+fOhqe2SjBY9EmFzLlOmjzsRcd2RxNvKlKNyyJg4X2IkcG9ySBJ1umFkj0JFNQ/DsBEYNiFUsod4g7paXIeQEe63wUiIRhccPRzV6oqLoP7eAcyKk5gap1MOREO7bbgmVcfrM3bwGCM8lagaf3rcQyTXJ39K3dzKxMt3knuxaWoqd/EaoDz8Knq1wdshGU6QeS04t/mmH8FKiCrZodv3cUR6I4C4ubUbzxn6UYkH2Na7B9qT1WVMtUfSgQQxBTY/+T4SVJ0QlMXG+TN2yyiKusvfsYynTQQR8Pkoja2CA00nkxAn6e+UtrdDnH1evd+4wTJIvkEOoISUBjz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0902MB1755.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39830400003)(376002)(136003)(366004)(346002)(38070700005)(31686004)(66476007)(6636002)(66556008)(6486002)(2616005)(83380400001)(8936002)(38100700002)(66946007)(122000001)(91956017)(31696002)(76116006)(2906002)(110136005)(86362001)(36756003)(53546011)(186003)(26005)(6512007)(5660300002)(6506007)(66446008)(478600001)(64756008)(71200400001)(316002)(8676002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXZhQU5NTkJ5TndkYTNBTldQZ3U3dFdzZzBWWE9qVDJuanBFdUk0ZUFOWEw3?=
 =?utf-8?B?bFVVWm04OWtZYnZKQ2FneVQ3eVdUYWE1dVJuTE9lQzNtOEwxdE1mcjV6LzlL?=
 =?utf-8?B?THVjUzhLYW5uc1B6T3ZhK1kyd0FjWmk2T296NXY3Zm5jL0dRUCtvYVJJT2Qy?=
 =?utf-8?B?Smk3V3Y1bCtCTitUaDVCVGJWNmxhUVI5Um9rd1BhN3l4L3dTRTIxV0hnSkpx?=
 =?utf-8?B?STFpNXkzWjBxK3k0aWJmeVlDQ3FDVkNjK3VtdnFiTGp5OEJ4OE1MUVFPaUc0?=
 =?utf-8?B?MkFIKzVBR083RERwUjZ1dmdZcENUcnIrUmcvWWRQSWxvaDZqeENVV1hKYmp5?=
 =?utf-8?B?aVp0NklGSGFrbkNoZ2JIWUpYT3FWS2E3d09ORkx4d0VIU2VKeUsrNmhaek9v?=
 =?utf-8?B?UmhIMk5ocmtUNEh0bHFaTEpCMTloZXdNU2wyaFZBU3I1bHZFSkdzWFVqdkM1?=
 =?utf-8?B?NXBlc0pMM3lTSlA1ZzhxNU9LTFBSVkxhMHFMd0gyd2VDZ2tJWTJ1RUlRTXdV?=
 =?utf-8?B?RklQYmdiOXZtdHUrSjNaL2dBSWNNZ0dxdXcvMkVFT0YrNnJYamJWWlo3RFVU?=
 =?utf-8?B?YUZLVytFTjRBS1hHTk5HRGg4Q1c3ckNMWXd4YVM1YU9GalJBY2pVbmpBUThy?=
 =?utf-8?B?NXdnOEhCYW9qdEx5QUJmc1JZMnRFOHV5SW1JWlVNN0Q2bURzKzN6UVlkZEpG?=
 =?utf-8?B?Y012VHdWTFhrL1J5UGFKanplOHdzRnd1cWdmTG5DSGtQQ29CNnpiN3ZPeDZF?=
 =?utf-8?B?a2NGWHlrd0lPeWdYMWNpSHNqeGZqVEJzYWdXY0tvZmV6M3o0Y1NjS3pmSUdX?=
 =?utf-8?B?RzZpemlJa3JDTENOWXFaUzZ3cDMxbkhBb3pZcGpiNERnYmFKL1dXYytkVVFH?=
 =?utf-8?B?UVArcUtpUjRjb0hPM2tSTDRDL3AzdXFsS0w0RWJGaDk0ZlNoSkhOWTNaYWtL?=
 =?utf-8?B?NjVIenlYTGNQSngzYmZmNXBGb2Zyd2tHUUlZY0NTK0tLWEJ3TUw4cTdDSDdl?=
 =?utf-8?B?YklITi9hQ3IrdGM3QUNxOWVNK2s5TnhHQk9SMldQbUFHL056aW1ScTFxdXN5?=
 =?utf-8?B?SFVRaEo4aVJmaTkwZytEVzk4UmNDYkxjTldwZFVHSDlVYmpCUElZMTMwQjhR?=
 =?utf-8?B?ZXJaS3FubnpZaWVaT0RVS1RyL0F1ak84bzNseVZ2OTBERS9VWWk1ODY0MWJy?=
 =?utf-8?B?U24vcytwZjNhQXVYdjVEd2NnNVpsVGhZU3luRGJaaEdCdFUrN0tCSkVDU1hS?=
 =?utf-8?B?NkZiVjJ6NG1EUWYzYlduajM5N0VJeTlvc01XOEt2T21iYU9GclV0TjBEMk5B?=
 =?utf-8?B?VDdFVXdVWTRuVHpLQjhZOE5OdTB3aTdEeGVNYWlJQ2hGbG8zUzQvVEV0dkQr?=
 =?utf-8?B?azNYWnRPVXdIc3RpZlkxeFkrU3MrQ2VmMHVyZm4rWkVBM09SRnV0OGZwanY0?=
 =?utf-8?B?UHJ1YTFuV0IxYmxXQlBQeXRRVWFtRlZZelZXc2pYWlJTNkdSdUpSVGpRdysx?=
 =?utf-8?B?Q3FPcUJHTFNkaVJabmFzbUZETEFCM0VBL1dOWjJxQ1V5YTY1N3VjWlZpb0Ji?=
 =?utf-8?B?ZWR0R0VyTzdxb3RCSmZHNGhwd2ZpVkZiVlFmK29RV3dmN3B3cStuclVoYkFN?=
 =?utf-8?B?OHQ4QlFRdXJNdDl4TVE5OVJFOFhNbkVKTHdiQnZyTEVFTlNHQ0l0UXRVQUNx?=
 =?utf-8?B?UHZxY1NmUzhGMXZidUFOcmIrTUo0Q1MrbU4zTExHYUhYV3drMXhOR1Rva3Fn?=
 =?utf-8?Q?mDuVaJEl8Q/dE8n1Ki0Pf8yt+K2kZ60J4cWr9Mz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <806631B6B09E484BB6C937DB8F89A640@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0902MB1755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc94ea6-71a6-4b18-2a35-08d957e4946a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2021 07:42:30.2442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yRIM73N1h4kOZ0sUvkdETw6i/JBlOeSFnlrccJNr6/ar5BSZudmpmKECHp+jOJvsZMUT5OVTR4DpRGeemKjA6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0901MB1594
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

T24gOC80LzIxIDEwOjUzIFBNLCBMYWtzaG1pIFJhbWFzdWJyYW1hbmlhbiB3cm90ZToNCj4gSGkg
U2ltb24sDQo+IA0KPiBPbiA4LzQvMjAyMSAyOjIwIEFNLCBUSE9CWSBTaW1vbiB3cm90ZToNCj4g
DQo+PiBTaWduZWQtb2ZmLWJ5OiBTaW1vbiBUaG9ieSA8c2ltb24udGhvYnlAdml2ZXJpcy5mcj4N
Cj4+IFJldmlld2VkLWJ5OiBNaW1pIFpvaGFyIDx6b2hhckBsaW51eC5pYm0uY29tPg0KPj4gLS0t
DQo+PiDCoCBEb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL2ltYV9wb2xpY3kgfMKgIDYgKystDQo+
PiDCoCBzZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9wb2xpY3kuY8KgIHwgNzUgKysrKysrKysr
KysrKysrKysrKysrKysrKystLQ0KPj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCA3NiBpbnNlcnRpb25z
KCspLCA1IGRlbGV0aW9ucygtKQ0KPj4NCj4gDQo+PiDCoCArc3RhdGljIHVuc2lnbmVkIGludCBp
bWFfcGFyc2VfYXBwcmFpc2VfaGFzaChjaGFyICphcmcpDQo+PiArew0KPj4gK8KgwqDCoCB1bnNp
Z25lZCBpbnQgcmVzID0gMDsNCj4+ICvCoMKgwqAgaW50IGlkeDsNCj4+ICvCoMKgwqAgY2hhciAq
dG9rZW47DQo+PiArDQo+PiArwqDCoMKgIHdoaWxlICgodG9rZW4gPSBzdHJzZXAoJmFyZywgIiwi
KSkgIT0gTlVMTCkgew0KPj4gK8KgwqDCoMKgwqDCoMKgIGlkeCA9IG1hdGNoX3N0cmluZyhoYXNo
X2FsZ29fbmFtZSwgSEFTSF9BTEdPX19MQVNULCB0b2tlbik7DQo+PiArDQo+PiArwqDCoMKgwqDC
oMKgwqAgaWYgKGlkeCA8IDApIHsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHByX2Vycigi
dW5rbm93biBoYXNoIGFsZ29yaXRobSBcIiVzXCIsIGlnbm9yaW5nIiwNCj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdG9rZW4pOw0KPj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgY29udGludWU7DQo+IElzIGl0IHJpZ2h0IHRvIGlnbm9yZSBhbiBpbnZhbGlkIGRpZ2Vz
dCBhbGdvcml0aG0gZ2l2ZW4gaW4gdGhlIElNQSBwb2xpY3kgcnVsZT8gU2hvdWxkICJpbnZhbGlk
IGltYSBwb2xpY3kiIGVycm9yIGJlIHJlcG9ydGVkIGluc3RlYWQ/DQoNClVtIG5vIHlvdSdyZSBy
aWdodCwgYmV0dGVyIGJlIHN0cmljdCBpbiB3aGF0IHdlIGFjY2VwdCwgb3IgdXNlcnMgbWF5IHN0
YXJ0IGRlcGVuZGluZyBvbiBpdC4NCkknbGwgdXBkYXRlIHRoYXQuDQoNClRoYW5rcywNClNpbW9u
DQoNCj4gDQo+IE90aGVyIGNoYW5nZXMgbG9vayBnb29kLg0KPiANCj4gUmV2aWV3ZWQtYnk6IExh
a3NobWkgUmFtYXN1YnJhbWFuaWFuIDxucmFtYXNAbGludXgubWljcm9zb2Z0LmNvbT4NCj4gDQo+
IMKgLWxha3NobWkNCj4gDQo+PiArwqDCoMKgwqDCoMKgwqAgfQ0KPj4gKw0KPj4gK8KgwqDCoMKg
wqDCoMKgIC8qIEFkZCB0aGUgaGFzaCBhbGdvcml0aG0gdG8gdGhlICdhbGxvd2VkJyBiaXRmaWVs
ZCAqLw0KPj4gK8KgwqDCoMKgwqDCoMKgIHJlcyB8PSAoMVUgPDwgaWR4KTsNCj4+ICvCoMKgwqAg
fQ0KPj4gKw0KPj4gK8KgwqDCoCByZXR1cm4gcmVzOw0KPj4gK30NCj4+ICsNCj4+IMKgIHN0YXRp
YyBpbnQgaW1hX3BhcnNlX3J1bGUoY2hhciAqcnVsZSwgc3RydWN0IGltYV9ydWxlX2VudHJ5ICpl
bnRyeSkNCj4+IMKgIHsNCj4+IMKgwqDCoMKgwqAgc3RydWN0IGF1ZGl0X2J1ZmZlciAqYWI7DQo+
PiBAQCAtMTUyMiw2ICsxNTQ2LDI2IEBAIHN0YXRpYyBpbnQgaW1hX3BhcnNlX3J1bGUoY2hhciAq
cnVsZSwgc3RydWN0IGltYV9ydWxlX2VudHJ5ICplbnRyeSkNCj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGVsc2UNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVz
dWx0ID0gLUVJTlZBTDsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOw0KPj4g
K8KgwqDCoMKgwqDCoMKgIGNhc2UgT3B0X2FwcHJhaXNlX2hhc2g6DQo+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBpbWFfbG9nX3N0cmluZyhhYiwgImFwcHJhaXNlX2hhc2giLCBhcmdzWzBdLmZy
b20pOw0KPj4gKw0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGVudHJ5LT5hbGxvd2Vk
X2hhc2hlcykgew0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXN1bHQgPSAt
RUlOVkFMOw0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsNCj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4+ICsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGVudHJ5LT5hbGxvd2VkX2hhc2hlcyA9DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGltYV9wYXJzZV9hcHByYWlzZV9oYXNoKGFyZ3NbMF0uZnJvbSk7DQo+PiArDQo+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBpbnZhbGlkIG9yIGVtcHR5IGxpc3Qgb2YgYWxnb3JpdGht
cyAqLw0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFlbnRyeS0+YWxsb3dlZF9oYXNo
ZXMpIHsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVzdWx0ID0gLUVJTlZB
TDsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7DQo+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB9DQo+PiArDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbnRy
eS0+ZmxhZ3MgfD0gSU1BX1ZBTElEQVRFX0hBU0g7DQo+PiArDQo+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBicmVhazsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNlIE9wdF9wZXJtaXRfZGly
ZWN0aW86DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbnRyeS0+ZmxhZ3MgfD0gSU1B
X1BFUk1JVF9ESVJFQ1RJTzsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOw0K
Pj4gQEAgLTE3MTQsNiArMTc1OCwyMyBAQCBzdGF0aWMgdm9pZCBpbWFfc2hvd19ydWxlX29wdF9s
aXN0KHN0cnVjdCBzZXFfZmlsZSAqbSwNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBzZXFfcHJpbnRm
KG0sICIlcyVzIiwgaSA/ICJ8IiA6ICIiLCBvcHRfbGlzdC0+aXRlbXNbaV0pOw0KPj4gwqAgfQ0K
Pj4gwqAgK3N0YXRpYyB2b2lkIGltYV9wb2xpY3lfc2hvd19hcHByYWlzZV9oYXNoKHN0cnVjdCBz
ZXFfZmlsZSAqbSwNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgdW5zaWduZWQgaW50IGFsbG93ZWRfaGFzaGVzKQ0KPj4gK3sNCj4+ICvCoMKgwqAgaW50IGlk
eCwgbGlzdF9zaXplID0gMDsNCj4+ICsNCj4+ICvCoMKgwqAgZm9yIChpZHggPSAwOyBpZHggPCBI
QVNIX0FMR09fX0xBU1Q7IGlkeCsrKSB7DQo+PiArwqDCoMKgwqDCoMKgwqAgaWYgKCEoYWxsb3dl
ZF9oYXNoZXMgJiAoMVUgPDwgaWR4KSkpDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250
aW51ZTsNCj4+ICsNCj4+ICvCoMKgwqDCoMKgwqDCoCAvKiBvbmx5IGFkZCBjb21tYXMgaWYgdGhl
IGxpc3QgY29udGFpbnMgbXVsdGlwbGUgZW50cmllcyAqLw0KPj4gK8KgwqDCoMKgwqDCoMKgIGlm
IChsaXN0X3NpemUrKykNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNlcV9wdXRzKG0sICIs
Iik7DQo+PiArDQo+PiArwqDCoMKgwqDCoMKgwqAgc2VxX3B1dHMobSwgaGFzaF9hbGdvX25hbWVb
aWR4XSk7DQo+PiArwqDCoMKgIH0NCj4+ICt9DQo+PiArDQo+PiDCoCBpbnQgaW1hX3BvbGljeV9z
aG93KHN0cnVjdCBzZXFfZmlsZSAqbSwgdm9pZCAqdikNCj4+IMKgIHsNCj4+IMKgwqDCoMKgwqAg
c3RydWN0IGltYV9ydWxlX2VudHJ5ICplbnRyeSA9IHY7DQo+PiBAQCAtMTgyNSw2ICsxODg2LDEy
IEBAIGludCBpbWFfcG9saWN5X3Nob3coc3RydWN0IHNlcV9maWxlICptLCB2b2lkICp2KQ0KPj4g
wqDCoMKgwqDCoMKgwqDCoMKgIHNlcV9wdXRzKG0sICIgIik7DQo+PiDCoMKgwqDCoMKgIH0NCj4+
IMKgICvCoMKgwqAgaWYgKGVudHJ5LT5mbGFncyAmIElNQV9WQUxJREFURV9IQVNIKSB7DQo+PiAr
wqDCoMKgwqDCoMKgwqAgc2VxX3B1dHMobSwgImFwcHJhaXNlX2hhc2g9Iik7DQo+PiArwqDCoMKg
wqDCoMKgwqAgaW1hX3BvbGljeV9zaG93X2FwcHJhaXNlX2hhc2gobSwgZW50cnktPmFsbG93ZWRf
aGFzaGVzKTsNCj4+ICvCoMKgwqDCoMKgwqDCoCBzZXFfcHV0cyhtLCAiICIpOw0KPj4gK8KgwqDC
oCB9DQo+PiArDQo+PiDCoMKgwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBNQVhfTFNNX1JVTEVTOyBp
KyspIHsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoZW50cnktPmxzbVtpXS5ydWxlKSB7DQo+
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzd2l0Y2ggKGkpIHsNCj4+DQo=
