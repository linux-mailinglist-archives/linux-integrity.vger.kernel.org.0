Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3816EA6AA
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Apr 2023 11:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjDUJOC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Apr 2023 05:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjDUJOB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Apr 2023 05:14:01 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10hn2229.outbound.protection.outlook.com [52.100.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F84BAF0F;
        Fri, 21 Apr 2023 02:13:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NoJ/uR/xTJXp2ZJMPT4c8KrUTf0784pEHeO0xapyzV6QbDLa8i/eQCP1phZSAYxC/2wRmtgj5+xdJ0duNRmw01FYNSIxnsk9OiZxVYJMBYvOG8N5XokMLUd2mhLGSuTDa9okTLfqp7eot/CnCoRUzCsDV0QZVtdrBkia0CtKeF8z3UStMdDKAF/FRwKIkGOmh57cdNQ4xEAQiTKzwMhEBU7vyVS0AVqn2UcPpFAxjsmUGAhZRV7yseJE0lqSWGapzxB4dKmoV1YkJBgUz9hHfWlOQ4B3yhVFrpzmdSA5CBtG6wPquugz8zMiET920al2aEMMUbqp/v1TCFyiUl/lNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDEXG2aOGP5HfveanhYkpEt+gV88x/8/T+EHM12vP5o=;
 b=S0Ur78eGoI3Ziq+qcc2Q5eF/9k4faIrClRJQppbPW2D8W0hGgzl3cyfVFDVlkdhH7HBUQSXPaRqngQDB7V5/8mwG2NevCYKXN9kIb9oUQuyKXxtgbv27sGZ6bZkFAWC2VxJtkMREGGWtWRVEI+btWayq7gTA+KqXX/3y8t+rXDGS7JNTKjpGxyzaabIGZFSkSueGVNQXVa4Z+XiNI+S2hGabS7mo/tknTM39fTIq5WXEjkRsF9ey8L/Itr/zpx/47sNSMnjEhyXXNk/fSxnImksGoDqmhaxQvX2aVNVN4sWDfvw9MzhV32US196LQc8+5FfKyEEKpfrmc0eyrN6bLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDEXG2aOGP5HfveanhYkpEt+gV88x/8/T+EHM12vP5o=;
 b=mtHKhxoeYEqfRA4u/WPviNer5bMIiPKSSoX97CAIii7iR56MwdNffqHBTAS7qNaf9i3S73ZKsZxsRI0MFCClUAiCsb3QL5qUA1S+QT0YxhkM9MHtKzBJ7In3JkWYVicowBF1NpJz3NUz5WXshIm1ns8v3ZMTQC/F/DKmezBZTT4jXwvzYyD7qEQk24wyZhJINp7mlIRr99W0S+tlZNtQHzIj/aGJzHukFJEfXLgFVjXIn+Zp8Bwg+2tRy4YyGAkx+Uabf4eEQPuEgdMMgxtJBZN8eWaQklRfEgCfmlKhZzawqoWlPvPXkll8YPmj0OPJO8W+VD4lVpYdcenf/FLS4Q==
Received: from MW4PR04CA0353.namprd04.prod.outlook.com (2603:10b6:303:8a::28)
 by MW5PR12MB5683.namprd12.prod.outlook.com (2603:10b6:303:1a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 09:13:41 +0000
Received: from CO1NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::7) by MW4PR04CA0353.outlook.office365.com
 (2603:10b6:303:8a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.27 via Frontend
 Transport; Fri, 21 Apr 2023 09:13:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT115.mail.protection.outlook.com (10.13.174.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.27 via Frontend Transport; Fri, 21 Apr 2023 09:13:41 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 21 Apr 2023
 02:13:34 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 21 Apr 2023 02:13:33 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 21 Apr 2023 02:13:29 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <jsnitsel@redhat.com>, <robh+dt@kernel.org>, <broonie@kernel.org>,
        <peterhuewe@gmx.de>, <jgg@ziepe.ca>, <jarkko@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [Patch V10 1/3] spi: Add TPM HW flow flag
Date:   Fri, 21 Apr 2023 14:43:07 +0530
Message-ID: <20230421091309.2672-2-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230421091309.2672-1-kyarlagadda@nvidia.com>
References: <20230421091309.2672-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT115:EE_|MW5PR12MB5683:EE_
X-MS-Office365-Filtering-Correlation-Id: 98ce3719-bf10-4a3f-1449-08db4248b336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IT5HhZyCJJcu+IdTMyWB+tFy94erBtNhz5VdM98Rxjxo2tQRhOPs0m9YdxiByKLRT135AqVH3clxtH0I2YrLUpk6J8pv2mgwYyO+QQwVYkibNnPJM1Po15QPGS8NODU7xlYH1drl1aHRAKKiqLwHHCr9edOM4A3j60AwtTFPbENbA0PxEppmbrhQEtT8NmBYKCZ7kyoilHDKxR5+fihMd60MPlkmX2vKlW5KGc+SvYEPmaHXvPZVEgH3brz7twa6GtKD4qfUxhKUAVc5I1/19YE7MlIRSe4VSDxV8QrqMidOpg0MLK2SROfw2LhrVFbc9Qw6tCM4b9maeHI8qnuDMtPB8H+7gdVBFi3+c9CYSt9FbrMCeBDwZyf96DTknj7Y4Wxt1kQuvs7CB87IpkbrnxhQbqLg4xaVsVTo3EA0cdDIkDtnOfXSgiI2akOOiEQrSpWHXa4KATCi0+JP9iaLKWC0UowK2MCjFJ3wK6zpavkHyrcahkKUdAen+tGsvIg+HGAu7hj3grgGZN83bJvoyrjeiU8gyH89udxM/aM20+zZAvfySF9cLGtFPY4I8R7yCKzUaTzaQjtJaIa+gMyUMF3PXlYSA0SnLY5TNu+sQrG7qLTfN86QXr9+iub8ryUfhdEGNGRtEXMqmBK9/r+FVwyKSa6GMU3PLQyGG4HpZwMmHvWIBLAvPMxqYB+AlkGxX8xIW74YBTJ9dun2VpkvzZW9zr0nZEeHXg/+uyx3umbJiDR02CmBf23XuQO1e1hvjofieXRkz1Sl7xsXfa4SWRI8YPujEJPKLnKvo6kYtRdqvYESplCEY4IjehIIKGZrDrFXYHp8K7o0FIOzUjdU6Za4uYrakBKtNmotKDUFnFO38ehCtAJjgMyQjS/3RzdRBXrAQhaKNThY/LoIsKTbv6DZfTAbexyfZjqn6wc/OEk=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199021)(5400799015)(36840700001)(46966006)(40470700004)(966005)(40460700003)(107886003)(70586007)(70206006)(4326008)(316002)(110136005)(7696005)(40480700001)(6666004)(86362001)(54906003)(82310400005)(478600001)(34020700004)(5660300002)(36756003)(7416002)(2616005)(8676002)(8936002)(356005)(7636003)(921005)(82740400003)(2906002)(83380400001)(47076005)(336012)(426003)(36860700001)(41300700001)(1076003)(26005)(186003)(2101003)(83996005)(12100799030);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 09:13:41.4020
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ce3719-bf10-4a3f-1449-08db4248b336
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5683
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

TPM specification [1] defines flow control over SPI. Client device can
insert a wait state on MISO when address is transmitted by controller
on MOSI. Detecting the wait state in software is only possible for
full duplex controllers. For controllers that support only half-
duplex, the wait state detection needs to be implemented in hardware.

Add a flag SPI_TPM_HW_FLOW for TPM device to set when software flow
control is not possible and hardware flow control is expected from
SPI controller.

Reference:
[1] https://trustedcomputinggroup.org/resource/pc-client-platform-tpm
-profile-ptp-specification/

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

