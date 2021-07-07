Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 386613BF1DC
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Jul 2021 00:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbhGGWOL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Jul 2021 18:14:11 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:16540 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229717AbhGGWOK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Jul 2021 18:14:10 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 167MAt4N016208;
        Wed, 7 Jul 2021 22:10:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2020-01-29;
 bh=BnUTQS1uVRA/CzcfsX1BDb1of4Q4sQsSWC25WI/nWys=;
 b=y2JYPSQoCr7ZgK0Q0UOfS5Up3Gz2+fGqquGpb4i9pKJFe+RBAUEj00Spko4oAW2bchDD
 Jqaly2yGvYZiYCJ0YviJ3MO6f54iJkzZYiLd8lAHbYsOEeMPsxTeHM4LGaJG6xhKZyRS
 YZ/0v6JwyE8XsXNGldTj5lXi6SWw6/uwD2oQefwWWIl9ja+zFfQog7Mh9S0ohBP7SO3F
 C0VFTlDHlPqZ5OfTfjBthTInkTVql+NPEnOpFknAk2PiYcz3sDZkyWPg82ucSccMd5oQ
 fSXBDEJYLbjEv7EOiaVbkcn4YXfoJTj8vOl0I90ZlAL9ggj8i2CWeyXEXYXj1tKK/akB vw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39n7wrsq71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 22:10:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 167MAWcZ154439;
        Wed, 7 Jul 2021 22:10:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by aserp3030.oracle.com with ESMTP id 39nbg2xwvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 22:10:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZvzcXCtc7haErJTezHmTc+n+BnIV5f0wD8dJD5b6SlsVRPw/KkkvsIxKkjG2WUyjmQ5XWgvG9GMlVQx91YvMc9b3fy35Dc2f8xFqw25hajgSOGx61AGau4l8z5HZ9uX+CBKm55UqrJaHMKE9FncUHPnV1Qh1EHE8/XAgKspjn7TUumqt/Nb04hiW6mZMTVgt8ypSbRzPTSfd6he9dCVOrptWpcJ8vPG2xIe1XvSaJc6OgNI3DbXb49ZZAtND7sqf/WHiz4w1grNqCTHNA8lAkCodl4gRcbp/45FGtQQLa5NWAJRxvBw7I5FH7J+rV/3jT4Bx6svYZ5o0G00LkUhkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnUTQS1uVRA/CzcfsX1BDb1of4Q4sQsSWC25WI/nWys=;
 b=Oy8C7DlA6Q7C6qfxEAlvcv+5C0zdmzRzDcsTyghhUJknD+EKtzBoQ8+IbWgS+FxT14UANUjB6I6FLcRYQOGylmaZr3OGTsIeDDTHBFpxOd75rPVrIYk8lIIsUG7evi+GEedlKNo289LwkF/Vrq2QDl2fU8guic8ZdsLtur4HnmLBrQYWwuKiImj0NJM1Bpolk2FqU3BMbwwsKNesri464bEpgdkdj8j/SXIDAs5t7PMM/KvXJtf4x6uhUJVVmSJxLU+jZSmLgEVtTqcYOK3jXVlbQ8mdJ4IxarApEgqjStw2P5FBNKcBduB9xfXfMcSKzc1xQWXLec0Ih2IzwulVOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnUTQS1uVRA/CzcfsX1BDb1of4Q4sQsSWC25WI/nWys=;
 b=KsG3NSNvLEStpPhI2VoV3EcT851kg0mlRYQc/3fHU1CP2/PfZC7Fjli0CgkoiXcCgdGUHMM6iP0qoLJji2SNw3Nn9kN/fWfc0WMJdVik0nSr3VsFcD9AEeYNHFbLEJpX8lK2Cl9/ho+fjPXd7jnXm7tlao22YejG2S9vQ92xT1Q=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB4039.namprd10.prod.outlook.com (2603:10b6:610:10::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 22:10:49 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197%8]) with mapi id 15.20.4287.027; Wed, 7 Jul 2021
 22:10:49 +0000
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH RFC 00/12] Enroll kernel keys thru MOK
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <886f30dcf7b3d48644289acc3601c2f0207b19b6.camel@linux.ibm.com>
Date:   Wed, 7 Jul 2021 16:10:42 -0600
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
Message-Id: <D34A6328-91CA-4E1E-845C-FAC9B424819B@oracle.com>
References: <20210707024403.1083977-1-eric.snowberg@oracle.com>
 <42b787dd3a20fe37c4de60daf75db06e409cfb6d.camel@linux.ibm.com>
 <5BFB3C52-36D4-47A5-B1B8-977717C555A0@oracle.com>
 <886f30dcf7b3d48644289acc3601c2f0207b19b6.camel@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
X-Mailer: Apple Mail (2.3273)
X-ClientProxiedBy: SN6PR01CA0035.prod.exchangelabs.com (2603:10b6:805:b6::48)
 To CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.177.128] (184.60.195.210) by SN6PR01CA0035.prod.exchangelabs.com (2603:10b6:805:b6::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Wed, 7 Jul 2021 22:10:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c957c86c-595a-4d42-2fba-08d9419413c8
X-MS-TrafficTypeDiagnostic: CH2PR10MB4039:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB4039C8DCC3D82AC21F70D2A8871A9@CH2PR10MB4039.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: px9B8ID4lpx8JldtwAoOlCJfuAl7FD6FgxHshHPMmGpo77TlZB7Fr2Ol/5CgROh8amqbwNYTDfS3w/ACS7ppRgpKDtEFK3d3A55RM/2a0CUm578Sqke0C31WIU4kCz8Zromi/f2BxeETxNNBScdrU4nsmcMcuv0+JFs/gJJpjao/LdxT7LbO5kFUWt/aHEey+YgbLo0IxuJemEN0TBdoRg9GJRd/KkG+qgJOvQoSDWCpOr0xYpHabmcldP2apr95Jx+cF4n1e48VV+5JUZTfC7NdrZu3WXI8Hd8FgJS49S0tRTaC89+bsJQ13XlEVAOWcVRtYVFoGLaWnuvMqZC7aFHX34px7CtpCD1pVvCMObelrlX5MXsrFL0/5gLLdy+ZJjId4IOLq9kUdwH7TbGzPMjieUHWh17QqDRwXZpa60ZSnhbe97DdHph9yeT1jXMEyEMTxuNqW6aJiB6oh4SStJ9ZjPg5PeLLl6gihLlaRk/BWBPga0S1cRTR54brzAvzqy2I/wN9j+16XLp+lBzPOEUlWKC9VatQA9ad7eLkuTO2J8VrJaNf2IADRVGJpVxpZSXKuA9T//qtYJdkqjBdc1DnSRBkKaCchZaScHz/wvYzlNP/7D1GdeAdLXwRMXjpQR9xrOYtqOLSBd99znellMG5CzuzA2aKulwQtCrh6ufx46mGKHNhER1y3r/eSVLhSezQJ6LbI+Kvg9uYJo/JJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39860400002)(346002)(376002)(366004)(66476007)(107886003)(6666004)(53546011)(36756003)(38100700002)(83380400001)(2906002)(8936002)(66946007)(44832011)(33656002)(956004)(6916009)(8676002)(2616005)(316002)(52116002)(38350700002)(26005)(6486002)(16576012)(186003)(54906003)(7416002)(4326008)(86362001)(5660300002)(66556008)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXliRkhqZkJGQm95WjF5eUQ0UWUvMmYwQkozMXdVSi82WXhiSTIwdkc2M1B3?=
 =?utf-8?B?UTl5dGZpTW9QUzlsakFvMFlyTnlHTkhISVpjTWRJeFlYb1JLekJ6VUFPMTda?=
 =?utf-8?B?R1hrZUxSeEJ4cFRCWndQNmEzYnRvZFlaelVjZUtoZm9yTG4raDJrMmZ6WXF0?=
 =?utf-8?B?MVpQbG5ab2FudFppeHc4RmhlRFhTL1o2bExOazM1OTRieXZGZmVVN3BGNW8v?=
 =?utf-8?B?VXdCMG9XT0FTamltUXA2ZVZjSW5nWkVSOExmS1VIMTRXcVg3RzZZTEtDZk50?=
 =?utf-8?B?NklFMG1PUWU5ZjhXbUZqREpQS2VlSVFFVHk0NTJVK1RMdnoxQzc1eXNvUFRt?=
 =?utf-8?B?Q2NGL1N0dXBPQVZwY3NqZUszeUZuNTBWZWlFajN3enlRZCtGU052M2MvZi9s?=
 =?utf-8?B?UGVTdFdINU1rblVKaEs3THI3a2F1bGJGRTZ1bEVEdWRzS3Q5QkdHYVhyTVRO?=
 =?utf-8?B?QzVHSG5CWSthMTM1MTE1Zm5kU2dDME9nRGFXS1I4eUVCcSt5a0k5d3JFU0g2?=
 =?utf-8?B?UmtWWHR1NjNLRUxnRVdzRkJWdUxWSU5ORnJtM1hCMlJ6MGxWajE3Q0h0SjND?=
 =?utf-8?B?VEpHQmptMjBkRjlSUUNaOTJUVlpHRGlaaEQ3SFZGSUVzTjdWcnlDdTlSaVRQ?=
 =?utf-8?B?MEtvTjdCWFJOa3hxbGxNWFgxaFBRemQ5dS9DUzdNamNTdG5TVkpQR2l2Rklx?=
 =?utf-8?B?YjV1UlhabzRzYlhWczh5YzVVQ2ZYZ2JvS2VyaE11c1hiVUVHZzVicjlBWGRx?=
 =?utf-8?B?OGlZU0F3R3NGc25zbjlNOUV1aGFYc2l5NzkzQ0J3eFlhLytRMEFVc3k5K3Uw?=
 =?utf-8?B?dWZPazVLR1lZR2FSMDFtZlZjZzkzK1IrRnBGNUYzWk9aQ3dpc0t6aWRhd0lr?=
 =?utf-8?B?aFZZVDkvdG9pUVBXLytEQjh2dWhZVk56NnRQbjhLbTNQSURURjFFUUNWZ2c2?=
 =?utf-8?B?SVExMXJVaUZFQ3lJTG5pOCtZd3BOOVRySUpOa3NwMXVwL05Kc0Y3bzZkSU9w?=
 =?utf-8?B?aHVPRERXTzJlc3Z5THA4blRWeUpPSzB6Q3UwSGU0MUtkVWFHSDVoMW1DZ2ZL?=
 =?utf-8?B?emZlMk93d2ZnUytOVzNFaUpnSlZHTUhoQzY2cVJYQ1cycDBpY0tlZkhMbHBH?=
 =?utf-8?B?eGVVdkVjUlJEQXBGeE9KUGsvZDFGUVhGWVdqZW82S08vL0M2WEFVazBzeXBs?=
 =?utf-8?B?NFRhUTU0dm40SWxFVENYL2lnMkRqcUVoajhPSmpUeXB4QXdtQ2ozazRqT3RJ?=
 =?utf-8?B?eWdGcGJjMjlnQ2E0UXI0a0xBakZTTTRmWHFGMzY3L0RKc2RqcW1tTkltbENq?=
 =?utf-8?B?aVQyYS9RMi9lMURjcjI4QU9lNmRoZUVvN2pmc2dGV0lDWDZYUmtKMUIvRkRD?=
 =?utf-8?B?dTgvcUZiZGZua3dma2JzOUpHdWZGTDNPTmtSZkJXVk9FckN2WUwyWnFOQXBY?=
 =?utf-8?B?dkIrKzJ6MGZKUUNlUmxSb1JwMWNlT3BnSW5XcEZ2cHN0OHd6QkhwWXNoOGYw?=
 =?utf-8?B?NFR2d3RweWpubHRzV2JwTVBRbis1WWpkaXpoSDVhd0Jkc2xFSGluWXZ5LzB1?=
 =?utf-8?B?dCtwamsxVytuU0hOeXE0WEpUZnI5SE8rU1YxT2s5bGx6TURQT3Rvbmsvczh3?=
 =?utf-8?B?NTc1MUJwSnh5ZmpBamF1L2UvTTVXR3VpNjlrL1VVMHBQSEt4RWJnU0w4RE1k?=
 =?utf-8?B?WWdBMkJwMkh0cHBWdnJkQ3hZWXFPb1FkZ2VkMjhwZlFacERONFhVNFMwYU1n?=
 =?utf-8?Q?M+vBYLeJJ7KC5PSHyOmMEfR429CHLQ8Y4CdZbEU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c957c86c-595a-4d42-2fba-08d9419413c8
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 22:10:49.4090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2nuXLasvdNq1d2yJ/HH9+t/c4PmG0PkTHPH73SuJP0K6vfEgS6LvxJdij/lkA85RPTs/WXb1qP0ZKDA9WZpqBntURQv6MSJq2sKaLPbCQS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4039
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10037 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107070127
X-Proofpoint-ORIG-GUID: MiQmzThDSqTUTMeblCtFSV019gR_19rA
X-Proofpoint-GUID: MiQmzThDSqTUTMeblCtFSV019gR_19rA
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Jul 7, 2021, at 11:00 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>=20
> On Wed, 2021-07-07 at 10:28 -0600, Eric Snowberg wrote:
>>> On Jul 7, 2021, at 6:39 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>>>=20
>>> On Tue, 2021-07-06 at 22:43 -0400, Eric Snowberg wrote:
>>>> This is a follow up to the "Add additional MOK vars" [1] series I=20
>>>> previously sent.  This series incorporates the feedback given=20
>>>> both publicly on the mailing list and privately from Mimi. This=20
>>>> series just focuses on getting end-user keys into the kernel trust=20
>>>> boundary.
>>>>=20
>>>> Currently, pre-boot keys are not trusted within the Linux boundary [2]=
.
>>>> Pre-boot keys include UEFI Secure Boot DB keys and MOKList keys. These
>>>> keys are loaded into the platform keyring and can only be used for kex=
ec.
>>>> If an end-user wants to use their own key within the Linux trust
>>>> boundary, they must either compile it into the kernel themselves or us=
e
>>>> the insert-sys-cert script. Both options present a problem. Many
>>>> end-users do not want to compile their own kernels. With the
>>>> insert-sys-cert option, there are missing upstream changes [3].  Also,
>>>> with the insert-sys-cert option, the end-user must re-sign their kerne=
l
>>>> again with their own key, and then insert that key into the MOK db.
>>>> Another problem with insert-sys-cert is that only a single key can be
>>>> inserted into a compressed kernel.
>>>>=20
>>>> Having the ability to insert a key into the Linux trust boundary opens
>>>> up various possibilities.  The end-user can use a pre-built kernel and
>>>> sign their own kernel modules.  It also opens up the ability for an
>>>> end-user to more easily use digital signature based IMA-appraisal.  To
>>>> get a key into the ima keyring, it must be signed by a key within the
>>>> Linux trust boundary.
>>>>=20
>>>> Downstream Linux distros try to have a single signed kernel for each
>>>> architecture.  Each end-user may use this kernel in entirely different
>>>> ways.  Some downstream kernels have chosen to always trust platform ke=
ys
>>>> within the Linux trust boundary for kernel module signing.  These
>>>> kernels have no way of using digital signature base IMA appraisal.=20
>>>>=20
>>>> This series adds a new MOK variable to shim.  This variable allows the
>>>> end-user to decide if they want to trust keys enrolled in the MOK with=
in
>>>> the Linux trust boundary.  By default, nothing changes; MOK keys are
>>>> not trusted within the Linux kernel.  They are only trusted after the=
=20
>>>> end-user makes the decision themselves.  The end-user would set this
>>>> through mokutil using a new --trust-mok option [4]. This would work
>>>> similar to how the kernel uses MOK variable to enable/disable signatur=
e
>>>> validation as well as use/ignore the db.
>>>>=20
>>>> When shim boots, it mirrors the new MokTML Boot Services variable to a=
 new
>>>> MokListTrustedRT Runtime Services variable and extends PCR14.=20
>>>> MokListTrustedRT is written without EFI_VARIABLE_NON_VOLATILE set,
>>>> preventing an end-user from setting it after booting and doing a kexec=
.
>>>>=20
>>>> When the kernel boots, if MokListTrustedRT is set and
>>>> EFI_VARIABLE_NON_VOLATILE is not set, the MokListRT is loaded into the
>>>> secondary trusted keyring instead of the platform keyring. Mimi has
>>>> suggested that only CA keys or keys that can be vouched for by other
>>>> kernel keys be loaded. All other certs will load into the platform
>>>> keyring instead.
>>>=20
>>> Loading MOK CA keys onto the "secondary" keyring would need to be an
>>> exception.   Once CA keys are loaded onto the "secondary" keyring,  any
>>> certificates signed by those CA keys may be loaded normally, without
>>> needing an exception, onto the "secondary" keyring.  The kernel MAY
>>> load those keys onto the "secondary" keyring, but really doesn't need
>>> to be involved.
>>>=20
>>> Loading ALL of the MOK db keys onto either the "secondary" or
>>> "platform" keyrings makes the code a lot more complicated.  Is it
>>> really necessary?
>>=20
>> Today all keys are loaded into the platform keyring. For kexec_file_load=
,=20
>> the platform and secondary keys are trusted the same.  If this series we=
re=20
>> not to load them all into either keyring, it would be a kexec_file_load=
=20
>> regression, since keys that previously loaded into the platform keyring=
=20
>> could be missing. The complexity arises from the CA key restriction. =20
>> If that requirement was removed, this series would be much smaller.
>=20
> To prevent the regression, allow the the existing firmware/UEFI keys to
> continue to be loaded on the platform keyring, as it is currently being
> done.  The new code would load just the MOK db CA keys onto the
> secondary keyring, based on the new UEFI variable.  This is the only
> code that would require a
> "restrict_link_by_builtin_and_secondary_trusted" exemption.  The code
> duplication would be minimal in comparison to the complexity being
> introduced.

This series was written with the following three requirements in mind:

1. Only CA keys that were originally bound for the platform keyring=20
can enter the secondary keyring.

2. No key in the UEFI Secure Boot DB, CA or not, may enter the=20
secondary keyring, only MOKList keys may be trusted.

3. A new MOK variable is added to signify the user wants to trust=20
MOKList keys.

Given these requirements, I started down the path I think you are=20
suggesting.  However I found it to be more complex.  If we load all=20
keys into the platform keyring first and later try to load only CA keys,=20
we don=E2=80=99t have a way of knowing where the platform key came from. =20
Platform keys can originate from the UEFI Secure Boot DB or the MOKList.=20
This would violate the second requirement. This caused me to need to=20
create a new keyring handler. [PATCH RFC 10/12] integrity: add new=20
keyring handler. =20

To satisfy the first requirement a new restriction is required.  This=20
is contained in [PATCH RFC 03/12] KEYS: CA link restriction.

To satisfy the third requirement, we must read the new MOK var.  This=20
is contained in [PATCH RFC 06/12] integrity: Trust mok keys if=20
MokListTrustedRT found.

The patches above make up a majority of the new code. =20

The remaining code of creating a new .mok keyring was done with code=20
reuse in mind. Many of the required functions necessary to add this=20
capability is already contained in integrity_ functions.  If the=20
operation was done directly on the secondary keyring, similar code=20
would need to be added to certs/system_keyring.c. Just like how the=20
platform keyring is created within integrity code, the mok keyring=20
is created in the same fashion.  When the platform keyring has=20
completed initialization and loaded all its keys, the keyring is set=20
into system_keyring code using set_platform_trusted_keys.  Instead of=20
setting the mok keyring, I=E2=80=99m moving the keys directly into the seco=
ndary=20
keyring, while bypassing the current restriction placed on this keyring.
Basically I'm trying to follow the same design pattern.=20

If requirements #1, #2 or both (#1 and #2) could be dropped, most of=20
this series would not be necessary.

