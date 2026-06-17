Return-Path: <linux-integrity+bounces-9802-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aUrkB5vGMmqQ5QUAu9opvQ
	(envelope-from <linux-integrity+bounces-9802-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jun 2026 18:08:59 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C5269B44F
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jun 2026 18:08:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=polito.it header.s=selector1 header.b="QMo/zh4p";
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9802-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9802-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=polito.it;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1117E30095FC
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jun 2026 16:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0AB4968F2;
	Wed, 17 Jun 2026 16:08:26 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021085.outbound.protection.outlook.com [52.101.65.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11C548B36D
	for <linux-integrity@vger.kernel.org>; Wed, 17 Jun 2026 16:08:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781712506; cv=fail; b=gWwcKkt4263SD/Cim/OFlBB3Dx3F6eOc7B8qT+95axwzaCuNADwg49LwDVtFP3wk41QMZ5INpldS72wV4zMkVZA2HHsWARWGl+PesDw6r0MxR49AdrXxIH+Rc1rnnH7cSZepKlDPJ1pYKyUiI9+0wehbKvGz7AQFGWZ+brPXloo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781712506; c=relaxed/simple;
	bh=YTFKwYyD59rkFu2plwBPbzxZd6nvzYzY9u3vzVklmns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SkiOF8dEXnWypmCvyWIpTmvmxRL5oVaUu30U5SBXHMOmXLkchrI2xMNvTjp4QMkQzJ65vdOc8gQCtkvaqvgys9x1lrYt7w1JJeHgfoHOsOYgtOk2IMNhUyr2yQhUYl56ztsfPSMLVp1ZkWqOePgrc2mHfYMnw29GRLE/iU8eKYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=QMo/zh4p; arc=fail smtp.client-ip=52.101.65.85
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQvUBiUo4lJyKbPWYW+vkPHXBDsZllKkkziRqYO8wQpcVFv5xRHp7FgL5w7bM8Lk5Mw50O5dAomqRzXcIgY9B6iUsxiTIy8FuAbi92rZzSQIco5WXKkSgFna6WWW+eKYTg0ojOh4KTp2IsqzfpzXejXzHCTE7HXTgGBsp0V4ePIJVB0bQu4ETcc+xnM6RLz7mB0NywIjqzMHNJ71Qx5IH7K2OhNUWesbA5OF9eisNB77OK2RYzXHk/MnWiZtIpiBQazBQRvAuZ4c58wlcsEHat3uoWIisSP9Qg9XX+Uk+Dkjl+uiTwvw5lxZ/+nBHlutNpOMHIdRgrOqWr1ERdHv5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4ihFxEH3NF/j/0FerA5fx1UfAljrBE2hwEO21XR84w=;
 b=Ckv5UMfBqd6i/Tvd4AhiigRX6MRLgVvcrLao3NIGrKy8jc+J/gNt/33Xily0Ko0K5/8SGYAPXlYZv+eRYWRrhUrjWpm5wzHikN3jnoQOmaqZpe22sGsRioLzZBu7pSXXzgaNpflk1Hu7JGaMxM3ljdgwdPqkSLm7PL13/y7LgD2kZzcRjON7KuWMKvp8t5BnIFBX67M2rginwzirDM6srJ+yT30cEAp9mgiamou9e7bFciZc5vgZYdlRzw5TBzB+hc8pSTLIWRw0lKnZ67imsJmTHFhFn4QVsyixfadJXmEn9EX0bekYl4R6crGx7HJX1dHxi3ZaR62QmyRwDA9t+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4ihFxEH3NF/j/0FerA5fx1UfAljrBE2hwEO21XR84w=;
 b=QMo/zh4pnPj9WP0SAZLQH/W7boFm77N39dgE1Omjx2lA1SuCOsYMZxKOQE8y6bM1RImlEY/Vc4M3S7gRVjNg4QUS9uD58a+ghLhfFHNLZE5cAPoBbL4UBxAzX6tsHF4ES8QIHorv5wf/JCPc7OOHSPlU8j16D7UX0eb0sdOoqpc=
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com (2603:10a6:20b:253::20)
 by DB9PR05MB8219.eurprd05.prod.outlook.com (2603:10a6:10:23f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 16:08:09 +0000
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64]) by AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 16:08:09 +0000
From: Enrico Bravi <enrico.bravi@polito.it>
To: linux-integrity@vger.kernel.org,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	roberto.sassu@huawei.com
Cc: eric.snowberg@oracle.com,
	Enrico Bravi <enrico.bravi@polito.it>
Subject: [PATCH v4 2/2] ima: measure buffer sent to securityfs policy file
Date: Wed, 17 Jun 2026 17:58:35 +0200
Message-Id: <20260617155832.434517-3-enrico.bravi@polito.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260617155832.434517-1-enrico.bravi@polito.it>
References: <20260617155832.434517-1-enrico.bravi@polito.it>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1PEPF000008D0.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::42d) To AS8PR05MB7880.eurprd05.prod.outlook.com
 (2603:10a6:20b:253::20)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR05MB7880:EE_|DB9PR05MB8219:EE_
X-MS-Office365-Filtering-Correlation-Id: cd512134-5b89-4b99-cc34-08decc8aa00e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|786006|376014|23010399003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	tI1rVfiUeMQuGK0AnY68j9rPUCdgcVkIG6+8St898yB+wiUP3W9x2OODeB3aBwxYSEZ/QsV/+3M5qPegP3CQ1JmHZFVnVmH0HysaQgkBDNeAAEUAE2BnWsrKAnl7vj0QLmSKE4t9Z5AGe6XEQ3lYa+iVRY2Q52Mta5cXQZcEwc1Nx970Gp4j592rJslpZ2w+SSzMMOw+1OoTLG5kCW28uRrWnfdsx5GNiCfeQHpC3FfP69ZDkwr16egxm4Z8hbF2LFIWO7fmDBmM1xD8cBBsnx5GDJ7T6yE31numB9as6hI62nndBiqudP059Wz+vO8pFAugWXxunjGay+cfItt/9AukAE3SS+kcun+lAAClkYcwlUkoj5YbOYOnLy70uYBOfkmz8nNXXvxwZHMXo16pWUB0X+gYwJ3OWwLgYUrvwllKkRpjY0Ec6tectlRyaFLD8RGIJyptqrOuETBAnrdV51AS9huGsatR8fspUBJsj1vW19UbhTB9bJgLkgE9j+sm0PJ1u9BdAz8tOEVXGExnV4djc7gCfKXu77AyHyZPaBNZq79C9K/SHA6XllIR3spfHytCjRcEzCEXnmFkm+EV29PmZGZ2iJ36Zc1WHMLCUh5OgLYI2P4NAq1bxNFyxwiMFIZRaAhzwoxL0/xAyyHf7D85bZxi2CVsBCr0lvseNAsuN5a75q+S0dshtyMIpejx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR05MB7880.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(786006)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vUWXaGelhBMj7XFCvk6DhK7dZE+PVYuMfZapIhmEA+/DE9DxTT2e4VK40eEQ?=
 =?us-ascii?Q?mQqalt3O4DwFOZoiUwx5TrqOQrTWCkNvsEM6RQi2xgpmr7VzZdlQ/pgeppmt?=
 =?us-ascii?Q?3X8Pya7K/v8NKOfQnWtEoL9buFlpTuQpyn8j+bDoS/L3/xRaBqOkhD+8FrBd?=
 =?us-ascii?Q?TA0+FNaS+cc2g2FzvCwOjSeMf1dAvpm6KD2pzsvyONq0ue17aPKqWfssUcne?=
 =?us-ascii?Q?snlxSpvKW84QJQJ2mduRtS8HTuiaZ5BtiLsJT8RmajXS+4a7/uYVp52WuMUD?=
 =?us-ascii?Q?ZSBz0F9xQ7YTlGuiOQVG29+XHg2wi0QH8UW4FhpOGSLSBdiyxIqsCm5NbF5Q?=
 =?us-ascii?Q?ZfXQLikZT9qjrtb4UcYlTAIk8fdO/83Bjaly7tND56SCB92RbicdYrxSl/Vd?=
 =?us-ascii?Q?51CHVtyomUUGaO8hmHSlJF1W88vLJEJWmjQEDy7vy87ZObCeNmpyVcEyWehG?=
 =?us-ascii?Q?XwbojjY2QTOjJ8A5AzuDPGVsslffAopB1E+H04gnG0kenhGjpyCRXuvSfW0J?=
 =?us-ascii?Q?BVA1NbmY7uEJOAXLyuGksaOEXudNSDrwsHGn6QbgI6B3HOOMCwEKX46PtLh0?=
 =?us-ascii?Q?Dq3kDkOMk1OCRRin2UKDwCwhB706KB5HaY2WaWnNg99Z7xopMYTSHC2yh4vB?=
 =?us-ascii?Q?865ac9F5cfCjAZNBP4gbH+E8sLe1EhJUX3ZSRysHsKg8jTMC+7wgh7Mk74OR?=
 =?us-ascii?Q?etpYBvJX54sYnzlkNOC5Eg/v2rbum84ZaFEaMvBnQBiw6DOqey7oU+yCnDJd?=
 =?us-ascii?Q?sHmP4MRTjPfZxOpwEMkW9djwTViKOcSzaXGJQy5ItGIWywQfm174YH29ivR1?=
 =?us-ascii?Q?Su9i58FCyB5+RzZy1eK9LkH4B/545Dnl1ZpoizVKNhu+aTkyYcP3N/Y8uLgD?=
 =?us-ascii?Q?0Fw0EWxoI5mNutHp+rbLpNMOTBI0mVbiY6XHqhk1NGfZavOEUm8/m/PlyrVi?=
 =?us-ascii?Q?c/m8OYoXfk3fZymQscbaxEVj7V8obfoVKQkXnr8FXjeSMog1I0Po65t0hcSJ?=
 =?us-ascii?Q?pG1+cZgWzsezCJP5a/HggXSz5phzglfuoDbFjlSpdGtxjOyxL2ywsU9lINik?=
 =?us-ascii?Q?QVv1YccUYCSzvW0rKTa8Z0HpdccA65qoRL6ESkpKXD0AUDLJCtmcT1vFXXQZ?=
 =?us-ascii?Q?J3tI1hBA48NCzCoGF7FoX2VrvOs6KQfCic+RDWP4TKpUOTseMqYojiWhmrRW?=
 =?us-ascii?Q?lajp4lIRId2FxbZ8iqCWRleWdrZI9j1R6DJtlKb3EruEqunY7uEyBMCF+mkL?=
 =?us-ascii?Q?NCRNSfS7Y1Hi5X4zv9dfoqs71/JJXPIZ7ynTUpQobyv6iGi7VR17utonxWTP?=
 =?us-ascii?Q?FBTimlURI8llnEV8kQV6YxUG97zEgHI5m7S5QHGVR98c2lG31UGTwn0Xn4Hv?=
 =?us-ascii?Q?99RzDsxaw2AHRY7KfJJuylH95sa+nG7hQRWwyiE6CNOI2qK6++hngc4jaIPq?=
 =?us-ascii?Q?CoqJly6ObJtN0AbA6sfCH5S6Qzw3Lym0LXtTM+Qlmdnk0F1R8sZpddxtoGnk?=
 =?us-ascii?Q?JYsLLf9zCXBiGthHNPFfnbrHZPLmlVe4inejOPttZxL55oAVVBhTlI2eUNo0?=
 =?us-ascii?Q?w2ccXC1MFKULheHpFg38qujiXtczkVudfD/2fMv/r5i3fiSRTD5Qp6Ldc75h?=
 =?us-ascii?Q?sGFNN0s0aZLNFvwSoS8e3c8YOAmEmKhyRkDyCc/En4pfabAdjffERPQh1XY9?=
 =?us-ascii?Q?da+jI0EefmOPZh/KfpzSE70+u2TTovvezfm/PPZpQqlgoceRvq46Mh6mKJDd?=
 =?us-ascii?Q?6KGgy66iag=3D=3D?=
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-Network-Message-Id: cd512134-5b89-4b99-cc34-08decc8aa00e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR05MB7880.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 16:08:09.6854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oEgVB4pTky/3UzfdaQj2JkEMDhfzSHrHGuFERdPuX0VvsEiouG4Tnl3xmormXf9ZUIcG5eojY1zKJSi5tmrCeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR05MB8219
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
	TAGGED_FROM(0.00)[bounces-9802-lists,linux-integrity=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,huawei.com:email,polito.it:dkim,polito.it:email,polito.it:mid,polito.it:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 32C5269B44F

When a signed policy is not mandatory, it is possible to write the IMA
policy directly on the corresponding securityfs file:

echo -e "measure func=BPRM_CHECK mask=MAY_EXEC\n" \
        "audit func=BPRM_CHECK mask=MAY_EXEC\n" \
     > /sys/kernel/security/ima/policy

or by cat'ing the entire IMA custom policy file:

cat ima-policy-file > /sys/kernel/security/ima/policy

Add input buffer measurement, regardless of whether the new policy
will be accepted or not, that can be caught when
'measure func=POLICY_CHECK' is enabled (e.g., ima_policy=tcb). The
measurement template is forced to ima-buf.
This follows the "measure & load" paradigm, exposing potential bugs in
the policy code and detecting attempts to corrupt IMA. It also completes
the POLICY_CHECK hook, which already measures partial policy load by file.

To verify the template data hash value, convert the buffer policy data
to binary:
grep "ima_policy_written" \
	/sys/kernel/security/integrity/ima/ascii_runtime_measurements | \
	tail -1 | cut -d' ' -f 6 | xxd -r -p | sha256sum

Suggested-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>
---
 security/integrity/ima/ima.h        |  1 +
 security/integrity/ima/ima_fs.c     |  1 +
 security/integrity/ima/ima_main.c   | 19 +++++++++++++++++++
 security/integrity/ima/ima_policy.c |  3 +++
 4 files changed, 24 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index befa221716e5..d477fc06821f 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -455,6 +455,7 @@ void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos);
 void ima_policy_stop(struct seq_file *m, void *v);
 int ima_policy_show(struct seq_file *m, void *v);
 void ima_measure_loaded_policy(void);
+int ima_measure_policy_buf(const char *buf, size_t buf_len);
 
 /* Appraise integrity measurements */
 #define IMA_APPRAISE_ENFORCE	0x01
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 65e7812c702f..a277c9135944 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -356,6 +356,7 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 				    1, 0);
 		result = -EACCES;
 	} else {
+		ima_measure_policy_buf(data, datalen);
 		result = ima_parse_add_rule(data);
 	}
 	mutex_unlock(&ima_write_mutex);
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 5cea53fc36df..599495304712 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1221,6 +1221,25 @@ int ima_measure_critical_data(const char *event_label,
 }
 EXPORT_SYMBOL_GPL(ima_measure_critical_data);
 
+/**
+ * ima_measure_policy_buf - Measure the policy write buffer
+ * @buf: pointer to the buffer containing the policy write data
+ * @buf_len: size of the buffer
+ *
+ * Measure the buffer sent to the IMA policy securityfs file.
+ *
+ * Return 0 on success, a negative value otherwise.
+ */
+int ima_measure_policy_buf(const char *buf, size_t buf_len)
+{
+	if (!buf || !buf_len)
+		return -EINVAL;
+
+	return process_buffer_measurement(&nop_mnt_idmap, NULL, buf, buf_len,
+					  "ima_policy_written", POLICY_CHECK, 0,
+					  NULL, false, NULL, 0);
+}
+
 #ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
 
 /**
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 0a70d10da70a..fc747f391e41 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -541,6 +541,8 @@ static bool ima_match_rule_data(struct ima_rule_entry *rule,
 
 		opt_list = rule->label;
 		break;
+	case POLICY_CHECK:
+		return true;
 	default:
 		return false;
 	}
@@ -589,6 +591,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 	switch (func) {
 	case KEY_CHECK:
 	case CRITICAL_DATA:
+	case POLICY_CHECK:
 		return ((rule->func == func) &&
 			ima_match_rule_data(rule, func_data, cred));
 	default:
-- 
2.52.0


