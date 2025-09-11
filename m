Return-Path: <linux-integrity+bounces-7055-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8411BB536BE
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Sep 2025 16:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBF8E1C862A9
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Sep 2025 15:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72B0343D94;
	Thu, 11 Sep 2025 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="ZK4S/pr+";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="orxBpJC5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx07-0057a101.pphosted.com (mx07-0057a101.pphosted.com [205.220.184.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1622D130A;
	Thu, 11 Sep 2025 14:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757602683; cv=fail; b=A8UGl3Xw3d3StWKKK/z5z0IM/Y+zXqP3jLW5JukQpkNrUu4glUzlitUapxGwPqEeD9oSfTf5XVaCd3yIKVFYXNkYP0OF50SMN5uWfha5uSHuID3xbfmdVVpSj1g08AZFwwO0GnAGaaTXC1bf2lSTRGXO6zCgZEouE3myUl/g0VY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757602683; c=relaxed/simple;
	bh=qUw2DTggMIQLlsDOpBLiZsmuI0UDRnP9GbZi660PEFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bwTt9klA0JHoOcJHe9+ARBDsSHowqPdijIFTLCLjhEv1nTQb++b8w4ETuBMIsOnJclzn7n/18k9My/T7XaQ1Jd19jSL5paPEn3HKUqD07uZIg49V0Vywt7gMRVdA8xStEW6ntsJ9QCmu4yEJ6Dxo41b2gmzjh4mDmC4c0DOzKTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=ZK4S/pr+; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=orxBpJC5; arc=fail smtp.client-ip=205.220.184.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214197.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58B4rBX04086617;
	Thu, 11 Sep 2025 16:51:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=270620241; bh=
	atTVO36UoRGcXWoesxfyvRJEQbDxzd1O+db3u2I96bM=; b=ZK4S/pr+Ll5FULJ2
	NRwof9KmKD8G+O1/8PcqLPLqNLCi8l5n2x25Ic/D0id5hEaJKPmwIUnRFMiNwjTr
	c0WMOKjM5ku0mstiaiibrXz/D3/JJQTDLTZY6+ncvyFQrHtRrVtk133bFCA3ckft
	dIi01svsjDxjJVW3G0PguwgLJYOTIdor3gQqvAUW79IRNNlNGaa91EqaxGJElU8g
	iuDvE15a4Np6MW3xWVAbSKyoqsX/8NQWFsGMVfV6dT/1pEQionqXiuZ+yFrJoq+0
	L0RA62S7VUFVwIDpZIkQVNlu5yv7UEDV0eSisxkSdZlizJGZ6STftD9NRx9JT46W
	x1BOtg==
Received: from eur05-db8-obe.outbound.protection.outlook.com (mail-db8eur05on2109.outbound.protection.outlook.com [40.107.20.109])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 493chb921j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 16:51:36 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KrLhOJt969GaiL+xh2W6v/RF3UySIdRlX4nqqQpG0bNXFbYBPqcYkVRwb5U/zzdoTdjW5bfm1ftkPbK0vv3ru6xrwqDFZlZBNl3E3CmvMh/m820Tq/rBDMW0FOVTCzICXNi+awL15HxMDJ6CtTSmnzvmELGAStODuBOPBMK65R/36mY/du86SJmp/tOvA9mfsm23IcF7EzfvqI4Gju6bG5orefV5GBaEidhbHcIhUIDo94bdMVqZYTy2f4nZOxmxWw/KICOg3+ehbiiUdTSzzLLoW6OFYOdlZBxxnXTwLP3U86OJC+QRR6rqs6IOQPNlCtsv1qW39g3iX8agq0c4EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atTVO36UoRGcXWoesxfyvRJEQbDxzd1O+db3u2I96bM=;
 b=tZGvGTbIv0UTvAjyWdQGUBiXRrb1uryCoF6pP4/F1MRs12deCPogJhAf/lo/lkjksRnOxrF0eeXx5W3w/fcr4lkMZJM1fO+D0VV/lkOGh3FQMk8MyIBJo8s47uMOxpQOOa43qdc4HMR4P5ghEIG8SoNU+3jnSsI97BQ9kl4pk9xjthqYRZRCaYyGsaLCYe5E5LWSbiQDiNU2vUe749pqfcv6OO5WOxND0Y8Xg09WuhTAyZz8IW5wJjn5q4r4XGx7ejvgK4IVvpTzLRNqJ/m1wdsXGDWGo1PglYO3TE0CcJRgybbRHgZDYsWfdPCRD31YRWkhTaqE06Hwmp0pNrMtjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atTVO36UoRGcXWoesxfyvRJEQbDxzd1O+db3u2I96bM=;
 b=orxBpJC5cb8xeEbfOXfqST60Lw4svkKeWkBP6CibCcSBigUlED1D4icduUB6knBe3K3q8doFop+7oaU8VQ0OrasXH4+GFvr6vGnFlj219qYWq93GLO3BBLyKQ9ZyDRUVxHN71rxWgzFL/h7rHJxPMqIEc4RFlpInpHnejx71VsA=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by PR3P192MB1024.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:a2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 14:51:30 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 14:51:30 +0000
Date: Thu, 11 Sep 2025 16:51:24 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Mark Brown <broonie@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: tpm: SLM9670 does not work on T1023
Message-ID: <aMLh7MCsPNwOqTsG@FUE-ALEWI-WINX>
References: <aMLUIVjHZ6CFvd33@fue-alewi-winx>
 <644b0f0f-9e02-44fb-a0d4-f4018816e156@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <644b0f0f-9e02-44fb-a0d4-f4018816e156@sirena.org.uk>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: GV2PEPF0000382B.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:5:0:e) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|PR3P192MB1024:EE_
X-MS-Office365-Filtering-Correlation-Id: f5ade782-aff2-475a-8a63-08ddf142b186
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVJuS1VJRTFKV0x5NUxGMzh2VGxCUUdoNlRkbVMrQnhDVUlRbnkybklIL1ZX?=
 =?utf-8?B?emVqRy9nTWdTZERoM1RsWEFvS0JsdjFQKzE3RmYvb2ZTVGZBY01sNXZFSGlB?=
 =?utf-8?B?WUUycmYxdityZ2tnWTNoeWk4N3NtcVBJRnFrTWQ4aTdybkorSzNHbEtmSTBp?=
 =?utf-8?B?ZGcxTHBPYnY5U3gvQ0tndUpmRlVwUDQ4ZG9oUHRUT0V0SXVMZkZXUERjN09v?=
 =?utf-8?B?TkRLMkM4OHJvUG1USzF2d2QyOTFJKzZKbUFXbElJd1hWZi94OUhndEZ2ZEMz?=
 =?utf-8?B?azZZMWhLK1FHQ2c3cW5FNzZzbGtoODZDc2tCNnBVZU1TZjBmMURFQXJQeHY5?=
 =?utf-8?B?TE9ES0VaRTEzVHVvRmswU2RENXBMdFZYSFBJbDBWL3V1TWNpRmZXWGcraVVm?=
 =?utf-8?B?aDdwcTZzdm9lUW5Ea1F1M3NiUXVoeUVPcEY2K2phbTI3RVRWRUl2Tlg3dlkw?=
 =?utf-8?B?VDZFa2RzWVFhb1RoY2lVRSs1dk54VGQ4SE0waURZWXpGNFhYQzZxWTBqTjhC?=
 =?utf-8?B?Q2l4ZWJJcHNxN04yQklGbVg1WEJuaE1GREV3dThQb1R3ZXhBcHFLU0hKSCtx?=
 =?utf-8?B?OG1zTUc1cmF4UnpYQkpsTGxsK2NhOWRDT3RQb3NpNjVVdVFrYjdJdDRFRnAy?=
 =?utf-8?B?cENYQjFFSENDa2dTRjh3bWFVMjRSZlo1WkVBTzFtZURUcUxMdnZxejAxazZY?=
 =?utf-8?B?SWR4ekhQbkpaaVFYWDlpUXZpYUQxdlBGY0VyMVdERVFLYXRWWjRBK2tPNnBl?=
 =?utf-8?B?eFJSbU1uZWtZbm85VjdMV0UzUFg3ajIwcGNrTThXQXFLeTVYYUE1bHEvTWpp?=
 =?utf-8?B?dlBVMGNCL1ZFT2JtazBMQVlTZHNtOGIwVTgxUEhmejF0K1lzR3hzdHJiSmk4?=
 =?utf-8?B?RnZoRkNpZXM2NnNWWUplZkdDNUZac3U0aFJENlRRejlPRkNxa0dZRENudzND?=
 =?utf-8?B?dFVZV0s2Y3d4am1mNWFtV2JCaW9TanQxK1hpMkdHN09iRE5RVEE1R1JoT1pr?=
 =?utf-8?B?citrOGpZZks0bHVqODVDWEZLWXF3SjI5MGxHSGp1cVFqTnNoUHFZUWI0Q1Nl?=
 =?utf-8?B?ZWp6bUpaUUlNK0szd1Jnc2lRWkRrdjNiMWpTRkdyMWovdmtrZWJ3UWppSWdD?=
 =?utf-8?B?TDVhZmw3OU1GcW9IMGF2dHhWdXAzOHNVWkREblZFc0hSV0pnNGkxV1QyblNX?=
 =?utf-8?B?U3k0blRDb3IwSCs5UXI2SUFZOXFERVArczlXcFBjWVIrM2JkM21tdUF2YVVl?=
 =?utf-8?B?TWNyY1o5c1c2N1FaL3lrNUU5Mm53NW1RWTBoaFVLQmZ3Q1RKYjdnMmNQVjBt?=
 =?utf-8?B?NTZoOEpyalRwbEloT0ZXMld4bFYvSDRoTUloWTFYT1gyVm40U3dSL21xeTFt?=
 =?utf-8?B?bmhnUG1iNEd1Vzl3eUo2ajFZS1N2QnE2K1B4UVVwM2JNalNBeXYrMGFxZk9V?=
 =?utf-8?B?cEpJUDFYVmo0R1J4aCtmaXkzVlNRN3hsbEoram5FU29IcEZSWCtTWFRZNEdC?=
 =?utf-8?B?azI4Y1p4Q0VNb1ZGQkJ5VzVnSm9EUzNEK2hDVHRrQUZWdXFMZlAvQm5ud2NN?=
 =?utf-8?B?L3YrZUlEeDlMUjAzMm16dGl4RXdUWjlJOGJwUmlXQUk3cCtzSVRQRTNRdzVB?=
 =?utf-8?B?QzRBUkhEYWgrQlZCMkI5bHZJSnVocm5IdVRMSkxDeWpKNDYvSnprcjlUTVNu?=
 =?utf-8?B?S1V3VVNSTkx6TDlPUjVpVXpuUGhYUysxY0NhcjZ4UDBVeEgrc093d1pxemFh?=
 =?utf-8?B?OFJhK2VEa2J0SWo5cDE5Q0xNd05CUnV3ejIzMVk1VmJrc0czSVVETkZzbVYv?=
 =?utf-8?B?MjB1SWdaZXQ4TGlrM2E4MjB2Z1ZkU1FuUGJGZG5aUy9ZZGNLSVBJUDJZREd1?=
 =?utf-8?B?dTRoZ2dMbk12dk1OMndRb3hWVkVobnp6NlI1SzVyNUxoazJOWVNBVlgyTXQ0?=
 =?utf-8?Q?+Uyy8ykOrGY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ell4UHhlUGFKSmp5TUZScGErQnNJNDhKMG5sc0RNcUFDQTVCYTR5YzM4N2NB?=
 =?utf-8?B?V3p3YTZYcHQwRndJbmR6RitiMGxjYmlPZ1dQc1B5Q210cUJxeFJqVlVZcWgy?=
 =?utf-8?B?bUhiOE90U1d6bUpKSk1mNjd2Mjd1c01aRXpCdHMzaXUrNEc5UTBYYnhPN3R4?=
 =?utf-8?B?NFNwTUtBWmFSWUd6NkJZNC9VT3VBTDdqZkk4NFNIcDlHb0lqeU02VThBdTEx?=
 =?utf-8?B?U3kvZ3N0Q0NDUUxmSmYybWZuQlB5Z0lGcXBzalFJai83ZjhLem81bjFqc1li?=
 =?utf-8?B?YXAydHg1WGpVcnNHQkpEcmJRc2dDWU9RSlU3b0NDbXdnV0k4VlJHVVdob0tV?=
 =?utf-8?B?YmR2NE1lWDNrM1BMd0c4cVNBem93d0g3b3pDMGIvVU1BU1hDZGdOMlRyN1RO?=
 =?utf-8?B?RkdKU0JqT0NwaVR1UTVxWUpERXF3NFZuSDduUDFsbWU3UERLa3pPL0wrVE9z?=
 =?utf-8?B?MWl4Q0l1MjFaSDZpT0k4bE9QbGcrSG5tVGdmbGN4ZzN2OXpyc25qZXI5eVV4?=
 =?utf-8?B?QStJVXM1SGQyY1JnTVc0OWgvbHJodHorL2VXVnFMWkFwRzZwK01uRFRGSXNz?=
 =?utf-8?B?MWI1WmgxMlo3d1FyQm82Y0NmUFpTcUgvaTY0ZXF4cENqQmtPaXpreFhDN1hk?=
 =?utf-8?B?WjFhT0pPN1lkSFRqUWdEY25hYWJTaUVRcDQ1bnorVzA5M3BGK2lpZWVnSVlD?=
 =?utf-8?B?eHh4dEt3bEErNjRsNzBzT3NGZXFKTzJiKzRTZmFuMHU2KzdzN0I3dFhqODNQ?=
 =?utf-8?B?T3JGRjlYSE5ua1NVRHRUYmJ5dXAvdDJZcTlYdDFTTHZ6TnltNHdudnZtS2pY?=
 =?utf-8?B?ZStMbnA5OWJTTTVDYkNvckVYRXVJSldSVG5wam5DU0ZPdWw3U1l0cDYvUXpQ?=
 =?utf-8?B?UjBrZ0hXSmN1cnNwMWRMU0tURnBDNGV2Qk5QQ3BRdEFGTk9Xb1BzL0w5UEFN?=
 =?utf-8?B?ZW5IdDJ6YTViS2s4S3BWZGYyOVhSbVMwc21QalJXS1JBNWgrMHk3c2pncWJI?=
 =?utf-8?B?REdyME5zbGh6NWtJK1ZDNzdEQlNMbEF6TXdrbHA1b1JVZzN5MWlEUHFxNHVk?=
 =?utf-8?B?V1pCMFIyNFd2NjE3cm9uT3lSVXgrTDZqZkFVVVIyc0lKWjMxUDZoQkdKeXNC?=
 =?utf-8?B?cUkySnJYQmVSdGZhZjhZVjNwSG5NWDVnTGhuaGpETEFRUXB2RXdQbkZ3cUtt?=
 =?utf-8?B?VTY0eThPN2R0QndiVytKc1ZaVkExYnNZdE5COVRCN1M2bGtFellIc3lJWVR2?=
 =?utf-8?B?TUtaTElvSGVTNk1KRE1LVlp5cjNLU05MbXRNaUVTZzhWQjZabDBRb0pDQ2ow?=
 =?utf-8?B?eU5McjdoZFJXTDhXWUFWL0FVSHd6RDJHNk9JYjZPS296VTZRdmFqYml1MG82?=
 =?utf-8?B?Z3pHRHhHSWN3ZUQ4ZUFiQ1NZclR4bXdnbUd2cSs5cVpqUkoxYlJRUE9ROEoz?=
 =?utf-8?B?UkNxRTh5aHVPYkd0R0dORUhNQ1RqWDJBek04d1NjTG1EMWVWeUs3VmhlM3VZ?=
 =?utf-8?B?dlJMaTZtSmNYcy93b2h3VEVWc0ljSjV5QVhRMS93dW04RFNBSGRZWitkUEZl?=
 =?utf-8?B?MUxMUlJ5bDBrZDFoUnZWYjNKTFhvVTh5YU9HZmEyU24yT09jOFZBWUZ1blFq?=
 =?utf-8?B?elgvREdrS0ptckZQTUorakpxUW5xcm1mRVJJZ1NRRkZrd2JieE0vVGh6QmNK?=
 =?utf-8?B?b2FaUy9VanUxY0E0ZExodlU4Q1psZTV3UzNhbHIvMERNUG9SRnJGZ2lNa0lk?=
 =?utf-8?B?Y2Y1V0ZLU1JrVjBZMGJ4cTY5NlJwTk5UTjA3QWgvSk4vV041YzJmcmZ2d3k1?=
 =?utf-8?B?NDhxSmpaS3RjbmJlUThlQWVFSEpPdGxnOFcvUjFXVTNQaEN2TXpyQ1Q1N2hs?=
 =?utf-8?B?MlFWQlBqMC9oMzFvYW9HMEhqU3VmN0JvZ0lvc3Y3V1pRb0RKRnI2UUlObjZu?=
 =?utf-8?B?WXIvZzl0SUdQUVFJNFQ0UmhVaXVEaWFqcHkwY3l5MEVOd0Vuck1uRTRzc050?=
 =?utf-8?B?VUQvUnFPS3pvQnVxNXFNMHVxRy9pcEZ5dDA4R0xhampyT1NYdlVNTm1ZN0t0?=
 =?utf-8?B?MEZqU2FUNEJKdnFxY0lMTUYvUDZYdlFtaHlNN3ZtZTZQQUtyR1F6SGJ3Nkww?=
 =?utf-8?Q?iFbo08b3+Acb2B11gzrRjYvaq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	A4q5HQpzO4LruM4RA1iCRSK8re9Wwzc0WSQSsbBCe7LpVzCZ+dqVBFbydEb8SZpElBTZ6HnAgoY5vS9fgiwPyySo8a2EXMp6++uxvecVAnWP+J53AnO/PLlT5EnPvN2cO4OPKLZM8I1Oh6k/uywRrjw3NrWwRZnqSkPhO3cfUxlEgGJ+8LULx+p/01JmjXEazFeeGTVLjgm4KC5wxOMaNTxgEmdv5jVKfcxt1aXLdeCaqtZzgqkp6JNd5uyDwSTL17xLqbfnOh554WApPl52hr2bvfNf+2b+poSVP6OVpf22WijFi/YLxDZCvGD+WvvQjLTnwZzcc0zcEH90D7+ZW5IkkR9NuQNg+NGaW16hGQPqYa71mq8xKZ+Ep+dN+RYUMzmpL+UQLLll4pC3uU5x49J0VyhRZ31CnH6KwmOfyIMLNRtWCIYSIdVCfTxfihn9qS2Hx9aKYoFvggDMYJbrIfODdvMHZRjhSxJLFOdndb+4kiqhaUYgnxii52y4ehtDYVVhrum318OdG5fvAEOE8GMBv+vjPEIIxuUQN7LWC7qKTCLVmiZZaic5Tkwqty6ROdgM878KInKtA1mmtN73LlHeIcZOtfa+GcJZjYBetVkih51d/vRv8vdyfjt/GkXx
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ade782-aff2-475a-8a63-08ddf142b186
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 14:51:30.5530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NmJH2Ec0h4TSKwR4rDixtQBDLb8gwHwIAwdYnCq2aYB+tYp86H0iBdumY7B9qU09LH9EejH3sr5WKQDJNmlbgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P192MB1024
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
X-OrganizationHeadersPreserved: PR3P192MB1024.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-ORIG-GUID: dgG-ekTaJCPUfYi54jBW44KadjDKjQ8f
X-Authority-Analysis: v=2.4 cv=B4S50PtM c=1 sm=1 tr=0 ts=68c2e1f8 cx=c_pps
 a=GwmIoWvobFxHOugU+5z7pQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=8gLI3H-aZtYA:10
 a=XMr7uJ95FAjf98OZuKoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTExMDEzMSBTYWx0ZWRfXzjLhFAKyGJR3
 lx8XYPaElfsPBr5KwBFjGsn+aKvTpPSal/QHYdiEmi9VerU8oxPO71uzgjGv0BV0cmaePyLUqlR
 ow1PLQoZId4vm6IGoh4kwVsCmVDhYCddWJgtSIwZVSZyI6R1r6peDS0ULUOK48MoRh684tsqczE
 bkJfnXdbYxeN6GARzc+KGCLIiBG4dGYBiYrRogzBEvXvaiftmJepAbCrUWYOyzy2iPjFMgzZwnl
 EVCzcQyXil0F7S2jO5NBg/s+0po1iLFsBih4pIuGimxYZuUCZEGOj7qtnV5RTzZHIVxKtCO2En1
 /f3GmuUJoBGrekl24X/SuUBUfsI+GP2aVvtYY+KJzCVe4IwaA59d1Bpf4av4vI=
X-Proofpoint-GUID: dgG-ekTaJCPUfYi54jBW44KadjDKjQ8f

On Thu, Sep 11, 2025 at 03:26:38PM +0100, Mark Brown wrote:
> On Thu, Sep 11, 2025 at 03:52:33PM +0200, Alexander Wilhelm wrote:
> 
> > However, the driver reads an incorrect vendor ID (0x1000000) and hangs during
> > the startup sequence. A logic analyzer shows that the chip select line goes high
> > immediately after transmitting 4 bytes, which, according to various forum
> > discussions, does not comply with the TPM specification. Unfortunately, I
> > haven't found a definitive solution to this issue.
> 
> That sounds like the controller is configured in word mode and is
> bouncing chip select after every word it sends.  The Freescale
> controllers are fond of implementing and using that, no idea about this
> specific one.  I see there's some non-standard DT properties it has
> which look like they're related to chip select modes but no idea what
> they do.

Which DT properties are you referring to? I’ve only used the default ones
provided by the QorIQ DTS files in the kernel.

> > Could this be a bug in the `spi-fsl-espi` driver, or is it possibly a hardware
> > limitation of the T1023? I've come across some suggestions that involve using a
> > GPIO as an alternative chip select instead of the one provided by the SPI
> > controller. Can anyone confirm whether this workaround is viable? I’d prefer to
> > avoid a PCB redesign unless it's absolutely necessary.
> 
> Can you not pinmux the signal from the SoC to a GPIO instead of the SPI
> controller?  It's fairly common to do that since controllers often have
> regrettably limited or unhelpful chip select features so GPIOs are often
> the better choice.  The controller does what it likes with the chip
> select signal but it's not actually connected to anything and we do
> everything in software.

The problem here is that RCW allows either both enabled SPI + CS or disabled SPI
and CS-pins set to GPIO. Furthermore it is unfortunatelly connected, so I cannot
simple cut the path on PCB and need a more complicated re-design of it.

The issue here is that the RCW configuration either enables both SPI and CS
together, or disables SPI and sets the CS pins to GPIO. Unfortunately, the PCB
traces are laid out in a way that prevents me from simply cutting the
connection. A more complex redesign would be required.

> I'd recommend contacting whoever looks after the relevant controller
> driver, though it looks rather abandoned TBH.

Hopefully, someone with experience in this kind of setup will respond via the
mailing list.


Best regards
Alexander Wilhelm

