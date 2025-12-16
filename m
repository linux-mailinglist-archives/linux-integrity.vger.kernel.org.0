Return-Path: <linux-integrity+bounces-8075-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CD79CCC4877
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 18:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06D8B302C8E0
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 17:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2A52F0C5B;
	Tue, 16 Dec 2025 17:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b="bbtOoqUB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023101.outbound.protection.outlook.com [40.107.159.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5825B155CB3
	for <linux-integrity@vger.kernel.org>; Tue, 16 Dec 2025 17:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765904467; cv=fail; b=XrCDRH2Y2SHJhssukV18s4piqZbQvAeXKQoSy8aHAlB0DRi5k0pXSGsO6Y+9xBrFuGBRwuT7i3Fy8lYcLn4lNmGJraKwQ3BUvxe9NQh46nUambNdjR4NghaOMDP7lSrs1UXwQhHI+5UX85sU2kb3YxMu82JAZVi9dxOLGfBKayc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765904467; c=relaxed/simple;
	bh=fjZrb9bsXhq48o4dcEugskzSXlm+IgRxl+w3Cv3Ke1A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XlDGblT6HvQljhsRK10nuqEOO+VdAAiXuPZWMSLvxnIBqA8qLWefsh+SM2DH8ffoTIJTczZ+Mbn7aiFsHiGyZKY22mqUtgRMndRNfAxJNPKcy8SDLSIUL2njzDOse+cwpytJS/Etlp4UQPiOcZI02g28aYeGxdkni6tatRN4el0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=bbtOoqUB; arc=fail smtp.client-ip=40.107.159.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=polito.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UPQtzPxivd+6MBROP0FQlfFses4AYOKGA9K3xUTz2ob5hVbfw2gxAI9EqA5X+N1uCbLdbA40xHGYrXbA1x3k/51MSJN0cCfLmvS9PlEGRNm1um2CA4SzA24i6kxXZz87q/jH78jMOBpz6PMlyWXP+7WM+TazjS5im3QNJZqJq6cqwcKvgXhjqDt8Ysx7u46ucptc3qnuJrGtVKmPqUvJaQu1NQ2D8sULpbdb0ltVSGRIJoU77jRn7wOpGIse75vtvkFG8smgJw2luXS9gW38gsRhkQROfutG9Gljg9WHPxTnG8wxITy5n3oFlWswu1cLKP/hHk2DPZHT1AzFxge9mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3B8lNovhfs5sGNBONSmqTDwg8KSp0y6q/drewgttJc=;
 b=QwIRxMWagQ5s/2ZslRNEeGtASMXQJz6yGppYcGyFtMWvi9x7amtsgun3KNlz3c31X1dxDLzFJaKCL1/saC57EGV+wppPwvnAMi89C1FUzCAialToKedj/Rk3+EDYSMcdeK+8aadJq4qgsirRzmRbJ4BAp9YHqQZDUjEirGWJOPvUP6b8MlQgNM0H1idctVZZ6hPR8Cp7JPyaKo3D7i1IEa0IcN3f9lYsZPIZpFlRPRzNQbbT7VtK1NLxJSt3VDjSOZml71Pg4ft+lP0POskvil4BgcW4AeJCBm59Ff1mOBxvYq4PHIKXyOo58Mvcg32kTmpu5SKG7sOjEsU+4h7O7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3B8lNovhfs5sGNBONSmqTDwg8KSp0y6q/drewgttJc=;
 b=bbtOoqUBmbzD1HildkFamZT16j5qhvav6yo+74SWTJq05xtWoLPEf6ay1vBfOMVYJYNpjxK6Ps/KmNr/uRrWHcNDGYN/lbkKnvSx9yGUvYkYGmznfDYCsnRR3pgepG2l6/lVB6TvQaTnAfCuC2kTFqfPzqu4crr8sYjycEWZsgU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=polito.it;
Received: from PA4PR05MB7776.eurprd05.prod.outlook.com (2603:10a6:102:d2::9)
 by PA4PR05MB9684.eurprd05.prod.outlook.com (2603:10a6:102:265::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 17:00:45 +0000
Received: from PA4PR05MB7776.eurprd05.prod.outlook.com
 ([fe80::509d:8c36:ae0e:8e4d]) by PA4PR05MB7776.eurprd05.prod.outlook.com
 ([fe80::509d:8c36:ae0e:8e4d%7]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 17:00:45 +0000
From: Enrico Bravi <enrico.bravi@polito.it>
To: linux-integrity@vger.kernel.org,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	roberto.sassu@huawei.com
Cc: eric.snowberg@oracle.com,
	Enrico Bravi <enrico.bravi@polito.it>
Subject: [RFC][PATCH v2 0/2] ima: measure write on securityfs policy file
Date: Tue, 16 Dec 2025 17:56:19 +0100
Message-Id: <20251216165620.683529-1-enrico.bravi@polito.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250225131255.154826-1-enrico.bravi@polito.it>
References: <20250225131255.154826-1-enrico.bravi@polito.it>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0218.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:56::11) To PA4PR05MB7776.eurprd05.prod.outlook.com
 (2603:10a6:102:d2::9)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR05MB7776:EE_|PA4PR05MB9684:EE_
X-MS-Office365-Filtering-Correlation-Id: e309e1bd-fcbb-4c5e-0613-08de3cc4a746
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oIr3PMdS2cumEklqVUJNxUp6yS85duTpgTj0yqrFtAW6qHXar7P8ZRoWqQtz?=
 =?us-ascii?Q?6yrYcEcI2PVhDdrn5mcP080uTVwLYRjG09GLcwVZVvAZwI36y+PpZwFUbyxd?=
 =?us-ascii?Q?s2Bpc1rXmREYU985Qdj5S2guQIWNikBGsXelUA4c3zxJABIswiLYi1T4mxhf?=
 =?us-ascii?Q?8K1ecbxXSK5+jUGE8bGGXdvApD0LcYfLgp0OcA7amqZgLU9yOWHwgTQslt9p?=
 =?us-ascii?Q?2LWQ5rPVyV2G7iQdiKp8SRxZ1tH2irDIyQQpHpXZ8kGkWYFhBf0c9iBaZjX1?=
 =?us-ascii?Q?77cSIUWUM54SBEMzWKJFbhbt1ILlceOpvJTP8ed6rHl19qoOtFf/4vSnfRCX?=
 =?us-ascii?Q?bkTfRjt0NlXWY9Bya4liUJhzSOw8m6ERytCBFCGOOMjfcibNOQQtqGZtaJuk?=
 =?us-ascii?Q?W3XqvGlB9iIhl9EMq2iQ0vml/oTQCWQAMmHuM5+r0UN7y6ZxC9dGqopN9vwq?=
 =?us-ascii?Q?errycDKcaH8Z9gV9+xJHIwjGbq6BDkurW3oyPUaNqJ1nqoIIxQuv0BnODjqd?=
 =?us-ascii?Q?P7bM2heKgedhCazMQsexYT9UpGc3ESdqs/6xOpySpa5tD9SrmFRdAvUoBqva?=
 =?us-ascii?Q?sfcmDIYEbH82GebJ2eXearOqvtGF2bPMICzaRsqypnKSNm6o3yQncDcguDLF?=
 =?us-ascii?Q?rBQXqHYsM2Af6odxRbdwfbtZAuglHuRcngFi6xIyRbUlQFnJdutlf+dRdiU0?=
 =?us-ascii?Q?euv1xNNCilpeaIG1iXbQNabRvHh3FOW9NU0xAkp+zadVpQ+A1IVYVcqIGB6C?=
 =?us-ascii?Q?8c8Ce8ttRHwD7P84F+kUOuaBq/TgBp7jXB39PXQ/aG9hOJbZV79uUQHM7DKo?=
 =?us-ascii?Q?X9brhmB3+ryTaJP9R4sByYXFixsMAgGxkEWmKdii8PZBi9jw1jdboKUySPJS?=
 =?us-ascii?Q?NVuPMD4Sizutw/V3EXth0l4l1esD9I+pZg8tc+GOdVjvkXjlqnK8zHJ187Ji?=
 =?us-ascii?Q?ioCGpkhp7Z0C8QIzTNmBATl0mPGNl2ZFW/amp79+Ty6X/QQE9ktDMu3NQKjR?=
 =?us-ascii?Q?k5pxmu8a2Y6Nr5me5vrzjwNObsXAlr5wpequqm3rr+XrvM+5TCabh030HjNK?=
 =?us-ascii?Q?xwd58yL/rBaPwardqdLdLFkGWPAZK+4vfsuFY4C0ghYK5u2mZuToFVmOwglw?=
 =?us-ascii?Q?UNv5gthX1/3WTc/mgHv+BdbA6G5+FWxvHy/UFEyS/PusLWJR3FugWZWWMTzK?=
 =?us-ascii?Q?QKiVgw4TM8tmPyqsf9ojs0AhIvBR7TK2GVt6Q5Fs+34K8Wh6VGEGoDnMbewt?=
 =?us-ascii?Q?uptb1Uzx3nqe2ClWMdQPYx0ZvtuIZX/22zArmbVzlf5F8mvoz4YZkhVBALHD?=
 =?us-ascii?Q?oVzFnlI3vGY718PgD/qs7jcrEk903preZz+QwVu5uCVH21gsPF5oNLbv4/VS?=
 =?us-ascii?Q?SKNcMROYQN2qXSatmEvCn6NK8AXZwpsUeIkux0QJQT4ac+MIvhmue5iGU4GL?=
 =?us-ascii?Q?VAD4okOtWErmvUtQyCJRKIwDeyi3IQcP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR05MB7776.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e8sx0u3L51Y3goCiUdSDrZfws+F2RvcYjZm5A5N/6dQHK6VDPFtbmFdsnOQ/?=
 =?us-ascii?Q?13xhsmuA0+Gsk22tcdHizIm5SwRzqapArTMLmr9Uq4Z51qfoaM8ASi+iZ8Fs?=
 =?us-ascii?Q?0Gbs+TeM6JsTjE5+gJ/7LBoFe2Cg0C29lmyX8/s0B7dU7XD4SSuKvrV2PsC6?=
 =?us-ascii?Q?jEao6tXA7ZK1Ghf0OfSTIaLxJisyHY9xsBwtP1jzzMvKTfX1beVku931EEyE?=
 =?us-ascii?Q?ZjIURCTqi84pl+ltWJZxogdzjInnsMmgrtkc6L7l722N9d22+6a1RxB55xNi?=
 =?us-ascii?Q?Q5PLHKbOFmwIz/JFEJXCb0SewVQZfNmH/8aQtjrkCoew7YZyD8f8DaDnVzs+?=
 =?us-ascii?Q?USl8KroLNHuRVBV5zq5vpGJOLvOC1KndIbum9pbniXTs9bn/ZnVMuWqTb/qj?=
 =?us-ascii?Q?LDLtY6+OgbpPMWHpBUM64Vuz2nzdffFjvqTcsLGvhxgP6/45MGUn9YEQHVI/?=
 =?us-ascii?Q?XdtrETWfa/Ga34tTmDLbFDIMYG+SeGw1OGEhukWNlPCNObghDy6xW6Xhj6os?=
 =?us-ascii?Q?ph8BQvQpR4pYQ1GjBYNGebqSLHlWNaQJtYuahOMxXoBUjdnuBGiw5RC8v7wh?=
 =?us-ascii?Q?VMi2auDHlwA2XrbOk/7h3alJHOlrA7IY+0KQtmPBXgMMyhezLNJnUJacAvic?=
 =?us-ascii?Q?GlP3PtBDNlzRnJGYuDCh0fhC3iB8A7KXJiX/Ghf9fIJT0Xz+Z/vUI4qEKO4y?=
 =?us-ascii?Q?ETHiIbTiqcgrsyyCrUzKhVyJ3X7TtzbBczIrpcIjOvh5exqDk3feqiD8+BDr?=
 =?us-ascii?Q?IVDRZc+Sax84IbZ4LnnC/2nZ2XtgE55usg7iWGGhbnp8e+C/wS/UGRojwDn9?=
 =?us-ascii?Q?TNz0Ws4Sz/MvrK2b/HJfy/JKsqIEt9e9FyRWF83sZjozsV8Wkg0T2Zp3t8Jo?=
 =?us-ascii?Q?bB2CC+ywJUqJl7d+wfXTe3Oc/9jcJ74af6uq3bCpWTz7l/KPMQP9H+3mofmT?=
 =?us-ascii?Q?xe/LeTT/R6IdAn+ZLqwHsnAFXB6kTFaQKBQm3MU+WsWShAOzSJY7pQAgDHl3?=
 =?us-ascii?Q?n7tPdSRlpMB3vUr7GDyWxnqMzHoBO8CSdAuxUZchVcr2F1RdBNRkk1YLQ2fb?=
 =?us-ascii?Q?BgqLG0oUqfB5xjI5v0kIp0yRK0kwERvQIZSz7FA/63sO43jJSTVKUYp63Y0M?=
 =?us-ascii?Q?dPmcvfRl0X+u+PgMOTQUt3pzx1QpXJUu2NWKiuV2q4q/i298KC37B5WyzloH?=
 =?us-ascii?Q?BXuQOPdgqGYt5DbrEtLD4d41aJvmN8QymgyI7U9iJyCP40h0gDGsj/kwU8/z?=
 =?us-ascii?Q?1AhCKUVMG2ZmHpNe2XKVw64EY2isBrDkczGv7/QInI5adaKlw40Hi2N96907?=
 =?us-ascii?Q?dVSZjz4VK62l1OpO8aQZccoHL5yQlokRx3i7cR0bZZ2Hg5gzP/+lBEVz/suS?=
 =?us-ascii?Q?pKy0jM1fmw+Q4iU9R5mcfp6mq2oQllRMQ+1Fk7DlZGRNOmg22WlB2xCiMhxY?=
 =?us-ascii?Q?5z+P26YfQ4SMxLj1LeHhHetmCG9f4QbQCZp1G93eR5nVt9Ci7o0Ulb5LW0Ks?=
 =?us-ascii?Q?4l3mibofy9gutJnH4DZNO7ORanKP9DXAjixncTQse7Kw5h9vyzoHwhQKeGA7?=
 =?us-ascii?Q?UKyZMkI0mxqJd4t5zSTdDeSZFY6BDa1GiOo0JFi/?=
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-Network-Message-Id: e309e1bd-fcbb-4c5e-0613-08de3cc4a746
X-MS-Exchange-CrossTenant-AuthSource: PA4PR05MB7776.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 17:00:45.3070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wODLIWuX0b63VAcVO2pmNlAkNhLrMOsRYIwN48wL5DcM4HWpIQgEuJJOr00UriJzjVdyEmyv5WyeMUw21xN0uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR05MB9684

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
specific policy rules.

The patch #2, following what suggested by Roberto, measures the input
buffer sent to the securityfs policy file, regardless of whether the new
policy will be accepted or not. This is done by calling
process_measurement() in order to catch it when 'measure
func=POLICY_CHECK' is enabled (e.g., ima_policy=tcb).

Changes in v2:
 - Set a new critical-data rule for measuring the loaded IMA policy.
 - Add the new critical-data rule to the specific arch policy rules.
 - Add patch #2 for measuring the input buffer sent to the securityfs
   policy file.

Enrico Bravi (2):
  ima: measure loaded policy after write on securityfs policy file
  ima: measure buffer sent to securityfs policy file

 security/integrity/ima/ima.h        |  2 +
 security/integrity/ima/ima_efi.c    |  1 +
 security/integrity/ima/ima_fs.c     |  2 +
 security/integrity/ima/ima_main.c   | 38 +++++++++++++++++
 security/integrity/ima/ima_policy.c | 63 ++++++++++++++++++++++++++++-
 5 files changed, 104 insertions(+), 2 deletions(-)


base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
-- 
2.52.0


