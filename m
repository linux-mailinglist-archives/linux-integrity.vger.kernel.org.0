Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0754F688404
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Feb 2023 17:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbjBBQTT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Feb 2023 11:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbjBBQTF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Feb 2023 11:19:05 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2087.outbound.protection.outlook.com [40.107.102.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D701D68ADD;
        Thu,  2 Feb 2023 08:18:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXpuoLD7s7UUB1eR1UwVuMi3AUiZ0RgcDKvXGgfXmx9T4mePmkWhQB++F6zs6Gy0hkQlXHJbNO6GnBTNqc+lpwwzmTchD8GvFqI3BR/MXtKo5DshM7DS/k4CYjMWZe3OBaRiIxSL4G0PTBIbshtdYeAQeu61G+2TieI2ZwxNM0wR6HNTrxi4OXTbq0+p2+nwMVSdK7TBywcd+x4gZzyMGBI/x5G+uzreOygmucDkClt+hAk3JHxiAesWj+B8VO3vNsSGxWtJ8TlWnuDvpYzXP7zISs5kD/yW6WCVLZzaPKflwFtv9UNJnYHDLoyW3eDiz0cXqktG5aM945N3Z+l6jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqWFNUwPKtgLMprxqTkaVOXPw+aYN4kOMzuRnY3qTUs=;
 b=PvKoaEezpkHEeJnjmd4iQ65ENXSqbdLPUcwdv3N2YWhnCN/FyDKRzGFD9wvgWqA9Olr5rzFvPH76UtD8dMwz/YVFa/+xhrmpUfUNFFP6FsVM+p886hX3hQLygO/KdD6PdxJnQDRJX4xbG5xEH1t+wpptkPNFFq1vSDziPo0dkJPyAUy3mUtFlTBOTQ7KkcmKEKQ0XXyIRdt8m8sRJRSx/FGNEGyL50kS/F+KImdq0bk1qxgioZsw7oEeTe5dhs/Ekv9iwynv4z+rTU2Sc2KNyb5nOfyCUucg218a37Loy3LRjf/m7o5ClPa+hnn7hrTdifBh0sLNH0fsENPpQ5/XOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqWFNUwPKtgLMprxqTkaVOXPw+aYN4kOMzuRnY3qTUs=;
 b=s9OPNkYr5NBAX43KE8enYBvly2l2+kSpWpPYmh53uKj8rczIM2ltZaSlW8G5b+lX6L2wFPZXi+UmOJgSOSMJgwVdPpbzHe5LaH9gOyP+spcfGg1WTv2MIODp4Nan06lcI43yRsVXgurs0+RXCJoKTYzvk79ng6FRCQ/tUEEKQ1XABfOC0iSKGj0aucfoDqN1g+fFaTigcZJwMyogfm1ZJOaT9cq6QiulpTlZGe35n7RuW90ee6FWh6wEXSPYDf2bGO/xthm0/dpQop9JXcGbweIYkDSHV1rEFKA4mXT77J97i47pZnDkK2VYVVwce8g15QdE14keGKzaYLFkPi6zyQ==
Received: from MW4PR03CA0191.namprd03.prod.outlook.com (2603:10b6:303:b8::16)
 by MN2PR12MB4269.namprd12.prod.outlook.com (2603:10b6:208:1d4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 16:18:35 +0000
Received: from CO1NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::e9) by MW4PR03CA0191.outlook.office365.com
 (2603:10b6:303:b8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27 via Frontend
 Transport; Thu, 2 Feb 2023 16:18:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT081.mail.protection.outlook.com (10.13.174.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.27 via Frontend Transport; Thu, 2 Feb 2023 16:18:34 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 2 Feb 2023
 08:18:20 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 2 Feb 2023 08:18:19 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Thu, 2 Feb 2023 08:18:15 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <robh+dt@kernel.org>, <broonie@kernel.org>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <jarkko@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH 4/4] spi: tegra210-quad: Enable TPM wait polling
Date:   Thu, 2 Feb 2023 21:47:50 +0530
Message-ID: <20230202161750.21210-5-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230202161750.21210-1-kyarlagadda@nvidia.com>
References: <20230202161750.21210-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT081:EE_|MN2PR12MB4269:EE_
X-MS-Office365-Filtering-Correlation-Id: cd937f5a-ace5-45a6-cd9f-08db05392231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OdUFbUzF7wvcgXhPiwfuK4FPttfsHhN5L8I52KjaZTNB3w7yHNYi+tj4bQptwz9xnMkOLoSBZdQQNCF5I/NqnkpSny27oU4S35pBWdGuCPBPNkofbVXD5AN2i9wokhIYMPy25jcsH/2fJoGgktjb0fjqFJcw+GRC9GjoGgcf8d/Fulw26SlpNwebVebVSwdcgqvUwid1nzy4MhCSLJGUs+MqlJ9ym/k/GhBMRVP7OJux0JX3GDJ5W5j1/FzFI1+dJHIhdCcWZQviRZR5Y78vPRPrag0VOGqvsyf6LoGeovzbD0JfL0Qs8scGcXT13imUTFsq3t8MiQRwIlQBCUp4qZw7Yee3FDZ/P62VnYkLjQaUcNBLWFGxzWRwbLPI77bhZwRdm7NMfCKv9bbLC6yHR3DHaotx67brAuZpW4pT6HlsvMIoCvuBs1jTMaFvas9EdEo35ZvVLd/I24JlG3QG3X8uoI+9HZJ/zh5z7+Pz/RHl9dqzN0orZWS+GdOhIdtk5c8wolom7foksTBKlif6zQPtZYuenU23st4l9EwLPtmqM0GuHcoaa/HurjjDb8NVRRZGrL2Op8Dm4EleOEJcYqArN4RGkEMOtQ6Mva1Gz7KC231+4rluc67HVmjHsuu9xbstLM/OYzhgDYOmrkq4z5Px/e4dTWAVgJp0MXY599jvQSIXIwumwDBEXdXGf62vjvKutXpMmNXJwhkqXK6YlUpy20pujIow8JD8gZLGwB1RdkN4jIMS6eAonunfaob3i6bwr3u7a99I55CRY5wmAw==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199018)(46966006)(36840700001)(40470700004)(356005)(921005)(40480700001)(36756003)(36860700001)(47076005)(82310400005)(7636003)(40460700003)(82740400003)(426003)(41300700001)(8676002)(7696005)(2906002)(70586007)(54906003)(4326008)(316002)(110136005)(7416002)(8936002)(70206006)(86362001)(5660300002)(107886003)(26005)(1076003)(186003)(6666004)(478600001)(83380400001)(2616005)(336012)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 16:18:34.7083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd937f5a-ace5-45a6-cd9f-08db05392231
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4269
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Trusted Platform Module defines flow control where slave will drive
data line at specified clock cycles. Tegra241 has TPM wait state
detections support when using combined sequence transfers. Enabling
the feature based on device tree flag.

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 9f356612ba7e..ea8a08a3d838 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -142,6 +142,7 @@
 
 #define QSPI_GLOBAL_CONFIG			0X1a4
 #define QSPI_CMB_SEQ_EN				BIT(0)
+#define QSPI_TPM_WAIT_POLL_EN			BIT(1)
 
 #define QSPI_CMB_SEQ_ADDR			0x1a8
 #define QSPI_ADDRESS_VALUE_SET(X)		(((x) & 0xFFFF) << 0)
@@ -170,6 +171,7 @@ struct tegra_qspi_soc_data {
 struct tegra_qspi_client_data {
 	int tx_clk_tap_delay;
 	int rx_clk_tap_delay;
+	bool wait_polling;
 };
 
 struct tegra_qspi {
@@ -934,6 +936,8 @@ static struct tegra_qspi_client_data *tegra_qspi_parse_cdata_dt(struct spi_devic
 				 &cdata->tx_clk_tap_delay);
 	device_property_read_u32(&spi->dev, "nvidia,rx-clk-tap-delay",
 				 &cdata->rx_clk_tap_delay);
+	cdata->wait_polling =
+		device_property_read_bool(&spi->dev, "nvidia,wait-polling");
 
 	return cdata;
 }
@@ -991,6 +995,14 @@ static void tegra_qspi_dump_regs(struct tegra_qspi *tqspi)
 	dev_dbg(tqspi->dev, "TRANS_STAT:  0x%08x | FIFO_STATUS: 0x%08x\n",
 		tegra_qspi_readl(tqspi, QSPI_TRANS_STATUS),
 		tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS));
+	dev_dbg(tqspi->dev, "GLOBAL_CFG: 0x%08x\n",
+		tegra_qspi_readl(tqspi, QSPI_GLOBAL_CONFIG));
+	dev_dbg(tqspi->dev, "CMB_CMD: 0x%08x | CMB_CMD_CFG: 0x%08x\n",
+		tegra_qspi_readl(tqspi, QSPI_CMB_SEQ_CMD),
+		tegra_qspi_readl(tqspi, QSPI_CMB_SEQ_CMD_CFG));
+	dev_dbg(tqspi->dev, "CMB_ADDR: 0x%08x | CMB_ADDR_CFG: 0x%08x\n",
+		tegra_qspi_readl(tqspi, QSPI_CMB_SEQ_ADDR),
+		tegra_qspi_readl(tqspi, QSPI_CMB_SEQ_ADDR_CFG));
 }
 
 static void tegra_qspi_handle_error(struct tegra_qspi *tqspi)
@@ -1056,6 +1068,7 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 	bool is_first_msg = true;
 	struct spi_transfer *xfer;
 	struct spi_device *spi = msg->spi;
+	struct tegra_qspi_client_data *cdata = spi->controller_data;
 	u8 transfer_phase = 0;
 	u32 cmd1 = 0, dma_ctl = 0;
 	int ret = 0;
@@ -1065,6 +1078,8 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 
 	/* Enable Combined sequence mode */
 	val = tegra_qspi_readl(tqspi, QSPI_GLOBAL_CONFIG);
+	if (cdata->wait_polling)
+		val |= QSPI_TPM_WAIT_POLL_EN;
 	val |= QSPI_CMB_SEQ_EN;
 	tegra_qspi_writel(tqspi, val, QSPI_GLOBAL_CONFIG);
 	/* Process individual transfer list */
@@ -1192,6 +1207,7 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
 	/* Disable Combined sequence mode */
 	val = tegra_qspi_readl(tqspi, QSPI_GLOBAL_CONFIG);
 	val &= ~QSPI_CMB_SEQ_EN;
+	val &= ~QSPI_TPM_WAIT_POLL_EN;
 	tegra_qspi_writel(tqspi, val, QSPI_GLOBAL_CONFIG);
 	list_for_each_entry(transfer, &msg->transfers, transfer_list) {
 		struct spi_transfer *xfer = transfer;
-- 
2.17.1

