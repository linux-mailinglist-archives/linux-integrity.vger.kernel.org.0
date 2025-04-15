Return-Path: <linux-integrity+bounces-5877-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB2CA8952F
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Apr 2025 09:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D52C13A912B
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Apr 2025 07:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106EF200B99;
	Tue, 15 Apr 2025 07:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mdhM6phQ";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mdhM6phQ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2056.outbound.protection.outlook.com [40.107.103.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2661717A31F;
	Tue, 15 Apr 2025 07:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.56
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744702403; cv=fail; b=SfBHZr3jxjcTiLJr7jJPT0Mg4VhPKEKPBDgPkoVTCWxj555jIYTJSe81Z8V8FFBxA+cQGwb/Dadh+WY4K1n9qy+nSNx1HAbVcx+PSTTSLmiFYxDJnJZywBnnOPZ4/MgFShwWVOLbawfE+P/dhJRPkueRU0Hh9GxljgrOL4RSt4k=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744702403; c=relaxed/simple;
	bh=zDwtJHqb1OprKjjHcHxhCn0U1h9bmGruya8T+9liEZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S5a9ZtnGsITy2RELEu3NXu/G32DadOupP3AbNEazrGWKnSjkZCG/hefc1uUkKpamMWcvphSmloX3wMMn50O9CxmXKcRzK6qyuDSnQypYvySZ5fiPQ57u4ozUlPE0NH8A12DtE5zdFrfDyg6jqoGB6VblaYq+EsFsVVcSbGXytHQ=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=mdhM6phQ; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=mdhM6phQ; arc=fail smtp.client-ip=40.107.103.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ZCqtK0UXjPtbNtAVQ82+sHN/EXxEN31sAcb6rk6/ErLm0Gk08pWizrkY0my8GQj+qTfrEaE+GDnn3+nKcechKvZuwU9pixIkFEiCxCyNNYqDJymsmlJrRZBABy7PPjtZhYSf/eUNh7gFa3Qk4GsJw9sbYeO+gAQMYbMtfZA+Lf9biH8thSh/Ie4Rq8vfadQgfeebZLsHsnP+DOzc5syttqA/h6fEwRM8RHm/Ym6MbmfpRqk3v1eGYvKdVOku6o+hYorcfGGDmy9nM/aLaOkm8ZtLFKBeXXNLRXlc4v3EpBnsSPitBfUaODorRsxTKPv8ANXzcLKYEQdUr9mjkiQ/vg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyZXh2FP5rKxN2CADiovsy2rESd7nMTwx+7Ac4VaSvE=;
 b=OpPm+3XEvlEjTOiaKT6Y4ja4TAxpKSwntUZYgTIPI+d5AsT1ukuldLlAZGG7FLr4N+wTBcOcOGx/3hu7u/Rxl0Y75CvFE85+Hm0p59f2KDZAFlS/2xKblzkUEB2UsgBBzKiXzZQ6AA9UQRbhx4Xfy6gDGi84CZlptyN5NB4TT94yY2VV1XVn83GpWDy+z4zDmOK+6tORCQupOKNLf87Oflg+AksJmwADH1VjyM/+tm2yrCD/NPrZY2NEg8pZfu5cqVVZtTeKTeO3FGdM+wkMRWq2tbDgg+6/CjZDmXbaXIuE2a2SWHLE/PJFtG/XNhoPVuxx+/ZSOHMuv9dj1uY4dA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyZXh2FP5rKxN2CADiovsy2rESd7nMTwx+7Ac4VaSvE=;
 b=mdhM6phQi93ycnIhk/lmGRKFoE00vu0p7bxZXmZIqlq7mebsKe2bO0txRER+b7PyH0xRfb/vmCYnbGM0xplgodx4AtXxFz8tbEPGBLrWeOKFDZ59O1G+nCNMIILjG0i6NhJCX9F5lpD+pBsaSjjRCFGY2LaonVJu3wqa8x4PEWg=
Received: from AM9P250CA0008.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:21c::13)
 by PA4PR08MB5919.eurprd08.prod.outlook.com (2603:10a6:102:e0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Tue, 15 Apr
 2025 07:33:16 +0000
Received: from AMS0EPF000001B4.eurprd05.prod.outlook.com
 (2603:10a6:20b:21c:cafe::fc) by AM9P250CA0008.outlook.office365.com
 (2603:10a6:20b:21c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Tue,
 15 Apr 2025 07:33:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001B4.mail.protection.outlook.com (10.167.16.168) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Tue, 15 Apr 2025 07:33:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l4TzW6R9Lg0ZN58e1cUJ746UisK4eDWe+nUV4coik/2Eg4SRCj+KaJyUIYAM21/W1L3Pzh76amImGo9C2cQ99WepHk/wtw6Vp9KAEIoumrhDRZhaIj9a5hckPGRzJMm9oQSuDbo/Lo4W6cvlSzPcHjU/EiweISTwYVItMg3QidtOs/tLLhe+XBsHHiU92o7x4/KRm6WQJlFUtk7zCu9Ib1mNcU9mUWaSrFWK/rpZw4rkmJf/7n2Q1qihGVeRKNU6v4hHtM727ovP1kn1Url9VLBBWvKUpx1SmIvyl5Agm6Rcf05JPoOvaee7Na2hyXidLleQK14d+2P4cpOW34v1Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyZXh2FP5rKxN2CADiovsy2rESd7nMTwx+7Ac4VaSvE=;
 b=ajvvEbBwP85D509I992Q2BHja/MPb5/sLdn4Z264L+83y2KMPthBPjeBVBW07XXE6h7imTZiNNCqEiwMZCuRJKUrXyl2Rphqn/6ebLu+AM5xGRZglPNQJ49fQKqlxwuxUiMcIHoLmVYqN0D9tx6tIvp8uRcGqSYH3RGcW17/dntDu/l4V+AejAYRB+abk4EDVWEqCcLIH/5bhHn64uGRc0gZFVIVMVKjUBRrXpNSvaCI/rVTaX1PbYyBtQtOakLW7KoxerhWsvQuG+Vjo8REhKu99ogVEh6QYIZBfKtZ3pO145IxweATogXRP83yn83GQ0fHNxGm6fBmv4Vjl2xnaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyZXh2FP5rKxN2CADiovsy2rESd7nMTwx+7Ac4VaSvE=;
 b=mdhM6phQi93ycnIhk/lmGRKFoE00vu0p7bxZXmZIqlq7mebsKe2bO0txRER+b7PyH0xRfb/vmCYnbGM0xplgodx4AtXxFz8tbEPGBLrWeOKFDZ59O1G+nCNMIILjG0i6NhJCX9F5lpD+pBsaSjjRCFGY2LaonVJu3wqa8x4PEWg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS2PR08MB10374.eurprd08.prod.outlook.com
 (2603:10a6:20b:547::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Tue, 15 Apr
 2025 07:32:43 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%6]) with mapi id 15.20.8632.025; Tue, 15 Apr 2025
 07:32:42 +0000
Date: Tue, 15 Apr 2025 08:32:40 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, sudeep.holla@arm.com,
	stuart.yoder@arm.com, sgarzare@redhat.com,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tpm_ffa_crb: access tpm service over FF-A direct
 message request v2
Message-ID: <Z/4LmB4iOFbHB5Sq@e129823.arm.com>
References: <20250412054721.1647439-1-yeoreum.yun@arm.com>
 <Z_0aBHJ16l-Vw72p@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_0aBHJ16l-Vw72p@kernel.org>
X-ClientProxiedBy: LO2P123CA0040.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::28)
 To GV1PR08MB10521.eurprd08.prod.outlook.com (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AS2PR08MB10374:EE_|AMS0EPF000001B4:EE_|PA4PR08MB5919:EE_
X-MS-Office365-Filtering-Correlation-Id: 400f98d0-9968-449e-ef5d-08dd7befc924
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?mFxYWZ73m7wMlwZuyE6kLzBGwipusmngKGHhJcq82U6bV4nIArzsrCF/SwO3?=
 =?us-ascii?Q?fHny9tFLs9qyqXdSgwR6h4B9T+xR8VGNgffXBnFcHPeMs/lO3zH9sC8+8oOM?=
 =?us-ascii?Q?AtyBDMMr1DtpPFyRmJYHuLS6GsKQLFScz7p/D0HzlzmQJfIgpaAmLZikTEhp?=
 =?us-ascii?Q?uuEgb4ISwX25K8/LNVXZSc5Cg0nFyVf9Xjd90BN+JiNZW8iVDfIWoJxMTvUr?=
 =?us-ascii?Q?z09Q/HvC6h7Nrd3CyMdsxUOXSyrt3Dw+Cy0Jya4JzBSvq8aTopfMyHTDVrRM?=
 =?us-ascii?Q?xthklFrfLqaQS5E3e0Pl9g1FfmKF6R09NGSgm0Ns8r22M+A/LpttoqiM5rSH?=
 =?us-ascii?Q?bUvMCP2PONrVNkbj6q75jZOm8UOTnO5yQO3PRhyuIIUSWWp1k3grrWyxkbzU?=
 =?us-ascii?Q?9Lwa0tso35cXvsgwEPF5VSeMthuuBJkgneGCAFkvFXL3DTXZ/slwdXqISnN6?=
 =?us-ascii?Q?LRbi2WuHVVSHZrGmy1S6MwZ1+xo2bUjJWvRFTcQ6FsdfBtAk9iSmTBuJ9QVu?=
 =?us-ascii?Q?RBAr4xdZmh8uFP21P971Zej3iIuwe7aOx31XSEJFDnyr/hwtxae706EHSTRb?=
 =?us-ascii?Q?pb6m1lj8pXhR4hQfmpAB8VyRaQD/u3EG9ulyOsc4/cSb7jKrVm+Ag6/j2FLw?=
 =?us-ascii?Q?uiF4HmLQoF4PaV80bKX0lPb3uUhBEeBOPxLzrZQy6sqc6Rthy0ngvnR1m5nK?=
 =?us-ascii?Q?ZcZj0Ct6WGfl1CZG1QQECmtYCG3QxBv98GN0a3kx6VnOutSsu4guuCg4PC6A?=
 =?us-ascii?Q?iRrWu/UZCt21o2XPWtx1P7xqgySnI9fXiDH3bdsi87vjPBl0mBE+2mGXq0oW?=
 =?us-ascii?Q?JUR2T4RRxgHkULT3pD8qlOAxVqPSf5AsAOtdAHarrG3fMWhcxEZaGq01wn0H?=
 =?us-ascii?Q?EOcyC2QJz/JDWxKhdSADSGm8jcN1vKzK01+wk+SLc4wP6/8KdDhjfUODRn97?=
 =?us-ascii?Q?EiwKt+w0/e+c3IX3wm9pEzS3FPZYo6cTIzKOBlXLm37wjz/SF91FDiLVKZl4?=
 =?us-ascii?Q?tkcPUQ0rGWaiIPKZ7t4PxF7VK3DYDYWQ+AKUacqX3yUw+p9yB67M+rCPtkZL?=
 =?us-ascii?Q?Yq7J2zebn/ZZCOb3kXRGNlHZyTTgOaTBhPN8sfVQ3pKY09dsbrJFxR0ietVj?=
 =?us-ascii?Q?oq2THU0WYnN+rvjLMFao/tOzxeuN+j155w0XAhEgeHv/2THr7PLNw09VuHhO?=
 =?us-ascii?Q?IlzE5yLYjM5qBkj+15hKJB5jc6I6yoK+/adTC2P7gORKrPUoVtr2A+60Zris?=
 =?us-ascii?Q?uXpUoQlJHKG+FY+esbjd8QVypxz0eC+X+UeLCobgP0X97k6Nn/IFCnq+kkzs?=
 =?us-ascii?Q?6PjSb4HyqYEzlUWzAyzAhneyznVVo8zFGav6aPhWVVgEE2xtnXze5keS4p8o?=
 =?us-ascii?Q?0nIHkJEoObebZwNQYVIO2rOqlddbSj1kqGQELpW9KW9bT456DJEsTG2nDK5e?=
 =?us-ascii?Q?Jzgo601ppMs=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10374
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B4.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7539f9be-1b5f-400c-ffde-08dd7befb4f7
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|36860700013|376014|1800799024|35042699022|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PMbCrYNkFNdgxuJi9kZOfFpSKqXFQL9PSHt5xbhXDgLbUgKyNEbZ0FIxTjOS?=
 =?us-ascii?Q?CINQLt4A2/chsLY3/Uy25VkQwrFgYKbkci99bQMFcRE4K6iP6JLJiTvteuem?=
 =?us-ascii?Q?pgsz6ybfa/8wJ0FrhpVIEO5h8/fJ/pyHdHitj0h6x0qDXxpd5oLPT4BJLwm6?=
 =?us-ascii?Q?e/4pnVuT7k6pPYOfQLsqWoYWK3lJJ5SwKHV38ZTrYh+WQ6qi5xiLP7+Z0GgX?=
 =?us-ascii?Q?FADzTeKUdTJNl8GWX69ng6QfpaqkHJfyIfbdv1YXpHG+TL8KHZjr8yDVEZ1B?=
 =?us-ascii?Q?N+aqFBcF8ZjsrVrJIcnNHMpnSajQhGVvsheSHKDonlicTJ6qtTuCLjEtXKY3?=
 =?us-ascii?Q?oQ1T+2tCuo3jyPdDdXHskiDjn1mD28y9bFCCmcIzB3boyRj5LrHI51MvCZ/6?=
 =?us-ascii?Q?WSSP+RicamoKZWOcjRhV5JDuhaXWYwYAL9cWur4wVU4xlPXZq3wD4J+NleUz?=
 =?us-ascii?Q?bYXwCSxxlo5li4HhOQUxhqgjX3BUc+Cr/rOezwpNmugWvn30AtEBj9xdC6es?=
 =?us-ascii?Q?cNqSYP9mWmJtp6IqjM2hIc8Y401Ugb107iwkO7K/pwR+kXpwGXfq7FOjS1Nu?=
 =?us-ascii?Q?TlMaA/U1vyWCRvsaONKSVmZkayhWh0iT/R3YiXq3s2jO5gq78NJKf4bgrmDs?=
 =?us-ascii?Q?ii6SDQnJRqdMu/4sQ0nnq0qMWxmkL804tpjO919UMgMhA6OozDK6tKgcLik4?=
 =?us-ascii?Q?qVAIHTGlkFqEFnupuCnzijcF8oY5nlhbBQPb+jm+1UlFZL73CY+JZy/iR6yZ?=
 =?us-ascii?Q?ZJ97yGAWiq6jL8KE1yoYZcjhXd521OeDqRncfFGHEwXwWGx40pPFxyadH2i7?=
 =?us-ascii?Q?e+z1xzErRykD07ugpYMIZKwLn+nRXWs+NfZworKV7Xo3WjedCAuVkgBcmq7a?=
 =?us-ascii?Q?gCZJRtx8i5nqYEvIr/wdEEABF4rLJwbnGyQm3L+uk3s0HKgmVIDz5Xz5deOI?=
 =?us-ascii?Q?n9iuIrXWaSY+f2iLqRh5fl6OS2fOnWsDYpHRYBLtddz6FXc9I3LJjA99zVtC?=
 =?us-ascii?Q?RKmlM5Ai8xRmoujagMP+c3bvr5SaFLa9I7pH5TY9O68g4IgRtzdwi20i/eY0?=
 =?us-ascii?Q?Dq9Zkj9lRfXz1KDjq5SdJ2mIIryKG67ydBGN260e+5n3hdLq4KxNV/me09P4?=
 =?us-ascii?Q?vHppHqEDsGVj1Uex1kJM92GS2uPf/aqsWR2Uhx9TANJmntMvzbA39Ab++6yf?=
 =?us-ascii?Q?qZOZb7uPd9WhaWrdBlXQfk4rZSg0IYJMHxLYscERt+/HdJ9x1tpn8X313p0A?=
 =?us-ascii?Q?tbM9SkxsmfpkagHL/CQcI9eR/93S6jnBpLUHY4pdcUNWlI/yM160mFXR+o9F?=
 =?us-ascii?Q?pbnr5yPJVH/1lYiE/gcmfJ3Z1vRGK6RwpNKYJhRXjGgNIOT0se/eMItJy/PY?=
 =?us-ascii?Q?I7xOfcbsbW4VB9PCZbYhlZLFgIoLPcwBWM2MndmcxC2Is05nelBVutiG8L85?=
 =?us-ascii?Q?BtOpHVJZMRlYbCVfs2vq2YoJiQhzX9efGuNhx1sYoqCvwCu1j3m/iZwrkJDJ?=
 =?us-ascii?Q?D1y/xo1pFoDgFmqm6JiFb023Eh/Bx8DOoTauSCfA++uj71ZTHqf+skr4Ug?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(36860700013)(376014)(1800799024)(35042699022)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 07:33:15.7582
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 400f98d0-9968-449e-ef5d-08dd7befc924
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B4.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB5919

Hi,

> On Sat, Apr 12, 2025 at 06:47:21AM +0100, Yeoreum Yun wrote:
> > For secure partition with multi service, tpm_ffa_crb can access tpm
> > service with direct message request v2 interface according to chapter 3.3,
> > TPM Service Command Response Buffer Interface Over FF-A specification, v1.0 BET.
> >
> > This patch reflects this spec to access tpm service over
> > FF-A direct message request v2 ABI.
> >
> > Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > ---
> > Since v2:
> >     - rewokring commit message
> >     - https://lore.kernel.org/all/20250411090856.1417021-1-yeoreum.yun@arm.com/
> >
> > Since v1:
> >     - Fix indentation.
> >     - https://lore.kernel.org/all/20250410110701.1244965-1-yeoreum.yun@arm.com/
> > ---
> >  drivers/char/tpm/tpm_crb_ffa.c | 55 ++++++++++++++++++++++++----------
> >  1 file changed, 40 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
> > index 3169a87a56b6..fed775cf53ab 100644
> > --- a/drivers/char/tpm/tpm_crb_ffa.c
> > +++ b/drivers/char/tpm/tpm_crb_ffa.c
> > @@ -105,7 +105,10 @@ struct tpm_crb_ffa {
> >  	u16 minor_version;
> >  	/* lock to protect sending of FF-A messages: */
> >  	struct mutex msg_data_lock;
> > -	struct ffa_send_direct_data direct_msg_data;
> > +	union {
> > +		struct ffa_send_direct_data direct_msg_data;
> > +		struct ffa_send_direct_data2 direct_msg_data2;
> > +	};
> >  };
> >
> >  static struct tpm_crb_ffa *tpm_crb_ffa;
> > @@ -185,18 +188,34 @@ static int __tpm_crb_ffa_send_recieve(unsigned long func_id,
> >
> >  	msg_ops = tpm_crb_ffa->ffa_dev->ops->msg_ops;
> >
> > -	memset(&tpm_crb_ffa->direct_msg_data, 0x00,
> > -	       sizeof(struct ffa_send_direct_data));
> > -
> > -	tpm_crb_ffa->direct_msg_data.data1 = func_id;
> > -	tpm_crb_ffa->direct_msg_data.data2 = a0;
> > -	tpm_crb_ffa->direct_msg_data.data3 = a1;
> > -	tpm_crb_ffa->direct_msg_data.data4 = a2;
> > +	if (ffa_partition_supports_direct_req2_recv(tpm_crb_ffa->ffa_dev)) {
> > +		memset(&tpm_crb_ffa->direct_msg_data2, 0x00,
> > +		       sizeof(struct ffa_send_direct_data2));
> > +
> > +		tpm_crb_ffa->direct_msg_data2.data[0] = func_id;
> > +		tpm_crb_ffa->direct_msg_data2.data[1] = a0;
> > +		tpm_crb_ffa->direct_msg_data2.data[2] = a1;
> > +		tpm_crb_ffa->direct_msg_data2.data[3] = a2;
> > +
> > +		ret = msg_ops->sync_send_receive2(tpm_crb_ffa->ffa_dev,
> > +				&tpm_crb_ffa->direct_msg_data2);
> > +		if (!ret)
> > +			ret = tpm_crb_ffa_to_linux_errno(tpm_crb_ffa->direct_msg_data2.data[0]);
> > +	} else {
> > +		memset(&tpm_crb_ffa->direct_msg_data, 0x00,
> > +		       sizeof(struct ffa_send_direct_data));
> > +
> > +		tpm_crb_ffa->direct_msg_data.data1 = func_id;
> > +		tpm_crb_ffa->direct_msg_data.data2 = a0;
> > +		tpm_crb_ffa->direct_msg_data.data3 = a1;
> > +		tpm_crb_ffa->direct_msg_data.data4 = a2;
> > +
> > +		ret = msg_ops->sync_send_receive(tpm_crb_ffa->ffa_dev,
> > +				&tpm_crb_ffa->direct_msg_data);
> > +		if (!ret)
> > +			ret = tpm_crb_ffa_to_linux_errno(tpm_crb_ffa->direct_msg_data.data1);
> > +	}
> >
> > -	ret = msg_ops->sync_send_receive(tpm_crb_ffa->ffa_dev,
> > -			&tpm_crb_ffa->direct_msg_data);
> > -	if (!ret)
> > -		ret = tpm_crb_ffa_to_linux_errno(tpm_crb_ffa->direct_msg_data.data1);
> >
> >  	return ret;
> >  }
> > @@ -231,8 +250,13 @@ int tpm_crb_ffa_get_interface_version(u16 *major, u16 *minor)
> >
> >  	rc = __tpm_crb_ffa_send_recieve(CRB_FFA_GET_INTERFACE_VERSION, 0x00, 0x00, 0x00);
> >  	if (!rc) {
> > -		*major = CRB_FFA_MAJOR_VERSION(tpm_crb_ffa->direct_msg_data.data2);
> > -		*minor = CRB_FFA_MINOR_VERSION(tpm_crb_ffa->direct_msg_data.data2);
> > +		if (ffa_partition_supports_direct_req2_recv(tpm_crb_ffa->ffa_dev)) {
> > +			*major = CRB_FFA_MAJOR_VERSION(tpm_crb_ffa->direct_msg_data2.data[1]);
> > +			*minor = CRB_FFA_MINOR_VERSION(tpm_crb_ffa->direct_msg_data2.data[1]);
> > +		} else {
> > +			*major = CRB_FFA_MAJOR_VERSION(tpm_crb_ffa->direct_msg_data.data2);
> > +			*minor = CRB_FFA_MINOR_VERSION(tpm_crb_ffa->direct_msg_data.data2);
> > +		}
> >  	}
> >
> >  	return rc;
> > @@ -277,7 +301,8 @@ static int tpm_crb_ffa_probe(struct ffa_device *ffa_dev)
> >
> >  	tpm_crb_ffa = ERR_PTR(-ENODEV); // set tpm_crb_ffa so we can detect probe failure
> >
> > -	if (!ffa_partition_supports_direct_recv(ffa_dev)) {
> > +	if (!ffa_partition_supports_direct_recv(ffa_dev) &&
> > +	    !ffa_partition_supports_direct_req2_recv(ffa_dev)) {
> >  		pr_err("TPM partition doesn't support direct message receive.\n");
>
> did not notice but there's couple of things:
>
> 1. It should be probably warn. Driver is working incorrectly, isn't it?
> 2. dev_warn()
>
> So along the lines of would summarize all this:
>
> dev_warn(&ffa_dev->dev, "partition doesn't support direct message receive.\n");
>
> "TPM" was removed because this gives the device info.
>
>
> >  		return -EINVAL;
> >  	}
> > --
> > LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> >
>

Agree. thou it seems not related for this patch, it's simple one,
I'll include this modification in next version.

Thanks.

--
Sincerely,
Yeoreum Yun

