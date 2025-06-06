Return-Path: <linux-integrity+bounces-6379-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 873CDAD07E9
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Jun 2025 20:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4781A173BF9
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Jun 2025 18:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541E5289E19;
	Fri,  6 Jun 2025 18:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ldw4Cuh/";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ldw4Cuh/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010032.outbound.protection.outlook.com [52.101.69.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF2E28C2B1;
	Fri,  6 Jun 2025 18:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.32
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749233610; cv=fail; b=aFZH/DkWQMPTN399GDdmI+PrNpPqjx+kkf+cuZlgA9fjeogAhR3wCaNobys1yWXWB8hU8anUEfX28FRwmL9jCIlzr+o53ucH/eVrCzpFS13WC87tFOgZw+V4aB/XBTcKBWsWX8gYEUymaQUc73NcWsoaG2+WbOwO1X3dkhpJ9LE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749233610; c=relaxed/simple;
	bh=9fKv+jSnmrkCzNdltPVhwRNNKrxBspls6baCPhLAGk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oMWAaZm31LKz17v5I1SfBvoFkPsh0lqex+pgqS0sXBxr9Ltyer1zBJIyKBahHaXeadB4c4jG+mAVfFMRwh7tjp0XlB0Tjs/wyo/n5z8rFV07KQUPT8x4Sob2VZw1UueTN7io4PhJPH3c3jW03DG4NSgvJwSoXdwqgXM53XYmMkM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ldw4Cuh/; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ldw4Cuh/; arc=fail smtp.client-ip=52.101.69.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=xhx1JKEp24qMjXgcUJQD2Ho6qttoi2dDCRzRwUBwXivswgXli8ImbMlAX550+40V//bxcsfSidGph1xA6Gii7sLP3MkorSk9ya47TUc8664ao12vHJCc+GN59HmdhMD8ezF5Gfm9I/tmaOVh63oOYg3eusCU1WrvoZgjdcq5z7kbKW9TaBdwJmNm/NfaucTBM/SixJSAijgbTxvrQLO9f+98c4QHJ3xl8DOpyxqXlhb5/j0x9M4car7UEJgxpri5ClNB6JlA828vhAdBSTuMYelOMjs0CmcTST0E3eXCxG4OaFzE1AbvsgU5bCwIkacrRYv8O/958M074M+2olu9dg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7mX9wSQ4BfnYuSVvhmOK3/1tdxGEs4gabJOjVgbP57Q=;
 b=v0Tzlm95dvpgTACG4KtP8mibEvgtM7DSxWblzEzr8IHDMzDyvgQxGuF8g1B4tq2zLn/QJQ3l5QQ/38G3dsrCqBofndhP0m5LOItDiXGB5y6uIFphWRxj3qGo96u/E288kvMexlEPGWHyfUWCEi2iFZ1HVPRSYUtwcMwQ1p4PYCGOjU90XYXpyWWrzQwxTgsKEya2+338jKo6yx3+Q2kE5yrtYRhDXpiLlWa+RRjv722um1nv91NSPVw26f3LqtJifi/BsF46Obaw0MA3bWJTRctMlVXlPbiGmV57MkKVgk8m1tKnAiz0KhZjtT/uLDUs7AOvwfNRqwE2ZkYzoOhVvQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mX9wSQ4BfnYuSVvhmOK3/1tdxGEs4gabJOjVgbP57Q=;
 b=ldw4Cuh/H582xul/0bHn63pT6IOVa9VZKy5r/QK1GSmnHZOxAf2UDqwFaw5DVSDTacPzutfmOZVC7B7ogGlNHnHG0JFSrrdKufDM+HCOSRUdIfwvS+LfrQ2e9VM+B1qsARTMLHgBheXhXOq72BMJgVZXJsAkkoT7kQ+zonMPQAw=
Received: from AM6P192CA0102.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:8d::43)
 by AS8PR08MB6232.eurprd08.prod.outlook.com (2603:10a6:20b:296::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Fri, 6 Jun
 2025 18:13:20 +0000
Received: from AM3PEPF00009B9F.eurprd04.prod.outlook.com
 (2603:10a6:209:8d:cafe::a2) by AM6P192CA0102.outlook.office365.com
 (2603:10a6:209:8d::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.28 via Frontend Transport; Fri,
 6 Jun 2025 18:13:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF00009B9F.mail.protection.outlook.com (10.167.16.24) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.29
 via Frontend Transport; Fri, 6 Jun 2025 18:13:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KCOSK/ss5Y5hcsjIpfFkDwzoGm7wCd/qY0iHiZiPN466WIRUO6WYNQUhd5nv61zPXo68IJ+zYXV0ox3L6HfgbLrx1xrxJyGQj+cIu2q0Owkf/iBb/BjgkZT3pqTcnoEx/8+S9/LrcfGeoqMAp41uzBo3N1OoaQiBl/ZgRxVBoClAUWaGV2tB8MBCVB9BhBrbOvZn0JUy3xx9gKKMehCd3is96xniLDdngRjapD3U4zITwvowvs4tuv91E5lkTXie244jGAmdidSSr7YtDg0iPwo3V928KODDyDVaRBglI0J/uITdXRYh7xr2i/L9PPLJsW7PdFSF59rz9T3GBhoqPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7mX9wSQ4BfnYuSVvhmOK3/1tdxGEs4gabJOjVgbP57Q=;
 b=MAWAUETOWBQyILMX6xaXCaHABCMhvtwlpbISSRfr6CDf2DYaxoSX4gKhy2IECCgfE4tWF7iUnDyUcrmv5wieuvgGgiqYNq6FVVmu2v8MCsf0PikL4qcHs59ugDmKC4adW8SMDuHaQanzobzUElKA2S7qNt7WbXgnjGua4N6z0P/w4wsdUjuEkxKjAVd9AWWGNB1+hG11UeElgoqqAbogabwYTXWsV+DgYoEMpiOv4yy72Y32AlYoj+cKvhyEZ6E7nO7eu8gVTDqhRyF3EEGz2YaUUPZCfAH7KYDP6AiiHjwEuKWy/HEeSXPcYe/d+nGJSmls0/D1R8W7+pa1t6QJ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mX9wSQ4BfnYuSVvhmOK3/1tdxGEs4gabJOjVgbP57Q=;
 b=ldw4Cuh/H582xul/0bHn63pT6IOVa9VZKy5r/QK1GSmnHZOxAf2UDqwFaw5DVSDTacPzutfmOZVC7B7ogGlNHnHG0JFSrrdKufDM+HCOSRUdIfwvS+LfrQ2e9VM+B1qsARTMLHgBheXhXOq72BMJgVZXJsAkkoT7kQ+zonMPQAw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by PA4PR08MB7433.eurprd08.prod.outlook.com
 (2603:10a6:102:2a4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Fri, 6 Jun
 2025 18:12:47 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.8813.020; Fri, 6 Jun 2025
 18:12:46 +0000
Date: Fri, 6 Jun 2025 19:12:43 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: sudeep.holla@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
	stuart.yoder@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH 2/2] tpm: tpm_crb_ffa: maunally register tpm_crb_ffa
 driver when it's built-in
Message-ID: <aEMvm2MW9bBXf2gM@e129823.arm.com>
References: <20250606105754.1202649-1-yeoreum.yun@arm.com>
 <20250606105754.1202649-3-yeoreum.yun@arm.com>
 <aEMdGXXBSym7cXmK@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEMdGXXBSym7cXmK@kernel.org>
X-ClientProxiedBy: LO4P123CA0329.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::10) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|PA4PR08MB7433:EE_|AM3PEPF00009B9F:EE_|AS8PR08MB6232:EE_
X-MS-Office365-Filtering-Correlation-Id: 63a3b9cf-6640-4060-f220-08dda525d101
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?tJG74Rt6jW/pn4Kx6qRILKHPrHfZaDXdvM6jIjFmF5OcSk6WrarurcfSKbBi?=
 =?us-ascii?Q?b/7w4TtwlL+HlirtGNReu0fqfN1XkLz1uvdTTP1n8QBcGfZER4GlmcuEqBSB?=
 =?us-ascii?Q?lvP4XzmhwzNmydZDbMw4lX4VN4J+ZJ65Qqwcysl/3X8xkVBV2GZNnKUyasSp?=
 =?us-ascii?Q?OXOw8+25vq4YOw19lxgNJQavT16+j3Zcf4cu0zRp37r+1W2Ddjwul8lVURkM?=
 =?us-ascii?Q?W4VXRKrfTF5dy67OAaLo+LPGbUSN9Wi1OZFd6+m89JVIBGT4MsoLt3imWaXc?=
 =?us-ascii?Q?b7yUxvr0x1ldn5KFA+Xkmz79JT1JlYnkIiVhAQELAFsRY2ij8CLLdQbAcr8E?=
 =?us-ascii?Q?gSDVt7n164bskxPcx5SHpKLukOSwzOQYYCrBwNdkNvO6mtbO+WIBIFQT8MHg?=
 =?us-ascii?Q?9qO+tbTO6PHmuyNvB4jMSWJApL51RYA3FrgQo4UbNn3KIP8fUKNz0x1cuPu0?=
 =?us-ascii?Q?8F2XEIuaxAaaywe1fZjzB1mlZt5mCayMAfmE0LSCEdoyd2RMWaFl3xFi/4pC?=
 =?us-ascii?Q?Bl+KFgWAjqAlij7apCrfBFHbycJcr2CClUlDPqpC7EM/6h8Qb4UGEVZhBbOb?=
 =?us-ascii?Q?PcrV/81wx2F8ZI4r9nu77tc14QO4CRLkejB511Jxp3DV1znf7mNPlm5KXFTA?=
 =?us-ascii?Q?CfOG94gKtbWA17PsPA2OxTtSan/TN/rJcJ99IWgQ+k4GoxjWvc3eWDSOKfVD?=
 =?us-ascii?Q?IAZkdQtS+MwfUBwNVE71+1/86RM8ghbYK8CRZisXjIWiyyawbZLsrUBd9q7w?=
 =?us-ascii?Q?KdaE1Sbs9L4/LBOV/JZQvW7C/tNzM0wj75pShOKte0Jw2K4ie0K+WOhOP4MJ?=
 =?us-ascii?Q?6JqpqMrMsn+d3T9rf8/gQcmbWYfutdzlT/RamtZfZT/OkGZFjPaegXxYdiaL?=
 =?us-ascii?Q?Kr1g7/JJG0QLi16xTIWH+f/eIqWbWxWTFNgcLgtBd1ZCskuww8q8MYeFWzSo?=
 =?us-ascii?Q?qjp6b39pMlAdb3nBd5vyNHti2UYIVqsHv/7T43MlSqfYwaMKreXjjLbyZPpK?=
 =?us-ascii?Q?0iKPftbtZ1YPf6/vIWjuhAMyfkM4kysT6jDDzWK8tDN/ABTiYjouiuBbXIdE?=
 =?us-ascii?Q?nc5ZlJrOhYVfOLMY84uJT3125K64nuSZ7MHP3+sQl4nYQ2RNM/FkuhfXY08M?=
 =?us-ascii?Q?MiiKnRP1Ax0HzarJ4K9+1ytynAnRi0yNaTrTz8q04apbpnkAV3+oupd9dY1C?=
 =?us-ascii?Q?0StfIFp+nug8vJbZrpj4jR75qWrpqaIp4dlAzuj+usXmDSzX6tC5cYiUPOX8?=
 =?us-ascii?Q?ZtCXOHsdhkOhgKkI5uu7hjAZf/LDm0CO7pxkxoMsZV3IDbIbOj0fqO8ik2dz?=
 =?us-ascii?Q?99ERYNnPdfSVTL3ZAZt9mMieIxd32yXaMki6zrgOqExCD0mA0gyE5wvrkPS2?=
 =?us-ascii?Q?O0TNnTDwiNbYnJUaG/0M/y0G/BYofXGjPOLilZEBNWpfLf2w/rwJozeKVL47?=
 =?us-ascii?Q?AGnK7LzTVZs=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7433
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009B9F.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	eb0886b1-f48f-4a8d-feab-08dda525bd6e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|35042699022|82310400026|36860700013|1800799024|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s+2WCFVVc57gvc2tiwWwOrfiQk3cKHUfN07GSdu8DsIdy+BbBKOXowIkGusq?=
 =?us-ascii?Q?XpwYn6SJV+nvKnr6/7rV6cisAUc5oegu3me7xfkEGtstuzhV0kE5zi5QyJqk?=
 =?us-ascii?Q?0saCAvT+qg4ssmQqm58mTrf5+dCocRTUtB7AaAzdt0iA4WOBbh+FVOoXTBqV?=
 =?us-ascii?Q?PH6be/PoWFHOgbysq7VVMJx0u23TaNZA9KFU91nS04PYRyOlaMeD5YppN/gD?=
 =?us-ascii?Q?6b3QHi5SLrGiu0PlIQg1wzRVC3QnRII5rZteQJ/WDrEIakNJuTtJMEp1qbZM?=
 =?us-ascii?Q?PzHPP2Twco7lOEBTBvh04kk1qYnxXbnT03Z9cPUurhemr1sHKMSeofNygcNT?=
 =?us-ascii?Q?yLuV/BbSFA7EPe4SsR6liFBOVbjJka4NiOz8NoauYaI6xcFJg4mUGWCiVVNq?=
 =?us-ascii?Q?6zxzEXf86KaFIHcaMd2k4FaNFwMYlrK730LAl9iKDGls6IeUhBI9a0jEFNaT?=
 =?us-ascii?Q?vUactpzVGFSnxi2HpLXfS1Jd2JNvnlYfBWGT4rdknKhbXGIyyOfGG011IbTV?=
 =?us-ascii?Q?8nib/4Hiputx8dL85hu1QxxtW7tN/HcdBkgZwu6slayBWjYFWp/cT8Wj3hry?=
 =?us-ascii?Q?vLePcNPEx5r+0W9h7DWpT0tQha2kcjFnf/CL7Tr9oHGLoSr4LzDNBF6rRew6?=
 =?us-ascii?Q?BpAxTh9Yf06Tqao2rTP/3iyHVil+of2+XPDaffalHYypZ4zwoqA0SPZ1Vmcv?=
 =?us-ascii?Q?lF7QvWnnn6PhtBofq+9uk8M851sHRsGY2AwOjXaeptdTK9B4WmyOeTM7tPgj?=
 =?us-ascii?Q?q8o+LmYWLIrQhjQmKJ9C9sNq9YJk5SttB2NVcEAMAaDOIvv8MSewOxJ23hMD?=
 =?us-ascii?Q?/dR9R7apWQQkb6lORFKuKM9zTdwoycpeabzAo2XpAB+UpsBRdezNXrAhNegT?=
 =?us-ascii?Q?N2iJ/Dl+ybp+mD1IvYxBopvTxOS0OiycA4zhXTStm3dHhPkysGrlcoKZ6U4k?=
 =?us-ascii?Q?Ab17n6Y/BvObr2aGkmtcbRotKOXz4lrBvU0cgP6FOf+CZS5GO1TnhLs/tCht?=
 =?us-ascii?Q?63t0zU82B95pr+RQTghoKlcysT6NrVzfuW0/fKg20IAzasXpXBPFH4XaewWo?=
 =?us-ascii?Q?1R34sEN8WnWL9DrOv/kxBboLfjN9Xp97kGXvPU4JX6aC+d70AOwGlk4do4HC?=
 =?us-ascii?Q?D1hBGvHYIE8jbGXYta1vn15EBbItrQ0P6J5OKeKnb90OYZBDINQJ+1To2lnO?=
 =?us-ascii?Q?pwR1ovPUrAcb3K8c0Ron7WaRVmtSq8RjamiTMk3druIAGcsv+jNQiujfe0bl?=
 =?us-ascii?Q?oN5uwacX82uikj+JIT5vF6gRTP1VESS+egUSndGAaHARwIX3ypfvXqWz1c3c?=
 =?us-ascii?Q?VHy0jpeGWWg5MvKrUVJYeunGldW8q0aEkZUqFuKS136v3wSLk4x/TVcEt9Ct?=
 =?us-ascii?Q?SYISP+AWtRLfZ1mnZqpNZM+tj5q2mDTayHmc76PcDkhYdbQmRODrdWUE4jsd?=
 =?us-ascii?Q?7Vb53VWUFawUigC/8IkGQXCrTrvFlEY7Ep5DYMQ78jhGQS/3dLeWx5rMG2H9?=
 =?us-ascii?Q?Cb8+VCPuz6NxMZiogu/Qt4bBR0pptnDAeQLj?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(35042699022)(82310400026)(36860700013)(1800799024)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 18:13:19.4472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a3b9cf-6640-4060-f220-08dda525d101
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6232

Hi Jarkko,

> > To integrate tpm_event_log with IMA subsystem,
> > tpm_crb and tpm_crb_ffa driver should be built as built-in
> > (CONFIG_TCG_CRB=y && CONFIG_TCG_CRB_FFA=y).
> >
> > However, this could make failure for ima_init() gets tpm chip when
> > each initcall function deployed like:
> >
> > 0000000000000888 l       .initcall6.init	0000000000000000 crb_acpi_driver_init
> > 000000000000088c l       .initcall6.init	0000000000000000 tpm_crb_ffa_driver_init
>
> The only failure I see is the patch 1/2 which changes init call level,
> and leaves kernel Git to a broken state.
>
> It breaks the famous "zero regressions policy".
>
> BR, Jarkko

Sorry, would you let me know what is broken more detail?
IMHO, by changing the init call level for ffa_init()
it's called early than before device_initcall() and it seems not to
break anything.

What breaks do you mean?

Thanks.

--
Sincerely,
Yeoreum Yun

