Return-Path: <linux-integrity+bounces-2052-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B277A8A2ABE
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Apr 2024 11:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32C691F2259C
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Apr 2024 09:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5533A3A1DE;
	Fri, 12 Apr 2024 09:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b="L+JugcT2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2129.outbound.protection.outlook.com [40.107.241.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91E551C34
	for <linux-integrity@vger.kernel.org>; Fri, 12 Apr 2024 09:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712913405; cv=fail; b=t7g9+08kCsieqEyRseCUMdmXj9Udjv1bmPwMI1eL3oak+h52Cjf6XLZ0Ivya9F2UwhmwEyrizcGYB6tcQzU0R4tFRnfsk/LpuaQES7pSqFY6s9yBjIkhfNUNTrKh8a6PhH247zNY5U3/Fb0CbqjMUMA6dausx4GFFpqOAeUQyjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712913405; c=relaxed/simple;
	bh=qbjs18Eabaa+oD6IGRwxyL8sJPdE2VTiomqIo+PIXVU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=gMzGDxATi7JHGp5InQQ8LZmhbANw6OHhz1OXZqeHFJKheM0lJCrmKs9n8q/KsDs7kZhuUrlV5mEoIjSZyWyZEbshSo4Ea/DhIXtvxNvUyESSRjvU6ywCsSGd1B4ep2rf+a5N+psSVNgqPNq0T8oKzvEqILfVxhaV6qbZPzz34IA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=L+JugcT2; arc=fail smtp.client-ip=40.107.241.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polito.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=polito.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFBKQDgrer6hrWi3HaiYyMeNotya6TlgtD6wmC9An/+WGCAmB26mF7aUJ37pnwHQym2MzDJcbhZ0h/tFD7BuBjWvWZz0rZnSq01sQ91q6ZgQcADvoN7TklEUjFhnRV/XmQ58zGmZB2vjsehYyrqtLQWgGJhQHYMao3GsRYrrS8nRQ/4SvzDac+PcPNe+0t5/ftfgO+9OjPg/eV8keYedWiLxkPMdglZufvrfCTY2822Xx2fvFpI4B9QLZuRz1a6kGe5WajUGrL5sdi649qSekbEVqZ5CWosKdf6H2E21m6Ym7Lb/CeQvjYMj9RV/aOHJXmNUfZ4UCgcU9WLcqa+hNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M62LwHJhaAcAyMRj8MEv5Y9gSd4lMgSc5NWe78qce/E=;
 b=KHN6eP1Q07w0MPASFDbXl12NuDbo8usJvnJ7BQ1LrK8efN+qYG9fv4lKbU3lpdaEo5vPF8fEQFxeIX8x+gH7lnUqu2OKEL+pghQriV6BdiVb3l8qlQjgFwyfKbVuxdqDhF/ZfWo2H0e0shNS/rT5xT4YcJX2v0gFxR4M3tcbDXLKjAXhbg7JaaN/ryqtNHuzqPsqR4mUMeXR1cBI4A2IPSA8FeLjGqAHV3ZsfT6YH43Z9hLGyEbnaDCzo1bo0Bevq+MRoS5PNFK8jAkPaWb5U3Damo+YJI8wJnZuUrmxGG9NClIZ9lchhgXOOkQQ6WW52K5bKGfe4JhECCu+KzUzJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M62LwHJhaAcAyMRj8MEv5Y9gSd4lMgSc5NWe78qce/E=;
 b=L+JugcT2HmhCIIQgetveXH/Y47B57XyqwaxKHMcovgZq1nEpZ+8/tU0+pI3wY8JwJJlXaOYFaNow6GqTlhhu4JNoMeOPXdetMXD0tk59j117Ov4C6Fa/+qTp8ZfrL+PbRKsg8rLfyuSBpJZyzo9lkA+APJijzf5B2/EsJmHUHxI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=polito.it;
Received: from AS2PR05MB9840.eurprd05.prod.outlook.com (2603:10a6:20b:5f5::20)
 by PAVPR05MB10473.eurprd05.prod.outlook.com (2603:10a6:102:2f8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Fri, 12 Apr
 2024 09:16:38 +0000
Received: from AS2PR05MB9840.eurprd05.prod.outlook.com
 ([fe80::87c7:ebd:309f:8e5]) by AS2PR05MB9840.eurprd05.prod.outlook.com
 ([fe80::87c7:ebd:309f:8e5%5]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 09:16:38 +0000
From: Enrico Bravi <enrico.bravi@polito.it>
To: linux-integrity@vger.kernel.org,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com
Cc: roberto.sassu@huawei.com,
	Enrico Bravi <enrico.bravi@polito.it>,
	Silvia Sisinni <silvia.sisinni@polito.it>
Subject: [PATCH v7] ima: add crypto agility support for template-hash algorithm
Date: Fri, 12 Apr 2024 11:09:53 +0200
Message-Id: <20240412090951.1893890-1-enrico.bravi@polito.it>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0080.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::13) To AS2PR05MB9840.eurprd05.prod.outlook.com
 (2603:10a6:20b:5f5::20)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR05MB9840:EE_|PAVPR05MB10473:EE_
X-MS-Office365-Filtering-Correlation-Id: 2df9f45d-83d8-48b0-1d50-08dc5ad141b5
X-politoEOL-CGPAlias: 1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4XnSkeIbMKmdB0p+R78VRbvrczpe4Q6VjevaZ1rVkFTXST/wQWYfJrdU13Q0eIKiY4KOMmkEKUMRN/pA9q29r35JQbrRCUnBaKHhy97Sn31QEBLI9lSZs6mEZpBbq0cbC6eUwfdjEmrW2FBtFGDuTv4nUwWx1UyFOAvw7b10fxJ6wWaS96IeLaDBVmRlEJnrNMLYqn7bYWJh1FIy132oZF89XJ7+sGhjTN/dmv8Nyi47So+hvqETUtkbWiplz0ASoT/M5agh0i4E1i8Yfs0Yr8B2B1rR3khzkrfFanVTOTd5k+7Pylrh4wKQQSn+gLm1DNO6X1um9+LFGMzCLug98DtJNZN3qr+eLZMRy81lf88EY53Ntil+SFnh5Rny3X+jgdjFWvzMb7EC02UjeZYMZ4SlEgmbMPwAOvTgddKWgTf408dpIFCfCZZgWJEfGDeLYO/iEMWgg72lfyojA7gptskCInK2EVFFlCCPiafID76XXbRH6l/HfK9GPVGdNhlknX1j44m1NOOeZdhPk20Gk4Q6X09cG3EusGnKO3vrRmMdhoxctTEZYyp/oTCKO7x7gvU808d1PHgt191gXAjkiBNDq3ci7hdRJW0gUT29th2erJEbC1m3mbWna/1UES0XuvFfp7QAsCHEX/8DGFqX5XIIF72RnQmVsHkLJ6qd19+EF9zp7J7tiR0xM8rSQt6gmVlK3OqCX9/k9/gUOOPslA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR05MB9840.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ElW1PkznQa7D+TScMdlz6weLto3ZLXXZGSn4ivkHXOg6fKQyYF6RVYgz+Zwf?=
 =?us-ascii?Q?iCJdCwtpCLPY/Bo5zwNQQfdKcmR3q5xavl6yA+BaBS6SrdG1xDwpNAEW4SsF?=
 =?us-ascii?Q?hxEEiGX7iwR81XMXqUBl0Iv/OGQGP6nHBf/nGzpAjCbefI0PahQebWcZtf7h?=
 =?us-ascii?Q?PWDQZyk2L/MgI1JP4JZUQzzHzqVQ/k2QHLEDpNcbzUPPKFXDKlUF1YMIuCsM?=
 =?us-ascii?Q?RgvPlHqBVZMe06gvaX0oOSkpAbpKHP1XPY92vpBA2VS5xKH6lRX2nkutLU+r?=
 =?us-ascii?Q?HZJA5MHljvp7nWmr8cOQ3XTMFjNqalsQ+WttkwBf1doBDtSUCwhBSRIJm/nt?=
 =?us-ascii?Q?gwjhnRcXOVlJfmUBuKjC8HzdW2pXq8HKd+gkHYmv4y/1pxlDPTNODdlt3eE3?=
 =?us-ascii?Q?+gHmCCLAi+iCyV8VVuWwPaKJ0R3l+/vl1m2kiL2jSzb6/8KMHW0wwh5kyi0R?=
 =?us-ascii?Q?r3VXuWNnJuJVOeM94IGB/haPei5bGhkEmD/Ft1MPNcwvR3hdslpA7FAbXnQf?=
 =?us-ascii?Q?3fxt/KUxYLHDqiDaCOzol4eQFjyCtCoR8zLhuXski2HP7IQPhV9c/zSGA+2p?=
 =?us-ascii?Q?rBR4klss4OAq3tx9hLBHPtCb1Cmq+81Cpufzpd1rIR4N+3nDCAcGiQPmYa1h?=
 =?us-ascii?Q?bYSDBSmpRNLVmljum1X9FhZotyPfY8C3Ay9/371NAjnl0+jXamOXinEpByaS?=
 =?us-ascii?Q?U6U4W4ne41oXWn9vkkJ17F2vAoUyd9xt82eikX2t0Hc2jm7Kr89aJx/i5nMy?=
 =?us-ascii?Q?JOL1Ynx+foVXoXAq0GWvDcV4gs384qcf+PupX47FcEYTooz/EbviI9ASe7IS?=
 =?us-ascii?Q?BP/UvTPIUgAym55VdX6jRj1+sLg28dtLhX8JAw5Rn0DpzAYIsDeIuFcdiPNv?=
 =?us-ascii?Q?wi4Y4JTWUx9H4mxZE0dCsjXRt50dX13mBVMGnO+2/H++InzTFz3a4BSJHyBw?=
 =?us-ascii?Q?vHpZ2FxC7zWoR34IkTRk53aECTrkfQkiMue3B5FgOl3uPynzTUzObmE38SK7?=
 =?us-ascii?Q?1FBq438TewVSSjC5sTyTJB5HlKo8sC8yCzXjaJdYTKImxXO2m8me6uGNw31D?=
 =?us-ascii?Q?TRB0gw9Abzf7AmbXs4lNP3DJythGjqL+riy+iRQG1V9Rc1x3vwRMSmT6efX6?=
 =?us-ascii?Q?SF3udSYKs7k8zd8KXk1pLClbiRBKROCEywX2f0uVwUWhOCv3Bzdqt8L17w1v?=
 =?us-ascii?Q?xPTc/uPmlJ4SMtMFj8FzeHWpdQnyQ0W7zYKkZ19/9UtSu31DY+9Yfl7CQGOE?=
 =?us-ascii?Q?hf5/LdqxBAhadj7v3efgNjWVynl1/J9pqTi+3s+kFHhKOKfkO65g8kUkanJ5?=
 =?us-ascii?Q?WQ8O/kRYHhwUQD2tsSDVs07vVnsfg/NEDq7/yqt47OrG6+ewhIikC5D3bLJW?=
 =?us-ascii?Q?apq3vvgk9Mc5bQbTSp/L5tXG6eap0qIqSwhTAB/DyL2KV2kdjef8p6ByVSNE?=
 =?us-ascii?Q?BwCA83H4H4H3ltcrNkGP+iQyqQWd4vhxWr3UPonLqQhu/xG0Kkn01yzN/aD9?=
 =?us-ascii?Q?SmJJCJ3fXPEiTlCfRp9FvkVEKdULaDqTiVrt9hxLXjGK6Tu++OKi09tX1v7Z?=
 =?us-ascii?Q?ATypF1S4LLN6DTZuvEDRM2XdA/Q9gLwT0WAeRpNMR6tfdMXAu7ARUbfC4FZI?=
 =?us-ascii?Q?JA=3D=3D?=
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df9f45d-83d8-48b0-1d50-08dc5ad141b5
X-MS-Exchange-CrossTenant-AuthSource: AS2PR05MB9840.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 09:16:37.9814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xlwXXSIjRgOpYTfaI5zsz/1kqSLmyPsJ3ozIecnqj6s6Y7JPb8wlJOKN5gHtXgTE1Np9Qgp2InIjxuP4Utocgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR05MB10473

The template hash showed by the ascii_runtime_measurements and
binary_runtime_measurements is the one calculated using sha1 and there is
no possibility to change this value, despite the fact that the template
hash is calculated using the hash algorithms corresponding to all the PCR
banks configured in the TPM.

Add the support to retrieve the ima log with the template data hash
calculated with a specific hash algorithm.
Add a new file in the securityfs ima directory for each hash algo
configured in a PCR bank of the TPM. Each new file has the name with
the following structure:

        {binary, ascii}_runtime_measurements_<hash_algo_name>

Legacy files are kept, to avoid breaking existing applications, but as
symbolic links which point to {binary, ascii}_runtime_measurements_sha1
files. These two files are created even if a TPM chip is not detected or
the sha1 bank is not configured in the TPM.

As example, in the case a TPM chip is present and sha256 is the only
configured PCR bank, the listing of the securityfs ima directory is the
following:

lr--r--r-- [...] ascii_runtime_measurements -> ascii_runtime_measurements_sha1
-r--r----- [...] ascii_runtime_measurements_sha1
-r--r----- [...] ascii_runtime_measurements_sha256
lr--r--r-- [...] binary_runtime_measurements -> binary_runtime_measurements_sha1
-r--r----- [...] binary_runtime_measurements_sha1
-r--r----- [...] binary_runtime_measurements_sha256
--w------- [...] policy
-r--r----- [...] runtime_measurements_count
-r--r----- [...] violations

Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>
Signed-off-by: Silvia Sisinni <silvia.sisinni@polito.it>
Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>

---

v7:
 - Renamed lookup_algo_by_dentry() to lookup_template_data_hash_algo().
 - Set ima_algo_array as __ro_after_init.
 - Fixed some lines > 80 characters.

v6:
 - Fixed format error when applying the patch.

v5:
 - Added lookup_algo_by_dentry() function to select the hash algo during
   measurements dump. (suggested by Roberto)
 - Renamed remove_measurements_list_files() to
   remove_securityfs_measurement_lists() and create_measurements_list_files()
   to create_securityfs_measurement_lists(), and marked both as __init.
   (suggested by Mimi)
 - Renamed ima_ascii_measurements_files to ascii_securityfs_measurement_lists,
   ima_binary_measurements_files to binary_securityfs_measurement_lists and
   ima_measurements_files_count to securityfs_measurement_list_count, and
   marked them as __ro_after_init. (suggested by Mimi)
 - Added missing NULL assignment for file.file in ima_dump_measurement_list()
   during kexec.

v4:
 - Added NULL check on m->file for measurements list dump called by
   ima_dump_measurement_list() on kexec.
 - Exported ima_algo_array and struct ima_algo_desc declaration from
   ima_crypto.c to access this information in ima_fs.c.
 - Added ima_measurements_files_count global variable to avoid extra
   logic each time the number of measurements file is needed.

v3:
 - Added create_measurements_list_files function for measurements files creation.
 - Parameterized the remove_measurements_list_files function and add NULL
   check before freeing files' list.
 - Removed algorithm selection based on file name during ima_measurements_show
   and ima_ascii_measurements_show, and selecting it comparing dentry address.
 - Allocate also sha1 file following the schema
   {binary, ascii}_runtime_measurements_<hash_algo_name> and keep legacy
   files as symbolic links to those files.
 - Allocate measurements files lists even if a TPM chip is not detected,
   adding only sha1 files.

v2:
 - Changed the behavior of configuring at boot time the template data hash
   algorithm.
 - Removed template data hash algo name prefix.
 - Removed ima_template_hash command line option.
 - Introducing a new file in the securityfs ima subdir for each PCR banks
   algorithm configured in the TPM.
   (suggested by Roberto)

 security/integrity/ima/ima.h        |   8 ++
 security/integrity/ima/ima_crypto.c |   7 +-
 security/integrity/ima/ima_fs.c     | 134 +++++++++++++++++++++++++---
 security/integrity/ima/ima_kexec.c  |   1 +
 4 files changed, 132 insertions(+), 18 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 9151b5369cdc..3e568126cd48 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -49,11 +49,19 @@ extern int ima_policy_flag;
 /* bitset of digests algorithms allowed in the setxattr hook */
 extern atomic_t ima_setxattr_allowed_hash_algorithms;
 
+/* IMA hash algorithm description */
+struct ima_algo_desc {
+	struct crypto_shash *tfm;
+	enum hash_algo algo;
+};
+
 /* set during initialization */
 extern int ima_hash_algo __ro_after_init;
 extern int ima_sha1_idx __ro_after_init;
 extern int ima_hash_algo_idx __ro_after_init;
 extern int ima_extra_slots __ro_after_init;
+extern struct ima_algo_desc *ima_algo_array __ro_after_init;
+
 extern int ima_appraise;
 extern struct tpm_chip *ima_tpm_chip;
 extern const char boot_aggregate_name[];
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index f3738b2c8bcd..6f5696d999d0 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -57,11 +57,6 @@ MODULE_PARM_DESC(ahash_bufsize, "Maximum ahash buffer size");
 static struct crypto_shash *ima_shash_tfm;
 static struct crypto_ahash *ima_ahash_tfm;
 
-struct ima_algo_desc {
-	struct crypto_shash *tfm;
-	enum hash_algo algo;
-};
-
 int ima_sha1_idx __ro_after_init;
 int ima_hash_algo_idx __ro_after_init;
 /*
@@ -70,7 +65,7 @@ int ima_hash_algo_idx __ro_after_init;
  */
 int ima_extra_slots __ro_after_init;
 
-static struct ima_algo_desc *ima_algo_array;
+struct ima_algo_desc *ima_algo_array __ro_after_init;
 
 static int __init ima_init_ima_crypto(void)
 {
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index cd1683dad3bf..abdd22007ed8 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -116,9 +116,31 @@ void ima_putc(struct seq_file *m, void *data, int datalen)
 		seq_putc(m, *(char *)data++);
 }
 
+static struct dentry **ascii_securityfs_measurement_lists __ro_after_init;
+static struct dentry **binary_securityfs_measurement_lists __ro_after_init;
+static int securityfs_measurement_list_count __ro_after_init;
+
+static void lookup_template_data_hash_algo(int *algo_idx, enum hash_algo *algo,
+					   struct seq_file *m,
+					   struct dentry **lists)
+{
+	struct dentry *dentry;
+	int i;
+
+	dentry = file_dentry(m->file);
+
+	for (i = 0; i < securityfs_measurement_list_count; i++) {
+		if (dentry == lists[i]) {
+			*algo_idx = i;
+			*algo = ima_algo_array[i].algo;
+			break;
+		}
+	}
+}
+
 /* print format:
  *       32bit-le=pcr#
- *       char[20]=template digest
+ *       char[n]=template digest
  *       32bit-le=template name size
  *       char[n]=template name
  *       [eventdata length]
@@ -132,7 +154,15 @@ int ima_measurements_show(struct seq_file *m, void *v)
 	char *template_name;
 	u32 pcr, namelen, template_data_len; /* temporary fields */
 	bool is_ima_template = false;
-	int i;
+	enum hash_algo algo;
+	int i, algo_idx;
+
+	algo_idx = ima_sha1_idx;
+	algo = HASH_ALGO_SHA1;
+
+	if (m->file != NULL)
+		lookup_template_data_hash_algo(&algo_idx, &algo, m,
+					       binary_securityfs_measurement_lists);
 
 	/* get entry */
 	e = qe->entry;
@@ -151,7 +181,7 @@ int ima_measurements_show(struct seq_file *m, void *v)
 	ima_putc(m, &pcr, sizeof(e->pcr));
 
 	/* 2nd: template digest */
-	ima_putc(m, e->digests[ima_sha1_idx].digest, TPM_DIGEST_SIZE);
+	ima_putc(m, e->digests[algo_idx].digest, hash_digest_size[algo]);
 
 	/* 3rd: template name size */
 	namelen = !ima_canonical_fmt ? strlen(template_name) :
@@ -220,7 +250,15 @@ static int ima_ascii_measurements_show(struct seq_file *m, void *v)
 	struct ima_queue_entry *qe = v;
 	struct ima_template_entry *e;
 	char *template_name;
-	int i;
+	enum hash_algo algo;
+	int i, algo_idx;
+
+	algo_idx = ima_sha1_idx;
+	algo = HASH_ALGO_SHA1;
+
+	if (m->file != NULL)
+		lookup_template_data_hash_algo(&algo_idx, &algo, m,
+					       ascii_securityfs_measurement_lists);
 
 	/* get entry */
 	e = qe->entry;
@@ -233,8 +271,8 @@ static int ima_ascii_measurements_show(struct seq_file *m, void *v)
 	/* 1st: PCR used (config option) */
 	seq_printf(m, "%2d ", e->pcr);
 
-	/* 2nd: SHA1 template hash */
-	ima_print_digest(m, e->digests[ima_sha1_idx].digest, TPM_DIGEST_SIZE);
+	/* 2nd: template hash */
+	ima_print_digest(m, e->digests[algo_idx].digest, hash_digest_size[algo]);
 
 	/* 3th:  template name */
 	seq_printf(m, " %s", template_name);
@@ -379,6 +417,71 @@ static const struct seq_operations ima_policy_seqops = {
 };
 #endif
 
+static void __init remove_securityfs_measurement_lists(struct dentry **lists)
+{
+	int i;
+
+	if (lists) {
+		for (i = 0; i < securityfs_measurement_list_count; i++)
+			securityfs_remove(lists[i]);
+
+		kfree(lists);
+	}
+
+	securityfs_measurement_list_count = 0;
+}
+
+static int __init create_securityfs_measurement_lists(void)
+{
+	char file_name[NAME_MAX + 1];
+	struct dentry *dentry;
+	u16 algo;
+	int i;
+
+	securityfs_measurement_list_count = NR_BANKS(ima_tpm_chip);
+
+	if (ima_sha1_idx >= NR_BANKS(ima_tpm_chip))
+		securityfs_measurement_list_count++;
+
+	ascii_securityfs_measurement_lists =
+	    kcalloc(securityfs_measurement_list_count, sizeof(struct dentry *),
+		    GFP_KERNEL);
+	if (!ascii_securityfs_measurement_lists)
+		return -ENOMEM;
+
+	binary_securityfs_measurement_lists =
+	    kcalloc(securityfs_measurement_list_count, sizeof(struct dentry *),
+		    GFP_KERNEL);
+	if (!binary_securityfs_measurement_lists)
+		return -ENOMEM;
+
+	for (i = 0; i < securityfs_measurement_list_count; i++) {
+		algo = ima_algo_array[i].algo;
+
+		sprintf(file_name, "ascii_runtime_measurements_%s",
+			hash_algo_name[algo]);
+		dentry = securityfs_create_file(file_name, S_IRUSR | S_IRGRP,
+						ima_dir, NULL,
+						&ima_ascii_measurements_ops);
+		if (IS_ERR(dentry))
+			return PTR_ERR(dentry);
+
+		ascii_securityfs_measurement_lists[i] = dentry;
+
+		sprintf(file_name, "binary_runtime_measurements_%s",
+			hash_algo_name[algo]);
+		dentry = securityfs_create_file(file_name, S_IRUSR | S_IRGRP,
+						ima_dir, NULL,
+						&ima_measurements_ops);
+		if (IS_ERR(dentry))
+			return PTR_ERR(dentry);
+
+		binary_securityfs_measurement_lists[i] = dentry;
+	}
+
+	return 0;
+}
+
 /*
  * ima_open_policy: sequentialize access to the policy file
  */
@@ -454,6 +557,9 @@ int __init ima_fs_init(void)
 {
 	int ret;
 
+	ascii_securityfs_measurement_lists = NULL;
+	binary_securityfs_measurement_lists = NULL;
+
 	ima_dir = securityfs_create_dir("ima", integrity_dir);
 	if (IS_ERR(ima_dir))
 		return PTR_ERR(ima_dir);
@@ -465,19 +571,21 @@ int __init ima_fs_init(void)
 		goto out;
 	}
 
+	ret = create_securityfs_measurement_lists();
+	if (ret != 0)
+		goto out;
+
 	binary_runtime_measurements =
-	    securityfs_create_file("binary_runtime_measurements",
-				   S_IRUSR | S_IRGRP, ima_dir, NULL,
-				   &ima_measurements_ops);
+	    securityfs_create_symlink("binary_runtime_measurements", ima_dir,
+				      "binary_runtime_measurements_sha1", NULL);
 	if (IS_ERR(binary_runtime_measurements)) {
 		ret = PTR_ERR(binary_runtime_measurements);
 		goto out;
 	}
 
 	ascii_runtime_measurements =
-	    securityfs_create_file("ascii_runtime_measurements",
-				   S_IRUSR | S_IRGRP, ima_dir, NULL,
-				   &ima_ascii_measurements_ops);
+	    securityfs_create_symlink("ascii_runtime_measurements", ima_dir,
+				      "ascii_runtime_measurements_sha1", NULL);
 	if (IS_ERR(ascii_runtime_measurements)) {
 		ret = PTR_ERR(ascii_runtime_measurements);
 		goto out;
@@ -515,6 +623,8 @@ int __init ima_fs_init(void)
 	securityfs_remove(runtime_measurements_count);
 	securityfs_remove(ascii_runtime_measurements);
 	securityfs_remove(binary_runtime_measurements);
+	remove_securityfs_measurement_lists(ascii_securityfs_measurement_lists);
+	remove_securityfs_measurement_lists(binary_securityfs_measurement_lists);
 	securityfs_remove(ima_symlink);
 	securityfs_remove(ima_dir);
 
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index dadc1d138118..52e00332defe 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -30,6 +30,7 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 		goto out;
 	}
 
+	file.file = NULL;
 	file.size = segment_size;
 	file.read_pos = 0;
 	file.count = sizeof(khdr);	/* reserved space */

base-commit: 5e2e4d0ea5c2c886c4a082890be6a1c2ee064605
-- 
2.34.1


