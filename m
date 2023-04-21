Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47146EA6B2
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Apr 2023 11:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjDUJOc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Apr 2023 05:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbjDUJOQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Apr 2023 05:14:16 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02hn2244.outbound.protection.outlook.com [52.100.160.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D497A253;
        Fri, 21 Apr 2023 02:13:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rq5NBg8CQ3nSQBTATIAc0rUBOgNLkfeQ/Bi6tze1odHT58fh48CHvQ59fUz3cQIKRhyC1zcZ80WESkO16Fbl5RTky4uMAaP1cHMlzmc1SRPgwZA4HN1y3DyTCSmYJQQMzr1YQIfZNePKlCEi54u8xeaa7L9RwSviW/uTPd8uvMwkN/ynvalDD8mJqxZMJRlIlaK1VxswD5/cUOp47o3ctiuxeq42oDYTsjBXIPN8VtmDE/dev92SDsxX7ZaVayj0zDLOWW1BBeU2ZAgAFZ22raRFnP6VQ6V6MuFw2RDLIGp5V/gMacTGte5Bw3fJJjjXI6reuSxJRfR5QuHOIW10Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/OCcEi0eKhWhbsKIPJhHnH3b4V/eOLudTwMFUOom5Q=;
 b=bVA0fczgFZ9J3C2qxX4BLAEGdvR3AVynRuZEP/ugnfme6JrwRejm+LxCRfIbD0Bo6IKgzNttltfTRsEO+v7vDCwtEI0QQg9P08gHTdRMgTFKieFGC5imVsZrKPsWRGMgRcm9oVyzzWk1IcNlowdTpuLKYRZJg7Yqt1gOnh4RW/hsjh48WfGk5vx+s1J2RxfZHHxKw3IzbJGI8JKO2+DaXaing7onfTg4qbvTSNIp7oSycxwQN5t4elg52DIYxjYa/VWaieMOQcNSN1W0pHjuBRHcpMicYsEKo0Iy/QAewf16MXqzaOLs+f12N+tiPUnH31kXXRTgYMZk0yNtIUwZ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/OCcEi0eKhWhbsKIPJhHnH3b4V/eOLudTwMFUOom5Q=;
 b=Ey18GQukF4icBkIVTjwexCM1SYCa+cpSJCjJjGk2IZ7+CdabuYb+Cdm/Beh9pqieGK455Khs/dlSzNRZUe4ItotMYE1K7SRLQ2P8CdMgjE+iU1lQIGPqt//h7OjJO73AIBBlk8CmtRfG6VDb/PUzhBFJY2CN0nxNITTUYj0bUHC+c/sO6gRywJcX8zRQ8kOSrYCEyEthkIChQIePENd0P6H/N1tb5GJM/qe3H9dy1+XEA2WQJj5TkPuu+DIB1oANhU30iKjfBZuUdXT64xmf/BC8NQ+W3GNAd6jbCD8YDQwUNRLhdF0WHBvysrF2yDXt/ZuwdN0YQtGJfexrp1/S8A==
Received: from MW4PR04CA0354.namprd04.prod.outlook.com (2603:10b6:303:8a::29)
 by DS0PR12MB8319.namprd12.prod.outlook.com (2603:10b6:8:f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 09:13:45 +0000
Received: from CO1NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::42) by MW4PR04CA0354.outlook.office365.com
 (2603:10b6:303:8a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.27 via Frontend
 Transport; Fri, 21 Apr 2023 09:13:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT115.mail.protection.outlook.com (10.13.174.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.27 via Frontend Transport; Fri, 21 Apr 2023 09:13:45 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 21 Apr 2023
 02:13:39 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 21 Apr 2023 02:13:39 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 21 Apr 2023 02:13:34 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <jsnitsel@redhat.com>, <robh+dt@kernel.org>, <broonie@kernel.org>,
        <peterhuewe@gmx.de>, <jgg@ziepe.ca>, <jarkko@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [Patch V10 2/3] tpm_tis-spi: Add hardware wait polling
Date:   Fri, 21 Apr 2023 14:43:08 +0530
Message-ID: <20230421091309.2672-3-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230421091309.2672-1-kyarlagadda@nvidia.com>
References: <20230421091309.2672-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT115:EE_|DS0PR12MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: a8f6fd34-cad4-44a4-6048-08db4248b5b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L3gPf0ezKIBQ4xUhpzQWN5ionU9HDL8UStkgq3COJ6e7DTs3QgTG4H4xKxXgBzkkL2cOW/BKUIgTEkuS/syvXQtK/WG5zEYWmV0MCK7kx315ZMzxvCu5i1nDEwjxaIGeCQrJVamQ1bclR7FzzdNLEcyakI9Vghwd1ParZZuh1RVCH8asPOA9+Rp6FO3c6yu/aDsjBai2WJGExpMvKyYNbnTFA7qFOBKNkjBjazXVQZMumt7hWJ7cailacuNssyqUHYYVy9lh2NVOmuiJjNQawEVsyTuRBSrTMfs090lnTYVb5UQqhOPFCFTE8XXSz577gqXkuzpvmRArCeIYmwnwO3H3BXk0uum1RkLHAtfI0FJ3586aEjpEH9fj6Y3h62IjyIQmJylxQjOKoNV5Lec1taOvWrqnvwyUU8ZlrhKMoJOWWy3ZpZIMu/JD78fJgbkrGw5WnZ80V/DCaxoKMtkHXYVAVjZryTxmONJIq3drL4lekx0g1Oca1GgT/VDR8VRpcw2wBCFHtgyPhYSeIaUYQ8oe0b8QfuqM0HMHWbuvRpg5TpyLKNFrG9eGh6BgK7avCPOlafGeQkl/9rZDY6YT0mjpgI5CgUPFhHNPyVdBzq3RQKLcDudh7MonOC9k67XiduUsKvBwlmNM+mMHRo80J82vG0dqJecffCLa23JiW5UFL4zgkNKNtRhY00T9UXCg9k2PGxocSv61np8Eo6qTAssuAqUwGmPOz7vT9EGNiNu0MljECJV6H7/SSmNaoBzc/LYsobBd8BxPJiifGrMkn6cS6bEFWcUmxAOLLuGcpHN0HNdtNxybwy74OLdHLj28kzmQ3ke6SHj83vO1Q7AJ7CdqmUcFhUp10yAqAyH8XY7+zD18WvAIwJiPgbwp/BHB
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(346002)(5400799015)(451199021)(36840700001)(46966006)(40470700004)(186003)(1076003)(26005)(41300700001)(107886003)(7636003)(921005)(356005)(426003)(6666004)(7696005)(47076005)(36860700001)(2616005)(83380400001)(336012)(478600001)(40460700003)(34020700004)(7416002)(4326008)(40480700001)(82310400005)(70206006)(70586007)(316002)(82740400003)(110136005)(5660300002)(54906003)(36756003)(8676002)(86362001)(8936002)(2906002)(83996005)(2101003)(12100799030);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 09:13:45.5892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f6fd34-cad4-44a4-6048-08db4248b5b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8319
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
index a0963a3e92bd..8967f179f808 100644
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
+		ret = spi_sync(phy->spi_device, &m);
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

