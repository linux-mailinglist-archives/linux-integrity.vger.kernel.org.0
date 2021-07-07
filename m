Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC80D3BE126
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jul 2021 04:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhGGCsJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jul 2021 22:48:09 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:4542 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230103AbhGGCr5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jul 2021 22:47:57 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1672Zp27001385;
        Wed, 7 Jul 2021 02:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=wIpJdn9h6v2TffanyfnpCNI1NeljTy+vJpTQzEK1rcE=;
 b=mCQa35unsKLCWjUAacOLLQhoferqUcqZZZCcQwGumcDx2m1pQH62jHGY1718fLJmAGVG
 UClLaWbPTn+gKU4r9E7yJQyvkYxT/8aPoki2hcH59RMNzwH40hBDzJQBLh+IzyoZ5ANJ
 m4VVnhuEQvQl++Z9BI/nW9AADt2p10YyRgYI+EE++VAUNZS7GHF/StQkDBInOtp7If4D
 BswMYtQ6Q4pwXEGFtJAOdAEXuyXMCpaF9i6cZeajS1OsWcZ0I/YvshDp7gsz6aJogPmG
 9xsiMG4+5H3Xoii9M8HMg4c5LgmZ/r/557wfKyArfhzSsQRPV8zWCXXKrhhOmSpPMkxe 5g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39kw5k3w94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 02:44:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1672aTlL070901;
        Wed, 7 Jul 2021 02:44:38 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2168.outbound.protection.outlook.com [104.47.73.168])
        by userp3020.oracle.com with ESMTP id 39k1nw7pxf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 02:44:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSogeLoOLhilLj4jVDOgK5A6b/5Tgth6OeTYGsAkxl7geb5jd46RHCA12Y99Swr26uelpLZQVtMLKje/vPIHYyetsbMLFDJJPl+ggpmIau9O5bso92Nuh1zDp0EMcCclX7HpKgLDPRKRp66xuRE89lEeVZkIkUoZbA47iJ6a41VWBEo56h4nmEjBfZNvhOP0hCdFl8n3HDUFA0TQCy33lf/miV5wngD6xDFMEjfjIi3pMi3lo9TpHxG5GAUrtsnbOIFq+gRSpEEauIfXOmvUAm+mQeQcw1rUmeJp6zrvRkf2564kdgN05k+TK7Ot5MoIoIQvGtP9S67y38OnwkhoCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIpJdn9h6v2TffanyfnpCNI1NeljTy+vJpTQzEK1rcE=;
 b=kmUbRyNHLRbiV/4+4ISeESG+3B2Gp77xX2YR7xuoKTcF3i0Nm9RDxEM6oAuqGyPbHm4ub4XvYuPO6tLyuKQzl3RkYU7QwaI6dRQWyDs5UnEk1xcrmZV3yfmNgJEYrb/sem9An0lq1KqonhPEpHKgoX+ry8yxc4RJy/+2axwi4uNiROP/PQ6vXy1oecDyh0CI828BgyhpiBl2cxl1EMJA9vqj/MeVi8GGceEVE/YdSXZTqE9cnCbavzRBUuBueNvQYvMhbYVlmg0KqCu1oE4wyulvDWlKHjK+tLPldUCTpOcYMEQnAEBn+3NOe9p0VP8kS6szphYX2OICAhgHaOwRSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIpJdn9h6v2TffanyfnpCNI1NeljTy+vJpTQzEK1rcE=;
 b=iSDwhHZCqAsKIKdJ6O1mkuHLg5RfjQ1DCmxCpnYyewT5O7V65apZht9i/vzLTUHQ1+tpU6NI3WhvMbATzDJIIcLroYglE3R9abbw8MfUM3FY+YVvoNTljUmV/pRs83xcxun1HuzwOUp5Q/Fj6/K1KakXPrvWSmZFhDLPuQCMl4M=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3863.namprd10.prod.outlook.com (2603:10b6:610:c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.24; Wed, 7 Jul
 2021 02:44:37 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197%8]) with mapi id 15.20.4287.027; Wed, 7 Jul 2021
 02:44:37 +0000
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
Subject: [PATCH RFC 06/12] integrity: Trust mok keys if MokListTrustedRT found
Date:   Tue,  6 Jul 2021 22:43:57 -0400
Message-Id: <20210707024403.1083977-7-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210707024403.1083977-1-eric.snowberg@oracle.com>
References: <20210707024403.1083977-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::10) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.5) by SJ0PR03CA0245.namprd03.prod.outlook.com (2603:10b6:a03:3a0::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 02:44:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3dd4181d-75fd-4040-6f53-08d940f128eb
X-MS-TrafficTypeDiagnostic: CH2PR10MB3863:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB3863CA93BC6EEA8EC96AB32C871A9@CH2PR10MB3863.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dbeHlibev7Ct8z/Gg7dFZ7sZV6j1aXnrB0AXO24RB+q2+ytjIWgq0mbNPcOuc4AIjKCbZGc+xXMksHM0cdjxSv8B1QsTd7lTI24iMOtLmWJpHG5LuaMkvLuCTDDSQC1PL3Q5gU6jf3AMI6ZWX94EOE39sqH1Hp58dUJQdUKIlE9O2Ni7XxcGR5T0UHGZYwHJQ6eEnX8GNBu98MwMyve1a/yHH9VSus17PZYncRbu8M6ABuOs10kXa3dmBCPAVxlrzzfDkt5Zjf34GlgnAdSLQYI+gNhsp6KazemRWXFhAuRmdw7VIbIfHqSXFwhOVdv2o28pk33svHDEtKemaS/FyN0jL6+XoCUHwoCqPSole+dBJl7fP/SC0xEFfNKO5SsT0fR95RZEoRcQeoHR/mTql+61ys61PosA2NanoRdWXH1CWh1xTOavI+K8zYY3ZJLcwINcCmu6JyiB5eT7bFo7z2xrBMMMLz05JUj4jbkjj+MYcDvNcvWEiUiGOVdmRmgRAkvtU1N5VyCSGrqcv16GS6rOkD2PlLL2IUU79iAu3qLmPi8Lj/fPbukMfBwbwaYg1T5ETYpEJ0F5tkB2kSCjtTLkaRQkGqg+IOaPZk6UyrmiLOsMksSFdgQdLty3KcSArqlqQYTugIfNriGptNcdvl2nZ/suaQCCgOfpIOsz7CklsrlPoN41spsSJjmbN2/L1S7uJKIHKaDELhYlbcfJEaugkM1qDXzG8itnTPWa50s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(366004)(346002)(396003)(376002)(921005)(107886003)(6486002)(7696005)(316002)(66946007)(1076003)(44832011)(86362001)(38350700002)(6666004)(36756003)(83380400001)(186003)(4326008)(956004)(26005)(7416002)(8676002)(52116002)(2906002)(38100700002)(2616005)(8936002)(66476007)(5660300002)(478600001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RjJiqHqdL7fGzGa7p39gaUAys3K53J0xzJ6tmbXBdjEAeuj1gtkiFjRXv1wX?=
 =?us-ascii?Q?HXSpswr1ZxDQRe85c5M9C3T+W3QxfuJwoHNZYon+HKRKCnIgrofTbC/MFQaN?=
 =?us-ascii?Q?YKsglquVSUo9H0Y8NBz0xNKTmoznGAgkzcivwQNqrYbynCwycDuMXEQ2RRyC?=
 =?us-ascii?Q?u1wKGjG8xzPEF97s6xAj3smN3UntRsMzFz6RP8yhzfVsexAgto05d/yCc9Ec?=
 =?us-ascii?Q?0+HLxVXbXDpZwaaWqQHjPvzHBpXs8QS75eIO2W7PJLpYZTCLPBoN1R9enqsZ?=
 =?us-ascii?Q?7DigA//jUBEeGFDCpVm4TU1oEndAuDQFqaNfuxDmnlJUX0E4GibfRBzs9YlT?=
 =?us-ascii?Q?ZaMugtUXR4lYkGU+1j3wPmhx/TbgIN3OyPN3I/rS+sOwxNpuc3bB8fiS7+4V?=
 =?us-ascii?Q?r1Rk9SbY2W/SeMWc2nJm0OIIeePTEvEr8E6mmCSpQing61y6FqndZ9sfFhoH?=
 =?us-ascii?Q?OmE93k5rg1XdL+RBqCscGnLZ6Hw6ENNMXQMH1mwnQ9pZZvkepr+X07r4Ffva?=
 =?us-ascii?Q?PGInVJIUFR6h+aOnhOiTLgg4zsesHp5jkCoNm/yzCEeRUO068Mu5Wc9nEMx1?=
 =?us-ascii?Q?gGNJ0mIAAL7GWReCrPAsOjgKIxeOh79xNmppZpLUJomPDyvJR71asTVJZUMo?=
 =?us-ascii?Q?eUFfWyYwKir6BBpxv1tqbAZ/HssmeHX/7BT0JvXYDGBNkpEt1hUhY8sz0CpI?=
 =?us-ascii?Q?qRTDKrVmVGC/e8PiVnGajAUYpV3xCQ1b9bqZlokkTvk5Vajc5FyhWItcohaH?=
 =?us-ascii?Q?KN3OS076sF8Vk0N1WUkldsNVCWMdNuRYe3RjeTQ37rIFopUG9k9tcc/TQ6Oj?=
 =?us-ascii?Q?zNQb/0dK69sPOyl9X5SxAFCyrSqmWicRQtYJ8Gubodw5+wkPsQGsg2LXkW94?=
 =?us-ascii?Q?XGejRhz70aM4IYbtZ01KKM05A0C8ofPNgV+Sk+w4eKhyeNmoObpP09jR1NVB?=
 =?us-ascii?Q?nPEf2H0hKcaG8EqOmymA+zCnIB2Jv7uIqcov0xNBfdTghQ7t0WX3SyfW+CJJ?=
 =?us-ascii?Q?cchcVA7g9io3zNsEgTQqv80x6SjAb+ZsWavnTVsaoY7NhQUuwWCD9jOatqHo?=
 =?us-ascii?Q?zCG45i8lfrlLh9QOi+HPtIqZ1FHRYNC5O7zO0WFZOKe1B2GpauqyX1jxeMQK?=
 =?us-ascii?Q?zoVinl6E3erVdpneMg0ggPbmSMY7yWE0Qc4GuMAJSLGnZkUeElYfN/1KJxR/?=
 =?us-ascii?Q?hgT6dM4SS9GIgbfLBpocUDGUG9CcN+v57OCKvSvE8kCWC2Rwnmb30pNAsCXf?=
 =?us-ascii?Q?9fyXnHW8ug5N0/D+Id7TPBOwR9rUCbuh6oKRWxkVfpGZLsvTPge0Hi7vuyaO?=
 =?us-ascii?Q?BugN41bfgJVu4WPWd+/nNYH7?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd4181d-75fd-4040-6f53-08d940f128eb
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 02:44:36.9411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: epFX+w+uphI4hwk3AJiJO94XrDIHvCHu/9XqXTYUFzINRfX+mzEgdYLzaxvYlG9wuOg3eWJHvAmY7Pnor5dxZpsjFoubJp6UHtMH67b2Y3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3863
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10037 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107070012
X-Proofpoint-GUID: RLvYSHhy4ZAIuetnwdYWF6SFpqjg9wpb
X-Proofpoint-ORIG-GUID: RLvYSHhy4ZAIuetnwdYWF6SFpqjg9wpb
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

A new MOK variable called MokListTrustedRT has been introduced in shim.
When this UEFI variable is set, it indicates the end-user has made the
decision themself that they wish to trust MOK keys within the Linux
trust boundary.  It is not an error if this variable does not exist. If
it does not exist, the MOK keys should not be trusted within the kernel.

MOK variables are mirrored from Boot Services to Runtime Services.  When
shim sees the new MokTML BS variable, it will create a new variable
(before Exit Boot Services is called) called MokListTrustedRT without
EFI_VARIABLE_NON_VOLATILE set.  Following Exit Boot Services, UEFI
variables can only be set and created with SetVariable if both
EFI_VARIABLE_RUNTIME_ACCESS & EFI_VARIABLE_NON_VOLATILE are set.
Therefore, this can not be defeated by simply creating a MokListTrustedRT
variable from Linux, the existence of EFI_VARIABLE_NON_VOLATILE will cause
uefi_check_trust_mok_keys to return false.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 .../integrity/platform_certs/mok_keyring.c    | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/security/integrity/platform_certs/mok_keyring.c b/security/integrity/platform_certs/mok_keyring.c
index 2b0d17caf8fd..666fa355996d 100644
--- a/security/integrity/platform_certs/mok_keyring.c
+++ b/security/integrity/platform_certs/mok_keyring.c
@@ -5,8 +5,11 @@
  * Copyright (c) 2021, Oracle and/or its affiliates.
  */
 
+#include <linux/efi.h>
 #include "../integrity.h"
 
+bool trust_mok;
+
 static __init int mok_keyring_init(void)
 {
 	int rc;
@@ -24,3 +27,38 @@ void __init destroy_mok_keyring(void)
 {
 	return integrity_destroy_keyring(INTEGRITY_KEYRING_MOK);
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
+
+static __init int mok_keyring_trust_setup(void)
+{
+	if (uefi_check_trust_mok_keys())
+		trust_mok = true;
+	return 0;
+}
+
+late_initcall(mok_keyring_trust_setup);
-- 
2.18.4

