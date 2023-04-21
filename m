Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641486EA6B7
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Apr 2023 11:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjDUJOf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Apr 2023 05:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjDUJOW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Apr 2023 05:14:22 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733FFAF20;
        Fri, 21 Apr 2023 02:13:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcoSur/NKaj/1vrZmN3frx69RshmW6wlfnYqRH/olB4IRcDQQoLCOlXVQh+kzHslto/0Nkl5MXrqaSw2zdqzCXSfXmuP35mijcR762is+y1A/EYfAGh33a/0lrBPS01KfCjuuy9Fux7208aiSaFqMG/HsXhb/DEzD+2aFww1a44ucNefvbTASA/9v9I7VGK+zzYhFJQSrrjOxtu8QRSyGDGg3658IkJjUxkuhlOQ723wTU40nPwHyBkc+bkGG8RB7Zlt3KJr9LCbZZbKW6HyVeip6Ozz5a2AA115n6RgiPZWwB+O6xEUacmI9M2cpEwE6SfAeFEkzTT8Bi+IdxN0dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUsSpoKQuIhRMFitmIN57d/3toAqN22GXDMTeeyP36A=;
 b=fXlPLrsfqtlwCOHyYA7847iJVQ9iskd5gCVG5dIXYY5SUIEQz3jCecruQGliMEBbrxHVuabSb6LVq7kjXwwJ3xZCdz0qDBv8k0vR7rVrhpaplh1lKf7mnwxdPPHmFA1rUrVgO2halI3WlK7XC3BxHk8M0dpZUimizOmfGqzAn4+GrxuMjAA35ch3yHu10RJ0sqDUSySOhyEpHD5ojcCGS3N8e/WSssbEx2jHn/cm85rlQeBmg6Z5AbT2ryMNIlNWEQ/HrX8YkiCfnnyms2vQmvlhYikiSI1vnjJ/15a+EKJRoOaGxDdQ9ATquE8t5hgwgMq4g+CLYqOJqxkz5Bihdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUsSpoKQuIhRMFitmIN57d/3toAqN22GXDMTeeyP36A=;
 b=plD0fIScnitp2uQcdkW/j5k9dokqtVL2nDIGqKb066GqZvE50TdJe6pzcSAeFGfugzNFIVOqs03JLgoxa/AH+XhRJKFZN0DkG+XgLqZUCxmTnsV+mE6QHwKGSU+GlCcMOxe16QfywlgeF0Tuvl2KWQfLE7tbF41TWHOubryQfmrnCuF6tlp2zvBOLxeLjqHdKk64dyvniuE8uIHxdtK7mioOGhlwA3DGiX+4w2N0xMOJW0LBx3cxqC/cwAyB42y8LJNTC4z7ls+1yPrCyZD2DufhfGI6ql4OI/wwtUw8e9ZDXPvqhAvtyKgp3TrDm3PaCN6VzytcT2AVxV5cYHBZEA==
Received: from MN2PR10CA0025.namprd10.prod.outlook.com (2603:10b6:208:120::38)
 by DS0PR12MB8199.namprd12.prod.outlook.com (2603:10b6:8:de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 09:13:53 +0000
Received: from BL02EPF000145B8.namprd05.prod.outlook.com
 (2603:10b6:208:120:cafe::2f) by MN2PR10CA0025.outlook.office365.com
 (2603:10b6:208:120::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.25 via Frontend
 Transport; Fri, 21 Apr 2023 09:13:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF000145B8.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.16 via Frontend Transport; Fri, 21 Apr 2023 09:13:53 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 21 Apr 2023
 02:13:44 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 21 Apr 2023 02:13:44 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 21 Apr 2023 02:13:39 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <jsnitsel@redhat.com>, <robh+dt@kernel.org>, <broonie@kernel.org>,
        <peterhuewe@gmx.de>, <jgg@ziepe.ca>, <jarkko@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [Patch V10 3/3] spi: tegra210-quad: Enable TPM wait polling
Date:   Fri, 21 Apr 2023 14:43:09 +0530
Message-ID: <20230421091309.2672-4-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230421091309.2672-1-kyarlagadda@nvidia.com>
References: <20230421091309.2672-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B8:EE_|DS0PR12MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: ba773f36-76da-4ba0-4e12-08db4248ba49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xSoZdK7VV7FiR86gfa8s1yJVjL6DFuOV/vMUyCV7k3I0f/hWv6dF2gvuyaaXQBdt1i0dwWpD44fyXZRLOI7LVhvZMyFFzB37L8dXpbj7v4J5vQEegPQA3jze6rKPvlJn4JX70eIMDFk+g52pb+JNnD8Gl3gmuLyVhJyr40lK08Cjl/dGhFwgAPzwRRu7pGvjJYISaEiBtS9I9sdBsMtaVtO2RPtgUgStuuYZC0FgJhmAZLsrcaaD9sIViMzSER54PbsStwW0KGlfcsXUJlbCLsw12021ys8aU3hLCBXFq4aNBmflkDhrQKd9iwuNsp/B2GlFUMz/+y8CuLRykb2TXALA1jRNEKUJWZIdYvnPY8hBzMepWqAju6qzjlAPhelWzXC8gfshLHEaIIiUSCC8DlFO/0SHzyMUTOQZJX+iw2EfJipM7D43Ipl2ikdusA3u+0VrTQpPVfY9fMfpOwpf8Nj9zbau30QxbXGeJhb4ewbIAUHfNYqzGSqJtGbenQo82tkj5Q1V7rJ+8nIBddhhrejTdmxO+VgdsOyUsnnciqJJvSbMBH9seQEZP2caCDOpSmrvYTLmkbAk/5xTK1wrQ9rIFnT7dol8UXioMI+OyjetAGK99SbSr/cxHG/wj5cxfO/FHgeb6cIVUrMgATZjOl8WwRW1P5cCXv/rUrKkA1ymTFOyDSU/a0HI0jJ52B02OsCVqzYd5bmAdqjnur6vXgtt0e4EXyX/q+PnrfRrM5TAqOfKwBFjzX0ifvhK+aDokAEa96WZDXf5xE5NYgnpSsws6aB9FZM/X/0RQvq/VSI2ROmS4SX3hDAVQj1d4P0m
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199021)(46966006)(36840700001)(40470700004)(921005)(316002)(54906003)(110136005)(70206006)(70586007)(4326008)(40460700003)(1076003)(26005)(107886003)(47076005)(36860700001)(336012)(426003)(2616005)(186003)(83380400001)(40480700001)(8676002)(5660300002)(41300700001)(8936002)(478600001)(7696005)(6666004)(82310400005)(86362001)(36756003)(82740400003)(2906002)(7416002)(7636003)(356005)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 09:13:53.1470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba773f36-76da-4ba0-4e12-08db4248ba49
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8199
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
index bea376acea1f..fbd14dd7be44 100644
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

