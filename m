Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27066A416C
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Feb 2023 13:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjB0MHp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Feb 2023 07:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjB0MHo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Feb 2023 07:07:44 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02hn2230.outbound.protection.outlook.com [52.100.158.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F08E1F5E2;
        Mon, 27 Feb 2023 04:07:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEapMt7/slqri6kx+CDGjW020JCrD7qkVbdU5vKd3Q66BEcE7Pv3vItRf1/NIawrWQs2DD3rgyA9t5XulOxFr43/oEsmuVc5TsQNlb+koxx/c5pxdXpjEU9JIgjt74FDyzJuiF5Te0H1u5Ns7Z9P+FiLp0LO1zk2tzbqd9kr/BGH+WJL//mZMiHy1bddzJG6y2Yv4/79vaGCGW6o+6aeHGMjZsiG7tbiI2KlMylmK09DKcfcrBwP3nwWtxyRSNDOYd81HG9SZ7VU7KGPZlfCgFWV6wSfRJyAyYu3iW0/tOerOLzTbferHNpx4aXRxnl082IlGkdaB5mBjpw6V1aTqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlgwQbdujaGj9+38SrRlGzXn/YnDWsY1jjfqL94PiFU=;
 b=bQa02ksnvkrgM4hDUaEaQSW+jnC7K0F/Vpca2HUCbMsc7qJ+GU7atrA18FnGe16rYFOAmO3SUtaMZ8zJeuIMIsjyuy2g8WlD7EkoiLw1iogsMKRO/BUAvAPgfwty1H19oTr4uyh7kp1Pq+CGJFFo6aqOeOrveInPNOOqdtd+O0g+1dpD7lQKPuHRAsGQkajoWOdfOd38lrfVGWk2fW+e6YkEVPosoLgrhzMVW7SDLG27jmH+5DREqeCLYvblIwVL9ueeBeROxVtZ6gQpoJwpnM+L8jYGFgTzjOW2CszPjEgM0as4Aubl5NZoohmz7WrmDYbpok92xE9El0LVNgyuOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlgwQbdujaGj9+38SrRlGzXn/YnDWsY1jjfqL94PiFU=;
 b=ZdxZCvvrRnX+c5VCZ6KERr29zWDi/RSB1W5TcC8ecnqri0lZ+sHpLOPEWJ+RtFT1VTf3rJtbggQy/boMqiz1HTHlqxH+6xQwQm3GOQInRKZLu6vgNbXNz69x+BIrRDRkl7Zhgdqso88QxjgU8IBsogt3c3mAFrRvownPyxhohgR8GaMQaUFv58rtgLY+cI7GMBiliC6ME3bUlrzhZrHPbZqgRNHH3Jrpx4FJYxC0R5guiwzNbOuSh1hlofavlU7qVApHNGB1e+tlp9fSbjrWj94UVn9/hsHTq7LCF4cwy3rx7vmxnGXPxHcalwvrojGEXydkBuNRJwjwsOu1qEKsBg==
Received: from BN9PR03CA0200.namprd03.prod.outlook.com (2603:10b6:408:f9::25)
 by DM4PR12MB5342.namprd12.prod.outlook.com (2603:10b6:5:39f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 12:07:34 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::7b) by BN9PR03CA0200.outlook.office365.com
 (2603:10b6:408:f9::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29 via Frontend
 Transport; Mon, 27 Feb 2023 12:07:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.16 via Frontend Transport; Mon, 27 Feb 2023 12:07:34 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 27 Feb
 2023 04:07:22 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 27 Feb 2023 04:07:21 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Mon, 27 Feb 2023 04:07:17 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <robh+dt@kernel.org>, <broonie@kernel.org>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <jarkko@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [Patch V5 2/3] tpm_tis-spi: Support hardware wait polling
Date:   Mon, 27 Feb 2023 17:37:01 +0530
Message-ID: <20230227120702.13180-3-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230227120702.13180-1-kyarlagadda@nvidia.com>
References: <20230227120702.13180-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT022:EE_|DM4PR12MB5342:EE_
X-MS-Office365-Filtering-Correlation-Id: 195d434c-5848-4a66-eadc-08db18bb35f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1tYyktesutHks6I2MOEEne3y10HBkWXvNPm4FfywCQkL9OyVWvw1kPpgvVxgTjBjbhn7pzHoBI8Iyhd2VxOvmvqV7Om+uQROhp2ichFVcP2kqM0RRHclj0yWjurRRlFUbMDSYj0ssgIZYzUgiOYWn/cgoJ7jrPtPuxacETpanqQe4EtvXTj8yHQIVqb74h0Xt4WumjYU8wzSVe1TXpi9/FVpF5rG0HNwvIGO2tu4T37qMPwyVIafm8zoiAJAsKAszGYYnUNocnb/kCj+OaH4mfmqicbUup8DJfu12yiJVAaObm+6WYZCZKLiV/u3+UWmMVrmTPYGlNQoZl7Ye4XDTUn9DlK1IYuMIxEoRR7euE7jpwqwyFtKRIOsopQGLdM4bjd7bJY8CgHE05McYPlhENFkKKozIZ9r/rk5M5+eaevU1U8i+ojfJ3BmN4Ky2J6hvt6JVLG3Gh2uIeXQG4nyx9rGdbsoRLF1yVlil4YWXpH6NkNGVtUYpX2M7Ubek1X5ASNS1xb1/En6hBOhHd1SS3548orpL6HVwR7Vcng2Fp2CMdgwepdNscJYYizPsJ1+ltMfxGM3uzD9RoG1jARxSrsiwl2VE9Cr5Vp9XWNxwhtTPC8rH1odC8FoT1HWZT3lzYYbds4L7DhSao0RQoMzaoEqC70D7nYSw9/kU3wwsei/e5U4CfKykEnm8HWnomqMd6pxKuGhh61S/y6KkGo/wNp1L/lZYvaTSs4H6b2LB4aQJDipglwqqknXquY/4OHd+TU+aVBlqmDRWHFzC6w727cuJ1diV7Jof9LIQQxQFf4xuLey4XsHQ8oeGcCZXXwHnveDxtgz2h7ZSN5Ucg2+pA==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199018)(5400799012)(46966006)(40470700004)(36840700001)(2906002)(1076003)(7416002)(5660300002)(8936002)(36756003)(54906003)(40460700003)(41300700001)(70206006)(70586007)(40480700001)(86362001)(8676002)(4326008)(921005)(356005)(478600001)(110136005)(7696005)(316002)(82740400003)(6666004)(7636003)(107886003)(36860700001)(82310400005)(26005)(186003)(34020700004)(2616005)(336012)(47076005)(83380400001)(426003)(2101003)(83996005)(12100799018);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 12:07:34.4507
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 195d434c-5848-4a66-eadc-08db18bb35f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5342
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

