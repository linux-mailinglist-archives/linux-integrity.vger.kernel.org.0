Return-Path: <linux-integrity+bounces-3742-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FD29936EB
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Oct 2024 20:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03C8B1F2233F
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Oct 2024 18:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E181DDC2A;
	Mon,  7 Oct 2024 18:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B3Z/wwUF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60307139587;
	Mon,  7 Oct 2024 18:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728327454; cv=fail; b=iD71sWbAjsDcLfCFh+b+fWqeZkaLvZwq6R5S/ObBhk/CbLmWtWQAOeFtwrMsNW+UTDtGkTy6CCiO1gig/+wCKBwXqUi7JAnonmXZ+Kp949kU/c9wUhMa2fE+XseJRYf+kMMGchFlxdfMKCot3e2CFgDj7cloehvs18D1SMNddN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728327454; c=relaxed/simple;
	bh=XJm82kTe0MX/a16qvfutlhqgiUsYpuTtSucNaYsn/d4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rii6ZwL0V2TzT1KFENtHp69Hl/uBkfZQ4b0x50sWI+c7PAJA+cWSb9yRwZls6bOk6dX+lbz8kRAlCj7Tg2QEf1L42NbcxFeW7XuTlceKj+lDuPpFcuxm4Y9kFkrFKuQByH0yAV/1A17HmGlw5I+mmO2kjcYDU3KppV0O26FUDRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B3Z/wwUF; arc=fail smtp.client-ip=40.107.101.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RqhKsdgXyHYYelE+jrVpy5QkmjZGzs0CbAywtaUIOoou0goS/HIRut4V+0HrkMsbojg288Nfxp3HqfYmt45bpyuRIWKe34wc/jxl/Tgws+OFqg6o0JjZxEzMfByTb/B8fo5pvljiSyL1ga7BzqEGqbsyyG6UBPNfDC7HWbM5V2G8nXQEd8/r9Pkr6HGqRvXxlCxXcfO20y8rxyMTxbZCwqJLBjBlsFqq55RtMqltQ7Z7hWGVKTon4uVHgadlf/dkQpbhXLEoZg+BjMABGAF64e+VKjMClEjdVe5ZDNNRVjUsy5wcTBYMM+Z3mB4sovRsZec388YkH2nlOCV2A9bK8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77NNL5FgJjqyvUgWN6qLTbo3HEvrzyUZP+jQbrYU+dA=;
 b=potTSHrkruWhl9qJcyukyNYrBXKYJ/4h+R5DM2huf0emp3+TW+eMKWwdxGLukl9gKvUAvK3U9tiuJh9/q7jjggmo5difYDmuOVu4Z7QbE6HPFDtw42yh/46rRwPkjpuXDy/WH4P3k6WtgzFVWwKaBvU8wMXrCz5gXE3lidFebM552AKhlbTQ++xxlY/Xycr9qYxRd8OSXmH2OUNPjzeDHRIx+HfLDeP1akncsuEyygijkJYLGTG5zsfS6f0JkkgUt7M3H74+kgV97Y7epIfqE0VBX7Vj6sZKSEaov0Yizvk3VRqHEIQLy0JPWPp97Mifxe+6G3hh6a+S+YwDEZ+W7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmx.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77NNL5FgJjqyvUgWN6qLTbo3HEvrzyUZP+jQbrYU+dA=;
 b=B3Z/wwUF4EceY6dTtqZhadQt/WESmfkydZs/dt243P9+menWyK4NHXN72wQB5lm0MH5dsuCkEvdn3gIURJQ0v/YelxyJlY6Viscqrv6qSivVjWw9MctnbzjPT5GhIQ5CG9Ybo9uL+UngVy0Mgik5r9IDAY2ahcd0HcBRtd8p7dlKGx6UQRzMkzazlLqTbdxCSG0n13QQwRn5gCS5bqvC5+2ZwwQ3RiLijvwHPtdYJWgMt2mdVrcfMa+l7HOFphsTKfYGdo9o9R6g8JQNfE5U05EvW2HdjVpxu6mCvtsycBBKLeO5Vv+H0wX21Q/1WI4AJLzwvdSEe4+PI4eQiqNAlA==
Received: from SN7P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::21)
 by DS0PR12MB6415.namprd12.prod.outlook.com (2603:10b6:8:cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Mon, 7 Oct
 2024 18:57:30 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:124:cafe::cf) by SN7P222CA0003.outlook.office365.com
 (2603:10b6:806:124::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20 via Frontend
 Transport; Mon, 7 Oct 2024 18:57:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 18:57:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 7 Oct 2024
 11:57:18 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 7 Oct 2024
 11:57:18 -0700
Received: from localhost (10.127.8.13) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 7 Oct 2024 11:57:18 -0700
From: Jamie Nguyen <jamien@nvidia.com>
To: <peterhuewe@gmx.de>, <jarkko@kernel.org>, <jgg@ziepe.ca>,
	<linux-integrity@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <kyarlagadda@nvidia.com>, Jamie Nguyen <jamien@nvidia.com>, Koba Ko
	<kobak@nvidia.com>
Subject: [PATCH] tpm_tis_spi: Pass in ACPI handle during init
Date: Mon, 7 Oct 2024 11:57:12 -0700
Message-ID: <20241007185712.3584468-1-jamien@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|DS0PR12MB6415:EE_
X-MS-Office365-Filtering-Correlation-Id: 9894854f-52e1-4c0b-cda5-08dce701e4cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h0IMNWhvjkcPLO9UfvbfA9qXBhu4kGPgt25iGkNj9xubtzuZA9ZrdgekWMki?=
 =?us-ascii?Q?1vb+5wNNGsWoSF7shDeny3QvdZLDHUfBVNeQfeiu3M0FPEUi0AQM/HzGMjfE?=
 =?us-ascii?Q?1bOkfsUSjduWAWk/H6tYb7TEnBIzy33ZavWoY+FUkO/FubBGOXzTCj4vx/89?=
 =?us-ascii?Q?VyHIb7/w/zBFDG5hvwFKlUv0Y38aHSYlqU/5yiJENtfwV8XoEyZYcb6S/nUh?=
 =?us-ascii?Q?j8t16iXr1hm5ZIwoqCyFI1HLRc2VNBEG43T7hH7ea4iUIbrW6J8im3CyTt3+?=
 =?us-ascii?Q?Tz4Pp4xhkB+GK5yyPfAz8G21l2S6z3lx9JDSVS6zXOoAPPvCFKUrpwX4Qf2P?=
 =?us-ascii?Q?BK/cWmsGES79s6lBr2kpNgPU98ZrF6XvbzFwx6NMySXom71yC/tudpbZKBSK?=
 =?us-ascii?Q?rieVx509fHbk1VUjnrF0LZHBF4Qsomc/UwMs/CoWW3yXZxtE8aMiP87hvKcT?=
 =?us-ascii?Q?eoBcLlMYfo56cyd3TiFb/96oUdjwWYacaQZzwL/oP4SGMuzSGJmY4MlWlN6a?=
 =?us-ascii?Q?eLbQJxtbB/jOoJfiIi/kakIt1o3YALDptBfS5F1p/AAke41GJ2HKbj3B/LzC?=
 =?us-ascii?Q?xhHNrOeW1GBriHdV89M78JVjwfIWYFbgZb7YKS06zABN8UbCWGP4J7kNPfK0?=
 =?us-ascii?Q?g3Qqt9p7i+DPTBe60UIptip49Cotcu/uSvtxYJEG4H89lxvkEMJsQwqz/Hlh?=
 =?us-ascii?Q?E590f53lkJh9qiroNgYSRCDyCjTUCRhX2fBBq43ADVa8HdPu3jwZD7zRZRTv?=
 =?us-ascii?Q?V+r+zCZOxc1xA+omQiP+NGq4uV3TwhifsO/jhddqeJIaj1SpmBtiJJfzetXZ?=
 =?us-ascii?Q?HPDviLsM9pF1k9QE7aNE5LdkXKIYqVHXQf9Lnbzy1EqNgIb30m19Vc9zbwLD?=
 =?us-ascii?Q?QvVHfJDpETUx/rMXhbEN+O0fW2owsJTElmVBQr/+nyG8/G75s9ocHZhB9DPb?=
 =?us-ascii?Q?NkQoRCl/zWMLfj2CaHwidyS7Wrzn8TXgtin+ipY0Ng3O473bVC2VUnAGbtE2?=
 =?us-ascii?Q?XWWJcvdMHOHmh9q2h7SsmWqI21fkHpyLfS/EcjuRMQN10sGHM9Fbo1HND2nZ?=
 =?us-ascii?Q?UugXoN7feevRw4RY7ODekU5qZ7CmZm4h8PANSuP7AZf+kgZg9BRxKGVc406M?=
 =?us-ascii?Q?ebap2HLL5Vy4I46X9cFgjZMcgYx4NoB3zPSP9wRhfHnNga2lb7HDEzdmw8ci?=
 =?us-ascii?Q?3xDg5Zf4+a/QdqeMqCW9G90jlRzLnvzekktDvr4zf/g9/XsVhd28i5YBpTl/?=
 =?us-ascii?Q?Cd43+2inw3xRJOTi3HuI7xLCkV4r3Ub2klQfKjwYz2okJxsO3yIt9kOKcM4I?=
 =?us-ascii?Q?vJKFzo3GKE9tEXGKV8FQppyHcwYmrpBbBbTmXYlOzst3F+ejWV7Pi+hMr82f?=
 =?us-ascii?Q?KvJcA+D6W1Rlrmp5pJj5CX2VZr19?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 18:57:29.8128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9894854f-52e1-4c0b-cda5-08dce701e4cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6415

When initializing through tpm_tis_spi_init(), we are always passing
in a NULL value for the ACPI handle.  Pass in a proper handle so
that we are able to take advantages of TPM features that may be
described in ACPI, like the Physical Presence Interface (PPI).

Signed-off-by: Jamie Nguyen <jamien@nvidia.com>
Reviewed-by: Koba Ko <kobak@nvidia.com>
---
 drivers/char/tpm/tpm_tis_spi_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
index 61b42c83ced8..a5e2e669c3e5 100644
--- a/drivers/char/tpm/tpm_tis_spi_main.c
+++ b/drivers/char/tpm/tpm_tis_spi_main.c
@@ -254,7 +254,7 @@ int tpm_tis_spi_init(struct spi_device *spi, struct tpm_tis_spi_phy *phy,
 
 	phy->spi_device = spi;
 
-	return tpm_tis_core_init(&spi->dev, &phy->priv, irq, phy_ops, NULL);
+	return tpm_tis_core_init(&spi->dev, &phy->priv, irq, phy_ops, ACPI_HANDLE(&spi->dev));
 }
 
 static const struct tpm_tis_phy_ops tpm_spi_phy_ops = {
-- 
2.34.1


