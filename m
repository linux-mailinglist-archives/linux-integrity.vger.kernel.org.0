Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECF76C9014
	for <lists+linux-integrity@lfdr.de>; Sat, 25 Mar 2023 19:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjCYSen (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 25 Mar 2023 14:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYSem (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 25 Mar 2023 14:34:42 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10hn2216.outbound.protection.outlook.com [52.100.155.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CDCC654;
        Sat, 25 Mar 2023 11:34:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QombX+HFoVZDDQsaRJviTqkrCpqSL9SVHSrf3cp6NvDGQmyOZ0amhv6cjHZiO71X4clVZocsp0kFsacP4K5NJMFy204+8j+wy8h5R10Y2I/AEppbl+UArqTJ9ehwahoTqmkY70jOCAECI5HDLK08ZIzU02ZUfriSxy9Pxyte9yJzb8cnmvcWp7mkz7DRrmgZbhQFevfPG6+USE+iBX5dU3uzIuMTkeBymyRtnJzjCiCxW43fbG4j8zqJBwh/q8bSeHSTuiOFJSkjPRW1CckqDxUijQtdoQUr3FGCgRynR9+BdjcakcfbqG0fdgplAC+A4tzSJIPco4H+RcA6jXczVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJ3wVmLNdM5fn9qyy+bnZhI7KlWGYQLbb6I8VBWVtVc=;
 b=BtNLkqjIPYmLznAXZT6IBJMh56d4A5GAD3puAB/TZGBmZVhfQe+LMPp1cLFMOBMpmGERa8aBopZN7YGFAqhqTwDLyXa+LeIKVfaCzlegEJjZNEFliOw9O+KX1txYPxNDpQHQLI9/IgAYktkFEMeSDILnYK/kv2VZrqyaEZW66Rpz1Fg+sI2p89ft3+4jf2kw1O7pS5uJ/1olCQjMRfGSdXTywTQlCYMcrAcP9CKPn0/OUr9NttEX0/QqyoRmQZf5MggvtVzzi0VJFpLRvrh4EPE9nJbdmhbhUyxdV2Iol4Hqv+qDpZn1GJUEd/7mPgKiLtWQO72KPS5DuvHYwzOdcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJ3wVmLNdM5fn9qyy+bnZhI7KlWGYQLbb6I8VBWVtVc=;
 b=E1WhysXrDkkERXIzP5uWo60HHnhRZ5EdaGn7+s97nMqAEUgdMoQUdYoZ8b3QvD1J/fcJPbuxLMEvt6QYz2tilq9cqd8vEWHcoMNuv7vKBb11UfpIhktT1FJEIv0OqzA57+lsOIgfZ0T/CGyx88sNEjSWKDlaTZbzLDsrpXZVfSNRGyUCAx3+tjCxH3Z5wBLh0ZpqTX4I01Mdo3wAISz4PYh5T+upORzTOnCpiMVYZHmwSiZRlyHNwozTgGLuyexSo+vohj2o/GU5NL3wNTd+HouYL4GXOmBRt5pS2FODPjewzdEXmPa+CBxj63u97kxfCDr9K93xlIATc6NHLrgkzA==
Received: from BN8PR16CA0002.namprd16.prod.outlook.com (2603:10b6:408:4c::15)
 by SA1PR12MB6920.namprd12.prod.outlook.com (2603:10b6:806:258::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Sat, 25 Mar
 2023 18:34:37 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::ac) by BN8PR16CA0002.outlook.office365.com
 (2603:10b6:408:4c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41 via Frontend
 Transport; Sat, 25 Mar 2023 18:34:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.22 via Frontend Transport; Sat, 25 Mar 2023 18:34:37 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sat, 25 Mar 2023
 11:34:36 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sat, 25 Mar
 2023 11:34:36 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Sat, 25 Mar 2023 11:34:31 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <robh+dt@kernel.org>, <broonie@kernel.org>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <jarkko@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [Patch V9 0/3] Tegra TPM driver with HW flow control
Date:   Sun, 26 Mar 2023 00:04:06 +0530
Message-ID: <20230325183409.7695-1-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT049:EE_|SA1PR12MB6920:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bf41ce7-3968-4366-859f-08db2d5f969c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2EENQu9KWwoZJxmeXv0PLHh30NwEu9hF4fzglmfBkmeq+EvHAyqKZBSGXnDSzq8StDZbxw9BcfiLX1pQRY9jfQrQzwbsrD4vNu/AvR6hL8OV2TG0K9HIiEMjawNzZ4Qg9LyDbam3GHBhlBjWQxEec8GjLIYbyUT3b2VmO20TFY8YZniofqdbfdOMqWMBCrXLYQZoEvTICPdMefYyTYfDKDoqiAmYijCjjM7zrV2cTh3SPgjvHH4qyzkVSAOvPbg9m44sSHK/wzQruRhFVwqpfJVAxQyJVRNlpBBBAunI/1oWJSJMR6dbvQZ5WG/l22Ct2HtlXPODJ7VNBMPJbbXDQdMIbN6bSc4RzLLj9/vbck0lwc+HRjYG2Rgjw5akYLP08J500vVisoUH95QcXMRd3hCmVwpPRxzDMF1TRTSPqjixeJyRWydmMPMP2xeoZ0whqT58BmGEUYOit5hsMxyceMzMRDAAgsYRPYD1QuiW2gDRhbrZ/mr7vz6Gx6eKuF/xY8mXNDoDdoXAUdMQ2DewJNEc8DOYy7g3rwy5oLBX6uAWZYsgCSRhFi1WyL3VHnxLKKjcG76Uf4wqagUcasjM4J//Efek4jGsdKWY3zbMxCbZSRFoWwPhckmVyPue44Nr+14Gj8bBd0RB/ER5l18r9Cm1xLgwonuTVEWRw/nVBywvdQFDy4Hp1ScaFy8BaKaCGcDlq/Gk60wr47EJjs+p7r7Hl5U1O8eEt2YsbH+Nts08b1R5c+ZfgigtxtGKnuQw+ik3zFCdroBFu14DqfLwyzO30B7wwY1ttZTn4XOUwayDGXHv4m0jmi2m1/tsJsSh1UvDGQpnkkBKy3LRGpoxxC5xEpCJJB6KlyMNd7UoK3BymVVGGsBPY1wD6KX/wGsc
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(5400799015)(451199021)(36840700001)(46966006)(40470700004)(36756003)(8676002)(83380400001)(2616005)(4326008)(426003)(34070700002)(26005)(1076003)(7696005)(6666004)(186003)(478600001)(40460700003)(336012)(82310400005)(110136005)(86362001)(7416002)(921005)(70206006)(54906003)(40480700001)(356005)(316002)(41300700001)(8936002)(70586007)(2906002)(82740400003)(7636003)(5660300002)(107886003)(47076005)(36860700001)(2101003)(83996005)(12100799027);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2023 18:34:37.3009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf41ce7-3968-4366-859f-08db2d5f969c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6920
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

Add HW flow control in TIS driver and a flag in SPI data to indicate
wait detection is required in HW. SPI controller driver determines if
this is supported. Add HW detection in Tegra QSPI controller.

Updates in this patch set 
 - Tegra QSPI identifies itself as half duplex.
 - TPM TIS SPI driver skips flow control for half duplex and send
   transfers in single message for controller to handle it.
 - TPM device identifies as TPM device for controller to detect and
   enable HW TPM wait poll feature.

Verified with a TPM device on Tegra241 ref board using TPM2 tools.

V9
 - renamed tpm spi transfer functions
V8:
 - fix compile warning.
V7:
 - updated patch description.
 - TPM flag set in probe.
 - minor comments.
V6:
 - Fix typo in chip name Tegra234.
 - Debug logs change skipped to be sent later.
 - Consistent usage of soc flag.
V5:
 - No SPI bus locking.
V4:
 - Split api change to different patch.
 - Describe TPM HW flow control.
V3:
 - Use SPI device mode flag and SPI controller flags.
 - Drop usage of device tree flags.
 - Generic TPM half duplex controller handling.
 - HW & SW flow control for TPM. Drop additional driver.
V2:
 - Fix dt schema errors.

Krishna Yarlagadda (3):
  spi: Add TPM HW flow flag
  tpm_tis-spi: Add hardware wait polling
  spi: tegra210-quad: Enable TPM wait polling

 drivers/char/tpm/tpm_tis_spi_main.c | 91 ++++++++++++++++++++++++++++-
 drivers/spi/spi-tegra210-quad.c     | 14 +++++
 include/linux/spi/spi.h             | 16 ++++-
 3 files changed, 116 insertions(+), 5 deletions(-)

-- 
2.17.1

