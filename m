Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7546883FA
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Feb 2023 17:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbjBBQSc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Feb 2023 11:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjBBQSX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Feb 2023 11:18:23 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E91212B4;
        Thu,  2 Feb 2023 08:18:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/YrryNIa8vgUd1ww2XpmYvmkdxwP8loA6NghAYFwLd3kzqo/CsUnh04tVDJUPCkxF18x+cKTJcK3oH9mSUkEYXNyqRyk0XIOJA6DU4t3Vu3LaWatOCIm75GsRdQqlKUDtnfq8vHSaZxHzkWsfmCcrBpSDzL3IWMI5J5MS2FtLigzVpqypql1068z4GPMF48W3M9YuUmInCrMaVst8jTAlaheebHvJznOrC+GTG6bkgzood3pvEAX94BK6WY5uPiucmmtZ7XxXFVDTsq1X3rAmnTblBWHrbJwO0BmTyKbhM0bhvKHG3rhyeUbjuA+AmTxaqP8jQ8CujZUyO5ibDUYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HCwdw+VY8n1JR+QE1oTKBbBxFSCXXoMSgE1nTrnikc=;
 b=PAHvA7TgsjNEG+pz7OWzODEt+QamLp5U4ERwYiiIZ+pRW/LnqjkzPEIuo4F6aaAeHfsaZdddmjI8+H7VaK6NzaCZCxQ7+JhmIZimZe8OBKfbr1yt86QuwRoGXvbI2wVkcOXIW4rYEO+Or20ecSK+f3ev9+9P9snJsKnLQZzb1UAPAmx9R63kJLq9DYp/pTMD+QkaPow3wOsuNcfhlDxZiVpj9R4Y5OhLMcqphxLKC0IBU7JskEyRueX5279le23xG0ITQ74CFXWi7kuBw/ENV+c1Pgqk3GmY9f6gL0xl8y+6uz0HMs2fgAcrjcgsucweN/fkZ4HjmrjVnu/Gh1v+Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HCwdw+VY8n1JR+QE1oTKBbBxFSCXXoMSgE1nTrnikc=;
 b=pEnsA57ocgotKcAbxtBQh/aFVLkzyNakpWdABj1dyDRp4m3jb+a7UuQQnKDz4TxfCgNyXJ0sSlAIQA4k3jaLUPLDZGPKoP5msETjhoby/ZZ3UV4Uu0gDVP3ByA4EIuKV4QgUOGQkz7gA05TTZUm+npG8V0WRAptyjk0b6VGkee0bC3eoqGPCNz1x/Th9MKK2JhQ/MYazKuCIuytJ9iobWhY8dlOkOJXbZgBxJuZO114qretOyi00JxZmnDgfl9nKlruDgl9lt3kGIJsJljPPretmpgoavyzC/ay1mSWhkmr+dHgAXbn7EG424w4ErBnG1YYDuy7XyXOVTYKAg+9Fiw==
Received: from MW4PR03CA0057.namprd03.prod.outlook.com (2603:10b6:303:8e::32)
 by DM4PR12MB5865.namprd12.prod.outlook.com (2603:10b6:8:64::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 16:18:18 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::9d) by MW4PR03CA0057.outlook.office365.com
 (2603:10b6:303:8e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27 via Frontend
 Transport; Thu, 2 Feb 2023 16:18:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.28 via Frontend Transport; Thu, 2 Feb 2023 16:18:17 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 2 Feb 2023
 08:18:09 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 2 Feb 2023 08:18:09 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Thu, 2 Feb 2023 08:18:05 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <robh+dt@kernel.org>, <broonie@kernel.org>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <jarkko@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH 2/4] tpm: tegra: Support SPI tpm wait state detect
Date:   Thu, 2 Feb 2023 21:47:48 +0530
Message-ID: <20230202161750.21210-3-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230202161750.21210-1-kyarlagadda@nvidia.com>
References: <20230202161750.21210-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT020:EE_|DM4PR12MB5865:EE_
X-MS-Office365-Filtering-Correlation-Id: 16d2ee37-8395-4264-3f72-08db0539181a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iyoCI04w4lwaK8Gltb2Ca/d9fvnQaOMXPQNxGETG0CR4owcKXdDqomFai5Z5pDAYUoirsDQi8B9UZRdq+f8MfdoFm998sNK3qVwPmSEVGOLSZlIoVo9FvpP6at5PDvR759XdAeEPKOUnKKvxlx+7MXa5V0mXJonHIjDVFaKHNKakWCB5ZXz5G1G9nUASJMamDns1yHpXh1YY4CNRT8zB4VEWPlstX6aJNOAhnFtFmTL5F7V5t+nex8vbZ1A9f7HYXGwSQSLFr9XccZ2hVoM7Wqmbt62qYsO7H/kfvWm4peik0GxOuDhiaeezDobwm5D9dxdKRKFMsKqKB9Xw96/UCLdMWXzEYx9H5lMzdRghRWXwI1r+eWHD33wvrfH79lq7Bp8g2b/Zv7nHj5JFRdxlKMdI5rKjV2CsSFbowtHed8NlmDZGkV5VBDmDdLHttJf6KDXM2ZGF3Bkl17lu/aiAQ6tsOrJbi/BtpQmy7HGgSR120Be4kNHortPMLiNjXHy4wPw88Iu2AvW1SqKpEl2YylUh6POm9HatRapNVka3IROiM8/fZ7HKN+WDfJLOcYaJ1uKi4StRhTRbnSVfavnO3tLvMQi9JWKHKB7Bsmm8Xk/+2to2Owv9Zi0Pl5zFIjoyrxkg898GIottXsPjfUnuBBhfEY430hxmN8+fHNhNWuycjubmvwJJ5F7ipYurPYQrXGnZFwOXn6Wo7SZ50QcFpwIHhsSxINWoxhD1r4o9XL2DF0pfAop5sW1WIyptDg6QXtZGUSkC78vProVubA0IAQ==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(186003)(26005)(1076003)(83380400001)(70206006)(70586007)(426003)(336012)(921005)(356005)(82310400005)(36756003)(86362001)(40460700003)(47076005)(36860700001)(40480700001)(5660300002)(8936002)(41300700001)(54906003)(110136005)(4326008)(316002)(2616005)(8676002)(107886003)(6666004)(82740400003)(7416002)(7636003)(7696005)(478600001)(2906002)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 16:18:17.7767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d2ee37-8395-4264-3f72-08db0539181a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5865
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Tegra234 and Tegra241 chips have QSPI controller that supports TCG
TIS hardware flow control. Since the controller only supports half
duplex, sw wait polling method implemented in tpm_tis_spi does not
suffice. Added extending driver to disable sw flow control and send
all transfers in single message.

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/char/tpm/Makefile            |   1 +
 drivers/char/tpm/tpm_tis_spi.h       |   1 +
 drivers/char/tpm/tpm_tis_spi_main.c  |   4 +-
 drivers/char/tpm/tpm_tis_spi_tegra.c | 123 +++++++++++++++++++++++++++
 4 files changed, 128 insertions(+), 1 deletion(-)
 create mode 100644 drivers/char/tpm/tpm_tis_spi_tegra.c

diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
index 0222b1ddb310..445b15493cb3 100644
--- a/drivers/char/tpm/Makefile
+++ b/drivers/char/tpm/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_TCG_TIS_SYNQUACER) += tpm_tis_synquacer.o
 
 obj-$(CONFIG_TCG_TIS_SPI) += tpm_tis_spi.o
 tpm_tis_spi-y := tpm_tis_spi_main.o
+tpm_tis_spi-y += tpm_tis_spi_tegra.o
 tpm_tis_spi-$(CONFIG_TCG_TIS_SPI_CR50) += tpm_tis_spi_cr50.o
 
 obj-$(CONFIG_TCG_TIS_I2C_CR50) += tpm_tis_i2c_cr50.o
diff --git a/drivers/char/tpm/tpm_tis_spi.h b/drivers/char/tpm/tpm_tis_spi.h
index d0f66f6f1931..feaea14b428b 100644
--- a/drivers/char/tpm/tpm_tis_spi.h
+++ b/drivers/char/tpm/tpm_tis_spi.h
@@ -31,6 +31,7 @@ extern int tpm_tis_spi_init(struct spi_device *spi, struct tpm_tis_spi_phy *phy,
 extern int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
 				u8 *in, const u8 *out);
 
+extern int tegra_tpm_spi_probe(struct spi_device *spi);
 #ifdef CONFIG_TCG_TIS_SPI_CR50
 extern int cr50_spi_probe(struct spi_device *spi);
 #else
diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
index a0963a3e92bd..5d4502a4461a 100644
--- a/drivers/char/tpm/tpm_tis_spi_main.c
+++ b/drivers/char/tpm/tpm_tis_spi_main.c
@@ -198,7 +198,7 @@ static int tpm_tis_spi_driver_probe(struct spi_device *spi)
 	const struct spi_device_id *spi_dev_id = spi_get_device_id(spi);
 	tpm_tis_spi_probe_func probe_func;
 
-	probe_func = of_device_get_match_data(&spi->dev);
+	probe_func = device_get_match_data(&spi->dev);
 	if (!probe_func) {
 		if (spi_dev_id) {
 			probe_func = (tpm_tis_spi_probe_func)spi_dev_id->driver_data;
@@ -227,6 +227,7 @@ static const struct spi_device_id tpm_tis_spi_id[] = {
 	{ "tpm_tis_spi", (unsigned long)tpm_tis_spi_probe },
 	{ "tpm_tis-spi", (unsigned long)tpm_tis_spi_probe },
 	{ "cr50", (unsigned long)cr50_spi_probe },
+	{ "tegra-tpm-spi", (unsigned long)tegra_tpm_spi_probe },
 	{}
 };
 MODULE_DEVICE_TABLE(spi, tpm_tis_spi_id);
@@ -236,6 +237,7 @@ static const struct of_device_id of_tis_spi_match[] = {
 	{ .compatible = "infineon,slb9670", .data = tpm_tis_spi_probe },
 	{ .compatible = "tcg,tpm_tis-spi", .data = tpm_tis_spi_probe },
 	{ .compatible = "google,cr50", .data = cr50_spi_probe },
+	{ .compatible = "nvidia,tegra-tpm-spi", .data = tegra_tpm_spi_probe },
 	{}
 };
 MODULE_DEVICE_TABLE(of, of_tis_spi_match);
diff --git a/drivers/char/tpm/tpm_tis_spi_tegra.c b/drivers/char/tpm/tpm_tis_spi_tegra.c
new file mode 100644
index 000000000000..23f20684513d
--- /dev/null
+++ b/drivers/char/tpm/tpm_tis_spi_tegra.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 NVIDIA CORPORATION.
+ *
+ * This device driver implements TEGRA QSPI hw wait detection for chips
+ *
+ * It is based on tpm_tis_spi driver by Peter Huewe and Christophe Ricard.
+ */
+
+#include <linux/completion.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pm.h>
+#include <linux/spi/spi.h>
+#include <linux/wait.h>
+
+#include "tpm_tis_core.h"
+#include "tpm_tis_spi.h"
+
+#define MAX_SPI_FRAMESIZE 64
+
+int tpm_tis_spi_tegra_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
+			       u8 *in, const u8 *out)
+{
+	struct tpm_tis_spi_phy *phy = to_tpm_tis_spi_phy(data);
+	int ret = 0;
+	struct spi_message m;
+	struct spi_transfer spi_xfer[3];
+	u8 transfer_len;
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
+		if (in) {
+			spi_xfer[2].tx_buf = NULL;
+			spi_xfer[2].rx_buf = &phy->iobuf[4];
+		}
+		spi_xfer[2].len = transfer_len;
+		spi_message_add_tail(&spi_xfer[2], &m);
+
+		reinit_completion(&phy->ready);
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
+static int tpm_tis_spi_tegra_read_bytes(struct tpm_tis_data *data, u32 addr,
+					u16 len, u8 *result,
+					enum tpm_tis_io_mode io_mode)
+{
+	return tpm_tis_spi_tegra_transfer(data, addr, len, result, NULL);
+}
+
+static int tpm_tis_spi_tegra_write_bytes(struct tpm_tis_data *data, u32 addr,
+					 u16 len, const u8 *value,
+					 enum tpm_tis_io_mode io_mode)
+{
+	return tpm_tis_spi_tegra_transfer(data, addr, len, NULL, value);
+}
+
+static const struct tpm_tis_phy_ops tegra_tpm_spi_phy_ops = {
+	.read_bytes = tpm_tis_spi_tegra_read_bytes,
+	.write_bytes = tpm_tis_spi_tegra_write_bytes,
+};
+
+int tegra_tpm_spi_probe(struct spi_device *dev)
+{
+	struct tpm_tis_spi_phy *phy;
+	int irq;
+
+	phy = devm_kzalloc(&dev->dev, sizeof(struct tpm_tis_spi_phy),
+			   GFP_KERNEL);
+	if (!phy)
+		return -ENOMEM;
+
+	phy->flow_control = NULL;
+
+	/* If the SPI device has an IRQ then use that */
+	if (dev->irq > 0)
+		irq = dev->irq;
+	else
+		irq = -1;
+
+	init_completion(&phy->ready);
+	return tpm_tis_spi_init(dev, phy, irq, &tegra_tpm_spi_phy_ops);
+}
-- 
2.17.1

