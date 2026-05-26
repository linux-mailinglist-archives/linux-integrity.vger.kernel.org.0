Return-Path: <linux-integrity+bounces-9678-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PKUHiunFWqJXAcAu9opvQ
	(envelope-from <linux-integrity+bounces-9678-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 15:59:07 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D96345D6F73
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 15:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F044D3059270
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 13:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4A63D904C;
	Tue, 26 May 2026 13:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b="FxRUoopF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021109.outbound.protection.outlook.com [52.101.65.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B922F6910
	for <linux-integrity@vger.kernel.org>; Tue, 26 May 2026 13:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779803600; cv=fail; b=uSLgcHf4QQKmKjuInPeKF43j06JxGFH9KhYJa7AkHXSzlASV/yHdm4DmmqE4DEhCpbBDdnILSC2pzhpFjFfVtE44+HFbFgkZshb/HPO7mi7r33QGF4eGDLLfNh9KAfUstaJ78zljisWsPXmxF0tfjVh51MdA7t4GcfKbXt3VdBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779803600; c=relaxed/simple;
	bh=iN9Wkzv0RWL9+zlQ801Cdds4V3BgC5Z0VDY2XbssLVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r+kdlUniO5p8z/kdcc0zlxUDjuvUeZJetVHwl9r5SyGkfGdZPbKsgBn68gnu8TBYNEzCuBeplJQ1mgCvNLwsNeV/261HWZDQzrMdvQah0izDFjjrxWAsScTTzY3qsvGdPYLtEyN5F3jas6/lBZIctEfbfBBY2d695063CYUUzVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=FxRUoopF; arc=fail smtp.client-ip=52.101.65.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=polito.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZzFrJiTnCuCUjrZJH3VpmUHhbSdiCnMYCDb+kYOWtrcTpIPyIxg8vQ9HTYsaR7yIcWwPGHwt4DrZ1xX4PZCWFAeFMC79a8trOHhcOrsV1y4Pj5Q1DkKmWSBtr1dSZzxgvdCMeEZwUEDOI51UtqF0r9XcMy/UscyKdAMuj96nIBaF9DP0d5vTQJZgTOnDZFezgKtiQeG8EuI6GFVtptgKfNksXFKy9PbQ8A74IF5gej1rK4hbrlVr3mrMP39XOfLr+wcxLTYs5gEEJdWl158MFLlBgL2MWcVtiNOrWE/4y12mTHOo9CWqOCOoeBI/9S83eXoV6NuRrCQiboAy+wNOzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7ai3KAWj7D9FNpf4cNbuXG82Efimwki5F/gpfe9z+w=;
 b=C904q5yVDp1towegWMEzBd6q0B0E/wLnTVQMGW7XzmhhwkIAzEnsOPTtqYWE+QFZVhSzcTEmeU1q/OEisD6XKzixv6RWVSFIHsC48qXy2vhujlbquAANLlgxzlPC6PNTFY0HryYMnFaQ1pna7YVyPBwGm01XvxRxur32OVR68ca9Is3CSTMh+SeRQQ+G68td5xvRiq7RdDw/FCXiCJXp3qfAVaqSnV/XRdBP/xMG8Ls9Oad0yBHI98h9B/HLrqdUo3tC6xrjV88YPSIYEENg3WO5QeABHAkcevTFKhOWvsFYocATCmOaX9X2gdTtUXaCcBS5cD0OjgUzg4B5NJ5uXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7ai3KAWj7D9FNpf4cNbuXG82Efimwki5F/gpfe9z+w=;
 b=FxRUoopF3Uj8mjBy4ot0dxVjXpRXymwLSh4cqyB0bWVCvgH6LU4vC9uanQgttFN2vzaAAo3DgPJZAjLMpTIBG9BPaf29UsRcwU6OJhE3rumJupwAG2ShGSdAA54j58c+pY+WrCUn7mrNh64qUJGFohU6iNH/DW3LkQi7o4SaYnI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=polito.it;
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com (2603:10a6:20b:253::20)
 by AMBPR05MB12793.eurprd05.prod.outlook.com (2603:10a6:20b:76b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Tue, 26 May
 2026 13:53:15 +0000
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64]) by AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64%5]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 13:53:14 +0000
From: Enrico Bravi <enrico.bravi@polito.it>
To: linux-integrity@vger.kernel.org,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	roberto.sassu@huawei.com
Cc: eric.snowberg@oracle.com,
	Enrico Bravi <enrico.bravi@polito.it>
Subject: [RFC][PATCH v3 1/2] ima: measure loaded policy after write on securityfs policy file
Date: Tue, 26 May 2026 15:51:17 +0200
Message-Id: <20260526135118.289633-2-enrico.bravi@polito.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526135118.289633-1-enrico.bravi@polito.it>
References: <20260526135118.289633-1-enrico.bravi@polito.it>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI3PEPF00004E9C.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::458) To AS8PR05MB7880.eurprd05.prod.outlook.com
 (2603:10a6:20b:253::20)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR05MB7880:EE_|AMBPR05MB12793:EE_
X-MS-Office365-Filtering-Correlation-Id: 4428e3df-6e79-41d1-368a-08debb2e2211
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|786006|1800799024|376014|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	N4X94+RqzwdPXQZ8OMPVHa8Zio4rLWMiXDpUDgW+YP9zqqzCBBKLVgJji3TG2+HH0lCdMChffhZEuEX9H3tHkhvUBWtbKmup8GPHOkuioxTDPbNrLtTivvxvlaorUjCBF45cyNUKm4iWxqNPzU4zVOFOGtwQyYNyz7GIgwHMXhcAGyHzPbqy7sbIHl69WwNs5ri4mOGhRL8TvMwe8oSLxZwfwTEvwzvJe9/Ol4teQgVW3lEs8soipXwA4cPAUbdRMxqmYC3Ymtp2NF/KhozjWpv8uyl/pyKEcR/HgPCtGUClmwckLv+9o1Cp02vbW2Zkwu9HwXe11lL7aOZfCVyg/arrcNYKFaCFp3Y6cj4XHoHjHKZGAP0EspU2ySARICmM0ntZurtlx10XP41nxPWveG7lgfp+POeGZM8vtha3JdY5FAphCEoX42Fsg3vFtxtS7U4xq1FBJX+BWmITsZGvSxFRRTzMCM56Pa+e+QQa5lbROkQ2QyXrHf/giAm7Y4a9ZBR9MgpFZAkkxXDdeYozl5tc8Z/BXZ177TpKC4ZXbZoqBI1OeXD/D5sH7x/5OMHUP2S7R9ZMa8vdHMjO+8ddCojtC3LLyil6Z3QUIdIMW3NBGuT3rmL9F4YIhh83iDHvL3x84i5sQG2D1+9kZ/zC/QkU4hSVA4DXm1M7F6xumS1j3pBv8gOmSE/Lf4tMYGgI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR05MB7880.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(786006)(1800799024)(376014)(18002099003)(56012099003)(22082099003)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?egp3zpw+kBnPa+AcdTiN56qk4kiFwRdvbA+fbLYFZwfWVSld536sKTHnW+hj?=
 =?us-ascii?Q?Wn1u9nwVn9aODoKQYHSp8MkcJVqlMlC6RmVzCSBCIgdevEuVeCIN7wAepDmu?=
 =?us-ascii?Q?pOopQxZO7Vx9PWv0NxiTJ+AsRRpBmd4h1qDThRuMHlRC+nFKEUYuKPSirQyn?=
 =?us-ascii?Q?cBsGe3V4wihMfte+ZhlRlezfbDyYNXhVWt9NMTJdLasyPs8LMhsfyjsR/5k7?=
 =?us-ascii?Q?iSVq05zbIe8JAGGtRTaU2TcHipOCBnsXH3+d1juijRp54Xuai4NTx1b5tvPF?=
 =?us-ascii?Q?LIhSljorjoXNSF8ZCI0h31tpqINHWQPdUBQb6Bb7UDnwu6OGa8w6m1CZ4K5c?=
 =?us-ascii?Q?rpJuJ+k89/gPI6vfWdAezf5zPfayM9oQxEhBGJspd2VYCiYqwQ0qOxg9uf8j?=
 =?us-ascii?Q?KjHfV11QHX+V1YWNtDumng9oeTOQ5bkQ/STEuEfiQ28cvfjSsqe3cx0SZFoJ?=
 =?us-ascii?Q?nvnU6Wm+O5ruvka+cYmsngHuV8iNnCUGp+fW4y1KIpaoiHS2E67w1Pj1nY0S?=
 =?us-ascii?Q?XaSX1uzKYt9G74mjm4dKbqWH6egz2tiaVojYHQXFW7svKpRAq7Xez7brTNoT?=
 =?us-ascii?Q?JqQFFvisXCt4jrN/oiBkJaOAVNw1+h0z9ON1WxG4VMKdfK/0fyGblgJFoTjw?=
 =?us-ascii?Q?bbZlfxTyEUklOjxJz7RcvAbZCUzoROxUXo3VjwgkUCdldNY3k5LXc0lU4knh?=
 =?us-ascii?Q?wSzD5t2Ev6LAxFL4ZidosnWUvGqmxz51qX1BiyS34Gipel1rKLf/SmJ38ePs?=
 =?us-ascii?Q?dGqc3UKWkWo1J3+gtzKk/TLBMBiGezRmUQjZkREjYQmgOQo6f3KncyOkt4VY?=
 =?us-ascii?Q?xTIeYqwRUipB/vdBaGo0KdYkbPTicZP/oCA/WqOX49fmMEPYr9/aR/eCmrKh?=
 =?us-ascii?Q?TtG3e+SPNtSdHl+JjEjLhakGzzg8XMYFAPdTyyn36evZQpVmxGlLdworxX8g?=
 =?us-ascii?Q?V4qc/QtE3AgNFWy00h04+HnWpK/EI34fM0T+NnF9w/WXM0T3nAmVz3orf+44?=
 =?us-ascii?Q?IflYbMOUP5qmDkJ/q3ZXSfkZd22p//BY3YtP9GY/PuX/U2df4SOHR+XVWfEQ?=
 =?us-ascii?Q?QX81R75TyhJ1xhO67dGivuPcCYwvyCjecyL0A7tdqfrm8SHgeQcEScqsxJ3X?=
 =?us-ascii?Q?jTjBRfX+sKIb9Y1VR+GS4CuSXKTLTV8a8V2YrrU+MnOYQZ+xUwo/AJC2M9U1?=
 =?us-ascii?Q?AWaZMEQnepDTcS+Bi8gDfrf5TlFei0t8VeZvHEIGjhdvLBdrpJ0f/taS3f9A?=
 =?us-ascii?Q?LTGfFgfi7BBCfZ0bRudublBBR44IOvWDkAQ0A9Z3XeOYFk9pJNm4Y+MwDVzz?=
 =?us-ascii?Q?uy9VwnfQcizNmVuFB9Gx6kLJzDsg+Z0g2bVyRKIX2X1GUvf4OkrTOCb6N21H?=
 =?us-ascii?Q?fv9i5kozILauVHlo3n3ROPTejVm7vuReVegm8+zFSBXIbKRPZ9HwQhHg+Zq0?=
 =?us-ascii?Q?F3DIPEgjNA3w+8nTPfYr9Tz6rPG2L50oH31qnGTR3uLQoBl/JDOd0moBgdmk?=
 =?us-ascii?Q?SOcWR+E3fGQ1x4UzJDvDhdQF3GMxkJgcMoXs9M1vlXq2vJigNQ/89xHXUZpS?=
 =?us-ascii?Q?vEGbw0b4Yv2Fr3PEBMppUTfAIIXrHKo1bRKaibc3cxk0b0v/lVFSGyL8pdMn?=
 =?us-ascii?Q?ZyiD7SoRVy5nGBT1BvNveaFBOXcclmRT22tuaFtKB3r18SRPKCbKMXwcgfnP?=
 =?us-ascii?Q?mz5jS8LmaTNwflwXkmhhPXZf3SXvLUzuBnhU9YG9kFMepfEeZN8BTm3eOQAg?=
 =?us-ascii?Q?kLK+7AVuEA=3D=3D?=
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 4428e3df-6e79-41d1-368a-08debb2e2211
X-MS-Exchange-CrossTenant-AuthSource: AS8PR05MB7880.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 13:53:14.8312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pnb0s/RzvgpQleiO2Vzh0wwMv7V4Whv+fqizKKLTkA4tpmr47klInbMiSBcIeOuP4a52hc3MFth6+ooZyETiBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR05MB12793
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[polito.it,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[polito.it:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,linux.ibm.com,gmail.com,huawei.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9678-lists,linux-integrity=lfdr.de];
	DKIM_TRACE(0.00)[polito.it:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enrico.bravi@polito.it,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-integrity];
	NEURAL_HAM(-0.00)[-0.983];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,polito.it:email,polito.it:mid,polito.it:dkim]
X-Rspamd-Queue-Id: D96345D6F73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
To verify the template data hash value, convert the buffer policy data
to binary:
grep "ima_policy_loaded" \
	/sys/kernel/security/integrity/ima/ascii_runtime_measurements | \
	tail -1 | cut -d' ' -f 6 | xxd -r -p | sha256sum

Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>
---
 security/integrity/ima/ima.h        |  1 +
 security/integrity/ima/ima_efi.c    |  2 ++
 security/integrity/ima/ima_fs.c     |  1 +
 security/integrity/ima/ima_policy.c | 55 +++++++++++++++++++++++++++--
 4 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 89ebe98ffc5e..a223d3f30d88 100644
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
index 138029bfcce1..8e9f85ec9a86 100644
--- a/security/integrity/ima/ima_efi.c
+++ b/security/integrity/ima/ima_efi.c
@@ -60,6 +60,8 @@ static const char * const sb_arch_rules[] = {
 #endif
 #if IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING) && IS_ENABLED(CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY)
 	"appraise func=POLICY_CHECK appraise_type=imasig",
+#else
+	"measure func=CRITICAL_DATA label=ima_policy",
 #endif
 	"measure func=MODULE_CHECK",
 	NULL
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 012a58959ff0..75cb308cf01f 100644
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
index bf2d7ba4c14a..e0b4dae922b6 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/rculist.h>
 #include <linux/seq_file.h>
+#include <linux/vmalloc.h>
 #include <linux/ima.h>
 
 #include "ima.h"
@@ -2022,7 +2023,6 @@ const char *const func_tokens[] = {
 	__ima_hooks(__ima_hook_stringify)
 };
 
-#ifdef	CONFIG_IMA_READ_POLICY
 enum {
 	mask_exec = 0, mask_write, mask_read, mask_append
 };
@@ -2324,7 +2324,6 @@ int ima_policy_show(struct seq_file *m, void *v)
 	seq_puts(m, "\n");
 	return 0;
 }
-#endif	/* CONFIG_IMA_READ_POLICY */
 
 #if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
 /*
@@ -2381,3 +2380,55 @@ bool ima_appraise_signature(enum kernel_read_file_id id)
 	return found;
 }
 #endif /* CONFIG_IMA_APPRAISE && CONFIG_INTEGRITY_TRUSTED_KEYRING */
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
+	size_t file_len;
+	char rule[255];
+
+	/* calculate IMA policy rules memory size */
+	file.buf = rule;
+	file.read_pos = 0;
+	file.size = 255;
+	file.count = 0;
+
+	rcu_read_lock();
+	ima_rules_tmp = rcu_dereference(ima_rules);
+	list_for_each_entry_rcu(rule_entry, ima_rules_tmp, list) {
+		ima_policy_show(&file, rule_entry);
+		file_len += file.count;
+		file.count = 0;
+	}
+	rcu_read_unlock();
+
+	/* copy IMA policy rules to a buffer for measuring */
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


