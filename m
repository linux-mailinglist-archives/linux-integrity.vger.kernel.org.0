Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D5D3E9C4A
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Aug 2021 04:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbhHLCUp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Aug 2021 22:20:45 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:41750 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233619AbhHLCU2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Aug 2021 22:20:28 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17C2AitU019188;
        Thu, 12 Aug 2021 02:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=mCuAz8xBmsK0VNzAR0lKnBkVqByYbVPDcSK/SpEOrQ4=;
 b=bAlSrvoL354FZlL8BnPwIMC3gYmvlrOoKwW81aXsc/ccqPtw3+W2PSqyoe7UOlN3RCgu
 LfvulVPZlHRuqpsxw+/RnnLTjsEVEmEZerKeCHoHlRZ0Lfqr5+BxK690OO6KzXexddcD
 OzgrUFgCqGyjGDqLAObToFiiGcsaN6wDjVkURKxzyd/S9TU7tPYIUbLl340A99CsxvFl
 UWFrIuBorJdaICy23XPa7iLLj9I40NmeHDGAEarj2J5UPWbAh+xoJdRduozA5XYSkSgo
 TvX2v84gB93ZHwovg6MJ2ADtpFaiubkXm1nzq6ienHe46T97DvVYHmHXkJEcty70J82b Mw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=mCuAz8xBmsK0VNzAR0lKnBkVqByYbVPDcSK/SpEOrQ4=;
 b=VkF2xS2g4BRe7qBdHMBJ/6KZzRaSGtEuDDLjyKIzJpXjzI1DUvzMkFayxsMuC2+ufbxR
 vNYMeVT+lq+cawkPu8FF7+iJtSrinjB+boijIRrmRYnC5SfQ5LcW7oPsBuszmSxywA2a
 ojnutjqOGEWF/LaECCl2AG0JfXXiUl72DXd9SKJNC8X9mv1c6wGCEQJIQHeZmyjS8CyI
 2kApcMxTiz9Zf4QzWn7QKZZcUW+Vku2Pt4sLP2Hv17ueB1mqcATymluk4JYQf8CqbXBs
 5iSesppOj/e9pIxj3VK5erM9IzmYOceYoQan2h1T3KDEMFqAqE5KSdYPa5n8bqjBTg2H Vg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3abt44c6gn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 02:19:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17C2GG38143063;
        Thu, 12 Aug 2021 02:19:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by userp3030.oracle.com with ESMTP id 3abjw7j7jr-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 02:19:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AelYal8vrHb3Kc1SRrT3fNfNnvxlSgMc9oC/Nu0/OxieWUKOonufyCTGecuEFcLfahawxQ2ZHwn2YYkSwPFV/a/RgIeJn3V5S+QVsLKRZUc2uRQz0izIIYR+U2Ye7p3AL3alca0l/XNOINXxScG2zH4ZYW+S6nhx59cnG+6B0sddNYMD+9mrTEUeeWrYIaKAfcbcL3Y+u525/aZ5CSpLD6xobmhMKbsrVDh+004lYyzfMzFWXJkowif517eEYSKCmE6kHJmgrkolp6t5qUiEB5l5i7MhY0H2W0zA9mTAFKnIDDCrhNZ6Q3W8JtfXSOu1zJU+rW1cQVPAGl2DgqHLWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCuAz8xBmsK0VNzAR0lKnBkVqByYbVPDcSK/SpEOrQ4=;
 b=GfvLO7jz0xNxC51/7hKY9M5uB8PvqLa8FNK3OubEsr6G3vDKqlPJC9tbpnU5Lmf0Va6KFpdZjpK83OkCPCn1o/olKVABxia6SeO9UnFKn5GI5cVam/SJWHtvhi9RKqmNjiWYosUcEQd6rtu9Qu/DO+Rk6dv9y5zqwL8556F/C7j5oqFoibarlKL+OI2QY6PQJ0MOOYgW92IS7zzceTfCQX1x3L5S6e5kTszjd3bzqwNFGsN8rCBdBvjVTy7KRutDMEb6F7v40eQZ/zd47Ha9ke5ErkJRBsYYWxkrF2sfLa7gzot+vls3YmKySibnimyrgAkFDeMs8Q0KJ/Fi9K8mqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCuAz8xBmsK0VNzAR0lKnBkVqByYbVPDcSK/SpEOrQ4=;
 b=pKO76kg94hZRwfpFkBNAlBEnRbHeLykwXLiZjmcP+En3D/uRley3+w5tdnr5LHrmUr8aVB8bPzdB9mkVtm8Q4DfxsDqMFKY3C1KgseL9ShxU8FepNr8/aus7rsLQs+rSWxqR+YaiygMObcYEo+j6Go8EeviTZp6Arrm2JR1sxcg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB4168.namprd10.prod.outlook.com (2603:10b6:610:79::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Thu, 12 Aug
 2021 02:19:22 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15%6]) with mapi id 15.20.4394.023; Thu, 12 Aug 2021
 02:19:22 +0000
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
Subject: [PATCH v3 03/14] integrity: Trust MOK keys if MokListTrustedRT found
Date:   Wed, 11 Aug 2021 22:18:44 -0400
Message-Id: <20210812021855.3083178-4-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210812021855.3083178-1-eric.snowberg@oracle.com>
References: <20210812021855.3083178-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0062.namprd05.prod.outlook.com
 (2603:10b6:a03:74::39) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.9) by BYAPR05CA0062.namprd05.prod.outlook.com (2603:10b6:a03:74::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.9 via Frontend Transport; Thu, 12 Aug 2021 02:19:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4f0fc56-8f19-4e8d-303b-08d95d3798d9
X-MS-TrafficTypeDiagnostic: CH2PR10MB4168:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB4168485F2E435AF01B9C500B87F99@CH2PR10MB4168.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zB5GqiSquXOjs0h5WnXDk14zJy/oOqLduJibeMK6R6ky9OnA3YW31da47NWuU0ZSlD4i3sTYaUYYbZYS/JyiFXVx2eJAxX6OMrc6KcuyKx4r3vsKTNCsAoAKeK5UsU1lJNn9Ipqci7FM2Pn8jSdESfuJ+WjwtHtNFBwjnf7MzTQO6iXXP7I7ng9ojlKClL7W/IG84n+xhKn0b1UzRn/SqkJbCCNPr/a4MscmSbqu6Q7xBeVxUK0fLxARy06F24nPfj0DM7Y27sA31szJRwn++YA1aKYw3DTHgDRLDEP57oPhDNuVud62BvDl1KIxtMxlef5/0QKIyaMWrYM+mXrYkYW5UHWufstYT+xSDahblZyHtcC0/qpfosl/vfNzFWbHW4CLa7xyKC7MrZ5AUuXhE3o2ee4R/fza4jUBflPLXzOBuRv4O0fue9dV53550qEDPq0Gkx4UIlvNiKqJ16xvuOH5w0CKFwfCbiYWIxeh+CFHv8lx+41YUjABFojbMdDPQEzNsH95VXnWGG48a9lMHviKbQtNTKoTiQUj1vXouIGnvblrYkJ4cIMPeG7y/5ETx7DENPR/yF1fp37FGI4hXdpawWx/9qDKcKYqEUAj4/3CvdUCPyoimKcERbGjnn7SePFxmm/j/t6+iiAG3JZrvNklwfcd8JWZTOt4Le4fTDwz4p1fjud9+X3+DcdY2hHvFgNBEECZ0aMbnpegn6n2WqfvSRSZGr9K4vy4ZoSLCZw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(396003)(39860400002)(136003)(4326008)(44832011)(38350700002)(38100700002)(316002)(83380400001)(66556008)(36756003)(6666004)(2906002)(66946007)(52116002)(66476007)(921005)(7696005)(8936002)(1076003)(186003)(107886003)(86362001)(26005)(2616005)(5660300002)(478600001)(8676002)(6486002)(956004)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h5V8vB+9E5kARaDAVPeHF1hCD0xQEE1yyqXJsJu/4ZU/NeE6dHfpba/+RMNv?=
 =?us-ascii?Q?LHErEO3TZpyPRCcPrOUh0wVOXucdd7sZt2yAXyOoJf6bAT4nfIwuZ+FpojOw?=
 =?us-ascii?Q?Wxs2N+UU2bk9BlkocOLVr9Don5jySQqMe6mGmjPFBUN6E45EMcAblk6gfqWB?=
 =?us-ascii?Q?ehh2iPHr+7gDEV8GmpLfEzyV+VvgBWnmYQq8S62EvZNyKHYPLeg75hNUDu2P?=
 =?us-ascii?Q?I/VWLyRQRBHy+RkY/J9GOJXDKbTrr/U+4rhgVIqwICJAWjsiKI4h4KEqnoO/?=
 =?us-ascii?Q?ea7ZJ1SIQhaIBJDZQFt5G+hQepC90XravSpU/Y+1NZ/YBOHkCb23ETtqFER4?=
 =?us-ascii?Q?V6xj9XV0tZwn9oURf2BL4y++RImLtSTIdfoNkdKMvxgfQAyoSodWV7zLMXAB?=
 =?us-ascii?Q?9bNDa2KdYN/dPHKExSD7ppQDFrk93AcHWmtM9W2H/wytR+1bhYMWgLEokCJn?=
 =?us-ascii?Q?26ZQ0mrNKK27Au4gA+7ME1doNcCQpoCrdd7oNvf0pVzmhMV0oqJEW9UDMzWe?=
 =?us-ascii?Q?xvIHSMsgWETcOWp4PatPVsCRIEZBvg6vyXKTuUuVqzyrHcTZ5ftuqRFf6B6V?=
 =?us-ascii?Q?lzTQkbtTRyW1hGSD0s8QuRM9OXqxj2+Y2oLDQE6Nl8Ycf7mzM84Gc6dRsSRT?=
 =?us-ascii?Q?UJ1/aWtnaqqk2XwvuL5JUZS5IK26NEM9D8yWEP6Usfoya5sFa4jrozckK3o1?=
 =?us-ascii?Q?4m6Eacgf/u8fAO1Gop4q6j0eGsAQGnU/nsLrpwNqlR9YN2K2HlC5vvlA/f6H?=
 =?us-ascii?Q?znzPCE5c110EhapQjHoONx6sayj3ZvEG9dsXCZtlsjJnST1z7uLFlk72Eev9?=
 =?us-ascii?Q?H2lbjbhCjtQl6U9ucdtLsvv9/JNES0Rw1vHUz2XkSlcXH46tIZGxGV2f/3/n?=
 =?us-ascii?Q?17EnZZveFWqcRBpY6F4tuETk1xoRU7NLQUbO4lpK7fl9O8udxSHjIhXinNeG?=
 =?us-ascii?Q?Hg+lkdB62SpNfw11l8G4lOo1auZJCnCngN4ciyOilcl7V7BNX9ZSTDzQXeHG?=
 =?us-ascii?Q?YjM4eyFtsc6WYrG+KuWhWO7LwZ71bwK38K0i4G12lCgTYSkMW2+gcW8WmSNc?=
 =?us-ascii?Q?YHEjfOATfUC1nzwaIKme0p8XAKzFcgYwbKcYxzhlqDTLNwnaUVHLZg1uazZt?=
 =?us-ascii?Q?tBBI4F+MxtVUGwQXlhaCR4S9ZcJEYXbIybeOnxkjJsgxMC9s1V3BzmiXJuSZ?=
 =?us-ascii?Q?mcgrMVZoxeOJTGa+by5hGX7Ad14Ir+KHHhTxyOe7aiuPv5/TH9sQPpe4jM5r?=
 =?us-ascii?Q?iO3tjgpk2VUoYGTAEtoW91RRyy/lZ3+qSZESnq4HKsBBV5YjDCscG+jL7D8e?=
 =?us-ascii?Q?i9RyvR7Km6dvr/oJ23ceLQGU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f0fc56-8f19-4e8d-303b-08d95d3798d9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 02:19:22.0253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zDEB36FXTI7MuKthwo3ff/A3awhYqBC4Sid5iMSKBPHl1nG+wUM4vuljd6VhqgDdicQIH61NQ4psx8BG1T1PhvhhultjxCau3BOsVeV+psQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4168
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10073 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108120013
X-Proofpoint-ORIG-GUID: 4DEIsS2lEvKRFLF_ZMlGDRJbyoCrBw1h
X-Proofpoint-GUID: 4DEIsS2lEvKRFLF_ZMlGDRJbyoCrBw1h
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
v3: Unmodified from v2
---
 .../integrity/platform_certs/mok_keyring.c    | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/security/integrity/platform_certs/mok_keyring.c b/security/integrity/platform_certs/mok_keyring.c
index b1ee45b77731..fe4f2d336260 100644
--- a/security/integrity/platform_certs/mok_keyring.c
+++ b/security/integrity/platform_certs/mok_keyring.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2021, Oracle and/or its affiliates.
  */
 
+#include <linux/efi.h>
 #include "../integrity.h"
 
 static __init int mok_keyring_init(void)
@@ -19,3 +20,29 @@ static __init int mok_keyring_init(void)
 	return 0;
 }
 device_initcall(mok_keyring_init);
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

