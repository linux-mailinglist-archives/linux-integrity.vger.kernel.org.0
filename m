Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5AF83F0F20
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Aug 2021 02:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbhHSAWk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Aug 2021 20:22:40 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:19552 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233866AbhHSAWj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Aug 2021 20:22:39 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17J0HQni029090;
        Thu, 19 Aug 2021 00:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=8WeNfhu067K0ZsIkkhnayDaFJ8fDyEL2f39jafQFSGY=;
 b=e8OLiMtJWqNyDZUhKxQ2I+binb367qc2j1KylU2zCNzVjL57/IDkDK4dSxGKvRjyBRTA
 poKP/LmTUARmTg+KgmvhTbKXEJH+P87HCB1cnv5zG9ZDcHkd3/mA2fLuLhRAroxtiwse
 rJv9jdM0sH2xCU5M4Wlg5yd2DYdXkNBDdz/Mb87NT0ys2vN/NTGqQG4/VXjD9NuQh1A3
 kDqrnJ8RwE7Vy+MWzBlauiGprSFmaKKmwLfhFh6sdRjc0l3fZkLgNcXgvcFE0hmLBp9R
 3d0UTrOv7sXY1uvooUG8e5Ig2BjAnVburDWUIeNWiYHh9yqv8eREi5OMi7wLDWtHuAfV 4A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2020-01-29; bh=8WeNfhu067K0ZsIkkhnayDaFJ8fDyEL2f39jafQFSGY=;
 b=GIUNXF49XPeKie7IAtU+thE0YdlcwUIeyLGeQBrFnKtuBqiCxpRlMLIpHxG1CmyWxX99
 SsQBKfaTmfjbmZDBdDu8mnxj6Ed9N05rv8f3tY8QHpviRy/Y6ckjlrcdp6p8L/kLhEwq
 +WkTR4OjpdL4f7uaU6yvp2orRZvUmopqPFHuyhjsZWqUzl1RidT1oblqKuasftSCeGv6
 ZBiaJCDrxUONCxA8it9lXMHan9lgMajfpB+ymQMwkFYcc2VllmoLPAHSlAC5ENDKdtiU
 xCt+0w5lBYIr+pYvQ6Qu31+nVIaPVOmEqygkcvuW4+6/MPC3MHoPfwCYsN/5McOj4Z3Y Kg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agykmhwn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 00:21:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17J0EpVx160260;
        Thu, 19 Aug 2021 00:21:27 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by aserp3020.oracle.com with ESMTP id 3ae5naf8wu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 00:21:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlBpoD1sY4vPJeHJC1CvBm67BlL4rnSD9UdmRywADFyBqB1Husn1zj+/d0gTBLSjixqeFTtGkDWpEAkCMBGFMmzY0ubm4Nb1uR9wbMeZA4zPXj1dpPC1GWs0uqxe5hCbdkcINGzsvXrwb8pQZ17sepK9mwiNp19pqTrSwK2mygvdP/OruQCf3T4zL9Wevl1Bcho5nL202CGrdUvLZX2fbYhFG8AbB6pXM32Yq+kByEWzojhJB4+CKuVTM4vQib1Gk2/0PGDwd+BX0fVa3ul7ni/Gd12+swY9Mfv8dd+EzK+bI4Ccjd1w81vEsC+g55cXed9OnHJvDpLiwwC5S/K5iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WeNfhu067K0ZsIkkhnayDaFJ8fDyEL2f39jafQFSGY=;
 b=InM16OWiH8a/WvvyUzaVfmZUfaLy40p0gmg0aQAUHNsIEY7JmFwx/irq9gWCXfwLekdcX7t95z0zJTBj8fz4QMQoNKwClmEsG55kFvM0aACq7bSpvecPY9HyW+UIL9LJzzCIuyJ1p3S/OqXmcHbn3bz9S1BAt6RHuEbjmqWWHUncRGk1F7MBtLixjukQkc5/eHa3sBpSdjbtTgz+yzneztXGkEYR9UJNozMabtBNH0IaEXJouI0MryNgQ6MtwJ32pmhUPXaBeGszSejguoIF7m/xL1MhppBfwmxejeztoe5GntFbAa4uzvJLWlILLH2jtp9Bfy/FN5vWfWwNGIzIYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WeNfhu067K0ZsIkkhnayDaFJ8fDyEL2f39jafQFSGY=;
 b=VYF7QTQFKbzvS5WjrJGkKb86zdNP5ZDPKdi//s1OdCjoze0EoYvzOnlHF4FQURU0NIlN9n5RVXegKplA7l/CY4pwR9fD0JsHPDB0DA90QDu7FfqbVQmbJlSPxdxqMlhqOu/4Jx0zNqQJFETxQT2R2iVjWmii78tUR9aQ9KLIJaU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5116.namprd10.prod.outlook.com (2603:10b6:610:d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Thu, 19 Aug
 2021 00:21:25 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15%6]) with mapi id 15.20.4415.024; Thu, 19 Aug 2021
 00:21:25 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        zohar@linux.ibm.com, dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jarkko@kernel.org, jmorris@namei.org, serge@hallyn.com
Cc:     eric.snowberg@oracle.com, keescook@chromium.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        scott.branden@broadcom.com, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Subject: [PATCH v4 00/12] Enroll kernel keys thru MOK
Date:   Wed, 18 Aug 2021 20:20:57 -0400
Message-Id: <20210819002109.534600-1-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0401CA0025.namprd04.prod.outlook.com
 (2603:10b6:803:2a::11) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.4) by SN4PR0401CA0025.namprd04.prod.outlook.com (2603:10b6:803:2a::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 00:21:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe67db16-b220-4d05-c887-08d962a7479e
X-MS-TrafficTypeDiagnostic: CH0PR10MB5116:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB51160A852BDA0ADD4993879187C09@CH0PR10MB5116.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m0Z9iySh731JbHYc6YWJpBDPnPgb7iTetNKOTozhQzUs9RZIOm/UPSOEkTkj+u8EHlcLCcsVsty5GBaVTC6ewj8N3jQEfOVianYyHWFdxpTc83YYnSJ1Vc8iXaLskInl7XABtEOQHhSNAC+EJVvX7oFoGG4QTNsWeP450Lj6FW4UDovlW9paCokGLx6UvpYhbK8hwoyVxI1DP9902kR2sJT7KJXGclq0IBTvGj19N+3hX4xfW1PBrTtyPi8AY1uYkfaQJ3wIGHBzNPK0mQlnBZxFoDrx5L14StKBdN80oMdjpoKWUunOhE8RM0xiSCPfil4rjfy3A2bNIu5NzJR7s0HqccVxbjNQkp6jtm1CBSMbPW5HrN6gLvH+Sq8ewlQXer+SQ9MOrIt4Z7PzsfLNWcMMnfzg4Kp65n02lmJpo+m/eoFHCCzUv5J6H5LWsPY2g83XN+x6jbEg4v4bpedbj57z+e7D63cfEDjWs5aibvVprR2Eq4V22D0RtkZ4WGkYiQa9x2vFTXpo36rBRG1LSLewBZ1FeGa4EM+f1daTNXzumNdsKMxIBlNx1mNJDA5bRryUJbY+/p0IzuYDbkCACtbX/j240HLs71frRp8jr0iVTUs+TfAf3YgvTqIK2W+iD8gpUwWP4uREoIGy17pumf4dwqgfaqLpKydLUT+VOfJtdu3ABrh0XJRY2szur+zalYCQ+sztyAmBIY1aaVtLJ6xlPRKfF1gOlBYeMSdnZAKT+Isg+uSyNxQKhQalwd//dutOhJ2O1pRHL+tb+CYYbtoD7RQ6cO7pIr0suTGa5ZJfNABp5qqgUuVK/B7+aCEfi0Wo5x2iALO4UaXpzsomQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(366004)(396003)(376002)(5660300002)(966005)(478600001)(6666004)(6486002)(66556008)(66476007)(83380400001)(86362001)(316002)(956004)(2616005)(38350700002)(66946007)(186003)(107886003)(38100700002)(52116002)(44832011)(7696005)(2906002)(26005)(36756003)(7416002)(921005)(8676002)(4326008)(1076003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6Z/ed2/Omhh4gQbiLd39bAh59CLlsBjdneb3+jo5zMxDixHGvh3PK+mYo6wa?=
 =?us-ascii?Q?GFUt6PdtsJCJipxM5kTovh+rSS/c13Ck/RFRK4ZzP9Uw3hBCBdefNyEj8JiS?=
 =?us-ascii?Q?l1Pw7+B5V1Xx3GLiD0e1HMDbcSwmAfNLAZyFWetBcokvwZLIgX4zKPUKfe50?=
 =?us-ascii?Q?oPu6KAABfvWWuHz3y+Gkwiqfzx+MUjzwBw2bXbj+5WuYw1Yo8wTAiZH+f0tf?=
 =?us-ascii?Q?ehw0hcIxo9McT20M9uDsTFr6JElfM5z+PByNpaeV8w5xh9lwidzQKQgzU9NA?=
 =?us-ascii?Q?bqXo7f1OzePXrTBRL2Qod8fOutd5bwCvSKRRh2wgrkrHrL7epg1WWPFQ83jz?=
 =?us-ascii?Q?5bJriLkqFSr/6/Me7itM7UDi8tXPc8LYLEYThoYFBB/wkdi0z2G/PvXL/qVm?=
 =?us-ascii?Q?kPYc1jBWIWwjBEV8lXAP1iH2I/wC/clmaRTszpHTcwIg87sF0Mh3BTodNd5C?=
 =?us-ascii?Q?hehNfnI5Gwab06wYbljB02k8z5gr0D+5mmZGuoU8fqpgXhrlXdG1seEQPfhv?=
 =?us-ascii?Q?fBcBXyu7AKd4Fe7TMv3odlca0z5Z2xFqwDg2f/QPBH+vALxbTgj3mXTN43ZR?=
 =?us-ascii?Q?AzokrbKSpvZ4/YvTbb3wQDUtglEFEULhEOL4LEmrvIRSvho/FZTdj6bs8juy?=
 =?us-ascii?Q?iR/i+3Nb46PfCbOF0L5KEuynHF8zoAL6vRLkn6BBrQQhWfvQGn/qEG/dqXcW?=
 =?us-ascii?Q?E3nZTneGGF6ogRQIUO4h55ujsV2CLrQg8sT8j5UP/3KOB7hdmTzADb3xSECF?=
 =?us-ascii?Q?N08gEGMtzB546lDIccixnijzio/ds19YYHJDMb7IERV1oUO9rA7YLduKxW6i?=
 =?us-ascii?Q?Rc+gClfOo09eNkFV2oNrnueJ7zZlH4O1vjfX42LMz18/0WnLAIrPl6a1EzTS?=
 =?us-ascii?Q?JdA6zVZgvpsGAvaOVDNM5tHYzT9hF38HXIu0B96X8tBzVoMcCZdig7RJpvIK?=
 =?us-ascii?Q?9Mf3ciHKK/L5uBmdVufuJ4aqcFXgDjwjf6RwgLwq/8AKtjalf0W1/TrxT2t1?=
 =?us-ascii?Q?NIUjs/mvOvX9x4aLFzABQuW09AO1XGVwNkblEXowAeoGxJ30deYIabZXKVPm?=
 =?us-ascii?Q?wt4aNiVqDc03qvFJ0mXKx66aLvpRJpHfanSPoiRgtYoVotupFDhhPA296RIC?=
 =?us-ascii?Q?3GssX3vxyFL48Ra91NxDc98DY/Lf41aHMlEoVUcdxJUuG1uAeL5E1pmKV4+s?=
 =?us-ascii?Q?xfw2Tn6di4qw5/+eNKOLeN/rC9xq6SURTPf2gEO5DrYX/g5cJp1M/PAmBPlE?=
 =?us-ascii?Q?ts3bNaq5ElnCMYy9NZSBwuW091vvZPh+NbXqBMxm7lECaeNszKKEUotNRfZa?=
 =?us-ascii?Q?GsLfeLqwELiqAH5k1wvpL9dF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe67db16-b220-4d05-c887-08d962a7479e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 00:21:25.2465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4FBxrDUIOHajWB6B9y/nphlAyA/9xEyzE5qNDOfvJd0rsa3VmU/kN1tgLsUjNv0w85bVzTwA2PcFsCBsIKjzm/5C/ot942DCfVnrNBRgdo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5116
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10080 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108190000
X-Proofpoint-ORIG-GUID: OHXtWQuxHYyfqU1_d2Fnv2Yy0AEEz9P7
X-Proofpoint-GUID: OHXtWQuxHYyfqU1_d2Fnv2Yy0AEEz9P7
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Many UEFI Linux distributions boot using shim.  The UEFI shim provides
what is called Machine Owner Keys (MOK).  Shim uses both the UEFI Secure
Boot DB and MOK keys to validate the next step in the boot chain.  The
MOK facility can be used to import user generated keys.  These keys can
be used to sign an end-user development kernel build.  When Linux boots,
pre-boot keys (both UEFI Secure Boot DB and MOK keys) get loaded in the
Linux .platform keyring.  

Currently, pre-boot keys are not trusted within the Linux trust boundary
[1]. These platform keys can only be used for kexec. If an end-user
wants to use their own key within the Linux trust boundary, they must
either compile it into the kernel themselves or use the insert-sys-cert
script. Both options present a problem. Many end-users do not want to
compile their own kernels. With the insert-sys-cert option, there are
missing upstream changes [2].  Also, with the insert-sys-cert option,
the end-user must re-sign their kernel again with their own key, and
then insert that key into the MOK db. Another problem with
insert-sys-cert is that only a single key can be inserted into a
compressed kernel.

Having the ability to insert a key into the Linux trust boundary opens
up various possibilities.  The end-user can use a pre-built kernel and
sign their own kernel modules.  It also opens up the ability for an
end-user to more easily use digital signature based IMA-appraisal.  To
get a key into the ima keyring, it must be signed by a key within the
Linux trust boundary.

Downstream Linux distros try to have a single signed kernel for each
architecture.  Each end-user may use this kernel in entirely different
ways.  Some downstream kernels have chosen to always trust platform keys
within the Linux trust boundary for kernel module signing.  These
kernels have no way of using digital signature base IMA appraisal.

This series introduces a new Linux kernel keyring containing the Machine
Owner Keys (MOK) called .mok. It also adds a new MOK variable to shim.
This variable allows the end-user to decide if they want to trust keys
enrolled in the MOK within the Linux trust boundary.  By default,
nothing changes; MOK keys are not trusted within the Linux kernel.  They
are only trusted after the end-user makes the decision themselves.  The
end-user would set this through mokutil using a new --trust-mok option
[3]. This would work similar to how the kernel uses MOK variables to
enable/disable signature validation as well as use/ignore the db.

When shim boots, it mirrors the new MokTML Boot Services variable to a
new MokListTrustedRT Runtime Services variable and extends PCR14.
MokListTrustedRT is written without EFI_VARIABLE_NON_VOLATILE set,
preventing an end-user from setting it after booting and doing a kexec.

When the kernel boots, if MokListTrustedRT is set and
EFI_VARIABLE_NON_VOLATILE is not set, the MokListRT is loaded into the
mok keyring instead of the platform keyring. Mimi has suggested that
only CA keys be loaded into this keyring. All other certs will load 
into the platform keyring instead.

The .mok keyring contains a new keyring permission that only allows CA
keys to be loaded. If the permission fails, the key is later loaded into
the platform keyring.  After all keys are added into the .mok keyring,
they are linked to the secondary trusted keyring.  After the link is 
created, keys contained in the .mok keyring will automatically be 
searched when searching the secondary trusted keys.

Secure Boot keys will never be trusted.  They will always be loaded into
the platform keyring.  If an end-user wanted to trust one, they would
need to enroll it into the MOK.

I have included links to both the mokutil [3] and shim [4] changes I
have made to support this new functionality.

V2 changes:
- The .mok keyring persists past boot
- Removed the unrestricted move into the secondary keyring
- Removed the keyring move bypass patch
- Added restrictions to allow the .mok to be linked to either the
  builtin or secondary keyrings
- Secondary keyring dependency has been removed

V3 changes:
- Only CA keys contained in the MOKList are loaded, nothing else
- Support for kernels built without the secondary trusted keyring
  has been dropped.

V4 changes:
- Add new Kconfig INTEGRITY_MOK_KEYRING and move all mok keyring
  code behind it
- Changed patch series ordering
- Consolidated a few patches

[1] https://lore.kernel.org/lkml/1556221605.24945.3.camel@HansenPartnership.com/
[2] https://lore.kernel.org/patchwork/cover/902768/
[3] https://github.com/esnowberg/mokutil/tree/0.3.0-mokvars-v2
[4] https://github.com/esnowberg/shim/tree/mokvars-v2

Eric Snowberg (12):
  integrity: Introduce a Linux keyring for the Machine Owner Key (MOK)
  integrity: Do not allow mok keyring updates following init
  KEYS: CA link restriction
  integrity: restrict INTEGRITY_KEYRING_MOK to restrict_link_by_ca
  integrity: add new keyring handler for mok keys
  KEYS: add a reference to mok keyring
  KEYS: Introduce link restriction to include builtin, secondary and mok
    keys
  KEYS: integrity: change link restriction to trust the mok keyring
  KEYS: link secondary_trusted_keys to mok trusted keys
  integrity: store reference to mok keyring
  integrity: Trust MOK keys if MokListTrustedRT found
  integrity: Only use mok keyring when uefi_check_trust_mok_keys is true

 certs/system_keyring.c                        | 40 ++++++++-
 crypto/asymmetric_keys/restrict.c             | 40 +++++++++
 include/crypto/public_key.h                   |  5 ++
 include/keys/system_keyring.h                 | 14 +++
 security/integrity/Kconfig                    | 11 +++
 security/integrity/Makefile                   |  1 +
 security/integrity/digsig.c                   | 18 +++-
 security/integrity/integrity.h                | 17 +++-
 .../platform_certs/keyring_handler.c          | 17 +++-
 .../platform_certs/keyring_handler.h          |  5 ++
 security/integrity/platform_certs/load_uefi.c |  4 +-
 .../integrity/platform_certs/mok_keyring.c    | 85 +++++++++++++++++++
 12 files changed, 249 insertions(+), 8 deletions(-)
 create mode 100644 security/integrity/platform_certs/mok_keyring.c


base-commit: 7c60610d476766e128cc4284bb6349732cbd6606
-- 
2.18.4

