Return-Path: <linux-integrity+bounces-5288-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D45A616E5
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Mar 2025 17:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BED203BA6B3
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Mar 2025 16:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C003720408C;
	Fri, 14 Mar 2025 16:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J241nYhY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F95D18B494;
	Fri, 14 Mar 2025 16:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741971413; cv=fail; b=ZiOQ+078vFDAJmMbelrjRZrgoVSnQj6aHfG0HOHZagXE99Z1qJy4+dk+XH0VHNhNicyqrkmY89Rx1ChQ+hhBkDYP0tNO8svGjswtKXZ1toCMSQp5xyAv1hMwI48KriJtpY/LePnSOlDQVKAtgck4EyiUKgK1F31JP81yZ0HwAb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741971413; c=relaxed/simple;
	bh=3tthbKb4uywVS4kz9gQRZTEbYwT9UPBHNyIXaIPsVUs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pF4J42qzeMMnNqSGZ+wX5CplI5HgN9i2ptMp87R1AAagwN6JBumv1AmncmmY0UHZFty3EXeJKrB56ntyeUBpaBNgqQ1s9IPVNUlp4VTckXYmXnqL7hi97jPSWN4c94SClj0zeoiRaEAt6GNnMQ/90odf+qIMJoddtLzCyCvOuPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J241nYhY; arc=fail smtp.client-ip=40.107.100.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B2nhXGoLDs/472TZTcL4mMddM883pvuQruSZNY+5KJHEkFmL3pLbzlUmBBnikbqcXHjbzv76vxkUxPA1FgOrB9Z9MhGImUUyouHGrVA5bUAQopYx1etMLfUREeVRGZLVMir+1Ng02KvT/p8wu6kGRJci+GDL3yV8q5EyX+jggJ0AvpTRSeMtIMF6lDUshdAfJwJ32QxhkjxCrc3VpBDE9Jvtt7K3jae2BmFjNVIsqcqBbBj96yswlOJTbJHDCNTPQXN6Q0UysyqbsJrmY5SbXfp8n1M5I6PDnTsZSqfwbsn/TrjWXdCR3VO4TVo6a4Fo4nOAnqo0zGmZTT7DpR2oYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DsQJpYfKqbPNdcMUFfN6tXuh3XQDjLR3M6pJKOpuF7g=;
 b=UE7tyXPOUWhETiIwfEpe9nnjq/b2ROEl9bJCvaH3tcvS5UpwhxW45z1QyLdKtTNP1McenZzUc15G+myB41DvsCDV71IbfpysKFHlvlI9bvmzFhbkzW/E5LKsF8qO8i/cv6nxxeCzBF18QMMWCH2TUg9v2SCvTCj7RTxRpIU/RGSNI7m2vExA3NZcnHV97PrUgSehrnB6o8n6Fain8hFgwp9QyIXmNua/UTig9QU/PNLrqj3aI5rjr+GxN0UOe1Zf+xEtomNacmWj/j4lxVgPZSqoEkttHuKnUUzSRnvEYteqtua+bqmPD2KEBHoPCtmxxU0RWIDIPiBOZfmWNG1A1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsQJpYfKqbPNdcMUFfN6tXuh3XQDjLR3M6pJKOpuF7g=;
 b=J241nYhYN6yPsUcyH4vmNMFnPsaroZ5FVa8Z91UrqJJ/8u0hiJAWvPhWZbGKbg0NRMfLbGcor9FaZS+ICahX5FAAQVT3xgGevviP0xmpEWykKIxC9zf4AvHSD4mkdKDsP1LtIHQZ1T6977uTx2zCcvviMERMk2GcRhuskGicOWM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by CY8PR12MB7362.namprd12.prod.outlook.com (2603:10b6:930:52::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Fri, 14 Mar
 2025 16:56:48 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%4]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 16:56:48 +0000
Message-ID: <7c35f370-f1f2-7100-3b78-b595e977e964@amd.com>
Date: Fri, 14 Mar 2025 11:56:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 4/4] x86/sev: register tpm-svsm platform device
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 x86@kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov
 <bp@alien8.de>, linux-integrity@vger.kernel.org,
 Dov Murik <dovmurik@linux.ibm.com>, Dionna Glaze <dionnaglaze@google.com>,
 linux-coco@lists.linux.dev,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 Claudio Carvalho <cclaudio@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Joerg Roedel <jroedel@suse.de>
References: <20250311094225.35129-1-sgarzare@redhat.com>
 <20250311094225.35129-5-sgarzare@redhat.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20250311094225.35129-5-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0075.namprd04.prod.outlook.com
 (2603:10b6:805:f2::16) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|CY8PR12MB7362:EE_
X-MS-Office365-Filtering-Correlation-Id: fcc17ad0-455c-446f-3e8e-08dd631935f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0NoSURkTk82dXFDL0ZGVjdrUXIxdTdFT3oyRDN4Mlc2bWo3Z01hTlpwR1g2?=
 =?utf-8?B?MjFKVVczRkQ4OWU4SWI5NlZQblo0SUpmc0IzQzgwYVNXb2hwZjBFdEZEL0s5?=
 =?utf-8?B?ejNYSGVFYi9TZFZGYmtGRS84ekRlUGlvdThLN1VicHVOWkZ6SFJ5SlpwYjla?=
 =?utf-8?B?dHJZazRWMDZ6OWFyNTJOMEhWUmVVVXdlaDY2VDZ5citsMHdnM0dXUldzbVRJ?=
 =?utf-8?B?bEQwUzlvelM0ZGxZR3N5UzdsMmpKa0NMUWFHSjFhd1h6ODZzOU9OMjFieFJW?=
 =?utf-8?B?K0poZUlYVjNkY2YwUUhsTGFTaFlIR3dkMCtwNTlIeTFJSXp2TkRIUllSc2NW?=
 =?utf-8?B?NEdBTzVLSXhBcGlpMVkyV2hLeUhCU1hMM05iRHZMQ2grY25ydy8wS0N3bm1Z?=
 =?utf-8?B?ZUU1OE1IRVJkMlg5QlI1RHVlZzh0TjNDQ3NPMmJ3L1V6dG43OVlaSXhxT0Jt?=
 =?utf-8?B?R2VHM2hxYkEzcThka09ObTlqSVdDYVJxTVFEbFNnT1l1ME83a3ZxS3Y5Tzhy?=
 =?utf-8?B?RDRFS3B3OS9YZW4ra25aSjBoWVBWUnhXWFRpdjJYUU1zVGFFL01oS3hrSlpN?=
 =?utf-8?B?bWdVWER3Qy9tdnd1NEFvbnU3L0hBbXlPYkpmOU1XOVhFMGkxcE9TUm84UWs3?=
 =?utf-8?B?K1JoMHB5cExZZ2RSWTIrTWdKVnVmK3oyVFRib1o0VVBWOGlhMEVKZHphV1JP?=
 =?utf-8?B?eExFakdPcVMydGlPWkdiUTRldUN2bW5FOXV5aHcrbUR2dkNxZklBenRtcDhv?=
 =?utf-8?B?TmR5MnNlRkhUTG1pSTVDT0taVjQ2UE0xb3A5S1daWGxqYUVLMGk4VzE1YXpB?=
 =?utf-8?B?UEJVSW9jUGIrR3NsYjFDLzl6Q2EwYXNhNERpc3RNWE9wcktzSDJyODlUKzJV?=
 =?utf-8?B?K1dQSjhjNnFoVDR5dHo0Vm50aGh1NFN4KzZiV1hXcGNwakUzNHJsMjNmMmcz?=
 =?utf-8?B?Q0dFMmo0K1c0RCtoNmNXbGZ2RDh3bndMQ2FhemhiTUh5RGpvUE5oQklPNGwr?=
 =?utf-8?B?TjNXNzRXYnNpZStDMjBnVGRRVUNLM1JGdXBjWmJadzZDeWkybEIwOUxLcnVn?=
 =?utf-8?B?SlB2b0RmLzl1UVRTdG5yRnhKTUZFMmJoSDFkV1ZsekJ1bDR1ZDBjc2lpTzhM?=
 =?utf-8?B?UDBXZE9TQ0FtRksyYlRyY2RJOXhJd2JvNVlJTmlNNWlHV0pjTUxFZFlGeGNQ?=
 =?utf-8?B?OWk1L2JJcDI0aUh4WWk1amdiYnhGY1g1ZHZlOTJCVkNUL1FzbUNUcXdXNlJJ?=
 =?utf-8?B?VmZKNkFVbVVoMjRiamVPcllmQWY0Mk9FZ0R0dGh0MmRDZFdFZEVhdzNWVTNI?=
 =?utf-8?B?aEJKaXhpM2dEd1BEdFlrU1VROUQrNjg1R2ZvTGEydWcwclYvM2lESG4rL2Nj?=
 =?utf-8?B?TExGS0tjVll1a2pGWll6TXlpNWpGYnFHZElTR0lEbUVoUU8rQkRBWGhZY2Zp?=
 =?utf-8?B?WGZ3clhhdjc0aDRMWUZRYTZNWXBsSUYvSytWeHk2SFB3WDhISm5vdXNNR1do?=
 =?utf-8?B?QTM2aCt6N0hoNjlaNlBKdmZpMVpOd0oxRjd0UjNLTXJDbXduM3U3OTlGVHBV?=
 =?utf-8?B?eTV6NE0yRGZOc2NobDl4bS9kM3NaY250NE1rTldYZkFLMG83L3owTFBLSEVi?=
 =?utf-8?B?ZWRSaHdVaFQ2U0x2NXdVQjhPUHV4dEo5bno0UEIzYnBTRDF2VzRtL0RRMkJM?=
 =?utf-8?B?Z0hPeURxU1FhNStEK093Z2ZjbTV4WHJ0cGxBTTdxYkpCQXh2N3A2UGFjS2NP?=
 =?utf-8?B?VzgrNVROcVhvUm1PSCt5QWgvT3NjdFJuUkZLSXhuaTNkdnNHR1dMdy81dUJq?=
 =?utf-8?B?eGpkOUtyZCtwWFVWbU1HSjE2SDVwQjlNT241dUNNTlUyWTFPWnV0UWZ1RFFE?=
 =?utf-8?Q?2cBEqu8WZZvSA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVJJY010OTgzMEhVVnUvanRrQU13dGpYcUFTQ0NLdFUwd2o2TDl4MnNuczRa?=
 =?utf-8?B?dTEzeGdIYU9YSitHZ1YreG5oSTNOS2FENm16bzNqVWhQdHpoeFlVYkd1V3BG?=
 =?utf-8?B?L1pTRHprWUptUnFpOTc2MkNTSGFZb3Y3bFA4eGlIam5SMmRuc0I3QkFHQkpI?=
 =?utf-8?B?MjZuMkRPc045dGROejlQcks5QUthQVUrenpwUVo3ZlJab25ZY3RhbWpVbWhw?=
 =?utf-8?B?OE9MaDVnMnR1Ujl6YkltLzRqUUVZTWNzazVacEkyM1gxTnJORkJoRjh5UlRG?=
 =?utf-8?B?Tjd2ZGxrbmxXVWlPQjI3ZThkNm5LaVRKS0tzY1ArT0c2RGF5a08ydVY2anFV?=
 =?utf-8?B?dHF0TEF1VFgwQmZRTysyOGJJZWorVVpwMU8vUGdRWFpNRmtxNFFWbjlvTEZo?=
 =?utf-8?B?MWFYR3N4VEFLbmU3QVoyWTlZREU3Y2VySW52aVdpcXJMZnVCWjJsTUIxSWl2?=
 =?utf-8?B?b2wxYTBJRnNlaUJMT3pzVEc0d0tRUTlFdm40NmE5RnZ4RzFoNDlCQjh5WGI5?=
 =?utf-8?B?bmZad2g3ZVJlWDBobmdQM2lTZ1VLSWVCRDRSbGpYSks0K3hSNGtoNWN5TGxv?=
 =?utf-8?B?SW0zd1luRTFGejkrVzNEQ1p5TjQ2QWwzNE1IUC9QTnMySlhjYW5JbDlvQXNh?=
 =?utf-8?B?VVdUWUNnZ0I3U0RDWUlNUVJJeU1JK0ZZclk3YmIyVldUL0hkaXZqa3BhS0xU?=
 =?utf-8?B?bDJ6OW53UzZjdDNOeUpiN09iSmtkdHU1VW5VOTk2b0IzZ0lUNCtRV09LSFl6?=
 =?utf-8?B?enM0b2xKeDhEMS8xanhsa292Z09qdnB3aVQrMFg2Q1prV2F4K2pMU1FVa0FD?=
 =?utf-8?B?WFh4eFZwRlNMUStoMnpwb2NoZmtDNzdBc1N0b3ErQnFmT1U4bWUvT1dlbEVw?=
 =?utf-8?B?VSt0TTJ6T2kyRk1uakxOYWxzUHdueFBuRjJsRzhEeWRISHhic1JoeW1MTFJT?=
 =?utf-8?B?aFVFVGNsdVhrckVTTnBzV2I3Q1FROU9CRGpHYmsvOFZTK2Q0cXNCZEZsOXp5?=
 =?utf-8?B?eFlBSWIxdDFnWjkxdHI4ZzQ0OEdLTjZYWVRablhGdUJ2bGI5SVVUdUx1ekVH?=
 =?utf-8?B?eDFTeC9DMHZZVTZYNDhmdUR0MVBlYVpwUmRkZC9tcHBMQmplSDVoMFFHczUy?=
 =?utf-8?B?aG13V2IyWENQYVhDZlM1QnU3T2JUN2ZEc1FIc09EZ2RlQkVxcE1pSU9OYmhC?=
 =?utf-8?B?bzllMzNZS3lvLzZZWDl4eTl1SFBwaDdtOTRhRDhsS0x1dmx4ZFI4VEdUektQ?=
 =?utf-8?B?Z2hmeE12aFVDMDY5RmhCbDI1c2dWdXdqSjE2K0dIUHdITGNOV29ia2lDZjRW?=
 =?utf-8?B?NkJpbmhjR09wbEZQNjc2c0QvUjM1elhGdndxZXBLMEsveXQ2WHRSbGlKaTc0?=
 =?utf-8?B?R3hFVUhZbHpHcVg3bTE2dTE1R3FHVkI0OHErcjNTSkxseGRMRDdRVnZRSkJL?=
 =?utf-8?B?ZGYxK3NHRTRxRzZKTGJDM2tVQjBCem11a09YTHlZRjcvMGJjRUg4RVVhOWIz?=
 =?utf-8?B?aUFFSHpNN1dkM3prU3pTaFc4TTN0QWU2dk1wcEwxbnk2cXNSTEJFV20wZ0tm?=
 =?utf-8?B?TCs5ZWJGU05mYXFLUjhMSkhNdVBWQnRWL3FlSDlhZlI5MzJaL0RRM0JQaHdS?=
 =?utf-8?B?OWpTam1DemdlMzZ6amlRTFl6ZjRrSSt4b1B1Y3ByRW1hZU1SdWF0Q09TbDZq?=
 =?utf-8?B?ZU13Y2VheWdFc29najkwdXg0ZkVnSzVNbkpGZXNmUURhOGxoZVNwUFdVNTdI?=
 =?utf-8?B?eGJUVlFNWHFCSGpJNkFIU1FNMGtOcWJBQ2VtMHJwZ1FzWW9NUUIwTFNqVlNR?=
 =?utf-8?B?QzlpKzFYY3JDVmVkbjc0dHVWN2xhK1RXa2xGVUg0d3dadTNMLzBMM2F6Z2xJ?=
 =?utf-8?B?OXlJRGpPcW1NRHg4MjhzMVg1M29mYXdVb0JEQ0FSU1NVL0VlRGh6bExJL2JQ?=
 =?utf-8?B?c2ViOWRLMTZVR0hWY1NuNHh5cWYyc3N5THVYOFQraDQ5L3Z3R3RHTDVveVZ3?=
 =?utf-8?B?OXoxZWZma3lmMHpXOXVDajdLU0ljODBweVUzK1hpVEV1NEVmZGlmSWhJazhR?=
 =?utf-8?B?dFE3NWd6cE9MOWFPY3BBcy9hZjdtOVJjcW9odkZSQ1lMTjJYVzJuRU5FRjZl?=
 =?utf-8?Q?jk1tAtchP7F/pj6KVazR0uSZ3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc17ad0-455c-446f-3e8e-08dd631935f6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 16:56:48.8517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R2mpCjrdCRkEQnM9EGuM0N5vGcwa3tz/kKqgPyIuDiFEXUoOTLpEzVun/uwToz5UzJGmWP+IQoY7ykDGMn1ikg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7362

On 3/11/25 04:42, Stefano Garzarella wrote:
> SNP platform can provide a vTPM device emulated by SVSM.
> 
> The "tpm-svsm" device can be handled by the platform driver added
> by the previous commit in drivers/char/tpm/tpm_svsm.c
> 
> The driver will call snp_svsm_vtpm_probe() to check if SVSM is
> present and if it's support the vTPM protocol.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  arch/x86/coco/sev/core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index 2166bdff88b7..a2383457889e 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -2664,6 +2664,11 @@ static struct platform_device sev_guest_device = {
>  	.id		= -1,
>  };
>  
> +static struct platform_device tpm_svsm_device = {
> +	.name		= "tpm-svsm",
> +	.id		= -1,
> +};
> +
>  static int __init snp_init_platform_device(void)
>  {
>  	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
> @@ -2672,6 +2677,9 @@ static int __init snp_init_platform_device(void)
>  	if (platform_device_register(&sev_guest_device))
>  		return -ENODEV;
>  
> +	if (platform_device_register(&tpm_svsm_device))
> +		return -ENODEV;
> +

You could avoid registering the device if an SVSM isn't present. Not sure
if that is desirable or not.

Thanks,
Tom

>  	pr_info("SNP guest platform device initialized.\n");
>  	return 0;
>  }

