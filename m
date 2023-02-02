Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515F96883FD
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Feb 2023 17:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbjBBQTG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Feb 2023 11:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbjBBQSf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Feb 2023 11:18:35 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355C54C0EB;
        Thu,  2 Feb 2023 08:18:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzxnFTDtw/Yy41WxyNxdhH4LWR9BNcZcrHz4sMqMwMXrDOk5vQGYMZHzfWP2aASaJMo+OMjTxrtss6wkgxQwP3MY3XCTlboM228cV90TyJ/B/A4WwZVzrorhg1hPsgspIIuq/OB/l88aAkvcFe3uuOOZFKpmArScVer7/yszdsqdwK0IfxClTupju7O7IpU5Szkb6PbZn1nr4BlIW8o+rSc2qQnSKWgOglB+E16zPRexuYxL9oRnEHnGoC7ZgkmTWJKzt+Og0itkgZmdsAYZrcoCCZd2eOY/yjHu7s2ePQBKDX+f4EjHfHPxbR+TCQdhY4duZ2jEYhjQGSO4NZmDYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CL/n1nsRkcySnkDKWfHIrHJbsnAM48N/Pz5SAi5CtKU=;
 b=nL84bjs1Pw2dlRLX/DpCiZohzQXl7rhuYt8sgSjbWTMVTtKxD/bicYak96Xk85hm+2DUCykvIf02bkoM5bheieYBZZDPDE5zJGH6bQwjRGzMwfTGvn1ffStLz0wzGRynb9RCRBuwwM8UqBMrs9Nu1A7JvocZ3zMZi7hnChfRwyphhPg6dpDg5uiJN0EQhodBMdB3czJgLCMLYkS4Pc7VkuJA0T/Qw0xzHntGPi4dzHAALsvUXgq5aOZuC2W1gevQncdoQ+jbJ9PFmuTPjUspgkSTuR7u9HZ9F4l0cAvimbv0w1G1KUmPcFIs3IFQjHBYhaEaU7vo8aSpSpPb6/gNlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CL/n1nsRkcySnkDKWfHIrHJbsnAM48N/Pz5SAi5CtKU=;
 b=tdXuYELMhjYpqJhGKBjMj/rO2p/HcgelNQbQbaE2IBzrzLQsAgO5DVBWzMvoXz3YRnWkmOiSjRvKuO8yY+AZiEO3d9PcxKkupT4SiNnFbuz+PdIVk/nCU8qV6oJGQSKM5WTNIurp1onkOu95X5V99aDFOqcBfDNAR7ZQPbjwyPHJrD9C3tD61qtKFbiEaIaimFeJtpFaopjTDR996MIcALiHXxHE6GP5+CuRLP2ylqvfT3jfEfymEipnCq7k4YJ7am7kUDstSvFEUhOTtZjQhtzCLht4XMq+RQDWyzulb5im8LqrV6wE3LpKirJeoT+wLzhckzrPZ/mlMpAxnhOr5w==
Received: from DM6PR02CA0042.namprd02.prod.outlook.com (2603:10b6:5:177::19)
 by MN6PR12MB8567.namprd12.prod.outlook.com (2603:10b6:208:478::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Thu, 2 Feb
 2023 16:18:25 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::86) by DM6PR02CA0042.outlook.office365.com
 (2603:10b6:5:177::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27 via Frontend
 Transport; Thu, 2 Feb 2023 16:18:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.25 via Frontend Transport; Thu, 2 Feb 2023 16:18:25 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 2 Feb 2023
 08:18:15 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 2 Feb 2023 08:18:14 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Thu, 2 Feb 2023 08:18:10 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <robh+dt@kernel.org>, <broonie@kernel.org>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <jarkko@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH 3/4] spi: dt-bindings: Add Tegra TPM wait polling flag
Date:   Thu, 2 Feb 2023 21:47:49 +0530
Message-ID: <20230202161750.21210-4-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230202161750.21210-1-kyarlagadda@nvidia.com>
References: <20230202161750.21210-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT024:EE_|MN6PR12MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fab5523-f88d-4643-8c2d-08db05391c7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GkmCaU9jONFDTpNRrt3/Oj2C8KXWyVAH8h16wLn46e0O+N2hNbfqZ5LV09/IfwpzysA5ppdKQ8vfVT0mM/uWiQF1siKPP6SaEr6D676k4SWlBwugJDnw8D/z8uU2zkFW7kDizJfhGRtHons5auW0hmuYqtCArA+Hcot7A2krIvTyhMkDKlfXDIz6nETOhC7lecK6A5gm/+Ikgw1bl3FrjgFjMJ2unzryUoq4c4VoFRLVDHuzdRLPM6FoKXKYNO4F4LOAGIJBccnQYD+KFDvEeHb8d31+XBhLyCnse9o8l941O+R6MvMn5EF6asGUy51eNRFxr8lpuLhWOA9FYzvGhZw2dDK2GTPl+W7FAEZTHy4pJSAnWu9ldWPx8ltPCWfDAzOMm3LxZJt1xHaQ6Lssvr0J2x7+SE3mK1Vzhhiw4ZoR2un302gW8wO7SuIrONKNqiI+jk4ASEBzKaY+4p8bn+4+gMw1B6CrzRw2K0rWYHWRm6pQdsdzG9mtBgpEr8yKrwntkdme773Uu+krjwuoVd0AN600YxQgWHUowL3EPAlpxofni1JgURGmmRjLnqhYu0556uUQIGUmJ6NsnqX2sltb9UT7/Q0VmjoQLhTczQORSA7KKiSNfd88ZuLMw+Fi7Z8EtzjuDFsCS5Tk4XxRCHUcTwLpG/xE4b3WdyQbP9LT7R3YIRE3heFpObfowuQXC8Ohn915cx8enmDCsx2P0+IPS3ysfK2hMrTkUOJ+XfzdAygo6nS5XXNfYZ0CdES/PYZ1Ll4ITsubAoYJ3mBjRA==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199018)(36840700001)(46966006)(40470700004)(2906002)(36756003)(336012)(82310400005)(4744005)(54906003)(426003)(6666004)(316002)(47076005)(107886003)(186003)(478600001)(40460700003)(26005)(356005)(7696005)(70586007)(8936002)(4326008)(921005)(70206006)(41300700001)(8676002)(7416002)(5660300002)(36860700001)(40480700001)(86362001)(1076003)(82740400003)(7636003)(110136005)(2616005)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 16:18:25.0784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fab5523-f88d-4643-8c2d-08db05391c7b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8567
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add "nvidia,wait-polling" flag to enable TCG TIS hardware flow control.

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 .../bindings/spi/nvidia,tegra210-quad-peripheral-props.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad-peripheral-props.yaml
index 2c3cada75339..25150d55603e 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad-peripheral-props.yaml
@@ -28,5 +28,11 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
     maximum: 255
+properties:
+  nvidia,wait-polling:
+    description:
+      Enable TPM wait polling feature for QSPI as specified in TCG PC Client
+      Specific TPM Interface Specification (TIS).
+    $ref: /schemas/types.yaml#/definitions/flag
 
 additionalProperties: true
-- 
2.17.1

