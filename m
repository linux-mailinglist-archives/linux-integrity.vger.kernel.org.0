Return-Path: <linux-integrity+bounces-446-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 331068133AD
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Dec 2023 15:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 527091C2179D
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Dec 2023 14:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712B55B1EA;
	Thu, 14 Dec 2023 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=politoit.onmicrosoft.com header.i=@politoit.onmicrosoft.com header.b="j0vjqX8M"
X-Original-To: linux-integrity@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2113.outbound.protection.outlook.com [40.107.7.113])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119C5131
	for <linux-integrity@vger.kernel.org>; Thu, 14 Dec 2023 06:54:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NsFuXwnCmkLvcfMI2+5hG/al4vm3ITpNg/wAQsjhhIRu6l1Nc0IPUjEc3vUWGRg4ncdNHcKbQEifKUn1Rcyhj8s/eajiSSWMOZsEFdkQKojDwwDrGB0w0ephuk4nX+AnJOemq01gKbDAePmwd6zP8/UuJ3Em99BdVFJDay6zhxVENIlhAdUj1p8D53Vg7HvOPBj7QpsuaQhZRDoT2v1iXpG0oLyqbT0tyjgjQ+qoi8CntDULlfxiqvoc3gLVguf3RcJYo5OOWpkkHc1nKbTFBdcOF3zBoU2qhj137YnI5XlTAfkJLBTRZN1Us+mMvk3A7jKVPyvRCEs3CRXNZAe3WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=raYD6Gm6tMQTJ4b0jpbqg86pfFCUjNWUOeWcRUWqTg4=;
 b=VPb5pj5V39qsCW+XMlG4RL5APHqy9+Hb1mpaqM9Hq6ZzM/KV6xk6IPePaqSQmCyDlB5QdaXTSQkk/G4CSmaILpO7Ie1hnk7jX2cExXE52db7JO12GC4PrQDnIw/MFVhzwSBOh2KE+Q4XlGBMhkXX5FOk2wNk2fFK/5lA2Mi0Pvw6Dawn8YiNIG3wWboq/6pWMQTXP5Xrtom4abqzL27LS1gOe7imWhNYjLBoR+hWWWLYAa8JfU/Wc9JxHV4yRCqqeLeKV1vl7t6bsZYL44QBihFK4K6KlTS6SoZzFaCEw1A8zg2oR5Wdvgng8EL1u+mocYdGBURiQdd4Ik6+qbdT2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=politoit.onmicrosoft.com; s=selector2-politoit-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=raYD6Gm6tMQTJ4b0jpbqg86pfFCUjNWUOeWcRUWqTg4=;
 b=j0vjqX8MqIHRCEcbolAkyOiEsgCZtPVoYbpeYBObbFbwbPFXcYFK0TpZ/fP9ZCn8AvOs2VT26tz43hsvUFftX+C5d511ymtd5fzMetymfP0RaBQda0Fic+FSHWmy+SVsSHQVoRPDXIfGILZixRbJpmg6s+O7KXSDEOPXDuOwgsM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=polito.it;
Received: from AM0PR0502MB3603.eurprd05.prod.outlook.com
 (2603:10a6:208:23::21) by AS1PR05MB9676.eurprd05.prod.outlook.com
 (2603:10a6:20b:47b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 14:54:06 +0000
Received: from AM0PR0502MB3603.eurprd05.prod.outlook.com
 ([fe80::8b05:2cac:f9ea:f12e]) by AM0PR0502MB3603.eurprd05.prod.outlook.com
 ([fe80::8b05:2cac:f9ea:f12e%6]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 14:54:06 +0000
From: Enrico Bravi <enrico.bravi@polito.it>
To: linux-integrity@vger.kernel.org,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com
Cc: Enrico Bravi <enrico.bravi@polito.it>,
	Silvia Sisinni <silvia.sisinni@polito.it>
Subject: [RFC][PATCH] ima: add crypto agility support for template-hash algorithm
Date: Thu, 14 Dec 2023 15:51:53 +0100
Message-Id: <20231214145152.36985-1-enrico.bravi@polito.it>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0037.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::6) To AM0PR0502MB3603.eurprd05.prod.outlook.com
 (2603:10a6:208:23::21)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0502MB3603:EE_|AS1PR05MB9676:EE_
X-MS-Office365-Filtering-Correlation-Id: aeaaf482-4bb4-44fb-e39c-08dbfcb484f8
X-politoEOL-CGPAlias: 1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eR9DX4S3lVDPxJ0kJHp8fKWvuaIBvE1AJkM5wr4xMb4JGH4m74Ayg84SQtkAbfEnd/1vngrQzBHGbBAhQdVNEbMCSDJLBor8OZ1a1Cd12EMiuJ5zq/5U3sOsP4vU3XQ4ZTts9R3LwPGxu5HABHCHY3+Y+9J3912Aj+Ac9hSQ2nTPQXbVNBlMpQ7ltvBTj29y+1FsmXaJr9fhRVZLfLCSiTFfBgll5hxuNncLVRKh08Puk1BNosI2oJFNJyCNPTOOS+7KQPCx9TGEZdW5rIx4WXay0nAr0/QLB1K6+32QnXYDedsttf3lKfwpSpmmSa4lXmMNS5wP5wp1YIeLIW8BSiGcXZtg3R7PCl5lWZh9GZAcI7ukeLPiuetLzdDziMwbsbEhETmcF7P0WBAt4sE7Thr0ewjQftLAByFofLtgLaEL81cQmhTzdUJV9DUafMAzVkorTfkvDEhy4UVreCA3IQ0qHVe26bSJjeGUxeJdgzZMXztL8Onl0PED/WVx69YsImjawVp1eEVo9yowyIM/lgejCnMYbvOeC0h+swS66C9CX8ZSmd1O3YceiL9VMV++fU0gPWuHp5rvJODmFQTWA9X9Be/GE6aFMql9jCzxPWxKwlX9g3vGAdnjuUzmFBnN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0502MB3603.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(38350700005)(36756003)(38100700002)(2906002)(41300700001)(86362001)(83380400001)(6666004)(6512007)(6486002)(478600001)(26005)(1076003)(107886003)(2616005)(54906003)(66476007)(66556008)(316002)(786003)(52116002)(44832011)(6506007)(5660300002)(66946007)(8676002)(8936002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ofBsbrdgOUNfAs2ZsWQbbIVJ1dfmYeXv/6ud8tJdxEadwADnCWqrzkFzmhO3?=
 =?us-ascii?Q?CCku0XtC93h2vcw213FICnbCpbNg7g1Gg5jhcHlGGnPKQ3lXLdOkcDcF3Kq+?=
 =?us-ascii?Q?N7lMlU1SbOdR3vT4mGob5GJE2s2fVbbLnCH8Hl+uwWWWsr25KYWcOnl8ugwv?=
 =?us-ascii?Q?AUw2k63E3vkAy14Eh3HdQ8F6wZaK2ml/kDVFTgG2JbTUHgH6VcMEb7vhv8ge?=
 =?us-ascii?Q?24JZSJgppkzPu1oP42ignw76J7SE4jDpxfanjCc3Jkb8vGOlu64f0wSk5EyP?=
 =?us-ascii?Q?2ttwAVwRcgFAH4tJcM08E7GH7tvECFKssCr0GJLjaW+NRzqhUz85Z3a78BRw?=
 =?us-ascii?Q?5ypTNltz44VxmNwd6mCAYaFJBGlwZzLMiisg+NoWZaVkM0bWOWsVoSh36kTa?=
 =?us-ascii?Q?0lB/p/xs+CnWL9qEE9WJN9nhI1KMWUDXNEWS/tZ/SEzubVOIH0a9Lz2hc9HU?=
 =?us-ascii?Q?iJkS6saw7apas0wMvuRqnhU1XUxR07py09yoykMhnO/1PlrsKdaEbXVSPgHn?=
 =?us-ascii?Q?cJHQUROzgmxhGyrnydHfFGtSMhfYuHJvypoARCBLSTme4seAshomEqlCYVwx?=
 =?us-ascii?Q?1On4MIKs8kHFq5e3EE3oV0YaGWOV75rHBMLqoNt1tnEr5dBW+usAUX8d+fKd?=
 =?us-ascii?Q?itJrGCuDWnH8i/+H5KZIYBKrCVHGfwZvowR7lxkZzPwp0v7ftGtzBJlBXS42?=
 =?us-ascii?Q?oCWw5VIpfQAgHcThZC3uAGlgTAz85cGrKlnhVTcZxb2aMV6bSySZxqUV9nQI?=
 =?us-ascii?Q?wBlHbER3X+8JggKPmD7jC+N7ZIIBbGMU8wmL26zHScn9FAyLSqgjkHb1KVM/?=
 =?us-ascii?Q?lz0J4nr4XBbikd/96MkIX1gbUyary88aQhgqlfl9AlTyH6W3UcxWlmsBvYLa?=
 =?us-ascii?Q?M3xclLCRkBN06NLDfvTiYieYCJ49iVuIE+VbHfQbnjI5dpJhliD5/Y/8o/HX?=
 =?us-ascii?Q?885JLEj+bHzhj6duOj/USxzEECm0wg4SBAn+572T7EdgLwMLvWIedJNXfqA2?=
 =?us-ascii?Q?UuaKB8KL1OkjKsoo2KvvVRSF5xcY9SRAqVXE2OI0Z0WIfTa/UYu1LZFyyu0D?=
 =?us-ascii?Q?Eyny+N6TNpgsDU0eVVOLljxA+lVY2LlA88GA0dCe6OkSq60ZYd4b5pZ6ggF3?=
 =?us-ascii?Q?85e2yxJHoG35RAyZGcC2YFgKZO1Yso3eS8hDTgHfaIbnKtwxSUxrmSC4olMi?=
 =?us-ascii?Q?ICwbN4d5grnQ1TFovW2J0xA+zxmr+IynLlSbIhznBlMi7gMCTUiXUQ5VzS86?=
 =?us-ascii?Q?TAdODCfEi8fOaA3jvh693PEJuaL5Scm5A69TE7nEMjIneQY0OocFt5Iz5KVy?=
 =?us-ascii?Q?BBrpYVRTTHocIYGzDGipXy8tOvMx6oM0fme3i6iWgcGRa3y5qwNBFoyKjBOU?=
 =?us-ascii?Q?0b4rHNW+3CZNrFv8q+IziRJjTlTbDh+1JMc6nROxPWigHUR7NSMSY4Ei1C3d?=
 =?us-ascii?Q?/IJGXauxa+qW0LfsSu8/cAQHkG5Zu3RWnivicFjRMNyh1LzIPk7NyobUZlzS?=
 =?us-ascii?Q?ArlUKUq4tUm6eSHkcvEAXONg4AJRbIjHFT+EaySdjOCAT6Z0rT/3Ql/U9w/L?=
 =?us-ascii?Q?vlTUzG8+6ZGvYXl4EutR20aV/z0qvAoEy5D0Fo9D81exdXVfagd5Zqw1nZtN?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-Network-Message-Id: aeaaf482-4bb4-44fb-e39c-08dbfcb484f8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0502MB3603.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 14:54:05.9535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IlVJyWMEM4x/bP4oGzsQDz/VfeWbM34w9LfYAN8Xu5kfNbMv7tbFYN9i88P8RPcmRUs08yogyl9jDXNz5Y273A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR05MB9676

The purpose of this patch is to add the possibility to configure the hash
algorithm to use when calculating the template-hash.
The ima_template_hash command line parameter has been introduced to enable
this configuration.
The entry will contain the hash_algo_name before the actual template-hash,
separated by a colon (:).
An example of the resulting ima log is the following:

10 sha256:64326[...]25313 ima-ng sha1:5fc9b[...]974e6 boot_aggregate
10 sha256:afd64[...]e3123 ima-ng sha1:5a493[...]f9566 /init
10 sha256:99329[...]a6353 ima-ng sha1:8c87d[...]3d8c7 /usr/bin/sh
10 sha256:a16ad[...]2ac0e ima-ng sha1:59d4b[...]330b0 /etc/ld.so.cache

This patch has been created starting from the master branch of the main tree:
<git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git>

Signed-off-by: Silvia Sisinni <silvia.sisinni@polito.it>
Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>
---
 security/integrity/ima/Kconfig      | 30 +++++++++++++++++++++++++++
 security/integrity/ima/ima.h        |  2 ++
 security/integrity/ima/ima_crypto.c | 26 ++++++++++++++++++++++-
 security/integrity/ima/ima_fs.c     | 25 ++++++++++++++--------
 security/integrity/ima/ima_main.c   | 32 +++++++++++++++++++++++++++++
 5 files changed, 105 insertions(+), 10 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index a6bd817efc1a..9cdeedb2be53 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -121,6 +121,36 @@ config IMA_DEFAULT_HASH
 	default "wp512" if IMA_DEFAULT_HASH_WP512
 	default "sm3" if IMA_DEFAULT_HASH_SM3
 
+choice
+	prompt "Default template-hash algorithm"
+	default IMA_DEFAULT_TEMPLATE_HASH_SHA1
+	depends on IMA
+	help
+	   Select the default template-hash algorithm written in Measurement
+	   Log entries. The compiled default template-hash algorithm can
+	   be overwritten using the kernel command line 'ima_template_hash='
+	   option.
+
+	config IMA_DEFAULT_TEMPLATE_HASH_SHA1
+		bool "SHA1 (default)"
+		depends on CRYPTO_SHA1=y
+
+	config IMA_DEFAULT_TEMPLATE_HASH_SHA256
+		bool "SHA256"
+		depends on CRYPTO_SHA256=y
+
+	config IMA_DEFAULT_TEMPLATE_HASH_SHA512
+		bool "SHA512"
+		depends on CRYPTO_SHA512=y
+endchoice
+
+config IMA_DEFAULT_TEMPLATE_HASH
+	string
+	depends on IMA
+	default "sha1" if IMA_DEFAULT_TEMPLATE_HASH_SHA1
+	default "sha256" if IMA_DEFAULT_TEMPLATE_HASH_SHA256
+	default "sha512" if IMA_DEFAULT_TEMPLATE_HASH_SHA512
+
 config IMA_WRITE_POLICY
 	bool "Enable multiple writes to the IMA policy"
 	default n
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index c29db699c996..a19375b9a6e4 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -55,6 +55,8 @@ extern int ima_sha1_idx __ro_after_init;
 extern int ima_hash_algo_idx __ro_after_init;
 extern int ima_extra_slots __ro_after_init;
 extern int ima_appraise;
+extern int ima_template_hash_algo __ro_after_init;
+extern int ima_template_hash_algo_idx __ro_after_init;
 extern struct tpm_chip *ima_tpm_chip;
 extern const char boot_aggregate_name[];
 
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 51ad29940f05..448b55ed5033 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -64,6 +64,7 @@ struct ima_algo_desc {
 
 int ima_sha1_idx __ro_after_init;
 int ima_hash_algo_idx __ro_after_init;
+int ima_template_hash_algo_idx __ro_after_init;
 /*
  * Additional number of slots reserved, as needed, for SHA1
  * and IMA default algo.
@@ -124,6 +125,7 @@ int __init ima_init_crypto(void)
 
 	ima_sha1_idx = -1;
 	ima_hash_algo_idx = -1;
+	ima_template_hash_algo_idx = -1;
 
 	for (i = 0; i < NR_BANKS(ima_tpm_chip); i++) {
 		algo = ima_tpm_chip->allocated_banks[i].crypto_id;
@@ -132,16 +134,28 @@ int __init ima_init_crypto(void)
 
 		if (algo == ima_hash_algo)
 			ima_hash_algo_idx = i;
+
+		if (algo == ima_template_hash_algo)
+			ima_template_hash_algo_idx = i;
 	}
 
 	if (ima_sha1_idx < 0) {
 		ima_sha1_idx = NR_BANKS(ima_tpm_chip) + ima_extra_slots++;
 		if (ima_hash_algo == HASH_ALGO_SHA1)
 			ima_hash_algo_idx = ima_sha1_idx;
+
+		if (ima_template_hash_algo == HASH_ALGO_SHA1)
+			ima_template_hash_algo_idx = ima_sha1_idx;
 	}
 
-	if (ima_hash_algo_idx < 0)
+	if (ima_hash_algo_idx < 0) {
 		ima_hash_algo_idx = NR_BANKS(ima_tpm_chip) + ima_extra_slots++;
+		if (ima_template_hash_algo == ima_hash_algo)
+			ima_template_hash_algo_idx = ima_hash_algo_idx;
+	}
+
+	if (ima_template_hash_algo_idx < 0)
+		ima_template_hash_algo_idx = NR_BANKS(ima_tpm_chip) + ima_extra_slots++;
 
 	ima_algo_array = kcalloc(NR_BANKS(ima_tpm_chip) + ima_extra_slots,
 				 sizeof(*ima_algo_array), GFP_KERNEL);
@@ -196,6 +210,16 @@ int __init ima_init_crypto(void)
 		ima_algo_array[ima_hash_algo_idx].algo = ima_hash_algo;
 	}
 
+	if (ima_template_hash_algo_idx >= NR_BANKS(ima_tpm_chip) &&
+		ima_template_hash_algo_idx != ima_sha1_idx &&
+		ima_template_hash_algo_idx != ima_hash_algo_idx) {
+		ima_algo_array[ima_template_hash_algo_idx].tfm = ima_alloc_tfm(ima_template_hash_algo);
+		if (IS_ERR(ima_algo_array[ima_template_hash_algo_idx].tfm)) {
+			rc = PTR_ERR(ima_algo_array[ima_template_hash_algo_idx].tfm);
+			goto out_array;
+		}
+	}
+
 	return 0;
 out_array:
 	for (i = 0; i < NR_BANKS(ima_tpm_chip) + ima_extra_slots; i++) {
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index cd1683dad3bf..5545602a6144 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -21,6 +21,7 @@
 #include <linux/rcupdate.h>
 #include <linux/parser.h>
 #include <linux/vmalloc.h>
+#include <crypto/hash_info.h>
 
 #include "ima.h"
 
@@ -130,7 +131,7 @@ int ima_measurements_show(struct seq_file *m, void *v)
 	struct ima_queue_entry *qe = v;
 	struct ima_template_entry *e;
 	char *template_name;
-	u32 pcr, namelen, template_data_len; /* temporary fields */
+	u32 pcr, namelen, template_hash_len, template_data_len; /* temporary fields */
 	bool is_ima_template = false;
 	int i;
 
@@ -150,18 +151,23 @@ int ima_measurements_show(struct seq_file *m, void *v)
 	pcr = !ima_canonical_fmt ? e->pcr : (__force u32)cpu_to_le32(e->pcr);
 	ima_putc(m, &pcr, sizeof(e->pcr));
 
-	/* 2nd: template digest */
-	ima_putc(m, e->digests[ima_sha1_idx].digest, TPM_DIGEST_SIZE);
+	/* 2nd: template digest size */
+	template_hash_len = !ima_canonical_fmt ? hash_digest_size[ima_template_hash_algo] :
+		(__force u32)cpu_to_le32(hash_digest_size[ima_template_hash_algo]);
+	ima_putc(m, &template_hash_len, sizeof(template_hash_len));
 
-	/* 3rd: template name size */
+	/* 3rd: template digest */
+	ima_putc(m, e->digests[ima_template_hash_algo_idx].digest, hash_digest_size[ima_template_hash_algo]);
+
+	/* 4th: template name size */
 	namelen = !ima_canonical_fmt ? strlen(template_name) :
 		(__force u32)cpu_to_le32(strlen(template_name));
 	ima_putc(m, &namelen, sizeof(namelen));
 
-	/* 4th:  template name */
+	/* 5th:  template name */
 	ima_putc(m, template_name, strlen(template_name));
 
-	/* 5th:  template length (except for 'ima' template) */
+	/* 6th:  template length (except for 'ima' template) */
 	if (strcmp(template_name, IMA_TEMPLATE_IMA_NAME) == 0)
 		is_ima_template = true;
 
@@ -171,7 +177,7 @@ int ima_measurements_show(struct seq_file *m, void *v)
 		ima_putc(m, &template_data_len, sizeof(e->template_data_len));
 	}
 
-	/* 6th:  template specific data */
+	/* 7th:  template specific data */
 	for (i = 0; i < e->template_desc->num_fields; i++) {
 		enum ima_show_type show = IMA_SHOW_BINARY;
 		const struct ima_template_field *field =
@@ -233,8 +239,9 @@ static int ima_ascii_measurements_show(struct seq_file *m, void *v)
 	/* 1st: PCR used (config option) */
 	seq_printf(m, "%2d ", e->pcr);
 
-	/* 2nd: SHA1 template hash */
-	ima_print_digest(m, e->digests[ima_sha1_idx].digest, TPM_DIGEST_SIZE);
+	/* 2nd: template hash (hash_algo_name:digest)*/
+	seq_printf(m, "%s:", hash_algo_name[ima_template_hash_algo]);
+	ima_print_digest(m, e->digests[ima_template_hash_algo_idx].digest, hash_digest_size[ima_template_hash_algo]);
 
 	/* 3th:  template name */
 	seq_printf(m, " %s", template_name);
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index cc1217ac2c6f..fa31ecb66606 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -36,7 +36,9 @@ int ima_appraise;
 #endif
 
 int __ro_after_init ima_hash_algo = HASH_ALGO_SHA1;
+int __ro_after_init ima_template_hash_algo = HASH_ALGO_SHA1;
 static int hash_setup_done;
+static int template_hash_setup_done;
 
 static struct notifier_block ima_lsm_policy_notifier = {
 	.notifier_call = ima_lsm_policy_change,
@@ -76,6 +78,26 @@ static int __init hash_setup(char *str)
 }
 __setup("ima_hash=", hash_setup);
 
+static int __init template_hash_setup(char *str)
+{
+	int i;
+
+	if (template_hash_setup_done)
+		return 1;
+
+	i = match_string(hash_algo_name, HASH_ALGO__LAST, str);
+	if (i < 0) {
+		pr_err("invalid template-hash algorithm \"%s\"", str);
+		return 1;
+	}
+
+	ima_template_hash_algo = i;
+
+	template_hash_setup_done = 1;
+	return 1;
+}
+__setup("ima_template_hash=", template_hash_setup);
+
 enum hash_algo ima_get_current_hash_algo(void)
 {
 	return ima_hash_algo;
@@ -1096,6 +1118,7 @@ static int __init init_ima(void)
 	ima_appraise_parse_cmdline();
 	ima_init_template_list();
 	hash_setup(CONFIG_IMA_DEFAULT_HASH);
+	template_hash_setup(CONFIG_IMA_DEFAULT_TEMPLATE_HASH);
 	error = ima_init();
 
 	if (error && strcmp(hash_algo_name[ima_hash_algo],
@@ -1107,6 +1130,15 @@ static int __init init_ima(void)
 		error = ima_init();
 	}
 
+	if (error && strcmp(hash_algo_name[ima_template_hash_algo],
+			    CONFIG_IMA_DEFAULT_TEMPLATE_HASH) != 0) {
+		pr_info("Allocating %s failed, going to use default template-hash algorithm %s\n",
+			hash_algo_name[ima_template_hash_algo], CONFIG_IMA_DEFAULT_TEMPLATE_HASH);
+		template_hash_setup_done = 0;
+		template_hash_setup(CONFIG_IMA_DEFAULT_TEMPLATE_HASH);
+		error = ima_init();
+	}
+
 	if (error)
 		return error;

base-commit: 88035e5694a86a7167d490bb95e9df97a9bb162b 
-- 
2.34.1


