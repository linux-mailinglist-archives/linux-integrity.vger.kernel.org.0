Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F556A7A6D
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Mar 2023 05:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjCBETW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Mar 2023 23:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjCBESd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Mar 2023 23:18:33 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04hn20328.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8d::328])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA5E311DF;
        Wed,  1 Mar 2023 20:18:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VAQs38G+3zm6v0ffhoQsRSvHjvre46Kq5FebxQz05xDfNmnUjpAegaZdH45aZdOJw3C7L+12y11/gM4GoYOu3UIgGLaKG+m1GuYkXQ9YFjMxiesNBVA11AlvOesWiL3OjKDipw3roD1DGp3MFOUqEeIpdCR71SIyZOXhicKsRCOvyLrBpeqEh6EWer5HyrQXxg0sW0SnYgUgIjYlRA+quh7y89YOsA0+TZqi0z1vpEDb5cu31/C/u7ioLFMHxpASzRE2dokxIoIW2yfS3Q0SKLnvLAqIMpZ2Op6FCSf8OwXnNTPUfKFI9Vyh/jXLFJ/v1OsZj6Lb69ZCJ0YCqORdFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzncxuURJjV4GP959QHXdVb3ilQTKDNs1iK0EzLlCuQ=;
 b=S1sk2onZqgH/0mfsqlGMw0GnDd7Zr/Ek6Fg+Woj6oIL0xarx7MkHopk7ZCvRDDs9RdiLy7dINnCEPruWiCC8Gdd9/7cr1IFrXT9h0HsvwzWbbtjyWiaL+J+wtPtAtr5jALg45ZJwE1TxAKKXsKHokLn67jGrPs++2RO+WVmmAGVUz3WMyunDrRfYRE/IMDrMeP5qwRAlprSHZIIX3EjZL66emq6HNYHw72ZCveERAeuFcttgItBsFf2B91VCe+rb3JC05dgSME2ctONq2vvoOh53eidqzbQeBH1t/VmrDWsoujFHxSo3JrtovAf3YOlmzRy3SsdHEi5RYC4+lhuoLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzncxuURJjV4GP959QHXdVb3ilQTKDNs1iK0EzLlCuQ=;
 b=SZ7Y/Wws1vBcnAdfJMxPkoH8NH+tFPmC/0IZ0MqZiUU4jWpgf13/g5oQEgXgsm/TpTYJxUVXuas//5TtqDyDA1fYMr72iVK07taOm6MgytC8PjXm/FeFyFuuzpVPpbqb9AxzYvEmTv7y2WNzBFNKQk5inWLeYSxVxJ18eT+KMcDsGett43y0atDYNIgJgPdhAWQDBIL/5+Q6DU4sqj8dqLhrWF0QJTTwPaH1M8ygpaCUAEQxWmFbTSlJAC9DaFnxvDrXEVXCOq3pak7s7+/Qnp5VOD/s1VoXJ98u9ALBV6kCIElXDHNukcjyri9mDAQ8axELOEjKukbd/6VMaSxORg==
Received: from DS7PR03CA0182.namprd03.prod.outlook.com (2603:10b6:5:3b6::7) by
 IA1PR12MB6625.namprd12.prod.outlook.com (2603:10b6:208:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.26; Thu, 2 Mar
 2023 04:18:26 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::41) by DS7PR03CA0182.outlook.office365.com
 (2603:10b6:5:3b6::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18 via Frontend
 Transport; Thu, 2 Mar 2023 04:18:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.18 via Frontend Transport; Thu, 2 Mar 2023 04:18:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 1 Mar 2023
 20:18:23 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 1 Mar 2023
 20:18:22 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Wed, 1 Mar 2023 20:18:18 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <robh+dt@kernel.org>, <broonie@kernel.org>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <jarkko@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [Patch V8 2/3] tpm_tis-spi: Add hardware wait polling
Date:   Thu, 2 Mar 2023 09:48:03 +0530
Message-ID: <20230302041804.24718-3-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230302041804.24718-1-kyarlagadda@nvidia.com>
References: <20230302041804.24718-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT022:EE_|IA1PR12MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: 97f5ca47-a31f-44d9-3253-08db1ad52b69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 71epHBS0m4aafXUCMQ/oNwFmxvGxCkO41i/rdxArclahMVDOWlkBo/r9kISfHswERKlOtmM7uvI4vz5o36yjTvcJMrTXDpuL6+Qh8T40Mevx87/9zYK05kXdXob+nkOCpcYAa37Bx0ufl+k+Ewg+Jvdd6+QC8GOqOMos3vziuca4/CAAF7gc+fcdAs2oxUwWijRpKyrIeA6KdEvHBSIkqeGqDwqwSMQmm7gF19ptm96PsAKFTtxgxZr51A5MI5Rbg6Fnz20jfvlZTrAmkGhsEP2ik/fz4csDDGkDzJnheJ1+OrUQ1D7RNvWJ2EVbguA8lUO4c5qD+KEc6DW4oGp0GBkSVo0W8Ss0ortdxmeWm+Mu5wODvKR9QKFDYaMkeul0G8WomUJDocApR4QKaZFCD3l00lCeCxnBqIimSRgTrPDl3sMSWJUZCPmsa8Gf/5v9CWCQMaf+9A9j8uKK3D2VH5khwHI7YFiMITGE8C2WWOIyoha5DwWoyzYJFy8hMxS9EdM/wFFxudizwHB/vP5jNFxFvL70CKMeOqGls/lrkblMK5b/zxKYNMPISIk7jXi1MO4NeuGwuWb5dUpb/W+deSRk9bOxHWirI+5q7ZrnoJIvzHXZNhsT7B/1wJi3r6kC8yZPk/NgrwZG8ZpdsuYSv9Dczqep0g5d6GWL08c4Ktv/dDeEh+/koH+kDJZwWk3vUukBcf5yR8oSt8y/W/pkW6KIXqe1+k212Lbj2YV3saROZLGY/9y/rscn3UiFLZ4PY0OYwperK5BzoCgshO+ZgCMtoGXm9M5I0YqCNLjjI0zfrv1gZTHctmzhGjtSaZzn63Q4hPzJrLtksmIyXesfyw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(136003)(396003)(346002)(5400799012)(451199018)(40470700004)(36840700001)(46966006)(478600001)(70586007)(70206006)(7696005)(110136005)(4326008)(82310400005)(41300700001)(8936002)(8676002)(356005)(36756003)(107886003)(40480700001)(86362001)(40460700003)(6666004)(26005)(2616005)(47076005)(7636003)(82740400003)(426003)(186003)(336012)(1076003)(5660300002)(83380400001)(54906003)(316002)(2906002)(7416002)(36860700001)(921005)(34020700004)(2101003)(83996005)(12100799018);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 04:18:26.0009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f5ca47-a31f-44d9-3253-08db1ad52b69
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6625
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
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
 drivers/char/tpm/tpm_tis_spi_main.c | 95 ++++++++++++++++++++++++++++-
 1 file changed, 93 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
index a0963a3e92bd..d0c1073bfa06 100644
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
@@ -181,6 +269,9 @@ static int tpm_tis_spi_probe(struct spi_device *dev)
 
 	phy->flow_control = tpm_tis_spi_flow_control;
 
+	if (dev->controller->flags & SPI_CONTROLLER_HALF_DUPLEX)
+		dev->mode |= SPI_TPM_HW_FLOW;
+
 	/* If the SPI device has an IRQ then use that */
 	if (dev->irq > 0)
 		irq = dev->irq;
-- 
2.17.1

