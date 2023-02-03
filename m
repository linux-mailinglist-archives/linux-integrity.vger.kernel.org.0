Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C11F68995F
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Feb 2023 14:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjBCNCf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Feb 2023 08:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbjBCNCd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Feb 2023 08:02:33 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2068.outbound.protection.outlook.com [40.107.212.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A2C9D582;
        Fri,  3 Feb 2023 05:02:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxwyaIbx1vDm1+db9XJTtssNsD6l1jQYoU4JwmQgXSgUI9uZCHFoXTy9NkVBjp1kJfN/nRYisA09PXfDJ2vOUzp1kEFE4pQNzpEnXcM4RaAQd/fQVF5FfbuIuAlzXia/UqMLgSxSyyrKl4j9Bx97ASmG0gY0MXq2Gds7EdVWj5fGts7k5jmLi5e0ZPtr7XzYOQaAsIrSbxBCwVJabtBTmONGRZcAS4hGdH/Gf+WzX+1Th7NS4/EhhBmiiWI0M94EqXLWEQ9gPycnVupF8UzFw7hXavLYRva1ZxN3dc5BP2rmowBAuwHv7QB45c5NPCEUsfQh3K8h/KcSYG5hvc/Qgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqWFNUwPKtgLMprxqTkaVOXPw+aYN4kOMzuRnY3qTUs=;
 b=jY7JunFJrPGi0OeI0ooyX4kCJhsmswf9HY9dMerJWKK4FD+UR51peUGqcZVMRrqAYyOVH336W+IKQhql2yRczEBTno5JP1P06xtLGajUivoR5CQ5pLoKQGJiSB+58TZciZjmkRoJcyiBxRFFUCrA/LY4YJ6kGqQPnC6NUmoQlbgGDhfHc4+OOpttJZ39ax3rpa6QLeLCwuWHNGkHn+19BLeZ9WI/Dba+xeA2sNLtR0kdRs2tQ4WuNlyaJulPZWVuv03DMSrWke3/0dOMkv91uyDstWn7GS0XZWvjCYpfWQlBnMYiD+/LdwixLCG5ZjsOziVqFeAJgEf6kVLfVQ/xNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqWFNUwPKtgLMprxqTkaVOXPw+aYN4kOMzuRnY3qTUs=;
 b=BIctkJi7p+x60j1k4l5YjQBkoHbT/WM33bqE+K8lOe+85A3WBpFZzdflRksU3IS76PbEjKA15j6gle3LlMmawNyP5kRmZRZE2QBDwF82RuqUyBKmffyMfjerbI9tSk+kbxwuctIpmaVsIzti4DPW/t3ygSN9zNPx620dlVMXU2OmVY9UxGvb2XpRwvYrLLg5gRJbQI2YZSygLvd1RS1O6AzyD32kI1BChM1TaVd1JBSpuZ2V61dFnSwX+EGJX42CfAM2oycRjrs8dhM2nNCctq3V5PuZJujQFqtL+S7FtbF+EtZiWDTKIPZfOVnVuTOhRzV3NrfeXQ5rNHXnPHcGNw==
Received: from MW4PR03CA0207.namprd03.prod.outlook.com (2603:10b6:303:b8::32)
 by BN9PR12MB5145.namprd12.prod.outlook.com (2603:10b6:408:136::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.28; Fri, 3 Feb
 2023 13:02:22 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::6a) by MW4PR03CA0207.outlook.office365.com
 (2603:10b6:303:b8::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.29 via Frontend
 Transport; Fri, 3 Feb 2023 13:02:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.31 via Frontend Transport; Fri, 3 Feb 2023 13:02:22 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 3 Feb 2023
 05:02:07 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 3 Feb 2023
 05:02:07 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Fri, 3 Feb 2023 05:02:02 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <robh+dt@kernel.org>, <broonie@kernel.org>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <jarkko@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [Patch V2 4/4] spi: tegra210-quad: Enable TPM wait polling
Date:   Fri, 3 Feb 2023 18:31:33 +0530
Message-ID: <20230203130133.32901-5-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230203130133.32901-1-kyarlagadda@nvidia.com>
References: <20230203130133.32901-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT065:EE_|BN9PR12MB5145:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a6423fb-b792-44d7-7b8d-08db05e6e3b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kpmU7srE9+EB1kNjCn9MeMB0eKsQoM5GRJ+mGWr0gBGMTDSGdcvVYqboUVtUib12Slv8VYwJVymX7VWCmJ0+3AUL2+DxzBK5YvSe2+TPlsFJIsojzaQShcdLTJfnJf9rmxb8dR65DxiwzRQdffmHCmJqh8DjcawS5Ph8UNyNI3nl/8SnoBKJlZWx6EB+gfiSDD1EORf+dnqxF0mEd0D26WN8BAxuXVk8e0go1Xw0t422Y+zhRB3V319SHwWJ3sg3vjk/kWWgyP2RpWKCAIZWnd5z1yLlnLLg+/E3LEidiJL2lpwegIsPCAOaYU3n3mdJQl7C1CUEcm+qHvyq4DnI7YnRk697GLt1AwLIEN5C7gMBINxFgSA8AB1UwY2f9Pu3SAijLB/ka6+wBnGqf30QHaijM055L8grQ/f3JSD/L3eeNtLCdnR0ubdjbFqgFWC/doxjwcnBWJhZ6LVHhr7nElg6tMf3H6N6MAESdZ4rlR0sd43orMjtmw33iJ/hNgdeoySyypTW4JVn5y705PGB7XCl72MO1c7bucCqy3K6CEs3iYj0C07IrUF6mlHBJar3ZfZAFH8jq0dDHgXxSgWsTXMmM+hYt7qNnQfR723dlheg8zDbWVq3YNISwP9eENvdGDw3eWLoGfccsU3bTCIPVlGaM3gEaeA+/C6jHyAcrJhljV3b+2bcLuws6ayrTn80+Ee+S9AbweAa+KDUYY5A9fdLaqD1eM6/TL3hKp3dVEV1FaE3cSXFC/I57jLUX/MWq1AN7GgbacW6TOo0mXy07Q==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199018)(36840700001)(46966006)(40470700004)(7696005)(47076005)(36756003)(40460700003)(40480700001)(86362001)(7636003)(36860700001)(82310400005)(356005)(2616005)(26005)(186003)(336012)(426003)(83380400001)(921005)(478600001)(7416002)(1076003)(110136005)(6666004)(8676002)(54906003)(316002)(107886003)(41300700001)(4326008)(70586007)(8936002)(70206006)(5660300002)(82740400003)(2906002)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 13:02:22.2458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6423fb-b792-44d7-7b8d-08db05e6e3b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5145
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

