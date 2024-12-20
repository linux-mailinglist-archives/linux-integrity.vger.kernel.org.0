Return-Path: <linux-integrity+bounces-4446-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C039F89B5
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Dec 2024 02:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 997E91891646
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Dec 2024 01:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2EE259487;
	Fri, 20 Dec 2024 01:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="n3ALOrmd"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B41923741;
	Fri, 20 Dec 2024 01:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734659260; cv=fail; b=PnjW/OQHU/DdM5GqFhs1HUBOpAMSMSX8f8iTKfNLcBcsObvGFAMKKmayjP4G3u6PyjpNPnRxae6FTCExKhbteieDCEpoWVD0lnueMiX3R+4SSKREtufiij/hb+cewwyK4VtSFxX7aqhUUiwQut7b69N88fU8uuwtu+heOTq9H7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734659260; c=relaxed/simple;
	bh=sX7YlV0tOvjKM+dHuz4o3LmMouqtTGPUMpwSbKUY4bk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dgQcXSnxLBntBunUYdDhetSDjJ4Lmmm41qSEmKMx5OvO6AWToxjI1+EfvXM3RbV8dC1z8r/FiI5TnL/Ino7BoBj/NiA9xRbBGXrltoGbk6SqYaIJK7VFiU016pJD7uHPJmvvepuIrah+dDQ0R6O+AzFQ9Ebqhh7pX6bSlE5ORrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=n3ALOrmd; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJNfSec031687;
	Fri, 20 Dec 2024 01:47:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pps0720; bh=sX7YlV0tOvjKM+dHuz4o3LmMouqtTGPUMpwSbKUY4bk=; b=n3AL
	OrmdVFD/EHlOY8kKCJhlHnMh8ruAbWuUbqo3O3NpMHWOsAah5+MRjD3FcmW8jb2G
	2uPLfjn9QZoY80v14AQl07vJ27PS2RgGY9+U1iSXbUbMEHY4wn2xBVFU3kR+v5Oj
	icb5YVd07i9cha6+K9qpDNe1jEKGZnszOJK1zYQhoU0vHbG2Z1b0st86o8N0DWmL
	beO02k7fB5EK6aoLYuQ4WIyAx5fThwSewCCjksvvZg+GeaBMv+AspG/jokqio35f
	TF4sJxQan48OLg48f/7QlQfjPTYRflja3VjeNEIO8CX2Ja4WLZIQE2YDZtaSpdgs
	UBfgJYRlN7ddRAqoGw==
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 43mwcggrv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 01:47:12 +0000 (GMT)
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 8C328806B67;
	Fri, 20 Dec 2024 01:47:10 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 19 Dec 2024 13:47:03 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11 via Frontend Transport; Thu, 19 Dec 2024 13:47:03 -1200
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 19 Dec 2024 13:47:03 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UzENTWJaL/DFP/mC5SfMafekW2OKHvqE3wdxzzN4/5VAtPgUJUd55fva1JJyOEkNlCHLjE33pRJqC5ZPI5xtj4Wdamo0E+TXPY4CMlqSwpds52VIPGIieKVKkhgiJk5bllQg/R5/HZR7wimTevxF4a0eV+/i+0EXCo8TGH53XaHrtquKW/OurZgS7ULjLh9jUWUSVhLSl9yI479eE7Ifh2xpswR5d3TaP76+P6J8C9jBVfyrVFtxP64tAyXW58jvHybbdsgXPrKkm+V3jL0PzUqoyXUEpOjY668pVSsVupgQAYWFYUZrYyHbjpuSgCC9ml1OcDQ3LJuBeBzAHWi2OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sX7YlV0tOvjKM+dHuz4o3LmMouqtTGPUMpwSbKUY4bk=;
 b=t4Dsuqbmv4W1NJDc08/GcmhRVClZQLmNeAF9WHZshQtMOPAOmmzCo2jp7+3hN1eGbdGesn1ZKM497uu0WgAtj9I2bYPwly9pMYqI6Yiz0ndnD2C1qkKTkTzslHFfKmvN6Bn96mvsjv9SdHE85nLtdPPjt0jwsaRK5wYFxzeRjedSbsZsaO+bylL0zDiRD46JWQ0R6fe/3KTDbdyD8O9NyI4FtnngeKXyvBH6nXgduU9iVkNM3epnWe9OCINXwBaYtvpTVHYZZ7LWJnGFStPoCDoRWPG3kJOrbPdQ6x5amw2aZxyHBi9XNb+WAs5mggKqKWeTsOdiZbWZ2pzcAJ22Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4f::17) by
 SJ0PR84MB1895.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:435::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Fri, 20 Dec
 2024 01:47:01 +0000
Received: from DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::a5e9:4a65:e738:8b3a]) by DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::a5e9:4a65:e738:8b3a%4]) with mapi id 15.20.8251.015; Fri, 20 Dec 2024
 01:47:00 +0000
From: "Liang, Andy (Linux Ecosystem Engineering)" <andy.liang@hpe.com>
To: Stefan Berger <stefanb@linux.ibm.com>
CC: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] tpm/eventlog: Limit memory allocations for event logs
 with excessive size
Thread-Topic: [PATCH] tpm/eventlog: Limit memory allocations for event logs
 with excessive size
Thread-Index: AQHbS1KoVUrDl6O+u0uT0x1rXFgY4LLjvaOA
Date: Fri, 20 Dec 2024 01:47:00 +0000
Message-ID: <606ADDA0-F1B8-442C-8E9D-176CD7A1E4D1@hpe.com>
References: <20241210222608.598424-1-stefanb@linux.ibm.com>
In-Reply-To: <20241210222608.598424-1-stefanb@linux.ibm.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1976:EE_|SJ0PR84MB1895:EE_
x-ms-office365-filtering-correlation-id: c501fc17-725f-4753-9bb8-08dd20983260
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?L21XODBDekhRelZxbzBDcU5IUUxtQ2pFMnFlcFBMU0pseGJyZExUbXVVNm5P?=
 =?utf-8?B?VlA0clNHakpBZ3k4b3NtSWNwZW5lb0hERm1ORnRvVEx6N0t6Z2xJc0ZkZWQ0?=
 =?utf-8?B?dHYvMFczVTd5Q1N5eDMvT0Q4ZVBMNEpSS2RnYVZnWWpuY0Y4VjBUbnVDRmpT?=
 =?utf-8?B?dkFiV28vQUQ5ZEl3RXV6bnB6dU56K0ppeldyZC9DRUs1T2ROa2NpNW1IL1hl?=
 =?utf-8?B?SnhCZzZQQUNadm1mZVFlN2RpWEllWlpPY3JFV0E4clZZN0c4bG1QNWtyUnBk?=
 =?utf-8?B?MWNFTlY1Y09ER0ZGUVAyV2RnTHkxR3JCNWlzb1VpcDZ5MzBlRlVFaEx2Yld3?=
 =?utf-8?B?bGhtOTVqL3ZHRkc2SVZRTFd0NjhwRXR0ZmpCWm5qYXdCZmlRVnNlSUducUVO?=
 =?utf-8?B?ZCtha3Z0dmNZY091aE82R3ZGVUlmMytLYmFjZTJkQ0NuU1FoNVpZdzlHTkxP?=
 =?utf-8?B?a3JUckVUMW13ZzVkcUdMbEx5YWJuZEliWStub3dyREVoMWl5dlZCN0RSSW5r?=
 =?utf-8?B?TXdQa2hrVHN6NkNkaWxoUi9LdVlCYkZUdEt3azVCSkk2eFJwT0o4VWlDWWlQ?=
 =?utf-8?B?RTlFQnQ5NWswWWdrTExwbm85aWpkQ2NZKzRESVF5dGV6L1c3ellOVXhkMnlY?=
 =?utf-8?B?OXRmZWMvSCtPdGt1Tm5EUXF4eGJLT3Z1ZHZHOE5CQUJuMWFpUWU1ZlowbmpC?=
 =?utf-8?B?aVFNbklYRTd4aUdRZ2FWbmhVLzI5OVlaUFhlVHVKZTAvb2xmcEthaUxwN09o?=
 =?utf-8?B?Nkd1OXFrMGRXbnlwQzEyaXNKSU1yTDVXZEdiL0kyTGRZdkJQN2VrUVJjMVhv?=
 =?utf-8?B?RDd4azFCcVEwZTlTRzVJRWZLcnRreFVhWWFud3NLcEhTTkw5elpLdXpZZ2xt?=
 =?utf-8?B?MGZRajVwZm11aU14S2l1Z3pERUMwallqaWdPajBjRFpjQWFPTmRQYVIzZERa?=
 =?utf-8?B?b2xodFVTUEFQeDh2Znk0YmVRTWMvT2c4cS9hV3FBeUlyZEwrbUNPbWs2TDdx?=
 =?utf-8?B?STEzRWZoVEc2N3U3YXE2RllvakJsNVBXR05BMDdpYW1LR3RnT2NjY0l3aWZQ?=
 =?utf-8?B?YnlCZ1g5Q3FUL25SVDdqengyVHRNS1YzbzZJR0RHUG0vRGhHMHpvNFJCSWtp?=
 =?utf-8?B?d0hzc1ByUTYrczVpek9OUkY3TEYrT2dVS0s1dlBIMVJkMVJORFFHTENWV3o5?=
 =?utf-8?B?V0xORzkvYXVsRGkrbTFvMHFkR2NDZFRvRDQ2SDJNV0NtZCthUmtWdUJkZmxC?=
 =?utf-8?B?cDVkOTZxdW1NWmpVdEhNS2xFSlNNWmdUelhXRnI3UWw5cDVRV2NucmhPVU1U?=
 =?utf-8?B?T0d2RElvL2d6MTN1N3lycGpaN0V1RGd0a29RV1B4RmZPdDh4RmJJWDRTaUxH?=
 =?utf-8?B?bm1yc0NuM1EyWis4SVZYdHpoVGZrSVVsdUhrdktxNldLeXpkejZ5MU1ZdkxO?=
 =?utf-8?B?UU1DV0hBK0tuVkRrYzJyczJSaGN1aG1aQkJXL2xBL2RVaDk3aDhuOHh0RFlS?=
 =?utf-8?B?SFJ4M0toQzNwVDZXeEVNSHZ4QnVodzVaQ0phQVdWV3A0K3g1RnlaelNPUzEz?=
 =?utf-8?B?RnlXVnN0YVFOMFdaQVhMamFzUGs3UEdERHlZLy80emV5NEV2UVpVdmd0UGRt?=
 =?utf-8?B?RXpiQnozUHcvTndFdWdKdmU3a25yam1wWjFHbkNMTG0zeHVlS2Y2RWdXdFRq?=
 =?utf-8?B?ZklxRGNiYjN2K0lzNGtTeGFoc1MyNXBUL1FiTzFKRlZ5NHRLaGNNd212OTJG?=
 =?utf-8?B?T2Njb3Y0VUYwZk1LZHpOTjZBenpHYmsxelJKYzRlWTdleXdlbGZhcG9XVFpR?=
 =?utf-8?B?WXpmY2hQNVRXSWl1ckxSTHlPU3oyaFlOblN0NCt4Rlg1bE16VE13bWN3UzMz?=
 =?utf-8?B?bDcxYy83eFN0YVJNVnRWSHcycThGOVgvMUhvVkZYTE5KWkNPb2hIcmVSdlRp?=
 =?utf-8?Q?Ocza0drOjbwafgXHLVrfWhTpjV8dXBNN?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDhYOXRGZmNIdzY3aDhwallUb0lOMXI2NVB0WUhHLzVrSGVMZ1pBUFRKUnFn?=
 =?utf-8?B?RGV1SGIyOE5ISWtWaEk3RmJXeUV5TVIvMDlHbzJ2TGwyWnhKcHFNWVVjVFFv?=
 =?utf-8?B?aVpSSStHUjZKdEMwUmxlbVlBVExmcnZlYjBQV1lsV2JmVlcrdEVwc2VyZGh6?=
 =?utf-8?B?VmpUTFowK0ZuMzE3Z2REc0Z1d0VvK2JwVkhISS9QTkxkTGxmM3Y1OFBySXNX?=
 =?utf-8?B?elFnQ25LaUJlZzZoVC9EZTlqVWxsckhINFd2ODh6ek5CVGhsOUR5TzZPSnFC?=
 =?utf-8?B?NGhXTUNXTXYvUnFFbWNlZWxQbnI1Tlg1elJzRVJiZWtObzdFd3Jmc1JGQ3NY?=
 =?utf-8?B?dVR1ZVRiUDJNV2JERGxVQU45MHRONFNZdmlHdzA1MCt1bm9CdFVNempwaFF6?=
 =?utf-8?B?WUM2K0lCZVNDR2tRNVpvS3Z0NjNJVlp5Y1FWNm1HOWViU0VxSFVZMzRxYnVm?=
 =?utf-8?B?WEdQOUZieEhOdmhyQWhnSks5YWEyeUNHTis4UWs3ZksybERQNUJzcXVuWTNR?=
 =?utf-8?B?czlMeWJwUVJudXFEMklENkpwbEpLa0FKM3UzNjZOVG1udFFqMDVuWTBVOElC?=
 =?utf-8?B?VzZKUnVyY0ljRFArLzNNTnJNUDZMM0swRFZDbjRPWGR0RU1haEEvV1NXYWM4?=
 =?utf-8?B?T0d0UXhFT3o0dkljaFVxK0poUDU0SjhEQXRZMnlTVWtMdnBGRE9sQlVYMWZl?=
 =?utf-8?B?UkRSNldNZDF0ZGdkTXFtdjBpQzJqQ1hvMmhvQXRtcFFDWHhsZWg5OU1raW81?=
 =?utf-8?B?TUw5WFFObEJIcmE3dTh5K2JlMS9xWENnZWM1ejJnL2tFZ2pLTFVtQVVNQkhq?=
 =?utf-8?B?ekJDa01xQ3VXdm04aTh6SUpnbGpaaWF2K2tDcGs4bkovdk1XdFhTM0VFcVBU?=
 =?utf-8?B?d003UERuUjlQNGFiMWQzMWIxallJMU53RnZPdCtMODd5ek1jazNnUEZmWGV4?=
 =?utf-8?B?UFVZYVBQT25HZE9NcllKYW5OWmdIcmU2L1NENFYvTURURzlBMVpQNFQzNUxY?=
 =?utf-8?B?MUVyVU9PTzJWMytnZUJSaVhJM3p1SUdZeXp5dU5ROVRLUkd3L2ZvSzlGcC9X?=
 =?utf-8?B?aTFiUmhqMG9aUlIyOHpCMktrbStxNnVOZVRwK0RiZTNvWWRHN1ZXK2x3bkZF?=
 =?utf-8?B?Y3FVQVU0QTBHeWx0aEs4a25pRm5uZnpiejhScjJyYnNpSXZOZE1lQmd6emRX?=
 =?utf-8?B?UWVGYlBEY1l6em5aWjI2OGhoeWxMakh4M1VoRTVXcWRQdU9LU0Q4MjFiK2Ix?=
 =?utf-8?B?V0pkZTNqRjdKSTFwMXlydjQ1YWRYTUhocnJWcXNMUjBRQUNBVjUvRTZDcFJK?=
 =?utf-8?B?MFNTbWRnVWt1aVdkdUJQc0w5V0RNWkRBR1J0ZUNmWWxoR1VTS3JWVW85eEhx?=
 =?utf-8?B?ZmZUdiswT2dUcWcxcTZ5cFN6OS9VUHVoTTN3VDJRWGN1VFZXTnFaZGpuUnhH?=
 =?utf-8?B?LzdxS251YWZocTFCcjVTOTRXek0vSktQd3llaUlqcStEb3VSNXZwODZTdStU?=
 =?utf-8?B?M3pONjBBWTZKYUl3QU42ZHNwZ2FJUjJqQzlnL0pxbE1KbERQV1lFNU91eHJE?=
 =?utf-8?B?bmFnVm5OZEZRMjE4Q0w5azBvQlNRVVR2REt5Z2tYN1JQeHhMWm5odWdDR1Va?=
 =?utf-8?B?dnB6bDdqU3NHTENIZ2FPcVBUUjVWdTR3ZSttUGptQ2YyTlYzck1ZZ0VkWlNH?=
 =?utf-8?B?emFxYzR5OS8xUmtONkROQWNrTTlPSWkvSVBUUVpIYXFLV0FncGVWU2o0S2c4?=
 =?utf-8?B?UzFjaHJLWTBTN3F4d3ArQXRqS212cHg2dXU0RktwN3pueWxFaDZscjVDbC9q?=
 =?utf-8?B?Ry9WQ3RjSmU0VFUrTE5OWERSZ0pHejhTdFphd3E2cDRoVGtuRHZYdVFnM2xB?=
 =?utf-8?B?RlVBMUo1UGNkTGJVWmdoaSt1a2RKcW5OY2d4dG11K09CcGpEandwTS9DVHF1?=
 =?utf-8?B?QVZBVFZ2RGMvM3RzaU51M2FJd2Z0VHFrOGFkckJweGdJWmN1T1FEa2l1Rk9o?=
 =?utf-8?B?QVFvVUtpZWtvb1Z2UDZlSkozVnpBajlOWE0zNHRMQWw1Z1d3THAyUnFpUWNQ?=
 =?utf-8?B?YmhndFNvY3Q5emt0V2NGc1JBZWNnL2Y5MjJOU0Z3QWtPM2VXNERBT0kvSmhr?=
 =?utf-8?Q?vJvZ5gVyu/57/kU91Z9khOJ/t?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A808231AA761C64AA1EEA52510B60A22@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c501fc17-725f-4753-9bb8-08dd20983260
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2024 01:47:00.8472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uhW6UcZvGjW6dlJWzUV2ZH6kxRzdEmsGz0WAiKHTzBgaxOqf1JKJSHvtpJ3I6M1aZuwO/RmxL3orHvno/6cF8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1895
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: Nf5pilS9Oinpdk61zOhBWPAhyN_bU8ut
X-Proofpoint-ORIG-GUID: Nf5pilS9Oinpdk61zOhBWPAhyN_bU8ut
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 clxscore=1011 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412200013

DQo+IE9uIERlYyAxMSwgMjAyNCwgYXQgNjoyNuKAr0FNLCBTdGVmYW4gQmVyZ2VyIDxzdGVmYW5i
QGxpbnV4LmlibS5jb20+IHdyb3RlOg0KPiANCj4gVGhlIFRQTTIgQUNQSSBCSU9TIGV2ZW50bG9n
IG9mIGEgcGFydGljdWxhciBtYWNoaW5lIGluZGljYXRlcyB0aGF0IHRoZQ0KPiBsZW5ndGggb2Yg
dGhlIGxvZyBpcyA0TUIsIGV2ZW4gdGhvdWdoIHRoZSBhY3R1YWwgbGVuZ3RoIG9mIGl0cyB1c2Vm
dWwgZGF0YSwNCj4gd2hlbiBkdW1wZWQsIGFyZSBvbmx5IDY5a2IuIFRvIGF2b2lkIGFsbG9jYXRp
bmcgZXhjZXNzaXZlIGFtb3VudHMgb2YgbWVtb3J5DQo+IGZvciB0aGUgZXZlbnQgbG9nLCBsaW1p
dCB0aGUgc2l6ZSBvZiBhbnkgZXZlbnRsb2cgdG8gMTI4a2IuIFRoaXMgc2hvdWxkIGJlDQo+IHN1
ZmZpY2llbnQgbWVtb3J5IGFuZCBhbHNvIG5vdCB1bm5lY2Vzc2FyaWx5IHRydW5jYXRlIGV2ZW50
IGxvZ3Mgb24gYW55DQo+IG90aGVyIG1hY2hpbmUuDQo+IA0KPiBSZXBvcnRlZC1ieTogQW5keSBM
aWFuZyA8YW5keS5saWFuZ0BocGUuY29tPg0KPiBDbG9zZXM6IGh0dHBzOi8vYnVnemlsbGEua2Vy
bmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjE5NDk1DQo+IENjOiBUYWthc2hpIEl3YWkgPHRpd2Fp
QHN1c2UuZGU+DQo+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBCZXJnZXIgPHN0ZWZhbmJAbGludXgu
aWJtLmNvbT4NCj4gLS0tDQo+IGRyaXZlcnMvY2hhci90cG0vZXZlbnRsb2cvYWNwaS5jIHwgOCAr
KysrKysrKw0KPiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9jaGFyL3RwbS9ldmVudGxvZy9hY3BpLmMgYi9kcml2ZXJzL2NoYXIvdHBt
L2V2ZW50bG9nL2FjcGkuYw0KPiBpbmRleCA2OTUzM2QwYmZiNTEuLjcwMWZkN2Q0Y2MyOCAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9jaGFyL3RwbS9ldmVudGxvZy9hY3BpLmMNCj4gKysrIGIvZHJp
dmVycy9jaGFyL3RwbS9ldmVudGxvZy9hY3BpLmMNCj4gQEAgLTI2LDYgKzI2LDggQEANCj4gI2lu
Y2x1ZGUgIi4uL3RwbS5oIg0KPiAjaW5jbHVkZSAiY29tbW9uLmgiDQo+IA0KPiArI2RlZmluZSBN
QVhfVFBNX0xPR19MRU4gKDEyOCAqIDEwMjQpDQo+ICsNCj4gc3RydWN0IGFjcGlfdGNwYSB7DQo+
IHN0cnVjdCBhY3BpX3RhYmxlX2hlYWRlciBoZHI7DQo+IHUxNiBwbGF0Zm9ybV9jbGFzczsNCj4g
QEAgLTEzNSw2ICsxMzcsMTIgQEAgaW50IHRwbV9yZWFkX2xvZ19hY3BpKHN0cnVjdCB0cG1fY2hp
cCAqY2hpcCkNCj4gcmV0dXJuIC1FSU87DQo+IH0NCj4gDQo+ICsgaWYgKGxlbiA+IE1BWF9UUE1f
TE9HX0xFTikgew0KPiArIGRldl93YXJuKCZjaGlwLT5kZXYsICJFeGNlc3NpdmUgVENQQSBsb2cg
bGVuICVsbHUgdHJ1bmNhdGVkIHRvICV1IGJ5dGVzXG4iLA0KPiArIGxlbiwgTUFYX1RQTV9MT0df
TEVOKTsNCj4gKyBsZW4gPSBNQVhfVFBNX0xPR19MRU47DQo+ICsgfQ0KPiArDQo+IC8qIG1hbGxv
YyBFdmVudExvZyBzcGFjZSAqLw0KPiBsb2ctPmJpb3NfZXZlbnRfbG9nID0gZGV2bV9rbWFsbG9j
KCZjaGlwLT5kZXYsIGxlbiwgR0ZQX0tFUk5FTCk7DQo+IGlmICghbG9nLT5iaW9zX2V2ZW50X2xv
ZykNCj4gLS0gDQo+IDIuNDMuMA0KPiANCg0KVGVzdGVkLWJ5OiBBbmR5IExpYW5nIDxhbmR5Lmxp
YW5nQGhwZS5jb20+

