Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E30A6C901C
	for <lists+linux-integrity@lfdr.de>; Sat, 25 Mar 2023 19:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjCYSfA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 25 Mar 2023 14:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjCYSe6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 25 Mar 2023 14:34:58 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D44EC64;
        Sat, 25 Mar 2023 11:34:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXZHw/zPKEZvAl6zq9ck4lU4quqjAxguc9gBhhg0HHyZppCWwc1jzwBldTE+QTv2AdBNPXAL/+YmS6kSiYut1CpeRqUXhmiEPg1gLcvLmXdfgTmD/vOfcDW9k7e4JT8clBxpqNJCQH485r1b9Vinp27OZip8ZoikuRdLCXWFeCtumUhLZUsyJKBHU+bIEanVBKi2Bnop3ROIV9QiqMShA/UzFa78c4/jvM+/m+GZN15wGpqGXwRS93QquJOWKhHe8WZgeTEKO5mfmHpX/4ujAYYk9OFOF2SgyPKqeAjvnHtzBr/1AwxcyTMg4PpUA/oZdqLo1ecbO3PcjCXcRTF62A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=StINWBCtlNjUBBGRhBLQYhG7ObosSZr/9pmozLHAl2M=;
 b=jXu+tA1M1as+jMCQzvzFezq1ez14VzqsUJiU9XnOcO4/Ue8UCAy6XeT+wWmlV6KBFP1xQyMB6EorJS0sLb7zs4xVLPbGt3BDn+C97b064508VPSqjxro0OA853a0IUY0HV0qZp2gbQ5oQMDDqmd59Scub6hcVlVrqxPcQicEhtiNmwc9S5uMBw/mCW4OHuC4wiotiCUXQHlROFyU81+u8G9Na33+afBcou70tWQb5EbGKAl7KFAB2XxnsMJJtaTDYdujCfFdH9iRxaOY3J7BpunMBE1jaHxPvivpP/KBMozK+zROdIimt8Y3HYG4m7EhHbrcTziFw/bowr7r8WyVkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=StINWBCtlNjUBBGRhBLQYhG7ObosSZr/9pmozLHAl2M=;
 b=D0phiJyXGrFDPYnln/djOY++eFmXVRvzz9kOcSzTFMBkPyj/HUY2c5qP29YonL8KZDDXj0Uk5ZXV2ixWdWgtWRbIZjxKyZ18k6tLu4KUU09SO/BWxx5R7G+e9ds1KRZE6v7rYWiNuRRZ1dMe3RWcuyfHTUC69Hbo06HtImp8RiOfNW2JHFIpwsqxTi19ZTXYl4CnFyL+6nKkoJSTh130OZcUOwjO1cT4Yw3LUem8/u/q8/cVFDOhiyHFr7cUHbDUJAbWMHzMAwB24y5mmqqMSxr9IR2vanlUpWucy4kpJv2sNC8QrRG410QeIMrWr+rmwQVaxOLPYr1CJujhm0hd8Q==
Received: from BLAPR05CA0012.namprd05.prod.outlook.com (2603:10b6:208:36e::21)
 by BN9PR12MB5227.namprd12.prod.outlook.com (2603:10b6:408:100::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Sat, 25 Mar
 2023 18:34:48 +0000
Received: from BL02EPF0000EE3D.namprd05.prod.outlook.com
 (2603:10b6:208:36e:cafe::70) by BLAPR05CA0012.outlook.office365.com
 (2603:10b6:208:36e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.12 via Frontend
 Transport; Sat, 25 Mar 2023 18:34:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0000EE3D.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Sat, 25 Mar 2023 18:34:48 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sat, 25 Mar 2023
 11:34:47 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sat, 25 Mar
 2023 11:34:46 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Sat, 25 Mar 2023 11:34:42 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <robh+dt@kernel.org>, <broonie@kernel.org>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <jarkko@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [Patch V9 2/3] tpm_tis-spi: Add hardware wait polling
Date:   Sun, 26 Mar 2023 00:04:08 +0530
Message-ID: <20230325183409.7695-3-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230325183409.7695-1-kyarlagadda@nvidia.com>
References: <20230325183409.7695-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3D:EE_|BN9PR12MB5227:EE_
X-MS-Office365-Filtering-Correlation-Id: b93fb4a4-3572-47b1-a5ff-08db2d5f9d21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vi/cCviphvIiam4n8QLapOff3cwnoaV3R4NyVCA6Ch8k0ZawqeA9M4tuxCfzrEKax3S7McLJCRSS6yllSMm0CtopmuLv44JhB7mMQNYobg7QQzBTvoGpCTxAj7YHSK22AgkYxd7KWdxomIZep+4ibeQw8cmJCGfLczlW95wtmCRPseHLAYg9fmokuvdYWW4dkdYhsc/Pa7I21YnUV+7RDdn9iRQeji5odQfpzvUGjupFp8jvpJf05v2HiG/fx0W0EPRMNbsXpMtdzr0IEMeOOrBnB5HbvxBEbXnjvuk2dSTkeYzc8tDZJh8/mr/nFSUimH+jf6HMtJDx9SN9qIi9VpqDnj2QJnTWxrBOiARdJJIpFx2WBc55efwRb7GKtzDwVsAce/1Z4RydliL/ZR1X6kNitKUxd1JC+m83clBuT2ec3e9eYJoNt1NwifU45v3v42F97ocVyLI0m6/lUeIv7T4O0eedSk7VM3QIcqcslztaTL8/RdXORTrZrHgGYT0fn7Kb0GbPxzzIbcEl3DCpLhg2Qdar5T+3ZPIey2tHHwWOMAQS0Kf6mJkJtzrkKP3W3QZD1EDNyq6Z3+sK1coB28S94K0Fa6HHyQ/nxpCxnvqascwmfNfWtAMoMemVedKV1UjlC2Kc9Rg0i4jre8HvMTXFG459LxJTiJbXk5dopiQeTR87tfWPBgb1UztOMc47nidPV8qLkg7CGkIlnDie+yR7vm1S4T8yng+xZpmyo6vR1BMhqhO5XFT8RHFd/T2JZ23MWMDnDB5/a88mMK9Eo8TjDgMofoqtfMyd58bCMpLRJzO3xllNHI7L6bHJrYEg
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199021)(46966006)(40470700004)(36840700001)(36756003)(40480700001)(82310400005)(86362001)(921005)(356005)(40460700003)(2906002)(107886003)(6666004)(186003)(2616005)(1076003)(478600001)(41300700001)(316002)(8676002)(4326008)(54906003)(70586007)(70206006)(110136005)(5660300002)(7416002)(8936002)(7696005)(7636003)(26005)(82740400003)(83380400001)(336012)(426003)(47076005)(36860700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2023 18:34:48.2552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b93fb4a4-3572-47b1-a5ff-08db2d5f9d21
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5227
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

TPM devices may insert wait state on last clock cycle of ADDR phase.
For SPI controllers that support full-duplex transfers, this can be
detected using software by reading the MISO line. For SPI controllers
that only support half-duplex transfers, such as the Tegra QSPI, it is
not possible to detect the wait signal from software. The QSPI
controller in Tegra234 and Tegra241 implement hardware detection of the
wait signal which can be enabled in the controller for TPM devices.

The current TPM TIS driver only supports software detection of the wait
signal. To support SPI controllers that use hardware to detect the wait
signal, add the function tpm_tis_spi_hw_flow_transfer() and move the
existing code for software based detection into a function called
tpm_tis_spi_sw_flow_transfer(). SPI controllers that only support
half-duplex transfers will always call tpm_tis_spi_hw_flow_transfer()
because they cannot support software based detection. The bit
SPI_TPM_HW_FLOW is set to indicate to the SPI controller that hardware
detection is required and it is the responsibility of the SPI controller
driver to determine if this is supported or not.

For hardware flow control, CMD-ADDR-DATA messages are combined into a
single message where as for software flow control exiting method of
CMD-ADDR in a message and DATA in another is followed.

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/char/tpm/tpm_tis_spi_main.c | 91 ++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
index a0963a3e92bd..db9afd0b83da 100644
--- a/drivers/char/tpm/tpm_tis_spi_main.c
+++ b/drivers/char/tpm/tpm_tis_spi_main.c
@@ -71,8 +71,74 @@ static int tpm_tis_spi_flow_control(struct tpm_tis_spi_phy *phy,
 	return 0;
 }
 
-int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
-			 u8 *in, const u8 *out)
+/*
+ * Half duplex controller with support for TPM wait state detection like
+ * Tegra QSPI need CMD, ADDR & DATA sent in single message to manage HW flow
+ * control. Each phase sent in different transfer for controller to idenity
+ * phase.
+ */
+static int tpm_tis_spi_transfer_half(struct tpm_tis_data *data,	u32 addr,
+				     u16 len, u8 *in, const u8 *out)
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
+static int tpm_tis_spi_transfer_full(struct tpm_tis_data *data, u32 addr,
+				     u16 len, u8 *in, const u8 *out)
 {
 	struct tpm_tis_spi_phy *phy = to_tpm_tis_spi_phy(data);
 	int ret = 0;
@@ -140,6 +206,24 @@ int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
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
+	if (ctlr->flags & SPI_CONTROLLER_HALF_DUPLEX)
+		return tpm_tis_spi_transfer_half(data, addr, len, in, out);
+	else
+		return tpm_tis_spi_transfer_full(data, addr, len, in, out);
+}
+
 static int tpm_tis_spi_read_bytes(struct tpm_tis_data *data, u32 addr,
 				  u16 len, u8 *result, enum tpm_tis_io_mode io_mode)
 {
@@ -181,6 +265,9 @@ static int tpm_tis_spi_probe(struct spi_device *dev)
 
 	phy->flow_control = tpm_tis_spi_flow_control;
 
+	if (dev->controller->flags & SPI_CONTROLLER_HALF_DUPLEX)
+		dev->mode |= SPI_TPM_HW_FLOW;
+
 	/* If the SPI device has an IRQ then use that */
 	if (dev->irq > 0)
 		irq = dev->irq;
-- 
2.17.1

