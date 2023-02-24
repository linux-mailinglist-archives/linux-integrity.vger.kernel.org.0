Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDEF6A1EE5
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Feb 2023 16:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjBXPuV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Feb 2023 10:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjBXPuT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Feb 2023 10:50:19 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A956CF29;
        Fri, 24 Feb 2023 07:50:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uki26hSNx4DrWWpthrLbL0vX937VuEXZ58Eb10PHPR8VbS3D9tr7iI2172QB/OsRyERimVlTLC0DoGpEGLDogOcYP2n7UXcrZeryWF9FKhpfhTBVdW1bX6xkP64VIOE4TYv5cl96nX5P1v26PF/siSbjsda7GQ82L8m2/B0FGnsZ+KERQzqgKtUKfwr5RI9/kvbEodIVQ4qCbh4Q8/LCYt/zhsHxJC+qGIwA08KwaAwkEVOV2S2rsUOYFuQ3ILNAbf6MhUgCkQH8eHN3I5ar2C8ajp6NZz5ar+JwxMQR+o8vwvGKdqubQXsZiNXwXWl7LPMQHzcSVzEPvUQuFpCx9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0cEiBaMNIgPRegxXaIJxXz2fOQimc4elvv1wRP+Co8=;
 b=CajXwa2tAMu2dbob6Z62w7RKJi9ElQyCEjusaMt/1dzNWW/cqtBGLARBCe6tfkbswGZHdZHbn4J6bRLqBd2/IrjaOkAH/yN04ehtq55/d/eOzYgCTw/O66na8BymY/TvxA4qEuA1nqDAUHSJ3QZbxTOKUT2YqTY6ykYXdxIU/6BEKSERC7YxKg8sQOFbvobxbbDJRulLEA/Kk2tVy/J57nWb6ZxoUI+8BMBHrnyUyXym/LD+TQ7uMzJXIxZUUZMtu54T8PFZdnIcCpfRAhKmZvmqKeBxtcD+WH7Fo0O6IXjCcnDD1NHpLGMljhUwZBNBrQigQCa/l9JjeqDhs5scFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0cEiBaMNIgPRegxXaIJxXz2fOQimc4elvv1wRP+Co8=;
 b=iODJeHPIubZKzMRsZGcD49HvwP5UhNHtnxADuRrGalYTNU1d39wAqualIv0djd9RbWPtaAxB5V5n0ylO3J/b39t/gwjQucAFFhfeneJRGbMLECZW5VLCMK6/r16O4dsb8A/t6ne6qx3j/3adgomEZLQBl7AppwxcaIIIWVfRLHh8K1kPkRcx6qXu2EwFvqHSVhlPMvcoJrja17JejDwPf5gDWGOejlDMmEo5tOVMSp6O1rnoAwWbFYxOBB3LXrCvlda+54g1Ci5MGwzl7bnbqjaahTOaAyZo7/rTHhFjQ/kX8IDQUQpNbH3HvUOUEn7twK4iEhcB8eIYAxrDmiszbg==
Received: from BN8PR15CA0052.namprd15.prod.outlook.com (2603:10b6:408:80::29)
 by DM6PR12MB4561.namprd12.prod.outlook.com (2603:10b6:5:2ac::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Fri, 24 Feb
 2023 15:50:15 +0000
Received: from BL02EPF000108EA.namprd05.prod.outlook.com
 (2603:10b6:408:80:cafe::ea) by BN8PR15CA0052.outlook.office365.com
 (2603:10b6:408:80::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24 via Frontend
 Transport; Fri, 24 Feb 2023 15:50:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF000108EA.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.12 via Frontend Transport; Fri, 24 Feb 2023 15:50:14 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 24 Feb
 2023 07:49:54 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 24 Feb
 2023 07:49:53 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Fri, 24 Feb 2023 07:49:49 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <robh+dt@kernel.org>, <broonie@kernel.org>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <jarkko@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [Patch V4 1/3] spi: Add TPM HW flow flag
Date:   Fri, 24 Feb 2023 21:19:39 +0530
Message-ID: <20230224154941.68587-2-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230224154941.68587-1-kyarlagadda@nvidia.com>
References: <20230224154941.68587-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108EA:EE_|DM6PR12MB4561:EE_
X-MS-Office365-Filtering-Correlation-Id: e56d3671-0a6f-4d90-1730-08db167ed219
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wrqanw2pJRvFAGqIzmOZFFMUWC/V/CV4HYbavFUG7kvj/BKpCOADJ5fGGQtyXmhLB/J1yA2xTBFcSSAz+ymsWZCi/CqfkBYXwpxMvfIA56vMDnt4nW+LUwaHDRduwB8B+Gch83bum1EvkC8g6pjEnj6SQaxiyAJL/GzZvoAobp+b7WcWxUU6XcA00kfTe7LqKts6ZJQX4r2jAVy+gfKkAV7XcN3Cg2ZdUTiknG9Fvbt3MDkglYbfEC6Gw9aBxcZClPNr7FCnW2oTZvU8TtCOd2byCvM6hftoon1L0mfUcvLSTmPnvO7KUiUN5u2KdR8Yy4Xt8QNmr0WLxIIELfK41MgQ6oTI3c3d7SsnrITMo6ql+Ie1pHd1/T0XqOlB8pHGgWzrKR1pultCnccpJ9TWG1Brp0FsRGoq0X8NuZzmIHxQJbO+s2hK4v45EHg9YNqUwSZBunCUhDytJsRpoJv2n3sZC3Bhd45w//S2ssd/lAm/kZQTN5DazrosJsyZUtaGVN5k+16rQ/rN8lObEnFLyb/5KsmPVvzwSSrSdbjBKpHuIjJWdGl4H6SClllHSpe1mnBmMPjI0S+XTvGk6sb+WYtjxf73glwuHk/I/Q2kf3rPUf9xj5n5D3isivNh67Vezf+KAVled6zExpmlblf0cXQh891BVQmctqwD/QTNTLA3fsiM1GGoZazlEqfVw1n6R0dVsMPHpvtlx+TeqimRmO7s2DCNUxC5e63hBXBzERSgJlSwLAY2l4kLrwNSbBqAUZKGVImJ7P2yEdUF0neYvg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199018)(36840700001)(46966006)(40470700004)(7636003)(54906003)(8936002)(316002)(336012)(186003)(36756003)(26005)(478600001)(921005)(40460700003)(356005)(1076003)(7696005)(110136005)(86362001)(107886003)(6666004)(40480700001)(2906002)(2616005)(82310400005)(5660300002)(7416002)(82740400003)(41300700001)(426003)(36860700001)(47076005)(83380400001)(8676002)(70206006)(70586007)(4326008)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 15:50:14.7575
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e56d3671-0a6f-4d90-1730-08db167ed219
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4561
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

TPM spec defines flow control over SPI. Client device can insert a wait
state on MISO when address is trasmitted by controller on MOSI. It can
work only on full duplex.
Half duplex controllers need to implement flow control in HW.
Add a flag for TPM to indicate flow control is expected in controller.

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 include/linux/spi/spi.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

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

