Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D203EE761
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Aug 2021 09:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbhHQHmr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 Aug 2021 03:42:47 -0400
Received: from mail-eopbgr60116.outbound.protection.outlook.com ([40.107.6.116]:54758
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231500AbhHQHmq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Aug 2021 03:42:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2vfgdzQaU8pZYzIR8rg8d2ik7Is3LIw4DOAcVwRTWbINezR800H7qZwl3B+kKjE6tc0ycVs2c4gaFehhxpitwCqEaldT+k5hl4RKxUfoI0RyhoLAEnIBPsUadEhlTMw0XOdle6/OO0v22gFymhTkrq6v2GBHglAF28RBnEOOBPFvZl9zwZC7+de2sydwuOwVlAPTe8oVgIRouIks5cQesKfBGj/cchwxiaeJQHzFv0tWJEkH57Aml85fZdR2q6608RtIqEj+KzsDQkiXFhJqQnQ5l0RwOH844Ozkod/7KJiXTY3ji+OasPp09DuSUEcUWbnbGnhwAJ+kepl7LhkIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEgl17mZe32WnpHOMyYlBsSAtewewknH/gqi6JL88fM=;
 b=b/0C0sgLH7z7tCMCgUwBST9wfe3/uoGTGHNK2SF/XUTob+ivhZLM5Jb5zCa0MiwfIkrjKjESYzM2EtqE3mBW8G94KJB3l1n4wFvs4BpByvQU3C4tzLPYHsas9PxdseOGZJ01KKMuXXKpUbdjGL8agDaDPfIMjzfgPrcgSNjZeQyNMTHe19HZUBVHdvg2KHcUzGWfytbKxNrcNIKVw9+6O3Tlu6/KNNOsPETTQ2hhiwB76Rx6szjrY35JW8rGy4uG+eClf/PmwP9tme7sQcXXnc3ZEthTOQAWO6aOdhL9qwJJ0DFomk/pP+aOZuGEoDm+NRcnOCpO9/6Sc6OIdp7Unw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEgl17mZe32WnpHOMyYlBsSAtewewknH/gqi6JL88fM=;
 b=Jh5zTquC9TCZaabtomp5X7L3dE+78lhOHvPaQ0sYgHkhsfVSCbFXFdsvR1J4EcR//XsFaGWtprnO0GjN4vQclYTnBtnxjyB87RybiCXNUKEbQ1w5dlz9C54OOOloS0zsilWmoShos/HRe4PNEhDFzDmBEIoa8ez+kOrvct0/UoQ=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM9PR09MB4627.eurprd09.prod.outlook.com
 (2603:10a6:20b:284::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13; Tue, 17 Aug
 2021 07:42:11 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 07:42:11 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     Bruno Meneguele <bmeneg@redhat.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "kgold@linux.ibm.com" <kgold@linux.ibm.com>
Subject: Re: [PATCH v2 ima-evm-utils] libimaevm: make SHA-256 the default hash
 algorithm
Thread-Topic: [PATCH v2 ima-evm-utils] libimaevm: make SHA-256 the default
 hash algorithm
Thread-Index: AQHXkztjSksHtjc6IEiMHdQ8S6ZSyg==
Date:   Tue, 17 Aug 2021 07:42:11 +0000
Message-ID: <2fb236f1-2a10-02e4-f796-6865d3411c2f@viveris.fr>
References: <20210816205835.76183-1-bmeneg@redhat.com>
In-Reply-To: <20210816205835.76183-1-bmeneg@redhat.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f45e739-04bc-40e1-1180-08d96152865a
x-ms-traffictypediagnostic: AM9PR09MB4627:
x-microsoft-antispam-prvs: <AM9PR09MB462730F4DD516D7E956378F994FE9@AM9PR09MB4627.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FVqwXORshg280NJx1lFzGrnJ2CMZH6YtRqTQdg4eX5eX9zYFh8AOYjTE32g6j6n4pYeABZ9jZv2E6G+Kwpth5Vb20Fd9CgzSNbDFAo6AkkB0T07wOPvLynoOivMbpqTh6ztAtkOBFQvZAcTIIUtZsLkFcYnS/ysQFWTpDsdYOKAiQ5rfjK+CLbBWI6ihL/UQh5pvY8MFZ3nPJ8r+C3cr9SuODvTjYGcMHDjLLeD3CdkXzbyp/DS07BVBShOYzeUFSOI9+mpZzHN8zBr0DZjIpNztGKkgqMsMgBvsFif83bLOE/qhAnXyWGUpUYX6jkJ3NwnyRZ53bKEp+vaDD0FVvx69V/TXef2BrN8IKVVMq5YoHvW3JJF6ZOFTzZj/+PHIF6CqkJrhRzU5bqbbVmRz2mb4WGI4YNPMxCF4YEpMWagLZFnX6Xz0Fp1Lgjuq00Ri9WN/aAzB+y9SbcFbEt/1M62JbY35j2pRe36NT3SBQG9U1D/Ja1n7fAltiEaDccW+1icf+kvfkZGlEQxRpKGmNB+eBoNR35UNuegC6xp6nwlmrC3wgSq80v7kK7QNEPUUO3YR7dSjmmBXPaTfGbjv0qn52FvCcUXeFkFewlxD4sf7HYO7iiYnPAPGCKQpYNefDnlUAie3OEhVOP5uCLU5b0T0SuocENVU+Um9GMzhKCTDc6rWDKklTPbdNJVgLDZ0Ieev8leXImZROMmX1ZccG4yZehfFiuVdD9hbpVdutlwNHog7RxhSzhAplP0s0BGQ7IchTOKvFf2fk8KYE9emmAfdREHRqHIjEbbb/Tweh/2QNh4PCybw1FdFMStlaoUXmfyUe6LtHchAnYkL74iIOA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(346002)(39840400004)(136003)(53546011)(38100700002)(4326008)(36756003)(478600001)(6506007)(122000001)(186003)(54906003)(31686004)(26005)(83380400001)(110136005)(71200400001)(76116006)(6486002)(6512007)(966005)(66946007)(66476007)(66556008)(64756008)(86362001)(66446008)(8936002)(5660300002)(91956017)(316002)(38070700005)(2906002)(8676002)(31696002)(2616005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjMvMDZ5akJUajhXTE4rSTlWMGd4LzBoekFTaCs2VVpzY3M4MDY2dnFRbVYx?=
 =?utf-8?B?c0R5c1RCQ1lySm9obUtScWt2dzZ3U2w1U21KYjR1cGZkb2F6VEJ2UWt2Y0xj?=
 =?utf-8?B?M0FRYS9lbEhzaUM4OTRZN3VRaWNsUUxMc2ZEdGxFaXB4SjZNVk5DajF6a0dZ?=
 =?utf-8?B?bFJhM21qMTY1cHR6VTl2RGM0bXVSWlB1THBjb0Jtejd2NWNOS2RCQUQxcGQw?=
 =?utf-8?B?UEpWRXY4dXMrVEsvNThaeUxKNW5tRk12OWVjZGhYT2JnM1ZrQ2VFNHlmOHBr?=
 =?utf-8?B?T1VlanZOdXBiZUNmUmtSb0hZWjIyUkxNMHJsV0x6eFNYMjBGakZSNmJCZGd6?=
 =?utf-8?B?d0hlK1MrcDEvUS9vNjdkN2cxVjR3NGhyRU5BTW13QnRzY2trYXVqOG1aYU4z?=
 =?utf-8?B?d0VtWXlJZk1pN1JhTFNoTVZUZS9kdjdYVmJBS3VOY25PNnludHBpdWV0MVYx?=
 =?utf-8?B?bkErL0R0MVJXV1RuVlR0OCswZUs2b2JuVkNuOTRxRnhxS0gyVUhueUp6Zzg0?=
 =?utf-8?B?eHlLelMvUXRpQThCL1JRUXBhL3FxYmtMTjJ6TFE0Mkg3YWxLRkhITDZDR3NY?=
 =?utf-8?B?V0FXMWg3RG5vditVTlFOaC8xUnhiTm9aaXk2b1RCN3JheW9Lb0hFRmFXdTZm?=
 =?utf-8?B?OG1sZTZmSWtRM1lnWktNbmxQUlpRY1N1NnpGU2RyUjRUL09FbmNCM1gyVlBp?=
 =?utf-8?B?NmZQdXVCOEZmNktkV0xLbWY2ZFlRV0ZncVorY1crVGh6K21xUC9lNmYwUWNu?=
 =?utf-8?B?WUlSbGRrUk00ZHNoN2h5Qy94WUpISDRydG5uM2ZwK2VZRnFvcUt4cllvcGxM?=
 =?utf-8?B?MGo2Q3hTY0U1djVYcXVGbmpjVURjNlE4ZERSRlF0cVJuZ0w2dEhUamhZY3Bn?=
 =?utf-8?B?STcyMzFhb2xsd2lVc250Nkd3dFl0aFdDOEdKVXB4T0pUUUZKLzlNdFVsbFIx?=
 =?utf-8?B?ZVlDckVINExSRTJyc1dXS3A5bmhsYUZKZ3QwNHhxQUMrOHJVL2NLVzhGUUFU?=
 =?utf-8?B?Yk1TbTFhMFRWQWZKbGtiY0FneHFuT2IyUDFOeDlseFpCeTB1Z2ppQUpwN0lH?=
 =?utf-8?B?NjhNUmk5ZHh6bzNhVnAvVnpVKzZIdHR4VWd1TW02Rko0MGVyUzBEaGRGWFVU?=
 =?utf-8?B?VTlBWHArSTFHbFEvVmk2MWZkQWFqMktFOTFoMHYyb1BtRTZ3UEZ3LzNuZmV0?=
 =?utf-8?B?UVgrWDJldzdiZ3IrZDVsKzl6UlJzalNuNTJjMHRNN2dTTkliVEdVRXVRSksz?=
 =?utf-8?B?S2tudzVEd1lMekpUeVZTR3NvQURETkxzNVlwRkxtV2FaQ0tZSXhBbk41a2xE?=
 =?utf-8?B?V3NuWnZxUzBmV25IY0RUdXJQaTFXK0VWNTdkS1I5L1F1YUlIR2J4bzhHMFFl?=
 =?utf-8?B?NmRhUmF3VzQvT1M2N0w3b1BYY1pqRkhkKzVBZXptT1FoQ1pZVi9vV0F5L0d4?=
 =?utf-8?B?amUxYldYQlZMdk5oY1h5Znc5aEVLdGIrQUhDWERwMldCRzBBSXR6eU14Vit1?=
 =?utf-8?B?SmZwOUQvUVFPMGo5aWZ1dEl1b2FOL2lRMzRTcG9QTzRHaDhQa0JGdkxoZThp?=
 =?utf-8?B?UGZzZFQwQkpDRzd3eWIzOC83US9CNC8ySnp3SFZYcTZIWDd4U25BeVA4TWsy?=
 =?utf-8?B?VHIzY1ZvSG1memRtVDczNGFabmlrMkdzQm81dWlhMkFINEducFZDa0hYRnNP?=
 =?utf-8?B?UW5xOTBOWDJVTG9Id0EraTVmTjVTbDZMeHR1dW10SHdhckhPdEN2cy8yc0xV?=
 =?utf-8?B?V0htVlZzOHNkMDJjYVZVeFBKWlFERmk0OEJUMGxncWZuNkdPaTd6WVhHY3VG?=
 =?utf-8?B?TER6THBPQXE4QVFicHVtdz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <49D80750E0964840835EA81F63D17666@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f45e739-04bc-40e1-1180-08d96152865a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 07:42:11.7988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RMsX+EXZfsc22pA6YU6+uXulE6wZCE4tyZOwsY+szDldh6NP6UJc2V2x85jiqKhCdvIDaImkkrasMV73Edi7jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR09MB4627
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

SGkgQnJ1bm8sDQoNCk9uIDgvMTYvMjEgMTA6NTggUE0sIEJydW5vIE1lbmVndWVsZSB3cm90ZToN
Cj4gVGhlIFNIQS0xIGFsZ29yaXRobSBpcyBjb25zaWRlcmVkIGEgd2VhayBoYXNoIGFsZ29yaXRo
bSBhbmQgdGhlcmUgaGFzIGJlZW4NCj4gc29tZSBtb3ZlbWVudCB3aXRoaW4gY2VydGFpbiBkaXN0
cm9zIHRvIGRyb3AgaXRzIHN1cHBvcnQgY29tcGxldGVseSBvciBhdA0KPiBsZWFzdCBkcm9wIGl0
IGZyb20gdGhlIGRlZmF1bHQgYmVoYXZpb3IuIGltYS1ldm0tdXRpbHMgdXNlcyBpdCBhcyB0aGUN
Cj4gZGVmYXVsdCBhbGdvcml0aG0gaW4gY2FzZSB0aGUgdXNlciBkb2Vzbid0IGV4cGxpY2l0bHkg
YXNrIGZvciBhbm90aGVyDQo+IHRocm91Z2ggdGhlIC0taGFzaGFsZ28vLWEgb3B0aW9uLiBXaXRo
IHRoYXQsIG1ha2UgU0hBLTI1NiB0aGUgZGVmYXVsdCBoYXNoDQo+IGFsZ29yaXRobSBpbnN0ZWFk
Lg0KDQpJJ20gcmVhbGx5IGhhcHB5IHRvIHNlZSB0aGF0IHBhdGNoIQ0KSSBjb250cmlidXRlZCB0
byB0aGUgcGF0Y2hzZXQgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaW50ZWdyaXR5LzIw
MjEwODE2MDgxMDU2LjI0NTMwLTEtU2ltb24uVEhPQllAdml2ZXJpcy5mci9ULyNtODM3MmIyYjU1
ZGM4ZTE1MTdlMzc2MjQ4MjlmYzhjYjQzNjFiYWY0ZA0KYmVjYXVzZSBJIHJhbiBpbnRvIGV4YWN0
bHkgdGhpcyBpc3N1ZSBvZiAoaGFzaGluZyBmaWxlcyB3aXRoIFNIQTEgYmVjYXVzZSBvZg0KdGhl
ICJpbnNlY3VyZSIgZGVmYXVsdCBvZiBldm1jdGwpLg0KU28gSSdtIGRlZmluaXRlbHkgaW4gZmF2
b3Igb2Ygc3dpdGNoaW5nIHRoZSBkZWZhdWx0IGhhc2ggdG8gc2hhMjU2Lg0KDQpUaGF0IHNhaWQs
IGNvbnNpZGVyaW5nIHRoYXQgQ09ORklHX0lNQSAoaW4gdGhlIGtlcm5lbCkgZG9lc24ndCBkZXBl
bmQNCm9uIENPTkZJR19DUllQVE9fU0hBMjU2LCBpc24ndCB0aGVyZSBhIHJpc2sgdGhhdCBmaWxl
cyBoYXNoZXMvc2lnbmVkIHdpdGgNCnRoaXMgcGF0Y2ggY291bGQgYnJlYWsgb24gYSBrZXJuZWwg
d2hlcmUgdGhhdCBvcHRpb24gd2Fzbid0IHNlbGVjdGVkPw0KKEkgYWxzbyBkb24ndCBrbm93IGhv
dyBmcmVxdWVudCBrZXJuZWxzIHdpdGhvdXQgQ09ORklHX0NSWVBUT19TSEEyNTYNCm1heSBiZSAt
IGdpdmVuIHRoYXQgQ09ORklHX0VOQ1JZUFRFRF9LRVlTIHJlcXVpcmUgU0hBMjU2LCBwcm9iYWJs
eQ0Kbm90IHNvIG11Y2gpDQpJIGd1ZXNzIHRoaXMgYm9pbHMgZG93biB0bzogImRvIHdlIGtub3cg
b2YgYW55IGRpc3RyaWJ1dGlvbiBub3Qgc2VsZWN0aW5nDQpDUllQVE9fU0hBMjU2PyIuIElmIHdl
IGRvbid0LCB0aGVuIHRoZSBiYWNrd2FyZCBjb21wYXRpYmlsaXR5IGltcGFjdCBzaG91bGQNCmJl
IG5lYXJseSB2b2lkLiBJZiB3ZSBkbywgc29tZSBkZWNpc2lvbiBtdXN0IGJlIHRha2VuLg0KDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBCcnVubyBNZW5lZ3VlbGUgPGJtZW5lZ0ByZWRoYXQuY29tPg0K
PiAtLS0NCj4gQ2hhbmdlbG9nOg0KPiAgIHYxOiBhZGQgaW1hLWV2bS11dGlscyB0byB0aGUgW1BB
VENIXSBwYXJ0IG9mIHRoZSBzdWJqZWN0DQo+IA0KPiAgUkVBRE1FICAgICAgICAgIHwgMiArLQ0K
PiAgc3JjL2V2bWN0bC5jICAgIHwgMiArLQ0KPiAgc3JjL2xpYmltYWV2bS5jIHwgMiArLQ0KPiAg
MyBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvUkVBRE1FIGIvUkVBRE1FDQo+IGluZGV4IDg3Y2QzYjVjZDdkYS4uMGRjMDJm
NTUxNjczIDEwMDY0NA0KPiAtLS0gYS9SRUFETUUNCj4gKysrIGIvUkVBRE1FDQo+IEBAIC00MSw3
ICs0MSw3IEBAIENPTU1BTkRTDQo+ICBPUFRJT05TDQo+ICAtLS0tLS0tDQo+ICANCj4gLSAgLWEs
IC0taGFzaGFsZ28gICAgIHNoYTEgKGRlZmF1bHQpLCBzaGEyMjQsIHNoYTI1Niwgc2hhMzg0LCBz
aGE1MTINCj4gKyAgLWEsIC0taGFzaGFsZ28gICAgIHNoYTEsIHNoYTIyNCwgc2hhMjU2IChkZWZh
dWx0KSwgc2hhMzg0LCBzaGE1MTINCj4gICAgLXMsIC0taW1hc2lnICAgICAgIG1ha2UgSU1BIHNp
Z25hdHVyZQ0KPiAgICAtZCwgLS1pbWFoYXNoICAgICAgbWFrZSBJTUEgaGFzaA0KPiAgICAtZiwg
LS1zaWdmaWxlICAgICAgc3RvcmUgSU1BIHNpZ25hdHVyZSBpbiAuc2lnIGZpbGUgaW5zdGVhZCBv
ZiB4YXR0cg0KPiBkaWZmIC0tZ2l0IGEvc3JjL2V2bWN0bC5jIGIvc3JjL2V2bWN0bC5jDQo+IGlu
ZGV4IGE4MDY1YmJlMTI0YS4uZTBlNTViYzBiMTIyIDEwMDY0NA0KPiAtLS0gYS9zcmMvZXZtY3Rs
LmMNCj4gKysrIGIvc3JjL2V2bWN0bC5jDQo+IEBAIC0yNDk2LDcgKzI0OTYsNyBAQCBzdGF0aWMg
dm9pZCB1c2FnZSh2b2lkKQ0KPiAgDQo+ICAJcHJpbnRmKA0KPiAgCQkiXG4iDQo+IC0JCSIgIC1h
LCAtLWhhc2hhbGdvICAgICBzaGExIChkZWZhdWx0KSwgc2hhMjI0LCBzaGEyNTYsIHNoYTM4NCwg
c2hhNTEyLCBzdHJlZWJvZzI1Niwgc3RyZWVib2c1MTJcbiINCj4gKwkJIiAgLWEsIC0taGFzaGFs
Z28gICAgIHNoYTEsIHNoYTIyNCwgc2hhMjU2IChkZWZhdWx0KSwgc2hhMzg0LCBzaGE1MTIsIHN0
cmVlYm9nMjU2LCBzdHJlZWJvZzUxMlxuIg0KPiAgCQkiICAtcywgLS1pbWFzaWcgICAgICAgbWFr
ZSBJTUEgc2lnbmF0dXJlXG4iDQo+ICAJCSIgIC1kLCAtLWltYWhhc2ggICAgICBtYWtlIElNQSBo
YXNoXG4iDQo+ICAJCSIgIC1mLCAtLXNpZ2ZpbGUgICAgICBzdG9yZSBJTUEgc2lnbmF0dXJlIGlu
IC5zaWcgZmlsZSBpbnN0ZWFkIG9mIHhhdHRyXG4iDQo+IGRpZmYgLS1naXQgYS9zcmMvbGliaW1h
ZXZtLmMgYi9zcmMvbGliaW1hZXZtLmMNCj4gaW5kZXggOGU5NjE1Nzk2MTUzLi5mNmM3MmI4Nzhk
ODggMTAwNjQ0DQo+IC0tLSBhL3NyYy9saWJpbWFldm0uYw0KPiArKysgYi9zcmMvbGliaW1hZXZt
LmMNCj4gQEAgLTg4LDcgKzg4LDcgQEAgc3RhdGljIGNvbnN0IGNoYXIgKmNvbnN0IHBrZXlfaGFz
aF9hbGdvX2tlcm5bUEtFWV9IQVNIX19MQVNUXSA9IHsNCj4gIHN0cnVjdCBsaWJpbWFldm1fcGFy
YW1zIGltYWV2bV9wYXJhbXMgPSB7DQo+ICAJLnZlcmJvc2UgPSBMT0dfSU5GTywNCj4gIAkueDUw
OSA9IDEsDQo+IC0JLmhhc2hfYWxnbyA9ICJzaGExIiwNCj4gKwkuaGFzaF9hbGdvID0gInNoYTI1
NiIsDQo+ICB9Ow0KPiAgDQo+ICBzdGF0aWMgdm9pZCBfX2F0dHJpYnV0ZV9fICgoY29uc3RydWN0
b3IpKSBsaWJpbml0KHZvaWQpOw0KPiANCg0KTm8gY29tbWVudHMgb24gdGhlIGNvZGUgY2hhbmdl
LCBpdCBsb29rcyBhbHJpZ2h0IHRvIG1lLg0KDQpUaGFua3MsDQpTaW1vbg==
