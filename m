Return-Path: <linux-integrity+bounces-7075-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B32B56FE2
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Sep 2025 07:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 804373B6D3D
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Sep 2025 05:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71330277C87;
	Mon, 15 Sep 2025 05:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="j7JPI7uu";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="o38zFH/C"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DA82773FD;
	Mon, 15 Sep 2025 05:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757915384; cv=fail; b=u7fttYYCODBWHqhi2rhcC4EPk26SsCHhv0YQbhf88FU763Qlj8WswoAupfIsS69PfG4AthDSkMgEMuw+4SavY6vZ6AkUkx4SmYeLjGCv6UdPDd42aadxVx6PSo6ACiCs+5T2tSoYKfECH4hGCdjnNw0JVei9FfXiMzzE+9+/xMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757915384; c=relaxed/simple;
	bh=boWUvoNzLMi4bSqcEWdcQtdLOAArzvDUHtFg1gDsUlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q0sbAd11PQVdU0ZAwK1OCL9w2RUGK+5LoiZ98dLpu6VK3qXRl/tPCA60M3iAhUGrRY68m9RsTz/6NRdyTwt3bLpwiu9aHjs5JfyhFf+LrqW4yzXlGAyIMzGAnmRLcxaik7HXSN6uetoFlm9Vw6Fa8KZzhBOSUMRaC08RzKL3vZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=j7JPI7uu; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=o38zFH/C; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58F4oCGd889824;
	Mon, 15 Sep 2025 07:49:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	VtIA3F+BQrXHd0r0lc2W3mK+ez+8oKwewUMThAfu87M=; b=j7JPI7uu6WEYVW3I
	Au9fmHacNmtGt+0Y+RLal5AKDRz0Z0bi+X0f3wKjMLew4mN1rqVV7KwUpWnbguHs
	apofTRISoF66eSMBteOex/eyhGebgAd1mO4X3iUUn7K+C50HitnBPJIHCrj1ne12
	sF/EDyE1mzSauFtofuTtU6Dll4iNrnpLyp5JDiCCiYkRiWYeUvWT2gtf/dGBZEQt
	SIqkcvdM5c9iPPFHLrqIcogcJYxbAXZJT9NaKzJq09zbvt+VKfJ5tjTxKdL3D4Og
	Hf52GeC3eI1LQpfJ8+C+CoTKEzL26DYySjHVoajLCJDphdajjSNMbHpanfSiy68n
	h5NX9Q==
Received: from eur05-am6-obe.outbound.protection.outlook.com (mail-am6eur05on2101.outbound.protection.outlook.com [40.107.22.101])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 494vm41q7p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 07:49:24 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+kRQpYJ6b/5I1bw9Olx3INvGdooHXSL5c0DCXPZnO0Fm5LdMM6ve47F1/Oy+eRylucnNciHAt8ri3o921pT1QZ2aCJB/5hTmWUeeKZ5XgFMK5pRsmluWIL9yF5PGkVG+XI6uKkk49v0hGPdX1ld/aDadM5w3AP2Uz/VHMZkO4r9LuhMT4DgzWhYHop+vaOdExcY71m7wVDi3oldTPw1dSHDmimB1DY5d/c/+kRntGxvixVC/8T/OET1JdDmaaVgm0RTpH4xWYK5B9vgIMxtfy+Za80AsZz8XeRfGIFgzLt1HVOvpR1BkzWOasmz2MzaJHsVb92SuqTN6yqXQAbadw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtIA3F+BQrXHd0r0lc2W3mK+ez+8oKwewUMThAfu87M=;
 b=y9vkXhG43Oq/QeTrWdEBsc2MQhWkbcp5lHne5iIK5cR1HqTSm7RvBP4xINpbIVA+XJqFG95JifwFArtJkeIAvsL+ITkuATmFAYR5ezIwn0gmb9SqyiNTBnGZQBM7MwS3JHB2QAPj0/z90YC+pcXJfe2+pmNYEdjau0K9NAZlW3ZNvUfC8BnUIiBno48xFHNyv9K214uOrJjhZ7KnWPqbbMSyWC0BwaClwQcBWXaQheWKpsPOossWfUX7cmai0vktLVdyD86L5XIYBMUxRP97e+pM3Mv4oxGmLdWGisJgORW4vG9Q/pOSCVNLUz5ZghyFPbvCaoaR8X4ncEvTptAqUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtIA3F+BQrXHd0r0lc2W3mK+ez+8oKwewUMThAfu87M=;
 b=o38zFH/ChFE6W/HWZOEcbtzgR+CQJ2j4N8KUy7Xl63QLY7AEiUtxxykd5jr/fyfIneVmAZT0Mj3plp4rbQOZS0xXDQ5+HC3PBWaurVgjwqqfBinjbl+FMgNih6ABEFyKafnZSjJWbVGBoJb/CmqZP4SsUM/NsSD8AI5U0twKrE4=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by AS4P192MB1767.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:516::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 05:49:22 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9115.018; Mon, 15 Sep 2025
 05:49:22 +0000
Date: Mon, 15 Sep 2025 07:49:17 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Mark Brown <broonie@kernel.org>,
        linux-integrity@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: tpm: SLM9670 does not work on T1023
Message-ID: <aMeo3Woh1guA2YPB@FUE-ALEWI-WINX>
References: <aMLUIVjHZ6CFvd33@fue-alewi-winx>
 <aMb2A5KzQJNx3daG@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMb2A5KzQJNx3daG@kernel.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: GV3P280CA0032.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::33) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|AS4P192MB1767:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bc5b598-b9f2-4e5e-929e-08ddf41b9f15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDkrdU9DM0hUSktabFdnQ3k4RlVOcFF0OFVCeU0ra3owanBSd2MzWE5jcWNB?=
 =?utf-8?B?cEFTOFliUmlrRnVsSTdUUXkvRWpTRDRyT09veUNzbkhZUDlxbEhOT3JSTzFy?=
 =?utf-8?B?b0oxaWExNFBkdFRwcWRCcWZrNjNXUTYzcVZoOUNIb2ZvNWMyd2hDQ3dMdVM4?=
 =?utf-8?B?VU5FYWRiWSs0TjI1d25NUmtGV3VmN29CcDB0WFlVaFVkUXpmNkNqYkt0QWdW?=
 =?utf-8?B?S0lKUStxalRqZWJLSnBtQmtJV2ZkOG5tMk9wcU0ybnR6MGE5SjRTVGlJRHB1?=
 =?utf-8?B?QVJqVEpnTWp4aXF0NlJ1UnJtNXdwNkZRczZkRlMvcjlqbC8rWEZRNTdPR1hR?=
 =?utf-8?B?WWk2WHFLL05UVWZKSEQ0bE55QlFQOUVLN011WnZCOHRGdHBXOTR2WFBERjY4?=
 =?utf-8?B?UXhycG13aXlzb3J1QmREdjlVRmFJVi8vbUhHenJKaml4dVEvbithUjhZNXpH?=
 =?utf-8?B?L0xabzNQTXBWZ29vTEtibHJRVHpCQ0t5NkNDYndkNDkrakNCM1hqOE9TM2xP?=
 =?utf-8?B?cTRvWDdONkpxdmI5eTVkSFpWOUN5ZXJVY0ovU3RDUVFlNzZRUnB3ZUJuWFl1?=
 =?utf-8?B?YVpydWVBRVcvS3dKa1lPbVE5bUFDRndiaHpCTEZkQW0wcHpDMGpIbjVMWjI4?=
 =?utf-8?B?cy94V3lCSWwvSTBZZ1pjRE1sanVYVExaamY2M05uekZxVmtPMUY4cGVDNnV5?=
 =?utf-8?B?Zmx0a2I3SzdGR1E0V3J1Wk5za0dtUUdhLy9tUHdsMFNXcThvZnNuOW1qdGlJ?=
 =?utf-8?B?U2p6UHlGRzNzZkQyTU1IKzJndnZZMnVCL0w4NFo1aUNPNlhVcVBnK1VKSnUx?=
 =?utf-8?B?WjFoOWFRSk1qNnZwRy9uWnhHdkVoZGQydmJJUkFaa21IanR1ZVlvM2MwYjdx?=
 =?utf-8?B?NHo2WjU2Z0NCZFFiNmxISHpVOXZkazFHbTZBV1V5U0NuKzVaajIrdllDRzda?=
 =?utf-8?B?MEIrc1lqb3owemRjY0JOU3NkQzVPV2x0SnBNRnRUKy9BUGwxR3NCQjlTSXFn?=
 =?utf-8?B?WFo1NHZBWmpwTnhYNUNvSVZMa0VoUXBaaVJnWXg1L0JLMjFmRndRSmFPeDJy?=
 =?utf-8?B?bGhDZGlVY2NWMytEQWdhOWtBciswc1MyL212bTY2NU9UdzJDaVRQa0VaVlNh?=
 =?utf-8?B?VkhtUlFaRWxKdi9mdko2cUdBUVl6TWgyTDA1WlRETHVhV0szZStLeGp1dGlP?=
 =?utf-8?B?elg5U0F3bUNDWTFwMjR6YndYN1Y4VHRuUnV5T3g0RDRzNjdhRlJ0cVJ4VDAw?=
 =?utf-8?B?K05tVS9HczFhWnBrdDVmUG5KajRLUDl4cVl6ODhQQjQxS3BydXBSNXdXMzVW?=
 =?utf-8?B?QWxHVWh4NTVZRHlMNDRIQnpHWWM2R3h4MzRReVMrbHVBRVRBc1lKNFQvN2dS?=
 =?utf-8?B?ZEprZVhXYVFBdTY0L1lzeU1TQWk2bVNhYXdHNkhpZ3BCTkI2T3NuT2RrVWN5?=
 =?utf-8?B?S0JRVENadGp6QmJkNWQyRWU2dWw2S0VibXZVdWNWYXgvdWJ5eEd4YWdpU09I?=
 =?utf-8?B?VndSZEN3RWttdHI5Y1RhREh0Vm81U3d1VHZ6ekQrVFZSSUlob0dqcEk1TXl2?=
 =?utf-8?B?dVFNMDRFQ2lLUzhSaGY1Z0VjYWdFMEw1NTZNMktVcnFLbVJrZTVuUDk2Q050?=
 =?utf-8?B?VlpmamVkL3FNQkcwUzlHWWhldUJVTnE3Yy9CSC9GeDIrNlRDQzRLT0NlZmVF?=
 =?utf-8?B?MFhWek9GcEFGcnRTM0JNS3BHT21mUDZDbGk1N3l5REFUODh0Ni93c0JZYUVk?=
 =?utf-8?B?aWpoRm1ibGltZmxuL1h5aStqVHZnQXYxZ2tQWXhJT3h6dGFFUDlPb2t3U2pk?=
 =?utf-8?B?SEhYL2luRFAvczhaU0xMZ0VacUF5SlpKM1plY3hJSmFGUG9uTDlYeSsreGxx?=
 =?utf-8?B?N1BGaVF0eG1rUXFtaFpJZGxFWlQ0RUVLS1duc1doLzZET3ZQNGI4cTZrUTJG?=
 =?utf-8?Q?CuViXt+kIxU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckxBcE5qYm01OG9xY3l6ejBNbU4wYTMyUTlSYWtTZnNlWTlNYzlTWHVuSmlB?=
 =?utf-8?B?d21TaHR2S2xlK09pQnBoRmx4OUk0TEdpWHdCejFuWFZVVVEwWWNSb2NXd09O?=
 =?utf-8?B?R3V2MXRBOUhFa290cFMyNkpmU2hYRlJJZ3JEQ0ViLy8rSkZGc2xsMEJDbFNV?=
 =?utf-8?B?U2hjekV4S2Z0VmdaZ0JIWWhrTWtWaElPOGh0TnZVNVlKb2FkbzU0QmVYMkow?=
 =?utf-8?B?MUk1RHIwS09NZ1dFOFpmOUJIUU9hd1ZOdmFJemgzZnYvYytDeWtlbnVlZUtw?=
 =?utf-8?B?alhxdjdqU3h0aFhnaVNOcko4K3ZFajZJbUtUb0cva3VGakNOMyt1bnMxdDBa?=
 =?utf-8?B?YnE2OEpKTkVRcTdmSS9JaFlYZlpwQTdETGE1eXBEZGtIeGR6QWJJbmVUMFN1?=
 =?utf-8?B?d3BrejcxSkNHMWNXVXBnYnhBa2wya0RBWGpNNndpdFFGVS9YM29QOHVTREZy?=
 =?utf-8?B?d0ZSWEY5SVRLRWpVZmVVenUzRXk4OHBSTHY2Vm41a0R3ZitLUVJ6YStzekFE?=
 =?utf-8?B?WVoyU1MzZDYydkFiQXFUc29peWN3UHFWYmRuM0VUKzI1ZFRwRUhPWDFDMHkw?=
 =?utf-8?B?UFJxUFoyZlVnWmp6aWhaSWtUNWdFV0dHVXBja0tEbXNHaFpDUk80NTAvV0Ft?=
 =?utf-8?B?ZkQ2TDhJbVNPYmxyV0JCWStlbnluL292eWFqVlE3YnZhVnN0Y2FVS0xQLzZm?=
 =?utf-8?B?WWdJbVkza1hRcmkxbEVQc25UeC9odUx4elZiVVc3YjZxSEhnWm05WUxNYS9F?=
 =?utf-8?B?aldCRWJNR2NobWloUDZ6YWpBbVhyem90YzcvQXZIWWxmWVBPZlJTanRLZFJv?=
 =?utf-8?B?OEhnVWZhZksvSFB3bVdrMzlBZVpkbkMwbEdJSjJRZ0U5YzVZem1BTUJBRlVx?=
 =?utf-8?B?c20rNFFrTUQxbzVwOGhISnhUQkVSdHRIVVpjWlo0RXNhd2E2eTVZTnljWFBF?=
 =?utf-8?B?dFlDZWJXdTBnRjBTUkZxTGhMMVBNUXBoUWJkbUpPcFlpQ3pZNXJTVHpRazFv?=
 =?utf-8?B?T3gwcjcyazVmOWExVDJoNGtWUG5jQU9pM2ExMC9MdEYyQUpja2IrZHlmSGpV?=
 =?utf-8?B?TTMyeWVLd1hqbGdWRDZxcG5ncWM4dFA3STQwM2YzNlY1NEx2YkZpaUY5Wm5w?=
 =?utf-8?B?czh6QmhYK204cGJXV09qSm1Pcm1aVzdPdkJSZWF5cnlXc2hieEwvd3Qycmhj?=
 =?utf-8?B?allCWFM2aU5XN3RKSThHSndBL3ZWSElXenJvSldDc1ZINHN2alV6d1FFcEdM?=
 =?utf-8?B?TEJHUHpic21WNmdCSDlNdUNxSUgwQld4cENqbVYwU0FJeDdMOGE2dmxCUkkx?=
 =?utf-8?B?U2VMUHQ3Yk5RZ1M1RzhOZGtKZUMxaHRPclVZSUYwR1k0VDFFTHcyNnMwaWdZ?=
 =?utf-8?B?cG9pSEtqOFpVQkVHMjg5N2ZvOG1ZVG82VU1hYmMvZFpqM2ZkeGw4bFh4MG5i?=
 =?utf-8?B?VWJueU10c1BMQXVVZW5DZHdWdEdNdzFMc1dwQjFPV2wxNkdKQm1FVWp5NHhR?=
 =?utf-8?B?dEVGN1R6SVRoUXVsSmdKRkxxKzZHMzBtK3BINXArR0xZSk9CNkZTT3pXQVh0?=
 =?utf-8?B?L1hqdjdMK005QzdQemc2dXIxNGNqZlJzcWw3NmxDaW56T1hNT2RFcDQvZjJK?=
 =?utf-8?B?Ry9peGVmM1o3OXBUUGJNWk52Vzc4VWtaUHFHalo1SGwrV1hidDR3Mmxabnph?=
 =?utf-8?B?NWFTTTF2c29ZUDdLWUZEUW1iUUpGUWtiM2d5SWJxSFFkZDdZc2gyZncyb1dl?=
 =?utf-8?B?L0huZ0F0bUhyajA5MG8zUldsSnI5dmh1L0sxTjIyaVo4V1BpVGlzVmJ2eUZE?=
 =?utf-8?B?OXViNnVYamhmMkhLdnRCYm9wSnowWTVQem1XTWZ0a3c5SDNBTFVuWTF1Mmo2?=
 =?utf-8?B?M2YrOGcybUo3RXV1aEQ4RFBuQ25QY0pqbGtINEF3czM4RXBRVk9DY1RoNTBZ?=
 =?utf-8?B?d09Wc0hnUEsxTU9NVlNTMlI4NmVKVmt6TkFhcGw5aERmc2tua1U5cVhaZDQ4?=
 =?utf-8?B?ODhLZjRTcVptRnVFMFVtL0oveG5LSytBejkyd1B1RG5jNnErZTZCYUtQb2JI?=
 =?utf-8?B?bml0RGlndjV5WFpwbGV6NXRNTW5xd1oxYWNCZVR2SkFGaVJrbEV3NTIrOTRC?=
 =?utf-8?Q?Slz8X+xRDnKkxD7IdQIx683Lt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GylqO1PmMeMs89cBujpQErrt6STaUPatTVNsZQ2JXRjRuvO1oF5vwuXpckWgb5S+fj+g5hCd+QJ+JiUNUDi/MwbZcshETiIQTDo0gp+vQg+YqF9niKoTPUqwcasD6lrduJLLbhqcki+eUaw+mqK93Zo1sO81J7roPdeIoVCA4e9Yce5gVvi8XoNMEpe9QQ8T447O2USzkZ3MjCoIzANK+YdEC90VpY4qBo9urECllivSSn94iProY2DYgc2WvSDeYTaqrzh/u6rTdz/0WD+CZCfhxJf6lrZ+NqMATAJHcwXF4neoK8RgUSd6YyQb/nvzyMI+8iQTpGTWwdqcQFVyzQ810e2jsF1BPQ4Hjt2B2NWV1xaRlozRJ78GyzAblm5Qj08GFJP9+meyLSyHqfw42DUtn4Ge7Xx+Nu24zPx9L/cs6IMNVfcFaQGCDRTOFbbmR2kyFsuBq+c9Qy0slqn+rjopGwcdqEkPtmnF9f/UI4RpxvFdCk3HRc1oPVYllFTr2fl7+0yU7DH1d+0vRarayTvM77rR/3HZ6YHepys4iCVcC+vJOCzRCgAJUxSCusxCtzD5FgLWPIUIRfz0IUX25CqDn5UoYS4ducxSjS6MoVN13SC11Rp68Mj/s8WqvAJ6
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc5b598-b9f2-4e5e-929e-08ddf41b9f15
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 05:49:22.7348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kxE0t2orUgWqVPYCYsx6Q9/lAmeeekwnKZsWrG44rtOR+t7u+N54yv2dxtq1AhBvHuP4E0QO+/8bvtwVfiGbOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P192MB1767
X-MS-Exchange-CrossPremises-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 14
X-MS-Exchange-CrossPremises-Mapi-Admin-Submission:
X-MS-Exchange-CrossPremises-MessageSource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-OriginalClientIPAddress: 104.151.95.196
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-Antispam-ScanContext:
	DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-Processed-By-Journaling: Journal Agent
X-OrganizationHeadersPreserved: AS4P192MB1767.EURP192.PROD.OUTLOOK.COM
X-Authority-Analysis: v=2.4 cv=HrF2G1TS c=1 sm=1 tr=0 ts=68c7a8e4 cx=c_pps
 a=6bOcy6oTFcs4RAGbCgVnUA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=8gLI3H-aZtYA:10
 a=WQe0MGoAMNQNjMHLNwIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: TD_wp0oJA6G9zwfhmmo3qxc8Qg_42NVq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA1MiBTYWx0ZWRfX9cM65sI+LuOZ
 ZH4yyfbVdGvjz3ylL3b0qw/hNV4vYVB1+rzOGjwTjjkMWz8SQBrA1ztKb88eMSqSq5ITjjHemj9
 RxS1sFvmYT1ZEoh6uJ6deb2Bw9i2zNjONGxWZ6jR+AwfmGz45Syr0OchNwmwb1//iXGt2YV4YiK
 c44CceB6f/JmSRTMtXhPqkbofwtK+3BeFpas1GuTPCUXO1P7QJuqBSQUQ7oUzzMVp7pJtgeeWMH
 nK1caPWmDE7nOHadVhJVrvj8wZbGS2GYDTGfkDM0NB/ES4dRiFvxfMCx4BwCAqqS0d9NHOewMMg
 zr8Njzr+jJSWoxfrVuhRjFLN5LO3bVx5lSpgOqo38/5bQ35Bc7JE8SlCLb2jgU=
X-Proofpoint-ORIG-GUID: TD_wp0oJA6G9zwfhmmo3qxc8Qg_42NVq

On Sun, Sep 14, 2025 at 08:06:11PM +0300, Jarkko Sakkinen wrote:
> On Thu, Sep 11, 2025 at 03:52:33PM +0200, Alexander Wilhelm wrote:
> > Hello devs,
> > 
> > I'm trying to bring up the SLM9670 TPM 2.0 device connected via SPI on a QorIQ
> > T1023-based board. Pin control is fully configured through the RCW, so I haven't
> > added any additional properties in the device tree. The SPI controller accesses
> > the TPM using `#CS0`.
> > 
> > However, the driver reads an incorrect vendor ID (0x1000000) and hangs during
> > the startup sequence. A logic analyzer shows that the chip select line goes high
> > immediately after transmitting 4 bytes, which, according to various forum
> > discussions, does not comply with the TPM specification. Unfortunately, I
> > haven't found a definitive solution to this issue.
> 
> So, at least the vendor ID is bogus meaning that TPM driver is doing
> right thing.

I think so. When the first transmission occurs, the TPM sets the very last bit
to 1. This seems to be some kind of acknowledgment flag. So when I output a
32-bit value, it appears as 0x01000000. After that, the chip select (#CS) line
goes high. In the next read operation, nothing is written, but the TPM again
returns 0x01000000. This doesn’t look like an incorrect Vendor ID, but rather
another acknowledgment flag.

I’ve looked into the TPM driver code, and it uses a `cs_change` flag to indicate
that chip select should remain active after the last transmission. Some SPI
driver implementations, like `spi-fsl-dspi`, use this flag to configure
additional registers. However, `spi-fsl-espi` I'm using does not use this flag
at all, not in a single line of code. I believe this might be the root of the
issue. By the way, the same TPM works flawlessly on an x86 platform, which uses
a different SPI controller.

I was considering using an alternative GPIO for chip select. But if the code
doesn’t make use of `cs_change` anyway, that probably wouldn’t help, right?

> > Could this be a bug in the `spi-fsl-espi` driver, or is it possibly a hardware
> > limitation of the T1023? I've come across some suggestions that involve using a
> > GPIO as an alternative chip select instead of the one provided by the SPI
> > controller. Can anyone confirm whether this workaround is viable? I’d prefer to
> > avoid a PCB redesign unless it's absolutely necessary.
> 
> My first guess would be that the firmware inside TPM actually does throw
> a broken vendor ID but it is exactly a guess :-)
> 
> I'll follow this, and please cc me also to future threads but right now
> I'm clueless.

Sure, you've been on CC since the very first message.


Best regards
Alexander Wilhelm

