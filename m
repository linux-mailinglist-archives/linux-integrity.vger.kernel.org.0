Return-Path: <linux-integrity+bounces-9928-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qKkGFyOhVGrpoQMAu9opvQ
	(envelope-from <linux-integrity+bounces-9928-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Jul 2026 10:26:11 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AACAB748A75
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Jul 2026 10:26:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=polito.it header.s=selector1 header.b=RTtnpcL3;
	dmarc=pass (policy=quarantine) header.from=polito.it;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9928-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9928-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97360301DDB6
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Jul 2026 08:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FE63988FB;
	Mon, 13 Jul 2026 08:25:02 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021087.outbound.protection.outlook.com [52.101.70.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563733ACA5F
	for <linux-integrity@vger.kernel.org>; Mon, 13 Jul 2026 08:24:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783931102; cv=fail; b=CSIjGoE0m15iW5a5MZCkh3B9fs0+l1Tj5X3IqqrbCViwVpxRaw/nJVTtK0HHlDfOBp2OyQgs/u2tMN4y5h1JVU/JiS/GMSgR9jCNeyDeKJoGCIrU9afPOat+Lz6pt8fUGT0AudAa6ajntIWtEFYZSqR4Q5l+HUiw7OLpbPC/ch4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783931102; c=relaxed/simple;
	bh=C4q4SMAB866Z53twc9//pV30zBcxE75MEIEUS6aZsIE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=q6ZT4/hG0qsWIXQa9HQPndTcrEY3mlCHO8jE0lIbFnEqf/3A6nHqIoRtMpwNRZp9WjgXX8tuP98jMBqmhy/5pczFyRqTtqG4EKIZO40FafX1e6623BTUS8vYXcXpTmdyBGlhO+fvT66K5A/YrcrNsi3y1kdPYgqEIZICQg4428c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=RTtnpcL3; arc=fail smtp.client-ip=52.101.70.87
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QLWvqRpuD/LpiZ0v6yLEzdvbmjArQjkrynscPE/6KO5MaAIKlKDPKEuErqCyczr73zb0AJ4CARsDdv+msUh891mLiLrwHdASef9qTRRkc52mXDPOYQIrCOZN+ggYzlZHa+L4onZBPK+mBP5IVuMv7ROTWikaMaVUHLNkfFWGdn0phrlD2ymPEpa6b+oxk97KZ395VqGvI4a0xrrTpbS6J6/dAG7HAyea9fbuNrbBrBsv0gQWI64wF+NIF0k2SUTWz8msvTbC0a8l2SNb25k0ifhnbFV0tyOzU/Z4EaefjUAYuN/hUpEariPFOpHzhvy8vd2CYiTqlP3SeMajxjqeXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/P/qVOQ2zcC2VJ73qoLAjgUrdRsq1/yoEDXLpDmqdA=;
 b=o6bvbWxGeE4XBfy7OlGPO9WlUNT2JZIVuDjUp3oFtxRptQ/3yjCSkuWCRfOzuyxWT4NmYvkcIbNrHUVBSdoKzsYsHHRjNlA6EfFEYWJTfOEbuYuDoC1Edo90D3qsiHhSrflwSIJlcZhHArSxLfTUpFDALro3lUpJiLrZ3YbiBeLUQ3l6LTt0i1WHZ44EGEWHR3kR136yPhkWGi7HNz3nIq/o5eBnIcB+KlqxVyUt001MUvc7E7pt35DGeGjxuiDTQbksREuLz1ZbI3Mtevc537Syxtp+rLOuryCJVexWPYvjaJRJ6q4qpCxH38Zh3B+ZazHJWkVsqWnm2aLmRWvZIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/P/qVOQ2zcC2VJ73qoLAjgUrdRsq1/yoEDXLpDmqdA=;
 b=RTtnpcL3g0fZUAZpgHq0BvxH5ZynVNcsluPL+OXaMGZ4MlCe8Hhsr2p0yQcUsXK6/gxf+dZLeUhRheB8qiwIc5WXfB5/aWsnPX38bLLOJ0Aizq/8EMf+PRe2LihWpp21jTzq9ILV6DF/cA8mKuYtKdZoEUf70c9OgilEMYpq0bo=
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com (2603:10a6:20b:253::20)
 by PA1PR05MB12078.eurprd05.prod.outlook.com (2603:10a6:102:558::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.23; Mon, 13 Jul
 2026 08:24:55 +0000
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64]) by AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64%5]) with mapi id 15.21.0202.018; Mon, 13 Jul 2026
 08:24:55 +0000
From: Enrico Bravi <enrico.bravi@polito.it>
To: linux-integrity@vger.kernel.org,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	roberto.sassu@huawei.com
Cc: eric.snowberg@oracle.com,
	Enrico Bravi <enrico.bravi@polito.it>
Subject: [PATCH v6 0/2] ima: measure write on securityfs policy file
Date: Mon, 13 Jul 2026 10:09:54 +0200
Message-Id: <20260713080954.28520-1-enrico.bravi@polito.it>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::10) To AS8PR05MB7880.eurprd05.prod.outlook.com
 (2603:10a6:20b:253::20)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR05MB7880:EE_|PA1PR05MB12078:EE_
X-MS-Office365-Filtering-Correlation-Id: 1922c224-2d42-4ae5-8e2b-08dee0b837de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|786006|366016|18002099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	3qohARMCSus54dvWZf3fWUlEgEPdPv/Gb52q1vEzNBFv5W03mNNsFiPxDVEnM7zp/V+dx7D4ZGkuJ5IXi7Dj/PjjQ08rC6QVNlbLdrcwgz0mu0o/8P3HeBAAQe/GMlfQKoQygrj1Eva+snEnOZJbIJeK7HGR3XYc+JVtd8vd6V90M9ukKOJR4RUdu83yuC+ZXIpT2GX6uizoPhYVW3MzwVU6LiZBMxdEgKMav0yCztYMK4sDwYQIZtJisXcVjU1w9TN1eEXnSdkkEol4WDyKxzRajAyBBRIds4kE8EDiKRvyLq8mYvQqrsSwoC5PFv++DAwWLHJUTTcDOVA2kaWVsP3bvvikqTz0LVx0fZhJLRGCEnpif9+ge87guV5Pfr+3JeOCofn9B5/hHAxsvXPoFjClNi59qgnmfxIJB/tIDk/SWIGrhvf9tYzYNgN/uUQt803HWgTWdnruPXiE00KLyzd3rxG6vW77xhhNzH3Z9QT+QsCkIT7b/y5MGaMCOGa1yUD0wGDlLYsFYUT5YJYTLkak1bsLDd8yzJ1k3WRamSDIB5sLW1u0ajnJVcnx7Ta5jaeh9Qql3PvHeRG2Cw3cC+8fY6NvKECeKimwqvuxvmPnCi9UzW5TmdgvmWnsIqOzrDYi0xBDzk/7n64ijzpM0JMO7gg3BYconUP7BKmH1EI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR05MB7880.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(786006)(366016)(18002099003)(3023799007)(11063799006)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p2W3C3GM7k+0E9e7eaTwbXh95MjuKn69xSSrc3BIUhb39Iv6NPjT1O+pgoE4?=
 =?us-ascii?Q?Hm7AsskWnyNu+APdqhT9mqXO9HHwW56UaYFj+uIUZfQJk+rxYMU8YNQnsB+z?=
 =?us-ascii?Q?brSAbaOoqEln2OmYpa+81B374Go3bqH3W38P2xU1NHGIn+8o5mB8wPTe1Hu8?=
 =?us-ascii?Q?Ih/yZu5CrA9hwv0OmHXkGmrilFBp/lnXJSuFcG8md1nYqZPOXf94uMhvmTi5?=
 =?us-ascii?Q?1nK18WsUPtDvJQYvjr8HU71A+iBnMlWmZSWlZ/ykSCM7VumlmPwnNPrSh7Fv?=
 =?us-ascii?Q?miCm8+HPZnxu9nG6nLNxFXK6iYz7tqoRAck4pyP9Wn8QDvEPDVr+K7+4FUsY?=
 =?us-ascii?Q?WXUGdIZ16CK6cFsT8BdfYlT3SRmTvZPnXGLME+JD9b7/TGgSZ5xBoy6wt+kN?=
 =?us-ascii?Q?51WL1FEyBQpIv3VPlrlNiYMGH04BIZHAgkYgDT6rBJkvW+jbiJJdDSDTWR43?=
 =?us-ascii?Q?QKOACJVv3jvztYdA7sbBLHwxsgAZUI1STi/k90MOlN6+xV56FagdzPYYmcYa?=
 =?us-ascii?Q?m43vRmhIrwy43HZ21eRFqxoN1sT3UQIU8r1bp/lq54lO1WivVg7cp137SIEw?=
 =?us-ascii?Q?IQL//Scu2cWitxsgdml8AM5ok2Gewl0656B7djY4UPggSA+CRNXvO3Ja9L8a?=
 =?us-ascii?Q?RsdBxb3RjJ8ygzweSICEsDHj96JG0eyy1qKYwMmEwsPvqqRp5bLf0Sqv/KTM?=
 =?us-ascii?Q?jtnkMRAcUj2oLS1B7bAWRLK0Y/tJ71U9gOQkOdppRDZhXzAkUXULL0RQwtRS?=
 =?us-ascii?Q?1qL+fm87j0qUnZA7u1eqZ3oGNvJ0D+k74vTi0YfGn01W2T/nTF4YNfFl94Qq?=
 =?us-ascii?Q?wK49tpWpHZX2kpA09QjcGR4LkyXOBVloCDnZj94apSsLCSK5ZG8t8nMGyySZ?=
 =?us-ascii?Q?BXykyhAsf8pcc/QC6ud/5LUSr1gN8++3STicYCWNVEPHdeK1cnY+98+PJQ31?=
 =?us-ascii?Q?M2gGgTsVZ2nXFfboO/JcMRJ1A/zSWF8lb9GxftyFrfsYfn4wd+OYh/53TX3g?=
 =?us-ascii?Q?PmWJTb810wn1ig5+fYzl1umZZCQO+nq/Q5DQ8ErZcq0af01DJJWEka2iLSPh?=
 =?us-ascii?Q?xjZ4Ce7Y2G3Mpw7+ZurvWPINm519YgsqDG5pNVZJrKOS+4atsVXyTIbqVWTi?=
 =?us-ascii?Q?0yEQekcRWuRvWthRM78ITL3IiAv314HQCQYdk+on8k/jofBAaGfh7jyCReEZ?=
 =?us-ascii?Q?rSnxKot30U/Jte3g2l9cFxDOsB22iJFU/i3A02yWg3Wurz1gCXoYQ3/vzXc8?=
 =?us-ascii?Q?04zBaVdYMlfegbOpVATwb6nDIRFxWAvhjrxecaTqxA09yOYjZE+OaISfWDEW?=
 =?us-ascii?Q?DlKFzL4dHuzmqCmSUyta8bdXwdIdH3K2ncHCj5YYhZ4KAggcHZzUJkocJEbH?=
 =?us-ascii?Q?WrTgNHp6/KKzVe5gBHuh0Y7zXM9IBfay6CVp/dSGT7jzjcblvuLG/LWarWTD?=
 =?us-ascii?Q?iooeNnSi1QKN7QG2wLgx1oDHhHTCu2cM66g1W/U1xvPZUGyJn//FlxNiG/xz?=
 =?us-ascii?Q?oB7wBSOZlMBhGrTjXFCRs3phpIDOAwmGLOri/6b4zP+oiDDqXhyhvaQLFfbj?=
 =?us-ascii?Q?Op337uad5p17AwICWYW83HGipV3kVsSeuDk68SoILm7WzE0VyUQSPZu+f5Pn?=
 =?us-ascii?Q?sr6jh1cKBhIqfxS3z3+V63j4PYYZMr7xcmXhOy76VZo59xtcnqQESCe+r5Vc?=
 =?us-ascii?Q?i0uKMbQ2R3kun1M9Q4wBqcVwWbygw7ha4n3VNyU2btWd45ONqr6ycLnFm7jY?=
 =?us-ascii?Q?w2bD5/v2dQ=3D=3D?=
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 1922c224-2d42-4ae5-8e2b-08dee0b837de
X-MS-Exchange-CrossTenant-AuthSource: AS8PR05MB7880.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 08:24:55.1139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vLtDzX6L/gybaFZqUtgS733V7oaBttqUHAobcbt1QBpeX2rfz7+eaTEYIS0BoRFu/ZVAt0PPEIfZBPVl7Bu62Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR05MB12078
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[polito.it,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[polito.it:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9928-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AACAB748A75

This series aims to introduce integrity measurements when the IMA policy is
written on the securityfs file.
In particular, when a signed policy is not mandatory, it can be written
directly on the securityfs file. This allows to override the boot policy
at the first write, and append new policy rules at the subsequent writes (if
CONFIG_IMA_WRITE_POLICY=y). In this case new policy can be loaded
without being measured.

The patch #1 introduces a new critical-data record for the newly loaded
policy. The measurement is performed over the textual representation of the
new policy once it becomes effective (after ima_update_policy()). As
suggested by Mimi, the new critical-data rule is added to the arch
specific policy rules (only when a signed policy is not mandatory).

The patch #2, following what was suggested by Roberto, measures the input
buffer sent to the securityfs policy file, regardless of whether the new
policy will be accepted or not. This is done by calling
process_buffer_measurement(), enabling POLICY_CHECK in ima_match_rules() and
ima_match_rule_data() in order to catch it when 'measure func=POLICY_CHECK'
is defined (e.g., ima_policy=tcb).

Changes in v6:
 - Fixed a merge conflict.
 - Initialized struct seq_file file.
 - Fixed some lines longer than 80 characters.
 - Moved from vmalloc() to kmalloc().
 - Corrected POLICY_CHECK behaviour in ima_match_rules().

Changes in v5:
 - Changed patches' subject as suggested by Mimi.
 - Added max_rule_len variable for tracking the longest serialized rule
   as suggested by Mimi.
 - Updated patches description.
 - Changed ima_measure_policy_buf() name to ima_measure_raw_policy() and
   updated function description as suggested by Mimi.

Changes in v4:
 - Added kernel-doc for the new ima_measure_loaded_policy() function as
   suggested by Mimi.
 - Increased the rule buffer size in ima_measure_loaded_policy() (suggested
   by Mimi) checking if seq_has_overflowed() calculating the policy length.
 - Acquire ima_write_mutex in before calling ima_measure_loaded_policy()
   and verify lockdep_assert_held(&ima_write_mutex) as suggested by Mimi.
 - Initialize file_len to zero in ima_measure_loaded_policy() as
   suggested by Mimi.
 - Changed ima_measure_policy_buf() returned error from -ENOPARAM to
   -EINVAL as suggested by Mimi.
 - Changed event name from "ima_write_policy_buf" to "ima_policy_written"
   as suggested by Mimi.
 - Updated patches description.

Changes in v3:
 - Include the newly defined critical-data rule only if a signed policy is
   not mandatory as suggested by Mimi.
 - Removed the ima_policy_text_len() function as suggested by Mimi.
 - Moved policy input buffer measurement from process_measurement() to
   process_buffer_measurement() as suggested by Mimi.
 - Changed ima_measure_policy_write() function name to ima_measure_policy_buf()
   as suggested by Mimi.
 - Updated patches description.

Changes in v2:
 - Set a new critical-data rule for measuring the loaded IMA policy.
 - Add the new critical-data rule to the specific arch policy rules.
 - Add patch #2 for measuring the input buffer sent to the securityfs
   policy file.

Enrico Bravi (2):
  ima: add critical data measurement for loaded policy
  ima: measure userspace policy writes before parsing

 security/integrity/ima/ima.h        |  4 ++
 security/integrity/ima/ima_efi.c    |  2 +
 security/integrity/ima/ima_fs.c     |  9 ++-
 security/integrity/ima/ima_main.c   | 22 +++++++
 security/integrity/ima/ima_policy.c | 95 ++++++++++++++++++++++++++++-
 5 files changed, 129 insertions(+), 3 deletions(-)


base-commit: 81429cd0161ae654454c2b277a1db2c0ecb7712e
-- 
2.52.0


