Return-Path: <linux-integrity+bounces-9874-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Dan3Ib64RmoRcQsAu9opvQ
	(envelope-from <linux-integrity+bounces-9874-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 02 Jul 2026 21:15:10 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFCD6FC75B
	for <lists+linux-integrity@lfdr.de>; Thu, 02 Jul 2026 21:15:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=polito.it header.s=selector1 header.b=Y1W5T88P;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9874-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9874-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=polito.it;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF391302E784
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Jul 2026 19:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1CD38AC92;
	Thu,  2 Jul 2026 19:05:16 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021125.outbound.protection.outlook.com [40.107.130.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F61385D7A
	for <linux-integrity@vger.kernel.org>; Thu,  2 Jul 2026 19:05:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783019116; cv=fail; b=dXgQbsyhNBzOAauyUono7PhlF/ujMAdua0LYb3cT/Jw3kxKbyPRifvkeyfxfrVnzWnYzVWBszKxfsAlWkFCVxsDIsZ6Cn0kfGQscUQskREel1DQaZYkjTejTTi0Wh+bKdUTSttZnn9sW6hMHFbPBjT0XYrWpzY/YGRpjfHHkr7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783019116; c=relaxed/simple;
	bh=JpnMBG1YTmJMEhIaKJN7sAhFY8GuIHdOWu1N2AGTPrA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=qIVo9iXgCMSBS6GP3pbUCngtOfG7YkYy8mR5WatXAT+Otaa2iiF7MClKMvnTEKOtqAi6/gTl+yi8GkzthsAKyXhjEdWA6WTEdmb57pUmy/mcfAUWOFv/3iJAZUswrCViwinSl+4zZB8XHM9MVUqRtLSUmDdIcWvochpvZSMo9pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=Y1W5T88P; arc=fail smtp.client-ip=40.107.130.125
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QOE/7k9t9YDYBFhM2XgocsQj+NBM4uE3Qs/PYNDd5Di0VILhXDb6kWWSgYZkJtzc7BCQ/nTkwhnNo/VuMmyYm9PnWrt8tNtpoHOirq2bVDYjl5kR1wVilEOdlrKuef58OXrJs9DP3wFTd0eBmJ9GW13l5A+q8TonCNNXNrTP/L35O1+mShqF6bAow5TQgbLefvWuksmB7hQc9Bwg+hD3tyJU6+wVgwR2KE+J0H71WlWjgNjvXW53B6t8frDLvqNnW7MfeBPem9i7kvL1ZlhiiNNlv5780nr5IJ5/2M1JAhb8PdRcP4+TMjct+fuwqq+JafnWY03o/14yi959jOZnZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X13pSXF0566B/+L/SWFjDr+8O12dxVuUoGoCQ5CzWLE=;
 b=pVwNgWVMO59BjP9Ibe8MrgzTOwMPpmAm2xxEfIsJyXI4pLIqBbIeOUXkgm3SO0ncoWKv9zml2y5TbtnbEXVcyUHiWIzVw4m5IeZrP9gTcSfuwQXmHXzm4Ks8msY6nQcx2Zc6QrGwnCsi2Iv3bhlpJTRFbAtYEJufGdtTqRuMaU2bYWz9qDieUD9029D77fr88cCymHvamiw3geEF/YW473NcO4fGzm7qeLbPpJjpVslWi4BkBiql5P6QEtsGgJMBl86EUK4GTstAUYCd9BIQ/R0m+KtxxrbV+jpB4mDn/ViEFTLGJbiqpHKJMVM1611hkxRhrkt81bqPMlABdKfz5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X13pSXF0566B/+L/SWFjDr+8O12dxVuUoGoCQ5CzWLE=;
 b=Y1W5T88P25Hu9Bzn33fXoYCE0KUepUcys3ous46DRYYZomWY415u8YRt0hYYnaCf+/8Hv6Xi7n+vBzUqIjPNkA5jJ8H8j4PLcktIwV+QDlnLUxNhRb1medqe5nXpDgMDGCsGR3yUy8aRxwxUxsgrCqcHYVmtpzosSTG9BzJCbU8=
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com (2603:10a6:20b:253::20)
 by VE1PR05MB7517.eurprd05.prod.outlook.com (2603:10a6:800:1ad::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 19:05:04 +0000
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64]) by AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64%5]) with mapi id 15.21.0181.010; Thu, 2 Jul 2026
 19:05:04 +0000
From: Enrico Bravi <enrico.bravi@polito.it>
To: linux-integrity@vger.kernel.org,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	roberto.sassu@huawei.com
Cc: eric.snowberg@oracle.com,
	Enrico Bravi <enrico.bravi@polito.it>
Subject: [PATCH v5 0/2] ima: measure write on securityfs policy file
Date: Thu,  2 Jul 2026 21:04:02 +0200
Message-Id: <20260702190403.5844-1-enrico.bravi@polito.it>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0001.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::16) To AS8PR05MB7880.eurprd05.prod.outlook.com
 (2603:10a6:20b:253::20)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR05MB7880:EE_|VE1PR05MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: 44af888e-917a-4667-d643-08ded86cd306
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|786006|23010399003|366016|11063799006|3023799007|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	UD9GD4a6z1eMn8uVMDn3ngo7+vGDp6qDdhZch9Uu65JkGEKDPtM8dQhPiahgDyx5rat+FxBtiowR/zipiP0/ty0qgJJE9QU3LETkbo7Lv7782lIS9dHQmxHh8/F+/KEkL6oAiYZrVFWbj0hPdreSefjblCrjf7DyFQIYyCJkN+XBR9bgthGCD5NOIgdf/r8ReH3wJHQnUt1QaCaNZntxWJm7bIYJ77Tfv1+nmdLfxt3dbqPc5KUPuyLqMhOXTexo1+VzspQGITRJaVDxUkcU776tm29c/TCOpnz7S71MUvGfH2kpPCRoVaDlavJLJivEnOJNKjebwFsVkNLD9OPy0DdOW22hi8DPS+lkESuIhDJBtQ0jjGCd2m07poK8U7hArzByDty8LGeeHXowHgq1GO52FMGNREo8PyoyxX0Sc1Cni5lzylQzjAnbs6Tx5tFS2O+nb15YHHQ8xVHOEqqTcNurLwkps9OFZ89wWPj+1Q/Ho3Ka2zfZH5upinXbeuiPd7vIUVS5NLLq9rkB1In/HX1IRxhtaUcD17zjTrHu5dnqOVUSBVU73sa6j0QUQb5YyFYL32pjmgahKkM69Dr+w8CeK9V4U2Qtj485GainRpA7eMAPkK9VZFly4BKPETaBi8og0gfuIINf6oy5aeJtPm3JUHRstP/6AusRoFsLvn8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR05MB7880.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(786006)(23010399003)(366016)(11063799006)(3023799007)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?20+iehsIZCD3B8r9OAJ53apQVmGOrsoGCEKQvWcEf+emPia3nSTCdnJ1InkO?=
 =?us-ascii?Q?/BeelgOOMNu9oqdLAAI6bd7LMUIq9twCXIix4TZh7sd8Oc17aVonCicbwpI4?=
 =?us-ascii?Q?iWgS2+6C0BidsD8o/hqLh+cx7rarp+X76xne7PUywoU2KiefcsV+D0+hQVT9?=
 =?us-ascii?Q?k2ktix+nugvn3LlnpLirlsqwfCiOHhEoYCKpj0X+LVmI8R2qWAv95uZqEpMm?=
 =?us-ascii?Q?bAkth43R6D7JO27nVgyMqFrCWD00R0pzZxBRjIuwN9kbpTF8VsL0AIfhBn2e?=
 =?us-ascii?Q?D3CNU7ybKiuEsvprjHgqvGZxAlBIDvKRxrhziskvMCFFAcilyWomUIbwZMp0?=
 =?us-ascii?Q?NP8BeATiQQxSpOd1xFKA1BLZc+pI1119OM9sWvdiQoLytOAEqh+/6xqrRHty?=
 =?us-ascii?Q?LWVfJrDHjjwHLe+REqr2HRqsIK/HbQmLGPvuu+xh2IMGdI53YARYqFLi7xu9?=
 =?us-ascii?Q?D8LwrZm4Y4pE0Y3QBdtmYl8H+3TzioNXVB92rIvqgFI5xUsJkT3fDxvPhfYL?=
 =?us-ascii?Q?IADYKmLuu8bJTAqf3DcmLTay445qiIiRT/uODJ/EOjjSN/A0eUY/M2Tt/xa/?=
 =?us-ascii?Q?UkKUIJ/ttSR3uyAXyazbyyXE42nKsDlF4x2uo4UWTuzMjv/ySppYO7LdW5r+?=
 =?us-ascii?Q?Zr6KDHRZhEEclXuDd0+n/7RdsXOVyFz9yYK4c2FskFu+k3AfMzEZgNweof09?=
 =?us-ascii?Q?MnMLoECc7KjlC+lRRsUE7RPAw09Uxum2JCUEwWVeAeDORMMruLm4NcKYwg/y?=
 =?us-ascii?Q?ugkTkMJxYa47SPJYt2jPPmyjLRUQjxAEiRqRL7C7N9/eZaQKSIv/IAKD2apM?=
 =?us-ascii?Q?RGclO4hesWtaTjE/xt1X2R+xWJgOpO0TdIwXTkXO5JxgwmeApILeDga9YAAj?=
 =?us-ascii?Q?5h00OsaWYXSNw/mxD9yr48XfzDgqqCUbmDETrfI24ythGAnjdPVrTHPy3WsF?=
 =?us-ascii?Q?39lOQWz4kPAWJ32qIcrlymLGwIvg74EkptE/lq7JP+uDq9aJj0Spyy+op7nv?=
 =?us-ascii?Q?rvtWgwbuKw77Y9hsPet7bOuTDfqrIXyJuz+8p/CKhRBfcJFfAJzL5MmZvqKl?=
 =?us-ascii?Q?ezKuXImDDfBWD2FEmoaSnI+OXkzxCEKSnKcs5XoOZ3v5N1bk2D75iuq3iCmg?=
 =?us-ascii?Q?wWcyGEWBVIyyxtf8IRXu874KSuqoMQcIwLLILooJLM+mInXPaK2XxZBZWLNs?=
 =?us-ascii?Q?EY/paCYs04Bj1RO5v97beSEoNYvYG/w1NMuhq+vhAHdUTJgDxVMP1OiQe2WT?=
 =?us-ascii?Q?EmUBasxno+oHDbGzMJCdqr4DwTPKj4bWt8zVlYjkZn++ibIN4wevNWCjxmAN?=
 =?us-ascii?Q?FMSvrUoknPqWTlDKGwrvj20hrVsR7wyKZsHY+3dTfFoQiRXuKd89qDobJ9nq?=
 =?us-ascii?Q?OyDallioYKuuh96B3J5cPay9wrFp5lfZhDp6PGGz7sJfqV8D8RkG94f6pdT3?=
 =?us-ascii?Q?LZmaj+XDlfcxV5SNqg7UPj0Wu4LFjIH0jwgG79c3AJ416Zb9VarbAJFm1jCV?=
 =?us-ascii?Q?bBdyc3lhG8xUOzEFtai/7wt+1nxF52f4UrRRrHu7y5DUf9nh9WRXqDo+xSAS?=
 =?us-ascii?Q?Rj+Yg7/i7Aeqlv9B7I6XPTtUi03npO22J+6MM+8g7EK6THfKJbhxgOvU2We6?=
 =?us-ascii?Q?Q40AJkNr3sWxz0i5Lw0TrN0WilSg96b5hADeUahBr/iMp7lrdgd3/JVrUExs?=
 =?us-ascii?Q?njUBvo5hNPAjxw8fxy3sD9BnW8p//pIBlCzJQy31A9O5WnfpTdmRiQQgDzGN?=
 =?us-ascii?Q?3po4p3wwbg=3D=3D?=
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 44af888e-917a-4667-d643-08ded86cd306
X-MS-Exchange-CrossTenant-AuthSource: AS8PR05MB7880.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 19:05:04.3194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6u2yX6fFQOT5AgLxB2th8dOOEPFjUrRRD9s6gs/Q7ACYreBQHoNlAHBkrhN3ALlpCa+i1cvXeHPqk9cuIYGakQ==
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
	TAGGED_FROM(0.00)[bounces-9874-lists,linux-integrity=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DBFCD6FC75B

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
 security/integrity/ima/ima_fs.c     |  7 ++-
 security/integrity/ima/ima_main.c   | 22 +++++++
 security/integrity/ima/ima_policy.c | 92 ++++++++++++++++++++++++++++-
 5 files changed, 124 insertions(+), 3 deletions(-)


base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
-- 
2.52.0


