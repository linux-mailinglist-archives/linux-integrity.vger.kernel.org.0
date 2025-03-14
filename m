Return-Path: <linux-integrity+bounces-5287-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C376AA616BA
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Mar 2025 17:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0560116E56B
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Mar 2025 16:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32067202C2E;
	Fri, 14 Mar 2025 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rmAuTt46"
X-Original-To: linux-integrity@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BDA2E3362;
	Fri, 14 Mar 2025 16:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741970901; cv=fail; b=BS8EVlU9ob04BasfedKZ777be8QO+Hfzr0+klJZPbnLR+gxQ2CMYponBiM89E8O7/RvlbyLBP2+85Hs01xw548+gIWAtY1gq91UVUxEA+42VYB7jlgkKXzgl7NfuVWLrXAfNvthJVf9DPMvinmZ0dOMC8DroRSque7BponiFCdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741970901; c=relaxed/simple;
	bh=qRrBzFGRlfb3iu32B3FSJegapRSw+JLSX+4Z+Dd4SXc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E/2j9i/AB4p4Wzq24b7sz5FvTvOWDq7H4QpCnXY6YH7ex+E0b6IPEcQ8xudZH4Hexja7QOcv31YvNMbCpBb5cx+6hzOTiJODm15f2xL/OZf2fgFuxncFYCBbMiF2mkpbLpbUEScUlCULitSqfMgZ87N6Nj6AMEtLUN8PJnwF5ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rmAuTt46; arc=fail smtp.client-ip=40.107.94.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPwZ6cr5cuQ+cT2U9ijmtSbKcKrSAxQP5K3c5xEW3DQezQXiz678U9gQh+LHyqdcpCMaKedIxTDzfglRQWzUHOiC7VZjzvUZmqOG2pfNT6H42ImLCfCrr8aUTy/g06UNdP6cThduRge/1U7Lf/KZvzUZLYvDUuo84zMzDvMrUszJGM6f+DnViL5zPRZHwE7Gv6Nv5fbrmqLx+W8GgoMDClo1Q1LvxyHhIwDIQitmtfIMHYj1r5WER3+VNDoTHu2R7wS+E4Dksm4seyp8GhYXg6Biwz/FZe+Pro01MRMPUoBnoedEcck5t4MRv5zmNd9Jvlu9ayycrKtW4TQoQ+zRZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vhOcFKq6cr3H8p1YY3RfJgBldBNJmwHqAOQRdok998=;
 b=XAJSbtE1sJYiAXSl0IEJYfx9HLOGWG5OWs4JlCQMVbrXn1qsAj7LRRLLUWdKzYpwcBLEds5J+mNI/2CfQxHq1+m8ttr4lrnIsg1oUV2LMEMSrkGTOAU9Grk22+QxdGhYJc0YXQoGbAECIvk4YM1FYvl+8e5lOmf+e4jW7H+eOgS6bReG5/4NX87Oof08sKnLd7rwLQVIqcQfNmKxZ/G5enLzOd9A42Af4NaalDcPqL5GjEG0CwZYwZrT6LwJwgzrkbcgozArPx7EBhh3CNoV3KgrY8n3HIKUkdA/gylYoi5yoluulixFX/IoXcCP3YGT7Ckb76nSpH2jGGeeF0DEnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vhOcFKq6cr3H8p1YY3RfJgBldBNJmwHqAOQRdok998=;
 b=rmAuTt46jSktiCAmz45e+hiLl7WWZb9Hq7vjDUcGHP3UX1wDIpgPAuCRyrOxgLe95lHplsdN0GRebj0Ohn66QfGTLJPz/bHe7mfpevY7BJPi37QzEcX+eu3EhSP42+mVNh8v7BUq5G/POReSgqb9shhaD3kjod1at/6+jPcpq90=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by DM6PR12MB4315.namprd12.prod.outlook.com (2603:10b6:5:223::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 16:48:15 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%4]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 16:48:15 +0000
Message-ID: <e4eeaead-2277-1f6f-86eb-f80deae2135b@amd.com>
Date: Fri, 14 Mar 2025 11:48:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 3/4] tpm: add SNP SVSM vTPM driver
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
 <20250311094225.35129-4-sgarzare@redhat.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20250311094225.35129-4-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0119.namprd05.prod.outlook.com
 (2603:10b6:803:42::36) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|DM6PR12MB4315:EE_
X-MS-Office365-Filtering-Correlation-Id: d0be1c4d-93ee-402d-8bab-08dd631803eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGJ3TUdSak85aS81dUkyNGcrclh5MzdBRCtwLzFqclJHK3NFZnl4YmtnNEtR?=
 =?utf-8?B?SGsrYlljMFBQUmhIbU03TEprakoySEVLVFZwbndUR1FreHpWUFJXSk9PcjZ4?=
 =?utf-8?B?N0dBWUR4SzhyeVVrTWtjWVpSeGZzK0lMR3JJcjFNWGlmTTBac1lMNDBZWEc2?=
 =?utf-8?B?RlZUdmU3SjZnUXZGZTI2V0FFSTJXVjd6MGx0K2drazVYSWkvTThnSWU2K3ZV?=
 =?utf-8?B?MVlGeURJZlRFa2V6Y2tycFhHWktnN3hVcEpXMDRPTHVOKzZHZVRManQ1T2c3?=
 =?utf-8?B?RmQ4azFMM3hIMjN4ZEZ6clJZL2MyWGl1Z0JkU1A4c3FWUjEvQkJReHY2MU1p?=
 =?utf-8?B?RDdFY1libzlQNXZSWXdiNlpVV3hvcW4zRVFoTWZnakU3Y3pKaUZxcS9lWVJS?=
 =?utf-8?B?SUJaR09zM28wOWp6RlYrOXBzOExCNXlqdW14NWxGQ1FsalhRWnJMV2dWTWlY?=
 =?utf-8?B?OEVvQVVINXY5RmkzZ2ticC9qaERoUVExdDhVWitJYlpiRlNTRHlNMzZVTnl6?=
 =?utf-8?B?YXo2dHVIaC80c2tFdENFTkJMUlJsQm5VY2FCZU5jYlM3U0JJdVdOMmlzb1Zx?=
 =?utf-8?B?MVFkNW00UkdObzJTRm9xMlBEUk14YkZ2QnEzbkVla3poUjl0N2FUS2xtdzk3?=
 =?utf-8?B?SUsyWWNyQ3UwR0FMU0pwdlpkeUN5amFuZzlTREgzclljd1BWbEVZRDJ6QXY1?=
 =?utf-8?B?Tm9mVUQ1UCsrZXZFOG51NGtTUWVBM0QzS1l5RnNKc0JpRGl4dmdWeDZKZkpI?=
 =?utf-8?B?Wk1BYzlackEyVTdRRHdHcmhIZ1Bicm1UTU9QNklDM3BBckhvVUdHR3RmMHln?=
 =?utf-8?B?ckp3ZXVLOElnWTFndmhUTkx2c2dmd2sxVWw1Qnl5UEtXMEdwY3RHWCs3QjZt?=
 =?utf-8?B?TmpydHdoYkYwNGVKZzdTdmRZZEJBOGlwZDc3WnRDMzB3R2xRd0IxSE1oK3VQ?=
 =?utf-8?B?YWJ2eFN0cHJOYm5ISXg4ZmdZUXlaYjN2WDY3Q1VUVGtjZ3l5TWxTZUNJMTl6?=
 =?utf-8?B?RTlJMVJqRWJPeGVSSUY4aS9jZjg3ZXRSUUZGOEhsaElaN3lscmVtRXlCVFhM?=
 =?utf-8?B?VWEvd0RISW42TU95a2NXaGdNanZROGhjd3lBTEVKSm1KelBmNSt0d1BwcWEy?=
 =?utf-8?B?M054MGFqMGhkVmxrQm9PTU80RlZXamdtSVpMQklQeDMrWjVJdmgzT2hBeElQ?=
 =?utf-8?B?OUxmdldJMURzTFlqdDZ4N2pCczlIa29yKzRWOW42R2IrYk4vMURGZERRR3Rt?=
 =?utf-8?B?VTVwcWdSUjdSczNDeTN6cmx1RTNrYU1sTDlrTnRBMEhNRU03L2gvOFpLYnJ6?=
 =?utf-8?B?ekJRTXRZSXRtYlJGQ2todUhBUzBHVll3UW1OMmdtVnFlTVFzaWo4RlFtaFdM?=
 =?utf-8?B?SFFZU1NTVm8xUXp0NnlHWlFjZWgyYnpkdWpSaUthQ2lWbnhyMTRxd2FrS05D?=
 =?utf-8?B?dnV6SjJJMEdpdk02MTlJVWJFNmowOFcvNHlqYVVIM1IvRVZmNEsvU0NKTWU5?=
 =?utf-8?B?SktuTmhacUFzeXR4YWFzTWxWcHBJdGF6aGh5YXdLSWVITS9yMFVkSzFFNkJr?=
 =?utf-8?B?ZDBqVVdaZ25sZGs2NWI3bzlKSk4zYURzTlp6TW5GdGJoUHZlM2JxdWcvY3p3?=
 =?utf-8?B?OGFBeWlxd2pTOXJLa01YV0lCd2xjUm9TZ29xZmZRN1ZFNXVIR1EyZkRCOEVh?=
 =?utf-8?B?SWQ4UXpaTTE5UjVBQTRsRmMvNHQ4Wmt6YlI3aGNxT3dRa3NSUXVHQkpteEhN?=
 =?utf-8?B?WHorQVhzYWNYelEyVmJRUFQ0bmV3ZWNFZ3RxenZXRnl0N29UVlA4dDVnSklj?=
 =?utf-8?B?MjBrRS91MkJMSlZKekJhR0U1N1l4VDVkbzUycm0wZTlCNTZzS2l2aE1McWY5?=
 =?utf-8?Q?Tw/FvapE/ackc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3hvcDdDeVZ4Q2RrdFJWUTF6UGNDQWlWbVNrc2VYbXFFQWhPUnhOVGxNdTBi?=
 =?utf-8?B?bGZ0Z2ZXMWk0S0VGckR5Q0g2TTJwRVQ5dHVnUXd4d1pEbmpKMEE3RmoxenQ3?=
 =?utf-8?B?TEVFWXVFMDJjZWZMZ2Y1VzNIRFVEUmw0cmJhRE1FVS9RVGwySU56MEFib21z?=
 =?utf-8?B?d0cxUjNBNHRZaUNrdmpqNmVZR0gvOVhhUTIvcFhTNldpUURIMTREeGJSUi85?=
 =?utf-8?B?TlNYcEU4dTdFRE5td0twWnBEVGVqZ00xckY4aEpLWStER0k3RFBMczI4OVZR?=
 =?utf-8?B?Q2lhTlRHd00wTmdlSkhYS2lkWWRlaUNPNklHeWtDK3FhY01qSXUvSXdVU3JB?=
 =?utf-8?B?bG1ZWDI1RzhFK1VWMGRScXkyazRTbUhJYVVFUG5la3J2QkU0VlZobnpjUVhh?=
 =?utf-8?B?TGsrVmhCbmtmWlU3d0Y0R1V6TVkwSTllMkNGQ2t3dEZvUklZRzJxdlM1ZzJ4?=
 =?utf-8?B?TEtiK1V4anU1S3pFcnRoKzA1V3FVa2xBWFlJdjdJYjJXMDB0azlySXl5ajcv?=
 =?utf-8?B?M3hkQndRR2xGV2pOMFp2QnVETk5wQ1VsdXJHcFQ5ZUVzdGN2VjdrOVBnLzlr?=
 =?utf-8?B?MENaZHU2Z3NCWWpZM0Z0T2JSaTk3RnIvMmxNK09WOGZGMERaUDVaKzRBbUZu?=
 =?utf-8?B?NjM3T0twd2xqcW9NNUpiVjZEd2VJcDNNUkdxZThtT21rT0U5aS95YTRyT1Na?=
 =?utf-8?B?N0dkVVFROHZZcVJYYVFmUTYxdlNzQm5zKzY0dzk4YzBzZW50ZEszN0dnMU9y?=
 =?utf-8?B?ZWNVWDhPc0N1V21yZ1hsZHRYQUF4V0tQQ0x4RzVmVnZ1NlZaWXhiR1dXUnla?=
 =?utf-8?B?RG5RVkwvUkZReU1QTjRDaUx5R0ZuSjI4NjdWbmN0czcxUitsSXNkbytpd05N?=
 =?utf-8?B?Umw5a2NmcW5xdzBhQ1VGUjc2dFlxN3VXNDM1SkN6NVJtcTdPdEVSdTlzS04w?=
 =?utf-8?B?RWhBWHZNT2J2M0pqVDN2c3NOVSs1b1JHc0ZyUmkzU2VBUE1QSWd2TUlPSGVK?=
 =?utf-8?B?SHNYRnVEUUd6SCtXQ21TVlM4bjVhNk1ZNFRuSjJlWm9QZ0xBdXUrcnJpOFh6?=
 =?utf-8?B?MTVkMG5aUU90bDFYeHVOYXBXeUo1VTJ6RS9xVWt1L0JZUGtOMGZqalJkOSsy?=
 =?utf-8?B?aWhBdDA2dVR2eHVNNHg3Z2dIVWV5endJdzYzTi9mNTRQMlZIRXJVSFBkWmRu?=
 =?utf-8?B?cEppZVhPMTFxT3Rsdk1ocUJlSThhV2hyMDRyT3B5K0RZVENETURvRkgwQldW?=
 =?utf-8?B?bHpnR3oxRkhINkk3RkkybWV0SWQxV1hiem1QZnZZZEdzZlY0N0FvbWt0NUhs?=
 =?utf-8?B?NEduN1k5SlVqL0JBVXJhaW91VDNTWnh5REpYeDZBcjdncThMNWo1WmRqMGJp?=
 =?utf-8?B?RWJxemVwL3VSaWxqY0pacElQNG5sek9aVEVBQmNTQ1BCR1dzeFJXWGVGNjhJ?=
 =?utf-8?B?eC9KUG54R2NOVVRpcGdDVDJ1NE80dWpuU3dXamdaN2F5ZjlOTlgwNHl5ZDRu?=
 =?utf-8?B?VkFEdWNxUXBHSHhQZWpFWW1lZ3RyY0x4TURXYitnOWQwdXN1OVdUd1NBVkdm?=
 =?utf-8?B?MmJQSTlmRGFiYVVuczh1VUlibk9zQ2EvU0dJNFJ1WFRyZE8zWnVLWUVxc3RO?=
 =?utf-8?B?eDFxeXVEVWV3U0gxQkNwOFNFbEVnKzNDYU5PSHdkOXcycGRQV3ZqcGR3Wkta?=
 =?utf-8?B?VlRLSFFSNDJxbnJYT21BbkVCcmZ1aHdqWkpDNi9VbVlkN0h3aU9ob1BIS0xY?=
 =?utf-8?B?UkVDL1FlVmtLV0VvbzJiN1QxY1BRa090SUtPTWhSNXJlWTlKdUVIcXppclN1?=
 =?utf-8?B?c1UwdkkrOUZjWGY2anhIWEJHOFpOazNEQnJuU2k0MWVUMnIrU1JMck5qT0RZ?=
 =?utf-8?B?Nk9rKzBqTUF2MmxSN3JkSlZyNmROeGlrYjYrMGRzalJFWDFybHM2RVh5RlBu?=
 =?utf-8?B?VnZ1RzZPaWdodkg5amtYRlU5bDYrUnIvMms0YUs4SmhFdFgrZWR1NXZJUHVQ?=
 =?utf-8?B?Q1hjS2JBaWpOVktWRTV1UEgrVjZMQkJMQy9qVVZqdXVsL0I4cW5sTGxnZk5i?=
 =?utf-8?B?aWZkWCtteWFMdGZ2UUpySTJ6TUdLaWpvTjViRUxsLzN2eWJDTjl3VzBubjVN?=
 =?utf-8?Q?jfSxa5fj/yDVH7F2H1/KomGT2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0be1c4d-93ee-402d-8bab-08dd631803eb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 16:48:15.3903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eA3kmlMJdAqsUjkETdmQH/VWfKVxlChPmG5qMLJHq3GCw4vNJ98KQRg2Vc+3VnziFS7Jw11R0Egj7BL26AOvpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4315

On 3/11/25 04:42, Stefano Garzarella wrote:
> Add driver for the vTPM defined by the AMD SVSM spec [1].
> 
> The specification defines a protocol that a SEV-SNP guest OS can use to
> discover and talk to a vTPM emulated by the Secure VM Service Module (SVSM)
> in the guest context, but at a more privileged level (VMPL0).
> 
> The new tpm-svsm platform driver uses two functions exposed by x86/sev
> to verify that the device is actually emulated by the platform and to
> send commands and receive responses.
> 
> The device cannot be hot-plugged/unplugged as it is emulated by the
> platform, so we can use module_platform_driver_probe(). The probe
> function will only check whether in the current runtime configuration,
> SVSM is present and provides a vTPM.
> 
> This device does not support interrupts and sends responses to commands
> synchronously. In order to have .recv() called just after .send() in
> tpm_try_transmit(), the .status() callback returns 0, and both
> .req_complete_mask and .req_complete_val are set to 0.
> 
> [1] "Secure VM Service Module for SEV-SNP Guests"
>     Publication # 58019 Revision: 1.00
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> v3:
> - removed send_recv() ops and followed the ftpm driver implementing .status,
>   .req_complete_mask, .req_complete_val, etc. [Jarkko]
> - removed link to the spec because those URLs are unstable [Borislav]
> ---
>  drivers/char/tpm/tpm_svsm.c | 148 ++++++++++++++++++++++++++++++++++++
>  drivers/char/tpm/Kconfig    |  10 +++
>  drivers/char/tpm/Makefile   |   1 +
>  3 files changed, 159 insertions(+)
>  create mode 100644 drivers/char/tpm/tpm_svsm.c
> 
> diff --git a/drivers/char/tpm/tpm_svsm.c b/drivers/char/tpm/tpm_svsm.c
> new file mode 100644
> index 000000000000..5540d0227eed
> --- /dev/null
> +++ b/drivers/char/tpm/tpm_svsm.c
> @@ -0,0 +1,148 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
> + *
> + * Driver for the vTPM defined by the AMD SVSM spec [1].
> + *
> + * The specification defines a protocol that a SEV-SNP guest OS can use to
> + * discover and talk to a vTPM emulated by the Secure VM Service Module (SVSM)
> + * in the guest context, but at a more privileged level (usually VMPL0).
> + *
> + * [1] "Secure VM Service Module for SEV-SNP Guests"
> + *     Publication # 58019 Revision: 1.00
> + */
> +
> +#include <asm/sev.h>

Typically the "asm" includes are after the "linux" includes and separated
from each other by a blank line.

> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/svsm_vtpm.h>
> +
> +#include "tpm.h"
> +
> +struct tpm_svsm_priv {
> +	u8 buffer[SVSM_VTPM_MAX_BUFFER];
> +	u8 locality;
> +};

I'm wondering if the buffer shouldn't be a pointer to a page of memory
that is a page allocation. This ensures it is always page-aligned in case
the tpm_svsm_priv structure is ever modified.

As it is, the kmalloc() allocation will be page-aligned because of the
size, but it might be safer, dunno, your call.

Thanks,
Tom

> +
> +static int tpm_svsm_send(struct tpm_chip *chip, u8 *buf, size_t len)
> +{
> +	struct tpm_svsm_priv *priv = dev_get_drvdata(&chip->dev);
> +	int ret;
> +
> +	ret = svsm_vtpm_fill_cmd_req((struct tpm_send_cmd_req *)priv->buffer,
> +				     priv->locality, buf, len);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * The SVSM call uses the same buffer for the command and for the
> +	 * response, so after this call, the buffer will contain the response
> +	 * that can be used by .recv() op.
> +	 */
> +	return snp_svsm_vtpm_send_command(priv->buffer);
> +}
> +
> +static int tpm_svsm_recv(struct tpm_chip *chip, u8 *buf, size_t len)
> +{
> +	struct tpm_svsm_priv *priv = dev_get_drvdata(&chip->dev);
> +
> +	/*
> +	 * The internal buffer contains the response after we send the command
> +	 * to SVSM.
> +	 */
> +	return svsm_vtpm_parse_cmd_resp((struct tpm_send_cmd_resp *)priv->buffer,
> +					buf, len);
> +}
> +
> +static void tpm_svsm_cancel(struct tpm_chip *chip)
> +{
> +	/* not supported */
> +}
> +
> +static u8 tpm_svsm_status(struct tpm_chip *chip)
> +{
> +	return 0;
> +}
> +
> +static bool tpm_svsm_req_canceled(struct tpm_chip *chip, u8 status)
> +{
> +	return false;
> +}
> +
> +static struct tpm_class_ops tpm_chip_ops = {
> +	.flags = TPM_OPS_AUTO_STARTUP,
> +	.recv = tpm_svsm_recv,
> +	.send = tpm_svsm_send,
> +	.cancel = tpm_svsm_cancel,
> +	.status = tpm_svsm_status,
> +	.req_complete_mask = 0,
> +	.req_complete_val = 0,
> +	.req_canceled = tpm_svsm_req_canceled,
> +};
> +
> +static int __init tpm_svsm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct tpm_svsm_priv *priv;
> +	struct tpm_chip *chip;
> +	int err;
> +
> +	if (!snp_svsm_vtpm_probe())
> +		return -ENODEV;
> +
> +	priv = devm_kmalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	/*
> +	 * FIXME: before implementing locality we need to agree what it means
> +	 * for the SNP SVSM vTPM
> +	 */
> +	priv->locality = 0;
> +
> +	chip = tpmm_chip_alloc(dev, &tpm_chip_ops);
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +
> +	dev_set_drvdata(&chip->dev, priv);
> +
> +	err = tpm2_probe(chip);
> +	if (err)
> +		return err;
> +
> +	err = tpm_chip_register(chip);
> +	if (err)
> +		return err;
> +
> +	dev_info(dev, "SNP SVSM vTPM %s device\n",
> +		 (chip->flags & TPM_CHIP_FLAG_TPM2) ? "2.0" : "1.2");
> +
> +	return 0;
> +}
> +
> +static void __exit tpm_svsm_remove(struct platform_device *pdev)
> +{
> +	struct tpm_chip *chip = platform_get_drvdata(pdev);
> +
> +	tpm_chip_unregister(chip);
> +}
> +
> +/*
> + * tpm_svsm_remove() lives in .exit.text. For drivers registered via
> + * module_platform_driver_probe() this is ok because they cannot get unbound
> + * at runtime. So mark the driver struct with __refdata to prevent modpost
> + * triggering a section mismatch warning.
> + */
> +static struct platform_driver tpm_svsm_driver __refdata = {
> +	.remove = __exit_p(tpm_svsm_remove),
> +	.driver = {
> +		.name = "tpm-svsm",
> +	},
> +};
> +
> +module_platform_driver_probe(tpm_svsm_driver, tpm_svsm_probe);
> +
> +MODULE_DESCRIPTION("SNP SVSM vTPM Driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:tpm-svsm");
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index 0fc9a510e059..fc3f1d10d31d 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -225,5 +225,15 @@ config TCG_FTPM_TEE
>  	help
>  	  This driver proxies for firmware TPM running in TEE.
>  
> +config TCG_SVSM
> +	tristate "SNP SVSM vTPM interface"
> +	depends on AMD_MEM_ENCRYPT
> +	help
> +	  This is a driver for the AMD SVSM vTPM protocol that a SEV-SNP guest
> +	  OS can use to discover and talk to a vTPM emulated by the Secure VM
> +	  Service Module (SVSM) in the guest context, but at a more privileged
> +	  level (usually VMPL0).  To compile this driver as a module, choose M
> +	  here; the module will be called tpm_svsm.
> +
>  source "drivers/char/tpm/st33zp24/Kconfig"
>  endif # TCG_TPM
> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> index 9bb142c75243..52d9d80a0f56 100644
> --- a/drivers/char/tpm/Makefile
> +++ b/drivers/char/tpm/Makefile
> @@ -44,3 +44,4 @@ obj-$(CONFIG_TCG_XEN) += xen-tpmfront.o
>  obj-$(CONFIG_TCG_CRB) += tpm_crb.o
>  obj-$(CONFIG_TCG_VTPM_PROXY) += tpm_vtpm_proxy.o
>  obj-$(CONFIG_TCG_FTPM_TEE) += tpm_ftpm_tee.o
> +obj-$(CONFIG_TCG_SVSM) += tpm_svsm.o

