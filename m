Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC236C9019
	for <lists+linux-integrity@lfdr.de>; Sat, 25 Mar 2023 19:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjCYSeu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 25 Mar 2023 14:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjCYSet (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 25 Mar 2023 14:34:49 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11hn2249.outbound.protection.outlook.com [52.100.173.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED80EB6F;
        Sat, 25 Mar 2023 11:34:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWLZ5RuzIiRjk+6dk6Bz1pCue/3wZ1iETOUyx/+SZEQHJUwo6M+EyeY3SoiEIIDkrV+Nut0ePm/bvC/tvVzN9MB5/o4heenA/WClHxDVJ1G9ZQlrjiG+2H1kBGsCCIMYN1du4N16Yv0HJ5JPoJWJbHeP5CqoIP9ySbxKU6HJaUrFCwFolI7tudHpuAwBy2GMfIoJtjVn/0bJFWY8XL8MiFrEnyx/GNVoZ6gorc0XZR2I2uMyAq0sONch1yx9dmPw3a9lFZ59XhyCfsXL4y359kV1WHvapbHaF42WFr+gn3VMxr7xBKUiP5yPE8zx2pyGvsxNfIgQ+didZR+QnvhEEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+FPDilVIk/o3k5C+klRMGlp15NTebn4SVzZdBYDH/0=;
 b=T+OIFuMvGZUOvmE10XrfwTIdtQ8o8Lg8XWlugvqD+FnVaCAjSs+ivi2xuHOPe57AKfgDsKgfgMOdTXrFP/+COt76+mE+agljhjiWKCGynHszaKBCjjsYOc/j4yrTzWjFw2uWZk+7E3gpVXNJlwvZEgA5Z13w7EyFpzOAoPJW/4yoxqo3qnF6zvbMQRCUN8+8VYoO6YN1ycAbNCn8UzLzq7RnNpDHN+88QfeKVDHJLpF8EJsmmaN+5yKVN/rviSru2RH5FAoRAZVQ9SNXEn68Rb/TyEqdeQnTUx0E8VS3HlThjKR9/KZp6wqScK44QCUpLYf+HCcADb62pq7m9iMTGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+FPDilVIk/o3k5C+klRMGlp15NTebn4SVzZdBYDH/0=;
 b=rzjHGHI4CyuvCo4Fdop5VBWur5iEY936ubEdLS4MM1Hu4ZTtyhyki5FW982Ul/H+7TAWif7OilnuiZ048Srg1G18b7mqmFJRq/ApYsMbYU/Bl0H6cFg3cU4GiLTY1Co8YJw225XuSOBtPJTYr9OE7hNdUvER2NVtllJJ5zW/9X8O/X1hiR75eZ3QnusYs9A1GKNMuxfNiNhh+35hanskVvrn6pOy2w1AMa1/HnJuThe3rqX8WTmVIlXx52Y38HpfiBFJY4gH7XpIHczZD1dimiLeeuZsq+Q6mSuoFpqKycXkm17D3lSOklmrrGxOZKIvqg20A+uMS4iO2jxmeQhaUg==
Received: from BN8PR16CA0018.namprd16.prod.outlook.com (2603:10b6:408:4c::31)
 by BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Sat, 25 Mar
 2023 18:34:43 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::1d) by BN8PR16CA0018.outlook.office365.com
 (2603:10b6:408:4c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41 via Frontend
 Transport; Sat, 25 Mar 2023 18:34:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.22 via Frontend Transport; Sat, 25 Mar 2023 18:34:43 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sat, 25 Mar 2023
 11:34:41 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sat, 25 Mar
 2023 11:34:41 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Sat, 25 Mar 2023 11:34:36 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <robh+dt@kernel.org>, <broonie@kernel.org>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <jarkko@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [Patch V9 1/3] spi: Add TPM HW flow flag
Date:   Sun, 26 Mar 2023 00:04:07 +0530
Message-ID: <20230325183409.7695-2-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230325183409.7695-1-kyarlagadda@nvidia.com>
References: <20230325183409.7695-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT049:EE_|BL1PR12MB5336:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b1e2388-05e4-46c8-6487-08db2d5f9a70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QIdX1i/iA6hGSnfXyx0HQ80yvxMNQ6P384GiUK0uAnnzfRzF4cp1zazEsVGrVangPDUMhw/TaiUYvskWj5Op8fcw566IWcb7AVVPIY7iQTCMh7jYWJSDr7ubK2EOjC6Fkr10X+H0xbVSnoHZ1r6NHbKBFcCYweAQajur1UW1cN+/rUNDm506y0InJPkKmL+NJ6NWgvZ+RyZXd28nl0QBoXRInWlQh3mQC4+bQ0iL0aV0oplVanNZ51jc8Ll0NeaSvPPhPAtAcpEgto8XNADZ8vD/PVIp2GRxQySWw8hapGSRC7KRgBaQuJcvG2ss6q9HWFkcYBwoVS3oYFcdlbIvfMDBAtzHMGlo80JswuHSHlBOWQ/1WhwROkjyWTEGgoxxLNV68ouWfdlNbiFwbHuOxapd1AJa2SKvM6vRc/XWzu3ViCv2g2+EQrAbN/GzHaCxTVcWd/4C6ZhZW6gHotbHOXXC6S9HbVPLN/U3h+g0BAYsg7J2qxhqLRphgeWUUa/wrhH8ZPfjnVaAt9jQPJVYCKutkzF+r2IpJmz3xn0z1af81z/3HimmMMW2um4/WZGrWWPFEvqPVPq99mgHDnJL0nSqffIhbktean17IcUQpOCEJRtEwigD0atBiwc3+SIojrP/0IsktqZ8o7DqFydTeimI83OD0qjCJxm/kLqwHASNBahhAp/IdnxQJIE1eeg1cLqhJuesEWAH/ODYxSD+g9kMValvzk3w1sdEx3oUAUHSJTST3J2oX6Nk99vy6TV+SqS/LaCbGmlQuJONDHlHr1Qwt4kR7jFXzVA2e/PPgogN1f6KI6uZAwbYZJOolNAg8YBHnuPN4yv1SMVvLW87XY7FcVRSqRQP99l0vOIDCJBSRbeM4LF8x5L4SSp/l4xI/+l2ZeUlqDLAdFjgch0vCII32L2XAL2ZEiRcPZFrMgs=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39850400004)(451199021)(5400799015)(46966006)(40470700004)(36840700001)(966005)(110136005)(6666004)(107886003)(478600001)(54906003)(316002)(26005)(1076003)(7696005)(8676002)(70206006)(70586007)(4326008)(41300700001)(40460700003)(2616005)(7636003)(82740400003)(40480700001)(8936002)(5660300002)(36860700001)(7416002)(36756003)(186003)(34070700002)(83380400001)(2906002)(82310400005)(336012)(86362001)(356005)(921005)(426003)(47076005)(2101003)(83996005)(12100799027);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2023 18:34:43.7226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1e2388-05e4-46c8-6487-08db2d5f9a70
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5336
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 873ced6ae4ca..cfe42f8cd7a4 100644
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

