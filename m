Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467886A0DF0
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Feb 2023 17:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbjBWQ1K (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 Feb 2023 11:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbjBWQ1J (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 Feb 2023 11:27:09 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10hn2228.outbound.protection.outlook.com [52.100.157.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD4258B5F;
        Thu, 23 Feb 2023 08:27:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gpes/qCY0ial61MQ5Nt6Y57B3TRln0cIB2X5Gjf85LO4QtaR4I9cDX8ofAq5+GKvzdQ1pJ1jFCbMOhL8/zO7pRFOYt/5T5J0jSTZ2ZPAgAyouI2m0HCW7M4gexDjOq1QGj/JAvjb+jASYk/W2zEg1H32+OcGglN1w3QOpC5dlzqXThfC30wlSkvNzPNF/oZSXuJy/d5I+nz1ugA3K1PAK9omFVwjcKP9yR0a+b0RpTc7AhTZIy05LRAswAdDSg7kNXTA33PFa1ASh0/wlOIS9yxoRk8eDXkyUit7d6TNbiYokWpLJLPg4CsOpDYkiTZW1v8LJdE60Vyl3jnTaaN9bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmxxe6Ots/cg2DiZ3clAVf3i7UNsJHuY5cXWFp36oGA=;
 b=C0VT9z0yY3C8HsZDNwrnsmHUMDPnVmphK+qK8tXgeEPLW6F1JgGBNJ7xD2FPZjRpCJqn1J13y7iZYzC6tzR4RVwfJ7C/cswjS8qg+fGhxAKsM7eHhH7im+5CD4+DxhYCWomRGZCAI7zu3hsPimr/aIlGI6QGsV72DaB0e75UicFNf5Qnsfv+KLuYcuvaUilQEx1x14e0Ic7PeLaXOJB39ZU5DiXM9QzFr+ZKfRfTRR5Bb7ecFFCm+ofr6mKUZSxS3dlgQVkm2/wSTRAx93OA5vJUShIXlSt+zITaKgnv9C3rTrc8XxR51zB3435z+6KZvEAG4oS2uuMJwQnKkcOE/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmxxe6Ots/cg2DiZ3clAVf3i7UNsJHuY5cXWFp36oGA=;
 b=UkARS+2RphKErm5Yif/HKxiq1x9jsFLbETaZnPZlL5a5lVMaQ9EOpzEfdLLZ3EGMl/B0gmM0Dd8gcmzXlCAUEXblHdS6fhApDgYzfQqBPt3iK3h/SJSu6FKFp32u/bZtYFaZxzGrDg86iZ1RNqb6YkkaEsormGKLCgZjaPcAuyGbsooN6zYAxbsPOXV3mBAaAmKaltfXeOOpUx3WoQSaNKmg5ty5b0D26M1vQ9q4JYiYNiQmfIEd71VxWkKRR0de3t/gfrF5JnlMthsaTsHdjrOJ0sILYh/3bgfcXjAKvsZDW+k592zejBEtemp7MscNHW6Qr3+fwxl/kh9SMnOSYw==
Received: from BN8PR16CA0027.namprd16.prod.outlook.com (2603:10b6:408:4c::40)
 by BY5PR12MB4196.namprd12.prod.outlook.com (2603:10b6:a03:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Thu, 23 Feb
 2023 16:27:01 +0000
Received: from BN8NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::58) by BN8PR16CA0027.outlook.office365.com
 (2603:10b6:408:4c::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21 via Frontend
 Transport; Thu, 23 Feb 2023 16:27:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT081.mail.protection.outlook.com (10.13.177.233) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.21 via Frontend Transport; Thu, 23 Feb 2023 16:27:00 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 23 Feb
 2023 08:26:51 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 23 Feb 2023 08:26:51 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Thu, 23 Feb 2023 08:26:47 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <robh+dt@kernel.org>, <broonie@kernel.org>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <jarkko@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [Patch V3 0/3] Tegra TPM driver with HW flow control
Date:   Thu, 23 Feb 2023 21:56:32 +0530
Message-ID: <20230223162635.19747-1-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT081:EE_|BY5PR12MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: 89cd1c2d-100c-49a9-904a-08db15baca44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8dHRTjLOHZ/vNZBE1PxVyDbMDgXsOFhy9sBeZKJPpDdYNBjEwQz5XopT800DtTkNmy5xcPGBDykjFhPxbD3rsLui8XRM58P69zm71GriwA14Xdbi4n+Ybg5NBA+asSo8GpRMvVr8Xfiy7eF1FNSvVXleR4Y9F6xrni9cD0QS2WcnGabA/6aLFiZrjFIZYyjzxINEzHHFT9/0NTrbMMXk6eCkkHNjSwr9UDiXz07ZmT1dlrBAsY83dYieOMbW8hgOs7uOcypo9rgihQu4Zjfc4UW9CHlA9SX39KuKPTU3p3Z0yVhvOZPWKLB4B3R5udTYX8Lk376es9lOHrNu9iNkQG0QOFw37OccCxtJZpc+3tWX/k3bGSmMxXn1JTnVSGUxGii2AfE/OkUljwIg4WAXfnoXlnGomOWVqGWEhMrDgTXI3CqJVbT+S+/rWZrcJabhPxSVm1w4HYKgRd/yVFR0O9dNiz7nSozASGK4pO7xOSIMTsAPWpNeCSf2pkv6/TeFp+EqodIFIv0sO5fmgjX6+nO1nRq/0SpGJRM9T23HfOYzx/ifJ8qUeQ+WtkiLsuxUknKXfDybXv+2WQnb1v5jAcaQKhUrizQYQhfbBhDnVSH6E16VdnmCh07P9VzLhh8/DtQbkPg+tf5iBtxWIYy84PHKkknYF9yVnSPVvr5ZKCR2vRxe1d2ge2tUkUh5sHuyDJGY1Gfo+7MwQM2mGS5M4XKHW5bp4A7WyDL6UVnp/C9uwObBkO0qZ2+JJZDX512LxF4CwfwmzrXnpkIHuGbWa1HeNnpRasOjn75NzJl9Ixs=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(396003)(376002)(136003)(5400799012)(451199018)(36840700001)(46966006)(34020700004)(36860700001)(316002)(186003)(26005)(336012)(40480700001)(41300700001)(70586007)(7696005)(82310400005)(70206006)(83380400001)(8676002)(478600001)(54906003)(110136005)(1076003)(36756003)(6666004)(2906002)(107886003)(921005)(4326008)(86362001)(356005)(8936002)(2616005)(47076005)(426003)(7416002)(5660300002)(82740400003)(7636003)(83996005)(2101003)(12100799015);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 16:27:00.2617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89cd1c2d-100c-49a9-904a-08db15baca44
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4196
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
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

Updates in this patchset 
 - Tegra QSPI identifies itself as half duplex.
 - TPM TIS SPI driver skips flow control for half duplex and send
   transfers in single message for controller to handle it.
 - TPM device identifies as TPM device for controller to detect and
   enable HW TPM wait poll feature.

Verified with a TPM device on Tegra241 ref board using TPM2 tools.

V3:
 - Use SPI device mode flag and SPI controller flags.
 - Drop usage of device tree flags.
 - Generic TPM half duplex controller handling.
 - HW & SW flow control for TPM. Drop additional driver.
V2:
 - Fix dt schema errors.


Krishna Yarlagadda (3):
  tpm_tis-spi: Support hardware wait polling
  spi: tegra210-quad: set half duplex flag
  spi: tegra210-quad: Enable TPM wait polling

 drivers/char/tpm/tpm_tis_spi_main.c | 90 ++++++++++++++++++++++++++++-
 drivers/spi/spi-tegra210-quad.c     | 22 +++++++
 include/linux/spi/spi.h             |  7 ++-
 3 files changed, 114 insertions(+), 5 deletions(-)

-- 
2.17.1

