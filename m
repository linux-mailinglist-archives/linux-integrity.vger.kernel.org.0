Return-Path: <linux-integrity+bounces-9929-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P9XME9+jVGqWogMAu9opvQ
	(envelope-from <linux-integrity+bounces-9929-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Jul 2026 10:37:51 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C74748CB0
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Jul 2026 10:37:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=polito.it header.s=selector1 header.b=cJTBbX6X;
	dmarc=pass (policy=quarantine) header.from=polito.it;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9929-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9929-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B63E93000584
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Jul 2026 08:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703D13A6F10;
	Mon, 13 Jul 2026 08:26:17 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023102.outbound.protection.outlook.com [40.107.159.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A875695
	for <linux-integrity@vger.kernel.org>; Mon, 13 Jul 2026 08:26:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783931177; cv=fail; b=Q9JtzeWL9NmkWeqkcPliudQ+iWoCwWxRagbKLz5DDB4noU/5yTgVSMsOYWrHwe8OIYv6A+K3C6NKWf0EpBjMgNiQmni6Z8ta5hq0Eg0KpQVb0yLw2QK0WvFcweWBz1T7+Vf5wqwTNWTO1vps++cZhKLV5pA58ZA0JxIC+vzjFW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783931177; c=relaxed/simple;
	bh=o3e5XAM2YmLiYdvKNwmCrOpbAtUtFY2N0PGLC8zhNw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jkHolLzOOJ+h4lb7Ah0C0Bm4QTGfbKrLmwhCcloFUSPxJq/Kh1YriXANtEruoYdadTA83HjmEYsukyHFDKmi2HtVc7aqaQ0tSU+eG3RFsnT+jEE2F2K++GQFfP1k9W4vsfJMCV72/UNgr8iBjKdMIAHaaAKhg6yWIBB2eLgN1XY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=cJTBbX6X; arc=fail smtp.client-ip=40.107.159.102
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J0q+wo5wYFc/vqYDSjDA6lZAqtGDhXrSzE1JNNhkY1hF2BfIGgnwGtN/X+6NB9JUDjZq9l42NqohbX45NG6GoRI/fzSiB9jEjCy2neciomtWrldd4DXfCbhiOqqfHUoKyHI9Bz1/yt9IWzum9cWYlXkpVzKXMuuZ/MROQ+WEqdNVm4tc7Bv7c9kA/ydcuaJoJ0S124/ohuCNvtHbll35bQR7yG9PRzifd2O5DAfcszRd4+9/deipCua0HiZXjQWU1g/epiJqSCKeCKCxjtccVYQAs9mOk1tW2j9TZ/nxHV7SJxd8IKC8XL9UOKMdrZ2HY8o0g+qyH04yWifAj3avvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1/4WpnN8T2cgQQ3ZSsotREgZuhJ2oCI6NSH3MrXp6A=;
 b=YFBeaOCaBj2o++liRsn8Yf6VREndRcR+FwfQMZtnKWMc8ovKOoPh/csyP5rINUYqMfWVwW70daj/FBIkB+NyacKyvsb/xlnCqsv008860NxhO8xoGTRvAJs7FlZ/BnUxig5+RLZPUIZv8MciZErzAN00Nq0smBO2h8HyRG37YwpAetKhv55H3rYCHLl+u8aYHCilIIDxGMZwz8wxM75yrcVYmiFy/dBSPiyP1A2bgSYSW1TYCIUjJC/Js966ik3bsYpVvV/L0MeUDYQB3oJ0WJh4FdzFtFmlpKXYm0s6B59dlmR5JZPfzpLS83OqHNSo7zJLBwPYKZwvE0HnbRNs8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1/4WpnN8T2cgQQ3ZSsotREgZuhJ2oCI6NSH3MrXp6A=;
 b=cJTBbX6X3/gTTMsHR71/Ao4X/4occq5A2b1GmX24+Adij3MaFXrrNezkTLKbXPhPWTuPaMAGQGOzVT2z8tFpBmsz4ARUIj2OYZFQ7WAw+HJPlUWOo0T8io+1kyk4wjnbmPE0i44FxVDCHtENSzsrAuDvRJJa+qBHhnK2T333BhQ=
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com (2603:10a6:20b:253::20)
 by PA1PR05MB12078.eurprd05.prod.outlook.com (2603:10a6:102:558::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.23; Mon, 13 Jul
 2026 08:26:10 +0000
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64]) by AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64%5]) with mapi id 15.21.0202.018; Mon, 13 Jul 2026
 08:26:10 +0000
From: Enrico Bravi <enrico.bravi@polito.it>
To: linux-integrity@vger.kernel.org,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	roberto.sassu@huawei.com
Cc: eric.snowberg@oracle.com,
	Enrico Bravi <enrico.bravi@polito.it>
Subject: [PATCH v6 1/2] ima: add critical data measurement for loaded policy
Date: Mon, 13 Jul 2026 10:09:56 +0200
Message-Id: <20260713080954.28520-2-enrico.bravi@polito.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260713080954.28520-1-enrico.bravi@polito.it>
References: <20260713080954.28520-1-enrico.bravi@polito.it>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0012.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::22) To AS8PR05MB7880.eurprd05.prod.outlook.com
 (2603:10a6:20b:253::20)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR05MB7880:EE_|PA1PR05MB12078:EE_
X-MS-Office365-Filtering-Correlation-Id: 12495271-fe93-4d91-0173-08dee0b864dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|786006|366016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	jVJIMR8pn/OBMxeR/WnE/JHX8ZvApASa+PdXhz3f2JzQeWnwfhJa3LAJU2IuWivlgU5+2E6nY5H8xk+UsSYWZKXgqA4DKt8Im0TtBVIrZheWzCOoGUtoa1YNd1yHGBvHmRDCKkGJy0CryJgqI+bH1sauqqXTe24at/85iaS6uYYm7MHUYp32Y/UDgbg5V5k8xTzvFn82DJErKgQ3DxwLGRIW6gQtbZwd56w1pMnXHAaWLiIPvKwNsg9Zsmug6jZomNA29tnyUAWD2kqp+jQboEj4Q1mHhRzG7GA372WogRKTr82yfb4lncZVgyMSj3XVuhMXokIGxko2yRKr72izUiNNjZEJhSu0vGzTVs7scxSNA3sQhL49k5t+QQ4lX+Fsq0Oke/dDJljyeZsjPVRFCBsiqSPmIBEr4RRCOeg+oAqORJeEB1DfrW/xxLq7MelIFAC9Cqiau/YP2GmgUXf7lF5LMvjo7lzCikPXB7BJY/6us/l5HrRUZo3sOOx1ZP8q6KEMlNp1V7OxQUakrxEPCQIJW3Qp9jQGAKLy68M3Puqyy9dD4LgHZX2HjMnDmOgMVZcl+Jz+jIus9Thv2rcrKpH5lw2RxXbELB1qUuXcikzai/xEGMEoKaRCVxraqv6KihgRzQqSdX5HeY9Y1iGHi7kYWgrviu3v2VeDIQQdwBM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR05MB7880.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(786006)(366016)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SKhCeJtaVBZ2F2RMTX54JoPl1EPxiZWtgD0LSJ7kfOtY0KS8W+ZuEWNJghfv?=
 =?us-ascii?Q?HWXgcTWPqAEjHRRjL7WIwfsfrSV8rRu3xH4j3D0dYcmIGmutqO/8FtqoGmj3?=
 =?us-ascii?Q?nK36Hej/HS/3WI9hpNfIIGNGSBO+oRn44nbcVkfyJBjvB70HvsRXkUexlE1E?=
 =?us-ascii?Q?Sjhxs1TN5J59XNNdAlF3Pl0sTN1VDc9i7XuE7qnPi1IvdRZ5pQTajN3aiN5w?=
 =?us-ascii?Q?9yCrrmj4zYTOsIcxNLvmmeP8N9YV7Kh3GwFWDapMz9uoeBhrcGTzJs8sXDm+?=
 =?us-ascii?Q?CKbutLVHfe2oMZVq6lxarOXie6h9wSn8PdwM/LUggFfAjrpACyrg5ERkyySN?=
 =?us-ascii?Q?oqDUlxdRdipv0IJ3+n0n4ckhf0RCJnRFwp5AF5/BY5eYrtP/Wk525NzlTRag?=
 =?us-ascii?Q?uTLmb2uf5uFIw/nh9ONXzDQ3eHp8B59e5fbmkzpnyPDdJfOOhs+8C19+xZ8g?=
 =?us-ascii?Q?grcSRj2BhUaejcFJs/VV7Re8SSqEYlql4H5kgI5aGmu8BP37a851NlaPEkh1?=
 =?us-ascii?Q?Qd7TIs6MaeqiLbb64w2oWHXyAKJDsXVdh0rJjosHvjdw/GJmUX+tcakC53O0?=
 =?us-ascii?Q?cXIEiVzM0m4IuPevjiR2F/G1+IOri1r0B9Mbbza63hwu/Bt/oNUnNWG7dQl/?=
 =?us-ascii?Q?4Bu9Ug2/yiSxo2YsC7b3YLLMfd0nXxGST3juLFQx0ApsmREfv7mhuc/af/40?=
 =?us-ascii?Q?2JKZuwRjRDI3QcqT0+YbdCn4F6io3tig4LVxKjKXeAs3Wh4rPU9V1GKqroHF?=
 =?us-ascii?Q?p5AplzSYx5SOeii5Q+O7UGT/I7CDKPWnI+Cn2HEE7uEZjcSuv/fLRdEV9Rwi?=
 =?us-ascii?Q?s+9ZeoIXI7jmsC+CZvlNTNLu8d5kdBHc5ZOdJY3lkAxVPaCGi8Bz4/L4eTpD?=
 =?us-ascii?Q?31Prtd5PE/FWNQUE3d6vxxFjz8SE6hpcfZ3NUdxtPKPZbQkwmeU/jt/cK9XZ?=
 =?us-ascii?Q?1XrGehN261XJ6DmBIFJUtQ5pli9Q+LHebvl282jBaacz0Z1VuhI8LXDT5uWo?=
 =?us-ascii?Q?Z9iWF/HSzsXqNY4PIYsgsdV6lBSKN1LPuwSoBjoTb3RdQbCNhSL7S5qyNjkM?=
 =?us-ascii?Q?sBtcB1rKeEsB53RPfWOlCmABdGkwcUERkdXSgVCVnDN64BPDYTAENfttflxt?=
 =?us-ascii?Q?WDUh4o7pg2bNAc4k8egcdXCOjnVWZinZD63zePk9y4BCTyrdK3pnVogMe7fz?=
 =?us-ascii?Q?a3ZoP7ndfelfgNdPM2LU2zQ166Otn0mWqUCWHwybTjWBIrehU8mMI29x/LKa?=
 =?us-ascii?Q?mwGkuZNRYXMqyXQav/+tkKa3567rpOEURr0H1PfRz8IgRzsApUfshupqnJcJ?=
 =?us-ascii?Q?KSNLT3sAEkReXraLamrfJ9eLILIpqdGQMSj7fZY6qTzRsYXXTupRG17cmCk0?=
 =?us-ascii?Q?6WZG1e9jrr2u1NBpPg5HqbmwBqWTL/+5fI+AIcellXp3C/XvRcJXo5tw9O19?=
 =?us-ascii?Q?sebAX9f4LEemFTeKNWwCZunYGHQbjDY3joNnPvbGaxHZk5x5s7CRovUlTjYs?=
 =?us-ascii?Q?GtvJYPuaTIIqreCMsZy771GFpde3zd7CnbjbmVHx+iqtS5Nzcknv97d11TT7?=
 =?us-ascii?Q?tw7w4mhpHFxuoz65fvSUXgdYY3kYhfRtZLlcs5jnxHb0Qa1GlS39nS+bLiEW?=
 =?us-ascii?Q?FJDRytMvZmt+ksKkvMACElpxmDQhxOIFHUXgXZf9qSHz8s7EfFgX1ugi0Y8Q?=
 =?us-ascii?Q?7e4CT1t3PAqiX2bd5jBKxhfTApMCtF3A5YIvzzU61E7rwPxdpOFM+ZcccI/f?=
 =?us-ascii?Q?Z9keMptbJQ=3D=3D?=
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 12495271-fe93-4d91-0173-08dee0b864dd
X-MS-Exchange-CrossTenant-AuthSource: AS8PR05MB7880.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 08:26:10.5191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QskmgXu9o7f3UzjZnJduVcvJoNg5u7W5tlDu0+heH7fmrxxdiZbjarwQ3eZgEyuheZFTpxoz7RFJNZhSw82ibQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR05MB12078
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[polito.it,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[polito.it:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9929-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 47C74748CB0

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
 security/integrity/ima/ima.h        |  3 +
 security/integrity/ima/ima_efi.c    |  2 +
 security/integrity/ima/ima_fs.c     |  8 ++-
 security/integrity/ima/ima_policy.c | 89 ++++++++++++++++++++++++++++-
 4 files changed, 99 insertions(+), 3 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index cebaeb620b89..6817ee53ed9e 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -55,6 +55,8 @@ enum binary_lists {
 /* current content of the policy */
 extern int ima_policy_flag;
 
+extern struct mutex ima_write_mutex;
+
 /* bitset of digests algorithms allowed in the setxattr hook */
 extern atomic_t ima_setxattr_allowed_hash_algorithms;
 
@@ -467,6 +469,7 @@ void *ima_policy_start(struct seq_file *m, loff_t *pos);
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
index 174a94740da1..92ca4d62c94d 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -32,7 +32,9 @@
  */
 #define STAGED_REQ_LENGTH 21
 
-static DEFINE_MUTEX(ima_write_mutex);
+/* lock for protecting concurrent IMA policy updates */
+DEFINE_MUTEX(ima_write_mutex);
+
 static DEFINE_MUTEX(ima_measure_mutex);
 static long ima_measure_users;
 static struct task_struct *measure_writer;
@@ -752,6 +754,10 @@ static int ima_release_policy(struct inode *inode, struct file *file)
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
index b1c010e8eb13..a6668329ccb8 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -53,6 +53,8 @@
 #define INVALID_PCR(a) (((a) < 0) || \
 	(a) >= (sizeof_field(struct ima_iint_cache, measured_pcrs) * 8))
 
+static size_t max_rule_len;
+
 int ima_policy_flag;
 static int temp_ima_appraise;
 static int build_ima_appraise __ro_after_init;
@@ -955,6 +957,8 @@ void __init ima_init_policy(void)
 {
 	int build_appraise_entries, arch_entries;
 
+	max_rule_len = 255;
+
 	/* if !ima_policy, we load NO default rules */
 	if (ima_policy)
 		add_rules(dont_measure_rules, ARRAY_SIZE(dont_measure_rules),
@@ -1994,6 +1998,9 @@ ssize_t ima_parse_add_rule(char *rule)
 
 	list_add_tail(&entry->list, &ima_temp_rules);
 
+	if (len > max_rule_len)
+		max_rule_len = len;
+
 	return len;
 }
 
@@ -2021,7 +2028,6 @@ const char *const func_tokens[] = {
 	__ima_hooks(__ima_hook_stringify)
 };
 
-#ifdef	CONFIG_IMA_READ_POLICY
 enum {
 	mask_exec = 0, mask_write, mask_read, mask_append
 };
@@ -2323,7 +2329,6 @@ int ima_policy_show(struct seq_file *m, void *v)
 	seq_puts(m, "\n");
 	return 0;
 }
-#endif	/* CONFIG_IMA_READ_POLICY */
 
 #if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
 /*
@@ -2380,3 +2385,83 @@ bool ima_appraise_signature(enum kernel_read_file_id id)
 	return found;
 }
 #endif /* CONFIG_IMA_APPRAISE && CONFIG_INTEGRITY_TRUSTED_KEYRING */
+
+/**
+ * ima_measure_loaded_policy - measure the active IMA policy ruleset
+ *
+ * Must be called with ima_write_mutex held, as it performs two
+ * separate RCU read passes over ima_rules and relies on the mutex
+ * to prevent concurrent policy updates between them.
+ */
+void ima_measure_loaded_policy(void)
+{
+	const char *event_name = "ima_policy_loaded";
+	const char *op = "measure_loaded_ima_policy";
+	size_t rule_len = max_rule_len + 2;
+	struct ima_rule_entry *rule_entry;
+	struct list_head *ima_rules_tmp;
+	struct seq_file file = { 0 };
+	int result = -ENOMEM;
+	size_t file_len = 0;
+	char *rule;
+
+	lockdep_assert_held(&ima_write_mutex);
+
+	rule = kmalloc(rule_len, GFP_KERNEL);
+	if (!rule) {
+		integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL, event_name,
+				    op, "ENOMEM", result, 0);
+		return;
+	}
+
+	/* calculate IMA policy rules memory size */
+	file.buf = rule;
+	file.read_pos = 0;
+	file.size = rule_len;
+	file.count = 0;
+
+	rcu_read_lock();
+	ima_rules_tmp = rcu_dereference(ima_rules);
+	list_for_each_entry_rcu(rule_entry, ima_rules_tmp, list) {
+		ima_policy_show(&file, rule_entry);
+
+		if (seq_has_overflowed(&file)) {
+			result = -E2BIG;
+			integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL,
+					    event_name, op, "rule_length",
+					    result, 0);
+			rcu_read_unlock();
+			goto free_rule;
+		}
+
+		file_len += file.count;
+		file.count = 0;
+	}
+	rcu_read_unlock();
+
+	/* copy IMA policy rules to a buffer for measuring */
+	file.buf = kmalloc(file_len, GFP_KERNEL);
+	if (!file.buf) {
+		integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL, event_name,
+				    op, "ENOMEM", result, 0);
+		goto free_rule;
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
+	kfree(file.buf);
+free_rule:
+	kfree(rule);
+}
-- 
2.52.0


