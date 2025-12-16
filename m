Return-Path: <linux-integrity+bounces-8076-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AECCCC4937
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 18:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48B353111CB6
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 17:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE28327C0E;
	Tue, 16 Dec 2025 17:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b="EH3LaRQ+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022090.outbound.protection.outlook.com [52.101.66.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8292D877A
	for <linux-integrity@vger.kernel.org>; Tue, 16 Dec 2025 17:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765904481; cv=fail; b=ulX2eAiBUhuYVKK3kohkDh7D4nwmwavE4hMBAkqyLmaV/qg8reB1/c/Ht6tJVkBjVWgldXcJ+QcL+OQvH94vrFxMH4ZQDgF/Ll7dmWNXp4cE5539p0jgZc3xzNgVNsQQZU6K6zHQ3IcjqApGYf9gZNd0ZNncVgr7gnSd36V5wa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765904481; c=relaxed/simple;
	bh=ywNX2jOYoPDcCjtjobm6fvzDxGB9l4Zs57ZUdMMpn8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l/nnn8Cc8uDQ0r19J5gvfjTBo+f5FGw5nYXnIS6GfNfBT1AqEmRPkLTmhu1YeRkUsqWrvhrSkoq42aH91ETbDPCfTiUgW8JyQdz6jquBohpXa29/Wfd46JEniKUR9DRiosGnuAX5U70tbyd/0uG9a4CTYNEbOWkHedRaMUjsAf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=EH3LaRQ+; arc=fail smtp.client-ip=52.101.66.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=polito.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nAg371T8/c1jgSEitgAy00GtBFf6aniiEvML8q72EK0hG+AU7pIm270975WXhLBKPVYd7GAlqYlsNiZw+uHkSA6ZcwZlJ/vuAMC9kNvnt5KJ33xrAdo1+lv3Gp4ccIymq07f7aHphADbk3wwHY9H74ts/hIEIIOo6yEhT17UtXr9JC9RoRxPRXe4t+OP/1VLZgKT27qzKq+YD/IPNKN+efVb0XVnopSLYA5Bii9YgWnQf19sw55RjbnM0V5Bzk2rdhZ2Pjhfr32ujtWB9zdhkxpAEYmqE3YOlYraDIGz/ovLZRv+TlhIf/cnjrlSH/wBV/AjilCqPd/IngBoVcZdlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eIYj/CL5sGFStlTwTKPLvhRhZFosrmn2bNEjujD4xfU=;
 b=fU80+ZMd0Fut+6Tr0nTZ7k7knUOafvglTOdA59GoC4TTkWiNNU5rA5oxSFOTkdn20lFXDNhQWGN+ZC/7KacmbwLMPx5kbHw98+l0Y2BZXcsxtkpzPoh+NqJ7M8dfuV1pk7kZsqInDv5QHxx8HTteVcnGlq9LJYF5inEIidJDAeIHcEUi6CJ9CYfBJ/x8iCjMbYWcx0w/4Boj9jP3b7AjS0dcigeVKjxWF9wa/kKSThmbdViDvX57WoyKWWZP5YAkEa03K0EUgr/r2CA80/e8ulOMAj472nmrFPH9m3YV1t6ycIyT49tKAR72XG8GCASO9dRODhbU9iYTfXO4tM3+Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIYj/CL5sGFStlTwTKPLvhRhZFosrmn2bNEjujD4xfU=;
 b=EH3LaRQ+gghq67G3gmRBC+T2vsGctHaoG0v6BYXIqTojAd3l0g76q9I407aVxxJDOg4Eb3pzY2FUSWDGJmwcHoQfsOnNoV8RljCJctODKj0AB3Eh+Nbd+D/v/F13J6UoYSxTBo6F4EZOXG1ObWhox+hnz8Rq1yPkXNsl2dYiDYc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=polito.it;
Received: from PA4PR05MB7776.eurprd05.prod.outlook.com (2603:10a6:102:d2::9)
 by PA4PR05MB9684.eurprd05.prod.outlook.com (2603:10a6:102:265::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 17:01:14 +0000
Received: from PA4PR05MB7776.eurprd05.prod.outlook.com
 ([fe80::509d:8c36:ae0e:8e4d]) by PA4PR05MB7776.eurprd05.prod.outlook.com
 ([fe80::509d:8c36:ae0e:8e4d%7]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 17:01:14 +0000
From: Enrico Bravi <enrico.bravi@polito.it>
To: linux-integrity@vger.kernel.org,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	roberto.sassu@huawei.com
Cc: eric.snowberg@oracle.com,
	Enrico Bravi <enrico.bravi@polito.it>
Subject: [RFC][PATCH v2 1/2] ima: measure loaded policy after write on securityfs policy file
Date: Tue, 16 Dec 2025 17:56:21 +0100
Message-Id: <20251216165620.683529-2-enrico.bravi@polito.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250225131255.154826-1-enrico.bravi@polito.it>
References: <20250225131255.154826-1-enrico.bravi@polito.it>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR2P264CA0186.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501::25)
 To PA4PR05MB7776.eurprd05.prod.outlook.com (2603:10a6:102:d2::9)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR05MB7776:EE_|PA4PR05MB9684:EE_
X-MS-Office365-Filtering-Correlation-Id: ad61d078-0b86-4b06-c7a3-08de3cc4b8c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qr1N+jR3n5kkJ10Dbu7cknEmlC1I2v198dfUXCspQ14iwh66xh6vVTjTPsMz?=
 =?us-ascii?Q?xx3HJ6iT5oyBUnsizYt69To0D4Aqhclk09TkfiIwYPqhokHq2DKZ1MN8gNVL?=
 =?us-ascii?Q?riW2T+aNIxmugJY5vk3X6nIulbF6lGx4sRYakYrrb6kNgqFpiKhUXsweyGXE?=
 =?us-ascii?Q?aqET18nizikwBNrmmISccQ7XA7A0NhzfOE9CZIUARPRuoq8wuD2cJWEKaNkQ?=
 =?us-ascii?Q?m3Fk56qleUZYlSipzRQNnYLW10O7i6GAOfHc6tXZJDSR91yIMUbwH3PcWqjB?=
 =?us-ascii?Q?Cn7oA1eMwEzkl1lK06URazqqzp7kTjnAup6xQLxQeH7atkUnfESEJjt6lD4v?=
 =?us-ascii?Q?93SSNzggMAxMc2VKZWRhsaFsTCySpgduI+J1pGwjExU0Z58hkXk6OLUpBXPi?=
 =?us-ascii?Q?8WrdxkvwwZNd6hDJfA710p3B7oqc5U0nvdSMwXzRMuzj+rRaVrwCw/n43RvB?=
 =?us-ascii?Q?9uk+8ORQ9/Qrdqc6YtsHM8RUD1G5FY8WExpOACCWDP8mVnGWxhCCtxjPl4NZ?=
 =?us-ascii?Q?+OstcgpQreGcpg++prXQFnpeqeZKliUvRqAf/6HdTLZ4ORrZ3UplSjlVih8K?=
 =?us-ascii?Q?Ve/gW0te/Qqr3rtccuVMHdPwl7+iHc3yAPl1qWssv7BGZPCEC3WQgJ61ab1M?=
 =?us-ascii?Q?luBoX5wO8vsnZryn5Ziw/gAEhc5+3eE/8yppxnF+gKskWF1mZeJq0II1xXBi?=
 =?us-ascii?Q?QPcRdkT91+EcFGcDUhUKRkZqX35U5SGiHDw3bKG4LHaWSrxYD9oLxShWx/jl?=
 =?us-ascii?Q?TGXKQJWFruPcjcQd7JQj3mTyUujeufVtLVFe7VKa/wuj/7n1uu+ZO33dOlqf?=
 =?us-ascii?Q?LUzh9OqMOitans+6H4dEV7lwC9RVN1cL7fkU1YJlk0s7EMKcdhExpfm/Ed39?=
 =?us-ascii?Q?iCNu02Bgu6dHf6Xi5Z/G4iIme7Ykoq5dZF3XFitvygSMaXPnhBEW2XKrLexl?=
 =?us-ascii?Q?RLPD3ruAzwTgsFmnkH5/6WFzvMhGVZIwNhVnFgnZ75JlCjReSGNUzRugDlx6?=
 =?us-ascii?Q?8D91WyM7PBt4LYFJpC0RPlq6JsmSWVi+/cN300sY0hrid0tC9JcIcppaox1U?=
 =?us-ascii?Q?kGqLKIiGYMKk9sjqltJ4bKxQI2lEiY8vEme/9eU7RzkXKnKfUj0T7j7rK5kR?=
 =?us-ascii?Q?sQB1r1HM9zgZnWLOcbQz8zitPuwNi+ZBuObAyZpQ3STwL98VHMYql2OZy/vf?=
 =?us-ascii?Q?2BiT+XzKKpfweZAYIdtNmPz4a4fQTa5YEH7R8Wio+u+F/CTG/OtBQW9aNEyY?=
 =?us-ascii?Q?7tAwklGuHFhu4DqwQQdDeRd38p2kyNI7WPUgaKiEZC3MYU63no7d0FzArAdS?=
 =?us-ascii?Q?9LHxDgcCnD2zg1lV87j3XalgzqJUwWOyADtVU5tZVXL2smUebHuRni/Vv5Gm?=
 =?us-ascii?Q?iEh0MRIzGyp0trfu8ExNMRAUxNHYrs/f02Q7eX12FceCj+anz2Vye/z/XZwP?=
 =?us-ascii?Q?6smbX+8yI/31ZSk6ewxdkohhuS9pORtu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR05MB7776.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?edwgEqwL66DZX12ABV3GYPzEV1oo6MzNeLjSTNeQHEfV0gUeFgSxts/j1C8R?=
 =?us-ascii?Q?1+u74zrKFlPJMoejchfeCCtt+CEtG5mArS95yLXKxUBZgvrFY/YJ3YScenRg?=
 =?us-ascii?Q?SgXfUYmMu/trm4K4v8/XU+14ZVXl7nJnoUG6SZa7na7Y6AwO7nGzEGNMX0wa?=
 =?us-ascii?Q?yMiO87fjJTcndkhzbXHC7eBzV+ZjkXjtJJnI5OjNwS/SOXx4G7AqjqUlTOb1?=
 =?us-ascii?Q?zC6Ospwhfp4YjjkF+NF9jm5AnIvzI46SEEB0eD+sUNDKDZzEn0m75o4/DnDw?=
 =?us-ascii?Q?K2CJkzVlb/1KQqgPcvU/5QuT+0DCcbPW7AZN6aqbh84Bfsne4ssxUmHJqdV0?=
 =?us-ascii?Q?kTsFx2QMyGVdUkUFTWeNGidk0v8JVtU0SrTc91QUz8WBpgY9m9EXgPgy1RUG?=
 =?us-ascii?Q?OmqieiNwHFTJIaQxPTNDFwxc2ShWghuiaynCLjP2xewjvfr7mIIyp14GDhKI?=
 =?us-ascii?Q?lEBjdMgGQtmv3M0zL8KZ8etXlVpc7IJ7XZ0E165LHvsVEQaL905tR0QzM1dS?=
 =?us-ascii?Q?dKQxhJZzABHiHQ/kaeLRoGkK9csz6PZ9bO1dz4Gwu0ZZrq9ongBoKLeyC2AI?=
 =?us-ascii?Q?23rZnpKXoQjFp8Z9aG8xoFlkSLyRwjeDQTBLJ0t5O0mjb/N9xAVEsDIp52fo?=
 =?us-ascii?Q?v7qu73XR3BKOj6Irp4iNSQJ+0Kk5dYM13fBH6LuPozzhwe4rCWmqSjrEf3yy?=
 =?us-ascii?Q?rRD1HQCzJnYRKhE/KRJri1RtAMhf2WKZGXDXxceDRI7dVOTxoEZC1ZnGxL4I?=
 =?us-ascii?Q?PkjOATz2LafNQEM/+BWs0SB5jGXqHRKgxY6e2GX/aGLC4SQnyH56myTpjoA8?=
 =?us-ascii?Q?H3RXoJByru4FPc+4vH6Ok1Yvg+6TZ+7cyQADjwUhATfAHgrsSHVQnjzIhHmh?=
 =?us-ascii?Q?k3NA1JKwI2l7FNq1M5SpFPF8Ox7z6sAB3KqclaHrHBkDzw4c2qyWhe8XQOQ+?=
 =?us-ascii?Q?HOY6zft+kxs8N2kQXEYr6yMcMB5JbUAvBfDwFv+SU+8U3VLMNpE8hTVJhbeQ?=
 =?us-ascii?Q?/HLR3aUbXvmOj2ovZ+zLiW3ou9UTWHOQ/j3hLzW0XGFzV2oLxiFHGvNgWHsN?=
 =?us-ascii?Q?IulNwqMLxHjvmKv77HWKtRL9eeSPklZj/bQOisJFWud8H77TObbFP0sCFdgY?=
 =?us-ascii?Q?ArskKy7nFd+38I45D+HH5B8OK7ZBrbeGZqOLVgOUPjGPQd12S9EePNmlNXUS?=
 =?us-ascii?Q?fNNr+WFC5WZn++MWTOuzU8mKzJU1ndMG65Z0i8ce+BXJRBevAvn0vhrWIpgX?=
 =?us-ascii?Q?8avh5A3+5zORHsgkeVen3tylFl+/uc0lwvVq2HY7l6C9/667QLtom84cu7T4?=
 =?us-ascii?Q?5cdCk8epmyCF4U/S0QHLSVOOQUv89wmojdDE9r3OZ0oRR7sDAQzgvoaNmX5l?=
 =?us-ascii?Q?cVU+JyqOU6IlOfAUNIMk8uk5JsWBaHsZgZlnDBhdgE/5lZbw1eJVeJnIGZWu?=
 =?us-ascii?Q?Sw1wA7t8vdbLg91Ciea4sPHXf416g+tWyCuKHPszVC55uyUrgt+pozXinNfZ?=
 =?us-ascii?Q?Y7xfC6QSpM3GnFNdRHcTPPy9H/G20kMgfTH6sargjoF2jtxKTApOEAqMK+nI?=
 =?us-ascii?Q?fRfLy4NT5pAJ4/e+P0KAdniswIdv69EwktwkE+orooF8tHSdTIi69wx/LKOi?=
 =?us-ascii?Q?xA=3D=3D?=
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-Network-Message-Id: ad61d078-0b86-4b06-c7a3-08de3cc4b8c8
X-MS-Exchange-CrossTenant-AuthSource: PA4PR05MB7776.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 17:01:14.5407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rQ2njJKytzkmZ0l23C52Z2WKL26fQwVsf5CH8liQmQckp+Enc/o/HoKgZ71L1FyXHoBa4ZoqsELMeUY1RX8xWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR05MB9684

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
representation when it becomes effective.

Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>
---
 security/integrity/ima/ima.h        |  1 +
 security/integrity/ima/ima_efi.c    |  1 +
 security/integrity/ima/ima_fs.c     |  1 +
 security/integrity/ima/ima_policy.c | 63 ++++++++++++++++++++++++++++-
 4 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index e3d71d8d56e3..ca7b96663623 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -425,6 +425,7 @@ void *ima_policy_start(struct seq_file *m, loff_t *pos);
 void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos);
 void ima_policy_stop(struct seq_file *m, void *v);
 int ima_policy_show(struct seq_file *m, void *v);
+void ima_measure_loaded_policy(void);
 
 /* Appraise integrity measurements */
 #define IMA_APPRAISE_ENFORCE	0x01
diff --git a/security/integrity/ima/ima_efi.c b/security/integrity/ima/ima_efi.c
index 138029bfcce1..199c42d0f8b3 100644
--- a/security/integrity/ima/ima_efi.c
+++ b/security/integrity/ima/ima_efi.c
@@ -62,6 +62,7 @@ static const char * const sb_arch_rules[] = {
 	"appraise func=POLICY_CHECK appraise_type=imasig",
 #endif
 	"measure func=MODULE_CHECK",
+	"measure func=CRITICAL_DATA label=ima_policy",
 	NULL
 };
 
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 87045b09f120..89946d803d44 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -476,6 +476,7 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 	}
 
 	ima_update_policy();
+	ima_measure_loaded_policy();
 #if !defined(CONFIG_IMA_WRITE_POLICY) && !defined(CONFIG_IMA_READ_POLICY)
 	securityfs_remove(file->f_path.dentry);
 #elif defined(CONFIG_IMA_WRITE_POLICY)
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 128fab897930..956063748008 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/rculist.h>
 #include <linux/seq_file.h>
+#include <linux/vmalloc.h>
 #include <linux/ima.h>
 
 #include "ima.h"
@@ -1983,7 +1984,6 @@ const char *const func_tokens[] = {
 	__ima_hooks(__ima_hook_stringify)
 };
 
-#ifdef	CONFIG_IMA_READ_POLICY
 enum {
 	mask_exec = 0, mask_write, mask_read, mask_append
 };
@@ -2277,7 +2277,6 @@ int ima_policy_show(struct seq_file *m, void *v)
 	seq_puts(m, "\n");
 	return 0;
 }
-#endif	/* CONFIG_IMA_READ_POLICY */
 
 #if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
 /*
@@ -2334,3 +2333,63 @@ bool ima_appraise_signature(enum kernel_read_file_id id)
 	return found;
 }
 #endif /* CONFIG_IMA_APPRAISE && CONFIG_INTEGRITY_TRUSTED_KEYRING */
+
+static size_t ima_policy_text_len(void)
+{
+	struct list_head *ima_rules_tmp;
+	struct ima_rule_entry *entry;
+	struct seq_file file;
+	size_t size = 0;
+	char rule[255];
+
+	file.buf = rule;
+	file.read_pos = 0;
+	file.size = 255;
+	file.count = 0;
+
+	rcu_read_lock();
+	ima_rules_tmp = rcu_dereference(ima_rules);
+	list_for_each_entry_rcu(entry, ima_rules_tmp, list) {
+		ima_policy_show(&file, entry);
+		size += file.count;
+		file.count = 0;
+	}
+	rcu_read_unlock();
+
+	return size;
+}
+
+void ima_measure_loaded_policy(void)
+{
+	const char *event_name = "ima_policy_loaded";
+	const char *op = "measure_loaded_ima_policy";
+	const char *audit_cause = "ENOMEM";
+	struct ima_rule_entry *rule_entry;
+	struct list_head *ima_rules_tmp;
+	struct seq_file file;
+	int result = -ENOMEM;
+	size_t file_len = ima_policy_text_len();
+
+	file.buf = vmalloc(file_len);
+	if (!file.buf) {
+		integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL, event_name,
+				    op, audit_cause, result, 1);
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


