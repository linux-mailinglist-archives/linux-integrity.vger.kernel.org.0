Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A336A4164
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Feb 2023 13:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjB0MH0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Feb 2023 07:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjB0MHZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Feb 2023 07:07:25 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12hn2227.outbound.protection.outlook.com [52.100.165.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3AC1421A;
        Mon, 27 Feb 2023 04:07:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNqFu1ORnP3X+/Mx22/Ue2rfVLTMBEMZCoPVXNWp9BOn6X9iefjdH5YyB1Q3OYRvlYYZqnJLIPhlLVnsOia2JOzhtCEtzurrUq5SfczXlgS5XVVGv1DngXxTHxYWuvfEcm/j7AUTffxlKim7y8Mrx1X2zKQUizqB75c5CV+P+DkgVZll35G3Ek8bYx2GnlNv0AbBVREsLx2x3J0x9kpH0bEoLdwfdOqx+FJdNSUc3zq1CRWdWeXWmU3HIUl/ua1ZIXJsooA9mMhujMEXx+d71IbdPXZ+OxS7E0WspmLpLaKFdWlLb1NBBHY0m6LFAfAhGHCE51TKro7G3FFp8OLJ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qu15BsEUyYEhD32KCXKOxI4fNgRm3r1DSYSEdTLybg=;
 b=RgXKVvXdxk2RESU43r4D/UfE/Wv8FLFlzIUSqQebNlips6bdCV6jP61qdf7K360htIfKcuP2zj7ZBvBoEh3oJigwf1P537PXK9fbXWryU933E9zADsJZxg4w2VRUhoNKI3OPtFaL3gakxJhIVrdEGxkqP1YUTfeAwtKb1moFPJeIReZoQgMDs0jlTQhe2FDdQU8EFWcgXtBGoMDijGNOA41UJGIFlygcKNVD0ON0FpV3onveoJB6guMy8pXk4m7Lye/S5W8YVdxBLPO+sANms1VeYQio/x8EJ5GIV1N3RlV09n4lTlcqkiV9Dxvdpn9w0Qh2NAWbOFKkxpq19hmhpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qu15BsEUyYEhD32KCXKOxI4fNgRm3r1DSYSEdTLybg=;
 b=mlwwOdIE6+sVWd/fJtqP6WdRmJB8zgRrE9deVFhQSEstgdi5J/q9utNRzUDphjZpYKNTJ7yLNlegIy59kVXJ7qW9c+5So6CrgxDz8HIXu7TQWZ5oP1Q5HGAs3Qnf+1oKbkqy0xR69mDBVJT2V1NkdfmQwwKUHgCcNPXoLCX6OL2Qe0K7nW0jpdmKUIPlnC0WNpvuWVWd96a5TXnsWWE/94hpPvOARlmSt+S1zLvBtvN0TEtKATn8lJBncQxbV9KefCRru97aH8RqJaIwKgQiaN/xSXQwxr8gVh/tbJCBuGggDQ4LiITejHWplj/YoPKHowPXN+Oy7vgNFVG+8Gd+0g==
Received: from DS7PR03CA0204.namprd03.prod.outlook.com (2603:10b6:5:3b6::29)
 by CY8PR12MB8068.namprd12.prod.outlook.com (2603:10b6:930:75::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 12:07:21 +0000
Received: from DM6NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::9a) by DS7PR03CA0204.outlook.office365.com
 (2603:10b6:5:3b6::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29 via Frontend
 Transport; Mon, 27 Feb 2023 12:07:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT095.mail.protection.outlook.com (10.13.172.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.16 via Frontend Transport; Mon, 27 Feb 2023 12:07:21 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 27 Feb
 2023 04:07:11 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 27 Feb 2023 04:07:11 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Mon, 27 Feb 2023 04:07:06 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <robh+dt@kernel.org>, <broonie@kernel.org>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <jarkko@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [Patch V5 0/3] Tegra TPM driver with HW flow control
Date:   Mon, 27 Feb 2023 17:36:59 +0530
Message-ID: <20230227120702.13180-1-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT095:EE_|CY8PR12MB8068:EE_
X-MS-Office365-Filtering-Correlation-Id: d568671a-ac88-40f0-b64a-08db18bb2e1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hj+RHWV2vKGRXXK2BDenbykzCs+tAb3jtigsJimo/SPQMQ6JHh2dOsCwL/DMi/6mMXDZ/QLEXwwP7zUxEV68/nwCkuBuV8U7lKtSEsWbWfMLeiwwylF2dyUHztG9U/Wf2u7uLhs0MTFGXw3QEByXfiGbnQnwGEtgfzigHtvggFClA6HgusJ0pJezm/VdrtxBiR+2c07xe7Ax1bVy8Nh33m8M0gYKw/eclICifj2ZQWwHvMjgvkn78OgziXpp4hgVdhNxuEn3a2WayYQTd7MX0PP6lu9Ef1u+yvraewXpP3zFmIrwzFL0vixkAUp2onwdYxypiWaA0lw4pU2fldfFljy4Qm+d1/PQhB10Aofgv+s6TS0Zwf+fNGPGqyjxICIZjehCbdnpw+bJdNrzOFFKiX7ozBKVR2Ol25lJ4SUt8Wl1DONPHeF6yB8SPRqHcX/k1Uj5ON4mOEHoBTwmLr1ryuPXFI36XNMYfOizQNOe6wx/7BMPJsCZzlsz1MHR3RdRHlpT02R1S5X7UET5sKoNjSqUkx5qiHMNSAkADW7kqY6R2ggfykBU+2awCHP3YMRnZYeMGukhNpGGncOTgGt/INuan6qM1Olx2xWwaxwK5r1t0xmviGigsS9cqLTnXCWc/BNtp/8AdvScXl5Sk3/QP7UsFOn72hcB1LOR1T/L/XWe8alLihVwtXHYysKg9ext7ub4WLoswHJbwKNXZwJOD3XbYFvPggWv8xFyZLV5JRfcEy/8wLZLlprHkdwkluxvD7HHgRZXxkXciEP2I7xRC3yfy6C6P7OqKoAm9SdFXXYNJWd084w+0EszLfQ9OYro7OTGPF7AjRghavsjrynOUA==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199018)(5400799012)(40470700004)(36840700001)(46966006)(2906002)(82740400003)(8936002)(316002)(478600001)(83380400001)(5660300002)(36756003)(7416002)(40460700003)(86362001)(41300700001)(40480700001)(921005)(356005)(8676002)(4326008)(70206006)(70586007)(54906003)(110136005)(7636003)(36860700001)(34020700004)(336012)(7696005)(107886003)(6666004)(82310400005)(47076005)(426003)(2616005)(186003)(26005)(1076003)(83996005)(2101003)(12100799018);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 12:07:21.3170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d568671a-ac88-40f0-b64a-08db18bb2e1b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8068
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
 drivers/spi/spi-tegra210-quad.c     | 21 +++++++
 include/linux/spi/spi.h             |  7 ++-
 3 files changed, 115 insertions(+), 5 deletions(-)

-- 
2.17.1

