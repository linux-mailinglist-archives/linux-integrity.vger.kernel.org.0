Return-Path: <linux-integrity+bounces-2524-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C83A98CB18A
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 17:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA66B1C20DCB
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 15:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164D51474DF;
	Tue, 21 May 2024 15:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fsQk5hfh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500A3145FEC;
	Tue, 21 May 2024 15:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716306036; cv=fail; b=ovn6EvUI2XgQT0/9Dw0FABZNQ65dGedNntuTxNB7zRb8TA0DYFHyir07xmTr8onBmVHoJMi3fAJfw/mognMwodSmCTU9Nu1pVY3IMUKkZ6XwzZaVlJJbML/JNRmMNypAvkeWLejNmHlzWXgVGnVAjD2dqJknh77Q88z86dsvtgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716306036; c=relaxed/simple;
	bh=04tC3MvLf7sx78NuG+EoTfAv5tCEZcqOxdWpjefUJtI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SJjKufCqJIJ0DA6ix7Pqgpf7Ul0BJaWpLxQbFpnwAdq5CD66rQcImYJGxSk2oli4jkYt/PwzC85qO2xolThJ2pi/8eoxABVaj4lsMYa+LN37DFc2fvbEmG027DjazCAN/DkJJMc0+AbHlp9lBEtFfFuW4lwyFa06QQfNXF2wIZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fsQk5hfh; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSZmYio5yNxD/SG8Ag2wIqHrJ/nMwjD5jDpq9v7gaTcKxw9F+rHx6b64roTFq1NKNOavXkgqeBSRMQ/pE3xQkuMMv0cHa40jah/pi1vrcJalQ2voYJTbqUcERnFgkFxXsNg5sbi4fwF2+pk5x3MVHx/1iAkW71P8RMiiWTuiPIBL4QAc48DssAZLpO0d9enq0cNBVHQt1zSyYecBT9DlclWhodtDHuxHcHSchGOBfLBMtDUsMMVEGSBwFOeGiYxTIRRw9XR9ktSbQgEeqVb4/C15YnBKWx0iqDIL0c9z2HPXwyyLYekJIdPZTKSdCVPqrQ7+JRfDs6PDzFEdDp1xkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdCwqLfYDXi05JnN+SLTqvbSFDhn77qXPaUEgiORz7o=;
 b=d8tssA/OyK/DpRHg71I44JW+Nzkfpvrk7nfPepry/68IQK5orY3lbOcwMXXlzCKSz4bD7kDMWKXQwZNRbmpGP9q33H7XGSWDqLa3/tLehcqt1bmPN+9IMllYPhPzzfTZORXum3tGSZgLLW0PF8QXqghj4O7neY1jVj5yPsMYGItxQUrFa7cw62XlBl5R0dvUKu0rp0snqG1ExBCcpqneZvQoFO5CzNlP8hU5+VaIX8CyeVWOfGn/VkN7jEJwiuOZKgOJjJBJ1+cSxOGQ5/9a2isVjbFyVt/n/S2gXBurCxyIbaHtbpjLrtR4cFZAWU5C4GXGNy47jLoG9Wv/qLgNMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdCwqLfYDXi05JnN+SLTqvbSFDhn77qXPaUEgiORz7o=;
 b=fsQk5hfhmJdEMeQxOIuA7kOnNpyv3PVIYqPIDHVCgM47ZpDnVN/NXM5Hfh1kmaSsxBvYguh3+VCwa/R14KjtCTOS3f2eXTuFSFgqWxW+99r7ssNupG349fNfVaM8KvshNo22X3g5R63SexDwsk+iz0Rz8jJRx+4Hl2h9ttcs76QDT/4bgFjnsVunhIkuyigVXYGqI6lTjhF4lLNEmiiXqynxNRCjKXU/3l8rMQoHIb2UvRUPgoZ6QxM8G650QU7btrM1OV1NMAL1I0sEtAHCvGdTpW28KNVYIZkP2i9c2o+a60lemY5hanILLKsjdOgtP2ntQjC8a330sZ0LDTKPyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5954.namprd12.prod.outlook.com (2603:10b6:208:37d::15)
 by CY8PR12MB7362.namprd12.prod.outlook.com (2603:10b6:930:52::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 15:40:30 +0000
Received: from MN0PR12MB5954.namprd12.prod.outlook.com
 ([fe80::883a:d386:a572:80c7]) by MN0PR12MB5954.namprd12.prod.outlook.com
 ([fe80::883a:d386:a572:80c7%6]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 15:40:30 +0000
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
Subject: [PATCH] tpm_tis_spi: Account for SPI header when allocating TPM SPI xfer buffer
Date: Tue, 21 May 2024 08:40:28 -0700
Message-Id: <20240521154028.3339742-1-mochs@nvidia.com>
X-Mailer: git-send-email 2.25.1
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0165.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::20) To MN0PR12MB5954.namprd12.prod.outlook.com
 (2603:10b6:208:37d::15)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5954:EE_|CY8PR12MB7362:EE_
X-MS-Office365-Filtering-Correlation-Id: fdecf461-b02c-4d2a-d7a3-08dc79ac5826
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hl7mKkeUXaQW9Vx00Da9NnYYVBoZfQsnm2cl2Z/kSLD7r+QOSPyTYYTB5GYh?=
 =?us-ascii?Q?566u6OcGMvcniVRQfOk2xWEclx2YRQrkfQsyauz1osWt83XEpVSwmb2FaPc2?=
 =?us-ascii?Q?xvW94hHc7+iKTCQciVGScQej0kykWV7O/M3IRUq3AFtawPE8YhOKGQLqRZKG?=
 =?us-ascii?Q?XoNqL92WUEwty7IK6bC7YmVNIDVcysajTLBcwW+4SQ9GiRMT0L11AI6ohqqH?=
 =?us-ascii?Q?IDjoNjKMX8OGYvuL8wXYv5CSAXxChkQhBbdpd5Ayj6qcMpNuccj/NOUrYEo4?=
 =?us-ascii?Q?DYZHx8AbquZs+H1873R/ZLlErM7XVajs01GoK5pF9IciZwAdCV1gL0mhpAtI?=
 =?us-ascii?Q?2aYDy1+XzreV/uGBA/gNvg6i7Mk+FP3427Ud4mmreuTgJAf7/PoHbuYGcLHr?=
 =?us-ascii?Q?a9qjn9DueT78GattsESr2nKLs49vDpkXcxP2HFCWysMHBJmhHjmr5uRgg24t?=
 =?us-ascii?Q?ueJzJMxVECd78mGyoHn4bCFV+yrx0A1yaaXTGLOEev4LQktWjvo+VTHyN1OK?=
 =?us-ascii?Q?RH0ex7gn+qT4z5PQT/mWf2s6+CbQPHov9+dWaaVON9N4srTs+GxCb2LYYnNM?=
 =?us-ascii?Q?5UjJD5SxZKzs50I/aPe44vUb1ehYoESn0BQt9SduucZyC8c7IMhEGZW5PWhT?=
 =?us-ascii?Q?7sgf5+rtgF3/yc7Jck6purbnb9qtiiamzL8W2NVWSMnDsmcRwuHMgLZlDIQd?=
 =?us-ascii?Q?UiZbFGrcNH8YaF7o4zUN8lGth7+5mfC8eYL6MDl1OzY4B2zEkTXVnTaXp17Q?=
 =?us-ascii?Q?3M+uLu483pk6JBkC1jCrJ+H9iKP9n7YqMdaU6TCayft+mALLAJqSvGH2g04A?=
 =?us-ascii?Q?r9U/jetZXAt5Hx8nDQmHZXtNRc+vwJSC2bEzhav9nB2/adb0BdhJMgv07/TL?=
 =?us-ascii?Q?nTfdiFOL26qItVq3OrbLfyaE8iCQKtA9ARDRVBb3GxtyOpODDIo9CUL32IA7?=
 =?us-ascii?Q?Px+YjO/pzpJrfeIfEqvV508XnsRPVBPpXVrcxwcfvkri96Cbpgtzu3+x1HtY?=
 =?us-ascii?Q?R1vHbt6vqgNBntsunuk23SGduTRzWmQe11OMqINRF2FRC7aFsGHfCgSMWrkW?=
 =?us-ascii?Q?4eM0WUemokwU9h7BPSPvcRPoJNivA35XkdifNQJeQIRLVNi2Yyr2FACK247V?=
 =?us-ascii?Q?0g6HzfWq5gulwfXaQdJb/4JwNWERUnKoD733BEwcTWiK3gd/3ptcq40MfI66?=
 =?us-ascii?Q?p/gEtumG/xioIH6VHq4GuHFG31IRgWgznJKRj6bX18R7QXrbaGGnKmh+GZio?=
 =?us-ascii?Q?wm0+15gG0DuSXYZ+6DUyorYgNscfm5/swRwCgBeupA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5954.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LsiNFuoE1T6Fdv1wyInGB4WCA1BxcVAHmjisC366oH+bkEcVxBwuJHxad2F0?=
 =?us-ascii?Q?j9WaI2ATA5I8jayjcTk0DqvoUnrsHmZrplwHKuq+mx3DLqYjI9AQ6GTHCd3s?=
 =?us-ascii?Q?P3P5ETSyupug9mrvzBx3u8Y1cELB1tYep/9bNWCLDFs/Qx9S1H7pLFsvDxM8?=
 =?us-ascii?Q?nxht7mcIzqIM4zrM4kWCHK2g8cbw3LjlIeaa+MpGdoBIYFYXQ/DdpGD45jOX?=
 =?us-ascii?Q?vkqk19LN8tZCZBeOxRVPbTZUfspMUlWVdUaZCNOkHiGYYakN4mpjJLpAGooL?=
 =?us-ascii?Q?4W0UJ5PzRAudE8CYGquQTtOAgvOmXp7MfLc9oXAqm0j6oYNvRAodHrtKdh6i?=
 =?us-ascii?Q?0Nu/X1VgZkO1vEhtTbVu1WzQeZYaD0ML+GjIR5y3wWeSQ5/kbkbtsk+OwBOP?=
 =?us-ascii?Q?Y8WrV8daMpknw9oClvsOCFnQmTOqpxZrQhrhA6H24rRzFoywb7Ubo5DZr3uL?=
 =?us-ascii?Q?vKCQ24EHX3yKaC0AmmEv+ytYN/GbBf/Z8LPvtPapW0rm4K4Dct3HPBsfEcah?=
 =?us-ascii?Q?cjiIGQ+MBqdJ6jzfktaQVi3I7ZkzGGWc+Y+FuzWAUTWXG23XbeZwdI849Bj2?=
 =?us-ascii?Q?s9KI9xa7I9rKMtcjf6OT3we4RON69myIlhE8L/3vOMYhT+YuAxJi3LIqoa0Y?=
 =?us-ascii?Q?opyf4/NyFCmvAxAJMm9pvWO0MY6JHfu0x5M0oGQVCEddgnmjybGdI+LQz6ry?=
 =?us-ascii?Q?382H0uyyPJNclgqbZs4rGlxrEuuNQjwyOYyShCVlEKryIhxfT5L9xb6cSRS4?=
 =?us-ascii?Q?6PXLdh4muTik6RquGrzmOYbz1KBHJ4W+py+z3OHxPpX51w3UqyaspIuvU0/R?=
 =?us-ascii?Q?sEfO+rq3gbF9jCX/y+iiSEiKZ9zmhwd7PCOXLiwQ07krYNgCsiu/6xH9fKZj?=
 =?us-ascii?Q?Dx2WWP9Q1QL258UTWKpU0a3E46b7dl7FARKCUKH1HnsgfJheIQ3B/Y8NEeN9?=
 =?us-ascii?Q?2pKzK7rzUzlaYUI+48QV1CTa1r+1SUBXOX+GZeaDksIhs+Qtfv1a5gZBN16N?=
 =?us-ascii?Q?q3cJP0eL1g6qhJ3bMGUBG76yYhIrq/uN0hGDBiKnaTbRmdGxfUy4Ueu4nqYY?=
 =?us-ascii?Q?6lz7MNZl7WP71qi1UYkl2gs7pMlZ31ZmvBEAFBIctLIm2XsCdWKu9Swl/Ygw?=
 =?us-ascii?Q?Ty8G8uANsuG31NBBGla1z6JkQ+YUdQO6Y2chWSyNSoL3lF63e/1NCx20m7P/?=
 =?us-ascii?Q?xp7Fvc869fs4LPZnLIyUW1DC3iz8ZXzlQuYTAqc+W6lkFG2anCFl54KaagAb?=
 =?us-ascii?Q?WVIz3Z76I1Y86bY9Wx7cHlXVh0Ycj2Kv7JLM6g55h/a+NMhS950+yrJ+oh3A?=
 =?us-ascii?Q?ZOXnixhkXr20YDEu+PxKoeWgIYYllDZvjBfpDd7Pg7UI4ku2QaUJjim4BWFH?=
 =?us-ascii?Q?ue6htw/WUjjmIxnXZ1PpT4omirXCBB2mkCrlg1CXXDZHFftvqnJFVeH4H/r3?=
 =?us-ascii?Q?B04h8pPYuFiie86QxnZQzvxICw5MvCBlx1M6oW8YXW5bghKa0DrjuvoyJ67/?=
 =?us-ascii?Q?ngDgazNvUrS0aed97egpfRgCaSq0ChGmzNzO0tqggcj77T1owNsdf9DCESO1?=
 =?us-ascii?Q?t7kSc3os3CquK0TnU0xMYJ7/IoufuKOVpYJywhb2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdecf461-b02c-4d2a-d7a3-08dc79ac5826
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 15:40:30.1284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ofe8cDHVSlSMBXVjdUyVR8RKeydy7Bc9yToZK+LQiGCC/eo/SOiKfR2ZlEIyg2mkdC0lqx90abbiVGjyWCjGBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7362

The TPM SPI transfer mechanism uses MAX_SPI_FRAMESIZE for computing the
maximum transfer length and the size of the transfer buffer. As such, it
does not account for the 4 bytes of header that prepends the SPI data
frame. This can result in out-of-bounds accesses and was confirmed with
KASAN.

Introduce MAX_SPI_BUFSIZE to account for the header and use to allocate
the transfer buffer.

Fixes: a86a42ac2bd6 ("tpm_tis_spi: Add hardware wait polling")
Signed-off-by: Matthew R. Ochs <mochs@nvidia.com>
Tested-by: Carol Soto <csoto@nvidia.com>
---
 drivers/char/tpm/tpm_tis_spi_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
index 3f9eaf27b41b..ba50eaead9d8 100644
--- a/drivers/char/tpm/tpm_tis_spi_main.c
+++ b/drivers/char/tpm/tpm_tis_spi_main.c
@@ -37,6 +37,8 @@
 #include "tpm_tis_spi.h"
 
 #define MAX_SPI_FRAMESIZE 64
+#define MAX_SPI_HDRSIZE 4
+#define MAX_SPI_BUFSIZE (MAX_SPI_HDRSIZE + MAX_SPI_FRAMESIZE)
 
 /*
  * TCG SPI flow control is documented in section 6.4 of the spec[1]. In short,
@@ -247,7 +249,7 @@ static int tpm_tis_spi_write_bytes(struct tpm_tis_data *data, u32 addr,
 int tpm_tis_spi_init(struct spi_device *spi, struct tpm_tis_spi_phy *phy,
 		     int irq, const struct tpm_tis_phy_ops *phy_ops)
 {
-	phy->iobuf = devm_kmalloc(&spi->dev, MAX_SPI_FRAMESIZE, GFP_KERNEL);
+	phy->iobuf = devm_kmalloc(&spi->dev, MAX_SPI_BUFSIZE, GFP_KERNEL);
 	if (!phy->iobuf)
 		return -ENOMEM;
 
-- 
2.25.1


