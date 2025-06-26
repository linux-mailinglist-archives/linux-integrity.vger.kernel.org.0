Return-Path: <linux-integrity+bounces-6546-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DD9AE9C20
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jun 2025 13:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40E0317CED7
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jun 2025 11:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E881DE2DC;
	Thu, 26 Jun 2025 11:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LZy5d5w3";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LZy5d5w3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012044.outbound.protection.outlook.com [52.101.71.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE551A5BBE;
	Thu, 26 Jun 2025 11:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.44
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750935966; cv=fail; b=MuiJUInAcNfoyB3bNd81NKBPoIe/sTKYT6e2ZJa4eg+N+k1RwzfljGnTAvSXPtpW6oxXdzOR4NbrfC98B7oX8OZbNw/tQ4AiHu+OkjxZXCH0nCP6JKEbmMoxQ6GBawm/F4qf8tr+HXjpU1wgQYSsuF6gN4bkQtwdSOA3ZVO/t7o=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750935966; c=relaxed/simple;
	bh=CFcBAcCyfuJTy93BokiR2gWgV7eQx7lfXqnbMclEbQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s8qeU+JpviqQzmZ5NHyUXjLXDMApRPtWX2FhiQpzlmZYf0cXBX4OE4trAgEKeXLzPbhgF840VEig8N2r8xaU3CAFvBgSLFEz4uCT0zR+XvT+wXwQgzqkfFRuhg94pYqC7+4aioO8hmW+MBKy6KU0sAyXN3OPMXTA0I/jocX31FY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LZy5d5w3; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LZy5d5w3; arc=fail smtp.client-ip=52.101.71.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=lOH6m6PyFXxFCf7e1wgpxTJJwJ23liexEjKj22ogQEHCF5aqMMiYu3Zluy/OkjIIYPcXhri3iWj00LlAX4wjjfIu4QN0hemNKXA6VILKyP63rfpxhJgufglUh2D2AC9G4dLXGVqTNV2ekdwGSDZaARas8jEcZeEPGxt5NyhOWFsL+lYfM1fhcN6HmyuAEu0j8Io04x/kSaXmJ119RED7bODVwCg2pX+cN657vXFgVGJzwj3ZCUwHdHzk7IA46tJXnaiJB8zBzcChImdh8CAMQtFBDKTDh9PzQGsbIHOt3CnL/5EHOaRQGyMegAoEphh4DYtWIt+v36CKAo6kyq/L6A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFcBAcCyfuJTy93BokiR2gWgV7eQx7lfXqnbMclEbQc=;
 b=oVMM/6rAYjsqxdqYrLTzUXd6O715Ocq2Mu9ZB6l/9LgeXF6qhBut5CSZLkO8J7GcLc9XVGieTMWdf894oV7Jbkss45RO56AdxMGCu473+BNRkcrloJGlwJ12REQg8drVE/DhYBqImO61/eHmYKUxxKDG9nlF5eU+GBpBeyLWMF6j5lNu4aEVlo+rt/DL0J6R+ip2CcotspxcXTWIa3q2OydHWJjAjNT0wmhaDzGRglKXHzLa1I3pcnWhUrWa9p6mQw8R1MqcGTxNj2Itop3/vPHZ8wuRHU7kZbd8Jgqw33zbaWvPvp0/8o5eLeOPXnT2JCBISKXGGeEanyh1Z/4Cpw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFcBAcCyfuJTy93BokiR2gWgV7eQx7lfXqnbMclEbQc=;
 b=LZy5d5w3h4N3r1P3bfzuDLyi7VGwWv1l2V2euXq3yOkh6nbJa94810lp0Yn4CoD3ggUfzErlDsU+z63HK28v9g3hcK7No8Gqf2GfP8DgrJjkH/qmzZsK9fnZ4prKjPRV66LIEgrnTkuC3c+qh/o2+jhe0sdnZaTFGkq1+yUle/w=
Received: from AM0PR02CA0117.eurprd02.prod.outlook.com (2603:10a6:20b:28c::14)
 by DU0PR08MB7948.eurprd08.prod.outlook.com (2603:10a6:10:3e0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.22; Thu, 26 Jun
 2025 11:05:57 +0000
Received: from AMS0EPF000001B5.eurprd05.prod.outlook.com
 (2603:10a6:20b:28c:cafe::71) by AM0PR02CA0117.outlook.office365.com
 (2603:10a6:20b:28c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Thu,
 26 Jun 2025 11:05:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001B5.mail.protection.outlook.com (10.167.16.169) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.14
 via Frontend Transport; Thu, 26 Jun 2025 11:05:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y55W1wQT7Q48SE0mF8QnaPlcGHQxdcbnbeuLLmgEBtHwhoViO7n4Jt6slBjSQ1R4oDORUk/nKrYzInK9qEn6coyDGfsQwxvpafAz0fXlNqqotR9eFMhovuJHhCNMMGv0teUNIXLCLwstfFV24834gFByJevwzB2VL7WNaWqTh6HVoMVMT48245vMustSTNzUx4eK/CWGotv29feHvn3ngY/PjLNy3RDxHFJemzlTFmAjgM2dXwxP3ZEmOdb/3tksKpMKCCF7QqI+/KFaOdRv2WtiarmF7pQp2fOdemFpPHbXXwZNMToMcFeTlmKt5ci4pgbh6oL8gBeHRucMB72hHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFcBAcCyfuJTy93BokiR2gWgV7eQx7lfXqnbMclEbQc=;
 b=oPamqzrEZXDCejTA0G3fyt3FZkpW+RF+PD9yUc0Rs64b147vL0fmQ1seQ3AIxQbj1eZBquPTISJxGokhWDjdYWsyXeaoMdt8rO47JgrqLrMIV2vIrkROsoXWOsuKda9kMZPGDbuIKdGD7kYuTiao0n327co7UXNCzvaoRSgADMo9gVPPC7xFYGnKf1TPRlp1QOHQhKDub5t7Hqq3sHcD9dB1tx7N/j/kNomCRuv0N8oDPfIRTRJ2Kveahvm58xdB82N/BKn3zCKzwR76DlnvQC7h18j/zToDy+j8h2s0I6Sr/rRcjJs9bXz/eKVHEoRT9APBgWAASv8LyAa8zIXp6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFcBAcCyfuJTy93BokiR2gWgV7eQx7lfXqnbMclEbQc=;
 b=LZy5d5w3h4N3r1P3bfzuDLyi7VGwWv1l2V2euXq3yOkh6nbJa94810lp0Yn4CoD3ggUfzErlDsU+z63HK28v9g3hcK7No8Gqf2GfP8DgrJjkH/qmzZsK9fnZ4prKjPRV66LIEgrnTkuC3c+qh/o2+jhe0sdnZaTFGkq1+yUle/w=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by GVXPR08MB11094.eurprd08.prod.outlook.com
 (2603:10a6:150:1fe::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Thu, 26 Jun
 2025 11:05:24 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 11:05:23 +0000
Date: Thu, 26 Jun 2025 12:05:21 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	stable@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, Sudeep Holla <sudeep.holla@arm.com>,
	Stuart Yoder <stuart.yoder@arm.com>,
	"open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH] tpm_crb_ffa: Remove unused export
Message-ID: <aF0pcV9TNsiOYXVM@e129823.arm.com>
References: <20250626105423.1043485-1-jarkko@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626105423.1043485-1-jarkko@kernel.org>
X-ClientProxiedBy: LO4P265CA0026.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::23) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|GVXPR08MB11094:EE_|AMS0EPF000001B5:EE_|DU0PR08MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: 485348b1-768e-4ed4-2ace-08ddb4a16d2f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?09YJpskmH/joHFMcZyQUg0Ttui9khWTdM0Gh089nKy2gUDE6jAkexQ+dwM+g?=
 =?us-ascii?Q?ZIGF79n/nfN3w5AmJxLKFxgDyxaTOKjG2xhw9VfT/Vzxbb2zoqCW08FD+GYi?=
 =?us-ascii?Q?wDfei5g4QV7yoYAudq6oY3v3Dlp5Lr21I3krzt9uAy5jgC90m8f0YEOtuV5k?=
 =?us-ascii?Q?vhWXXZGp83KcOVVw5UaXkNMVyp206vAa6Qs6wfNU3dab1SFSx6x457SI+aR5?=
 =?us-ascii?Q?ZKr2uUvkWbAu7CqFrkUHvoHAv1A+kYoXMFMbn5u11udcRpB1Jv3LszNeGr17?=
 =?us-ascii?Q?oLtdH1r7tEDdt0WiTROPA9OYcCXJAbPilbxobtUxe+kXrNV78igIXEEJzwQB?=
 =?us-ascii?Q?AzLepe+9Qpl1/d+3k/wyro5KSo9Npt9vyeNK405a0TfMml38Ij1TVY4dI0+D?=
 =?us-ascii?Q?8TMVTBGGwr/EHR4XxyiyHfI5avc0aolV7vFRqcvvXYnJ3iPkl8jSHy3uHRQh?=
 =?us-ascii?Q?Ac1Ij4G8OXNRAmU9tHMJkRrcIU5XinrFd8QU36G2TvzYmcVPkec62EKlhCID?=
 =?us-ascii?Q?G+cOHZwZ0yLNFkGKSmmohbvfmjLMQyz4WoqfRsw1L7XCCO4fMGvzaAvtY4tx?=
 =?us-ascii?Q?RDLjgAbZHS4pxvK+NOdNRa3hXnpjVYcFoLwcSJZWmyRwioL/tMZbTtBTX3tm?=
 =?us-ascii?Q?0vRg98E80MGb+yfcOPxpD8ionljW7QynUdEasrWAoN/A3xOeShiMqYDh3u1f?=
 =?us-ascii?Q?A2pDoJ7s/5S86GR5lIPnBIbJRyYaMrKSF9UAW2fGGSlfczOHvvVHb9SDN0PL?=
 =?us-ascii?Q?m7mafaT+IL6yhb/pq9DhaZcj4KXxsiGNQV2wpBlq+F9iXiv17cD1iOkneWvR?=
 =?us-ascii?Q?UfxJEtlbvYUukqyVihbyhnht8vJz5IppGK3fFeeLOSr9vAgs6MOaFHVKTEvz?=
 =?us-ascii?Q?o2KFKH6cSREn17xjkIqiErEaoe28JC/dWkqBuChGBHssqLkWY8nDptEh6ZTp?=
 =?us-ascii?Q?6KIDEEP/u95E1ACyQWTDZXQYa23hTkV8ih7hMTg09dRGNwE5traOiPOnsKUz?=
 =?us-ascii?Q?Tm+acFlPIYDmnn/7FOsH6ZhEywXgGLE96d8nMBx13LH5B69OX2RV6GCzyYeV?=
 =?us-ascii?Q?uz9WZrIvcDDDg/IaClcDMmAL5u5WsaVzEJNTTkUMI6pfvAqe3MRIGSWb2tpN?=
 =?us-ascii?Q?ayTHZFXOkmG6464WJBK+jqrrO1Quf6LzjALFNSRci0bqQ6msAwOuO3x6wzXb?=
 =?us-ascii?Q?yLa4hH7DaReklRjFP+6h4eZzZWQg5UZJiDUV400tAr2OEtbXTFnzmvxk9uHo?=
 =?us-ascii?Q?Hf9am1IJDYDO4vLBV/DuG/4ZsofnMNepqOrIhi3BFvPb8ogBFTbf+Luc0pNv?=
 =?us-ascii?Q?XCWdIBHrUR612997oswPZvDBYWLO1sItCtb8zX4hX3udaW0ffuXl1GFcRlNe?=
 =?us-ascii?Q?Bk+tSmK7b+AOM2V0cTUmLHU1CsvC1PEIzklA7JGJju/LFcWMslUjA2VHzRNr?=
 =?us-ascii?Q?RNEboJAzoto=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11094
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B5.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e1bb2c53-2b20-49f0-24c4-08ddb4a15940
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|14060799003|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ET6s1KdtSZgOU4v1IyFqFOGlSJyNhNj/ch1fcfEKQrwdW//6fDaaaQD9ZUp4?=
 =?us-ascii?Q?iNfXTWbMg+CF5rT4/WA1xoH9+uv+Q9yVuqtVzhKPK6W0oKeeBKGMjldAamUS?=
 =?us-ascii?Q?NfvxyGq21Zsykr+Oj431pm/R46f+3HCgd86LDfvnutHf1BNtT+B17wcfegdp?=
 =?us-ascii?Q?5ptzmyYOVYaQmM2Gu7PNJMtSPY7Y7ZZIwfCZ02Ky0ZpwV1r+6/lCXSfdGMTN?=
 =?us-ascii?Q?XPzJk36qPe2aGD/9g/55lTKfMBJ2fpDYuauB3MfTwPDcyzC2rLg2dHD/wo8a?=
 =?us-ascii?Q?49nLz+SEH50l2o/X6dh+z1JCPgUdVrepHKnUSpFMO6etMD7OuMPzMSs3FQTU?=
 =?us-ascii?Q?hzGnVwU68LXf660YXnsWxuTyaG/EGTckFrCRnZ4npQ2VK/UTGSgMPTVCa90m?=
 =?us-ascii?Q?ihcyCjGDEBje4gSaGemNRaVyZ/dFgd7UKVIR7QJP/f1GgLRNBK4VqgU+btzI?=
 =?us-ascii?Q?caR1QK5a2+GCm8sHAYT12JtOFLdzYSu63XiIZHDSD2ZX4sMISyvpmu4C5uO2?=
 =?us-ascii?Q?wU3vbTS5/6Ztw/udKIYom8/Uv7dDlcqHijvb+RRCjcA4ylywwJLcIRlIu0ZB?=
 =?us-ascii?Q?ifAvkl5RQEOhcF4DZkzkVQxMMuZeJdjJPXoI1T7lSyu/28IZc3KDLzmeOudH?=
 =?us-ascii?Q?dHdjOtkg95/SX4h1tqKYUCZ5jGy4YZfU7E2LyNZYORd0lbI45UTd+zZkH6S8?=
 =?us-ascii?Q?9wugPvqo8l1HRAabHal32msKOSwt41K5CTSqMcDWPEv0ERU7OHABkWzn3JvB?=
 =?us-ascii?Q?sotQTHKyCw/HwTF58trQrHc2YolWWGf9MbiKCQMgBpH/s84uvDYYD26Xyxcq?=
 =?us-ascii?Q?TpLJtrBQ1m/u8Vzvy2HtDUbBjrW3l45Rf5YiyumvGMGpwwxwqQw51vuucLF8?=
 =?us-ascii?Q?T/BIOe+fMC0VivbcKuEcEbtgF3HqJ5W5TDXOUEX+/CW9J+MWKI2cmv9KE/Yo?=
 =?us-ascii?Q?BF7XFmzedYzqBYNYZAXwhuZA+WAWakApQexhFml3Kh70odAuw+Km5GybIcO2?=
 =?us-ascii?Q?OVZm+m4tGryJ4G5VaiA322ics80rfHVJxLZHW2nLHihjh679E0Ia6DOSO/vJ?=
 =?us-ascii?Q?etDX0c3gz233QHpP7DqOymXVGaZFexjWD06X2epeuL1YGWAfaposATM4eW+a?=
 =?us-ascii?Q?ATwb1rTUVqppXdqSFev7He5iZk1nurqokqswiaqT0Eldi0sgmD+wH5dZe9Ge?=
 =?us-ascii?Q?vDNuRS98e1NsAXRlxvK7373DP6/+AsCAL0iHiXkSlUzbSASV76UHF8vuiJ5x?=
 =?us-ascii?Q?Ze6Qqi+CEb+zfjBhLIybYqydJzUOT/tj6u6s9cvTK0A9Xc0g88drNJFeXM6a?=
 =?us-ascii?Q?SbULTXjhibZE9f5iWe+JrG3NgD5iDibufp0QxzsVMNY7XKVePPxtwlLkkKC4?=
 =?us-ascii?Q?8XiJEglh56jtLQlk0oHq1QnDL/Th7pn/cec1pgZrdpN1g/4n0aIq5Nl9cn/X?=
 =?us-ascii?Q?2Yxl6JPLt9v/+XfIVHLBhY6sP4eMxia0KJ2XgNgPO3ZEmd55KmxhrmARSr+k?=
 =?us-ascii?Q?tdgEB7mLCCf1XhgKeA+F95TxNpVjnizZaZgu?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(14060799003)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 11:05:56.9973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 485348b1-768e-4ed4-2ace-08ddb4a16d2f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7948

[...]

Look good to me. Feel free to add:

Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>

Thanks!

--
Sincerely,
Yeoreum Yun

