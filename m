Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825396A47CD
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Feb 2023 18:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjB0RWC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Feb 2023 12:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjB0RVw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Feb 2023 12:21:52 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22D123C4D;
        Mon, 27 Feb 2023 09:21:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/zAZVoT2HEp1omAKMFhPbbMtspq/4ErWlR9wAgIRhdYnDgE5VAyAcjIlPgE0jT04DqGloN+u5Ng2jOxbipTtP3MHu1iqX2Ph1foVUOo471G2wBtA0kpepx0EdUnozfIyQcPMfRMjcTrQ1QGm3N8sUUP3lIajC+i2D0Wk/paMY9bRBKOtbbBgIVxDv0Q6hs2NxKphb6tYrZbhfiD7EUWH3l018NuQVGXmMswItP+6mAxC6Tnr4d1hrRQczZ9/S6AoTI6H2BB4eclmFdPc503sT1RRcAUfT641B+yXH6h1lu5FylQmF9I46C40uV9OmeZzdp7L5ulPOea7jd9bbePow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CrWYrnQzjeqIgMM8PaaGIiWahYHga0PSrE4U2JWwo0=;
 b=NEGVTQ+MkCLRr0TWvHJfl1Ds8eqHMzhA/DJRa6cK8vK9+bw3ZdjqyysQ/T8oSVZ/ntp3CrhJ55sed2HVv5oSPNxtcfmV0THc56VhfDs/04wesZWxfDCOXPnaTWhKAmdZ1e533N8d950Y5K02N6VdEOS8LB9DwWOVYPKk2O0or1GWDNARUXH73i1y5wxg/vQd6mAhJj6GJuKYZcu7zYSbONt839g42jBve1qKPKxVaGKuMNQWJDxPdi0KkwLT7/xzZKP6SHE22+2NjDYWhLZIHPQ2KNUcOenXiYnRopxQnf91IuW8nLPnqTeAyRzDCqe3hbAOm0i24JQ2dFV/CFfv0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CrWYrnQzjeqIgMM8PaaGIiWahYHga0PSrE4U2JWwo0=;
 b=FGc2es3iU3yBxtF85+x8yiSs4dY1wrqpbTs1Smf9+yKcoQrbZllTkOw2s59yE+fWD9fHRkAc4pFiAOJjatcgw0r9Lo2MbKf89AVowfEcSR9SWQRoHPoXMwKYthu68poCwvzi1BeSVSp4sdqY6UNQLjcN2NdRmegxnm+OC85NCUjLP3FE4DtrLiATPtLli9tA3kUkLNOBXbsqeHArC2cTlzwfZLOPknPKNi0j9OfdBla+n2IhSuZ01D6BQWOM20v2kw76lvugJAIW1Tnhs1w/v/pulYiCSJuO/l1zl3Mo1T0w2Jhj5kmYRoxgEPZgUshQ3M387WPSI5ieFsuUhtUblw==
Received: from BLAPR03CA0118.namprd03.prod.outlook.com (2603:10b6:208:32a::33)
 by IA1PR12MB6138.namprd12.prod.outlook.com (2603:10b6:208:3ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 17:21:46 +0000
Received: from BL02EPF0000C404.namprd05.prod.outlook.com
 (2603:10b6:208:32a:cafe::da) by BLAPR03CA0118.outlook.office365.com
 (2603:10b6:208:32a::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29 via Frontend
 Transport; Mon, 27 Feb 2023 17:21:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0000C404.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.12 via Frontend Transport; Mon, 27 Feb 2023 17:21:46 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 27 Feb 2023
 09:21:33 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 27 Feb
 2023 09:21:32 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Mon, 27 Feb 2023 09:21:27 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <robh+dt@kernel.org>, <broonie@kernel.org>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <jarkko@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [Patch V6 2/3] tpm_tis-spi: Support hardware wait polling
Date:   Mon, 27 Feb 2023 22:51:07 +0530
Message-ID: <20230227172108.8206-3-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230227172108.8206-1-kyarlagadda@nvidia.com>
References: <20230227172108.8206-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C404:EE_|IA1PR12MB6138:EE_
X-MS-Office365-Filtering-Correlation-Id: e35bed4a-5d6a-4937-b5f5-08db18e71a91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +0WqTloj6SsLNVAMazZZ0if9/2xc3jvxhZSAj1z//UH4eHeIwPndLG+5hmJD6lJUyxByjVQ4X/CH2Sb7edlDSiJ45FbWMvGsTaCxuXeyz1Sk8A2HqyL0TVqmcF5xHLwqXCNFS2GNKjKIWw4qeD7ZzScH6ASUaL4zdh/SjyLBOj6Wq0F1XEnM/0JJCxFSXM4q6a1TZccT6rGaEGmv4JRG1SAbZhuNcoWUcJ6M18JT3sads6iPu5RHbtmaAy0oO9j3WDG82v1pd7A5HH+NnBmbK4a0Nyxx5wki8kxls93TFQyLOTzSTuQ8y8MOHoUdZvAZmRIQuovzM4ZCCDnDZYbsR2db4wICyuUQWkfvHQFRXRQMdoDfpfaOPg4pdke0lXYPq+pA+rwpVPJhqcgkZtTUji4yGRUPFTIbu6ZowPUYuSyQUwFE9bQ61sxiXZD9K6w1q2MBw6OFAiNTXMiieDpuO4t4tfdgLk1Bdrj4a9x6idHzADOx8WlptL2Xo5jaqGN9gqAhdBzJ+15IUCF2odEZWy9Gx5K0Kl0KkwEkFeenlXnlPJoyL/8g7xN4mGaZMZqwSjb61hAOyhd2AtoXCKpviTyC2Y0AyAsZJgTrPH6LSk3SfrYwlSCqZWimuu2CcorfdC/RqddspMVYNUPlEzGCCnUSNyXoaX/AdX6MnlayXtUtNjEx51Zj7PZpAXeH7uirxX09eIsJs9SBTntUysqDgJVLHBdDftJAedFHqLSyb5MnoFk6oFCUb2Iw6B4N15KAHCTBX2G8p0TmVMSO2ekQcQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199018)(40470700004)(36840700001)(46966006)(41300700001)(4326008)(70206006)(70586007)(83380400001)(8676002)(7636003)(36756003)(36860700001)(86362001)(82740400003)(2906002)(921005)(82310400005)(40480700001)(356005)(7416002)(5660300002)(8936002)(40460700003)(47076005)(2616005)(336012)(426003)(478600001)(7696005)(110136005)(107886003)(1076003)(54906003)(316002)(6666004)(186003)(26005)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 17:21:46.3295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e35bed4a-5d6a-4937-b5f5-08db18e71a91
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C404.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6138
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

TPM devices raise wait signal on last addr cycle. This can be detected
by software driver by reading MISO line on same clock which requires
full duplex support. In case of half duplex controllers wait detection
has to be implemented in HW.
Support hardware wait state detection by sending entire message and let
controller handle flow control.
QSPI controller in Tegra234 & Tegra241 implement TPM wait polling.

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/char/tpm/tpm_tis_spi_main.c | 92 ++++++++++++++++++++++++++++-
 1 file changed, 90 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
index a0963a3e92bd..5f66448ee09e 100644
--- a/drivers/char/tpm/tpm_tis_spi_main.c
+++ b/drivers/char/tpm/tpm_tis_spi_main.c
@@ -71,8 +71,74 @@ static int tpm_tis_spi_flow_control(struct tpm_tis_spi_phy *phy,
 	return 0;
 }
 
-int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
-			 u8 *in, const u8 *out)
+/*
+ * Half duplex controller with support for TPM wait state detection like
+ * Tegra241 need cmd, addr & data sent in single message to manage HW flow
+ * control. Each phase sent in different transfer for controller to idenity
+ * phase.
+ */
+int tpm_tis_spi_hw_flow_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
+				 u8 *in, const u8 *out)
+{
+	struct tpm_tis_spi_phy *phy = to_tpm_tis_spi_phy(data);
+	struct spi_transfer spi_xfer[3];
+	struct spi_message m;
+	u8 transfer_len;
+	int ret;
+
+	while (len) {
+		transfer_len = min_t(u16, len, MAX_SPI_FRAMESIZE);
+
+		spi_message_init(&m);
+		phy->iobuf[0] = (in ? 0x80 : 0) | (transfer_len - 1);
+		phy->iobuf[1] = 0xd4;
+		phy->iobuf[2] = addr >> 8;
+		phy->iobuf[3] = addr;
+
+		memset(&spi_xfer, 0, sizeof(spi_xfer));
+
+		spi_xfer[0].tx_buf = phy->iobuf;
+		spi_xfer[0].len = 1;
+		spi_message_add_tail(&spi_xfer[0], &m);
+
+		spi_xfer[1].tx_buf = phy->iobuf + 1;
+		spi_xfer[1].len = 3;
+		spi_message_add_tail(&spi_xfer[1], &m);
+
+		if (out) {
+			spi_xfer[2].tx_buf = &phy->iobuf[4];
+			spi_xfer[2].rx_buf = NULL;
+			memcpy(&phy->iobuf[4], out, transfer_len);
+			out += transfer_len;
+		}
+
+		if (in) {
+			spi_xfer[2].tx_buf = NULL;
+			spi_xfer[2].rx_buf = &phy->iobuf[4];
+		}
+
+		spi_xfer[2].len = transfer_len;
+		spi_message_add_tail(&spi_xfer[2], &m);
+
+		reinit_completion(&phy->ready);
+
+		ret = spi_sync_locked(phy->spi_device, &m);
+		if (ret < 0)
+			return ret;
+
+		if (in) {
+			memcpy(in, &phy->iobuf[4], transfer_len);
+			in += transfer_len;
+		}
+
+		len -= transfer_len;
+	}
+
+	return ret;
+}
+
+int tpm_tis_spi_sw_flow_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
+				 u8 *in, const u8 *out)
 {
 	struct tpm_tis_spi_phy *phy = to_tpm_tis_spi_phy(data);
 	int ret = 0;
@@ -140,6 +206,28 @@ int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
 	return ret;
 }
 
+int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
+			 u8 *in, const u8 *out)
+{
+	struct tpm_tis_spi_phy *phy = to_tpm_tis_spi_phy(data);
+	struct spi_controller *ctlr = phy->spi_device->controller;
+
+	/*
+	 * TPM flow control over SPI requires full duplex support.
+	 * Send entire message to a half duplex controller to handle
+	 * wait polling in controller.
+	 * Set TPM HW flow control flag..
+	 */
+	if (ctlr->flags & SPI_CONTROLLER_HALF_DUPLEX) {
+		phy->spi_device->mode |= SPI_TPM_HW_FLOW;
+		return tpm_tis_spi_hw_flow_transfer(data, addr, len, in,
+						    out);
+	} else {
+		return tpm_tis_spi_sw_flow_transfer(data, addr, len, in,
+						    out);
+	}
+}
+
 static int tpm_tis_spi_read_bytes(struct tpm_tis_data *data, u32 addr,
 				  u16 len, u8 *result, enum tpm_tis_io_mode io_mode)
 {
-- 
2.17.1

