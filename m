Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30B66A1EE2
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Feb 2023 16:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjBXPuO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Feb 2023 10:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjBXPuN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Feb 2023 10:50:13 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA4166970;
        Fri, 24 Feb 2023 07:50:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D16FpaKVphw9w8hlVzJ+B+WUP+0UqoKCWqHspPaynzKtDfg/ugHtMgoWCH9RdQ6qjbXhgyUq7Zl0zK7TppBJaxigYLQvBZf1HqrqNKOSqSTiJ+eyWgy0AXxJwSiJUhf8+O1lud78CyKr2QlCEeJi3tQHqgYIXFvZv9tBTpaggGw2ZQWMgS5COfAAspbzxupUDjh1SYnypz+CgAXpJWv1y+e2ybohL7O+x+NB7Mv7vEOBl6sr8kC8PV7k4vZxkZExO1J14KVjZVa4psxvskdV2ZYZ17DbNZ0AM9/TRx6zO2OOYtrJBpTki6AzU6FHWDb+rxLDd5lbx2TXXnwnAvemAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TlnVDHReiu3NbkgrQqQ6ESXudHR8Vub0lUxVtp7R8H0=;
 b=R+FaNC9eS+/faI77zFF33AfzN1NplNXf6av08HTabq6iZyrr9OJwmKh8+AptIya7TKgCoR5+vdstLqpKS7IniXFTG6efEzdIBhDT5QjL37iRL2XSMSLJHl4b5X5Uogd/tPw3daqsg4J7rjlx92SWfY7IwsWA0ZSV198i9GNXLKbbU5jOrWSIwygShjIeozHERqwwR2ZyK+8Y9kQbYA0H209FeO+h1awbQbnKVZ3gVThBCK+DpDbciESE0E6EdVv5u4kGvUbgigjPa1iJqEDUiQqwKDo1dBn1RBbZDL+sLIWRHeBKUSB7SIpcGQudqlKoIEqj/TQPUtQfE9Fxs0eTxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlnVDHReiu3NbkgrQqQ6ESXudHR8Vub0lUxVtp7R8H0=;
 b=XBGsrkK5ZXysKlhlZrrDPm6+Odu4KDJM9uelUzv183mE+TjeQrzpgzgDDUGAa9pO/mdj5BbY0V1zi3ruADHpnDSUKhy3OpkNGJlLVQvCVlPD1I3eF9O5D+50K2xs48PB7+ffVCU2YlsDmhLW9S6IrN9Qwf51m/bJvDFjhq5aRI6kSyYY7VDHOAd1TLHrNnyaQUe8Owkq1+9BtXNRnmCUf0acLL3Mm2Sd5lZd79VUHsG2SQkVEtZ93EvHumcW3hupYTyb3scVNMUjT40cAcV0riQl9Pk+/gESngI7hOyUQi+8BloMrewlBWlAw4oljCIfWZXelduywe110GVDUGfKEQ==
Received: from BL1PR13CA0159.namprd13.prod.outlook.com (2603:10b6:208:2bd::14)
 by MN0PR12MB6223.namprd12.prod.outlook.com (2603:10b6:208:3c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Fri, 24 Feb
 2023 15:50:10 +0000
Received: from BL02EPF000108E8.namprd05.prod.outlook.com
 (2603:10b6:208:2bd:cafe::38) by BL1PR13CA0159.outlook.office365.com
 (2603:10b6:208:2bd::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.11 via Frontend
 Transport; Fri, 24 Feb 2023 15:50:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF000108E8.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.16 via Frontend Transport; Fri, 24 Feb 2023 15:50:09 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 24 Feb
 2023 07:49:48 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 24 Feb
 2023 07:49:48 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Fri, 24 Feb 2023 07:49:43 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <robh+dt@kernel.org>, <broonie@kernel.org>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <jarkko@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [Patch V4 0/3] Tegra TPM driver with HW flow control
Date:   Fri, 24 Feb 2023 21:19:38 +0530
Message-ID: <20230224154941.68587-1-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108E8:EE_|MN0PR12MB6223:EE_
X-MS-Office365-Filtering-Correlation-Id: 71a77a00-5897-4a72-d16b-08db167ecf17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0DRODKL0pzCG/KlzQDLDLAeNN/9mvulLMsbym1euGEONYYztvcY7FEBuAx5rwHviMgJ7KJs6MSrBAaTJVUroY7z1YsZxk6Ey9NL77/qFad84ixp5bWIJz//O7IUUA6MDe2UWq1uLhCsNBAeL6mHnSqlO98Z/IbT6WxGzXjnM+x2X6z2xWwBYnrZCkAKL8OQwYBdi7Tjq86Mbay1/I6VBoAzhqhgaQ2Gx6nOK6rGWAvE0L0aTD/LwFAoDUe8h2lm+2e+2NUHWGG8f33M8GMwrCn4hDKm/2ND/chVzeNzsdd1NLIGCioJPtZQF7cv2EBKS1z062pT/PXdHUe/pLdFp6yv9DuzSZk40H2RD+ASuTOO6OhRdsmmyorKCG5nw95qocrCRFgtbvstWaVY0oAr+3pZijFkSuUat3tkw7MWhruzaQQtDBlQqMtTu1Fl1j+Nr0N/qACREv5vWBv8i2Y5e/RNokU/QN+wX1SFpe9JF1Oo0S377UaK9Z73Uhtr/1fAQvUJbPeMWJWiLJi1ZZkCAtg3cB8yQFnCg7c7pBm8uRJA0t45xkHgZe/b3G4qCVjVUoYHnCkfdqbM3wovglZ2nPXvpXL42p8Ja59DMIravcaVPo+Ylyl67PtYQP+mdo8NSr3pVhcMazbjKpIng3GnIbyvr5t7NJB15yITNSop8I9eeiaNKhbIylFRmGMubdMLy9Fexh631ZkvOCaQpT/UNQcymrT4VW6NbJNWLnHE8jojQfWhl10/EKdAdEXgJq0ylJyHNB3aqRqm7BclfJlp+8A==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199018)(36840700001)(40470700004)(46966006)(82310400005)(36756003)(2616005)(316002)(110136005)(86362001)(54906003)(26005)(186003)(40460700003)(2906002)(36860700001)(7416002)(8676002)(41300700001)(478600001)(6666004)(426003)(107886003)(47076005)(336012)(40480700001)(5660300002)(1076003)(7696005)(4326008)(70206006)(7636003)(921005)(356005)(82740400003)(70586007)(8936002)(83380400001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 15:50:09.7160
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a77a00-5897-4a72-d16b-08db167ecf17
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6223
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

Updates in this patchset 
 - Tegra QSPI identifies itself as half duplex.
 - TPM TIS SPI driver skips flow control for half duplex and send
   transfers in single message for controller to handle it.
 - TPM device identifies as TPM device for controller to detect and
   enable HW TPM wait poll feature.

Verified with a TPM device on Tegra241 ref board using TPM2 tools.

V4:
 - split api change to different patch
 - describe TPM HW flow control
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
  spi: tegra210-quad: set half duplex flag

 drivers/char/tpm/tpm_tis_spi_main.c | 96 ++++++++++++++++++++++++++++-
 drivers/spi/spi-tegra210-quad.c     |  1 +
 include/linux/spi/spi.h             |  7 ++-
 3 files changed, 99 insertions(+), 5 deletions(-)

-- 
2.17.1

