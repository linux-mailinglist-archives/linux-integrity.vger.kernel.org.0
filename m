Return-Path: <linux-integrity+bounces-7552-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0520AC26DE6
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Oct 2025 21:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 699304006E7
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Oct 2025 20:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D27325727;
	Fri, 31 Oct 2025 20:09:37 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021121.outbound.protection.outlook.com [52.101.100.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B40F2F5461;
	Fri, 31 Oct 2025 20:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761941377; cv=fail; b=Ik69nhFagssqLtLhgDZE0SSnOVrDPVdK7XSWdN5d4nYvO2HqMFkfB/keFoRCyWriimFtiU6UVdVaX7+5rfqEM6gueAmld9F2e08eBk8Q7m7bKkEfbLkDTR681/5mc/H+TZnH0fLRZK1X/xCBthFEUQNC6lgqY5RYsM8p6CqWMx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761941377; c=relaxed/simple;
	bh=tX7zjxyUW5VhShKOcC9cOYpb+76MG9sssTjBSP8po+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nohDKFhb8RPtJeaHhbUmi4Cy0NuwD6QHhRu8261so2aEFyxYL8jTnQRkCzOhJQ9zi4vMaM+4QBIgkQEkhhn4STQE0pjPCzT/IvvbDMdhfK8NN+RCO5jqTU8+4a3OwDLUCGM+d9ZuwK+muzjoKiNn6r7RKoG6ewUOuAbT5JD0ruI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LypyTPmVQilgesOmvF1IB1sGEk4rbe2OMY7ulP/4Ok3kAf6AYApNiyom4IUhRBSEWKFeHlH0hqTSR/B/R+rzTsjG6gR0bBRDvy3HTmjNxvnIlx1QO6JpVhcp8h5D/kN7RVjT3s0/V+yZM28cTpXpORq7kPwIrkyEriwQm+7a7XZafAANLOQn2+sVhUqk9snW5cAoykmX7qqFJWa3Ggrvu2/F9mP5H6pB4TntpDq/wz2QpN5BK9U9AQiqtgW8Sm4oxyfaVoFNWHdhHJNkyAy3ofi5j4VYVzkRwAMuxVIBKD1qGKaEvgdADZ/dvQRA+Hxu6Gh6nB4bhEqn8eXIM7pcrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOm017V+OUhyMxEkjpyOS9dHIXHoFreOuT/Y20V0esQ=;
 b=ZzAh9/4/ibWKsg29FvZU5IbJtLcxQ+pFy1AcoeJwdZS4GPihn3pBAZNaoF8xSQzzNiFVwHCqCsRsIy3JB3XDZRA2X9I9w2u6UzQsN1bA6hPsgxhuBEqQzvQD51sizS5Nd+f4yNTn+ERIgD6RJuCRwmiXbLIexyzcw1Gwhn0cthYli5WKonlQ/c+PIT9Am9x9e3XxGuZoJA8Nwf0/IMpuYWeFrc/0pxLHiUqZT89MXnWbUb5cyYEg+IJh78nQJEkFTQEScBqljDWApTdDX8p+UbxlhUjm1rVanvGsyJQCtQ6RYnlmdXyS9jRxkgFhnaBijgK73IIbYrU3xDlKlLmxVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO7P123MB8387.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:44e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 20:09:32 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 20:09:31 +0000
Date: Fri, 31 Oct 2025 16:09:27 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Coiby Xu <coxu@redhat.com>
Cc: linux-modules@vger.kernel.org, linux-integrity@vger.kernel.org, 
	kernel test robot <lkp@intel.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, "open list:MODULE SUPPORT" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] module: Only declare set_module_sig_enforced when
 CONFIG_MODULE_SIG=y
Message-ID: <w4vqvjighjl33a32gvwnu7xlzmp6yztx42gbjixrhic3wt34j6@5flsq5omspn7>
References: <20251031080949.2001716-1-coxu@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251031080949.2001716-1-coxu@redhat.com>
X-ClientProxiedBy: BN9PR03CA0405.namprd03.prod.outlook.com
 (2603:10b6:408:111::20) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO7P123MB8387:EE_
X-MS-Office365-Filtering-Correlation-Id: 91307e33-ff96-4a0f-ee8b-08de18b96722
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2d0Qm82NlF3VnZsTjdUbWpublBoQ2c1N0I3Z3ZYTU9vSVhXTE9JdDBndnE3?=
 =?utf-8?B?V1libW5tTG05bHZLeG5PeWRsREZMUjZpRmdGM3VTNDlDQ1Y3YkhxcDIyN0Np?=
 =?utf-8?B?OUYzNnBGUk5MUTM1Z1ZRSWRVd09WQVNPSFZXQlFSV1VkaWZDaysvdmRqUmNn?=
 =?utf-8?B?NENLYWNVcjQwU1RqY2FoS21YTkxpU1FrT2NiZHYxUi8wVnRMWmQ5eEZmc2pr?=
 =?utf-8?B?QVg5QTh2TTMwWWx4ZXhwRGJvR05LUkc0VWprT2hPV2Z4ZExEZGdzcHFBNmpP?=
 =?utf-8?B?eTVhWklBZ2RRNm80ZXNNZFlLdTJEdEo3bG1CWmNxbWoycmJmVEhMdjFoMnpx?=
 =?utf-8?B?YUw4NGdqZGMvc2FieVRHRVJRUUNwYk95YmVqcEZZdy9nb1krSER2UlJualh1?=
 =?utf-8?B?Si84MTN2NDM3alUvS1hUWCtUd2lxcmdvRlFLQnhqSVNSNnVBcjRmNE1TRTBO?=
 =?utf-8?B?Q1pza1NkRmFnN2dpOVJDck1wNWdYVjZvV0RPOEl5N21BQjFtOUFhWnhmSE1Q?=
 =?utf-8?B?L05qalZDem81ZmJLeHlYRU9KL0owcXBBbFJwdHROc2QzeG1xYWhjNU1YblYy?=
 =?utf-8?B?QzhLdDhkcjYvMG9EVlBpSmF1ZFZxcVBRWTN0eDFENzcvZzNNSGZMcmgxZEVk?=
 =?utf-8?B?bDN6djdxN1FjYW9zZ3EzeVZMMXdNK3pnUkJZdVYxLzhWV3dXVzdMaW9YSUk1?=
 =?utf-8?B?djNUSFh4RHVCSVlUWng3U2kzeGRlR0JlVG55VDNUT29rcUZzbSs0L1M5Wnoz?=
 =?utf-8?B?WnJONHBqTk90bTdrbTA4YkNWa2gwZG5Ec21EWityalJmZGc3M3FqejdaSVpN?=
 =?utf-8?B?M2U4WXNQeG13bWsxQ29VTXZLRkFtVWJ1b3RPWGZ4QUl6OGZCcWsyV09oSEZQ?=
 =?utf-8?B?NVEyYmhPMGhwU1pwaDFCRFMrTGg4anZmazdGd3RETDR1cSsySjYyQWs2eWp3?=
 =?utf-8?B?UlVWN0gvV1JhY2FVcW84ZC9qS2J6eWJ0U2RPaHdMTkFGZzNCZHIzU0hKYkVx?=
 =?utf-8?B?ZW1JWmNyQWlsUnN3WGJVdDNxaFI4KzdNVUVjb2dVaXFrakttbEN1TDNVbU53?=
 =?utf-8?B?RWx2NkFHZXRnMmkvK0ZXUkVPamlKN3ZZd29zTjgyTW5iWkFxSmhUczhLY0Ft?=
 =?utf-8?B?Sm81VnpEYjZWUmZnVVlBRVNiWWpPN0F3Wng3eVQ4Zzd2bnBKOURDWUlGMkFw?=
 =?utf-8?B?YXZKNzlhWU9YK001NUNIRUU0ZzYxbWNMckpzaDd1TUg0QnZhdGN2R1BaUEh4?=
 =?utf-8?B?dWxMa3FTbEtTQ2lRdDRpSUdRN0gyTGg4OWc0VnAwdWllbGNGWmZjS3pQOEhJ?=
 =?utf-8?B?R3lyWEdLQTN1L1Y2aWd6TmNvOTkydWxFQXhpYW4vNVRhRkl0MkQ3TDRYSHY4?=
 =?utf-8?B?MkxPdGZ6T3RUeURDU3RxOXRLcUVCejNHMjhnMlFDL2NjOWQrajRBWGV1NmU1?=
 =?utf-8?B?NlBESXhhcUJVMStaUFBTUnFzOVY5TmlwRSthK3hRZjk4N2loY2NKQmxtcHZ1?=
 =?utf-8?B?akQ2OVVWd1FIMkh1MmFPazR0K3ZHNVNNRkRTUkFwLy83dlkrQmlGcmNxTWRU?=
 =?utf-8?B?N1JzR3BSSTAzSGEwS002b3p3ZXBvSFJGVFlpQmlmNk02TEp5djRQb2VYcWJV?=
 =?utf-8?B?ck1zSW9lRVM1dnlibXNrUllZVkt4S2hLZU0rN3BPdjhqTmErOUlnUjU0ME1E?=
 =?utf-8?B?eFNOMFphM2RaZndJMlpzTFdvM3JRSXRxUExxZ1c4b2dxS2RpbTZHTGs4VGdL?=
 =?utf-8?B?bWcrTXoraHRMZVQzREVaWXF6SXRyblZwWFI1UDJPazlPa1RJVGVHZkhuQWFF?=
 =?utf-8?B?NjYvcUM2QVVaKzBXUkVMSlh0dEEwQVJiWm4xOThiR1kxeThpclgrNlpQaDdS?=
 =?utf-8?B?aVFJalZuRTFvdEQ1MGltdFlVN1A5M2dlVkFReFY3dHR6SHoyODh5UHg3Uklu?=
 =?utf-8?B?NVhJWHVFWS95U290R2JUcEFGQW5NOThQeVZLWW9rMHJGemthelA5bndhNGFH?=
 =?utf-8?B?MUNwdnZMNWRnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWJmZGJ4Y1RaWkZ2bW9hdTlsVzdEcEJyTmU2RlZKSFZ3dm5PdVl0ZVI1M29l?=
 =?utf-8?B?UjZEM3U0SjBzYVp0L3Q3WWpNMCtnZk00Z3NNeWlleDdwNmhneXpGaGhLK0RD?=
 =?utf-8?B?bXFpVGdpR3YxVU81bERUZGh2SVV0MndMVU5MU3ZMUTlTYWFWbU9RSHBMVWVQ?=
 =?utf-8?B?ZWErTlBEcjh5aTIxWUlZcHByeU9sRW5CMXRsaVZ1c3BZd2hnZXNZR0lHc08y?=
 =?utf-8?B?TjRwQ3l6S2w4U05nQVZCSGNXYzNoVGJwYjRBSHZXYjFCUXpqajBmOXVmZWRa?=
 =?utf-8?B?b2loRWpIUnhSdEVhQ1BRUVJDMVhHUXloaXZBdGNmOHRoRmdJVHdxejdVL1dQ?=
 =?utf-8?B?WVloZlFsL0FTd05XR1oxWG5qVGhEMzYxZU8yZVFvcUVLT1U3eVQ1SjgrcVlr?=
 =?utf-8?B?aDJ2MzEyRXo1eEMvazNmb0o4a2IrL3RaRXE3Mml0QWVGRmFrOEhCUDRrNzZr?=
 =?utf-8?B?cWg3dGFDOFZRWS8vY1d3ejZZU1VHRmlaYUdUK0J4OGlXWkVIKzhIV2VhemU1?=
 =?utf-8?B?QThSRTFjZjlqYmpSUEovU1BucDVXSnBNWWU2dURES0crd2tJc3VhaEMvdS9X?=
 =?utf-8?B?VGliY2E2OGxqNXVkVmJWWS94V0Vyd3EyOEt6eHF6bSthdVpjSndDdWNMNGlJ?=
 =?utf-8?B?UDVydFlUR1MxZEhxeGpHWWY3RGpxTHV4YUN4V0xvWGFDdnViVi8yVGRBQWlQ?=
 =?utf-8?B?Z05INzg1c1dGdjUwMEVwNVdteDlDMGVoTzlXMFUvSHREUlpDVjBGek4rUFEr?=
 =?utf-8?B?MjVkQ1N2ZlA5dkFtL1czanB2K3FpaGdYRzY4VEFuMnh2QkM3aXJ5VjNQTjJ1?=
 =?utf-8?B?M0tVM01zZGVraGxvU1kra3NKK084bGh5Y2JES09HdkszaDk5cHU3RUlMbldM?=
 =?utf-8?B?ZCt3TkZ0czlNMzVPSEF1SFNzSFNOMHBUR2ZZUlQxU0x5blZtSWJVcUZqWUpO?=
 =?utf-8?B?UW5mcHJ4cmV0L2NWTmFhSDdzNFVqMWRWTlFDVXhrQTJYbTJtR3IrNWFKQlN4?=
 =?utf-8?B?M2x1SmJzUHRXS2xkL3JheXE5aE1laCtrMGV3KzV6dlk2ZTZHazdwT29ZN2x2?=
 =?utf-8?B?QmdkYkx5UXgrbHlSZzRtQnRpbEV1dkZjSE5IRTIzcHMwZ3lRRGRHcUs2Y29J?=
 =?utf-8?B?ckhaS25KVmN2L3Q1Q3U5MGhydEpzNVFuQkhmM215UTgyUzdPT2RXNmJmSlU0?=
 =?utf-8?B?Tkc0NG04bWxrNDk1NVg0eDlkMHBQL290MlR5M21pQlN4Y2k3TXZpd3AzM2ZD?=
 =?utf-8?B?MStab04vRSs0Rk5YTlFuS1l0VHBranVoVDJVVExIWkxsNU00dFVzSEVBSmI2?=
 =?utf-8?B?S1BKdGxyaFAxY3FmT2JXdk5wVmh5dVg2aWRBL3lwQXJnbE9uTzl5N2tFTUMz?=
 =?utf-8?B?c1QvRVBXdDJoK1RLWEJERytDTjB5RUdieERxZlpzWUxjcWVDZW9MaDJRaU4z?=
 =?utf-8?B?ZnYvQkZKSkhReWN5R0cyNXdWQUxpNnFvY0lYNWZ1bWQ0cDhid0hYY0MybVcw?=
 =?utf-8?B?MnBGcHg0Um5WaVRwYndKNi9LUFl0MjhxMitZaVFmR1ZGcFc0blRKTVFTZll5?=
 =?utf-8?B?OXpSWmMvQVdOOUUyNGNOZWNObjRmUHVBUXd6U2VLUWNxa2k2bDcxaTc3YzBG?=
 =?utf-8?B?SkU4MXloOEtmS2x1eHFiSktWSGdub21GMm1HSitGVGx6a0JpNGg2ZnZ2WDAv?=
 =?utf-8?B?ckN6ZnpSNjIzcnBTdzVTSEE4cEt1dis0cCtjY1NvaTFlNzBXTG4zNTU1NDJZ?=
 =?utf-8?B?TUJCcElnL3VTWkpWU0tzcXowL2tpMGpsd2o1bUUxcFdlM2RRQTBIaVZ1MlJy?=
 =?utf-8?B?NE5nTDdNYW5CMG9KVkFML3hCQU5Ua0RrY2J0MUNuWnBpY0JlRVFCRjBOaW83?=
 =?utf-8?B?WlIvWUtUd2draFJGK1Z5aU1jZGdpZWt2NDdYa0NsRlErZlM3dk5SUmxiMHUr?=
 =?utf-8?B?aHNzZGxqb2RiWnR2alZmMEQxR0w0ZlI2WE1nUEtHRGszcXc0RDU2dzFuakpy?=
 =?utf-8?B?T2JTOEZOMDRsOW9oWVRxM3kyQXMvdHQzOU5kQW5PVnVuTTFQc0F1Y2YvVGM0?=
 =?utf-8?B?azZoUnJzWTNVRkcrcnRPOWQzcEdvdXpTWDJLZk5UWVd5Z0VKdDd5MjFPamx0?=
 =?utf-8?Q?FkpP3gLYPq1/uvZqpho3UUhvk?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91307e33-ff96-4a0f-ee8b-08de18b96722
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 20:09:31.5225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hfJMo74rm5AxHuF8E6xuqDf9kQHdNVfaOIDuUQ+pM7QATtppgXQlDYaKKjVgbkDiMruRjJtpsxVO5HCMjj9Bng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P123MB8387

On Fri, Oct 31, 2025 at 04:09:48PM +0800, Coiby Xu wrote:
> Currently, set_module_sig_enforced is declared as long as CONFIG_MODULES
> is enabled. This can lead to a linking error if
> set_module_sig_enforced is called with CONFIG_MODULE_SIG=n,
> 
>     ld: security/integrity/ima/ima_appraise.o: in function `ima_appraise_measurement':
>     security/integrity/ima/ima_appraise.c:587:(.text+0xbbb): undefined reference to `set_module_sig_enforced'
> 
> So only declare set_module_sig_enforced when CONFIG_MODULE_SIG is
> enabled.
> 
> Note this issue hasn't caused a real problem because all current callers
> of set_module_sig_enforced e.g. security/integrity/ima/ima_efi.c
> depend on CONFIG_MODULE_SIG=y.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202510030029.VRKgik99-lkp@intel.com/
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  include/linux/module.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index e135cc79acee..fa251958b138 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -769,8 +769,6 @@ static inline bool is_livepatch_module(struct module *mod)
>  #endif
>  }
>  
> -void set_module_sig_enforced(void);
> -
>  void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data);
>  
>  #else /* !CONFIG_MODULES... */
> @@ -865,10 +863,6 @@ static inline bool module_requested_async_probing(struct module *module)
>  }
>  
>  
> -static inline void set_module_sig_enforced(void)
> -{
> -}
> -
>  /* Dereference module function descriptor */
>  static inline
>  void *dereference_module_function_descriptor(struct module *mod, void *ptr)
> @@ -924,6 +918,8 @@ static inline bool retpoline_module_ok(bool has_retpoline)
>  #ifdef CONFIG_MODULE_SIG
>  bool is_module_sig_enforced(void);
>  
> +void set_module_sig_enforced(void);
> +
>  static inline bool module_sig_ok(struct module *module)
>  {
>  	return module->sig_ok;
> @@ -934,6 +930,10 @@ static inline bool is_module_sig_enforced(void)
>  	return false;
>  }
>  
> +static inline void set_module_sig_enforced(void)
> +{
> +}
> +
>  static inline bool module_sig_ok(struct module *module)
>  {
>  	return true;
> 
> base-commit: e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6
> -- 
> 2.51.0
> 
> 

Looks good to me.

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

-- 
Aaron Tomlin

