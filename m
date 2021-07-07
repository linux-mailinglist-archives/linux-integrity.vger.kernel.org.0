Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B043BEC18
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jul 2021 18:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhGGQbM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Jul 2021 12:31:12 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:52894 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229542AbhGGQbL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Jul 2021 12:31:11 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 167GGMMr007133;
        Wed, 7 Jul 2021 16:28:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2020-01-29;
 bh=0f+u5xNNS1ljNmIdjUMtfMCL2KbWVuLQykvP+SM5bzk=;
 b=hnDfDmfX2lPrwssYyPbqVmJ/ryvnj3d8NhuWyAPP0snIssbWHLGlj6wbzAxJ2BEuGn9e
 /6K9GcbijApDdPPgFvKwgNGHitx7MqApk1YxyP9+RV8S2ZU9kcqRwLjE7LLKTDdl4jV+
 njtdnURGu7cckVOMjuoG+iF36r8VmAPIHJ2j3yzpGmrWUXAFdWJDK12SUwXx5Lmir4d7
 x52qV3sx8UEBsZI9AyVhRZbdjKLE8oYkWPtX6SDkLINhjVRQ9x0O1XSkqpvm2L1SpITe
 LLJlCoV475Lc7Yn55pfsWNPV7/s+1BtMtD34zjUk9OJW/SHV/mIV9qvqsIw2EQxBI8VI +Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39m2smmkjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 16:28:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 167GGVCp061609;
        Wed, 7 Jul 2021 16:28:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by aserp3030.oracle.com with ESMTP id 39nbg2fb6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 16:28:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZ5KBz+ILjMllLTVykcNSDBuLjJJZ3ZUN5CZg8fbQA/gwO1H656RiHYnm94qH0Aq4HDfIbcFFKxicYFZbNdYjemy+TcmlIzI5BlJMsa3n8asPERqu7vMA5HRZhocUiN9sJHd/5LlThQiBFsb8XqVNOEV/ow9iAqot7HwZ7F12K50gdVH5TbKkM36EDYBddqMc8pDNSTks0pfedKHtRD2C2mqdXwB/bBAowExxI6HUkftBpgbibsT1ti/d+aRNxUzhZPDF5pLUpRzVXuRjPkxDbO71ykrH6Hx+S3AAyWkCY2miH5WHYxVsxDHfJYwarslIkZBcFvyy43dBiBpClPRiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0f+u5xNNS1ljNmIdjUMtfMCL2KbWVuLQykvP+SM5bzk=;
 b=WJoGDEnoJpIENrvRCmc9YpKWCxjDYVvny6iU/Fk+S4uux9mZy+/9NKxu4fOeik5FLohFpctJnPJUrjCakNjLDsWHa++QhaeV0KskPyUC9bRIAOMSbAVPZgkZJkoRu55lcyTHfYNy2PqTFoGHsfgVPxkWkl2HLXsEHwDRCiO7Quq5p9fZYekr6zdt2NiSIsA2omjoHNxCWEbY6qW//kzqwh8Qdj66AhBdaanh3ZFhSwgOFTTunBY8ZtBUI5upuDAIKbMeOR3v+mJX3IFA7bRRGaTtIqt9djHCOEud4ZLQtXjA4rT4EOU46Lj0DRa8X9bOZUs3ExyLv3sKHPhvdPQjuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0f+u5xNNS1ljNmIdjUMtfMCL2KbWVuLQykvP+SM5bzk=;
 b=jMe2Llhxcy64kR3SlkVopF+v44VNm16vgNdhgEwFwszsdk+FcestNsjCB9Sn/4Q4YjwJqVOEtQiqlDHNdrejvarLaDgEXfRz785eg5Rfjc5aSnaRHVcZeJNLWlS6/QaLLHKHVlmLGTvjh07lLZtu/fkvR//J5xQQpNncfaVa7Dc=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB4326.namprd10.prod.outlook.com (2603:10b6:610:78::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 7 Jul
 2021 16:28:06 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197%8]) with mapi id 15.20.4287.027; Wed, 7 Jul 2021
 16:28:06 +0000
Content-Type: text/plain; charset=us-ascii
Subject: Re: [PATCH RFC 00/12] Enroll kernel keys thru MOK
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <42b787dd3a20fe37c4de60daf75db06e409cfb6d.camel@linux.ibm.com>
Date:   Wed, 7 Jul 2021 10:28:00 -0600
Cc:     keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>, serge@hallyn.com,
        keescook@chromium.org, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org, scott.branden@broadcom.com,
        weiyongjun1@huawei.com, nayna@linux.ibm.com, ebiggers@google.com,
        ardb@kernel.org, nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        glin@suse.com, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
Content-Transfer-Encoding: 7bit
Message-Id: <5BFB3C52-36D4-47A5-B1B8-977717C555A0@oracle.com>
References: <20210707024403.1083977-1-eric.snowberg@oracle.com>
 <42b787dd3a20fe37c4de60daf75db06e409cfb6d.camel@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
X-Mailer: Apple Mail (2.3273)
X-ClientProxiedBy: SA0PR11CA0113.namprd11.prod.outlook.com
 (2603:10b6:806:d1::28) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.177.128] (184.60.195.210) by SA0PR11CA0113.namprd11.prod.outlook.com (2603:10b6:806:d1::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 16:28:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c18e1a28-09b0-477a-e777-08d9416432db
X-MS-TrafficTypeDiagnostic: CH2PR10MB4326:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB4326BCE7E88B1209F4E51385871A9@CH2PR10MB4326.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O/LyiKU2S4r8wOelvRO3v31JfiPSNuEtMf1tFvzoWTDPLzBMHUTysYysSQw1NqYvhNcSwSD7RsWV594upjXFLtrxakC0BlAduuI0jagY/3oqFxQ0F4Ia+MYfWSGyNtLGQFnOSvBmuTMRpWxaalFKZ65dhEISKNhQSYElbxdIwz8zBGmbIIfBWcU9QP7nD2yZDEUHyhHC9ArGtqLFj254WjdwkluQ+KuExst7P6HlwzBmrMULtjX1gCgyo5sfhxLeEjftGKEmAYy3ImGoqGFCzNTEtqG9hytB+YRdlwVMzrX/H+eylfJhGfH5k/xLJYCgY6s7oHfc5EtU1Q08jVEZ043qj99L5PrjdxC4KDUU3sFCl/Of3QFgIhuFdf/xKvF1QViQSTc14/Fh2mbvRnjSo6NOeNjld6cJ2TOILyagHDY7Yu6C38tdr/rEnmIUYxcNSGTxnlU3id/u4f/6TdLhLmra+vOak6WS7OkHWI6gkAHc7mZMDW6aYO/9xy4DCqYL8fCN96k7vLI4xsOF8KUBh9UKWJsbgGp8wuG9JXhkAVR69rwEmrM1jEZyZBSqIhWXdo7w+daQucRvVPRYuuovyCJ7t+p/STtZgqc12vnjs3Al++QDsEppu75IZHUT+lFvrVNgK2VwUZHjcyqDiwEYerxyo+CB9a7dLrMjb2+Gqefx0G7BekoSiGGpxEU2BUT2KD0NZRqvymlIzl1kjfrFXH7TWsnREmHGTU3XeBo2+FY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(396003)(346002)(136003)(39860400002)(6486002)(54906003)(16576012)(26005)(956004)(186003)(38350700002)(5660300002)(38100700002)(53546011)(107886003)(2906002)(33656002)(52116002)(7416002)(8676002)(44832011)(66476007)(478600001)(6916009)(36756003)(86362001)(66946007)(83380400001)(2616005)(316002)(66556008)(4326008)(8936002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fn7BxWsJNRQZZPwq3OHvnmW51ZCYqM5mBU4ashq5qoL0w6fiNcnQQDOFHcNc?=
 =?us-ascii?Q?877fNV+g+fpRgoH0VJ/ZAodWtD0SlI9m6jLqM31SUVU8cRVIXA+racONu+h9?=
 =?us-ascii?Q?srYVV8opVtj1nR/pdbF3LO/Meff1J6HeYIoukilLBcRKskJchOxhU1aVwrMI?=
 =?us-ascii?Q?eThmwWtjQuIMM13hHNSIgLEx/jYwSJwWVU8hg379sc0IhFUhm2hw4ycOAZ/h?=
 =?us-ascii?Q?Sqfvf2GdaFMJAUHFmzoTFwBCtIaVEa88xHxoafBAcURhY6qkEN1M5q5VDmCH?=
 =?us-ascii?Q?Kp3i5WEy8Gu8W9qC3jBMkQbeVT2xHbXNS/3GjzpoU9NdbCDUKhoeKoiFl80l?=
 =?us-ascii?Q?R/YlLzwjy5+dIrHabtYt07+36LRwKG96naCkqbSMZq+UNk9Ol0IZEM3J+xWC?=
 =?us-ascii?Q?Oz7W8e/8IKVhMCETiySv/rwWS4O/CCzmmabGxhHQ2wzOiFwTgPbF6Oii8gdS?=
 =?us-ascii?Q?kkrYc/UdKyZ04zkMfAMPfhsfZ1iZuKBB344PduRSIUyZ7fWw+xF6EDlLY+vp?=
 =?us-ascii?Q?1zFS9PlaLB6aAOvxlGfG+uJGbAwttFoZfRkgFwATNvGJ3xqd+l/2QHWLjakc?=
 =?us-ascii?Q?UB0Tbo5QqWugyTRbWaTT3QYUxF4B8pe1OWcxyYRN45utEIRbuDrIbjCHoMFp?=
 =?us-ascii?Q?W1taa3JaVXByaDFzzVLJtMXEyascFw/c9tcH/nDqhViY9jLGhdC/2VL6y/4l?=
 =?us-ascii?Q?3D56J5gL0eOItrx+RzLpse++LXB+QZj129RpmyyC4g3olRHHeU7Oht4sUjLm?=
 =?us-ascii?Q?dfLTs4VTCktqrFU8ScyzQp9tNc1ZhMgCDlGVeRs1BxH7mAba0IG6oXjGqusz?=
 =?us-ascii?Q?+9pWQXJqlrOLYWIzVh51/7D4Y6USJrb1qUzJBz9jMKFPlWTVQ2f02LK0N10M?=
 =?us-ascii?Q?ry+nWjPcmnbBG/01XbozCfiAEd7Q95+zDbTseEx4WtPDpTYWmUjcPt+QD4Q8?=
 =?us-ascii?Q?oYx3PDXyq1tvY7DEPzaM0FfBVOmAEQvGX4b6KkNqQERn3IUlPnaFZhZ6KZGg?=
 =?us-ascii?Q?K9Ciw7qhMDIZOuC9C1nqmPMGJqG5d0rqsYan5+AdbIaF0rwL0S4YsvBOPn+F?=
 =?us-ascii?Q?IMAs6VSRLyAuxvneXDvKTP5icCMdxXRAlbEj0+OKa6OssX/Y+/0lwnqub5LO?=
 =?us-ascii?Q?cniRJwfKW6qJZFG2xzL+fLe5yTLDafDxjrr0dI6v6ug7THDvRVbgKjAlS0m4?=
 =?us-ascii?Q?pN/MZyE+P2o2PWT61qJopFf9Cl2WAzMb5bD1FAZ1spuZGhT2i1LwJGWDeD5C?=
 =?us-ascii?Q?HFX893bZnM3d3y7R7khN6SmLd+khVSPXd50zBSBpJ+1zP1ifak/q3Gyitq8k?=
 =?us-ascii?Q?HaRxxtOpNnLdlOYJYbHcTDlq?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c18e1a28-09b0-477a-e777-08d9416432db
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 16:28:05.8340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cJX/zw+xcDdnmtq+gJt3CMO2/p//9IWs1+zatLKWjeO2oU9L7YWQQEyEfG8ZG7qQ5gQAHVxaJda2NMTWobjmjHaw7G/0rkmAw3pR7EPMZ+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4326
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10037 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107070095
X-Proofpoint-GUID: 7DQBt1zCdOzLIhBmm9vjYmOo4fFcE-M7
X-Proofpoint-ORIG-GUID: 7DQBt1zCdOzLIhBmm9vjYmOo4fFcE-M7
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Jul 7, 2021, at 6:39 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
> 
> On Tue, 2021-07-06 at 22:43 -0400, Eric Snowberg wrote:
>> This is a follow up to the "Add additional MOK vars" [1] series I 
>> previously sent.  This series incorporates the feedback given 
>> both publicly on the mailing list and privately from Mimi. This 
>> series just focuses on getting end-user keys into the kernel trust 
>> boundary.
>> 
>> Currently, pre-boot keys are not trusted within the Linux boundary [2].
>> Pre-boot keys include UEFI Secure Boot DB keys and MOKList keys. These
>> keys are loaded into the platform keyring and can only be used for kexec.
>> If an end-user wants to use their own key within the Linux trust
>> boundary, they must either compile it into the kernel themselves or use
>> the insert-sys-cert script. Both options present a problem. Many
>> end-users do not want to compile their own kernels. With the
>> insert-sys-cert option, there are missing upstream changes [3].  Also,
>> with the insert-sys-cert option, the end-user must re-sign their kernel
>> again with their own key, and then insert that key into the MOK db.
>> Another problem with insert-sys-cert is that only a single key can be
>> inserted into a compressed kernel.
>> 
>> Having the ability to insert a key into the Linux trust boundary opens
>> up various possibilities.  The end-user can use a pre-built kernel and
>> sign their own kernel modules.  It also opens up the ability for an
>> end-user to more easily use digital signature based IMA-appraisal.  To
>> get a key into the ima keyring, it must be signed by a key within the
>> Linux trust boundary.
>> 
>> Downstream Linux distros try to have a single signed kernel for each
>> architecture.  Each end-user may use this kernel in entirely different
>> ways.  Some downstream kernels have chosen to always trust platform keys
>> within the Linux trust boundary for kernel module signing.  These
>> kernels have no way of using digital signature base IMA appraisal. 
>> 
>> This series adds a new MOK variable to shim.  This variable allows the
>> end-user to decide if they want to trust keys enrolled in the MOK within
>> the Linux trust boundary.  By default, nothing changes; MOK keys are
>> not trusted within the Linux kernel.  They are only trusted after the 
>> end-user makes the decision themselves.  The end-user would set this
>> through mokutil using a new --trust-mok option [4]. This would work
>> similar to how the kernel uses MOK variable to enable/disable signature
>> validation as well as use/ignore the db.
>> 
>> When shim boots, it mirrors the new MokTML Boot Services variable to a new
>> MokListTrustedRT Runtime Services variable and extends PCR14. 
>> MokListTrustedRT is written without EFI_VARIABLE_NON_VOLATILE set,
>> preventing an end-user from setting it after booting and doing a kexec.
>> 
>> When the kernel boots, if MokListTrustedRT is set and
>> EFI_VARIABLE_NON_VOLATILE is not set, the MokListRT is loaded into the
>> secondary trusted keyring instead of the platform keyring. Mimi has
>> suggested that only CA keys or keys that can be vouched for by other
>> kernel keys be loaded. All other certs will load into the platform
>> keyring instead.
> 
> Loading MOK CA keys onto the "secondary" keyring would need to be an
> exception.   Once CA keys are loaded onto the "secondary" keyring,  any
> certificates signed by those CA keys may be loaded normally, without
> needing an exception, onto the "secondary" keyring.  The kernel MAY
> load those keys onto the "secondary" keyring, but really doesn't need
> to be involved.
> 
> Loading ALL of the MOK db keys onto either the "secondary" or
> "platform" keyrings makes the code a lot more complicated.  Is it
> really necessary?

Today all keys are loaded into the platform keyring. For kexec_file_load, 
the platform and secondary keys are trusted the same.  If this series were 
not to load them all into either keyring, it would be a kexec_file_load 
regression, since keys that previously loaded into the platform keyring 
could be missing.  The complexity arises from the CA key restriction.  
If that requirement was removed, this series would be much smaller.

