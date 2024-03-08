Return-Path: <linux-integrity+bounces-1674-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0967487626F
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Mar 2024 11:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CDA21C21DF6
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Mar 2024 10:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41A554BD5;
	Fri,  8 Mar 2024 10:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=politoit.onmicrosoft.com header.i=@politoit.onmicrosoft.com header.b="iP2yU6zJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2112.outbound.protection.outlook.com [40.107.20.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F4755C01
	for <linux-integrity@vger.kernel.org>; Fri,  8 Mar 2024 10:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709895039; cv=fail; b=GRP7qj4w2Fr40OcHnLhHUxsvqYvKnL3BgcYVysMjEPVYuV3pSU4BEP3v2LackRzdzs+38v4tendcniezKK4ex6C3cIcmpyunA9UMJU1fcoG/HtE8ZoI6a/5SL5Wlqepfyjzm7hJfg9+RuRpjtvxu/x+HqSRr8ZN/1bjjLggH1FY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709895039; c=relaxed/simple;
	bh=LoybNNPzHxGz9b40v/7JyGzj41tTSM7EX0o7tdJi3fE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=TnuN5sOyIuLohdS30M07OhU7kMBYAEGBqgmQ5wKW/+BSQot6K66CpSNeK3skWkbjPzaY8grnkMiNd0amAan+ZAWtFGWCh/oSWMWCi1wlRBKoAL4/LDgbyP6K86p6uQvvBFgHOeaMOTa6v5e2wsJ9Q53KXuPymEMr8D3AkuwOQjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=politoit.onmicrosoft.com header.i=@politoit.onmicrosoft.com header.b=iP2yU6zJ; arc=fail smtp.client-ip=40.107.20.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polito.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=polito.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfqFL1HoTbbsTugeZoXM9kt//5TzxQp8k0lWD1z6Xi4k2WwgMxa2HgCWDAOaNm5+AucA2n2hi1a+7GoDZktLBjE4yPgz+B6ZRxaY69/SS23ZbpUlz6lpyKDHIrpNH0Bwn2kngNPDhJBSekWQQHFcch8HigW+kd5DZFXQUnJ92/PjAMT3vj7kipOAT5w04dpIufhAGkmKJV+Nfe1Bdwd6WWE8oK7TIHLjymy7eDF/S0F40vhAZWp70XduKU9xgw80z9vNMyev5xSVYwkRDOZNbX/NSnqff6b4O9uhPuMRMZKXYRekzvmpWKE7u/1go54cvPbaWe5nLKgZ7mLmm1ZN4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8WSjSXJ7db/4vJy//iiMkGuzXNDQf2Fk7YVMNDopOw=;
 b=LGZRmc8NTgLS7B99d4Opeg3Sl4cGGM2l0ameNScgoIrlGRiXoZTvAefUiNV3E/uo8igxEUa/peS/LCaX8mv1djP31B6/y2jiUZwNQNc+Y/dX9zlt0hKhhIvL8WAgDNH0KfUHA93i45ItjxXCFz4Uz44VkJvZcfMq08CZQJljB2ul/kvpLV7fe5NRpooaCBu494sUIYeFxauKBkl1v6+j8rmgChbBrVTLYQr5tT91q5pSxrpgvSfw/vHC/OHJGPALd7ObhQ/lkAQmlJQScui+31ydtq9exuxfOZEBX3u/lN+X9/26IMB9zClHL6WpDP0Ezs9CqucPgfpGfSfUKAuGig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=politoit.onmicrosoft.com; s=selector2-politoit-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8WSjSXJ7db/4vJy//iiMkGuzXNDQf2Fk7YVMNDopOw=;
 b=iP2yU6zJ1fMU9a7/wtmKMqm8RcQTXUuHUk/rClhEoqDSAUherSumnr65bTjPQ+yisdnpVH+V1M9MaTnSlrGg4s01xWCiueDyyrO2L1RXhTgb2gKCb5EeuYKBcTYWcwzaDem3CVcZuGUMg5mk7cGtol4q9ZM2k0/KLFbarzApIoY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=polito.it;
Received: from AS2PR05MB9840.eurprd05.prod.outlook.com (2603:10a6:20b:5f5::20)
 by DU2PR05MB8806.eurprd05.prod.outlook.com (2603:10a6:10:2d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Fri, 8 Mar
 2024 10:50:32 +0000
Received: from AS2PR05MB9840.eurprd05.prod.outlook.com
 ([fe80::9351:e76:ff6d:29ba]) by AS2PR05MB9840.eurprd05.prod.outlook.com
 ([fe80::9351:e76:ff6d:29ba%7]) with mapi id 15.20.7339.035; Fri, 8 Mar 2024
 10:50:32 +0000
From: Enrico Bravi <enrico.bravi@polito.it>
To: linux-integrity@vger.kernel.org,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com
Cc: roberto.sassu@huawei.com,
	Enrico Bravi <enrico.bravi@polito.it>,
	Silvia Sisinni <silvia.sisinni@polito.it>
Subject: [PATCH v4] ima: add crypto agility support for template-hash algorithm
Date: Fri,  8 Mar 2024 11:49:54 +0100
Message-Id: <20240308104953.743847-1-enrico.bravi@polito.it>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0042.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::11) To AS2PR05MB9840.eurprd05.prod.outlook.com
 (2603:10a6:20b:5f5::20)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR05MB9840:EE_|DU2PR05MB8806:EE_
X-MS-Office365-Filtering-Correlation-Id: c832ce2e-6025-48e0-b796-08dc3f5d93d5
X-politoEOL-CGPAlias: 1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FabIZ8s88FpPXEJd0Hi2kXfKKZD1nCSif2Naqy9T97Bk8GATUphF7Phven4SqQdR48e47BjlOtqL8CIwtOG4ll7l4ne6vxlCggaydh4XImWW9mhpkRsT/8MCs+7y8u0k/L1jNgVTeg9zCmF32SrbgmYkQmlNm8sYDgGXw+29s5q8b057tAbp8YAs23C0IRcSFCreabMxkmUi88AdQvQe152Kc1fss/8CWvRDyhOV7Z/Y4DvXZne3wGobPqCDUK7Z731QIDYffzf0yN5iai1U5mwWb/cOokrTmZUFa1hK0BYIegC43+8uvKZMCl23DRKNBWgKyryTbGOsXygXFrSpG3r3q2ei62KVjpIvZedY5M2lBEwC8wSiRhtvZpg32mIsaHx9scf+x/z+r4IF2OVccLEtCO239SHZmfxSeBKdlt9Fnu4qXu1yzJiU3ehQgEMus+NDtTbhAijuim35MlH47Uhu3ok7Ak07yOk0TFcvZbr1mHJzq3vVv94wPJRWbZwM3936X9YgOQamTEJI3NwzL+cEeRvUIO9w6uoRXvmnCrT2XG+hOXRFRZYvamyVa0BPY9QCAha193xpzqM9ZYLmVD2hvLc6HJf3wfBPiM11E1bcAwPmhVWqB0x7O39UlFS7QVXg5I2xT/VxCg3uC92JXrKP0DGJnj2xjbo3JaH+8oXYeeaAA48FuTQobF907H+sxBA23wJiwAe4dBrie8Sfo8P693W5r95X/LpWjMDsjWU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR05MB9840.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lg/MqcugRW/Wg9zj4n3ht9tjvkn4KQmyrSKmx/py8wf3WzJLNfEi/AJ3hc1n?=
 =?us-ascii?Q?nYpTx4Uj08TpwtcOPBtC9hqNBP+6/MfxsIaDT+AJOoqXmXY3Z4m3eU6l0xQ3?=
 =?us-ascii?Q?aQ7W/C63HQJ5Fyfrre4mZwk8AMzZ56YXdPjf7cP6U1+iN8Qm649pTzdov913?=
 =?us-ascii?Q?L5Hb1fO0bVgoJt7xsGSDab4MvRZ6wrxfbMke+HyOoUESgQf2nBH4pDBChmxu?=
 =?us-ascii?Q?95CrR7jSaDGEjUWTw9mlOdELgDpgpK/hCv+A21Bt8ZEbE2zBHKoXlSVAnwEQ?=
 =?us-ascii?Q?PKU4iFyOTrKZ26yziiPRiwKWaDb2qtZAlGmbsuBQTHXWCSdwBgIJu/1ScghB?=
 =?us-ascii?Q?y1LpfYrl128aUHtuoDdV+PjJffcli0K2M9wTWt4mEvSEH5MmkIVPP9PLPW3S?=
 =?us-ascii?Q?iYYN5DOR1CZlgjuxkmsSbes/YW0UhgcTyQnXtCGjN1x3WLkcud6wxd++ssXs?=
 =?us-ascii?Q?aNcLdUuZBvdcKlcaj8saN7mALyPhxirXHo/d6AlGIwJYJ67Fi49XEPpiBDuW?=
 =?us-ascii?Q?q1SSJyfblj483E1Wbxn0AIZOKrmEPA13HQoncjD8gtdweGKml7God4SphCqv?=
 =?us-ascii?Q?MefT2JzW7zQiDvEtzmP7SZQkqdPDxVVgpS9DF0DGc37rWQsS20CTpHFAzog+?=
 =?us-ascii?Q?SJUuyHpnWx2Crkp3AAMdPZErsYYu9yZbQakXYEij/Y+bUss1+ovCJNaNM/DG?=
 =?us-ascii?Q?T/UpDR19cC0AYbLA3GEmZypnzhdX7nxPIn0Ea9sJ/S/h68X3tqQVssHY1Kb/?=
 =?us-ascii?Q?IIoXgJzQcNQX2w2m7iNjh3TGiD+oupPZWecmtKG15P42xX274y3ZMANsDNg/?=
 =?us-ascii?Q?7i2QRZB8PpUj18fbQOm0Kzxa1CrM6PUvpGgtproi8TXX/X9oxrzINpERRosY?=
 =?us-ascii?Q?7eRu4cW0j/fV9o1GhhE/AnpQxntXXYzHAgzQnRx9xFewJ+J6p168dO86tvaw?=
 =?us-ascii?Q?ARlZqf1u3IGa5LdyBAUYlp+cGJ5FvtYdt+42/TvMrtBelUcK8s97J8Oq9qTg?=
 =?us-ascii?Q?PkVwwAew32wOREgZmims/pZr6J8aO/gyANN8rbmCnyrZBXXveBKt+lQFlS1H?=
 =?us-ascii?Q?1q7K0+cAnKzWQ/v05EqpFOWq53yc3JA9gQ1NjaPI8DAVqt1RD7yIzCebjWe8?=
 =?us-ascii?Q?TwLhKxbNPTQl97bw/HWCnmZhMZbjKZ/AgLiREVhdw6JwOGyMG52OoDjyy0sJ?=
 =?us-ascii?Q?4xsdeFnLJO90KNX2TyEnD/lWHaNmlQcFtLHNmtoK8pyTWMrM9IHCud42ZhYb?=
 =?us-ascii?Q?LghVIRvl27zeOJAAnabz6Ma7nY67MBHdFv19/j7m8NlUAVTRlCiRKJAe8YIF?=
 =?us-ascii?Q?cJQtPE2OPpuPCH68cVb5mYSB/KntRukLHphaK2gyi5xCm0z0b0LVam44+pIM?=
 =?us-ascii?Q?B0XS8rNZmkpNEbytedmg136Edy/hR0gMLfBrHPVPX7PI/dq7eFNKSDey/JIx?=
 =?us-ascii?Q?jpH46iouXd0bTNbXG6O184D6Eo7bINecn9QCcddJotVfladQXEYbPlLc0NpJ?=
 =?us-ascii?Q?QuHH9eelxrBgJyqxlvC2pZfIfeGcJIfD1Pnes3Q7ufFqrXW00iVATVgsHwxw?=
 =?us-ascii?Q?jXtF1Tr0Obt7bY/vfKYTKJhgVEUTU4PotqbTZ/xDufC5ty780wyjr9eHEoTe?=
 =?us-ascii?Q?6g=3D=3D?=
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-Network-Message-Id: c832ce2e-6025-48e0-b796-08dc3f5d93d5
X-MS-Exchange-CrossTenant-AuthSource: AS2PR05MB9840.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 10:50:32.5942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u2c1TUmQMh4KNXeTtpnJsUHrKDSRF6s3rr37NHyc+AUr+TTdfXSpD5xDpbrejPDXuzrPP00Y8nynBhCznFfd2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR05MB8806

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
the sha1 bank is not configure in the TPM.

As example, in the case a TPM chip is present and sha256 is the only
configured PCR bank, the listing of the security/ima directory is the
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


 security/integrity/ima/ima.h        |   9 ++
 security/integrity/ima/ima_crypto.c |   7 +-
 security/integrity/ima/ima_fs.c     | 135 +++++++++++++++++++++++++---
 3 files changed, 131 insertions(+), 20 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index c29db699c996..81318e294175 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -54,6 +54,15 @@ extern int ima_hash_algo __ro_after_init;
 extern int ima_sha1_idx __ro_after_init;
 extern int ima_hash_algo_idx __ro_after_init;
 extern int ima_extra_slots __ro_after_init;
+
+/* export hash algorithms configured in ima */
+struct ima_algo_desc {
+	struct crypto_shash *tfm;
+	enum hash_algo algo;
+};
+
+extern struct ima_algo_desc *ima_algo_array;
+
 extern int ima_appraise;
 extern struct tpm_chip *ima_tpm_chip;
 extern const char boot_aggregate_name[];
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 51ad29940f05..d42ea0d350a1 100644
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
index cd1683dad3bf..475ab368e32f 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -116,9 +116,13 @@ void ima_putc(struct seq_file *m, void *data, int datalen)
 		seq_putc(m, *(char *)data++);
 }
 
+static struct dentry **ima_ascii_measurements_files;
+static struct dentry **ima_binary_measurements_files;
+static int ima_measurements_files_count;
+
 /* print format:
  *       32bit-le=pcr#
- *       char[20]=template digest
+ *       char[n]=template digest
  *       32bit-le=template name size
  *       char[n]=template name
  *       [eventdata length]
@@ -130,9 +134,26 @@ int ima_measurements_show(struct seq_file *m, void *v)
 	struct ima_queue_entry *qe = v;
 	struct ima_template_entry *e;
 	char *template_name;
+	struct dentry *dentry;
 	u32 pcr, namelen, template_data_len; /* temporary fields */
 	bool is_ima_template = false;
-	int i;
+	int i, algo_idx;
+	enum hash_algo algo;
+
+	algo_idx = ima_sha1_idx;
+	algo = HASH_ALGO_SHA1;
+
+	if (m->file != NULL) {
+		dentry = file_dentry(m->file);
+
+		for (i = 0; i < ima_measurements_files_count; i++) {
+			if (dentry == ima_binary_measurements_files[i]) {
+				algo_idx = i;
+				algo = ima_algo_array[i].algo;
+				break;
+			}
+		}
+	}
 
 	/* get entry */
 	e = qe->entry;
@@ -151,7 +172,7 @@ int ima_measurements_show(struct seq_file *m, void *v)
 	ima_putc(m, &pcr, sizeof(e->pcr));
 
 	/* 2nd: template digest */
-	ima_putc(m, e->digests[ima_sha1_idx].digest, TPM_DIGEST_SIZE);
+	ima_putc(m, e->digests[algo_idx].digest, hash_digest_size[algo]);
 
 	/* 3rd: template name size */
 	namelen = !ima_canonical_fmt ? strlen(template_name) :
@@ -220,7 +241,24 @@ static int ima_ascii_measurements_show(struct seq_file *m, void *v)
 	struct ima_queue_entry *qe = v;
 	struct ima_template_entry *e;
 	char *template_name;
-	int i;
+	struct dentry *dentry;
+	int i, algo_idx;
+	enum hash_algo algo;
+
+	algo_idx = ima_sha1_idx;
+	algo = HASH_ALGO_SHA1;
+
+	if (m->file != NULL) {
+		dentry = file_dentry(m->file);
+
+		for (i = 0; i < ima_measurements_files_count; i++) {
+			if (dentry == ima_ascii_measurements_files[i]) {
+				algo_idx = i;
+				algo = ima_algo_array[i].algo;
+				break;
+			}
+		}
+	}
 
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
 
+static void remove_measurements_list_files(struct dentry **files)
+{
+	int i;
+
+	if (files) {
+		for (i = 0; i < ima_measurements_files_count; i++)
+			securityfs_remove(files[i]);
+
+		kfree(files);
+	}
+}
+
+static int create_measurements_list_files(void)
+{
+	int i;
+	u16 algo;
+	char file_name[NAME_MAX+1];
+	struct dentry *dfile;
+	enum hash_algo sha1_algo_idx = -1;
+
+	ima_measurements_files_count = NR_BANKS(ima_tpm_chip);
+
+	if (ima_sha1_idx >= NR_BANKS(ima_tpm_chip))
+		ima_measurements_files_count++;
+
+	ima_ascii_measurements_files = kcalloc(ima_measurements_files_count,
+						sizeof(struct dentry *), GFP_KERNEL);
+	if (!ima_ascii_measurements_files)
+		return -ENOMEM;
+
+	ima_binary_measurements_files = kcalloc(ima_measurements_files_count,
+						sizeof(struct dentry *), GFP_KERNEL);
+	if (!ima_binary_measurements_files)
+		return -ENOMEM;
+
+	for (i = 0; i < ima_measurements_files_count; i++) {
+		algo = ima_algo_array[i].algo;
+
+		if (algo == HASH_ALGO_SHA1)
+			sha1_algo_idx = i;
+
+		sprintf(file_name, "ascii_runtime_measurements_%s",
+					hash_algo_name[algo]);
+		dfile = securityfs_create_file(file_name,
+					S_IRUSR | S_IRGRP, ima_dir, NULL,
+					&ima_ascii_measurements_ops);
+		if (IS_ERR(dfile))
+			return PTR_ERR(dfile);
+
+		ima_ascii_measurements_files[i] = dfile;
+
+		sprintf(file_name, "binary_runtime_measurements_%s",
+					hash_algo_name[algo]);
+		dfile = securityfs_create_file(file_name,
+					S_IRUSR | S_IRGRP, ima_dir, NULL,
+					&ima_measurements_ops);
+		if (IS_ERR(dfile))
+			return PTR_ERR(dfile);
+
+		ima_binary_measurements_files[i] = dfile;
+	}
+
+	return 0;
+}
+
 /*
  * ima_open_policy: sequentialize access to the policy file
  */
@@ -465,19 +568,21 @@ int __init ima_fs_init(void)
 		goto out;
 	}
 
-	binary_runtime_measurements =
-	    securityfs_create_file("binary_runtime_measurements",
-				   S_IRUSR | S_IRGRP, ima_dir, NULL,
-				   &ima_measurements_ops);
+	ret = create_measurements_list_files();
+	if (ret != 0)
+		goto out;
+
+	binary_runtime_measurements = securityfs_create_symlink(
+		"binary_runtime_measurements", ima_dir,
+		"binary_runtime_measurements_sha1", NULL);
 	if (IS_ERR(binary_runtime_measurements)) {
 		ret = PTR_ERR(binary_runtime_measurements);
 		goto out;
 	}
 
-	ascii_runtime_measurements =
-	    securityfs_create_file("ascii_runtime_measurements",
-				   S_IRUSR | S_IRGRP, ima_dir, NULL,
-				   &ima_ascii_measurements_ops);
+	ascii_runtime_measurements = securityfs_create_symlink(
+		"ascii_runtime_measurements", ima_dir,
+		"ascii_runtime_measurements_sha1", NULL);
 	if (IS_ERR(ascii_runtime_measurements)) {
 		ret = PTR_ERR(ascii_runtime_measurements);
 		goto out;
@@ -515,6 +620,8 @@ int __init ima_fs_init(void)
 	securityfs_remove(runtime_measurements_count);
 	securityfs_remove(ascii_runtime_measurements);
 	securityfs_remove(binary_runtime_measurements);
+	remove_measurements_list_files(ima_ascii_measurements_files);
+	remove_measurements_list_files(ima_binary_measurements_files);
 	securityfs_remove(ima_symlink);
 	securityfs_remove(ima_dir);

base-commit: 88035e5694a86a7167d490bb95e9df97a9bb162b 
-- 
2.34.1


