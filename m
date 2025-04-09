Return-Path: <linux-integrity+bounces-5691-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F64A82BFE
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 18:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92B591888AB9
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 16:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEC81D5173;
	Wed,  9 Apr 2025 16:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x1LMv1/b"
X-Original-To: linux-integrity@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2083.outbound.protection.outlook.com [40.107.96.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686D117A319;
	Wed,  9 Apr 2025 16:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744214879; cv=fail; b=JJeDyC2n/0rV9kjizNmbkuoIED0vpeZpnkJcDu/vzH3Q4t/b/ANSznKJhBCPNYc8lG7M5kWrPNccKHYKiGMQtwGk7FK9ZgUMR7Cvx9JRIcxfER3u04qW7tJ+mfZvBjaNceKYpzC+Po2YghPMI2eNCKz4ZLZs0vmtaxZY7EnNHAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744214879; c=relaxed/simple;
	bh=YaROIC+jxgTEaf0zlIIkX4yEhwmlhca4EVSE+d4eTws=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZQXLx5dFzEZafZ5haA0X4RaSOn0j7ugF7ii0z+oSYa403/WM3TIhxI3weJ4S/tzPnq74MnD/B4EF1dwMjMAdzkmzGgUBxVEGQDG3avp4nWJy23vEdbXRjdFhovnJ8idAAPCFqrkgnoQvpccZx9BZ+ur9E89Ao54nk3yhmgEjWKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x1LMv1/b; arc=fail smtp.client-ip=40.107.96.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6ozzq+V4CaL1c70BCNX8OVPGWXHLhdfiD4i+ujrt/2Mbm/+FTkULdW2dS+BuXZL9cOl68rWIo9b0oeAGUUt5BEwsT0DHcOboTYlRlJMHia+MPYHilmZ8VpwXtrCiVDYcZcMtmMwaWG37EvcTYFtiaK89njNRnzRboWODu5qxfGbaQO2G6THcEmUn7EcbtXg2O+JmLVZ9b3Pd4IGk4rxnnmP5MIozLvkhu3Siu/geWmyu9QUmJgjW+PDuewxjdamh2zYjK8SuXBv7zzw/wnB44kcgFXiiZvNuENYlu+sKvCjroxj4zeRGQT9Y9elZBCO9lpDc7YLiqUK3a9uW2QeNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmfP52NbqTAYqJgijfY8BaJSM5aS4uPSrqUP54d4LPY=;
 b=mFdYcFfF80ZXxuj5P7T97FfKIYkC3GDtFA/N9jqg5ZwoKMiPaB2YfZn52/1I/1WmtyNVLY0RFojlK13c3GfbMGkryJnPKSIgy0UPgO3cwN/kEcT4MKilJgwrlLVhB7SqlhAafiuPCz2EALZkzCQ53YyWE851OMwF22bjkYbN7HaqW4AigWRQYLc/z+wEPt5X2xb/9KPvasbj3A+YBaKsd7S4RLmqI4NQZV9BdSQJEo/8lMISTnucNKoQ1SrMlN0wNZBz76QM5KXEepB93Opm0yVJ9W6Cv1HWW2HTVwEVHxgfUv6xaeNBXP1odR7oA2ECOGIlmB5RKtAVTkHjqZAO2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmfP52NbqTAYqJgijfY8BaJSM5aS4uPSrqUP54d4LPY=;
 b=x1LMv1/b3PsHEf8QpplJ62inbHmRFDjKLO+yFDIq8qt9WOAQkPdEpVQmxaUzpEOUFmCKRbzOw0K3muPJ+nZ9Wq5oWJXZcG3Jegahxv0nBmhdGtJ9VYaIoDFa1h1khfVredmkoCSNT19mA3htx01D8iZ366co2Rt3ROEBXXtF4Fs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Wed, 9 Apr
 2025 16:07:54 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8632.017; Wed, 9 Apr 2025
 16:07:54 +0000
Message-ID: <6e5bf479-ee95-a996-5845-1f76730e2488@amd.com>
Date: Wed, 9 Apr 2025 11:07:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 4/4] x86/sev: register tpm-svsm platform device
To: Borislav Petkov <bp@alien8.de>, Stefano Garzarella <sgarzare@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Peter Huewe <peterhuewe@gmx.de>,
 Jason Gunthorpe <jgg@ziepe.ca>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-coco@lists.linux.dev, linux-integrity@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
 Joerg Roedel <jroedel@suse.de>, Dionna Glaze <dionnaglaze@google.com>,
 Claudio Carvalho <cclaudio@linux.ibm.com>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 linux-kernel@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20250403100943.120738-1-sgarzare@redhat.com>
 <20250403100943.120738-5-sgarzare@redhat.com>
 <20250408110012.GFZ_UBvOcEfEcIM4mI@fat_crate.local>
 <eqtiiphs6rtjo7nirkw7zcicew75wnl4ydenrt5vl6jdpqdgj6@2brjlyjbqhoq>
 <20250408112820.GBZ_UIVPp-LuIiVrIV@fat_crate.local>
 <o2u7p3wb64lcc4sziunr274hyubkgmspzdjcvihbpzkw6mkvpo@sjq3vi4y2qfl>
 <20250409102120.GCZ_ZKIJw9WkXpTz4u@fat_crate.local>
 <CAGxU2F7r_fWgr2YRmCvh2iQ1vPg30f-+W6FXyuidbakZkwhw2w@mail.gmail.com>
 <20250409113154.GGZ_ZaqgfRrrMij_Zm@fat_crate.local>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20250409113154.GGZ_ZaqgfRrrMij_Zm@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:806:130::15) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|MW6PR12MB8663:EE_
X-MS-Office365-Filtering-Correlation-Id: c98c1d90-f2db-475d-5ca3-08dd7780afc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZG1jd1JSWWt1d0F0Z0JuNnQ4K05kbXpsNU9VTDF6bWU5R01ZYzNsaE81UUl2?=
 =?utf-8?B?RklmbVM1VGJYeUlxWUVXaGQyd2M2bmxvUlFoa3huT3h6UGVxZ0FMSkJGZVg5?=
 =?utf-8?B?TGFxeDBnZzZrSTJMb253Si9mZk5xMkNHL0M3Y0M3MlY2VXVXQ3hVdzdUZFBD?=
 =?utf-8?B?a1BJdnhJQld4RGZqUGdVVUtMWXJnTmdGdzd2ZmJ5S3hPZzV5YU5iVEZjVkpl?=
 =?utf-8?B?S3VsMmJpUzMzUzlsV3hmbHduMXEzYjM5d3d5Z1JlcnRkZjRvMmRhdDFIZ0oz?=
 =?utf-8?B?SmN1NlUrRmtvLzFDMjhnTndGaThVMmlrOStBZXJ2L2UxMXpVUTQyV2U0cks5?=
 =?utf-8?B?V1Q4NTgvNXZrSU5nbVMyODhobC9MK2pDOUFZTGFEQ0pkMUFxbzB1dXhYc1d1?=
 =?utf-8?B?TUtJWlh5Q0RLZzEwOS9WdlhpbEJEbzd5R3IwZXdIMlBQTjRUZGhJb3o3UVdW?=
 =?utf-8?B?YXJORG5HS2ZZQWFsV2U1QmNsT2FEaFYxbkJwakZybTNCZGZyV3JiVzFwbEZJ?=
 =?utf-8?B?MHZvY3JHTUZpSUdYOUJIWlZqeWs5c0FFUGlxUTBTVG9uOTVkb0orOUthVFYr?=
 =?utf-8?B?cUt3c3Jwbk50VjhhdGpaMmFyMEt2QVY1NThOMDFUa0dIMzcvODJBRjFmc3Rx?=
 =?utf-8?B?ckFRSExRclRHVElmM0lObzQ4bDB6cWJWc2JkRnlBQkhhWHFkT2xTN1dKVXFY?=
 =?utf-8?B?bGhXRXpZdU1SNXhVcCtobFQ2eVFWL1J4M1YxZ2UwbUZMVGV0YXBlTkx1M3pO?=
 =?utf-8?B?YTBFTkhadGd4MVhyNzVWcXhCQmxkQ05zdUZTRHMrVEg0b0g3bDFRbHphWmYz?=
 =?utf-8?B?UW1tWDgxWjE0akZ0M1R6V0RtMnh6cG9qT01OU21hNUlSelJjbjhaTWNYOHdi?=
 =?utf-8?B?M0lva01Id1MvTkFLTFFreHFnNUtjR1NpQUNUM1ZSc3ZBRDdGa3ByS2pnc3Q1?=
 =?utf-8?B?dWdhakk4bmxSdjJvZFB1azl6eS9saXBuclFrUG50M1hwQlJXTUpIa21lNFRL?=
 =?utf-8?B?Qnh1MWNEVEZaYnVyNzdEQkNQT2E5UFdCd2YzL3J4Ym5GTVBPRlVJWE85azR3?=
 =?utf-8?B?SmZMQmNxcUpiU2k0SlI3YUM3YzJadUVIUGp2blhaQXNjVDRwNWtndldXdVlR?=
 =?utf-8?B?NUowYk1YYTk5Qys1UTh4YnFURGxHdVM1RHVFTUMzMldQeXcrU1FjVFlvN2Z4?=
 =?utf-8?B?RXFXdmo2RFlhbG5obFZkQzRmcThsZlZWQnJkUjhSYlZHSlIzcnAwM29vcGhx?=
 =?utf-8?B?WU13Y1NZejZVY1Z0aDdjc294QnFyd2pya2JYbzNad1lrZjFPN3dPMTZCYTNH?=
 =?utf-8?B?RW9tNVZZc2dBZEM1WWNXdFJNMGY5OEM1bkZLNTk2cXk0NGtXRWJ1NlArTFlR?=
 =?utf-8?B?dzN1K3d6SXNPQ1R2NUlTSi9FeTJCcHROZjFkS2FVSVp3c2ZSMjdDNThOMXRi?=
 =?utf-8?B?S1BhSDZFQU9LbzRUZVg3cUlzRHFMSmdPVFBXVGRqTk04TTFLRDlqdmcvNEZm?=
 =?utf-8?B?cTk0WHJDa0kxS2xJR1JqcTdJb0NSY0ErOWxyY3pjcVFuVTBJc2NsNTBmVGlu?=
 =?utf-8?B?OS9iOUpRTkhYbTR5R0x4WVVLSWsyQWp2TlQ3QUdIckkwekJMejBpVk5qR3ZS?=
 =?utf-8?B?Y0cvZUg1cjAzUTZsUThHV05YeFk2TkpRWjFURm8rRlNQK09GRzlTbVNXL0gz?=
 =?utf-8?B?S0ZEVEVPa1Z3aHJuaW5KMDgxVTV6QlNiRUJ0d3NJbUxoTXpoeGxuZ0FRMTc2?=
 =?utf-8?B?ZnRhczNQajJwNFlHQ0xqMzRYUng4UWFCQWFIcVZXeGl1U3Q3bWMwRmNjNWg3?=
 =?utf-8?B?cUlOazZHQlFleEVxa3hUc04waG1DT0VIVFMwVk1EVEtjRzhxUDBPUUZNeG5Z?=
 =?utf-8?Q?vahZsGzIk1vrt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REpFbGlWaEtPNzBMTlJRaURORkdKZEtwNE84SjZ1VDNtL1d4ekwvLzAyTlpI?=
 =?utf-8?B?VStzRGkzcFdxcENwb21UcnVHZ0ZzbWNhNUVLRUJSdXAwQjNMV2ppOUlVTnBV?=
 =?utf-8?B?QW9CUmZST3lIQ3ZETmtLV2MwNmE4MWRjYW1zbHhXbVRoZHF1MytRYmZTNFl3?=
 =?utf-8?B?Vy9uNjI1Z0p3ak5aQy8yV2J2L1JEZUVQWktmcHJYQ1BkUUdURjdySjYyRlZD?=
 =?utf-8?B?clh2MlJVS3BnaHE2Z0RSKzlpM0tlckNacS9kQmhlZ3BrZG92YU91Y0ZVRmhH?=
 =?utf-8?B?SjhSeVRTL3k4VVJiZExTc25SbklxRVppQTVjcm1CbEtCZ2JMNHRSZlowVkxr?=
 =?utf-8?B?TXNITFpNTUNlVmEwYVRYY1paOE9mMVUwbnMrYUYzRnZETVVXdjZBb1NnaHRN?=
 =?utf-8?B?NndqVDVQR1o3Z2dlS0Q5REU1c2EyK3BwcHkyWUlrTmdDLzJ6Z3JxRzNreHJS?=
 =?utf-8?B?QlBraysrTXZSWjh5WFQzeUtMRlVFci8rejIrbkdPUHRaUTBGTnhuSjNrTjJa?=
 =?utf-8?B?WW9EUHZXKzdwWGxDRG1JOEJpbGlEdWdwY2ZiUmRnSUUrTVN2MzJGQ01ud3FS?=
 =?utf-8?B?SFVzemxaRk1Cc011UG1LUktJVzJQV2dMbTBYUjU4dGFOeUNDeFNSdHBtZTho?=
 =?utf-8?B?RHNqOVpxUXRwajNvbGJJYUF2VHlPdVBYWitoQ0pHbVZ2Qzg1bTNoS3V0YVJX?=
 =?utf-8?B?VVBGaUtabmtYTE0vbFVYZm02b0tIMHJRelVoMWgxYVdwOUdYamhuRlZmS09F?=
 =?utf-8?B?aGdDbm9jYkgzbmgyNkhzaCtDcVNLL0lyalcrWEFQWXlvbjhQSTRmNW5NeFlR?=
 =?utf-8?B?Qm8xa01GbFBWYUpoM0hFY2dXTldjMkJjMHdSUlpoOU9kbCtsNjdiNXBwKzc0?=
 =?utf-8?B?UlBZUWZKQVNGVVdLalJXdnZmVE1CeE82RC82QnBubEYvVWdtUElZa1lyVFJ2?=
 =?utf-8?B?dGVFQVpWTTAvdURycE4wYjdtTlVOVXdacVBFUnZWajJvc3cxMFhQbjRBMFhr?=
 =?utf-8?B?Q01KSmI1RlozU2llWmQwbEtxaDFnUFdIRWttNlBvY2s5VVllci80RStvOXBl?=
 =?utf-8?B?QjdiVTZEUnBubUk0OWZiMzcvRGdnNTBUbXU2dCtlT1g1UStmQkdqSU1kRDkv?=
 =?utf-8?B?WVNJV2RJWk1UbjJMWWVGNGdWajVaenJoeGlBSWsrM3V1L2NXVHBnTzFsMHFH?=
 =?utf-8?B?SUNRTDBld0kza1JhS1F5dWdwUjJvZE1KQUMvbWpSYmhIUytwVVF2SHRqc2p3?=
 =?utf-8?B?djROODlKcXRPNitEeGU5Z2xwbk9vaVRQQW15dHI2NjFzUlFlaElBSzk0dzN0?=
 =?utf-8?B?dXhKdkRKb1RNUUhqVXJVYUNvcTF5aUs2VmJ2MWgrbDk0bk5QNmVKblJvQ2JX?=
 =?utf-8?B?Z3poN3p3Vkp4RUtVUnN1Y09jSGU4MjJMUG5vL2UxRUpqck83QmgwZGRHZ1V4?=
 =?utf-8?B?OXhFdW5NS3JjckdjVzlvQ0ppemNxY0FHdGRLMnFybHA4V0kyUUtselh6Nmdr?=
 =?utf-8?B?TjBMYlQvejdEWHFqaXRXdzdVTUZ5OENMSDdkZGI2Nm9qcWRsS1BHRTlwNVJs?=
 =?utf-8?B?VFcyRFExTlI4WU00U0Q0aU5BUTdiell1eno3N2FNdkdRRjZibHpHcjN2VzZW?=
 =?utf-8?B?bm5ma0ZKaGZ5ZFFiZWJlNVBSbmxyL1FPL3BrVkhrTW93VVpPWnZEVm9lekxi?=
 =?utf-8?B?QmlVYWRmYkc2amxFVWhoZWtjbU12THp4MFgxZGVPMGorOFdOUDZUSnNMeHN4?=
 =?utf-8?B?b09HbmszUW1JeW1BMm9jTGJVSVJVSzk2WGFtVWQvKzRlS0xiQ3VFTWowQjFh?=
 =?utf-8?B?cHB1QVJBTy8wQWR5S20xbFV2S3IrRVhpRHI5emR5RWUybXhCUHlDVFFiRVEz?=
 =?utf-8?B?Z1ZISFlXSHR6KzBkY1pqNVhROW85SnVzeUhTZzdJWFo3MnowVExhcXhNZ09C?=
 =?utf-8?B?MjNmYVNDWkE5cWprZGRObm9id3JibWdGSnhaUjRHbCtkWUl4S0hzOC9xc1Zo?=
 =?utf-8?B?UVc1djA2NDlvY0xMRGljbWhRR01oVnBMdmpaNGFHZ2tmYmtKbC9tdU9mZ2M1?=
 =?utf-8?B?UThvbU5MVVM4M3lHc1hRYzFVTm1sQU12Q2g0Z1lJZ01pNkpMYnhTemVieFRv?=
 =?utf-8?Q?+s5L0teRvyH+E8IxVExAGZkmm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c98c1d90-f2db-475d-5ca3-08dd7780afc5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 16:07:54.6569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/Iv/y3gvy7VXVkSazlNq/v3MPhN5DWeoHvokjyy5/I3dsJLkMl274gyzNuqmvkTHvZ4GBzqiIycCTpOm7kzUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8663

On 4/9/25 06:31, Borislav Petkov wrote:
> On Wed, Apr 09, 2025 at 12:43:01PM +0200, Stefano Garzarella wrote:
>> Sorry, maybe I missed something.
>>
>> tpm_svsm.c registers the driver with module_platform_driver_probe().
>>
>> Someone (the platform I guess) has to register the device by calling
>> platform_device_register(), as we already do for example for
>> sev_guest.
> 
> Maybe that platform device thing is the wrong approach. Why does the core code
> need to register some dummy platform device in the first place? Why can't
> drivers/char/tpm/tpm_svsm.c probe and init without it?

I think the platform device is the right approach (just like we do for the
sev-guest driver), but I think we should only register the device if an
SVSM is present. Then let the vTPM driver probe routine check if the SVSM
vTPM support is present.

So the vTPM driver wouldn't change, just snp_init_platform_device():

	if (snp_vmpl && platform_device_register(&tpm_svsm_device))

Looking at the message that is issued after, maybe it should read
"devices" now.

Thanks,
Tom

> 

