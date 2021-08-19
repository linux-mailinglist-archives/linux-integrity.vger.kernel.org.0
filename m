Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98AF03F0F51
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Aug 2021 02:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235520AbhHSAXL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Aug 2021 20:23:11 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:13082 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235320AbhHSAWy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Aug 2021 20:22:54 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17J0H5TJ000821;
        Thu, 19 Aug 2021 00:21:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=Q8zi09uI7QI1gkaI7EQikB/FMskiYWbFQjQxjvGC3fA=;
 b=dLC3Ps5KE4fwrKIWSxoI0lLhbekiKSz12n4TlZ/YtTz5L3xppWQxW4yAqeqs3X6CuMD6
 eunVsxEOs/qRpBV01oyFmJJ28NG73EVwG4YVETa7yNSOImjpvS0sNW/kmler123JCgE0
 RIqTplK4ayC6nTI8Xs8V0rTFFjK3k71shB9JHjQ4wVaLzerfVoAACYA+mvj7H7tjkjRV
 Au/WGcYfdTeEcH8nfd4mmjUOSlBgAnHXFd5LBRciW1n0b/Cdn70H2eEeB3pZtTuEhfSB
 1BjQHGahkMcMtPH6cohmIAh/N2ClOtPgXKuglGE0tbZotEHTXh6AtRTGZL40au9XyRPP bw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=Q8zi09uI7QI1gkaI7EQikB/FMskiYWbFQjQxjvGC3fA=;
 b=vVeHBfa/iQFSwnRo2uAKQmkCsg6h9MK1mNUfE31Nk78PmkzzdDhgp/RZWTNxE6t2hp7B
 0p1DFlhImx69rSao74uufdVqy97IYb9pdXMhtSjvHtONxzrq/weqz/rNJ5zzSBOY/xJs
 bFuQyeyyPKfrvIKEcaGJ2rtYF11HGP+b0ANDSAJdKR38rU4oWO2984iIf6t1Lre5K4oS
 iSKDWdXfQ8/1CJQ0faIu2Gxtdcrre9UdSqoWgxxTECOYjqmTfT4z8KVIebU9tTsc4Gpb
 5BAhiSKgrZAZWhr1Bf85ff1Uv36Kr1v3j/jxetTD42/UB9EYqIGkInecJqfONvV7vOLj Ig== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agdnf4dmy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 00:21:59 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17J0FBgh040857;
        Thu, 19 Aug 2021 00:21:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by userp3030.oracle.com with ESMTP id 3ae2y394jq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 00:21:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwUsr++xdJqQ/K/Lg432Xr8IyzPDCOEmylarbSLk8AJgB+5/4I77blaPUSDhznq3QmfyQvxLa2OHZejlchyuVW3iQOY4yAr1ByZ383I0d6BgNFfT3vmbzEwNBZ6DGuktS0GJpDx781uj/VHAnpwO5aCSKHzXU5hlmTHbKC5M+4b2aSDmOhpbelnosRcVBxyehhOxnER5tc0K5u9ObVRQl11zw6HnXGOJS1hLKZbiKcf3tsZMD0V4LZ8xGaDc28UZgoQB64OSP7YhDEPgxt5V61G+zqy2HRBLu3FGgcNa+NRAnq+dGG2o/X5a8FCR1k3q9kLDHGhH+RGPN7thp6PmWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8zi09uI7QI1gkaI7EQikB/FMskiYWbFQjQxjvGC3fA=;
 b=Tc5mj+yIR6hPkuc411q+DhdSpfvThIimqiJZatIeCtkeBZX7Wsn41fZzImi0gBX2i+p88ZS7Sev1T1rjUHXwOSLRToB+29HsUxcwsYtkOqYmcRindgbHrMO2App6tamavn+rgyqZjtpFjwv8+HLL4gnzwe7v3Fc08nHcVfT+wsZX/pZj1e4R/ZAeDjAZsOA7xrljwg/Ey/WGP7Wgp+/9RPsQu3e2XyIywcCy4pd0nZdyeNnSzuyt8OShaId2CVYT2xWRptSSEKhmSbLwJ17tX5/+l4y17MkQOXF9koQ2/6stdDJidEVHqXOrkcpE1HQo8oE6Lc4E6PuSiyi5lT3N6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8zi09uI7QI1gkaI7EQikB/FMskiYWbFQjQxjvGC3fA=;
 b=U9Zsazx8eq2CgogAfp7i+5XnoMUIlTxLgaJ06tv0klD5X2ryJa2gTNlwylX5jQ9tO3A88aL7oFlBDacdRwUhZbcodwsrvS4JXe6do93RlqApBMJyE+ewLPhRGMes7THymh+lDx0qW6c8F15fqb0hrTm9tYEM3Yb4BrrKbad6z5E=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5116.namprd10.prod.outlook.com (2603:10b6:610:d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Thu, 19 Aug
 2021 00:21:55 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15%6]) with mapi id 15.20.4415.024; Thu, 19 Aug 2021
 00:21:55 +0000
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
Subject: [PATCH v4 11/12] integrity: Trust MOK keys if MokListTrustedRT found
Date:   Wed, 18 Aug 2021 20:21:08 -0400
Message-Id: <20210819002109.534600-12-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210819002109.534600-1-eric.snowberg@oracle.com>
References: <20210819002109.534600-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0401CA0025.namprd04.prod.outlook.com
 (2603:10b6:803:2a::11) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.4) by SN4PR0401CA0025.namprd04.prod.outlook.com (2603:10b6:803:2a::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 00:21:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94dd7d35-47d8-4f3e-b58a-08d962a759b1
X-MS-TrafficTypeDiagnostic: CH0PR10MB5116:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB511605630077AE93CDC4CA8487C09@CH0PR10MB5116.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VMnm92QF2B26tbqufBy39HtbaDxCJqSJRZvw9SE4zskOHKBRvOU3OzysqhdQW4rtmL9Aif5NVIwwWWiHvvd6w2D98W20ulQzQdijUPwUJYdMM8CRXLD7btk/DU6Y2AJUR6MJfl0b7yf7TT7F5ugmFi7RCuhFarm7AC2VCu9xEnpJABguNxNdBNYYrh0o5owgnOFeGR8cAD+s3o4vCZgKO0V+cjgHd3voZX6+jkxMozynpWBZVSho+CgKEU+K4qUlJ14bMvEPSMTZJeKxvACJso3r+uFK/FUoGRKe+lfbe0efu8aPEE23pBVW/hlhbIX7pY9segdbeNujKUzJ78yrpAH3H+Cgrt9V5/nKa6VX4xvYg+OTTQCcJjIfr7QmFcTugCvNossP4J6sAWPYppOgJ5oOvPv3hN+fUcY67BEVagBxI1huknKQXLKBqvbKvOy+Ox7TXp4dxoGa01gSjTKooU9UZjEHto3FQITz0OAVL4mij7Pgmnbh0cLnACMXx8EV24dMq0V3y/RiTblaHlJgKc1oqFMmtm1x251kk8DrLJC1ox2AHzipS9Ht6nX2EVm1lojr7ZkAdqDR02DLFc0lhvNPJqkxWPymABwVJylfEhTKB/wTJNX00SO9EHDc9/4nHAuLsZY1WsNk5au2RQWpQCVtKugcsmywwiY4C3/8Avwge/XrHdSYO5y4EFa9Q2DYhEQKW6XXk+lN6D7ULGTsEHc4BqduuHQUFwLn0TKxl6Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(366004)(396003)(376002)(5660300002)(478600001)(6666004)(6486002)(66556008)(66476007)(83380400001)(86362001)(316002)(956004)(2616005)(38350700002)(66946007)(186003)(107886003)(38100700002)(52116002)(44832011)(7696005)(2906002)(26005)(36756003)(7416002)(921005)(8676002)(4326008)(1076003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q/xUSUDTcXWsrr8v0GJABUUpfoBZQkanUsn3v4gaJLsLnagKhVegGo4WRDrW?=
 =?us-ascii?Q?3vR6Bfri+5SVTdaT2hqPJaTSDy5RJSxvGxD8+oN1KZzsltSuObGidibRp2/Y?=
 =?us-ascii?Q?YHFGXhNR/BhbehM+Kh1Itf4C8rW0/P6xuFmTuyknZ7O9QswdE4YXrwYfq/lh?=
 =?us-ascii?Q?doKv8Rik1W7ZNIqp3fz2kG+dm1FKt/8E8lgxu0Vr0f6X/AYKABXsTZEl9Ly/?=
 =?us-ascii?Q?g6TjXUSIAyOwRvfK0ABtXrj6qb7Nud6BsivHjWnBTnBtxyRnioQUOxOg1nFi?=
 =?us-ascii?Q?KJhLLDayPzCVRCYqZcxaFhCyKyu7lS4qw7I86kOPWqeGWHdTMw8Mwk7ba3ci?=
 =?us-ascii?Q?MKbxZHY60KpWufHJcaDNBS6PptEPPlP5NHrXhQOeiIxiTNNAY6SzsrlB1skz?=
 =?us-ascii?Q?EHfnQCQkJk6Pbxo1H0y3XLhLY67HhK7uKAhkbPRh22I2drKULXDKoNUjIx1O?=
 =?us-ascii?Q?EY07PeHqbvDjqsu9T421yL0L8gk/bMrVbodxgI+5IVMVelw3daHuwy8ukThR?=
 =?us-ascii?Q?4mstwRZlswrhDe3uAJuCc8v0mqTHhmCUkOncTL+Fs+sQoh6mC578S6oXkXHU?=
 =?us-ascii?Q?A55YwbpWFsfLIfS+3p6NcRPKGJkBvpxkpLl3PGaLn6WAreAxvjjXw2AAP+tF?=
 =?us-ascii?Q?enkJHb1lPjIeaRdFpKyTFM2hxXeEhEIaZh1/y/rA2c0u4XrC3fhXslBkqwa1?=
 =?us-ascii?Q?quCJzhg5nG7EicixN2yQjt5hVxxtTXJ0tvkCiYr+Wjp7DJGEz+HMr+HqBKz/?=
 =?us-ascii?Q?IeaNa440U/NRBxCHIhOsLrG9ue6dkpKDtQkKC8uIdOxuIM28Qq67OlyiZGyR?=
 =?us-ascii?Q?IwOxxqNaDRgLqLsxkozzZiqy5JMgJSkWq2OHryzbrmwFu3+2hcxSQyzZujJ3?=
 =?us-ascii?Q?hq6ebieqlKmmLRS7pq9vTdwIRLXSLTQ3qmR00aL6yxdcrwel7HSHmla2xT+P?=
 =?us-ascii?Q?fNhepR/IIVSDVUbLoiZVBgWyRwBYbS7GH/1dod5wvh6kQOI3KATbzI3ngUm9?=
 =?us-ascii?Q?WYedvluPcUyZDIdu8+dro9mKTOa7s1VC92QTnQtAk+GHcD0FVkCtSNZQXI0I?=
 =?us-ascii?Q?sfsk/KAoACEK6oKDS6UjOOgf+RLXHQRizvamUQ7RpdSeYcMB2SbUV9JLrGBd?=
 =?us-ascii?Q?nE8VBJEjY2j0eLEJWzzdpCgRzWxxtv4OwWOcO35yqX8akBlxq/9KXHzdU2lN?=
 =?us-ascii?Q?q4utGuRlZ/B+GBw1D0nouL3e2AF46tYKqIPfPn88I/3EPnXnJuyQo3G6R/zL?=
 =?us-ascii?Q?XNvFFB1t0sU8egVT70kNxa8XqZWP8ecpHZS7zHPb4FC+CbGpfT8urlqWhvNC?=
 =?us-ascii?Q?yIXmuuSfOFoSOXLKjTPHfh64?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94dd7d35-47d8-4f3e-b58a-08d962a759b1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 00:21:55.6302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8gpm0Vmt853yjml4wKo5R1mqs1Q20ACmBnTXU4vjFBK/XQKqGQggS53Wq6cS6CSPciQOpgOmXYCUuW/fF8hH15QAW4QXhqx8hOD/CI0Kv1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5116
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10080 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108190000
X-Proofpoint-GUID: 8xD-RxrdYbg5AJmQ0HUZrpcd3M2GFAue
X-Proofpoint-ORIG-GUID: 8xD-RxrdYbg5AJmQ0HUZrpcd3M2GFAue
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
EFI_VARIABLE_NON_VOLATILE will cause uefi_check_trust_mok_keys to return
false.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v1: Initial version
v2: Removed mok_keyring_trust_setup function
v4: Unmodified from v2
---
 .../integrity/platform_certs/mok_keyring.c    | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/security/integrity/platform_certs/mok_keyring.c b/security/integrity/platform_certs/mok_keyring.c
index bcd9ac78ce3b..bcfab894a9dc 100644
--- a/security/integrity/platform_certs/mok_keyring.c
+++ b/security/integrity/platform_certs/mok_keyring.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2021, Oracle and/or its affiliates.
  */
 
+#include <linux/efi.h>
 #include "../integrity.h"
 
 static __init int mok_keyring_init(void)
@@ -40,3 +41,29 @@ void __init add_to_mok_keyring(const char *source, const void *data, size_t len)
 	if (rc)
 		pr_info("Error adding keys to mok keyring %s\n", source);
 }
+
+/*
+ * Try to load the MokListTrustedRT UEFI variable to see if we should trust
+ * the mok keys within the kernel. It is not an error if this variable
+ * does not exist.  If it does not exist, mok keys should not be trusted
+ * within the kernel.
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

