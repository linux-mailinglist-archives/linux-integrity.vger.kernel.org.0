Return-Path: <linux-integrity+bounces-4354-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8889ED1CA
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2024 17:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D35B280A9E
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2024 16:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CA31DD871;
	Wed, 11 Dec 2024 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XxTHOK4S"
X-Original-To: linux-integrity@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1005F38DE9;
	Wed, 11 Dec 2024 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934657; cv=fail; b=CSemXO5vpwKhDu/m5UGp1BEeiWBNJC/2CU+mF2y2h+RTv1IHjUopYR1+hyzcUizcO2AwjqvtEmCP9FDgodCSxdFYR8WqcNp+znoGK2xD3D7JEHJ0M9zEV8C2cJw7Mba7cX2P43BVj+15jvcmBu1IOd+WhN75nEsjAR5p1P6TbjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934657; c=relaxed/simple;
	bh=e9nFwkTlZ/mnYBKDVlHJfqoKLG/fF5j8v7Vq6n9Z758=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=CjV5ZZeeEzGJrbevP2wsFTOVsSA8C0umuG5agAz2zlBoxthVLTbE61btB+cIhF8f9JYp7w6+HdvsvyYrABH4D0aCE+ZKTE6zAe86GHeHYf3HbUw4WdEyU25T/1Kg9UpIMXdXQf8DRzGYuJRlU8FmXuaivJnY4F1x/29vmOJYsrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XxTHOK4S; arc=fail smtp.client-ip=40.107.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d8THoD1xKu/tVfiVbk1b3/OKTOSZLxzAy8LwVVEiE8ioK9MDFygDhedOg3IWZG74dyomSL3114fgGk4kZjxTh/GjH+DtEs8B6imWcYd6x6f/x9mXWtrjL9wqFuj8zvC96E2g8YRtLpbqFD1CDvLrFsfGhISVaLQeeZprTGMfZYlZqrFTt8V7gIUSN4Ai16EwdOwcfoGbo0Og+WkQxreQbMuSk0/KPTYZJeIUhn3OdvTujAjwoQkUHxyaSuFrQc7V4QsT8cO8yJPSnpmgpPwD7MiVswtbyZEcgy55hIoRl6440yGN9LfGJf23kF8sT68xubtR7D7GaP+StpwWZ1rcJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8aEAasg53VWNL3leDA8mdgvrccUmPJPgnKyVMmFXkVg=;
 b=XOKpUMhGJfEPHF9FkA7gO8GjFDP+j2BjW2Sf920nEWXlDwvBbsZZ1ZFnxaX/mkG6JszeevlhENdRmD2mFpMh0RCH9l+l5x+iCDcm6GelCl5NXt8ttwrCcLE5ZyjrFUFclnjiZaEl2nJT0iK5kL6JAd1PtAlo1WrH1Z+FEClv7B8wuDkXKquOGqlfhABnjF6fnxEgqWRyWx+K2U4TjYD3nkYTC5Zds43brSh27pf3sRGgAuTHoOAxqXvcBZWPYO68zlIncqGwgP1s1MQtZJ9UNXJijmkGV44k4KI7LPd/Fm5I0yWkQQHr8btS0HeNQVyZg+8RDcCM1r1oJGsokCn0sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8aEAasg53VWNL3leDA8mdgvrccUmPJPgnKyVMmFXkVg=;
 b=XxTHOK4SZ873vQ9Cr5sgI8MODCAaBEWW+5zc1BU6zuApICY4hDfuWVmwA6GeS6gEzmvZQT2j1/3lMt9q/7uWaiDG8usqFoWNck+DbUXik0cC3MuCatEXevBY+bDHFfcDQOAJppeeBn28CstbeERtHh4TlFLlWv4X9y9/HW2MY3I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by CY8PR12MB7684.namprd12.prod.outlook.com (2603:10b6:930:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 16:30:52 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 16:30:52 +0000
Message-ID: <f8c6c1e0-a42d-6fa6-a10e-925592d7992f@amd.com>
Date: Wed, 11 Dec 2024 10:30:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>, linux-coco@lists.linux.dev
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, Peter Huewe <peterhuewe@gmx.de>,
 "H. Peter Anvin" <hpa@zytor.com>, linux-integrity@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>, x86@kernel.org,
 Joerg Roedel <jroedel@suse.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 Jarkko Sakkinen <jarkko@kernel.org>, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Claudio Carvalho <cclaudio@linux.ibm.com>, Dov Murik <dovmurik@linux.ibm.com>
References: <20241210143423.101774-1-sgarzare@redhat.com>
 <20241210143423.101774-4-sgarzare@redhat.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 3/3] x86/sev: add a SVSM vTPM platform device
In-Reply-To: <20241210143423.101774-4-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0111.namprd04.prod.outlook.com
 (2603:10b6:806:122::26) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|CY8PR12MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 280dc554-9783-4c29-0b2c-08dd1a012dc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wm41SUVPSHBYeUEyRHBOZUFSZUhhdGw1RmV3eFM0eWpwN2dVUzk2ZXdHWHQ5?=
 =?utf-8?B?VGhnaXBIYjZDUkROcm5MMDU2WDJyUGt5L0x5WUdNWDMxd1hlMFhYNFk0Z2s5?=
 =?utf-8?B?QlZnWU54TkJ0M08rUHFwZXVxRUxJNDVweHZvUC8ycGZnaFh6WEZWNXptK3lv?=
 =?utf-8?B?VTk4NExobG5jZVlPN3dlTlpyWmZBN0xqQWdUalYrVGw4ckw5UlM4R1U0bURS?=
 =?utf-8?B?SkFxaG9CKzY5WlJsN1RVTWl1NnMvdlFNaGRPWHRYZW45SENEdzEvL3ViQlVP?=
 =?utf-8?B?bkFYNVBkOXlUWXh3Q1JiWnh1N0VFY1ZDVk9jYnJKRithWjRpVm9rMXltbDNz?=
 =?utf-8?B?RTRNZCtPMWhYbmZiNktIQ2FIZXVYZ0xqcUtqNHRzdU9zVk1qV3Nub1RITE00?=
 =?utf-8?B?aDZNZWRHQkhKeDJQZHJUSkZRaElJb0puNzRhQ3pWbkJXdWtqaGtwaWJmbVg1?=
 =?utf-8?B?WjNvNm5MdW56UEVCd29jNHIrSkZ6bmFIK3VXQ0pwOEIzOWc0aGRoR1dSbngr?=
 =?utf-8?B?OWptRFg3VTlKNC96ZklpeVpRbDhIWEVHSVNsNmxob2RhTVNEQXV0d3JSQWZ0?=
 =?utf-8?B?dEU3N2pkTzFwSWRKUzc2Q3grejdocGZrd3daME9WZmNweXY2aGhlWWJEVU93?=
 =?utf-8?B?VmVveG83dGtzOGdlOU9kakk3YVFERFRXb3lLYytkOUxFYnF5YWlROFVWdGN1?=
 =?utf-8?B?Mnc1TENtYnpPMGRUZTlhaElTVDRaamxrbWRFYjU3UEREWkhXQU5mb2FqMkFM?=
 =?utf-8?B?U05SM010Wk9jd1NDT1l0U0hvWVdMRU9oUlRQTnVQNm42OVNsdjlXT2FxZzhI?=
 =?utf-8?B?dGVYRkYybkpaMFl6L1RjVXJ4T052QzRDc21oaUhKVGNsSWh6TkovYVdJUWd5?=
 =?utf-8?B?bDBGem8rSGtJeVp4eDUzU25JNzdBK2ptNXAyVEIzZVcxbGRjWjNaSldkVGNE?=
 =?utf-8?B?dmtHTTZBUnFmQTFpVHBLNzVITkExMlRNWjRnbHg0d1JkdW1BRDZZS29CbGVV?=
 =?utf-8?B?by91UjNoQVovZ0l0SVJ6Q1BOVlJET3A1S0xzNWZrZGlzKzBVUFpuZ0szdWNX?=
 =?utf-8?B?d0VaTW51VFZqNS9CeW1TekE5cmpMYklTZWdzRWNKM3JvYmd3OXFNL2M2aW9a?=
 =?utf-8?B?V0Q5V1orMjRGQlhzVzgwRWY0Z2JVcVN3anpYMVBOd1ZBRytiOW4vSlJiMmpY?=
 =?utf-8?B?Z3BBbEhJL0QvQ3hwMWRVdTdBNWl2L2NGLytvTndHREJOcEtJTGN3dmxrVmNB?=
 =?utf-8?B?SWtKMHl1ZWdZcGd6elFrL29FMW00V0IwMlFET25TcnhndzlLa1dMbXMxYjls?=
 =?utf-8?B?eW1MS213YmtFNHJjMVp3YWJEeHZtWkdOMkwvMXErNTY0eHk4ODU1OGxpekUv?=
 =?utf-8?B?Q3ZPNnhXWC9wNU9VM3lMa1BoZVZFWkpzQjV0OXd6ZE1lb2FZOEc5ZEdGMFJY?=
 =?utf-8?B?MDlQRE4wU2N3Yk1UMVhIdmp2MXB2d2VQZFdxN2NyOWZjaSs1U3NXT3MyZ05B?=
 =?utf-8?B?VjNHR25vSEhCdTRpcFlTVS9YbjNZWHIzSmw4eGFpV2FpVlF5T1RscUxBTHly?=
 =?utf-8?B?UnVsbWZySWpiN2loR1RXTWJXNmV5TTV2RGtCeno0anFWWHUvZ0dXZVc1cmM1?=
 =?utf-8?B?NGgwNFJNV1Q3ZHRXRVZ1RHh5S1Z6UGRrbXdCUWQxVTR2ckFGSnVPdUx4L3RU?=
 =?utf-8?B?NnArRXhUSDc0VmJhMnp2WlUvWEd5aDRwSlNRU3p1dm1jeDM2Z29Semg5MWE1?=
 =?utf-8?B?dXBxc3dJMFpZVUhJSkVRb3k2Q29kdXkwRndLVU5tWmJWTmcyc09KK0pLTDBW?=
 =?utf-8?B?YkNRbFhUMThYU2hVQTA3UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFZmZy9DUEJpb0lOV1lQOFk2TlhkNm1MTXkvWGx4d1Q5REZnQlRhekw1dVFi?=
 =?utf-8?B?b2pWa0NPa0lmMWgrUWJ4V0lCeVV0M2pnbFlSSjNoNjNZNmVWTGlpd0IwUzZh?=
 =?utf-8?B?RzBHa0F4dWZySjFLRFFHYnRPOXZTQnBoL2JzTlRQenRJbzcvNVV6VG1MOGFk?=
 =?utf-8?B?djZodFREdnN6eGlWTlQ4ZTR6Z2RHNTJ3Q1F2Yis2dXJHOGo0eXB2MDVpSE5k?=
 =?utf-8?B?N0dzYmZXcDliZDJ6MUtzbFFZaDYxdGtWUFhHWTdaS2QxRHRnc1dDbDJoc3Yz?=
 =?utf-8?B?a25Ic0JaUVZKSWJWdDZGby9wV2F6SzhiZjVqRXBqaFBWWXpIVDgyTEdRNG9v?=
 =?utf-8?B?TVpobDRENDRRNkdvbHp6bUlvVmt1YityYis2RWhhaldzcnhKUUlncmtFTUNz?=
 =?utf-8?B?UGpTakpYb1ZaT2ZoQVl2M2FhYmhpNkVlU05ueGttM3p2dzdCdWJDM1FwN01Z?=
 =?utf-8?B?RTFxbWRvQi9HUTNwVHkwaEF3YXB6SjRrZFhUSG5vS1E3d3NIbTRUbklGVVgx?=
 =?utf-8?B?UTk0RVFWOFU4Uk9oZlltYlQwbWh2RWgxUThKSE8xdFB0dW44NVA4eDVmMkdT?=
 =?utf-8?B?V2hSOXlXdnZ3Vk1vREVwRlgxVkdETHNNVzZWaG5CSUVrVzhUQ3Z0dUVVbWNy?=
 =?utf-8?B?Q082aUZRa0RFUDNNaW1uT1g4cUVtTTE3a0UwMk1abFJTVldqV2FIZThiUGZu?=
 =?utf-8?B?VkVJU2l4bThkVVVuRDlGTzNzYlpEcTNwRFdxY044djdTblNzRUVWYy9iTFR1?=
 =?utf-8?B?UmlHUVVGR1B2VFgxcTBBaVNUVkdPdDl2UWR4QzZqbjZwaXFzTDY4TXY5dXRD?=
 =?utf-8?B?ajdtcWd4bWk1ZW84K2RGUjB6WWx0K1hCc0pNNnlRaHhaZUlpYkl2Nko5S010?=
 =?utf-8?B?bXFzRllaZ0RqZ1ZqMm16U1FtM3IydFpuRTlUcFJ0MTdYa1AwazBWdnpnVjZx?=
 =?utf-8?B?RVk1WFdTc29FWkh4WWdTLzVpd09raFVZWHZ5M25vSmFSL3ZBaUtvV0V1aG1C?=
 =?utf-8?B?YlhvMzR2V2ZlemphMHVHSFhyTC9wOC9ITm5jekdqMmtGTlJYS2RoLzF4VjI5?=
 =?utf-8?B?a3BGSlVVTVpDQ29uSnJxdG5YTzdJUURUcFJYdkxCTGQ2czlOMkNzMXUxUWNO?=
 =?utf-8?B?OWNoWEh6eEtrUWFKWnlLQlY5WGpUT0VhVnBBVkhLOTNHS01aWGk0WU5FdmpU?=
 =?utf-8?B?c0FSYU9KMEFpWnN2bFlJcVN2QURDVHNnY082WktBVWFLczZ1NTBaQjdhL2hF?=
 =?utf-8?B?LzI4N2JsTkZwb2xsdnFDWTl1cE15UUEyQVBZdzc0ZENTOExPeWhrOGwxdVdu?=
 =?utf-8?B?QUYwOFhGVXJOaUk4TDZ6bWl5SHZGM0FsUzVoTW5lWHg2UzI0YXQ3TlVjaFU2?=
 =?utf-8?B?MnlmaEJXYmR5N0FyWS9uWVREeitoczVYYmlxd3ZXUVkyQUxWSWRiSjNxRWJ0?=
 =?utf-8?B?Rm95a3NSSmpQUFNMOGtuRkxXejdKMEVjdGpCRTZ5M0xYcUVaU2pwYnB4YWIr?=
 =?utf-8?B?elZGdHNLbzZUaDJvTjJ3d1Y0Y1BZeDRZTlBqUjdnQXllWGM2a2hGYk15RCtO?=
 =?utf-8?B?R2pLKzhiSVczeU5DeXhRTTlRN09FVXg2cXI4TStrQlI0WThvL1R6bWdVTmwx?=
 =?utf-8?B?Q3lWQmsxbGdJUW9FeEgrU1V2Q1V2NGhzYmRqbW55T1JzeEVuODFzR1UzbE5z?=
 =?utf-8?B?RzdLSnFOWE8vWUNEUklwNUJiUEl0OTBvRC9kREJpRGdSR2VWem53c2lhYXVX?=
 =?utf-8?B?MFBPNWRiVkFIRWNPK1lTRXpZR2M3Ly9qNnU5Ri9pcDZsY0x4K3FVN2FoQ3Yx?=
 =?utf-8?B?UkpGSFFidS9DaVBXMTVGTDBnT01kaVFDVks5clJDZGhBeUlsZWZNZjJFcHgv?=
 =?utf-8?B?ditTTTM2WGo2eEkvSjR5TThmNFpJaG9RaXh6MXhocEMzMXhyVnVLOCtTWUU1?=
 =?utf-8?B?TE12K0FIOTg1aXh6ZzNMTVZISm50MUx1bHBYR1RqbXliVW5PMnlNVDRYWlRP?=
 =?utf-8?B?aU5JbkJmNHNLTUdvakZqVkVHMXdHVFJOYWVwYmFYbVUxRUlnSzVVQ1VSSEpQ?=
 =?utf-8?B?S2FCNjZ6OXJucGtsWEZnaTJQUUJ2MllnRWs1QnlFRGc5cCs4ZFBFZTJRLzU1?=
 =?utf-8?Q?abWZ9E8+GeEMzqlvh3jlrAB8m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 280dc554-9783-4c29-0b2c-08dd1a012dc7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 16:30:52.3708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: szxjzscvFwZxyKRuIZRTclzYiQzyjaqKiq9TwiKrORaIA2UUFHXkt8x1QyKsILg9Gi6A73Nj6/cnpI8Nt/yDgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7684

On 12/10/24 08:34, Stefano Garzarella wrote:
> From: James Bottomley <James.Bottomley@HansenPartnership.com>
> 
> If the SNP boot has a SVSM, probe for the vTPM device by sending a
> SVSM_VTPM_QUERY call (function 8). The SVSM will return a bitmap with
> the TPM_SEND_COMMAND bit set only if the vTPM is present and it is able
> to handle TPM commands at runtime.
> 
> If a vTPM is found, register a platform device as "platform:tpm" so it
> can be attached to the tpm_platform.c driver.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> [CC] Used SVSM_VTPM_QUERY to probe the TPM
> Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
> [SG] Code adjusted with some changes introduced in 6.11
> [SG] Used macro for SVSM_VTPM_CALL
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  arch/x86/coco/sev/core.c | 64 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index c5b0148b8c0a..ec0153fddc9e 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -21,6 +21,7 @@
>  #include <linux/cpumask.h>
>  #include <linux/efi.h>
>  #include <linux/platform_device.h>
> +#include <linux/tpm_platform.h>
>  #include <linux/io.h>
>  #include <linux/psp-sev.h>
>  #include <linux/dmi.h>
> @@ -2578,6 +2579,51 @@ static struct platform_device sev_guest_device = {
>  	.id		= -1,
>  };
>  
> +static struct platform_device tpm_device = {
> +	.name		= "tpm",
> +	.id		= -1,
> +};
> +
> +static int snp_issue_svsm_vtpm_send_command(u8 *buffer)
> +{
> +	struct svsm_call call = {};
> +
> +	call.caa = svsm_get_caa();
> +	call.rax = SVSM_VTPM_CALL(SVSM_VTPM_CMD);
> +	call.rcx = __pa(buffer);
> +
> +	return svsm_perform_call_protocol(&call);
> +}
> +
> +static bool is_svsm_vtpm_send_command_supported(void)
> +{
> +	struct svsm_call call = {};
> +	u64 send_cmd_mask = 0;
> +	u64 platform_cmds;
> +	u64 features;
> +	int ret;
> +
> +	call.caa = svsm_get_caa();
> +	call.rax = SVSM_VTPM_CALL(SVSM_VTPM_QUERY);
> +
> +	ret = svsm_perform_call_protocol(&call);
> +
> +	if (ret != SVSM_SUCCESS)
> +		return false;
> +
> +	features = call.rdx_out;
> +	platform_cmds = call.rcx_out;
> +
> +	/* No feature supported, it must be zero */
> +	if (features)
> +		return false;

I think this check should be removed. The SVSM currently returns all
zeroes for the features to allow for future support. If a new feature is
added in the future, this then allows a driver that supports that
feature to operate with a version of an SVSM that doesn't have that
feature implemented. It also allows a version of the driver that doesn't
know about that feature to work with an SVSM that has that feature.

A feature added to the vTPM shouldn't alter the behavior of something
that isn't using or understands that feature.

> +
> +	/* TPM_SEND_COMMAND - platform command 8 */
> +	send_cmd_mask = 1 << 8;
> +
> +	return (platform_cmds & send_cmd_mask) == send_cmd_mask;
> +}
> +
>  static int __init snp_init_platform_device(void)
>  {
>  	struct sev_guest_platform_data data;
> @@ -2593,6 +2639,24 @@ static int __init snp_init_platform_device(void)
>  		return -ENODEV;
>  
>  	pr_info("SNP guest platform device initialized.\n");
> +
> +	/*
> +	 * The VTPM device is available only if we have a SVSM and
> +	 * its VTPM supports the TPM_SEND_COMMAND platform command

s/VTPM/vTPM/g

Thanks,
Tom

> +	 */
> +	if (IS_ENABLED(CONFIG_TCG_PLATFORM) && snp_vmpl &&
> +	    is_svsm_vtpm_send_command_supported()) {
> +		struct tpm_platform_ops pops = {
> +			.sendrcv = snp_issue_svsm_vtpm_send_command,
> +		};
> +
> +		if (platform_device_add_data(&tpm_device, &pops, sizeof(pops)))
> +			return -ENODEV;
> +		if (platform_device_register(&tpm_device))
> +			return -ENODEV;
> +		pr_info("SNP SVSM VTPM platform device initialized\n");
> +	}
> +
>  	return 0;
>  }
>  device_initcall(snp_init_platform_device);

