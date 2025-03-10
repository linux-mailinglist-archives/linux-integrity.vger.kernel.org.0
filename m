Return-Path: <linux-integrity+bounces-5205-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 321EFA59641
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Mar 2025 14:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3A6F3A649F
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Mar 2025 13:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86429229B23;
	Mon, 10 Mar 2025 13:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NTDBsaKZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD8E22A4DB;
	Mon, 10 Mar 2025 13:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741613264; cv=fail; b=Q1oT+VmzGmvFjpfb6n2TNkioMquhVZrBQgpQWKF9oXUyeecHh+rIVa9vcXwnm2vApqqZcKEO3L2auAIrBbqG9b8GNHJzz0Uy30pHXBU0SAEeGkC1eVR0lwrAb1ylACzLnmutTW5mOuJCWZJu44VNExaoRe3G6PjNU02Ed4RAous=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741613264; c=relaxed/simple;
	bh=kfNVjTNvV1XvDQmYYAxF4MR3rNysNeg4Yk4Q8r3m0wU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kkGGsNGDKaT+lboMNKSTyM3DXn4GNRhH458QKmU7f79MLbfFQVON6UP9a9wzdC7bGXV9fTEYKFC5poUfO60VPRmaitJkoZCt1OvC9MKaiZp0BySo37EYM7HjfWKIz3gsZz1kRBCioJgBcKDmb4mjcUZ5Z/E0BuW+11NcBuEbzPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NTDBsaKZ; arc=fail smtp.client-ip=40.107.95.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wHEckpKLiAVminy9rk5euSsg+t83O4dHa9EG3Jd0kudo3mEKX7sU7FQpwyfPe4pgMJ2Abn9iZBLlAdIPvz/S7NFSHiXHIAH69onWkpSvPFnfx/BNh24oowxehWjMUFs4Z5tlc1a9MFbvA6bJMAXdOIdmlaRcppz7ctlMads98ikZOWKjYYwUmpfarG57wGxBvtcrRyXBhgz98uLb72XT5efDpv05AvsJ3M2+9Kxi8Pow42NJgrrVj6jseyqZdxEAzoyqLpMxIiBcVLo2BXZaCFqaGqaEXhJiV2rXbZaGIn9hZgir9KxWK8qt7HmDZnFdu+n/WGcXRbKIEpEaPotq1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXcIojixJ/VXREJrG38wOq1fdII/8f9clnPdi5vFDW8=;
 b=vT1ZJBak4J7eAiIgQjiZpe8F9w+k1LcSeLM792v32MZag5k5krXyHv95Kmh967wa+fSHNEDNQK43QKvfgsySYhI409g9lIcpFf9odfyqZxN3UGxOGI573YRuv/+EJEHejOx/8Ku6dUaQfC7YsrtW/XVVtyM0K+0rD4PFBWEVJBoBKm5mFt41dhCmY2d43b58KEpA2km02zuPPDxSMmr9sdhR+PeseLiEQ9+SmoJPhgQiSxLK/5teMH7XLWlvGyXJS7gt2QL+H0T1XUyUNYjr5txy/S37KYeMfxOtlQnw0OolFzCWp4xtGDZCjPgwa5fBwEyyTOW/1PI7NPBwRxgC9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXcIojixJ/VXREJrG38wOq1fdII/8f9clnPdi5vFDW8=;
 b=NTDBsaKZVVi0bJIdrSwbKlukjkxt8RpZ0cugDXakoxZHHO3BFwe3LrG366Tp+UGJ4ufaYlnEtDSiDyUb5KrwBwMfROnXuRtfbgQMHjmgloWLUBMm+Mi4MvdQY/+BuJv07GUnHDRhifFt0C07T8qf1NAkCfKik9D5iwBwLsh4zxQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5062.namprd12.prod.outlook.com (2603:10b6:208:313::6)
 by DS0PR12MB6415.namprd12.prod.outlook.com (2603:10b6:8:cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 13:27:40 +0000
Received: from BL1PR12MB5062.namprd12.prod.outlook.com
 ([fe80::fe03:ef1f:3fee:9d4a]) by BL1PR12MB5062.namprd12.prod.outlook.com
 ([fe80::fe03:ef1f:3fee:9d4a%5]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 13:27:40 +0000
Message-ID: <3dd645f2-476a-d0d5-c8c1-c87307f2d756@amd.com>
Date: Mon, 10 Mar 2025 08:27:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2 2/6] x86/sev: add SVSM vTPM probe/send_command
 functions
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Claudio Carvalho <cclaudio@linux.ibm.com>,
 Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org,
 Dov Murik <dovmurik@linux.ibm.com>, linux-coco@lists.linux.dev,
 Dionna Glaze <dionnaglaze@google.com>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
 Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250228170720.144739-3-sgarzare@redhat.com>
 <20250310113006.GFZ87NPu-LgFVVtsEG@fat_crate.local>
 <mjftygohmhgs6daqvgkh2jbfuqjquchcaovcjtnzyhilnt5ww5@l3fr7phqh2ps>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <mjftygohmhgs6daqvgkh2jbfuqjquchcaovcjtnzyhilnt5ww5@l3fr7phqh2ps>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR08CA0023.namprd08.prod.outlook.com
 (2603:10b6:408:142::17) To BL1PR12MB5062.namprd12.prod.outlook.com
 (2603:10b6:208:313::6)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5062:EE_|DS0PR12MB6415:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f80e1fb-f531-40e1-1991-08dd5fd754ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2JnV1dVSENmVytxUDRsMXJqU2Iwa2pYeGlZMENnMHlpbjNDWGpjazd3anlw?=
 =?utf-8?B?UjVlZlc2cXlNakh0d0JmUHZyQ3Zra2MrRHd5T3pidnhHSUtMay94RmM0Vlky?=
 =?utf-8?B?VlV4cGJEcDVjajhnOU9weEE5ZHIwZVA4UWhIZVptWmp6SGt2aXcwZ2pLNzdV?=
 =?utf-8?B?MmYzZ0tiVzFFb01KclJnU2VvaTljemtsZ2cxUkQ1ZHMvUnRucm5QS05qMjgz?=
 =?utf-8?B?NWl0ZldaUkU5THd4SDIzd3dxbEYxQnVLMUJrZHBNYlo1VlByQmZKZ2VVZkQ5?=
 =?utf-8?B?cGNqbXhFRDMxWnZacDlpWDdZUGNGVjZoOVpjME5RcDdNV3UzbFZwdlJhd2Q5?=
 =?utf-8?B?YTQ2bzNQbkg4N21OeWFXZTVCYlpJOUsrbXYyeU5MVE8vbW9NWkw2YmZma1M1?=
 =?utf-8?B?NS8vbkRCVktTcS96ZXZBN2hEZ2dtSTVtVFY2aTVIVytZMjhob283bFhzdi8w?=
 =?utf-8?B?REhXR1NxWjErTHc3T2NqL1BHVjIwMEV0L2srMWlZVGlJeUVlT0l4OG8zVFlz?=
 =?utf-8?B?WXJrODRBUTVwYzdiL2FmY3daS2NOYzl2MHJCVDM5TGszWHNJTTM1VHdhTHlW?=
 =?utf-8?B?c29LcEpBUEtUbk1ZODkzak4zaU00OWtNWW0wcTFIL0tXZytJNStvSDJ6ajFG?=
 =?utf-8?B?bllLVHdzR1p5cExycGVJaFpsWEJRL2RKakp2SitpUHM2dTd6Si9lL1EyN2JL?=
 =?utf-8?B?SUVjQkZnSm5zNVRBYUZDaWJPVnJPSnRkNmNpanpPREU4ZWxaZEFYNmdOaWJD?=
 =?utf-8?B?RGlSNHJNc016aE8yb2VwbGJKTkNzbjNvKy9GTXlpbTFtOVZDQmZZZkgveUdo?=
 =?utf-8?B?N2xaU2paeTlHYXZGNGc1UkZKUy9xb1ljQ1NjanU5MXBpM1A4bkpiWEZPcHN6?=
 =?utf-8?B?ZDBvazdxZEQ2VGJkMm0xRFlmTFBUUk8zd2ZhbTNMdU9CNXF3bEViaTdQQ1By?=
 =?utf-8?B?RFBETFVnZUNKZm1yeWlKN1QwMHVVVW1mREpBR2pnaWtjTUthMjJmZDJKNzh6?=
 =?utf-8?B?QXRkNWM2K2tyOEZDdU96eHpxanNGOU9jWDhQRUx2bzQ5K1VhYlRyaDgyZEln?=
 =?utf-8?B?SjJmd2dkS0V2QkN1SXhwdmVVc3BGcXZnNnZKUlNsdGhBaFZUcWdUNDdWSE1l?=
 =?utf-8?B?V2VBdm1vSVdaM21LMCszc0wrNTFrMW9ubzVRSVJBOUp5MmJsWnFjbDNiTnVL?=
 =?utf-8?B?Y1dTZ2lkdHdnYkN0ZGRMcXdqWSsyYUhaNEZDUVpPSEN2ZnhkQ2M3Rmg5Vmpl?=
 =?utf-8?B?TGNvVkV6dTVqc0QwZ1RzenVJNk9HTElFdFNCRlpsUTI5azN5ZGlyNGxtc2Uw?=
 =?utf-8?B?TytxTUoyNFRXU014YzJMMlk1ZnFtL0FDQnE4ZUg1Z0dubmRtakhuNHhaVXN4?=
 =?utf-8?B?eXlHTk1CWUVVUGtxaHNUVGdPdUFUR1paVmRpUnVrVUNnYW42NjEvOUsvR2k4?=
 =?utf-8?B?NXFsTTd5Q3BJeHBZRHlPUkt0eWdGVjNpL3psM2VoRlZoYmtiVGdUaTlZY2Jj?=
 =?utf-8?B?R29zWVd5VVBmNTRidHEvVHJxS1JhU2IrbWJ6Q3RYYWM4SXVsanZscjd1QVpi?=
 =?utf-8?B?SVlqMklIYTRubVBpN0pjSG15eE5MYjRQcUVsYXRNNHhWL05VVXhsMmorSmgw?=
 =?utf-8?B?RnRaK0lnWnF0bGRYMWgvNk9vd0hlWDl2eXpZWWdUWEQrbzhKaFhKYzZqb2Vi?=
 =?utf-8?B?cC8vdmxOQzN2ZkR3RE1MaGoyQWtqQk5SWC9qL0ZlM0RqMHR3djNTR3hPU0xV?=
 =?utf-8?B?c0NZbHA1ayt3d0FUYjVIeVIzN0JsUWJ1ZlBtaEpYWDJzTklMczBqZTVFb215?=
 =?utf-8?B?RWJiUy9vc2NTOCtvM1Mxc0lQdjMyRVpERXlUQmdFSTFnZUhjTW5ESVVESkVH?=
 =?utf-8?Q?G40CsoNzpq3jj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5062.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0YzRjJsamoraGdxaklUQmJNMkdueFFFSjY2YkhXSVRZTzZmNUd3QUY4eEhO?=
 =?utf-8?B?SWtTQzlTdlF0Q2pxTzBuTHduT0x0d0laVUlzTFRrM1lvZ3FxcmsvMmxMR1NB?=
 =?utf-8?B?YWVzdGdUUmhWVmVVL0s5eHE1U3JrVnAwVnFpLytDcDRNTWI0T1ZiSUptb1FV?=
 =?utf-8?B?OGhMMHpnTmpJUXJ4YVEvZm1IcngzU3VycnBXM1h4aEZNL2V0QkRleW4weHRQ?=
 =?utf-8?B?emJpcTRFZ2VwREF3dmIvbDhwdXY5c2hTV0NWL29xQ1JvNDAvdjBWM3dJWHhH?=
 =?utf-8?B?TThPaE8yK0E1WG5aRGhMVnUwTUNpZnovN2sxaEFlaThxYUY0RVlwT0MzK3VE?=
 =?utf-8?B?MlFRcHV4VXVlakwxbEd6VGtsTHZRcUpxR3JYWndBRjhEOURnTzg5U3pmVG8w?=
 =?utf-8?B?NEZOaGUyQ1k2ak81OHM0ZVFHbCtScEwyRjl4S3lLTHRtZmc4SFprcFdXczJ5?=
 =?utf-8?B?WVluZjlpNUF0V2VYaElZMUpDTUlFMDdLM25NNWdXNzF6SnRvU3hIMFVMZFUr?=
 =?utf-8?B?Q0hzbm1KSFl3ZnFJSnJhZGlkNU1uQU1QWDcvTHIxN1R5Wi9mcVRtd2g4cnpw?=
 =?utf-8?B?WWNjeWNWdmhzRjZBRCtaQWZNRVVETy9hRzFhaGV0cHJGcUU4d244bzlaR25t?=
 =?utf-8?B?VkxsTzJUeC9EaEd3bDJjcVUrZVowZVEvOExTRlpsdTZydDBUN2RHaEJueUJu?=
 =?utf-8?B?dE4vYlVocmhrQnljNkJaQmgyeXo2K0ROVzRvNWZnV2dqR1V2Q0l5Wi9POFlR?=
 =?utf-8?B?eklJSGNSSlM1dkE0dlM3cWVnMzlsT2JSWFkwcWd1NCt3L3RUbjNjL2l2ZG5P?=
 =?utf-8?B?UEhENXRuT016cDdwUkNNbXowUFlqWVluZlFxZVUvTUY1bFlrVzY1eXdxbUZW?=
 =?utf-8?B?KzU5N1lmUG9xR21TSDV0UzJBT3B6ckpNNjdpNU1rLzAwaE9aMlBRT0dRc3da?=
 =?utf-8?B?NGRuZWhGSVFCZ2Y2TUhvSTJvNGR6eUQvVnVPRjhZRHZaSm5VZ1pzbEJyTTZ2?=
 =?utf-8?B?WTcrczlMc1llZmFobGpEQVVLT1FqTzVucUVuc3JkdWZoTkt6SUZVUlVBR1FN?=
 =?utf-8?B?cWxQaDIwbitlRmxJa2d2THRUYUxjcGUxSWFQelFMY25vdUh4QkRVSlg2WkFC?=
 =?utf-8?B?UTVoZ1NpVlVwR1FzS1VIMXZ3MVlMQ2NSVXI2MGx6VjJHVkVMSHp5UlZrdzRW?=
 =?utf-8?B?Rm1kK2JCSGw5ZWRRM01QdkhPQXRIUHpBN3lJRE1sN2ZsSmVUcFBaVTBNdGp1?=
 =?utf-8?B?OTlPNnMwRUMxVHc0TkZTSmt5QmhDVkJoVXFXS0ZnckU3RjhJeHplY2tWWlly?=
 =?utf-8?B?anpiK09yeFpRQk1uN1BGdmZEb0FKdzVKbXdORWR4ay8zZTd3QWVLNGloZlo3?=
 =?utf-8?B?U04wOXZmV3ZSbjZlcm5QN1FmeFhhbFVTVEFxaEw4NUE4Ukg2cUJHalVERnBj?=
 =?utf-8?B?RXlscm1aMkpGQ2lVdzgzS2hJWlhXTFE1RlMzalFRQkZobkg0SzIrbXUyV2FB?=
 =?utf-8?B?Smd2aFNlbU8xRE5qbnFLREVJU3ZmbW9zUEY0bHIxTnJjc01WNUFpcVdLZDhI?=
 =?utf-8?B?N014SmhBYnZVenZSQUZySXA0U252Q0Q4bmdYNHcxQWtZN0kvNWhFRENoY1FT?=
 =?utf-8?B?TWY3ZHZ4Um5pSWF3Y2hMWng5Z0pJS25BaS9Rdkxub2tzUlpYWEJVN1g1ODdm?=
 =?utf-8?B?VWViRzVIYU5CYVhvODZJbURDSFQwVktsQU92VW9FYmlNL1ZZeEhveWp6VW9Z?=
 =?utf-8?B?ZnFoZDRpM2h4RzdLMUlPTEQxUk56M0Zpb0lrWkdqMjZVelJoZkVrU1o3ejBC?=
 =?utf-8?B?ZlZoSk1YbDZ5UmRPaUtzNE9INWZyRTZBOTFUY1NtcnlCSXkzZEhpTDRZZUZI?=
 =?utf-8?B?TnlRUy9JdFZvbDB2bndPRkFnVml4ZTZRMTlGbHkxWmt2WUJhdDl4NG9VV3Iw?=
 =?utf-8?B?SVVvamErbnJ4cElQK1Y5MjdlWkhKeTR4eHBSdmdrUDFJNmdhWTBjbDljV0VL?=
 =?utf-8?B?UEdDYVZId0RvOTQyVjVRNzZMTnB6aVl5QnJKTStKb0xXc00zVUFTVTJSM2Rv?=
 =?utf-8?B?TVduNUdFNDNhd0swN1YreUk5VTRKNnI1clE2MW1MUWdLZm4yeVovMEx2WWo4?=
 =?utf-8?Q?4BgIDa5sxDg8HMHRq7rz3ngIZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f80e1fb-f531-40e1-1991-08dd5fd754ce
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5062.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 13:27:40.3295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kyuzf9mSRbYHS49RDiZh9RmVK/R1IxicZz5FkWPeAVNamzgTxhU5NpdmSQEI/uuxFQ0crBzv+yNeE5JNHWpFng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6415

On 3/10/25 07:46, Stefano Garzarella wrote:
> On Mon, Mar 10, 2025 at 12:30:06PM +0100, Borislav Petkov wrote:
>> On Fri, Feb 28, 2025 at 06:07:16PM +0100, Stefano Garzarella wrote:
>>> +bool snp_svsm_vtpm_probe(void)
>>> +{
>>> +    struct svsm_call call = {};
>>> +    u64 send_cmd_mask = 0;
>>> +    u64 platform_cmds;
>>> +    u64 features;
>>> +    int ret;
>>> +
>>> +    /* The vTPM device is available only if we have a SVSM */
>>
>> s/if we have a SVSM/if an SVSM is present/
>>
>>> +    if (!snp_vmpl)
>>> +        return false;
>>> +
>>> +    call.caa = svsm_get_caa();
>>> +    call.rax = SVSM_VTPM_CALL(SVSM_VTPM_QUERY);
>>> +
>>> +    ret = svsm_perform_call_protocol(&call);
>>> +
>>
>>
>> ^ Superfluous newline.
>>
>>> +    if (ret != SVSM_SUCCESS)
>>> +        return false;
>>> +
>>> +    features = call.rdx_out;
>>> +    platform_cmds = call.rcx_out;
>>> +
>>> +    /* No feature supported, it should be zero */
>>> +    if (features)
>>> +        pr_warn("SNP SVSM vTPM unsupported features: 0x%llx\n",
>>> +            features);
>>
>> So
>>
>>     return false;
>>
>> here?
> 
> In v1 we had that, but Tom Lendacky suggested to remove it:
> https://lore.kernel.org/linux-integrity/4valfkw7wtx3fpdv2qbymzggcu7mp4mhkd65j5q7zncs2dzorc@jjjevuwfchgl/
> 
> IIUC the features are supposed to be additive, so Tom's point was to
> avoid that in the future SVSM will supports new features and this driver
> stops working, when it could, just without using the new features.
> 
> I added a warning just to be aware of new features, but I can remove it.

I don't think anything needs to be checked or printed. If you want to do
anything, just issue a pr_info() with the features value (and maybe the
platform_cmds value, too). Issuing a pr_warn() here would be like
issuing a pr_warn() for a new CPUID value that the current kernel
doesn't know about.

Thanks,
Tom

> 
>>
>>> +
>>> +    /* TPM_SEND_COMMAND - platform command 8 */
>>> +    send_cmd_mask = 1 << 8;
>>
>>     BIT_ULL(8);
>>
>>> +
>>> +    return (platform_cmds & send_cmd_mask) == send_cmd_mask;
>>> +}
>>> +EXPORT_SYMBOL_GPL(snp_svsm_vtpm_probe);
>>> +
>>> +int snp_svsm_vtpm_send_command(u8 *buffer)
>>> +{
>>> +    struct svsm_call call = {};
>>> +
>>> +    call.caa = svsm_get_caa();
>>> +    call.rax = SVSM_VTPM_CALL(SVSM_VTPM_CMD);
>>> +    call.rcx = __pa(buffer);
>>> +
>>> +    return svsm_perform_call_protocol(&call);
>>> +}
>>
>> In any case, you can zap all those local vars, use comments instead
>> and slim
>> down the function, diff ontop:
> 
> Thanks for the diff, I'll apply it except, for now, the return in the
> feature check which is still not clear to me (I think I get Tom's point,
> but I would like confirmation from both of you).
> 
> Thanks,
> Stefano
> 
>>
>> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
>> index 3902af4b1385..6d7e97c1f567 100644
>> --- a/arch/x86/coco/sev/core.c
>> +++ b/arch/x86/coco/sev/core.c
>> @@ -2631,12 +2631,9 @@ static int snp_issue_guest_request(struct
>> snp_guest_req *req, struct snp_req_dat
>> bool snp_svsm_vtpm_probe(void)
>> {
>>     struct svsm_call call = {};
>> -    u64 send_cmd_mask = 0;
>> -    u64 platform_cmds;
>> -    u64 features;
>>     int ret;
>>
>> -    /* The vTPM device is available only if we have a SVSM */
>> +    /* The vTPM device is available only if a SVSM is present */
>>     if (!snp_vmpl)
>>         return false;
>>
>> @@ -2644,22 +2641,17 @@ bool snp_svsm_vtpm_probe(void)
>>     call.rax = SVSM_VTPM_CALL(SVSM_VTPM_QUERY);
>>
>>     ret = svsm_perform_call_protocol(&call);
>> -
>>     if (ret != SVSM_SUCCESS)
>>         return false;
>>
>> -    features = call.rdx_out;
>> -    platform_cmds = call.rcx_out;
>> -
>>     /* No feature supported, it should be zero */
>> -    if (features)
>> -        pr_warn("SNP SVSM vTPM unsupported features: 0x%llx\n",
>> -            features);
>> -
>> -    /* TPM_SEND_COMMAND - platform command 8 */
>> -    send_cmd_mask = 1 << 8;
>> +    if (call.rdx_out) {
>> +        pr_warn("SNP SVSM vTPM unsupported features: 0x%llx\n",
>> call.rdx_out);
>> +        return false;
>> +    }
>>
>> -    return (platform_cmds & send_cmd_mask) == send_cmd_mask;
>> +    /* Check platform commands is TPM_SEND_COMMAND - platform command
>> 8 */
>> +    return (call.rcx_out & BIT_ULL(8)) == BIT_ULL(8);
>> }
>> EXPORT_SYMBOL_GPL(snp_svsm_vtpm_probe);
>>
>>
>> -- 
>> Regards/Gruss,
>>    Boris.
>>
>> https://people.kernel.org/tglx/notes-about-netiquette
>>
> 

