Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EE36A7A68
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Mar 2023 05:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjCBETV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Mar 2023 23:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjCBES1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Mar 2023 23:18:27 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11hn2237.outbound.protection.outlook.com [52.100.173.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264542CC46;
        Wed,  1 Mar 2023 20:18:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8X2wCkkQlidvUsSIrVCiNLWJfR8kgXCtUhtaujkjRfCRP/FQK9Zz/IB/SPKtOoly6j9adnskvN068lOsjxJkIxXSyozuz8Q/HOtBjnGkgB8RcmT2PqCxGVErXmqOTez0dP9h5xmWQRDscdwB+AmbeTpvDIZQFqPowgb+vUPB6dI2u55NTPpTSeV8oNNAamXHihW+5uslP+MQB/gnxiIn701xn8/iKrcHnQG2EAHsrGUdv56A0qhgtoBlKhuGDT0yOAIZRUEdOS96G21+oweGq9fkYvjRZRlRCecKTU5u9IdPdaYOoazlh+4kyLiD1V9ADFLHfXPn+oF+rTUb4UvgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mh9Ua9+PFTGOWRtWUmLN86IqbLOmxsmrJzCJu52I840=;
 b=BDIrgOwP0qzZaJ1IYqV2SB7p3I7L2Br1uNx5arrO7GMpj4W/YQToPPHG6vqAl+277LTUa9gxCkUPI9aODENs2fza2LbNcZxJr+LJEGNFqGJGurdcaeZlvPV8B2OmW/e5axV8XnpzQf0yBupdh9RLPh3Jmnern2pwDTF0F4Rxpnp+zw5hDXmkc1mxFf8mCmX2auvYEdeKPEPIQxsr7z1BG86PG8Un5yRIlM5ZgaNQ0T0zBPDQgzdVg+HS7JXlEbrgG/jyfiHkQr7hffRte8II6FH5Y6V7QVLKIQaezlKlMclCpn/D1orVqapDqnUfWQ+ybRWPHXRF+jnu6RYEzqWlFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mh9Ua9+PFTGOWRtWUmLN86IqbLOmxsmrJzCJu52I840=;
 b=QxXR7zeLZvzBcMVheyuwu1jgNyWPBAIRJij8a37T/FartXOIGSjvsrlRroUf8lY8xOWIA8GNB2YiVEBa9cGAGSYlqYBVDf//+Sb6CKkF2yoHT9Jn2Q+MAhUMagoaRgRv7uzCJS/FZLiITpANlGqG7eQK6/2dhSy7sgUxAI0d5oDQ1QPsUZ6/NxxdgVV6gCumxdOJkv6aSKt6/U6JoUa1peAD7gpBfwVoQq5txE8RJtYc8Qys9jMoZfU3QXp+Zm5BI0gZmYSEmzVqYrSYAKSeGs2CWq+h6XYnguZTVI5yJ9bNzzywOOFT1GzAWujMKrmss2hqaRP161vXaYTFD3uV9w==
Received: from DM5PR08CA0059.namprd08.prod.outlook.com (2603:10b6:4:60::48) by
 BL1PR12MB5731.namprd12.prod.outlook.com (2603:10b6:208:386::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Thu, 2 Mar
 2023 04:18:20 +0000
Received: from DM6NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::10) by DM5PR08CA0059.outlook.office365.com
 (2603:10b6:4:60::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30 via Frontend
 Transport; Thu, 2 Mar 2023 04:18:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT112.mail.protection.outlook.com (10.13.173.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.19 via Frontend Transport; Thu, 2 Mar 2023 04:18:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 1 Mar 2023
 20:18:18 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 1 Mar 2023
 20:18:18 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Wed, 1 Mar 2023 20:18:13 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <robh+dt@kernel.org>, <broonie@kernel.org>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <jarkko@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [Patch V8 1/3] spi: Add TPM HW flow flag
Date:   Thu, 2 Mar 2023 09:48:02 +0530
Message-ID: <20230302041804.24718-2-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230302041804.24718-1-kyarlagadda@nvidia.com>
References: <20230302041804.24718-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT112:EE_|BL1PR12MB5731:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d9e2af2-3283-40ac-027c-08db1ad527dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vYGHZYq1PeT0asEO6qY7LaevG+IrMEBGGfmsjqV6crppEZINvAqXfGaRvqcFB2gl145HR14xI/YD2/Snv25/URALufKZY7TPCCctK8ZodE5tGXprzVqMUAoFJ11uL90jBgbU8Uvu2Z9VnjB4TsfuNL9MunhGTmH0vIj3979kqsUMNkCgSB4c6ZINsstkGoPMMP624jhAsydP/wPUOTyqfE2Bk0ZFdkkqBNKIx3Dl7JlDMA+BHnD8s6QrWq3XZxJUwNpoD/qc1mV2DoYK6bIBgdMojb3uSIdOUJofmIN3qK+DmpOBxTqEQvCpxqeAooNnI6OKFXdXVoiAopIwn/QgnA7oBLCLZOXgNkAtL1mA1i485fL+YmNu31986uncm9S5xOL4dZomoH0kRltFFdozmjo6DVMtj2Cbfo68KzvfwCWmGW8fE9c0EK25Mqku7NdGXjO/IXdoKjjVUwoatt3GBIObHgNxo66m0k1xuayl9Fr421nRf3gDLtLhaO9LdCzRbJKngYo8efWJr7rjFmqrrGIu92WZzvXVBoFA5GT8pfIMqJAIn42XgGzhhxkPV4nBJ37VNn1BlWCMIRduKPgrmsmB2IzDzsZp2ljvrlv8Hc7cHidwtNjEXF3wYQo5Bc8MZ68BkvZz8nVaT9k/Eo0KrCA580UScQbA/ERX9VRL7n+M9wUHjU1vxE+VLs8pEZmA41ZER9HbTWVPnP+yVktf0pQXgxseiutRvLFVZpT+FJjVw78BTicHCl4j1nOWF8zD3+cu82K1SrOXuWMjGl32/ct2ow4/SUyEWWn91O6YBTi0sqj1ayq1Uk+UO00G0CvbinRbdURBqCpK+MnkuNWB4CUp7UW0kx1FwVoP1daUZMuJl7B7cD4bnz24ROIuMaMr
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199018)(5400799012)(40470700004)(46966006)(36840700001)(2906002)(921005)(47076005)(2616005)(82740400003)(336012)(426003)(356005)(7636003)(34020700004)(82310400005)(36860700001)(54906003)(83380400001)(966005)(110136005)(36756003)(316002)(7696005)(6666004)(40460700003)(107886003)(478600001)(40480700001)(1076003)(5660300002)(86362001)(8936002)(7416002)(41300700001)(186003)(4326008)(26005)(8676002)(70206006)(70586007)(83996005)(2101003)(12100799018);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 04:18:20.0580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d9e2af2-3283-40ac-027c-08db1ad527dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5731
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
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

