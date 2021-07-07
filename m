Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A003BE10A
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jul 2021 04:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbhGGCr7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jul 2021 22:47:59 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:60838 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230019AbhGGCrx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jul 2021 22:47:53 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1672aHGH015804;
        Wed, 7 Jul 2021 02:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2020-01-29; bh=axVz66+bKjtVqtwkrkS0dTGUXDk7KZaw72ezQulgORw=;
 b=V5KzCebKB92biGxC9A+NWoHFabq56dP50RkrzC84x2f9cWPt7eHaS15LvxLFdFo95Urn
 KLIHFIT1DaheRESBwT6cmgmBA2y5qrbBQsfvyXEs+YsdijbxNn/qC6DPC3CfZdfs5tEt
 Eha/Vihl9R8o864U0NPu1tJoE4ec73uAiYuSBiqBLc07LmIuV8LXNw0VpZasRGV9KQDJ
 hctLxBFDBM+xSQr0+LduPWa0E3J5QKnKz+JIlV4Fxs3+iBfuqSV7jBvUKEtcLk9JPqwA
 NCpETj7B5svyagqNIseQY+G7UjSbltbqo9ZBQhimCH1vDgMq/xE6DQjY14xq/xcOwdSy WA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39m27hb64t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 02:44:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1672a75t145022;
        Wed, 7 Jul 2021 02:44:27 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2173.outbound.protection.outlook.com [104.47.73.173])
        by userp3030.oracle.com with ESMTP id 39jd12ghun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 02:44:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0n9KzLq+66z4JKHbVm1QAV3nJYRXmp30CNUn9c9zXl7sq/flwI0K2qpMmMa8Qkkx+mTy/k6Yrg5bDpHN9eRAyolHWag2kZxCT25U65E4MEEvnxK24HY8MfHP3tG5moQhpEyLiIBrdvFMaD/vfRJawMJl19PZSzUDOUBOfY7pV6v+/E6VfG70KTAihqiGOoQFLWJ2xLjl/Mww4826o0TWbaXLOT2t0gGLv7TOkGTIvHBqdIQxmIxpXI//UOIArS25xXEirbbA8L7EF7IXbVNI+C3UPHNu+GId497VeA5sQA/5gYLn0RGbIqibpUxMeJwfJ6DgK19DKYxtUnD+IM/YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axVz66+bKjtVqtwkrkS0dTGUXDk7KZaw72ezQulgORw=;
 b=kYkYWrD/WKJ8q+r+WA+R84HV3gwYmwdqdpGl2gd1PNatf/kg5d6UVk2gi++EI+tW/XGZYbMJdVIlFXAhHzQxffFE1IoI8yKZub4MBcuestEdDytdI/WyujRsfTnGv163O3Ut+xM1Hw2NgiZA5d2IUllP8w0UGNYs1ZBtB5IG7tHehGy/r2gZ3BMt5hROBsFWxryZ6Oud5/t53sSm0eEAC8TIaP77Tcz4qcUSLEmiQ7x2BmyNm5sQ40fgChCAMzl1QUiw5LqV+n11y/3En/xZdKFs/e+uuseVolo/gO1Jua48ze48o8xLJmsQCxMv1KhTU4L5wC8/nronJLfGKFfDHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axVz66+bKjtVqtwkrkS0dTGUXDk7KZaw72ezQulgORw=;
 b=Fd5dSUARF9aQLm4bx1P42yasXm3O0jswLBnC8l2SX9GUqDWdScEMOt8UYbyFIaxhlqXcxVTrEGBMcuR7Up2TcVjLxtFwloMAiqn6CA1bAkfFS3cS4tp0gFNuds+Y6r8k1X/h1Oguq+xOgPYbhtMQ4U7OjPvBwcS2PWk6AKqYF3M=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3863.namprd10.prod.outlook.com (2603:10b6:610:c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.24; Wed, 7 Jul
 2021 02:44:24 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197%8]) with mapi id 15.20.4287.027; Wed, 7 Jul 2021
 02:44:24 +0000
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
Subject: [PATCH RFC 00/12] Enroll kernel keys thru MOK
Date:   Tue,  6 Jul 2021 22:43:51 -0400
Message-Id: <20210707024403.1083977-1-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::10) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.5) by SJ0PR03CA0245.namprd03.prod.outlook.com (2603:10b6:a03:3a0::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 02:44:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f159a9a-1caa-482e-c4de-08d940f1212d
X-MS-TrafficTypeDiagnostic: CH2PR10MB3863:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB3863367689BF5AF4DA31B322871A9@CH2PR10MB3863.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E9ud73a0Yxig0ZGrAuYuZQ1dmG+3nOWnbwhy+hiPUz0kaosk1bBDY3/tlCP7PTY4uoBNicOJZcWLxsfQ7tsF7xF4eyxQRoWroYEhwZGfwP+bYrtNuiLRpNKucKUDTHrtS1G5IGH9//vAhWki8Lncx5zYYQI0YUvxnOwvtZg6EtrT8afnBWVPPs0BNysAfk5jejux3CCq7SbZbN/H2H2FDjfAkltru4K9iRr+YfEdUt8tVpXH2Nz8kF/G77tKBc1QSy5ExfahyyrMNDEo20fH8+QMSchuJJluwjHH4uB6PQwV6Jlg3TmsHkqD6yzoWYjkZZKpl+/OqX6klflszVD56BHrsCA3ESu1a4HO/rdgI4p4MceCfrLM9pJ3Pz54xeSb9e0lvW5u5J5eVEfzJ6IzAeUSHeaCWqNkT1cSpGjVpICb5Dw4tVY/QK8agAP0zn+DIxCzEzuEX7BGr6VHonGSB4V5HLY9D2IifQBApOjcPzSKTS4n88oUOPER6CM/kUDVk31PJipE34udBbVrqHGp4PFhNg0CewKJCYJXAr51pjzVyM8NbIQr6jsbAJ8hI1IZHu8yh0vtkb/h8qHlFLFTtbx8UVDRLLF+aQMLMp1k5a8Fe3CHTh1VSpn9CLEqBwKYQC/TqGTEUV9lHxDFlAdJ1QRfLSU+n2kgtt/qKR21OxDfv9aQmAQh2UHik+PoySR58QEyMiOZWH2KnYoM1I/H3aJ04dVXyTG+YeqwaCXThV4gcqwR8nZ3VCfNziNQm/0c/pyxXU5M2P8rQZyycsX2RF1rEJljaiA11Xaeujo2Ee2fldDT20LZs/BXlRwIJ7/x53zYmKpsh/4vLj4gBSRkUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(366004)(346002)(396003)(376002)(921005)(107886003)(6486002)(7696005)(316002)(66946007)(1076003)(44832011)(86362001)(38350700002)(966005)(6666004)(36756003)(83380400001)(186003)(4326008)(956004)(26005)(7416002)(8676002)(52116002)(2906002)(38100700002)(2616005)(8936002)(66476007)(5660300002)(478600001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4+oG/0QuQZEKiD2kSJRuwH82UQLiN5OwwjMW8xT4SShi0uLHhgKAs+r98DvJ?=
 =?us-ascii?Q?JHOwZK3PsNdsjUnDjrjjCAND388pf+y5vCR7UGJ1rAayo9HpYOoXwqJPUh4e?=
 =?us-ascii?Q?RSamfij3kXlteetc0UbdoZMliGpB8T8mZSUZ5GcKafWKdcTWHsUExiYHbsA+?=
 =?us-ascii?Q?PbY86VTZh/XIBsVpmp5FMKQY7vmzTsbAD8Wyd0tgUgEACS9aMZNzbGBEsz0D?=
 =?us-ascii?Q?2SDQaxaBIwWE6z5nxAlclFKCY703vArOliILFwlbpoRy1yZHfaCiUvF8jNJM?=
 =?us-ascii?Q?geOPnkSy//XT7WSTc5pSqsA+flE2+y8dSX8GwCf/6T5WAT2vjpc3qqI/kdBP?=
 =?us-ascii?Q?C77YoODrBSWKCbhEcGxvdkELjtvGum7fYvWypGP999T3zesq9Q0sBruZWPmv?=
 =?us-ascii?Q?/w8DTfrqfDydagwWvQ5wZBjJUZEBlAjHMwtHxzA0iaU76qJZ+q53ZhgsKf5B?=
 =?us-ascii?Q?UPjf7gWZignQPwqONz8aCH4gLcFvZwCBJiYhMkuu6S4HZdA8yzJ/FuES76cp?=
 =?us-ascii?Q?kPg+qtWbqVnRLz9l0vlkNbZ68nD4QZaOXp4+UNMXXI5VzOQ6fJmm3HF3WSo4?=
 =?us-ascii?Q?IlRCNHAXl24k7kePneOElS8I8QWHV5vUkf6d90Hnuj7miqGQO/2Mb6KquKNm?=
 =?us-ascii?Q?YzxqzozM47NQbREFTlW/SrMsTKRXA51uIlfytXRUfy1xyhExA8gZNvI/+PTa?=
 =?us-ascii?Q?VdJoXHLEDd0dsiZrxXfORN67MZVPqCmTkdng+1TiwDiAd+7+8aCtinO3cr8H?=
 =?us-ascii?Q?/BE8UlmMud7RfMd7BMACLNRn+GDJEwxlIzKCoXtWgbnryVMNqAiDhjvnJuG8?=
 =?us-ascii?Q?kYehoP7ZO38Opyfc4Hm/8+wlwv0x7IuGhGBs8t07bdx37KQoLd4TXhyXxJD/?=
 =?us-ascii?Q?z+aIoUU9kNiHaxrWbBicl592mG0T2d2FLKuE6Og2XTGNlLK8NMwb9vkGRC6a?=
 =?us-ascii?Q?mCV0PkVFx9tGsouuYgudYt1OXV675mdOfCoCbed7+pP13W7o9upsrzO/l+W7?=
 =?us-ascii?Q?SOzLTwTa+Spt32xj5cQAcPJu7+8UMONXkM7puCiDNRpjXhZoH1y+0+oYiahf?=
 =?us-ascii?Q?/g6EEJZwGG05MfCXX/17U1THEvvRjEBYWB6MtKe5yJsnTjNvYMCfq4H8Zaiv?=
 =?us-ascii?Q?bOb7mpDVRyFLktP8mYD2NoB0+2u/hCwexnD03zg+OCOYPbgS6PPvPqamuZdR?=
 =?us-ascii?Q?25u/sn1Th2FFfITq2J8pKHVZN8E418Mbs5XtI8orwZfB2C43zoxiFRZay7Xt?=
 =?us-ascii?Q?5aUkkXNDuEt8hIb5cniw3af8sFIcxKp8oiF1h3hSF9Tl3nrPHmAYgPlQx9rW?=
 =?us-ascii?Q?hwqNL/Tu8HezBiWXDrsxMWBE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f159a9a-1caa-482e-c4de-08d940f1212d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 02:44:23.9730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IhmDGbFoAlY8zAhN3ihgJeqDA4zYaGVrkiXIJu1ZAQp2UYfvtlgNzalmsDfDKpSTXGG1/39OuoykQGgw6EPBka4dOC0pkVPqNDR4PTvzbxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3863
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10037 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107070012
X-Proofpoint-ORIG-GUID: f8uFnTjJtq2bKzB8aNvTim-L0vP4BYiP
X-Proofpoint-GUID: f8uFnTjJtq2bKzB8aNvTim-L0vP4BYiP
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This is a follow up to the "Add additional MOK vars" [1] series I 
previously sent.  This series incorporates the feedback given 
both publicly on the mailing list and privately from Mimi. This 
series just focuses on getting end-user keys into the kernel trust 
boundary.

Currently, pre-boot keys are not trusted within the Linux boundary [2].
Pre-boot keys include UEFI Secure Boot DB keys and MOKList keys. These
keys are loaded into the platform keyring and can only be used for kexec.
If an end-user wants to use their own key within the Linux trust
boundary, they must either compile it into the kernel themselves or use
the insert-sys-cert script. Both options present a problem. Many
end-users do not want to compile their own kernels. With the
insert-sys-cert option, there are missing upstream changes [3].  Also,
with the insert-sys-cert option, the end-user must re-sign their kernel
again with their own key, and then insert that key into the MOK db.
Another problem with insert-sys-cert is that only a single key can be
inserted into a compressed kernel.

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

This series adds a new MOK variable to shim.  This variable allows the
end-user to decide if they want to trust keys enrolled in the MOK within
the Linux trust boundary.  By default, nothing changes; MOK keys are
not trusted within the Linux kernel.  They are only trusted after the 
end-user makes the decision themselves.  The end-user would set this
through mokutil using a new --trust-mok option [4]. This would work
similar to how the kernel uses MOK variable to enable/disable signature
validation as well as use/ignore the db.

When shim boots, it mirrors the new MokTML Boot Services variable to a new
MokListTrustedRT Runtime Services variable and extends PCR14. 
MokListTrustedRT is written without EFI_VARIABLE_NON_VOLATILE set,
preventing an end-user from setting it after booting and doing a kexec.

When the kernel boots, if MokListTrustedRT is set and
EFI_VARIABLE_NON_VOLATILE is not set, the MokListRT is loaded into the
secondary trusted keyring instead of the platform keyring. Mimi has
suggested that only CA keys or keys that can be vouched for by other
kernel keys be loaded. All other certs will load into the platform
keyring instead.

This is done by introducing a new .mok keyring.  This keyring is only
used during boot.  After booting it is destroyed and not visible to the
end-user after booting completes.  This keyring contains a new keyring
permission that only allows CA keys to be loaded. If the permission
fails, the key is later loaded into the platform keyring.  After keys
are added into the .mok keyring, they are moved into the secondary
trusted keyring.

Secure Boot keys will never be trusted.  They will always be loaded
into the platform keyring.  If an end-user wanted to trust one, they
would need to enroll it into the MOK.

I have included links to both the mokutil [3] and shim [4] changes I
have made to support this new functionality.

Thank you and looking forward to hearing your reviews.

[1] https://lore.kernel.org/linux-integrity/20210517225714.498032-1-eric.snowberg@oracle.com/
[2] https://lore.kernel.org/lkml/1556221605.24945.3.camel@HansenPartnership.com/
[3] https://lore.kernel.org/patchwork/cover/902768/
[4] https://github.com/esnowberg/mokutil/tree/0.3.0-mokvars-v2
[5] https://github.com/esnowberg/shim/tree/mokvars-v2

Eric Snowberg (12):
  KEYS: Add KEY_ALLOC_BYPASS_RESTRICTION option to key_move
  KEYS: Allow unrestricted keys to be moved to the secondary keyring
  KEYS: CA link restriction
  integrity: add integrity_destroy_keyring
  integrity: Introduce mok keyring
  integrity: Trust mok keys if MokListTrustedRT found
  integrity: add add_to_mok_keyring
  integrity: restrict INTEGRITY_KEYRING_MOK to
    restrict_link_by_secondary_trusted_or_ca
  integrity: accessor function to get trust_moklist
  integrity: add new keyring handler
  integrity: move keys from the mok keyring into the secondary keyring
  integrity: Suppress error message for keys added to the mok keyring

 certs/system_keyring.c                        | 43 +++++++++
 crypto/asymmetric_keys/restrict.c             | 60 +++++++++++++
 include/crypto/public_key.h                   |  5 ++
 include/keys/system_keyring.h                 | 21 +++++
 security/integrity/Makefile                   |  3 +-
 security/integrity/digsig.c                   | 26 +++++-
 security/integrity/integrity.h                | 21 ++++-
 .../platform_certs/keyring_handler.c          | 17 +++-
 .../platform_certs/keyring_handler.h          |  5 ++
 security/integrity/platform_certs/load_uefi.c |  5 +-
 .../integrity/platform_certs/mok_keyring.c    | 90 +++++++++++++++++++
 security/keys/keyring.c                       | 10 ++-
 12 files changed, 294 insertions(+), 12 deletions(-)
 create mode 100644 security/integrity/platform_certs/mok_keyring.c


base-commit: 13311e74253fe64329390df80bed3f07314ddd61
-- 
2.18.4

