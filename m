Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02C46A7223
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Mar 2023 18:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjCAReQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Mar 2023 12:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjCAReP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Mar 2023 12:34:15 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCDC22782;
        Wed,  1 Mar 2023 09:34:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tc8eKmINbzOZJK4awpuARWoh5XmgTVagOIh0kE2t0XQhXMiU8qGt+txXuCKT1+5gYJWyL3K0OBweQCy0XbPivoZkaCkqcJnqWT4L7cgXpn2JttvWlx7oeb9SpMSTiH/sAuUmD57B79yRG0S2ck36CZhV6MkrpRlYwCcWwrLkacp7yeugz8PCx54aztBLIJV001YJRMtBPSylrKNGNhy9tarfdK8n98DAtKIS59sNbQplJawXeLeqo3YuSskkKMVHSx+yymFhckjiAvnWPxZmE30NqDxFJ00gxggcd0Eh7aI/vN/dJZjEBKLGnRO5luS9RCRhHhkWxo97q53a5WFzhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBpqDaMkEVmKXySxVI+2HjWfAB6R2pwtHL+AmuLzPW0=;
 b=V1y5mFQSTxiAmB+zI6QEuGUdt74xlFSx8aUW6UbfJ5ZNYl4s+NFfAtUm+Su/TcqYenFVZJvr8DDcTObmoMAPLkOxYtNy5BhBfPenvZPAH+CKqZeiSMw9gRoyROFuN57PNksQ8w8QlQ0bP8Dfr1zCrZ45bSm53Tzuha9rsCVSCC1Wvt29d11y8fLJ9P8XARVkF+LBL/5YLiCFUQ8I36e4kq3YAPdUbH6hTRhqSZus68c3srY9OZoufUPT1HAVWvSdf7okObtEeK6eLESHZcnZTEcRF18yy7SgevC0I9Dx+nakv261Xwwzc5Webl1EnD/32H7ngRlkfMQIYh2ET4SPOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBpqDaMkEVmKXySxVI+2HjWfAB6R2pwtHL+AmuLzPW0=;
 b=gBX/oeiJoxq1rNNtd9gZ5mWrPZzo+ZFNN/iMXMyU5nV4oAVjTKsDqCzw+B83lVi5VLHGk8AHQ9CJ1fJxaEfOC2YaAmrIw9OSpZjym3cWBGzRX95kDu/7xXWa0yL2o2F963TURVQo4sYRwuPUp98nLJTOKoBR9FsSahivwrU8IIussu/0EdGvbgQ3lM6VH4y+6CKrsQsnRmSZTvDD4u0ayw37sJ6F3QJZ4dQZCx2MhT9CZ90TJPbC+flXWUMkVmhd/hd2GwJ+reW5dk9zi+EWYyAxlSv4jwTHSwpaq5yHEIgUg/egtHuBu7exLGkuuInBHfhI/PEJ8h/ycwH182uxgg==
Received: from BN0PR04CA0166.namprd04.prod.outlook.com (2603:10b6:408:eb::21)
 by DM6PR12MB4402.namprd12.prod.outlook.com (2603:10b6:5:2a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Wed, 1 Mar
 2023 17:34:12 +0000
Received: from BL02EPF00010206.namprd05.prod.outlook.com
 (2603:10b6:408:eb:cafe::af) by BN0PR04CA0166.outlook.office365.com
 (2603:10b6:408:eb::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18 via Frontend
 Transport; Wed, 1 Mar 2023 17:34:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF00010206.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.12 via Frontend Transport; Wed, 1 Mar 2023 17:34:11 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 1 Mar 2023
 09:34:00 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 1 Mar 2023 09:34:00 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Wed, 1 Mar 2023 09:33:56 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <robh+dt@kernel.org>, <broonie@kernel.org>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <jarkko@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [Patch V7 0/3] Tegra TPM driver with HW flow control
Date:   Wed, 1 Mar 2023 23:03:50 +0530
Message-ID: <20230301173353.28673-1-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010206:EE_|DM6PR12MB4402:EE_
X-MS-Office365-Filtering-Correlation-Id: dc5fa5b4-b4f6-41db-a7fa-08db1a7b2ba8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QdyGX/Bw6aAI1euTKcTOhXpWYyA1oVM5Tlb2YdtP6B3buYvqVCkZYphMvnBu7ashzeL3DvMvzrWGgbvi2wAgtOMjjT+1u5yVQWMFEDR8277K7Edxi59iieqf2m4SRlaJS9Iu7QOQp8Y6ZVqRoDZZv2mIofTkkNseOSDDsS2ov7QqM/wNfsuJQDPmfmblMJqYjWvtbVWlOgebjPG+Yv40guxuiZSJ+rS9Y9gR+sh9Poq6ddqrwvD1R1NpJsJWJtM+ySaVjS3n8aEVswaghqXkerBPwQGra97mXau+2EkcEVociyX3FMKTgaR9oil+yGYdx/5G5tirwQu9qxYBGPcc1KIitJOeJJVdg1pZ7e73wx3lJxRjGMhvlG5rWPnElTyliHPDuRWyeI4Bsbfqha85SLGg0jpSXSqSTD4vzWVPMpWkhFmnBTGw09m6lvQI1Z/q7HCvWiC7WhJDLDRornurZ0VKdgIRWcBCXBw2BcMcRZIH6/mQhV9OTTOIh7gnKk/Wy4qZweJ9IVfjDXYaQOpSEmb5TbkLHmwOVBCmnqNCO6XwK3aL8x1YpyVBkO+T+JcecPZPmjW6wrwgZJ2UgJcydZqjJlRMCQL7zpGFIrCSG0mOclTPPxAToFOSKoi/EYBux3k5bHtU+a9oEEWSbEO/5Swsll9S4woLnXL3VguadezRbpOYYJ90SEvXs66HMDJ3TTaubq0Trwmersh7wlpwyDkizPXNU+V1AO4XCrMWjFwS14vfWqzUfFUWoMCqsJTav2JgrEuIL9r96BboIx7Pnw==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199018)(40470700004)(36840700001)(46966006)(36756003)(82310400005)(54906003)(336012)(426003)(110136005)(478600001)(316002)(83380400001)(47076005)(107886003)(7696005)(186003)(2616005)(1076003)(40460700003)(26005)(6666004)(7416002)(8936002)(41300700001)(2906002)(921005)(356005)(86362001)(70586007)(5660300002)(70206006)(36860700001)(40480700001)(4326008)(7636003)(8676002)(82740400003)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 17:34:11.6955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5fa5b4-b4f6-41db-a7fa-08db1a7b2ba8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4402
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

 drivers/char/tpm/tpm_tis_spi_main.c | 96 ++++++++++++++++++++++++++++-
 drivers/spi/spi-tegra210-quad.c     | 14 +++++
 include/linux/spi/spi.h             | 16 ++++-
 3 files changed, 121 insertions(+), 5 deletions(-)

-- 
2.17.1

