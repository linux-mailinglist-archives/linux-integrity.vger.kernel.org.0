Return-Path: <linux-integrity+bounces-877-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F63183B25D
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jan 2024 20:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C61FA1F2417E
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jan 2024 19:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DD3131E39;
	Wed, 24 Jan 2024 19:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=politoit.onmicrosoft.com header.i=@politoit.onmicrosoft.com header.b="NSZp7jAc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2123.outbound.protection.outlook.com [40.107.105.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1B67CF3F
	for <linux-integrity@vger.kernel.org>; Wed, 24 Jan 2024 19:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706125090; cv=fail; b=qS5OcpqYUQbs0Hp23Sv8tdIGK0BFC8G36lEKzCyVV9Xthof6ze9meM/RyNtc5HY0W6HqHPtYeCygnrQlYzaOyUJeXGqIu6xMI+1C92DPaGOTx0HrEfUsifoh3LH+kje3KqwK8rbljX5zVEppwS4weM/d2swTAIkxiGhlFzYfCL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706125090; c=relaxed/simple;
	bh=FZ2FYDPus/v2eLUbsYMSHma8I/rXpVvI4IvDl1HpybU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=AMSXxvG8DSFj2YSgZJqrwzNu2W460bFSlxZbN+D7YyAbAvDNtMlrGjwfV0Cuo57RcKXFrLyA+AA81elt2Tjb94gndF0iZXUDQNAT8U8wGgimhJ+UPboJm6OVw/GQoOTJruoEWTddgSFydLpCPSpMvvmBnTjVhx/xiG2G6oZcBkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=politoit.onmicrosoft.com header.i=@politoit.onmicrosoft.com header.b=NSZp7jAc; arc=fail smtp.client-ip=40.107.105.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polito.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=polito.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RA36UAHgh/7OpFJZJVbIZHwkXE0RGb/THLYc2qcXpQOAcqMsdxdtf3g1o/ngblE0nThFx2rNaP1fs+QAFynmpZAXHCYGmFk7f0oLdbbqeXaZjskammysjK4e6v2ISAEMT0LvxKdqCh8debNXjyDmQg1FdDIS8dgf0g43AZuAxYEGaNBuqMw9x/t8fZPc1LbS79ys0KkYCsqs3Vlrk+DFMJPAr/l/AMyziMA1QaIRrQb2C+mADUWIQPjx+ylpscJP5DapapzeuiWpGa/NgAm6uSupLpCbDs68cGFyPKrj6gQk4aG9r6dYeAXXnqQhlTAxQZN2YobbsgxqUOG1Pm0H3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ou2pxGLNXWd+zzeUoxtfH4u9LzkhaaW/GXv1d468Ds=;
 b=fqLx6SEPFflVxxAIBmAaPZberU6duznKhZQwUsmeL47ccTRQ1t6ilxOX0wGoI7UePcGSdUD+FVJ7lvhD/cgzzTLup2N3FHQtsjIDkgrxY8IGfSstw4giCEl65GDx/Q2/eajNcnSHtN0Oru0awRsg6BFbDx7aalvc1iCEV6LW3oyo6wQY7AOH9tojdMFmHCC6vDrE/PLyNFyFCBM9+oQw1af6PxFIDupSsTphYotJkJuVTmYUH2OxH7AZqE60HvbDsVXb4oUp3BhjBdTTfTCS/isML3OPCenra+AlX8kZYIH9Lf4mIqiRnL4ES9jboe3Phs79KiCVRpjeI2/K64oZEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=politoit.onmicrosoft.com; s=selector2-politoit-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ou2pxGLNXWd+zzeUoxtfH4u9LzkhaaW/GXv1d468Ds=;
 b=NSZp7jAcZLf3VMZ95AWJ5WAgqQKy/J50tQoFwP6qMqJyCCFyYol08NGA//12G76n5DR687q3khbILF0Vs+cjuSE1MBw7R14u1gW5JVavYaJmeuUCmmYZn4W4L15E35hMq7bp1RIy8pVVup0Abi5iFvvy1nwHJVAf5ugElUwoKsc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=polito.it;
Received: from PAVPR05MB9853.eurprd05.prod.outlook.com (2603:10a6:102:32e::18)
 by VI0PR05MB11157.eurprd05.prod.outlook.com (2603:10a6:800:20b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 19:37:58 +0000
Received: from PAVPR05MB9853.eurprd05.prod.outlook.com
 ([fe80::9a4:8b99:c4a2:4620]) by PAVPR05MB9853.eurprd05.prod.outlook.com
 ([fe80::9a4:8b99:c4a2:4620%4]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 19:37:58 +0000
From: Enrico Bravi <enrico.bravi@polito.it>
To: linux-integrity@vger.kernel.org,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com
Cc: Enrico Bravi <enrico.bravi@polito.it>,
	Silvia Sisinni <silvia.sisinni@polito.it>
Subject: [PATCH v3] ima: add crypto agility support for template-hash algorithm
Date: Wed, 24 Jan 2024 20:32:24 +0100
Message-Id: <20240124193223.46383-1-enrico.bravi@polito.it>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR2P264CA0055.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:31::19) To PAVPR05MB9853.eurprd05.prod.outlook.com
 (2603:10a6:102:32e::18)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAVPR05MB9853:EE_|VI0PR05MB11157:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b30a1bb-0b70-412d-e0c0-08dc1d13f7bb
X-politoEOL-CGPAlias: 1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RZJ8Qtm2Tsyt/i11A6jTv0wXmtMNxWWKqEdj5KrzXGS1mINcwpM+n6lMTXMNBBnaJ3yDkGG+sMI46OJeoHk8UJEwa71awJQ7rttXlEtDhlwfnaxricm60qXq3cuqJAkUG7PP+QlX5wuc5z7+9DSEGAPZnnvfE+OaxQF4D098/kt3GRjxEZQfnd+9/k2KAqsy2xAZkTEDS0Thrmf1wu/WCWeSmJHayqTvjE2oUO3/7APz/3GUq0glGERAriptQpQVNxdF0vZZtrPVomQwy5lyZytexAQEb4MGg6Q1TihYdbXIqhb2E36DwmO+Rdvw1tA8MyHfiQDkp8WZoXL6R2Src9j7ZXp9JBeHc0pvs474qfryNHlkPPrfgvqowa28chX/PsIezkiAsruam0pe0jgE+lVE7VKgd0QL6mQGaFNnOEK8kFn/192sLRah810AKleeypDN5b5pg2uzJAZQ4QGWd+z7mGBeIyHlfQrc19atS5YyWqXJdsMYIFiQGaS98Gdd/s+j1NLDnX2MVUjjGDgV/mXVLEf+iUxI/O3wFlwVFG6hj1IUu2LfpO1P9bY8S3zyiUSGEnO/aVpsXnSwPNz3/4YyzNYEySYEPoilgXBYYxyFTf7Lqlewe+zK9xKMKz9A
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR05MB9853.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(136003)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(316002)(54906003)(6666004)(786003)(66476007)(66556008)(66946007)(38100700002)(6506007)(36756003)(52116002)(2906002)(83380400001)(6512007)(8676002)(8936002)(4326008)(41300700001)(6486002)(38350700005)(86362001)(478600001)(5660300002)(26005)(107886003)(44832011)(2616005)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u10nk9YVm6KPdPMgh50du+P+32gEvtoyWnb+B6/ttNnxvUZ6sad/2yk8k2oR?=
 =?us-ascii?Q?+hNj1Fd+URQx3moIYJWS1UGd05QGNUOBRTq5v+NyqKR7++uuoX/0kjiihT9W?=
 =?us-ascii?Q?T1ytpe/8rGRjwvJvLrPiR1SPSQQokFS4XcbEfJJ6HPks8wLUU7cSgU72T/XR?=
 =?us-ascii?Q?nDulZHY6Qe0Jwh74LFDNg5Ig7hn1c4YBh1OkVFNeRuH0UvPCUjsxFgLifXH1?=
 =?us-ascii?Q?91nr41ufsgI1xbjBcFsjzV3idn9xJD8Fx+EMcttgVBU7VtSMdOIk0NsExFHn?=
 =?us-ascii?Q?45F5qSwKkLtsSlcjrmBcemMUu9rdxr4Cwj1NJTsC49V2dnyBHOI7oSZ2ihPd?=
 =?us-ascii?Q?4uaxkFu3jJ9NkXk0jdwDPvLqj16fiE5OrFzTwMtCU8MnkUp9gnYo3wBantUy?=
 =?us-ascii?Q?aAJoYTBiRJejzFFhv1aTdk6Y2XGH8ihEmA2BdA+15Lipa2d36noa9b9oHmO6?=
 =?us-ascii?Q?RGSorGjOSnkQnB/ShV/EBQ7BrRLlwOkWZsA1C/YNx19lUCdNCer/SWmE5VM0?=
 =?us-ascii?Q?bO2bwEW4VR8ED6jcCCQrVbUJxoylUzoAtZ7gLvivfgoVYSG+7csfoDtg29T7?=
 =?us-ascii?Q?DzaBKFCWD+YfWNWNy/SBBuDVzDMRVJHQKbUFXDpUQVjAwOZlK7DkV0ZASd9D?=
 =?us-ascii?Q?+RsI38uwlcWduNMqbAiHDP6u/fBh7TRJsiepxud9kj6z90TyFqrSrQHsiOtz?=
 =?us-ascii?Q?1CbqalMnUBxYe58eREjlyrMckY9WXjoItyWxIegt3s7+tc2wf4EW1Utdf4ho?=
 =?us-ascii?Q?S1IKCR4PJtE0bqepYhIiQqY3ssKlRj7fKxVf5oJh/ilCpPW8W4NEFN/fJ4GP?=
 =?us-ascii?Q?jqCmyvU+AUSLIbd7WsheQZnIV8Z8ZboLY0+5Y0jq0ovdqG1jD0wYjcdSEHKb?=
 =?us-ascii?Q?iX1EiAxESA6pHti52tJyXb1WwYwAmS1KT1Z5g7o3dq91Xo9L+Qh2/u/y90vC?=
 =?us-ascii?Q?Rx03mpTIHoJ6GgRsgVnq2KkYwHucBPyA5QTVKdRu+8lAoI9YPWLFskIerG59?=
 =?us-ascii?Q?aCDyRArQ6otMXRv4Jz2icZpd+cR1DJmmyp3kS7a0yVPxBpM54omb2mL/3Viy?=
 =?us-ascii?Q?Al8DDD7Qv08DpfR0Hk9rUg9S6lYN4nOwO+S2dJd0jg3ePdVMlBh9MbF7R8ZT?=
 =?us-ascii?Q?U/1IPR0/+etmi9oFLOpYlQ5yFZ1oH6vleRgWNsvsYIdE9AxtjYoLYIHC5t6N?=
 =?us-ascii?Q?43SA0D2Ye015k5SlO5UmnIson/Ktn9wFldPnqWsrruOZmw8O4eAeDImMGRWS?=
 =?us-ascii?Q?u5VHIck5VHRtQhdrOvfC4ackEBNthC28wohEZoHiwtfUqglz2bLfMmPaj8B/?=
 =?us-ascii?Q?4ACPpVPCFQW49noqMtrUKe6r+sBFabkg9j/N9Zsa/lX257Wi8SfpFjBpdDJ5?=
 =?us-ascii?Q?RkrFwdjXm7ywbSXFP9diSQFefCTNA4FzOrh2qU86YcNyOj868Eqf8yKsU3Tx?=
 =?us-ascii?Q?BcjveCH6KlxHqvC15YlaxRLeX4dF9DSnmxaHp31bn2kVJYb7FW3jC9pUA4eI?=
 =?us-ascii?Q?c38/YDnB7BgDS/O7BLuAn8gzUdv1EYvAckBnaMg/+3Q/LIIyXJJ+yZTmFff0?=
 =?us-ascii?Q?WAj6yEZWWy//JUFNCTV2qlx0+B/0RZjKkMZIO1lx?=
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b30a1bb-0b70-412d-e0c0-08dc1d13f7bb
X-MS-Exchange-CrossTenant-AuthSource: PAVPR05MB9853.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 19:37:58.2909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ew2mh9MptlZ/xNHWQXPyjWwGarZukl82Q4m/PF9dAxm1lXoq4yRp5NU73zCsvQJ1WzM56F0nPFRwNpWfR1C/5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR05MB11157

The template hash showed by the ascii_runtime_measurements and
binary_runtime_measurements is the one calculated using sha1 and there is no
possibility to change this value, despite the fact that the template hash is
calculated using the hash algorithms corresponding to all the PCR banks
configured in the TPM.

Add the support to retrieve the ima log with the template data hash calculated
with a specific hash algorithm.
Add a new file in the securityfs ima directory for each hash algo configured
for the PCR banks of the TPM. Each new file has the name with the following
structure:

        {binary, ascii}_runtime_measurements_<hash_algo_name>

The <hash_algo_name> is used to select the template data hash algorithm to show
in ima_ascii_measurements_show() and in ima_measurements_show().
Legacy files are kept but as sysmbolic links which point to
{binary, ascii}_runtime_measurements_sha1 files. These two files are created
even if a TPM chip is not detected.

As example, in the case a TPM chip is present and sha1 and sha256 are the
configured PCR banks, the listing of the security/ima directory is the following:

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

v3:
 - Added create_measurements_list_files function for measurements files creation.
 - Parametrized the remove_measurements_list_files function and add NULL
   check before freeing files' list.
 - Removed algorithm selection based on file name during ima_measurements_show
   and ima_ascii_mesurements_show, and selecting it comparing dentry address.
 - Allocate also sha1 file following the schema
   {binary, ascii}_runtime_measurements_<hash_algo_name> and keep legacy
   files as symbolic links to those files.
 - Allocate measurements files lists even if a TPM chip is not detected,
   adding only sha1 files.

v2:
 - Changed the behaviour of configuring at boot time the template data hash
   algorithm.
 - Removed template data hash algo name prefix.
 - Removed ima_template_hash command line option.
 - Introducing a new file in the securityfs ima subdir for each PCR banks
   algorithm configured in the TPM.
   (suggested by Roberto)

 security/integrity/ima/ima_fs.c | 145 +++++++++++++++++++++++++++++---
 1 file changed, 131 insertions(+), 14 deletions(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index cd1683dad3bf..fb65ba9426a1 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -116,9 +116,12 @@ void ima_putc(struct seq_file *m, void *data, int datalen)
 		seq_putc(m, *(char *)data++);
 }
 
+static struct dentry **ima_ascii_measurements_files;
+static struct dentry **ima_binary_measurements_files;
+
 /* print format:
  *       32bit-le=pcr#
- *       char[20]=template digest
+ *       char[n]=template digest
  *       32bit-le=template name size
  *       char[n]=template name
  *       [eventdata length]
@@ -130,9 +133,25 @@ int ima_measurements_show(struct seq_file *m, void *v)
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
+	dentry = m->file->f_path.dentry;
+	algo_idx = ima_sha1_idx;
+	algo = HASH_ALGO_SHA1;
+
+	if (ima_tpm_chip) {
+		for (i = 0; i < NR_BANKS(ima_tpm_chip); i++) {
+			if (dentry == ima_binary_measurements_files[i]) {
+				algo_idx = i;
+				algo = ima_tpm_chip->allocated_banks[i].crypto_id;
+				break;
+			}
+		}
+	}
 
 	/* get entry */
 	e = qe->entry;
@@ -151,7 +170,7 @@ int ima_measurements_show(struct seq_file *m, void *v)
 	ima_putc(m, &pcr, sizeof(e->pcr));
 
 	/* 2nd: template digest */
-	ima_putc(m, e->digests[ima_sha1_idx].digest, TPM_DIGEST_SIZE);
+	ima_putc(m, e->digests[algo_idx].digest, hash_digest_size[algo]);
 
 	/* 3rd: template name size */
 	namelen = !ima_canonical_fmt ? strlen(template_name) :
@@ -220,7 +239,23 @@ static int ima_ascii_measurements_show(struct seq_file *m, void *v)
 	struct ima_queue_entry *qe = v;
 	struct ima_template_entry *e;
 	char *template_name;
-	int i;
+	struct dentry *dentry;
+	int i, algo_idx;
+	enum hash_algo algo;
+
+	dentry = m->file->f_path.dentry;
+	algo_idx = ima_sha1_idx;
+	algo = HASH_ALGO_SHA1;
+
+	if (ima_tpm_chip) {
+		for (i = 0; i < NR_BANKS(ima_tpm_chip); i++) {
+			if (dentry == ima_ascii_measurements_files[i]) {
+				algo_idx = i;
+				algo = ima_tpm_chip->allocated_banks[i].crypto_id;
+				break;
+			}
+		}
+	}
 
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
@@ -379,6 +414,84 @@ static const struct seq_operations ima_policy_seqops = {
 };
 #endif
 
+/*
+ * Remove the securityfs files created for each hash algo configured
+ * in the TPM, excluded ascii_runtime_measurements and
+ * binary_runtime_measurements.
+ */
+static void remove_measurements_list_files(struct dentry **files)
+{
+	int i, len;
+	len = ima_tpm_chip ? NR_BANKS(ima_tpm_chip) : 1;
+
+	if (files)
+	{
+		for (i = 0; i < len; i++) {
+			if (files[i]) {
+				securityfs_remove(files[i]);
+			}
+		}
+
+		kfree(files);
+	}
+}
+
+/*
+ * Allocate a file in the securityfs for each hash algo configured
+ * in the TPM (for ascii and binary output). In case no TPM chip is
+ * detected only sha1 files are created.
+ */
+static int create_measurements_list_files(void)
+{	
+	int i, len;
+	u16 algo;
+	char file_name[NAME_MAX+1];
+	struct dentry *dfile;
+
+	/* 
+	 * Allocate NR_BANKS(ima_tpm_chip) files in case a tpm chip is detected,
+	 * otherwise allocate just one file for sha1.
+	 */
+	len = ima_tpm_chip ? NR_BANKS(ima_tpm_chip) : 1;
+
+	ima_ascii_measurements_files = kmalloc_array(len,
+				sizeof(struct dentry *), GFP_KERNEL);
+	if(!ima_ascii_measurements_files)
+		return -ENOMEM;
+
+	ima_binary_measurements_files = kmalloc_array(len,
+				sizeof(struct dentry *), GFP_KERNEL);
+	if(!ima_binary_measurements_files)
+		return -ENOMEM;
+
+	for (i = 0; i < len; i++) {
+		algo = ima_tpm_chip ? ima_tpm_chip->allocated_banks[i].crypto_id :
+								HASH_ALGO_SHA1;
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
@@ -465,19 +578,21 @@ int __init ima_fs_init(void)
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
@@ -515,6 +630,8 @@ int __init ima_fs_init(void)
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


