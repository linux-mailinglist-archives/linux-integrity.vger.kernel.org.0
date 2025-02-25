Return-Path: <linux-integrity+bounces-4985-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B546A440DD
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Feb 2025 14:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D634C162807
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Feb 2025 13:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BB3268FF1;
	Tue, 25 Feb 2025 13:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b="Rg9rCDUz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2095.outbound.protection.outlook.com [40.107.20.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F972054E4
	for <linux-integrity@vger.kernel.org>; Tue, 25 Feb 2025 13:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740490120; cv=fail; b=uXyJD4+FkfzELMMBKyitxdilKA891LsopABMaqohKGlX2kcDiUF+vQ7Wq0P9jlDqiiQbd5Wsn8T5gZV4tzOrXQXszn5eCS6vuu8rCDnk1Ekt2aKTxzlpySlcrl9ABQoKxJmIOGm6X7jUFZpYn6bba9yiQIKqZGS/3uX7UonDKxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740490120; c=relaxed/simple;
	bh=a20NvNiGh0wp9TSutMVYSApFLGPc+uPC0nuh0wV9n9o=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=aT/pZDl5DUMfSY62K2BuL/wIQUrjVrp8QqlFzcdoP1kT9+mm0NRmvOV8UoMV6b5GOGqfo0I4Ih5aVf+q/xlEOZksF7rfowYdPc8SM4IKn7YoZ4CicTsDC+Wt5MF3HvXuI9raOxstNmqxpPufptu8mULaP7KCv/79NzLq2xLmZ3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=Rg9rCDUz; arc=fail smtp.client-ip=40.107.20.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polito.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=polito.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ppnd7vic2GaIIoS9w/nzzt0LYTp+R4jvnCKgslSuz7A2ihpJNNGk2PxFpFCUWHARsvaBXy3YjXGw5Jh7AhCvHVtH5yJuDpgmiJYHUiIE4RTfFYyUZmYUzn6Uz3hyquxc4gIQk6aYw5ZK8uBGqxhb2foIauJfJWa8dUkx03u8Kp52LsqGT9rXjJS8rFcMvjKnVK7Z1XdlqocwQGEAl+9W2Cm0+j4bYpTvuPQcNuZqOU9J8RASh5S6uN06BqU7NM+rIj+KuSYEOfclcfaKsCrLjKrNDs2SS8hcEQrQ2mhLmmpFcP64NE6B/DiUxrRD4AM0K0vaA6V8OLYzDPrPdX8agQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2U6+9nQnSo/UalTVODqtKu+LL2by9uikpWHbuK8Nzz4=;
 b=PQYoGDTBzMDTWuRCK8WZEY6h2b3TpORD/9c956qh2Fnb4zVIrtaDnNgTIKUkUzuqux/hR8RrlBAL0UKzzU02VR/K8pK759drpC1ZLuK/NXKx5DSjzvtEtQ/9SEdvKdmzKtlRM33SirWknyZ54PL65QY/lKeJLhbUtbgUCVsgyIAXtUdSYi1cl3s6g2KuKabTpTFtped2xcATHKDn3XFh9KTgjQj92ZXggmWcrEANyYR/Fsxq967FRZxOqUAiEs+V+lHd9iUI5yKbw9faIydIEC9ik9WljOdVK9vYyysCoB0jyiHmiS7d3wTtoJFfhdrpys1plwI1o4oPrtwV7C8H4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2U6+9nQnSo/UalTVODqtKu+LL2by9uikpWHbuK8Nzz4=;
 b=Rg9rCDUzqZL22cr46RLPoGDDPB5VMCQCrQc1E9q47isvfFrc4U2u2XoRJhd2pMGJo+1L2L8sn7lYBYmgDCAHmtJg8As4+YkDHHoR8F0BOocKynrT/xLm+tD/DoejhvpDelSIV1v1ZKjRdWRQGGbjohE6HjzwOVhZa5gIzvsTwUk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=polito.it;
Received: from AS2PR05MB9840.eurprd05.prod.outlook.com (2603:10a6:20b:5f5::20)
 by AS8PR05MB8836.eurprd05.prod.outlook.com (2603:10a6:20b:423::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Tue, 25 Feb
 2025 13:28:33 +0000
Received: from AS2PR05MB9840.eurprd05.prod.outlook.com
 ([fe80::237b:12ae:525c:3bbd]) by AS2PR05MB9840.eurprd05.prod.outlook.com
 ([fe80::237b:12ae:525c:3bbd%4]) with mapi id 15.20.8489.014; Tue, 25 Feb 2025
 13:28:33 +0000
From: Enrico Bravi <enrico.bravi@polito.it>
To: linux-integrity@vger.kernel.org,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	roberto.sassu@huawei.com
Cc: eric.snowberg@oracle.com,
	Enrico Bravi <enrico.bravi@polito.it>
Subject: [RFC][PATCH] ima: add measurement for first unverified write on ima policy file
Date: Tue, 25 Feb 2025 14:12:57 +0100
Message-Id: <20250225131255.154826-1-enrico.bravi@polito.it>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0220.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::22) To AS2PR05MB9840.eurprd05.prod.outlook.com
 (2603:10a6:20b:5f5::20)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR05MB9840:EE_|AS8PR05MB8836:EE_
X-MS-Office365-Filtering-Correlation-Id: de73b7cd-ef73-4ca8-9ae9-08dd55a04cc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DW6W5uCGZ6up7+baWLr0QPwurGVxmqozZ4jjj8otw1rw8CQjPziV+aH/8lFO?=
 =?us-ascii?Q?vpeyqyju4xDg18HF9qVUClbvYWtAs3bL3iviLUbUKEg2d2BKimAtiKVUMvp1?=
 =?us-ascii?Q?tym0pnGfRz1p/o+rdVg4B/TMckpB4N/bKLUoGV9jYp8WdiOoNyurnQf9MOM/?=
 =?us-ascii?Q?cTddeRllXNMJk8vC/E7fwf0rz5CGke29k8sOAIg3gyf730lx85Gp51cys1Y5?=
 =?us-ascii?Q?aAMHKSZpQZ3IUuZlUOFUt5zquTXQP7lCQpQqV+pRzgG2DXwBVYzlZ1Jv+8FX?=
 =?us-ascii?Q?oixay6CZ7sNSPL4is/brKP/BSK5j6O3cJ/JXylODWmHIAbvuZAgSRBsGG/Pv?=
 =?us-ascii?Q?n4dS0fYoLeBdQSnEHFpP5AXoqyvoYVChB05zeojumGlHDGf1H/pFyugbJQXX?=
 =?us-ascii?Q?ganuAfqDNBKWl/u7HCa9Xt0q87MD6orbnpKH1dsrfuzVZuH09zed5kYAg48b?=
 =?us-ascii?Q?RspdcTPF7bDWcBINlCaR/GqupPfuKcHPa6Ny5G1blSCVkZHg5WdAztOTxX/5?=
 =?us-ascii?Q?nnE/SJ76OJHkO8JMOEOJ6pL9IykPSP09uQJM+dEKfo5npWoRQPJG1T0KEmio?=
 =?us-ascii?Q?hrMbz7Dij0her9XeuvM1EYalKnWoFV43CEidrcbGFB4nZyj6eeXpGjEd6fX4?=
 =?us-ascii?Q?eIkyUdBM8bJ84qWKSb1uT0vCrs2lQg0wBAchiJ1LB3fts83wKh6B9n9Ek3eN?=
 =?us-ascii?Q?GlPZiKntOwMlc/55TDWuH6/aapsLQkxOQ22Jx5x2qKRWcz+++CPOneELjskt?=
 =?us-ascii?Q?aNu6HodfVSM1adY+MY8hvHGOKstXSxEPnyEvKhlOgoLVrMK1Z7AM8kfUTL2Y?=
 =?us-ascii?Q?ARTN9XU7VJmad/k8SXTmPltMjL+hkPle/PX8BO1o32sNPPQ8GKAAf8PHL6fi?=
 =?us-ascii?Q?cIXEThwMPm1ryBGVreltUXsSEf3WxQwghMhlTaGYQiwF7dVUFfhZiFuyff/5?=
 =?us-ascii?Q?Ev9uLw2Rif0KxExPD8o1hUnh/axd0llNwNp2h/H7azJV5iMr23K5FdFiBw7+?=
 =?us-ascii?Q?UIlk4XQzRKoijjZUSm1cuOta9pe0+rOWc/rctryzbE52U/lw3uCi0LrzOfe9?=
 =?us-ascii?Q?BwHzETT6sBc1CdT5HgwnQZYTGiSOEQ2AD3EBcH7HevV5iLjuDBVJEo9nN6Wr?=
 =?us-ascii?Q?/6aW7XRsn2YjBfCmZwH9cXs0d+JWdj77/nGEvtKYzfQQ4qYRqwdf2s4qLTxK?=
 =?us-ascii?Q?nfDi59VfnVr/AJPfWWYd8jHptbO5tjh7A9yPHyHnOp1WQMd7MBgv66tFYmVh?=
 =?us-ascii?Q?9GMJ4eY6kgl/iVo4CFlBm+c96LMDHIJLq59kWT0JuZYjuRmcqw1AG5CwrDNz?=
 =?us-ascii?Q?LUuhiqG+lNmdp7szAP+wdvHaKMm6X0rh0CGyoTYYbU/wrghQMmfnJu06sD4q?=
 =?us-ascii?Q?3yW0cymQKf4S5zp+aNvAUEZ19zka?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR05MB9840.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rly5HBjsI/hD8g4h+NS/tJx/TiSgTgT/Xta1Chw1ZkpTdmAPN1N6Yi73aCia?=
 =?us-ascii?Q?fRMYMlSS1ONty9+t+PBtaBtduRM3hUeMbOol+Glxm3f4o7o0FgVoHSSCqtzC?=
 =?us-ascii?Q?fkWI95YJ2QyitFiQz38NG9QfOJgdB3ZcdwPb8oMCOxwEkLcKPxYcd3VP5Tg6?=
 =?us-ascii?Q?o+oOZI2JC6zB18ri0wv/J+Vzcl7QWkgTrCXbcavY5j0hbW6zxld4eqftYXF0?=
 =?us-ascii?Q?ZRtTLsEm/hLFwHpQD504T8ccE3f8yxj9dZRtwTWl3HWusdo74ajevuL51DdW?=
 =?us-ascii?Q?FCoFhvOiR+l6FTp10H/ndCALuxp2zHoc105surFaL3SwKtsCugQFK3EoUG4W?=
 =?us-ascii?Q?W69b0gsSRbJLDLwOXs2u5/hJU22gLUGgnMuDiONcJvHeokIk//WZqvYBwe4X?=
 =?us-ascii?Q?GXmbAq2KEI69V6mK5qExfVsA8UtwxoX60QeLCtora1kP41OUQ7CjVbU2/fe5?=
 =?us-ascii?Q?XZ0vkeWOKx1BdFtSat4xCGW5vac26cOZGsYmO6/Szc0dyf1CxIRRLm4rirFX?=
 =?us-ascii?Q?k/u+RXOgsudkvgaoA/0m0A15hAQBWobcTVFxHbJfnlpiHAFjaLqUMUUXw0qI?=
 =?us-ascii?Q?OBdylCZEg0PXiIbQSPhBLbMOpFDW8yGAep0TPqs4aHJQH1SRmS8Cr+spTfFp?=
 =?us-ascii?Q?m1P1KCBAF+ZjpY63lhp3f+n3zxyIl34Zye8XObcmxg3hwmY5LHBlr9zre92J?=
 =?us-ascii?Q?H1nZLCWymYoxZNIELflnq0gZyFVRr2XZKJLBzAuMaof/5StQ1qYURE1HRoVh?=
 =?us-ascii?Q?h2WIqnZQkukdTla06zfKBk9CcwV2IcYKffLLXQ/qhQq1dZp10bSWUliEQ7TQ?=
 =?us-ascii?Q?aN5JRfJkuRV9jmEKLg2enqYQu8AMCE9h4+wTC7uFLgEjo2+WBKmoO5r6oaxG?=
 =?us-ascii?Q?vAG6UUmF5BHzIcH/KPk+QRFw+sNA0M3q3sMsbZM+BCpbAQJKdeSkkNztG4kb?=
 =?us-ascii?Q?FIwnnKBo3gDRbQFk64FHJl+J9zw2NwzznpV5L4NBJidxq0xawdUZpnVYwpSf?=
 =?us-ascii?Q?vjXejLCtpnparTFgfp9XN7knfbP3v21IceLqrjulUg4fIroSCUMz1IyXiciJ?=
 =?us-ascii?Q?HIa/VbLGXwSpms43ahsId6LYPI0YBp2LucSCjEdWrZWcEQmphwkLp4NkTuFy?=
 =?us-ascii?Q?xQzW0F6BFuo7ubP9SAe7JmlKHLQ1QjejrJBlpdZBoGrOufhulVzZuscck3RY?=
 =?us-ascii?Q?RseT0H3g1ziXbfGDj1ZtLhhT1s5+JcT2i7nGqBIokMGtvd+a2BfWMN1RrnY4?=
 =?us-ascii?Q?dMb5uPrY49U/ONM84Ul1o7Np/zgdgfTtw4ZFTSGjVDE+IBtL7jx4KQHJBygW?=
 =?us-ascii?Q?mBIAO/1LyvmYHVcSwfZ0wxMbPyXEQLZLRhHh5H8QJ25qKpx/ebPwMXVNtyNm?=
 =?us-ascii?Q?F/DVToMfa4ZrYzvN9pTO9mBALS0qrT36DgK3AN1W3XOp8CxK4O5JQ0wfYZRB?=
 =?us-ascii?Q?xkiqu0giON6C9S0UcGqC+15gqfeZSXe4u5+PHr0uvSZLbKWiUJYMODJzgIjg?=
 =?us-ascii?Q?Xs/xsF7Heciw+hQ6lS3K090ehDS1AQYDbvoMvTm0cB0fprW8qH29kLF0A+zR?=
 =?us-ascii?Q?+dK4ktRSfaLv1B083rHBzB8fZ8w5hR3Pa3OxyYhYv2QxmMhntBvbF0LsEmC2?=
 =?us-ascii?Q?nA=3D=3D?=
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-Network-Message-Id: de73b7cd-ef73-4ca8-9ae9-08dd55a04cc7
X-MS-Exchange-CrossTenant-AuthSource: AS2PR05MB9840.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 13:28:32.9915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VO7j6CJSCmKG6xyhahSzOL0ROTck6N8v4cGJAingHZ8NKIqONys/QIi6C+B2L1UXkQtCT8CjHfNchZITjm/8CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR05MB8836

The first write on the ima policy file permits to override the default
policy defined with the ima_policy= boot parameter. This can be done
by adding the /etc/ima/ima-policy which allows loading the custom policy
during boot. It is also possible to load custom policy at runtime through
file operations:

cp custom_ima_policy /sys/kernel/security/ima/policy
cat custom_ima_policy > /sys/kernel/security/ima/policy

or by writing the absolute path of the file containing the custom policy:

echo /path/of/custom_ima_policy > /sys/kernel/security/ima/policy

In these cases, file signature can be necessary to load the policy
(func=POLICY_CHECK). Custom policy can also be set at runtime by directly
writing the policy stream on the ima policy file:

echo -e "measure func=BPRM_CHECK mask=MAY_EXEC\n" \
 	"audit func=BPRM_CHECK mask=MAY_EXEC\n" \
     > /sys/kernel/security/ima/policy

In this case, there is no mechanism to verify the integrity of the new
policy.

Add a new entry in the ima measurements list containing the ascii custom
ima policy buffer when not verified at load time.

Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>
---
 security/integrity/ima/ima.h        |  3 ++
 security/integrity/ima/ima_fs.c     | 11 ++++
 security/integrity/ima/ima_policy.c | 81 ++++++++++++++++++++++++++++-
 3 files changed, 93 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index c0d3b716d11f..27cba2e612a5 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -46,6 +46,8 @@ enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8, TPM_PCR10 = 10 };
 /* current content of the policy */
 extern int ima_policy_flag;
 
+extern bool override_ima_policy;
+
 /* bitset of digests algorithms allowed in the setxattr hook */
 extern atomic_t ima_setxattr_allowed_hash_algorithms;
 
@@ -414,6 +416,7 @@ void *ima_policy_start(struct seq_file *m, loff_t *pos);
 void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos);
 void ima_policy_stop(struct seq_file *m, void *v);
 int ima_policy_show(struct seq_file *m, void *v);
+void ima_measure_override_policy(size_t file_len);
 
 /* Appraise integrity measurements */
 #define IMA_APPRAISE_ENFORCE	0x01
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index e4a79a9b2d58..8c516de4aebe 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -309,6 +309,9 @@ static const struct file_operations ima_ascii_measurements_ops = {
 	.release = seq_release,
 };
 
+static size_t text_policy_len;
+bool override_ima_policy;
+
 static ssize_t ima_read_policy(char *path)
 {
 	void *data = NULL;
@@ -383,6 +386,7 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 		result = -EACCES;
 	} else {
 		result = ima_parse_add_rule(data);
+		text_policy_len += (result + 1);
 	}
 	mutex_unlock(&ima_write_mutex);
 out_free:
@@ -532,6 +536,10 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 	}
 
 	ima_update_policy();
+	if (unlikely(override_ima_policy && text_policy_len)) {
+		ima_measure_override_policy(text_policy_len);
+		override_ima_policy = false;
+	}
 #if !defined(CONFIG_IMA_WRITE_POLICY) && !defined(CONFIG_IMA_READ_POLICY)
 	securityfs_remove(ima_policy);
 	ima_policy = NULL;
@@ -558,6 +566,9 @@ int __init ima_fs_init(void)
 	ascii_securityfs_measurement_lists = NULL;
 	binary_securityfs_measurement_lists = NULL;
 
+	text_policy_len = 0;
+	override_ima_policy = false;
+
 	ima_dir = securityfs_create_dir("ima", integrity_dir);
 	if (IS_ERR(ima_dir))
 		return PTR_ERR(ima_dir);
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 21a8e54c383f..34753bce4668 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/rculist.h>
 #include <linux/seq_file.h>
+#include <linux/vmalloc.h>
 #include <linux/ima.h>
 
 #include "ima.h"
@@ -1044,6 +1045,8 @@ void ima_update_policy(void)
 	if (ima_rules != (struct list_head __rcu *)policy) {
 		ima_policy_flag = 0;
 
+		override_ima_policy = true;
+
 		rcu_assign_pointer(ima_rules, policy);
 		/*
 		 * IMA architecture specific policy rules are specified
@@ -1982,7 +1985,6 @@ const char *const func_tokens[] = {
 	__ima_hooks(__ima_hook_stringify)
 };
 
-#ifdef	CONFIG_IMA_READ_POLICY
 enum {
 	mask_exec = 0, mask_write, mask_read, mask_append
 };
@@ -1994,6 +1996,7 @@ static const char *const mask_tokens[] = {
 	"^MAY_APPEND"
 };
 
+#ifdef	CONFIG_IMA_READ_POLICY
 void *ima_policy_start(struct seq_file *m, loff_t *pos)
 {
 	loff_t l = *pos;
@@ -2028,6 +2031,7 @@ void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos)
 void ima_policy_stop(struct seq_file *m, void *v)
 {
 }
+#endif	/* CONFIG_IMA_READ_POLICY */
 
 #define pt(token)	policy_tokens[token].pattern
 #define mt(token)	mask_tokens[token]
@@ -2276,7 +2280,6 @@ int ima_policy_show(struct seq_file *m, void *v)
 	seq_puts(m, "\n");
 	return 0;
 }
-#endif	/* CONFIG_IMA_READ_POLICY */
 
 #if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
 /*
@@ -2333,3 +2336,77 @@ bool ima_appraise_signature(enum kernel_read_file_id id)
 	return found;
 }
 #endif /* CONFIG_IMA_APPRAISE && CONFIG_INTEGRITY_TRUSTED_KEYRING */
+
+void ima_measure_override_policy(size_t file_len)
+{
+	struct ima_iint_cache iint = {};
+	const char event_name[] = "ima-policy-override";
+	struct ima_event_data event_data = {.iint = &iint,
+					    .filename = event_name};
+	struct ima_max_digest_data hash;
+	struct ima_digest_data *hash_hdr = container_of(&hash.hdr,
+						struct ima_digest_data, hdr);
+	static const char op[] = "measure_ima_policy_override";
+	struct ima_template_entry *entry = NULL;
+	static char *audit_cause = "ENOMEM";
+	struct ima_template_desc *template;
+	struct ima_rule_entry *rule_entry;
+	struct list_head *ima_rules_tmp;
+	struct seq_file file;
+	int result = -ENOMEM;
+	int violation = 0;
+
+	file.buf = vmalloc(file_len);
+	if (!file.buf)
+		goto out;
+
+	file.read_pos = 0;
+	file.size = file_len;
+	file.count = 0;
+
+	rcu_read_lock();
+	ima_rules_tmp = rcu_dereference(ima_rules);
+	list_for_each_entry_rcu(rule_entry, ima_rules_tmp, list) {
+		ima_policy_show(&file, rule_entry);
+	}
+	rcu_read_unlock();
+
+	event_data.buf = file.buf;
+	event_data.buf_len = file.count;
+
+	template = ima_template_desc_buf();
+	if (!template) {
+		audit_cause = "ima_template_desc_buf";
+		goto out_free;
+	}
+
+	iint.ima_hash = hash_hdr;
+	iint.ima_hash->algo = ima_hash_algo;
+	iint.ima_hash->length = hash_digest_size[ima_hash_algo];
+
+	result = ima_calc_buffer_hash(file.buf, file.count, iint.ima_hash);
+	if (result < 0) {
+		audit_cause = "hashing_error";
+		goto out_free;
+	}
+
+	result = ima_alloc_init_template(&event_data, &entry, template);
+	if (result < 0) {
+		audit_cause = "alloc_entry";
+		goto out_free;
+	}
+
+	result = ima_store_template(entry, violation, NULL, event_data.buf,
+				    CONFIG_IMA_MEASURE_PCR_IDX);
+	if (result < 0) {
+		audit_cause = "store_entry";
+		ima_free_template_entry(entry);
+	}
+
+out_free:
+	kvfree(file.buf);
+out:
+	if (result < 0)
+		integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL, event_name,
+				    op, audit_cause, result, 1);
+}

base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
-- 
2.47.1


