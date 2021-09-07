Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF526402C6B
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Sep 2021 18:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245745AbhIGQDi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Sep 2021 12:03:38 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:1978 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237991AbhIGQDb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Sep 2021 12:03:31 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 187EdQXl026795;
        Tue, 7 Sep 2021 16:01:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=KzDdMYhzeswXIU+JmDGR/uvceM9RZfHu29/g4qBZ89I=;
 b=C1SX34dfduOz+7bD+e/cpTqJtn1Ut1WxHKuCdj0Bh/4cm+FwUVpdV6PDJDWKDB3QJG13
 O//ahi1daDyeMYsOYhWfB7Fdwyr5AMWkZnFv0oIW++AYMecr9CTS5zMmSb/1CNIzVllW
 WPqBXZhSp9C6r+/r6jJxRvM4zbYULX9owTTOQdBwrNXqWF0sv2kmebRAvSnETNhaOHWe
 tEyaugxwh+TH630vuBc6So2HtmbK4OiW/wPjkAzUm6jJ4691hh7qc4zVeiHb/y3DZZze
 qesLM0MOiFnLWU7XzM0NW/iy5vcDIObpbaKgw+HAQeq7jmOBiWRvFWx03sYAjBFOQJs/ TQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=KzDdMYhzeswXIU+JmDGR/uvceM9RZfHu29/g4qBZ89I=;
 b=Fmni1mpWYepvRgZ8vLR0xEPRkEUZWVykcB7LMGknbAeVw25cGBrC8GMbTgBe2drO+v9l
 yQoBgzGuivv4hQQaMXmqeVs7Vcnhp4AoZa89ePaxBeyCx/g+fqIdUTsgA3F4q8M81cam
 dxUs1Z0cBjVyoubtMFX76s8iZfSPGqqbZ1ZCas0hKkwrNepAuSs7QHmauX56XoPFLWV3
 +1DvhanKPWlX89lc7kgbx27hqbUlIDk6E7if9ah7vfEu7JxSzvqlhWNllY9mn9v4wQqA
 nozKTP1BuvXKVJsjWVyyMGfffUFr7AC12xRDePUArVW41c8FnleiFU7m1pZnPtYaCkvJ NA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3awq29jg0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 16:01:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 187G0GTR134812;
        Tue, 7 Sep 2021 16:01:31 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2049.outbound.protection.outlook.com [104.47.73.49])
        by userp3020.oracle.com with ESMTP id 3avqte3cy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 16:01:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JxWVq1kusJWHz8ermZZwGGfMUg7oVaSNhxzaAEsYQ4JlTAjAzm2TG5ssTvRXFLYiem0yjNWO+6amlul+VBl12nGHneN8h1ixgqvXTa4jz5wREX4SAuoXMVX9ZQHWKJPVt7U0zg3ANG55WciGqqrl/W0By3/RKGfSrfIip7nZVljTjckY9R7rd7IjDfmLNFnYB/kaybn/ngAZE6aKraQsxKobpmdgdYrksZAwdwKy82YQWPnr67aRAByOdyc7bW8tFHharnQwpcMITtsUhguEiY6BYj4/5/P+cP0E3G7PhIAeQqDFFHVwlYR1jZKzcMnP43zU3hwnDA+ZcDchhAyG6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=KzDdMYhzeswXIU+JmDGR/uvceM9RZfHu29/g4qBZ89I=;
 b=UFl1tnWgeycr1zNofse5QUJ2PCFtz8/8Jbp+MUATKFr5wlatHfT0QnJmJvBXFO92o9YN8vUftLEBDIJKNjVtAWYoyJyL8amRVINemTbo3vM+x6HRwMT62zOQT3uTmGqgeaR7Bs8OHpskF7mCFsH3//2mL8sCZiG//serOcpG+mfRCc2g5Y/i2ZJEROSyVQedCnL1+2UDe2Lj9fx3at57izjBysM3mDoCGQCpN12saGulnSQDHsjf9RCsM1YIDKDN3znHxl9Ct9lGsl+KGVRv21lfCeYaLBfpUqrci8TSRFoRP8uUwYkxLq6osmnkbxzb9Q6WFdd7GBZ6LALjj+n+2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzDdMYhzeswXIU+JmDGR/uvceM9RZfHu29/g4qBZ89I=;
 b=ng892xI8mkS2PCF8D74ZAtVbYB9I1iEh7lsKyM7sCVutGb6FkjzTN70zxop3uM6fxQAVsnrK5cqUjpnebT8WUhmLgN+yadtF8xU70RdRHaoMspwvIEF7d/crk9ZkNFciCPjOUJJupIuGrIblueGgSTwRs35ul4dg2cUyEoceIBU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB4200.namprd10.prod.outlook.com (2603:10b6:610:a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.25; Tue, 7 Sep
 2021 16:01:27 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7%8]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 16:01:27 +0000
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
Subject: [PATCH v5 01/12] integrity: Introduce a Linux keyring called machine
Date:   Tue,  7 Sep 2021 12:00:59 -0400
Message-Id: <20210907160110.2699645-2-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210907160110.2699645-1-eric.snowberg@oracle.com>
References: <20210907160110.2699645-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:254::28) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from localhost.us.oracle.com (148.87.23.13) by BY3PR05CA0023.namprd05.prod.outlook.com (2603:10b6:a03:254::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.4 via Frontend Transport; Tue, 7 Sep 2021 16:01:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a65e98f-84ee-412f-1a4f-08d97218bfbf
X-MS-TrafficTypeDiagnostic: CH2PR10MB4200:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB420000575A0A2F794C7B440387D39@CH2PR10MB4200.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /UXTYPRzQ7KFCOWANg4PANPfX9oDm6FcupN3aFgSHN8YA7DQp6glRGxzkX09irPKk2aHCQJ/Tvt0aInuXLTBpRXi4daNv4TPhHafRDuT5cuyYznx0mgt/9SddOgrV6rLYYr0yVon0Yqm2XG5MXJQsclaSWXkTzJQoLpXtPWqlSDCBnYGofZdBO2cuofGe0EmJ33mnE1QqOSKSiqRZcK0NoDffP+PJX96s4YPcjY3TBYKtZkK4DRBBaEGebFHq0x+p5Q/crKZb6exYtKpBLTHrMXBhUB0G/5gCTCjTGFGMtzP1xszSe8xNF9Dc0bp4Tjd8XlINqu/HIgpmQpCOH7+pAyyytOh4W9ST2X1drx7CJVSSjtp+mGGhS8aK/pjkJVIoFrWPI+6BEsCy1XS/L5ye6T5MzcJsRPqTGu4hg1M8z+UjfJE10hBJnG0NxM7JwrOwJFD7F8WkLX9fezRc0ZiI2OXqgKmXEBtzeqBt7dBBTej5fhaJ88Q+Ro8GJEdbYTJznZqEyTgML0uFqjQmJj205UnK7XcvwtVhQ90LuKzKcDqRdZAUU7SNA96Xfwh+J1I/u5MnHZ4zacDZ0MtxSYOxTf6OLg5LQto3BlVFG3AWe7bEohlkCDkq54EydgMSB5ZhF3eLZ9jFl0qUeWUWh24M9VA5DhvZFuAQvKvDvFKJdsslRoF2n0QEOF4Q9+iPs+LbTk0ZpMX94yRI2BBV8JfRRdNB7wJRCONiCGbXq+d8OQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(39860400002)(396003)(136003)(83380400001)(956004)(36756003)(4326008)(8936002)(7696005)(38350700002)(52116002)(38100700002)(8676002)(186003)(44832011)(6666004)(2616005)(86362001)(478600001)(66556008)(66946007)(316002)(7416002)(107886003)(66476007)(26005)(921005)(2906002)(5660300002)(6486002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?030CZV1xWF9rfOnZweVU+eKKdrG4HWUqDOyLLTJ/J6d89dPGUR321cF231LD?=
 =?us-ascii?Q?QUoVQaQhqO+8k35qLhK1ev6+46IXk+ni4+7SzNDdeimHtZqgnGOqUB18kGph?=
 =?us-ascii?Q?/7YxpkmdmuEGBrJlpFLHE9WKrBf8ZTwDJit9AoqkAZgwmORW4yby/Glf/Yl1?=
 =?us-ascii?Q?59XoNj3QGmFBPUw3QZW1ayoUdJGdXKkrBsTOfJLMu1A0/vIW+Tw6WqgjPtvS?=
 =?us-ascii?Q?qWMMY4fuYfwIXjo/CAUf5iZJ3y/O5ViyalLiJCds2kXyU9+rM+C7t8nuHs1M?=
 =?us-ascii?Q?phAmYuGzH5/35iBjmRVtsCMBgww/9h9NT4lPnNaAAak9zBNTC+3MbfCiYQ+l?=
 =?us-ascii?Q?T+/oPXXOr2X+U9UqwX57cMRvu9fcQXdDvKv6OzaS3hzjXi4T/ICcwVPUlr82?=
 =?us-ascii?Q?gnSAh33EfiZydQ2AbuU5b0xlwiZAxgKA5hGSJphd7qfK4zlJFr3VNeL2AUIo?=
 =?us-ascii?Q?HjDIMa6/n5RKScLbtv/DKINkhAAhskMjtEzVoHwc/jL7uW6nilAd+0jryz3D?=
 =?us-ascii?Q?oihsxvclijU0zsg12fxvqqsAjU9N1bcAqhA8ZzSP165ZTWxnkfFdCRtFiFsu?=
 =?us-ascii?Q?PsktyXGeuC9M0Lk0ezZ7QNY1lEp3A+Ew9JARpmP8YpzFbfzwY5LZdKSZFGaw?=
 =?us-ascii?Q?YmfuDjpr12sDqtkNgjwICPS5yev83tpINYecS1dacTEVwY5sO3CyIo+P0JIc?=
 =?us-ascii?Q?u4Gfp6iEy4oNw8BOSkxvPOrlwsWWa5Zs04d4mXHkjMry80f94AlHqhwZG8eq?=
 =?us-ascii?Q?zjFgz/E7l5GSOK2KOLz3KMvjXcnnZfnwHbWxVAC+639sYh8SFe8QFR73N96/?=
 =?us-ascii?Q?aaaYKGpxtznLvyqIsyhM1JFaK1c8YQDQb966I4PoH3M/xHt62D/6gbnScM81?=
 =?us-ascii?Q?9pyRh+JQuOj1RmNoSl6P3TUOxieQfhl4t/JKhEB107Rp1PqasFDJYEQAEukI?=
 =?us-ascii?Q?ikvRIE3Q3TxkgQJQZtAL45LGPPNGHuH/iJ7ucyVCYXzuk17gUl9oGZZqszLT?=
 =?us-ascii?Q?AcFqg5uUvqaW4RvAzHXEfp6Ubkn0ZvMLVAw6EJqZ9Gm0WhL8lP2DUSwHRDPB?=
 =?us-ascii?Q?knqAdl8NnzBzMM6cBI7310DSp6XFyoMNXLFpxX0/T6qxt7migY3L6VdvZmwC?=
 =?us-ascii?Q?07h+Hh7cAq06GyP5hgF1JxInh+2DBPnuJKhnCh53zp3cHXURYE4xiaBUtsY3?=
 =?us-ascii?Q?ARTK+yALthnJfRqSNTwA2f79+94qu72oqouq8okr5E0iA5d+rhOM17SmzGFL?=
 =?us-ascii?Q?/3nDRXISsZlc7/1UA1wDZePD5sYzpd28TfzVk0INnDKn3CpZ4Oyp/PzrYCnH?=
 =?us-ascii?Q?er4Y1a0x+YbfkT1SBebOVWCP?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a65e98f-84ee-412f-1a4f-08d97218bfbf
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 16:01:27.3042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LPIBoiEXX1jJTdg+XyKNP55VVzifz/7N/tOkTIr1j0jQgmN8wbBUS5UmCF60E03oaSkOAzrZGlWjf9ZePqRRFg/2kB1tQUJNBsXlcgiWCTA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4200
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10099 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109070105
X-Proofpoint-ORIG-GUID: suCbH4AdxMCNRgtAAlMJVlH581jZSUrM
X-Proofpoint-GUID: suCbH4AdxMCNRgtAAlMJVlH581jZSUrM
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Many UEFI Linux distributions boot using shim.  The UEFI shim provides
what is called Machine Owner Keys (MOK). Shim uses both the UEFI Secure
Boot DB and MOK keys to validate the next step in the boot chain.  The
MOK facility can be used to import user generated keys.  These keys can
be used to sign an end-users development kernel build.  When Linux
boots, both UEFI Secure Boot DB and MOK keys get loaded in the Linux
.platform keyring.

Add a new Linux keyring called machine.  This keyring shall contain just
MOK CA keys and not the remaining keys in the platform keyring. This new
machine keyring will be used in follow on patches.  Unlike keys in the
platform keyring, keys contained in the machine keyring will be trusted
within the kernel if the end-user has chosen to do so.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v1: Initial version
v2: Removed destory keyring code
v3: Unmodified from v2
v4: Add Kconfig, merged in "integrity: add add_to_mok_keyring" 
v5: Rename to machine keyring
---
 security/integrity/Kconfig                    | 11 +++++
 security/integrity/Makefile                   |  1 +
 security/integrity/digsig.c                   |  1 +
 security/integrity/integrity.h                | 12 +++++-
 .../platform_certs/machine_keyring.c          | 42 +++++++++++++++++++
 5 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100644 security/integrity/platform_certs/machine_keyring.c

diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
index 71f0177e8716..52193b86768a 100644
--- a/security/integrity/Kconfig
+++ b/security/integrity/Kconfig
@@ -62,6 +62,17 @@ config INTEGRITY_PLATFORM_KEYRING
          provided by the platform for verifying the kexec'ed kerned image
          and, possibly, the initramfs signature.
 
+config INTEGRITY_MACHINE_KEYRING
+	bool "Provide a keyring to which CA Machine Owner Keys may be added"
+	depends on SECONDARY_TRUSTED_KEYRING
+	depends on INTEGRITY_ASYMMETRIC_KEYS
+	depends on SYSTEM_BLACKLIST_KEYRING
+	help
+	 If set, provide a keyring to which CA Machine Owner Keys (MOK) may
+	 be added. This keyring shall contain just CA MOK keys.  Unlike keys
+	 in the platform keyring, keys contained in the .machine keyring will
+	 be trusted within the kernel.
+
 config LOAD_UEFI_KEYS
        depends on INTEGRITY_PLATFORM_KEYRING
        depends on EFI
diff --git a/security/integrity/Makefile b/security/integrity/Makefile
index 7ee39d66cf16..d0ffe37dc1d6 100644
--- a/security/integrity/Makefile
+++ b/security/integrity/Makefile
@@ -10,6 +10,7 @@ integrity-$(CONFIG_INTEGRITY_AUDIT) += integrity_audit.o
 integrity-$(CONFIG_INTEGRITY_SIGNATURE) += digsig.o
 integrity-$(CONFIG_INTEGRITY_ASYMMETRIC_KEYS) += digsig_asymmetric.o
 integrity-$(CONFIG_INTEGRITY_PLATFORM_KEYRING) += platform_certs/platform_keyring.o
+integrity-$(CONFIG_INTEGRITY_MACHINE_KEYRING) += platform_certs/machine_keyring.o
 integrity-$(CONFIG_LOAD_UEFI_KEYS) += platform_certs/efi_parser.o \
 				      platform_certs/load_uefi.o \
 				      platform_certs/keyring_handler.o
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 3b06a01bd0fd..8c315be8ad99 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -30,6 +30,7 @@ static const char * const keyring_name[INTEGRITY_KEYRING_MAX] = {
 	".ima",
 #endif
 	".platform",
+	".machine",
 };
 
 #ifdef CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 547425c20e11..730771eececd 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -151,7 +151,8 @@ int integrity_kernel_read(struct file *file, loff_t offset,
 #define INTEGRITY_KEYRING_EVM		0
 #define INTEGRITY_KEYRING_IMA		1
 #define INTEGRITY_KEYRING_PLATFORM	2
-#define INTEGRITY_KEYRING_MAX		3
+#define INTEGRITY_KEYRING_MACHINE	3
+#define INTEGRITY_KEYRING_MAX		4
 
 extern struct dentry *integrity_dir;
 
@@ -283,3 +284,12 @@ static inline void __init add_to_platform_keyring(const char *source,
 {
 }
 #endif
+
+#ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
+void __init add_to_machine_keyring(const char *source, const void *data, size_t len);
+#else
+static inline void __init add_to_machine_keyring(const char *source,
+						  const void *data, size_t len)
+{
+}
+#endif
diff --git a/security/integrity/platform_certs/machine_keyring.c b/security/integrity/platform_certs/machine_keyring.c
new file mode 100644
index 000000000000..948ec6c738c8
--- /dev/null
+++ b/security/integrity/platform_certs/machine_keyring.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Machine keyring routines.
+ *
+ * Copyright (c) 2021, Oracle and/or its affiliates.
+ */
+
+#include "../integrity.h"
+
+static __init int machine_keyring_init(void)
+{
+	int rc;
+
+	rc = integrity_init_keyring(INTEGRITY_KEYRING_MACHINE);
+	if (rc)
+		return rc;
+
+	pr_notice("Machine keyring initialized\n");
+	return 0;
+}
+device_initcall(machine_keyring_init);
+
+void __init add_to_machine_keyring(const char *source, const void *data, size_t len)
+{
+	key_perm_t perm;
+	int rc;
+
+	perm = (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW;
+	rc = integrity_load_cert(INTEGRITY_KEYRING_MACHINE, source, data, len, perm);
+
+	/*
+	 * Some MOKList keys may not pass the machine keyring restrictions.
+	 * If the restriction check does not pass and the platform keyring
+	 * is configured, try to add it into that keyring instead.
+	 */
+	if (rc)
+		rc = integrity_load_cert(INTEGRITY_KEYRING_PLATFORM, source,
+					 data, len, perm);
+
+	if (rc)
+		pr_info("Error adding keys to machine keyring %s\n", source);
+}
-- 
2.18.4

