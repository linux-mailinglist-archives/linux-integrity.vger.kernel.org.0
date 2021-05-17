Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF1C386D60
	for <lists+linux-integrity@lfdr.de>; Tue, 18 May 2021 00:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241845AbhEQW77 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 May 2021 18:59:59 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:29136 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238861AbhEQW76 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 May 2021 18:59:58 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14HMqf3E028377;
        Mon, 17 May 2021 22:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=vnx3UOOHlYy+LzdQrU4wLxAgWLrhunJvAtQvwd7t+I8=;
 b=qwG6YwFRVGH8yFZXJ/9Gk/10DrdHpaOkk4BY1D+X7PXtSNpBnekgmWw032hlOprHvbrq
 Taywn3I7BldxVhzkywZHrGX8bd9xnd3a5sk6iED9O0lE9AhbDWN2fscdCNhz8rH4Dv/1
 XFbvzrc+nccMZbm3dk5ctS2ReCxFs2huEgKN5SpARjZpW9/zdoweHG3MROhnJYhY+WRk
 9AFnLBdg6FpQTyzfEpJJC4Vjz5UsKBPyE1xDutl4LRpJL3zU5u6Upe3XRjwrCpmSPjyN
 DexTbjDoKHzW8+Zuo+Y957sVi36hWknqOKaO+TDqhyQmC2GWoKpCw/uCffLpkRnOc/CF /A== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 38kh0h8cr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 May 2021 22:57:54 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14HMvpIf154682;
        Mon, 17 May 2021 22:57:53 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2174.outbound.protection.outlook.com [104.47.73.174])
        by userp3030.oracle.com with ESMTP id 38j3dtss8w-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 May 2021 22:57:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GL7K333eBjZIANq9wt+amm3PqcBFcy6a/9LXBOwIHmzMMaQPDlyokJvlMy25eJNhOK0snz7y2nkTt6ftgPVvxFMgFMLy4b7Jf+Kf5vTLm+0HDN3gVZ1EPM7iZSLzWYogUH97AmTf/4PaTN/fEyfoWnC496GjVcmlcm/ugiAOMLFkyGOteWo4HqAifcrSThlGS3BWOCWzIHIbZRlOsxb8y9ip7RMavP+8rZXRjACiiuRBPIfz79MW9WsXrw7GEYeWL4Okq6Ynd33l0/6mVurCzDQ2cnA0V/tWRHdlffOu278m/tfIkfyZ2KOUr9BwaTv3HYR4ym45vc3wEK50ACYcjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnx3UOOHlYy+LzdQrU4wLxAgWLrhunJvAtQvwd7t+I8=;
 b=Pki87/aErPT6BEraucjpGQh88sV5/e3YYg5rVMLKcg0oq3HPOWfGEvfd3gAqLilgAq/If36bPcpGgGuwz1wPKJKFxK6ICZ1AvLgJwsKNxm9VBYmO9BecPIi56zbTpcJ/JCVB17TSpmvTJf0BHRF3wILFUNCeg8zlGDugid3WUSoUeKFBBW6qRHCXP32qgnKgOC2b0EW3NQfThMYj0pLjrCKIENfRjxYQGoeXxbbBniiTe2YicYkOeF3s58CHM/+0Isy4bCqMkLXBtwgSGxUh4G3ad9D5dwl3tfBQkdKCYBWJRmRJt+RmksDtoEsIifirbQoCAIzVHxj8N09dpsvTuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnx3UOOHlYy+LzdQrU4wLxAgWLrhunJvAtQvwd7t+I8=;
 b=wpkqDWZO5FquEH1fWK4DYIl4dswR+/ogev5mWtIcw0+yf/wUNxklkDbWaTgwkFsNsqmE5WqY1DoAciHkhHRQaVlV/9GqTUsQD5QvZ+UlHCSpPtggi4v7R3YFjpE5S9EPHD8FYIOQi1bxVaevPsmeIjImOFGpZACsTzawkupeL8w=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB4328.namprd10.prod.outlook.com (2603:10b6:610:7e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 22:57:52 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::99fc:aabb:5cff:b177]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::99fc:aabb:5cff:b177%3]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 22:57:52 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
        jmorris@namei.org, jarkko@kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, zohar@linux.ibm.com,
        torvalds@linux-foundation.org, serge@hallyn.com,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        glin@suse.com
Subject: [RFC PATCH 3/3] ima: Enable IMA SB Policy if MokIMAPolicy found
Date:   Mon, 17 May 2021 18:57:14 -0400
Message-Id: <20210517225714.498032-4-eric.snowberg@oracle.com>
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
Received: from localhost.us.oracle.com (148.87.23.5) by SN6PR16CA0059.namprd16.prod.outlook.com (2603:10b6:805:ca::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 17 May 2021 22:57:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4bc3856-3fb5-4edf-3257-08d919873356
X-MS-TrafficTypeDiagnostic: CH2PR10MB4328:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB4328F4438E7422DBE40FEDB3872D9@CH2PR10MB4328.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: koi6xIxI2ACTkEO1oecclzCMibPFtKoimHUH5gyJEtoTf5oTyvxWtfMujl4sYkdVjpd6pczzIFJZ+du/ZdgBjxIZpAIK1NYIN5KU7Xq7Sla7fYA80OASeSlbAGfbkj41yIhguZQmKTjAJKywrJIDa2dC47hCGNNB7f/4T5ikJPePHu3SBOOjVH4PeJ3b+zaH/E8KOanhoZk0GvcuMQarItpfMhgv7Nx+8w5iDjrKnp9n+Q9FaeRzMEDq0zwi+FGk+RV00Ce/NN8+V7rkEqNU5Dab1IJ6NwdHCjE9KoxAvCzlE3mCeHjDQHiafG1G1dQWyEz1fjSsEVa2GZY492biI5Wa8XXOiUu7+6pRyCL+B2iOxs57id3B3lzNfXZf7YzgoYaNs5embrpGtLFoYcoyLJ6keFJPIetLz2IXXXApiIA8RjXyHsr3hiTdSRpIW0U9gC4U3EOA64L164lAKcW1Gz32M18TirihyblK+dZAsNntx3ESTEO35qyWyyRT2B0lZre4TZz5fSRPdhySchM4Ud7l8EQyuaADBjLEnfPqJSsFKgHLN7XQZ2hzCK5pD/veaoJQuET5QD/C1BcVTUHhlLyMbulbqmbSgMOjZ999odWG9uaqqwbhHncrF9Gt6c/1TvZL5FWAEECQxNP9gnunWju7RpISqiKqOZpSKBck2Nk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(376002)(366004)(136003)(396003)(52116002)(7696005)(66476007)(5660300002)(66556008)(316002)(36756003)(66946007)(86362001)(6666004)(8936002)(6486002)(38100700002)(2906002)(44832011)(38350700002)(26005)(186003)(4326008)(83380400001)(8676002)(1076003)(956004)(7416002)(2616005)(16526019)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?pEvPKj5rUQzdSC35A2u0GcJDj7KYuYtC8cEHS/tvd6TFhCVUXXQcA6tIXqMd?=
 =?us-ascii?Q?zZ7LQStLv9kcqeUIizGGZVeNY0+8L9AM769gPNhqzbKrsfVszjE/N00Cxdvs?=
 =?us-ascii?Q?4hFh6fPzUhuw8zuH2gxOB15limOkJTfHFizYSU1hCyPZqFlRjNi2yVkFGpk8?=
 =?us-ascii?Q?LSZN4UKD6boZaAlii6dXDJzLuvQJRevie8H80yatmx/Mh2VAxu/FVbVM/f9P?=
 =?us-ascii?Q?OrEdVBx6NIGO+fvrvGhrKv+gFnTCaoPnpaY8YsSTsD7KzKzBj3iZy5x7x3At?=
 =?us-ascii?Q?N2UDxlITOvjo9SB9UUQzWaDVja3hvzmGsBtPl/LPKFUQfHy7P5rduBesIvze?=
 =?us-ascii?Q?vsglrdriLKunsytfVjywmEGJV03ukuszaaEBmy53ClJTUlatTLdj6fWzuyPZ?=
 =?us-ascii?Q?zXyI1qB+DTbbbyjfmAKOn4p41GRVerrxyCou8irXGDnPrbzvcD02VvcBsbSx?=
 =?us-ascii?Q?P5rFa/1nzHMOTqL7o04Q2pTFPuFW1EqMfQV2kJE+Rl8SKIt1CRAD/WvDEHHv?=
 =?us-ascii?Q?x4uII7WbawCKbiMjD4SnUKD1VnDubtCuH+G53lWkxtc/WRwVUvmQSgUXKZiq?=
 =?us-ascii?Q?eLMRulirGgDGoYN8R/xIypFWI2SqyulBYsXBxt2lEuZvNeVNfmkscdxuJ+iy?=
 =?us-ascii?Q?UeBHqzZByF2dQv/xD8j7xXUG8XOs1UJmEOctPbnFaBr9OsICh4tby4UjMocI?=
 =?us-ascii?Q?tYGYg4lUqClgCkMMcTHfaLcwZYd7f7h50+TzwxrTeD14ExScTfbGfL6jT7gu?=
 =?us-ascii?Q?r4hjEEZSZyNxGjzAlQWEXwY5NqLL9p7821THZVb44r1JRi/tUTHTfR9NBf9T?=
 =?us-ascii?Q?4doKYee4ADiEzXhcf8kFXo8+rh4jgM3etEMfUY5Ga5XUSwWAeL3MkB3WDitc?=
 =?us-ascii?Q?ok0ksI8tGa2qBkcnKrDv4Hl6RUC9A5qdMZRXlb1h5krSuIjc4RAZpnPvZvQm?=
 =?us-ascii?Q?0dKngQOrXAbf097EOGPQtFshpWmEoA4CW9oKLzf0XWaMRuoLeuEbSooq6bZP?=
 =?us-ascii?Q?H8AIoUqAZU0+YDwKPajVDvSdkIfCmomuZTI4hB87kJvKA8LhKMYKxR6eKYzg?=
 =?us-ascii?Q?T57B+HEjgQpz5/CUpOQyIGAJ4QGMGMPW8P3eyhStZZQZxQwdegGbek9izSrG?=
 =?us-ascii?Q?EWK5ywgKkkCPBHkmXOrfztK2u8cTyvezaT0XiDiwaAkQ4bZxlBiiFzIGt/hA?=
 =?us-ascii?Q?qTTNVZ/YFinO7wYGaFEY1RUBNb0hpqwLIFcLLntj07mgOakgl14xIwj3DAL+?=
 =?us-ascii?Q?l2HAD775ulXl6rcOhl/V2rGl91FHr+3R9pihdFFyPiKot/MTR2i+XtqWjYvD?=
 =?us-ascii?Q?wFT3lCCubVAjLo6OKr1QJ4LD?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4bc3856-3fb5-4edf-3257-08d919873356
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 22:57:52.4442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V2m0hTpUICCbm6qEcFM/N2Rlk4+yyqJZoPZMMZ002rq+L8kyP7sVWeGsATvTUwr86pDQUKfMQQ4dZoUozTkN3RjmP4B1tWNifDc7J5z8+U8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4328
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9987 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105170162
X-Proofpoint-GUID: ytW35DfjSTaNPWkM807FsUGigHlePvoy
X-Proofpoint-ORIG-GUID: ytW35DfjSTaNPWkM807FsUGigHlePvoy
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

A new MOK variable called MokIMAPolicy has been introduced in shim.
When this UEFI variable is set, it indicates the end-user has made
the decision that they wish to use the built-in kernel IMA architecture
specific policy base on the run time secure boot flags.

By default, this new MOK variable is not defined.  This causes the
IMA architecture specific secure boot policy to be disabled. Since
this changes the current behavior, a new Kconfig option called
IMA_UEFI_ARCH_POLICY has been added.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 security/integrity/ima/Kconfig   |  8 ++++++++
 security/integrity/ima/ima_efi.c | 24 ++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 12e9250c1bec..3773d2d1ddc4 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -172,6 +172,14 @@ config IMA_ARCH_POLICY
           This option enables loading an IMA architecture specific policy
           based on run time secure boot flags.
 
+config IMA_UEFI_ARCH_POLICY
+	bool "Enable IMA archecture specific policy thru a UEFI variable"
+	depends on IMA_ARCH_POLICY
+	default n
+	help
+	  This option allows the IMA archecture specific policy to be
+	  enabled or disabled thru a UEFI variable setup thru the shim.
+
 config IMA_APPRAISE_BUILD_POLICY
 	bool "IMA build time configured policy rules"
 	depends on IMA_APPRAISE && INTEGRITY_ASYMMETRIC_KEYS
diff --git a/security/integrity/ima/ima_efi.c b/security/integrity/ima/ima_efi.c
index 71786d01946f..46873a94c934 100644
--- a/security/integrity/ima/ima_efi.c
+++ b/security/integrity/ima/ima_efi.c
@@ -62,8 +62,32 @@ static const char * const sb_arch_rules[] = {
 	NULL
 };
 
+static __init int is_uefi_arch_policy_enabled(void)
+{
+	efi_status_t status;
+	unsigned int enabled = 0;
+	unsigned long size = sizeof(enabled);
+	efi_guid_t guid = EFI_SHIM_LOCK_GUID;
+	u32 attr;
+
+	status = efi.get_variable(L"MokIMAPolicy", &guid, &attr, &size, &enabled);
+
+	/*
+	 * The EFI_VARIABLE_NON_VOLATILE check is to verify MokIMAPolicy
+	 * was set thru the shim mirrioring and not by a user from the host os.
+	 * According to the UEFI spec, once EBS is performed, only variables
+	 * that have EFI_VARIABLE_RUNTIME_ACCESS & EFI_VARIABLE_NON_VOLATILE
+	 * set can be set with SetVariable().
+	 */
+	return (status == EFI_SUCCESS && (!(attr & EFI_VARIABLE_NON_VOLATILE)));
+}
+
 const char * const *arch_get_ima_policy(void)
 {
+	if (IS_ENABLED(CONFIG_IMA_UEFI_ARCH_POLICY))
+		if (!is_uefi_arch_policy_enabled())
+			return NULL;
+
 	if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) && arch_ima_get_secureboot()) {
 		if (IS_ENABLED(CONFIG_MODULE_SIG))
 			set_module_sig_enforced();
-- 
2.18.4

