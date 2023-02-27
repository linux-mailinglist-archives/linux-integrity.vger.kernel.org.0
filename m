Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3AB6A4168
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Feb 2023 13:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjB0MHh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Feb 2023 07:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjB0MHg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Feb 2023 07:07:36 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10hn2221.outbound.protection.outlook.com [52.100.155.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344351F5E0;
        Mon, 27 Feb 2023 04:07:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDar4o0CSpj1j+Se1ThAL63mWwZQM9Il2ewVlfB+shmgH5XxL7I06UBMX7aFX60gyH6z+Rd3cDTApy92e6DV8k1kkZXOacATwZpaffgP27+7t46m9j1iz5rUKgsBnTjnKinR2wIXv/I45+rXgaNRYIy6SWbqXtbHewY+BCVMoVo7uh3mqQISbZ2C/fePvSIx+rc5uY+gboFwGI5z+nIpQWj0wh6lEcdbSYyx+DiGOQRCvfimp5/WkfglD9Mqhp1gnKxKwQOaOeoRLwkJShHAIGI7K3TUW1+2NPijKiKc9xP5P3epukRAGRwugb3EcY4ARVVOl0o7hINzxFmqGvCYQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9z3h89NmWQPE45T7w8B5uzlawJkhoD5j8eX9+XZE78=;
 b=np/+2zQ6xTl0FjueOGA5LwPrv0YonhgkJuXeMbKrIv1uo4LxbbqNLTGIMR0Db6jjsjl8HRc/WlIxruK/sjNOeq7BvTf8iWP9L+rhsGMRMujNhtFnrH5KuqhM1/o7vCYLiABm4C07KrYj0cEj6AYptcOLPYME84bZxrfkJxSA8na4CTzPFHZji5R5ETuTYjm5i/CBadbFUoyBdsrsmo12gYi0RSFhUlh2me+AQFZQI4l9NdyYXA+cIUGlL9cfbjopWFoclZYalQuwj509qofsIx7spLCnghc1CKVF5vHZVaZUTXzKnrIVSjnNI5fYf9K14GlfiGwLv7ImsJH1GqELiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9z3h89NmWQPE45T7w8B5uzlawJkhoD5j8eX9+XZE78=;
 b=mRwtrm56hPNdpKqUMISXAdmKIQ9wmG+2YcNDbwXd9N3Jy7hsWlSBwAR2LiugJUASrpehoB4CT0NcWamgfhq1o7Jc9/dDKg8Cfxfjuo+863CGl6wBFgVE4XZ3YimrZ54UwdCoIl0k4uJ8Mj9KcJZACid5JMNBtmvYP0cLcTlDeuV5s07TriZRs2Cg4OUr3Maj2VjXprcDlA9PTmszfmyzgdliPth9Sgot4A2wdjXbfwx6yAswhf9d//poxokPKU+TWSU6DwhxXodzcQ1PN99cjOcRte8CJYTsnH5UFtGgTIt4zGLjqt8zSuPfSH9IuTav8VQ7CF+JY8atydQdeAs9yQ==
Received: from BN8PR15CA0061.namprd15.prod.outlook.com (2603:10b6:408:80::38)
 by SA0PR12MB4592.namprd12.prod.outlook.com (2603:10b6:806:9b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 12:07:30 +0000
Received: from BN8NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::cd) by BN8PR15CA0061.outlook.office365.com
 (2603:10b6:408:80::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29 via Frontend
 Transport; Mon, 27 Feb 2023 12:07:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT082.mail.protection.outlook.com (10.13.176.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.12 via Frontend Transport; Mon, 27 Feb 2023 12:07:30 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 27 Feb
 2023 04:07:17 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 27 Feb 2023 04:07:16 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Mon, 27 Feb 2023 04:07:11 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <robh+dt@kernel.org>, <broonie@kernel.org>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <jarkko@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [Patch V5 1/3] spi: Add TPM HW flow flag
Date:   Mon, 27 Feb 2023 17:37:00 +0530
Message-ID: <20230227120702.13180-2-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230227120702.13180-1-kyarlagadda@nvidia.com>
References: <20230227120702.13180-1-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT082:EE_|SA0PR12MB4592:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ae2f2bf-144b-4120-ba0b-08db18bb33b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qDvvfn8y8N5JaMulu6MU/7Os6TEdEwqRVzH4KMpSkVSYPJPA1OHW7HWbs3u6vibFbBEnM2vFPJuPze8JJnp01SKXErkrTokUoOg6q/Dy4hoEnLJUICAVT4nZF+i2MKmDRoYte5ARVwPYSHQQzAYwwkBXajAnnoUnyf1Fh2vjjQXCUSQxMRz8SRnD2HzvN7jvxvBOnFavRvH44KMVkJCjX2CDbAF5NCyy5VNzok5z3YuwpOdAsGXA+U2SevNbLOdAJVuN6O6sJFv+kLqooqc44F6OaaOLzSwXCi7XZbu0BHriFKM5tqJDocVp8PXP22H5mw9EfmQrxVBbKH0Ae+EwaKkAQU94U5CLxsskJ5S41XulDFzFAGt+kkdGgYyHk8j5dPcSjRIQGcN4KOy1rWwLPw0AT482HFlyIdCestUcblkZ5zVURxoq3h0J+iJYVHH/VH2Wi2atyJMcmYjig0m7fuhTnN/i2Ls+3xPchuIvxtffVL7dzPQfZOalsie3+LLHI6c+4KC/qVP0sPjwhTYAeCsJ/zBaB45PJA+jS50rNZIrJeG/DsKXXVYBTLeg2t5M9cVMEZv0e9T/lnLUneSNKx9aLbvHvYvTNE8zoaCSHZoSh5b2qIvdMgwlDm38+r9mIzg8qAQCd/g5Yp8WJ/PLoIC586kM9swz0vpV0UNRJ0uvTkXceDwzXNc8I6BOEQkpB+xEDsbLA72/Rdnvkx+Yh0wXOgWqCL1hF9boi2pBIZ9jKPX1EjsQrzhA9KCgcdNSi6S6J3KRJ7nHbdiTvAAJdry8f57JNx/b6JDqGmjWLS6vCrhGZfKbBUdOXYmQ1SmYbbVY1l7dIr0++mynmvyqaA==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(346002)(136003)(376002)(5400799012)(451199018)(36840700001)(46966006)(40470700004)(2616005)(426003)(336012)(47076005)(478600001)(7696005)(40460700003)(110136005)(316002)(186003)(26005)(1076003)(54906003)(6666004)(107886003)(83380400001)(4326008)(70586007)(70206006)(41300700001)(7416002)(356005)(8676002)(34020700004)(5660300002)(8936002)(36860700001)(82740400003)(36756003)(7636003)(86362001)(82310400005)(921005)(40480700001)(2906002)(2101003)(83996005)(12100799018);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 12:07:30.6459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae2f2bf-144b-4120-ba0b-08db18bb33b4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4592
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

TPM spec defines flow control over SPI. Client device can insert a wait
state on MISO when address is trasmitted by controller on MOSI. It can
work only on full duplex.
Half duplex controllers need to implement flow control in HW.
Add a flag for TPM to indicate flow control is expected in controller.

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 include/linux/spi/spi.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 4fa26b9a3572..6b32c90e9e20 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -184,8 +184,9 @@ struct spi_device {
 	u8			chip_select;
 	u8			bits_per_word;
 	bool			rt;
-#define SPI_NO_TX	BIT(31)		/* No transmit wire */
-#define SPI_NO_RX	BIT(30)		/* No receive wire */
+#define SPI_NO_TX		BIT(31)		/* No transmit wire */
+#define SPI_NO_RX		BIT(30)		/* No receive wire */
+#define SPI_TPM_HW_FLOW		BIT(29)		/* TPM flow control */
 	/*
 	 * All bits defined above should be covered by SPI_MODE_KERNEL_MASK.
 	 * The SPI_MODE_KERNEL_MASK has the SPI_MODE_USER_MASK counterpart,
@@ -195,7 +196,7 @@ struct spi_device {
 	 * These bits must not overlap. A static assert check should make sure of that.
 	 * If adding extra bits, make sure to decrease the bit index below as well.
 	 */
-#define SPI_MODE_KERNEL_MASK	(~(BIT(30) - 1))
+#define SPI_MODE_KERNEL_MASK	(~(BIT(29) - 1))
 	u32			mode;
 	int			irq;
 	void			*controller_state;
-- 
2.17.1

