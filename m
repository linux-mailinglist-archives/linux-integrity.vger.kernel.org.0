Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB2F6A47C6
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Feb 2023 18:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjB0RV2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Feb 2023 12:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjB0RV1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Feb 2023 12:21:27 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9495622790;
        Mon, 27 Feb 2023 09:21:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ir+GAIt1s4cNBzE2FBCI2LTkpg8PWlJ5LCSlJz/w2UDRcrUn5VbKnv8Uvp6mDfboFi+dT9qihHxnMeP2CAth5NfSZyNxs2RW4MQ7rFkkVrVJsgzo12Fc+xj6G/hN7K3PsousvNUnt+gdq+XEi6Rv1XcXOrQvtgddbtlkgtKafb1Si6TO0fq6Y9lBu+zPTpXzpxyVZsCx2FkJF3w+4XHum6AfbOOci1R++jD//ttpJ3A58Dzc3ghr5S5l5dG1dml6KX0iQ9lnwDl4uEGXALr6zV+AZxKGG2XqNfI/W0Dt7H91nxJRpNvV2kTpKq/7EPkwNCh5bV84Nk0Xq6JoU5Ni7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWyR9SUzmlm1JpWbJSgfTsjEp3U/GqLUSExaun4y5Kc=;
 b=GVsaP0jc3pHu/AN3pGhOeCLML0xBml5hgsJozsgbIdYoARK4C4cG3CWZvpoxXfEdY4NfLVuL3O0aeCYE4fbaPeMaQ81uH3WFXcnCIaOPx+KhUvtE0I5vAHJcx5uAs7QBL0MreZ3q4jC578gelzEGVPfOG4DXQnOzBDGBQPtWKeWyNEs5rEaYqMKBZU+AVy6BSvR1rgHqNF30wLSO3Jc8cZcrEuDQ9DqwWFF0zjUnLxQfdKqAVzHF1Q08rJyd//+hzZasgLz5r8y5UU8KMtx+hFnBcgemVNpvewkahUiDMVmf9VZCDM4gjLEsCuYEcb0ObkrY0OmL3wlxcHr/SFzu+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWyR9SUzmlm1JpWbJSgfTsjEp3U/GqLUSExaun4y5Kc=;
 b=e3hAlTJTlnuOkSYI1BGxghUtdI6IVawZ8zK659ecK+XvugQH1zE+32V8ATlLu8mg7Mf7tBTDxZFBaYqbPimkp3th2/aRjRYE/DsoDaT1oAHb2m5r5mGmfpcJaoRKYu1aaBY5p0R8dHvrfLNqA9l70kyqSAF5R46X72QEQJnDgvy7rx9Vf009Haf5NAu68ia/heW+yonP3nSpkgO1ASUgn/3qqYu+G1ZmO2IB4iVKCkPFRNni1SblsCqtNiE2hOUKQqtcBYJPbL9L1if9X6s4ADD2Slyd+udzQYFeHYh/0kczdGAMXvNKTSYPpao30/yrshOanSq2q+7ZYXCICWC17w==
Received: from DS7PR06CA0012.namprd06.prod.outlook.com (2603:10b6:8:2a::22) by
 DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.29; Mon, 27 Feb 2023 17:21:24 +0000
Received: from DS1PEPF0000B073.namprd05.prod.outlook.com
 (2603:10b6:8:2a:cafe::31) by DS7PR06CA0012.outlook.office365.com
 (2603:10b6:8:2a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29 via Frontend
 Transport; Mon, 27 Feb 2023 17:21:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0000B073.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.12 via Frontend Transport; Mon, 27 Feb 2023 17:21:24 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 27 Feb 2023
 09:21:23 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 27 Feb
 2023 09:21:22 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Mon, 27 Feb 2023 09:21:17 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <robh+dt@kernel.org>, <broonie@kernel.org>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <jarkko@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [Patch V6 0/3] Tegra TPM driver with HW flow control
Date:   Mon, 27 Feb 2023 22:51:05 +0530
Message-ID: <20230227172108.8206-1-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B073:EE_|DM4PR12MB5167:EE_
X-MS-Office365-Filtering-Correlation-Id: 293bf0c4-b311-4da8-8224-08db18e70d7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O9teTn+sJjXfwMZGjUYuLIEG95KA2QNXaH78rvuKsHS5QBlTd3z/CdTLqCuOgVExcR4U3eO07k8Itiwtkx0fb/e+BgaZ3+kuLyLZzpfQTIEOYDIXSIn4OWnJv65zUZZKYVwEb+kFx7ESZQrRo7j4wPhICRNS0vd29Nn63dHizmFEPmzAp9bezX6w6q2ERcZssraIqZXymoDQIRyxMKaSd0QsU46TGtqTJOswKYBuzKt7x/Uq8rTLDxSJccqtvUXqA6E7E5VD8m7F00veFJt7Ki4KfztB/BXAy7kys7uVNsXtFDiS/kRxi1fAN6x/tCVPZg/z3nEwFrM4ccLfGzW8h/k3g5UdJlLi6z2xp1gu2WLe6U+b/MfTqQ7S/SWOqTwuEgN8W9H7jraYi53V4c4IhSYSHOPDCF7gjO4qS8P1oDz0XrpVyeb59unYyYH7y0Yrs4R1SSA85f21ieu7lODd4PVnbERWH8QXwMQOT8xxchdoVuyM5pJYT1yP2eml+pyIsmyQt3V1RaLc4Ci2Hy6ep1gMYRE6WNhbPuabdM0F9SfNfT7pOTCvx94zTdNfnTWCnAqbDhG0fWnjaB6R90yyCZROtajxB+elgw2NMq/s+jF7tWWRZgyFEP4Ijquh0KAK+GZX4Ca7QV3UoSwr/VM291YG/hCSmoEqJ2GPlw37RnHyxNc12DJtFOVN8TT6alVHFE8RbBlMf14nxrkBiKm3xwur2QFvJOqWsfsFo+T0j+KplSI8OzNfV407y48uw8EcSGHQWRPVAzz0fB/AFdJHrw==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199018)(36840700001)(40470700004)(46966006)(4326008)(70586007)(70206006)(83380400001)(36860700001)(41300700001)(426003)(47076005)(316002)(36756003)(8676002)(336012)(7636003)(54906003)(110136005)(8936002)(82740400003)(7416002)(82310400005)(5660300002)(921005)(7696005)(86362001)(356005)(40480700001)(478600001)(186003)(26005)(40460700003)(2906002)(2616005)(1076003)(6666004)(107886003)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 17:21:24.4270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 293bf0c4-b311-4da8-8224-08db18e70d7c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B073.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5167
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

TPM interface spec defines flow control where TPM device would drive
MISO at same cycle as last address bit sent by controller on MOSI. This
state of wait can be detected by software reading the MISO line or
by controller hardware. Support sending transfers to controller in
single message and handle flow control in hardware. Half duplex
controllers have to support flow control in hardware.

Tegra234 and Tegra241 chips have QSPI controller that supports TPM
Interface Specification (TIS) flow control.
Since the controller only supports half duplex, SW wait polling
(flow control using full duplex transfers) method implemented in
tpm_tis_spi_main.c will not work and have to us HW flow control.

Updates in this patch set 
 - Tegra QSPI identifies itself as half duplex.
 - TPM TIS SPI driver skips flow control for half duplex and send
   transfers in single message for controller to handle it.
 - TPM device identifies as TPM device for controller to detect and
   enable HW TPM wait poll feature.

Verified with a TPM device on Tegra241 ref board using TPM2 tools.

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
  tpm_tis-spi: Support hardware wait polling
  spi: tegra210-quad: Enable TPM wait polling

 drivers/char/tpm/tpm_tis_spi_main.c | 92 ++++++++++++++++++++++++++++-
 drivers/spi/spi-tegra210-quad.c     | 14 +++++
 include/linux/spi/spi.h             |  7 ++-
 3 files changed, 108 insertions(+), 5 deletions(-)

-- 
2.17.1

