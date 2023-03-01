Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A506A7231
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Mar 2023 18:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjCARfI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Mar 2023 12:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCARfH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Mar 2023 12:35:07 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11hn2218.outbound.protection.outlook.com [52.100.172.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CCE2594B;
        Wed,  1 Mar 2023 09:34:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtdTbMVKx5Q3HJLd0llM2hup9vLYPsHScZVjhWZgVPxRY7aaROglHiNm01l3aq265BEXmoR6lhsyBSXGe26p2pyx+51dBdOXaVmYuBQXocNshszlpIdxgQjrSxvH8f469JX3bHVAMPxbFNgzjCjxkDGSOK4Aq3ytMStM7jFNekU3B6O5ICT6zNml9eWh2zvn0uCyK4nAJcyJ1RKsqGkdmXyo5mCZ8Otff3KhGKMVa7SLjgJ4S8KkQ32yOfWvsHzUSPhYraWmDtg6U3D4WABvc2/DIM6W6vSaHxMDYHxvX9XxfA47P3guS3OVw5U2IJtmGOIAokxGPxzQwvMFRNgKDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6cfpwnnVrUbHlknS5XSwMZgssAwk958FxhAcSDRmG8=;
 b=DD+IoJK8eHUu/603kDmc8WVbcuIEhIQtvkjFQMyrcIwhcSwPSyEKJHW4Uj74D1FDQp5NjF5MfIB0cr8tMSdqbnYdux6UUVwFnQceQWN59GyCJfChK5fWfQ39pFA5cG5PtGqlSGZ1BOFXsjeNNa/Cm/IK4DOel9qib8mpwQ9ks9r0X/EwblOxl6vMYzu2zSDzWy7BLyrz1usmfIV2tC9JaJADdGO42RDVlrL+ccRTFpmqV6dB7wgjgV9CcgbrDHtNFHzpVZHide1YRYUtqWgM4tNoytcLllHEHvreZ40//0niXBv1tKjH7PvRh8eFyJwi/ghtNjoKhxebo50OXRIDag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
Received: from BN1PR12CA0027.namprd12.prod.outlook.com (2603:10b6:408:e1::32)
 by SJ0PR12MB5439.namprd12.prod.outlook.com (2603:10b6:a03:3ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Wed, 1 Mar
 2023 17:34:27 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::75) by BN1PR12CA0027.outlook.office365.com
 (2603:10b6:408:e1::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18 via Frontend
 Transport; Wed, 1 Mar 2023 17:34:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.14 via Frontend Transport; Wed, 1 Mar 2023 17:34:27 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 1 Mar 2023
 09:34:15 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 1 Mar 2023 09:34:14 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Wed, 1 Mar 2023 09:34:10 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <robh+dt@kernel.org>, <broonie@kernel.org>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <jarkko@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [Patch V7 3/3] spi: tegra210-quad: Enable TPM wait polling
Date:   Wed, 1 Mar 2023 23:03:53 +0530
Message-ID: <20230301173353.28673-4-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230301173353.28673-1-kyarlagadda@nvidia.com>
References: <20230301173353.28673-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT048:EE_|SJ0PR12MB5439:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a90ca49-c1d3-4e51-a8f2-08db1a7b34e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3a2fgbN0F47Rs4XTOA+HvHNN2ohx4ZZ6PK15miBMYDr1bZiJR7EZERPLlMyNHxnUa/SzFgVu8zvKtkh/sxOmGTKCCit0rTEvE/bIu2/H5bz0T52YUxu+YZ3MkLWaayXo3mHh37OmkHf6MAtZoTcllMdFACd1499chNKz1ToLiaoDFALFu9Pweflbxa4MSH9cRJ/huzsk/9hiJ9UARENu2mXLuRblxJMv9bGBd904xapDCFWaI8WN5rdvp7JQcN8e3NWZfcQI/ChAJpMGeBWb1C1RmJVfIRj/L5TwL/OsIRCEOpTcy5092tSsNNLBkq8NhUV3VTpH/zRiq2HUZziYGapHLlIng0iYJMTZ50/N24Y/DLumhX6zNt2KtwUWm/FOGHYW8SJASxdOG/QDgzsNT9NW+Fexn5ax0/NiYlYeG8mzzIwXEdWFhtxe7nV3jmgPPOvVBS3IshzPBHQehjHCNq0NZtGslNA9d3cUAXJ6/jgbAL83BB3g6h4SH4LbvaJDjXeNvcyfUvQnfmoRP73k2d0j1JFcjTgF+pMyMeEaESGza3wkZpkmJQsoUoJGx+qujYHcqUDqHoGCSzNHZbXLM59ZYeGCqnLYOQR5SGIO8eypefljq+gsiUYibRGVSamDfcexR9mFIGhD6MtyLaXNiO/bFhySNuE9HUcgLK4GuLnBGi/0vYi09kQXm38Vz7llLSfCwSKuSz84NF6NsXxT76w0ikYTWF7OESLC6m2NXD0R1SVDjCirVE6YIULB//XnLZ0pjJiX9OryHts4qEMOeT4vYR9H7sfj8NL6FQytTxPMoXYaz4lyo/OOb07VYei+driH3GUy2wE9HmFhDAGF5w==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199018)(5400799012)(46966006)(36840700001)(40470700004)(82740400003)(7636003)(36860700001)(316002)(2906002)(34020700004)(40460700003)(7416002)(5660300002)(40480700001)(36756003)(8936002)(86362001)(26005)(4326008)(70206006)(70586007)(186003)(8676002)(1076003)(110136005)(921005)(54906003)(356005)(41300700001)(426003)(336012)(47076005)(82310400005)(478600001)(83380400001)(7696005)(2616005)(6666004)(107886003)(83996005)(2101003)(12100799018);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 17:34:27.1529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a90ca49-c1d3-4e51-a8f2-08db1a7b34e1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5439
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
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
Tegra234 and Tegra241 QSPI controllers have TPM wait state detection
feature which is enabled for TPM client devices reported in SPI device
mode bits.

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 0b9bc3b7f53a..82aec6cb7863 100644
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

