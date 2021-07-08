Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F333C18D1
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Jul 2021 20:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhGHSDb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Jul 2021 14:03:31 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:33526 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229580AbhGHSDb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Jul 2021 14:03:31 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 168HqUwR018681;
        Thu, 8 Jul 2021 17:59:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2020-01-29;
 bh=UadNw7rJyK30QxW+PsWBQ0jqqCIKfsfBZ5hEjzPqBH4=;
 b=J0pbkwnJ5DRyNl0AVKL76RYhXl8/kX0Mp+4eBz7QAjnIyi7eOT0IjgtUydqKgSJ0KiSv
 myZcF3CZcfvDBdF+XXHjPA7OFmRNgm18CIRr74nHP/hjr+eOOWenwtd9MAjv0ZrlFvaW
 gIQ+huCoVxa4Vy7A6Eh+v0TP0zoqyBID8jOR04kQLRyuIEoOFYfgJqz67yLVhWZFK+3x
 GFfMwOtCr2NOth7ZwJ8RjRkg1ZzKZVB1EqurUw2TwmqU7TpVyoIjQUsRbv9uf94+n00h
 FWHeyTKpWvs/oJul5LJGb/F9hrWHuzgjwaqa6Zr6aK4+UXKC8vqeOuFXasCzX7BAzGPq Pw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39n4yd3r6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jul 2021 17:59:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 168Hub9R073913;
        Thu, 8 Jul 2021 17:59:56 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by userp3020.oracle.com with ESMTP id 39k1p1024m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jul 2021 17:59:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LyG40AaszNifIuiHrN+WwWPJ/ecrJ8P/jQyJZBC+Zc7mI5nTyPTnIHNfIC3J+vtDarE8ycpRk0m95g06tQrGFZIcuwVQSZLKbyyObskcQxLEhHEn1YCHErZQXPpEs/7qqiMvFUC866IOECwyRObqr8TgOMyH1kD5mHeIanX8LpkMXezazTh0TMNrmmqn8zFScHutFEIDxsbyhFlTzXrdrUfLcBzJ5gzUMS8kxx7Tj5/EQuXBJxMvhUledSUrb777NAh+gc6AhbpCHNnQ8mhKoL1nklpUbb2bkJMwLDdkUF+DsV61A+inBuavuWcQ9xNj9Unp659rdySD8OX94GPZpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UadNw7rJyK30QxW+PsWBQ0jqqCIKfsfBZ5hEjzPqBH4=;
 b=Z/D+32qzcNAK9AWmJ+hAV3d6lbamOl7U2Psh/9cLMcjyaNqEpJtT69GXJuquZVUs9545p8q5TJvf7vtv390c433Ok/nPGcecWziG54ZFijMboUwhHTZJ7CH3Vw4ZKt8nJnMyJxV8JRFIST79t3kuTK32H803vNtNZKLsQVgX5/HUhCWvU6Atzbz8iiG+uNDd8dxycR0YLC9qBHdg4wV/H8vFM05rFp5BTxr/spOZI4XV2tW1w+WsAXBJOpgQpzXl0Tmn0MlJK/zCvxCU0PSZEhzbie7VpI236vKaO3+BvddX8pVXa8XiaefKG2fitwn9uhPETj2qvp6uCzZ7BXIuPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UadNw7rJyK30QxW+PsWBQ0jqqCIKfsfBZ5hEjzPqBH4=;
 b=Ao6zEen9YVWJ+2xVjAcUzKI40728ZHBZpi8nedq95jK3SCD8nERXaj3W3EwRQDepasdx2THc0WNqC9lq6FVhi2DSD2X8xAwLFxLr3sp5B/PJ0Hvas/EwiV4otNQzGV4SYmS7Z/quZg3eDF2TJAp6Y4kaeDFZbIbyCydZzCkWiNQ=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3944.namprd10.prod.outlook.com (2603:10b6:610:f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Thu, 8 Jul
 2021 17:59:53 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197%8]) with mapi id 15.20.4287.027; Thu, 8 Jul 2021
 17:59:53 +0000
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH RFC 00/12] Enroll kernel keys thru MOK
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <c0cf7f883a9252c17427f1f992e4973e78481304.camel@linux.ibm.com>
Date:   Thu, 8 Jul 2021 11:59:45 -0600
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
Message-Id: <21EFCB58-2D89-4D30-8DA2-B952A7E1B1BD@oracle.com>
References: <20210707024403.1083977-1-eric.snowberg@oracle.com>
 <42b787dd3a20fe37c4de60daf75db06e409cfb6d.camel@linux.ibm.com>
 <5BFB3C52-36D4-47A5-B1B8-977717C555A0@oracle.com>
 <886f30dcf7b3d48644289acc3601c2f0207b19b6.camel@linux.ibm.com>
 <D34A6328-91CA-4E1E-845C-FAC9B424819B@oracle.com>
 <c0cf7f883a9252c17427f1f992e4973e78481304.camel@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
X-Mailer: Apple Mail (2.3273)
X-ClientProxiedBy: BYAPR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::32) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.177.128] (184.60.195.210) by BYAPR02CA0019.namprd02.prod.outlook.com (2603:10b6:a02:ee::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Thu, 8 Jul 2021 17:59:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 063b2f31-574f-45f5-d264-08d9423a2ff5
X-MS-TrafficTypeDiagnostic: CH2PR10MB3944:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB3944EF795CBBD19DC278FB1287199@CH2PR10MB3944.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xb6HxJEqjJRg0P7AiakVLKRNdaaqPw9cmB+vbbOPtfVlJl08jqvkjdMSs54OqQ8h1Ehm8nAlbnvPvdc5xatvRGsY8kSOruY74zSnc5e40SeBdQb3HBfhykYiNjZSolw51xegCrGErvAm7x6X2U8oSoGSWJdcVAe2rYJt2c3hz1Pa7KWi8tZwA4atGcvt/cm0yzv36BNM8cM2g2Bx+rjAFCGfHGorMGzKZH/Re81FJvfWZ1aoF6fZbe2jcrwvlxPIC5nrwvgl9hvCvKuBAkKfJBqduNAKARStVbVLQrTyP3lLABJTu9trZdVeLUzTJxSpkbzgwUH3mIyuszXbtDjPQmtAplgAMcbgWL2gcCYW6IwuRNz4GfPDL82WBNa1a8ZClrwAz6S/yhWYZNu4xOjjWhz84eeahJQTihBQOQykSLMU2Ytj6BI97VBflJa0VxVH9zwMLjjnBJvlb/fWxRCJUovC9JzYfwD1zg+AkBd7Wz/mBIdNls7h4GOdiGKqATVCIzkVJs61hjiuyrjlnTEan3YEhEFntofRq3USdMGDogI1blbOF5CwteuaANZe0yyTjrzjTekDKdrPmZ/BwScgj2idhGs90vOb/vaRDdzPpJ3cKS13XCSyoXVGKACn0H+iylM4VZ5YQFkAMpwjApkyg6qyJY3CCvJt/qRlI+IicJ7tTnsmaQcmgoGuLdb/kM6AE0WIUBIQByZYtaARz7jyMtOjZUNw9VQzRGnTWns0iU4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(136003)(39860400002)(396003)(6486002)(7416002)(86362001)(6916009)(316002)(16576012)(36756003)(52116002)(33656002)(8936002)(8676002)(2616005)(83380400001)(44832011)(956004)(107886003)(54906003)(66946007)(26005)(186003)(478600001)(5660300002)(66476007)(66556008)(4326008)(6666004)(2906002)(53546011)(38100700002)(38350700002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjNyektzdjRZSjZaTVhZelNXekd0dmNncDJsOGRndC9kdXhOYkZud2xaTG9m?=
 =?utf-8?B?RWNaWXl2M2xwV0l4MUJlQVo3ZWtQYTBpZU11Y1lIZ2E1Y1psdCtLcUtPbjFE?=
 =?utf-8?B?K25QS0J0aGI1aVZnaDRkd01DaTBjMHNpK2JLemxEbThvbmNkMzAyYUdQZGE1?=
 =?utf-8?B?UVlKTUd2Mng5UWRnSjVBVG5SMk5qb29kY2ZlUDdkMGloNllQUDhDYkVDNzVy?=
 =?utf-8?B?RU5RWm1oNWg5dVJ1KzAreFhlS0RybVY4czdKMzVDR1FqcVlEam1PVnY1WFFt?=
 =?utf-8?B?N1VKT2tobVpMT1ZTSHJCVWJ1VEt6SkJFUWYrWVFTOHJYb3h0LyswbzhGZmhC?=
 =?utf-8?B?VUp1UGh0QnMwN1VCYW9JWlZiN1lLTDBmYndOVHBIZWhkWDRpNlFIUGR2SGNx?=
 =?utf-8?B?NTlGaUZmS0V0dHViRXhNZVB6U3RTMzJuZmk4UldMMy9hR2x0RVp1bFhBelNa?=
 =?utf-8?B?VEpiTExjZG5OSk1zOVhCWlhVUHFWK3JKcW5KUUlwZFZQN3IrUjVlbVVvMmF1?=
 =?utf-8?B?eldlelZpcmF4b1RCQ21HMXhrMXFIbGhteXJPT2NONjhOMlAyeFlOUEdiVXE2?=
 =?utf-8?B?UUphbW00Z1U1WlV4aVA3dSttZ3IwU0RiU3NqcWlyQWNVRFVtNjgwc0lHN2Fn?=
 =?utf-8?B?RzFiTnNyaEtjMUpmbjFLOGEzdFV1bXZvMEVqcGVoSGsvcjhEbWUvdFhrdHQ1?=
 =?utf-8?B?UkF6bks3aG9oZkg2UFJTdEZUSVBXOS8xWHZBU1VYbW5ZUGRSTFhEN09zL1pn?=
 =?utf-8?B?TnZrcTU4T1ZPeW8vb1RkMzQ2cHg4RVRNVFpWWTdrOU15TWl4RlIxdXFYei9X?=
 =?utf-8?B?UkNhZkVpdWoyN3lDS0hIY1M4dWNXNE5DR1llZy9CbVAraGVRUFQ1dm9IZC9Y?=
 =?utf-8?B?TlhjeC9hS2tCQUpwWEIxYXJkV0w0cVlER3dPTHpOcWdPMFNNRVdFUlo2Qnl4?=
 =?utf-8?B?RVhwd2FMbEFQMzh3M2ZKZHgzS3NYb0ZUSk1GTzU5NXdFL3kxUWFQRHhnaTRu?=
 =?utf-8?B?eFBUZU1UeHYwam15U0lSMXRJbmx5N3YzaWxna0RZKzBoZWM1VGtZSjNDOTJh?=
 =?utf-8?B?ZVp3R0p2MDRBdXZwTTkrbFNmcmFaeVpaOVdUVTFmbGRHTExsbkJML2FBZmE3?=
 =?utf-8?B?QmpRZ2Q2a2tabGZWcVY3N1RIWUhHZEp4MTRucDc1UlBpSkFRTXo0REFQNHJI?=
 =?utf-8?B?ZFF6cGV4eTJFRUFRSjk1bmdKMDlsNk5ZRTYyb0pxYzZEV3JVcCtyWFRVQk5G?=
 =?utf-8?B?Y3lSUXh2d1RDS3BIZmlLdmUxWml4bno0LytaVVBTRWpQTk9ybEdYNkZJZUd4?=
 =?utf-8?B?WHFaQ2YvdWRXSVF5VEpFMTBmZHZkWkNXWU9LYUlnQmJqdUhaOXVHSGR5b1A4?=
 =?utf-8?B?czlKZXh6bk4wMS9XZjNXWmtkMVJYeGZyQkExRnIyVDdhcXNZbndGay9seG4y?=
 =?utf-8?B?YVdPdzNuV2Ivb3RLQzhScXQ2emRvczVNVXRzQ2c4cU1oOGlydndoNURDTVpC?=
 =?utf-8?B?a3ZpTkx6eHgzUXVXS2NzaXVta3Z0eFo1ZGRweGU2dXo0YWhEQjdMakxwU0s0?=
 =?utf-8?B?MjRkOHppU3FiR0NKN3FTZEdtaVJ6ZEU0aWVsbjcrYWJUUjFiR1J5R1lxR0dy?=
 =?utf-8?B?Vjg5WStDa1I1MnRqVklDdjJzQ3BmR3lVaGFmUnluQnRBSGtXNkdRQkFwVGl0?=
 =?utf-8?B?KzJBZDh2aFU2cXdwR1JkdW4zMTRzdlE3VjA4NFVDM2U4RUppVWpWNTVpdERO?=
 =?utf-8?Q?O484SHGr6rhJhG3W1fvai/7MeZe5qKLZ3KFg9rG?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 063b2f31-574f-45f5-d264-08d9423a2ff5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2021 17:59:53.1982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dOig/FUEeXjB3ugcTdjhgxaUMWV3NZKCTKjXha4OY6fh4Ve5kGpJbXrNKsfoKALyaXhyAXWKq9IOkh8CJPveupge2WMOIQs7epC99yQdFh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3944
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10039 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107080094
X-Proofpoint-GUID: 6ESc9fiosqOk1adra_VU3efpFLe0G353
X-Proofpoint-ORIG-GUID: 6ESc9fiosqOk1adra_VU3efpFLe0G353
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Jul 8, 2021, at 7:56 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>=20
> On Wed, 2021-07-07 at 16:10 -0600, Eric Snowberg wrote:
>>> On Jul 7, 2021, at 11:00 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>>>=20
>>> On Wed, 2021-07-07 at 10:28 -0600, Eric Snowberg wrote:
>>>>> On Jul 7, 2021, at 6:39 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>>>>>=20
>>>>> On Tue, 2021-07-06 at 22:43 -0400, Eric Snowberg wrote:
>>>>>> This is a follow up to the "Add additional MOK vars" [1] series I=20
>>>>>> previously sent.  This series incorporates the feedback given=20
>>>>>> both publicly on the mailing list and privately from Mimi. This=20
>>>>>> series just focuses on getting end-user keys into the kernel trust=20
>>>>>> boundary.
>>>>>>=20
>>>>>> Currently, pre-boot keys are not trusted within the Linux boundary [=
2].
>>>>>> Pre-boot keys include UEFI Secure Boot DB keys and MOKList keys. The=
se
>>>>>> keys are loaded into the platform keyring and can only be used for k=
exec.
>>>>>> If an end-user wants to use their own key within the Linux trust
>>>>>> boundary, they must either compile it into the kernel themselves or =
use
>>>>>> the insert-sys-cert script. Both options present a problem. Many
>>>>>> end-users do not want to compile their own kernels. With the
>>>>>> insert-sys-cert option, there are missing upstream changes [3].  Als=
o,
>>>>>> with the insert-sys-cert option, the end-user must re-sign their ker=
nel
>>>>>> again with their own key, and then insert that key into the MOK db.
>>>>>> Another problem with insert-sys-cert is that only a single key can b=
e
>>>>>> inserted into a compressed kernel.
>>>>>>=20
>>>>>> Having the ability to insert a key into the Linux trust boundary ope=
ns
>>>>>> up various possibilities.  The end-user can use a pre-built kernel a=
nd
>>>>>> sign their own kernel modules.  It also opens up the ability for an
>>>>>> end-user to more easily use digital signature based IMA-appraisal.  =
To
>>>>>> get a key into the ima keyring, it must be signed by a key within th=
e
>>>>>> Linux trust boundary.
>>>>>>=20
>>>>>> Downstream Linux distros try to have a single signed kernel for each
>>>>>> architecture.  Each end-user may use this kernel in entirely differe=
nt
>>>>>> ways.  Some downstream kernels have chosen to always trust platform =
keys
>>>>>> within the Linux trust boundary for kernel module signing.  These
>>>>>> kernels have no way of using digital signature base IMA appraisal.=20
>>>>>>=20
>>>>>> This series adds a new MOK variable to shim.  This variable allows t=
he
>>>>>> end-user to decide if they want to trust keys enrolled in the MOK wi=
thin
>>>>>> the Linux trust boundary.  By default, nothing changes; MOK keys are
>>>>>> not trusted within the Linux kernel.  They are only trusted after th=
e=20
>>>>>> end-user makes the decision themselves.  The end-user would set this
>>>>>> through mokutil using a new --trust-mok option [4]. This would work
>>>>>> similar to how the kernel uses MOK variable to enable/disable signat=
ure
>>>>>> validation as well as use/ignore the db.
>>>>>>=20
>>>>>> When shim boots, it mirrors the new MokTML Boot Services variable to=
 a new
>>>>>> MokListTrustedRT Runtime Services variable and extends PCR14.=20
>>>>>> MokListTrustedRT is written without EFI_VARIABLE_NON_VOLATILE set,
>>>>>> preventing an end-user from setting it after booting and doing a kex=
ec.
>>>>>>=20
>>>>>> When the kernel boots, if MokListTrustedRT is set and
>>>>>> EFI_VARIABLE_NON_VOLATILE is not set, the MokListRT is loaded into t=
he
>>>>>> secondary trusted keyring instead of the platform keyring. Mimi has
>>>>>> suggested that only CA keys or keys that can be vouched for by other
>>>>>> kernel keys be loaded. All other certs will load into the platform
>>>>>> keyring instead.
>>>>>=20
>>>>> Loading MOK CA keys onto the "secondary" keyring would need to be an
>>>>> exception.   Once CA keys are loaded onto the "secondary" keyring,  a=
ny
>>>>> certificates signed by those CA keys may be loaded normally, without
>>>>> needing an exception, onto the "secondary" keyring.  The kernel MAY
>>>>> load those keys onto the "secondary" keyring, but really doesn't need
>>>>> to be involved.
>>>>>=20
>>>>> Loading ALL of the MOK db keys onto either the "secondary" or
>>>>> "platform" keyrings makes the code a lot more complicated.  Is it
>>>>> really necessary?
>>>>=20
>>>> Today all keys are loaded into the platform keyring. For kexec_file_lo=
ad,=20
>>>> the platform and secondary keys are trusted the same.  If this series =
were=20
>>>> not to load them all into either keyring, it would be a kexec_file_loa=
d=20
>>>> regression, since keys that previously loaded into the platform keyrin=
g=20
>>>> could be missing. The complexity arises from the CA key restriction. =
=20
>>>> If that requirement was removed, this series would be much smaller.
>>>=20
>>> To prevent the regression, allow the the existing firmware/UEFI keys to
>>> continue to be loaded on the platform keyring, as it is currently being
>>> done.  The new code would load just the MOK db CA keys onto the
>>> secondary keyring, based on the new UEFI variable.  This is the only
>>> code that would require a
>>> "restrict_link_by_builtin_and_secondary_trusted" exemption.  The code
>>> duplication would be minimal in comparison to the complexity being
>>> introduced.
>>=20
>> This series was written with the following three requirements in mind:
>>=20
>> 1. Only CA keys that were originally bound for the platform keyring=20
>> can enter the secondary keyring.
>>=20
>> 2. No key in the UEFI Secure Boot DB, CA or not, may enter the=20
>> secondary keyring, only MOKList keys may be trusted.
>>=20
>> 3. A new MOK variable is added to signify the user wants to trust=20
>> MOKList keys.
>=20
> Sounds good!
>=20
>>=20
>> Given these requirements, I started down the path I think you are=20
>> suggesting.  However I found it to be more complex.  If we load all=20
>> keys into the platform keyring first and later try to load only CA keys,=
=20
>> we don=E2=80=99t have a way of knowing where the platform key came from.=
 =20
>> Platform keys can originate from the UEFI Secure Boot DB or the MOKList.=
=20
>> This would violate the second requirement. This caused me to need to=20
>> create a new keyring handler. [PATCH RFC 10/12] integrity: add new=20
>> keyring handler.
>=20
> To prevent the regression you mentioned, I was suggesting reading the
> MOK DB twice.  One time loading all the keys onto the platform keyring.
> The other time loading only the CA keys onto the secondary keyring.
>=20
>>=20
>> To satisfy the first requirement a new restriction is required.  This=20
>> is contained in [PATCH RFC 03/12] KEYS: CA link restriction.
>>=20
>> To satisfy the third requirement, we must read the new MOK var.  This=20
>> is contained in [PATCH RFC 06/12] integrity: Trust mok keys if=20
>> MokListTrustedRT found.
>>=20
>> The patches above make up a majority of the new code. =20
>>=20
>> The remaining code of creating a new .mok keyring was done with code=20
>> reuse in mind. Many of the required functions necessary to add this=20
>> capability is already contained in integrity_ functions.  If the=20
>> operation was done directly on the secondary keyring, similar code=20
>> would need to be added to certs/system_keyring.c. Just like how the=20
>> platform keyring is created within integrity code, the mok keyring=20
>> is created in the same fashion.  When the platform keyring has=20
>> completed initialization and loaded all its keys, the keyring is set=20
>> into system_keyring code using set_platform_trusted_keys.  Instead of=20
>> setting the mok keyring, I=E2=80=99m moving the keys directly into the s=
econdary=20
>> keyring, while bypassing the current restriction placed on this keyring.
>> Basically I'm trying to follow the same design pattern.=20
>>=20
>> If requirements #1, #2 or both (#1 and #2) could be dropped, most of=20
>> this series would not be necessary.
>=20
> But without these requirements, the source of trust is unclear.
>=20
> Is there a reason why the MOK keyring is temporary? =20

I suppose it doesn't have to be temporary.  I was trying not to introduce
another keyring within system_keyring code.

>  Asumming a
> function similar to "restrict_link_by_builtin_and_secondary_trusted" is
> defined to include the MOK keyring, the CA keys in the MOK db would be
> loaded onto the MOK keyring, the other keys that meet the secondary
> keyring restriction would be loaded directly onto the secondary
> keyring[1], and as you currently have, the remaining keys onto the
> platform keyring.
>=20
> This eliminates the exemption needed for loading keys onto the
> secondary keyring.  The MOK keyring, containing just CA keys, becomes a
> new trust source.

I just want to make sure I understand. If we kept the .mok keyring around,=
=20
we would store it into the system_keyring code, just like the platform=20
keyring is stored.  This would allow the move exemption code to be removed.
If the mok keyring is a new trust source, whenever the secondary keyring=20
is referenced in verify_ code, the mok keyring will be checked too.  If=20
I have this right, let me know and I=E2=80=99ll work on a v2.  Thanks.

