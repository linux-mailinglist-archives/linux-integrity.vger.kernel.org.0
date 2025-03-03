Return-Path: <linux-integrity+bounces-5042-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53432A4C35C
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Mar 2025 15:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6710816BD7F
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Mar 2025 14:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3560A212B07;
	Mon,  3 Mar 2025 14:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U9daH1X6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2050.outbound.protection.outlook.com [40.107.212.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4CD2B9AA;
	Mon,  3 Mar 2025 14:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741012132; cv=fail; b=Wk85wkT8NmVjGO076vbeRFhCIZlCxys9FK0OT0276XE/AADD9VtDi9UCRgCPLig9hS9PfZdX+YFhfw69cFdk1Z1pQzoAb4KwXQPnU9OhGFnUHGXl7dHsqZsS15hCOkrrg20p5uL1nFYgByHUHx3ciYbdf604ksgnBqS8QFgo/2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741012132; c=relaxed/simple;
	bh=T6dr6lcm/f7hIMcvlf057PVesRA7FZndmHthDd+9yOU=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=pvF1a48sVpBpPBjbvtM7ctzJJ9hPzKa1LHbcl/9HBgek0AbL0f42qXGAjoeiHhakzG8/V5LpSUjUhwwIZaqGw3bBLsEAQsJAzIXDLJ3eKNZgOklR466ecARP67orBm3DrPyO2dzwMDtCsuODUTepG8MKt6MTEOMf26TuvXX/OEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U9daH1X6; arc=fail smtp.client-ip=40.107.212.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wy2Qs5os+8xawIeDpHCV5l60plS/VQ86qwSXY/VaE2TFY8V3DLP+YF9AqQBM2roiaD3oBg19ed54FTRoHBGIKxVRDal/ubvheXXul+o664kilatMNFIuVZ2NZpxM4p3O90eWnS9StkMcADjrUHEeanJ2yAGFQrIq7rXwnEzWYCi7d0Ebn2SiqjaCY/IXVGMSSPJplVSaR7+/Q/mbNS9KJGJm21KWo5UiyXpTQyBHd18WBogBwk1TLboi17WA77QVVBJ1LHUrjTT8ortwYQvgTGHgvZwa7rYsysONKcIxfO3WcixxyWbv66q1Z9x4UhwGJ30sbnNiYtwkkx26YJpgow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TirtGI3/bGjHLic+cuJvUpuQp6fimqcL5Nupv1buS/0=;
 b=PasiwPKwghqnNJ49qUM6J0pRJS7qRILGMGH5AIEswyCEHg7OnIn+fg8kBL+ju4nsYSfLX/7HX0lR6DJ9+kG32rR+WjYuUQJjmBOvE/V4OgZ50DYqPsSKHu1lVRDaSt8bI+QtKjmk4rezOSgYByWvqq7ppWuaTp0bV7J7icD715Qol2tcH+MG8V3B2LMYGtzvcJaRGquEJqyqpUOeIx8O/91CuJG6bI4rNUE/kYInlfsx7T5CD2U16mVVAwDKtMO6eByVnxDK4tVdu4tysmApY9rCezi0oXSzhy53xyH39maTBPOP7ZSSO+/GW8+091CBA83t5GZda2NU9JhIQXlT2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TirtGI3/bGjHLic+cuJvUpuQp6fimqcL5Nupv1buS/0=;
 b=U9daH1X6imOnzsPXFd6bsRNeKsuQ6ZG254psKVRlMpcupl2tFFKWz8ULCAwMIWRvcU/W0kUtBZGAug57NDc4t+87a6G0TgpG86c43d3dUuUXneGjEad20Sz9Me5AUjSxc12Tew2kD6P7+QLIxT9px8WYSS4WROpbS7Ie+yGznis=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by LV8PR12MB9262.namprd12.prod.outlook.com (2603:10b6:408:1e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 14:28:48 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%7]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 14:28:47 +0000
Message-ID: <d50d9d6e-10e4-23e8-a584-df28a1c41e86@amd.com>
Date: Mon, 3 Mar 2025 08:28:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
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
 <20250228170720.144739-5-sgarzare@redhat.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFC PATCH v2 4/6] tpm: add interface to interact with devices
 based on TCG Simulator
In-Reply-To: <20250228170720.144739-5-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0104.namprd13.prod.outlook.com
 (2603:10b6:806:24::19) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|LV8PR12MB9262:EE_
X-MS-Office365-Filtering-Correlation-Id: 2da39aa3-af94-45b1-85d8-08dd5a5fb5eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVI0SGZGUWFDZUJCWk0yK21PVXljREdkT25YUVRyR3RWQkIrQ010eWN1eGcy?=
 =?utf-8?B?RkFyS2lRNVV3TytGVTJTODFuMENDVEUzbENwbWtKa0R5aTEzSnRhQUlMY2ox?=
 =?utf-8?B?OE5ENENTTCs1N2ptNWdRK2VUR0htQ29QWndrclI2aGRYcFhYMEVmb21pQVg2?=
 =?utf-8?B?QnZHbjlBSzhoMUp3T0k1dEE5M3N2enIwUHhZZWZjUlV2Z2ZYMkQycFhqeVNx?=
 =?utf-8?B?L3VMKzA5VUNuRHV3RW5BVkV3WERZMkFoN2krRVVLS3dBZUQwdHpZdEFGTjc4?=
 =?utf-8?B?Um8xU21TVnEzeFVTRlkzNmNERXR4Wk9pMHZvV2pIYWFTNHdZcFhVMW9TZTgw?=
 =?utf-8?B?OWdEaktzVkVyNXgwSDBYVUo1TEkxN2QybjhnbzlRWUNRVGVTeXJVcERtOURo?=
 =?utf-8?B?TVVWVTI4TUw4MnNvbjI0MUxkdzluTHVSckppU3p6K3JWSWRVbUdjRHlRcUdP?=
 =?utf-8?B?R1ZJcWF1M09DM240Y2xVTklkSGlBNVVUOXZuOXErV0FOeldqREE2SXNqcWYy?=
 =?utf-8?B?QUU4dEJpQ3doTVZlU3VwaHhqcHBuYnZ4aGNEM0EvV01uYVJSV1Q3Rkx5YlFR?=
 =?utf-8?B?c2QwOVZkdjhZa1hxU0tLMjJJcEc2V1lESDhvdjZ4MTRzbjRuNXNvY2RiTS9D?=
 =?utf-8?B?Z2syR1VhNG4zcUJ1bUxNWUh2aW1vcWVOd2V3bHZmemNMRmd4UlcxdXEvekg3?=
 =?utf-8?B?cGJRK1VYVzZHdG1YazczZGdjT29mNzJaaytJM1pDcUUyY1F3Z1htYmJPQUFn?=
 =?utf-8?B?U2FFdGhaVDdIUWpBeGxKd0xIdWJhNXdJUmRPZUw2MTN4ajhpb2t2TzVTY2Ra?=
 =?utf-8?B?MklCdGl2aXE5TU9VN0x0Si9xYjBsWEZWczdLUm5CTU96alRTZ0F4cjRKRWlN?=
 =?utf-8?B?RU5GZENlTUlKN2ZIU0tBd1hERVBFa1kyTmtrMDYydXJZRUZ6T1loNTMwdkZS?=
 =?utf-8?B?Ny9wT0ZYLzRNSytpWkFpTkRUUHhPUUdJNXBiVm1NVGlFSmIxUU0yejV1NFdj?=
 =?utf-8?B?WityNmZaWXRjVXA4TFMwWnJnZER3OWlCeG1KaXliT0lxenBUditsc3A1SFlE?=
 =?utf-8?B?cU5EL1ptT1h0SG9xU1A3U3Z6ZjF3TTBYZ2pQUGk4Mi8xaUp2ZXNCU3htYjl6?=
 =?utf-8?B?RjNmQjFQZGxqWnh3S0NSNmUxalJkaHdXQ2dILzhjRTJjQk13VGV3WjBQVEo3?=
 =?utf-8?B?LzVzSzRCS0Z1aEJnQldZNUROUmVRcnJhMzd4aGEwQU1BN0ZScHBUa3o2TzJv?=
 =?utf-8?B?ZHdtVHNmcUczYUk3NTVKUklTZnc2dHdYVktzWlM1Mkk5RkdPMHN3MEFHbnpW?=
 =?utf-8?B?Y0NVdHZPVUhRbXcxYXVLa1BpQUJDYkxuZGwvNHNoVUFGbXF2SDZ3ck1RVzFr?=
 =?utf-8?B?czM4a1hVaHcveHFNL3Rna2JjUXB0Y1d1QmcwTFhoaUw3T21WQzdKL0lBMHZN?=
 =?utf-8?B?ZlFidVJrYytuQzNDUzZaVmV1NFRjZjVkS0dBZGZoRTlqcWhsYUs3c0FyampL?=
 =?utf-8?B?N3dFWktiMlkxbzVEN3U2M3VackdxMjR4SG9FS3o1MzlzeFg3alVsYjF4QWtv?=
 =?utf-8?B?dmc4eE12QjRQc3BWL2hMWmVXODNGRi81YXphbndGVGU0TWczVHd2MTNUSVMx?=
 =?utf-8?B?U09JZEpHL3FnQ01OYnBxVFlHUXZLNVBHbGhhcnlRNG9lRm9SOGlRMDR0VE5z?=
 =?utf-8?B?VTJqQnRvY056K244NHR4VHc0UU9CZ3I5RkFZN1Fzb1VZVjBEY054ckpocFM2?=
 =?utf-8?B?SVp0c0M1em1QbzYxczVjZ1l3dFhUOFMrbHFQOUxOY1JFNkJXeEE4Nk8vWW5v?=
 =?utf-8?B?Rkk5RjNrbWZpN2xEalQ1KzhaRzVId1d4VDUrQitmS0dSeXNPbGo4Y2RjNURV?=
 =?utf-8?B?eit6YStGaWN5NTVqUDJLNytQWGlKdXEwRjc1L1VWajNmOWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3hJcERybHF0b2FKWkVpZjVPZ2VIZFF3TkxNSzR5M2dibXVGdkNaMjBzNVU5?=
 =?utf-8?B?alIwS0F4K3RMNmQ4M2p4bEJXbGo5RHBFZjJaMjBvdVJaOUU5SmlDQVlkWHZl?=
 =?utf-8?B?THh6MVdKa2p2dUVJRjZkM1ZzY0IyMnZTU3FRLzlxVEttWXhKMHZLUDR6ak1l?=
 =?utf-8?B?aXVtRVEvMWdnbG9zVGJXblc4Znh4NHExaVNVaUpGRUIwbTBnMUc1eWJZRUxB?=
 =?utf-8?B?VWI5UklucGNQZHJLTzJ5Vy9CZnBTazRaY0VkUVRGaTZudFUzcSt2YUc3WFhi?=
 =?utf-8?B?UkRoYlVTeTBPRyt6cFlPdFRqcWpSWit5ZGkvWFBHdTdpdXYwZUVtNi9BT3Az?=
 =?utf-8?B?dnlGM0RMRkRwazE0Wm41WEN6cnJTSTBrUDJDc1E3Um94bndzVFFycmV0eEhs?=
 =?utf-8?B?U1NSc0x0WXpGNTBNOTFGaDE1bUI1SmNaNGdpaHBPRzlmcGVDRnFhcks1SVUy?=
 =?utf-8?B?dWZmaWZmbnpVSlRuNXVJekI3N3ducCtia2JtcUpIdjBWbVhQQWJlRzRCQ3JZ?=
 =?utf-8?B?SGphT3dMMEtGeWNXZmhiVXQwb3VXZmJvcXBQNTF6Vk42b3IxdzBqRDZwTEFs?=
 =?utf-8?B?TE80OWFKd2lJK0dzYXhNRGMxSTR4QkNibE9yQUtoZkF4NW9NclBFN3F1bnNa?=
 =?utf-8?B?dFQyV3k3SnJDOHVmb3VXdXJyMXNwNitsYUp6K2c1d2piQTFBdU41dEppSXV0?=
 =?utf-8?B?d0tBOTl1c09pZHp0QmFOb1AzSmtDb1dkaDhYWC9wMkJtQTA2Mk42eTFSM0VD?=
 =?utf-8?B?ck92Y0pzaWE1dUJwL1NxM3ZzWGIyU09VM2ZwdkdTWDY1VUxCSncxMzJBbGg2?=
 =?utf-8?B?SnhtOUZ5TXZNelc4VXR2YmZOR3RKWFdrL0RGdkxUUWZKS2E2bVgrRUFMalcv?=
 =?utf-8?B?WmF2bjM2QnFuQU0vdUZiK0VkK0hkVjB6SCs1c0lQSXU2akZvSVRVTUQ1bzdZ?=
 =?utf-8?B?a2VhYWgwWVZqQlJscnIyUWx3ZVBJK3ZVUElBeWJ6RzRtaE0xQjdZaXNYeUs2?=
 =?utf-8?B?WnRtTmhCOWtmQ01KeURuM1BSM1NQTm5OVHhUUTZLb0p2a0FaTTZ5VXYyRzVV?=
 =?utf-8?B?M1VoeVVzYUVHdXhFam9vWS9wMTMrOFZwejFnMzJ5RG9tK2doRmc2WDRYU3Rw?=
 =?utf-8?B?VTZmMitIcDNqTjBCd2Y0OG90MDFIVFRrSnlGUUxCNVRYZnZSYTE2VXpEdW5n?=
 =?utf-8?B?NHNPK1dVK1VlaDlIbzVrNzhWc21jc0oxbU5naDg3OENoeERzbS9mR1lUM2RI?=
 =?utf-8?B?Zmt1TkFJTnZmbWRKU1VUVzNKQ3RwL0dLdXNZaUppNTZaZTF0eDZpTmhkSVcx?=
 =?utf-8?B?ZjhQRXdkbGoxWDA1Z0lJNWI3Y3ZaQXYrdklkNVpiSzYvR0x1c0E2cno0b1Mr?=
 =?utf-8?B?Q1A0OWRvVUU0aHdkVGpSUUdUKzMzRTQ3YTcvM3djV1VDMmFqcmYwNUlQOUkw?=
 =?utf-8?B?RUZTNDl3ZFhuT3IrU0Z4T1RLQ2VFcWpFWlVOS1BpOVNGaTdkV1pVaHZDcVpR?=
 =?utf-8?B?Wko1ZDlpLzBRK1NBSHFRckQ1WmdwdDIrNXpGL0NkQnNVbHhzQVBnNThWcUM1?=
 =?utf-8?B?ZWZ6TU41RzRWMjdxaGRlQzJ1N2JLM2pNcmdBKzkwaHpaaXVpbWtkV04ydzVB?=
 =?utf-8?B?US9nWS9ZT2dDTlFFTThvbHhhTjFQcExIa0JMT3NHelh6Uk43V0kwenljUi9F?=
 =?utf-8?B?M1hGYzFQTHJjUTR1eFhLMHJEVGN1b2ttL0ZIc2VySE9nellPZ2Y5MUhUYVgr?=
 =?utf-8?B?YWIwVlFpbXgxL0hVRW9xclNybkd6d2pvUUJJTmpQR1FxNUtGMXdLa0Z3cVFF?=
 =?utf-8?B?SEJTL29GcCtlYjluVkI1TnFMYnBKSmVjSHRuemFFdjdQa3l2VTV1MUc5UHI2?=
 =?utf-8?B?OVhhRERiMDF4aXYxWmdXcEh6M2FDTzR0bzQ0cDBaWktBMXdaTDVRbGhWYTEr?=
 =?utf-8?B?SEdIa3dwWEEwZlF0SUJyZU9NbmFEck9CRVZEYjlVSTZhOUsxYUtabEVKTmZC?=
 =?utf-8?B?dzdYSXBLT3FPSEQ1aXAvL2hWbW9BMk9EdVFmT2E4S0xxRWIvdEpJVDJMQ1lF?=
 =?utf-8?B?alhMV28waFVONG5ZQUQ4UmtPczkyZnM1a0x2NmxMdlVVMHNUYnFxL3ZKZ3N1?=
 =?utf-8?Q?zzSUh/4nPh4yurbu3J5X+wmi0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da39aa3-af94-45b1-85d8-08dd5a5fb5eb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 14:28:47.8351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ToGvMP7nPCy0I+onVDDzvkQCW2uGp1qUaajVrMHMUa7MScB5w4WZSXBsOVUj3pMHLyaX2yJaO39GaSXeCjmwsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9262

On 2/28/25 11:07, Stefano Garzarella wrote:
> This is primarily designed to support an enlightened driver for the
> AMD SVSM based vTPM, but it could be used by any TPM driver which
> communicates with a TPM device implemented through the TCG TPM reference
> implementation (https://github.com/TrustedComputingGroup/TPM)
> 
> Co-developed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Co-developed-by: Claudio Carvalho <cclaudio@linux.ibm.com>
> Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> James, Claudio are you fine with the Cdb, Sob?
> The code is based to what was in the initial RFC, but I removed the
> tpm_platform module, moved some code in the header, changed some names,
> etc.
> For these reasons I reset the author but added C-o-b.
> Please, let me know if this is okay or if I need to do anything
> else (reset the author, etc.)
> ---
>  include/linux/tpm_tcgsim.h | 136 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 136 insertions(+)
>  create mode 100644 include/linux/tpm_tcgsim.h
> 
> diff --git a/include/linux/tpm_tcgsim.h b/include/linux/tpm_tcgsim.h
> new file mode 100644
> index 000000000000..bd5b123c393b
> --- /dev/null
> +++ b/include/linux/tpm_tcgsim.h
> @@ -0,0 +1,136 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2023 James.Bottomley@HansenPartnership.com
> + * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
> + *
> + * Generic interface usable by TPM drivers interacting with devices
> + * implemented through the TCG Simulator.
> + */
> +#ifndef _TPM_TCGSIM_H_
> +#define _TPM_TCGSIM_H_
> +
> +#include <linux/errno.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +
> +/*
> + * The current TCG Simulator TPM commands we support.  The complete list is
> + * in the TcpTpmProtocol header:
> + *
> + * https://github.com/TrustedComputingGroup/TPM/blob/main/TPMCmd/Simulator/include/TpmTcpProtocol.h
> + */
> +
> +#define TPM_SEND_COMMAND		8
> +#define TPM_SIGNAL_CANCEL_ON		9
> +#define TPM_SIGNAL_CANCEL_OFF		10
> +/*
> + * Any platform specific commands should be placed here and should start
> + * at 0x8000 to avoid clashes with the TCG Simulator protocol.  They should
> + * follow the same self describing buffer format below.
> + */
> +
> +#define TPM_TCGSIM_MAX_BUFFER		4096 /* max req/resp buffer size */
> +
> +/**
> + * struct tpm_req - generic request header for single word command
> + *
> + * @cmd:	The command to send
> + */
> +struct tpm_req {
> +	u32 cmd;
> +} __packed;
> +
> +/**
> + * struct tpm_resp - generic response header
> + *
> + * @size:	The response size (zero if nothing follows)
> + *
> + * Note: most TCG Simulator commands simply return zero here with no indication
> + * of success or failure.
> + */
> +struct tpm_resp {
> +	u32 size;
> +} __packed;
> +
> +/**
> + * struct tpm_send_cmd_req - Structure for a TPM_SEND_COMMAND request
> + *
> + * @hdr:	The request header whit the command (must be TPM_SEND_COMMAND)
> + * @locality:	The locality
> + * @inbuf_size:	The size of the input buffer following
> + * @inbuf:	A buffer of size inbuf_size
> + *
> + * Note that TCG Simulator expects @inbuf_size to be equal to the size of the
> + * specific TPM command, otherwise an TPM_RC_COMMAND_SIZE error is
> + * returned.
> + */
> +struct tpm_send_cmd_req {
> +	struct tpm_req hdr;
> +	u8 locality;
> +	u32 inbuf_size;
> +	u8 inbuf[];
> +} __packed;
> +
> +/**
> + * struct tpm_send_cmd_req - Structure for a TPM_SEND_COMMAND response
> + *
> + * @hdr:	The response header whit the following size
> + * @outbuf:	A buffer of size hdr.size
> + */
> +struct tpm_send_cmd_resp {
> +	struct tpm_resp hdr;
> +	u8 outbuf[];
> +} __packed;
> +
> +/**
> + * tpm_tcgsim_fill_send_cmd() - fill a struct tpm_send_cmd_req to be sent to the
> + * TCG Simulator.
> + * @req: The struct tpm_send_cmd_req to fill
> + * @locality: The locality
> + * @buf: The buffer from where to copy the payload of the command
> + * @len: The size of the buffer
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +static inline int
> +tpm_tcgsim_fill_send_cmd(struct tpm_send_cmd_req *req, u8 locality,
> +			 const u8 *buf, size_t len)
> +{
> +	if (len > TPM_TCGSIM_MAX_BUFFER - sizeof(*req))
> +		return -EINVAL;
> +
> +	req->hdr.cmd = TPM_SEND_COMMAND;
> +	req->locality = locality;
> +	req->inbuf_size = len;
> +
> +	memcpy(req->inbuf, buf, len);
> +
> +	return 0;
> +}
> +
> +/**
> + * tpm_tcgsim_parse_send_cmd() - Parse a struct tpm_send_cmd_resp received from
> + * the TCG Simulator
> + * @resp: The struct tpm_send_cmd_resp to parse
> + * @buf: The buffer where to copy the response
> + * @len: The size of the buffer
> + *
> + * Return: buffer size filled with the response on success, negative error
> + * code on failure.
> + */
> +static inline int
> +tpm_tcgsim_parse_send_cmd(const struct tpm_send_cmd_resp *resp, u8 *buf,
> +			  size_t len)

This is a confusing name... would tpm_tcgsim_parse_cmd_resp() be a
better name?

Thanks,
Tom

> +{
> +	if (len < resp->hdr.size)
> +		return -E2BIG;
> +
> +	if (resp->hdr.size > TPM_TCGSIM_MAX_BUFFER - sizeof(*resp))
> +		return -EINVAL;  // Invalid response from the platform TPM
> +
> +	memcpy(buf, resp->outbuf, resp->hdr.size);
> +
> +	return resp->hdr.size;
> +}
> +
> +#endif /* _TPM_TCGSIM_H_ */

