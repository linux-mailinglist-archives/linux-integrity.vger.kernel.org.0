Return-Path: <linux-integrity+bounces-843-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC0D8356A2
	for <lists+linux-integrity@lfdr.de>; Sun, 21 Jan 2024 17:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9A601F21D42
	for <lists+linux-integrity@lfdr.de>; Sun, 21 Jan 2024 16:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0615E37710;
	Sun, 21 Jan 2024 16:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=politoit.onmicrosoft.com header.i=@politoit.onmicrosoft.com header.b="O9Mxcacx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2102.outbound.protection.outlook.com [40.107.22.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928F812E4C
	for <linux-integrity@vger.kernel.org>; Sun, 21 Jan 2024 16:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705854122; cv=fail; b=qpPjkNsuFqlBHYx6Zgng7GTfEXzKdfQEr9XQwWVVNOzSirHCH//R63XZU3EaJNWjuPrhNJWsVIn3uoFYwhoTrIaRN5FD3sIIFLCMKKd2sE+ciHA8unp5EbaV7udCr5q3hS3bXry7opPgTvMBLdmM8D/gtSntWVotevcHScAzCLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705854122; c=relaxed/simple;
	bh=LUeJG5bFE6yikBmaAW5U09iD4MwXZrag99AvGJDxyA0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BIGUXib+idqdLURUkOsXAGZZSi76LtajXHGuYDc6h8HUfE4Kv/WTbUIpjZjeQE3S7aSPEkug8/y/KxOiTHQqy69UvuzjI/AxtwhLMvFLgFDdtkhxk1VwCLUfO323RdppKGO0B/jHWaI8vafNVoAyui25m8EDm1ySA0yBjWzmd8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=politoit.onmicrosoft.com header.i=@politoit.onmicrosoft.com header.b=O9Mxcacx; arc=fail smtp.client-ip=40.107.22.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polito.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=polito.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gk7uqrfUpaGdI9W1nr8NqS4mwZlr+2le0YrPiiUtOt+curkYBmik7xvxaUiBQKaagRdu01dM7jRElibwf5hbD+QLhcS6RP+eEuZiJCInPoRik694zIPArYjiK+Aa86x0mlACWwOr/MMTwP8q9qXCjJeV07Evr32VQnESlE9vq6YIQxNjDzKeG//xBfIqUqKnHi7M0Z5dNGcvaNAWCSHo6Xcvs3GoMqbGOjFxhKzqs0y0FYJ+4PzxXmA7OTd4bio0tEgceTEWs7tHCK8n1aIPrL2b7xWoqm+4bOAVPhsYQN1bJAztHsNhk6RyCjW8NkkuViQPPF0Zg+ftgDj5N1xTGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxqmK9aAWeBqFJOaboOQXVLC0POUDVh4azEofcOQItc=;
 b=ZG5KV0rJIWaB+v4g2F0mDB/Q0WINafmOnBm3TqZ4tlDfgKNrZmoeLieFLRAAowymt6ax/Lyt3M5n1XWbUBYhJeYPXJNfUn5eKZDMn85f+GDOk26e8HXyVzMobakyqIYXmaFbD4kZt//VLjwV02gnytulTsi3badSO4eQK0ZOhZRgoAYuFRJU16T7j4sMEGIkwPchV07Wie2OTqr6d1XgvpkbGvWnq6TdQp+vam0aXBAsBnLt64/lmiLSSAAOD15s/TeEmdGW2tD0GRC/VXyrCKmsYGYcvRqWM/06+r2Mnt7OS0JmI3vHb8MwFJOhBRwSbKkHQ8ms5M9rlNJp/RZvew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=politoit.onmicrosoft.com; s=selector2-politoit-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxqmK9aAWeBqFJOaboOQXVLC0POUDVh4azEofcOQItc=;
 b=O9MxcacxOY4Vntlxfvj9mNxZxyCnH4W+sZSTwwmjnpKKvI2EaZu5gq3I+eec/VPlJWXN1r6OCEqGdB8iLWOCbziAdQLDEiz4Zq/J1hrMJmh6LGuXhTY0H58Um6lRLwDUPbSvVtzDYyhfauAzRUmmiT9Pgw81dDkRDfLvv+jwH2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=polito.it;
Received: from AS2PR05MB9840.eurprd05.prod.outlook.com (2603:10a6:20b:5f5::20)
 by PAWPR05MB9821.eurprd05.prod.outlook.com (2603:10a6:102:331::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.30; Sun, 21 Jan
 2024 16:21:56 +0000
Received: from AS2PR05MB9840.eurprd05.prod.outlook.com
 ([fe80::3351:44:a53e:99a9]) by AS2PR05MB9840.eurprd05.prod.outlook.com
 ([fe80::3351:44:a53e:99a9%4]) with mapi id 15.20.7202.027; Sun, 21 Jan 2024
 16:21:56 +0000
From: Enrico Bravi <enrico.bravi@polito.it>
To: linux-integrity@vger.kernel.org,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com
Cc: Enrico Bravi <enrico.bravi@polito.it>,
	Silvia Sisinni <silvia.sisinni@polito.it>
Subject: [PATCH v2] ima: add crypto agility support for template-hash algorithm
Date: Sun, 21 Jan 2024 17:16:35 +0100
Message-Id: <20240121161633.2302285-1-enrico.bravi@polito.it>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0017.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e::22) To AS2PR05MB9840.eurprd05.prod.outlook.com
 (2603:10a6:20b:5f5::20)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR05MB9840:EE_|PAWPR05MB9821:EE_
X-MS-Office365-Filtering-Correlation-Id: e96a84fa-2192-4e90-4d5c-08dc1a9d15f8
X-politoEOL-CGPAlias: 1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	euxAHIEXjtjAmXanIrj7e6JcxzSo41nMKhWJfuBBu5HS1IuIK4XRys05P50OhJPE7hRO+Ttu1zahdnNkreYVvQd30Rs5zW5Ru1ZExFogwwfYY0dTgSYmzsLQOIu2euMJNstuLnOfZ3gXdQAsBCVxZslG2o4g1YybuRdh5zNWV9ZTUeLnX6iUTg1Xkn8Tghzbshm11cHAqmECojKO17KBIPMs8pX3FdKcpbpoEbJcqLiQDvSbL0XSEMGZBzLM8k+QnfrnZhPtKNo2SCMnzLyXzejUrsRr5cytb0V5gVP6D+8WM98rXRz1xZ0qgK60DGL0emIgnnjwmJRkVTFB9AI3eFT3jMzcOU9NzXWrAcLq53lcoezKEMf6vy0XQSOXAkCXbaUx5rrWHsgUY/8ySHQ3Q20ZkcAqPJ/1I+XMoiGEtRHYCxBI9+rlmI5NQGQIipEj1YvhCa6sTuNlhDCH7opiyyZvkNEAHVi2hFj09X8fSVv7839Vb5j6VH3oNr1mkMws6FtuslyPsc50PkK/PBR/8siYzXvxsJNQczoQwL3Y2M2QYUMbF4nQp3dioR0eWzsJLYk/MzWwceItJo+uaJ8awk+1YnUu/JCZ3cub1eq2/jkjC0n7PRlrB8vPRirY5c0v
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR05MB9840.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39850400004)(396003)(366004)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(83380400001)(6512007)(26005)(2616005)(107886003)(38100700002)(44832011)(8676002)(4326008)(8936002)(5660300002)(6666004)(6506007)(478600001)(6486002)(52116002)(2906002)(66556008)(54906003)(66476007)(66946007)(316002)(786003)(41300700001)(1076003)(38350700005)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EJDdTkPVC/4awuMv/c5BL7voDFa6v/lu+vydOnz4AQn1P2qKM4MFXy3j6nHN?=
 =?us-ascii?Q?s45657PfciEKxNcSHSDiOZKZTjOpei6GgHKfJhCdVB+MJNtlDLpF8YynHZJP?=
 =?us-ascii?Q?zEOa7JG7n9seN0AS2RptTYK9clB30MRQORXOaBOWVpAwEdsPbxCDvUcWKHPm?=
 =?us-ascii?Q?crjLQitTIeWEIpT4Mb6hLu7BCgLU2daXTZg8nSyv3lLrGKnRqF7k5jKGTClB?=
 =?us-ascii?Q?8XG5ViBaKx6S3tNz//8CteeJPsPVS2zag++aHQsP7iz3HDYz9tWmSWyYs0vt?=
 =?us-ascii?Q?xYdqpKetz4aS0pvHS8N7KcFC6EJI7NZLnHzi4n3XPTPMpgZLV9rsyeXlsDUu?=
 =?us-ascii?Q?PSgR7+aIAYdQMwXkgzskWSJk6xRDOZ6DybdpORmxzQI3r4oeOA80dIcGvJLS?=
 =?us-ascii?Q?tZ38mIhTbaXo7OYvI2BA41mPC8Grbs7bdpBfTMiJ0G7l7n6jMVaCFmXghpHb?=
 =?us-ascii?Q?hi6/gjzHEI63BxrCEOHW7r1qI93F+QI/8uThtg4wCqXc2nGpiPrp2yLV38tr?=
 =?us-ascii?Q?9s9OcaYelsWDOxD4qZi1IcjogoziKJ0G9yVtWwlLbCxGGO2udBHO1lRW5kpP?=
 =?us-ascii?Q?GdjFD63CXBZbHaIJw8VW5jk7wqzZxk5AAbPqV0VgcgGa3NAoCWEleTq68now?=
 =?us-ascii?Q?XaMr+1+tjVzXwU8r8akxoa52ekcZ8Hxj0jvdnAySCZ21qn9yrl48dSsnjCHu?=
 =?us-ascii?Q?9d500XbGlyTvJ2Zyz0yCK0xiGNl8dDogkDTO7gkeAjgIhK360quNaRruaY6z?=
 =?us-ascii?Q?kfBKw+Q1dR7aqZ+EnZF90vzjSyLQpLMx1iKoTJEF9hfWdsmoXPopcGcuOgtn?=
 =?us-ascii?Q?QEHSarLOmxSKH1A+++FhmvEfKQArzwgeMxFGCx5qatjzbDS+qLc0R0c/wQqs?=
 =?us-ascii?Q?/k8GD1kikIkGDE3yYL1DCS87pkY78GZrtzxObUjIzh1uB/jI8rL/zNKFlWBg?=
 =?us-ascii?Q?xxHNpyIV6NWky2AupJ5BBMed9VqK7DleyEOa0w0RfLUPPb6/ijeyTlSpVcVz?=
 =?us-ascii?Q?n3aI6mrAbAYnqUXWJBI8j4D42/4ppryZQGHnW5KY+CyMo5gedLW94rHjyYYB?=
 =?us-ascii?Q?yztSZo3gB86u0z04Q0PC+lqaSa7mLOz9zl54anF76kidq76EKpBNN9iyeRP+?=
 =?us-ascii?Q?zV8f0XsqIvAbE0ElIXhdU5ehXhD6WB2JA9wsimdzaxbK80XPeZXhRmVKIppx?=
 =?us-ascii?Q?jH3vQg1FD9lhYP4qiHFC/EFALLUuqX7tfqewJEorQBfkuQg3tUw1RkjfiUuZ?=
 =?us-ascii?Q?Wcuy32SIGd6AXlZN2d2E5aTkxnEbCEKWjWzKdENxNQPQZEyXcDv6zmBf3DA6?=
 =?us-ascii?Q?gOsgc01gBneMCQ9ntzwl6QSPIqlnwnd3MkM48DaWrlL1VOmRAQxieOxicQ8p?=
 =?us-ascii?Q?phPgBavt2B3C9sUAwmJWNCz+dLTkaK2zkE3uFNWV+Hq0gmCIUW/1LAtQSIdK?=
 =?us-ascii?Q?9Q/qNVBJzrnt22PjEV9dGAEreY5a6PW1kWd7oyWBmLNUsThNbRlQ9PZ9bXNw?=
 =?us-ascii?Q?Q83cbHCgQdlmPdIR0qzdhpSMucLVzOdai+UPTcksyXp7rOmHbUwBz5hUV3d9?=
 =?us-ascii?Q?Z26g5I3jqF6kJ37RqpUNkqAUbbraVmbDytNyDiQXm4dfQ4wP+Dr6fRnEOm58?=
 =?us-ascii?Q?QA=3D=3D?=
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-Network-Message-Id: e96a84fa-2192-4e90-4d5c-08dc1a9d15f8
X-MS-Exchange-CrossTenant-AuthSource: AS2PR05MB9840.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2024 16:21:56.1825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jvhCzzBW6uAAKpGYD49FxP2AonPt1fDqzAzeLiryFbrFXVreBsDtEVya4/IZscusnFquHfKnR/NxoVlXAQtkhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR05MB9821

The template hash showed by the ascii_runtime_measurements and
binary_runtime_measurements is the one calculated using sha1 and there is no
possibility to change this value, despite the fact that the template hash is
calculated using the hash algorothms corresponding to all the PCR banks
configured in the TPM.

This patch introduce the support to retrieve the ima log with the template data
hash calculated with a specific hash algorithm.
Add a new file in the securityfs ima directory for each hash algo configured
for the PCR banks of the TPM. Each new file has the name with the following
structure:

	{binary, ascii}_runtime_measurements_<hash_algo_name>

except for sha1 which it remains associated with the standard file names.
The <hash_algo_name> is used to select the template data hash algorithm to show
in ima_ascii_measurements_show() and in ima_measurements_show().

As example, in the case sha1 and sha256 are the configured PCR banks, the
listing of the security/ima directory is the following:

-r--r----- 1 root root 0 gen 20 15:06 ascii_runtime_measurements
-r--r----- 1 root root 0 gen 20 15:06 ascii_runtime_measurements_sha256
-r--r----- 1 root root 0 gen 20 15:06 binary_runtime_measurements
-r--r----- 1 root root 0 gen 20 15:06 binary_runtime_measurements_sha256
--w------- 1 root root 0 gen 20 15:06 policy
-r--r----- 1 root root 0 gen 20 15:06 runtime_measurements_count
-r--r----- 1 root root 0 gen 20 15:06 violations

v2:
 - Changed the behaviour of configuring at boot time the template data hash
   algorithm.
 - Removed template data hash algo name prefix.
 - Removed ima_template_hash command line option.
 - Introducing a new file in the securityfs ima subdir for each PCR banks
   algorithm configured in the TPM.
   (suggested by Roberto)

Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>
Signed-off-by: Silvia Sisinni <silvia.sisinni@polito.it>

---
 security/integrity/ima/ima_fs.c | 164 ++++++++++++++++++++++++++++++--
 1 file changed, 157 insertions(+), 7 deletions(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index cd1683dad3bf..db57edeb112d 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -118,7 +118,7 @@ void ima_putc(struct seq_file *m, void *data, int datalen)
 
 /* print format:
  *       32bit-le=pcr#
- *       char[20]=template digest
+ *       char[n]=template digest
  *       32bit-le=template name size
  *       char[n]=template name
  *       [eventdata length]
@@ -130,9 +130,37 @@ int ima_measurements_show(struct seq_file *m, void *v)
 	struct ima_queue_entry *qe = v;
 	struct ima_template_entry *e;
 	char *template_name;
+	const char *filename;
+	char algo_name[16];
 	u32 pcr, namelen, template_data_len; /* temporary fields */
 	bool is_ima_template = false;
-	int i;
+	int i, rc, algo_idx;
+	enum hash_algo algo;
+
+	filename = m->file->f_path.dentry->d_name.name;
+	rc = sscanf(filename, "binary_runtime_measurements%s", algo_name);
+
+	if (rc != 0) {
+		for (i = 0; i < HASH_ALGO__LAST; i++) {
+			if (!strcmp(algo_name + 1, hash_algo_name[i])) {
+				algo = i;
+				break;
+			}
+		}
+		if (i == HASH_ALGO__LAST)
+			algo = HASH_ALGO_SHA1;
+
+		for (i = 0; i < NR_BANKS(ima_tpm_chip); i++) {
+			if (algo == ima_tpm_chip->allocated_banks[i].crypto_id) {
+				algo_idx = i;
+				break;
+			}
+		}
+	}
+	else {
+		algo_idx = ima_sha1_idx;
+		algo = HASH_ALGO_SHA1;
+	}
 
 	/* get entry */
 	e = qe->entry;
@@ -151,7 +179,7 @@ int ima_measurements_show(struct seq_file *m, void *v)
 	ima_putc(m, &pcr, sizeof(e->pcr));
 
 	/* 2nd: template digest */
-	ima_putc(m, e->digests[ima_sha1_idx].digest, TPM_DIGEST_SIZE);
+	ima_putc(m, e->digests[algo_idx].digest, hash_digest_size[algo]);
 
 	/* 3rd: template name size */
 	namelen = !ima_canonical_fmt ? strlen(template_name) :
@@ -220,7 +248,35 @@ static int ima_ascii_measurements_show(struct seq_file *m, void *v)
 	struct ima_queue_entry *qe = v;
 	struct ima_template_entry *e;
 	char *template_name;
-	int i;
+	const char *filename;
+	char algo_name[16];
+	int i, algo_idx, rc;
+	enum hash_algo algo;
+
+	filename = m->file->f_path.dentry->d_name.name;
+	rc = sscanf(filename, "ascii_runtime_measurements%s", algo_name);
+
+	if (rc != 0) {
+		for (i = 0; i < HASH_ALGO__LAST; i++) {
+			if (!strcmp(algo_name + 1, hash_algo_name[i])) {
+				algo = i;
+				break;
+			}
+		}
+		if (i == HASH_ALGO__LAST)
+			algo = HASH_ALGO_SHA1;
+
+		for (i = 0; i < NR_BANKS(ima_tpm_chip); i++) {
+			if (algo == ima_tpm_chip->allocated_banks[i].crypto_id) {
+				algo_idx = i;
+				break;
+			}
+		}
+	}
+	else {
+		algo_idx = ima_sha1_idx;
+		algo = HASH_ALGO_SHA1;
+	}
 
 	/* get entry */
 	e = qe->entry;
@@ -233,8 +289,8 @@ static int ima_ascii_measurements_show(struct seq_file *m, void *v)
 	/* 1st: PCR used (config option) */
 	seq_printf(m, "%2d ", e->pcr);
 
-	/* 2nd: SHA1 template hash */
-	ima_print_digest(m, e->digests[ima_sha1_idx].digest, TPM_DIGEST_SIZE);
+	/* 2nd: template hash */
+	ima_print_digest(m, e->digests[algo_idx].digest, hash_digest_size[algo]);
 
 	/* 3th:  template name */
 	seq_printf(m, " %s", template_name);
@@ -363,6 +419,8 @@ static struct dentry *ascii_runtime_measurements;
 static struct dentry *runtime_measurements_count;
 static struct dentry *violations;
 static struct dentry *ima_policy;
+static struct dentry **ima_ascii_measurements_files;
+static struct dentry **ima_binary_measurements_files;
 
 enum ima_fs_flags {
 	IMA_FS_BUSY,
@@ -379,6 +437,31 @@ static const struct seq_operations ima_policy_seqops = {
 };
 #endif
 
+/*
+ * Remove the securityfs files created for each hash algo configured
+ * in the TPM, excluded ascii_runtime_measurements and
+ * binary_runtime_measurements.
+ */
+static void remove_measurements_list_files(void)
+{
+	int i;
+
+	for (i = 0; i < NR_BANKS(ima_tpm_chip); i++) {
+		if (ima_ascii_measurements_files[i]) {
+			securityfs_remove(ima_ascii_measurements_files[i]);
+			kfree(ima_ascii_measurements_files[i]);
+		}
+
+		if (ima_binary_measurements_files[i]) {
+			securityfs_remove(ima_binary_measurements_files[i]);
+			kfree(ima_binary_measurements_files[i]);
+		}
+	}
+
+	kfree(ima_ascii_measurements_files);
+	kfree(ima_binary_measurements_files);
+}
+
 /*
  * ima_open_policy: sequentialize access to the policy file
  */
@@ -452,7 +535,10 @@ static const struct file_operations ima_measure_policy_ops = {
 
 int __init ima_fs_init(void)
 {
-	int ret;
+	int ret, i;
+	u16 algo;
+	char file_name[50];
+	struct dentry *dfile;
 
 	ima_dir = securityfs_create_dir("ima", integrity_dir);
 	if (IS_ERR(ima_dir))
@@ -483,6 +569,69 @@ int __init ima_fs_init(void)
 		goto out;
 	}
 
+	/*
+	 * Allocate a file in the securityfs for each hash algo configured
+	 * in the TPM but sha1 (for ascii and binary output).
+	 */
+	if (ima_tpm_chip) {
+
+		ima_ascii_measurements_files = kmalloc_array(NR_BANKS(ima_tpm_chip),
+					sizeof(struct dentry *), GFP_KERNEL);
+		if(ima_ascii_measurements_files == NULL) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		ima_binary_measurements_files = kmalloc_array(NR_BANKS(ima_tpm_chip),
+					sizeof(struct dentry *), GFP_KERNEL);
+		if(ima_binary_measurements_files == NULL) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		for (i = 0; i < NR_BANKS(ima_tpm_chip); i++) {
+			algo = ima_tpm_chip->allocated_banks[i].crypto_id;
+
+			/* Skip sha1 */
+			if (algo == HASH_ALGO_SHA1)
+				continue;
+
+			dfile = kmalloc(sizeof(struct dentry), GFP_KERNEL);
+			if (!dfile) {
+				ret = -ENOMEM;
+				goto out;
+			}
+
+			sprintf(file_name, "ascii_runtime_measurements_%s",
+						hash_algo_name[algo]);
+			dfile = securityfs_create_file(file_name,
+						S_IRUSR | S_IRGRP, ima_dir, NULL,
+						&ima_ascii_measurements_ops);
+			if (IS_ERR(dfile)) {
+				ret = PTR_ERR(dfile);
+				goto out;
+			}
+			ima_ascii_measurements_files[i] = dfile;
+
+			dfile = kmalloc(sizeof(struct dentry), GFP_KERNEL);
+			if (!dfile) {
+				ret = -ENOMEM;
+				goto out;
+			}
+
+			sprintf(file_name, "binary_runtime_measurements_%s",
+						hash_algo_name[algo]);
+			dfile = securityfs_create_file(file_name,
+						S_IRUSR | S_IRGRP, ima_dir, NULL,
+						&ima_measurements_ops);
+			if (IS_ERR(dfile)) {
+				ret = PTR_ERR(dfile);
+				goto out;
+			}
+			ima_binary_measurements_files[i] = dfile;
+		}
+	}
+
 	runtime_measurements_count =
 	    securityfs_create_file("runtime_measurements_count",
 				   S_IRUSR | S_IRGRP, ima_dir, NULL,
@@ -515,6 +664,7 @@ int __init ima_fs_init(void)
 	securityfs_remove(runtime_measurements_count);
 	securityfs_remove(ascii_runtime_measurements);
 	securityfs_remove(binary_runtime_measurements);
+	remove_measurements_list_files();
 	securityfs_remove(ima_symlink);
 	securityfs_remove(ima_dir);

base-commit: 88035e5694a86a7167d490bb95e9df97a9bb162b
-- 
2.34.1


