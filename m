Return-Path: <linux-integrity+bounces-9677-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFeZOuynFWqJXAcAu9opvQ
	(envelope-from <linux-integrity+bounces-9677-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 16:02:20 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4CB5D6FF0
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 16:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65E8430036FD
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 13:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C63A16F27F;
	Tue, 26 May 2026 13:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b="fcpfIgIh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021124.outbound.protection.outlook.com [52.101.65.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472131FE44A
	for <linux-integrity@vger.kernel.org>; Tue, 26 May 2026 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779803583; cv=fail; b=iw/23EK4lM7PtvCUueuUbu94cwbjZZOIrtpRiI/52tdWNdBG2yROij3UbAycNl7vFT6AyHHvt1hdEheCdjfX8+xNEtPuWLZ+cjr4Xr2EtH6HqtAZWcjrp5gqtazqY1Jf8qdMKL5/3R8ooAyT60eTHvWlABTiL/6w+YeWXiTa7hY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779803583; c=relaxed/simple;
	bh=lKxtvaJEJv1ogbpp//m0csMa7UaVanX3KugSWRXmaBE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=f5mzj73lFXWLki0ceoQj5ijto49d0vAG1bI++12CcydLGlEaXZvW7im9cx/Tw4FDHZv23j14qUzbOQlJGQl6KGeXzGWFE0tFA2pEXIGxXwkAntK/Bxk/bLKYYHZdzliJ4Ap+4ubYSRJR54CVajsoXdyIkIdy9DMRGrGOItaqmeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=fcpfIgIh; arc=fail smtp.client-ip=52.101.65.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=polito.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CD6SfBaGYjMB4SLy/lFpBNYCv9QSb4qUTxQTnOjUeOvO13umaX8ASAm/WI61ysMeum1FA+nvJdWlu9TuP3/tT4UiwB/0sr3yN0RFv4C8Q5ulMnJ40YZpYJ6xZ/1MYpotcFJfc1hjPIb63NPTImnWVbPUEjo34mBlnxRRF7NcKaYqJw7i0y5erPBqfDHnIdpezVCNRvArD0E9bxDid4GnAvB68Bw1CbeLpXLt6mVEzI+4Qxc69Oonux/9WnS5/i1r4Fgtu4wEceh1faWVcoYnqqlVwr3SOhMSHb7m5gA0wGjKRGWW+IDWfjrqOTBbjdRdFlnwOfGQR3ePSAdN5vDZTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mcPYg+mRbcz03A4QtThoLV0QtFEi/5H+uKQ7FE/UGzU=;
 b=gFnDb4lrweltO4At+oQ80Q5EyqkwZxdwoqIOVc622SwGFpRGzj4Bw/Jji7CA2wvNAjs7b9Z1iYK+a+VP/feeCmGqC8A5/WLHe++QqWOpT00fCpP3A26msZNmWAP2aIyft/5IQLZnY+lA2LCbdes3LC0pHKr+An3u/MrPakzno+jGHFmnzzAcaV6k308SdNMs9gc49eQccZaXPtoKDUCNLe9REZ9/tdyOpXwXuAsEo6l8UHrigUU6Hg0Po6MykaCIxNU7dS1uiTewUYeOwaDOAjU7whFFG/+cvQbyWkJO/c+uIh/5Bf9TRXsJ1l4YPAPqj7qpyb343gL6Qu9dKAA54Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcPYg+mRbcz03A4QtThoLV0QtFEi/5H+uKQ7FE/UGzU=;
 b=fcpfIgIhOM3+a78lOS3gtytTa23CJPWL+iLH7GvEzLAmu4aiEJ2UtKdugiXF9xNBbzE0O8L1SZA2Yoce4p4cS1Az1QFlj+6smvYDNjkocp0yQeS9+zO3PM4J83bxo28sIfWcDWYKkhM+eFw+WNu4deCQmaD5aKygUNFvprcmk3c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=polito.it;
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com (2603:10a6:20b:253::20)
 by AMBPR05MB12793.eurprd05.prod.outlook.com (2603:10a6:20b:76b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Tue, 26 May
 2026 13:52:47 +0000
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64]) by AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64%5]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 13:52:47 +0000
From: Enrico Bravi <enrico.bravi@polito.it>
To: linux-integrity@vger.kernel.org,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	roberto.sassu@huawei.com
Cc: eric.snowberg@oracle.com,
	Enrico Bravi <enrico.bravi@polito.it>
Subject: [RFC][PATCH v3 0/2] ima: measure write on securityfs policy file
Date: Tue, 26 May 2026 15:51:16 +0200
Message-Id: <20260526135118.289633-1-enrico.bravi@polito.it>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0009.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::6) To AS8PR05MB7880.eurprd05.prod.outlook.com
 (2603:10a6:20b:253::20)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR05MB7880:EE_|AMBPR05MB12793:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c7575c0-3b33-4923-9d72-08debb2e11a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|786006|1800799024|376014|18002099003|56012099003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	m1oPX2SpPOI1o66181j1mQPeRKlPmDRbpc3PwQJfD2oii8vo4rbAKK8YQj5BzhdG5jNdiMhU1zBKezocTSCEkCVZ0aGQJhbVCz2Fgr7pWLXb4TFMIPM39Xt16+x1ROTvD2KdrlZiDt1rtPNtLgUTd1gHOANLqrmszBkNXZAhuZd+PkFj9WRFYAagn23yH+HLnwwnBdTY/e7TgoUROOVaQimmZlBjpqf5udsRPK3HibaFhNW5tjSmK/PoqA9++UOGz/fu6J9FpWCPnGnQ/Ayv/t5wqvJ5gYAWjyETcaPeMe0JiDAGS0wUXN8ievBX2/51rwbzeiJ4tI7JSSe6GZmJzOsHvY3xdb6ztv3ntq7V5k0+4kPJtJQTL0SILfw/JdzZcrRCrxr6zk+4E713yweGbC8yVR7B4Rqp+ccpU/ko5lCge3QObAnTiqp/z6qt7GljWr3boGus3kgOB93vJFh/UmVyVUbbDrY7m4UTovKdQnVSwwUlDImRII0SefK7SlpMWKr6KzE6xhXxuptWLharBsMea0ywpbDjwGopFUzFl/ZyqCgf/GBkR67BAN7L8bgOx78ZA+zVBONSLyHy508Mf/bCZuw94SIOxp7lpAN2oFtmbvOGmMEFrCW/lHr3JPVDD2XmuIkXLBeF11FvMFGjecK6khCykK6fb5ZcUHScB0tI1ic6LJdiOHn1GIEL0NQp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR05MB7880.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(786006)(1800799024)(376014)(18002099003)(56012099003)(11063799006)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gT5IhpBmLWrADxmkhg+bxw5Vv3aV0LGf8odUi1LoqmAy3wlALHYdqF8n1NCf?=
 =?us-ascii?Q?TEIeRfYEhyV+hqsLab2SS4S/JTIkVUGKEOYYxRTQaF4OatTdK8alOPSDU/D1?=
 =?us-ascii?Q?mU08xdh5u9GKflCQT4DlPla7itbASRfl+8iw0o83P7MkBKZixfa94RwuuUb+?=
 =?us-ascii?Q?N8rF0Rkp5WLSQWRDp1ideTrOB8/MWGcce9kWzr5AoGXccpL24sb7AufYaqN+?=
 =?us-ascii?Q?Bsq/6NofPHCpUvoXydKA9TuP3MfdEP3yVhdPPUy0IqJ/SwUhMSzMYwIzJWf+?=
 =?us-ascii?Q?K4iVMHse09267GuyDd4xzmX/3nC3uQUdtEKrQLjrT1C5sQ/9GQpcCSLjRnOF?=
 =?us-ascii?Q?X0VU54nWzeaPs3F2o3DAq7CAnmc67bGZxR+JKCBMrbvYXy3pEMhjoElIaxxT?=
 =?us-ascii?Q?7Bu/00e/yb+HJ2Mavg6NQxDWGLZfqqLl4RRHkzlsRtFgNoAbGGpiRCqQIGnR?=
 =?us-ascii?Q?me1EXy4nvYpIWct8Te6zU5zFpwbZWeXT7gIrBemO68ip1gOwpvdT5UGyWgVP?=
 =?us-ascii?Q?i20wAjjvLsz9EZVlVcsLDilj2omMtkPy5b5NA8JjZC7pKzNLkxmtjZQL3nUZ?=
 =?us-ascii?Q?2W6ebRV7ecyzXTuloVJmEsHbfLUwoZAfiG6auqSSgkwcyh9Stf5rqEUq2GPZ?=
 =?us-ascii?Q?uwhE4+hGCNWDS5GqXGARB/VWogbXujmLRRm5LFZCmftdQgsq2xI6y8PgtVON?=
 =?us-ascii?Q?ZS9UxbFcZGftiXPosunnAvf+ZpxFB2VPWfHK1HNJmyFU08TndgAPIaK5e6nb?=
 =?us-ascii?Q?tY/NEcCBLSfHwql7/Jx6hXykQ1LUW/SXvBVw/5RNkwXkBFA4h9vJqv9K28mZ?=
 =?us-ascii?Q?ne+zwWoY5+0eWqoH86UVMV/ZYl4bN9lcmjWsKAT5MU43dzKzapma4OSe5ms8?=
 =?us-ascii?Q?MlseaRUCaAiD9ubLRRCJQc+oK61JDMPOYd3cbNh4UqSAMjWJf5LIcAIs2bko?=
 =?us-ascii?Q?n4JobkR/NgTQgmJ9pU+u0OFi2f7K/oDnO+UABnDkhjf6g9RqZMGy2zEa6lT5?=
 =?us-ascii?Q?6t9sPIcmOLl1zYbyhU06/mTI+Uabz29lSj6U88rFSXBR2WGlT2YJ4bqSyeTQ?=
 =?us-ascii?Q?K4ifJzDXKDmoFGKCln9WaTDGQ4RVufe6csxtIk0IpBC1AxDAynXEGostpsT/?=
 =?us-ascii?Q?TJGKqvuktqXj8ZUfpB/UxunNk5gvkxmJDdWG/YG5pUK5cdNmR2gSuoQlYkHN?=
 =?us-ascii?Q?E5BwS1nQ70o+sJJ8O0sDxXhiq1vLriQU6qzEy8+Z9kdXHzodFhXtGrtzYSqB?=
 =?us-ascii?Q?XDBBsggdEIiflJSoKtOKJ6aXziDilp+aQYo96JOGMoH3NAqPSmqxEuS9vod8?=
 =?us-ascii?Q?282W3EOA3i0WIveJW6NW0jikLRfTtamyOvSfwrHZeMt4R/msBEKwmBSC9siI?=
 =?us-ascii?Q?PJGF8DSaVFLKFemnSBOD2WlgkWmk5wH7Yk9DeS+XjYUfTJng2sLfe/Ao2v5j?=
 =?us-ascii?Q?i4b00tU45IxSGjvaXDLwe6djwNvK0lD0LcSx/HFN6NE5FYlm0QU4M2FOtGiv?=
 =?us-ascii?Q?gd1IbdxnrDmOTYmrxsfEfKWS0leZYoRw1DAu5VrbTLgt7sC0gQL+D8RQ830d?=
 =?us-ascii?Q?9FUv+CTQdaTQB9666Cze5grre9f0+VuSQ9IRPVB3/i0MAmM/dQxYgOKD0gca?=
 =?us-ascii?Q?+QmFVj2+YwlOb73GXOfsT9NHUqK98wBhb3uc4jCke3MLrvzGAtys3T5f1tTW?=
 =?us-ascii?Q?AVmjnH9vqbBJUVKa4jsqiDTK210ERnMqV7q0DGyWFtH5T4aOwYJ+KPFJvzQB?=
 =?us-ascii?Q?gHhV2vw4fQ=3D=3D?=
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c7575c0-3b33-4923-9d72-08debb2e11a1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR05MB7880.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 13:52:47.2668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqHk4gpFDnUGWcAcVDwdT7Yz/cdEithqxC11PkWM1We8k7ew0FEeo7FcVOCxlFdLvhwCEUcUFedHTsy/4XOKRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR05MB12793
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[polito.it,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[polito.it:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RSPAMD_URIBL_FAIL(0.00)[polito.it:query timed out];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9677-lists,linux-integrity=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,linux.ibm.com,gmail.com,huawei.com];
	DKIM_TRACE(0.00)[polito.it:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enrico.bravi@polito.it,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-integrity];
	NEURAL_HAM(-0.00)[-0.984];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,polito.it:mid,polito.it:dkim]
X-Rspamd-Queue-Id: 0C4CB5D6FF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

 security/integrity/ima/ima.h        |  2 +
 security/integrity/ima/ima_efi.c    |  2 +
 security/integrity/ima/ima_fs.c     |  2 +
 security/integrity/ima/ima_main.c   | 19 ++++++++++
 security/integrity/ima/ima_policy.c | 58 ++++++++++++++++++++++++++++-
 5 files changed, 81 insertions(+), 2 deletions(-)


base-commit: 028ef9c96e96197026887c0f092424679298aae8
-- 
2.52.0


