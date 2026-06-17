Return-Path: <linux-integrity+bounces-9800-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 57r3DKHIMmrZ5QUAu9opvQ
	(envelope-from <linux-integrity+bounces-9800-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jun 2026 18:17:37 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C6B69B523
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jun 2026 18:17:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=polito.it header.s=selector1 header.b=XhXN7UNJ;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9800-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9800-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=polito.it;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2060E3392151
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jun 2026 16:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D26147F2FB;
	Wed, 17 Jun 2026 16:07:12 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020127.outbound.protection.outlook.com [52.101.69.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECF0466B5D
	for <linux-integrity@vger.kernel.org>; Wed, 17 Jun 2026 16:06:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781712431; cv=fail; b=uRUBzUOqZkOwc9RaQwb/RH0U3/mK96fuI2cFl81sgZVY/v5i4y0i+CBOt/cUtxzh8+L/gJ0VgR+ACtfh25uDmGTE5GFcRd92DZI2OZQeoptnWyDP9V17ggaY5ngpo9wxCu60KFkGZvx+0a0GV8QFPLugQcdQXot87Ckm8z9weJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781712431; c=relaxed/simple;
	bh=eikSITp7fpQDhQ6wRP1oMQBYzJ7iYNvOamEdX4rg+WY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=oLzM28BS+sjqb956oYCKfquPXAdrY2D8MnVOXpW/3s/u84kjv/yL6+rzUPFhw8/O0IptKuUu3kEYdyfWyMhHkO8Xkx2w3VeV9sBGsPdOUIITHO5QJV7Qr7TCQTHX6YMQRaQ4aLw/xcdI2kRsynxeWEr8YBoFf+N3ySyrJx7h1LA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=XhXN7UNJ; arc=fail smtp.client-ip=52.101.69.127
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2kf/ZN0Ub9vruCBzBGv3XcxF8vlPfghKVUxeofnBTsYMx4OniK/cf48GAYt3FFiPmicKgkpdjJUDJCEHV8wkJZCiMBy6p1GLoP4RY5FQ+Cz2Mz8OYtRL0qJdfUuxhsVjPJ1MGTHFrRPIQWUclBHVuHjsfPdhOnVJc29J/SiWhnXV4bJGel3xmQ6yVDZKAnGT0VqTb6nt0OIAH2pUD2/+QLQRkyHXI+DEIh0MJRi4pZwZHa3rOYCCPEdWoYcBHoQStmzV64CFJrRjX3ZsM+A/Lero82plxxtleYPzqXddAgVRJbbkfgk+rkYIjfBcu2y/fVEjhKGYyA+UEUlD3QprA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlcZ/0KTTtm9fqfhOqS9isWyYJpuulqRYFo/V8KmxJo=;
 b=NuhOrgnDLaKlfbt6iXx6RkbD/NYXx/qa03ZIf+LoerN0tWfn4778D7r5UlQbvaUJv3afSSgLyyViE4eS9XFVMIoHBQztX9IgKzdrxnV9Kgjb9Moy8kELcmB2LkD0OwvNtDyiCfjQ2EhQ2bkc+647zlElBJVgi9VXIg9IhTLu0wUkXey+Mq/Sl+VHdMUV2vqW6BSXLSRw3FvyEI3UwZI1AymoxAj1JJSIPeUnAk+mctrW6CymNdZivkFuGfJcmDQmAd/o5aIDoF5l6dAfJdg8pYmHMx0YK7Fls2fawlC9VGDxy39olhp17wU+N/i4UWVHmyZ7jUivTs6516bs8pyDpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlcZ/0KTTtm9fqfhOqS9isWyYJpuulqRYFo/V8KmxJo=;
 b=XhXN7UNJBM4NzpX1TwJpI/1/p12FoXYlDucr3AmR98xsKDlu4Wv6MThuYImDUr67RTcdlLZb8GpoxUH8x6dAGFC1hAVDy6SqHoNHMKnWP/n7nUwWOcyOtEemTdQPtM7q3NPge3WaKTegbFB2Sj61bxR7cMBM1yOwlDGhPNi5/LM=
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com (2603:10a6:20b:253::20)
 by DB9PR05MB8219.eurprd05.prod.outlook.com (2603:10a6:10:23f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 16:06:53 +0000
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64]) by AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 16:06:53 +0000
From: Enrico Bravi <enrico.bravi@polito.it>
To: linux-integrity@vger.kernel.org,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	roberto.sassu@huawei.com
Cc: eric.snowberg@oracle.com,
	Enrico Bravi <enrico.bravi@polito.it>
Subject: [PATCH v4 0/2] ima: measure write on securityfs policy file
Date: Wed, 17 Jun 2026 17:58:31 +0200
Message-Id: <20260617155832.434517-1-enrico.bravi@polito.it>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI3PEPF00004E9D.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::454) To AS8PR05MB7880.eurprd05.prod.outlook.com
 (2603:10a6:20b:253::20)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR05MB7880:EE_|DB9PR05MB8219:EE_
X-MS-Office365-Filtering-Correlation-Id: 432b4dbc-da9f-45cd-9f54-08decc8a729a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|786006|376014|23010399003|3023799007|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	7VflKrpeCvnT2s1SrCj2YuIXpwcesvsLOTePNVYH6eF12bicM4Tw/5iGKq1y+KPgA3BYfI+x5gOMBNzFot4wnB74uTp6RsbSK7aBXstwhVET3sSYmiX3p7CupTdvN3Bue9B8Nx01YsOD2ZmqD836hiDAHAq+zJfGGARJKPqVfJx/8DGVLsZLnyrbYqcBFzLIl/PzSqL+5bVCiQJ0WNx0RR7ww7MfzeI8iEEj3gEnrKt+cA9WK+3AKgpZdWrESoZhqlm2RMAes77Urephpv2khcCrv1IMM6955Bwy5zyiHhO/n/rp0dYYCWbJxuUhHse6kINjD/DptKhpYx63SGrilOgb7nrT1gkkZ5jO1OETrm4DQqLi/75CXlXLLHMl84QmeWDlIZDs32eI16LGHUCRwNtRucWlo4d9N3KwpwjMsB8v98iKZfroT7fsZfNlsgESWO7HinYTUwRasRqOP8YFgutIgX+A2vkZaOdbx219eNpfyM4yM5nffraSK/te2IlXfd1j9I+83z81PjZEbvmpdcc7iMefynNhoy3gUZz8hyYItQ2RdSgaDMJAzAj2yWlqCJha5/CDOt2rVekCCYLYY0aUO0Hi02RRon19MHvN3XyezNQVYg91knuzijcY9IgB/o9vtLX7np7pn1MELlLmQCL4tvPI65iGYGSZzc3IG+SwVs5xNI5iSGHIqGFMxF/f
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR05MB7880.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(786006)(376014)(23010399003)(3023799007)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4Cf8vmwwD9CmwYrkR5dP3ydawxYYaKFNw+9G0i/xlqqGRSkZbF4Xa8Wpk7R+?=
 =?us-ascii?Q?XPLcz/pUNPVENN24hXnwoV+SnfCsi05JDsFacYW28XG7JVaY5zjaSaLcytI7?=
 =?us-ascii?Q?B0lnbUP/c/H3/AAzZLYjy4vy+/wfGvlXafOwO+ArCAj06sZ0+yzCGuvYGE3N?=
 =?us-ascii?Q?ffqqK0/cXGWLSf5y5lJrnks4m+hn9GCjHVIN+dIuK9xsogUBog3JFs/byGWU?=
 =?us-ascii?Q?2SaQn2DAi7fAMSB0nGe3EUCeoZHrJaYqtaHtXVUro3zdD4DDGAY0ag54vwcZ?=
 =?us-ascii?Q?sZNvvIONGEBMTPo2Fy/Y6vJ40Dm3hv5mijIdvKbYUm80yDvPnfraNorFMpqk?=
 =?us-ascii?Q?ko10jyU0u4qC2xOwXCXckOKsKnFoXH+Of6XWy7WkVglBU01xgoKBw4LLrH7v?=
 =?us-ascii?Q?slaxeEyeaG4rEK9taMHaeaMWnrkJ1UQ5RQXayEn6jNvnnZsD4jlQUtFu/sC8?=
 =?us-ascii?Q?DVKWGheSNdf9qYy2hj4RdtcfQU3b4H1z3i52IRZRPWuNfSYni3eXG0Yreg+r?=
 =?us-ascii?Q?zN5kyqwSlK4lqb3KmqseHySJ3L7yP2udJTi5h6JqJr6z55wDyrXulmcvTJ6J?=
 =?us-ascii?Q?AH4i+v6PGliwz1F2GnUfH0UJ8QfXTBSSak9Y5dK7XtVWnVU0CVPS0W80Sw/U?=
 =?us-ascii?Q?ftnfS0cngwjsyr6xI1tjnGcfCkYaRv621BtHY490Sw1OosCQJJTIKXciNHvO?=
 =?us-ascii?Q?F9zpBdtP79RK7iX2hwYZMQjj+6XvoikI5VBuh8xSlt2O9+mmaX4dyFLZhlbZ?=
 =?us-ascii?Q?bdw/sy7iG0scOKLssKcntv7GUviVKpxVt5ZOfm5WTVWJRF/9ocm6ZV1klknF?=
 =?us-ascii?Q?Hy9a9UgGH7inEOj2EvP0Wdv7ehSdUSeHTP/UzcXYBeWZ7NPXCZZG8CZZFhm0?=
 =?us-ascii?Q?A02T117kJZ0YtWA875SLJ6h++Ji++4J+Ha0jI8Tes6x8VdBR5PzkhAdoaUiS?=
 =?us-ascii?Q?CFWaeduU4hqKa5gQCqXkFsuCdQGNaAGQY/yNaGnX3Z0Pmt4iIn6vHTRdDGE4?=
 =?us-ascii?Q?hMZMk0kS5sSKnbr0G+3UzwQmRR9unDFhhqpHcc04d0qAVSBiwvbs+NKjJ/7Y?=
 =?us-ascii?Q?HsJP0t0kfZK+YgKFwCTbi2mQrfGRBrTe4KgOnWAeTF7X7A+yZCvSOadGhAVK?=
 =?us-ascii?Q?ytiq0CHVkz3X9yjqLcCe2gnYwYr9VQvtFTIyDnVRYKjy7mhvRmdjXX0/Zle8?=
 =?us-ascii?Q?PkRBBPJOdzj34C4lZmeRN1pgRQoqIgOqKIwjo9H5gI7qNigtNBZzNy1EQpIJ?=
 =?us-ascii?Q?2sFQa7mQIg+ekgW+k5fYawRpz7nESZ4gS9/Gpey7+rUqcBIXmLe9FUH4CT97?=
 =?us-ascii?Q?zUIdmFSg8T7x3ULnvbYAJPGsChz8ZDh78CSW9CcYMenOLS0wbXckpZ5IVGYd?=
 =?us-ascii?Q?cd5h7KGmkkePXNN6gt8NGJTbSfduqg1u3anGk50/KfRIro2WnBPaxLKTNvbC?=
 =?us-ascii?Q?10GlP1KB5+q7Mw2ih3YqMaK0fb6QwIm5dkxr+YnKgOGKuphk21iHKXoVs8wX?=
 =?us-ascii?Q?AOdqO4H5FOVlb7KkcrLCnW4rjBtD5XuXliqmIC2NqVVriSj9s3PinB41QTS/?=
 =?us-ascii?Q?EkcHGdGOXqLUHT2fFxTLIGFDHs/koVTY+9eDeVrZ1624Ys+PxzgntPftPjie?=
 =?us-ascii?Q?r1muBqzL2AoLTSp9ZLhiEV6y29zmso51B6G7IsxcPyu7GiL6dQOraKzCB8sZ?=
 =?us-ascii?Q?TNyS4ZnDuFfvoN/4Rpm5L4RjcoyaMqDcWvO5syv/IsvqIRN83UzMft0fYfiJ?=
 =?us-ascii?Q?884FXwDs2w=3D=3D?=
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 432b4dbc-da9f-45cd-9f54-08decc8a729a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR05MB7880.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 16:06:53.5010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4x3foj84lNWYbeEo5j7sf0d1hLa7676mylBMBOnYa6bzJtGsKSH1AY3vwsrKByEkj6rgHruKyVPsaNK7d7xFAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR05MB8219
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[polito.it,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[polito.it:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9800-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,polito.it:dkim,polito.it:mid,polito.it:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 86C6B69B523

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
  ima: measure loaded policy after write on securityfs policy file
  ima: measure buffer sent to securityfs policy file

 security/integrity/ima/ima.h        |  4 ++
 security/integrity/ima/ima_efi.c    |  2 +
 security/integrity/ima/ima_fs.c     |  7 ++-
 security/integrity/ima/ima_main.c   | 19 ++++++++
 security/integrity/ima/ima_policy.c | 73 ++++++++++++++++++++++++++++-
 5 files changed, 102 insertions(+), 3 deletions(-)


base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
-- 
2.52.0


