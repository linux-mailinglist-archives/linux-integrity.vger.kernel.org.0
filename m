Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB73E6A4172
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Feb 2023 13:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjB0MID (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Feb 2023 07:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjB0MIC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Feb 2023 07:08:02 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11hn2222.outbound.protection.outlook.com [52.100.172.222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E0D1F5D0;
        Mon, 27 Feb 2023 04:07:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHrNTDNdpwxNuShTBCPVj8jdDcIwtGh9/PiqeXLjizxX8kyoHXauJjRxEpa74+4AnQZ83U2/psygiirBfF6XsAQrVtPm2uq/9GGb/4OKJllaBLbp+BcS8n9CTIR5l4By5u+P8hARRTWD1lTdIj7Kcww6uMy0v0AmuM42jQTRI+xMxB4o7kbFbXLx66mVv/5Mvrss358P2T8xxRJ1zDCvknK3/foIj7isF7r+/zTN4Xa+HAw6jAVHtP+UTGYDwqnra4TQ7nMpbMHgoW8o2dyJfk6QGfvdi6IbQgXoa9R6ap1dap6hM7QhUHT4Z81SHLUuYQk4IhkfTaJQVNI5kHRpCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpKHpbqOPtWGpwP1tKVnq5lfCOEd70QTpkDFyU21Mqk=;
 b=XWck96eBJR1Q8Ka9wSpjXLUdjY3vfApQDmRQoeKCv39tiNPvVmGu6eWcGpmxquTEkhlvE+UjJWG0rx4k6Vse51yfooXmFtD/IZd5PHEjD1M2IFFQQBuya3QfewZo7+bBe68H+WdHm0b0iX2eMz78Uog5IdXxc1HiALX4mALB/qI6v6K2CxIpZ3AJwDQ/dfgh7i15IuLZhvRJZ4F7XtqR9zJE+rRATvX+XK7Q5Nesk77jVq11sUA+H+6JrzkiKLGqAMpQIvTy76p4UFlWkqQOnqioefPtCQAoQA6RWE+Xsk5E4qFcORly87MpDi8oVIiHp1PhEdLfw7PC5X+ASOA7/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpKHpbqOPtWGpwP1tKVnq5lfCOEd70QTpkDFyU21Mqk=;
 b=Nz2GWA5dJvSkrIgoQxUvTBgUTEeEykyiZx5b+zWU29vxldZNpQL2CfyNdNa/NTraeX8vJNQvmehDLPdpTRflpEE0hxtNWoFAxRgsw4pKnwL+ege3PaXE5MS1MJzL8KuLuykUz/Jtw/Zh+bpzCEW19dA1GaXEhO0vPQzJfvwBi/Do+rGHqAveQcCU5PZhEdP7KURUAIJ2tRzsc9HJwN76LLulo9G+PeQChpuTNcdMSXOBYmamqC/0XrKp8aM7yvBHD6WCRsPiDyeZDGErOw7xTS7YxVhcqjk/uNzt6f5BA0+nYIJjH3NfUBwaHAqzUg4lIbbwRuMiqUkzhmkcgmU3QA==
Received: from BN9P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::13)
 by BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.28; Mon, 27 Feb
 2023 12:07:40 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::d2) by BN9P223CA0008.outlook.office365.com
 (2603:10b6:408:10b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29 via Frontend
 Transport; Mon, 27 Feb 2023 12:07:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.14 via Frontend Transport; Mon, 27 Feb 2023 12:07:40 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 27 Feb
 2023 04:07:27 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 27 Feb 2023 04:07:27 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Mon, 27 Feb 2023 04:07:22 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <robh+dt@kernel.org>, <broonie@kernel.org>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <jarkko@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [Patch V5 3/3] spi: tegra210-quad: Enable TPM wait polling
Date:   Mon, 27 Feb 2023 17:37:02 +0530
Message-ID: <20230227120702.13180-4-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230227120702.13180-1-kyarlagadda@nvidia.com>
References: <20230227120702.13180-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT046:EE_|BN9PR12MB5115:EE_
X-MS-Office365-Filtering-Correlation-Id: cfe91f0a-b878-4fda-ba07-08db18bb39a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NygylvNpcYHHmoGZzwUljsuhh4rqavwLGFnEj3xI58i45rSCKLNiZdztzqtRqFZk9eJT0HIlWzgxWokABoJDXU1CvTrTs/eH5px5MfCLz08ck3nALHyaC+NL4aDX1a06WHOyci2AXyFCR0UdAhN5AyOb/G3TT6dDAIzx28o/TBM2FzJIhzr9PZow8MArL8G2hr+Lqgy8UIpcb/ox9vQ2mwnJgSA2Y3Xi9NAqwCkeyUEZwEdAGC5b3UpzG+1038D/nV54r/f/7itd2GeDHXzh8TbJ9ww1bUZMTXc8yVN4xbLv2dykUOFRVUVg3MT7w4YcvKAh5WKMIsSLFqrwTjorqq30HDEWp95VQ08XWvWNBow4JYnICgm9ZsGISSriCVFvoOMGmUpTj68zJqGHxnd4Fl+n2jZ+meqQTgfriXXUVHZjIG6dSyJE+5TcXlRcZkRR8SLwz9b6zY80tT7TZ7IXb3tsK/HEqNDAuIPafqbF1NhkkDultN1JvR4T13mCwr0L2n5/BZXqaqO0usIRQ+TAbbOGaaXYh3d8yRo0cbJqpRTAmjUQC3KbPqD/0BeYWwqNUcX7u/FdnEldob+drw+lTh9s/M4CYNf3GJXPjO+LogUYYxFS59iw0UcC4OyuSWEcgel/65h4v7zQJ4ucJvySd2qhYfBPO7afHi7g8OB4GC5u++tk3rzmHYd0EscKVXozRtDvDE58vy56xVCwLc9i3+XA3mLLebF8L40UfJ/OVipm4T8h7v2BLQFB8+yjMIF8O7bAP5jWeN/hA4+ULZZB9GiICayTzGtn+CL/lEBb9GXHR3fqHrbzy9rStneWb1rweq2Wb+vynPPLUP/NXI1DBg==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(39860400002)(376002)(346002)(5400799012)(451199018)(36840700001)(46966006)(40470700004)(40460700003)(186003)(7636003)(83380400001)(82740400003)(921005)(356005)(8936002)(4326008)(2906002)(70586007)(41300700001)(70206006)(7416002)(8676002)(36860700001)(5660300002)(34020700004)(7696005)(40480700001)(47076005)(478600001)(1076003)(426003)(26005)(336012)(6666004)(107886003)(2616005)(316002)(36756003)(110136005)(82310400005)(86362001)(54906003)(83996005)(2101003)(12100799018);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 12:07:40.6008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe91f0a-b878-4fda-ba07-08db18bb39a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5115
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
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

