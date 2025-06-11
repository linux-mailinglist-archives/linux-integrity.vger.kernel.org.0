Return-Path: <linux-integrity+bounces-6420-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32031AD5D51
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jun 2025 19:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A397216DDD2
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jun 2025 17:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBE620E026;
	Wed, 11 Jun 2025 17:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="O3mJfL/p";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="O3mJfL/p"
X-Original-To: linux-integrity@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012052.outbound.protection.outlook.com [52.101.71.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFD919D890;
	Wed, 11 Jun 2025 17:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.52
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749663408; cv=fail; b=oDyCi3eKjg1qhLDar8NZHcTvjeLSbOekp9zSgfJymZ1wPIu0Nk/gyImWO9LGcmuBT1HJ6J6KYvQLAez5Vh8DnZYDeHjaFf6AainidInsQFEeIRJa6JTb9MtqwZk9yZZruGjMjpIgBnwn9fudbxWotiVRfenyJCMam9Z0kpGdG0M=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749663408; c=relaxed/simple;
	bh=UbafvI1GPeJBPP919CW986cI75hp6PSJEL8rEQ8nphE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gu5jeGBctuj4xeF6Nzv7uzvqbB/4ovQPShwBXj3P5TQ9Ca/F/lIdjeR0zgPJhaPVtLNmJ4q22KxuXB70I0FrBBNxc155ymcxIqY4tCHyKkJI/0GgK6ZOjIu6bLCs4AXag40yzouxfsJS00zQuu1jD8rgRRrvIQXJAZMR3g37j1k=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=O3mJfL/p; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=O3mJfL/p; arc=fail smtp.client-ip=52.101.71.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=eeTOZviOce4TFtmP+11bD2tPdNJXMrvFIPugk9ji+4OToTtugyhiz+7XhA5WkB0n34jKTVwduj2oGK18QVu+Gcd15r6l9CO9M+nlvZFp4tURkLjPIRfRWRlX4Mu2HpbNi4a4FDCfLkzcSPqncg5RkgA9opyiQ23uft0r+5SSc82M9qzNBbeoigAK6EfGzmhFJJ1Ie28ma9kiTCwvgaJb4nVveb/PB4i126HE4pWxSGEN5hqeAZAgb77199H1GGe24vjGwJ5Nl8rx0dy/4AiAgF2c4dSTBI6qY+nSYJRLzFEvnnpXTQ41b+8yG+d13TwHWkDal2Qnsx/F6oRDx84Qtw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHYGCqvD5MlLcG6JyowXfJFCUBvr3KIbGzG33IdZCn0=;
 b=g2wbU9DJ/V3u1sNjDF2vMgfxvTchQeA29CLl3B9Vf94tuSkxLOm0NHlrxQSk6ImzOvKPF59go0/w76DchYLAs6r6B4G2gdOHudoEs/JYNkFc3TBGZqZpRxnmZu2YJ1q96Jep58D5ZYwbS5+FBiDzt7nzJhNvz0l1BbVwEB1TsEmStofb7bd7QAYqzEt7bZBvClS6kykhAdB49+ylUQ0NybixdYJtlPvfzhN9qUClCAWZ6EQEjqmNhwrEYSslgmxkZewaAcn+SOhzX03kWJoUD5T3bxOJJgX9LwQSxTQjadYikgmcUu2zJ297xwCR47nmDzTveGCAvdc/PfYAGlD+mA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHYGCqvD5MlLcG6JyowXfJFCUBvr3KIbGzG33IdZCn0=;
 b=O3mJfL/pkOFm+ap0ex+uE8Eq+cO1o8cDOm+ozX6AcbY62XZ3ssOew+ce10O+7fcsxMlbPpJr9OPL9l4RNZslUwctOz9nTSmMV08zsUD6chnoDEAxuZxW9F74xd80CRljZjGoM69bfhT8rkQ9uJB3CCNJkouKO1nhHJuntFWlGFY=
Received: from PA7P264CA0251.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:371::19)
 by AS8PR08MB10025.eurprd08.prod.outlook.com (2603:10a6:20b:630::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 11 Jun
 2025 17:36:39 +0000
Received: from AMS1EPF00000045.eurprd04.prod.outlook.com
 (2603:10a6:102:371:cafe::45) by PA7P264CA0251.outlook.office365.com
 (2603:10a6:102:371::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Wed,
 11 Jun 2025 17:36:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000045.mail.protection.outlook.com (10.167.16.42) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Wed, 11 Jun 2025 17:36:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2V480xrSGEB6C9Q2T5gpq9/RIKy0yoeFKvuxqvDZxeWC1Oo/1S+hwL7sty33rCO98wpqUGo27ZyekUAli2qCJGkcVRlvdFG6Tjs+U22jrRNbaykz8PNV4iW6c0AwVm5fynKgTt1eEQzeS3mSr8VuPYqxB46mx6wb7Ae6Dr8RjZ+h9cCc+yDcjnPm+aGHYFn/MFot8lB2rGFcma6PE91w/UCk29pIKn1QhbQpwZGwxeI0uHJQb+rbqOMINmCyr2ZPxjureSwm1GkGinYoUVZDgL838+Fm1UYb8D6vPA5lNQzTtN8tYSWa6wRCdkLAvAUcG3qEE2N7ZgCdMC/ZEMAEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHYGCqvD5MlLcG6JyowXfJFCUBvr3KIbGzG33IdZCn0=;
 b=Wu/qKg+rhKf8T3aCR9Z7z2ZW83p+qZGrMwl54e+uzd5vAG76KqHenr/AiSprK4AIVnUq/ndE7JI1B3vu3En48xXZajMe82LCegXmQqdhSynv40pxhwcJZ5g7b+4pReF9pAdbLLx5tM02w/VLSO2yI8HBe95bzcvWNiaJH5KAfGKPOI2Jl+FtLbDUI7++RXeixTgvD++eUP0INDfzIAiz9R3jaIxaVqbA1TeJ8oz/ALAkreQeNuIw7agCQ0Ra7WXldpK99WQfj0uI3lpMHGeqsvYkOuhOkX8pKeq/t1BYZfT4JkqsLrN6jX2Guxkyjz7UkrBJ4iBw+AT/vWESgBiFtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHYGCqvD5MlLcG6JyowXfJFCUBvr3KIbGzG33IdZCn0=;
 b=O3mJfL/pkOFm+ap0ex+uE8Eq+cO1o8cDOm+ozX6AcbY62XZ3ssOew+ce10O+7fcsxMlbPpJr9OPL9l4RNZslUwctOz9nTSmMV08zsUD6chnoDEAxuZxW9F74xd80CRljZjGoM69bfhT8rkQ9uJB3CCNJkouKO1nhHJuntFWlGFY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DB9PR08MB6682.eurprd08.prod.outlook.com
 (2603:10a6:10:2a2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.28; Wed, 11 Jun
 2025 17:36:06 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.8835.018; Wed, 11 Jun 2025
 17:36:05 +0000
Date: Wed, 11 Jun 2025 18:36:02 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: sudeep.holla@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
	stuart.yoder@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 0/2] fix failure of integration IMA with tpm_crb_ffa
Message-ID: <aEm+gqyp0aa4ULYa@e129823.arm.com>
References: <20250610060334.2149041-1-yeoreum.yun@arm.com>
 <aEgmhwu1RP27yBpw@kernel.org>
 <aEgwpXXftXW6JNRy@e129823.arm.com>
 <aEg6Bgh8TqzK5nSu@kernel.org>
 <aEhDY4VlkIPYAjPE@e129823.arm.com>
 <aEhIPC95FisptBO5@kernel.org>
 <aEhNnAxlToRMteA2@e129823.arm.com>
 <aEmxaJQNfYJwSCd0@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEmxaJQNfYJwSCd0@kernel.org>
X-ClientProxiedBy: LO6P123CA0051.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::7) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|DB9PR08MB6682:EE_|AMS1EPF00000045:EE_|AS8PR08MB10025:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df18657-81c2-43a8-0653-08dda90e8573
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?havZOI/gGzrEEBQ+zDw9cIxogW6GKSu0cx/xV4LOQnfGdEK2vSnNm25N5ofJ?=
 =?us-ascii?Q?ezfFjtyiDmJueIL15XU+TNSGaVUyB79oWZ/NBolWUVISPZhk//AJiZgEjpyF?=
 =?us-ascii?Q?JOJ3LriADzkkV+W8U58QqKLrIepVCWkrgjbt2GOHM99DvKmbFZJD05JXV3cC?=
 =?us-ascii?Q?aLvSCDbPN+mdZ0SEtQ3St7AWbSx+jLLqg2r/tB+v7CZIjENnLHSJXAR7+zTn?=
 =?us-ascii?Q?p1cotyjnwM7jepr0ErYxMO0vYDa2rZCvWngGHZxc33/XHf3ITx2SHfEUvaJ/?=
 =?us-ascii?Q?Usgp1WsGrzjXh+n4IT+spr/gJbL9k9exD3xfKn+K8mPyUzyrsImoDslH7ldh?=
 =?us-ascii?Q?5fvp16D3+KL5RO9bcXcNgg1naNJL37K8TqP2pHMvxEGX423gipP68ypgMP+P?=
 =?us-ascii?Q?d31qVShY+tJPbXSc5xeK8+SLACw6T0T115xd26wvFKRI8mQaVcIzCjNa66tD?=
 =?us-ascii?Q?7YuDM3q/p3TJGKJwQq6DW02WSnqq+mOYChU0U8J45ynibfmo2y2VL5AE2rso?=
 =?us-ascii?Q?JM71cgTG+i+hP163nkIxZiL1NKnzPgkJkPg9N6k3KHbQ4+An1bjYq3gs30bi?=
 =?us-ascii?Q?5AdzRLWYZflvm7TAePIHEivBhx+UWyMoxo9vj+ihCHmJXhpjCiieIKm84Xoq?=
 =?us-ascii?Q?ljh4wjvgeyw8yq1w2gzrV4P0zQA/UtSWtM/Xel3Nf7coB80H62X0GYvO0FZg?=
 =?us-ascii?Q?LnUFNwWgU11j2mYGlbtYR0waYJFr5TgBa2uwtVicgA9CVUaw7OXqRmSoG5Xd?=
 =?us-ascii?Q?kgfXCRbhlrXdeKg67gIGz9nLWiISo6Xjf9FN5H6arFWtZM3cAjxYtjAHHl+b?=
 =?us-ascii?Q?jgzwP9d/oAz1m6ATLx4CndD52RrrV1qW/QZH9nbZIFJwrcYE8BGrAuO+xiOO?=
 =?us-ascii?Q?BG0eDWlQRDao/A61L6hrv6KjQVVw9Q9cstv9utjkidF2Xmy8IS94Y0WAXV1d?=
 =?us-ascii?Q?BgjFS31awK6Y1bqzBTGA4PmQtnn4bZWhqTjLv5tX8F2C8QNiSYcRbBRKzAcT?=
 =?us-ascii?Q?4clebjKomKCuLsoJcYQX/c2l4IihgDZ/zLFka4CI525qHI1vJZCNp47vdNsx?=
 =?us-ascii?Q?UkFU8vRMRKr2L1A12Vz49rViMsstNPvaL/9sR4VaExFBklJPHIMQJw7D5YDz?=
 =?us-ascii?Q?MM1FGnD8wEy1R7t1Wzcl/MqRH/pBIkyUSEf2gOqK0PG10liCnKy6nrLPC0Fq?=
 =?us-ascii?Q?R41YFx03u6E1p1oNAPRxk3zeJZhMg37BAv3OCpN+3O2723DI/3C59FzE8mx/?=
 =?us-ascii?Q?OnYTaPxUV6gXLVFBFkmPfcA5sj0YS/iwlND3vRsiPcUiGlYjCcHq4P3c0JWC?=
 =?us-ascii?Q?UoE0pROmsrZy0smnn/jC61i6NkUYLtHapjHkA39fdcEPbu0t/s1UN8PtweSU?=
 =?us-ascii?Q?0ZNHw66G1dfoImAhhJcnWq1xcAu8xwReSXzMIID6dxZ/7MOQUUnVwfletjXx?=
 =?us-ascii?Q?SpARS6kqsNo=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6682
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000045.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	867c086c-ee35-4a73-3f3f-08dda90e715c
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|14060799003|1800799024|36860700013|35042699022|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lJOywqLovYusONc2i6474e2LrBMEfAgv412erOVNL8HBQ5GPPGo7F9EReXbj?=
 =?us-ascii?Q?9aol8kdh8hfxIrDAsT+peAFRV0jOBjg26G7hXyvmN4Ywv3UX25LU4zfLclJv?=
 =?us-ascii?Q?V+hDXA6fEWUAAH/zye/pbnPwsqOS4YaDbYu3vIihkeLEas2fkgEB3WizJT2g?=
 =?us-ascii?Q?9n7MOPz1v6zKGsBItX4rFV9yNccq2cXr931S7Re7ouu2XDjcPEk4XKjdJl0H?=
 =?us-ascii?Q?im/2E5CEX4hEuSvc36cM+1CxHg7oAJQu3/BbFGRfpup4GmBrdj0lxK1fSR1l?=
 =?us-ascii?Q?LdehNvCXUNecbwld5FJJI9Rl7Th0YaK0Vyi5FjwYhCr/1UM4+mdnfLmLVanO?=
 =?us-ascii?Q?4Q30CPkgeoyxHIJY4DE7okw9DRzHu9hDvtfkXMc3OUIchkcJJUJTH9XFVDr0?=
 =?us-ascii?Q?DBLl9IB0oskj+yy01JPq5STS2JzhafmW+ei1GQvovJYHUVkEkril3qlFhJof?=
 =?us-ascii?Q?3JKHVwlQVRdkHi2RH1C+owdExVtly1nWEhKx2I4/VwBRHCkT0D3hOpya4bBM?=
 =?us-ascii?Q?xKmk86ILxwFQhcmELZ1dUH+zzvKLIkOphQqJKsYB6uh1SnAvsSKOP38D2O8S?=
 =?us-ascii?Q?9IfXE6/cFYH6m4DiB2NzeoPBYxzgGGQwIG09lRO+WwUgERF2+9K8xOuYtypY?=
 =?us-ascii?Q?+jN4gZrWJKKVfDBCgFTf9aL4+A0JQP8+xszOfiYMMm3QB0sdYikth2dDkpe2?=
 =?us-ascii?Q?QZvVGRkL3Cm4k7VQ5Rt33Q/nR3SFL8mp4Zw2BINo5l/92kMvjbZYCOb/wDzM?=
 =?us-ascii?Q?+liv7BCufQjqV46ZcmWQghdebDzl7aFdEsdGYKwsFkuf/tVACVKyKUhBWBVM?=
 =?us-ascii?Q?IpqU0pGqPGOBxnmHT2u5fTXUB9W8TjvZ7E9VT8rqhe5EShLL7f2dzQ//1EQC?=
 =?us-ascii?Q?eYp3qht+H9W1G18DBA8AOf2VwDedaVNkUW/eqN8av3vI9+7jNA9FUCt/49gD?=
 =?us-ascii?Q?DJwj5P/GTkjVC3nEQxhS6+O86+7Pn4bjGCjOoceVUr6qRQEX0ODIec76YKQK?=
 =?us-ascii?Q?KTrFimJuBqq7oie7t1BKpTi6DQtKytIyhWlycXP+2kgplnkC2Fr0SSmfwF3y?=
 =?us-ascii?Q?Zbh0pqnVOF06cs3jGiL5ygvl8fUx2XQtBfjHMguQWRASW0CeKUDgoXbLWzp7?=
 =?us-ascii?Q?whf7xrdDTDenXfMDgXwp6HzUHrHihIeofJ2DqKm1x/N8P0bRomUMkLAX3dxk?=
 =?us-ascii?Q?DILLNMzzBSFlE8YAOFXjjRtPtqrqG2PDpE3aaiUr/CiHOoCXEtNu6THRp+Ev?=
 =?us-ascii?Q?89Pnk/xRAQfUHn+Yp9pFU+FB03BiGKyd573PuQCy1g2e19SSEszAm5JL4lrh?=
 =?us-ascii?Q?9MDCAa4jv1svg84UqKrrz1sKIP/xU/ZFPQ/M8bOvMlCjWL2NvCNbJbdwwGFx?=
 =?us-ascii?Q?806cPc6gtA8fHLD0nRICONi2RVTUYBi9BBFr4GQCGoL7DN56T1X6uJwhEUsD?=
 =?us-ascii?Q?mQv84ostK5HTi3OOEHDIUfNrj0g++vwATzweyfalWLOSg4F57uuEYxsxFJZZ?=
 =?us-ascii?Q?FQ2dLtImMFubg+mrmUC83S8k8vWlfm3Nf4kX?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(14060799003)(1800799024)(36860700013)(35042699022)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 17:36:38.9193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df18657-81c2-43a8-0653-08dda90e8573
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000045.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10025

Hi Jarkko,

> On Tue, Jun 10, 2025 at 04:22:04PM +0100, Yeoreum Yun wrote:
> > > OK, if ffa_init() is leveled up in the initcall hierarchy, shouldn't
> > > that be enough as long as ko's can be found from initramfs?
> >
> > As you mentioned, this is handled in Patch #1.
> > However, although ffa_init() is called first,
> > unless tpm_crb_ffa_init() is also invoked,
> > crb_acpi_driver_init() will fail with -EPROBE_DEFER.
> >
> > Please note that IMA is always built-in and cannot be built as a module.
>
> Sure but if one needs IMA, then tpm_crb_ffa can be compiled as built-in
> with zero code changes.

All of my describtion based on all things are built as "built-in".
in case of ffa_init() changes the init level to root_initcall,
so, the ffa_device will be produced first before the trial of TPM probe.

Note that tpm_crb_ffa_init() which is the "ffa_driver" is called in
device_initcall level. I mean

    ffa_init() -> arm_ffa -> root_initcall
    tpm_crb_ffa_init() -> device_initcall
    crb_acpi_driver_init() -> device_initcall

therefore, "crb_acpi_driver_init()" can be call first before
tpm_crb_ffa_init() since they're deployed in device_initcall.
If this happen, "crb_acpi_driver_init()" failed with -EPROBE_DEFER.

That's why this patch is required to probe "tpm_crb_ffa" when
crb_acpi_driver_init() called to complete the TPM device probe before
IMA subsystem initailization.

Thanks.

--
Sincerely,
Yeoreum Yun

