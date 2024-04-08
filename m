Return-Path: <linux-integrity+bounces-2030-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFD189CDCA
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Apr 2024 23:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57D8F284850
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Apr 2024 21:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E4A2E41C;
	Mon,  8 Apr 2024 21:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b="ebF0BOep"
X-Original-To: linux-integrity@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2123.outbound.protection.outlook.com [40.107.105.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1E711725
	for <linux-integrity@vger.kernel.org>; Mon,  8 Apr 2024 21:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712612768; cv=fail; b=ov4d3rqZOrnzhxG1dVzTGa6E0MMlc4xVGj0j7D63Y/7PqYV8E6x6I3C8U//VouVl5vxL0WyXYxfJ3GeRGONHSbkyRiuLBTHqzVB/LWpYF1tIqSUIPiBKPHS8JIySVu5/E7LjPhUYfdEXG4sPPOlcjyg2FKHitOaHFQDL1K9pD3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712612768; c=relaxed/simple;
	bh=0bn/cRjTkVEsHIL7oYZy7/DFYIB1uqJrWPdzF1pqrUw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=HLpAfNSxr8oZYh2TP3UEi0dhsFtuqqR7JD1fr6nTO9/bfraalcWWkGLL1faze1tqPzPkkPHsghGIhBnlZQwV08WJ49Iu9kdqO2wOfhDisOUpr1EcFXtmsgr5S46KB5T10BtTewwBmv/rM/2G6lVG/vrQHUZQa0fkE/Rvwgsr/2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=ebF0BOep; arc=fail smtp.client-ip=40.107.105.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polito.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=polito.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvPVJV0p9WxGn32LQdj2zbPNNp2l4vfdFkytwta+o1OAISK28fVNTGvVoJIgCdgNyzoJimnhh3u01kRdejMuy1Q08WSNEAO4a5j0jHYkadV4yJH3PJFlGtiCQktHfdQg7f4GNO/H0zH5LAzHIBWe0kRwBmwMWNsDUFrIP4dJOk36VwRPS0LDMAoQP7KnH3mQ7NT3Zy5KenHhqV+sNsbx43KAIRIAKgnDgLK8rprW285pwOBSfV5qt5hOvixU4lTowW03HfwUy834fo9zOKMTvy4PPcG/bqTYmqGlXBE/Zp6SBhzI3JJnXwVvAyKQZuCRrw44O8V3pwhEDW4nfqxVPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHOKs1brh2nuiAcOgLpFboWIQdlzvCA/q7Jij1JZcrc=;
 b=g/baxaf7ZcW8lU42xhwZzfKWu0b/gBq5n0Wcb6owPlVzYOG7SwsrNrDwOwe/4KOCMAxyizY4k2HS+HiIe5BES+HTrTE5GzGQ4320E0YNnvxAG9vrW+acGYUX0chfaxevfbZYp+Nr+y3mZykVvLyVuqtX3jWNE1mJY3je3DEWOveUUlJvngFzA2ns5Rl46gMUb/lp20Io+OEffJRC8IT+gnYwH8Ncqs/tiYnVsAy0jF5P1e0yNdB7r1jVfBz0C2IShfEVw0Odvp00RXO+3cbTXapjFDqueozHGHXOp6JZD2C1hHtyI5UJr3nHq5iVFhUzCTqVwQTNm7D5nyA2TXey5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHOKs1brh2nuiAcOgLpFboWIQdlzvCA/q7Jij1JZcrc=;
 b=ebF0BOepaLq3xzHuA/OLGEtsTurH9/yey55WEolPtrgPo9sKt8XjPLnxQDhnHAXz2UmJCVcov6WBudIeFGaLkCi/mgmpqz3da+q/7nEeiDoyR3H91cPh72UBGGhFQY8HjzUdHGj11Aak2iMTQCTG40RFeoVjndAZJFwR5A/vxDE=
Received: from AS2PR05MB9840.eurprd05.prod.outlook.com (2603:10a6:20b:5f5::20)
 by DU0PR05MB9480.eurprd05.prod.outlook.com (2603:10a6:10:32f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 21:45:59 +0000
Received: from AS2PR05MB9840.eurprd05.prod.outlook.com
 ([fe80::87c7:ebd:309f:8e5]) by AS2PR05MB9840.eurprd05.prod.outlook.com
 ([fe80::87c7:ebd:309f:8e5%5]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 21:45:59 +0000
From: Enrico Bravi <enrico.bravi@polito.it>
To: linux-integrity@vger.kernel.org,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com
Cc: roberto.sassu@huawei.com,
	Enrico Bravi <enrico.bravi@polito.it>,
	Silvia Sisinni <silvia.sisinni@polito.it>
Subject: [PATCH v6] ima: add crypto agility support for template-hash algorithm
Date: Mon,  8 Apr 2024 23:28:13 +0200
Message-Id: <20240408212810.1043272-1-enrico.bravi@polito.it>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0058.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::9) To AS2PR05MB9840.eurprd05.prod.outlook.com
 (2603:10a6:20b:5f5::20)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR05MB9840:EE_|DU0PR05MB9480:EE_
X-politoEOL-CGPAlias: 1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pF7yg/QdArTSjF+CPcbLQtXNgteNRPzvUQlOHTzdlw7/MiC45rBHv0aILu4L/m4Pv31zS4oBCPTSCCchEs/pETYyEf796IapmArtrQXuCClRZkNsEpH/Z4wHDgSQXnlFMgKXpMU6oiFtuxh9Vf+slE773dc3Y7NDFceXbN/jn8zel3zCTJK7RPfFPioXYCaoXB6J6RWg/jIxnNq6opRiJEFWxSexnOms3+t2OkxUagbEwPbdulmpEpefzMrXQ98G8zD8B4GEFx05762dQUflmLPK5uMIHFgf+cFaFUsR5YZKjilgOBjKwjP9OGQuksahCvYY6C5rheJh+apRo6T3b3VmoKjU9D6EWaK+6M4oontZs/CgYvkWpfMOmz7SLXMz2O4JlnoHHGl87+30JV2tUNRC6eSAIQrSSy7dOceAf1BmJHNBav73anEkWAM6hDgkjmQFVT5Lh7r0GNnlC5uKt1XldIvQrPIefYgmNLIwZF+nMJ4Lh4fsy1aUIjza1bV5PKDS64nGa8wsY095KuZeVu/mCpQuRSllLWA8EAdFGr+me3i5YTVDmbxAlSSf61gCav+VXTA/LwSjQ6Q0+T5G32tzuH2P3un+szM8qJBVi+Ad12wAxpbpWRY3QD2SaZaCG8Ck9ADDznp4m+nMYcXs4iLPM4gGtpAzNfdUbO7tQ52ImMxd2DSZEXTgauzyRr2cSmWg3FPoVpkVreK8Vov4YA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR05MB9840.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(1800799015)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tuv2n1zbm2XBStwYZxnRhjvZ4BZtQ5j8cDESODoKD2qXbjnM4lvgaH57/s3B?=
 =?us-ascii?Q?t5nsgY4VKBclSYTH0qyA+ImW7CIXa+meVa+t5olnEazefX4LEbe2J9VeFOUm?=
 =?us-ascii?Q?ah6lXXrTODaQxZu3EoOJT5N3tEEfvaBDneAwV/1+HDzh/9218zTP8magMsgq?=
 =?us-ascii?Q?p0NUGJHHRXQzhTZqUDK1X7SW8Q0gjjCYIZqXUt0l2cSCB9k6ryb6IpuVO1zu?=
 =?us-ascii?Q?pV+ccPL29Wvrtan9E02tSMJN0i4+xEin0Fiqe4OfWBQIkQ+0uzB5iclTW+m9?=
 =?us-ascii?Q?QcE9PuvSgivlKCAqY4SacroR8kKvd2OVosbpxBlAMLtYzb+nofGtnGK7afjH?=
 =?us-ascii?Q?zIMQoqtQbrg3bHi94SZ0ZwqzabzJ4gxeYMoicahgdPZc+Pcn/+50Os9UKYxP?=
 =?us-ascii?Q?9X3tCXQbkaAKGa1xIf7tTRid+qzuOuUY+tqcM+58e1Imw5Wg28uxqvhwLmsY?=
 =?us-ascii?Q?/JH6Li21V+6QR6TWoBzjvWLcTxlnQPNCunuRxn4K9XYItvVUS/vmWFoBxgsX?=
 =?us-ascii?Q?JuPAUhGtKgVBijuQ0lFBJfy35bLGj94td2HAqUdBGlfGgse1HkrK3+03MPJ0?=
 =?us-ascii?Q?c08+Q0RvA5zNm6CTRtWL/BiI9ccvMDu7PXMIxE1X5RZoYPyGDoKx4x0yAr9I?=
 =?us-ascii?Q?uZTfh9oKmQiPK+hIkQ8VO27uhoUA7gg1DEWWt0hRYNgfzLy7m5jC5cdpULeF?=
 =?us-ascii?Q?DxfqOxDaB1ij/GC2nGOPc8q+WShm3PwSvNgCGY1+Xu6Wt0FlAyXDLNnpJ/P7?=
 =?us-ascii?Q?WIOoAiqeuEKINOPixaoV/h04nw5hd3PhvFMOZXdB72RVikHYjbxbp+A0iRLE?=
 =?us-ascii?Q?nUkvcpEd/Ahx1enagqzj2t6hP6c7NWWvk8CxCuiK8FohdIPfoU2G2eDaoHkM?=
 =?us-ascii?Q?xYYvi3Ibc+KNRfN1oBAxg8dGg8lHHUm0AkpAWxxarsywiSzyXp2Vn3c0pzOT?=
 =?us-ascii?Q?BVycg5z37jRhn7g6aitE4/hkNxZiUoQ73I11HmjGO6nw1hW7R8PAlFUS00nW?=
 =?us-ascii?Q?jX5jZqYrZc2POlUFx1x2YHSa4uRNa6jIK8mw7Ix6AJZroUbvD6b1/wALVQ5u?=
 =?us-ascii?Q?Y10nV2BJzPBH7hiPNnwNsamCc6HQMs+Udk9BUdsbiqitw5d5hAuYulEC5jqK?=
 =?us-ascii?Q?Zb7hlOfkZ5aN+dDTsjKUCWVSO/mrmu7FiMmai5NuGAqV23faNGYYN86ZFLEv?=
 =?us-ascii?Q?p90Aktwf7VN2Bjo1rcc3DPVkT5DdwfKpjBVB7a4c/eY37qwCRflZKbeCcsic?=
 =?us-ascii?Q?MXBkiL/KmNsFdoWRBxpjxiXPpYLniEiZU+Tux96X4F4xRzcHzfmUsTAb+Pkt?=
 =?us-ascii?Q?yA5vvrLj4I7f5/jcukzdFcS4paWPOMbpsehrVcIHtVIgZ5s2ppLfO10LbZCC?=
 =?us-ascii?Q?4Mi8N5lq1tUfxJ8O/3WL01l/5HLgItB15sbYKtCGxlwkyfPPJhBxs1QcWDDC?=
 =?us-ascii?Q?FlB8WI9Z6UmnAtIKyxLRZFjL0QgWPXahsu5n/taza4zb7VINUuldl7LzqSWw?=
 =?us-ascii?Q?LXsYi+ojiN9IXuRT0t2YmZJ+ZrNscCYGvJt4R5zyENi7QzlsdGFF3ORuwQhU?=
 =?us-ascii?Q?M3Ud5vSgSoBi87xCP3paSimk4qCNtF3YA4ak8OgP?=
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf4eebd-1253-4a59-d1b0-08dc5815471d
X-MS-Exchange-CrossTenant-AuthSource: AS2PR05MB9840.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 21:45:59.1933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EYy2oEBaA75PCTG6tt+xfrKwY2zX6cLx97Tzm/493SXbhJBnG+oLNpRNnI3A61LhgCqrN0Bj2APEQdUa8lSzVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR05MB9480

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

 security/integrity/ima/ima.h        |  10 +++
 security/integrity/ima/ima_crypto.c |   7 +-
 security/integrity/ima/ima_fs.c     | 131 +++++++++++++++++++++++++---
 security/integrity/ima/ima_kexec.c  |   1 +
 4 files changed, 131 insertions(+), 18 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 11d7c0332207..72ac73ebc83e 100644
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
index cd1683dad3bf..7d9c2ef5b86c 100644
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
@@ -132,7 +153,15 @@ int ima_measurements_show(struct seq_file *m, void *v)
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
@@ -151,7 +180,7 @@ int ima_measurements_show(struct seq_file *m, void *v)
 	ima_putc(m, &pcr, sizeof(e->pcr));
 
 	/* 2nd: template digest */
-	ima_putc(m, e->digests[ima_sha1_idx].digest, TPM_DIGEST_SIZE);
+	ima_putc(m, e->digests[algo_idx].digest, hash_digest_size[algo]);
 
 	/* 3rd: template name size */
 	namelen = !ima_canonical_fmt ? strlen(template_name) :
@@ -220,7 +249,15 @@ static int ima_ascii_measurements_show(struct seq_file *m, void *v)
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
@@ -233,8 +270,8 @@ static int ima_ascii_measurements_show(struct seq_file *m, void *v)
 	/* 1st: PCR used (config option) */
 	seq_printf(m, "%2d ", e->pcr);
 
-	/* 2nd: SHA1 template hash */
-	ima_print_digest(m, e->digests[ima_sha1_idx].digest, TPM_DIGEST_SIZE);
+	/* 2nd: template hash */
+	ima_print_digest(m, e->digests[algo_idx].digest, hash_digest_size[algo]);
 
 	/* 3th:  template name */
 	seq_printf(m, " %s", template_name);
@@ -379,6 +416,69 @@ static const struct seq_operations ima_policy_seqops = {
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
@@ -454,6 +554,9 @@ int __init ima_fs_init(void)
 {
 	int ret;
 
+	ascii_securityfs_measurement_lists = NULL;
+	binary_securityfs_measurement_lists = NULL;
+
 	ima_dir = securityfs_create_dir("ima", integrity_dir);
 	if (IS_ERR(ima_dir))
 		return PTR_ERR(ima_dir);
@@ -465,19 +568,21 @@ int __init ima_fs_init(void)
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
@@ -515,6 +620,8 @@ int __init ima_fs_init(void)
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

base-commit: 38aa3f5ac6d2de6b471ecb6e1cd878957ae7e8de
-- 
2.34.1


