Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51FBF403E2C
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Sep 2021 19:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352374AbhIHRLp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Sep 2021 13:11:45 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:28712 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229689AbhIHRLp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Sep 2021 13:11:45 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 188GxQ4X018357;
        Wed, 8 Sep 2021 17:09:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2021-07-09;
 bh=hMrVIasxZQpa2ea4PPS2lV21un6mPe1hwX6xA61zj3M=;
 b=ewdQjP7hogqRWcBM13S9+k3kIhd4K3xYvlE/YKocDyQ4e7aWFJMB0xOWks7Tj46S7Od5
 vej2Qt952Ufl2Ew1rZPmL79IzuqyBonm/tmzyT7h+BjcF5jzLQf2Se/k/LP7NWZ+v4Yw
 kzwo6uFBE7+FEYw65JMDhzHqVSlu+hR8d95fWGqlvol4pUQgSsDGTXp17EJRXEjIvW36
 7oyY2PmfTIWBepGLkGYAukGHqTgj5fV4oU16Ud+Z+f1Zro8PPXFfSTBFzvdtduj16zXJ
 aW6w0ckPxz8OWOneqe9VSl8qRuYz2mFdbi7QFJpeWUk5zyNNQE/3mpUfsL4XhDtxzbG2 yA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2020-01-29;
 bh=hMrVIasxZQpa2ea4PPS2lV21un6mPe1hwX6xA61zj3M=;
 b=ty1LrZIZJTpG2uUXgJC/F936mDFvs+0jRzy3P5cV7gV198jsW1Ri1tYNmgVvGk9DAg1x
 TxCHcDiVdJoxHh3pVCCBfmy0dUvxr/e1MegtEju96YukcFdE5H986c9CfVShglw6tO7J
 gkZFxMp0Im5/aCCW9P4gRe0ZqtXD3VdE1Lsgd7Pyl0gsK2OZmPO930yV1XAUqnC/IHiT
 3BrZFECSEcG/Y9gGrCdI/Vg1VbaYri6v3tUkvTjT9NS6RYkKCHiTpJUpql6hnaIt8mR2
 eZon6PiVPIg5Gns3XgdvEPKto6sBQn+8nRTgJDGSvJPO7srIrKpj8annztA0JDIi9/T4 Dw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axd8q3g6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 17:09:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 188H0EfJ024409;
        Wed, 8 Sep 2021 17:09:57 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by aserp3030.oracle.com with ESMTP id 3axcpp1sc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 17:09:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbR4Fq+/Fuoztj8R7Fs/63zC+7npLEORPuRv1+5vXa+whaEGka5CMQCiXTf0KSD+vXERO042j1O91Dv0SyEuqsIrVkYdwUACfX8gdJtAF0DLOArL5eeciGBV471gG3GIsMFejDcnj3pOD8oadBWuf8bxOIInkXYvEhunsrNxLxrlw8iZ1IEufiduhQlCWXZhS9QUstrxvoMU/sOTZ8rsbBtDvoFuWePRKK2HdUf7SBfItaDyeylXEzae5ZKyQPb9Xd4UiZ+SJ+L8aEdV7l5KxjZnXBheJ0iU2uUNmNMMr0JKUfaJJ4otQ+VZ2GG47G72ech4WA5PWSaIPc6Gw+dq0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=hMrVIasxZQpa2ea4PPS2lV21un6mPe1hwX6xA61zj3M=;
 b=GxWXqHbyj6hOsOQaV5WtdXQMpIi6UKTXTaiVhITULI1LcOvdGJrcPWM6MBs+B9cGVOkM7+WcI8jRBpkdWN7wDYKy1U6r1oEEypkz0sPc/Fe+TryBYGgeDvUyU1DaSDcx/88l4CImIWQsKHKl4KMXtD3JFa32lXnzPLkUwwgCeTJHEWtjwjQYaTQvr1VmUmHCQelNU/BGE+alVVrMsgBp89eM4YcTHIxMNeaizSGulGTljb1UrbjmKaxv20C5ihoOgoVHha77B1083a+dbcWtBgZf3g/hpTDfGY48fdpwAN4yStw9oyGn+81Ffo4am4PRYYFgs/cpwxUmyMt3mhfLuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMrVIasxZQpa2ea4PPS2lV21un6mPe1hwX6xA61zj3M=;
 b=RFxySebl4N63ly8MylMO6hFT+0nuSb7YvOBMc0gL2FBsig/14m6Z7mjasXdBMXLxFa4Gx9liCdnHTC3YaAM4nsUc9ZQe6P7hgcktTwjBp6oMc84PHHn3QkyUW2V6MMRFlOvR+O7su0pV9kw5QqpcvJivbJbS7TpCdNd393Ru8u4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3749.namprd10.prod.outlook.com (2603:10b6:610:3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Wed, 8 Sep
 2021 17:09:55 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7%8]) with mapi id 15.20.4500.016; Wed, 8 Sep 2021
 17:09:55 +0000
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v5 00/12] Enroll kernel keys thru MOK
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <7f9fb65a4ee20c337646a1fc887cd24365c2c59e.camel@kernel.org>
Date:   Wed, 8 Sep 2021 11:09:44 -0600
Cc:     keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, keescook@chromium.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        scott.branden@broadcom.com, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <17C81066-DBE8-4DB0-B66B-822BF6EFF67C@oracle.com>
References: <20210907160110.2699645-1-eric.snowberg@oracle.com>
 <7f9fb65a4ee20c337646a1fc887cd24365c2c59e.camel@kernel.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
X-Mailer: Apple Mail (2.3273)
X-ClientProxiedBy: BY3PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::28) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from [IPv6:2606:b400:2001:93:8000::53] (2606:b400:8024:1010::17c6) by BY3PR03CA0023.namprd03.prod.outlook.com (2603:10b6:a03:39a::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 17:09:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28da17ac-a38f-42ad-a24d-08d972eb7a79
X-MS-TrafficTypeDiagnostic: CH2PR10MB3749:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB37499841C70C8E9EF7DB6B9187D49@CH2PR10MB3749.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CNXwcZVb8cW39vwoSGubrvrK17oNiaMjC3bBgdnFX48Sz0BESwC5txka8Gif2a8yV8aBiGmzocqg0mgxCFJwcyEqxzxEg0G6pVzlgBhLFkZJF80c+/ZczYYpVSZhrWESgIrrqi6HchVm9oxIecZ9mb6L7iVIvIB6Rdlw22+1YjQxyFJ86aAVwPz4AnW5vp4mxpLraPdnvq9qZuYyhS5pgC+rzny/TumYnV412fYRDac8fXySqSb9592r+kHW9DbjK709bXTwlPGYVz33bBN4E1EJe5+pSnU3vu3ENjMRY1uPFn/Dppo21eBE0sFsx/p1rMKxZBw/i23yRg0tuO1+qeZsZv76A2kx8/+YDb8s1ETEkb8ZanpLkPUKRwxEIU4P9Is9TGsELklVZKvXnX09OFs2/4uDLwPtbIIUBRwTRPXmnmDx1TF91T+tvSHE5UE6lGrWSVX8QGQHyt7ojZiKUDe8CgkPIF0UFIp9LVkyB9Tumo7C5uM4zjkj/Of8Vmc01OgDmVGzbA2N+/tXlac6uzUkX1u2rYPkDsd4O+z5Vlv+ilQtY26HEJIiVEUoLyWQiAGewqMZpm3tCJOFy4ygtqbqbJHV9znRLvKg27uGGK6RCZDk8exJ+28H8lVoA5FIlkKJzFNLyLQnkoFwDbt6YucUVi0GBXW2gV1c72aol3dW3QgOzgtlxaf7S1mUl/94gVrZs9c9Sd0yWyvpIxm5Cg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(66556008)(6916009)(53546011)(66946007)(6666004)(38100700002)(8676002)(4326008)(54906003)(86362001)(316002)(44832011)(36756003)(2906002)(8936002)(107886003)(33656002)(5660300002)(2616005)(508600001)(83380400001)(7416002)(186003)(6486002)(52116002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MCsrNVdRYllsbHZPbnFybjIxWkF4bUQrWlJkeHZRMmh0Y05QbnNXNHJTK3Y5?=
 =?utf-8?B?NndIWkxZV1QyZ3EybzFTdkxhU3Q1MlRsUEhvSlN5Zzl3empoejN4ZVBxNTB1?=
 =?utf-8?B?d3JtKzVmaTBQM01yYy8vdTAwTStBRk9UekppTXhNd003UU0rYnh3MEFEY0l2?=
 =?utf-8?B?VjQ2c1EwcUo0elkwK1UrMXFSN2FwMjhuS1ZFNmhteHRnSjQ3dnlHam1XeGhz?=
 =?utf-8?B?cXh0VFNFTmRUcFNXVXkzUURnNE5vcDNPYWpxYU1CQ3BZcDVaanN3VVNHcXZN?=
 =?utf-8?B?UlVyVnhCZEZVZjBCaW1uMmVib09aNG1yU0lERjJlTC9IUUhoNEJiQjRERXJr?=
 =?utf-8?B?bENwaGNXQ0hOeHYrbmlUL00yWXNJODgwRnJaTUJlTmRSUytVLzhBT0p2U1VU?=
 =?utf-8?B?OEVjbi9ScGFrRklTNnpPYzk5anh1K2ZiSjhRQ1Eyc3BSNFpxQzhJc3UzSnUy?=
 =?utf-8?B?QTNCaWREZkcrdWJKRDVYK3VtdS9ydkNTTnpCb1NZQk1IT2xKRXF3YTEwVGpm?=
 =?utf-8?B?YUVJdXh1bFB1WXlWbkxyRHJSS1U3Y0E2Ty9wNkJpUHk0c2I5OHc3djlwKy8y?=
 =?utf-8?B?OExFYVd4NnhaaGI5RnRLSFkvOG1iOXVOeUVRTHFwZ0NKMWg5WHErRUJRNjRO?=
 =?utf-8?B?QnQ3aFNZRmlpeGJ1QWpVWmFNU1hhWmVIaEszeFhUOEt0M2RpOVFibVpuSmNY?=
 =?utf-8?B?d04ybUtmbmZ2VTRla3dFTzViWVJsS0NYUzJId2NHcjFFSEVreTdsSHNIQkdq?=
 =?utf-8?B?TGJFVS94RVZIbXFMclNhMnNXbGpTQnIyRFl6REIwYWVEZ1J5VUhDN1plZEox?=
 =?utf-8?B?dUIyV0RreUk0emNQOHJjTURjYUxPYVJYeEg5eEtqUkhLRHhrMlJoRkNWUFpx?=
 =?utf-8?B?NXpMR2RtSHhyVFVJNU92d0FJTTdnZDN0cmpHQnlZWHdzTnNscTRoZjM4SkNa?=
 =?utf-8?B?bzBvNTMyOXZOeDl1UTVabXJYNzVqL2xteEFSTnkremordm4zSVpIZm9TMnBq?=
 =?utf-8?B?WldCUm1Sb1JNUW15RmFhczlZeHZvbVFiV0RoR2JLaHJtdDBCcUtxMDFkd09M?=
 =?utf-8?B?RUNkVmYvNkZCSnU0Y3ZvWlBDV2R1dExubjYwalhCUUZDUGJ5UkJHQ1dTdVBx?=
 =?utf-8?B?Rm9ZbEcrMnQwYXEyczd4NFp5a1pWcXVWK0k0NGVaNW9EQm1ZTkJBT2hTbkUz?=
 =?utf-8?B?NEwxUUJ0T1JjVVc5QkZ4NUVQTytvdEhPSlpVSXkwRXZRWUVyemhrWExoWlJi?=
 =?utf-8?B?dnJRUmxqTkZISEdZWEFBMmdPM3pBd05iZWxZbVRnL2FhU2V5OE5VTDQyVE5y?=
 =?utf-8?B?b2JheU1YVlZpK2hMRkFGajBMb0JiVkVOY3Rva2dISUQvbE9NNlVGNGkzbVc4?=
 =?utf-8?B?ZHdCbFd0bUd6U2dHY1dYOHVsL1dMK0dTRTkyUDl0RVNwRTM1Y2svV28zajBo?=
 =?utf-8?B?OEh2aHdUZVBPUW9pMVUyYXdzZG1KMVV1YjdoNGZXeG5mMUMvRGNJRU1jNUZl?=
 =?utf-8?B?MTlYa2FzZWdwYzIvTnZNU1JhbFdrOVVRMEVIOHVCTFk4ZEcveW1yc0dqTHpx?=
 =?utf-8?B?Tlpyb0srdXVPTGcyMWgzNGp1TXkzbnlDT2FrTEZzeitOVDZQMy8zZys4blVS?=
 =?utf-8?B?c0t2TTIwaDJ5bHRNb0d4K0RDdnhXYnZId2VCQ3o2YzF2T0Fob0RHU0wveUF3?=
 =?utf-8?B?ZnJWWXN3WXRNMWttUnpPRmhyaGVZNDYvRUIyeGl5VGJ1UkwzUzltQ2NzYzk0?=
 =?utf-8?B?VjgxYytHMmxwN3BaMzNEdE9iWENUZHdDVENScFIxQU54WndSS3VNZlBLSDRi?=
 =?utf-8?B?ZTI2MDNIY0NRMERRWkdnZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28da17ac-a38f-42ad-a24d-08d972eb7a79
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 17:09:54.9688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sv8nxLbUShaf0UBsTe3xnNy9qbOV8DRPnZbvIK02M+PwJPBFjYLm61X+znCMbsspMM7urBNMuAuvKqNaLPy7uqsFammx3EidefzkfEfln+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3749
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10101 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109080107
X-Proofpoint-GUID: wU9IFKYLqzqURTPYIGot3iMQyeMRO983
X-Proofpoint-ORIG-GUID: wU9IFKYLqzqURTPYIGot3iMQyeMRO983
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Sep 8, 2021, at 10:03 AM, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>=20
> On Tue, 2021-09-07 at 12:00 -0400, Eric Snowberg wrote:
>> Many UEFI Linux distributions boot using shim.  The UEFI shim provides
>> what is called Machine Owner Keys (MOK).  Shim uses both the UEFI Secure
>> Boot DB and MOK keys to validate the next step in the boot chain.  The
>> MOK facility can be used to import user generated keys.  These keys can
>> be used to sign an end-user development kernel build.  When Linux boots,
>> pre-boot keys (both UEFI Secure Boot DB and MOK keys) get loaded in the
>> Linux .platform keyring. =20
>>=20
>> Currently, pre-boot keys are not trusted within the Linux trust boundary
>> [1]. These platform keys can only be used for kexec. If an end-user
>=20
> What exactly is "trust boundary"? And what do you mean when you say that
> Linux "trusts" something? AFAIK, software does not have feelings. Please,
> just speak about exact things.

I am using terminology used previously by others when addressing this issue=
. =20
If I should be using different terminology, please advise. The kernel does =
not=20
trust pre-boot keys within it, meaning these pre-boot keys can not be used =
to=20
validate items within the kernel. This is the =E2=80=9Ctrust boundary=E2=80=
=9D. Preboot keys are
on one side of the boundary, compiled-in keys are on the other.  MOK keys a=
re=20
pre-boot keys.  Currently they can not be used to validate things within th=
e=20
kernel itself (kernel modules, IMA keys, etc).


