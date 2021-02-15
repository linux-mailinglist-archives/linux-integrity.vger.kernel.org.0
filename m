Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5BD31BE6A
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Feb 2021 17:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbhBOQJZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Feb 2021 11:09:25 -0500
Received: from mail-edgeDD24.fraunhofer.de ([192.102.167.24]:16269 "EHLO
        mail-edgeDD24.fraunhofer.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232223AbhBOP5h (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Feb 2021 10:57:37 -0500
IronPort-PHdr: =?us-ascii?q?9a23=3AMXP8MhDlaQU38TTzuJ7WUyQJPHJ1sqjoPgMT9p?=
 =?us-ascii?q?ssgq5PdaLm5Zn5IUjD/qw20A3NXIPG+7RFge+QuKflCiQM4peE5XYFdpEEFx?=
 =?us-ascii?q?oIkt4fkAFoBsmZQVb6I/jnY21ffoxCWVZp8mv9PR1TH8DzNFnTpGCiqz8YH1?=
 =?us-ascii?q?P0Mg8mbujwE5TZ2sKw0e368pbPYgJO0Ty6Z74XTl22oAzdu9NQj5FlL/M4yw?=
 =?us-ascii?q?DEqT1GYe1Lw2NvK1+J2Rrxtco=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2F7AABkpYde/xmnZsBmHAEBAQEBBwE?=
 =?us-ascii?q?BEQEEBAEBgWcHAQELAYFTUAWBRB08CoQRg0UDhFlghXiCEYpqjTSBLoEkA1Q?=
 =?us-ascii?q?KAQEBAQEBAQEBBgEBLQIEAQGERAIXgjAkNAkOAhABAQYBAQEBAQUEAgJphVY?=
 =?us-ascii?q?BC4ZFAQEBAQIBEhERDAEBNwEPAgEIGAICJgICAjAVEAIEDgUihVADDh8BAaQ?=
 =?us-ascii?q?0AoE5iGJ1gTKCfwEBBYU9GIEQfAkJAYEEKgGMMIIagUeCWj6HYIJekEg7oBM?=
 =?us-ascii?q?HgUl3lyUdjzWMS48ynB0CBAIEBQIOAQEFgVI6gVdNJE+CaVAYDY4dCxiDUIp?=
 =?us-ascii?q?VdAKBJ40ZAYEPAQE?=
X-IPAS-Result: =?us-ascii?q?A2F7AABkpYde/xmnZsBmHAEBAQEBBwEBEQEEBAEBgWcHA?=
 =?us-ascii?q?QELAYFTUAWBRB08CoQRg0UDhFlghXiCEYpqjTSBLoEkA1QKAQEBAQEBAQEBB?=
 =?us-ascii?q?gEBLQIEAQGERAIXgjAkNAkOAhABAQYBAQEBAQUEAgJphVYBC4ZFAQEBAQIBE?=
 =?us-ascii?q?hERDAEBNwEPAgEIGAICJgICAjAVEAIEDgUihVADDh8BAaQ0AoE5iGJ1gTKCf?=
 =?us-ascii?q?wEBBYU9GIEQfAkJAYEEKgGMMIIagUeCWj6HYIJekEg7oBMHgUl3lyUdjzWMS?=
 =?us-ascii?q?48ynB0CBAIEBQIOAQEFgVI6gVdNJE+CaVAYDY4dCxiDUIpVdAKBJ40ZAYEPA?=
 =?us-ascii?q?QE?=
X-IronPort-AV: E=Sophos;i="5.72,341,1580770800"; 
   d="scan'208";a="39192703"
Received: from mail-mtadd25.fraunhofer.de ([192.102.167.25])
  by mail-edgeDD24.fraunhofer.de with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Feb 2021 16:36:56 +0100
IronPort-PHdr: =?us-ascii?q?9a23=3AqZHnqBE0s3NRnGuqDmsKPZ1GYnJ96bzpIg4Y7I?=
 =?us-ascii?q?YmgLtSc6Oluo7vJ1Hb+e401wObWYTd9uICiuDT9avnXD9I7ZWAtSUEd5pBH1?=
 =?us-ascii?q?8AhN4NlgMtSMiCFQXgLfHsYiB7eaYKVFJs83yhd0QAHsH4ag7Wo3uv/XgTEB?=
 =?us-ascii?q?C5Pg1wdaz5H4fIhJGx0Oa/s5TYfwRPgm+7ZrV/SXf+rQjYusQMx4V4LaNkwx?=
 =?us-ascii?q?rSr3AOdf5f2GVoIlyehVDw65S9?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0B4CQDuQSpg/z6wYZligQkHgxtRB4F?=
 =?us-ascii?q?PJUMKAYQ2g0gDhTmITwM3AYpojX2CUwNUCwEDAQEBAQEHAQEyAgQBAYRNAhe?=
 =?us-ascii?q?BcAImOBMCEAEBBQEBAQIBBgRxhWEBDIZEAQEBAwEjEQwBARQjAQ8CAQgYAgI?=
 =?us-ascii?q?mAgICMAcOEAIEDgWFRgMOHwEBpGQCiiV2gTKDBAEBBoURGIETfwkJAYEEKoJ?=
 =?us-ascii?q?2hAeCUIN1gkSBR4JkPodUgl+CRAeBDhwVgVRFDRqTNQFApVIHgWuBEpwKIpM?=
 =?us-ascii?q?5j3SUOZ02hEYCBAIEBQIOAQEGgWwjgVdNJE+CaVAXAg2OKhiDTopZQzACNQI?=
 =?us-ascii?q?GAQkBAQMJfIoIAYEOAQE?=
X-IronPort-AV: E=Sophos;i="5.81,180,1610406000"; 
   d="scan'208";a="104236492"
Received: from 153-97-176-62.vm.c.fraunhofer.de (HELO XCH-HYBRID-02.ads.fraunhofer.de) ([153.97.176.62])
  by mail-mtaDD25.fraunhofer.de with ESMTP; 15 Feb 2021 16:36:53 +0100
Received: from XCH-HYBRID-02.ads.fraunhofer.de (10.225.8.59) by
 XCH-HYBRID-02.ads.fraunhofer.de (10.225.8.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Mon, 15 Feb 2021 16:36:52 +0100
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (10.225.8.41) by
 XCH-HYBRID-02.ads.fraunhofer.de (10.225.8.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2
 via Frontend Transport; Mon, 15 Feb 2021 16:36:52 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgXahpzC9sW+p+bVrwYFCOys1x3yeyuGZMcjPCEA9eR75/QpbEqA9zuMYGuovYDrCciCxcskWllUxru/gzNQ9UdOq+u/aeUevCvlMtnWBaMXOFOusaKRvpGau17N9pKspCFPvuuMA31NJqw+uzizXGQioQXYHMQTQyPDEYqck0klkZHMIjZNwmzxaRfCO0DPL1lV9PNMSktsTeDRskgmF5AY9XCCm/gFJcGF41Cnihe35QvVMfMncJyzhyG1Qr1okwgaPCrUDwYha/VmZp+oTTx1H1eOXR0sOLJClsQcWUWAXUPLA0qqYOBGn3gzBb2Zg2OgvxdDzLpgVvgMP7ISkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKxtaWBlzhyyfj8rfJJwoq/BGApDTAG6ehLIYuzT6sM=;
 b=IlBcVBFpDIfyr9OtFJbc9FUKxbxCduPnoG0m/PtqHRO3pVmLQ8kcrL6Wv1dK+5tyHGksW0fHOS4+EZdibwq7CTW0IF6Vt7qXOJ1en+1sOvRMD3333KoxETnyjXUIMDRWy2hTYzmN1vTh1xtvBMzZe6MluHZG9S6DP3GP6frf032YN8HfG1CP5FU+FmzQp9PTUYOIXtHSEHl8BqmIU2eGxMa9v/xfG5rnv7s9CLGIwhbQj2W1C2hbALqbBG+jSHT79sMllf9S27VCtnv2JXEB63OxJtCB3xMsaHcbQgnCyCdh9oKAiAg5qfFW6dKILuekPy4UFYP6sdb9KTLsSP9kWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKxtaWBlzhyyfj8rfJJwoq/BGApDTAG6ehLIYuzT6sM=;
 b=cyg96Slj+L5KiSubkx2J2Z+IL/QWJ5aPneiQleNabTi+IXaDkEx+wAUfwawegnk7FxhsszTNNySHyhsJm7lQgo6kpjx4Y8zFq8UvxlJ5o1ExMHksJe23PvpDvlLt079zoitHIvDLSQWv35ch+fkCYIKGH/Mj35IRiIgV/MRAIrc=
Received: from VE1P194MB0814.EURP194.PROD.OUTLOOK.COM (2603:10a6:800:16e::20)
 by VE1P194MB0943.EURP194.PROD.OUTLOOK.COM (2603:10a6:800:161::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Mon, 15 Feb
 2021 15:36:51 +0000
Received: from VE1P194MB0814.EURP194.PROD.OUTLOOK.COM
 ([fe80::8d6d:8967:5eb7:25b0]) by VE1P194MB0814.EURP194.PROD.OUTLOOK.COM
 ([fe80::8d6d:8967:5eb7:25b0%9]) with mapi id 15.20.3846.042; Mon, 15 Feb 2021
 15:36:51 +0000
From:   =?utf-8?B?V2Vpw58sIE1pY2hhZWw=?= 
        <michael.weiss@aisec.fraunhofer.de>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] integrity/ima: Provide Kconfig option for ima-modsig
 template
Thread-Topic: [PATCH] integrity/ima: Provide Kconfig option for ima-modsig
 template
Thread-Index: AQHXA4SlbgWEbp839k2JLouMjPZRO6pZNW2AgAAkTIA=
Date:   Mon, 15 Feb 2021 15:36:51 +0000
Message-ID: <bea7095300c3daeaae65e6e6f230d1a3a500c322.camel@aisec.fraunhofer.de>
References: <20210215102305.10722-1-michael.weiss@aisec.fraunhofer.de>
         <fe83fb7572e0eea7a9a9981a15c63f1f7709d714.camel@linux.ibm.com>
In-Reply-To: <fe83fb7572e0eea7a9a9981a15c63f1f7709d714.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5-1.1 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none
 header.from=aisec.fraunhofer.de;
x-originating-ip: [146.52.20.127]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2fa8963-e797-4097-3f78-08d8d1c78427
x-ms-traffictypediagnostic: VE1P194MB0943:
x-microsoft-antispam-prvs: <VE1P194MB0943DB8B744DAC1CA95DE8A6AC889@VE1P194MB0943.EURP194.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zx78V8tYp6N8GmqF+PPAbM5B6W8FVANQRgOQ9XsN6RVsxMcEjOMU8kjK+EjdsxcSGxXjvo3K/U5QYe6C9+pHYRa4jlKIVie7BC7QFeR56D1v01SbCVbKch/EAZiVNX5tBJqX/ijS+XzLVvtmEK2942GAXwmRa+5Z+jxZdD7PnaMJES31i4EbjF09QKKOYUGvLsCbyjhLyD0Zw848oj6Hg+G1d9e+IRyyvMBnq6dnM/2EH0wiZXNOLO2YGlBKf14uOK3azyxo0m6F0SuNP7BLNNQtfjTaZghNa+6LbdpUkTJN0pCyTHdaYfhvjE4Usiiv8pfQFVk4cTd/UboqNtlf1KeHRz7PRN4RUtSb0jGkQ7tg2d1HtUurJn21YoA2Oet5UWFi1BTw7ztZrIW9pIkH9cPD2Ds1YCP1daDd0KxYQ+128iotV5Puztx+DeHP4ELY9N8cb52TDY85JkhSwAmdBzyRUx5C5YJud8wEwdfn0c3rpD5U/9f+gXo8pQsQ30i23eKOP/6+zLDhWzHIvizNlg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1P194MB0814.EURP194.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(39850400004)(376002)(346002)(136003)(396003)(186003)(316002)(6916009)(26005)(6512007)(2906002)(6486002)(6506007)(54906003)(86362001)(85182001)(4326008)(66476007)(76116006)(8676002)(91956017)(5660300002)(64756008)(66946007)(8936002)(66556008)(66446008)(478600001)(83380400001)(71200400001)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?elhaYkxVZjNkR2ZkZVZPb1I4dTY4NGRVZGRqYmdmaDRkL2tSamVVNnFKWmt4?=
 =?utf-8?B?eC93ZHh2anJpbk12a3J4d1BmM0lSMFZzUmxlTklWVWlLci9WM3Z0blBWNElX?=
 =?utf-8?B?WndGQ2FZekdFTGozNmpRM2orY01uZjg3SnBLanY1QVRpLzcvdnlaZmUyaFpn?=
 =?utf-8?B?K3dCZDJJWTd4SHR3TUhqODE1YVN2eUxKTlBSRjZTdHU1Um1ONzd4ZDZYMjlJ?=
 =?utf-8?B?bXlRRlFIME9aRzR4MkUxay9uWi9BY2JRZjc0ZVQ0cTlOMTRjbHhLeGZkZC9J?=
 =?utf-8?B?WENqNjFJNHQvdDY2OTlPMVpFS1c0a2U3anUrY05jZ1pCQngyZ3EvdmRvWlVl?=
 =?utf-8?B?MEVNK3JuVzE3Y20wb1lYdUkzN2gwWTVwWlZJS25xbDV5WldzNk5lcnlkbjNy?=
 =?utf-8?B?UmVFRkFmbytmUzY5alUxTCsrOHQzRXF5WENKemtwTFNLRWdzVy9RZTlRc2NB?=
 =?utf-8?B?L1Axd2ZoTXNlNEs1b3dONzFXdnFJU3dHbktQN01xME56ZUlHaXNuaXpKVSt5?=
 =?utf-8?B?RnR3QVdNalFVS09IOENEMWl1dlZlbFdQQzBkZkRnVFBZc05HTEJwVXgzc29Q?=
 =?utf-8?B?Z2dpb2VSbWpndmxSTEFqekVyNW50WEh6N2FVajVpSnhhUVVnbWJtd1U5aDNk?=
 =?utf-8?B?NXF0dk9zY2FjWFk0K0RWdlNpS1lWYWwrZ2FlMW44Nk4wYk51cENrczFteGtp?=
 =?utf-8?B?VEVFa0xIVEZLQno4Tm9xV08wdXBXSFcwTGgrYkRidkpNVFUzeFVReWJWVldj?=
 =?utf-8?B?VDEzUWxheGdOejVianNzK1R4czE0eDNDVHlrOTJzMGluNGR1aTkxWXUvaG9N?=
 =?utf-8?B?aXp6cDBWRzNZTXVZMG02UXY5VTN4Y09Xb0hodDNhZkhpYUNtTWlFazhzZUxG?=
 =?utf-8?B?YVJDYkJXMHNWTmJkVFBGTWZRdVBSV1gzaldreHU3YUxWRUx0M1BFYlFKc3RO?=
 =?utf-8?B?OCtKamcxUzh2RXpieTQzSFdtc01PVUlLTEExY1BwT280ZElxcGZtYjZBc3NQ?=
 =?utf-8?B?aVYwUVF0clU4YmJwU0dqY2JQdXczMDhZYTg4R29qYnBDdzlnSk5maDk2dlJS?=
 =?utf-8?B?dVIya3BxekorZUhDMi84UXEvNWg2UzBnaVRWSi9La0F5RUd4OFZRbXhwK1A5?=
 =?utf-8?B?S0c5SjFDZlpsNUdEYUtBY0FLRU9WR0duS0dHSnp4ME9Mb0ZJc0twU3owV01s?=
 =?utf-8?B?VEd2NzRvL3RSTXRqakdnM0ZydU1Hbk5mSnZDTzBhOEhYTWVnT2ZaRDJoUlov?=
 =?utf-8?B?MlVXWW96VWpSSWNhY3Vhd3RCOGcwM2dQbGZ3UFZGdXQrM1BZcUppQ1dqQ1BP?=
 =?utf-8?B?a0VUbXRaOXRXZzEzU3hlTTkreVNEWTJIVkNHR3MvV1pBdzZ0eWFqajR2UE12?=
 =?utf-8?B?eVVDMEFmVmIxVVdLRHB0N09zLzY0S1pCNkRIekJKU0FGQzZEYXA5OEs5Tm9m?=
 =?utf-8?B?OElLTWV6Y1FwZlpHOCsrZUZvTHR5TkQ1aTltdzdnazlLSzIrYWFmSEVJMTNS?=
 =?utf-8?B?eEpGUnZ5dUZMUHVuc3M5TFpKNGJyYXV0dW1JbVc5ZTR5SkZIOGFFNUphNmxj?=
 =?utf-8?B?WTNvNDRLRzJlbHFmOUlQU3NTUGtQR0ExL0l4NEtzVTFaSXZScjVmM21mdEVw?=
 =?utf-8?B?cStGV1gzVVZxOFRzYkl4bXNSbW50R2ZxbzBrdzM2bE4yelBmOStLOVU1QWdR?=
 =?utf-8?B?M3oyVWxVWnhFdFZGOGExT05maG41NkR5dStURHQ1SEJveE5OUmZLNldhL0ZN?=
 =?utf-8?Q?k377kV4BSaBHAaBoslqoM+jj3KyGW+DCBdCZ9v8?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B052675C37A1B74881462A82F790D942@EURP194.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1P194MB0814.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a2fa8963-e797-4097-3f78-08d8d1c78427
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2021 15:36:51.7801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xSb9+qUuVtFyFfJIimi6VxJmCUWbwTulo0YsoV1LXOHbmE1cAWSFWLsatYS4NFQGT3NOzzCa/igSxsNqvwUFfOcFNLbgn7vtNvYXxzcvJOUhPvqtSSS7XHdLkheo2/GC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P194MB0943
X-OriginatorOrg: aisec.fraunhofer.de
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

SGkgTWltaSwNCg0KT24gTW9uLCAyMDIxLTAyLTE1IGF0IDA4OjI2IC0wNTAwLCBNaW1pIFpvaGFy
IHdyb3RlOg0KPiBIaSBNaWNoYWVsLA0KPiANCj4gT24gTW9uLCAyMDIxLTAyLTE1IGF0IDExOjIz
ICswMTAwLCBNaWNoYWVsIFdlacOfIHdyb3RlOg0KPiA+ICdpbWEtbW9kc2lnJyB3YXMgbm90IGlu
IHRoZSBsaXN0IG9mIHNlbGVjdGFibGUgdGVtcGxhdGVzIGluIEtjb25maWcuDQo+ID4gVGhlIG1p
c3NpbmcgS2NvbmZpZyBvcHRpb25zIHdlcmUgYWRkZWQgdG8gc3VwcG9ydCB0aGUgaW1hLW1vZHNp
Zw0KPiA+IHRlbXBsYXRlIGFzIGRlZmF1bHQgdGVtcGxhdGUuDQo+ID4gDQo+ID4gU2lnbmVkLW9m
Zi1ieTogTWljaGFlbCBXZWnDnyA8bWljaGFlbC53ZWlzc0BhaXNlYy5mcmF1bmhvZmVyLmRlPg0K
PiANCj4gU2luY2UgJ2ltYS1tb2RzaWcnIGlzIG9ubHkgbmVlZGVkIGZvciBhcHBlbmRlZCBzaWdu
YXR1cmVzIChlLmcuIGtleGVjDQo+IGtlcm5lbCBpbWFnZSBvbiBwb3dlcnBjLCBrZXJuZWwgbW9k
dWxlcykgYSBwZXIgcG9saWN5IHJ1bGUgInRlbXBsYXRlPSINCj4gb3B0aW9uIHdhcyBkZWZpbmVk
LiAgVGhlcmUncyBhbHNvIHRoZSAnaW1hX3RlbXBsYXRlPScgYm9vdCBjb21tYW5kIGxpbmUNCj4g
b3B0aW9uLiAgIEJldHdlZW4gdGhlc2UgdHdvIG9wdGlvbnMsIEkgZGlkbid0IHNlZSB0aGUgbmVl
ZCBmb3IgbWFraW5nDQo+IGl0IGEgYnVpbGQgdGltZSBkZWZhdWx0IG9wdGlvbi4gIERvIHlvdT8N
Cg0KVGhlIHVzZS1jYXNlIEkgaGFkIGluIG1pbmQgd2FzIGEgc2ltcGxlIG1lYXN1cmVkIGJvb3Qs
DQpubyB1c2VyLXNwYWNlIGFwcGxpY2F0aW9ucywgb25seSB0byBtZWFzdXJlIGFscmVhZHkgc2ln
bmVkIG1vZHVsZXMNCndoaWNoIGFyZSBhbHJlYWR5IHNpZ25lZCBieSBtb2RzaWcNCnVzaW5nIGEg
c2luZ2xlIHBvbGljeSBsaW5lOg0KDQptZWFzdXJlIGZ1bmM9TU9EVUxFX0NIRUNLDQoNCkkgdGhv
dWdodCBmb3IgdGhpcyBwdXJwb3NlLCB3ZSBjb3VsZCBqdXN0IGNvbXBpbGUgaW4gdGhlIGRlZmF1
bHQNCnRlbXBsYXRlIHRvIGJlIG1vZHNpZyBidXQgaXQgd2Fzbid0DQpzZWxlY3RhYmxlLg0KDQpJ
IGhhdmUgb3Zlcmxvb2tlZCB0aGUgcG9saWN5IHJ1bGUgInRlbXBsYXRlPSIsDQpJbiB0aGUgYWJv
dmUgdXNlLWNhc2UsIGl0IGFsc28ganVzdCB3b3JrcyB0byBzZXQgdGhlIHBvbGljeToNCg0KbWVh
c3VyZSBmdW5jPU1PRFVMRV9DSEVDSyB0ZW1wbGF0ZT1pbWEtbW9kc2lnDQoNClNvLCB5b3VyIGFy
ZSByaWdodCBtYXliZSB0aGF0IGlzIG5vdCBuZWNlc3NhcnkuDQoNClJlZ2FyZHMsDQpNaWNoYWVs
DQogDQo+IA0KPiBUaGUgcGF0Y2ggaXRzZWxmIGxvb2tzIGdvb2QuIA0KPiANCj4gdGhhbmtzLA0K
PiANCj4gTWltaQ0KPiANCj4gPiAtLS0NCj4gPiAgc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9LY29u
ZmlnIHwgMyArKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiA+IA0K
PiA+IGRpZmYgLS1naXQgYS9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL0tjb25maWcgYi9zZWN1cml0
eS9pbnRlZ3JpdHkvaW1hL0tjb25maWcNCj4gPiBpbmRleCAxMmU5MjUwYzFiZWMuLjMyYjkzMjVm
NDliZiAxMDA2NDQNCj4gPiAtLS0gYS9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL0tjb25maWcNCj4g
PiArKysgYi9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL0tjb25maWcNCj4gPiBAQCAtNzgsNiArNzgs
OCBAQCBjaG9pY2UNCj4gPiAgCQlib29sICJpbWEtbmcgKGRlZmF1bHQpIg0KPiA+ICAJY29uZmln
IElNQV9TSUdfVEVNUExBVEUNCj4gPiAgCQlib29sICJpbWEtc2lnIg0KPiA+ICsJY29uZmlnIElN
QV9NT0RTSUdfVEVNUExBVEUNCj4gPiArCQlib29sICJpbWEtbW9kc2lnIg0KPiA+ICBlbmRjaG9p
Y2UNCj4gPiAgDQo+ID4gIGNvbmZpZyBJTUFfREVGQVVMVF9URU1QTEFURQ0KPiA+IEBAIC04Niw2
ICs4OCw3IEBAIGNvbmZpZyBJTUFfREVGQVVMVF9URU1QTEFURQ0KPiA+ICAJZGVmYXVsdCAiaW1h
IiBpZiBJTUFfVEVNUExBVEUNCj4gPiAgCWRlZmF1bHQgImltYS1uZyIgaWYgSU1BX05HX1RFTVBM
QVRFDQo+ID4gIAlkZWZhdWx0ICJpbWEtc2lnIiBpZiBJTUFfU0lHX1RFTVBMQVRFDQo+ID4gKwlk
ZWZhdWx0ICJpbWEtbW9kc2lnIiBpZiBJTUFfTU9EU0lHX1RFTVBMQVRFDQo+ID4gIA0KPiA+ICBj
aG9pY2UNCj4gPiAgCXByb21wdCAiRGVmYXVsdCBpbnRlZ3JpdHkgaGFzaCBhbGdvcml0aG0iDQo+
IA0KPiANCg0K
