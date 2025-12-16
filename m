Return-Path: <linux-integrity+bounces-8077-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6622ECC4880
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 18:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E26B30215EC
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 17:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67214298CC7;
	Tue, 16 Dec 2025 17:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b="deyTO6xh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021085.outbound.protection.outlook.com [52.101.70.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3296C26A09B
	for <linux-integrity@vger.kernel.org>; Tue, 16 Dec 2025 17:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765904503; cv=fail; b=lfhpOj/90iZXFsWeDOggriE3XTffmwb0t5SHLOYNM1fVmPyoCXq9iKDH2XuO8b2WeMqJb0WX1+PuHGh5GEAm3mo1f8ZFZqk+b5eJ8QAuUkrbfTmpgIxmhJ8KW1Giu/549VQnk3KGuP9rzxoM7QZ+LUr7eFvxwRJelUMhVgaBDHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765904503; c=relaxed/simple;
	bh=gxnqmCsdxeOcWfXlBHZ1NWyPH23mX1I0FcPn9FmiGaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WjaH9XQToS3oTwJnXG8j9UXjR9aLZB5uxbQ2Qf05o6cmlyOw+z8Ak6n1efgPbKDecCZau3YmWpzqGCMzs9qS0TDmxyr2X9S81zKiMwbpdn2ycbLGk9xonA11UM2ux7g5r6SyjVc74DlBJthsd+jlYBxFVJDxCqfwaN8gMmh+onk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=deyTO6xh; arc=fail smtp.client-ip=52.101.70.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=polito.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pUg1OXOsoXSrxX98Tgty0ibM7t4kgOgWrPzFCXcqLtz7SA4nuXpAkB+gL4elvVyGvBLdq+CAtE00lY31xIdjj+dn/FhuGblr5uU1Yy6H3uhWGdGAqW9oTtnQWshqKgjiBB1O5gl74QazcvnmP7wSvpcPSHp8PGopYbB6pYt3LAFMKs0AiJEdqg99yMJjHZY0IjdUddFKv0hWKF9GvcV5qBEFdorHxQIv3rb1p1JdWhmYZpy5TrCpGqcDA6ly6HBZzE1zl8XGnEAz8X/U6kSRcpVn3mGPZ7dGt9bZcWpUNtqWm2JzN7KlIKe1hBFaGNbDwjGi35/cKKsPAJ5DayEE8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHdP6G42FZb8rr3ditIUmoZpUXSkTvpvaIfWPQE5LbI=;
 b=eL5Ai1pm0VFaZCMAZvOnU4z0qbHCPIW9bjakKxlKu4IOtOQEd/HwIzRUgoOSgS/TvkNZwGhFuZKxb0U48Z4HECicaYrgyFN8gkmePKNTiU1vtNjt3Ur5SoD4RnFGQ2Is4KVMIfFxqpO1V0UYQgEKv8DsbKe8jqnoN7fpfu6gkZc6OBLchcstl63OMV+GYikzgKfhn9kB1yrc8/p8fU65ppnA+UzOQTDooz6c3pb44R3JTyxrtpJYEqYK7+3OexOlZvCrHlTSLCgH1gZw0YMudL/Nhp4tkrMyxjq2WetgRoyp/sb9Qa0GWMdgKWbE5WfwraaJ3rqhCG8WRqJ5aP63jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHdP6G42FZb8rr3ditIUmoZpUXSkTvpvaIfWPQE5LbI=;
 b=deyTO6xhmGPXbCg7tPzuo6temR1m8iJKO3zhNq/0+fj5Bu5z3kalEirs1E8EoQacA6MFapJJFykF+jDHZPO88NrXsWBS20vq9sGhnYRnLwmhEE6pX+ZfTLDTTCCII7q/H71UpJcydLIdJS54ScGIzOzYz7dq2HDdXcmIUNU9O3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=polito.it;
Received: from PA4PR05MB7776.eurprd05.prod.outlook.com (2603:10a6:102:d2::9)
 by PA4PR05MB9684.eurprd05.prod.outlook.com (2603:10a6:102:265::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 17:01:36 +0000
Received: from PA4PR05MB7776.eurprd05.prod.outlook.com
 ([fe80::509d:8c36:ae0e:8e4d]) by PA4PR05MB7776.eurprd05.prod.outlook.com
 ([fe80::509d:8c36:ae0e:8e4d%7]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 17:01:36 +0000
From: Enrico Bravi <enrico.bravi@polito.it>
To: linux-integrity@vger.kernel.org,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	roberto.sassu@huawei.com
Cc: eric.snowberg@oracle.com,
	Enrico Bravi <enrico.bravi@polito.it>
Subject: [RFC][PATCH v2 2/2] ima: measure buffer sent to securityfs policy file
Date: Tue, 16 Dec 2025 17:56:23 +0100
Message-Id: <20251216165620.683529-3-enrico.bravi@polito.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250225131255.154826-1-enrico.bravi@polito.it>
References: <20250225131255.154826-1-enrico.bravi@polito.it>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::15) To PA4PR05MB7776.eurprd05.prod.outlook.com
 (2603:10a6:102:d2::9)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR05MB7776:EE_|PA4PR05MB9684:EE_
X-MS-Office365-Filtering-Correlation-Id: 141e3276-e0cb-4f50-a16a-08de3cc4c60d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xG3KbG+CEfYcQUzGEqntRHWCSJyEwLMD0hJnye3xcuARl96KHJ8Q19OfzyW2?=
 =?us-ascii?Q?3HdXmp4PpyIg7Z3ZWJhw2mqGFS2n7wveOktRXPIRG0qzIotYLO4Xdhx1irKn?=
 =?us-ascii?Q?+3gjzZILgN7ZnE1KgMSeMM+4RpvoCyo2bB510JknYBocoK+rLYTYoNxSOsxr?=
 =?us-ascii?Q?IVJKnGqkg2cT1u4seQvhi3Xz+z/EgdvilvST7ldC1apk2h1eVUmw+GYA3CSb?=
 =?us-ascii?Q?ue7LeYI6y+0R28LJCXUuyRDNL3wfBz+8ApknzAX8MyKkrLZ9lEzffkvbLANV?=
 =?us-ascii?Q?/1RfAnNpZovcPbfW1wXXLh8HIglgVYWhb2IoZ1rCfc32Qtoz4Uha82raSAF2?=
 =?us-ascii?Q?Rc4qsmoOIXLecr8olYTRtxDOcwzsxDUo/94JBM2ECSZCjyQy6XGkdfGNvl7N?=
 =?us-ascii?Q?lwPCZ6ANJVinmx7UD8PnHMqpzEqNI3zeVPQZP502ts04dMRBv4mvvv7zpV+E?=
 =?us-ascii?Q?9mKOdy5PXnzeZb3ApbZ57Pd5+Wze/V+Op0a39f7pX3ZbaTbSDjX9d6rHjgpE?=
 =?us-ascii?Q?0HbFJrnu0zDDkL34SUV8JV7UthYJaB+D1NNxxmHv3J9FBlR3Kkt9ZCLya8Ba?=
 =?us-ascii?Q?zN64iycFB6A3W5YIedQm59p7nur5NwRJhyaqKd91Y0tkfbj0CoE5++6UKQRm?=
 =?us-ascii?Q?3df3C1APLCob7ZeztBXrrgPf8GH0YqNbLgdt7mAilg6Jfq0csHMvv2ErKvLi?=
 =?us-ascii?Q?83ME+ahUQJuVCcNaiGqgJU5WqOu76wFjL6de8VO2MbhpqpdgwVOYnCa94vMK?=
 =?us-ascii?Q?Z51r6393DeFHsw0f0iWprg6BJTi2447xB/5oWLJ+CNC4gLV1fV+MCLWImAAm?=
 =?us-ascii?Q?xygDokEscWh6YhEdhgQS9rTs4Ar4BeUi3POT++qHLW8f0xRt2Ed23E7cMCKK?=
 =?us-ascii?Q?fUxqgO9ugQnawxXmNaAJ2lozbzhnINZt+nu16oTynOsEAuI0Lh1aQmV5ds7H?=
 =?us-ascii?Q?fr4+BjRDkB3PWoS2a5P95sAf45Av7XlACUrmIP58oC3BQ/TGMeVcndpBrA4D?=
 =?us-ascii?Q?n4t+0i7ZLJwcNnrGOeJpt4VfeFFDOQEN/QsLbOtcpnX5KTLbsPW549RLkhOm?=
 =?us-ascii?Q?tnmpgjXPu4NBYwynDJUvK2vEKIwqxisdKkNIe7BViQD0dZ74jHUf3DAEdMlG?=
 =?us-ascii?Q?wboXNtjRjoUlUFsm8HMSW47u0YXzzgbNs2HZJBuQLW4Ky9GKP4JbUG/hcyBx?=
 =?us-ascii?Q?kYEmB5DCprXF3q6LB1qwa9Y/uKyDv4Mmpeo3nJ/IKnqNJNJlisSHBkrrqewp?=
 =?us-ascii?Q?99JEMsEq72j03+WyCQ42T4DjwlTwoSkmAbgqtxIDbX46H/EX893BCOmfSq2Y?=
 =?us-ascii?Q?X1ZLGd99YzCDPo3KtO0m4KvMC2hyF4JWDOmcd/D5li6+xXpqubokULcnxB5I?=
 =?us-ascii?Q?dV5kRgOeuQhH/PUtZXWpJ+O95kDwHpxvWzbrstNsMoMOaubDpyNghhfdgDT2?=
 =?us-ascii?Q?IM5HKu2G6wdz8MzGHtDwHFFaBJ6YGatU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR05MB7776.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8XriQ202p4Qvm27phAp5bpAbdOkBowGprCTB6ZTKFd9WENhTse/qHFqWQG2t?=
 =?us-ascii?Q?A8wsQBxkYtfj+3x9YGit0zu89/evMZNbudxnlc4aXVQzdVWBugG/GYoNuJDu?=
 =?us-ascii?Q?xDRa1iMyS7pvl8poXf4RpB4JBK4adonYcE2Z8izV5r/Pr5AnZb4NgYkjHREL?=
 =?us-ascii?Q?U5x5WPM8et16SUrwcMaF5lu5NuYScXPYBjZF9w8SWE7pxnOlMfIs5Dc0foza?=
 =?us-ascii?Q?3hgyM05YcYVvVGTjhp8wc7EgESOBVNzdCpkYnxaknnzFpXer5aMohEPrWk3r?=
 =?us-ascii?Q?YHCpUY0Dkm5SaGGTeF+T47fw/wBuy4LtsHRAvToVKFWiVYi+lus3UVAaRsL4?=
 =?us-ascii?Q?YL8mm9zj6TemN9ECpi2UgWzLYFPcBTzYLH5DmlfZoLY3eQ0/nYkoF9wFzemK?=
 =?us-ascii?Q?DQvqtTsVL1QkdZn99yeanhzXRH3eMjgtJHG0B9hj0MfI39hVEFjvQYASan8c?=
 =?us-ascii?Q?R0GrM3iv6eddqx55LEhPq6rWheISDiB0/c5bkmfhBKAraxZgZzD6Rv923HVC?=
 =?us-ascii?Q?eBvs3ju17q9t6TEHOyfpaGSGbltK/yAs2vQHRJhbcKjwo1PzmZVWlvG6hgv7?=
 =?us-ascii?Q?Xz1TYfRlUUVehvUofZuttBWPhkzrthOEzITNf8/h0cE7BaICTpQDE35vCeLW?=
 =?us-ascii?Q?f3wAb/Yd0DJJGtD+r2pPqNatTpzEpJJXDdcoTxdaL6ePYGJeVn6TzxTHzGPB?=
 =?us-ascii?Q?TgkVUybvsfWxHqj1BegS9CLV+egvss9rEl3qyEvB/PnLQxxVHyRqMXYHsHNA?=
 =?us-ascii?Q?0ALbzcpF+G9PijxAwfwich/FKipqT7gLnKj/urcymM/N3aBWPVy5TJsNp/55?=
 =?us-ascii?Q?le/XEqm1GDRq4MFK8cR5QlI91dnV71EuWjNEPTz2fAtW1aJyUf4Eyz1Pp7Tl?=
 =?us-ascii?Q?lvLNIolEFlhDOuCYSc5r+iUSSDQrzSxGrs/zo1a2y7rA0lIAWDCZuiw/P1rh?=
 =?us-ascii?Q?IurCCiV7hIxXkKH1ymSB75rPog3QVLC5mkey3v5pmUvlHK/Z7KI/sUfxffL5?=
 =?us-ascii?Q?yS3FersS62DkJUThnPuyYuGmBSmXy++PllC2PjTi1onQAKaL28J3mqhKXpDh?=
 =?us-ascii?Q?FhDnhNsTb6WtViLeqkqFLp5Gy+SsZ8K3V2j9uh0RgAS2zYx1H1GSMRGJZsyb?=
 =?us-ascii?Q?HDXfKuuScb5ibN0W3RuBs5W/p+Bntgm8oJa6vz/8L/HtgdDigkmBRIdq9dDQ?=
 =?us-ascii?Q?8pWU6TyAkcl+XJOQahePN5BZwpNHqLHtOFHmvaeJxmRoVrU14xhsSzmzqA6t?=
 =?us-ascii?Q?QELvRFdZw2cTQ6hfgole8SVvYu9KqwtDcZ7q7jj0uOp6N5oArU4Sf1E2aJ1o?=
 =?us-ascii?Q?zrdbdBdr1kzj9rUJBObVPQB/i6dGApXeu4Z3mX8ZA81vpHEd0w1b227K8o2E?=
 =?us-ascii?Q?o4ow7fJntBhRjVRCTbhn1eX8/g+Em5ZSK73fAkhg59cykl0Az99ZCZFHK722?=
 =?us-ascii?Q?m6+U1aAYdyps6TtpNp27PbZdu1wAfo/i3x2uOpypbtlU2V0Z3kewjdXmKyDx?=
 =?us-ascii?Q?FCO0zhejyUCd/UVvgbYykBLG3xWsLuw40MZBCHqmIowdjUDhsYJxKFoSV3MG?=
 =?us-ascii?Q?vrCuklD6P1whiZvUhffTcz8NIHjXf0KeL3UU1AKKmwu1jXRxg6IXxINIn1Eq?=
 =?us-ascii?Q?Rg=3D=3D?=
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 141e3276-e0cb-4f50-a16a-08de3cc4c60d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR05MB7776.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 17:01:36.8493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PE/PteDPW5TJB7cLPGth805RpiUO38yhsgfi6irl6pnTgTpVAezUHWbwFMJx4uoG+YbKczF3IjbsmHqcLiHQRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR05MB9684

When signed a policy is not mandatory, it is possile to write the IMA
policy directly on the corresponding securityfs file:

echo -e "measure func=BPRM_CHECK mask=MAY_EXEC\n" \
        "audit func=BPRM_CHECK mask=MAY_EXEC\n" \
     > /sys/kernel/security/ima/policy

Add input buffer measurement that can be caught when 'measure
func=POLICY_CHECK' is enabled (e.g., ima_policy=tcb).

Suggested-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>
---
 security/integrity/ima/ima.h      |  1 +
 security/integrity/ima/ima_fs.c   |  1 +
 security/integrity/ima/ima_main.c | 38 +++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index ca7b96663623..3b00c298355b 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -426,6 +426,7 @@ void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos);
 void ima_policy_stop(struct seq_file *m, void *v);
 int ima_policy_show(struct seq_file *m, void *v);
 void ima_measure_loaded_policy(void);
+int ima_measure_policy_write(char *buf, size_t size);
 
 /* Appraise integrity measurements */
 #define IMA_APPRAISE_ENFORCE	0x01
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 89946d803d44..f1a5edd060ad 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -362,6 +362,7 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 				    1, 0);
 		result = -EACCES;
 	} else {
+		ima_measure_policy_write(data, datalen);
 		result = ima_parse_add_rule(data);
 	}
 	mutex_unlock(&ima_write_mutex);
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index cdd225f65a62..6a8ad4714881 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -28,6 +28,7 @@
 #include <linux/iversion.h>
 #include <linux/evm.h>
 #include <linux/crash_dump.h>
+#include <linux/shmem_fs.h>
 
 #include "ima.h"
 
@@ -986,6 +987,43 @@ static int ima_post_load_data(char *buf, loff_t size,
 	return 0;
 }
 
+/**
+ * ima_measure_policy_write - Measure the policy write buffer
+ * @buf: pointer to the buffer containing the policy write data
+ * @size: size of the buffer
+ *
+ * Measure the buffer sent to the IMA policy securityfs file.
+ *
+ * Return 0 on success, a negative value otherwise.
+ */
+int ima_measure_policy_write(char *buf, size_t size)
+{
+	static const char op[] = "measure_ima_policy_write";
+	const char *file_name = "ima_write_policy_buffer";
+	static char *audit_cause = "ENOMEM";
+	struct file *policy_file = NULL;
+	struct lsm_prop prop;
+	int ret = 0;
+
+	policy_file = shmem_kernel_file_setup(file_name, 0, 0);
+	if (IS_ERR(policy_file)) {
+		ret = PTR_ERR(policy_file);
+		audit_cause = "alloc_file";
+		integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL, "ima_policy_write",
+				    op, audit_cause, ret, 1);
+		goto out;
+	}
+
+	security_current_getlsmprop_subj(&prop);
+
+	ret = process_measurement(policy_file, current_cred(), &prop, buf, size,
+				  MAY_READ, POLICY_CHECK);
+	fput(policy_file);
+
+out:
+	return ret;
+}
+
 /**
  * process_buffer_measurement - Measure the buffer or the buffer data hash
  * @idmap: idmap of the mount the inode was found from
-- 
2.52.0


