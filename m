Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCEDA6A7A69
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Mar 2023 05:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjCBETV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Mar 2023 23:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjCBES1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Mar 2023 23:18:27 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10hn2247.outbound.protection.outlook.com [52.100.156.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CEA20543;
        Wed,  1 Mar 2023 20:18:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGqesmmGU0F1dx9NI3B8JYrw4BR756Dkn1nOwiIU7RP9k8ffK84UCGt9A1Pd9C20nBe7id8PjrcCB/ArDkOHKKn9fMiyoEWEbNSoartQ9W336PQmlIl1ZmqgoJxvcK9e/NR/vIKfQxRyu4h2/LRqd7vFBL5v2ZKmqfqOeoy5fdActGBl4mwYPtqPO/eHmU61JWw0nQ9nrZJEI5ZG3VxCfp5kC0b805NiWVxvTCrb3bcBArCn+7onkjKnMYr32HwlTom6LaWHwLJwpgMjmWQUmFmgficWzEAgU1+TV9mheZMrLj8a+m294OU/xZUOiK0Y3xd1EapHUiOEOJqWQtnv4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FH1AL9YcCp66WY20YL8vJPr9g5pSpanvVSXAlC7BDAo=;
 b=c0UkR+MF438KAAIh8aTkXSv1EiLH/RtmCP1pB4EWqBdBWGp4D1AvzihVwgsh1yC6wkVHzjbV4qMtuksxykRkpnW5LsXt3PRu89LGDdsgCNuoJE3p9SDdS4eF1oYGFxhI4oCWG+KSGCgppOh5G7BS45rv9SSIo44UVUqkak+BM1pFAT8eFwPQsq77pUadvSulzoUnytlrpTPlVxhS4rzv8IWSW34h6GE3c7Bv0bjyDCkYHvnVTHYx2qY3IbqrVPu2VsLsT+04ganOlRz9GJYNn1HRbLznc6D3jC+OoIxEx0yv1qL1uR0OIv6lOVWQlxsTw/eV/PnEBfTM9ZicsgApRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FH1AL9YcCp66WY20YL8vJPr9g5pSpanvVSXAlC7BDAo=;
 b=LxRfw685AWdI5Z1e1FeUc9CqqieyiWTEILTn0ZMBxL9+XXk+l5zBHDv1plONugcoOwin879h0Z9xizFt4/xyLjgvtS/PKeXLKbC8mmJcGA4eOw+f9H/uJim0DLsLZRihqqUJrEn9r1zf5apIT5SFvXFMYj3YzxJ6gssz2QDAQuC135fvyNmV2ielQyDUqfqvvk5KjexMbar8HUrm6lxSTJJ8LEKN/IYQ/uzjeP20OmDyvUl4xIBOSYdf2xPReW4Jy91BhldxrrQEnryUU0O4jssXWfDyDOKuujyt00uMjtikRzfAZLmiY8Ku6v7dp/AidDkrub+NjVAK1lelJPiyGQ==
Received: from DM6PR12CA0004.namprd12.prod.outlook.com (2603:10b6:5:1c0::17)
 by MW3PR12MB4587.namprd12.prod.outlook.com (2603:10b6:303:5d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 04:18:16 +0000
Received: from DM6NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::ad) by DM6PR12CA0004.outlook.office365.com
 (2603:10b6:5:1c0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18 via Frontend
 Transport; Thu, 2 Mar 2023 04:18:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT088.mail.protection.outlook.com (10.13.172.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.19 via Frontend Transport; Thu, 2 Mar 2023 04:18:15 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 1 Mar 2023
 20:18:13 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 1 Mar 2023
 20:18:12 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Wed, 1 Mar 2023 20:18:08 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <robh+dt@kernel.org>, <broonie@kernel.org>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <jarkko@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [Patch V8 0/3] Tegra TPM driver with HW flow control
Date:   Thu, 2 Mar 2023 09:48:01 +0530
Message-ID: <20230302041804.24718-1-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT088:EE_|MW3PR12MB4587:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec30605-9955-4b9e-8b77-08db1ad5252b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +32grPF9/racfedz0i69ZeQ1mA7K4VOYQy3e33DtB/HOjim8LODljxNKnBzThrORhrhyuzvdqznCpDHlQ5zihofrmuEu/FVqCHyFECjVrwXpu/FNArBGPX2pq4rbudxziyX+YO/uEi7Pq+MkPbW7Lw5kdEtWpZQf3msgbIFdMxxfOaPtpPP4cDSAjfpgBcnNPrBNJZ4h9zBoCCWshW55WZ0JWBMFFf5FXU4VqTLcWl5rFg9yLMd7P6vDIkRteBwYIzngc2DJqfeh9xgQTWbQKJyelIxfAHbfrQXYihaV4BM8YkQA+cMv7AhIi0i3XsCyYfkYqDJdUn67dV/dtQbJa9kVBRCYffXMynmI3AjRAu8Fmgv9Qc15r/YeKIPXx/qJ0JYFgM+mkTtqdV3XrOPvUmtpHgN4uzqgAfu5BWj6jDD8FtBUoERfvA0EsA5K3ovU5lOuzql2m2IW0sqO3AuVhm7qzXUAz57h0KYBCeS9GIG1bdsAuYPo7mItllvAgovBT+ilMTV/+pRWEHXCDcFJa5cdBIn9dNs0rW6QoaDLfuVyiaU3d7HS2yZdJzBGu5NPKoq2tI9VyYs3rSipZ7jQ7yrK/YN6JJiYHIBISO6DMx6E384TFsgkn7V7+yafuB5TBtOW8B2uh4Y8OGGsl+nMWFG5SCpQRfEExApGR1HEDBs0CVEpRZG2MgfAZiyrKS5B9zSTB/ohwDIyL5w/2D1NMzCPgbqVKw++jbrgWfFEBGLgy2fCW5WcPV36arQUfGuZ2g2I51gPKtqqqQj25Le8p2OrMi+ZIghS9wD1pJvzxHdXbs09OYyu9vIXmatr5AC1K4MUrZmBahVXncdlUCdXlA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199018)(5400799012)(46966006)(40470700004)(36840700001)(36756003)(82310400005)(316002)(110136005)(54906003)(47076005)(7636003)(478600001)(83380400001)(336012)(107886003)(426003)(2616005)(40460700003)(6666004)(7696005)(1076003)(186003)(26005)(86362001)(8936002)(2906002)(41300700001)(921005)(356005)(70586007)(5660300002)(70206006)(7416002)(40480700001)(36860700001)(8676002)(34020700004)(82740400003)(4326008)(2101003)(83996005)(12100799018);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 04:18:15.5617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec30605-9955-4b9e-8b77-08db1ad5252b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4587
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
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

 drivers/char/tpm/tpm_tis_spi_main.c | 95 ++++++++++++++++++++++++++++-
 drivers/spi/spi-tegra210-quad.c     | 14 +++++
 include/linux/spi/spi.h             | 16 ++++-
 3 files changed, 120 insertions(+), 5 deletions(-)

-- 
2.17.1

