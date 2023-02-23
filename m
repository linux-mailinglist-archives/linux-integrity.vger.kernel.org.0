Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4BE6A0DFD
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Feb 2023 17:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234566AbjBWQ1Y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 Feb 2023 11:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234609AbjBWQ1V (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 Feb 2023 11:27:21 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10hn2214.outbound.protection.outlook.com [52.100.155.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D6A5653E;
        Thu, 23 Feb 2023 08:27:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRGGNQVwaP8zshQc9C8Jgg6HEEqn8utZ1ix1MFxeSoQhsIl57GX2LGRZRWfnSXvP9YY25TuJkdmoXBGb07a0zXc+/sIMyArFf9Z8D/aufpN2JSTvEwIyX/5Xp9IdLQv0mXDaDHLj6t4YDRcLTjMi3EzOmA7Qsn/w2XXkQAZPcezC4Jq+voWCAbXnxIEPzNhw8zaUdLuz8X8DBdnSumLK1Fv44pysP5iwsH+6OlWc+9OJEu+RmmgkczV5zJWJg8Yu3qg+rCW1s0f3ICV3tVCo2YUlXXI3KxtnxwDYQYbrT00IH8uxJB/xEd5gnw+ZmSls1v2WVgStmd4ee/8hnfQZ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpKHpbqOPtWGpwP1tKVnq5lfCOEd70QTpkDFyU21Mqk=;
 b=TTeuXBh66zYMkdMIorpkYAGmh4kMeA1zlsO0DBK7mclAJTfYNQP4fQV7jDf4IiCq4D4Yn1QA442x3+oEbZey4PuFm1uxujxX0K9TynvbTMn8OojEUGPvVB4BIY4K/kdp4swjDcIfbnMUuKhT/ofVfnyq5a72CQ3WGjj0ZrwIR0n010RQGwBFLr7hq0ltu6Ore2w7LEW1vdLMYnc1dbaA47WAfFQ0MZlHYqTRCbWxKr7Ln5uLwy3SacF1K49bkg2mwzUVriMMKr1s6vsyJj8HPXwcY1vRPh5UTZRJVe8rG5uhp1Q2OwNQ6Nyi0yE9PsTPQKaUFJLTdSn7pegHnq131w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpKHpbqOPtWGpwP1tKVnq5lfCOEd70QTpkDFyU21Mqk=;
 b=ZtDP3iLNsYN4PpRMxGLuOFU3Dlh5MGNVFfo+3n7TNfJxfIcmpmCTqBzTCe1fbLCA+wrUb8pcF7R01drvisdpBxs+6L0uku9C9N4Lqfe+IYYMeyC9W8McDqjvL7qmEZODXrY/pDACVRBjO7x/zra+83iE6CzRDPJ5vgNPyVAopbGFoEgE1pBEXJv7rWsN8nQaZ3mKiLn9B52DLuDKRuQ1meKk7O6f0deFxR7K7toiFlmvqIOq937Hf52n+j9VJDIcufypp6vMUTV8Sb3MxeuJRJKgB8rLJZa7v3CGzD34ApFOfZrWoH5MT1LhzPRdC04wQY5JcQJZUCO1AL696uDkXA==
Received: from BN9PR03CA0914.namprd03.prod.outlook.com (2603:10b6:408:107::19)
 by DM4PR12MB5246.namprd12.prod.outlook.com (2603:10b6:5:399::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Thu, 23 Feb
 2023 16:27:15 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::c4) by BN9PR03CA0914.outlook.office365.com
 (2603:10b6:408:107::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21 via Frontend
 Transport; Thu, 23 Feb 2023 16:27:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.21 via Frontend Transport; Thu, 23 Feb 2023 16:27:15 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 23 Feb
 2023 08:27:07 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 23 Feb 2023 08:27:06 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Thu, 23 Feb 2023 08:27:02 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <robh+dt@kernel.org>, <broonie@kernel.org>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <jarkko@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [Patch V3 3/3] spi: tegra210-quad: Enable TPM wait polling
Date:   Thu, 23 Feb 2023 21:56:35 +0530
Message-ID: <20230223162635.19747-4-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230223162635.19747-1-kyarlagadda@nvidia.com>
References: <20230223162635.19747-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT010:EE_|DM4PR12MB5246:EE_
X-MS-Office365-Filtering-Correlation-Id: d9fa8154-79a5-46f0-646e-08db15bad312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q7yM+FfPaPjy7S8KxPpZEUmT027XBxnfdd10uWOA0DCPa0wmEj2DR8p578YOI2nH9JX5qWIhClbN0+bWcjmeDLa0B6pr0FClwXlbGHIGDXq9slTRXaJpSsTK709y9TH0jCAzHM8bfE4BO8r4UT+bFl89dPE61V7/KEkf32oOfHHC1WeJzZT7ewf9IQrECptc4xhB5Oys9MYh0Mt8ESSlHRLw1u86wX7rAl3msLtF4bf9cFeaMo1SXmhbUATvRGmFKEm2KKJ78YE95Q6M0oELvM6NcfLkJ3JEwaUc1n+LMme52CGo6U0CQoHQAqAkcm68DM7eK+/JHAoLTcYBEDP3XhU2PRxhI3HwIFPC9rwYR6N6ycnG0Btce5rsMSY2hdyFq0AyieZG2erk54YpE+ARwzJK7LmJYC40EEaaVIexMeeOXt+CGX/cu09+gatgMh0dM9RpsMrS6uSDTy5vE7DsV9774ww/HpQ6pl9AEjXDoQrWrjvKMw3aMqHWZEGXSIRM9CPBe0BmOMYZM7tp1M8H9ME3vfBJX/j0QuttvTb2AC4uYQXXclmz81DyP7Cy3aV1xr51sAgc2maa3yTelmxxRxBB5zzS+VKD+3pz7W8oopFbcEaSbFDh2hYRyQy4WJdtA13SSBqxANEX2GFxqbidYqTzz4ZKJxVsYxmnUHlXxg58dxTYBebA/+sdcdPugRaiisjFe124EbYyDFgTovYMCPkjEa+AcfClzQziRni6RaryrO8NIUtsvW9T5C0fL20i7iihfvo6t1CN/JkiQJ9cEjGL4bkV0Ioh3FcjCwY2ZZq4qe+XIgBhCZ7bbF3RtPFHhyGe5IlSJxcmBTEJfkEC0g==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(396003)(39860400002)(5400799012)(451199018)(36840700001)(46966006)(40470700004)(2906002)(5660300002)(7416002)(36756003)(83380400001)(1076003)(426003)(47076005)(82310400005)(356005)(26005)(2616005)(186003)(40480700001)(921005)(336012)(34020700004)(82740400003)(7636003)(70586007)(70206006)(8676002)(4326008)(8936002)(40460700003)(41300700001)(6666004)(36860700001)(86362001)(107886003)(7696005)(316002)(478600001)(110136005)(54906003)(83996005)(2101003)(12100799015);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 16:27:15.0168
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9fa8154-79a5-46f0-646e-08db15bad312
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5246
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Trusted Platform Module requires flow control. As defined in TPM
interface specification, client would drive MISO line at same cycle as
last address bit on MOSI.
Tegra241 QSPI controller has TPM wait state detection feature which is
enabled for TPM client devices reported in SPI device mode bits.
Set half duplex flag for TPM device to detect and send entire message
to controller in one shot.

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index b967576b6c96..fe15fa6eecd1 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -142,6 +142,7 @@
 
 #define QSPI_GLOBAL_CONFIG			0X1a4
 #define QSPI_CMB_SEQ_EN				BIT(0)
+#define QSPI_TPM_WAIT_POLL_EN			BIT(1)
 
 #define QSPI_CMB_SEQ_ADDR			0x1a8
 #define QSPI_ADDRESS_VALUE_SET(X)		(((x) & 0xFFFF) << 0)
@@ -164,6 +165,7 @@
 struct tegra_qspi_soc_data {
 	bool has_dma;
 	bool cmb_xfer_capable;
+	bool tpm_wait_poll;
 	unsigned int cs_count;
 };
 
@@ -991,6 +993,14 @@ static void tegra_qspi_dump_regs(struct tegra_qspi *tqspi)
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
@@ -1065,6 +1075,12 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 
 	/* Enable Combined sequence mode */
 	val = tegra_qspi_readl(tqspi, QSPI_GLOBAL_CONFIG);
+	if (spi->mode & SPI_TPM_HW_FLOW) {
+		if (tqspi->soc_data->tpm_wait_poll)
+			val |= QSPI_TPM_WAIT_POLL_EN;
+		else
+			return -EIO;
+	}
 	val |= QSPI_CMB_SEQ_EN;
 	tegra_qspi_writel(tqspi, val, QSPI_GLOBAL_CONFIG);
 	/* Process individual transfer list */
@@ -1192,6 +1208,7 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
 	/* Disable Combined sequence mode */
 	val = tegra_qspi_readl(tqspi, QSPI_GLOBAL_CONFIG);
 	val &= ~QSPI_CMB_SEQ_EN;
+	val &= ~QSPI_TPM_WAIT_POLL_EN;
 	tegra_qspi_writel(tqspi, val, QSPI_GLOBAL_CONFIG);
 	list_for_each_entry(transfer, &msg->transfers, transfer_list) {
 		struct spi_transfer *xfer = transfer;
@@ -1450,24 +1467,28 @@ static irqreturn_t tegra_qspi_isr_thread(int irq, void *context_data)
 static struct tegra_qspi_soc_data tegra210_qspi_soc_data = {
 	.has_dma = true,
 	.cmb_xfer_capable = false,
+	.tpm_wait_poll = false,
 	.cs_count = 1,
 };
 
 static struct tegra_qspi_soc_data tegra186_qspi_soc_data = {
 	.has_dma = true,
 	.cmb_xfer_capable = true,
+	.tpm_wait_poll = false,
 	.cs_count = 1,
 };
 
 static struct tegra_qspi_soc_data tegra234_qspi_soc_data = {
 	.has_dma = false,
 	.cmb_xfer_capable = true,
+	.tpm_wait_poll = true,
 	.cs_count = 1,
 };
 
 static struct tegra_qspi_soc_data tegra241_qspi_soc_data = {
 	.has_dma = false,
 	.cmb_xfer_capable = true,
+	.tpm_wait_poll = true,
 	.cs_count = 4,
 };
 
-- 
2.17.1

