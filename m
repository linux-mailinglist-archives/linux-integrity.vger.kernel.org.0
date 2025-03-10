Return-Path: <linux-integrity+bounces-5207-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E36A596CD
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Mar 2025 14:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B984C168422
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Mar 2025 13:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA8622A1CD;
	Mon, 10 Mar 2025 13:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z4U9jtW7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F7A33991;
	Mon, 10 Mar 2025 13:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741615021; cv=fail; b=LdwX4RFKXgFcy255uinWhdfbUwRi15sjRUH4xMKzZ8BpWDpY9TqHbHJvIqJc9DmwChfdHANIJnK+bSinOiV+ja0qQJm0KCduCcePh3sj8smS+4F/VF68w6FR5b6/xtL2moMHwLHQlT9rrOjM++0HJ+DXX9dUztKaX7B7Jo0/bhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741615021; c=relaxed/simple;
	bh=aWeHvgoT2//LqTbJBL5M1gZD5pd0Q48nrk3fX1o6eZw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ecvv5S6TqZLkltR/2OCA1lwIderEa4FEx5zlI4gVutSz+MMSya6qtUE5nosDLCNf9Y6fkRjb38elMI1zVHnHlzu2kK1VYR7Tb/rCXx0KWBykuQ2uMULSa164kboRETXrSv0f3NO4JM4PvPSOihWUuyU8T2x6No1/XdJxknV/H3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z4U9jtW7; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uF8ZnHJKUs8B7oQS+ycIOtaxPss7FqRrJzi59s7FrNbXR0ZoynODktww+tTef1P9bGU7RInmcq8RpDoYNiN2ReD2krEWphw8vK4OyQJbYhwq0bNcvOqMELscWqP7EMrbRxuTJjgFdnLNXRzbUmKem97BKj7Qy9ZpxtNHhziKDTtSh25ABjQGN4tlqMprV18va/ESaVYJ/5PL62pKhpVoYU3N1dVZna9f3jp9wz9/RGy0Hxo0MZwXqYPwqb8T1sF3SbzETB5pGEsA7i+3G5/ADTBlOqSVJTlpGyQF+gxWuX5byBl0VtQBlCVIyddG55Gats8prs+FqalM/+RDMfqHiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NxerYN9MCgeJrH/NeubbPIiRhONI9CRnRPkoKrFpQk=;
 b=vjb8RZMsb+wn6wFNFontdm1imhESAVCjGAYjOcL1qDb6UZd/h0BU95qubrHtWVRIIMWZh9SpvPmzw9Nj9zKRiCeGTdaYkEU3TiLHLsMoD9PQ6/lW16hUGjpBR6b3BONdjiqk6FllMjDFnSylmmMLZPKdbgW2GrCf+2EUZmqqGafMLpyc5pgJ4yM3U/AiuZYBCI8sj/sZd7W5J+uYNDWGkMHeWnpcUKnijf49echR3zNlIo61jDPTOb8iLo+c2LQDH4x+hZlWOriDh0eK+des/gqx5wj0z4LK5OVKYibBhzlUbmYOnWPQAEDIEcFOBTSx6jZsCkgnT+k+K1YsR8B9uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NxerYN9MCgeJrH/NeubbPIiRhONI9CRnRPkoKrFpQk=;
 b=z4U9jtW7a5gM0eqbFOofQwUTV8iGrrHojK0eYFLp2T/A3YIDLdLUA8mEcpX4bdeUtX9QK/xrw0zf5G3WD6dJp2oCBqzt5MS9Zw28CLnhp4sb1KyCni5Wsa/CxZiqTSaUbMcgf/IP5QPrEoR9CIsJksIhGty6AhIsIQ+efelNzv0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5062.namprd12.prod.outlook.com (2603:10b6:208:313::6)
 by MW4PR12MB7484.namprd12.prod.outlook.com (2603:10b6:303:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 13:56:56 +0000
Received: from BL1PR12MB5062.namprd12.prod.outlook.com
 ([fe80::fe03:ef1f:3fee:9d4a]) by BL1PR12MB5062.namprd12.prod.outlook.com
 ([fe80::fe03:ef1f:3fee:9d4a%5]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 13:56:56 +0000
Message-ID: <9c1246c8-6965-b8b6-eab1-df0761a2853a@amd.com>
Date: Mon, 10 Mar 2025 08:56:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2 2/6] x86/sev: add SVSM vTPM probe/send_command
 functions
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Claudio Carvalho <cclaudio@linux.ibm.com>, Peter Huewe <peterhuewe@gmx.de>,
 x86@kernel.org, Dov Murik <dovmurik@linux.ibm.com>,
 linux-coco@lists.linux.dev, Dionna Glaze <dionnaglaze@google.com>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
 Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250228170720.144739-3-sgarzare@redhat.com>
 <20250310113006.GFZ87NPu-LgFVVtsEG@fat_crate.local>
 <mjftygohmhgs6daqvgkh2jbfuqjquchcaovcjtnzyhilnt5ww5@l3fr7phqh2ps>
 <3dd645f2-476a-d0d5-c8c1-c87307f2d756@amd.com>
 <20250310135133.GIZ87uZZNhNSkmxvg1@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20250310135133.GIZ87uZZNhNSkmxvg1@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::35) To BL1PR12MB5062.namprd12.prod.outlook.com
 (2603:10b6:208:313::6)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5062:EE_|MW4PR12MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c28aaaf-0695-4afc-7dbb-08dd5fdb6b76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWRjN21ic3VDNG0rbXB1RENxNEdGZnpGZUhWM2hXR1lIY1lvVno2YVprYVdU?=
 =?utf-8?B?Z2FxNElZWjZzcVdzUnh3Sm1QMHd6OVVHekdZK1ZYcE81NHF6dmIvODZiSUlQ?=
 =?utf-8?B?SnlCOUYvcW5WaGQ4Z3pIVnJwRUNsMEQxYzB0RnlGM0VKdXZJaGZ1NTZQVkNj?=
 =?utf-8?B?MnA4RXpUWGM3TXpMcUxtNUVhdFo1Rk1OWGtZNkRKOVRwVjVWNnpBYUR1YUxF?=
 =?utf-8?B?emQwV3dtN0pFUnNKME5HZGo4dWJmeXc1UXFwMHV1R1ZmRnpsL21xdy9BYjRt?=
 =?utf-8?B?NVl2S0pVSzVCQTVFV085aStYdmJMbGEwM1F4dGZuSldZbXZEYy8xY2dqU0Vj?=
 =?utf-8?B?MmJ5WnVKZEpTd3JnZHVKT1NYdEg1THloK216RFNqcVkzeEdpRHRQQnEvMWJ5?=
 =?utf-8?B?aDdmTE1SWnNnQ0d5KzlLbXVLOGhESEp5cXRtVUNJL0k4RTdCalZGVzRFYW9v?=
 =?utf-8?B?Ym1OS0hZRmRxL1ZNd3N3NTlOTUI0VTJ6TmVGa01wcDEvSWpDSVFHT2lxWnFB?=
 =?utf-8?B?RzdiUUlNK3hKMWNqeHJaZ3pQYmhoZE5RTjhWdTdmRyt4Y3QzcVRlRDVQWjlL?=
 =?utf-8?B?NmRWTHRVQVRBbmpCNWtzaXFvSFFlNTJGaUlXZUNnSW1mTGJEY25lbXN6MUZE?=
 =?utf-8?B?YzNoSXpCbFMyUmZ4cVJMcEExaC81M0prVW1MU014MVkxUUNGME1Vb2RJN0Vj?=
 =?utf-8?B?M0VwVWlKSzdyZWNwYzAwRFJMYmdsME82S2xvK3BNVWZFUXlXWms2a3RWa2c4?=
 =?utf-8?B?UmE3MHdFaU4wMENoa3Zjb2NvSXpWYTdaNm52aUg3YjFqcStDSC9LMy9VUmtH?=
 =?utf-8?B?cy9PUUJIVEUrRENoSFovWitBUEs5NlphWTltNkkyc045UVdSdjN2akx6aUdR?=
 =?utf-8?B?TkNNT1lKdHA2SElLenFZSmR6NzBtMnJlbXZBVGl6dmhXTHJlKy91NDYzU0Qr?=
 =?utf-8?B?STYyN0h2dmtIRGpraCtlQTJjcVNaazMwM1hHVkgyaDRoazc4RUFVWmRIbXhU?=
 =?utf-8?B?elJ6c1l0aVEzYlpmSG9mQ1RML2lMMVI2VGpOOHQwNlVtdWN1Y2lFdFBwSXFa?=
 =?utf-8?B?RFcyWjRPL1hkaXFnWUZ6VEFvbGxUSXZUOW8ydHNKa2s2RU1DbUtzY0F4VXhi?=
 =?utf-8?B?VkF5YnNoNFN2ZjEwcUhhMWM1Wk5naXdrOUhySWtZVUxTSEZMTWs4anI0L1Va?=
 =?utf-8?B?SnEyWHJjZnp4NU50aGxhM0s1WjdPVTV5RXJWY09Obk1VeSszV1p5NXRVOXZa?=
 =?utf-8?B?Y05GTENGYnBmWkhCRWt6VE1KMHMreWxQbVQyRS9Da3l0czdkVS95NXF6QkVH?=
 =?utf-8?B?ZUJwR2NCRzU3R2kvVmg3b0JmTjNQbDY3MFl4N3ZkNExpcFMyQ3ZybEQyTGto?=
 =?utf-8?B?d2o1cGpOT2NHd0d1NkhLUUpvVUpRR0Y3K2ZtQUpjS0JwTS85dVNyQ2xEYmRC?=
 =?utf-8?B?dWtLNEQ5YkVvcG9SbFJGNGI0S3o4MWUrZ3RNM1N5eitjdDcwbUFUdXNmNE4x?=
 =?utf-8?B?cVhnblpXUlRqK3dObGc3MzdSWHZJeWExcjlKWWdzR3hPZkVLTE5tRG1xb1hS?=
 =?utf-8?B?VTM5aHJnT0R3M21qZzVDUXJpTXFoR3Zod1JSclkySXh1U2dhTVZrZ0Z6RWFY?=
 =?utf-8?B?U0pNQnBOSGdBTVVPUkRxK2dRNFZ5RjEraEd3RjRyNDJCN0lKbDBQMDFPLzYv?=
 =?utf-8?B?REFCN3pXTXhvT2dIOFk1dDA1aWhBeDFtTUZvb3d1RUF0R3I1dlVVLzRDaDV4?=
 =?utf-8?B?dmVBZUx5Q1JzUWoySEQybWNWMTN3a0gzZ2F5YzA3bDEycDVGdW11RjJsQ2cw?=
 =?utf-8?B?VXM1M2JYdUl5UUpNRm96QTRaSDBDTHBxeTI0d3NZVzFXSU42UTU3Tm9TdC9m?=
 =?utf-8?Q?EL2OhuDWMy64f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5062.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHluTkpIU0hDUVpOanJ1akFxb1hVZkpHOWVHTVlZa05GQisyMXhiUVZWS0VI?=
 =?utf-8?B?bm1ERXhKVFFzd2N6amVvT3NrVWg3L1gxL2VNZzJJa1F3QzRFYjVPSWVSWXVP?=
 =?utf-8?B?MXRHajdVMUt5RkhrWllhWkFGbVc3OFd3czNla0NVeXJuMXBuY0NHZjc4N2lE?=
 =?utf-8?B?SFNmNUVTVzR2a1NOYklvaVg3Q3cvVDU0eXQwWVdoNkpPYjRQZ2xtTXg1NFdR?=
 =?utf-8?B?SjZxbE9JczVaeWRSQ2RObmpxd1hzVzZUcVh5T1hiL2l0SkVDK2crWE84RGpm?=
 =?utf-8?B?Y3JzL1M0ZzFrVGEyczBQVG41Zi9seGhOOExNOExib1NSa0RJMzZZRmw3V2Ux?=
 =?utf-8?B?M1gra0g3bUhnckQ3VHZjcjR2RmJld2Rod1g5RTNvREJXcWVBUHVwS1dJckth?=
 =?utf-8?B?ME1naThKeWozRTlZNTRxdDBYQkhNSjBCVkNkWnlDZVJPWDA0RXZ3amFjQThY?=
 =?utf-8?B?cnlBRnh4MDJpZ0pVMld6YkNlK1YyYWJlWlgwelhGbUloUmtlOVZEN3JGSVN3?=
 =?utf-8?B?WGh5ZCtqSWM0SjJrMjk5TjdRN2Y5R0dCeEdoM0hHMmowQXgzT3U4KzhBeGpD?=
 =?utf-8?B?MGM5VU82OHZiTGZyUllLWk1JeUx4TjdSNGQwVTcwQnZ0QXNSYlFTNGhjdnkx?=
 =?utf-8?B?ZnJTMFVFS2V5WVVpY2hUaHhHalR5REMxMmtpRzBCY1phQ3pVNm1UNGw4amdq?=
 =?utf-8?B?c3JKVW9TdXRlZTl1b1RDSlhEcXNpNUk1b0VONmJZR3BReWtUMW05SU9WdEZZ?=
 =?utf-8?B?MDNZOHp4b0dRam1LanA2a1pWL1VnTGFuMHVyL3VEZGRVeFZjb0xpbldvRHhJ?=
 =?utf-8?B?Y0x1RlJPUFMvbGNGSktUaHJENE0xZDVQb01iamVBTHpyUVp2ZW10c1BGWDYx?=
 =?utf-8?B?ai8vUE9yYURMMGRxeW84eHBVUGQ5U3RWN3BCVEMxV3VLc0lmdm9LcDBwSWcx?=
 =?utf-8?B?VXdoYnFJTmtDSVA2QTJDU3RoZkpJZVVhNytLbnRuaEFEc293YzVZOS92SnFx?=
 =?utf-8?B?Z09xcGxsc2tCR29tMEJ4cUZseWtsQ3VuZmh0blV1RzZXQzFieUh5dUUwcExx?=
 =?utf-8?B?V3dNazRQcHFpNWtOM0FqRW84bkw3dkx6OEhpTjNjRmVqS0xPTCt6V2lFeGwz?=
 =?utf-8?B?d3lLUmVjMnhnMld6bFdJeDZXbkhMeGpTWW91Y0s4SWIxRk9zdE5IMnprN2dv?=
 =?utf-8?B?ZTkrU3BIdkNYVFAxeWc1WDJud3M2MGQ2VnZBV1UyWmF2TUUwZXFhT21sQ3gr?=
 =?utf-8?B?a3d0azVaVnVMb0l3aXFOZXp0RnlCNStnMUkzVEQ1TCtDVFkzbjFtNHd2QlNt?=
 =?utf-8?B?WlY1bStjYVZTelF1RVYyN25aanlqc1VLalFjUUZkSk5xa0dOemFxOURaeVhK?=
 =?utf-8?B?cHR3eWJqNHNVNHl0VVBPaWRmVmM0cDZYK1RST2JIZ2o3NzhLTGhtSVBxd3Rs?=
 =?utf-8?B?b0JwdHc3RlBTZEN0Vmw1NlpRTEYrUGdNU0pRWlhKTTlGdmZJVlBKKzFQUUZy?=
 =?utf-8?B?Nzd0dlRSVUdjbHpkRmNobDZwRHRmamNQcVFlNmdLVnJEb1JMTUh3RXlHb3hD?=
 =?utf-8?B?SmZuTU9CVnRjNC9LRWhlaUVRcjl0ekI2bzdwNWd4bkV5WlpUZVcvZTN5OFFj?=
 =?utf-8?B?ZFhjd2VCQ3JUZUxONmtvdGZmNTRvTXVZRjdyVCtIOUdGdkl0ZkZwL1BId3RM?=
 =?utf-8?B?UDl2Mm9yaTU1Y2o3VytsNjJyZjhlTFVsaDVEVmE2U0ZhS0ZWYlRqcGlaQnRr?=
 =?utf-8?B?TFZ3bnFqRXRveFR1bWtaUTdFMDNyT2Q3MkV0U3pOZXk1VlYrUnBCYlBXSVFM?=
 =?utf-8?B?SzZTbVZHWExaZXBSMmxYaUZXbjRUaU5OV241eEpUd2VDSFp1K2dWODhsZmhh?=
 =?utf-8?B?TU0wRkFMNHNCRnV1dktueWpyYkw0Q21NUG1VNWVYbUliR281YUU3TUZobzly?=
 =?utf-8?B?WkRsTkZnZjh4WDdleG9MQys4aWI0d0xpUitMTm5PNkphS3BORm9TVkJjdHJR?=
 =?utf-8?B?U3gvMnlOajBSNzFyZFB2dnFMR0VsMG84QTRjTUFCWEJJejV1d3A0S0lLaUtZ?=
 =?utf-8?B?R3NyaHQxaW1mNm45VmtscHMyOGNhZHUxYVh5UnU2L2ZUWVZEd0VrVjU1VEVu?=
 =?utf-8?Q?Ml9eoFoJL5+cseMPMmmh2Rfax?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c28aaaf-0695-4afc-7dbb-08dd5fdb6b76
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5062.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 13:56:56.4146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZI3r56IKppEhaVgP302dQCAkvBGeyri04Xs/oeia0h4kL02iiKInRg9yzzNFQQIFUXN50if9xLL8ROeeHEd7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7484

On 3/10/25 08:51, Borislav Petkov wrote:
> On Mon, Mar 10, 2025 at 08:27:37AM -0500, Tom Lendacky wrote:
>> I don't think anything needs to be checked or printed.
> 
> Yes.
> 
>> If you want to do anything, just issue a pr_info() with the features value
>> (and maybe the platform_cmds value, too). Issuing a pr_warn() here would be
>> like issuing a pr_warn() for a new CPUID value that the current kernel
>> doesn't know about.
> 
> I still don't get the need to print anything. Why?

It isn't needed. It's similar to "device" information/capabilities.
Maybe pr_debug() then? But I'm also fine with not printing anything.

Thanks,
Tom

> 

