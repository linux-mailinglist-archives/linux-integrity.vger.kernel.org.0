Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9E16A47C9
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Feb 2023 18:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjB0RVy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Feb 2023 12:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjB0RVq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Feb 2023 12:21:46 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF5923843;
        Mon, 27 Feb 2023 09:21:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwGgeL4hJfq8x+TRe5gJBkYtG2h7rCjoKbJ5A0l9+bHsG64aaSEBt8g6O7krOPxsGZzFGA7oGK/lMZRurmZ8gFBVNEVH60FN3tDEPV27R3ftzXyhEd4Zvkc1tSGzsjCNI8nJ9AntWjHUNEj6gYlWsqTOdKdcXAky5GIaQtZS1KkEX86NGPnu/+byzXqgJN+lXHxkuI57dWQVHEb5bVad5+3P9/CW/44Pgrj9pgY+lg37QcF4adYjUVib5Z3Em/PDZAIaBo8Z90VpPqXnhXdULSdH8zF7q+cl25BUrvi9EGYyNBfx50rsZGk27coZz/oeDyFsAZwej3kiHIgpmwKtWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9z3h89NmWQPE45T7w8B5uzlawJkhoD5j8eX9+XZE78=;
 b=b1QgWkOPDEXpnPgyPm2BvXbaCzDMrxOi8rygCoqFPucd2jt1T+eIW1LnbuuJwKAsMPVH/2fVX2AMNyn8iwaY4e/4t4OlLNyZ0roa4WiJfv579Ey0w5j0A6abrePOr4z8rECU05WP/oKFzCUyDBhc3a0TpPDsKKpiT4mP4l3jkN+4SLATbEVONTj8kKbnvWECaGaI1aVWYIgFMC92+zITKOQMxN4LOGsiFU97Jm9C18jZ+MypQ86YqdL5aTw9l0748sj2ydEbahg4gjVZWOpm5GdcdbpS7CT3/iUq0ZlOHv91OOx+1Ffsjd/6FGl1zMOg43qfc39a5G71mAuN19jh4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9z3h89NmWQPE45T7w8B5uzlawJkhoD5j8eX9+XZE78=;
 b=t/Zi+k5WEDp4q7w9A08ub1/+YkwiWMuNZpOAgQTs8QmHjj8PtzsGG5McbzByRFGgXe9uGrx0Z0VqeLDSJnNxg89cv6dCnHqLJUl2SoJyUheM4rV0saEJDVvg4AnZPgtbPhP1I4AdV5RV6kMjzdSnnJ6vb2hkIpAMikqRzf0Bx1cObCN9LGtxR53gQ16AYBechD0wnD/GF4LwNCJ0rKIYM9UjHcfSPvDd423tD4EceXimQJFWDODpECo9YCRovkmCuC8FKi7OOtwyEBDE/4hDvLWwA7k5q/FdphQkYNxC53AwskoNv9Xlx9RbVzoavqVisEqihT6H6nn3Xc9YFepFxg==
Received: from MN2PR19CA0049.namprd19.prod.outlook.com (2603:10b6:208:19b::26)
 by DM6PR12MB4105.namprd12.prod.outlook.com (2603:10b6:5:217::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 17:21:40 +0000
Received: from BL02EPF0000C405.namprd05.prod.outlook.com
 (2603:10b6:208:19b:cafe::9d) by MN2PR19CA0049.outlook.office365.com
 (2603:10b6:208:19b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21 via Frontend
 Transport; Mon, 27 Feb 2023 17:21:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0000C405.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.12 via Frontend Transport; Mon, 27 Feb 2023 17:21:39 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 27 Feb 2023
 09:21:28 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 27 Feb
 2023 09:21:27 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Mon, 27 Feb 2023 09:21:22 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <robh+dt@kernel.org>, <broonie@kernel.org>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <jarkko@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [Patch V6 1/3] spi: Add TPM HW flow flag
Date:   Mon, 27 Feb 2023 22:51:06 +0530
Message-ID: <20230227172108.8206-2-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230227172108.8206-1-kyarlagadda@nvidia.com>
References: <20230227172108.8206-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C405:EE_|DM6PR12MB4105:EE_
X-MS-Office365-Filtering-Correlation-Id: 4859cf62-c78f-452a-c939-08db18e71682
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wz8NP7+vrjPf3w3sU8vhsAC5McRDuNrFXPPgCnU3cwxwMw2+KJ+0HVHiRKPQQkgQBUBv5kaACifI+BXa6YV7sL0aLIPN5ww/5sCox5bif8PNR/X+ooSmgMAojcfSFYXELVqKzWVJdrFsW2bUhTATjRdemtPEn8Kx8f/BTC1RJ/Y1Wg2lMul+xaJkklU9pts0cchIsO5hLDBtVv/W7TIIU135JOJv9uD5i5iURumwshG+NgGsBAZIwXJbTJSIP93XeDd4Ry9AC9NofUX25o2ra8QbPztq59l8TxLQz+u8E/OeN+M5LcVgLM0HqupQfdCKwCv8Rh1IqrTtprCaFZ3dtkS/PXE/gSoWxRiTqkwFG4XhktfvN9IOvQzL6542ZhUoHYPQ46DZPPuMbxc3WfP0Xh421vn5y5QYcQuCLO41oP7ta2iM/R3gEkuwFlbnuPRz1ossFGvWVxlIJRWxUhULLgvgVnbipBFigiz9iOOJKSslns5HrJRWWd4sDY6jUTULEXfafBM1cnqio6Vqv/CEble3J9XajBxKj+9nk2GGw8CjmPAGbrMmsnHa66INSDVKrFOYD/mnhaCtoKc2xlEnGIfXZo1SvGUvkwxgH80bR0vplKz4XuTaw5vyT3R0hfMd+Yqzf1vU/r90y3lq62hFQrvDuzxX8jcCxoAGnmRxDlf08tUioZyQ4vqDAbDdwnGdvYm3jE6NssYc+7br69NXTbQGUNPOXL5qpJuan6q1xH6qJYiRWVrFhi7dU9/4xQ3U0iqx9GDqCn6f1kyuqOxC3A==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199018)(36840700001)(40470700004)(46966006)(7636003)(54906003)(110136005)(8936002)(316002)(82740400003)(36756003)(336012)(8676002)(26005)(186003)(478600001)(40460700003)(7696005)(921005)(356005)(86362001)(107886003)(6666004)(1076003)(2906002)(40480700001)(2616005)(5660300002)(82310400005)(7416002)(70586007)(70206006)(4326008)(83380400001)(426003)(36860700001)(41300700001)(47076005)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 17:21:39.5051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4859cf62-c78f-452a-c939-08db18e71682
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C405.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4105
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
index 4fa26b9a3572..6b32c90e9e20 100644
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

