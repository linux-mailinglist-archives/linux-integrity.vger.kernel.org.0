Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0009A6A722C
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Mar 2023 18:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjCARee (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Mar 2023 12:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjCAReb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Mar 2023 12:34:31 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11hn2241.outbound.protection.outlook.com [52.100.173.241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AE248E1B;
        Wed,  1 Mar 2023 09:34:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCwH+oiS7y3EPV5XjIPT85XLyoCrdqSeACaOX26NO2ojk5ILPOOsRmv6guZJwobgGiJ2APsaRjPDgWQr5z7Quo8UyFv2sVBRYnlHD1DXoeaKS/gOyTldlEflGEC5QYl5yJwMHOjJ/bfpjpcDV2WMpm4zeho/QQeNHkL5vurdsqCH/MHfQtNvosuw/jh37Mp4vIidS5Vf3iHUVOL418a9bA+H8Gsd5uXtlf3SZ5+zpj7kjTXuIGe/fecajNI/GoKP4xApS2AIFGoDi9jVegXDSjkmDmCZrZpIGk4oBypB9OZvBP4JzXTM1i5cSzZIX/eNTn15l7jcXPKKrixrQ/1MvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6nzbWPnxBfKpo/CzW043bxzHouFCEodDPJmySf5H+U=;
 b=na/cp2pU7hCwkxj9jMSShey0+mAlj82BUYuUq8YSoQ/wGnv2PscLaBJFRg7g/agK5QW5klPeoaWhnnWBnmZQK+kM8dz64aHNu3vgpDNepAQAKpJ2h7XO8uS8HqEaQ50eRqRqAYFRe1g971X8CCk6LMdjPKBelA0FBc1aOfu4dCA9iY6CTazSiR7g8WdtOuSN9V6b9Y/3Sred0zW5E8mFfd3oUIssUOhT4/hlhnZIVA7/79QJ4U0ioJD8TgOrN3vPBsPMyq6+BZbOUIoy38nagw5/xBQcxqXR1hnCZiS3hy2uccceXcXKnAxRgb4wrRyTorE/GqPzmdhNDB4WGiL40A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6nzbWPnxBfKpo/CzW043bxzHouFCEodDPJmySf5H+U=;
 b=VqSVy1ofc7TH/+tjTtjQYSbY2v4dTBV6yoOfM3VwpcpR+q7pw5Bt+PP+nB7Bm4w2W8abwTOJQ9ykYCgPQCNcCfOKRh1kWhEW9UYfMPHMikojqZ0v1BECB72m7jAE+1VU8ADiJqMAoOVThGBz+0iGW6lUdh25Nkl+ff434ki3le7n42VJ2itpRu8R0qYC4gcgLNj/F5pstoMJTnGHvblgic0GyZWLRHYtsNY/lXHRkGgVjrmzmhQZdkKQM/h2XTiafCLka5y0voHcPUJUvlZ/c3qDi1HuU8lPjad0ZL0GnKfysWNXe+3fFpFypZXUVMpnZfK0a0zmToP3XuTnIgRGIw==
Received: from BN1PR12CA0020.namprd12.prod.outlook.com (2603:10b6:408:e1::25)
 by CY8PR12MB7337.namprd12.prod.outlook.com (2603:10b6:930:53::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27; Wed, 1 Mar
 2023 17:34:23 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::a1) by BN1PR12CA0020.outlook.office365.com
 (2603:10b6:408:e1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30 via Frontend
 Transport; Wed, 1 Mar 2023 17:34:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.14 via Frontend Transport; Wed, 1 Mar 2023 17:34:23 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 1 Mar 2023
 09:34:10 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 1 Mar 2023 09:34:09 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Wed, 1 Mar 2023 09:34:05 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <robh+dt@kernel.org>, <broonie@kernel.org>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <jarkko@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [Patch V7 2/3] tpm_tis-spi: Add hardware wait polling
Date:   Wed, 1 Mar 2023 23:03:52 +0530
Message-ID: <20230301173353.28673-3-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230301173353.28673-1-kyarlagadda@nvidia.com>
References: <20230301173353.28673-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT048:EE_|CY8PR12MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: 5507e469-a5a8-4609-55f3-08db1a7b32bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NAXR9Pj1BQtNLFzhOPEk52RLEKAgnns3LOS7xLDvSnQN2pkj4MdxUJeVrGtIXhw23VPgWOFUzohA06WqPePE8yqsb7qy//hotbRSHep5uTM5j+TprbAv1FpEiJ4RAY6gAZY4XkZlq/MoOTrsUgw3K7CrXbxVFOz7bdb0lvVHCT5A+hmoqhRVH3gfF/4kmUCnwMQsdG9JbatfSlTsR3ARE10w1F5krCQyo6MlwoltGgh8MHwdxU3sj4egqrrXm3s0Vcz1HNRBM1CBSYX9nVCLYXmkPGbf0U8IPzalbAyQ+mcxBX/GMrxbTebcPylpGcnXPbF5SgBQ+2mccp24M/wVssCL05G6AFPh6aDCRcrMNS+c78xrhYZNg1gYoV7O0l06IdufcUH32gW4cELRv3pd1+Ve/l4VgGf5XY+xcjmRKXaALbr8dYSyJFbypPLfsf+SFt7KcWXnPLBzPyvKM9PX6p9jXpOtnaBWtlfqF2KF5Z4fkdXbmeYVWnPcfctMbh3pVx0qhoD9UJBzTu3NaGc45CbbtAE3V+W8LNjdpPKyJcP4toBVr0/sg2tc/qnNhIVvnYQaaTHTkE9g1Dxfk3Lbn9O9wgx0HUdr8BU/hvLBAWsy6Mh7jPXG9hO6Jyzw1UDv5UepuqrH4pF5/rrUDbe8o9uaj85+sLgJYbrm7JkLL+9OftaqbXe6dGp+e8qRlGo67/ddfXKd5C3GkjAtgQUjXKVwdDdbG0MfaUXMMzVFDKQpwxLhjdPsz/yUl/GhvF5gnQiwOuxMeQy/sBlC5SV8L6WFpZHJmrIyfrDgbhTJLMPqyRqpfxUNnRNhqffS0yArXjsdteon00usDEC2XdhMxA==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199018)(5400799012)(40470700004)(36840700001)(46966006)(7636003)(8676002)(110136005)(478600001)(8936002)(316002)(336012)(82740400003)(54906003)(7416002)(36756003)(26005)(186003)(7696005)(86362001)(2906002)(40460700003)(82310400005)(921005)(107886003)(40480700001)(356005)(1076003)(6666004)(2616005)(5660300002)(34020700004)(83380400001)(70206006)(4326008)(70586007)(36860700001)(47076005)(41300700001)(426003)(83996005)(2101003)(12100799018);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 17:34:23.5594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5507e469-a5a8-4609-55f3-08db1a7b32bd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7337
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
 drivers/char/tpm/tpm_tis_spi_main.c | 96 ++++++++++++++++++++++++++++-
 1 file changed, 94 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
index a0963a3e92bd..fc6ee784ff76 100644
--- a/drivers/char/tpm/tpm_tis_spi_main.c
+++ b/drivers/char/tpm/tpm_tis_spi_main.c
@@ -71,8 +71,76 @@ static int tpm_tis_spi_flow_control(struct tpm_tis_spi_phy *phy,
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
+static int tpm_tis_spi_hw_flow_transfer(struct tpm_tis_data *data,
+					u32 addr, u16 len, u8 *in,
+					const u8 *out)
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
+static int tpm_tis_spi_sw_flow_transfer(struct tpm_tis_data *data,
+					u32 addr, u16 len, u8 *in,
+					const u8 *out)
 {
 	struct tpm_tis_spi_phy *phy = to_tpm_tis_spi_phy(data);
 	int ret = 0;
@@ -140,6 +208,26 @@ int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
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
+		return tpm_tis_spi_hw_flow_transfer(data, addr, len, in,
+						    out);
+	else
+		return tpm_tis_spi_sw_flow_transfer(data, addr, len, in,
+						    out);
+}
+
 static int tpm_tis_spi_read_bytes(struct tpm_tis_data *data, u32 addr,
 				  u16 len, u8 *result, enum tpm_tis_io_mode io_mode)
 {
@@ -172,6 +260,7 @@ static const struct tpm_tis_phy_ops tpm_spi_phy_ops = {
 static int tpm_tis_spi_probe(struct spi_device *dev)
 {
 	struct tpm_tis_spi_phy *phy;
+	struct spi_controller *ctlr = phy->spi_device->controller;
 	int irq;
 
 	phy = devm_kzalloc(&dev->dev, sizeof(struct tpm_tis_spi_phy),
@@ -181,6 +270,9 @@ static int tpm_tis_spi_probe(struct spi_device *dev)
 
 	phy->flow_control = tpm_tis_spi_flow_control;
 
+	if (ctlr->flags & SPI_CONTROLLER_HALF_DUPLEX)
+		phy->spi_device->mode |= SPI_TPM_HW_FLOW;
+
 	/* If the SPI device has an IRQ then use that */
 	if (dev->irq > 0)
 		irq = dev->irq;
-- 
2.17.1

