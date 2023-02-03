Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798E5689956
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Feb 2023 14:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjBCNCD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Feb 2023 08:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjBCNCD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Feb 2023 08:02:03 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5E8A267;
        Fri,  3 Feb 2023 05:02:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+QuM9Gu3KMRROqP+Yeva3hjWFjz2/JviDoJ55HyiCGTPWgbazOQlJG3Ndg1wUd0semYtwbDs6y7PD16Knlefj0pJcHyG8huhhr+ar4c10blknA4pkFiPfyISROGu6NLKDnOsWC0u9ejg9ebSYACvt/uOOOAoq2ls4OUnX/kiOoKPuv0AVCdc3MwuCcPLIxXHILp2wgSr3qwFxJ5315TNuDgCb35+neSB3PZzu0mgYjUFY+S4aWVDtFy1l+FmMbQrgJaitzreouI9oQPdrnxnjLTy2e4qa/Q1NEzF1CH/RPqGZ5x3ExWr6uK48Uq64LuULlV+xB6CQbXLZXTISW2Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPr8oacSTHDgmSeDnBMJ+ssHDS3BcSHxIfCulFks1ho=;
 b=Mt1PsJkM5wqBnIE1JdvUy8pau/13qAQu5UJ/xP8aWQgrSqUgPHnNXIk9FQ5TdGxyMoX1FtgczWBMUhNruEKYAzAewOLItZLTt+qI0W0SfJpEfUoA9OOFEKcvuFghAiwtN1KBjVWwMVXTZZm1u7TiY8jfQrbzbjsUTeAFfR+7YaNQ+f+RcTIDU5KHqLhnaP0RSdNnOi1QQt1nRo9+2yloSxUXXcD+0jbOGDxw5ZXRFPKPq/8E3GD3OJcP6RZvQiA0KKYXIznwNPRZgeClFg3DCw2Ex2l5j3c+pyXzeGN2kJPHD5MWEaD5LwL8U5Oh/rw57gWTwu0OoYx55iPyNt26YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPr8oacSTHDgmSeDnBMJ+ssHDS3BcSHxIfCulFks1ho=;
 b=bRkSOEy3QxG0USCdhSm3F3QNULNeeBhEjtsqEITcvu3YgWIOcuqnKbbS5M7RU18HLER0MB04Dlp8I5puV2dypxI1ubPaqF/GSGPvvoC4oOzu8qJU29suBtJm+Mr7jD+1FwD9fxVAZ1KMBz3NarPXRNX4YqXgX9ioa/C26aYLxbyX15DmoKVZWEWPCcW0U6R6PwbXT+iYOvywYCB1od7svDd4dfLg2sGgDkzAQqi/JV3QkwxPTV2w3sYHFq1UbbpEWAKxmPd2ZQ2FdIDlZigYEZ0e2zlIbbHTgearxsDXQZdeR4sWtjEZS0EXl908fkK1kt8e+9uJW9jqp76pioPbwA==
Received: from MW4PR04CA0031.namprd04.prod.outlook.com (2603:10b6:303:6a::6)
 by BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Fri, 3 Feb
 2023 13:01:59 +0000
Received: from CO1NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::7c) by MW4PR04CA0031.outlook.office365.com
 (2603:10b6:303:6a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.29 via Frontend
 Transport; Fri, 3 Feb 2023 13:01:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT107.mail.protection.outlook.com (10.13.175.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.28 via Frontend Transport; Fri, 3 Feb 2023 13:01:59 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 3 Feb 2023
 05:01:45 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 3 Feb 2023
 05:01:45 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Fri, 3 Feb 2023 05:01:40 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <robh+dt@kernel.org>, <broonie@kernel.org>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <jarkko@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [Patch V2 0/4]  Tegra TPM driver with hw flow control
Date:   Fri, 3 Feb 2023 18:31:29 +0530
Message-ID: <20230203130133.32901-1-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT107:EE_|BY5PR12MB4068:EE_
X-MS-Office365-Filtering-Correlation-Id: 3815865c-84c7-4399-7702-08db05e6d617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fGfInRC7mAMise8OtozHb7MsBdD5tAqOH3jJfJ9dmBrGWSmM3jJR7HHV1y/Yzrx/GNZmsuretZTcgl+puZQ4k09kh4mUF67ggIuezbCIKhBrcd2msVRvns3W250ghAUNsAWGuYGRHA+lVgfgf8ZuOcM7HDp19N2tJAQPUsxqu/jdepSbfRsvtkBAg/IQdEenk9H5ekcMkcLRmQTzzxZmYySsU+ptb4tODe3Z5rIW5GnIS7EpYPEsvA2Tg4s9rJ3jf3fzEjN0vu+JhSo5a2CWRQnEwXwgCczlfuLDxnVqK/WHbn0ih8JeLCdMiLfYSAN6A7ZmGtgnwZMYbXrSbhSPRsPdRQyQxfrfmnZOr23b6xhOEhh6Cn1YcDj3b2lTMWEgF64W1UuaZFtO3zlEzOarqop2djaoZosZGD34UBKb/l064Dbp5/8d8PlRPuzg0H8NxTx3Wu4rOnGHwlLwohro9N1cIbTk+1uaUbHw58klBHM2VyRlYzzcPDibEFEt6HMxotjzR+fIxRQefYDi2+XK9xNCzhjw00T8nvzFffZWWn+42DPj6SOv6WoVy0UmeeRh33OosJ+ngI+XjW4pYVi6iK2PDsHTJZhV6KEczOyfOWkc/f4qvMUz7tzvLo+pkC8O4EouNpK2/VYj3vcxPirQzabtIC1jpAKPdjOk6x0vMTTk6PdT4KS/uJt4tfe13O8lIwn/l3YUF5uSutnk+RQjhZH2i9nD60gBx29oXgwqX7M=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199018)(36840700001)(46966006)(7636003)(356005)(36756003)(86362001)(6666004)(8676002)(70206006)(921005)(7696005)(70586007)(54906003)(8936002)(316002)(4326008)(82310400005)(41300700001)(5660300002)(47076005)(7416002)(478600001)(40480700001)(2906002)(82740400003)(36860700001)(26005)(426003)(107886003)(336012)(83380400001)(2616005)(186003)(1076003)(110136005)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 13:01:59.3973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3815865c-84c7-4399-7702-08db05e6d617
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4068
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Tegra234 and Tegra241 chips have QSPI controller that supports TCG
PC Client Specific TPM Interface Specification (TIS) flow control.
Since the controller only supports half duplex, sw wait polling
(flow control using full duplex transfers) method implemented in
tpm_tis_spi_main.c does not suffice.
Added extended driver to disable sw flow control and send
all transfers in single message. Flow control is handled by hardware.

V2: Fix dt schema errors.

Krishna Yarlagadda (4):
  dt-bindings: tpm: Add compatible for Tegra TPM
  tpm: tegra: Support SPI tpm wait state detect
  spi: dt-bindings: Add Tegra TPM wait polling flag
  spi: tegra210-quad: Enable TPM wait polling

 .../security/tpm/nvidia,tegra-tpm-spi.yaml    |  34 +++++
 ...nvidia,tegra210-quad-peripheral-props.yaml |   6 +
 drivers/char/tpm/Makefile                     |   1 +
 drivers/char/tpm/tpm_tis_spi.h                |   1 +
 drivers/char/tpm/tpm_tis_spi_main.c           |   4 +-
 drivers/char/tpm/tpm_tis_spi_tegra.c          | 123 ++++++++++++++++++
 drivers/spi/spi-tegra210-quad.c               |  16 +++
 7 files changed, 184 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/nvidia,tegra-tpm-spi.yaml
 create mode 100644 drivers/char/tpm/tpm_tis_spi_tegra.c

-- 
2.17.1

