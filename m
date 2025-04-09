Return-Path: <linux-integrity+bounces-5725-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A3DA83048
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 21:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 473338A418F
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 19:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EBC1E25E3;
	Wed,  9 Apr 2025 19:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="frTac2qc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B7D1E2007;
	Wed,  9 Apr 2025 19:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744226210; cv=fail; b=uetDGQ2yx8EJ5gUxVyv6jOYriUvrzgBzXkgsKA8WGgcXYdHQwgav3dm+CNldUKtqqeRkv88NRQpYj74sOlOHfm8qZbCZFlVGOpoJzBTabcguzgN7glcpv2c/EhG+odF64F0CebbNDOZ6K+YzqRVfcW8GI5T6S61o/qy7dHFJczo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744226210; c=relaxed/simple;
	bh=QQzo3V0GLUw6chkwZM5EdPytDu+g420go6cBNk6A9zk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ud6pHzNj7XeAIF5OL7MLibM0deiXd8D7AlsWOMjoSo+vdwFsWoyzC+mq4VcWTrjbbyqmTWh+BG3Qp5sip2T7txayVY6KD0V0oqknGCWg1nnB8psg6phvvHUio2UWtC7PtKZ5ghuDOFR19D6KrcyhpUM25KGBrQaZ9S6ItWQdutQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=frTac2qc; arc=fail smtp.client-ip=40.107.93.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fagz/zLacEUDo/Trl66yANM+w0nn1m0G3kw7qT/+e70Zq36NhRxBcwCjjsLu4QnW1Qzw57X0OFGJUH6MioLO189OTzDETNjjVcigxA61celW0SufiAKwF6bwf3FCon1qt6ubBK5cZT+72YsL3BZPymVsp5F2nGvXrGLz0Uk4GTmTk/sfjw1cgCBg/ERi0K895fvBnAvdq0pjF+jru+sddt3jExsk5d2yen5IlwHNae7t011Y9bf3GR97STGbcj10Emb1J2eSHdVezOLZnwu1xG6iLnqbS9EkZQKD23xgG639ok1haF4MvWjyZb43DDUR1zHlgWxxQ6HwsEAdxADaEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dnICADJ3mHErX2t7Gj92yX7Y82GIaOyo11XS3arW5Q=;
 b=w+r5nnDHvo2XSx9uFQFBXopItiMgXJYoFIsZ07Mb/fJmuCbmSOuDIhXLSLwIFb9B22gGIJ+Ziqu+AmN5JnGAe/SP1WxeJhbWbo6O27mErO8JGBBcVsd3JBcMLRoI9IQBm/wme2KP9qJ4/XM+cevqMjhui2iZq1OtBtoKzSv6E+Si8D4zxg9pytAqN2TzE7YrQBiBRpFJAucqlGKGp6R/uTJ5By9eFKjPggU3ZiO3L7CCvzv3inBYXVM+UxeUzZNeNNVURzFPgrBZgiT2/o6n+4BGS0mXknNC6t55JNPq6jloWnvUvuH8FOyvOWKRD/ZbTZHBAIe6lJvyyqVHbxfFWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dnICADJ3mHErX2t7Gj92yX7Y82GIaOyo11XS3arW5Q=;
 b=frTac2qcCOdn25MrgvFrlWBXTvESfhR3Xas5qtvtyZDr5eZvjbnJeqsq1mXqsKuA6WYoHqYs5Kvf4AlwmlVq791Dn+QmDBuh5vLA4w7YpU4tGjz0GHDLJLN7clQJg5fkxSrDS75gZzwUS1xEPsX0haYIgiF+RtE6+wNzZAHIDXU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by DS7PR12MB8418.namprd12.prod.outlook.com (2603:10b6:8:e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 19:16:46 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8632.017; Wed, 9 Apr 2025
 19:16:46 +0000
Message-ID: <bf8b7522-f34b-f7bf-11a5-5f6a223129eb@amd.com>
Date: Wed, 9 Apr 2025 14:16:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 4/4] x86/sev: register tpm-svsm platform device
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>,
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
 <6e5bf479-ee95-a996-5845-1f76730e2488@amd.com>
 <20250409184507.GLZ_bAM8LCPXKn9xU1@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20250409184507.GLZ_bAM8LCPXKn9xU1@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P221CA0029.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::20) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|DS7PR12MB8418:EE_
X-MS-Office365-Filtering-Correlation-Id: 8df5c0bd-a772-4e01-bd78-08dd779b1229
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3hGUExUUmtVZDdGc3hkbkxXM1R3ZGtyMDd4UlczblJRQXF0dloxNUd4TG8z?=
 =?utf-8?B?dG1vQVhaM3JXOXBLdUJKNnN4RE41SXYvZlJIcFdZL0FIeGRPaElaeE81aExG?=
 =?utf-8?B?T1ZSTUo4OERFU1FhSG1rbGJXbXpOYm9iNGhCR2drZVQ0cGRQOGpZaVFoYU9X?=
 =?utf-8?B?Rk9naU9MRnBsYmZ1eVpONURRQXk1NXJUYm1BN09nQ2toNzhROU04Z2ordmZ2?=
 =?utf-8?B?bE83Zy85cUNlNThRRnRSRjFEN3puNG9GbHNpTnBkZitWY0p0RUV0ZmRRYWc5?=
 =?utf-8?B?Q0hCbG9SZU03TVhXVnlvZm95RnVMclFnZUgwQlJEMS9wcklwa2lOakVlTFJS?=
 =?utf-8?B?UGNWaWE3Q2hKY25IS0M5OGJKclFBUjczcEJOaGlqYXZURCtwb2s3Mk9oTS9L?=
 =?utf-8?B?T2hncjBJZDBRNDREaEhVOXl6NjFJNC9DcTFoSHdaL3JSa2VMZ1VqeU9JSGhv?=
 =?utf-8?B?U3kyWjhPNzJyYXBvRlVmaGEvUkRZS1JuQzRJaVl4aXZzdjYwVG8xWVRHdi9o?=
 =?utf-8?B?NzIrUFpyajYvdnhiUVJHMHQ2VUpVdnR1Y3hhU2hhOHVGVGlicHlPRFREeW5M?=
 =?utf-8?B?Qm9pbWU0YjZaem1keHJGa1BHeGZqQ0c5V3VHd3ZNK2pWQUtkVGk4TXlobFJw?=
 =?utf-8?B?b05scUVCb2VFNzQwaVlMSFlIYXR4aFQ4TmVvZlBrTnJWQ21QcS8vaHAzU2Yv?=
 =?utf-8?B?c3IvaHZDTmYvNmI3KzlZNWhMc0dWQ3dhQy91U2hRWU9vVnV5cnFhVWQ3YlAv?=
 =?utf-8?B?QTN0NGc5TVljNGxtZHVYVkhNMUdKUmRSTUZ2ck1XK3BUSjBrS0pGalNpUk16?=
 =?utf-8?B?STVWMFJDY3E4TzBwQjd4NDBKN3JJMEhEWjdZUXNYL2JXbW5qcHpiRFBycEJU?=
 =?utf-8?B?RWp3NEt2eXV4WDhsSld4bU1teHI0UHZvTDBUTk5MTmFla0dXVDZMOGhHUnpD?=
 =?utf-8?B?d2FWQkVkV2hubWhYVWQrbWo4OWliaDMxQkF4WTQ5c0FIc3NGZTVJOHRqUkdr?=
 =?utf-8?B?SFFwaTNSVlJ4SGNDenhjQkw3WDRFWEs3TFRPNlRhVTd5NFZCMmNrNHBnUW1a?=
 =?utf-8?B?OWs2bVIvSHZxS2J4OFdORlVtbHh2M2FvWHhLWSt1N3B4UGVkcGk0bGt5aEVZ?=
 =?utf-8?B?R1h1S3ZmbHFpRFIxSWVBZTNvY2x6a1FnVndESHJhL1o1Z1JDNW5xRXk1aE1k?=
 =?utf-8?B?bXJkcnY2R1hZQUk0a0NRRDUzTkllampjUjRjbWxhN2xEbHV5M1I2NzZaQWdU?=
 =?utf-8?B?eG0vR3d3c2Fucy9TdTk0dEd2d01qV0J3UWFUdFlBY203cUpmUjV0cjBMd1NN?=
 =?utf-8?B?VEM5TEdYc0txR3dSZ1J5Ky83d252N1N1RVUrcFdjVEZ0ajk2cndlU1FWVVZR?=
 =?utf-8?B?THUvSk5HcjRFVG1HK2I2anN5N1VGVWh6VmF5UkQ2MWhPdCtEVnRQT2UyaHcr?=
 =?utf-8?B?ZVdXNjYxSllqdDJJSG45all6aWQ2MndqMnpRQ0t4MGtEY1ZMeTRySE1TVmhP?=
 =?utf-8?B?VUs5WFFyRGFlZTQ0ZnZIbVpTSnpWMTRRWVhUMUpOVHRZVVBoN2lWQTl6Z2Nl?=
 =?utf-8?B?M0o0aVh6T0xuaU5xUmQxakt5WHJPc1JKdm1nZG92aHg2VVd0Y0pDSGJwdDJW?=
 =?utf-8?B?dEpHbGRlMU5uZ0t3cW9zTXIyRVEwNFQ3QUV0R3EvMDlDM0RGZzJaV2tta3p5?=
 =?utf-8?B?MHFSUEVVcTBvdEVJMkFDUlArbUpKUFRwcGpaOExWeDZSUHh2QkFGcGVxcVJz?=
 =?utf-8?B?dVlBZzBUcTU2UE5zby9xbXlFZVZjaFdrL01hQ3A2dlFpQ1ZZS2p6K0lZenY1?=
 =?utf-8?Q?9QyXg8oUxCwPaP9Bn1opfEvKHUaX6JuKamYQY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmVid0dXS0FnZ1Z0am5VWkFsWklrNzlMTTh2SGI4TERubDZYZEVRQkR6YjBH?=
 =?utf-8?B?azVQNGowUW9iN0wvR0JoeVNZemc0aWtaeEREVWtBZ1g4YzZKN3NlTi9oK0xa?=
 =?utf-8?B?QWRRU1ZMSDBPQ0RrRU1Fc3dRMGdiN3VSMTcvS2FQNnNCQjlEbURLNDBmVGJP?=
 =?utf-8?B?M3BlalpicmRLQytOc2JJVEoyQkpmT3ZnTjZSTDJKY3dLMzlpNUEwZWI5TGRy?=
 =?utf-8?B?ekVnNjNCTzM1SWZQcE10em9CWDVmd0N3MGVzL3I2MEI2dzZrelA5emJoem1m?=
 =?utf-8?B?NzlOd0FTZmdNR2hHdW1ib2FXaDlFS3hNTE1KTTdRTlZ1UXVMc3h6cU9nRmdB?=
 =?utf-8?B?V3RtT0g2dWIrc0FOcThqdTUwQnFMcTRQNm9JYWl5S2hTTjVFbHNTQ1V3QXZy?=
 =?utf-8?B?ek1TM3o1blhnckpuU2RVNlNKcE5zM1E5cGp1eXJhczFoMFV6Yy8yWHpnR2Uy?=
 =?utf-8?B?K29IYlF2WExZWHFaQlpIZThJaVppYVlhMzVwVU9IT0hOdmJsZVBPWXVQSjRN?=
 =?utf-8?B?VGdSSlBlMWFpS3NGNVdwOXJtNWVuL010WWV2dVM2a2V0dm1RQU9HQzVxUEov?=
 =?utf-8?B?VCt5L1FST1FqVWRPTGJvbUtCNFhlTTNJSG1ieUNNa0F1TTUvVyswUCs0NU14?=
 =?utf-8?B?clZRVXNSeURpQUp1Q2pOWVJtWmVUbDFhU3A0ZFIyM1lHSUtEU0IvRVhUTmha?=
 =?utf-8?B?TXVSMzRyRHNnNTlvZlM0SGljRCtnZjdIeW9jZHJmWmJaaXpZMXRJZEErYVBv?=
 =?utf-8?B?VEtuSm9CMTNPVUN3ZUMyMFBlZHE3bkduSG9GcmhMRzkyOXdFUUpvYlJqc09m?=
 =?utf-8?B?QmEvL1VxY3FrS0hiN09yRUpLRzlhbW4rVXpCc0Qra3pSV3gxNHpLeHllclJy?=
 =?utf-8?B?VW5DQVJlczhBbjAvZHByTExUNkthOXlGOHJBZ0RWNlgwdURodjdCMU1jYTk1?=
 =?utf-8?B?YTRqUThDL1Jhb0VKSDMrL21Hbkszb3Fqem1hMXhPcE04WDFKQjM2SVVYS1BS?=
 =?utf-8?B?cWR0ZTdXQ2tsVnVmWHJScXJqWVNwTUNkaHRaSVA2NjJ2SWl4UGhrL1RHZ3k3?=
 =?utf-8?B?SmpWclVGSndxVjYxZkpTYUtMRld2bGFuRXlrcEV2SFRBaU95ZEx3WlhiMXd0?=
 =?utf-8?B?UDl0RWE1R2JuRnQ3bXV3K1hHUFU2V1VJWGc2ejJyUlRLc0RDejBHL2IwMk5L?=
 =?utf-8?B?YTNwSGJMZk5sUnIyWFFGUTBidE9KV3ZZVFBoRFM2M2ZMa3NMQ3VvOXorV2JM?=
 =?utf-8?B?L0VvZEFuanRhdldaU3VHRHN0T29QSCtGUlk5aE1JTnMrTVFlTVAvYzFRdmN4?=
 =?utf-8?B?dmxuV08vK3hiNFVQTFZ5Mng1dGJ1bVhNcm40UGZkM0dDdHU1NzNqa21mQlUy?=
 =?utf-8?B?b24vOVUwdXZ5TWFIZFR5ckgvQlYydjJLcmxtVk9iaXpLamQ3bUE5Z3F4R1p6?=
 =?utf-8?B?aDlZYVRxUVc0MGRpWmdqOEV2NDhtVVpIQUh4Z2ZvVHIwUXpKTTFZbDRXKzJF?=
 =?utf-8?B?ZXFEWmJUOHFid2RTSnN5Vm5ud3RqZFhFYnEzamVReTJEc2hCRGxRZzhoRWR4?=
 =?utf-8?B?SlVlODBUV3BGQW1LckFXOFBiWWo3UVkvUG9CRlVpWW1WWXQ5U3UrelNJSzdG?=
 =?utf-8?B?RitTY2laSThVWk8yaEFFTklBSTl3Z1BRaXEydnBtb1g2akhPNmVYQ3NjeUlU?=
 =?utf-8?B?aTdNUlRQdktteVdlZnBJNFlpeFI0NzdLRGR3NU5tcEZLQ016bjdkTjV0OEdO?=
 =?utf-8?B?MmRiNEVhMmVzN3RVTHlwaFArS1B1OGMzbjBBV1A4UmV2NklwZDh1VTlEYlkw?=
 =?utf-8?B?YUNUeU1HREdGNmZEdnlVVzl5WlRLZFZBRS9yeXpwRVl0OGRPYVVwWEducnZr?=
 =?utf-8?B?WVhyWUllTlcxMUJKS090b0FMZTVJZmQ3cWhoeXRNTmdISm44UTZ2ZWNBRGVi?=
 =?utf-8?B?NTVwdk5uN2RIOTVVTmNudVovVUhhS0tHZUtNaEZqZ1hOcUtmZUkrYzljWm5X?=
 =?utf-8?B?RGRDbDNnR25EdnBpdTR2bkhzU2xJUFFzVlhVb3dvTFBCT095S0Zha2w2V056?=
 =?utf-8?B?VG1oQnNjb244ZGtScTEvQThqb3VlaGRaSnNLU0dPZHhjbnlsc2liYWtIU1BH?=
 =?utf-8?Q?gWbNKPesmkjt2GzoVBW/Fbu8I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df5c0bd-a772-4e01-bd78-08dd779b1229
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 19:16:46.6518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aq2flMOH2ie9gbbRg6bY1H981xsn2pl1C6vlEL6DBhQqnX1McBH3iPf/YiqaOW4gC4+mwmF4PIS3iaj9iMb7YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8418

On 4/9/25 13:45, Borislav Petkov wrote:
> On Wed, Apr 09, 2025 at 11:07:49AM -0500, Tom Lendacky wrote:
>> So the vTPM driver wouldn't change, just snp_init_platform_device():
>>
>> 	if (snp_vmpl && platform_device_register(&tpm_svsm_device))
> 
> So this basically says that the SVSM is always sporting a vTPM emulation. But
> you can build the cocont-svsm thing without it AFAICT.
> 
> So I'm guessing Stefano's suggestion here might make more sense:
> 
> https://lore.kernel.org/r/o2u7p3wb64lcc4sziunr274hyubkgmspzdjcvihbpzkw6mkvpo@sjq3vi4y2qfl
> 
> considering it all...

That way works for me, too.

Thanks,
Tom


> 

