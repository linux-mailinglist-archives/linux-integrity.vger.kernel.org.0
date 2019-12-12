Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDE1011C654
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Dec 2019 08:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfLLHVd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Dec 2019 02:21:33 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:12300 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728043AbfLLHVc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Dec 2019 02:21:32 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBC7KBlw010985;
        Thu, 12 Dec 2019 02:21:22 -0500
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by mx0b-00128a01.pphosted.com with ESMTP id 2wraevybcg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Dec 2019 02:21:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIf77/CoK/xLKziPxYuQO5VaX9DkSeNnA5+yYHVaEgFZHHAJ/boxBBwR8x00LN4sHVj0kfsCzm0mDAGca/JCtoxPzPEb38ZA2VJj3R98wm5CMHtTmBOWjJFA27OjXBATlwFuC8qwIaTrt1Ut8Aot3A+Pu2hGUCHVH/Xp2GZHxCdXadUKflVcb60J0IGBTAVHljI5JaV22+4o/uHRW95iKmnbXmDA7lq7KCCVoiqJ+yp6ywQ1yCNySzTCQqjc7TS1Espfb4HneEH1kW3Pw02YsjbGfyPcRxCFDwkf/jJ5iADJWjceCSMTx+t51/lYo0Jx7Ajn+UewNXabQRh7CmHEQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+a83Rt1MQbC2yUj/eEBM7qcQvMa9aBBYlY5cZgjkUgA=;
 b=erQxciEHJtFbDaKeNrEfcZ+MxbK5mhD9IjJ6fCSISqCTVyvEYnpWc6bSJBtllthEPTKyGEcr49C2lnqegocs51G63mEeGd9JSauLetHeU5Zx9E8DfV6Cwc/aP/3ttcBpMlp5bUsV6YVCSq2lUj8RubyAerWD1fjfeQRWKxeUweWhCGAHkkDM4DjYogMNpa6N9pnoLLR/JJTab1VnaNhrCRMrM0uDXNXAhNNbjyqFj8+SJafhKzuyilocOiYMUBMM873Io/qrbUjWTtSz6CIs2cARqbsUoQzzG6qmjCAz/Pc28tAL3SixAoI1Cq4IYQBtV2i7eBtg1/ChcGpKGotlbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+a83Rt1MQbC2yUj/eEBM7qcQvMa9aBBYlY5cZgjkUgA=;
 b=RCNqhh0Slj0/g8ekKIsbruHe6y6SoSGftiWjubIqvdBTUSTIwxepNSyfYgHBr8cmg077BvJNNdENYlo3bjIzTEppTcleaMb1w2mJZu0dsIeBXAJdQbi3LRvJfxk1TmoJ9H03TIPN3yq2TREQzPG3dBHLVsD5n+xQCOK7UxcwhzU=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5159.namprd03.prod.outlook.com (20.180.4.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Thu, 12 Dec 2019 07:21:21 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::38e7:c7c5:75cc:682c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::38e7:c7c5:75cc:682c%5]) with mapi id 15.20.2516.018; Thu, 12 Dec 2019
 07:21:21 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH V2] tpm_tis_spi: use new `delay` structure for SPI
 transfer delays
Thread-Topic: [PATCH V2] tpm_tis_spi: use new `delay` structure for SPI
 transfer delays
Thread-Index: AQHVrybztrExPq4jw0qMgCAKYpL1lKe1NO8AgADmqIA=
Date:   Thu, 12 Dec 2019 07:21:20 +0000
Message-ID: <6920bc5e8bc932dd85fa8e14755d2e6999512f25.camel@analog.com>
References: <20191204080049.32701-1-alexandru.ardelean@analog.com>
         <20191210065619.7395-1-alexandru.ardelean@analog.com>
         <20191211173700.GE4516@linux.intel.com>
In-Reply-To: <20191211173700.GE4516@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1235caa4-8554-49b0-cf5d-08d77ed3e388
x-ms-traffictypediagnostic: CH2PR03MB5159:
x-microsoft-antispam-prvs: <CH2PR03MB5159FCBDB6F12EEB569CEF7AF9550@CH2PR03MB5159.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(346002)(376002)(136003)(199004)(189003)(2616005)(8936002)(186003)(36756003)(6486002)(4001150100001)(478600001)(4326008)(5660300002)(81166006)(81156014)(86362001)(8676002)(26005)(71200400001)(6512007)(6506007)(66946007)(66476007)(6916009)(54906003)(66446008)(66556008)(2906002)(76116006)(316002)(64756008)(81973001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5159;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VUPxJsFbjQq6G9SbNHCNG/ZmOQivZghNDjo6y14k5MSB24b3+tlUbCjpGmY6ap3QXtJfV0NoggGKAZpsda/JYX/FaTfFNZOmkyqzepxY1uwh3hfaTRQOTlvLkKp5ogBTyx1GlBZsM64UU5BatNRdl2ekxEU2lSa1U8RQ8n/QfUc4Feyflf5L160r9SRxepc7qB+L2IVv2uKZtqdnM8iFcbR2nADa+SOaq2h6HaCskG2proKOU7+hnyTXGLZmVuwBsYkrcKb9bClmcJSQvMlmhtg9WmBN72kN72+NIbA5toInV42RtNGlGLr+uLAd0C9Y4LXy9FecZQ+FDuSJWfNoXdq3DRlR4MLFUxvgm/bWDEog3N+fO7e9H/cp6t9J+42n3wN9Iledg8UacwO0vayET0FydEcqjzRdmi6BUpWobTqJMKjExtG0DVvJ4Rqj/ABWejYypTZFBn6blsd24r/rf+HZwaLKCFjywHiIkhNCsFXHgMDF5ZDokFV3nfr8xQAh
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5116B30964A1C4409EF43075D3C3AB70@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1235caa4-8554-49b0-cf5d-08d77ed3e388
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 07:21:21.0326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bfxHORTQjAWYO29/Y+Oi7UGivGETUP1AxZqTGZ/qBW0dpN4jRbLIBrV6MND7cPN2U32KdCaJueKWj0TDETk/ACHZ8DCx1NX60eWs1zRpBNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5159
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_01:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912120049
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

T24gV2VkLCAyMDE5LTEyLTExIGF0IDE5OjM3ICswMjAwLCBKYXJra28gU2Fra2luZW4gd3JvdGU6
DQo+IFtFeHRlcm5hbF0NCj4gDQo+IE9uIFR1ZSwgRGVjIDEwLCAyMDE5IGF0IDA4OjU2OjE5QU0g
KzAyMDAsIEFsZXhhbmRydSBBcmRlbGVhbiB3cm90ZToNCj4gPiBJbiBhIHJlY2VudCBjaGFuZ2Ug
dG8gdGhlIFNQSSBzdWJzeXN0ZW0gWzFdLCBhIG5ldyBgZGVsYXlgIHN0cnVjdCB3YXMNCj4gPiBh
ZGRlZA0KPiA+IHRvIHJlcGxhY2UgdGhlIGBkZWxheV91c2Vjc2AuIFRoaXMgY2hhbmdlIHJlcGxh
Y2VzIHRoZSBjdXJyZW50DQo+ID4gYGRlbGF5X3VzZWNzYA0KPiA+IHdpdGggYGRlbGF5YCBmb3Ig
dGhpcyBkcml2ZXIuDQo+ID4gDQo+ID4gVGhlIGBzcGlfdHJhbnNmZXJfZGVsYXlfZXhlYygpYCBm
dW5jdGlvbiBbaW4gdGhlIFNQSSBmcmFtZXdvcmtdIG1ha2VzDQo+ID4gc3VyZQ0KPiA+IHRoYXQg
Ym90aCBgZGVsYXlfdXNlY3NgICYgYGRlbGF5YCBhcmUgdXNlZCAoaW4gdGhpcyBvcmRlciB0byBw
cmVzZXJ2ZQ0KPiA+IGJhY2t3YXJkcyBjb21wYXRpYmlsaXR5KS4NCj4gPiANCj4gPiBbMV0gY29t
bWl0IGJlYmNmZDI3MmRmNjQ4NSAoInNwaTogaW50cm9kdWNlIGBkZWxheWAgZmllbGQgZm9yDQo+
ID4gYHNwaV90cmFuc2ZlcmAgKyBzcGlfdHJhbnNmZXJfZGVsYXlfZXhlYygpIikNCj4gDQo+IE5v
dCBzdXJlIHdoeSB5b3UgdXNlIGAgYW5kIG5vdCAnPw0KDQpUaGF0J3MgYSBoYWJpdCBmcm9tIEdp
dGh1YidzIE1hcmtkb3duLg0KV2Uga2VlcCBvdXIga2VybmVsIHJlcG8gb24gR2l0aHViIGFuZCBN
YXJrZG93biBmb3JtYXRzIGB0ZXh0YCBpbnRvIGENCmNlcnRhaW4gZm9ybS4NCldoZW4gSSBvcGVu
IGEgUFIsIHRoZSBQUiB0ZXh0IGlzIGZvcm1hdHRlZCB0byBoaWdobGlnaHQgY2VydGFpbiBlbGVt
ZW50cw0KW3RoYXQgSSB3YW50IGhpZ2hsaWdodGVkXS4NCkkgZGlkIG5vdCBnZXQgYW55IGNvbW1l
bnRzIG9uIGl0IHNvIGZhci4NCg0KSSBjYW4gY2hhbmdlIGl0IGlmIHlvdSB3YW50Lg0KDQpBcyBh
IHNlY29uZGFyeSBub3RlOiBNYXJrZG93biBzZWVtcyB0byBiZSB1c2VkIG9uIEdpdGxhYiBhbmQg
Qml0YnVja2V0DQoNClRoYW5rcw0KQWxleA0KDQo+IA0KPiAvSmFya2tvDQo=
