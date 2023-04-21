Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0846EA6AD
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Apr 2023 11:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjDUJOD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Apr 2023 05:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjDUJOB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Apr 2023 05:14:01 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA8FB459;
        Fri, 21 Apr 2023 02:13:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YpkX8iUw2vPd7+i6QIS5s1simCpzxoGmSNCNHcRhm67b0G6Z3fgoYoL0MgnoN4FTyHSp86uYds327tRFfdboEYkEWR42TLSgE7e8yxyuLVWMUrobPT8OVzvKZ9d9tOjAURYZ8AxotA/GqjYX3gLoi7ChcTY/UqZrxm03i/JumowtHELRHYtwNFOzKkkFP3R9V2mZy6iRLIoZCfeQMNmyhI0bpnbZWJx0CMoBpZBqK5XsRtAIAox8TQFNbamHD5QHk4S8KdMezyZEZ9EvTOF+G2QBs0ga9dg5a918RzlLvLRJzVnzNK8vrnOxaXA+JeebTzbCKzK7HocEUWAhiEFkJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBymlZELQ1LwIUGIMOnDuoWy9yoiLRYT/iqSZYI/H1k=;
 b=IV8dAYKrubT6cUSTjtKj2LF2tOPyvUW8H4zPP3hJFtk7brY3gHuWaYBuNF+IGorhNQGKZekG54G2BgUDIuYNnyIQsJaKuGIcWCzt5suplKEPcgF/IMzi9q3VfzZdk2+QOiJIr2a51mF0WBy0JlyjuOSEcsi4w39DQBLQ0xsREjay1j6x5qfyqXvGIjqX0c1qdTIHlFuYy8yUiAU6ZAI+aqJ/V/iD5wNL3XtWYIufuyxe0xfoXmNUPxHPCkF4kVIko8eYmRhBrjNE1lKFFMtVcxZBLOLwq9GZ+5V45uCl0o2z3UOK2FoJTa20TUdP7H9rf3/s4ocVweDHYtfikeu+vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBymlZELQ1LwIUGIMOnDuoWy9yoiLRYT/iqSZYI/H1k=;
 b=Z+95gq1Up2wzRAywaGddBcIM0GKzFtnLGHdbN3khLh/nmgcKBF+b/U+8lOR//1iNExzAHlj3lzQppsS4r+qnroC3Th2F1PYvEnC5iCRNsDsS0K1VlXijyjAWHZ8E+3re9EFrN4qy/BwptGLzFCezWxFt5lK113hDe5B9DuE49dvdK0jqxVLC1EXXXJpHFuR4yqG7ptfmLPX7k0S6UOj0exUQVbLws26jqy9jhwJbH9i0365D/ELDWp3hnUxOmSWffkPjM/3C2BDfX84hpG2TsdXQhZcH9+UizdY+wH4XYllRtFtBqrXl1Ew/I0vQWxUGGcF1uYniFipBgQGUZSXOeQ==
Received: from BN9P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::28)
 by PH7PR12MB7307.namprd12.prod.outlook.com (2603:10b6:510:20b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 09:13:42 +0000
Received: from BL02EPF000145B9.namprd05.prod.outlook.com
 (2603:10b6:408:10c:cafe::94) by BN9P222CA0023.outlook.office365.com
 (2603:10b6:408:10c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.24 via Frontend
 Transport; Fri, 21 Apr 2023 09:13:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF000145B9.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.16 via Frontend Transport; Fri, 21 Apr 2023 09:13:41 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 21 Apr 2023
 02:13:29 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 21 Apr 2023 02:13:28 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 21 Apr 2023 02:13:24 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <jsnitsel@redhat.com>, <robh+dt@kernel.org>, <broonie@kernel.org>,
        <peterhuewe@gmx.de>, <jgg@ziepe.ca>, <jarkko@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [Patch V10 0/3] Tegra TPM driver with HW flow control
Date:   Fri, 21 Apr 2023 14:43:06 +0530
Message-ID: <20230421091309.2672-1-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B9:EE_|PH7PR12MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: e4c616ae-6b1e-4086-1a9d-08db4248b35f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zMwC7T4t9G89tWPDHCYOCnpYbK/v/DP4AK7LtXzLT9EEVIz7lM/3KhCqof03g+KsOH4qgMdb+oNKFSZY8KwCMkaPcipZuo6IUsgE+Maekd76yI/4kFxhCTbUm3vMELygrdnMzRCXkkeiHtUk8aex/bX9WpyXmeGVaqlTEMXaKi0ViL4gUKSQmNEHE75ZywPRRAmaUmRE8Fr+k7fGLFcSjYmIEB6EUB9muK+tXHE/n1PJKmHt9rD4xiSPx0rhE53Sz3xeZf6uxEbOoxolAblcJsro4XvMx+0FKq/QqEmaX3AGr0g3Otq5cuplkOTc2biJMJ2w2z3zpx/RD7KbmlPQnryYIZkmvUA+0fQuRWg5Cpcdtn/FLZFIvyX8Y+gn6bCoavUf2zo67KZ4yFWb9eX18d22371sv66A3SRNONurkrZ0VnKVk7T+fo1Mw8/LVl9RHm1AdDHd4DfTxsV+ZoYnm6b1a4cfklG+AyEMBFpKWXtLJpoS8QuV9B/n9WetJpJdkmrQnMEInVg8paYVK45+qJjlPd8n7191si+ETq/LY3pBcfwFrba/SGHK8ggSPuG+2k0ysAjwjos9ZnuU8EIy07QNkPFE/TGLVPvDw9M0pCeAbuAOhuAQudwOwhilPi4WCF8zUzjEh0CD5jDMMIYT3ICyzmtMALL5LuLKcuxCnRT2XDvtapJeeIGoBRcEbU4+jySVuQPWjNbc3OeQuc+fVi7hX2BFlUe2iZRjJ8eTTEwHqLMobOClhEYhscHn4p/ZOax6vMeiGGRqASBuAtUMN0EJv03PybHg2AAvDBw0EWs+61m6cxYBFae8vzRCNs/T
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199021)(40470700004)(46966006)(36840700001)(186003)(86362001)(336012)(426003)(41300700001)(921005)(7636003)(356005)(107886003)(1076003)(316002)(40480700001)(82740400003)(4326008)(26005)(6666004)(7696005)(83380400001)(47076005)(82310400005)(2616005)(36860700001)(478600001)(40460700003)(110136005)(36756003)(8676002)(8936002)(5660300002)(70586007)(70206006)(2906002)(54906003)(7416002)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 09:13:41.5458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c616ae-6b1e-4086-1a9d-08db4248b35f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7307
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

V10
 - use spi_sync in place of spi_sync_locked
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

