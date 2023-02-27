Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67696A47CF
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Feb 2023 18:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjB0RWG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Feb 2023 12:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjB0RV6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Feb 2023 12:21:58 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68F223843;
        Mon, 27 Feb 2023 09:21:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNZ9y9oHU1RLpObMFNCLHsM6Tgd24j5PiI/PjX68OStYi9ELhKqlDzEO4DpNg9cIRzFUOPcFLeYsKgox3XA3ciZFXLdWD0Q5i5QpahtJ/oRKeUBUD6UJvBGaH6sWPoisr83ENN8utnvSmguIx58PzU+66lpaAd/H0r4fJMBVP3bZsF07y+RLEUHtOEBKh4jcuzJE6OQ3JY0iKR1DIuaJxduXbfxbeSjlSdBizYYFQlpOOSeZyDDl8IYZnyGqo0d/ZrBZv2nRXxfybXLfn+JLUYRbIBGcHdpufrpPveydC4S88vqoCMDPRhHQjeFHCodFMp1naFXMoU/wlKXtuM02qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvARMp4wlkj39NWdjhwDo4rztchb5d+OT9cAFalgSQY=;
 b=KQ4KPRG1eoOhNIVqn7MRKiHWexgtAPhj8UDpktrXrGlmueBoqLPw6T++qKt/Qq8JZhNMAc07NZig8oxgwsSHPX2Hq/xF5FQzJSJwDUr9RsPAV6SJjt1LQrRRd9HtNo3LZwhMCAINzYsfZA98bbSBSiCjRihEGPeBwmLFVyTvAD6/YxgzzBns5nvrpiUFMuJzIwYjv6bho7OipNOFPm3ng5GohDZSwMB5pobfqqBMNfiNZZD9j8X5b0VXnyqyRRqaYNyShJHXwk4Wv8B1ItTXFExmTJP93oiVMury0lbgnDDYsogxnZDlSpoR/FUJ/gsN7h5Uiu9DQIk7YogmojSXBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvARMp4wlkj39NWdjhwDo4rztchb5d+OT9cAFalgSQY=;
 b=pdJTK01P0rsJy4xrHXqSCgWlrxr/gpNie4F1lhju8QNNw9vqM+FYQahbDgUXKWjAb2R/s7bY4xyNH2ITgMp96N52+ZRzbD70eqB3qiQpYqhnal6WhCyMnDvXTmzUTdy5Y02B+WFGwkN+h7Yc93mFQTwF1qKXXg/IQVRGML581K+TeJ+9CbaSDBjm1WleMZY817YVsyRkRk+p8QdtYD0PB3o0NIAQ4JohCTd1DlnOVixDtWAYnSk7irJLoqaXn/xGj+5/d4bDbRCv/LGXva+j5LOWrEfahP8MAqsfSr/wO2vbCbVQ4EANEysf2gFkE1vi7LmSgdy8lXP1yApW4JjwTg==
Received: from MN2PR05CA0046.namprd05.prod.outlook.com (2603:10b6:208:236::15)
 by IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 17:21:53 +0000
Received: from BL02EPF0000C403.namprd05.prod.outlook.com
 (2603:10b6:208:236:cafe::5c) by MN2PR05CA0046.outlook.office365.com
 (2603:10b6:208:236::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.16 via Frontend
 Transport; Mon, 27 Feb 2023 17:21:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0000C403.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.12 via Frontend Transport; Mon, 27 Feb 2023 17:21:52 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 27 Feb 2023
 09:21:37 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 27 Feb
 2023 09:21:37 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Mon, 27 Feb 2023 09:21:32 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <robh+dt@kernel.org>, <broonie@kernel.org>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <jarkko@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [Patch V6 3/3] spi: tegra210-quad: Enable TPM wait polling
Date:   Mon, 27 Feb 2023 22:51:08 +0530
Message-ID: <20230227172108.8206-4-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230227172108.8206-1-kyarlagadda@nvidia.com>
References: <20230227172108.8206-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C403:EE_|IA1PR12MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: fbea1484-48d0-42b1-d071-08db18e71e38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kbu2qLZObvtXXbAEEVG87+r1AqHnYRLj2ZaCBnyCouRCzGSArWx/93QSPy85BrnBYWBkM3qtHySXlqsXmwy/QqrVRQEyWsc3J+71NT42mulvVrGqCuG7MIUVDbXUkNfqS0/Q9tw2CGyh4G73VMLTdm9g9/PLdOwoo3vB4DVG9cCZjZ0f2QbSXBqHEqCD7lz3AYedMKy9S7KT0KAOCX1qkVeWzBjjgNAhoIt04h90EquSYoHfEaZ1Jd0aLV0echo28ghqshoLHTqeHFJT+px+jZCWHxTH86i693K6dHAksofRg+gUeONMRpvPHO5+VPNcYD/+60UeLI7P+mXK+OOSPraBUgU1xRrGqp5wgc+Rkcu/FKkM+4h45gdP9ykcA8dzlfhb5FPrlpZFl8mjSVcO02tRzY1IQJN9pC1WosN1e4kZmsnkZXjeeBH/WmkaDZ3ZGeAdq47bq5NKVShCPU3PVuUBmYF/yi/jPGdOysH5vvLUjtAP70PoDGivF5dgHcelKA8Mj8vmwpEIfJxqTPmy4bRfmmgQjBTSpzi0wxNoOPlE+AFHRPjtCKF3imMh5FS+jpNgreMSlCBP0qabEOVNY6xyGr5Mq5vXkAbCstmc9SEngvkbE3nag9Jw4haghE6xgQpKeZ+IZnb9w9x9fKPtGvozmp28Ygb9WNt865h3gMcSngM00aAUzGfgeEGtBS0uN6vAR2Vtl9Gq2HPf9bypcSY80pJKxN+HUlGLQoPmnegi59m2/H2EaawWronrVY9wnYr21tEoneUosH8iE7Arkg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199018)(40470700004)(36840700001)(46966006)(4326008)(70206006)(70586007)(83380400001)(41300700001)(36860700001)(47076005)(426003)(316002)(82740400003)(36756003)(8676002)(336012)(7636003)(54906003)(110136005)(8936002)(5660300002)(7416002)(356005)(7696005)(921005)(86362001)(40480700001)(478600001)(186003)(26005)(40460700003)(2906002)(2616005)(82310400005)(1076003)(6666004)(107886003)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 17:21:52.4421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbea1484-48d0-42b1-d071-08db18e71e38
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C403.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6628
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
 drivers/spi/spi-tegra210-quad.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index b967576b6c96..e1165584a20a 100644
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
+	bool support_tpm;
 	unsigned int cs_count;
 };
 
@@ -1065,6 +1067,12 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 
 	/* Enable Combined sequence mode */
 	val = tegra_qspi_readl(tqspi, QSPI_GLOBAL_CONFIG);
+	if (spi->mode & SPI_TPM_HW_FLOW) {
+		if (tqspi->soc_data->support_tpm)
+			val |= QSPI_TPM_WAIT_POLL_EN;
+		else
+			return -EIO;
+	}
 	val |= QSPI_CMB_SEQ_EN;
 	tegra_qspi_writel(tqspi, val, QSPI_GLOBAL_CONFIG);
 	/* Process individual transfer list */
@@ -1192,6 +1200,8 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
 	/* Disable Combined sequence mode */
 	val = tegra_qspi_readl(tqspi, QSPI_GLOBAL_CONFIG);
 	val &= ~QSPI_CMB_SEQ_EN;
+	if (tqspi->soc_data->support_tpm)
+		val &= ~QSPI_TPM_WAIT_POLL_EN;
 	tegra_qspi_writel(tqspi, val, QSPI_GLOBAL_CONFIG);
 	list_for_each_entry(transfer, &msg->transfers, transfer_list) {
 		struct spi_transfer *xfer = transfer;
@@ -1450,24 +1460,28 @@ static irqreturn_t tegra_qspi_isr_thread(int irq, void *context_data)
 static struct tegra_qspi_soc_data tegra210_qspi_soc_data = {
 	.has_dma = true,
 	.cmb_xfer_capable = false,
+	.support_tpm = false,
 	.cs_count = 1,
 };
 
 static struct tegra_qspi_soc_data tegra186_qspi_soc_data = {
 	.has_dma = true,
 	.cmb_xfer_capable = true,
+	.support_tpm = false,
 	.cs_count = 1,
 };
 
 static struct tegra_qspi_soc_data tegra234_qspi_soc_data = {
 	.has_dma = false,
 	.cmb_xfer_capable = true,
+	.support_tpm = true,
 	.cs_count = 1,
 };
 
 static struct tegra_qspi_soc_data tegra241_qspi_soc_data = {
 	.has_dma = false,
 	.cmb_xfer_capable = true,
+	.support_tpm = true,
 	.cs_count = 4,
 };
 
-- 
2.17.1

