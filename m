Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1EA6A0DF1
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Feb 2023 17:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbjBWQ1L (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 Feb 2023 11:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbjBWQ1K (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 Feb 2023 11:27:10 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02hn2230.outbound.protection.outlook.com [52.100.158.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDDD56506;
        Thu, 23 Feb 2023 08:27:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZmJeoAOgLe4YA6GTGU/fYResr1GI5WnUHrmIW4NvrlmKDyA0k9vIRyEckLqTLkeJ3EAm8CaZ0dKR0ACxrL4SzhfHtL0tYMgz4dxqkZZMY6Vhf5LTr2PXpVxGjCC08Z2kPIaprZd+5M5ww514NLAolPDNFzM/Gb5R4HJXIVE0KqrdFL1plVT5Cn6nVdSlxmddAWwmD/rBcU5E19/X2YuZSAIEif7R5R3mbdDBCGo3/zBBn6TlVOT3OInEIsj90zd7FAB/8zzt2AN06z+R0qHy2k+9V3RF8YL50ii0xY5Y6XrfrA9vOv0t2OEcaYcsd5brYp2dN3fBbR4+NxpXKJcTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OyYLYUH4QzLSiwA6Ej8cpIX1gGW7clql9i1HxVB+TMQ=;
 b=akhMYZFvaWqL06Rz8fbLA4NZ0YWLjVw7DTnVV1Gepggaa7A+IJX2+AMemZa/w6yDLT6m/FCWYqb0QawakJJsLpmwISnGwLNww8JVOy6C7u/8DSMEw7iBcQ1PacZBfqCYuZj3RFkarC9LGV7oZlUuEAqqHnQ07MyRhmGtFM6V0DQJuL/MFNT/Gfmk6BVOefVbz1MfQMvdoxzcIVNLLkqy35zkdKEHskXzvCx7P4YKVSHouyfBzCYOlje5LL+yn7p+8gWqSsSE79fpkCczZXQ2Z6d2qd+ZjKLQ18UsoQw8WL2qO+TBygjNbpRk3yIxxRwNmJrBBlP9K44B3482l/TQJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyYLYUH4QzLSiwA6Ej8cpIX1gGW7clql9i1HxVB+TMQ=;
 b=i/tij5cDPw7pVoxpgP2W0bIK/WIzhBjUKv0t/mK9qtd3Mc0yM1p0x7SghLplBXIatNFUpZz77OHZ2ab9mjVmp6jph/D6FC01uYHlG8XZunfE3zm1rplK68jJAZgKdVbdSnjuGeNtF70ijnC8yKv2KrGhozunmFjJJKEeenpZadepxqviUfjhskdFUpm8sUlYecDbLwuLBHmDMeXTBHkuGGsB57FIg2Z05iK+HWZ9kSUjE2GeGBztsvQ7nHjCER5lEepCFpSB73gCExmIdahlJ9Cph1U4kJQvSD/eJLqV7jTGmau9daqj1Px34CoO7KLrg/dhBmdjjcQ86XbrMutT3w==
Received: from BN0PR07CA0020.namprd07.prod.outlook.com (2603:10b6:408:141::18)
 by CH0PR12MB5267.namprd12.prod.outlook.com (2603:10b6:610:d2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Thu, 23 Feb
 2023 16:27:04 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::e0) by BN0PR07CA0020.outlook.office365.com
 (2603:10b6:408:141::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21 via Frontend
 Transport; Thu, 23 Feb 2023 16:27:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.21 via Frontend Transport; Thu, 23 Feb 2023 16:27:03 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 23 Feb
 2023 08:26:57 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 23 Feb 2023 08:26:56 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Thu, 23 Feb 2023 08:26:52 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <robh+dt@kernel.org>, <broonie@kernel.org>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <jarkko@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [Patch V3 1/3] tpm_tis-spi: Support hardware wait polling
Date:   Thu, 23 Feb 2023 21:56:33 +0530
Message-ID: <20230223162635.19747-2-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230223162635.19747-1-kyarlagadda@nvidia.com>
References: <20230223162635.19747-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT040:EE_|CH0PR12MB5267:EE_
X-MS-Office365-Filtering-Correlation-Id: e0d4c17d-0b2f-404c-891a-08db15bacc4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bjAtRQTC/W4IFem2/NiVGeCjbyU3oo20rNejRaSclHSHYqInoudPQB+OA085L4G+O/rCreabKPoSvt1qql3RKISJigrCuM6VRhODJc9xJDOyjuOVpSxriJInQAfBP3oQfJAxQwEDGxHhM1ynNuVVDj4rNzelpG1OdhUbuLIPXrTrlXtlPHCshv8OueWDD23CoW5XrPv750LvX4esMFg1ugydEK3wRCzjSDA6ZFr1n7/nXE5RnJa8MvoTdoFPV2muGr8U7M7mvGzE2hxuyP4xqg7bLpBrL6Jyzscyydromj9g/GH8vnYMibBHycKGZrN9109VKk0lV1zzBXsreqP/YK73MreZzRy9BDVcVXLlIY4hFGsx2QZ6g+HZrvtH+3XIuu5uGbzIWjurpVOk6hB4PUx8vznIT3sQcwrKMjn5QdBxy8Y0OoNh2+Mk639fEXlAd9dA7CpNs92nzx2u86PuS+YZlLGtUZY5V1QCPDSHCfD1hnB5bfV22N34j1/d05q3UrIQ55GbgJC4UYtHDFUeL+Ij1ZM7OXvFYkANvAlaVJkHS96Owu+bONxDTNvVlfbyb1AQVauG3RU56qbCuwEK6zegqnNPQ9Zle+MWsIIE1T7LJWX1MSVxo214O9RQqz38SznwQwtUwGUGGBzaeL901yRuMW97r0Jnzr2TIuu6NDQ4UKqMgWtprIZAePubNYrsEApPF9GTO3wB/3bY1IibzTcZ6GVGX1QWtOIiVRqlWkWdTtZPqhH06SPiNZokUeehd8jrNHqeiPn07RjcvTgoGG1y61JEXq7losj++T96hsLFG6l4ETuf+UwoT1juCZcc+HxJAsx7+GGKHuYs+JNgdA==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199018)(5400799012)(40470700004)(36840700001)(46966006)(478600001)(110136005)(1076003)(6666004)(107886003)(7636003)(26005)(186003)(7696005)(47076005)(41300700001)(70206006)(316002)(4326008)(8676002)(336012)(426003)(83380400001)(8936002)(5660300002)(2906002)(34020700004)(36860700001)(7416002)(82740400003)(921005)(356005)(82310400005)(86362001)(54906003)(2616005)(70586007)(40460700003)(40480700001)(36756003)(83996005)(2101003)(12100799015);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 16:27:03.6784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d4c17d-0b2f-404c-891a-08db15bacc4b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5267
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
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
 drivers/char/tpm/tpm_tis_spi_main.c | 90 ++++++++++++++++++++++++++++-
 include/linux/spi/spi.h             |  7 ++-
 2 files changed, 92 insertions(+), 5 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
index a0963a3e92bd..0d3da7ef9a89 100644
--- a/drivers/char/tpm/tpm_tis_spi_main.c
+++ b/drivers/char/tpm/tpm_tis_spi_main.c
@@ -71,8 +71,72 @@ static int tpm_tis_spi_flow_control(struct tpm_tis_spi_phy *phy,
 	return 0;
 }
 
-int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
-			 u8 *in, const u8 *out)
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
@@ -140,6 +204,28 @@ int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
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
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 988aabc31871..b88494e31239 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -184,8 +184,9 @@ struct spi_device {
 	u8			chip_select;
 	u8			bits_per_word;
 	bool			rt;
-#define SPI_NO_TX	BIT(31)		/* No transmit wire */
-#define SPI_NO_RX	BIT(30)		/* No receive wire */
+#define SPI_NO_TX		BIT(31)		/* No transmit wire */
+#define SPI_NO_RX		BIT(30)		/* No receive wire */
+#define SPI_TPM_HW_FLOW		BIT(29)		/* TPM flow control */
 	/*
 	 * All bits defined above should be covered by SPI_MODE_KERNEL_MASK.
 	 * The SPI_MODE_KERNEL_MASK has the SPI_MODE_USER_MASK counterpart,
@@ -195,7 +196,7 @@ struct spi_device {
 	 * These bits must not overlap. A static assert check should make sure of that.
 	 * If adding extra bits, make sure to decrease the bit index below as well.
 	 */
-#define SPI_MODE_KERNEL_MASK	(~(BIT(30) - 1))
+#define SPI_MODE_KERNEL_MASK	(~(BIT(29) - 1))
 	u32			mode;
 	int			irq;
 	void			*controller_state;
-- 
2.17.1

