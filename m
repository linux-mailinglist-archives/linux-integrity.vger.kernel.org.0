Return-Path: <linux-integrity+bounces-5529-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABD8A76BA0
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Mar 2025 18:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8C9B166C1A
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Mar 2025 16:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0D0214216;
	Mon, 31 Mar 2025 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kt/P1U2d"
X-Original-To: linux-integrity@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2055.outbound.protection.outlook.com [40.107.96.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8DE1DF75A;
	Mon, 31 Mar 2025 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743437435; cv=fail; b=ElXBV6dR1eZGyDayGql7u3RYtsA9nl0XECHGRJDeO3rCKh4IwS2V3tUL+loIANxKHWLCnt9sMY1dZNRjKPNJXjyonAJJv7fZWpMPhhLZD84ehXFH1zg2xAqNL0moJOBN9bc7cF++g7IIaVkkr+/y81c2wG8T2BpjJF6mZVfgx+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743437435; c=relaxed/simple;
	bh=Aecyww4kPmBSWnVQai5dBDgS2OOWuzkIvFTX9nZvWOw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rMwayFyIS/D6GzDMdliSdAuh62T8nF63dbNm/qlRs3ZxyaT8i5fabvv4xy9umbYHIpnAYssL0O0dIO4SY+4TEP1SLg867pffNYdE7tlgeYxWO48rKeYIP8jWqLSI/mPU43ok+d7nnpK1jcyBNVbVufBbd78XPP9llPSJVLGyD7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kt/P1U2d; arc=fail smtp.client-ip=40.107.96.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ChDg/rDlCWjRJ1vRE9SMq6uARkIpzB8moPmTwpiOHcdLjRN/a/Sp7ynjeuCpb7BvUYigMFhEmOBN2Tf4SPMrcrD+rKOTQhq/wMcvZqJMwGYttXRqfY8ZOZ4+ZIq8tgIihwwzK5ZjqYYtibVXffEUxxs0SHTTeI4db+hkhP0xJjG+7wOkP0xMuRYwj6RT7xeIpY1hLitBzjAwSdCLBrCX44AY27z3Z0WQPKeDSitvspn00/1Lirk8BNYzGpeqZwVecKWXMIPp3Y/fSb7hVS+LS0f2H4Kfu2T83BxFLkxh9+ZlqP4Lkb1EnXCI5nyEwmyh6nQ94qxfSFkB52vuC5LRMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ByjbrW+rEnV/w8gvLzHoc7+7Rhf/FmsWAjVumYWcOvI=;
 b=BIAWTxMb1gMAmdjAOz9p33uTK3RxSzDD/EM7dt+ukHjAw2JOHU2h1w3ybWFkHXUiqaJjX1XvK+8IU+wibbUWvpaeFPy6k4S2GAh/H1tmOhkAetL/CEao2FIQkyLrcgQ+r7k9C04ouWR8rK5eXMUY9/ifr+ZqLTaUqkduPjazvsZZHfRwluSHXp00iy+iV0frotMFUQFkAeDAjv3a73U41MF1sTsU92iKhl+yXnJ4Yf6fbzcCQNUhxdJuTDWtCse2g6KXS6IrssB6EYel6G9ecmSsw8P/WVpd7mUp5oWYyC4BY3TDmfUc4oP4IWRSTFN27/rMMOznLM7XaPaMGuQtIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ByjbrW+rEnV/w8gvLzHoc7+7Rhf/FmsWAjVumYWcOvI=;
 b=kt/P1U2dvN3kPbd9OJnb3mLGaZOeCtH/TfIMCGK6fEiTuCroywmUtTxG5mNMIec6T3dAlygT/yo/A1HvTp7eXUL8I1PPNeOECsoJ03Kj+rbTp+TfgAr4oTKxKxW3EN+5iHkC3rZrXLQxXLoaPrcA0vKOmrgwlqbccBl6l0YwUDo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by PH8PR12MB6890.namprd12.prod.outlook.com (2603:10b6:510:1ca::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 16:10:31 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8534.043; Mon, 31 Mar 2025
 16:10:30 +0000
Message-ID: <1c985127-626c-cd09-4dfc-c5607185de85@amd.com>
Date: Mon, 31 Mar 2025 11:10:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 4/4] x86/sev: register tpm-svsm platform device
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@alien8.de>,
 linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
 Ingo Molnar <mingo@redhat.com>, linux-coco@lists.linux.dev,
 Dov Murik <dovmurik@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Joerg Roedel <jroedel@suse.de>, x86@kernel.org,
 Dionna Glaze <dionnaglaze@google.com>,
 Claudio Carvalho <cclaudio@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>
References: <20250331103900.92701-1-sgarzare@redhat.com>
 <20250331103900.92701-5-sgarzare@redhat.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20250331103900.92701-5-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0214.namprd04.prod.outlook.com
 (2603:10b6:806:127::9) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|PH8PR12MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f0de7fd-2b27-4b78-b0ab-08dd706e8f27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OG8vYk1CNFI3OEJvTC9MR3RhVGgwejVLdHF5TmRzeVhYdDRJS1FtOG9vUEpJ?=
 =?utf-8?B?dVZWNklRSENJdXE4QlpRTTlSOFVrZFplNFFnaGtod2RsbXJwMHNlUUFBdWlw?=
 =?utf-8?B?YXJSU1p2ODZRblhZZzFRT3hpYWhISzlRSXVUY3BudUNXNUp1Z2kxOVNQOUkx?=
 =?utf-8?B?dk0wa0tzR1VIQUFKMGhWZkpYWDZUZm1IWWZpRmxRanh5QlJKWGQ3MDdhKzFY?=
 =?utf-8?B?YzE5aURWczRJMmZwckp0clFPbnZkNSs4eGhSSERzRDN4b3dTZXFkbmJ5Q1Zr?=
 =?utf-8?B?S2dnLzhXeTlyTklMM24xMkRGZWg5V2wwdXoxRk9qR1d6ZEw1Q1FGM1pZWTBO?=
 =?utf-8?B?NHgraVdQRG9CbWcxcDlJTUordzRQYnhaWUt6WjBzWVJIK2VVSXZKSFZlN0JC?=
 =?utf-8?B?Tnl4MU9jLzZZTFREODRyUUJ0WFZucHhIV0wzUk5OdWcxUUpaM0FvUDc5VzYz?=
 =?utf-8?B?QXdsRVNVd3dZM2p3MkJpUm5mdjVZVlJLNFE4ZGd2bTVvNTVLS1RvaUV2SDZ5?=
 =?utf-8?B?cmNqTHVkYlBqc2w2d1JxVDhSYWRaZ0I1blI5eXlBZm1QN1lrbGU2YnRGMUdU?=
 =?utf-8?B?em9NYjFvS2lMQlpCWk1JcXl2TjFZcHRyRTJvWm5xVkx3NDBBSlEzVDF6QjRp?=
 =?utf-8?B?U0ZQbEFqRWhWU2lwOGYrS3p1d1RWZHAwWUxKVDVubWpFUFo3SFZGdU9ucHNE?=
 =?utf-8?B?WXJhczFrczJOYURINk0wR3FzY1dCcHBlWUcyeG96aFVtdlAvTDlCQWx4RGR5?=
 =?utf-8?B?VDhnd1d2bkxKOXlzSE5uQzNzK01NZXNDSnl0RTFwZ1NhdXU5em9saThMWHVD?=
 =?utf-8?B?S25kbWtIaG9oZ21mVnFQNXpCLzlKU2FGMEhqdXBoNjNhY2tZNFFGb0dkRE9y?=
 =?utf-8?B?bnQrdkxmZVRVL254UEZOb0lUeTd0OEdSeU9VYlVuWUVobXJEa1ZEaGdnSzYv?=
 =?utf-8?B?OU0wVklXUDNUK0VwY1hNZUh5UTlkYU5oYk9teVdBLzRoVm54dDRTVUJTTVFv?=
 =?utf-8?B?Ui9lUEZnUzhwYkwyRDhLZVhaTi9CYkQ3N0luVlk4SzFyKy91cTZZS2hLM2hr?=
 =?utf-8?B?aGpZd2hVd0JWeXhHL2x5ZVJQUk91d3loQTNyUk5xZ1pCMGszK0lwMmFObktI?=
 =?utf-8?B?K1cvL2JkcFVSbzZRaXVSZzEzcEhWR2hITWVQb1pjNzh2U3pGMGxkMHZoRG9v?=
 =?utf-8?B?RVkxakxnNHY2QzFNSlN4WGZUd3Q0a3NYSGxNZWFjMHN5bThqSWVuRDhEM0pF?=
 =?utf-8?B?SXpLQkQ1TkdtZTVWV3JTeEE2WjlZNmhSVTlDZ2ltYXZPS1pqaVM1czRVN0RS?=
 =?utf-8?B?SEg1MXNzTTE5Q1pDOWY0c2R2RWRZaTNBZHl5RXkzMXJtaDlMV3NacDJYR0lE?=
 =?utf-8?B?Zlp5YmF1RmU4VitlTU1yMHpMVDczQUhBUDJNdUo2UWlmRGFBUnRNaDBEc3RT?=
 =?utf-8?B?bnFVM3Nudy82Vi8vdjZSMElUUDhnN1FUUUxUZlB0dVV1R2xxMUZzU1dwRVo0?=
 =?utf-8?B?ZEdoZnF2N3hMQTlzU2pHTmZCUG9kUG5tNHo3dUxmL2JYU3VtN0NmMFZrZ1dY?=
 =?utf-8?B?a2pKNFdSUm0xejlKcklhcVVDaXpoSlZPS1BrWUQzNUtEeDB6ZlpjNUpQc3JX?=
 =?utf-8?B?TEJqWGF0YktpcG5CTkFJaEl0WHVzeEhKbE4ycmlvbk1JeHV5REV1eXdaTVZX?=
 =?utf-8?B?alNBOUdrc1BRSDhUbjlHSFhUVk9xb2NhemNNYUpLVENDUEVMYTBkZXl0U1E4?=
 =?utf-8?B?clhqMFlWSVE0RTZXZXNCVHJYMHNhVUE1dlNkZ1dERk51b1ZucGVweVpGRGpm?=
 =?utf-8?B?UW91KzVuYlJXNmtZeDBUQjBLNmVqVitxMnh5MHo3V04rR0llbHp0SXkreDgr?=
 =?utf-8?Q?Rad0X7wPOcD1k?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ellid2ppKzZNMW14eFpnUU9ra1lJbzl2ZUpwSThuaGlZdFZGTnEvTCsrSVA3?=
 =?utf-8?B?TTRFTEc2ZUMvSm82c3U5UkxNbDA0UkxQTm9CWGloblRlRVdCRFZMNTdqSmRy?=
 =?utf-8?B?WDdaNWRiLzZWT0hnRVcvcWVESjFyT3ZvQkRNbVd5aVJaT2xMQ1AzOHB3WWVD?=
 =?utf-8?B?QmxDNTdQalQ4M1RuV3F4UjNpVTFzZTVxQlhtRXNuUk90Qi9BU2IybVduZk95?=
 =?utf-8?B?d3hYSko4WTR3KzdIY2tDTWdsZk1GMUlMRDE5ay9VKzYvSitPRmhqcGpoOGYr?=
 =?utf-8?B?cWVXOW4veFdYd0dpMExwVnNmUWdOZG04MTFFcHJJMWFFS1NGaXpvOUd5eGdz?=
 =?utf-8?B?OUp5ZVRROWh1OWo5eXM4Z1F0dmNRNHlheXFzZ0JhQnYzMFpBbkFYN1U0ME5O?=
 =?utf-8?B?aXk2NUJwYmJXOElWWVVoSzFqeWhHaXFZVndUTVM3WHBzV0hsakMza0QyUFMy?=
 =?utf-8?B?TXQvYjNGZkpYejBDT2tYS0RSZnRyMFVhdHVMS3hrV1hUalNrSmJsRUplTkx6?=
 =?utf-8?B?L0REelBCODU2djl5MFE1WlNyWXBVd0pjL0llMzBlYVRvRkt5eGVhTVBlbXJn?=
 =?utf-8?B?R09qQ2w4enQxV29SQktnQjR5WVNJRHpYM3pqckxKZ2lxR01JNmRxME13UFB4?=
 =?utf-8?B?clZUYSs3ZDJmVElsTUpoQUR1MzdOTEdSelpSSmpIejhtdndIUXpDc1lpZ1Vj?=
 =?utf-8?B?bVFQTXZpOGNTL1JSTWV3L0xVV245cnVjKzRTYVVzV3JHNHdxMEJWTUZabVhD?=
 =?utf-8?B?QWM4TUcvMGNScUV2YnZzV1hmWWJtZ25jL1ZRZk1kcU04WVdYNm1nd1EveUs1?=
 =?utf-8?B?eHl0V3F2TW1BNmFiRXhhNnRGWXQ3OUlKRURmMFZiTENwREpGSzNhZlljQ0R3?=
 =?utf-8?B?bmhDUEs2anBGaVl3aFY0VHB5L2ZBQ2RNUlRmZ2VCejJONy9lN2gxSXY0Z09F?=
 =?utf-8?B?Q2FrRGFoQ3RQMmZrdFRCSjNuRis2cGhTa0dXUkNWK2xHOFBERE5aN09wWE80?=
 =?utf-8?B?by80Q0dIM0lJa0RWL1QzQjJ1Q3AwMXBBR1BBYUZ0MFRDbWdScUZLRWdpN2xq?=
 =?utf-8?B?N1U3QzQ2UFgwK2E3dnZHWUlpZTJFMmRTY2pPQ2JWcWMwUVp1MkwxWmtzcjNy?=
 =?utf-8?B?TjM0TDZmZHJjcjliNDQ5RnNWY0VMYlRmZVlYcC9kRlZDQ2xZUXZndC9HdGM2?=
 =?utf-8?B?anBHOXhUWG93RWV4UUs2WEhSYWphd3p3dFp3SDRidlF1R2Y0NjBIUTVMU20r?=
 =?utf-8?B?amdRVU53dlZ4Z3hLNDVjSzd2RS9aMWFBSitNMzhZMUprQm5IUkZHMDN6bG03?=
 =?utf-8?B?b1dweko0WkNmZGhvdEI3UW5LZUlrdE1CYmlyREhZcy96eWpxZE53UWdGak9I?=
 =?utf-8?B?MW1pZ0t3SWwxamw2cnk3cjhVeE05WnlUSDI1cVVJeW5aKzNaNG1rNWV2ZUlM?=
 =?utf-8?B?WFl3UHJ0MEVNMkEzclNwTmt3U2NGZWZmbEVUU2M2ckhzUHJabVVHenFGV0o2?=
 =?utf-8?B?OEpnVEthRDNablZpM2NTZFdabmw0M3c5TlluMjg4UjFNRG9hODhhSk9acUdL?=
 =?utf-8?B?RXVSTUlBdExkQkNpZEFiQ0t5WDBxNzhYOTR6SnBZZkVsbE95SE5yU0ZFaU4r?=
 =?utf-8?B?TjJUQ0pzR21LUzBQQlhhQ0t5Y3VQeEJOOUZFUEtlanRrU09ST0pEL3JnSHl5?=
 =?utf-8?B?VU9zTHZ5YWVSS2FKMzN5NXdYWGp6MHpFZkw5SHBNQVVmVnFYbGpHS0x1WjlL?=
 =?utf-8?B?Z2RNYS95YnVYaVhseUI2U2V5d0RPd011UVJZQzF5UVBqQzY2UGM0QUI1VUpC?=
 =?utf-8?B?cjFudXhVQm5Yczl4aXljTlRzeVI2MHFHWXg5OHpDcEFpZm51eWhVcXh4cVhT?=
 =?utf-8?B?L3dZSXZubUpmRW1ydnZEMm1STDk2ekYwVEZUZHJ3R3Z1L1haQ09kQTZVSVhS?=
 =?utf-8?B?Nzc0Q2x0dkg1c1Rrb1FORU9LUnYrdk9zSW5NL2g2NUE5WlFaZ0hWRVpONHFw?=
 =?utf-8?B?cGVDSjNncENZR0dtUE1HZDlBYW44KzBDa3lWSG84ZUtVdVkxUXNPV3JNYm1T?=
 =?utf-8?B?MlBKaVo5WGVkVXZlYnhvNUMvaGl5d3M3ajVid1JkWWdoVXUranA3aVpyS1Jz?=
 =?utf-8?Q?mnWbkrTF8iKFs7K5c23YxJa7j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f0de7fd-2b27-4b78-b0ab-08dd706e8f27
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 16:10:30.8489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2RSIdIwQjDTCiwWZzPS8T4BnjoqKJQpySIw106I8Te/jBK+KGCl7vZEiAsqPEwgYygk58e5n6+5rHcs7fC3nfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6890

On 3/31/25 05:38, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> SNP platform can provide a vTPM device emulated by SVSM.
> 
> The "tpm-svsm" device can be handled by the platform driver added
> by the previous commit in drivers/char/tpm/tpm_svsm.c
> 
> Register the device unconditionally. The support check (e.g. SVSM, cmd)
> is in snp_svsm_vtpm_probe(), keeping all logic in one place.
> This function is called during the driver's probe along with other
> setup tasks like memory allocation.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
> v4:
> - explained better why we register it anyway in the commit message
> ---
>  arch/x86/coco/sev/core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index efb43c9d3d30..acbd9bc526b1 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -2689,6 +2689,11 @@ static struct platform_device sev_guest_device = {
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
> @@ -2697,6 +2702,9 @@ static int __init snp_init_platform_device(void)
>  	if (platform_device_register(&sev_guest_device))
>  		return -ENODEV;
>  
> +	if (platform_device_register(&tpm_svsm_device))
> +		return -ENODEV;
> +
>  	pr_info("SNP guest platform device initialized.\n");
>  	return 0;
>  }

