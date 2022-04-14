Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0EC501DD9
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Apr 2022 00:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241976AbiDNWDC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Apr 2022 18:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244643AbiDNWCl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Apr 2022 18:02:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710BF4338B;
        Thu, 14 Apr 2022 15:00:15 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23EIbRba018418;
        Thu, 14 Apr 2022 21:59:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=sf68t1I5OIx2i9ZZs54X6pYOjtE4nF9CImI7YEWcloM=;
 b=YKTevDGFNS9KMJhBEGktZlOCf4p1y60MOzi8YvHhGlQqCsPGHBUSFytJbOWrwk0owXhd
 DHEDj4aHz3M/lwzViHceV28Mlmxquso7WQXL0/rk477UEffW1LVCLQueakFBAaYQnM8i
 RtEAceBMxGoLfJAlmzbJTIdaEwnLTqCw4rY94tuYp+PQhLEvCkaSzVrOViR/zotfH1TF
 jX2TZKSTcJ+EiZIT2FVNRVcmkJPuPGFElUcKl6jnaXzTGfDDSYc8vi1ztIMF9YYJxBk3
 xadKM8RIVLxQVZoN3SrjACzyid0FcdFlFfgjGcjeR1IxXf7wl/xVPfzYsKCyWfJ8I9oq FQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0r1p4t6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 21:59:41 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23ELuVUq008479;
        Thu, 14 Apr 2022 21:59:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fck15cmr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 21:59:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEIISm4GyDX66JX9IMpZIliEvO3ei3N0hUgkwChti5PHfKyru2AGXwy2qwfkPNOkAFGAio+cqA4R+uTdUaqZBMQRpRTAtFXIzBbDz7plUKAOOkKhBO+CSnhxSh+bUncJXKWRzZiB0FB2/IDYcJ0tqmXLtMoynD9r/Mvmk9lqIa4/zkHFujcq+oun0n/KTGhX3v/ZgPkKCO0GrYYU/hBsbItgUyvyw7huEUjnytt95qax2jQjTW4OIcnJPdhSW7az2xlJLIS340OnDz7Yikr33I/8XIG5CNWiuR8EYGqBqfoPnqEYq6XBVcBcKNNLYlnVwesbCjUZy4H0X++2GtPlIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sf68t1I5OIx2i9ZZs54X6pYOjtE4nF9CImI7YEWcloM=;
 b=kL61A1n8F2ogbeADVbUMO45PeV00Ifq58kpENGU0VHHeSk4MA6z/TtwTgKGrgn7ilBLBLusjHSGRSm5uWWUq/TV6x8Mngbx6IWE3ne5uW8BdgSM0zknfTlI6whSDp6MjEX+um6y/CN6AmJ7dwVQdn2iQ6vdY/YAydLcCQYV6E2HNC0trX6hLyNbYutR7FgG7DrTEE+6mZUO3oRoc9P3QIxmp3vjr0VPzjLu5T5DWcZPOeI5gvAEyjEhmK/Ebkw+dcLUHb4mPkqf7m0JtByGq4BfaVTKOagCOT+nFGxYj2Npx8jvrVyJaP9FKK/Zr9AXiHlRXWyp4KVlr6mSLBLUdPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sf68t1I5OIx2i9ZZs54X6pYOjtE4nF9CImI7YEWcloM=;
 b=DskMMkXBLVCSabwKkJKlCo13Owy921GvdVSzj72WDrekrMs+XtmVNA/flFmzu3G1sgy7EuKVXPdOpmv6Pe9Zs4HzArpHG0HvMEBd0pXCNGRZJGHQ76OGwil+a2ZOCIFayDm7mq2dNlifkf6tO9w+t4bxAQqUZdaXfFb3nPmV1w0=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by SN6PR10MB3024.namprd10.prod.outlook.com (2603:10b6:805:d1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 21:59:38 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7ded:5b3:a28f:2e55]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7ded:5b3:a28f:2e55%7]) with mapi id 15.20.5144.030; Thu, 14 Apr 2022
 21:59:38 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
CC:     David Howells <dhowells@redhat.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        "pvorel@suse.cz" <pvorel@suse.cz>, "tiwai@suse.de" <tiwai@suse.de>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 4/7] KEYS: Introduce a builtin root of trust key flag
Thread-Topic: [PATCH 4/7] KEYS: Introduce a builtin root of trust key flag
Thread-Index: AQHYSVkvRBwH8IpE9UCisTSasA/N5azmGp0AgAANAACAABh+AIAACxSAgAAU5ICAADUngIAESlAAgATJOgCAABohgIAAQEQA
Date:   Thu, 14 Apr 2022 21:59:37 +0000
Message-ID: <0A0B0B93-80BD-49A9-B0B3-56C6F74D2BE0@oracle.com>
References: <20220406015337.4000739-1-eric.snowberg@oracle.com>
 <20220406015337.4000739-5-eric.snowberg@oracle.com>
 <4fbef0889d6f286c7fcd317db099b4857e1b2fa3.camel@linux.ibm.com>
 <EF1544D5-54E8-4D47-82F8-F9337CA7AEA0@oracle.com>
 <b8965652274b49ba7c6f67cad6d42965cf984b42.camel@linux.ibm.com>
 <16DDA7F1-95BA-4279-BE4E-9F713A905B36@oracle.com>
 <986199739ff8bd730b9aabe8882e245946d3d9e9.camel@linux.ibm.com>
 <BFA04505-F4BC-4CF8-B813-EE81DBD90E09@oracle.com>
 <6798c67d748ecdc92455a8be8c63fb55e243368a.camel@linux.ibm.com>
 <B67D99B1-1DF9-4146-9147-08B2C4A72FEA@oracle.com>
 <909b435d947070b44e66e7e8a10951972fc3da7b.camel@linux.ibm.com>
In-Reply-To: <909b435d947070b44e66e7e8a10951972fc3da7b.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67325405-b023-4aab-bc13-08da1e6211cc
x-ms-traffictypediagnostic: SN6PR10MB3024:EE_
x-microsoft-antispam-prvs: <SN6PR10MB30240609A097B9535B81302F87EF9@SN6PR10MB3024.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4HbXQlh2DU70C0IahkXc9OJA7dzxuuD+jbZORG68OhLbSrgaDZSXKmnfcibZCezhckjaqaVEknDTBZdxTWhSoIkFeQPMO/3CBiDPKpxrqO5Mez8e9gF7dfxUwQnOpEqU9veGL+INqwflG9nHND8R0JiorVpFtXg9261zkTKQUSbfeJq8zDpAp02W7t2QfVesuf8vvyuXm3aBHTYKgKyQWPlbsq9iF1fxGTQEXC+AP1BovbkiVOCymI0oi3yq9Wq4Z8UNIn90jUEA/GpBDRms3RBTXlur5Ifd9r9YJ1yA6TZ838T9G/oqfw0aijTE+OXYEG3I5TE2a0OwGdgADg08PWykOuHkDSu9+FOrGGHzdsdfAD3STkr/8kYC30gP4pj//ekrX2bt+eSx0k0be/QOGNYLzttJ5IEr9sIA18mBvMZ19VKFRYXDupTkWQzDBPPNaa6IWma6RVGCBowjgF/7UbVN9FmZGPMXu1EW1WKwoghy0iAErK0w7vc+R3hyo6uDnyDtKlmPFdmaLtch/M8s1nWnxGol/8IAkJ3EKtFVvYk21096AtEGpvVo8mtMhJnCcGvZCiacMV+vjI3igNI6GApNEHyAqFCn7IV8nO+T2yOn3x5po7Dg0Vi+s7ASU4ruUhAFNO4iJSfFERbzPIfAtA+Ogc3cxqaTDOZYIRwr8STrrXb2mf5hf+vrNX6o4Nx5lzSeBvJV7dyvy17Ex4iefiUP260Z0EPyEWcSuUzApWiwfDS55oLhdJ4lGLeLeKJe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(86362001)(508600001)(66476007)(6486002)(186003)(2906002)(83380400001)(38070700005)(38100700002)(6506007)(122000001)(6512007)(53546011)(64756008)(33656002)(76116006)(66946007)(36756003)(2616005)(91956017)(8676002)(4326008)(316002)(8936002)(7416002)(5660300002)(44832011)(54906003)(6916009)(66556008)(66446008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWVaSE1YL2J4U3kyQlpKYVFuaDlYQkRlc051MDFCbFpaRTVqM3kvVmNsRTVn?=
 =?utf-8?B?bUdTZkRidDd1dSt1Tis5OVE2a0Z1V0cxcjhwKzNGWXBCRnZFVmxoUXR3OG5W?=
 =?utf-8?B?ZE1Lak5MUVBvQzloUFZoNHdRZm1YYlFpZ1lOcVcwdkRSU0lDRm9XNDJYdFBJ?=
 =?utf-8?B?b0wyeFRwVkMrSVo1RXdDNlBSSkRwUEVFNlR3VnIxNWJKT1R5d2NYVXJLRy9o?=
 =?utf-8?B?MGwraVVoWVIzejRBRUFSbE5mUUNRQUxsbTh1cjhicDV4citYVzZ0QVkwNm5B?=
 =?utf-8?B?b01mTFNmUmFwdDlERU53SXZRb2MyY3VzVE1uSmo0YmNPTWpmR24vWDNqMk95?=
 =?utf-8?B?a21IMGFSWTZMQUJRWW5KSThhR0poa3FKWG1OZmM5Q1F1V3dxSjhZVnJqczNk?=
 =?utf-8?B?ZEp2dExZTTd6cDVMUEZIdzk5RUV4cS91NUZLWTFVb3BWNE83eitDeXhNTC9i?=
 =?utf-8?B?TmYxeG85L0lzQlpzckVJTVUvc3J3dmJmYUdkL08vQzMwUUc1cUtpNHpvNzZV?=
 =?utf-8?B?QlFkRWtTY21hdW1aWEVnQ0F1L0YrQVJuY1A3QjVueTBGRFR2UVVBUzRkd3pj?=
 =?utf-8?B?YlF2M0llenRtTjVxWjd4STZheGo0S1FzQXd6WDRYN08vUGdjK0JmVno4OEhr?=
 =?utf-8?B?cUJibDRLdjZCWk4ySThSOUo0Q01YMDBIVkRNcEE2a0xpT3RidXcyL2l2bHQy?=
 =?utf-8?B?NnhKeS9DMEYwNDBRL1RXZHBqYnBoRE55Y1R4NWxSc2JoVTJ5UHpSdzdhc09D?=
 =?utf-8?B?Ykt1bDB5UkpZdXJKSDJ5Y0UwbTlpY0hZQkN2eUJXRGRROXkrU3EwK24yYkdG?=
 =?utf-8?B?YUpPOFZyYjZGODdaeEMyN3JyVnlqR1VJM1BwRnVlZG41YjdIS0RJd0hSWWZy?=
 =?utf-8?B?MTZBT0wvc0lwU1BXRkNBb3RiY2wwZVdDd2Q5ZGNKMzJoYVRyTDhmYU8xU1Fi?=
 =?utf-8?B?M1dwR05WdmsrVmtkMytxZmE2K3hoWXhWaklnRENlTWNYTHVTOW1VT2tFS0sr?=
 =?utf-8?B?eDB5NFN2VGNEQ1hMajJSMGhtR1l6QzFzZmhXZldvckJEdVhHYkxUaHVwaW9K?=
 =?utf-8?B?SUF5YlhDZS9pWExjUm04Z0xsMnpPYjQ3Rm84Umw1dTRxYmRVU2d4b3Jhd1Nt?=
 =?utf-8?B?NnI3QmhRMlFoampOU2tBWS9VcWZETVlLdFdiMkk1SGo1WkJjdExkQmlzVjI2?=
 =?utf-8?B?VlUrd1BUOEhYWmovdkxjNEZDazhHRGorZlpISVVac1BhaHphWDNIcmFpL3Jw?=
 =?utf-8?B?WXNreFpsL1hNVFc5RGpGU0ZNL05CNmdxN1YzbmtQYUR4MFdPRlpab1RSUVI3?=
 =?utf-8?B?OEtNUzBBYmZFSm5rb0QxUzBCeXBIOC9JY0Vzb3JSa1Vvd1RFdWdtV0VSNGQv?=
 =?utf-8?B?aFo2ZjgyeFlJbkFuQ3ExQXJQTU0rZnRGWUZFV2xSZVcyVzVQR2NjWXUyKzNn?=
 =?utf-8?B?QzQwNWZRM0pQRWttTERqYnlkejNBU255azNGYXM5cVo3YWp2ajlnOTl5elZN?=
 =?utf-8?B?NFBPYkpLTVBVcGVuQkdDRzVacGFkNGU1UUZ0Wis2YjY0NmdsZGVnTEdleXRS?=
 =?utf-8?B?YTBUYmRaQ1ZoOTNqZittME9MVyt5UTVPRFlaZjlwL0hYcXhBaDdzM1hYdVFL?=
 =?utf-8?B?ODRBMS9vT3MwZWladWMyWnNlYTVZVWJGeTF6WC9GaEFCNFhoWWJoZ2o3VGQ1?=
 =?utf-8?B?Zyt5eEJDd2tyZGhUSHhEZGJSdUhSaERqemtpclVoUVRmYytVYmsvVFVpQUJN?=
 =?utf-8?B?ckpMbnYrY01uYTJMWENJeVZKNGJsTHZDUDd5VVhSQjk0UkI1bHRXYURpdDcy?=
 =?utf-8?B?TFVjcjBoL2FucWdKVXZTbkg4NXl4a3RPQlpadXBKaGRWd3hncFdOYndaMU9U?=
 =?utf-8?B?bk9WQXZPMHI5YTFPN1hHQXRCR3RrQlhwbE5lN2ZnVGZEdFBUdFA5Yi8rbWpZ?=
 =?utf-8?B?NmZERW1Eb1BIZ29hV3FTNVlOOUdDd0JQTkdOOWdMejJjZlNqaFRhRXhCbWp1?=
 =?utf-8?B?WWlUTkVncENadGNtcmNvcjBqRy9rTUI1cGZuVlBzcThVTk05TGVFSmZXOHhV?=
 =?utf-8?B?cTduQkwwTW1XQzEydjVpZkdJZHdoeVFudWNDNXZoa3d4ZklnbUVjNTdTZ055?=
 =?utf-8?B?NERoUWJ5Tk1NTWtMWG1nem5EdmpwR1pyeFh3Skt4N1VJQXZyRmVJTDhnUGZV?=
 =?utf-8?B?eHNFSUg5a1JMc29HNC9aWlZ1TndYbDNXWFk0TFFxbVNnTjUzZldXQ3RHUGdR?=
 =?utf-8?B?KzROVDUyWHNmWmo2dVdOTlFRd3FNQzh2KzhzSFQrQm5zUWNyclNoeTB5K3hs?=
 =?utf-8?B?VXkwNFZYT1ppTmhXZEI1WlpYNVpDcm5qeVpWTzRFb0EwREtjSi95RFl1MldG?=
 =?utf-8?Q?JQoEth1SaWJtOMWycgcIQsQYumIJP9vj4Vun5L6qpmjgz?=
x-ms-exchange-antispam-messagedata-1: Jor9xSjEkjTc+g==
Content-Type: text/plain; charset="utf-8"
Content-ID: <E13D2E4FC2FAF2459B1BB0E8DECED280@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67325405-b023-4aab-bc13-08da1e6211cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2022 21:59:37.9354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wqBwOnHv/ya4PKaRP7GRDGW+BEvdkUYfXyLQftrSpRDQHPjF05ZWGvyXfSNjhqd82SubC34xUQ3+8877kPKHOS72T1++lYcV5U7qebGBlsw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3024
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-14_07:2022-04-14,2022-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204140114
X-Proofpoint-GUID: ird0Z5i2c9k9tKRyCtiSgzWVojVCWbna
X-Proofpoint-ORIG-GUID: ird0Z5i2c9k9tKRyCtiSgzWVojVCWbna
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

DQoNCj4gT24gQXByIDE0LCAyMDIyLCBhdCAxMjowOSBQTSwgTWltaSBab2hhciA8em9oYXJAbGlu
dXguaWJtLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIDIwMjItMDQtMTQgYXQgMTY6MzYgKzAw
MDAsIEVyaWMgU25vd2Jlcmcgd3JvdGU6DQo+PiANCj4+PiBPbiBBcHIgMTEsIDIwMjIsIGF0IDk6
MzAgQU0sIE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4LmlibS5jb20+IHdyb3RlOg0KPj4+IA0KPj4+
IE9uIEZyaSwgMjAyMi0wNC0wOCBhdCAyMTo1OSArMDAwMCwgRXJpYyBTbm93YmVyZyB3cm90ZToN
Cj4+Pj4+IE9uIEFwciA4LCAyMDIyLCBhdCAxMjo0OSBQTSwgTWltaSBab2hhciA8em9oYXJAbGlu
dXguaWJtLmNvbT4gd3JvdGU6DQo+Pj4+PiANCj4+Pj4+IE9uIEZyaSwgMjAyMi0wNC0wOCBhdCAx
NzozNCArMDAwMCwgRXJpYyBTbm93YmVyZyB3cm90ZToNCj4+Pj4+PiANCj4+Pj4+Pj4gT24gQXBy
IDgsIDIwMjIsIGF0IDEwOjU1IEFNLCBNaW1pIFpvaGFyIDx6b2hhckBsaW51eC5pYm0uY29tPiB3
cm90ZToNCj4+Pj4+Pj4gDQo+Pj4+Pj4+IE9uIEZyaSwgMjAyMi0wNC0wOCBhdCAxNToyNyArMDAw
MCwgRXJpYyBTbm93YmVyZyB3cm90ZToNCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+IE9uIEFwciA4LCAy
MDIyLCBhdCA4OjQwIEFNLCBNaW1pIFpvaGFyIDx6b2hhckBsaW51eC5pYm0uY29tPiB3cm90ZToN
Cj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+PiBPbiBUdWUsIDIwMjItMDQtMDUgYXQgMjE6NTMgLTA0MDAs
IEVyaWMgU25vd2Jlcmcgd3JvdGU6DQo+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+PiBUaGUgZmlyc3Qg
dHlwZSBvZiBrZXkgdG8gdXNlIHRoaXMgaXMgWC41MDkuICBXaGVuIGEgWC41MDkgY2VydGlmaWNh
dGUNCj4+Pj4+Pj4+Pj4gaXMgc2VsZiBzaWduZWQsIGhhcyB0aGUga2VybkNlcnRTaWduIEtleSBV
c2FnZSBzZXQgYW5kIGNvbnRhaW5zIHRoZQ0KPj4+Pj4+Pj4+PiBDQSBiaXQgc2V0IHRoaXMgbmV3
IGZsYWcgaXMgc2V0Lg0KPj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogRXJp
YyBTbm93YmVyZyA8ZXJpYy5zbm93YmVyZ0BvcmFjbGUuY29tPg0KPj4+Pj4+Pj4+PiANCj4+Pj4+
Pj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgva2V5LmggYi9pbmNsdWRlL2xpbnV4L2tl
eS5oDQo+Pj4+Pj4+Pj4+IGluZGV4IDdmZWJjNDg4MTM2My4uOTdmNmExZjg2YTI3IDEwMDY0NA0K
Pj4+Pj4+Pj4+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2tleS5oDQo+Pj4+Pj4+Pj4+ICsrKyBiL2lu
Y2x1ZGUvbGludXgva2V5LmgNCj4+Pj4+Pj4+Pj4gQEAgLTIzMCw2ICsyMzAsNyBAQCBzdHJ1Y3Qg
a2V5IHsNCj4+Pj4+Pj4+Pj4gI2RlZmluZSBLRVlfRkxBR19ST09UX0NBTl9JTlZBTCAgNyAgICAg
ICAvKiBzZXQgaWYga2V5IGNhbiBiZSBpbnZhbGlkYXRlZCBieSByb290IHdpdGhvdXQgcGVybWlz
c2lvbiAqLw0KPj4+Pj4+Pj4+PiAjZGVmaW5lIEtFWV9GTEFHX0tFRVAgICAgICAgICAgICA4ICAg
ICAgIC8qIHNldCBpZiBrZXkgc2hvdWxkIG5vdCBiZSByZW1vdmVkICovDQo+Pj4+Pj4+Pj4+ICNk
ZWZpbmUgS0VZX0ZMQUdfVUlEX0tFWVJJTkcgICAgIDkgICAgICAgLyogc2V0IGlmIGtleSBpcyBh
IHVzZXIgb3IgdXNlciBzZXNzaW9uIGtleXJpbmcgKi8NCj4+Pj4+Pj4+Pj4gKyNkZWZpbmUgS0VZ
X0ZMQUdfQlVJTFRJTl9ST1QgICAgMTAgICAgICAvKiBzZXQgaWYga2V5IGlzIGEgYnVpbHRpbiBS
b290IG9mIFRydXN0IGtleSAqLw0KPj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4gLyogdGhlIGtleSB0
eXBlIGFuZCBrZXkgZGVzY3JpcHRpb24gc3RyaW5nDQo+Pj4+Pj4+Pj4+ICogLSB0aGUgZGVzYyBp
cyB1c2VkIHRvIG1hdGNoIGEga2V5IGFnYWluc3Qgc2VhcmNoIGNyaXRlcmlhDQo+Pj4+Pj4+Pj4+
IEBAIC0yOTAsNiArMjkxLDcgQEAgZXh0ZXJuIHN0cnVjdCBrZXkgKmtleV9hbGxvYyhzdHJ1Y3Qg
a2V5X3R5cGUgKnR5cGUsDQo+Pj4+Pj4+Pj4+ICNkZWZpbmUgS0VZX0FMTE9DX0JZUEFTU19SRVNU
UklDVElPTiAgICAgMHgwMDA4ICAvKiBPdmVycmlkZSB0aGUgY2hlY2sgb24gcmVzdHJpY3RlZCBr
ZXlyaW5ncyAqLw0KPj4+Pj4+Pj4+PiAjZGVmaW5lIEtFWV9BTExPQ19VSURfS0VZUklORyAgICAg
ICAgICAgIDB4MDAxMCAgLyogYWxsb2NhdGluZyBhIHVzZXIgb3IgdXNlciBzZXNzaW9uIGtleXJp
bmcgKi8NCj4+Pj4+Pj4+Pj4gI2RlZmluZSBLRVlfQUxMT0NfU0VUX0tFRVAgICAgICAgICAgICAg
ICAweDAwMjAgIC8qIFNldCB0aGUgS0VFUCBmbGFnIG9uIHRoZSBrZXkva2V5cmluZyAqLw0KPj4+
Pj4+Pj4+PiArI2RlZmluZSBLRVlfQUxMT0NfQlVJTFRfSU5fUk9UICAgICAgICAgIDB4MDA0MCAg
LyogQWRkIGJ1aWx0aW4gcm9vdCBvZiB0cnVzdCBrZXkgKi8NCj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+
PiBTaW5jZSB0aGUgY29uY2VwdCBvZiByb290IG9mIHRydXN0IGlzIG5vdCBnZW5lcmljLCBidXQg
bGltaXRlZCB0bw0KPj4+Pj4+Pj4+IHNwZWNpZmljIGtleXJpbmdzLCB0aGUgcm9vdCBDQSBjZXJ0
aWZpY2F0ZSBzaWduaW5nIGtleXMgb24gdGhlDQo+Pj4+Pj4+Pj4gIm1hY2hpbmUiIGtleXJpbmcg
bmVlZCB0byBiZSBpZGVudGlmaWVkLiAgU2ltaWxhciB0byB0aGUNCj4+Pj4+Pj4+PiBLRVlfQUxM
T0NfQlVJTFRfSU4vS0VZX0ZMQUdfQlVJTFRJTiwgbmV3IGZsYWdzDQo+Pj4+Pj4+Pj4gS0VZX0FM
TE9DX01BQ0hJTkUvS0VZX0ZMQUdfTUFDSElORSBzaG91bGQgYmUgZGVmaW5lZCBpbnN0ZWFkLg0K
Pj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBJ4oCZbSBvcGVuIHRvIHJlbmFtaW5nIHRoZXNlLCBob3dldmVy
IHRoaXMgbmFtZSBjaGFuZ2Ugc2VlbXMgY29uZnVzaW5nIHRvIG1lLiAgDQo+Pj4+Pj4+PiBUaGlz
IGZsYWcgZ2V0cyBzZXQgd2hlbiB0aGUgWC41MDkgY2VydGlmaWNhdGUgY29udGFpbnMgdGhlIHRo
cmVlIENBIHJlcXVpcmVtZW50cyANCj4+Pj4+Pj4+IGlkZW50aWZpZWQgYWJvdmUuICBUaGUgcmVt
YWluaW5nIGtleXMgaW4gdGhlIG1hY2hpbmUga2V5cmluZyBjYW4gYmUgdXNlZCBmb3IgDQo+Pj4+
Pj4+PiBhbnl0aGluZyBlbHNlLg0KPj4+Pj4+PiANCj4+Pj4+Pj4gUmVuYW1pbmcgdGhlIGZsYWcg
dG8gS0VZX0FMTE9DX01BQ0hJTkUvS0VZX0ZMQUdfTUFDSElORSBkaWZmZXJlbnRpYXRlcw0KPj4+
Pj4+PiBiZXR3ZWVuIHRoZSAiYnVpbHRpbiIga2V5cyBmcm9tIHRoZSAibWFjaGluZSIga2V5cy4g
IFRoZSB0cnVzdCBtb2RlbHMNCj4+Pj4+Pj4gYXJlIHZlcnkgZGlmZmVyZW50Lg0KPj4+Pj4+IA0K
Pj4+Pj4+IElzbuKAmXQgdGhlIHRydXN0IG1vZGVsIHRoZSBzYW1lIGZvciBtYWNoaW5lIGFuZCBz
ZWNvbmRhcnkga2V5cz8gIEJvdGggYXJlIHN1cHBsaWVkIGJ5IA0KPj4+Pj4+IHRoZSBlbmQtdXNl
ci4gVGhhdCBpcyB3aHkgSeKAmW0gY29uZnVzZWQgYnkgbmFtaW5nIHNvbWV0aGluZyBfTUFDSElO
RSB3aGVuIGl0IGFwcGxpZXMgDQo+Pj4+Pj4gdG8gbW9yZSB0aGFuIG9uZSBrZXlyaW5nLg0KPj4+
Pj4gDQo+Pj4+PiBUcnVlIGJvdGggYXJlIHN1cHBsaWVkIGJ5IHRoZSBlbmQtdXNlciwgYnV0IHRo
ZSB0cnVzdCBtb2RlbHMgYXJlDQo+Pj4+PiBkaWZmZXJlbnQuDQo+Pj4+IA0KPj4+PiBJIHRoaW5r
IEkgbmVlZCBtb3JlIGluZm9ybWF0aW9uIGhlcmUsIEnigJltIG5vdCBzZWVpbmcgaG93IHRoZXkg
YXJlIGRpZmZlcmVudCB0cnVzdCANCj4+Pj4gbW9kZWxzLg0KPj4+IA0KPj4+IEluIG9yZGVyIHRv
IGRpc2N1c3MgdHJ1c3QgbW9kZWxzLCB3ZSBuZWVkIHRvIHVuZGVyc3RhbmQgdGhlIGRpZmZlcmVu
dA0KPj4+IHVzZS1jYXNlcyB0aGF0IGFyZSBiZWluZyBkaXNjdXNzZWQgaGVyZSB3aXRob3V0IGV2
ZXIgaGF2aW5nIGJlZW4NCj4+PiBleHBsaWNpdGx5IHN0YXRlZC4gIEhlcmUgYXJlIGEgZmV3Og0K
Pj4+IC0gQWxsb3cgdXNlcnMgdG8gc2lnbiB0aGVpciBvd24ga2VybmVsIG1vZHVsZXMuDQo+Pj4g
LSBBbGxvdyB1c2VycyB0byBzZWxlY3RpdmVseSBhdXRob3JpemUgM3JkIHBhcnR5IGNlcnRpZmlj
YXRlcyB0byB2ZXJpZnkNCj4+PiBrZXJuZWwgbW9kdWxlcy4NCj4+PiAtIEZyb20gYW4gSU1BIHBl
cnNwZWN0aXZlLCBhbGxvdyB1c2VycyB0byBzaWduIGZpbGVzIHdpdGhpbiB0aGVpciBvd24NCj4+
PiBzb2Z0d2FyZSBwYWNrYWdlcy4NCj4+PiANCj4+PiBFYWNoIG9mIHRoZSBhYm92ZSB1c2UtY2Fz
ZXMgbmVlZHMgdG8gYmUgaW5kZXBlbmRlbnRseSBjb25maWd1cmFibGUsDQo+Pj4gdGhvcm91Z2hs
eSBleHBsYWluZWQsIGFuZCBlbmZvcmNlZC4NCj4+IA0KPj4gSeKAmW0gc3RpbGwgY29uZnVzZWQg
YnkgdGhlIHJlcXVlc3QgaGVyZS4gIEFsbCB0aGVzZSB1c2UgY2FzZXMgY2FuIGJlIGRvbmUgDQo+
PiB0b2RheSB3aXRoIGluc2VydC1zeXMtY2VydC4gIFRha2UgdGhlLCAiIGFsbG93IHVzZXIgdG8g
c2lnbiB0aGVpciBvd24ga2VybmVsIA0KPj4gbW9kdWxlcyIgdXNlIGNhc2UuICBVc2luZyBpbnNl
cnQtc3lzLWNlcnQsIGFueSB0eXBlIG9mIGtleSBjYW4gYmUgYWRkZWQgDQo+PiB0byB0aGUgYnVp
bHRpbiB0cnVzdGVkIGtleXJpbmcsIGl0IGRvZXNu4oCZdCBuZWVkIHRvIGJlIHNlbGYgc2lnbmVk
LCB0aGVyZSBhcmUgDQo+PiBubyByZXN0cmljdGlvbnMgb24gZmllbGRzIGluIHRoZSBjZXJ0aWZp
Y2F0ZS4gIFRoZSBzYW1lIGFwcHJvYWNoIGNhbiBiZSB1c2VkIA0KPj4gdG8gYWxsb3cgdXNlcnMg
dG8gaW1hIHNpZ24gdGhlaXIgb3duIGZpbGVzLiBBbnkga2V5IGNhbiBiZSBhZGRlZCwgaXQgZG9l
c27igJl0IA0KPj4gbmVlZCB0byBiZSBhIENBLiBUaGUgc2FtZSBnb2VzIGZvciAzcmQgcGFydHkg
c2lnbmVkIG1vZHVsZXMuDQo+IA0KPiBUaGUgZGlmZmVyZW5jZSBpcyAid2hlcmUiIHRoZSBrZXkg
aXMgY29taW5nIGZyb20uICBJbiB0aGUgYnVpbHRpbiB1c2UtDQo+IGNhc2Ugb3IgdGhlIHBvc3Qg
YnVpbGQgaW5zZXJ0LXN5cy1jZXJ0IGNhc2UsIHRoZSBrZXJuZWwgaW1hZ2UgaXMNCj4gc2lnbmVk
LCBvciByZS1zaWduZWQsIGFuZCB0aGUga2VybmVsIGltYWdlIHNpZ25hdHVyZSBpcyB2ZXJpZmll
ZC4gIFRoZQ0KPiByb290IG9mIHRydXN0IGlzIHN0cmFpZ2h0IGZvcndhcmQgLSBzZWN1cmUgYm9v
dCB3aXRoIGEgSFcgcm9vdCBvZiB0cnVzdA0KPiB1cCB0byBhbmQgaW5jbHVkaW5nIHZlcmlmeWlu
ZyB0aGUga2VybmVsIGltYWdlIHNpZ25hdHVyZSwgdGhlbg0KPiB0cmFuc2l0aW9uIHRvIHRoZSBi
dWlsdGluIGtleXMuDQo+IA0KPiBLZXlzIG9uIHRoZSAibWFjaGluZSIga2V5cmluZyBhcmUgbm90
IHBhcnQgb2YgdGhhdCBzaWduYXR1cmUgY2hhaW4gb2YNCj4gdHJ1c3QsDQoNClRoZSBtYWNoaW5l
IGtleXJpbmcgY29udGFpbnMgYWxsIGtleXMgaW4gdGhlIE1va0xpc3QuIE9uIHg4NiAoYW5kIG90
aGVyIA0KYXJjaGl0ZWN0dXJlcyB0aGF0IGJvb3Qgd2l0aCBzaGltKSBhbGwga2V5cyBpbiB0aGUg
TW9rTGlzdCBhcmUgcGFydCBvZiB0aGUgc2lnbmF0dXJlIA0KY2hhaW4gb2YgdHJ1c3QuIFNoaW0g
dXNlcyBNT0tMaXN0IGtleXMgdG8gdmFsaWRhdGUgdGhlIGtlcm5lbCBpbWFnZSBzaWduYXR1cmUg
DQp3aGVuIGJvb3Rpbmcgd2l0aCBTZWN1cmVCb290IGVuYWJsZWQuIFNlY3VyZSBCb290IERCIGtl
eXMgYXJlIHVzZWQgdG8NCnZhbGlkYXRlIHNoaW0sIGJ1dCByYXJlbHkgdXNlZCB0byB2YWxpZGF0
ZSB0aGUga2VybmVsLg0KDQo=
