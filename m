Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B215386D64
	for <lists+linux-integrity@lfdr.de>; Tue, 18 May 2021 00:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344166AbhEQXAB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 May 2021 19:00:01 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55622 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240090AbhEQW77 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 May 2021 18:59:59 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14HMqPh1019678;
        Mon, 17 May 2021 22:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=doW6z1eSes/D926NuQINs2SpAlpC4CXIsIYqzBBo8C8=;
 b=ej2QLREPtlV9hBMEtpoy3Ta1krLJDIJ70mkil2Ytrt5vxz2e9b/e4nqo/bw4XMf8AI7T
 jI0RSxqO3gkCg+HlsbDboHi4DW6d5nGEJ2dhspNOPeLTKxROmHimM6P/sfWvY1ai/nwK
 0TCGvXqaor1Wj7oALM+bbcI4/wSVUkrkZKKkcwKd/Wyd2rmc+cen91glCaaVjLBTDsM6
 lCfdFSLFJdTZNu0IDUs7ujlgIxuHsSc9NS+f3DdKjILAuOQhIgPbp1Em3aHEfOcZI0GR
 JAzjaJpp3v9uzNeJt0cAvXnmhchzLwuqYOmeEFJ5W2mnin2/OJ7O6ldS/3kqRWJwezoj ew== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 38ker18dmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 May 2021 22:57:54 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14HMvpIe154682;
        Mon, 17 May 2021 22:57:52 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2174.outbound.protection.outlook.com [104.47.73.174])
        by userp3030.oracle.com with ESMTP id 38j3dtss8w-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 May 2021 22:57:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYkBnMEMWGftKSAr4BoOd0UgWip88WqO+32F0lScXMWP08ZhNWJawEIj0RvMC35+ld88YISoC4AIske9z0dLjmcdZ9Ec1XU3aV/sZZgItLUdWfI1Inh9rB6BYC2HRF97M5OlYrgQ8/RVMCbxqGsfP5z5TGYeJJW3yCVprTK+cGJGsFCfQAT1c2ObfUbU0vrMsCqk7Q24w24GgthW2/dyeTR+zSCvSSuAr7P1sJM08tE/kz4flD7/eI3b2ZhdD5fBCMiRZIv1wkNaY3/zURvv+jGNPjeknDDRVQ9KY/xAJdy8wmE58PxPnNyiR1aNab994Yma00J/RHTfQZ/4JmA1Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doW6z1eSes/D926NuQINs2SpAlpC4CXIsIYqzBBo8C8=;
 b=FoFPaTogXrDO3ai2812qQUsaQFQ79097cwtDlwLV3AdiQU0hDbD2W+8G03BhVLHq/CjxsMTt1Sy6NTyDH7xsJFcKvbp3TmmxjDYFTq+TGc7HIMej7liNcEc1zRl4Y0MM8hUKX7/6yuR5IGaEYYn42Mab3wfpNORbDZB9yw1SA9wzxbRwjRuzgj9ipG46ynwKrNV18nIQqZu7MjyblqSY1/PMf50K4nL8+w8jP1CswfjHkBNd4SYsGctTLG7wZGzDGxmMFvANzPi6X6Cp2uHmfjPd8KksKqJDiOb4qJwF9M95ycb22hDFfLwD4cnsCXAnj9/snekcnIOKPAUBz+9x1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doW6z1eSes/D926NuQINs2SpAlpC4CXIsIYqzBBo8C8=;
 b=m3gA5ogQX5oi3bNhbBfmtsu6DQ04K3O2JKOEuTRCIh2/XfUxeZJ/sdIlhQhgLIeLXA3HEqkIOqLNoEFq3uoRzApsnUJd9E99dfZiVh+RMrrYNS2kqnAMfKykKUqxdiPKU/c6HztbPmG0KR0IFlJ/wH+wkYeVmvAyzTUifznjLmM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB4328.namprd10.prod.outlook.com (2603:10b6:610:7e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 22:57:50 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::99fc:aabb:5cff:b177]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::99fc:aabb:5cff:b177%3]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 22:57:50 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
        jmorris@namei.org, jarkko@kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, zohar@linux.ibm.com,
        torvalds@linux-foundation.org, serge@hallyn.com,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        glin@suse.com
Subject: [RFC PATCH 2/3] keys: Trust platform keyring if MokTrustPlatform found
Date:   Mon, 17 May 2021 18:57:13 -0400
Message-Id: <20210517225714.498032-3-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210517225714.498032-1-eric.snowberg@oracle.com>
References: <20210517225714.498032-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-Originating-IP: [148.87.23.5]
X-ClientProxiedBy: SN6PR16CA0059.namprd16.prod.outlook.com
 (2603:10b6:805:ca::36) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.5) by SN6PR16CA0059.namprd16.prod.outlook.com (2603:10b6:805:ca::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 17 May 2021 22:57:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d83b15b-6a8b-4d25-9c6a-08d919873242
X-MS-TrafficTypeDiagnostic: CH2PR10MB4328:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB4328007AF6BC19C63F1416F8872D9@CH2PR10MB4328.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j8Wozw6FjfQ8ByMOffeY7Rc68Lb/wVFgLB1VZ1mNxqh7ZuTmRyymLzK4j8eM5XJCbHLLGHDSkh1xUhUXjBoBjlLFKyR3b+/OdotuGkPwxPt3yXwhFpW4mAxuIaDFoJYr7P41j/phrq1FLTXFi5n9JfI6DXLfRuH6nldeKhHmPL0mNTxETJ90fv67Gcs/UYLB1hpcus6+5m0bKZ4IGaZt/TNa7+WboVV5OBcwdEWqS+CrHNX85CAe8TN5r6B5ctAn1/ndfNgsoajCZnDc59Mze1kRqQHDkUG5bsdK4sHFLmYrH52rhM1crmhQb8SzGrwUsrY8yG9UbMyTPKnS3twC8XVqYHi2AN/msttDSfXf+aB/E+vLy600ZhU2qulHjUsHhBkPgIteqSdpYl+Rsk1ic0b044Zf3zF4s8mm4Ho8HkExM3V8n69cJ1tj3CH4hZ4tbdfe+BNkXkyiC8T0xpoQs6txs4rIGuQHS/+n8OWqORTS1ckQoV2cVP6KeFRu4QCPhtV0pOGzer3pu2RKfIwUp3CSg8gwfqCPw1R/pKNxVTq2pLYMHGkXc+SuqACYgowJ1mA9Tcr+CnUAbx2QONpWDSgBIK0FaoNLYchsevXqLEObAbVdKG9Ob1lOX8S+96oi8IP0kQPAjGDzH8An0oaWpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(376002)(366004)(136003)(396003)(52116002)(7696005)(66476007)(5660300002)(66556008)(316002)(36756003)(66946007)(86362001)(6666004)(8936002)(6486002)(38100700002)(2906002)(44832011)(38350700002)(26005)(186003)(4326008)(83380400001)(8676002)(1076003)(956004)(7416002)(2616005)(16526019)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?TKGVnyZyCbjldzWBSI4DZr579a/H1BibVAoFe8a5ixLAPm5xCoZCSiAVLczt?=
 =?us-ascii?Q?JS3O4dWcHBPuuYDxXVZ74nrJOJEEYb9EkxRofGBGEPF6bAzTYCH39EC9fbyU?=
 =?us-ascii?Q?KtYhFOj8zONU5m+9IhcYpGLFyRjZgfCbXgxg3ZnNxhdAFZmavLsgmaSaoJkO?=
 =?us-ascii?Q?5xSzdRp7eM/vudiK70riJkl1WcnikqGaIbOzwubgGwgnTCw1HBWwkkSq2WKP?=
 =?us-ascii?Q?EKFY2F8shm9rXSgO2xyc6tHWkEFbxr6Ds+YXJUCvLl6z0O0e3cQG15bhx4Mb?=
 =?us-ascii?Q?8dg9KuV3nWzt5Nk6cgqgyA2G3HI0O28rNdxlBTDpc2mD9cyvfYgsnZwsy8jW?=
 =?us-ascii?Q?PMsLSPMIT/166aJOuDSPDpgTg+GNmAgruzaffXL1oHmeS6zsdCjLHdQByAyL?=
 =?us-ascii?Q?Z6G1c/2H+r163nvFdy5f/Hh1EaVnifLKBx5wNA4EiAQWWhfLeOxfhtorVUsb?=
 =?us-ascii?Q?2TYZwsODw+0ZHNI45hCfRXDB6fakafS218C0uKmIVTcMotyqH0THkStd8pb3?=
 =?us-ascii?Q?MqdTS4FClQrF0UIWhpm9TvyY9iPUi7TZZ5fnJOylw0byDlUQZTit5tJf7Y/c?=
 =?us-ascii?Q?ngcMrGhfjTdNyChFaHwdU48oJ7RC/V7HBhaKof/eWannh/VrJ7pmAghZS3GA?=
 =?us-ascii?Q?2nV5l2gyjhp9U0nLFTR+/05YseScSQOYd4HkALOM9PtlqRj2RudUhSWYm7wB?=
 =?us-ascii?Q?WR/Wr8BxmsOz44VIuqq+MlZGNVsjyScTyJWCbOGa412R/lps3mIFeL1Gh+vQ?=
 =?us-ascii?Q?eRKMytsTDc3OwwHU9FNhOpWYLSGajMCdVjRpMOrFSTnTYsU+S45Vx6m8uLHM?=
 =?us-ascii?Q?d8MvBqcH8bdcoT3RpJ5YEgik8tVk4UfdzdoPYCe3mc9yf8smf4+87EQKQN0z?=
 =?us-ascii?Q?rRjfL9lMZOXtE8fVTvkUOJTWNDysrRus7MP17JoHwZZpsU3HXJ7ttFCRdc4m?=
 =?us-ascii?Q?TpYL3mWz9Koow8d5MV5wY7bhIjoJfqEj0BYP2pLbSdkpY8zSjhLDd/vC5/y0?=
 =?us-ascii?Q?zChtab6LUCdilGlR5HOumAPU1vffAu8Och1VJJeUQTnJeWAD92mFCMbPzefZ?=
 =?us-ascii?Q?Ge1HTXBaE6VtvCv/VtrYZh9b3EQwG33PjJ5SezLlytPta+KrLkLuba6xfRjR?=
 =?us-ascii?Q?4CmduwpGlR6JQrENcqcgZB0SXjy0iPc26KPbqfXQLb6SNd1iUan8yfX0ZVgv?=
 =?us-ascii?Q?oHHeCyLhmlcCnpiMttQEo51XRsKPIbgi33fcG05QMIgWj6Ssi51HC/p/4OVm?=
 =?us-ascii?Q?OEZxPfIw2kDjxf45TjuZG/e0bIWODAmgZw8omCj1kXilSYhKE73fJk1tpH79?=
 =?us-ascii?Q?ryJlZtyIV/yiRM63dw7CT5lb?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d83b15b-6a8b-4d25-9c6a-08d919873242
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 22:57:50.5694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gvDenO6OV8cf89xkR6s3PL2qDyza5X/DwXqFUce6X7ht09TQHk3hGcJcpF2RnqcEtZAQ/IQWmaNjniFq9JRLuRHldICJ111SB9A9uPFt2oU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4328
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9987 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105170162
X-Proofpoint-GUID: C830sk42bVyOc7CsJ6Aa0ddVfl6CeMVJ
X-Proofpoint-ORIG-GUID: C830sk42bVyOc7CsJ6Aa0ddVfl6CeMVJ
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

A new MOK variable called MokTrustPlatform has been introduced in shim.
When this UEFI variable is set, it indicates the end-user has made the
decision themself that they wish to trust both UEFI Secure Boot
DB and MOK keys within the Linux trust boundary. It is not an error
if this variable does not exist.  If it does not exist, the platform
keyring should not be trusted within the kernel.

MOK variables are mirrored from Boot Services to Runtime Services. When
shim sees the new MokTPKState BS variable, it will create a variable
called MokTrustPlatform without EFI_VARIABLE_NON_VOLATILE set. Following
Exit Boot Services, UEFI variables can only be set and created
with SetVariable if both EFI_VARIABLE_RUNTIME_ACCESS &
EFI_VARIABLE_NON_VOLATILE are set.  Therefore, this can not be defeated
by simply creating a MokTrustPlatform variable from Linux, since
the existence of EFI_VARIABLE_NON_VOLATILE will cause
uefi_check_trust_platform to return false.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 .../platform_certs/platform_keyring.c         | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/security/integrity/platform_certs/platform_keyring.c b/security/integrity/platform_certs/platform_keyring.c
index bcafd7387729..d2731182e511 100644
--- a/security/integrity/platform_certs/platform_keyring.c
+++ b/security/integrity/platform_certs/platform_keyring.c
@@ -13,6 +13,8 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include "../integrity.h"
+#include <linux/efi.h>
+#include <keys/system_keyring.h>
 
 /**
  * add_to_platform_keyring - Add to platform keyring without validation.
@@ -37,6 +39,43 @@ void __init add_to_platform_keyring(const char *source, const void *data,
 		pr_info("Error adding keys to platform keyring %s\n", source);
 }
 
+/*
+ * Try to load the MokTrustPlatform UEFI variable to see if we should trust
+ * the platform keyring within the kernel. It is not an error if this variable
+ * does not exist.  If it does not exist, the platform keyring should not
+ * be trusted within the kernel.
+ */
+static __init bool uefi_check_trust_platform(void)
+{
+	efi_status_t status;
+	unsigned int ptrust = 0;
+	unsigned long size = sizeof(ptrust);
+	efi_guid_t guid = EFI_SHIM_LOCK_GUID;
+	u32 attr;
+
+	status = efi.get_variable(L"MokTrustPlatform", &guid, &attr, &size, &ptrust);
+
+	/*
+	 * The EFI_VARIABLE_NON_VOLATILE check is to verify MokTrustPlatform
+	 * was set thru the shim mirrioring and not by a user from the host os.
+	 * According to the UEFI spec, once EBS is performed, only variables
+	 * that have EFI_VARIABLE_RUNTIME_ACCESS & EFI_VARIABLE_NON_VOLATILE
+	 * set can be set with SetVariable().
+	 */
+	return (status == EFI_SUCCESS && (!(attr & EFI_VARIABLE_NON_VOLATILE)));
+}
+
+/*
+ * Check if the platform keyring should be trusted
+ */
+static __init void platform_keyring_trust_setup(void)
+{
+	if (uefi_check_trust_platform())
+		set_trust_platform_keys();
+}
+
+late_initcall(platform_keyring_trust_setup);
+
 /*
  * Create the trusted keyrings.
  */
-- 
2.18.4

