Return-Path: <linux-integrity+bounces-2026-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0254D89BE08
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Apr 2024 13:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EB0A1F21CF2
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Apr 2024 11:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A621651B7;
	Mon,  8 Apr 2024 11:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b="B3o6dyA8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2096.outbound.protection.outlook.com [40.107.22.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854ED657C5
	for <linux-integrity@vger.kernel.org>; Mon,  8 Apr 2024 11:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712575194; cv=fail; b=Gse3/2QB4wk7+YrvlztvjAdHCwos58wdKeF64o3z1GfQP8pn3ZwYWZvCViyEp48mNaNplThhC/wEBE2TmPtQLhlJnKGz9zLELfONrB9TCAeRANn/RbHsST8x7Ar0drmvn2iq6tCuBT0kkHOjxGDkTFBWmVeHVj5OAckhjEMQ/sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712575194; c=relaxed/simple;
	bh=bxmGjPSwEjy8Bf8oCcvMR/UpWpVeQKerAFpEFopHb+0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lSK2NiDsWPwdbKb3j+ZSCzozeIHL3LCI6izkNuiZh0/cSCSYItagiF0Upw3+2IWDkK3yaTS42x8d3tm8CqI7F3PkRoA1VmDITBjxuSJtIi5cy1BfmyJ1oolv/mRoI7D4xKHh5XXIzGy5LdEbMCF+eZj0LyY4JPMuhCU2cKzYo7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=B3o6dyA8; arc=fail smtp.client-ip=40.107.22.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polito.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=polito.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfOf0qwnoGObcz2rDQIBngLcvCG4CKBe42TyNobdJRAnVLCxXNsB/qUkDX+O6gUbpFek7aD8hXFhb35ZGB3rnw6Gla4y0EQ1mC7lYda+b4GCfJhWAb3F2MX+c1g5lyGkBVdxuOhUc8WW6Pn7vIcbpTMVHyVub0Ak6lxI83STuZrOXV0CJc2HxNHYgtvqqmk4Gy0tCG7yxRuDmHhHmmbiWZKc5z5myPixWnmaqgP9kGRBqTi19J+oKHezOG+BM0F6yq15M5R0zrfNPfj3+0mZjSkYx2/HrcUQrqtTkQ4vUyNZrsKCmxWc/8F26ogAAGpT02E0BNO8EVZvzSWsTHIzqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojU8thpJiNiKlvI1Xiu2/GTBVfXawGr1/rsWnAqTj7I=;
 b=CH+G8D9bNnbuOtNBqExrm8id91odByZntR7gxgipRlN89EpRJEkecmKdUYJML8t4Hm63nCrH+P65s5claiUIc83UR8kvaDt/x+KDsaMQtwT99jyN0yrqZ+1Xoe67dOb+GJzayr4NvMfhdlvryzoLQ3EXda/kz8bigS0at5FJdWfpTXSWJ5Zq6hDdXrtF/e49/8K7TLIY1+P6Vly9BnHQmAm/STlxh7o3ptpEOVjzgqNIpevgdndWiZzPfsib/+hN2nI6neHlfUSQ9mox6WQNbcg21rmpREJ7QmsmRtQhbFdQH7xigiWjHeiDyHc2kBlDRT69J/zBSQWve+4yjv1WZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojU8thpJiNiKlvI1Xiu2/GTBVfXawGr1/rsWnAqTj7I=;
 b=B3o6dyA8jYnCo6LujocQ3kJAsip+kWrWA4FYipSk80IYbQThw6JEssTnbOJmOCEF9iL+Ry2/U7F5mpl+IWf7sUhyWP7oHK+h8cYyNhARWNlRwnVzATrrmKvhb5YuyFDK1m8hQ3a9Tsgci3VVzLPXz3ippu7xYJcSxa0Dcbp0Haw=
Received: from AS2PR05MB9840.eurprd05.prod.outlook.com (2603:10a6:20b:5f5::20)
 by AM9PR05MB7793.eurprd05.prod.outlook.com (2603:10a6:20b:2c6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 11:19:43 +0000
Received: from AS2PR05MB9840.eurprd05.prod.outlook.com
 ([fe80::87c7:ebd:309f:8e5]) by AS2PR05MB9840.eurprd05.prod.outlook.com
 ([fe80::87c7:ebd:309f:8e5%5]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 11:19:43 +0000
From: Enrico Bravi <enrico.bravi@polito.it>
To: linux-integrity@vger.kernel.org,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com
Cc: roberto.sassu@huawei.com,
	Enrico Bravi <enrico.bravi@polito.it>,
	Silvia Sisinni <silvia.sisinni@polito.it>
Subject: [PATCH v5] ima: add crypto agility support for template-hash algorithm
Date: Mon,  8 Apr 2024 13:17:28 +0200
Message-Id: <20240408111727.404486-1-enrico.bravi@polito.it>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZRAP278CA0005.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::15) To AS2PR05MB9840.eurprd05.prod.outlook.com
 (2603:10a6:20b:5f5::20)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR05MB9840:EE_|AM9PR05MB7793:EE_
X-politoEOL-CGPAlias: 1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/+P8HRhpCQm9dqV5KXxrWp42YiUTx6jN5rTBGv/HEXsDg1ICNNXlI1V/9JpK40FOTBY5IUIBmBotSBnqabpMNzsVng62QL3ZB5ikj6vUlSKifjdblyXXJlp3Dmlw5gxi+YcA6xngKq5QN/4wUNz9EHggIkM48lg9rVQH6dNK6T3VZiZCRQn5L1yiEWoHxBPDrIY1/QkJh2JfwXFMZbGn053iMDTmxSoBtflxFp/b1Fn7nijJheQPKZ6heqvGELG8HVDbn/YHy4UbiBcIH+H/p9SA9QLpUP/3wC5guszjz/knbEFFi07wF7s6l1b95hIfwg/oXt80iwcRm5cii3UvNk/j5zkGPAen1Vr50wh6OXQgT3x9BQIhVflvZ/aIdYB6N6B5dt7DZnRkh5Zrf3KE8VtBlRsD3jkfYGd4Tl0aZ8XQ/mzLCSEYadb3hUhlyiRLLeCx/Hp2xnwvXL8I6bCx/zXXtfw1P0rAR8w4BSnXQGz3BOZMC9DrT273vZRP4CBuueBy1SvMHn7NzePJwX9YG0rL1MoX3QTHgLnE0IiRicdbLJwujV9OAkwX8SY6hwcn5KHvZU5IEV3mj8SsEtRWMzQnKtJx8p9zXLiNukMLXD93dF/4Cm3LJZXfvScvN8fuDVVraM93+1QQcmsZCV2T2r/O3Ta96u85hOWkRhCNgkG20zcsAHpcqg1NyNeU9WXDQZUEJKrxczGGp7hDwEgPlQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR05MB9840.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F9OCu+uH9xco70pHugXoVr5r/HIi/KoPMC/YbMLmjHoc4N7wzdMLtXfbSpXm?=
 =?us-ascii?Q?FWarLVbogunSPr6qvwFFSrQVB098BPr0Suz3wK6kD8wpdEZdz9zVkDBPWDDz?=
 =?us-ascii?Q?ROXADE3Vs2jtrEebsE6M4qLeNRmZgIo4xdtTPCNOMuYpAzJ6jD9qCr61iP5f?=
 =?us-ascii?Q?jqC/JaZLaCyBeihkzRWLHijOvKSkTszRP+HQC/IJ8w77vq6merlELFt+eXWD?=
 =?us-ascii?Q?/g8RLzrV3MBDno4BtT6sg/toMZbu4P+9KGeCPsGtvTxY1z4gKZz49UZavAzV?=
 =?us-ascii?Q?ypxB5XrKjMisxrVgViUpoLz23t9NoOK7dRttWYNJE9hJumJQ57cBATc+mF67?=
 =?us-ascii?Q?EUNz82Fbqb1dfXe5LOVAfyySEdCtdOjsSPZyzOIHJAxPiC4WrJ6K6V8k9xbK?=
 =?us-ascii?Q?ehmWS5hULlppVeYi1SomGi2xP7eufUzNzvCSCD0Q+edcYR5fKZymM9CFlGeU?=
 =?us-ascii?Q?Cdliwp1ax5I/lSLFVh/9E9v6ZrxPgK1Dj7FDaRj2fYbz45mNFEXc3K7FjXzD?=
 =?us-ascii?Q?LlqP91uYE0xY0GQYIQpLIZpyjSx0r2IIW1Agvexjbkf8rwboztFpWOqvU1yN?=
 =?us-ascii?Q?jfM8/AFX+7JgKi9zwRK7+MpjtIPTYXBVquu6DYa95k0C/kvaxmMsikn++ByZ?=
 =?us-ascii?Q?o621F5F3+XGpXy+xU3xVdcsIHuEH5cq1HTDkjmS+cg4yv302/pXQIY51IUp+?=
 =?us-ascii?Q?Hxf+A3rNYp664RK15yCUwRIuVVmvUMYIikoFf4AwU3qBy/g61fpeJ4oMaMlw?=
 =?us-ascii?Q?NB92HAkVxI1WXkyZBc0vf0KMeCRWENhQqaRqaSmcVYCExxEhDCcI+qOYKnOB?=
 =?us-ascii?Q?RAHGkc89EtgSXJ6FIquBxWP3A2zynayHj8iUPMbxGsNCnoWr/UOqmf65RtyW?=
 =?us-ascii?Q?0TkxGlM+SwuF63SnsxTg0ipb3MlGpCvhMWFuiQpSx3egnKnkJAdXgndDkxDu?=
 =?us-ascii?Q?VP0W5QF8Y5vqpeZgVm4F0xW0xNzMMGRs4KPUajR5R2jFPHsCMCSCDq5M76hy?=
 =?us-ascii?Q?tdctu9US+obmjOmXWTITml33TXd1UvmIrorSArJOoPuWUc7TXS+9NXi2EUal?=
 =?us-ascii?Q?5QffGvQJ+XFgmSTQ/2rv4EiNrczOp5BD3LQh+Ibxd67yn9I7ri6OaSc9jsvK?=
 =?us-ascii?Q?+KXvW/Yp1t5mmiruHoZCjvfhdHgYMD8yep1guMKCzRtontUFapnC+3m6kb43?=
 =?us-ascii?Q?cZuG0uI8vq9j6TISLBgPB/LFdLBBoywCqZ5EYNQpy3USFdGyueLZxpz+Zv9W?=
 =?us-ascii?Q?6k4iCukKiStKkchxiyz+G0kciTb31gva57DUgQRMtQxROAviNXbSqw7odhRG?=
 =?us-ascii?Q?C4mYDoFAiaOGAM4mmheyx/EGbb3vVNA1i8l7wpj4Pic5YGuHX0MeSq+hDRpF?=
 =?us-ascii?Q?prgHz24oDlobTQGXA5jSSuybyadMpVGMcxm+8/loBNo011DMKyo0OVpovp/O?=
 =?us-ascii?Q?DK+YO8yz/fztC/U4kvxefR78fh49eQzP3BRgqu7t79JIMg4HQc1215f04Uhv?=
 =?us-ascii?Q?vqP2Zf5vKVUwFoyJD/QazKQZ0KZDGsZnQGHfUoRDQSBUz+4OKc1WihKKLTUt?=
 =?us-ascii?Q?t7SL1xLtxWLyFfvAfHazqGcm56IYFrLCZuKTF7b/egHuCWiU6Zun9zenRzCb?=
 =?us-ascii?Q?lQ=3D=3D?=
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 7410fec9-913e-4d45-640a-08dc57bdca04
X-MS-Exchange-CrossTenant-AuthSource: AS2PR05MB9840.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 11:19:43.1180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CSghH92Hva05izXmBPy121pD5Ng6D0qKQwZtcr+5Bmn0sAQehkQQlxwo5HduOqSjoEYxhqJJkxDihwl6i/BBeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR05MB7793

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

---

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

---
 security/integrity/ima/ima.h        |  10 +++
 security/integrity/ima/ima_crypto.c |   7 +-
 security/integrity/ima/ima_fs.c     | 129 +++++++++++++++++++++++++---
 security/integrity/ima/ima_kexec.c  |   1 +
 4 files changed, 129 insertions(+), 18 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index c29db699c996..e5e45cce4d0e 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -54,6 +54,16 @@ extern int ima_hash_algo __ro_after_init;
 extern int ima_sha1_idx __ro_after_init;
 extern int ima_hash_algo_idx __ro_after_init;
 extern int ima_extra_slots __ro_after_init;
+
+/* IMA hash algorithm description */
+struct ima_algo_desc {
+	struct crypto_shash *tfm;
+	enum hash_algo algo;
+};
+
+/* hash algorithms configured in IMA */
+extern struct ima_algo_desc *ima_algo_array;
+
 extern int ima_appraise;
 extern struct tpm_chip *ima_tpm_chip;
 extern const char boot_aggregate_name[];
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index f3738b2c8bcd..3606931fc525 100644
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
+struct ima_algo_desc *ima_algo_array;
 
 static int __init ima_init_ima_crypto(void)
 {
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index cd1683dad3bf..d0c8f7daa2e2 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -116,9 +116,30 @@ void ima_putc(struct seq_file *m, void *data, int datalen)
 		seq_putc(m, *(char *)data++);
 }
 
+static struct dentry **ascii_securityfs_measurement_lists __ro_after_init;
+static struct dentry **binary_securityfs_measurement_lists __ro_after_init;
+static int securityfs_measurement_list_count __ro_after_init;
+
+static void lookup_algo_by_dentry(int *algo_idx, enum hash_algo *algo,
+				  struct seq_file *m, struct dentry **dentry_list)
+{
+	struct dentry *dentry;
+	int i;
+
+	dentry = file_dentry(m->file);
+
+	for (i = 0; i < securityfs_measurement_list_count; i++) {
+		if (dentry == dentry_list[i]) {
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
@@ -132,7 +153,14 @@ int ima_measurements_show(struct seq_file *m, void *v)
 	char *template_name;
 	u32 pcr, namelen, template_data_len; /* temporary fields */
 	bool is_ima_template = false;
-	int i;
+	int i, algo_idx;
+	enum hash_algo algo;
+
+	algo_idx = ima_sha1_idx;
+	algo = HASH_ALGO_SHA1;
+
+	if (m->file != NULL)
+		lookup_algo_by_dentry(&algo_idx, &algo, m,
+				      binary_securityfs_measurement_lists);
 
 	/* get entry */
 	e = qe->entry;
@@ -151,7 +179,7 @@ int ima_measurements_show(struct seq_file *m, void *v)
 	ima_putc(m, &pcr, sizeof(e->pcr));
 
 	/* 2nd: template digest */
-	ima_putc(m, e->digests[ima_sha1_idx].digest, TPM_DIGEST_SIZE);
+	ima_putc(m, e->digests[algo_idx].digest, hash_digest_size[algo]);
 
 	/* 3rd: template name size */
 	namelen = !ima_canonical_fmt ? strlen(template_name) :
@@ -220,7 +248,14 @@ static int ima_ascii_measurements_show(struct seq_file *m, void *v)
 	struct ima_queue_entry *qe = v;
 	struct ima_template_entry *e;
 	char *template_name;
-	int i;
+	int i, algo_idx;
+	enum hash_algo algo;
+
+	algo_idx = ima_sha1_idx;
+	algo = HASH_ALGO_SHA1;
+
+	if (m->file != NULL)
+		lookup_algo_by_dentry(&algo_idx, &algo, m,
+				      ascii_securityfs_measurement_lists);
 
 	/* get entry */
 	e = qe->entry;
@@ -233,8 +268,8 @@ static int ima_ascii_measurements_show(struct seq_file *m, void *v)
 	/* 1st: PCR used (config option) */
 	seq_printf(m, "%2d ", e->pcr);
 
-	/* 2nd: SHA1 template hash */
-	ima_print_digest(m, e->digests[ima_sha1_idx].digest, TPM_DIGEST_SIZE);
+	/* 2nd: template hash */
+	ima_print_digest(m, e->digests[algo_idx].digest, hash_digest_size[algo]);
 
 	/* 3th:  template name */
 	seq_printf(m, " %s", template_name);
@@ -379,6 +414,69 @@ static const struct seq_operations ima_policy_seqops = {
 };
 #endif
 
+static void __init remove_securityfs_measurement_lists(struct dentry **dentry_list)
+{
+	int i;
+
+	if (dentry_list) {
+		for (i = 0; i < securityfs_measurement_list_count; i++)
+			securityfs_remove(dentry_list[i]);
+
+		kfree(dentry_list);
+	}
+
+	securityfs_measurement_list_count = 0;
+}
+
+static int __init create_securityfs_measurement_lists(void)
+{
+	int i;
+	u16 algo;
+	char file_name[NAME_MAX + 1];
+	struct dentry *dentry;
+
+	securityfs_measurement_list_count = NR_BANKS(ima_tpm_chip);
+
+	if (ima_sha1_idx >= NR_BANKS(ima_tpm_chip))
+		securityfs_measurement_list_count++;
+
+	ascii_securityfs_measurement_lists = kcalloc(securityfs_measurement_list_count,
+						     sizeof(struct dentry *), GFP_KERNEL);
+	if (!ascii_securityfs_measurement_lists)
+		return -ENOMEM;
+
+	binary_securityfs_measurement_lists = kcalloc(securityfs_measurement_list_count,
+						      sizeof(struct dentry *), GFP_KERNEL);
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
@@ -454,6 +552,9 @@ int __init ima_fs_init(void)
 {
 	int ret;
 
+	ascii_securityfs_measurement_lists = NULL;
+	binary_securityfs_measurement_lists = NULL;
+
 	ima_dir = securityfs_create_dir("ima", integrity_dir);
 	if (IS_ERR(ima_dir))
 		return PTR_ERR(ima_dir);
@@ -465,19 +566,21 @@ int __init ima_fs_init(void)
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
+		securityfs_create_symlink("binary_runtime_measurements", ima_dir,
+					  "binary_runtime_measurements_sha1", NULL);
 	if (IS_ERR(binary_runtime_measurements)) {
 		ret = PTR_ERR(binary_runtime_measurements);
 		goto out;
 	}
 
 	ascii_runtime_measurements =
-	    securityfs_create_file("ascii_runtime_measurements",
-				   S_IRUSR | S_IRGRP, ima_dir, NULL,
-				   &ima_ascii_measurements_ops);
+		securityfs_create_symlink("ascii_runtime_measurements", ima_dir,
+					  "ascii_runtime_measurements_sha1", NULL);
 	if (IS_ERR(ascii_runtime_measurements)) {
 		ret = PTR_ERR(ascii_runtime_measurements);
 		goto out;
@@ -515,6 +618,8 @@ int __init ima_fs_init(void)
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

base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
-- 
2.34.1


