Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55AB1170204
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Feb 2020 16:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgBZPLP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Feb 2020 10:11:15 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:41286 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727064AbgBZPLP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Feb 2020 10:11:15 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01QEn8Tf014853;
        Wed, 26 Feb 2020 10:11:08 -0500
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ydtrwg26t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Feb 2020 10:11:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6l0F79CGPOI0refm4jIg+wiVwcxZzEB/688pAbepvqexvmMiIQDLw4m85yqngujTYLJXXGg4CHDMLNhFqczvI+Pz2+a1gOsfr6COfEnYW2nd9Y7DntvlFcG83v0flmDOxek1FqS6hIfFJ+rfZ7ab+nz63kZGLBoBZf2GhpAKGzllz/nQtw7fqJ1yu+TUHthuN3Ndj8LjFlbmOnfFCvYujVoxuQdUQJkK4tzThJQKUvQsF+bWlWArmhR5Kdvb9b4/S2ghXtCCKizmUblFFqwXu7dVm41zsFj2pckJjVfdSOSlxKgz2VWV9evxAdqw/2HEeFyCBMpu/nx1JCy2r8SAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+4B5LtLt9yGsWQJRnHtvLPyn6YJkb2TrudMDKxUW9k=;
 b=nbqWpFgJ01KqWAbylIhprTZ0s0lyZAMAECipjj3oF51BkK5bBefK2KBwqEnJzVPLqQuIbAH4yIUscZkQK3Ne/aeFh2qbN3K4h1BvyWt4F5bDoYo83nlP+I/hFcPt0vt4QtHVZUFlJdwQUKRgnLEjOl6j7+CI0fCxo9EXFUFa9LtkS4NrRAtTb8NYMh6atnFEEiX1swuUJYMbELHW9zScKGgC34shH66jrovEfESRMIT5ic2qudKtye46LnqwyRvHrVEtZSOznwTA0kVyywgel32Kmxroexpa662BW/OP/Mv/+7P8gX7/YCpcLjsALxM7N7F7TU+cj6Ai6p0sHhYjgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+4B5LtLt9yGsWQJRnHtvLPyn6YJkb2TrudMDKxUW9k=;
 b=DsJlHCQM01e3xp48FBHEL5lGbYzkVAN7N+V9kjPk7yYzQGvl7nZPs3c5BEVQ76ax8I1A5CnPPQbEbaW1hA6+YdFEOoz54qSy9uDofFB3pNYwN+G7O46uct00ubtGjvNB83VSDGeRPBEduTqj/ceGpUwapitwryxi1hX89tKtPNo=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (2603:10b6:610:90::24)
 by CH2PR03MB5317.namprd03.prod.outlook.com (2603:10b6:610:9c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.22; Wed, 26 Feb
 2020 15:11:05 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::edf0:3922:83f0:3056]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::edf0:3922:83f0:3056%4]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 15:11:03 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH V3] tpm_tis_spi: use new 'delay' structure for SPI
 transfer delays
Thread-Topic: [PATCH V3] tpm_tis_spi: use new 'delay' structure for SPI
 transfer delays
Thread-Index: AQHVtLqu0YiY+9IGDUGLRFfgkettHKe+Os+AgG9PjoCAAHnVAIAAARcA
Date:   Wed, 26 Feb 2020 15:11:03 +0000
Message-ID: <193b5d111772fb16a7c6d0ea86a1405c6c4243b3.camel@analog.com>
References: <20191204080049.32701-1-alexandru.ardelean@analog.com>
         <20191217091615.12764-1-alexandru.ardelean@analog.com>
         <9991700815c02b3227a5902e4cae1afe5200b0ff.camel@linux.intel.com>
         <b790461b49685082f843c59cd047836e13744285.camel@analog.com>
         <20200226150944.GD3407@linux.intel.com>
In-Reply-To: <20200226150944.GD3407@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: df5299b2-e5e0-4dde-0c1d-08d7bace18e2
x-ms-traffictypediagnostic: CH2PR03MB5317:
x-microsoft-antispam-prvs: <CH2PR03MB5317775FFBC6BC3AE2B8371DF9EA0@CH2PR03MB5317.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:497;
x-forefront-prvs: 0325F6C77B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(376002)(396003)(39860400002)(199004)(189003)(81166006)(81156014)(8676002)(2616005)(6512007)(6486002)(186003)(6916009)(4001150100001)(4326008)(478600001)(86362001)(66476007)(26005)(66446008)(64756008)(36756003)(71200400001)(2906002)(54906003)(91956017)(6506007)(5660300002)(66556008)(66946007)(8936002)(316002)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5317;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WVzXPDrYIDnJ4Os74GfdwUAgcyrpyiDAky8P59dONTObRYN510f5sMf/XUdT91MmCq7WRQH1LRWonP5ajP234/V0lqt6Kx/bTTGwKMzx7sID5EhRarWOjjdlHC8vHoqcLQ79/cjAO1P5savc1t7IxqNNGCnkCCkTcpeZQQgHOH964Q61G07RzqpBfCU30kymX9LngHBZ1QxmeieCDb9YD/+YIkv2SmffqKuMN4T3+luH4SUEFaj9HMnbHt0qVunKk0jyHk4bzaeREMUJYC85y7EOKsYEE1FMwvoMXUsNZtCRls7DXYxL4KB3WJN2IZdxcIZ3GeKUPKV9K4bA5NOs/N4U1igb0wslCVeOBCZhtIvpN3mfq9ySyVb9EohDcYloWnl3UtBpucfi2/VVrk3WKkpUUu8SM0O2Hbci9/u2vCiDZPoMX6YqkwXv5uHlqqCo
x-ms-exchange-antispam-messagedata: 6qfcvUQAbTmVk1kV20aFvOfv9fAgox7gBqjI5xHUlSSSpPXiP23nOGmvRn1FpmCoFrBYksfbvkEogJx8pcAtvGkoGCFg0Rwu6jCV2xnK7RvQrEryilJc/O/+fF93DIVVtoO8IZ5Soa98OgrQEE6mlw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D0834933A7C724E8A8779C44E4C441C@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df5299b2-e5e0-4dde-0c1d-08d7bace18e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2020 15:11:03.8317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kn0pgWbLZqeu+irR2gpZK9QCu1HUqhxMGVOOlV4kUyqp1DxgDGU9F7bd72sQ7d2/Vrccl2oqSoYYeGw33fpNbRcrjKasYLmJcs+QH9Hwe4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5317
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-26_05:2020-02-26,2020-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002260108
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

T24gV2VkLCAyMDIwLTAyLTI2IGF0IDE3OjEwICswMjAwLCBKYXJra28gU2Fra2luZW4gd3JvdGU6
DQo+IFtFeHRlcm5hbF0NCj4gDQo+IE9uIFdlZCwgRmViIDI2LCAyMDIwIGF0IDA3OjUxOjA2QU0g
KzAwMDAsIEFyZGVsZWFuLCBBbGV4YW5kcnUgd3JvdGU6DQo+ID4gT24gVHVlLCAyMDE5LTEyLTE3
IGF0IDE0OjA0ICswMjAwLCBKYXJra28gU2Fra2luZW4gd3JvdGU6DQo+ID4gPiBbRXh0ZXJuYWxd
DQo+ID4gPiANCj4gPiA+IE9uIFR1ZSwgMjAxOS0xMi0xNyBhdCAxMToxNiArMDIwMCwgQWxleGFu
ZHJ1IEFyZGVsZWFuIHdyb3RlOg0KPiA+ID4gPiBJbiBhIHJlY2VudCBjaGFuZ2UgdG8gdGhlIFNQ
SSBzdWJzeXN0ZW0gWzFdLCBhIG5ldyAnZGVsYXknIHN0cnVjdCB3YXMNCj4gPiA+ID4gYWRkZWQN
Cj4gPiA+ID4gdG8gcmVwbGFjZSB0aGUgJ2RlbGF5X3VzZWNzJy4gVGhpcyBjaGFuZ2UgcmVwbGFj
ZXMgdGhlIGN1cnJlbnQNCj4gPiA+ID4gJ2RlbGF5X3VzZWNzJyB3aXRoICdkZWxheScgZm9yIHRo
aXMgZHJpdmVyLg0KPiA+ID4gPiANCj4gPiA+ID4gVGhlICdzcGlfdHJhbnNmZXJfZGVsYXlfZXhl
YygpJyBmdW5jdGlvbiBbaW4gdGhlIFNQSSBmcmFtZXdvcmtdIG1ha2VzDQo+ID4gPiA+IHN1cmUN
Cj4gPiA+ID4gdGhhdCBib3RoICdkZWxheV91c2VjcycgJiAnZGVsYXknIGFyZSB1c2VkIChpbiB0
aGlzIG9yZGVyIHRvIHByZXNlcnZlDQo+ID4gPiA+IGJhY2t3YXJkcyBjb21wYXRpYmlsaXR5KS4N
Cj4gPiA+ID4gDQo+ID4gPiA+IFsxXSBjb21taXQgYmViY2ZkMjcyZGY2NDg1ICgic3BpOiBpbnRy
b2R1Y2UgYGRlbGF5YCBmaWVsZCBmb3INCj4gPiA+ID4gYHNwaV90cmFuc2ZlcmAgKyBzcGlfdHJh
bnNmZXJfZGVsYXlfZXhlYygpIikNCj4gPiA+ID4gDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEFs
ZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5jb20+DQo+ID4gPiAN
Cj4gPiA+IFJldmlld2VkLWJ5OiBKYXJra28gU2Fra2luZW4gPGphcmtrby5zYWtraW5lbkBsaW51
eC5pbnRlbC5jb20+DQo+ID4gPiANCj4gPiANCj4gPiBwaW5nIG9uIHRoaXMgcGF0Y2gNCj4gDQo+
IE15IGJhZC4gU29ycnkuIEl0IGlzIG5vdyBhcHBsaWVkLg0KDQpObyB3b3JyaWVzLg0KVGhhbmtz
IDopDQoNCj4gDQo+IC9KYXJra28NCg==
