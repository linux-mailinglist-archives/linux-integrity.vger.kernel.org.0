Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77430689966
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Feb 2023 14:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjBCNCS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Feb 2023 08:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbjBCNCQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Feb 2023 08:02:16 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF039D595;
        Fri,  3 Feb 2023 05:02:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCq1yVB5O8MQYLvmpVsf4okocyDw/sjsXZd3+33hRA17mCGmX7xg5iZags7I3oRsaJ9ZSi39+M9TH414prepKIlaYJx86ncOvL4ykO82DCZFmcssgPNw++aF9huW32c2QFgzWJw3iTWlZBNVWJ33SQDO8cqIHCWZG7DflAnX3Pwu5cofuwEKPZgw0huC1Lpt0yjLoXJ7okKbX8dX1RrcNJ1J7TKTcNmctO+XTknZtd4VsXr1SYHal+oFCTVSXbSFG7KlajXhgoxD/J0STnE1N4ExGJynwcVYGbX8h09825Vnmq0tvnm1KvcX5dtzpYc1V3JsDu1jelgSJvQpiYClgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HCwdw+VY8n1JR+QE1oTKBbBxFSCXXoMSgE1nTrnikc=;
 b=mOeJpnj7eY98SjKDEy6eEkNM6FOzahqqu4hfq5C4CmfGzBJk6uRFja0msGmLNzYZnEO5JS/1eqD0Nx6aZdvgsADgzJKJe8cn5eo0sMTcW0lr8ZbSe3xdMXDD0Uz4jBUqd4990pX8uqttxrM/ri7fxd2JCEkIvtr2LaahmLdSRvSDffryDLU23iTAIzeOUNb2CkEIFo/EQ25/GchsSGwsIvf5C4DcF9PxXKZqJDuhVR43YSG0kl0zZkdxcAp67W5ilivwnJDa38faBvVd0RG2ZEWFq62dAjPxhMRcdakxe28WG/J/WT8g6u/HbIWilBZCJPvfQeLfxOyRV/Mdl65klw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HCwdw+VY8n1JR+QE1oTKBbBxFSCXXoMSgE1nTrnikc=;
 b=KrrSsfzPgK2Y46eXxREDER+pEbUyjGj4sKVRM18zrRBAK0y6aAXsZbgcoLVbgJNkSGiyERwlsJ+RiY3Oj3/rVqxecpNk1U8c2fYlCKP3GAyIBR6QRwq7QhZSLpDjzSx1MS0CyBAyJmQhepAyPdYNQZAnvEjuirUV2IGWilEqr6rvKS2MwCB/oxtlzLLN509mFeUyyPu6Bx7VaJEDiVxSJQH1zcmwzK0rSft8uM18mMI7byuh2FNIu5+ut6jhT19gUW+iMweiTdEvE/iJzFUl8ChKg18S00Fx7xOrwxMZo1YWykbsZb09QM2fr49ykvHy8dq7b+OdEpU0SW4bJMuOkQ==
Received: from MW4PR04CA0199.namprd04.prod.outlook.com (2603:10b6:303:86::24)
 by CH2PR12MB4874.namprd12.prod.outlook.com (2603:10b6:610:64::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Fri, 3 Feb
 2023 13:02:12 +0000
Received: from CO1NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::7c) by MW4PR04CA0199.outlook.office365.com
 (2603:10b6:303:86::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.29 via Frontend
 Transport; Fri, 3 Feb 2023 13:02:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT097.mail.protection.outlook.com (10.13.175.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.31 via Frontend Transport; Fri, 3 Feb 2023 13:02:11 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 3 Feb 2023
 05:01:56 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 3 Feb 2023
 05:01:56 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Fri, 3 Feb 2023 05:01:51 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <robh+dt@kernel.org>, <broonie@kernel.org>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <jarkko@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [Patch V2 2/4] tpm: tegra: Support SPI tpm wait state detect
Date:   Fri, 3 Feb 2023 18:31:31 +0530
Message-ID: <20230203130133.32901-3-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230203130133.32901-1-kyarlagadda@nvidia.com>
References: <20230203130133.32901-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT097:EE_|CH2PR12MB4874:EE_
X-MS-Office365-Filtering-Correlation-Id: 32c57e6e-8e33-47aa-edf6-08db05e6dd7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ywU40jzMwri6G8rZYNvqGFNe6wjNYdLKlRz57y+nfoVieUiEO5AV2DVDzOE/s3cj3NRfzSyXjDsYbufvr9yd7KHX/oq88U63N8rSa91IcRgabQdfugD+B71i0qaq630Vp5WO9FTltdF8ZrgEBRXJdluSkULZ7me5EEvIYGEU9Ch5iQtt5eG+fH+2Fu+HxJFgHVtMTPQcdyajJnbMAVyWmWYlf6c/B3eP3Kzzoa0hXNQC1Pf4skyvMrLhtdWMC34L5hMLspCxrct6qYR+RWD+kXuA9NbJmE5Iyu1gxeMIGB64JDdHpbRYX5xrpmjVjNE/lVA4Cuq077DGGZ9CpYSfJUuL/NpBnHiVOyVc7rpASZ7qef0f3IFeosZq5xxFwhQ0VdlfmjS2BfsXR24UVhj9Xw7YWu0SO7jSilRlCkOD9X5ufEB3L9AZnjypoHpwkjM095PhWpY1ehffNHhxzLLIrlhXOJH3BmbgtK1fL2x5QVQJFJoi5Hm5SvNWlv35NvUmaZLXghp2Zc2smSX8qbAxa5Gsjr/rTWvTHg8VfN1vogLRperk3emQC1fLUhhRuXqv9IjOGy6i8ru5/T2vB9EPUt0I1wIUVxU1Xxa3tY+7KatLdikfYzrHNVq9/1RjrjCGCYDvH0YvivHxE1GSQ6wcUVVtddPAJAOW44po9I6sQKsYoIM4pnE+QfvQ1kGdaiIwljCrV/MSV/mhghQxXy+xeFNedJhdC0WlDWzAG2kcM7fCRRJ1qD23rqr5epNu4ArMX2JnQNZpzGYv2qmOhavvwg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199018)(36840700001)(40470700004)(46966006)(36756003)(47076005)(70586007)(70206006)(316002)(82310400005)(36860700001)(8676002)(4326008)(83380400001)(54906003)(7636003)(110136005)(82740400003)(1076003)(5660300002)(186003)(107886003)(478600001)(26005)(336012)(40460700003)(6666004)(7416002)(921005)(86362001)(41300700001)(426003)(356005)(40480700001)(2616005)(7696005)(8936002)(2906002)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 13:02:11.8129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c57e6e-8e33-47aa-edf6-08db05e6dd7d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4874
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

