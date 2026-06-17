Return-Path: <linux-integrity+bounces-9801-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wuZUFYjKMmo35gUAu9opvQ
	(envelope-from <linux-integrity+bounces-9801-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jun 2026 18:25:44 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DB469B5DA
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jun 2026 18:25:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=polito.it header.s=selector1 header.b=OU3nCrPq;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9801-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9801-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=polito.it;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B656932A80D5
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jun 2026 16:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733954A13A2;
	Wed, 17 Jun 2026 16:07:48 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021085.outbound.protection.outlook.com [40.107.130.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B2E495529
	for <linux-integrity@vger.kernel.org>; Wed, 17 Jun 2026 16:07:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781712467; cv=fail; b=Z8msphQgy9xfcblbv1ZoGU51XjX7d9469g/RsTd9dADTdhTHXaHzB7wXcXs9qQTJ8eyEgKDw5FYSrb0gjI8O0PmsIQuTYeQK5DHhO8COX2pXsX5MY0haVQr6H9y4UBstF5dpcjLhe2AA3D6uxkdVC2OKwTCZ8p+W2osPtIjqbHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781712467; c=relaxed/simple;
	bh=AQu8WnyoJA179vUFmB1P/idpfbd49d1WUwIdIe6QO8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MJxvfp1MOZdzVfHjE6YqFzgNinOmMRus5J6yWkuLIKy/bPV/nimr0n+aC5hXWIMElENoNTUwdyHJ5fWAYAoi+bB9DU/0MarC/9pA5jjsPma0HXARMO4opWlVfBibEvyX1oHRbBWbpI7vMK1LyWmwMOMUqhlLdjQoMESTcBmfUKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=OU3nCrPq; arc=fail smtp.client-ip=40.107.130.85
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4ynYB+nQ6TJ5UvxrwaF3+oADtPHh74fQ6KiMfE618q02vX2Sz6AahU68+JBtikGgH+/XjPsExl1BG54wAKRH+SB4PO6HuuIOQT86QrokiuTu74ZHaToHnqRNNGB//actZotYIt0JiU5EYbEQOub3B9Urn0r7K0/+mivqtERx/PLJmZxo4VLQq/++RDZbKC48bePexdIMb50tNvPT4djhz6VyZaI/Md4slrGK1qdNQTre1USqfX9dn9l1dktJuJeCyPBn9SZiJ9XbwTiepAQ1tEd2hM6wYtyJzSx82jJQMkdNQM5tGTvahBasTAO/2XtQN6SeXzMWjf4uCkCUDr3GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMw7EB3thiRi6xTpWHF6bh+9GwQOjVS31GzuuOmbqyo=;
 b=KctlbdeMkeFyq3iC52kPew5p63OZ+D2UERGr2vxX9oe4tIOFnh0EUk8ro9qFuSy+4SRHaMeX7Sbp5AB2tqqrywKT43nGNQY6vFn0vylMXLEz0qdq4/VxKPe+v2V9mUMe8vsnAoO3NANx5vw+TQnX5tRXp+UPKD75mi4ojhkpYJoD+fbctaG5KiW0yfgWozK9b/grYz3ONYc8sp84S7yzJlDjHduEweJXAVSyBo7/6cjwOvWClWT7u0YmDb+kqEqDvyIXE+bOCp2vObSCcdvyVx2CL5fDwE3mbPtHFN+HooZZT6p9vahuWot3hpVdarPQexT85OwqRXy9iBshiZxGLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMw7EB3thiRi6xTpWHF6bh+9GwQOjVS31GzuuOmbqyo=;
 b=OU3nCrPqDaS4uv/+njBUzUbird10IL6JHeHqx2Pl/w3Wv6titggvoXFpBmshcVaObJjVN3jZ2uRbJamDzLaZRKFo0WuhBgoRL7IgJeiyDDDQ3Cy2K6sE9+dSJDwXUqY8vdWEMdOFHd7CHssBNPmFTfxrNY+WyAtKF62TSDAkwKg=
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com (2603:10a6:20b:253::20)
 by AS8PR05MB8772.eurprd05.prod.outlook.com (2603:10a6:20b:343::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 16:07:28 +0000
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64]) by AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 16:07:28 +0000
From: Enrico Bravi <enrico.bravi@polito.it>
To: linux-integrity@vger.kernel.org,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	roberto.sassu@huawei.com
Cc: eric.snowberg@oracle.com,
	Enrico Bravi <enrico.bravi@polito.it>
Subject: [PATCH v4 1/2] ima: measure loaded policy after write on securityfs policy file
Date: Wed, 17 Jun 2026 17:58:33 +0200
Message-Id: <20260617155832.434517-2-enrico.bravi@polito.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260617155832.434517-1-enrico.bravi@polito.it>
References: <20260617155832.434517-1-enrico.bravi@polito.it>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::20) To AS8PR05MB7880.eurprd05.prod.outlook.com
 (2603:10a6:20b:253::20)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR05MB7880:EE_|AS8PR05MB8772:EE_
X-MS-Office365-Filtering-Correlation-Id: f9d718d4-48b8-4d77-75c3-08decc8a877b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|786006|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XN4j92cuwyjFVJ7iJdcNQvxylr2tlnalY2QjG1QeFTAcRPTRvEx0gc+lY3idy9g/CRz0W9RXbmEf9Zwm39HThMXs/f0+fNoocvbVLysXT6zbTq9BkGXWjxJHJS/veS5jh20WhDqAak3DGmKuuxxGLWzwvkYxRBGMoD6bblkC+KEcwmIHfFy5mkatgWcMLjA5G1Lgtdtg/NBwE/HobNU/c9IIKinOtz51PvcNT2QBkGrwZYvUg4zmLk4HbzWfGTxKgwZaHMYfwfzz8MYBFwUN/su5bnxjM5B0WV/a3tGdegomr49T71BM0J5GDHI3y7AaYkzPtQCT+g+OVxMkm6NGvoPFb1Tgli+T0V5JpKn8b0cm+jbDGT0RO2sQbhvhhn33KXpytSSAU3KPmLrT9Hk9qfOn40RK7/isjlAgB6EWZHG7tTSwH1aJ94z0OwJSlapBMKJ+SEwcmmEHCeZKIYL5MZNKwwgEQOGhJUGRVRahdkmDDKfpddw/L1+XWlXnEVz2c4+gtd7QG3sRYeYcjsmsHJl0VN5YbMBsmk9gWDlKeCkOU14EqIofUcrFRqGOH4Jmy6JKci+HAsxekwyyTJLbO7ouRUMHjiXctU/0B33ruJ/OaRlXHqxTQItLxmZK1n0cdSTbcK+z7ZvkMNwBPAwqX1juoNHwBV3kgVx3YtyUlwisjexwm24IKQAHS4f2VevA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR05MB7880.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(786006)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?noDt4rqaABpyFAxkUeegFIq588pcfuOStwtnZPlehEIKDi3nwjzzkFarfNzV?=
 =?us-ascii?Q?9vpDXey4eEHpImX3U7sdaBShaXwT7Im0bvX6QQPMr04KSrtm1cEPaH06dLKj?=
 =?us-ascii?Q?v5CLE3WGHIXknWw5emNWGlQ2wGf7eP7h+t7/gHeW2fOPlmIW7UdKT6+TRczL?=
 =?us-ascii?Q?YUPj4JgHIF/qJxHBQO/PwNVt5UzoFMID3fcfAqXHj0Ajn/J4ZU0QviAq10SQ?=
 =?us-ascii?Q?D3gTlssQ97IhaHhVcwAjBWYa+CZtQ1Z+6WR9jgm3JofvxjoTfQ7oddraBR0F?=
 =?us-ascii?Q?eHisvW88Tyldy01CpU39Kd1Itq4WJZnh12lnQMUIlDKjaIRp2Fw+SqYmRukp?=
 =?us-ascii?Q?L5KIPxM8BMe58C2uoTinsZjK3Nl3EJGeAGKjcaS7CZEd7dQl/RiyescncNz9?=
 =?us-ascii?Q?GDxLK3Kr81tV53h4bxdWKYw44T5XQLUl6SiBmoG+3V9VS6Z7MgDepkIDHi/u?=
 =?us-ascii?Q?cB/JMCq+zUJrBoEzit2SHXlwochFTkvpyR98GQ/LjMdN41ijC1YHMg5kDYD+?=
 =?us-ascii?Q?Ujin76WR1XLTtY/8qz16BFALaLfz9WjWIik5NWftNwJrVEJPAmryEI2PvQzu?=
 =?us-ascii?Q?FRcXauj+b2Ol7l78SlfDDe6dOmi59D9xCZ07agD3B99wXRPV3c3QOxq/tQo4?=
 =?us-ascii?Q?2UuWwYqwofapeHSwteQqx73cNkHA7gjUNGHAHSlzV4obdvPIm2n/I526UtTy?=
 =?us-ascii?Q?SvinHdnReaV1edGIkeqd3yjdnOliIDuajyKKWY64k/4AUSId0FbANFIQa+FB?=
 =?us-ascii?Q?Sxg7krctzjWwFk4LPOupp8Af8R9jm7v9jBlqB3rQxFW9O1Cg0nosd9xeLILE?=
 =?us-ascii?Q?QtdcIDpWASxKRDQ3XRo7XHxxe1kHQQQKTAPfH+4C6CuwdER1NC8m37SFaz3I?=
 =?us-ascii?Q?M+vNw2C5RIGKxLUbGyc2YJO1NOByxsetu71oYZfiWYBy+9ELhF6ojiJK8IRc?=
 =?us-ascii?Q?WrfAS9zIviIWmho25Mc3GiQxtBLOEcqi93kOq5SqeUfbMUePBZ5Y3TUwq11I?=
 =?us-ascii?Q?7aP37FPTKKfXwoYmmdIuTpxEDXuuzI+0WFGsNfUumNfrdA/8Fd24LvtNe7HK?=
 =?us-ascii?Q?CVMnjxYS1ZXiyXfHeTeHTDb155sxW6bIBsV7zM/zp4HMmDdhT6ixPU219csk?=
 =?us-ascii?Q?mbsgvrIaVIJmLj4E49flR7buoGBeFVMhPf8cJCG2yNHjaUlsjl/0x9r3jHed?=
 =?us-ascii?Q?OfDcleATwyvDVikLgVyeIIO5SUCNVKecZvconQBrd8Nxy0StDpSpz8Lk3FNb?=
 =?us-ascii?Q?cF36YZn+GVKGrIeA9b2k8Ve+0ET+OGdYWbpCo6I8Soc/WOelnilx4ns3Qz7m?=
 =?us-ascii?Q?TrG0/33LRuyUkU39DQeIaqLooXhGQ2K+CxCPijSqFdhPWWM3H8lD2TYzhCkY?=
 =?us-ascii?Q?IVbyJgdJHA/oUWX6Mt2TZxvJkCyHZmn0w+m7TKwl6gR/ZkPXLb9euDVXidXb?=
 =?us-ascii?Q?0uZYfY9V/hGUHE+rayu5fxPXj4B8eXFWN6RItKPAnS3JexqzxXcquA3YRf3A?=
 =?us-ascii?Q?j9GtOcqmONLR20NkKkGKvbY2ghgsA7aFoVPilmLIoojRYq+b2hbVEJ40+HGG?=
 =?us-ascii?Q?AVptz3aVhrM0+TO7dmvtBwUO7GW9ENHvYKu/UCvFioltRv0Fv8yaA8RZeR0D?=
 =?us-ascii?Q?YP45FnEdcyrpXWFoBxkwvnsIyjlMbdfKQfEHbCNWBT8SHXBNbuPK7VWt5wIy?=
 =?us-ascii?Q?yQwT52h9vdd8f9kPt5XXKPUM+afLdWz8cN2yWReSe7zoSnMcNTU9aw813QR/?=
 =?us-ascii?Q?aHwLyxC2DA=3D=3D?=
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d718d4-48b8-4d77-75c3-08decc8a877b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR05MB7880.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 16:07:28.5051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zPeX74dxYj1CPabt6W9uuuN0z2HbwO1AVCNA2GlaNOsib62JmudQJ5MXS3eMTDEu03lPZcpA3fW2jLT2WP82qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR05MB8772
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[polito.it,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[polito.it:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9801-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,linux.ibm.com,gmail.com,huawei.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-integrity@vger.kernel.org,m:zohar@linux.ibm.com,m:dmitry.kasatkin@gmail.com,m:roberto.sassu@huawei.com,m:eric.snowberg@oracle.com,m:enrico.bravi@polito.it,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[enrico.bravi@polito.it,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[polito.it:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enrico.bravi@polito.it,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[polito.it:dkim,polito.it:email,polito.it:mid,polito.it:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A8DB469B5DA

IMA policy can be written multiple times in the securityfs policy file
at runtime if CONFIG_IMA_WRITE_POLICY=y. When IMA_APPRAISE_POLICY is
required, the policy needs to be signed to be loaded, writing the absolute
path of the file containing the new policy:

echo /path/of/custom_ima_policy > /sys/kernel/security/ima/policy

When this is not required, policy can be written directly, rule by rule:

echo -e "measure func=BPRM_CHECK mask=MAY_EXEC\n" \
        "audit func=BPRM_CHECK mask=MAY_EXEC\n" \
     > /sys/kernel/security/ima/policy

In this case, a new policy can be loaded without being measured or
appraised.

Add a new critical data record to measure the textual policy
representation when it becomes effective. Include in the
architecture-specific policy the new critical data record only when it
is not mandatory to load a signed policy. Additionally, enable the
policy serialization code even when CONFIG_IMA_READ_POLICY=n.

To verify the template data hash value, convert the buffer policy data
to binary:
grep "ima_policy_loaded" \
        /sys/kernel/security/integrity/ima/ascii_runtime_measurements | \
        tail -1 | cut -d' ' -f 6 | xxd -r -p | sha256sum

Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>
---
 security/integrity/ima/ima.h        |  3 ++
 security/integrity/ima/ima_efi.c    |  2 +
 security/integrity/ima/ima_fs.c     |  6 ++-
 security/integrity/ima/ima_policy.c | 70 ++++++++++++++++++++++++++++-
 4 files changed, 78 insertions(+), 3 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 69e9bf0b82c6..befa221716e5 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -46,6 +46,8 @@ enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8, TPM_PCR10 = 10 };
 /* current content of the policy */
 extern int ima_policy_flag;
 
+extern struct mutex ima_write_mutex;
+
 /* bitset of digests algorithms allowed in the setxattr hook */
 extern atomic_t ima_setxattr_allowed_hash_algorithms;
 
@@ -452,6 +454,7 @@ void *ima_policy_start(struct seq_file *m, loff_t *pos);
 void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos);
 void ima_policy_stop(struct seq_file *m, void *v);
 int ima_policy_show(struct seq_file *m, void *v);
+void ima_measure_loaded_policy(void);
 
 /* Appraise integrity measurements */
 #define IMA_APPRAISE_ENFORCE	0x01
diff --git a/security/integrity/ima/ima_efi.c b/security/integrity/ima/ima_efi.c
index bca57d836cb9..be7911009454 100644
--- a/security/integrity/ima/ima_efi.c
+++ b/security/integrity/ima/ima_efi.c
@@ -17,6 +17,8 @@ static const char * const sb_arch_rules[] = {
 #endif
 #if IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING) && IS_ENABLED(CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY)
 	"appraise func=POLICY_CHECK appraise_type=imasig",
+#else
+	"measure func=CRITICAL_DATA label=ima_policy",
 #endif
 	"measure func=MODULE_CHECK",
 	NULL
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index ca4931a95098..65e7812c702f 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -24,7 +24,7 @@
 
 #include "ima.h"
 
-static DEFINE_MUTEX(ima_write_mutex);
+DEFINE_MUTEX(ima_write_mutex);
 
 bool ima_canonical_fmt;
 static int __init default_canonical_fmt_setup(char *str)
@@ -478,6 +478,10 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 	}
 
 	ima_update_policy();
+
+	mutex_lock(&ima_write_mutex);
+	ima_measure_loaded_policy();
+	mutex_unlock(&ima_write_mutex);
 #if !defined(CONFIG_IMA_WRITE_POLICY) && !defined(CONFIG_IMA_READ_POLICY)
 	securityfs_remove(file->f_path.dentry);
 #elif defined(CONFIG_IMA_WRITE_POLICY)
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index f7f940a76922..0a70d10da70a 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/rculist.h>
 #include <linux/seq_file.h>
+#include <linux/vmalloc.h>
 #include <linux/ima.h>
 
 #include "ima.h"
@@ -2020,7 +2021,6 @@ const char *const func_tokens[] = {
 	__ima_hooks(__ima_hook_stringify)
 };
 
-#ifdef	CONFIG_IMA_READ_POLICY
 enum {
 	mask_exec = 0, mask_write, mask_read, mask_append
 };
@@ -2322,7 +2322,6 @@ int ima_policy_show(struct seq_file *m, void *v)
 	seq_puts(m, "\n");
 	return 0;
 }
-#endif	/* CONFIG_IMA_READ_POLICY */
 
 #if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
 /*
@@ -2379,3 +2378,70 @@ bool ima_appraise_signature(enum kernel_read_file_id id)
 	return found;
 }
 #endif /* CONFIG_IMA_APPRAISE && CONFIG_INTEGRITY_TRUSTED_KEYRING */
+
+/**
+* ima_measure_loaded_policy - measure the active IMA policy ruleset
+*
+* Must be called with ima_write_mutex held, as it performs two
+* separate RCU read passes over ima_rules and relies on the mutex
+* to prevent concurrent policy updates between them.
+*/
+void ima_measure_loaded_policy(void)
+{
+	const char *event_name = "ima_policy_loaded";
+	const char *op = "measure_loaded_ima_policy";
+	struct ima_rule_entry *rule_entry;
+	struct list_head *ima_rules_tmp;
+	struct seq_file file;
+	int result = -ENOMEM;
+	size_t file_len = 0;
+	char rule[512];
+
+	/* calculate IMA policy rules memory size */
+	file.buf = rule;
+	file.read_pos = 0;
+	file.size = 512;
+	file.count = 0;
+
+	lockdep_assert_held(&ima_write_mutex);
+
+	rcu_read_lock();
+	ima_rules_tmp = rcu_dereference(ima_rules);
+	list_for_each_entry_rcu(rule_entry, ima_rules_tmp, list) {
+		ima_policy_show(&file, rule_entry);
+		if (seq_has_overflowed(&file)) {
+			result = -E2BIG;
+			integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL, event_name,
+					    op, "rule_length", result, 1);
+			return;
+		}
+
+		file_len += file.count;
+		file.count = 0;
+	}
+	rcu_read_unlock();
+
+	/* copy IMA policy rules to a buffer for measuring */
+	file.buf = vmalloc(file_len);
+	if (!file.buf) {
+		integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL, event_name,
+				    op, "ENOMEM", result, 1);
+		return;
+	}
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
+	ima_measure_critical_data("ima_policy", event_name, file.buf,
+				  file.count, false, NULL, 0);
+
+	vfree(file.buf);
+}
-- 
2.52.0


