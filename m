Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2316C9020
	for <lists+linux-integrity@lfdr.de>; Sat, 25 Mar 2023 19:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjCYSfJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 25 Mar 2023 14:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbjCYSfG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 25 Mar 2023 14:35:06 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11hn2204.outbound.protection.outlook.com [52.100.173.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96640EC69;
        Sat, 25 Mar 2023 11:34:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gU5JbaNZw0Z+drBr2foxXt5ZF/+Ipyy7dHCF5d85zsRHwVVPO1X1lX/GwLaXE3/dhzI0RRSHxNrtoj4gWrlfGV3NAKHwMWQUq55+ySAYLhK3GsJ/begRIPFZ9EqpNIX1Gg0rMg6WKZNROkr9DUr5SODUKpZ6EKM4JdFXid7a7d9k8hv8DP0XcPT3DToxlqpzqMY/OKLdae372BiivYIrzOlgUy1qHtchm8dw5NzV+vGwD9E5xyRcoXaFvQtEcI8d/bDJarOX/3eT37VVR5DizRO+fpwNpCm/cf+6OemFc5htwL6XADl8TuSglq/1fOdphhDDIufopuHZP0yJIVkONQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHUi5v9Gc3/D8leeYb11n8pDVawxq0/2mLSkzw+ypPE=;
 b=i0Lbp1JyybLDPF763QuKXDhS8ZQkj4YartgkLMKwlV14EsZakQcdIhwwfohJaI2UGChNRACrEw3WgDZliVBmejpRw7bL0ZZw6CCbNA4WLDMdRydDbv3eBor5D+cP2/B/8AEpSp0NBBozy9s0YqpRPByJk83p9/7qQLNQGfhaapIPdYbZpPk6V3+0gcscK8z9xVr0ESWiSS2duJLBQSXXtTkxANkhZeGTAQ8sO9/DR+bJ7QNK4DAiAkaotUxyGL81MKJmTgkucTBCZhdSZOo/AHKE573hVH2LqVHvb51bzNi0oSbsFcAE1+z44RCvZHKx8wZ3gT5O5IN8n/YAXwD1kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHUi5v9Gc3/D8leeYb11n8pDVawxq0/2mLSkzw+ypPE=;
 b=MX2PG2IVQYtYnyliaRG+manL34apFTeyTZPhpkKe3P0U44x3vUn+O6RhGX/3XylJaWsviHmw7hiJmlQeVCC7nz8sssSdI746Yk9v2t/ARkyjxGBpKTq69kKJeFyJDZFIGcCb9XBeC8+t99+kH9T+mIo2BA8SPKCTgZshzWq0sMnNdfhh7A4Jgg+RkmixPy1wTdqXvsLpG0/7atWqTPgyVWLmjGsa13Y44bA4sY7LtoHb3w10OBTEfIcS9rgqfImjE/SqRWL++ahSfq72ppfcVQocrx834Xo1aUci9Dt1qXsOEvLGNL5xZ92op0WXY27Etc/3ZiRTTNw7HIAbF2osVQ==
Received: from BN0PR04CA0193.namprd04.prod.outlook.com (2603:10b6:408:e9::18)
 by DM4PR12MB5940.namprd12.prod.outlook.com (2603:10b6:8:6b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Sat, 25 Mar
 2023 18:34:53 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::51) by BN0PR04CA0193.outlook.office365.com
 (2603:10b6:408:e9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41 via Frontend
 Transport; Sat, 25 Mar 2023 18:34:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.22 via Frontend Transport; Sat, 25 Mar 2023 18:34:52 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sat, 25 Mar 2023
 11:34:52 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sat, 25 Mar
 2023 11:34:51 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Sat, 25 Mar 2023 11:34:47 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <robh+dt@kernel.org>, <broonie@kernel.org>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <jarkko@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [Patch V9 3/3] spi: tegra210-quad: Enable TPM wait polling
Date:   Sun, 26 Mar 2023 00:04:09 +0530
Message-ID: <20230325183409.7695-4-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230325183409.7695-1-kyarlagadda@nvidia.com>
References: <20230325183409.7695-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT064:EE_|DM4PR12MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: d6f97a4d-3c4d-4d0a-7ab3-08db2d5f9ff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FO4dGUjyWZKMeLK4TM48bmWJm34kPMcN6gU/Mzo3XJUPIxzB589u1Azx+IQLa/VEc3ZOD7LAM5iwqrAr7rCOHHtevNdukAMMi3GQDr8TDl28PFAUH0kjPZ3RTvx1sZ4luD3gysBK6a5EtkgM8WAKMb6YzsWN0/kcGcSy0ZcbI5Uz+TKbedReHWrW/hO/VH2wqufdq5Cr3dskWV0eDl+n4rxrcbGN/gPBRM0XexPMdd8JL5rn4u3IczaFWv28CGE44z8qPMLpjbLUN26QJZDZQ65AG9KI8xSz8iPJWIzf1bMOVoCzyD2pXXU8NRwawprR1eCJJPMDmZ2pmhSRYbpP3wUGaXu7kniLO7PjkoBBO25NziKJSttOY1OLLyHzio1v0mG0/eMHaNehI6mjYp/SLR2fR186aq9XBotxEhpSLDWd38tSNNZBJb9Uy+iAM6uAqJHMt5LLKPJ/0cDpk1c1PrD2jrq1f3P31T4hxTpsiD1bfyT8bNJcmyHe+Au8wT/fPfFMUWgkYKmfe6JDsDv5E8f+saakG7r2dcbp286w4Jh4l3LmdjxUR3Mu9JxApvR50y16ckvfOeKH4uLXdasSxzifiF+GKEHUMIUnbURH2oHTsKJhVYtHg6h8nTgGGLT0pKBhU4pCsOktVX6rpqjdf2SGiHkR3fXT/Ns7LIv2KrGUDRZAYgL78hzdTfGfKFX2KGdrD5qM+e6nvaZuP+mPGoev6vq0VK7q++G2EZwiLfaRQdIKkrcWeKYfgIjdkG2JtYYKjAKS2GyzKIOK4yitrlrDRoJZ9hnKaJQgRG0+8jrWC660QHcO6TsW7f2C0esZBxN1Mv+1Hu2GuQ8j/eGAHwMu4A1cgMc27ZXXbAs2rrRzGJSu/DAB6fhlaxnlQAJp
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199021)(5400799015)(36840700001)(40470700004)(46966006)(921005)(356005)(40460700003)(40480700001)(426003)(47076005)(83380400001)(2616005)(2906002)(36756003)(336012)(34070700002)(36860700001)(316002)(110136005)(54906003)(107886003)(6666004)(70586007)(70206006)(7696005)(478600001)(8936002)(7416002)(5660300002)(26005)(8676002)(4326008)(186003)(41300700001)(82310400005)(7636003)(82740400003)(1076003)(86362001)(83996005)(2101003)(12100799027);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2023 18:34:52.9768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f97a4d-3c4d-4d0a-7ab3-08db2d5f9ff4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5940
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Trusted Platform Module requires flow control. As defined in TPM
interface specification, client would drive MISO line at same cycle as
last address bit on MOSI.
Tegra234 and Tegra241 QSPI controllers have TPM wait state detection
feature which is enabled for TPM client devices reported in SPI device
mode bits.

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 325b4427491c..de6aafe4448c 100644
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
+	bool supports_tpm;
 	unsigned int cs_count;
 };
 
@@ -1065,6 +1067,12 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 
 	/* Enable Combined sequence mode */
 	val = tegra_qspi_readl(tqspi, QSPI_GLOBAL_CONFIG);
+	if (spi->mode & SPI_TPM_HW_FLOW) {
+		if (tqspi->soc_data->supports_tpm)
+			val |= QSPI_TPM_WAIT_POLL_EN;
+		else
+			return -EIO;
+	}
 	val |= QSPI_CMB_SEQ_EN;
 	tegra_qspi_writel(tqspi, val, QSPI_GLOBAL_CONFIG);
 	/* Process individual transfer list */
@@ -1196,6 +1204,8 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
 	/* Disable Combined sequence mode */
 	val = tegra_qspi_readl(tqspi, QSPI_GLOBAL_CONFIG);
 	val &= ~QSPI_CMB_SEQ_EN;
+	if (tqspi->soc_data->supports_tpm)
+		val &= ~QSPI_TPM_WAIT_POLL_EN;
 	tegra_qspi_writel(tqspi, val, QSPI_GLOBAL_CONFIG);
 	list_for_each_entry(transfer, &msg->transfers, transfer_list) {
 		struct spi_transfer *xfer = transfer;
@@ -1454,24 +1464,28 @@ static irqreturn_t tegra_qspi_isr_thread(int irq, void *context_data)
 static struct tegra_qspi_soc_data tegra210_qspi_soc_data = {
 	.has_dma = true,
 	.cmb_xfer_capable = false,
+	.supports_tpm = false,
 	.cs_count = 1,
 };
 
 static struct tegra_qspi_soc_data tegra186_qspi_soc_data = {
 	.has_dma = true,
 	.cmb_xfer_capable = true,
+	.supports_tpm = false,
 	.cs_count = 1,
 };
 
 static struct tegra_qspi_soc_data tegra234_qspi_soc_data = {
 	.has_dma = false,
 	.cmb_xfer_capable = true,
+	.supports_tpm = true,
 	.cs_count = 1,
 };
 
 static struct tegra_qspi_soc_data tegra241_qspi_soc_data = {
 	.has_dma = false,
 	.cmb_xfer_capable = true,
+	.supports_tpm = true,
 	.cs_count = 4,
 };
 
-- 
2.17.1

