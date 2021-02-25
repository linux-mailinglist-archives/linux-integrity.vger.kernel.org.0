Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F111E3257D0
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Feb 2021 21:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbhBYUhA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Feb 2021 15:37:00 -0500
Received: from mail-eopbgr80077.outbound.protection.outlook.com ([40.107.8.77]:18150
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233960AbhBYUex (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Feb 2021 15:34:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/cush2G0tKU2VFEGBktL4taNn+wn5AUtpI3jflKgyZ7s2PpteS3FWot0aT21Hrq1Sjijv0L+5s5nVWBpp3jhSWsrOl7jQsGzmxHdICka8YL+2yL6da1GzEsS88EdoYsjt28JogZ2twlafwsvCo4Wwb+jmDcSC7it66eBNUe5SL9SuAwEiOf8zoEwFKr+PQzXumChjy3ny72ENxrXVDHUvPniQZuu3kq4mj3cloWPu5bTzbVHFyz9MVVtFdJ/09TE8TQKkw1rSSSbFtaDZjDJM7nmgdvIega56xfhCA7ySTpo7stoQMdqFr8FNGRxmN9+E3bo5+1V8oXTpv4oS/9lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5Qpikqg+zpMc3h8h1XLsm2X6/xzWAGKDBk1Uj5LBNk=;
 b=JYC9Fsx8FhgrthGeQ0Dz7qX6VZb0pXyyw0sp2n349GRcxBX2zOpNc4twQ+C+QX+5Gz6ij2qjGDgymC0b4EYg/ZMieVUnRVdVZUBu2KKcL/WKCC1amH7JifsTYryTVseBwya+vyMZOAqJ+BYlCwhlGVahdTjWpdOH3TWlAo/3oZqlX6t8tNcr6SHnRAg4beXZpEdVeOtjofpWLLETOfL3dtMkSVFssJKbWQPfqasbs7MmrFk85/5MfOSMpgqLoK/uWpgJvLrNxkIR9qFyTjquLYjwUzPIhVcnSvnuKs4jafyIoIWEF++M7KuwlyfcoJJ4V8FkaaCtQ3zvmDQ2J2nEQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=puiterwijk.org; dmarc=pass action=none
 header.from=puiterwijk.org; dkim=pass header.d=puiterwijk.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=puiterwijk.org;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5Qpikqg+zpMc3h8h1XLsm2X6/xzWAGKDBk1Uj5LBNk=;
 b=SMW/wEhm4SrR2cIpbvtRCZM5qFK02aN0MqAJ2qKV/66lDuBDmecxlDjJ6Z2l6KJkJEwFDm4NJxFoTlEYjWuCG676zEO7l1JpRrR2n52hOwxDjZ87UjeXtOsZOlRZmZnb7eFbtXj/XWifWUERt3OjtIevQqCJ2GeG+0m+HfBNCVVq31oGVB3ZL8yt+BhvQunrm62oAsCPDdo9D32DjdHT87pTSEvhGZPiVdEpRcNX7FK5TjL6zx7UUlkvADh4KDqbGbHlH4zzgq5Tcu7sFbnPyhywGR+7tJfrJs36dQoR/H0fiqBUZ4NdEy4u+eZhEwQX8KcGAa16//Ou+nZXuTWtrw==
Authentication-Results: gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=none action=none header.from=puiterwijk.org;
Received: from AM0P191MB0721.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:15f::13)
 by AM4P191MB0083.EURP191.PROD.OUTLOOK.COM (2603:10a6:200:65::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Thu, 25 Feb
 2021 20:32:48 +0000
Received: from AM0P191MB0721.EURP191.PROD.OUTLOOK.COM
 ([fe80::b002:8668:5cfa:a46b]) by AM0P191MB0721.EURP191.PROD.OUTLOOK.COM
 ([fe80::b002:8668:5cfa:a46b%8]) with mapi id 15.20.3890.019; Thu, 25 Feb 2021
 20:32:48 +0000
From:   Patrick Uiterwijk <patrick@puiterwijk.org>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        linux-integrity@vger.kernel.org
Cc:     pbrobinson@gmail.com, stefanb@linux.ibm.com, kgold@linux.ibm.com,
        Patrick Uiterwijk <patrick@puiterwijk.org>
Subject: [PATCH 3/3] integrity: Load keys from TPM NV onto IMA keyring
Date:   Thu, 25 Feb 2021 21:32:29 +0100
Message-Id: <20210225203229.363302-4-patrick@puiterwijk.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210225203229.363302-1-patrick@puiterwijk.org>
References: <20210225203229.363302-1-patrick@puiterwijk.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2a10:3781:662:0:ec87:3741:6e9a:b11e]
X-ClientProxiedBy: AM0PR03CA0018.eurprd03.prod.outlook.com
 (2603:10a6:208:14::31) To AM0P191MB0721.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:15f::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rowhammer.mgmt.home.puiterwijk.org (2a10:3781:662:0:ec87:3741:6e9a:b11e) by AM0PR03CA0018.eurprd03.prod.outlook.com (2603:10a6:208:14::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend Transport; Thu, 25 Feb 2021 20:32:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbca39a8-af2b-46c2-8870-08d8d9cc8395
X-MS-TrafficTypeDiagnostic: AM4P191MB0083:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM4P191MB008354EE69203CA4D343C170C89E9@AM4P191MB0083.EURP191.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AnONTjdz3uwWPjeZMA/dx9wlhmW8qp+qPwMD58GFK3XIPCNaKW/p4gg2h/okorhl7G93k3ZuNSki2l6EDNiU6iRuJ9llLKEg8lpIRB96wNMTFoQpzV5HoT0bzKIA4nsnIOOrkcR3wQ7QnzIuL1sWk5FBsbOWHh/1QzU1jOeaS24cuP338MVLvsYEdajjU0DsobizjIdRQWHlziFLhy6YBZk6Tcu0oZi6tqYtK77/HqEt+o33e42zd8HTpRwmWwG7ncVCF0R+t/01lEI+i701TE24kLUVZ9Mtr7dmXuiimmS+vQ4ghRuEuTNK76AcSwVT/IaDcAV125ihkS+QPa3TSRkLR/fLNSsO2c4ymAoxNIGHR4smjK+KFvuBFBkMQkvcDIy7ugnsaLzeOKi5jTpioEhdW4TlEYw80tJQRWdwNbkIVIPlahMJpK3mVn+/oMrCqJYGS7dH1LJ4RZ90pq4tjK93UuIa5Bo2Ue6sM2tBQsDVCuxwdyzrACr8mnbEDDsRkMeNbUFQzONphn32i4ik2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P191MB0721.EURP191.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(39830400003)(136003)(346002)(366004)(396003)(2616005)(316002)(186003)(107886003)(6486002)(5660300002)(4326008)(66476007)(1076003)(478600001)(66946007)(6666004)(2906002)(36756003)(7696005)(52116002)(66556008)(83380400001)(8676002)(8936002)(16526019)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?c/q5FMsg1V43GOH+SqYofUWKinkPXpoK46LKfwMDqbIYcZhmKr1J7l4stUGA?=
 =?us-ascii?Q?TSSuFFHlXgRPOzTFubgSNYxe6nFfE0//v9TYylQA0k+y9K4LjwdHcdC5hUxq?=
 =?us-ascii?Q?8wDJDStEfwKGSjSrzbiKknfrUNv7UXWphV3FiGNHhO+9Q5IUB8w04c4peo53?=
 =?us-ascii?Q?FzdidiFpcNRpeadsKBZ2A2/wfxIRF9ct7fhcE8Y9n1bg4rAB1AZ6kVv/y6im?=
 =?us-ascii?Q?lL4xmm8Ke0dVhJmtzVGSpOuu5EbeeMf/exTN8uNt5jJ6B1QU3ygSffemEy4L?=
 =?us-ascii?Q?9gUz38g7orSqoYeq3CtBiLTrPeTiDtIQ+4+ALPr3DaU1jskSs0ilvHwTyjGe?=
 =?us-ascii?Q?EDCNXRzNEN6tO09L2sltl1SNzNGTTc74O+YWolcuQTdGa2QTleRGwe8Kga8I?=
 =?us-ascii?Q?NSAx79/LgtHK9lRTC7lcFfF069tVlMK/2FuR3CWPZofE2y5ERzd34llITNBX?=
 =?us-ascii?Q?E2t91RqWe5wUB91U2RN9Ih8Ny96EmFxSW9OmS4VSEW/0u0e6wS8PEyKZrUyN?=
 =?us-ascii?Q?BQo5Weukncc7KdnYUBFIOXy6GRtxWEWdqbagRfzn+cbf6d9ndMHGfgd1wzID?=
 =?us-ascii?Q?I7qTYE7E/AK32B8I+GhfRBqRvu0gyY5g9r8NeyzIzgxcLiyrdJP0+D5u3ko1?=
 =?us-ascii?Q?gLnpElQ/oJ9n017m4ilRLxtj9YNj3c5xhPWTG6RL96sWfCWIQ4WImlMmEnIX?=
 =?us-ascii?Q?S13A9bM/LhvKL3p4iWtyM9pZIIQm1KmIyf4OUvG6TghRfsz0gY9kWokUmA0j?=
 =?us-ascii?Q?0UwwE0m/XJmwqRDrrtYHOGygHlDQV4BDqVF4m/rwx8AO10rqH57YK6iqNzrJ?=
 =?us-ascii?Q?F2FIo/J4/CJ8/GbwUwPNSNIvn+iSvmUi9DCyxKl/MGIiokpw7BpYEyMLj44G?=
 =?us-ascii?Q?rqe71sDW99toOGJIl3h3axTC5IjinIJYKHG3XtKBzbofXQCZF4WzkIOfzEeJ?=
 =?us-ascii?Q?lBNOT8VyGyjOxwW6iy+4jzyy7FU5jdXnkMaUh81KKyQR0G8y0FXuygSCU2VC?=
 =?us-ascii?Q?3iv1ZBP7Ws6/P1of77EPBJrP+8V43QnB7tcuZ2cM/unaR77U0fyI/Ju1Awt0?=
 =?us-ascii?Q?vMzdWsTK9Mi4hTrdANRSStZ20fZQawJ4FRngJ7iMX318OeJ2fJ1ZpxVx7aMF?=
 =?us-ascii?Q?9ulbmV03lHeW0XXbLIO3s+rIytUowKUh7uVg1RTv+HpmYnwMfdl4ZZBXZO1y?=
 =?us-ascii?Q?Q8zpP9YHKaXHyPWv297PvJzrG1tHxM2PrmS/zH9BM8RaqX8boJNHVCyFF60J?=
 =?us-ascii?Q?E6xa9aNdSMoHqrjSOCb0maNumBc+QCkK2kX+f7PZR9L3Me51cn11dhKPT9cr?=
 =?us-ascii?Q?iZ9bGNfjks9/Akpd5lTniRWogdNC3vdyJodkhgo4ZBxRmLZTSdPK1eTn9M4U?=
 =?us-ascii?Q?Ds1b2ufiiUf8q1s6yslkGRLMi2dA?=
X-OriginatorOrg: puiterwijk.org
X-MS-Exchange-CrossTenant-Network-Message-Id: bbca39a8-af2b-46c2-8870-08d8d9cc8395
X-MS-Exchange-CrossTenant-AuthSource: AM0P191MB0721.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 20:32:47.8111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 963619a5-d7a7-4543-a254-29462dc51fb3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mFF1WwW5YLnhpZ34tiFe8pXqs88LyU+OFkOH2PYurH9hx90kyIweTaI6P4oh+ExVV63JIEF4N2LSC1axMD9ejA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4P191MB0083
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Allows users to enroll their own public key stored in a specific TPM2
NV Index, requiring the absence of the Platform Create and Platform
Write attributes on the NV Index, to be loaded on the IMA keyring.

Provides a method for users to load keys without the need to recompile
the kernel or change the kernel binary, which would require a resign of
the kernel image.

Signed-off-by: Patrick Uiterwijk <patrick@puiterwijk.org>
---
 security/integrity/ima/Kconfig    | 22 +++++++++++++
 security/integrity/ima/ima_init.c | 53 +++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 12e9250c1bec..28424b930c81 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -291,6 +291,28 @@ config IMA_BLACKLIST_KEYRING
 	   the search is successful the requested operation is rejected and
 	   an error is returned to the caller.
 
+config IMA_LOAD_CERT_NVINDEX
+	bool "Load certificate from TPM nvindex into '.ima' trusted keyring"
+	depends on IMA_TRUSTED_KEYRING && TCG_TPM
+	default n
+	help
+	   File signature verification is based on the public keys
+	   loaded on the .ima trusted keyring. These public keys are
+	   X509 certificates signed by a trusted key on the
+	   .system keyring.  This option enables X509 certificate
+	   loading by the kernel onto the '.ima' trusted keyring
+	   from a TPM nvindex, bypassing the builtin keyring check.
+
+config IMA_LOAD_CERT_NVINDEX_INDEX
+	hex "The TPM NV Index to load into the '.ima' trusted keyring"
+	depends on IMA_LOAD_CERT_NVINDEX
+	default 0x184b520
+	help
+	   Defines the index of the NV Index that gets loaded into the
+	   '.ima' keyring.
+	   The default is the "0x18" prefix for a non-TCG specified NV Index,
+	   suffixed with ASCII for "KR" (keyring) and then 0
+
 config IMA_LOAD_X509
 	bool "Load X509 certificate onto the '.ima' trusted keyring"
 	depends on IMA_TRUSTED_KEYRING
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 6e8742916d1d..ea0949e8df12 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -112,6 +112,55 @@ void __init ima_load_x509(void)
 }
 #endif
 
+#ifndef CONFIG_IMA_LOAD_CERT_NVINDEX
+int __init ima_load_key_nvindex(void)
+{
+	return 0;
+}
+#else
+int __init ima_load_key_nvindex(void)
+{
+	void *cert_buffer;
+	int rc;
+	key_perm_t perm;
+	u32 nvindex_attributes = 0;
+
+	rc = tpm_nv_read(tpm_default_chip(),
+				CONFIG_IMA_LOAD_CERT_NVINDEX_INDEX,
+				&nvindex_attributes, &cert_buffer);
+	if (rc < 0) {
+		if (rc == -ENODEV)  /* No TPM2 */
+			rc = 0;
+		if (rc == -ENOENT)  /* No certificate in NV Index */
+			rc = 0;
+		goto out;
+	}
+
+	pr_info("Loading IMA key from TPM NV Index 0x%x", CONFIG_IMA_LOAD_CERT_NVINDEX_INDEX);
+
+	if (nvindex_attributes & TPM2_ATTR_NV_PLATFORMCREATE) {
+		pr_err("NV Index has the Platform Create attribute");
+		rc = -EACCES;
+		goto out_free;
+	}
+	if (nvindex_attributes & TPM2_ATTR_NV_PPWRITE) {
+		pr_err("NV Index has the Platform Write attribute");
+		rc = -EACCES;
+		goto out_free;
+	}
+
+	perm = (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW | KEY_USR_READ;
+	rc = integrity_load_cert(INTEGRITY_KEYRING_IMA, "TPM NV Index",
+				 cert_buffer, rc, perm,
+				 KEY_ALLOC_BYPASS_RESTRICTION);
+
+out_free:
+	kvfree(cert_buffer);
+out:
+	return rc;
+}
+#endif
+
 int __init ima_init(void)
 {
 	int rc;
@@ -124,6 +173,10 @@ int __init ima_init(void)
 	if (rc)
 		return rc;
 
+	rc = ima_load_key_nvindex();
+	if (rc)
+		pr_info("Failed to load IMA key from TPM NV Index (%d)", rc);
+
 	rc = ima_init_crypto();
 	if (rc)
 		return rc;
-- 
2.29.2

