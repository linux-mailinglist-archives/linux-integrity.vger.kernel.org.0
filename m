Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66588689960
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Feb 2023 14:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbjBCNC1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Feb 2023 08:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbjBCNCZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Feb 2023 08:02:25 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2044.outbound.protection.outlook.com [40.107.101.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56F79D593;
        Fri,  3 Feb 2023 05:02:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gk6aCK0UyQb2BOQtp7AZDO8MuG3dk3zv5YMEhF9WfvKiR9xZb0TKMX0U79xjQkQ5CIyh4q6gjAFJlfkdghq3dwMr04a3n6qgQMF9IBm3A3nx0lpwzPwwo35QNJXG1wME1GVrgD8BAp3HU9YJvaHIywrEYvczfChLhPH3te8NbNjZGyIsThwi4Ecd72OKHdEYRzVS5HwQCj0SrZTiyxkvLvGLNBSg7/u7AOyWa6V32gIg3JpUgu4iS1cIgKulEWsqdT5694uOu+EHndwNarc2ULVRcBLYlHNdQOWh1So2efyDcGTRAUFTfnzydecC68Bd4oCdmIwdMMGfWPUcltnbUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aExJLvyqOQDaSH2CBQmqboHZSVYzBuC+9cM/kjEBTHs=;
 b=Z8sbGIiNe/FWzWD0lWCLde1wrtZPaGCXmuAPRtPrCasSvoc45pLZY3I8SAS91o+1q61EgTe4mUc65MLslpMXNwFMwWZ/EYiukOcWfuId+MZQTIVX9kFA9MWNMjxNcCOkjhTiTP1gtTDUDeGCiC/mYohpax+C4CiB3NmI52Xy0B4OoEhbWV1SWUiskdXpqf3Lnz7PhYDr6sq8Q91c32c3Hk4aBIYNhNJwKqcPE7YX9PDjIKwmQi+ch/i2dAslJrEmaUr7lHAb1tWNbY8l1QptEuT6O/H4S6YnXVSdOtSMe1NdMd+ZVDxKzYopMb3V34EFDNYdiCA/BImWuKb+GEPdhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aExJLvyqOQDaSH2CBQmqboHZSVYzBuC+9cM/kjEBTHs=;
 b=Qp36Qk6crLD/jKgrl8YKCVrAKYN53rFJO3dF9F/yQEOVJRVJxor2Yh57OzLRpbhQozciJYOgsaWlRTUHzJK4ETe4xsZTtwWGAqQ9A7kFcIqrbT8fVspekkMQeMrT/xpIU16s/sCOJHk+jyPROg2BiUzM1hq8/6iAKx+N9uKfRSAs5a2kBrgObO0TmySdUStCLwIV6trkfllQgKhyGDGZF8qjlwEeIcLTgn0jG6UUcpkdAkYC218ENP5okjqqEJB7GAiDAPjE+5tytwuq26H83oZzdtOt/Mk+XreKVvomE8L+TiDgNReaw6y+ZjY8HU0mD0klTriELAuWVXpf8DCBVA==
Received: from MW2PR2101CA0031.namprd21.prod.outlook.com (2603:10b6:302:1::44)
 by DM4PR12MB5842.namprd12.prod.outlook.com (2603:10b6:8:65::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Fri, 3 Feb
 2023 13:02:16 +0000
Received: from CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::8c) by MW2PR2101CA0031.outlook.office365.com
 (2603:10b6:302:1::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.5 via Frontend
 Transport; Fri, 3 Feb 2023 13:02:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT112.mail.protection.outlook.com (10.13.174.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.28 via Frontend Transport; Fri, 3 Feb 2023 13:02:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 3 Feb 2023
 05:02:02 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 3 Feb 2023
 05:02:01 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Fri, 3 Feb 2023 05:01:56 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <robh+dt@kernel.org>, <broonie@kernel.org>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <jarkko@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [Patch V2 3/4] spi: dt-bindings: Add Tegra TPM wait polling flag
Date:   Fri, 3 Feb 2023 18:31:32 +0530
Message-ID: <20230203130133.32901-4-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230203130133.32901-1-kyarlagadda@nvidia.com>
References: <20230203130133.32901-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT112:EE_|DM4PR12MB5842:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e81568b-a193-42e1-4b0d-08db05e6dffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qOulHvGLqMzsSjlx1CJJXZaF2px49lnZKLY+Y1Wgn5qrU41/DYuF5cKqBMOnnYfRRx9asmucAHO6oO7m5nQg0BOKBlU5wo9qXy24UaeOBlMHd6Bs1qC6c3XrhEkga9FBlF13iobvFgy3nt02eevGaArDpb8yQg1zMLeon169+5ELyhNcVKRggXSl8RYVXrQU6rgC5FZUY//I/p1sWFbbPhmGrDgIubLkSWiNNBiONNbBGRC/vQKYPTWYH4TPSKdmiEOAsSuxNK6rLXD09h0QBYOnzD3XPrDmuvgbG3gYmHM1KizOv4UMscfjLzCPwRXahBiVmmPkx0sea2XkCEIxxKFxgz62ZKlQOCyZ3M5fmaodt6Rhp6+CFZ/nXx9492ExzpIM5c/V9VQZ75GMJXySQLnTDOePArRVL+75iSDUmy/Nz+v/117LSl72uwZ8WbajWnSiOl6qqjMzxDJL0xR6QTgNO16yqRieuIjOcPiEBZgbdfGqlfmc/nhvm/RDR3KMSTLF+sbE4BJ9+LQOqivQuta5ht1U/92X5TqY2VEj7xpWAa2Px6yh3M+TMDlIMnTg4ZuL/K13YdIjXmlzzGMiCMva+lDNK0jdaErpsls57vhgt+ZKN3FCKSOvqFS4EcgHAk6K1TqwmxGIEoBSHzcgGxRcbWHbX9WUrT2tmynEv9kECLtFVp9sG26OlKIccWm5ODUi4fVNkOceFmznmkdLmFyktbF9j8+RNIC3NAA+2mjL9NlkW630Ak002GvSjJU6EGDh9nDeZ+56i7+TgVU9vA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199018)(46966006)(40470700004)(36840700001)(356005)(921005)(86362001)(36756003)(7636003)(36860700001)(82740400003)(316002)(41300700001)(8936002)(5660300002)(110136005)(4326008)(70586007)(70206006)(54906003)(8676002)(82310400005)(40480700001)(40460700003)(2906002)(7416002)(426003)(336012)(4744005)(47076005)(478600001)(2616005)(186003)(7696005)(26005)(6666004)(107886003)(1076003)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 13:02:15.9965
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e81568b-a193-42e1-4b0d-08db05e6dffc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5842
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
index 2c3cada75339..19d2b30cadbf 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad-peripheral-props.yaml
@@ -29,4 +29,10 @@ properties:
     minimum: 0
     maximum: 255
 
+  nvidia,wait-polling:
+    description:
+      Enable TPM wait polling feature for QSPI as specified in TCG PC Client
+      Specific TPM Interface Specification (TIS).
+    $ref: /schemas/types.yaml#/definitions/flag
+
 additionalProperties: true
-- 
2.17.1

