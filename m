Return-Path: <linux-integrity+bounces-9876-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ghROJX63Rmq7cAsAu9opvQ
	(envelope-from <linux-integrity+bounces-9876-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 02 Jul 2026 21:09:50 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C6A6FC684
	for <lists+linux-integrity@lfdr.de>; Thu, 02 Jul 2026 21:09:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=polito.it header.s=selector1 header.b=HqITmbKk;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9876-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9876-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=polito.it;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 415C3304C6F9
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Jul 2026 19:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA03E38553F;
	Thu,  2 Jul 2026 19:06:36 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021077.outbound.protection.outlook.com [40.107.130.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9933806C9
	for <linux-integrity@vger.kernel.org>; Thu,  2 Jul 2026 19:06:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783019196; cv=fail; b=sF/pJzKy9Ds1M/MAqUP6QzM6IB0cCG9Ec37eGEY6tE2q6MOFIYVcJJA0B++wkDeMXz7Q5HIA/IpeK8zfUmkrWxkmEzRBxh3wfViXbD56IW31fRyWumuDbHfPV+Skdw5eVPGgpbwUavxENYoqyQeTMK0W8VX80asSvC7p4pcZn24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783019196; c=relaxed/simple;
	bh=CGW9s4ps9hMapYgePX1gA5q3kuAYNouOWt1HFvUIGj0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Be1a86AxYx+C/QvEeG7L0o7sA3KvYRkRFHc/WxGfFHwfjKPjJRnR78HfNg2E7etxqkhs0eNO9Bz4nODSFE53GcGXygfRmauGAOh4OHJtOujiWsyoO95+hniERoi05s0WY7eRfSUnZrdqCsE6kN5yUW11AIz47KUUw/qonjbKQuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=HqITmbKk; arc=fail smtp.client-ip=40.107.130.77
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mhYmgUMQXRThn0j+PmCWHWZNHzSItGhX1e8b+HVbV+InDoMlDbp3TuSaIhzF3FRI4vspPJLEXqBHRLO8zXWVY5Y9ohKxL0rh/arxjqxVkivE2HI2qC2ThWPqWxqzrspzrx2KMUO8fUyimLHarzXFikzE13Uvd3yC54D6gqhEG0P/hqgrHekej+3kW0BwTOOgNmQdDu2ncj6hb4iJHamo3qIcf8im0ek0017+Br6uQdmQXU11vcOzOITg6HJDWzCc3BvrvgIoqWUOl0pdHfUovXAbJPs+mR3b1cq/p4rAAc/WHxSpLiMKAnJOlMQnGoKGCRONuCBVWtE0OdGz2c3GTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVrohCxoRWcEWh/U8YsFeKCLPhxg5xkhjnJ6M4A2Y5c=;
 b=CWWVpfXzr7340T2pCBcAO4L4TZmTt+b+C6GOw5y/63zQmZi5Tmo7309w8j8/V0eQXBM2LI+klq0SDVF3rh5STvnMc+szGO9otuIAIEfmcs9FJ2xsk0tM0iAKfHzu2Oqd4MDfycnGmJHIo2zqMAzYyA8cmtSLs/kwu9fxK9f6ijrtx55ihVrMEYlrFnSwYuXxMsO7gtvLszTOaVJXpDM5RR4wbz/VzYFPkJO5cX2GpfxZoduR80qlt9R+kJHVmytSDobB0RBzgbDq7RTPOmYF77exntJayfY8kuFeQtXDO4vufvkNYy8DpnuQY1hbYyrxEvMxVD82ISo+B9xZ7oEcNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVrohCxoRWcEWh/U8YsFeKCLPhxg5xkhjnJ6M4A2Y5c=;
 b=HqITmbKkzFfVwohwgs11KgpTidIwD4lik2SG5EWEgquYtMqV0OOmV8paCHUP5KJNMHY9Vs4g+OhfCa1tdLOgSDTGLwBNqGPwUSxnaDlnidkV0Ps8rLrqSd5RlSZanvNmTuVyNkqiDmNC0NesN4BscW04rW8vH14RLgD0cohErl0=
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com (2603:10a6:20b:253::20)
 by VE1PR05MB7517.eurprd05.prod.outlook.com (2603:10a6:800:1ad::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 19:06:31 +0000
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64]) by AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64%5]) with mapi id 15.21.0181.010; Thu, 2 Jul 2026
 19:06:31 +0000
From: Enrico Bravi <enrico.bravi@polito.it>
To: linux-integrity@vger.kernel.org,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	roberto.sassu@huawei.com
Cc: eric.snowberg@oracle.com,
	Enrico Bravi <enrico.bravi@polito.it>
Subject: [PATCH v5 2/2] ima: measure userspace policy writes before parsing
Date: Thu,  2 Jul 2026 21:04:06 +0200
Message-Id: <20260702190403.5844-3-enrico.bravi@polito.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260702190403.5844-1-enrico.bravi@polito.it>
References: <20260702190403.5844-1-enrico.bravi@polito.it>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI3PEPF00004E9A.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::456) To AS8PR05MB7880.eurprd05.prod.outlook.com
 (2603:10a6:20b:253::20)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR05MB7880:EE_|VE1PR05MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d8b8ee9-7086-41aa-7230-08ded86d06ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|786006|23010399003|366016|11063799006|18002099003|22082099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	8hxu6A77BTbPAWDh2zSsb7pU0WcQojcNPYgO4kFJzemGQpEyqoX0WFGrVOp/NtyjUJ2vQChS7zTq1QsAyG1qER18JC84upasvZX6gybZI9LlFJQrwKuJuWuk1iwrNhQB7fl+/9GGhXc0PAeWXLiNBYAE2egqcrUWBDsjB+K7JdVwWeEk7up0+cGbjtl6Ewkk8XjscbcpO8eI1PIdclOXeVJyzkOXdhEEidSJJPQKBPhvzZwrdqXUji9ueO+Bhu1e+jD6xyCxbzN/NHHHB1bwgODugeLSiU399vowHkPB62S3SKNlSdQ/b5tGdOc3hbDzMdBgMV9z7j1kJsYbDeglRrsrF1BzRKDgTRXapwWYMCnIpZP3QWs5mtuxISHkgnojg7QMhoKc2EgNnKWWT28MWkonRfDp69/GRC0IPIAXqDizTXa3OioFWrApaf0/hjc3ALrez2WrzDT12i4bPxMuHkgHzzq5PpUeGkOO1iy1/M3CaKp8u55Y/c8qMmYAPhjs/f4JWb7FAmSf5eKF7pewlICeFrB+pVTPMSyE4vWVK2tnzlfAI/WvaUgLg7rwB92vYXGWWOrDAF85A/JcvRT3YPrCQDvk1gy+xfwS0TsonsHYfllp2u835e6AsHPCWm0mhLIUzZ8IPdj4ZFb41te8T12iXJxX2b8Wvqq0EogcovA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR05MB7880.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(786006)(23010399003)(366016)(11063799006)(18002099003)(22082099003)(6133799003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FbCF6LZGSKEHQqSxzuFhzJ3c1tc0/ppHO6GdvCNGJOTxumSKBhRSjbRVKGAn?=
 =?us-ascii?Q?+7eHCD0k/U+W3A8G/p/hV6kxK0Zxia1bQ1mjDzxJeBH456KLyzbvHI2c3vfj?=
 =?us-ascii?Q?VLCf5XuPdVbJ0Og31SttJ+F2rXH6W/p2AC1eXNEIMyuLQVcRfjut/OAbYFRh?=
 =?us-ascii?Q?DyhDlfbHohwvklbbWmlgeBBsC1rNdIdjUi3tPcXLCEuhvysqorf5n7A791V/?=
 =?us-ascii?Q?IbaodFa7oHRobAguYo5+edP4O79QFWoW8Lon9qOBVRe2GguIM7ILEAhTHo98?=
 =?us-ascii?Q?o0F7U7R4Vti+ybxBuD5EkjJehf3LnxfBoou0rtv3bXWbm3xj7amiU8Mp3hBY?=
 =?us-ascii?Q?8WsB7HFChwCuNBWlluuxEItqBdXZhwueRc+k3/88FsmjxYun/zCxyBc6ASc7?=
 =?us-ascii?Q?eLAODA+8OzuwPl74f0PKTp02v0/iOQKE+hNR3TPThelScE9s6vfOKfAQp6Vp?=
 =?us-ascii?Q?D3ieF9ievdlfG1RVqRMIw/4hDyaD2i8w95kD5+76EUYi5jCCxk7JAD8qdmZ7?=
 =?us-ascii?Q?BWhFVWWbWYfGrMxv99uReV7wpRY/AeKTnqQd5jOVF1gAdFCuNN4DSfb/dZpR?=
 =?us-ascii?Q?QhLyETilbTxybLmgnngd8buPlNuWnOYV0v2dcx0LvyxwnaFevyalOUMousHi?=
 =?us-ascii?Q?U+RyDa+9EH8k0L6HDAR6xOV562XBiURwM3pN//Nd7BLHBRkaQeU2XuqkvAdS?=
 =?us-ascii?Q?/PIInaprPy4N1A04XyvAp628zngIeUyfofIUrWDd9XajevReqcRoTPYVRZiz?=
 =?us-ascii?Q?6JhP+fqpQ3KvD4a/ylHZFLJB6yUWH02i+8L4FzJWlBrUk5LMLBjLIGL2rhQR?=
 =?us-ascii?Q?6DnHikDE4aLXAoauHU+lNVWXyBpGH6cz1SaH+zu59ThIwO/m+X4xIHQA3TyI?=
 =?us-ascii?Q?tmgG6lvtg/bhnz9zwg7FmnGatzyCWDiQ5brEfdgI6y9+cESUVJ3n7QqVYWxf?=
 =?us-ascii?Q?gd7nZRd/NLYUX55ZvNyVLWFNnMbA2scpdlyM5Z+xOVd5OxDJQAEbhsjzFQb/?=
 =?us-ascii?Q?Oe7f8st3r9gKoJaIqJ18wF5ZEqsM9kfDQ8iej4RTSx8vKETjoT0lRW2mrlQS?=
 =?us-ascii?Q?0N8O1AOrZfEA8FcdgFsWS719GPbEpRW07U4wm7sWpKeEVuhLeQGP1ODEBntS?=
 =?us-ascii?Q?I3HItrcA/9snQZ11g7ECjih6uFobfrrr8Q9hBF3fA4n7E0QzF1QpfltENE5M?=
 =?us-ascii?Q?25U6AAWkgCw7vg+tIx0uWr+5zRhAow/hj1goAIyhhlDdwTFJ8qtd8bMGrj/X?=
 =?us-ascii?Q?tEkYKQ7VICS8BdYqtOVDQPrJvFVHuKNUVLiaUgd1Gwi0o501lG0n9xXZmUPm?=
 =?us-ascii?Q?jyHiLoxtqKPrFq14fnPBvHAO4EPeYhoPHB0Sqnr0YyYdPW//pwzm+klJB+Wq?=
 =?us-ascii?Q?0Vdg+7Ggp5R+a+0+i1g3cL3HrhhJ+n3gcBodBorCPaRUHtfVHj8z11hW/UsF?=
 =?us-ascii?Q?4l6v25CkFMnP1wVYmngNfOGsq49dz83x13V1pOzF3MQ7iEivoreAiMLz3lQn?=
 =?us-ascii?Q?5aqrAZn/lYHgEb5OgmoHHYu6ZOe6TZ/e6BU1ndypVGSl3peqSj8yBf0Nt2DD?=
 =?us-ascii?Q?qfSeapRGCldNBGkewvCjbD941SJstDPLa6EGAsmKJ4cvBWlMQYOgswzQZSnQ?=
 =?us-ascii?Q?rsau/CPfKOkWsfwTw4YeO59c7LZVA7Zwjo7oshCbV+0eg7mNvZNfpbJoN/1X?=
 =?us-ascii?Q?MZl1BWIAFkImWcN5pJWmDGiKdXroSsxMxkyafdA32Rt2weT/fWvTeg00rZHn?=
 =?us-ascii?Q?TTqhXIGbfw=3D=3D?=
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8b8ee9-7086-41aa-7230-08ded86d06ec
X-MS-Exchange-CrossTenant-AuthSource: AS8PR05MB7880.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 19:06:31.3565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cf703oT2uZcYnIWVH5FiLjwujxCTjroubd4/AjsuNk8WzcE4iK4syyOVKDfH/EGeR1TMGTF4gTStajCBLHEcjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR05MB7517
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[polito.it,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[polito.it:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9876-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,huawei.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 45C6A6FC684

When a signed policy is not mandatory, userspace can write IMA policy rules
directly to the securityfs policy file:

echo -e "measure func=BPRM_CHECK mask=MAY_EXEC\n" \
        "audit func=BPRM_CHECK mask=MAY_EXEC\n" \
     > /sys/kernel/security/ima/policy

or by cat'ing the entire IMA custom policy file:

cat ima-policy-file > /sys/kernel/security/ima/policy

Because these rules originate from userspace and cross the userspace/kernel
trust boundary, measure the raw write buffer before parsing, regardless of
whether the new policy will be accepted or not. This can be caught when
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
 security/integrity/ima/ima_main.c   | 22 ++++++++++++++++++++++
 security/integrity/ima/ima_policy.c |  3 +++
 4 files changed, 27 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index befa221716e5..8d60dcf9c689 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -455,6 +455,7 @@ void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos);
 void ima_policy_stop(struct seq_file *m, void *v);
 int ima_policy_show(struct seq_file *m, void *v);
 void ima_measure_loaded_policy(void);
+int ima_measure_raw_policy(const char *buf, size_t buf_len);
 
 /* Appraise integrity measurements */
 #define IMA_APPRAISE_ENFORCE	0x01
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 65e7812c702f..fed97eb625dd 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -356,6 +356,7 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 				    1, 0);
 		result = -EACCES;
 	} else {
+		ima_measure_raw_policy(data, datalen);
 		result = ima_parse_add_rule(data);
 	}
 	mutex_unlock(&ima_write_mutex);
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 5cea53fc36df..5277e1f680f0 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1221,6 +1221,28 @@ int ima_measure_critical_data(const char *event_label,
 }
 EXPORT_SYMBOL_GPL(ima_measure_critical_data);
 
+/**
+ * ima_measure_raw_policy - Measure the raw policy write buffer
+ * @buf: pointer to the buffer containing the raw policy data
+ * @buf_len: size of the buffer
+ *
+ * Measure the raw policy buffer sent to the IMA policy securityfs file. The
+ * buffer is written from userspace, and the measurement is performed before
+ * parsing it. This measurement includes any data written on the policy file
+ * such as malformed policy rules and comments.
+ *
+ * Return 0 on success, a negative value otherwise.
+ */
+int ima_measure_raw_policy(const char *buf, size_t buf_len)
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
index a65b7e4b64d6..d6d249190705 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -543,6 +543,8 @@ static bool ima_match_rule_data(struct ima_rule_entry *rule,
 
 		opt_list = rule->label;
 		break;
+	case POLICY_CHECK:
+		return true;
 	default:
 		return false;
 	}
@@ -591,6 +593,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 	switch (func) {
 	case KEY_CHECK:
 	case CRITICAL_DATA:
+	case POLICY_CHECK:
 		return ((rule->func == func) &&
 			ima_match_rule_data(rule, func_data, cred));
 	default:
-- 
2.52.0


