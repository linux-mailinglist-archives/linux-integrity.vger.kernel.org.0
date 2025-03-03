Return-Path: <linux-integrity+bounces-5041-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC45A4C2D7
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Mar 2025 15:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2687171246
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Mar 2025 14:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC879212FAD;
	Mon,  3 Mar 2025 14:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wl6iXmqA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CB6212D68;
	Mon,  3 Mar 2025 14:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741010811; cv=fail; b=ongYBEuAfLwuscigwrYknfpCJsoHhjbfR8jS1u8ZKgWmPF9hAAhNYVenA+l9+h8LBT7reIo+Rbez6vInMTQWYbnpQy7+rIfB5JRDHpw/qZiBIRkDgk1/YL/jW0SkItm+YlMFbw2sJSufAFU9VDQzOFSGlCiCZADaHBcfjAg51l4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741010811; c=relaxed/simple;
	bh=0Uv1yhHk3002hAluQFciow4dAq8FF8lLMqLialcd8u0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tyuO2/MAo1e6NIUuOaqjYkVQkFAB+1IL6ZlbbaGowB5M/JWw9e3HBES1u8o9VS/3N9lAnP9XB4kkGGRly7eyyS0XBcDMPr/cAJqbxBQuaE+B/qGaw/JMjLq4qNHQTtkCECdmi09y890JcoHJbKwV083VoHZWvnd5cI6xxDUZJTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wl6iXmqA; arc=fail smtp.client-ip=40.107.92.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=An+X5qG8xpkeiNUxKFwjh+X0q1NlrjAAFiUsMvLJbOMJwPS5awj5RdIAUibygL9zfrCNFn4Y1Co7Z24R2l9deWY/fFWUAu/uRXRd2yVYV3uwzgxmIgWnpEHtp9j9UdkiQqrr9aec9YkQPV9tXHyooeF5YBgPoC0BDE2QnYrKICtsTOmrQ0E86hUwO1ROPB3F15G43grMsrdQS8ef88GK3c1O843t6LusGwVv9oLJ9EFOdWXbdqlWnAxEE1K9Q8+JDoew3DBrCoS0WUngcKJ1k2NTZxofPpV7hzCVdwC2yOllONPdivULOY0w9tMaS1Bi4k3QgwwaSSkqjPukvx78Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VI0pk/D4wK+j3TjNK3QsSu57F9eGHHcRF4cNghH0MWo=;
 b=mo9XYnS27Zyhl3q4nWBTBTBf2XYzTDysojxi0w44By3PpAsPh+BeMFOe7W01uQVCYUHigQ1bSXYSkjpcROY2ZD8DSoes6msSMmIgjFua9Olzimn+TSOrBHE0MYZvJA/Tf0jzZViVax+n4lor3omFZnt3MfIjTKoFvF+D3jvvtlXwIogP/Z9U+nLkRabLA0oSwlmouH5VCiBO84L1j310LISeEmVeHR5DmtcbV+/14bsyb7+IlCuJONK2wif4LlamTDzi0eLzzieVGMKTJ1lWRIGYnJfAAeTgWcBfdTBq0bLBQxSnYBihjkERU4ojbvPPtBP96qGXO/Sbs4/pLaNePw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VI0pk/D4wK+j3TjNK3QsSu57F9eGHHcRF4cNghH0MWo=;
 b=wl6iXmqAJlnZi8ml1ftCRxl9wCHOx93BUWbiGGxRcRWVESLidmKY7XGHO6va1HT/2STQuja1VKLZbZUWJ2Bj6ufvbnrtz0RcVwTri686TBxV29+hKQg459UTNAD0FeQnKICNW6sIiTlUYg42YuukOISnNIDpo8ov1NHopC1xG0o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by PH7PR12MB5807.namprd12.prod.outlook.com (2603:10b6:510:1d3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Mon, 3 Mar
 2025 14:06:46 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%7]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 14:06:45 +0000
Message-ID: <c8e067f3-117a-7737-64ea-ac016b697d0e@amd.com>
Date: Mon, 3 Mar 2025 08:06:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2 3/6] tpm: add send_recv() ops in tpm_class_ops
To: Stefano Garzarella <sgarzare@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Claudio Carvalho <cclaudio@linux.ibm.com>, Peter Huewe <peterhuewe@gmx.de>,
 x86@kernel.org, Dov Murik <dovmurik@linux.ibm.com>,
 linux-coco@lists.linux.dev, Dionna Glaze <dionnaglaze@google.com>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
 Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250228170720.144739-4-sgarzare@redhat.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20250228170720.144739-4-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::20) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|PH7PR12MB5807:EE_
X-MS-Office365-Filtering-Correlation-Id: a67c407c-d6a0-4e78-8c22-08dd5a5ca1d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUV5UmRRMzc2SExQNDRnMGFZUlhvTWFHcFFrdzk4elNaa29OS3J6QW5ta29J?=
 =?utf-8?B?anJwb2s4c1RMQmV3OVdvbVpHUGFaUmJLWVpVVy83eWR5Ym5VWEQ0MzFOVUlW?=
 =?utf-8?B?Z3ZTZnBmSkRMR29kUnFkWUpEOHc2SWcvcGRnL3RuTldTV0dQT04zTGwrV0JZ?=
 =?utf-8?B?QXMrc2pOa0xtem4wUk9WcXJMVm9vMjhESGRUUnQ1UmRaZGpRZ0E5TVVkUEFp?=
 =?utf-8?B?Z0lMSjk4NGtVQTRiY3pnS1MrTUIwbmVGVVpvMU44RXluTWJ6YXFYYitFN3dH?=
 =?utf-8?B?ZzFjTHJaZmRDZzZFaWdsVEJqdFhNQ0locE4rZnZyQmhvVnQ2RVpRQmtPMmFC?=
 =?utf-8?B?eWhiY0xmdEJGT1laYU5XWVJXZE84VlJQWWJwZnh1UWVKUHV6dVBLeTRucXFK?=
 =?utf-8?B?WVFtaU9LbVJjY0FNMEFWKzlMY0MrVFI3b3pneG1qaVBNUGhIVEJkdHNaREFU?=
 =?utf-8?B?bTM3Y28zRlhXbVVIdWhHSHM4ZFY0TlhlMjZvcGZpemlmWGU3a1FZV0lQLzVT?=
 =?utf-8?B?ZXVqb3Y4eFVCazhQM29sWUE5STBtYmRISHh5ZVYzV2pDV0tFeGN3dWM5aGdB?=
 =?utf-8?B?SFVjVlNiTFd3NFlyVlpnUFpoUGNqTTEwbkRHZjE2NkRYblBXdElkNVdYSWwz?=
 =?utf-8?B?NzZyQktWcWJleWEzKy9WVElRcVYzM0xBSlJGR2RFcWhVamhSSWNtaWY1aWNF?=
 =?utf-8?B?aURFT2xDYWF6M1VoZlcwNE4wZE9SUjJUbFRKbm41aXU2akgxcElqYnlWelhY?=
 =?utf-8?B?d3J5NmR4VmVwYVFaNDlsUTRYU0s4T3Y4WGYrSUE3dzJZbnpDWW9SV2Y4Z2lJ?=
 =?utf-8?B?bFUveFJON2FlUU83QzNXLzRhYm5tbXBrVXlXaTVWZ3dwRXNuVm5PVjJISXVl?=
 =?utf-8?B?ZHRSUndycWZDZDlFVnVOQU8wR3VhenZXdXRxc1hiZ2ZkT3dHUmxlRGlVajVh?=
 =?utf-8?B?bzVyMi9lMFh5MmN4M0Ryd1dkbllKNlpUcnJpVGFPM0hzS1lGZ2JhYlBPUjdm?=
 =?utf-8?B?SVpvdEdIaVJYbVpXSExCQUF2RkZwYVdnUTh2VTNoTng3RlY3RXhNaUlsc1Jj?=
 =?utf-8?B?cVd1SENVZWhmZnI0bGROeTdVWGVjSjliU1p2bzlBdHZkVTV4S0hJSU03cVZW?=
 =?utf-8?B?UGVyajFzZGswQ0NyVkZTaTB3eW96cW55a0IveExvZGhrbTZiU1NuMlVTb0dG?=
 =?utf-8?B?NUV6Z1hpQTZjWW1yeUJxajlGaEQ2MkRDMGdWY1JISDUzSE1GVHIra3Vxc0dJ?=
 =?utf-8?B?UGMveG5STGZWWHE0Qi9QbFJBd3JtY09UbStNUGtYL2NDRG1QTm0xSmdGSlYz?=
 =?utf-8?B?TWFncCtWS001QTA0bEtzS2dESnNoOWd4a1cySi9oOU4reHJMTFhWZE1lRWZP?=
 =?utf-8?B?UXNibk81b0NQOFJIRkZHWFRQMzIzQnI2Ri9OQk9ZdGdFRHV3UVdlci8wMFZ2?=
 =?utf-8?B?U05NTlZxcXpIQzlrd0tOci9KeHU5TzdSSTNWNnFPMVZrVzIzSHpYeUZQTVda?=
 =?utf-8?B?Wk52NjBkWGQ3clNNSGxkeXc1Tk9vaEVrdkp2UnoyM1B5ZWhSUW9iL0FOZFdp?=
 =?utf-8?B?RGx5a2QyWW9JTUhuQ3VZU250WTNpTXhmQ0E4d3VFc3p1NktjdUE4VElNRjBQ?=
 =?utf-8?B?UjdUTGwxR3lPcm5YOExBS1F0ckVLQmo5YXVYbExpV3VtZXA0UlZPbjFQV0o4?=
 =?utf-8?B?L0RKM1Z5dGN4TDg3bFM3T2FmekRKTVBaM1lQOUNhUUN3b0ltK1p5M1FBTkFC?=
 =?utf-8?B?VHpobE9sbmVvTHZEYVU3ZkhacStvV2FOU24rUWpjd2JpWEZibjNRQkZCUHhV?=
 =?utf-8?B?NTAzSVgya1Z4UjRmN2xFc2tINlZsbFhvcWhwREhaKzA4UVpqWmlhYzM5OHY2?=
 =?utf-8?Q?hJW0ZQjoeL228?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjFKOW5GMVJrK2VkSjdFb0c4YWFLN2dIOVFpdEVhMGRuWHVVN05nUnl1d3hF?=
 =?utf-8?B?Q1RBamRmeEt2WW50SW9OTDJGci9IRm5nQlUzU0g1ei9zSDIvbDlwK256UW5T?=
 =?utf-8?B?eDFJL2l6eU5JcHNMS29adjhOYzFKSlRrek9tVTdQUUFFQjJCOFdGZTBNUnNr?=
 =?utf-8?B?YUtpL3MzYUloRDBhUnduZ0FzdStmMzF3Mzd6ZUVYaHQ1MjFkRXNJRXpjaDg0?=
 =?utf-8?B?S3VqeW5SRGdRZjBUUDNRRUw1aUhYOTdRSW1MaU9SemdJVzNTYXo1cnFrVy83?=
 =?utf-8?B?MSt3eU5SVmJKYWdCcjRkY0pta2xrckVVWlpBQzhnaWJ1cDdwTGhvbjNWY2xm?=
 =?utf-8?B?UFY5RXpTanpBMmQyaisrTHcwOHFxSmlIa01qRHBOMDRCTndVRWlKNW1scTJM?=
 =?utf-8?B?UFQwOVByTHlnZzU4eHhleU1sZ0tFZHN5K0xZMUJZQ1pSRDZiV0ZueGhFclpz?=
 =?utf-8?B?S2xNSlk2azBzZUdQOGxSVFRZNmlOdzBEc0IrMEx2MlR2akxKWFJnYzV5R3h0?=
 =?utf-8?B?NDFZQWROUm1URGY1dnNXc0lacmJTNUJOc3ZPbjJOaURSeXZ6MnhhemxvMGNm?=
 =?utf-8?B?Zm1nNVZCamo0OUxJUXNQMkI3emVVcnRiTjVvb2VpMytaR21sWEVyUzhPbEE2?=
 =?utf-8?B?V2k1c3N6MEp2SElBK1JkWFdiTjhWeFQ4VytpU05lZE9YWEpiNFFWVjByK0Jq?=
 =?utf-8?B?U1pGRDN0M1ErdVJwZ2xCS2laMFIwdDFvd2hTVTJjakdmeW5pUmRYV3pZRS9y?=
 =?utf-8?B?ZERHcmswVktLNlJCMjZZdy9HMm5TVzlFVTNyVC9qZEdDTkYzdUVwem41Qko5?=
 =?utf-8?B?OE9aL3ZlZWZvaUQ1U290bjNpbDY4YnlkZHAxMC9BSXU1RFlpYkt3VWgxbjRF?=
 =?utf-8?B?R0dZeGlpTmFTeHV0c3ZKZHorcVV3TE5McEhnTFE4RkhTd2hpTlI3RXhoOWYz?=
 =?utf-8?B?cXFXeHFXYjZZcHJSWTQ1L3dkb2oyakpWWEJGNEFmOWl5cklsaGE2RXV0bE1C?=
 =?utf-8?B?VU8ycU02VlFPWHQ5VkhhQ0FaTndPdTYrNDd0U3ZPSlR6M1A0SmpwWWxUTU8v?=
 =?utf-8?B?OHc1SXRSdDRDY1lmRmJkWWZ4bGQydGVVVy8vMktKeStSeW1RQWpQcyt3WVJn?=
 =?utf-8?B?bVl2ZkV2bm1ndmdkc2I3UXhGczJLSDJVZ2YwRkQvbjlSTUM3d3B4czhBR0hU?=
 =?utf-8?B?SjMxZkt0bzVCcENwaWtFaDdVM0lTdkpORVBtaUE1dzIxcWkwQXpqVXljUS8w?=
 =?utf-8?B?QWFaV2phbUdpaG5XL0QyWW1UWXhka0xFV1pRQ3lNQXg1OXhMdkRuTEdsT2RI?=
 =?utf-8?B?WU01dGhWMGQ3T3dUVytWa0lGNnVETmVzNTI0YUwvdGkzempXNFk5K240WHFE?=
 =?utf-8?B?RUZ0dXdoRjBoNysyU1hZS0JTc2VBSS9CZkpRSExveVZIZ3RyaEk4eDVoU0FI?=
 =?utf-8?B?R0U1M1Axb1hvVTk1bWRGUDR5QTZZR05mbUI3c0Vaa0FqNjBMbC9YWktZSWRZ?=
 =?utf-8?B?d05qT3B1TjhMUFZpYWxERU5vbHc4dVpLOTNqZldlcEUxQi9VVnhiTGhKVUI5?=
 =?utf-8?B?U2tXMXhqcEtSRGpiYUFZbjEyNnFaNU42QmM4THBVMk9QWDdheFhsaHZsSWtZ?=
 =?utf-8?B?dUIvUTdHdWVHajRwQXRKaURwZ1lMMExBbTNzSTVZR1JseTJSM1d3K3FPdjNR?=
 =?utf-8?B?VkhtWXV2UnNhczdRVVY0TWlmY2VYYzM1YnpuSVBFZTJPZnMwRkpnV1RqVnVv?=
 =?utf-8?B?TDdPTEZWWFpnWXZ1ZW9FZTVxWSsyV0pMVVRFd2xiVzdTcEZ3NDRZQURxMXJk?=
 =?utf-8?B?bUpMVUlHbkNSRDBsZmxCYkxhRGVNUkNnVE1mMEJZT0FaNFAyVHpsYnNyclZF?=
 =?utf-8?B?dGoxUENHa05CVWNpOGdyN2N5WkdIRlBJSjdpN3NBUEliaVZ2QzdRK0dXK21X?=
 =?utf-8?B?VXlEakJDVTlBeHJqRVNpejAwTk8zdGdJYlB6THhqSzcxRTVPd3d4M28zUk5t?=
 =?utf-8?B?UmdyQlcwdmpQdkVmcVRQR1FlaWxsaEE0eEtFOThpVU1rQzBNTGYyYUZGMEVs?=
 =?utf-8?B?dTZrSE96d1k3K3BCakVJRW9yc0hCOGdrZzRhaGo3cE5Bd2V4aVpSN0FpbHlQ?=
 =?utf-8?Q?fGELJ9g8AsHDuIGB+kPgNY/z3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a67c407c-d6a0-4e78-8c22-08dd5a5ca1d9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 14:06:45.6939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mgj190qHEFrDQEItYJ9IVjcvqHyoHowAfE2PxrNdX6EnizfUI2hI/HhRjJDeBWjbR290LI3ay8fVS3LqeJdHhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5807

On 2/28/25 11:07, Stefano Garzarella wrote:
> Some devices do not support interrupts and provide a single operation
> to send the command and receive the response on the same buffer.
> 
> To support this scenario, a driver could set TPM_CHIP_FLAG_IRQ in the
> chip's flags to get recv() to be called immediately after send() in
> tpm_try_transmit().
> 
> Instead of abusing TPM_CHIP_FLAG_IRQ, introduce a new callback
> send_recv(). If that callback is defined, it is called in
> tpm_try_transmit() to send the command and receive the response on
> the same buffer in a single call.
> 
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  include/linux/tpm.h              | 2 ++
>  drivers/char/tpm/tpm-interface.c | 8 +++++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 20a40ade8030..2ede8e0592d3 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -88,6 +88,8 @@ struct tpm_class_ops {
>  	bool (*req_canceled)(struct tpm_chip *chip, u8 status);
>  	int (*recv) (struct tpm_chip *chip, u8 *buf, size_t len);
>  	int (*send) (struct tpm_chip *chip, u8 *buf, size_t len);
> +	int (*send_recv)(struct tpm_chip *chip, u8 *buf, size_t buf_len,
> +			 size_t to_send);
>  	void (*cancel) (struct tpm_chip *chip);
>  	u8 (*status) (struct tpm_chip *chip);
>  	void (*update_timeouts)(struct tpm_chip *chip,
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index b1daa0d7b341..4f92b0477696 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -82,6 +82,9 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
>  		return -E2BIG;
>  	}
>  
> +	if (chip->ops->send_recv)
> +		goto out_recv;

It might look a bit cleaner if you issue the send_recv() call here and
then jump to a new label after the recv() call just before 'len' is checked.

Thanks,
Tom

> +
>  	rc = chip->ops->send(chip, buf, count);
>  	if (rc < 0) {
>  		if (rc != -EPIPE)
> @@ -123,7 +126,10 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
>  	return -ETIME;
>  
>  out_recv:
> -	len = chip->ops->recv(chip, buf, bufsiz);
> +	if (chip->ops->send_recv)
> +		len = chip->ops->send_recv(chip, buf, bufsiz, count);
> +	else
> +		len = chip->ops->recv(chip, buf, bufsiz);
>  	if (len < 0) {
>  		rc = len;
>  		dev_err(&chip->dev, "tpm_transmit: tpm_recv: error %d\n", rc);

