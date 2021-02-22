Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B311321E57
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Feb 2021 18:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbhBVRml (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Feb 2021 12:42:41 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:57710 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbhBVRmi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Feb 2021 12:42:38 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MHVBDv189995;
        Mon, 22 Feb 2021 17:41:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2020-01-29;
 bh=tgZgzefRhC+4CvKoLZc454CwBmOFmlLryME3AixTMS8=;
 b=hw2AVjM6yjmSzSjYjVlKQdSAxSlRyecwc96ZYqg/ex0HrkFMLgXsFwcO+h758SgsbTe5
 K4HIYbFmHYV8PWVSpwTL2YKOUgA3XvKer4+Exy2tgQM3As4ZHqgh0IP28zsQRA28j/mr
 t52AT8twziAYNS1blVwCnW6pjjy/5NuD7wRL/4pXUOep5C5KTdoC+eTmxJf0/R5v68hd
 8lCFduXZ0V8ntUhRToGuopqgcoOj77ZIR71tgDi4ATUyGlm46bv0M/9KGDuFl+kULS6/
 PsX66yVMVbAImpaTh0X2kDt6rIFG78eiBQqnsauc186Cv9SfsDMR8p9b023JRT0YCFMm JA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 36ugq3bcqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 17:41:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11MHUQSH034639;
        Mon, 22 Feb 2021 17:41:14 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by userp3030.oracle.com with ESMTP id 36ucbwdek4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 17:41:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jbt3b74KO8TD2A1oDBsAqNNXw881aHf1T9IFDObdkB10rgF6/s1cmV3MIVGhBthY2n1xa3VIC6tOwH+FPLBczsOZaucUQkzU6Z5ZvbDLNF8KR12407UxeGQ0Cz8AThz1/KE1/b2bkK/2Is5Yb3QxdRrTjS0eRBUC4plUxH/z5JKjuckYnjrS9o7m5wVAX0O5vClqLBCPr+4Fbm/bKxjQVvIYHt5fPSb57xzBqcT4PJggnbsMZnQx59nIaM5fe/O5CpxvXQ6BjH5Rk++Dg0qX5+S2Ceb4n2tIsodNpsKbaKKBtb3TwqSeSBnKyKcr6oGDZtEwrhaKFQj7C5kk8tlnhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgZgzefRhC+4CvKoLZc454CwBmOFmlLryME3AixTMS8=;
 b=h2jyCyT0RoYlyaoF1D4wJD2DdDelNW3NIsBLYPT/EWtXzbGmjVdDZCPSsR4a3hXp/hvSQiefY1a95YqFIjFxg9Iw814yq/7LCNAQ5+Q4NhjKuY3KVz5ge3gzMf3rRe0mtdhcmoFyYp8N9XtbfxmgxKugbdRhP06R17Jd7UUgG+nv6kj3iLmRSRjnPUkYEhnHfOx6qsgZVhVeP61APm2RpUvHYfadAbwk2yA0gd6KDiA4IFFzCCzELeDyaZ0d7Xm9t61TJDK4acVP5aolXwOpw7mFpzKeqsp+NZvHXHQO1tiLsk53uhs8qY7lG7B5bWB3nznXKr3D7MOXIgh+NfuLZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgZgzefRhC+4CvKoLZc454CwBmOFmlLryME3AixTMS8=;
 b=XgCUv2ae78vkic42PT5Y919Bic1aGSzyP6x4n8YS+UDUQJLogAckQX5gkO8NMZJsvduHnWc8zb26zWW5bij/9gYW9T4c5ZSh3FTPFiY20w/PlJS8ohHA6OZ7AXMLzBQUsvC8aCKqSAhnEnGc4zbMQy7Lkhf5ylqrMR5RzN9dsJ0=
Authentication-Results: digikod.net; dkim=none (message not signed)
 header.d=none;digikod.net; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB4389.namprd10.prod.outlook.com (2603:10b6:610:a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Mon, 22 Feb
 2021 17:41:11 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::95df:950e:af4c:a5df]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::95df:950e:af4c:a5df%9]) with mapi id 15.20.3868.032; Mon, 22 Feb 2021
 17:41:11 +0000
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v6 0/5] Enable root to update the blacklist keyring
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <132a6049-e91b-3922-cd3f-89574dd049fe@digikod.net>
Date:   Mon, 22 Feb 2021 10:41:04 -0700
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
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Eric Snowberg <eric.snowberg@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E00A6ADE-5634-4E75-8892-FF99AD77EA39@oracle.com>
References: <20210210120410.471693-1-mic@digikod.net>
 <132a6049-e91b-3922-cd3f-89574dd049fe@digikod.net>
To:     =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
X-Mailer: Apple Mail (2.3273)
X-Originating-IP: [24.52.35.144]
X-ClientProxiedBy: SJ0PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::35) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.177.128] (24.52.35.144) by SJ0PR05CA0030.namprd05.prod.outlook.com (2603:10b6:a03:33b::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.12 via Frontend Transport; Mon, 22 Feb 2021 17:41:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32b87e72-5001-40e1-b319-08d8d7590ae1
X-MS-TrafficTypeDiagnostic: CH2PR10MB4389:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB4389ECFB2A8B3AE3633B29D887819@CH2PR10MB4389.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4yEBgweGLdLJV5bcYkkeAq7A0nLcwMLpJB13/D/NtVYJKiCvSOvn26QgNtLQ64pcq9IpW6YlH/zGJ8VKsu97eSMa8S5djxNnBffD050qapqjJRceiovL25jFVAf3n+xupHetxeYG87k7yZuqwIxZQlGec7wODWL0FddxKaYtAulgEDmjj+Tal+Upv2F7Oy08QZY95vGFGUjNgFmxu73eUl6BptxfhyWGMU6RfOZbP2MAfB9kpY6+WHvd2El4sVl2NFCrgRfEhXYKtpqw2gZ2fWPMhGEGpLWwPJAbcZfICzmY8HFSrMxnvsm7F/UIkd8Te9rYzEo35dhGWPIyVFveIInDoY/j82mSe5v2CnZwxOZAR19ZJ4ucBAFbw4cYk5UZoRIWmkragRvj6XwcTjTT4zCxOINb1moBMvKpd2y+BFL64w4OONKK0saAmBCsvZvlsx9AVUCKtj4yhBp0q++uJ/pEBAkwDSghD8MZt9cPz/am/uGzyi1njNMdDoK7osMB3wS23coOOuI60JAWGzzacO4Wc+oSeDyPYPGr9gpi7rN3yOQcvvXVOv8WKxso++x80Ca5ubiSEweVhMphDblT1sKmLxjhUWCHwxCzlOMjF4X36b4dciR7rpmTkef1NuR+VteI8fBqGkzAxCGBv4AJC+ZP/Jlb+5p+vrHgTGqnhrc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(366004)(136003)(39860400002)(83380400001)(107886003)(66556008)(66574015)(36756003)(6666004)(33656002)(6486002)(316002)(16576012)(8936002)(478600001)(8676002)(966005)(956004)(52116002)(186003)(54906003)(26005)(53546011)(66946007)(5660300002)(16526019)(2906002)(6916009)(66476007)(4326008)(2616005)(15650500001)(44832011)(7416002)(86362001)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NHY1SkN2Vk1lMlJaalhmQXF2TjQ2R1JnMjg5cXMzZzBLU3JkUmNFL3g3bnlR?=
 =?utf-8?B?ZlFvczc2NG5sa0FMUmpNYmN5RWV4TFdjSC9UNjBmOWhMWkQvS1JHTWRlQ2JY?=
 =?utf-8?B?alZCa3A2TmxETUlQb2VXWFVrd1BNVTJ3M3NMODJaK1NGUFhreFJvdDVzbFp2?=
 =?utf-8?B?NkFNUFNQcmhOdWdSSGt1V210b3E4dkVsaDRDWGIvaTBtSW9SeVdJaHh4TmV1?=
 =?utf-8?B?VW1ZeTBZbVBLeDVacnZ1NmVKOFltendFbkxpWjR3alZUelpld204d1JSbVRD?=
 =?utf-8?B?Qk5KVUlNd3lPRU8rM3dZWkppUVhvNWtFdXhudXJVMUhlaitxakxwZHpnTlZq?=
 =?utf-8?B?V0ZVckpFcU1peVJHNE5uUy8vNlhLTVFCWFRPbFBmV1VNT0JwN1F0VjN0WXdm?=
 =?utf-8?B?Z0s5SHRwSzBhMkwxaEtBZ0NoWEJJa1lqdkNOcnBPUVhKNEJVOHhyV3pIbGNy?=
 =?utf-8?B?QXp4ZzE4UEJ3SzM0QnRlSHNna1FYK2J3eTh3Wnl6YU1aQURGL2VRaDJkeHRK?=
 =?utf-8?B?NjJxS05GTnZJRTZwMHpMSzdmZU11Mjg0TU1iSHJTZTYxVVVnQ0tsdUJuS0dj?=
 =?utf-8?B?WDVPV3RER1Bwd3R5RVNTMUIxNkVGSTJvMmtvNCt6SnJOdnpFeXZDMTk3ZEs1?=
 =?utf-8?B?OS9yRXdITWF0QU0rQjhURDk3UUFjcEM5S2JIR1BzSDFEZG01UlgzSktiRG8z?=
 =?utf-8?B?VHplR2c1NTdVK3puVDFSVjVtU3FUMUJkc3ZWa05pNUtIYWk1Y1F4QjBwUW5W?=
 =?utf-8?B?dVdBMy9TTEVQOVFsVmlBVFdCOTlUQ2ZOTUlUMTN4ODkrKzlUYUFEWXJSR1l0?=
 =?utf-8?B?WTR4OEt1L1d2WXpGNkcvNDk4UUlxZ212NHVIdXBZend5dXl2cHNMVlVGaWw5?=
 =?utf-8?B?YXV0TnR6YVRtekR2VXVhMUJsL20wbU9uWm1KeitneTVUaDE0STZoUDlNVVFE?=
 =?utf-8?B?ekFzWTNNUkJZMGVtQ0tJT041dkRpaWppUUpRL0w5M1U1THIxRXE5cHlNQ2lL?=
 =?utf-8?B?dVFTNG9iU2Q3Wi9tUjRGbE1DUDJxaHJ1dG9zWWNuU2lqL1RQY2hrN3k1N21T?=
 =?utf-8?B?QmEwb3NTK1p1RTRmY0VrbjRYQ1JhS3FZazZXOUIyR3RqTHNjU0E3UXNIeVZM?=
 =?utf-8?B?d3pNYW40Y0cwS0hDUU44SU9IdHBGZ3FsYUpRMHg0V0RxQWo5eXJLemFxcmlw?=
 =?utf-8?B?MWE0S292QkNVNDRxa0xXdzRiRHFOUEpURmpBL3dydVhYa1lEMktHZFpuZ3dW?=
 =?utf-8?B?dWJFMFV5ZndHOXBXY0Y3aWJJZ1VpcTNyckFOYXROdnN2YjE5NTkvMTNseVA2?=
 =?utf-8?B?bDZ4OTBEdjlwb3RVQjVVOVl1UWtmcXhTdmdnc3JqeGlXenVQV3dpZ2ZVZ1BO?=
 =?utf-8?B?QXhYNzEzbnVNRyt2ZWNzdFNMN1FMV0RSTCtpeUVaeU1qRWNZYU9Tc3V5bExv?=
 =?utf-8?B?c3Zvb3AyZytnanN0TDdYYlpMVklwV1diSHZwR2dDbVVYQjNGdkhyOVYxUlBu?=
 =?utf-8?B?YWdld2xUcTcrSWFHd2RLVG9zcXpRLzYzM0hqbm1uWCt4NnNGeS9vMGV5dkNX?=
 =?utf-8?B?SHFqV3N5WitkQmpMSlFFUThoc3FDdWpkY3VGa1pTbDJ4YklvNTZoRTdIS0s3?=
 =?utf-8?B?VXJIMnBkc3M5SzlEOE5rYXFHeFhBMG9zdG5Ob0oyc2lrckEvSjF6bGpWSGh6?=
 =?utf-8?B?eGQzTmZPSUtVNkFudVFjQU5zRDFPek0yVE9uSURQYmVHUlUwMEh5VkE0RWJC?=
 =?utf-8?Q?WcWbQgrHRjq9I/5GOekHMHw2canjw3Wx8E2pCPx?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b87e72-5001-40e1-b319-08d8d7590ae1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2021 17:41:11.1552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6TnTP0u0gNhJa/YVwlM2yEUTNTjS0clVCO3p2RbkikvviJXjedLVXYEhpfHyfiZ3YuBpBXDmnk5WZp357B/ejXlnhvkW7eaCtbPhStUYRDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4389
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220157
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 clxscore=1011 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220157
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Feb 21, 2021, at 4:17 AM, Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> w=
rote:
>=20
> David, Eric, what is the status of this patch series?

All the previous issues I had identified have been resolved, so LGTM.

> On 10/02/2021 13:04, Micka=C3=ABl Sala=C3=BCn wrote:
>> This new patch series is a rebase on David Howells's keys-misc branch.
>> This mainly fixes UEFI DBX and the new Eric Snowberg's feature to import
>> asymmetric keys to the blacklist keyring.
>> I successfully tested this patch series with the 186 entries from
>> https://uefi.org/sites/default/files/resources/dbxupdate_x64.bin (184
>> binary hashes and 2 certificates).
>>=20
>> The goal of these patches is to add a new configuration option to enable=
 the
>> root user to load signed keys in the blacklist keyring.  This keyring is=
 useful
>> to "untrust" certificates or files.  Enabling to safely update this keyr=
ing
>> without recompiling the kernel makes it more usable.
>>=20
>> This can be applied on top of David Howells's keys-next branch:
>> https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/lo=
g/?h=3Dkeys-next
>> Git commits can be found in https://github.com/l0kod/linux branch
>> dyn-auth-blacklist-v6 commit fcf976b74ffcd4551683e6b70dbf5fb102cf9906 .
>>=20
>> Previous patch series:
>> https://lore.kernel.org/lkml/20210128191705.3568820-1-mic@digikod.net/
>>=20
>> Regards,
>>=20
>> Micka=C3=ABl Sala=C3=BCn (5):
>>  tools/certs: Add print-cert-tbs-hash.sh
>>  certs: Check that builtin blacklist hashes are valid
>>  certs: Make blacklist_vet_description() more strict
>>  certs: Factor out the blacklist hash creation
>>  certs: Allow root user to append signed hashes to the blacklist
>>    keyring
>>=20
>> MAINTAINERS                                   |   2 +
>> certs/.gitignore                              |   1 +
>> certs/Kconfig                                 |  17 +-
>> certs/Makefile                                |  17 +-
>> certs/blacklist.c                             | 218 ++++++++++++++----
>> crypto/asymmetric_keys/x509_public_key.c      |   3 +-
>> include/keys/system_keyring.h                 |  14 +-
>> scripts/check-blacklist-hashes.awk            |  37 +++
>> .../platform_certs/keyring_handler.c          |  26 +--
>> tools/certs/print-cert-tbs-hash.sh            |  91 ++++++++
>> 10 files changed, 346 insertions(+), 80 deletions(-)
>> create mode 100755 scripts/check-blacklist-hashes.awk
>> create mode 100755 tools/certs/print-cert-tbs-hash.sh
>>=20
>>=20
>> base-commit: 5bcd72358a7d7794ade0452ed12919b8c4d6ffc7
>>=20

