Return-Path: <linux-integrity+bounces-4023-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8209BC236
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Nov 2024 01:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA5011F228E4
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Nov 2024 00:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6376EB67E;
	Tue,  5 Nov 2024 00:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Lli2IhzM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lKnVMPZo"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9523C1FC3;
	Tue,  5 Nov 2024 00:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730767940; cv=fail; b=sYUe03aNEGDXWMjMeBJJ2qzYMr/s+C6BpEVDAyanEDE42+HAk6W84R6npKzDptPKPBzqHE8CWI/8CENhQMSAQULrfS0lRtvy8QDDXjAQqPzP2X79k9V79mKAFxndL1usUGtOPUv8vbWkVcQFzXop9IheDidNE9qYflFajBcq8n0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730767940; c=relaxed/simple;
	bh=qUvjqyQc5xqTSsdwOEaCysDCKGfTYnq8zlMRsOp90m0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YWWDdMJKRrgfoW4w9FUo6g7/1VgABSsqQuw39JY+SZfyebrbPhEqVkeNuWI7Tc5LbimRuXaBact9yHI3r21sRn180ayMNZbb3N3ng+NTrk9zoeQccFiwOC2psw733w0YokWqR730wt+M06Ami8irHpK6QCZ/eelQKTdOU8cltCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Lli2IhzM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lKnVMPZo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A50fbRB028742;
	Tue, 5 Nov 2024 00:52:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=1eEdxKA3m/W0/91LEYN3j83d14vxRwZb6KMV03500lo=; b=
	Lli2IhzM7NR+MvvXeDJFdW1mWc3XbGA2i9Nlndrbl9rXkhlV3er7dlCDYdLHPodO
	qei/iSgLVw+ZsOpWNlAjx5ymA3hf6Wf0VBesNBEwT4NsUVsqXKTu1AIN8OBv6auV
	Cd/jf1L+dh+2Z2yavmAqJpUWlOwXFr7XB5qD2nYooW0G59eDHRmKmduRX/mYgcgz
	QlN+TLc3HMDqiY2Jar4lyM7mprhRUd2a9DdD2IA5Z4VNvOmXonXhZzdm+LirH1Fh
	aHRJF7Bl1oXxGpg88Y8LH9LUzajEgLifA1WXV+z149lsnvt+p2qkSMFLCl5oTVjt
	HDL281ANMl87rqHydfM8OQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nb0cc6qu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Nov 2024 00:52:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4MAKsN005093;
	Tue, 5 Nov 2024 00:52:09 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42p879wp5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Nov 2024 00:52:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3h6elK+AH3YItp8gkB5uCOl789ykrklJ+D3gpU8Y2T5/UG69pkbHBCdDHTEqHu5wvkJycRxwosPmjDv3/Ugw1VIdDMIKoOrlPrH1D+5rsUCSdA6r/TkX2XqnwbysZSMucH+3toV55AcqcQ3ixZ4rIsg8AltQTB8g+0BOBPRI2MtbucYV20M21Orz2JBR1/ml9Sgmd0DVQ3VrhdaVr2eR8gZDjxcSZqjeybRVvb5luUyagdITozYgU4asaytfyOEjhuuAC6Sz0SNcOnZ2JKvRpmZNYKlx4WhttxvdCOmV1SnhdkvpcCP25ImI4NVZOUALt/LBDx4JUP8HDUUsffIkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1eEdxKA3m/W0/91LEYN3j83d14vxRwZb6KMV03500lo=;
 b=r5ecEwR8syhn1nQ2/QdBY+trRoURZRboWK3aMLhgjGoNfSr5V+WG8Q5X/xE7J4yOnBu4JVboKXmbr19keqwEOhpCSixO3K6ywhaZxsONyKlSwO2777CgXUPknxTz6UVRiEGQnEdurLVoaVuYp2q3Ev/8yRKDUgE3vttsugE+pmPPnu5lwBq/n6whgvG7G2wFe3Xy5xktHai1gmaze7KOju+a0MdDM5XwjrKSKijgiiTE9Rpmh50IUjzD7XBvUHZRV+fdpKCN+91RUEmr6dnOfiz0WYmTVb6V38GtzEouMkCdhlrS10i3LDG51t/FmpwIjpW//gtGc1vUwoHd4alzSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1eEdxKA3m/W0/91LEYN3j83d14vxRwZb6KMV03500lo=;
 b=lKnVMPZoIC+KlMzdYfcWqvBo0LZqidXZ3x+9W0hKIILZpIWhyt+8y65TPOwsQraXpiTcTSVnLP6bssYvxzfLg4LHZmFDzB/4Di6iUdMZ6Zf4PazUO6y7ndFk24GLagZm2HCmNv6VA/iuiWgd1WWbr7gH/SPe0jFBKr024VpuLSU=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 CY8PR10MB6779.namprd10.prod.outlook.com (2603:10b6:930:9a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.31; Tue, 5 Nov 2024 00:52:07 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%7]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 00:52:07 +0000
Message-ID: <7412e1e0-0e28-41a6-a4aa-a3fc97d36468@oracle.com>
Date: Mon, 4 Nov 2024 16:51:52 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] Alternative TPM patches for Trenchboot
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: x86@kernel.org, "Daniel P. Smith" <dpsmith@apertussolutions.com>,
        Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20241102152226.2593598-1-jarkko@kernel.org>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <20241102152226.2593598-1-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::11) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|CY8PR10MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: 6caab49a-c052-497a-09b7-08dcfd3412b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UG9UUytDUUhWUFZKUm90aW5wRWJLeXEyQVZnaHVOUTlONzE2WkRqOVpSeDVw?=
 =?utf-8?B?aDdlSUdFZ3JmT0dwSlJweDRwYXRVQzE4V1AvVDluZFEwd255ZzlmNTNvSUwv?=
 =?utf-8?B?KzVWS1NMOXRZVGVtcHQ2Vll0U0w5aldvUDVoVzJDeXRTNDk2WDltbDNhMDU0?=
 =?utf-8?B?Um1uUTdyNmRQazZHRHVKK1dHTGJOTzh0RndNT1E0SVZEN3E0OFdEdGN2d1JF?=
 =?utf-8?B?Mk9IOWlvbGR4dnNMQ3JlMWdHZndnKzE4U0g4L1hES2Myd0hYeGdiNGU5c21t?=
 =?utf-8?B?M2VQOW9lYWUvMTg5ZEdFNzY0b3FYVXIxZ3k4bzF6YVNMUDB4ZFovVmtUb25x?=
 =?utf-8?B?QnF4MHR4U09hUHNZWCt5cG4wZVR0SDBYL2hHRlFndzk4STlwbnZQOGZDRVdu?=
 =?utf-8?B?WmFaUHhoRURXM3dRMWlEdWFJa3BRcWNIc29Jdnp1MkltVUdhV1JzZHVkd2M0?=
 =?utf-8?B?UkRJYUNCTnN0OUFpM29JVC95K2JzVmE0MUM5VmVVODdybVNQVm9abHJxZ2p5?=
 =?utf-8?B?S0VBcW13aXFiaVNrOFRabkxFNlo2d0F0bWhoY3U4aGJlcXhZa3haNzg1VW5n?=
 =?utf-8?B?WkwwellsUm1PMDJ0TFdabThxaEMvL3JJcGFyN3Y4MS82d0ZJSmduY0FzZWJ4?=
 =?utf-8?B?MjZOU2V5Mll0UVBERDJWNTRFZzF2bXhadGFzbEtzdHpVTSsyTWF1K3JPVklK?=
 =?utf-8?B?Ym5PY0hwOGpDWUd2MjNFVzVObHRJT2VWMS9jZ2RveWxhZXNjY2tNTVRuRkpZ?=
 =?utf-8?B?STRyVUFBL2sxZFlLV3QyTytwa3AwMUhVMWZPdWV2RmY1S0RJOCtJQ3RmUWVS?=
 =?utf-8?B?MWp1NTExeVgzendIVVRwTlVmcHAwbVI2SFpXK0hsSEhyV1JnMUFjdDhZeFJk?=
 =?utf-8?B?eFBOa2NFMUdCSTZqR0JtSk5HUE5tNG8wUEcrQjZpakhKNlAxdGN3MWZHT1FE?=
 =?utf-8?B?Q3RJM0VLeXpQSm04SEVEWnZsb1hqa0QwbjVqeGMrTnJQRjNzYWE5aTVXcWhB?=
 =?utf-8?B?UlVJUGQ3dmpEUzB5SHA0cmp6cTFIRWh6elgrUllUcTJ4V0pKbzlIS20wd2xk?=
 =?utf-8?B?NGU1bnBLMytOU2VZcnFtZmYwRlZWNHQxMGZoNTg5bGNiamhuWTB2QURuakp2?=
 =?utf-8?B?Q2VzdUt3b2czeUlXWUY5azUwZnJqQ2ZlRzhEcTN1OTZIdU9JT1dMcnY2dThO?=
 =?utf-8?B?eEw4N2I5U213QTlaaWdMeEZpTlBhZ3YwYkNnWHNOWFc1S1YyZHc5Ry8xZndq?=
 =?utf-8?B?TEVaWEJ5ZloybWljVG1ZUUxFWTFJeGZibmNaOWkvcWx4eTdOOVdCWklvYzlO?=
 =?utf-8?B?N1FWN1MyaS9HQzQ4UnpseWcwUGdFMTYvL0M3R0h1TVF4S2lKV1pTVStKdnhF?=
 =?utf-8?B?Q1hFV3Y1bytmbFo5dEhHdTlrVXRvMHlKanNNaS90ZW5DNjVTNjVzS0I1Q0lj?=
 =?utf-8?B?d3dObG5WOTVsajRzOElhK3pwbXc4b3dScFVxM2t6cE5KZVZtMTVjd1c4TnJ6?=
 =?utf-8?B?bG5KcjllcXM3bmJhaWgvM1ZtS2tVNlFodDJGTnRiTGd6UVZudjhPdXI2SzVm?=
 =?utf-8?B?NFlQWU4yeHYrK3RzRzlia0kwSzk4bFFJUHVtWktXQ3MvTUw1SmJMak01T2wv?=
 =?utf-8?B?ZlVabG5GOTV5RllGVUJpMWtManlBQ240d2FxbHRJRmlLVkp4QTQycDZqWW5n?=
 =?utf-8?B?T1haazBBblZiNzM0MGNrQnBUYXA2aUJzdWJteUFlWDM2MW1jQTZmMVJJV1Mx?=
 =?utf-8?Q?17OpL607uYNDrg0B5pSBOyHlcroFM++7X1y7FHa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEZidC9zS1pOcDk5bE02RVh6cHVyYTd1cDNvbGNYRFFOQTZ3VU1PSk9CYkxN?=
 =?utf-8?B?WkRuSUovWHErenR3emJ4UmxTQjcrMmVUaWI2eUlPT2tFVUJ0N3d6bG1ub3Vt?=
 =?utf-8?B?b2g5bTdsY2E5QzNGNmZtVGhIMC9tRGswMGJQOUlUNDUrYWZMZDJmWTB1Wnk0?=
 =?utf-8?B?c2pNRUwyRTE1TXh1c05waEZBUWpLNUQ4ODJETXFqMUxYSmxvTkpzTnNRMWRh?=
 =?utf-8?B?VGoxWXpadnpDc2RTQlA3VytPeCs5UndPUm0yaWJIaitFaVliLys3V0dBUjhx?=
 =?utf-8?B?TWRaM1pUN0I0KzgvMDY0VmpMeVFhRmMyL3QrMy9JemI4KzAydEZDR3oxcURK?=
 =?utf-8?B?OUpjdTlXUEJnY0RyZmpkaVhZRkluRDkvdHdTUmxPcG9rQnRrbE1HNm5DUHF5?=
 =?utf-8?B?TFdyNGJwUGoxU1RlUlNsclRib2tsNHhqWW9kdmFZT2w4TElGT2EzaHNYOCts?=
 =?utf-8?B?Zk1FMmVSYnpmdENlMzVqQ0VsTEM5MXlvcUtSZ1BRN0xGclNIS0l5RmNyTEpo?=
 =?utf-8?B?TENiWnRHcGViS2FyMDcyOGM4MUozUzY1YUFycjB2QmRQSlJBbFU1cFFtaEJJ?=
 =?utf-8?B?eVB2S29zV2xJNzNGWEoyWU5DbnA1N3Bhd2t5cHhOb2NyMjdoY3l4d25ucVkw?=
 =?utf-8?B?bkJMSUdPRTRMWEFyQWUzQTdVbitBZHJUcjhRZk15UlQrQzFlUWdGVmw5WWoy?=
 =?utf-8?B?WDhXQ3NqdjUzS0JDazRmeFdZVjA5aS9CWkFqWmQ2blF4dFJ0c0R2OCtTdmhD?=
 =?utf-8?B?TUpFU25Hb3ozUGZhYnFtUTNENFI3Vlljek5UUWJuQmlzNnBHYUErcmFpQUN3?=
 =?utf-8?B?SGhHT0RGK21LbjI0WGJzMmZCNEZxbzBraVFFOWl4b0ZmWDZIL01maEtLbUpr?=
 =?utf-8?B?ZmVXRXF3czlXZUtKRTlYS0NQZ3JMdG93aE9hWDBNOHoxY3A5V3hyM3ZFZ3ha?=
 =?utf-8?B?dmZxZHJia0JwMU82Y3p6Zk9wSWppUmtWRVRXaTNHK1lFNVhiZmlOcUlRUDhB?=
 =?utf-8?B?UnFreWcrajZyUHY0VzIwdkNXQmZwMjFtTGFnR2M0QjBPeGIwRzNBZ1NlNjFk?=
 =?utf-8?B?aWR6TjIrU0lZRGNNYWtxM0Z2RGRJTDhIVHhMUFB1UlFEZXJpdk5OM1B5SkI2?=
 =?utf-8?B?OUVXeElIeE9mSy9wTUZNRk14cFNVU01qTU5oQzBGdG5IYnpGbC96L3N6cG9W?=
 =?utf-8?B?Wk11SG9YSDNxY0oyMTBmRXpNTDVCOVdYYS9ld3VDV2YweGFXbkdXNDNQb2hj?=
 =?utf-8?B?aDBTMjdvWmpIV2NVZFVPQzBQWHRwWmFZbFJ2VzJNVldQWXFJOHhFZHkxbzhL?=
 =?utf-8?B?Sm5WWFhkd29VVFB1eW1pREJvMXlhQ05EdDZmQWFqeUZkTWRJYnRNTzJ3MjBp?=
 =?utf-8?B?V01sd1drenRac2I3YUhJMStyNzRkZVlUMVcvN2RvOW8rQXNOMGdvNHBKVDgv?=
 =?utf-8?B?Und2OG4xTzNvNjdUeHlmeUFZQ3YrK2hBRkh3WEhDWEVTbk1OYUpySkE0ekRL?=
 =?utf-8?B?bWVqanl6ZEMyUGdrckd2c0xSUXN0QVVjQ0xLMmRKckxibXlNTXk5SysxaTlI?=
 =?utf-8?B?SUJEclpHTXdoTVB0ekhUcjZqSHNwZkxlQzFwQUtsY3dVdWdQWmRoTGRTVXEv?=
 =?utf-8?B?UVBWd1pzbUdQTjNjUmZhRVFJYTRoRFpvNU0yczkvdmJIT0d3SGNDakNySHNs?=
 =?utf-8?B?Z0YrKzRmbUJrY1FjU2hRK1JsYUJOTjg0bXlnbkg1dHUrRGlsSmVaYU80VVdV?=
 =?utf-8?B?c0JmUlFONjNMN1p6dDJhOFVBUFR2Y08raE5aOHRPYmhCT3JYeDQxN0xmem9B?=
 =?utf-8?B?b0FDZC9pZ0FaYnV0SUxUdFIxbGcvVGlpL2ZrdXVhZ2g3SlhxVk5BS0tiRGlX?=
 =?utf-8?B?azBXZ3djMGQ0ejZaM3B4UnlCQkNSY0pNZGNMSEVrcjJMMzdLejZBQk94QkNa?=
 =?utf-8?B?eDBpM25xWitVUmErc3UwaWlxS25QNFgvQ0I2ZFFlTVpwR1U1UFUrNmJyeWR5?=
 =?utf-8?B?WE1wbUNlRmVrTXArZUJrdDhmeGZJSVFRaCtaTlE2aW9peXJrdzlERXljRTN2?=
 =?utf-8?B?aWEyS0lGTis3dFl6NzJ3VWJoZWFOWkFucWdqSG13ZmlVK21kZkVEZ0NBK2ta?=
 =?utf-8?B?YXlTZm9wbm4xM2ZONW9uTVUweVZ1ZUM0S1VBUWgxazBWSVpKVFhpOXNjRXdu?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UnyREl8TttSJb1+LQdWinGvfukrC7QYVfXamOAU8lJJYspmzY1o2Dl60CrRSl3SUl2L1qbVmkzEmnbFdQKCuuYSuImTfNYBoNpqg0GQq021v59+AheIx1bzphwGH1gvotCo9leglyitukBvGEFuW6tAfTy2xBZJWxShvRzkuZqrOLmTWpos+wM7UY8JNJX4mV7k1w2GKU2yWpIxvNJBdB9yH/8yMEzvTAuP7haHv7kWKnYE8olM3TpYBIGA9a49Gm9XrssMG+7xscNg+PAQhwutiz8Cau7mFCE2MJd+vNM1Jge8NwyGfOpIujANaZetXIuB8ZAtD16j6iCPK+f/VljVNB+e04kwOJGhu9QChv6S6/1+6YlcQvXQ0artb/5+rSEwsY5PYT+anoj3GJyrLbXwFDIQp8YIla7yraLBjMtbIEs1jVZrXc5et4AOyJtucXOaPo69tAOLyHAmw7V5qOJGqXDVZazAm1aV5DNA3KTF89ufxUoQd08/9MwL/4mr5/yaTr8KX2eV9neiNwM7f/IXMc0K/px4Nm4dwcahyuQBspGpEctu8j7TC1rLgm9pR/OnIsWyOSei//oujMPI1FNT6e8hwxJL15v0T+xHs63E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6caab49a-c052-497a-09b7-08dcfd3412b8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 00:52:07.5879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IfePfri0btAGIEPnyyA+6VLAJS9wgr+tdjropj2iqAqj5ON19Tx4e5uzUUSDInOzkyLjIu6xhcPfPhLikYuvbJJ1OB6fXWtNY44XQL/HKV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6779
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-04_21,2024-11-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411050004
X-Proofpoint-ORIG-GUID: klO3yQY-_JWaGEer_DViywZ6OdjH9QPX
X-Proofpoint-GUID: klO3yQY-_JWaGEer_DViywZ6OdjH9QPX

On 11/2/24 8:22 AM, Jarkko Sakkinen wrote:
> This is my alternative patch set to the TPM patches included into
> Trenchboot series v11. I don't mind to which tree these are
> picked in the end. All the patches also have my sob's, so in that
> sense things are also cleared up.
> 
> At least slmodule needs to be patched in the series given that
> tpm_chip_set_locality() returns zero on success.
> 
> It is not really my problem but I'm also wondering how the
> initialization order is managed. What if e.g. IMA happens to
> initialize before slmodule?
> 
> Cc: Daniel P. Smith <dpsmith@apertussolutions.com>
> Cc: Ross Philipson <ross.philipson@oracle.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> 
> Daniel P. Smith (2):
>    tpm, tpm_tis: Close all localities
>    tpm, tpm_tis: Address positive localities in
>      tpm_tis_request_locality()
> 
> Ross Philipson (2):
>    tpm, tpm_tis: allow to set locality to a different value
>    tpm: sysfs: Show locality used by kernel
> 
>   drivers/char/tpm/tpm-chip.c     | 33 ++++++++++++++++++++++++++++++++-
>   drivers/char/tpm/tpm-sysfs.c    | 10 ++++++++++
>   drivers/char/tpm/tpm_tis_core.c | 18 ++++++++++++++++--
>   include/linux/tpm.h             | 10 ++++++++++
>   4 files changed, 68 insertions(+), 3 deletions(-)
> 

Jarkko,

We have tested with this latest RFC patch set and it does what we need. 
Things also functioned correctly when we closed down the TXT DRTM and 
brought up a follow on kernel with kexec. So we are good with dropping 
our TPM patches and adopting these. The last question is do you want to 
take these in directly as a standalone patch set or do you want us to 
submit them with our next patch set (v12)?

And for what it is worth if you want it:

Tested-by: Ross Philipson <ross.philipson@oracle.com>

Thanks again for your help.
Ross

