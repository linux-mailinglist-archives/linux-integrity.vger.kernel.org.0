Return-Path: <linux-integrity+bounces-2544-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 534DF8CB8C0
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2024 03:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C32951F254C3
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2024 01:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44E24C6D;
	Wed, 22 May 2024 01:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EKbJM84S"
X-Original-To: linux-integrity@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD9DAD59;
	Wed, 22 May 2024 01:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716343179; cv=fail; b=KuXaWK13SLP4SS6SPdECpT9hxJzmoJQceIAPevGqYx+6K05rY18ANQlmbaIoCyEg2zO1XkJsWYMCxFlhh3yriy/lU3QIJoRlwUTHxqJh/RzQSiiKpeDmtbO7YR5NmdxepKsilXHeZSR1OeCGxDrd6SOEEE+p30f721wQztsqhqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716343179; c=relaxed/simple;
	bh=Q3VxjgWtv1P6PjXnFYNhw1pHOehZR4StsEveeoi2+ss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e55tqOcYUygHAqfu5x9uy7FBIgTYzOOJZ94oYXSJO6zXvzPyT8++b34kY0AdW7kd+2W0KYh3oaMz8rpPgUVyL63jJDHkQH6VSUq6IdaSP3lIUJnU4h1KUHuYDSj4BY3w8SCtH3KlZQ3L89sRUBVWH5V+Pd3ZjQvECOY/nkhmrt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EKbJM84S; arc=fail smtp.client-ip=40.107.237.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNKCcUlaZ28yurEXmEMWGrPUYsVYqV5NO5CsCXVhmy94errBAmwqEL37i8NbJKAIxRdRzqPVUWN3OmJ6D3jybE+a8Sc8cqGfz/xDmpHQi7llt99caxhg98jYGEYySZiqi4WsIQz1wuVagJHMe6u2SKoy7FnwhH9/etLLN9aSPYqSIu3Pg7lLq5oeVYRPGeF2ZHXf0h0454qDWIcB7M+CC2CPnFWJYr5o5S4Yubv9s2508aGDnKJk5woxbbDqbTMu0AhotvMAmwFCYAjlDEHerpaPat77JEH7hGzjzda/6YN30xIQrtH+h+OKqgfwYLllITekTcqswCyOdXPK7N6SfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vj6jjxlf6VLToN2OE4gB0UVRjxY3UREOqUl9487+pE=;
 b=ed/vafJ8C2ego4qsXjXWfaHRc0Eapz/ohFLAtQEr5nYgxUCd2Iou2foSBTX2JT2ajL0B/QIaHxPtRypnfFIWy2HePQeTNp98Dfy+MQA3iBnHSJuMhpGs4NgHQnFaGVQ+0wV/2N5rqqsU1kNHry23l5O4LbUCD1fel04gbakPAJ6dg6TLr+5GF2SutEvFWMVv64ftJlOrdyGjuLTCAelGU5COmIANPlaInkBs/k5CfuTEXMy50Beo348FXdPb0RvMZTD+8WzgLApAB8Nmfxbm4lljcgOrWT2s9Qg09bz+4cnrSH+RqU1YM7wOAyeJgUWn0DgJ82xZBjXvib4XG+xYIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vj6jjxlf6VLToN2OE4gB0UVRjxY3UREOqUl9487+pE=;
 b=EKbJM84SWZf20bLzG79JP827LuUJYhXDX/e7ZPx0311yYelKH5yLNWvyreEKiBMxacBEe4cHUW0HFaHmOQzZ3EjGpW5oNXRR/PXmEz7PBUvPel27/Wbi1emHnjnzOCzn0ebpF9Y6sxufcG6Fw7Q1bm9Jtl5pgEdkH8sbUION64uJkq7raJG081ABYw6yH69CfwqFhi3OVZ73TdGhzcPLC9gShRyxeCcKxFdgNI9oMcw2I8CHVA2zpB+ibjIVhJR+6G9c8Y3Ld/4DUQA/hy/HqMwSvVLklc+lhMq/wWefGTHlRuRaeIRXu9slKXTzBOkeENzgfo4vvXorPBkH2xialg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5954.namprd12.prod.outlook.com (2603:10b6:208:37d::15)
 by DS0PR12MB9276.namprd12.prod.outlook.com (2603:10b6:8:1a0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 01:59:34 +0000
Received: from MN0PR12MB5954.namprd12.prod.outlook.com
 ([fe80::883a:d386:a572:80c7]) by MN0PR12MB5954.namprd12.prod.outlook.com
 ([fe80::883a:d386:a572:80c7%6]) with mapi id 15.20.7587.030; Wed, 22 May 2024
 01:59:34 +0000
From: "Matthew R. Ochs" <mochs@nvidia.com>
To: peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	kyarlagadda@nvidia.com,
	linux-tegra@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: va@nvidia.com,
	csoto@nvidia.com,
	mochs@nvidia.com
Subject: [PATCH v2] tpm_tis_spi: Account for SPI header when allocating TPM SPI xfer buffer
Date: Tue, 21 May 2024 18:59:32 -0700
Message-Id: <20240522015932.3742421-1-mochs@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240521154028.3339742-1-mochs@nvidia.com>
References: <20240521154028.3339742-1-mochs@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0078.namprd03.prod.outlook.com
 (2603:10b6:a03:331::23) To MN0PR12MB5954.namprd12.prod.outlook.com
 (2603:10b6:208:37d::15)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5954:EE_|DS0PR12MB9276:EE_
X-MS-Office365-Filtering-Correlation-Id: 997f2cb2-76f9-4e47-b804-08dc7a02d3f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FmwIVz2sgyyIAZC668z3j6ghIWPz65mMn9CaLN8CralLeH2bq6VGnRqPZszQ?=
 =?us-ascii?Q?L6mT6ZuTkkdKsKGr4x2YqRdHYzdUQuaavEPwkRBEsbwBVGnHzUWHYkE1FK7y?=
 =?us-ascii?Q?xWeFjZjfNeNt9t5uACGqlq82ES9v9g+2GuqYs09RrQ84xI8a16V7Wjw//LHY?=
 =?us-ascii?Q?Resj09TMCDoIgaGwiMFWntn0gcczzOT5GrhVjExRnGycoBKdanv768V1U1gd?=
 =?us-ascii?Q?gTLPW9HorP9rOMQGr7EXmGrRp9hw6kIU5Ozhw2d+BAHpK6A8KA1nVdw42Hss?=
 =?us-ascii?Q?VCLNDGTpJpSCtOlD+KhCg/LAMJOeBhTxhYiAqXVXCXU6iaM3S/Az9uccm952?=
 =?us-ascii?Q?mwtIXEEve3zcdhY5aateuh3edpulIirFlF3p0MogAd8Wa01f0vsSQ5RAPBlF?=
 =?us-ascii?Q?WXm4aRoKgRAZo5Zyr4rpwSH3KPjpu0hqhCtAgOum8Dq2F6IYYs20NWzRs8d4?=
 =?us-ascii?Q?6gTkwTucEbEPdyFDkz/cdg77YWKZhF7Tvqi4LV9A5ShwjNjqJW34VYqgIKV+?=
 =?us-ascii?Q?vL2f9ZGH+XEHfhFAcZ+mtikXpP8/Xf3m2G1H49LIj25/DIA7T0wqxkhAAxY5?=
 =?us-ascii?Q?BC9qJMdMhNE6K/MqG+Nm8u6v7FoJGCStrIV0M6vq6SDF5+uzymTznO6RhOfX?=
 =?us-ascii?Q?uAuiQXPBdfkZUjkRvUUrued31JvOB8xZ72cC0pj8f2fz6njc9T0Os+y/rD2X?=
 =?us-ascii?Q?GwaQPyxH0oVG3oPIZAspLm+t8ud3Bmzyz974vxTs/0mwE8fTpa36O9ag6/+l?=
 =?us-ascii?Q?Zlvt6CC06rkRNunQ/nI3zuLTgPjWtGHPgIMrGYS7iSRJSZkzGun4WEGdMqy3?=
 =?us-ascii?Q?RHPtRfPm9K8lWsNdhP4MwqcsMOMXk/efd44Af+1ncHlr/73vkRj1OyVgoPj/?=
 =?us-ascii?Q?pQa55XMi79U92zNCNKHpBxa9EUxpC56u2Y6JM5f0PGxyywWXwGWgjl91Lcce?=
 =?us-ascii?Q?IYNz6Yv5HTDJg7P8WfxWBGo773znOSI95SO+t0Ra0yxYc3hpxEjgRQmDEesq?=
 =?us-ascii?Q?cdAghROX9WerSw+zvLyoXwwJ4A7XoLxWNmXcj9FnmBEtQHfY29fDGffdYNr4?=
 =?us-ascii?Q?PImNmITRSQKN5b8J+I+ZA9eIR7GMe3t3gjh0peJPwEVnK7+vfOEzz69zRmoq?=
 =?us-ascii?Q?uy2OzQgtD9Gz3pDWs1ejwyge1nhjWUlhBdd35uQ0PonOJ1SWOe3aIotMmwgr?=
 =?us-ascii?Q?ccf7Mof2yLuS57o78SabGI2eRW4QmTzADSOyyKyCIrzUIkQTs/XlLQX1Xv1I?=
 =?us-ascii?Q?HDjzTvP+iL4NJO55QokEGfCBwCnJNl9VYwQVTY6eAA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5954.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iESwovLYbaN/9Mrh9OwgknlEbAMB4w/M5yb3dXfGOY+v2eKT0krNKnNo3ZOh?=
 =?us-ascii?Q?Fkj0fZZUaue5QmBA23BaffVR/ibfx6rKR2rsDNaUtnX8n91V5C4WJr/YcuPg?=
 =?us-ascii?Q?eI2eNXi43IsGF4PzWOUWgajMhwpQ060AprAsWRmPbWngcZfbjxmW11HmcgH9?=
 =?us-ascii?Q?48Qj6VtIYYLVfaQgNCT1j3ChJWJIxL3/Jmz9whZg5R8NAaEGA8RW1HBamNko?=
 =?us-ascii?Q?DCZKjvw2jP3Z3SAa8i4DVi4hiMf3kny78wMrUqoRqSBl39d3lp0dzo+7LE9v?=
 =?us-ascii?Q?kpCPczOIqoRBq/EDcXVZKaFXfL4I4Rab9PN4D+Jp42Nvp4V0thU1F46lpJIa?=
 =?us-ascii?Q?yVjMi208BuDpJEaRLdOXS7a8ed/Y29ZzDY/CYBu8slSiLiIv87R0cjES7Lnt?=
 =?us-ascii?Q?p4ls/hGiiHT6CuU5Fob2k6hrkCUR+UVaBDhOcregIxsnVYgzu99cux0AKqTZ?=
 =?us-ascii?Q?NWZqINOndt9nnHwai3WGXJJLmGfo/udbYTnqDbx4eD7YtDoCVlIsayTzZkEW?=
 =?us-ascii?Q?4V6ZJL5cQJBshQZqzZ9zqvmRFPM7+pc+77XHcZjy1BRWJGjkW7Lbrw9ncyne?=
 =?us-ascii?Q?q8UJ+FXGUHi8HJJngBXzSwi79tuNQ0xk3XIDlJVl0dKkPaGD+Gdh4OYHEOcz?=
 =?us-ascii?Q?EFtyDaNdsbny21KMsYf5+OOsw+0cBfRopk7QU4Ic6NIMl/pgFpN6ah3sRGdq?=
 =?us-ascii?Q?RlwXw4YBkon7kzgy3kfd8EzdcT87h4jIbC2ZF3i5qqxHwR3sojkqWxeu+ZcU?=
 =?us-ascii?Q?L14LwY04spyo0n/nUDmAqT5wsq/n/FwsMrRYfR74zp9+zWhMaSOpZeioey7S?=
 =?us-ascii?Q?Q4am2p+5vE8DJlaWoVnBcNhTWflLuBo+ER4C1849uc9qSWL/Z8E2SRTStrrn?=
 =?us-ascii?Q?EEM+hTvP/+En40pWgyqtYSt02mxqROkXvITnzX+Tbmi4laMGeOXN4DmVjLS0?=
 =?us-ascii?Q?u13EgW3DyjTsJEh2UzRk0fsHC7d40phPjAue0ZEkbyLKdq6uUZo9ErsEANDo?=
 =?us-ascii?Q?4slFxrnAOdWt5eA5jTIqUGcXWA57cgS3iLMWVPXXkWzj/1JVmlIU+zbj4eHN?=
 =?us-ascii?Q?9rogy/EckTAWeIMUTMaX3z45PtsEVcQdIDT/KmRHsM1O/5kLD7+h9HXnfDwD?=
 =?us-ascii?Q?a63WeAlC//jLziqBGS7TF2SZ8r1JtItewzeql54CDZjpvO0S8vJvfgXZ/bxv?=
 =?us-ascii?Q?CDlBOmVIJACg5o5xGGxhGC3Pq9OFEjNB3Hx3f+Qf8wFA9JEXEfRIJ99nTQf/?=
 =?us-ascii?Q?eqrrXy/ICNGGxTo5GwHFzcquiHD9NdI6ei+fcsx/G2WK6xwTMmNr5HNmnnkm?=
 =?us-ascii?Q?4aUgxrxPcxXz8grRJuMQq7Bidl3Gjct3Qp3fMsE0e180loV3oRYL8bL8vW62?=
 =?us-ascii?Q?PPvy2Z0hj8rgWsH9dwT33KS1YTddFOip7qZt4+crzD2TfPPLpLg9aAH84nh+?=
 =?us-ascii?Q?HAlUOakBptuLSOAduFTA9DzOkwll8j0Us6qv3sXUNYh7M+OtXRnd2ISwnIeX?=
 =?us-ascii?Q?wVujCwiMzNyyDlk/0E1fgY5fbnvFkpWUTL7+Z77g/USZwgUCdTUWXPkLOxOr?=
 =?us-ascii?Q?6Uy7qak2MsfdxofcorAGRAtW/xnt69a/iaiwOuAw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 997f2cb2-76f9-4e47-b804-08dc7a02d3f7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 01:59:34.5570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mdEIjPqKooctc2DG57IV3A0DxIwR57ogt/2eH8stJO1UKBqz1PR5aXsECHh7kl/81MyDd/ES2eShVaVDk3R1bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9276

The TPM SPI transfer mechanism uses MAX_SPI_FRAMESIZE for computing the
maximum transfer length and the size of the transfer buffer. As such, it
does not account for the 4 bytes of header that prepends the SPI data
frame. This can result in out-of-bounds accesses and was confirmed with
KASAN.

Introduce SPI_HDRSIZE to account for the header and use to allocate the
transfer buffer.

Fixes: a86a42ac2bd6 ("tpm_tis_spi: Add hardware wait polling")
Signed-off-by: Matthew R. Ochs <mochs@nvidia.com>
Tested-by: Carol Soto <csoto@nvidia.com>
---
v2: Removed MAX_SPI_BUFSIZE in favor of open coding the buffer allocation
---
 drivers/char/tpm/tpm_tis_spi_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
index 3f9eaf27b41b..c9eca24bbad4 100644
--- a/drivers/char/tpm/tpm_tis_spi_main.c
+++ b/drivers/char/tpm/tpm_tis_spi_main.c
@@ -37,6 +37,7 @@
 #include "tpm_tis_spi.h"
 
 #define MAX_SPI_FRAMESIZE 64
+#define SPI_HDRSIZE 4
 
 /*
  * TCG SPI flow control is documented in section 6.4 of the spec[1]. In short,
@@ -247,7 +248,7 @@ static int tpm_tis_spi_write_bytes(struct tpm_tis_data *data, u32 addr,
 int tpm_tis_spi_init(struct spi_device *spi, struct tpm_tis_spi_phy *phy,
 		     int irq, const struct tpm_tis_phy_ops *phy_ops)
 {
-	phy->iobuf = devm_kmalloc(&spi->dev, MAX_SPI_FRAMESIZE, GFP_KERNEL);
+	phy->iobuf = devm_kmalloc(&spi->dev, SPI_HDRSIZE + MAX_SPI_FRAMESIZE, GFP_KERNEL);
 	if (!phy->iobuf)
 		return -ENOMEM;
 
-- 
2.25.1


