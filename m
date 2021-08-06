Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAB23E2109
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Aug 2021 03:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242606AbhHFBaw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 Aug 2021 21:30:52 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:48154 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232952AbhHFBaw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Aug 2021 21:30:52 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1761Gq4P017763;
        Fri, 6 Aug 2021 01:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2021-07-09;
 bh=DJzr4qTBphwQGVPxPNioqvlCbN/fvHBfBgV3sjbbnZ8=;
 b=FLr8VhW8nuBnlQiuot3FdwQEvRhe+Ir9ewuRkPTyx5vCin3DXwt99XvVs1NTPm2NBXvd
 HF1J1P7u0SEltllNJSF5M7X+MdZmw0MhhT1uvyQ00ufUEH00tdiJz/3oGWjbi56Uk2CS
 jZh6rr0qrlUmj54IIgeomymx5kRTipmkzmhghybj4vbEPGJp2dKs+4vCwYrRV68dXMRS
 vDksgqDIPseTkt8AXFxmc0QhuB50GNQ/bBtH3VJK+kbw5/dQFCOopuXqChgKtZxz0czn
 O0oPGUjQcFGtlHvQ981VAipsStb/LRS3BnEpmksoITGYuPYyV9SGYk08LTkW8x8oFCjd CA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2020-01-29;
 bh=DJzr4qTBphwQGVPxPNioqvlCbN/fvHBfBgV3sjbbnZ8=;
 b=QGjItdDaZAOWKyvmygOB4fJxJOXFxwPMxJjvJQZ973hCYmn8m54M2Ic4LDLYkb1hu4Mg
 0E28ycdVkH0vqVnQPUTE18VASfCGVdfZX55t0v6hbD5+dbTXKnM9drwwV2FfhEwdRJIf
 oNYLRCPOUw+WeecixFpUexPdXjFs8ByTpslWdjJatPHWIgAq3R8noUsdYua2pdTuLIsx
 Bbi9FV9TwGBk2xfhBEPkQtZEe5tB2ZqPXr3oRJWCEEf/X6G8wxCJAoPttJY4cdpeltK0
 HACas2X9ZKKxOnRzccsDbqDqu6+XTNHj/oY11ZxjkW4gN+OGKIlvJ25/rC4hcPQ9F3tP ug== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a7wqv3px3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Aug 2021 01:29:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1761FYwo092786;
        Fri, 6 Aug 2021 01:29:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by userp3020.oracle.com with ESMTP id 3a5ga19x38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Aug 2021 01:29:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDHN8RNsRIlmWoEmb7kYwMdPIOAukQoU9wqtmFRVvRB+HyrhJtclW8AOLrIYIQBE2Bqhqofqm8F179x1RfLS71VNemUTj2qbOPGYywfTFxP8jZt3vEAHsda7bMQnRcp0xGW+gpqecloS6QyjV0S+BTPbNRuPsDCnz6sqM/KaQIiaTUUl1yMzI0sYftwdjyhMGa3iM+cSL25SihR3G1eo0DyPh9SRvtxXSf9WfiGa7HeZk9wT4IZApiNBSy5gt/1//fzDtQxSeiOjSOx3QWj3v6utyz4IJo0ckMrjPmez/mK4IsB/JkjaxVqD8XR4i8LgyhI5SyInc38X/suUV60hRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJzr4qTBphwQGVPxPNioqvlCbN/fvHBfBgV3sjbbnZ8=;
 b=LVR2LIUMBlco3uerIMiHMMBpVVEccXq+bu3KFm5vZkzUt7itZKLZEmlhy30tzIx9Yg46UJkJ6ulJQaX6Rc39fb+SG30ljg5t2BFkHcKCTgBlWr/g0BNb2Kq7NxsWLTgkJT/Df0aJu5uasHzbk65k31eB3pjotGGkVU9e8QpWKx9qbqAstR0C4priE8x12noJfbgwYhqWUqTdN8MjKQz1cGR5bAJuoMHPkW/UlyZ7VQKTrO1Xo8t04CDGzdbdpamheczfCq6CCpynQbzdn9ESR/Wyyo5gCxKSQ9ufIxrnk7kcG57UHSaP/jrDpQ/RidXPj7RTSC3k9dmHyaNkxwCoJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJzr4qTBphwQGVPxPNioqvlCbN/fvHBfBgV3sjbbnZ8=;
 b=t6c/fMT16W27BjeebrjPbf0v+P4N2ELptmqwqiWwaQ+2/pv6txxdNDO/6zpFVkHU/ltGrmV5/ufHaCLPJpKkXnCQvx6h14JZZCNkv1wz7HA/NlXeVc6Ypds4on4XYYLNNTML3FBqCvOiFvnO6tOoexOrWPWY5gKEpsQk0+28XKY=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3925.namprd10.prod.outlook.com (2603:10b6:610:12::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Fri, 6 Aug
 2021 01:29:52 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::1d17:4a7d:92cc:8fc3]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::1d17:4a7d:92cc:8fc3%7]) with mapi id 15.20.4373.028; Fri, 6 Aug 2021
 01:29:52 +0000
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH RFC v2 10/12] KEYS: link system_trusted_keys to
 mok_trusted_keys
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <6c751dadf4ce7385d0391ea26f1c7e4e910219e0.camel@linux.ibm.com>
Date:   Thu, 5 Aug 2021 19:29:44 -0600
Cc:     keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, keescook@chromium.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        scott.branden@broadcom.com, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        glin@suse.com, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <44ADB68B-4310-462B-96A8-2F69759BA2D8@oracle.com>
References: <20210726171319.3133879-1-eric.snowberg@oracle.com>
 <20210726171319.3133879-11-eric.snowberg@oracle.com>
 <6c751dadf4ce7385d0391ea26f1c7e4e910219e0.camel@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
X-Mailer: Apple Mail (2.3273)
X-ClientProxiedBy: SN4PR0201CA0048.namprd02.prod.outlook.com
 (2603:10b6:803:2e::34) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.177.128] (184.60.195.210) by SN4PR0201CA0048.namprd02.prod.outlook.com (2603:10b6:803:2e::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17 via Frontend Transport; Fri, 6 Aug 2021 01:29:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d123d34-8a2f-4f43-9e90-08d95879afe5
X-MS-TrafficTypeDiagnostic: CH2PR10MB3925:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB3925B998CB5C2852140FE21487F39@CH2PR10MB3925.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MT2vEWL7XnlHzfUToHfeiYvwo91vBq/Wz/GO3vX/zj71/m738is7MvhVm7pu2rIRDi6268RU7dDzRRF2LdoHp618xpbyW0DU2/Z9/3E23/OC+6zq7z8XjQtqyA0o7UrYgy0NnskOBgFOJuXLCPdQofSMCRGVt5auEONoU341jeKpZu8fyHV/PfP1NtwK65iKt1xEZNHtRi9LPCQg6rUWgz+8AK0kdqepfU/xn0mgpRxh1YDPs0vXBhqZcGb9VBLquhRcHDcxxRiTuHfKPnkbaE+BLAhw9Z62QazNjZKvATqHlHkEvukc7ui8UT48tFZXR8gAm+o2tLR/NVEGqbUXtyJN3oKIUZpMstCEOvL8pHVIBiLO+Ij1PTEWQ+mESSbgD+9BixvG9ZL6zhifCZalI81gTGzbzjVbut8Gpv0bQJx0uG0peg6I/SAdJjxOWFO/l3GXVFidvab26vodnKge5cm+HEj7POss/BpIyJwAiJI5pSDrDct5XtKigU9YnJzNV4UeRvwSPdQauEim5ORP5mbbuGnMKbb1ra2QfkVjRoJ+l0GYM5l8sxchNmRLF9Sb7j4k7D3d8oqttyS9u8qtSH4b+xzLtirQNKMrLfrQQ0+zqFCGJqI67Y88DatqtTKcRmSgL/WmRYDqZr0oBYZ1WJPLGEhTWrQKJvs9AyUI1uA8nuq3ZMKBy/Ut4H3uys/wLWVF81z8P9qV/F8ZOJXAvcav/VZk9FKKpVJSMdfbpho=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(66946007)(316002)(16576012)(66556008)(7416002)(2906002)(2616005)(956004)(8676002)(4326008)(508600001)(44832011)(107886003)(54906003)(36756003)(26005)(33656002)(186003)(6916009)(38100700002)(38350700002)(86362001)(53546011)(5660300002)(6486002)(6666004)(83380400001)(52116002)(8936002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHRmSEhsQ2RML2o3cWZwWWMzY3ZkekZRRlZZdUpVRUd0b2RRbE1kOUVrbXVj?=
 =?utf-8?B?WWNsQ1NRNncvMEFlam53ZXB0Vnh0N2FyZG5NMnRWanR6Y2VQWGlobFBNSjJq?=
 =?utf-8?B?bVdsbjdGTkJLc3hXYnNqVTFKUm9qQ1IxYTd5RUNNOExVZHpZUWFCaVV6d0kx?=
 =?utf-8?B?VG9GRDlHTmdvQzJjVEtySDh6dDZPYUhzU3MyRGRFRWJUOThrSTdzNHRUOGZx?=
 =?utf-8?B?SnBGeTZhR2lhOUozWXAxc1BQRGtqYWFoOGxad0pqLzhSamtmWEpXK2VhSjZU?=
 =?utf-8?B?WE02Rk9BT3E2VjQ3M1p6RHkyRHRHOHBCK2pjMWJuKzhCdDQveU1Gck5IY0tD?=
 =?utf-8?B?VG1WY0w0ZmcyYUJPODlwUUp5RnVySitqTUNKc2s4NS9uV2VvT0RxVTlxcEgr?=
 =?utf-8?B?OFpBWWhMd2hCSFZyNSsrYnlkQ0ZPSzQ5a0pvUzBQQ1U3L1JxcGV3Vm16NmJr?=
 =?utf-8?B?blFxbDg4KzR1WGhLY1M0Z0ZMS3ZaU3pZdHhpL2U0Vm9zYlJISEo4UUMyL2Vs?=
 =?utf-8?B?VDhqcWR0dnhUS3FzSTdHZXN3S21VY3VuSEJHazZFaFlNNGRnTWZ2WkQ2ZnFS?=
 =?utf-8?B?Smx5Y0RYUGtuS3pGRVFpclgwV2ZYM3M1RUVHUUxScWJsamhGN2svME05NDho?=
 =?utf-8?B?bkZaakdnRUtUVVQxa2hTSmZmWG1QWWlHQnk3a3ZrdXA3M05rSmRORktJMFNk?=
 =?utf-8?B?eU05aWs1RjYyK2hhZUJFUkdyd083L3pESnNMWGdqVkdtUnRZSDZCeW9nc01t?=
 =?utf-8?B?THlCVjYwUmR5ZlhEN0p5aG83ODVHVGZMV0RoOXZENU9jL2RyZnpWVUdVeERS?=
 =?utf-8?B?MnBlUjdZWHA4WmpBT2kwYmFsemVjRTZFOUpsakFLS3JGeXBZRm9LODF2YXdP?=
 =?utf-8?B?dXRrbGpaNWtYNWpLbDdENnpOTVUvWGJVcHRad2NFKzVCOHpNMTdtMnR3bTRv?=
 =?utf-8?B?SWVIYW1EOGUyZXlJd05EQW9pWVFWVElDVUN5OWwwTUZXZER1R2NSTjVreFlW?=
 =?utf-8?B?enpGOEdGWlMrSUNqS2RUL0xXSldPQmZvaWRHVkkrYzVNQnI5S0V6c0I0bXo5?=
 =?utf-8?B?OHk2VTV0UHNObXd3ZDlvMjFpc3VFM0JDK1F4eEdLdk1SZTV4Vnc1ZkFLN0ZK?=
 =?utf-8?B?TUxWSTk5VlNzVDJKd1U3Y2VYeGEvOFFDVklabU01d2pCcDJGTDJHekVxS0Y1?=
 =?utf-8?B?ZFdUVW9iSXVIQ3FsYUdlcHNNVDh1WVJ6WVNVMFpQT1NUM3ZDV0Fyd0FYQkFB?=
 =?utf-8?B?QWFIR0N4Z3pWTnJiV3UzR1NuQ2NtaGl1UmxDK3I3ZU1La2lsV2xDUmZRWUVh?=
 =?utf-8?B?VGJnZlZneUI1K0lPL2NWekNzY0tjUXJXMDBhdzdrUmZNcG8wOEpRQkRwRmJ2?=
 =?utf-8?B?UitCZlFMenlGUGhneWNkZ1QwTjVJNjlnR3FJcnFwMXZJR3R0WWZqRWhvV1VB?=
 =?utf-8?B?ZXVRQmcxWm5Ia0YvNlFtZy9yKzExUFdhLzRhMWVVZEoyQ3VVbDR2V1ZEd3Y2?=
 =?utf-8?B?QVh1R0ZtcE1CZFFqL0w3d0tqUE9jL1VSMzE5UFl4TDhWTDB3a1dUa1h0c01t?=
 =?utf-8?B?cmJkSTB2bldzRGM5Tkh2M21kMlNqS0NzUDhpaTN5Vld6cmJIK3V0bTJzSlpa?=
 =?utf-8?B?Wkx2Y0ZOUExSaThEeHFzUFpTQ09MTzh5VExHVHp1Z1JzMU5tcnArWFg1VVc5?=
 =?utf-8?B?TDBzQjVTdGdQWTVYWUZKbUlyazJzZ0JZVVF1TW95RGN0cDNZWlo4ZVZ4Wjky?=
 =?utf-8?Q?48b4/O/rf9eSxnvZgxgcpfUcvJw7IqowuRbsUSR?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d123d34-8a2f-4f43-9e90-08d95879afe5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 01:29:51.8996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0mv5uwr1f1H3S+Fodu1lF/KmqtoQJYccEKTqXNy8lE+rL1Zimhr4IjJ/qAzd2i/y68A+CO3sf4/OwBQQsV2joCLu0C3eHxjgsDktwIa1Vg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3925
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10067 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108060006
X-Proofpoint-GUID: IaJFhgSeoIjqMxltMifERhL6aekrX4-T
X-Proofpoint-ORIG-GUID: IaJFhgSeoIjqMxltMifERhL6aekrX4-T
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Aug 5, 2021, at 7:58 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>=20
> On Mon, 2021-07-26 at 13:13 -0400, Eric Snowberg wrote:
>=20
>> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
>> index dcaf74102ab2..b27ae30eaadc 100644
>> --- a/certs/system_keyring.c
>> +++ b/certs/system_keyring.c
>> @@ -45,6 +45,15 @@ int restrict_link_by_builtin_trusted(struct key *dest=
_keyring,
>> 				     const union key_payload *payload,
>> 				     struct key *restriction_key)
>> {
>> +	/* If the secondary trusted keyring is not enabled, we may link
>> +	 * through to the mok keyring and the search may follow that link.
>> +	 */
>=20
> Refer to section "8) Commenting" of Documentation/process/coding-
> style.rst for the format of multi line comments.

Sure, I=E2=80=99ll fix this in the next version.

>> +	if (mok_trusted_keys && type =3D=3D &key_type_keyring &&
>> +	    dest_keyring =3D=3D builtin_trusted_keys &&
>> +	    payload =3D=3D &mok_trusted_keys->payload)
>> +		/* Allow the mok keyring to be added to the builtin */
>> +		return 0;
>> +
>=20
> Unless you're changing the meaning of the restriction, then a new
> restriction needs to be defined.  In this case, please don't change the
> meaning of restrict_link_by_builtin_trusted().  Instead define a new
> restriction named restrict_link_by_builtin_and_ca_trusted().


Along with this

>> 	return restrict_link_by_signature(dest_keyring, type, payload,
>> 					  builtin_trusted_keys);
>> }
>> @@ -91,6 +100,15 @@ int restrict_link_by_builtin_and_secondary_trusted(
>> 		/* Allow the builtin keyring to be added to the secondary */
>> 		return 0;
>>=20
>> +	/* If we have a secondary trusted keyring, it may contain a link
>> +	 * through to the mok keyring and the search may follow that link.
>> +	 */
>> +	if (mok_trusted_keys && type =3D=3D &key_type_keyring &&
>> +	    dest_keyring =3D=3D secondary_trusted_keys &&
>> +	    payload =3D=3D &mok_trusted_keys->payload)
>> +		/* Allow the mok keyring to be added to the secondary */
>> +		return 0;
>> +
>=20
> Similarly here, please define a new restriction maybe named
> restrict_link_by_builtin_secondary_and_ca_trusted().   To avoid code
> duplication, the new restriction could be a wrapper around the existing
> function.

and this too.

>=20
>> 	return restrict_link_by_signature(dest_keyring, type, payload,
>> 					  secondary_trusted_keys);
>> }
>> @@ -321,5 +339,8 @@ void __init set_platform_trusted_keys(struct key *ke=
yring)
>> void __init set_mok_trusted_keys(struct key *keyring)
>> {
>> 	mok_trusted_keys =3D keyring;
>> +
>> +	if (key_link(system_trusted_keys, mok_trusted_keys) < 0)
>> +		panic("Can't link (mok) trusted keyrings\n");
>> }
>=20
> From the thread discussion on 00/12:
>=20
> Only the builtin keys should ever be on the builtin keyring.  The
> builtin keyring would need to be linked to the mok keyring.  But in the
> secondary keyring case, the mok keyring would be linked to the
> secondary keyring, similar to how the builtin keyring is linked to the
> secondary keyring.
>=20
>        if (key_link(secondary_trusted_keys, builtin_trusted_keys) < 0)
>                panic("Can't link trusted keyrings\n");


This part is confusing me though.

Here are some of the tests I=E2=80=99m performing with the current series:

Initial setup:
Create and enroll my own key into the MOK.
Sign a kernel, kernel module and IMA key with my new CA key.
Boot with lockdown enabled (to enforce sig validation).

Kernel built with CONFIG_SECONDARY_TRUSTED_KEYRING=3Dy

$ keyctl show %:.secondary_trusted_keys
Keyring
 530463486 ---lswrv      0     0  keyring: .secondary_trusted_keys
 411466727 ---lswrv      0     0   \_ keyring: .builtin_trusted_keys
 979167715 ---lswrv      0     0   |   \_ asymmetric: Build time autogenera=
ted kernel key: 07a56e29cfa1e21379aff2c522efff7d1963202a
 534573591 ---lswrv      0     0   |   \_ asymmetric: Oracle-CA: Oracle cer=
tificate signing key: aeefb4bfde095cacaabff81dd266974b1b4e23b8
 968109018 ---lswrv      0     0   \_ keyring: .mok
 857795115 ---lswrv      0     0       \_ asymmetric: Erics-CA: UEK signing=
 key: 9bfa6860483aa46bd83f7fa1289d9fc35799e93b

With this setup I can:
* load a kernel module signed with my CA key
* run "kexec -ls" with the kernel signed with my CA key
* run "kexec -ls" with a kernel signed by a key in the platform keyring
* load another key into the secondary trusted keyring that is signed by my =
CA key
* load a key into the ima keyring, signed by my CA key

Kernel built without CONFIG_SECONDARY_TRUSTED_KEYRING defined

$ keyctl show %:.builtin_trusted_keys
Keyring
 812785375 ---lswrv      0     0  keyring: .builtin_trusted_keys
 455418681 ---lswrv      0     0   \_ keyring: .mok
 910809006 ---lswrv      0     0   |   \_ asymmetric: Erics-CA: UEK signing=
 key: 9bfa6860483aa46bd83f7fa1289d9fc35799e93b
 115345009 ---lswrv      0     0   \_ asymmetric: Oracle-CA: Oracle certifi=
cate signing key: aeefb4bfde095cacaabff81dd266974b1b4e23b8
 513131506 ---lswrv      0     0   \_ asymmetric: Build time autogenerated =
kernel key: 22353509f203b55b84f15d0aadeddc134b646185

With this setup I can:
* load a kernel module signed with my CA key
* run "kexec -ls" with the kernel signed with my CA key
* run "kexec -ls" with a kernel signed by a key in the platform keyring
* load a key into the ima keyring, signed by my CA key

So why would the linking need to be switched?  Is there a test I=E2=80=99m
missing?  Thanks.

