Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C221433C2E1
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Mar 2021 17:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbhCOQ6s (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Mar 2021 12:58:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56614 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbhCOQ6Z (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Mar 2021 12:58:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12FGjkOV151374;
        Mon, 15 Mar 2021 16:57:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2020-01-29;
 bh=Lf8MqhFk41xiYbhWADyYqlSDummXTupAEP4HXqi9rZs=;
 b=p9AysWlBJsScrHRdGD86f8piOP/gmLOzb4UCpzQ/Tl1L2ZXrpzXhVNs6ek94XQvMZDvx
 663Dt3h0/xF37C8GMx+ZnscvlNYN8I1c5DO8xHOxNzOrTPrlIxyYEtEc8LAdx1jUd0BH
 vvouwt1SCB6aQ7SoQhBBWP/Qxre1/b0B4OEXNbxoRwKY3mkHRwpPBa0hLcvwlB3WOR4L
 R3ZPqCWur17vjAlQXRfy8IxNUYJ+N0nwkVtFZ1T3OLTlODN6yYpYXLq224U9u5jnsUbp
 czP4wo8JN5jO86ZUEaacRBLCk6HOmf8ssdZchtejA7SD1eo1BYVzPDvb7Gm3U8ajrbpk ng== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 378p1nmk08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Mar 2021 16:57:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12FGk646075085;
        Mon, 15 Mar 2021 16:57:45 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by userp3030.oracle.com with ESMTP id 3797axxh6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Mar 2021 16:57:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxKmvBEDr/SC6py9v/JwxXpz9mR14t1XFp8Dkre5pcZoIi9K6+7XkO1RhvHxFgASgV9GEIvebH/jk9/9640Ns7Yam5pR9inhBeVBwL0T8f7UZy0lKUvXXZ6xAhb5Hx1nPe8hYjU1DC3B7NMSfoETdJDPhd1ZrszSiiOnX8eUpixgagbJ+cwHQ2/0Q6NuWkpkKk5pE2hWtfv683vViIahv6k5bt3SAK0me1twwrsQHU5X7Jo8UjQpMrVveLsTHUAppemjYuP7g8/uElbH4cYrO8xsDwpZHMPWbOcMqyJMt7o6tCgPhaDJ55hbyY//ro0howzdTmSszQRYyBCGrpA/0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lf8MqhFk41xiYbhWADyYqlSDummXTupAEP4HXqi9rZs=;
 b=TMQqViM4OQzpDNkPEuq64S/fJKiD+VX6wJMKj12ZlaXeOwepPvhEPLy/P6DPW75JIrdxgs1XTjirZldgndP8qVAIoTdNGSkcpHly2k6SJtlDPy7qVH7MotXfovBTN4xT1dBJe1Br2mRaCbWLs0fJNCl4pRxVju2QhUacuSAaqvM+3T4Lj7yW8l33iaIuQhLEaNsr7oTtiTBECwHqwaxXmGX/GQXDJfgDvLhlknBkLt9c7JnDXQ0HwYNMPJZByeNYtEWMApqOqH0Hx0/zND8rckCAa3nTV7FsjWOd4UjpNMBh1d6CikcYYQ035BsRAk0HIYmO1Y+af44dEe4R2Ub4Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lf8MqhFk41xiYbhWADyYqlSDummXTupAEP4HXqi9rZs=;
 b=rvNHcI9iiLKu/xrP4rAzujSK40uMb5tVOk4SoPkUaxgch3pUiIqaqhrwWEdIBpqtpccR1Jlt3G61yF5FWTDVRjuMx3zsj07utROdybppX/Btl+nvh4VquzkT+ZbYJ3lXGNjelEtwvOne5hQArD0i6py08PYdoQnTguK8dMvhPzg=
Authentication-Results: digikod.net; dkim=none (message not signed)
 header.d=none;digikod.net; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3768.namprd10.prod.outlook.com (2603:10b6:610:7::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Mon, 15 Mar
 2021 16:57:43 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::95df:950e:af4c:a5df]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::95df:950e:af4c:a5df%9]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 16:57:43 +0000
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v7 1/5] tools/certs: Add print-cert-tbs-hash.sh
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <20210312171232.2681989-2-mic@digikod.net>
Date:   Mon, 15 Mar 2021 10:57:35 -0600
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0BB27C1C-9B66-4671-B3F5-B4C505955CC6@oracle.com>
References: <20210312171232.2681989-1-mic@digikod.net>
 <20210312171232.2681989-2-mic@digikod.net>
To:     =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
X-Mailer: Apple Mail (2.3273)
X-Originating-IP: [24.52.35.144]
X-ClientProxiedBy: BY3PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::20) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.177.128] (24.52.35.144) by BY3PR03CA0015.namprd03.prod.outlook.com (2603:10b6:a03:39a::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend Transport; Mon, 15 Mar 2021 16:57:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b81d12ba-f105-4de8-6fd9-08d8e7d37361
X-MS-TrafficTypeDiagnostic: CH2PR10MB3768:
X-Microsoft-Antispam-PRVS: <CH2PR10MB37688642D5F9F1B240882B96876C9@CH2PR10MB3768.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:69;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KyMGOksJLqFlTW6xUIU3oEe78aQa4kZtmtE4jT7jMmJSmvIqHFaPuO9r0Eg2BT63+YB6Ip4MUMvqt9qaEmcmOSLG0eBiLm0lIA8wEV62qT9GNr4w75gnKE15Wh0eUPg/2y+1VO3SfnQOf9LuQfvCYpc8/IqLvPv+PXT7nJkErLxAsnHb0YPbDL6Qfui2iEXw6atALQ73LYrTY9x7AJSeKuja75KVn/J4oy/jd8WA6MdBWJMEyP5WBc4uVchguN21o8lnlz8/qhXqVMPYO/UYHK/XU5nZTXa0D/SFK9znWNqngcb9eoa5oTaBBs3e2EdJ7O1REOkrojdAUQL3LHZ9QFeBsTzayW+3uOJ1UEKB4ahIHC1XxMKNNJlxybDo7ngixoP1QNmDLSi18q9x1q/UeutuFEXALR0MpXCs+R9SQ5k4vB4226/2rbtUCAwDmpTHE5p6LsUbUAjOTAxVrpN3U0ikMX9qp9be07u3nGpr3Hi2fsvbBIWI1kzfsLOAbpz1LDln4zf70+/sSzKXGmTYJwECsHntb2GmEpMPP9sZHoAo9ENdtRWom2voW+50Lg3sQ46wTjp/C/M4dU9IwuZUo/VDX/L2/2eA0+Z7O9ePeqCa02Bw9Xe0CLfc+CtxnYVSpj94bOvTqMr0NZbZZwl96VDvrH9WiP/sfxLp1ttHuza525k1dNS05B0TQtbKLKoZCBkh5Ie7aOrJdGUVMlaK1jQEuYYm/APatWHsnyT1PMo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(346002)(136003)(39860400002)(66574015)(6916009)(2906002)(66946007)(7416002)(8676002)(2616005)(16526019)(4326008)(5660300002)(186003)(26005)(478600001)(6666004)(83380400001)(45080400002)(86362001)(966005)(66476007)(16576012)(316002)(66556008)(6486002)(44832011)(33656002)(36756003)(8936002)(52116002)(54906003)(53546011)(956004)(45980500001)(414714003)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Q2loZHhQZTBDYkEzSm5iTVdtbmlWd0VzdnBQem9ldG1Oci9NNDhucElzekpU?=
 =?utf-8?B?L2JtRGJNeWwxK3lmOXlNQnQ1ZHFxY1ZiZEU0N1VGU1hqaHJUQmVzNHV4OUMr?=
 =?utf-8?B?TUdZdVU4K1dkb1FiaklmMFpNZ2JLaWdsZlZrN1ZyZmVZeUJvZURTSzgwS1cv?=
 =?utf-8?B?Y0lVakxQUys5QnVGNUdrc0xBb0pjNVdEajdGdFlZTGF0TnY1MUVHN1NzRDRK?=
 =?utf-8?B?UldXT0Y5ejZISnZSV0hYMzNRdVBoTVdVMjNsUkxIYmJaa2l6SlBJZ3crLzFt?=
 =?utf-8?B?OUNnV3pibUh0VU9ybUQ4emdtU3N6T3BnM0tGNUdjTWdDald5OFlSTkFGNzF4?=
 =?utf-8?B?eTBPSE9lZ1BBWWdzR0dzT1BRV0VZWUNSdDRjR1Rla3BlZDJKbmw4Yno5UkJ1?=
 =?utf-8?B?ZmJ6M0F1VHM3QzAyaEZrMUJUWGpwVi9MQWVUWjVkVDljaGJGMmdsMFIwOVhq?=
 =?utf-8?B?czZzWFNpT3RzbkovUTk0MVVxVlpPN3B4SFpOR1pvaGwrYVRFNFRMaWd2ZFpN?=
 =?utf-8?B?KzVSei9waUFCZFRRd2RDRDIrSFdBTm14NUdJb2tRL3Zya1hjYmhGZWY0T1Vi?=
 =?utf-8?B?V1NDVkFuMDh3elI3WEpZV0dGTUJjbEhnZnM1djJHV0RRODJueVIzbnBGbnBQ?=
 =?utf-8?B?bUhxTkt1cmhQVXJSdXF6bmNScDMyWWJiM1ZMRFh0MlhrakN1cFlicVNyUVQr?=
 =?utf-8?B?TjhYUko0ckhwMDJHQUw4YmRrbStEenYrOWtZVEtHMVpjamZ1Rzc3ajFpRG9p?=
 =?utf-8?B?ekdKbVVPNGY2N0VVT2F4VVNSSFpWVEp3bWdmbWdISEJ0dm9lT3d3MUVmdXhH?=
 =?utf-8?B?UWxHaWZvSTV2cXozdkV2N21iaG5wT0d5anBMMjJYQ3o2UFdCd0R3YUZ5S0FJ?=
 =?utf-8?B?TUlWazFDSDE2QXU1ZjRHNEtSZjAzTkd2ZzBXaDEwWldXNW5iMytUUUhkdmxt?=
 =?utf-8?B?UW1CNy9rK05tME1Zb0FTNFhqYVhIRzJtQUJKaGVNVFN4V3M1cEFiMHBtUDJm?=
 =?utf-8?B?V0dUNmUzTndHZGpDUThDZzVMQjJtVDNkT1VvY3FKUTJKTHlzdENDVldKNEFO?=
 =?utf-8?B?NFlaVVBDRW5xS3JkRWQ0SjJHdDdValNhYVVZWkVqTEhob1VGT1AyZ3EvNGJm?=
 =?utf-8?B?MXBUSmp4WWhpR2ZKeXc0cEc1UUh6WHRyM256ZXdTckRUWUw5QUFtSHU0RHh1?=
 =?utf-8?B?S3diRVhhNjg1VDMxTkQ1TWpBeUpoU2tMSmgvVlBjejlid0RCUHlTc1pOaDRJ?=
 =?utf-8?B?Rk1SQTJXaVhXYzBtbnAyZGkxaXc3ek5WSWMyRzlJRlA3Y2x1QXFic2hWN0xS?=
 =?utf-8?B?VHB4ZGRvWHNNZzJFV3BNNWU4S29HalR4a2xoV09yUjZ5NlJqa3JsampFRS9m?=
 =?utf-8?B?UjA0SXZYb2JIZUtCTUM0SG02cFRQQWlrbUtzSXNQOWV4ZmM2RVVrQjdqWTI4?=
 =?utf-8?B?dWJ6TjhNa0srVGpSZXE1a3lBRmRCOUVwQjZTT3JNYmsza0J3dldvSUIyWnNX?=
 =?utf-8?B?cTFkMytiQzRkRG15b0pTU0N4YVB6YkRqUHhXVjZnWTBBcVhCS0ZXb2FjS05s?=
 =?utf-8?B?TGtRaVlINkkveFlXZTVta1RvMkcrY0tiR3lDdkNZZnY5Wkt3Q1lrelh3N2Nz?=
 =?utf-8?B?bFdwbjVYUE1lY2dLc2g1TGdQV25SOEJqbUwzQTFodFFWSUdHNVk5UllPbmUy?=
 =?utf-8?B?SWRWeHdiODhqZzFGdENXL1VtbEFUbW96dXZZV0xnMWJaSFFzZ0l6TUR0dTYz?=
 =?utf-8?Q?c5jUu/MJCKLvHYb2UYfl9/0CKZvKVGISz+khN3q?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b81d12ba-f105-4de8-6fd9-08d8e7d37361
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 16:57:43.4125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tkcd0GVlt/jf7gv6D1XvS4Kc90u7tU7UQ3uxerhFaUE3ThiWxHHwBjFOMKw8RbYphoA7Q+tKtBsmJRmUW9yzb114BWB5fTdH46n9RnMl0r4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3768
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9923 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103150114
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9923 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 adultscore=0
 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103150114
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Mar 12, 2021, at 10:12 AM, Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
>=20
> From: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
>=20
> Add a new helper print-cert-tbs-hash.sh to generate a TBSCertificate
> hash from a given certificate.  This is useful to generate a blacklist
> key description used to forbid loading a specific certificate in a
> keyring, or to invalidate a certificate provided by a PKCS#7 file.
>=20
> This kind of hash formatting is required to populate the file pointed
> out by CONFIG_SYSTEM_BLACKLIST_HASH_LIST, but only the kernel code was
> available to understand how to effectively create such hash.
>=20
> Cc: David Howells <dhowells@redhat.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Eric Snowberg <eric.snowberg@oracle.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Link: https://lore.kernel.org/r/20210312171232.2681989-2-mic@digikod.net

Tested-by: Eric Snowberg <eric.snowberg@oracle.com>

> ---
>=20
> Changes since v5:
> * Add Reviewed-by Jarkko.
>=20
> Changes since v3:
> * Explain in the commit message that this kind of formating is not new
>  but it wasn't documented.
>=20
> Changes since v1:
> * Fix typo.
> * Use "if" block instead of "||" .
> ---
> MAINTAINERS                        |  1 +
> tools/certs/print-cert-tbs-hash.sh | 91 ++++++++++++++++++++++++++++++
> 2 files changed, 92 insertions(+)
> create mode 100755 tools/certs/print-cert-tbs-hash.sh
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 00836f6452f0..773a362e807f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4120,6 +4120,7 @@ F:	Documentation/admin-guide/module-signing.rst
> F:	certs/
> F:	scripts/extract-cert.c
> F:	scripts/sign-file.c
> +F:	tools/certs/
>=20
> CFAG12864B LCD DRIVER
> M:	Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
> diff --git a/tools/certs/print-cert-tbs-hash.sh b/tools/certs/print-cert-=
tbs-hash.sh
> new file mode 100755
> index 000000000000..c93df5387ec9
> --- /dev/null
> +++ b/tools/certs/print-cert-tbs-hash.sh
> @@ -0,0 +1,91 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright =C2=A9 2020, Microsoft Corporation. All rights reserved.
> +#
> +# Author: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> +#
> +# Compute and print the To Be Signed (TBS) hash of a certificate.  This =
is used
> +# as description of keys in the blacklist keyring to identify certificat=
es.
> +# This output should be redirected, without newline, in a file (hash0.tx=
t) and
> +# signed to create a PKCS#7 file (hash0.p7s).  Both of these files can t=
hen be
> +# loaded in the kernel with.
> +#
> +# Exemple on a workstation:
> +# ./print-cert-tbs-hash.sh certificate-to-invalidate.pem > hash0.txt
> +# openssl smime -sign -in hash0.txt -inkey builtin-private-key.pem \
> +#               -signer builtin-certificate.pem -certfile certificate-ch=
ain.pem \
> +#               -noattr -binary -outform DER -out hash0.p7s
> +#
> +# Exemple on a managed system:
> +# keyctl padd blacklist "$(< hash0.txt)" %:.blacklist < hash0.p7s
> +
> +set -u -e -o pipefail
> +
> +CERT=3D"${1:-}"
> +BASENAME=3D"$(basename -- "${BASH_SOURCE[0]}")"
> +
> +if [ $# -ne 1 ] || [ ! -f "${CERT}" ]; then
> +	echo "usage: ${BASENAME} <certificate>" >&2
> +	exit 1
> +fi
> +
> +# Checks that it is indeed a certificate (PEM or DER encoded) and exclud=
e the
> +# optional PEM text header.
> +if ! PEM=3D"$(openssl x509 -inform DER -in "${CERT}" 2>/dev/null || open=
ssl x509 -in "${CERT}")"; then
> +	echo "ERROR: Failed to parse certificate" >&2
> +	exit 1
> +fi
> +
> +# TBSCertificate starts at the second entry.
> +# Cf. https://tools.ietf.org/html/rfc3280#section-4.1
> +#
> +# Exemple of first lines printed by openssl asn1parse:
> +#    0:d=3D0  hl=3D4 l=3D 763 cons: SEQUENCE
> +#    4:d=3D1  hl=3D4 l=3D 483 cons: SEQUENCE
> +#    8:d=3D2  hl=3D2 l=3D   3 cons: cont [ 0 ]
> +#   10:d=3D3  hl=3D2 l=3D   1 prim: INTEGER           :02
> +#   13:d=3D2  hl=3D2 l=3D  20 prim: INTEGER           :3CEB2CB8818D968AC=
00EEFE195F0DF9665328B7B
> +#   35:d=3D2  hl=3D2 l=3D  13 cons: SEQUENCE
> +#   37:d=3D3  hl=3D2 l=3D   9 prim: OBJECT            :sha256WithRSAEncr=
yption
> +RANGE_AND_DIGEST_RE=3D'
> +2s/^\s*\([0-9]\+\):d=3D\s*[0-9]\+\s\+hl=3D\s*[0-9]\+\s\+l=3D\s*\([0-9]\+=
\)\s\+cons:\s*SEQUENCE\s*$/\1 \2/p;
> +7s/^\s*[0-9]\+:d=3D\s*[0-9]\+\s\+hl=3D\s*[0-9]\+\s\+l=3D\s*[0-9]\+\s\+pr=
im:\s*OBJECT\s*:\(.*\)$/\1/p;
> +'
> +
> +RANGE_AND_DIGEST=3D($(echo "${PEM}" | \
> +	openssl asn1parse -in - | \
> +	sed -n -e "${RANGE_AND_DIGEST_RE}"))
> +
> +if [ "${#RANGE_AND_DIGEST[@]}" !=3D 3 ]; then
> +	echo "ERROR: Failed to parse TBSCertificate." >&2
> +	exit 1
> +fi
> +
> +OFFSET=3D"${RANGE_AND_DIGEST[0]}"
> +END=3D"$(( OFFSET + RANGE_AND_DIGEST[1] ))"
> +DIGEST=3D"${RANGE_AND_DIGEST[2]}"
> +
> +# The signature hash algorithm is used by Linux to blacklist certificate=
s.
> +# Cf. crypto/asymmetric_keys/x509_cert_parser.c:x509_note_pkey_algo()
> +DIGEST_MATCH=3D""
> +while read -r DIGEST_ITEM; do
> +	if [ -z "${DIGEST_ITEM}" ]; then
> +		break
> +	fi
> +	if echo "${DIGEST}" | grep -qiF "${DIGEST_ITEM}"; then
> +		DIGEST_MATCH=3D"${DIGEST_ITEM}"
> +		break
> +	fi
> +done < <(openssl list -digest-commands | tr ' ' '\n' | sort -ur)
> +
> +if [ -z "${DIGEST_MATCH}" ]; then
> +	echo "ERROR: Unknown digest algorithm: ${DIGEST}" >&2
> +	exit 1
> +fi
> +
> +echo "${PEM}" | \
> +	openssl x509 -in - -outform DER | \
> +	dd "bs=3D1" "skip=3D${OFFSET}" "count=3D${END}" "status=3Dnone" | \
> +	openssl dgst "-${DIGEST_MATCH}" - | \
> +	awk '{printf "tbs:" $2}'
> --=20
> 2.30.2
>=20

