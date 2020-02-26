Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADCA416F8C5
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Feb 2020 08:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbgBZHvP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Feb 2020 02:51:15 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:28736 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726587AbgBZHvP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Feb 2020 02:51:15 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01Q7jKxD031561;
        Wed, 26 Feb 2020 02:51:08 -0500
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ydckps706-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Feb 2020 02:51:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fvw6W7L8ob93kduBEJKEDmLGfr/TnYGw2u4C5hDbr0aOpnRPILP45Vi/y0K/YtT/KbaJVBmMUCDBCD5gJeik1t6g5dIBiKBHK/U4ivz3C1kzjWQmDpYJPDmBPHnH0E3L0FfPurOcVU/f5u9P2YmrSuoBDuhwH569xoLy6Xmkm9awIf5SquhcLddZKuoslhj0/C6fUrSSfOZnAJ0+GkA108JYHomEQoB43Ow7Wq/O+PenrcOxCXsiwFYBz/I3pJ/SbkM91aTd8e9gEqsEsjYfiq3HWgA/aqtDqVbtD+8qAGpW1stL4ezL7PEGpv14N8iozp8hgQKrKmNGx6Uu4em51Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUs3iF2hJ/EY/1lK9CBXKgtyfWOI3AI/EjCKihoowV0=;
 b=M+qRwWb6GlmtafRMltntYufLtc6TkR8o7XHqISTa0BegYPzS5SaHvEaoAXt89kgCTtyhuBU1GdeAEhiP5p6oiOALP0SpxtkYGIPlPkuq9ltMTtu3rri7p0W4M4BqajD13x3lsLIKlDPCZYppuHfSgAHsRzzwIENgOt0yNsxnk5ERjkdH5bBRVgorLHXEEtH4fJ/PQaySN0Ytyceo8gtip3Bt1TdF3TQVwHHwyBFUzlfcsUK4QFAHHfQg8cbG7q7B4RVa/eJR06lYkmpY793DRimP6DhiM6uMNnBEJn2i3Pu07Eku+eAFXc4crO2qD2X8n1ESPh7FEp8iVjylHw5jqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUs3iF2hJ/EY/1lK9CBXKgtyfWOI3AI/EjCKihoowV0=;
 b=oao/W8OWNCUISmI95M8oPisQlBbThXvI4pgsqmEdfz0gOtLPL6KbgpG07Ekml5wN0fn55+FFdQEtSSdwvOLBycW1qfjJwLNNNh4LU8Lev71kveCiC2fMAX/X+mMdB4zKPGqS1+g2Ac+pe9I+fDVsxPtDTl/8wF4z1dmHJK4ae3o=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (2603:10b6:610:90::24)
 by CH2PR03MB5269.namprd03.prod.outlook.com (2603:10b6:610:90::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Wed, 26 Feb
 2020 07:51:06 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::edf0:3922:83f0:3056]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::edf0:3922:83f0:3056%4]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 07:51:06 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH V3] tpm_tis_spi: use new 'delay' structure for SPI
 transfer delays
Thread-Topic: [PATCH V3] tpm_tis_spi: use new 'delay' structure for SPI
 transfer delays
Thread-Index: AQHVtLqu0YiY+9IGDUGLRFfgkettHKe+Os+AgG9PjoA=
Date:   Wed, 26 Feb 2020 07:51:06 +0000
Message-ID: <b790461b49685082f843c59cd047836e13744285.camel@analog.com>
References: <20191204080049.32701-1-alexandru.ardelean@analog.com>
         <20191217091615.12764-1-alexandru.ardelean@analog.com>
         <9991700815c02b3227a5902e4cae1afe5200b0ff.camel@linux.intel.com>
In-Reply-To: <9991700815c02b3227a5902e4cae1afe5200b0ff.camel@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1c331b5c-b84a-47ff-3cb9-08d7ba90a2fb
x-ms-traffictypediagnostic: CH2PR03MB5269:
x-microsoft-antispam-prvs: <CH2PR03MB52694DE89B8296287C728E19F9EA0@CH2PR03MB5269.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:972;
x-forefront-prvs: 0325F6C77B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(396003)(136003)(376002)(189003)(199004)(8676002)(66476007)(71200400001)(8936002)(478600001)(66946007)(4001150100001)(36756003)(54906003)(4744005)(316002)(66446008)(5660300002)(86362001)(66556008)(81156014)(81166006)(110136005)(76116006)(91956017)(64756008)(6486002)(6506007)(2906002)(4326008)(186003)(26005)(2616005)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5269;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z4crVivOEShFkKcWGJoSaMGVNYC42XlOtViEZXmeqEtw7AjbdWdsC/2tFjTV2jYtRyvijop4GJHVA0Iv62Vi9w4rBINyuOd+ywgb8BcLZX/nRaiNJmQ4p0+7Pl4R8aWYPEzvYTuXryfJA0azfnPh1ctLGH4m9hiztdyUe6a5NDatPyJiana76PNweIDkFm3yFAYjK3Th5ghAsDeQiX5uyOgzKEAX2ah1Y/xu28U6BDR7gWBIMLraCl/Yc7NGAXS9wcdyp/2GHa6cswze4jNdAFbXafLyjzXDAQusLb8/gFCU8llOA9TpVBnWmy2arIXrL+835m1g7E6Ssv17J/mZmcHBEhdL7Hbdke/GzTF6rShvvLzwXDOf1wjbv54VHwRAGiBKF4x3xE0AyzpV3ptJ4isMGppEpY+2vAv7M5EEor2F4kaxfo46285ztHqSBsRt
x-ms-exchange-antispam-messagedata: eLxVzScu5OUkbX9GK7vh+B1z9YwmibGs4PRh2AN76+yDUI/1jVGdN3tshj7mYy3fuD2WxVfzLtGti0XkMKE/VGYOZzOY5TwAQKKkQA3ARvoP3QGpW6vcR26NP9EDXxpVDEToOHmhslz4bccGA9ct5A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <04FD8C3ED455594B8F51D5DDD4DDAAE0@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c331b5c-b84a-47ff-3cb9-08d7ba90a2fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2020 07:51:06.6813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k9sHClTJf6sfdvjOaQwdmAAAF48ZVZsW62ZMrMrJVuaUWlwX2Zwfr6ZJRqeRV5yXoslPSAIyzkM/x7xS8aDQWD7P2iUtmjxwc7E+3AYEDDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5269
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-26_02:2020-02-25,2020-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1011
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002260058
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

T24gVHVlLCAyMDE5LTEyLTE3IGF0IDE0OjA0ICswMjAwLCBKYXJra28gU2Fra2luZW4gd3JvdGU6
DQo+IFtFeHRlcm5hbF0NCj4gDQo+IE9uIFR1ZSwgMjAxOS0xMi0xNyBhdCAxMToxNiArMDIwMCwg
QWxleGFuZHJ1IEFyZGVsZWFuIHdyb3RlOg0KPiA+IEluIGEgcmVjZW50IGNoYW5nZSB0byB0aGUg
U1BJIHN1YnN5c3RlbSBbMV0sIGEgbmV3ICdkZWxheScgc3RydWN0IHdhcyBhZGRlZA0KPiA+IHRv
IHJlcGxhY2UgdGhlICdkZWxheV91c2VjcycuIFRoaXMgY2hhbmdlIHJlcGxhY2VzIHRoZSBjdXJy
ZW50DQo+ID4gJ2RlbGF5X3VzZWNzJyB3aXRoICdkZWxheScgZm9yIHRoaXMgZHJpdmVyLg0KPiA+
IA0KPiA+IFRoZSAnc3BpX3RyYW5zZmVyX2RlbGF5X2V4ZWMoKScgZnVuY3Rpb24gW2luIHRoZSBT
UEkgZnJhbWV3b3JrXSBtYWtlcyBzdXJlDQo+ID4gdGhhdCBib3RoICdkZWxheV91c2VjcycgJiAn
ZGVsYXknIGFyZSB1c2VkIChpbiB0aGlzIG9yZGVyIHRvIHByZXNlcnZlDQo+ID4gYmFja3dhcmRz
IGNvbXBhdGliaWxpdHkpLg0KPiA+IA0KPiA+IFsxXSBjb21taXQgYmViY2ZkMjcyZGY2NDg1ICgi
c3BpOiBpbnRyb2R1Y2UgYGRlbGF5YCBmaWVsZCBmb3INCj4gPiBgc3BpX3RyYW5zZmVyYCArIHNw
aV90cmFuc2Zlcl9kZWxheV9leGVjKCkiKQ0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsZXhh
bmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQo+IA0KPiBSZXZp
ZXdlZC1ieTogSmFya2tvIFNha2tpbmVuIDxqYXJra28uc2Fra2luZW5AbGludXguaW50ZWwuY29t
Pg0KPiANCg0KcGluZyBvbiB0aGlzIHBhdGNoDQoNCj4gL0phcmtrbw0KPiANCg==
