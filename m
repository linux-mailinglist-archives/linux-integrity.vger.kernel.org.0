Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245F0402C63
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Sep 2021 18:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244356AbhIGQDd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Sep 2021 12:03:33 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:46944 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234524AbhIGQDX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Sep 2021 12:03:23 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 187Ehq72015568;
        Tue, 7 Sep 2021 16:01:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=y/M0AOwHWRBjGCOiCMUEM/RnaVYdkTrhp293S9bX4w0=;
 b=klHpm22F/82Wb1HVZ+kBqNNCA4h5GPCNy3uEgUyWH5KaC5F79exKaZuyO3UhnCdcrg7B
 jvfhjMpwJinkZT3rvWDgRmTky9XP03R+APgk/pTItWJI4kqA0s8+yM5dnNCsTszw5Pai
 hkRYFcX2CBhgWUsqhf9Ez8S8PqMu5dafSVL2ZJkh6KmMKFdlKAk/r51c4orarPqzq/cg
 yQDm2qglfXiXocbim0kR35PScZRWY4JULK4H5040r99/KS+OkW3OppYCpAgUoIj6k0Di
 5MkHFitH2wGRPjl+1VIYytba82nE6Pjr5dspJeRzmYMhgLIwx72yk486/03Ik+0/MQhr YA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2020-01-29; bh=y/M0AOwHWRBjGCOiCMUEM/RnaVYdkTrhp293S9bX4w0=;
 b=VwvPxD70So7z8c2OUUKiuUH9Rs6oa6txLWT5ly8pqBlfToJcNOVMnv8bWZp72ZywMdwq
 Z1h0H1HL7/v4K6mZmy7lpB/lkh2ppGKobQguxwHB3aPdyudlcEc1UV6vpjGqlE6I1byJ
 ur6UoY9WXk80etZIjDqiVnTlX1sACOonuRQIli1JuzpSagVo0Mm8vs2FbCEFmvU2UQ+N
 6uNZTEJVakGbD9T8VXRhmTjN3eZikSq2VXALxIyZBT5nD/BQ98bSnuxKItBThSh2YifS
 B/CXhQKoAypsPRvKGuJ6eXRH72x0YdWo4hEieYSV6d23VdAIlFd+KLpXsVhOXJOvuk94 ww== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3awq18adxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 16:01:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 187G0F3f134735;
        Tue, 7 Sep 2021 16:01:28 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2048.outbound.protection.outlook.com [104.47.74.48])
        by userp3020.oracle.com with ESMTP id 3avqte3cts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 16:01:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOrgrlBaHI54qIpgJ8J873/eqtrpqG3oJSX0yrerj25cC1UbDdr+5aCUCubCnE3mhT6UJDxGTurhEUZJEhc0yS8hRwHRMdaPE9fvQRy3jjJXSA98B8MIAlubcYWlN/ONoH6TJO8NtuU7/Zlb36G62wyy9sbpMp36YprN4vFBvRDcB1k1G8m2JfP87mK8AI2XDLASsQBxspbj+Rsc2FH+s1IxI2iSGzW43eH5Nu1Eoj9pbB10RHXhd2mMyd89WmmIJ6W0xMrIuvgreD0Quz5xfIu1CZr17aaR/L/SBBfdfbdGR5p2XryApo6FylSmWxaOnm/VqxeeoJzLJE+oLupFfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=y/M0AOwHWRBjGCOiCMUEM/RnaVYdkTrhp293S9bX4w0=;
 b=YfQqqmwTEQ9f+jbndEAeLdU6yP6xyTLnfRzPLafh3CUajsQbv052OwacyDGb1+IHHcrVji2Tb0E6bWF1DyPgaI/0Y96Ly7ZiKlD9FE/+SBO6FYVdCR1rTKIHEo7FBWVAsoo5N+QKTMRCppp5fNYTeHTjhS8v3GMj4MBMVWbGsS4OvfaZqGwpYKOKZ7MclmaBIUfmPMxtIe5TMyJT54cAd9TkExLAihCLM2kDriT5Us5gfRd2lB9LJya/Qu1iY0scw7YpEDJ3BISq54v8kt6ylNexxUq/pptQx2bP7QB6S8Xf26Yfn52t2mQNnQYiisngcAJD5NwTR/cf4hurxAD/vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/M0AOwHWRBjGCOiCMUEM/RnaVYdkTrhp293S9bX4w0=;
 b=d07d1dygpKZE64mXf+HNrL0gacT5rAT7ru2fkBaZmrf+QwOYrsErW217S04GZ3ivNBReLgB9t/YtYOVdCwxKDvvtOS+SJz4vgYgX3P6URN/gubpep8d8llvTKQPcHEv9IOZ5VJma2LiYvbNydoGRhs44+g2cPxez+cuCMlpfs9w=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5177.namprd10.prod.outlook.com (2603:10b6:610:df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Tue, 7 Sep
 2021 16:01:25 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7%8]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 16:01:25 +0000
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
Subject: [PATCH v5 00/12] Enroll kernel keys thru MOK
Date:   Tue,  7 Sep 2021 12:00:58 -0400
Message-Id: <20210907160110.2699645-1-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:254::28) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from localhost.us.oracle.com (148.87.23.13) by BY3PR05CA0023.namprd05.prod.outlook.com (2603:10b6:a03:254::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.4 via Frontend Transport; Tue, 7 Sep 2021 16:01:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2cf3be7c-474b-4e08-c217-08d97218be5b
X-MS-TrafficTypeDiagnostic: CH0PR10MB5177:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB517769AF54B00C021BEE635687D39@CH0PR10MB5177.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7hMf1hZPPFjKO3wkewQor7ntwQ/VwusuRai/NEGqNJAg7R3M/Lokgv1glcnB/2bxF8t31NhvNdllJX98oaLLyHr/OheaKOYZ3thgWA9mchfbWi3IxO6pUkO4pD7dZXn2zePmrZpB/eiZVvZBcjXHT0tY+pvcn1ksw1EsHcz1ZKoQSl0rzquI8H+uOyQtQ69LJw4J0wRsjoHgGevyewZeEEpEm3hGTMWad7EdO4YbEns2J66KpmuYzsQxAhc3Ra++QPLDRfXG1tETi1Tq2UQu17+t/h/+x6AuZtjsxPdf4CRyJTwbQ3arWVkMnZ/EwQ/yGBARngzzd3EtYrQ3qC8a0LrDPluCfPbyE215RpO87se8uyL8yYcXYzGenN/+yk8gXGV2s51dw2KMMrax6nGoXdrHXCiYZcjtaX4GHGlehFWcLT6G7mX1+Dx4H5iXdj8i4/vJ/vmOyoUCvvwlD6mkJvBSBnEJbMkyrQ4SwfBVM9x84DtD73WjdfVfy3pUhVM4DqaL4snuqm86k01I9CZRL9FvDxQPEuNo8HFb+5TQ6bxS4SmcX8vHseZSxAXwJjPQ/QHcx/50leTKexpBNmULFkMpXjIrY+QHqJGiU9Mn+6k4Xp3TdffewO4adjoQCsFA1mgx9ETVKrYa4GZcTSyxtWbaa5M3jlFKMon92qLelcZi6Cx43cLhvu9rx3NTsX+nru3dYJJ2ATNgNaNpfp4RlSpmCKClZcmiYpznMz6noBzkffcTO0qzvViHRx+e7OTlhjw91GBN+TneVhuOvYw+5m+Zly0NrognxYL2vYwgpRW9v44oGAzVRp1VrwI7uIgWAoHxLZZoTEhpIUvLiEh/Aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(52116002)(956004)(7696005)(2906002)(2616005)(5660300002)(8936002)(186003)(921005)(1076003)(66476007)(6666004)(26005)(38350700002)(38100700002)(36756003)(86362001)(66556008)(44832011)(7416002)(83380400001)(4326008)(6486002)(8676002)(508600001)(966005)(107886003)(316002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FGbhPW3WMmSbzXk+zMFBV3TVIw0vsFNEGZCJDw8VAvJGPPiJiihg9VjV4t+W?=
 =?us-ascii?Q?4m255dBy+OkE4p4cXCDrUZ4XJXj+nKCB/l9tN5O+Oml8ksvVWtSk9loZL8WQ?=
 =?us-ascii?Q?gxjaY7rj5bND+nis+Od4GrfsmH6k+tjH14wnv6AIw8vyaC5AZnGkQzBKCcxs?=
 =?us-ascii?Q?0YSpQrT0QfraWqzG5oQH05WOkXmSF3SME5B2CzdKqeaGu4WVkP1u1P4QDeXu?=
 =?us-ascii?Q?Vp6v1zpDb/R0QuiFJALCq8R9WsA56x/4lcJTgs0qDCgm3ic4HtUvlN1RvZcJ?=
 =?us-ascii?Q?uLD86A5Se31AbpAop72tR64/iCTvXkh8eK6mQcx512Yxt2on9DQQ15oqIXCO?=
 =?us-ascii?Q?cfoAjjPPu/Ld94KySJWPIjllinJGb/XYUxP/CH2dGL0nr3z7pEjvRL4AZ7jU?=
 =?us-ascii?Q?UIBSflNJt0vRTW/x+n4yHQ/Qd3WxwmxplB29DsvlcYho9cYKIeWuYNDn73eN?=
 =?us-ascii?Q?gVX08Ctm5bRDaRkNJbWUmXHp01YjzqqqZLUt+VZZ4PO5qsG81rJx2581DlqI?=
 =?us-ascii?Q?OLeGeOEg+UHQK0G8+lWmGV5ZDYMLskrBua0FEQinwhVlo7Fi+fcRFFrb92+9?=
 =?us-ascii?Q?ccjfHxx+KEJYPcuiYgY3Dg04ZdCW+M4vBHX6xHMTaJi7a/hpSbCdUZE1a0BH?=
 =?us-ascii?Q?kFLXO4mNn7fpqPoHXfIT8VRgc9I/aRsZEnzN767DniI7bUnouEQ+uOc4JHEB?=
 =?us-ascii?Q?vWAiIokCizRnuY5yjdy9y7Al5C2k+jD/S7p6+57JJ0tpx8W/VdnkPjlurNas?=
 =?us-ascii?Q?VdlxVns4BTJsdNL6Ut33DSlr3A3L7rUZ7YgC8OZoel9kRDDnShieottGuFZS?=
 =?us-ascii?Q?1+WBlYBS4Wx/58gyBlipR9jCiZJZdcs/sANDLOxlITtZM3WvVb6y331s63Ig?=
 =?us-ascii?Q?cBIofPUVnl42NC+uvRR9OmDDV7ar5fUiF2uT2j4gF/GZ5bHYo6SJPQszJael?=
 =?us-ascii?Q?KgG7WbmI+cS3PEkwq4l+1IvDxk86KCEUgZk5/p5fkXcoqjqBVeB0EA39Rgla?=
 =?us-ascii?Q?2gLgjlEwT/RXIj8p5I6px5R6aGY20TdzDThsUu9U5Gl6iIrVqBKAaPP26i6R?=
 =?us-ascii?Q?oBpoEZwmvSmXPJC5gIt0M+WLsiy468wFUApRZgFyjOeeXZJgbOhh0oyt9t4G?=
 =?us-ascii?Q?KMMciD1SvqvZYPwYNLlD6FvxQnf6EczdN0JrhYj0XM0NbPu7Cbf7ZQp/eKp8?=
 =?us-ascii?Q?I43vMKvIjmvRM1s33WEcHFqIu3I8EwE6V4MHXhHgBi5zcl7IFH+oUDIk7Yov?=
 =?us-ascii?Q?GTdO8il71nkuSoJhgvQYRAe2sYu/8U7Fa3eBtXjhcgZKkUqtfOSYcLWgVmuE?=
 =?us-ascii?Q?mcMBdKQFgN8Z/5yjSOpFlTQj?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf3be7c-474b-4e08-c217-08d97218be5b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 16:01:25.0401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3h3sb2w5QpFonVyUCI2eJHt6LUXzQbfocUfkfg0b59RC3tGopmOo4nVKDhWNaQFannN01uRWn9kYTM3RBpu4wdiLxrIIIVsGxhlp4bzyFtY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5177
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10099 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109070105
X-Proofpoint-GUID: abWxKp5W61Gb0P4KjyjMOQ2cMan2h0FK
X-Proofpoint-ORIG-GUID: abWxKp5W61Gb0P4KjyjMOQ2cMan2h0FK
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
Owner Keys (MOK) called .machine. It also adds a new MOK variable to shim.
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
machine keyring instead of the platform keyring. Mimi has suggested that
only CA keys be loaded into this keyring. All other certs will load 
into the platform keyring instead.

The machine keyring contains a new keyring permission that only allows CA
keys to be loaded. If the permission fails, the key is later loaded into
the platform keyring.  After all keys are added into the machine keyring,
they are linked to the secondary trusted keyring.  After the link is 
created, keys contained in the machine keyring will automatically be 
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

V5 changes:
- Rename from mok keyring to machine keyring

[1] https://lore.kernel.org/lkml/1556221605.24945.3.camel@HansenPartnership.com/
[2] https://lore.kernel.org/patchwork/cover/902768/
[3] https://github.com/esnowberg/mokutil/tree/0.3.0-mokvars-v2
[4] https://github.com/esnowberg/shim/tree/mokvars-v2

Eric Snowberg (12):
  integrity: Introduce a Linux keyring called machine
  integrity: Do not allow machine keyring updates following init
  KEYS: CA link restriction
  integrity: restrict INTEGRITY_KEYRING_MACHINE to restrict_link_by_ca
  integrity: add new keyring handler for mok keys
  KEYS: add a reference to machine keyring
  KEYS: Introduce link restriction to include builtin, secondary and
    machine keys
  KEYS: integrity: change link restriction to trust the machine keyring
  KEYS: link secondary_trusted_keys to machine trusted keys
  integrity: store reference to machine keyring
  integrity: Trust MOK keys if MokListTrustedRT found
  integrity: Only use machine keyring when uefi_check_trust_mok_keys is
    true

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
 .../platform_certs/machine_keyring.c          | 85 +++++++++++++++++++
 12 files changed, 249 insertions(+), 8 deletions(-)
 create mode 100644 security/integrity/platform_certs/machine_keyring.c


base-commit: e22ce8eb631bdc47a4a4ea7ecf4e4ba499db4f93
-- 
2.18.4

