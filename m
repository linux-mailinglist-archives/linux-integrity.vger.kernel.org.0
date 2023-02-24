Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434AC6A1EEB
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Feb 2023 16:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjBXPuX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Feb 2023 10:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjBXPuW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Feb 2023 10:50:22 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40D866973;
        Fri, 24 Feb 2023 07:50:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KsGxCl6rfTU4tPRX8VSSuSw5stcZky6lp7hnJotxaVSIv6fruURmgqTqTQTGjDtNIOZcvZVTOkZCfDAr3AIDZCYygTbXKSGp55DK5386vC2/9X/mXFb8WKqy37MMKBzUhhw/V5L8Hs5Xxia5icO34HbwZ7A6bKapxIC4ihKDxXQn4dsIWqpfzY+q76cQ1/qkQny/hzUd3x21FF9u2D2civ5K7Javed9pTdkAqX/o8o+e0ttKiKWhJRtu/lIuWZ6l3CbvPD44nyPYLyKl5WTdReQ/4wv/V++t58dxOUsJNWGFuWFldrDeQ6XyeYhwsC7H61TG55X+d/XBeA2y+w6pEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzD8z7HwK+9VBLftUFJPu9vmJRdUl869K7Fizq2RcOc=;
 b=NjMUEnS0u7UjVBWeu/Kl0Q9cg7qUnGsZj7gAJBXz99VhOaPwcV9LQ4qTk/npRpiy4pzPNLyW7k/xjFRij61dGOzdj62ePAfHND2AP65nnhkg9cNKBQyzV7JkHvRcsCZBc+CQ9gs7oQ/oC1jgI1zjbL9x92m11BkTa4E6crk1+W4uD7MZfm3xylcu/PStqI4hxue83ufIBEq/XB1zfv4Gp+h+1qEzMwLQZzRrhexx78oWoQmLHn6SUVvpMQcWkFlVBkS5Or9QY8qBPrdjEw3H7inrQNwn8oXvc4C+vWPoPici7LXJj2dla3GupaOSEIvMz8j/YeK/9XGVsZOESm4g/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzD8z7HwK+9VBLftUFJPu9vmJRdUl869K7Fizq2RcOc=;
 b=Ymm7gUDpYGff2w7FhQ2CP7sXQ/1zFCGrMOYxzx3G0vARO/jOTJXvtPwf3RaazKS/MK/EqQ/ds5PGz3tUsCN6/7z5y2IJLTlvIzlsMy0KoX8Iaq6TjILWW2gdJOeAPB1uEEJjq/NGlkiG3xUxL8vVYiaDcwwSe/bUYalMCeZ2Qh47AeGNFB2ycs8XiEiKnpGpMh1J09yYD80TuaS770xkQUDTU6g5o0pCzbt2tUZWqvBXLGu9mTAhLNvE408y00dXBph0iBXdsSaTqNhrqStGJF8yY/cTvpAdnGxzvieYsePqcZg/j3hqqoRNhx5Eb0T4o3hwoJOJ574ptb9tElULzw==
Received: from BL1PR13CA0164.namprd13.prod.outlook.com (2603:10b6:208:2bd::19)
 by PH7PR12MB7356.namprd12.prod.outlook.com (2603:10b6:510:20f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Fri, 24 Feb
 2023 15:50:17 +0000
Received: from BL02EPF000108E8.namprd05.prod.outlook.com
 (2603:10b6:208:2bd:cafe::27) by BL1PR13CA0164.outlook.office365.com
 (2603:10b6:208:2bd::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.11 via Frontend
 Transport; Fri, 24 Feb 2023 15:50:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF000108E8.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.16 via Frontend Transport; Fri, 24 Feb 2023 15:50:17 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 24 Feb
 2023 07:49:59 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 24 Feb
 2023 07:49:59 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Fri, 24 Feb 2023 07:49:54 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <robh+dt@kernel.org>, <broonie@kernel.org>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <jarkko@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [Patch V4 2/3] tpm_tis-spi: Support hardware wait polling
Date:   Fri, 24 Feb 2023 21:19:40 +0530
Message-ID: <20230224154941.68587-3-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230224154941.68587-1-kyarlagadda@nvidia.com>
References: <20230224154941.68587-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108E8:EE_|PH7PR12MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: a67e445e-2180-4933-2976-08db167ed39c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: acvZsp0zHhi14oitGJhouD36fQ24dDAFTbk4Yl/8bBiUGBYUE0HHXsXASTEncZQPmbkjo5p0ko0cDbJTr4ju2cQAjWZjQNPrupfnCRQMv7/zQSYBDIVLZDwDA8gNSiRbMTHWE7ni6uPoHTuQJBzlWYNYttb1AzcS2AireZB5fxPk2pgoAOied0uj1OSLlrIInuPMHfgA2NukK755j/jgzzhtH1bkxvYNiSgGbR+xGcsttjLTfJ7hxSQcpPtBXXmuYHjRp/nSabrJVPyLyOqIAoqJeFCp+ZLZemU6sCcUvXyJXHrvQ1rrg1hH8KGw4uwhAQXCNHbMB70MNnE5Gv6eI5JGktIraSyF5XmiCnReO4vhqhJ0Jx8qdF36X8Di3HbC6pnrT2jpURNsLqcLlzgWfFN1G0g6Qg6I6qlbXKq/o55EM45C4FjGnZ7Sstq7LpQpzY2scZ9jgJdnnYjRft3G7EmTMhKN5GXnBovm3VIRxmK7TbQq9s9kq+CeQ+a0LmcwkhgH72xsKlJsRIlEucD4W+OaSGL/5ASEbwSoeu1xLEy+p7hK/nzow3/ZALPZjbnRAJM6JxQ5D3St7+QqhDdd8myKn0gMWtuWwvRY7z4VqtPd5nxFN5jMPu45IBebZkq9PWYNIMF08EHZLYd72ofe9xwpzmB4vStEAk4CjwZSRE8V/j/fN907VFgEXmlnmlxPC8mx++WIXW0LNcljXgwbx5mtygaqurtSBwTr3bmnGf/4rlR/YlUqUbfIA0WIBc+Sy2xsn8OrY6qmhvtXg0bpZpjmGGR8iX1oUuAUP9BekSB8G50tRmMmMoELbIftHmEs
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199018)(40470700004)(46966006)(36840700001)(36756003)(1076003)(6666004)(26005)(36860700001)(82740400003)(186003)(7636003)(83380400001)(426003)(47076005)(2616005)(336012)(107886003)(41300700001)(4326008)(5660300002)(8676002)(70206006)(70586007)(8936002)(2906002)(7416002)(40460700003)(478600001)(7696005)(921005)(356005)(316002)(40480700001)(86362001)(110136005)(54906003)(82310400005)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 15:50:17.2943
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a67e445e-2180-4933-2976-08db167ed39c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7356
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
QSPI controller in Tegra236 & Tegra241 implement TPM wait polling.

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/char/tpm/tpm_tis_spi_main.c | 96 ++++++++++++++++++++++++++++-
 1 file changed, 94 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
index a0963a3e92bd..b193c950f133 100644
--- a/drivers/char/tpm/tpm_tis_spi_main.c
+++ b/drivers/char/tpm/tpm_tis_spi_main.c
@@ -71,8 +71,78 @@ static int tpm_tis_spi_flow_control(struct tpm_tis_spi_phy *phy,
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
+	spi_bus_lock(phy->spi_device->master);
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
+			goto exit;
+
+		if (in) {
+			memcpy(in, &phy->iobuf[4], transfer_len);
+			in += transfer_len;
+		}
+
+		len -= transfer_len;
+	}
+
+exit:
+	spi_bus_unlock(phy->spi_device->master);
+	return ret;
+}
+
+int tpm_tis_spi_sw_flow_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
+				 u8 *in, const u8 *out)
 {
 	struct tpm_tis_spi_phy *phy = to_tpm_tis_spi_phy(data);
 	int ret = 0;
@@ -140,6 +210,28 @@ int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
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

