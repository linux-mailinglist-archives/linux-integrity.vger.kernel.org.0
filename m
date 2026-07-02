Return-Path: <linux-integrity+bounces-9875-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ytxNCv64RmogcQsAu9opvQ
	(envelope-from <linux-integrity+bounces-9875-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 02 Jul 2026 21:16:14 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7916D6FC76A
	for <lists+linux-integrity@lfdr.de>; Thu, 02 Jul 2026 21:16:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=polito.it header.s=selector1 header.b=XqMXzZIx;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9875-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9875-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=polito.it;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0163F300E3A7
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Jul 2026 19:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469D1383C6E;
	Thu,  2 Jul 2026 19:06:16 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021092.outbound.protection.outlook.com [40.107.130.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4093381E97
	for <linux-integrity@vger.kernel.org>; Thu,  2 Jul 2026 19:06:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783019175; cv=fail; b=MfEMyK/pr9hyfUXid4V2l6O03+ixLH58Di0Sw1poFO5yPzCP4+HrdQLRwF5rBNYhOMng9hn02F/elAmkz3ULZJu6m8qtsDB9Q0s1lXOySILvD2z9FvPqai3EGrg8EUP1IUwycKwV+woa0hJ8YWusc9inx7LSkdulHEtZMnjX2zU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783019175; c=relaxed/simple;
	bh=tlR+l2cJYixCti/JeuVEJNbB3wNA6RLeFD4+g0+C6IQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e9IIIbFD5Vkc2mhtgTG6IbTr2YfxbOdzlSzgCEyUdafMNxaSCLIMmjzVjWgpESEtOKQwryOlFiYZVnklhF3QhrcVjdSmXRj/Sy5x45FM7zuY4CAep4+I7z1cKy3DQnQmG277DKWfqO0vs3eLOSLKIuJ0CjFXFVTo7lnAK7N/8PA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=XqMXzZIx; arc=fail smtp.client-ip=40.107.130.92
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wvMvGoUrEd8BC+hfyv0yLCj8D53T1IUp8Hl0Xw22jnZhxdtIuA/h6XSq6g4UlXinAeSU5DDKBHpmXrTXY9ZXPmpFZhBrMp07dJFBnN69cW1CiDmMxVXB8U3xN2eHnbenl640BCVI2pv2cJJ6Wb9XhAgDBXeva6Tm1/ZfOn93j5WHW/4sQSDxE4OfLd9lgk3Vbpf4pAX4R91H3tcoYOFXgzqiOEIhMCBWFHfxVvDq3GBEz3YJz3y19i2U86Sj746BN789bxPuH9OoRlD9Bg5Sq/qIQkke9WSA9SGysk4+b6/lsD/+h1UyZeABCbJ91jiIm8wMPNHbz2uRedEe39r8HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axfOgwldFeA4SegedXzCvCr4j1eYI9+/ZqOvhvo3OsI=;
 b=OdchYcjBzqlzYmVADwLHa8jgqhr99NMiOLmlu0Z5EDFmew1A269joxcMPiXALS8sPMzN6rdhsd0tP2VE2hrlWKQsWvA2AtdwtTmqK/sJMkl7xzojmAdqqgjSbIPjvjVz6veZCAbrvKOdAQB97JJrc4lTj5+jcG2wG0X68v+XiCtmI++M7dNA3svH1crAMggd/gQJS5aSRWAHSj/LThVHXlEDqU6wOaRe9RwcN0fYklF4MBeXDRBUfLX3Phuzd2QArmapmFXHMScLz/bIhnEpoJOcJeQwJWBs7OCrzzAllZoQBROFigPR7iXLmTcLBVi+mfaxq9k54Uqm5pSyhfQ13Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axfOgwldFeA4SegedXzCvCr4j1eYI9+/ZqOvhvo3OsI=;
 b=XqMXzZIxYsCq1l61k5EqfEEmTKCYP3xG93py9DfdOibg64jZvTSKrwDfEyyeUlo2N0lXw26nCliR+TpuzDgQOiqdAxCZdEHv3GmRqwkv6qMtDFVWd1OtCcr8JeuLBuCpF8jirGjmax0Jf0FUz90IhqDEyDXrWpJCIsAOKZ9jYrI=
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com (2603:10a6:20b:253::20)
 by VE1PR05MB7517.eurprd05.prod.outlook.com (2603:10a6:800:1ad::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 19:06:08 +0000
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64]) by AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64%5]) with mapi id 15.21.0181.010; Thu, 2 Jul 2026
 19:06:08 +0000
From: Enrico Bravi <enrico.bravi@polito.it>
To: linux-integrity@vger.kernel.org,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	roberto.sassu@huawei.com
Cc: eric.snowberg@oracle.com,
	Enrico Bravi <enrico.bravi@polito.it>
Subject: [PATCH v5 1/2] ima: add critical data measurement for loaded policy
Date: Thu,  2 Jul 2026 21:04:04 +0200
Message-Id: <20260702190403.5844-2-enrico.bravi@polito.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260702190403.5844-1-enrico.bravi@polito.it>
References: <20260702190403.5844-1-enrico.bravi@polito.it>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI3PEPF00004E95.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::445) To AS8PR05MB7880.eurprd05.prod.outlook.com
 (2603:10a6:20b:253::20)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR05MB7880:EE_|VE1PR05MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: 81f62242-1d82-4a5f-cbfc-08ded86cf945
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|786006|23010399003|366016|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	t/N3cMB/FWSXZH5kCbXtCzZRe4w+GD1GcLr990WP0BZwkkIZc8s1aOqFmm1EBLLoPf6Jb7KTqhz8vbnaWt8mFOQey3usgZrv5Mf3f79/sfIti6bCe4SQwhTa7c7qVS3pM80in6MtJyYtifkI0wpTES7nCulatr6ZchHvRZz2uxvfiAGRiPWtsgTynF+hiXb4nd6AYelWndNdJUwz/59vRbGnfxG931ADdUqnAeu6+Cp4RH/Ft/yfNn0JFW8qHmgDW5SMLoKGI0fmMQUj2/BcIKVENGiGLDvthRr2fNGsLyyN837O+38+5yB1sUjQAZbvP50wdH0h9Uco1aBIJOEAj+a+jUgo9oOr6W2q7kiCgJLa9JKFLiAkMh7HlukZMin0p1DV66sivL5+0FlYxvMw72sBiOj+kcWjj132c8/e3pju9V3epLcp0GBfabuC/IWiaKjdkwRfrn7ctHtrPyFbJZelQeb1vuHVv8Judw57VuVfa38aHXqYG/nOXQ8UwzMIL/R10fxswfkHtPvZT24P0nCClWKFy4xCGr+Ir4SmPiPl284FHxG1Zsm8H2smFmZtIBMEtl5YSVAw7F/bECjeae8xp9qAWFBdvzoW0jB32RW2klP/r0RxOXnjQxwfjhinuhphLp5hXwjtKW2BbghmHnNEl85slzkb5zCi2LctYbM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR05MB7880.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(786006)(23010399003)(366016)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q8kcv90AAADY2X+FWxS3pKmAKbHHPiCBOd9fGSTTM8Yy8lNUi9nhudx126GC?=
 =?us-ascii?Q?3InHnpM+ddhrbN+Qt3NLQubC/51djq3RyL0213kS6pWcxelTuiso6ujHIDKW?=
 =?us-ascii?Q?VFeObNAm4w76WZVcLzJ1Fl4BqSy2LXEg40f4I+srN5ffr0B0/Aetg20v8bTq?=
 =?us-ascii?Q?Do1padBHCf3PF9PfAMRASDah/rNQbZEmOtecTOLK424Vl65wnNmrZSB/ndSA?=
 =?us-ascii?Q?REF1bNu/alVQDETC+Pi6i16zj3r/XRAi+oIt/7OAax++5jiaI1R+d1xhc1kP?=
 =?us-ascii?Q?dYqsqqB/Ha5IRxTa5MJeMzur2dGE5XP5Odon3c3Eu8BYTJ+cWwpY2S4RySuE?=
 =?us-ascii?Q?JCmGX00PmvNiDvZl3kNl4rOFGKGVrXyDFnZp7vRBbvajMFFDk8CSF8Fn09dH?=
 =?us-ascii?Q?bSHBuEua91k8GUDPV7g4M2zmTqUHv4yVD/qS/VYmBCRJp6rotnBRBOa4OA88?=
 =?us-ascii?Q?hvy1OsD0K8+1KmNss3ixfo4gOOHtxrAQaIrU1pNvuQBhe6L8o4oEgpk3ifPy?=
 =?us-ascii?Q?E/bKRzsjophDCUUvdB8fZjtyhLdqr2Fv9A23EN9kiWBEI4UUOaXVGUFrPA/w?=
 =?us-ascii?Q?wexU1hHMNDn+ZX22JbHbee6U6S/6TllwECRuDybauOo0ZC70lqj/byocI6CN?=
 =?us-ascii?Q?BKSuPhoDMnrQr/TEUXIsx7RvqHDV7xpJ0u8wEx/A85YfmeUM7L8vqQ2AZeRr?=
 =?us-ascii?Q?nhgbF8ZwKSaLU9U/riID9VmPxQjKQ/0GZk9UDQyVzn4XUvfpzSxpagLnRwRW?=
 =?us-ascii?Q?jXz+7ugGVBqWI7e+8z8POz4bMdGUkTLHGwFXydM6PznLvhFZmdBeOIFOzg2L?=
 =?us-ascii?Q?jE8xEVbPhjUa8dF8ayFyWJiBgcqRNS5K0SaPlhBpFMRsSKRtHWBRR9tCBa7C?=
 =?us-ascii?Q?RoKt8/u64UIj3aNiKOgC6qK59YVUtiDFo7X5kgD0KHjkYC2Pd+VblsTw1bQ5?=
 =?us-ascii?Q?pXs+gbvAjCbctGAT/irpuUPASG0mrurvAAuwlyAYSyhnZQFA/QWCf4LJGuUa?=
 =?us-ascii?Q?JiMpjsyj3gV3VvSc91k3hjPpCZR2p8DjJK1G/hsDVDvMTiA2K5rOeF1XZJvF?=
 =?us-ascii?Q?ecg1AjoCZp1RV4ATKHAzlZORd/vwGtZdBQ3WyBjpw19RMjgsZ9d4E90Jpbqe?=
 =?us-ascii?Q?xGYEBJWJ0T3DOg6ZVT7d1hDcZbICvpgIM4PX71HcpjbvQNXXIkHOLmp4rriS?=
 =?us-ascii?Q?70OBhhvP5FrbS+s1GCYqAzCQPJBzaUAHTc5Lkwm3zHOHxgWYjFC2WUBcWb3P?=
 =?us-ascii?Q?hKbni4Ox/oQLy0SkpD9uKMUFaOsuWFZtzr84a8nf/7tVPa3JTYgxtwp9pz4H?=
 =?us-ascii?Q?w2Lt+EqQ94+ovxkn6AnswLyck3376QsRyaXGz2P6jjhIrPpC+ghj4Xmb58Ep?=
 =?us-ascii?Q?Id9CpjyhKMQTrBr3sjbB0C/S2VedFC5CPY6HNMqmvZm+2IGxudMu4gUn5Yhz?=
 =?us-ascii?Q?aS8qIYhwM2E+skQ0wA+/Fo4nvz26PUBZUaa3bJ8b1SVsadqs1N4kRP86mhoF?=
 =?us-ascii?Q?f/ubGq/CC7XnC0HsM5ZLaSPMBoJ80Nghpo/pkvo3Dbu0WqVRVyDBRK9VMSxJ?=
 =?us-ascii?Q?aC1MBitq9mc/Z9IvY9mhSG1tyIiyBZNFKKjTvuIGHB05wZJEiWVdAlLxFZnJ?=
 =?us-ascii?Q?ijh1+lb8CuzVefiwJX1HnMab5hE9iVuadwStcbti1/g3d6V38G/1erT6BPz4?=
 =?us-ascii?Q?zRO0+cD7ZfHc75uEVcHSfFu+tfgYZgFgFbax3ZXgcflpqKmokudkDO7E1yw3?=
 =?us-ascii?Q?2sCe7zZXdQ=3D=3D?=
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f62242-1d82-4a5f-cbfc-08ded86cf945
X-MS-Exchange-CrossTenant-AuthSource: AS8PR05MB7880.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 19:06:08.4955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ToBjGe4lyQYgtFUUGL+BNUKvDnFyxZvUOScjvb0oTNoiWJTQ7Y53y3BmGBUmqt4/cfwu91OsL25bCwzU8VKQ3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR05MB7517
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[polito.it,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[polito.it:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9875-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,polito.it:dkim,polito.it:email,polito.it:mid,polito.it:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7916D6FC76A

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
 security/integrity/ima/ima_fs.c     |  6 +-
 security/integrity/ima/ima_policy.c | 89 ++++++++++++++++++++++++++++-
 4 files changed, 97 insertions(+), 3 deletions(-)

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
index f7f940a76922..a65b7e4b64d6 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/rculist.h>
 #include <linux/seq_file.h>
+#include <linux/vmalloc.h>
 #include <linux/ima.h>
 
 #include "ima.h"
@@ -53,6 +54,8 @@
 #define INVALID_PCR(a) (((a) < 0) || \
 	(a) >= (sizeof_field(struct ima_iint_cache, measured_pcrs) * 8))
 
+static size_t max_rule_len;
+
 int ima_policy_flag;
 static int temp_ima_appraise;
 static int build_ima_appraise __ro_after_init;
@@ -955,6 +958,8 @@ void __init ima_init_policy(void)
 {
 	int build_appraise_entries, arch_entries;
 
+	max_rule_len = 255;
+
 	/* if !ima_policy, we load NO default rules */
 	if (ima_policy)
 		add_rules(dont_measure_rules, ARRAY_SIZE(dont_measure_rules),
@@ -1993,6 +1998,9 @@ ssize_t ima_parse_add_rule(char *rule)
 
 	list_add_tail(&entry->list, &ima_temp_rules);
 
+	if (len > max_rule_len)
+		max_rule_len = len;
+
 	return len;
 }
 
@@ -2020,7 +2028,6 @@ const char *const func_tokens[] = {
 	__ima_hooks(__ima_hook_stringify)
 };
 
-#ifdef	CONFIG_IMA_READ_POLICY
 enum {
 	mask_exec = 0, mask_write, mask_read, mask_append
 };
@@ -2322,7 +2329,6 @@ int ima_policy_show(struct seq_file *m, void *v)
 	seq_puts(m, "\n");
 	return 0;
 }
-#endif	/* CONFIG_IMA_READ_POLICY */
 
 #if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
 /*
@@ -2379,3 +2385,82 @@ bool ima_appraise_signature(enum kernel_read_file_id id)
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
+	struct seq_file file;
+	int result = -ENOMEM;
+	size_t file_len = 0;
+	char *rule;
+
+	lockdep_assert_held(&ima_write_mutex);
+
+	rule = vmalloc(rule_len);
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
+			integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL, event_name,
+					    op, "rule_length", result, 0);
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
+	file.buf = vmalloc(file_len);
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
+	vfree(file.buf);
+free_rule:
+	vfree(rule);
+}
-- 
2.52.0


