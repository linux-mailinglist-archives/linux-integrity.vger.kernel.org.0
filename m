Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76173D655F
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Jul 2021 19:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241739AbhGZQex (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Jul 2021 12:34:53 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:7866 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241042AbhGZQdz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Jul 2021 12:33:55 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16QHBAqW015683;
        Mon, 26 Jul 2021 17:13:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=vtOEHhVfH7CoWIlySMpir++BNLJFq1bVT1X9P3G+gu0=;
 b=CJqxQwG14V1qyxfhm9PZpMcrIJP8brizWCmOvMyE7+eVj8So/DrskYdBxr4Jsgp2U/96
 4anpRFZDpc9X+OPfEPTm7XV9vOf21MqMGqVPtInl37iZXHhL8RTIwbv6SKvGTP8pIK+9
 8q+B1kv+zgdpIZopYLEDOZKd9/UIObB9/sH59eLOVq5NJxykoBA4/ueie2KT/uY0jemK
 bXP7DIZ7rdHGyG+nAxUmj6nYMrsWzEXUB10oonymomqvnyRab2Wh5otX9FM0dFO4ZyJI
 UxFR9xGT++AI3RhcTyuAQ0zfdL6nD+O5mXd3UrJi1XjHvo6Sf1kTPH4ra/s7gwYjgUr1 Ew== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2020-01-29; bh=vtOEHhVfH7CoWIlySMpir++BNLJFq1bVT1X9P3G+gu0=;
 b=csgmzlhaIi+LDn3+2uHD+DNsbDeeGCfeFGsqndV9Hs37u1sslSjNdXTxo+ceShAUjjt4
 /+4wPZYATlr9MrQnRFC53+OhNmbaw5gAKJ8Hreo1MIW2fKiL4aT9/QkvzCLwfIk154ok
 4kDC6Z64aDS0Xv4mCsO2XrkyhMTI+EQO7KQgXj0RfiBSTxYXs+U8YMEVmLVnhQ23jmCR
 O1//Sy5rq8eBg3U2RR8TaXgjpxyhyFN+KSyHPszDcIpyoxTKvhBSzwCJXjYRLV5136BR
 NiJGKzwRQBwjfk1EvR7+Cdd4QeBQIaPr4ZpjHnS7Fp65okGW64I2k69rVKSVQz279l3c rQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a1up6ryg7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 17:13:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16QHBeGw043864;
        Mon, 26 Jul 2021 17:13:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by aserp3030.oracle.com with ESMTP id 3a08wewwd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 17:13:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGgvl9EmR4GJWMRgVsy5F72CQ9egAPxpzVhjPD7ZjFWG5POrxJowf7P1V7F/PkyuWMprmA0OW8Tryh+7R5R5lsP4AMYoRNwsxmYDeo1SRj1v922ZvaE6+SXnmYJGUE+NLm9Jm3cfxmnUGbo0DnZWETIVhh2wahHF/urYMsiGKkr5v4IRsIBQJsAxY3TBPHjQAgwsm13mF/TC/AR7UluK862+YXS94ZDkrD4dt2ADw7IYrNvKewrWoaSKvckABhhWKCnPSKcbgs9MSvh/gV7KX7JdNj+K4zByLDDI0PAppQ/Ctj2JRs0guS1ngJPF9Gu5a2xBbEiZpf/1HTsp/GRZlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtOEHhVfH7CoWIlySMpir++BNLJFq1bVT1X9P3G+gu0=;
 b=BLN9evi2HInQ+qeQFYFkXG+JTpOmpLLTs6XqxULq4g8FIdAYEuX8tnmxfXkg7DJ95rzR2PngfzSH23GbQGAcgsGfGF/S0LExMiJdStCGC9F4Ct5Lu3JlvgKxenE5yRu4NJfTYJPA4mgoONs21Xn8A382lgPdh5SlnUDdR4fc8ulUct7hU8N7QEu3K97MoULluaQFTBdRoI40xWo+WRcO57LIPMiXuAN1xz/UuztKPzPquWrAQUov+UKhGoWo4abUp2sVMx7kcQwh42JVKuCL2wjgyaVXJIdUq/S/o9EskeIGZ7of7rLffypHkUhyYIdRh0HgJ4Znl//8e+m9H2y5Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtOEHhVfH7CoWIlySMpir++BNLJFq1bVT1X9P3G+gu0=;
 b=AFfUPbh8MRK6V6tW/oyRF20KRjzZmDjrnijdaLaxFe4f0ZDCwcbEvI6BMItaO10GhW8CqjwgNFNOqKzi1MW6N63vBrPv5LBEY4cHG7PCy04XlmRuk85vaPeLHFwqkcWTqzTZnbDGJVcducIvesFMqYhjFE17Gx62c10I6Zmyg7M=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5211.namprd10.prod.outlook.com (2603:10b6:610:df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Mon, 26 Jul
 2021 17:13:33 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::1d17:4a7d:92cc:8fc3]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::1d17:4a7d:92cc:8fc3%6]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 17:13:33 +0000
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
        glin@suse.com, konrad.wilk@oracle.com
Subject: [PATCH RFC v2 00/12] Enroll kernel keys thru MOK
Date:   Mon, 26 Jul 2021 13:13:07 -0400
Message-Id: <20210726171319.3133879-1-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
Content-Type: text/plain
X-ClientProxiedBy: SN6PR01CA0004.prod.exchangelabs.com (2603:10b6:805:b6::17)
 To CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.11) by SN6PR01CA0004.prod.exchangelabs.com (2603:10b6:805:b6::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend Transport; Mon, 26 Jul 2021 17:13:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60ecad04-aec5-4f28-4fe4-08d95058b2b7
X-MS-TrafficTypeDiagnostic: CH0PR10MB5211:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB5211809C556790C0EE4732A487E89@CH0PR10MB5211.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fDs7n758Rz+PAo3FJ+0aAp8yTQit+T0Qqu39Y+6B7bghmC1corsDiOifWQv8X/W3ndhgIoaBlD6byjdcsP8R3XFl5b0YYOmYDkM93SmEchmzbLwHFj2Tpn/0PgElRHH/Pto2npbNi680220S/QfAjWKt7uFxEh0ohMV8EZMSpr4jLCaY3kQNAInIqYZ074mb+K4UGLQot2adAEWe9EbzbZ8G69dGZqsbjfa34pZO2rXcUqjzRxvS6N1gbMb6qnz4ZbkS/4u0Y6V/6eBE7av3PpdzPmPKpI+cEF0DLpEcYqgS/Hytf5bF9D1qQqKGBzwIqCtiEzoBdp253vrnXcciWQs+OGJbiB6iPUv9/MEQyNc1EAa9OsqwcDoViNlo/pqDk1WPxUNYjrkBM/R5gGugIA4SKc4B5TTeHKkQVBVlkUm9M9CWqjfjzfAf3q6NlBwkoqeEh3folZNzIEK9QbdDCmc9iFjkxPtB1PqJyn7FtM+xcSTOp99RbGLhJPZYmP/xCWmajsDsr7rBt4SAEUnvedAXnv5sXunrNdL6XZPOcnkx/gq22kpm/lS/3AcS2xc+JF648PUrOxCyiIvP+zp+7tRILHsCG2k0mmA/Met/FG3rs+vHoUb+6cSLZst9m4pK8LEmx7dyylqJO7zM5rkHr1RqyRaY4Xx7D2Uc4WPmnTPgvmTy8CJBx54FlLKzFmbjsnG6Vkkpgqx+GxqxhnkptJMcWxELvauunUuJuyxSSDWuM1SvlXt3MG9dVsQuszUYMZ2M25ktBS4uLoWXF1GXdZLn0cZVYtn8sX4Qx/uKu/iaZ3VPgk9x7+uZ24BIwAY1docRuycDK5hqXxwqjOIaSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(39860400002)(346002)(136003)(396003)(1076003)(2616005)(7416002)(52116002)(7696005)(44832011)(478600001)(36756003)(66946007)(38100700002)(38350700002)(186003)(966005)(921005)(956004)(8936002)(2906002)(26005)(86362001)(8676002)(5660300002)(6666004)(4326008)(66556008)(66476007)(6486002)(83380400001)(316002)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6C/IGBmrIy0vJ8bGOq2gKk+156OOujH7JIVzXA2xnKk+N5gZQkXHOPxGJxWp?=
 =?us-ascii?Q?jmIW8dwqG7aIFHrS98tEdtZllQqFubopncI/Uwqo+BHoQZ9pH8bqsKPgFud8?=
 =?us-ascii?Q?qKn1fOUtJkvhrkR9h9Fu9U2guBwkKL9njQ/Zsv1xd+jOLTbZFoeSt0ycbdK8?=
 =?us-ascii?Q?m4n6VrFBHRhtTbxhSQaqvQXbJospFWaw68VEzUfcseI95nQclOhPFrGT1+hh?=
 =?us-ascii?Q?8xNph9gGKfrFFDclyqtcPktmolswJBKYhvuvnNC04SnLq5g8wE+8ITP9VccK?=
 =?us-ascii?Q?oRI1CkjKJS5N7FnjgK1+ye4HpvkM1CVKf5SrIVKIIrGqQW6IqtsiJSJZgBmL?=
 =?us-ascii?Q?arM8jIAYxGnwG+2GhnCRrG3dFUFsn7xxcNGZ+Df6+L9Sg4NeC+O6yAZHYtQg?=
 =?us-ascii?Q?tl5zoINwBSuWSY4dB3gzqH2aP4XP2tuxSXILImgAZzz8PZ7PwwsKUzWa3AI+?=
 =?us-ascii?Q?s5S1Yxx36AoYh4ditzJ+mwKYxN66kh+06L9xGcUOFCI0dzGy4bQJDQKHC1A8?=
 =?us-ascii?Q?KIIdfKycg0I3vp8tnmsnIne/wntHMnB5ZGow2oLNUf0LBFZX2RBwx2gLC7kc?=
 =?us-ascii?Q?Mveyj96hbbTVXSQ9HZGdxTjulfumHt0upmS8+g70JPWrtNZK5iVelA67wCjI?=
 =?us-ascii?Q?GBNuoiz+pOAFTTsTi4zCn3VTGerjVAZLijGtGuvdJUKW2zf4aAi38q1EeMYn?=
 =?us-ascii?Q?UmeCi1Nm+CwBV17Zwl0uCPm6/ntugkb0ZWHvpOoo3QgrSleyayENyLHSrh2r?=
 =?us-ascii?Q?RQhntI05GlEGrKSObIZXAI2M5AUcefyXHTUec/o/wNfKm7DjlTvqSWjhUOMo?=
 =?us-ascii?Q?oS13hj+a9rdng8+w2ZbkSsmo18PVoYGrtrIQgZMvCMESAFk7GDUhVXF9TDZk?=
 =?us-ascii?Q?2WBKKhie9CCL4u7WVvIl1XStEqbf/qkjZDJ+G8/R5Uqo7y/gE+LJgoOpY3fR?=
 =?us-ascii?Q?WM4fPN+uKa1erohLvjAIMQaJsB2VYh6Q5iXD6ma0QGP0FLRDDzOfgxZdIH9Q?=
 =?us-ascii?Q?XGkg8RniH4UXiwArZnmXxEk38pAyU+iI0owIZytIZW9Y0vTPtR3yA8oPWV8V?=
 =?us-ascii?Q?+p3ZpcPSrT7pKHBGEQ4DgbQcPC/Et1quJHb9qW2Jpbqsp1EedLdcdoqvwCL/?=
 =?us-ascii?Q?mDNLUUF7qPZ9CP5ztr4F9IwPMH3Aqk9JCigMuijCG3v+o0KtN0zyCXHSIePk?=
 =?us-ascii?Q?+ipW8KbfbSfuf+TFBkP2VHoUnsY2w2yZckJeDd98Z9/haLgkU+OGJ2vH6CEU?=
 =?us-ascii?Q?oL/8pf0zsu+0qLlVFkW3k2VoL99F4Vetm/RJv4xvjSuO9aAjnvdNTEVtuisD?=
 =?us-ascii?Q?eOI5itTg6NWUzur7/l6VQaIz?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ecad04-aec5-4f28-4fe4-08d95058b2b7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 17:13:33.6960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dnVTIME6Y8G9btHP01l4HgpzrlyKOtK8wijJsvztO6iU+GJ5TxmQdgC2Ii1fjnrDJprCtZ+w1+zgDGWXh5LavfPvmuUoLeGLK7oFRyK6UxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5211
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10057 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107260100
X-Proofpoint-GUID: 83U3KHumjn2x_1luWgtfD5OKDmOIpzAH
X-Proofpoint-ORIG-GUID: 83U3KHumjn2x_1luWgtfD5OKDmOIpzAH
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
only CA keys or keys that can be vouched for by other kernel keys be
loaded into this keyring. All other certs will load into the platform
keyring instead.

The .mok keyring contains a new keyring permission that only allows CA
keys to be loaded. If the permission fails, the key is later loaded into
the platform keyring.  After all keys are added into the .mok keyring,
they are linked to either the builtin or secondary trusted keyring.
After the link is created, keys contained in the .mok keyring will
automatically be searched when searching either builtin or secondary
trusted keys.

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

[1] https://lore.kernel.org/lkml/1556221605.24945.3.camel@HansenPartnership.com/
[2] https://lore.kernel.org/patchwork/cover/902768/
[3] https://github.com/esnowberg/mokutil/tree/0.3.0-mokvars-v2
[4] https://github.com/esnowberg/shim/tree/mokvars-v2

Eric Snowberg (12):
  integrity: Introduce a Linux keyring for the Machine Owner Key (MOK)
  KEYS: CA link restriction
  integrity: Trust MOK keys if MokListTrustedRT found
  integrity: add add_to_mok_keyring
  integrity: restrict INTEGRITY_KEYRING_MOK to
    restrict_link_by_system_trusted_or_ca
  integrity: accessor function to get trust_moklist
  integrity: add new keyring handler for mok keys
  integrity: Suppress error message for keys added to the mok keyring
  KEYS: add a reference to mok keyring
  KEYS: link system_trusted_keys to mok_trusted_keys
  integrity: Do not allow mok keyring updates following init
  integrity: store reference to mok keyring

 certs/system_keyring.c                        | 47 ++++++++++
 crypto/asymmetric_keys/restrict.c             | 60 +++++++++++++
 include/crypto/public_key.h                   |  5 ++
 include/keys/system_keyring.h                 | 10 +++
 security/integrity/Makefile                   |  3 +-
 security/integrity/digsig.c                   | 16 +++-
 security/integrity/integrity.h                | 12 ++-
 .../platform_certs/keyring_handler.c          | 17 +++-
 .../platform_certs/keyring_handler.h          |  5 ++
 security/integrity/platform_certs/load_uefi.c |  4 +-
 .../integrity/platform_certs/mok_keyring.c    | 85 +++++++++++++++++++
 11 files changed, 256 insertions(+), 8 deletions(-)
 create mode 100644 security/integrity/platform_certs/mok_keyring.c


base-commit: ff1176468d368232b684f75e82563369208bc371
-- 
2.18.4

