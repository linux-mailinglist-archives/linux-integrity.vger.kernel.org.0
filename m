Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226C1389913
	for <lists+linux-integrity@lfdr.de>; Thu, 20 May 2021 00:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhESWGx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 May 2021 18:06:53 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:50338 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229455AbhESWGx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 May 2021 18:06:53 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14JM2OrL020340;
        Wed, 19 May 2021 22:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2020-01-29;
 bh=FKHLdLhbWXuFLVxEhHVD15ZDFpb7y5boG65aR0G1UBQ=;
 b=nczvtCNnD49XHPPohNTdzKeONgjAUq/MSFIr7WN2Js2U+3EWmVyl2VtEwNAHMEju4DVT
 0aUedtIOmBRL9gTfUn34vCRz07gywqcRCuIwX+xONRGtNMRpIuGcNk3u+VXEWOE8F86O
 mGlje8+ymLLCk9r3ba0nkD2DyHbECNEq05aPt1UijcsXDddm21Wp6gDR1jV995XwtMsB
 dH4S8usInfq/SX0ARV6/mKn1vYx/7E7HB5dh28AEyafo/0r6DAE8iO75IL+J3XbUjkTd
 MwB5GqLu5Xu1tAEGYKa2/Mg+GNMGjIF7oB33QEaTqPRZlKXBNBA6uZvpPeZQc5LFwf+k pQ== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 38n4ukr608-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 22:05:07 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14JM56DB037041;
        Wed, 19 May 2021 22:05:06 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by userp3020.oracle.com with ESMTP id 38n4914mpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 May 2021 22:05:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKmdq8GGkZlm5BBVH3u2dlMhsGOUfG7ZA3rQDwGBhnpK/XrYhy+iZ0b1ojgV/Wn3cCc6dYFQ0lEF6CoY1xI+qxBhsj6XHRNBwzrgzyqJWzCn9ZdSy3Wb5LZYrO2/z0whvvQkw5HCYQcL8u8lDFVoMstrd4eVNBkxCO2x4W3/OOj7dDFyaWqBxKm+a5L9M1tVv41ynfpAdVu0RW5sd5UDSr3Msu2vAQ5iUI7JRfhcj+/GjHeszSVaVhZCD52ubEhxtLZV9iLRUTqJO+A2FnijGKvRLQc0SPtDLITTt5KVC+nCwU9JyeqgojXNIDdCU24/ghyzHJ8S97xO0UrZDrcGaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKHLdLhbWXuFLVxEhHVD15ZDFpb7y5boG65aR0G1UBQ=;
 b=NeBigvsfogTBTgSiMFAhmPjhQKBlCJSZGxHVBYkDj0OUpdRxIrP1vWu2i2ryipxmM9X/G5RtM5ghRxFbNtQvo0/1y5N4wh0YiLhnZKRmmEbeyYvkHpURbPeAsRilooRBFSRMRmcbMx0cLUlomxDYtO9eYaSr+XPv4JPL9lJSgxFC2o9jVsae/TWB7snUKsQPnPlbLHPW2SbYwYrOGZX4cpmMSh21OSSYR3P8zLzIcnXhdbqtzM1e1aOLuc5KGYaw61nbCjxXaPEKr71SiKJZa+80onN6M+1mR9K39RdbVXd6FWcwzfekZHWf/hkBd+qR7D+5s0SHzoZAYcmuBVnwjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKHLdLhbWXuFLVxEhHVD15ZDFpb7y5boG65aR0G1UBQ=;
 b=duGF7JRysxc0THppjBt/DjcHb1qDUzR7yy04RlGW9SXdYZ4r0hmkaS7dVN8MF6h77XbzXanuKNcIj1isr/Fgboe0PHHbUoDEHickw7ojzGGX3RDwIcfASMKcv1xDeCuaJsPPjXSWx9g9N2qdjwPjTbCX+ZBLWR7veCXJbR1tNSk=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5100.namprd10.prod.outlook.com (2603:10b6:610:df::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Wed, 19 May
 2021 22:05:03 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::99fc:aabb:5cff:b177]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::99fc:aabb:5cff:b177%3]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 22:05:03 +0000
Content-Type: text/plain; charset=utf-8
Subject: Re: [RFC PATCH 0/3] Add additional MOK vars
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <fdb42621e7145ce81a34840cbcf0914874c78913.camel@linux.ibm.com>
Date:   Wed, 19 May 2021 16:04:58 -0600
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        dmitry.kasatkin@gmail.com, James Morris <jmorris@namei.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        torvalds@linux-foundation.org,
        "Serge E . Hallyn" <serge@hallyn.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        pjones@redhat.com, glin@suse.com,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        Eric Snowberg <eric.snowberg@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7F861393-7971-43AB-A741-223B8A50FFA0@oracle.com>
References: <20210517225714.498032-1-eric.snowberg@oracle.com>
 <fdb42621e7145ce81a34840cbcf0914874c78913.camel@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>
X-Mailer: Apple Mail (2.3273)
X-Originating-IP: [24.52.35.144]
X-ClientProxiedBy: SA0PR11CA0207.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::32) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.177.128] (24.52.35.144) by SA0PR11CA0207.namprd11.prod.outlook.com (2603:10b6:806:1bc::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.33 via Frontend Transport; Wed, 19 May 2021 22:05:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51fafae3-851b-48a5-0be7-08d91b12277d
X-MS-TrafficTypeDiagnostic: CH0PR10MB5100:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB5100BA466A8F6D44F56B7D6F872B9@CH0PR10MB5100.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qu9PNniE0HV716F+VKpQFSVG4InhZaufwG+fF5j2SMB/AxuNranQPEL6WAiYlQ5Vvbfk+kgmFhIKIoSei5LlGMUD+m0r8UfKw8HPZ+qD94786P5mAZaHitq0k94guAq2D91zVbEHYrsUC+fG9vW7YUCR1YPBwQJvjUtXpXv4KB4YwAne697eRFSpTSHr/1bV+itJaxxO5WBc2ZMjGR7h4C1XFkEVpthWSGKnwmFGtTRdaOv2zAWADkZFN1FGuEMszV2u6VIIJxN/7Rxn5UUH6k4fmvYh1kPLXkz/0to0mvmdR28IZfVGtvWc7ep54ZcWAdw+9rn4HQUmm2SVwPP0POMfSf7VvAk9exYePoSacFUCzYgrepSjmeStK+g9EkGm3n82U4MO45jwRMMERfAtQS5wYk/SjNdjHmdcJ1XN2t8e5/6FzHHVhq31YfcNzHnct1MAV+PLUlI8P93qq49KWQxIdbtEHByPC+qLajyY7ZaoAvEvTyWLp6uiAwyxSdl2cry+12zszyR2TJ+Pw4Z89aY8ZS4Z+N04qLs7r9k0gEpXdyhf/AiMqLutbKJn8HpKiA0s0pmWMCkz9SF6OTNuZOgEpx4mU4az4AFrphPIdw/RRATd2CajG5JLSqIkbMSKVSbsfs37aoZV1/ANldmfkJf50zkj6N9X86TfUuAR9g1kO+VOQViPZZ8uNMI/BYxdIp52EdM6iGMpzMUzHqs1r8NvL7Y3Kyy9ePBRXQB5bkpCBMY1LE5HbZ7R4mvfvIS9hgEiNFP/Z8zdstBTk6X5ZB4Lm2dBoFP1zzJ8J7XiRUY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(396003)(39860400002)(346002)(376002)(8936002)(4326008)(8676002)(316002)(6486002)(83380400001)(52116002)(54906003)(110136005)(16576012)(53546011)(26005)(107886003)(186003)(16526019)(2906002)(66946007)(66476007)(66556008)(6666004)(33656002)(44832011)(86362001)(36756003)(2616005)(966005)(38100700002)(5660300002)(38350700002)(478600001)(956004)(7416002)(45980500001)(6606295002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YUl2N2tvVGdnQXA5T0thb1J0NmE2TVhVRWNDeVc2cHhKTFh1aStqSjV2eXl1?=
 =?utf-8?B?OC81WG1MMnI5MHVhSWROR1hEeU9oMDRZaHJrZ1VUMHJxVCtHbFpLb3QrMk9S?=
 =?utf-8?B?YlhwSGRaMGg1eUQvcHFNeFZQdjJpS2kvYWlkc3BFcVNMcE1oOWIybGxtcnlq?=
 =?utf-8?B?YVNvdnlmY3pTcURzbXBGemFsYVFWejQ3RVhNRmRTVlJwNkVCNkVRRzMyOFNl?=
 =?utf-8?B?V3h6cEk4RG5sMkpmRHZHMml3eFZab1lqQTF0VTZVYi8wQkNUcjB1UHU1YUt4?=
 =?utf-8?B?T1FrS0dBYVNzYml5S01EL1hTWjVPNHNQKzhYVHpKV21SN0MrZXR3ZmRJRk1q?=
 =?utf-8?B?WjRiQlZRVytBQ0YrY1pubmZjNEZBYlEyV092Z2RZeGxPQTR0a2RLd1F3Z2lR?=
 =?utf-8?B?TXVYK0t0RW5tcGJNR3o3Y29HUGxvQVFUV1dhZUxPUzBza1EzNzlvVUFSekdw?=
 =?utf-8?B?dFFGc050T1BrY0pDRjkwd3VnVkg0VjRvSGhWZEZoelkrb3BBNVFZdlVhK2RU?=
 =?utf-8?B?ZnlCczU4WU42RlQ2WFFuVlZQK2VkcUszYzBrUVVHYzQ4enhQVGFRbUtGanFi?=
 =?utf-8?B?dlBpUjZibmNvZ3RzQm5JUTlQNXFMUHF3clNxWEZscVNVbWVYbUcwRG1SanRp?=
 =?utf-8?B?L095WnE3NnBTNTNLOXFYV2NqTFFFREQ5S05VQzdYSG54OHh0dWNhbXo4VFVo?=
 =?utf-8?B?RlhoU01XWjRvaHZCUVNoV3JVY2hOT1hLVlJrQlkzS0RHNDlaR0JFWGZWam1O?=
 =?utf-8?B?LzhMcEtMR3J4RW5DbUExK3duQzUzcGs4K01kTFpWdGkxOXh0ZjRoWU9MWTlL?=
 =?utf-8?B?TW94am5WdUxFRjJrVVBIZWcxajlJUFBjeHN1YUlSekN6cDJONHJLVXIvNmM1?=
 =?utf-8?B?eW4yZ2ZhZjVKanJ5enQ0YUdNcG51elU1L3J5UTR3aHI5VHU0VDM1YjZWbWhC?=
 =?utf-8?B?TXcxbVR1TFhOMHZTQlRzVzhWekQvajE2K3MwMXY3TkNIdjVNUUVtT3I2Wi9Z?=
 =?utf-8?B?YmZWU0pkMUNkSUtpVXpoUnFCTjVtTjhJWTdtU2tXdlF1c3pSc1E5NDhaNmRv?=
 =?utf-8?B?TUV2bC9HaE54c045YlFHeHYwMGVxV0tnT1V5SXJDN1BxaDR4NTI1M2JHaTlx?=
 =?utf-8?B?VW4vRVhhWHpMOW5IQ2hndFVRendtT1ZRNTlaZUl1bHcwTGl6RXN1MHJUMk5H?=
 =?utf-8?B?SVlhcFllOTAwVUZnTlM1TTVtekZMeGsxTElsT1JSRkh3RDJtMlZNMlRIV2lx?=
 =?utf-8?B?bmZUY0dRdHhpRmt1Z1pZc3F1c0NraEhuc08xcFhseVZJWnk4WlppMnZrOU5Q?=
 =?utf-8?B?TnVGejUwUThEazgzQ3BtTC9PdkNWMktBV0hKSEVZYkdDeFhESGpSbTNqcVpr?=
 =?utf-8?B?bmFhWWEzZXZ4U0JuS3poZ0pKU3VEZHhBazVQbW1lOUhTRi9NdStvVVJOQ0k4?=
 =?utf-8?B?UUpvUDdVNDFkVzJYcEhQUm5ZUDZKM3lUTjBuenFhUFRUaVhsN0pJRTRuUnFU?=
 =?utf-8?B?NlVoTUNiMmtIeERHb204N1BuanpIYUswdVRPNDNQU0dHamxadkk4Q2QzeW5U?=
 =?utf-8?B?VVZVQUdXV0N0aVVxYnlhSFZPM2JMb0J5ZmlBeTRuZmd3RVZ4TUJpWjllMXRw?=
 =?utf-8?B?dlpTK1UzWmM2eUI2MVEwSnlJblNpTzZ6TXFSblZVcy9uVHNNZWVSVzkySG9D?=
 =?utf-8?B?c0EwZUxKQU5VK1ozZUFqWmprY1lXa3dLU08wMnBKS2hzMXZQYkJDSnMwZndj?=
 =?utf-8?Q?q/wUNc6HwOD5MHOXjUDg93Fwx39p3w4yTaDamyH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51fafae3-851b-48a5-0be7-08d91b12277d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 22:05:03.7325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wDtKDDkeHYeSABRqpM4gWU6VIelX+NH7Uyzs4OT2wAfSgghQ/PuqEPs/5k04e/Qwx82MEv1VMBqjQNkSvtIHiNDAFMg/pkNmPMwPd9cmHDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5100
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9989 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105190133
X-Proofpoint-GUID: Nf55dCkNMYxnzCfS2kC9b8gCC85MIb0l
X-Proofpoint-ORIG-GUID: Nf55dCkNMYxnzCfS2kC9b8gCC85MIb0l
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On May 19, 2021, at 8:32 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>=20
> On Mon, 2021-05-17 at 18:57 -0400, Eric Snowberg wrote:
>> This series is being sent as an RFC. I am looking for feedback; if
>> adding additional MOK variables would be an acceptable solution to help
>> downstream Linux distros solve some of the problems we are facing?
>>=20
>> Currently, pre-boot keys are not trusted within the Linux boundary [1].
>> Pre-boot keys include UEFI Secure Boot DB keys and MOKList keys. These
>> keys are loaded into the platform keyring and can only be used for kexec=
.
>> If an end-user wants to use their own key within the Linux trust
>> boundary, they must either compile it into the kernel themselves or use
>> the insert-sys-cert script. Both options present a problem. Many
>> end-users do not want to compile their own kernels. With the
>> insert-sys-cert option, there are missing upstream changes [2].  Also,
>> with the insert-sys-cert option, the end-user must re-sign their kernel
>> again with their own key, and then insert that key into the MOK db.
>> Another problem with insert-sys-cert is that only a single key can be
>> inserted into a compressed kernel.
>>=20
>> Having the ability to insert a key into the Linux trust boundary opens
>> up various possibilities.  The end-user can use a pre-built kernel and
>> sign their own kernel modules.  It also opens up the ability for an
>> end-user to more easily use digital signature based IMA-appraisal.  To
>> get a key into the ima keyring, it must be signed by a key within the
>> Linux trust boundary.
>>=20
>> Downstream Linux distros try to have a single signed kernel for each
>> architecture.  Each end-user may use this kernel in entirely different
>> ways.  Some downstream kernels have chosen to always trust platform keys
>> within the Linux trust boundary.  In addition, most downstream kernels
>> do not have an easy way for an end-user to use digital signature based
>> IMA-appraisal.
>>=20
>> This series adds two new MOK variables to shim. The first variable
>> allows the end-user to decide if they want to trust keys contained
>> within the platform keyring within the Linux trust boundary. By default,
>> nothing changes; platform keys are not trusted within the Linux kernel.
>> They are only trusted after the end-user makes the decision themself.
>> The end-user would set this through mokutil using a new --trust-platform
>> option [3]. This would work similar to how the kernel uses MOK variables
>> to enable/disable signature validation as well as use/ignore the db.
>>=20
>> The second MOK variable allows a downstream Linux distro to make
>> better use of the IMA architecture specific Secure Boot policy.  This
>> IMA policy is enabled whenever Secure Boot is enabled.  By default, this=
=20
>> new MOK variable is not defined.  This causes the IMA architecture=20
>> specific Secure Boot policy to be disabled.  Since this changes the=20
>> current behavior, it is placed behind a new Kconfig option.  Kernels
>> built with IMA_UEFI_ARCH_POLICY enabled would  allow the end-user
>> to enable this through mokutil using a new --ima-sb-enable option [3].
>> This gives the downstream Linux distro the capability to offer the
>> IMA architecture specific Secure Boot policy option, while giving
>> the end-user the ability to decide if they want to use it.
>>=20
>> I have included links to both the mokutil [3] and shim [4] changes I
>> made to support this new functionality.
>>=20
>> Thank you and looking forward to hearing your reviews.
>=20
> This patch set addresses two very different issues - allowing keys on
> the platform keyring to be trusted for things other than verifying the
> kexec kernel image signature, overwriting the arch specific IMA secure
> boot policy rules.  The only common denominator is basing those
> decisions on UEFI variables, which has been previously suggested and
> rejected.  The threat model hasn't changed.

Could you point me please to the previous discussion on the threat model
this change would violate?  What I found was [1], which I have tried to
solve with this series.  Having the ability to update a MOK variable=20
indicates the user is not only root, but also the machine owner.  MOK=20
variable updates require both root access to update and then physical=20
presence to set via shim after reboot. This patch set tries to address=20
the "*second* order" Linus requested [2].

> The desire for allowing a single local CA key to be loaded onto a
> trusted keyring is understandable.  A local CA key can be used to sign
> certificates, allowing them to be loaded onto the IMA keyring.  What is
> the need for multiple keys?

We have no control over how many keys an end-user may wish to enroll. =20
They might want to enroll a CA for IMA and a different key for their=20
kernel modules. This is a generic kernel that can serve many different=20
purposes. Think distro kernels - like Fedora, Ubuntu, Oracle Linux, etc.

> Making an exception for using a UEFI key for anything other than
> verifying the kexec kernel image, can not be based solely on UEFI
> variables, but should require some form of kernel
> agreement/confirmation. =20

Isn=E2=80=99t that the case today with how MOK variables get set through
mokutil and shim?=20

> If/when a safe mechanism for identifying a
> single local CA key is defined, the certificate should be loaded
> directly onto the secondary keyring, not linked to the platform
> keyring.
> The system owner can enable/disable secure boot.  Disabling the arch
> secure boot IMA policy rules is not needed.  However, another mechanism
> for enabling them would be acceptable.

For a distro kernel, disabling the arch secure boot IMA policy rules is=20
needed.  Distributions build a single kernel that can be used in many=20
different ways. If we wanted to add a built-in IMA policy for an extra=20
level of security protection, this allows the end-user to opt-in when=20
secure boot is enabled. They are then protected before init is called.=20
Not every user will want this protection; a different user may just want=20
secure boot enabled without the IMA level protection.

After going through the mailing list history related to IMA appraisal,=20
is this feature strictly geared towards a custom kernel used for a=20
specific purpose?  Do you view it as not being a feature suitable for=20
a generic distribution kernel to offer?=20


[1] https://lore.kernel.org/lkml/1556221605.24945.3.camel@HansenPartnership=
.com/
[2] https://marc.info/?l=3Dlinux-kernel&m=3D136185386310140&w=3D2


