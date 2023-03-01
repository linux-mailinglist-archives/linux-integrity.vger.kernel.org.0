Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE7A6A7226
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Mar 2023 18:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjCAReX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Mar 2023 12:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjCAReW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Mar 2023 12:34:22 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547F222782;
        Wed,  1 Mar 2023 09:34:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CubqDvy7iU6C6gPWlWTjFzns0RqNt+XVpaI7R74JWL4ZGxFdOTgooVjmSLA2hTqqixzZ/Q8mE7VxCfggRDNVTUJJoWnevOa57vJz4rpu8BAzC7Ng/4lZWzepz8Az5X+zVVzpji3t+DPyjTbTjBzrsUJOpM4wFtC2Deqq90fnOaKIJgybVvcDHn+t+gQa/qT1Knx3CSR14EbuKlN61Tlpx/bf+TRKGl1TKQhFIOO2Rm2pFIeg8PvfhmlBGKr7Mn/8t8iWpMqZSLTuLySI4+/eM6kJKEkiBQW75QyZdY6lUHbQkjnp/0m0sFUBuHp3vcVJ63X/BE/eyCM0Qo/gmiY/8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mh9Ua9+PFTGOWRtWUmLN86IqbLOmxsmrJzCJu52I840=;
 b=iQum9Pizew/Xr6B0fSTLyKS00g2Cq7uMuf6ch6vkYIVtGzegnl694fWclnjuVkJ//gm3AwnIVVllJpf21ZyZRZOUtuoFtOpv1kvYletf8htiGkdCtd1kxOMaiJBb5VI2vOptoEi4IxI9fw0wryWFShq2mOCW4B8oHbiGUssgBgdU8KbhnMwCqLMaMshTe6O9m5JP+rcK1ycEESsU9gxvo3SoBRru33oaampvpBbaPu22NXaSy48GAz0Sw0uQckM2LrRp30jG+WZzHVm9hGNEzV+A9ye4G/Yng+30uI+M/uQVNKZGlVT6xhvtWOpJyhBK2muqbEXWPhQgQQ3BT+Rn7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
Received: from BN0PR04CA0155.namprd04.prod.outlook.com (2603:10b6:408:eb::10)
 by IA1PR12MB6530.namprd12.prod.outlook.com (2603:10b6:208:3a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Wed, 1 Mar
 2023 17:34:18 +0000
Received: from BL02EPF00010206.namprd05.prod.outlook.com
 (2603:10b6:408:eb:cafe::7c) by BN0PR04CA0155.outlook.office365.com
 (2603:10b6:408:eb::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17 via Frontend
 Transport; Wed, 1 Mar 2023 17:34:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF00010206.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.12 via Frontend Transport; Wed, 1 Mar 2023 17:34:17 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 1 Mar 2023
 09:34:05 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 1 Mar 2023 09:34:05 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Wed, 1 Mar 2023 09:34:01 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <robh+dt@kernel.org>, <broonie@kernel.org>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <jarkko@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [Patch V7 1/3] spi: Add TPM HW flow flag
Date:   Wed, 1 Mar 2023 23:03:51 +0530
Message-ID: <20230301173353.28673-2-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230301173353.28673-1-kyarlagadda@nvidia.com>
References: <20230301173353.28673-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010206:EE_|IA1PR12MB6530:EE_
X-MS-Office365-Filtering-Correlation-Id: b62dbcff-3aff-46a2-8018-08db1a7b2f4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GkhL9DmFTZXdIWP+Orpjd131zb6ME1tqm5dlwjBYDnL+2+ApMjJfGPdwUrDCuGMfqiMrJW9YbjCrSALzL5pDFHazVXY4B1HVkl2m7HQuUtryaT4YxGa8lKnU4A2gwbz7HqQQO9BteE2pUnTevjbsiAjahBkH9hdpcow0Q2pFu+EKUV9mlXxD5cq5fiFP/s8Pk/DQdi7yLlai8Mu2RfwS9ziInPY5xdP9PDdfqxCb1Ac4RIHJJ6sitEcg4+rnm9aLr0p3ILx8zIKWgXQ6+vxBEGvEAiGxa/vCMFfXQ8xu2uYYr+GW6Los7J2HZpngItimNnY5tMfKXCkUyBtkGRNMsUMlFT6eA8Gab2Jt47uQpJQCTvjZjMhSJKApNlG5Xx8ZMRU6SMnQX3UjSpnlXcCCdkXzrdNYhr+eahfe1Jn5HC6AIEudBFmhZ5bG6II//0FAHJsgo0EhZNA94FppZWlChNM3UdL3crvIK9CP52pf1u4/JrSqhWd8H8zYiA0YQ2zq6NqtVdU9aHETt8hlv2izFKJEarFQwYlHEVQLfajG5OTlCDo9YZvDYY6q6L9s2GJwRc5dMib9fx4rLJeH1q97sck0zW8el6HDnqzJVkxsNGx6FK8wUh6X8keKxRaxJbkar4meGrLnfJ3QtT5yCci/BqbuS3xX07RvX8f5KLppwhxfF5efdcjFTIRakU4bCgv6DRqUIIlKQM1jlgH1wypoeMjI/COUjxXdYp5Ji2bWRrkGfkGK2mlS4iPtAnlAvj8HxnLPoVVdUf2rsdwqMSB9HykwqvdOD2TUxis8cZAu03Gb9pPCI38tBVdp+sUVelo9
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199018)(40470700004)(36840700001)(46966006)(5660300002)(2616005)(40480700001)(7416002)(54906003)(110136005)(7696005)(107886003)(82740400003)(6666004)(7636003)(921005)(356005)(478600001)(966005)(41300700001)(186003)(36756003)(40460700003)(8936002)(316002)(26005)(86362001)(1076003)(4326008)(8676002)(70586007)(36860700001)(70206006)(82310400005)(83380400001)(2906002)(426003)(47076005)(336012)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 17:34:17.7737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b62dbcff-3aff-46a2-8018-08db1a7b2f4a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6530
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

TPM specification [1] defines flow control over SPI. Client device can
insert a wait state on MISO when address is transmitted by controller
on MOSI. Detecting the wait state in software is only possible for
full duplex controllers. For controllers that support only half-
duplex, the wait state detection needs to be implemented in hardware.

Add a flag SPI_TPM_HW_FLOW for TPM device to set when software flow
control is not possible and hardware flow control is expected from
SPI controller.

Reference:
[1] https://trustedcomputinggroup.org/resource/pc-client-work-group-
pc-client-specific-tpm-interface-specification-tis/

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 include/linux/spi/spi.h | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 4fa26b9a3572..b9e49ed42955 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -184,8 +184,18 @@ struct spi_device {
 	u8			chip_select;
 	u8			bits_per_word;
 	bool			rt;
-#define SPI_NO_TX	BIT(31)		/* No transmit wire */
-#define SPI_NO_RX	BIT(30)		/* No receive wire */
+#define SPI_NO_TX		BIT(31)		/* No transmit wire */
+#define SPI_NO_RX		BIT(30)		/* No receive wire */
+	/*
+	 * TPM specification defines flow control over SPI. Client device
+	 * can insert a wait state on MISO when address is transmitted by
+	 * controller on MOSI. Detecting the wait state in software is only
+	 * possible for full duplex controllers. For controllers that support
+	 * only half-duplex, the wait state detection needs to be implemented
+	 * in hardware. TPM devices would set this flag when hardware flow
+	 * control is expected from SPI controller.
+	 */
+#define SPI_TPM_HW_FLOW		BIT(29)		/* TPM HW flow control */
 	/*
 	 * All bits defined above should be covered by SPI_MODE_KERNEL_MASK.
 	 * The SPI_MODE_KERNEL_MASK has the SPI_MODE_USER_MASK counterpart,
@@ -195,7 +205,7 @@ struct spi_device {
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

