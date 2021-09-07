Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705EE402C72
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Sep 2021 18:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343671AbhIGQDj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Sep 2021 12:03:39 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:6304 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242422AbhIGQDc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Sep 2021 12:03:32 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 187EcutD020831;
        Tue, 7 Sep 2021 16:02:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=NtfnIpQuMh5wq7mxAVtRi1Hn8ORlntMBKYIbvv+NutM=;
 b=mGVOycubz8AlN4m3rBDoTUl9ZcpqMsvUt6i/3y9kJX/FDgJYcENEFhxI3IJkHy5gGGUH
 pI7IJ1wSqs7Nm1jiNYTGwPId1NjEE74fQec0STc7227ihHwUfLf76aLoChPgij26gawE
 AvPjF+JiAmN2FJJyoS9mH2yr7L3sq+HL6uywPKHQilMGiPCa03lGlQy0SvpFbIyv7Oex
 6lpZOkv1ilLdgCtVGe5Yi183yLu96mtsVH3CZH0Y94Lk2Y4Ec2TA0kYTF/KjN7msmj+w
 xMBaF3/yeVfoekmTI0zVtaAKhLwH0qbZ/GctGPCDhcGAtniTfCL5Q5Zq6Ql9/zstQn3o YQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=NtfnIpQuMh5wq7mxAVtRi1Hn8ORlntMBKYIbvv+NutM=;
 b=OA34RjF1d0UQGWCMvgzj+8TSW2EiuspSzSocl+cpaunbWJlhX6lmTxvtANxmh7zeLENJ
 8vLIg1ijAAk6fACvxEbnEZ9VwdTBAHEhB4tXhdI8TKvdt7rYIpZbx5xMTCvFu4RpFPeV
 fSzqK5SFTkEcfIXIwfRuSrVSyTtlSe/KCqoJ+n+xSX3OwF9bvD07sxCw7ItzkmLXDG5S
 9nq0M/bbpHAPqvG47VmfiZcKIcVgkRUTg2MKKU/cenZHUX8kFjdEc2Fi+AFzFX9vku8S
 RX1LfK68XHPBrxj3gyGgQ/KBsdrivEVpb6B7ChThzH4TAHrgyR41X5+hS0pAJlZCJP57 sg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3awpvnah59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 16:02:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 187G0lBG157517;
        Tue, 7 Sep 2021 16:01:54 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2047.outbound.protection.outlook.com [104.47.73.47])
        by userp3030.oracle.com with ESMTP id 3auwwx487u-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 16:01:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDa79B3m7CZZH1IJDNmUXXB0Sa2vZwBEKVqNXpcDN2RYXP+9kNpcMd3iUSahgvNEJmnYLqNT2DUyxeC7qH1U3ZIPdYTgg5us380wM35l8GPfpxfibgcq8+PmjjSdVS87gWAyxziNrGBhO4+ezyCkleN/vd8sHrXKABXwslyuxzTMz1hP3M3kgvM2PmZDmGklm4kdoIa4CGpqgjF9CfPIvhxcqOoHdjxZQP+UTVDgiRaiudLH5W6gKBQDZnwjJM5XMOFN7OmP47qHauCmlncKXwXqJMRUQ/SzvwDH7tZs+fEKbViiHyONfzGT2odKYWxvcUVSJcXW28FfmGGFfRWFHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=NtfnIpQuMh5wq7mxAVtRi1Hn8ORlntMBKYIbvv+NutM=;
 b=VgZrfD8QnbbxUoUHbioL/9kHJKCkhIQpv8+XBHe3MZZmZJbXJl3N6T9aWtakflCDyVN/F33xNEKqW6O8QDUP86c8Nkwa4t3W3vv9UXJzcoL4w61hVb5KmrXlMPAic4mLJj9g7sun2q5S9oPeKmcX9DiAFk6nFSFx3IMLBkRZiQe8LKx5rRDdlhOTOsTjNXr5iVjXIwIogGW1dA7oEOiB3m+t411UroMip45cZw2eqfiRxYWRU6UPcckHUyEtq8nqsSGSA4/7C2uHZafHWl8khUPARYPJkBYXRgHGK2y8O3XAuJxFd6AZH1uTEpndywYP8v+zXqJOK/gCz5ouSfF7kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtfnIpQuMh5wq7mxAVtRi1Hn8ORlntMBKYIbvv+NutM=;
 b=JZidYqvE2D2Q85kXsUdOvO/TwIgdzmTOxWGSPL8sGM1Gv+lx40/Jf9PTwXOQj9CLKIl2GEGArrj+DSxc/zZ+Bo6rO74CMwuMBraez3fR9pf1xIjyvN6QJ6nj9Rrwk9HAMZYJnBaufJVaifk+pPQMw/FdC585HLWFIT2Wmk3OX04=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB4200.namprd10.prod.outlook.com (2603:10b6:610:a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.25; Tue, 7 Sep
 2021 16:01:52 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7%8]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 16:01:52 +0000
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
Subject: [PATCH v5 11/12] integrity: Trust MOK keys if MokListTrustedRT found
Date:   Tue,  7 Sep 2021 12:01:09 -0400
Message-Id: <20210907160110.2699645-12-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210907160110.2699645-1-eric.snowberg@oracle.com>
References: <20210907160110.2699645-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:254::28) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from localhost.us.oracle.com (148.87.23.13) by BY3PR05CA0023.namprd05.prod.outlook.com (2603:10b6:a03:254::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.4 via Frontend Transport; Tue, 7 Sep 2021 16:01:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49aa27ea-065e-4166-1f31-08d97218ceaf
X-MS-TrafficTypeDiagnostic: CH2PR10MB4200:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB42000AADE9E0C03A210F9BC687D39@CH2PR10MB4200.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /N2e7kJMhQhIFm/dtctgwD2yX4wczkNhbFQvX/OfgP1kzFn2c1Mra07i++te7C661OvhP3aiT/yovFrGKflyYC1Bx9m2186Bq7WHsXsyvcLyEGbAZYlNaIOrjKqllZocp50e0gDqDpAgb4JQ1UICuIdwIYHhs35YpFxbGB1w2KZcbEEy9aEkpmFd4uGHtvde3PoHcndrZ8Io6tMfN4XPGKvQktW/Y1HFnH0wcOTtrCb9WhvPKDxCF42w/szpwk9zz3IVfw+ouPtIslLcOdd9t46v9tuwnminBGr1qF4BnyLGlj8dNMv8OfF4WzNvsS8782JJp6flzsF+t8AD4c5qwx01hzyc6Wf/mXpdhxpXZ9VSGp7poa6tcrOnIVLuadl6/+7Y/HR/ZtuxwRRmpXd/Gm2CSTRy0K8TKb7lqgkw+nDxClhfduf7mbQ1XOlOIxQmrwzr1lqIo50xiZuQQDhTmOhYDb+Zg4PLtBkAPKqwvw1L2j+8mnBbXw9zVkNeG4uFVrjvE0C+KKB6wMu9qn1zFYqpia/WPxgIbK95PdRaqkBrY8+N5/oJBoOEU9Hv5Wb8y3B/sGY6Mize11+q5f5V+uTQrfcodTRDl2bSrjrIsB0hkkk0AXTFzFrAO27kqbwFZj0r7nzZI6k88tJLQz68wpOsxRPxAailfEh0TvcIlaperDB2uEzMiElo4/jnJpMNECsyM1jUmV2+w07TCTD/LRPfn/9/zld2p7kdKR6xo5U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(39860400002)(396003)(136003)(83380400001)(956004)(36756003)(4326008)(8936002)(7696005)(38350700002)(52116002)(38100700002)(8676002)(186003)(44832011)(6666004)(2616005)(86362001)(478600001)(66556008)(66946007)(316002)(7416002)(107886003)(66476007)(26005)(921005)(2906002)(5660300002)(6486002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9qGCsmDCwveCSGlkdiqpj2xZTWGaNPOQ+H8uUg12EUHRWGTSk592MCEU6BaV?=
 =?us-ascii?Q?eK9DD0rWuNkLop5fjdztDyDQ4qZzxd+3bXvDFgx+oHEHZg9/mrX2tUDpsiwg?=
 =?us-ascii?Q?ZZ13mqnhUsXWcWpGg7EH61vH6powrTMiss1gKn0DO7qBLq5V1kZrB25NmYN+?=
 =?us-ascii?Q?75b17zBH47NCmj9vh+VuPvdkjXUxNjR7ynLolqf+OWv5srKjej9qIR55s5YF?=
 =?us-ascii?Q?S2Rk6qrCmwb0/Hl0+gJC5wIj6L9Ezb+ZXO9V4Jp2x4xa2gV06fR0RXt4RBmM?=
 =?us-ascii?Q?ldk8nJbQP4bPHfv5dE/nYjmUkTBYRpZluazVToGZyxH2y+VYrdSX8V9O1G5h?=
 =?us-ascii?Q?HiH9SDbATboGYDEiBVn746drjJBjViZf7iJK2B802nMPMbQNMOhVM/Klo1vO?=
 =?us-ascii?Q?KusqnAA/+9oiH8YXJsi7GTRZ5Oz6DQHvIRs+leC7+5IfeuQUOKHyDKVPLeW3?=
 =?us-ascii?Q?7kHQrDCp/PR9pPQKh3LoANiCIfzOQuQzrnhc33csKnZJZnJRowf1M8bbgSy/?=
 =?us-ascii?Q?DfsN+nAwAv0otRKQeF3fZaGP10aaxIOOE8pD0gPqPzI1tH1mIsQv8yVvfZCZ?=
 =?us-ascii?Q?lW98+bGF9IIx8nhNEYONIVRBJACVAjGfo94NWkHEP6jO5iPM224dTEIOu68x?=
 =?us-ascii?Q?9zoXvVMBGydmPh3ym/Bvg/ClcjkSqi8IkNLmvPtQ4NzOvaSwFoRnGUXlZDCw?=
 =?us-ascii?Q?gz9/Kp3GDmL0Oaq8nSyMXNgrugJqrKSjnA+g4fjBcPQPgcFu9MhaX1n2hNgS?=
 =?us-ascii?Q?Po51UNqikC8JZuA5vc3Qw60r9YKL4lHrbPpBgbHiCjqsz/NdLKV/wv5hzgL3?=
 =?us-ascii?Q?uDbhmcaeUhSy0xrlH6zdmojm8v2QB5zJ8KTGRnwtvD/EVaVkUAzVd1wapRuZ?=
 =?us-ascii?Q?cLqHtHAr7yCXspgpemhr/hoEhThzm6qIIv6uIYjQkVad/O8AXtgf/+y4QT6O?=
 =?us-ascii?Q?hyuglkFvngiUTEcKTWeuO1qfJh6zWCZB45xYtrQz4v3l2NnfUGpLbQoPI1zu?=
 =?us-ascii?Q?IQSNfaYYfFi6ilcpy32dGQqqJiMoQDUMGXkhUBgTeZGouGzbMV4ONTiemZKd?=
 =?us-ascii?Q?b0+r9NtcxlYYxGYcNehxQzctUVNTA4alpX8fE7MoLejlPbQH+O7dIX9Ki3hk?=
 =?us-ascii?Q?A7EKil7hA2h+pPSMaVTLM8aaLVBLXpGQe0nskGqdI3evpDRQJv5/FXcG7TGA?=
 =?us-ascii?Q?QeK1gGfJ+SuEf2bInVAGhYY3mX4r6YPW+pi816C5aKPIDrU7xLeaQXIsT6zU?=
 =?us-ascii?Q?e9TKZXPXZL0BiaAnWc3iQPVSSZvoo5XZIDlpnOyrXFsW5gMuzLjgeCr0nqd1?=
 =?us-ascii?Q?1UQIfbZSt0VnpnAQ6zag0jHO?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49aa27ea-065e-4166-1f31-08d97218ceaf
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 16:01:52.4559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1anpfStc0DTBqRwQJ0XBW5WGDjI7GMIA6iBkAwmuJpyqdjdEdapsh7PDy/cRG6KrWQlqFU5T0jrf/E0tPFa/bwUIu6VGgvc/TVprmuDeqXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4200
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10099 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109070105
X-Proofpoint-ORIG-GUID: 54Y213nLVigV26R-yZSRDXtLuSLBm1f_
X-Proofpoint-GUID: 54Y213nLVigV26R-yZSRDXtLuSLBm1f_
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

A new Machine Owner Key (MOK) variable called MokListTrustedRT has been
introduced in shim. When this UEFI variable is set, it indicates the
end-user has made the decision themself that they wish to trust MOK keys
within the Linux trust boundary.  It is not an error if this variable
does not exist. If it does not exist, the MOK keys should not be trusted
within the kernel.

MOK variables are mirrored from Boot Services to Runtime Services.  When
shim sees the new MokTML BS variable, it will create a new variable
(before Exit Boot Services is called) called MokListTrustedRT without
EFI_VARIABLE_NON_VOLATILE set.  Following Exit Boot Services, UEFI
variables can only be set and created with SetVariable if both
EFI_VARIABLE_RUNTIME_ACCESS & EFI_VARIABLE_NON_VOLATILE are set.
Therefore, this can not be defeated by simply creating a
MokListTrustedRT variable from Linux, the existence of
EFI_VARIABLE_NON_VOLATILE will cause uefi_check_trust_machine_keys to
return false.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v1: Initial version
v2: Removed mok_keyring_trust_setup function
v4: Unmodified from v2
v5: Rename to machine keyring
---
 .../platform_certs/machine_keyring.c          | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/security/integrity/platform_certs/machine_keyring.c b/security/integrity/platform_certs/machine_keyring.c
index 948ec6c738c8..635ab2b9e289 100644
--- a/security/integrity/platform_certs/machine_keyring.c
+++ b/security/integrity/platform_certs/machine_keyring.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2021, Oracle and/or its affiliates.
  */
 
+#include <linux/efi.h>
 #include "../integrity.h"
 
 static __init int machine_keyring_init(void)
@@ -40,3 +41,29 @@ void __init add_to_machine_keyring(const char *source, const void *data, size_t
 	if (rc)
 		pr_info("Error adding keys to machine keyring %s\n", source);
 }
+
+/*
+ * Try to load the MokListTrustedRT UEFI variable to see if we should trust
+ * the mok keys within the kernel. It is not an error if this variable
+ * does not exist.  If it does not exist, mok keys should not be trusted
+ * within the machine keyring.
+ */
+static __init bool uefi_check_trust_mok_keys(void)
+{
+	efi_status_t status;
+	unsigned int mtrust = 0;
+	unsigned long size = sizeof(mtrust);
+	efi_guid_t guid = EFI_SHIM_LOCK_GUID;
+	u32 attr;
+
+	status = efi.get_variable(L"MokListTrustedRT", &guid, &attr, &size, &mtrust);
+
+	/*
+	 * The EFI_VARIABLE_NON_VOLATILE check is to verify MokListTrustedRT
+	 * was set thru shim mirrioring and not by a user from the host os.
+	 * According to the UEFI spec, once EBS is performed, SetVariable()
+	 * will succeed only when both EFI_VARIABLE_RUNTIME_ACCESS &
+	 * EFI_VARIABLE_NON_VOLATILE are set.
+	 */
+	return (status == EFI_SUCCESS && (!(attr & EFI_VARIABLE_NON_VOLATILE)));
+}
-- 
2.18.4

