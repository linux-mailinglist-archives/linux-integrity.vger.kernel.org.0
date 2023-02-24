Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB60E6A1EE7
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Feb 2023 16:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjBXPuV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Feb 2023 10:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjBXPuT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Feb 2023 10:50:19 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04hn2222.outbound.protection.outlook.com [52.100.163.222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6496CF2E;
        Fri, 24 Feb 2023 07:50:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FnPy0ri7TiLxRf9TCjRcNgs8Ch/EF/n9dxvC8ULmRGKA531Zg2jU5RcAeHEv9ClhAe1y5WDNHf7FfS1RTnLyYCf9R4vvfON8zsT93Pd0cUTcrW108PTy0RpyVnbLpukjze/fEGhk8w9FhHzllFl+4aVTJzsfIpKMdz8bxwckA7Onur1o6k65g8uOYll74UU2zC4sssvaWlCloUo+Tjngaup6dgSI6yu4zIokXB2aHaRR8auwEpHbcuELq6gKoVH2BdPaA29ubaU5HOLCuA9J9jibMYaWPXVkRKl/jBnw2UNSZIvDcn84vzDmKW03mn3pM8GQ838Xgc1bQm4aXGoseA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16STglZTI/DGYdzA7sqcyZCgku+uxhdaj2buTCIKCMo=;
 b=CZlDAlylNn6IYhA8kw1vCjdkxqCjHU+CEW11JjRv7XLnMoZ2DRRvQ0v0igAcC/gTBQ6XqbiB66w+3g0ujuF69e839H4AA+eLcPJ9FpzUdpuIbG0LRxJ1C5gMnOkLLpl+A74acLY0OYgw2Vh3ctcd0m0hWQo7wC2RBUNypCawTvZQWWEFAg7X7cMD9nCTCgaXE6NaXOPvsN+qWv9IVeFpmgvTPGq1Zo6OwLoYm1Uj/ip3GzvxxZ8d9hnQgwud3WDg8TbXbR1VbCPqZsUbX7KWQrxA4YJMewCsqymrnCfjt77MpATiKwvCYBzJYoPadr3qw6g6AKnFAI3D0UbbzJFGFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16STglZTI/DGYdzA7sqcyZCgku+uxhdaj2buTCIKCMo=;
 b=QWgAUzAjTqo9ajFN5EfLaaQ5VSVE/IWqc8AmD29Dlj62pj6RUqnTpemQzcUC0PVtnjmXEMUNRDLwgRjBPF2yiSY+AnkMWJgH8y+oIeG+dobrlMvnUcOVY+7hAppKSAkzTc7bKDUPItTeS+WAgvorVfaWMsQSBLnvF8TEpse6uHouQS4WfBHc2i44NfY1Mho538/ya/vqTQo7KTOT8vlOgeVU8l6MZYNZa0hAzZgg/CULQz7PecD+nC3WGNMUaF2ipG4JR89OIzFQh20386B7HFojD1Zz+lrdUR7ceCNvmnylprON6MpiyhLKFAqoCb+muhhjVgduTidWxDvIpM1anw==
Received: from DS7PR03CA0097.namprd03.prod.outlook.com (2603:10b6:5:3b7::12)
 by CY8PR12MB7729.namprd12.prod.outlook.com (2603:10b6:930:84::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Fri, 24 Feb
 2023 15:50:14 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::77) by DS7PR03CA0097.outlook.office365.com
 (2603:10b6:5:3b7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24 via Frontend
 Transport; Fri, 24 Feb 2023 15:50:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.24 via Frontend Transport; Fri, 24 Feb 2023 15:50:13 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 24 Feb
 2023 07:50:04 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 24 Feb
 2023 07:50:04 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Fri, 24 Feb 2023 07:49:59 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <robh+dt@kernel.org>, <broonie@kernel.org>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <jarkko@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [Patch V4 3/3] spi: tegra210-quad: set half duplex flag
Date:   Fri, 24 Feb 2023 21:19:41 +0530
Message-ID: <20230224154941.68587-4-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230224154941.68587-1-kyarlagadda@nvidia.com>
References: <20230224154941.68587-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT061:EE_|CY8PR12MB7729:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ca6ab6c-dbb9-43f1-b0e9-08db167ed175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1UqUkIAo4S7/DdioFOd0C8fxdYvwS/t9m0TqNI4kqX3SLsNYio37WJxhZObSKJDH+aH9n90lMXpiWY+lFXyixz8xD9DwPmbujjrvFpdraqx5EopUdPH1b08SER66jw+nSJam+SAlOMevs/4pKS194zFgAAn51DRiWvYlaCzdA4CpR3mq3XVdquC/cJOtmtSajoyDt/aA3t7wbEFW6tPzWBLvYdcHv1YUE0BE6AyHeCEMzKFPscR5oI/mYmBzdfolnR1e8n40fDcihG8mtfc775KwD5BPeveZyt6H/1BkvRRQ3LCvuqOwMqnvAtSgcBkBYTmrRrtjrwwL7oyFic78MuDz+GtxoWIxoYNvCdoOTbNWMYiignmMu4EOR0fvq4cU8SGh9lXAqMHWJ2OxDp2wC3bAQoWE0qCb2WdwbFlgsN6bRhrTV8Q3V/mMRhSFuumkDjDZP4G8Nr9G5JcIecNEShOVGEIechBp7jsQqLVLgbAEQHBSjjJdzrKFfq1JX3zIzEYZAuNWwq27NSt8GViU7CAicwg1weeIgbtGmyWLCa++EX1/5nCefmkCekgtevhRqgUcYzTASiiUA3ILFNXVbAjDOk55yy3cNC6TAxaDA/GdiXyEARS4MVm5rpZKYNQxuIU4JxfR6V3UOXixXqSY7k0OIZ2F6Ha38X08sgTgrz44mjoGWt17psH2pjolzst4Dun2CjgBCy4/aAdH8euyBHXlMzoFeOCN/kGlFOeHuxNtKzU4EaPsuqDZlBVK0A8/1o057p7iatoKJuXpDthfvg6SZmaFRdyI5zhrXfO7SsL56YWWakkWMMS6jufH5mvTBF1XKxEF5KB7JV1jG4gWmQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199018)(5400799012)(46966006)(40470700004)(36840700001)(83380400001)(41300700001)(426003)(34020700004)(47076005)(36860700001)(70586007)(70206006)(8676002)(4326008)(82740400003)(316002)(186003)(36756003)(26005)(336012)(8936002)(7636003)(54906003)(110136005)(2616005)(5660300002)(82310400005)(7416002)(40460700003)(921005)(356005)(86362001)(7696005)(478600001)(4744005)(2906002)(40480700001)(107886003)(1076003)(6666004)(83996005)(2101003)(12100799015);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 15:50:13.7492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca6ab6c-dbb9-43f1-b0e9-08db167ed175
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7729
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Tegra QSPI controller only supports half duplex transfers.
Set half duplex constrain flag.

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 39dec2dc161b..fe15fa6eecd1 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1553,6 +1553,7 @@ static int tegra_qspi_probe(struct platform_device *pdev)
 	master->mode_bits = SPI_MODE_0 | SPI_MODE_3 | SPI_CS_HIGH |
 			    SPI_TX_DUAL | SPI_RX_DUAL | SPI_TX_QUAD | SPI_RX_QUAD;
 	master->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(16) | SPI_BPW_MASK(8);
+	master->flags = SPI_CONTROLLER_HALF_DUPLEX;
 	master->setup = tegra_qspi_setup;
 	master->transfer_one_message = tegra_qspi_transfer_one_message;
 	master->num_chipselect = 1;
-- 
2.17.1

