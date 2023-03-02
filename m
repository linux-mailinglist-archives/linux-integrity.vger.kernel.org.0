Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3366A7A70
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Mar 2023 05:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjCBETX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Mar 2023 23:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjCBESd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Mar 2023 23:18:33 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12hn2213.outbound.protection.outlook.com [52.100.167.213])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A222305E5;
        Wed,  1 Mar 2023 20:18:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYSXb8/jJg9GS+G8Pe2HeJG0AH3P3HLjlK6iQKtFB++/2q2G+fN+cvlLRuYBWKafOt0xBGGkLbvt0XyOugk6sL/aM3LC0XKlcJEsmjDkpaf52YcPr7Sf4qcFs0q/xFaRLoRoCei47G/e1/421E5Tj70JHdBiJv9gRHcaEcWZieKNmI6xcTfbD4RR4yl1/OrvpfALszob/zSyUKq3Vco57gmAtUNyF691tr+4poUYJKABUtfxAE/ibdy1scfK9rNrYZ+/LMi/X+AfORvpRGAyUeo3nV54vw3iRUyfnrGaoFU+i0A80L7YemZ84uIbBCSgq0maIXxwqHRjHHOX7Btauw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6cfpwnnVrUbHlknS5XSwMZgssAwk958FxhAcSDRmG8=;
 b=m/YloCqmFeGPT2pnNeB/25qddEtuQsEEC4qb9Knond/DJKGSlwRxH+zYMxxgIUwcuizNukRWmw9ukZHarzpVXwbEtHgOqInYIhKStkfh74G+b+jz2hz+tqAVlzV0M0S8reCPTPV4ZaJDhiaa0q0Qk/GP4NBo1yayxQ93jujvUyCXGdWBdVJq82LcI7nngQL3CgcWj+Y+KBhuDuGLwRtc3GS1yGRf9AY88+2AIyb6X6F66CHeiKquNS2p67DUJBHG6gGQYQYZfe5EG+1hkLihbc5LRcsExhHBEqdeu3J5QbK90EfkpctxwhmgbE2TVd6npGYpLeeYLF/1CFIjYXcbPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6cfpwnnVrUbHlknS5XSwMZgssAwk958FxhAcSDRmG8=;
 b=ApID+C0tU3YeKgax7/oe9ObeCkjwYLl9VcnBwn6QqxKk7fUhzE3BTgRBxk7oZMdXpISm/8JLRtClyhd/f8uE+C85OtzZ5QZ2yvc+oZJPsrHIzmwnQpWQVnDWgXv2sQ+c8O4F3XuHcXsfovQKwZOtaB/tCyjMkFYooVypTdYjbhMC/mTfdS1waJIeQhyY2kpYmztemlO1yeNrjjwuEcaJhn8v3O9rWi6ugtU6KdBm+wMtqugEajDadbhM5z/NLO+kknq7PfxaGayz3ZAnSuB5FC48RNjURROWN2k/hmKGQirKmB1J++vkUYhzDKqYsN9wQx6cWUicultvEgqhMJy1gg==
Received: from DS7PR03CA0029.namprd03.prod.outlook.com (2603:10b6:5:3b8::34)
 by DS7PR12MB6238.namprd12.prod.outlook.com (2603:10b6:8:96::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Thu, 2 Mar
 2023 04:18:29 +0000
Received: from DM6NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::a7) by DS7PR03CA0029.outlook.office365.com
 (2603:10b6:5:3b8::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18 via Frontend
 Transport; Thu, 2 Mar 2023 04:18:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT114.mail.protection.outlook.com (10.13.172.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.12 via Frontend Transport; Thu, 2 Mar 2023 04:18:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 1 Mar 2023
 20:18:28 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 1 Mar 2023
 20:18:27 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Wed, 1 Mar 2023 20:18:23 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <robh+dt@kernel.org>, <broonie@kernel.org>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <jarkko@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [Patch V8 3/3] spi: tegra210-quad: Enable TPM wait polling
Date:   Thu, 2 Mar 2023 09:48:04 +0530
Message-ID: <20230302041804.24718-4-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230302041804.24718-1-kyarlagadda@nvidia.com>
References: <20230302041804.24718-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT114:EE_|DS7PR12MB6238:EE_
X-MS-Office365-Filtering-Correlation-Id: a81d767b-eea6-4059-44e8-08db1ad52d93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bym+l8Iz0mv1GqPrwH1cs2oLtYefLreGcb5oxl9U9TuommyORAu+Okz5rYMoRnXAXDxSKty0AK0IMsdXL53VO3oGK8XwOufOAN/A2I8rkBPtm667nOR8dTFs+Qs2f4Yp32gcsiFV1uGJM0g9RXMcZ0tUs9moDRxiHndSTKkze0XRroyN2M2VWo7CzSqaoWWE8+g8FjIQsRcJFtZCVun5vxLjVyHrmkOXxY92x1N23v+D9HP1wC+jRCuGV/ao17ycwUSr22hAzvUVdhiXqK4Ez1lsZCk+1aI1zOYc2QGRTcNvLAPUtR8Bnr0P033BRf6N1BV1/YqAwawBsTJ8gF/fBh6/zaIAgNm3B5HW72iNcb+TlT3SWEjI+p2zD4KA1HEf4pTOj2qySVI++RCqhwYiMW/9pWNN96lcKOVQGG20g1zX8n+TovkyJPx5W7rKDdjPAZQ9rpnUwzmG1PWXO86f5BjBpj7VyuueTL/x85jgPX2zkGuoSFyr4t5L+7vMeIp0pIb/JcTGB7TZRAGHb2cD9/X5nWxXXc6MEuJZqPk9ktgvwrEAE8AHl2jNsDK/0N+oqpFepKxlvsP4YAvnmoCh4TZ8oqYQO9b76F616CR6sZ4UUPVIMwkIoIGME5gvQvs9xVx4wp+ZBWw/PpICEa2tBG5VfevLiAXpLlMUZVQypwGCG2rEhH782GJKRLA6SFi+AqLv1x/zNEwVAz2D2m5Lkd8eFDgc/km4/o9d7o7pr+cLN/oylK6ljhM6SRWrQJbVMNiQTAw0PjKMS5mQzcmab9rqC48oQFumXgQ1EsFzzk0/TtGP2wMfuOhV3z8UFH60ryDxrQLdU5X449ZoGYX00w==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199018)(5400799012)(36840700001)(46966006)(40470700004)(4326008)(70206006)(36756003)(40480700001)(41300700001)(7416002)(8936002)(5660300002)(2906002)(86362001)(7636003)(921005)(356005)(8676002)(34020700004)(82740400003)(36860700001)(82310400005)(6666004)(107886003)(7696005)(54906003)(316002)(478600001)(110136005)(70586007)(83380400001)(47076005)(426003)(186003)(2616005)(40460700003)(1076003)(336012)(26005)(2101003)(83996005)(12100799018);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 04:18:29.6633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a81d767b-eea6-4059-44e8-08db1ad52d93
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6238
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
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

