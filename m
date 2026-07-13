Return-Path: <linux-integrity+bounces-9930-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z6asJFKjVGp2ogMAu9opvQ
	(envelope-from <linux-integrity+bounces-9930-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Jul 2026 10:35:30 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF97C748C23
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Jul 2026 10:35:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=polito.it header.s=selector1 header.b="Yw3/nFyK";
	dmarc=pass (policy=quarantine) header.from=polito.it;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9930-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9930-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B61530710A2
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Jul 2026 08:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B8A3B0ADB;
	Mon, 13 Jul 2026 08:27:52 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020134.outbound.protection.outlook.com [52.101.84.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0FB3AE1BD
	for <linux-integrity@vger.kernel.org>; Mon, 13 Jul 2026 08:27:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783931272; cv=fail; b=ntKkhgZ+/1EaSh6fL1u63OZ41NOSJHmyXWc5JEFrrDUwZwMRIXT8qFwOxUxwdchvbgQBa6gTqT+kAiyBQgYCW4Fehp/lsnMaEmkUnuRnEBedocTLJTl9NPGuxEK9C8y81gUGJWjVUfHvjXToKSGC+b8lAONqDTNv6cHiaSjLENM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783931272; c=relaxed/simple;
	bh=OwlACzDCfHqf2YWS/zLv+KwDq/7hgcoOyFbpW7JDMxk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I7TwKeV/4Ngkx2XewVTs0fdFEoRhxNHoIwV5JfaMuvxX7QClj3bNKuzka3fgX9x4ys/x2MQShuS3a+SgAAkUglXCHgWfoXWelMDVNloAjV67VaZpotJzxXv/q2c+ekOpmMv5NaTwlIcNgGX74nq9cNPETcHS0xlgSFm1XetkmXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=Yw3/nFyK; arc=fail smtp.client-ip=52.101.84.134
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idYMQiNDuV1sTwXPyrT9USCDHNrkVGzzlHpPWjJsW1qVmdOojHM0p8HfXRcqxL3wOT/c/14NiMpCrFL51lW/7w0zaLBklEVvKL+6bQxoMhaqNO7mTDzN0UAOyiGPgcRcTJ85tSXgdvCBIcTvoRNQYem7ROuVF3UPYOMjJnKxwM0VqALKQFukoRJlrp2/OQR4kY/GT3YdAqOT4qay5Nm+tL8/M4ykhL+7/IIMl3CaT2AmOBXSWJew3u+YQn0tTDpwMEutVpQqIZee/S2bzE1gADNMsamFqfeXF/jfb4kRZKdXZUOMcONyOyr5HgTry4wEZTxED0YEHECgBFPD1ad6Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxudSKIRprt+G8YstGVonIj8p7Nzhbe4FLTHc43dcvo=;
 b=cxDSKaHwp4odHfjnw+a0s/Qbis1bbcKpV3a9wRPR8IzhqhkEO4w/GfwPojkcL8gON0rKZv8N1M98MY5N9KtVtH5tF42Bqtjhe8Qd1f1ZeCJkSrbWzczsmTKHqrJHouQnSjgjvLRiJbZDy8lgkfJp/yrtNy8/eyv5U9JdFD/TeZ2jaXoXut4dqgAsC7fBlMkmAu5UX4YJcYUpyu7l1gzskVHgQm2eqE2coIujS1vJavgZhtNxktrWBMm51MyzSYjy0WwW2jcVQTR3qDTy4lWp3B+E7VpNKTnT8XKvbhp2IkknjKfq57IVkOrqOOXXbI+4nNPVeBThE3hbj05vyIcbLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxudSKIRprt+G8YstGVonIj8p7Nzhbe4FLTHc43dcvo=;
 b=Yw3/nFyKO4K0EsJ2nZ0Jg8hFMPixWwM2gBjXZsd/dNOZ3FeXxml94MUzVZr6nT8XKj0WpbH+c7JszRuXd3bCKqrwQhiopkMVu1PFxFrKCL0MoINC/6ymzVjgvcJDTp9dY4e5uOuOox8I/oRmsSs+LzBL7Nx5XO1JvWacgLjkWb8=
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com (2603:10a6:20b:253::20)
 by VI0PR05MB11320.eurprd05.prod.outlook.com (2603:10a6:800:210::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 13 Jul
 2026 08:27:45 +0000
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64]) by AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64%5]) with mapi id 15.21.0202.018; Mon, 13 Jul 2026
 08:27:45 +0000
From: Enrico Bravi <enrico.bravi@polito.it>
To: linux-integrity@vger.kernel.org,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	roberto.sassu@huawei.com
Cc: eric.snowberg@oracle.com,
	Enrico Bravi <enrico.bravi@polito.it>
Subject: [PATCH v6 2/2] ima: measure userspace policy writes before parsing
Date: Mon, 13 Jul 2026 10:09:58 +0200
Message-Id: <20260713080954.28520-3-enrico.bravi@polito.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260713080954.28520-1-enrico.bravi@polito.it>
References: <20260713080954.28520-1-enrico.bravi@polito.it>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0194.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::21) To AS8PR05MB7880.eurprd05.prod.outlook.com
 (2603:10a6:20b:253::20)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR05MB7880:EE_|VI0PR05MB11320:EE_
X-MS-Office365-Filtering-Correlation-Id: cafbe8fe-c900-485c-a1ec-08dee0b89d26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|786006|23010399003|56012099006|6133799003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	0GWDAMXJElRAwzRmdPcWH6OLe9ZJAI1Yt2OcobbwJ2o3VyM1SqaHT8LcrJf+bOAql/oLkI8TRNi3mYERupcA+MKNpkCeLEKpdha5m4btyuh19Lpun82LNp9KjYFBTAFMz9JymG9uh5FjYbxrK/24cFFqyNT46SxILqTAPThV+6WLyxCtLV2640x0fGsj+czd2I637MmZg8Aw05gl8JIVlw5xVdEHqKUbURh1Y+BS5pbyX9PuU3Sf0603bRLSkuQo7Xg0LT9GBdg6+QHRrZCVsZu8ErZ35/Z/S1rpSRxQbyaxO86s0kPz7qXKRgq1NqKNFAOW9XNssrIKvhI6bm3pFlZqniraUs+sPZoZwEZQdW7kV3Chl8cZShQ82R0oN4X52mehFJ4f3npr4DII9rZnk4MNN26Pi3TvdyRfSKFa2MfZGdjr5B8vA+3Guj2W+wTPmWbDqfjp8AHmOuXO79R3VSsbyIrsuy0/5i/BSpTFGxCYzOlNAfLVh+RYKvJyJ/hfwnetpytf9kUXmvbE4VnC+XRcdUSJzfUeZ9yKC0S5/D+UxE4JFkOP4MD6DSBZhrgUwtydbkvf4dAFWyUjpJi37zzA8KVrOGviWtdPaNqINNC/SKKaqvidH4gGesccxF2/tfsFgvtWMiz17RWJxPgoJxe86Ir3HAQ6asyg6zQFVsM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR05MB7880.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(786006)(23010399003)(56012099006)(6133799003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aGATys2t3GdwglK07JzIeIJ2NYUM2TFm0l/deXnfyBgw5XVG+V7Ggn00Jq3m?=
 =?us-ascii?Q?WuBMcu86r5aA6nlF91LZQcOvqaEZivlUXOCMmdE2aNy5JZ5DG7EyplMliWCi?=
 =?us-ascii?Q?NCxOeFKu5DmrziwKjwZMbwWaRIQkmfZuNkbeXj2wmCWAXgnvb1mpqagQWyA8?=
 =?us-ascii?Q?JZZL2MUXYifgfXgC61boW6v9dV6D14jFCewER59U8klyHxsSj375GYFeGH0l?=
 =?us-ascii?Q?q2TaCqRInty7KNJjSuMfWtwzmZjKRIn/i6+oG5LQFWhouE4NArJGuXG4sUvT?=
 =?us-ascii?Q?So7L7tojHyP32dBmtZo1OurvvN7Po/+LRto7haeAfutI7C9xZ4imn29bhZ2f?=
 =?us-ascii?Q?LX0htpSLUOQMo7MqVS81GWUsrAl5a0VXa8kU7kcyd9iooRp2llly+eWLCVU0?=
 =?us-ascii?Q?6djLwaM0BduaG2bH0Cy0kNS20sFDa8zyqCyxUvTCeJ2tlcN7Blhxb26k3Zxn?=
 =?us-ascii?Q?CqU1m9W7VqoiwoapMD3fS0uqa/+6ick3tkpXUpTO4d/TfDP+76OUTtx0L+hl?=
 =?us-ascii?Q?PXq4/Z633f31wTuly01FTx3ggOJkepd/9ND3OwegZE3s/mOOFLm1ipPa7WNx?=
 =?us-ascii?Q?mdt7aDKtSSUYOG1Ww1EeLqu1z3noHXntaaFYND2J2iyWgW/e3y4Q1k6l+whH?=
 =?us-ascii?Q?Su1QifgZQDR24OVr24WCHQhzZ2QFMa9SJ4HM/8O+10IO3BY4/id9fzgYcJaN?=
 =?us-ascii?Q?YGiCXmQ1fUlnXkW6tAYbJ1Hi8OgjqABMTKW4R71Umzpopy7oYq8Byf9IgGpG?=
 =?us-ascii?Q?I9Geot9e+dHWUESw6n4YA71EmaV6uYZcZsAt3MDnmuCzhiD0RqpHpAdKd89q?=
 =?us-ascii?Q?pTLDsZjaaN43dt5vylSm5uBBH30u3EyYn9+f1Gl+5C5X99GkhGE3x8vYtsoD?=
 =?us-ascii?Q?RpaLW8HgNFQbMA7lLLk+2URPdSejtEXW/cPFn6bbwV+9tgZDKj/u9Gzjf8yg?=
 =?us-ascii?Q?1rhRmp2dzNlQUazZYn0QpY2L8wwlZXQQC3bjHb2QNL16rTw7W7Ki1W7E2/aW?=
 =?us-ascii?Q?JTRWD9GxI0SCm1/fREOXc1cGruJPLBv+RTYZS+Bf1FggRjaGSrtbet2XdTcl?=
 =?us-ascii?Q?eRFyRqKNxGU3mvfeMtfGjCdGPq4VSSPFMOzcUhKslIOoCITgL2b7lmuMwLgY?=
 =?us-ascii?Q?0eVuhT+l77hY/7981w7nM35y0NPFzq5Nkpepd7TzVfPTiTTOLAE157sMQ28a?=
 =?us-ascii?Q?Udn9hyA3MYaO+LzAApU68mJQdkfEeVVhuYB14QYr+T//3hve3l5NvpLNmFoK?=
 =?us-ascii?Q?0srMiBwOm5ToIKFxXFYc8r1DwCmXdYWEgx1wum2XANhMG0lvso8yRqlCNava?=
 =?us-ascii?Q?Y938dOH9/+YzkcOIkhN7hHWp7F9qV6VaMbqGseEzd/6cvdN+dFtqo4BqVXFG?=
 =?us-ascii?Q?Hdo5dC+a3YDxdIsAqFhvagG3qmqS4ptWkK+AXzPHLqvbMkUJBgPRZQACvEx7?=
 =?us-ascii?Q?384md032bmGP0HkrB8rthvtMUbc9ICh9pAhkMZ4sntbZhy2LrlRcCHJacBik?=
 =?us-ascii?Q?uAcY2Ntzk3kZ3A3oXnCtBQePRsVSrfVNlljay+7gHfVktXHyoC/xyWKdcmEw?=
 =?us-ascii?Q?wWAAYCLHbAYp6Vo6FhT8QAAE8WQevAmR9v/7AkZfMn5r57jElQqDgqU6gGfU?=
 =?us-ascii?Q?bYoBFiroQ1oFgkA8jVrX2B0idcsX3+eeZvIbbw9bhFzxJiFSfzBSqBtGXok4?=
 =?us-ascii?Q?h65SvHYpPDwkMxcrOgdVfTESu5sdJTuq6f8GLij9jkobmM+bmaIsJZDGPox2?=
 =?us-ascii?Q?Q0hZmSY4aw=3D=3D?=
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-Network-Message-Id: cafbe8fe-c900-485c-a1ec-08dee0b89d26
X-MS-Exchange-CrossTenant-AuthSource: AS8PR05MB7880.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 08:27:44.9499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WkHpLNwqPvCoTahPx42jj+CWqktL1eIQi6C+cs9NAmh/n6IXDUD57jliI/m903csmlyFQYG3afP5Kg5urswWuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR05MB11320
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
	TAGGED_FROM(0.00)[bounces-9930-lists,linux-integrity=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,huawei.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF97C748C23

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
 security/integrity/ima/ima_policy.c |  6 ++++++
 4 files changed, 30 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 6817ee53ed9e..10214f73ca1e 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -470,6 +470,7 @@ void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos);
 void ima_policy_stop(struct seq_file *m, void *v);
 int ima_policy_show(struct seq_file *m, void *v);
 void ima_measure_loaded_policy(void);
+int ima_measure_raw_policy(const char *buf, size_t buf_len);
 
 /* Appraise integrity measurements */
 #define IMA_APPRAISE_ENFORCE	0x01
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 92ca4d62c94d..2a0bca554316 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -598,6 +598,7 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 				    1, 0);
 		result = -EACCES;
 	} else {
+		ima_measure_raw_policy(data, datalen);
 		result = ima_parse_add_rule(data);
 	}
 	mutex_unlock(&ima_write_mutex);
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 1cfae4b83dc5..334e21be4075 100644
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
+					  "ima_policy_written", POLICY_CHECK,
+					  0, NULL, false, NULL, 0);
+}
+
 #ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
 
 /**
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index a6668329ccb8..3b0db2770ffd 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -542,6 +542,8 @@ static bool ima_match_rule_data(struct ima_rule_entry *rule,
 
 		opt_list = rule->label;
 		break;
+	case POLICY_CHECK:
+		return true;
 	default:
 		return false;
 	}
@@ -588,6 +590,10 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		return false;
 
 	switch (func) {
+	case POLICY_CHECK:
+		if (inode)
+			break;
+		fallthrough;
 	case KEY_CHECK:
 	case CRITICAL_DATA:
 		return ((rule->func == func) &&
-- 
2.52.0


