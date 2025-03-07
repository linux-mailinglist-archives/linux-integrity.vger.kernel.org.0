Return-Path: <linux-integrity+bounces-5171-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 516A0A562AC
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Mar 2025 09:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 790BC1893A7F
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Mar 2025 08:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F131C84B7;
	Fri,  7 Mar 2025 08:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="dtm5Ff2l"
X-Original-To: linux-integrity@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2126.outbound.protection.outlook.com [40.107.21.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378EE1F94C;
	Fri,  7 Mar 2025 08:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741336738; cv=fail; b=fjMFIOeSp+YP9nA+XI8lK0/Ah5YQrHzTYJ8aQltndiEFWwvKlW4+n9A85BXlkOSF8SycwePtqN+nfTB3ijT/JH4nWg2vQL+NSPVjHrj6357UsrK7urHyc3xB+7g80PSDO3yBdhUFlXW8OGq/PqsvHXhKF6r1l7b7X+kWrPXteCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741336738; c=relaxed/simple;
	bh=4aB3RPMpLK0+PMbVZFD81nlfgqJUWg/nde4djA4fOuE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ez03Scr8Q5csAdNufzNZHlA+vByJZSExf3GeHX77cZs4uMsuOE2yqHxybTZyQl6NzilkC+HiZex8oNFHf11oVlTxm6Z075VO/cPW5QQGh5g0LJlMrIcgTpGrjIkNsOVRDrw8LeiAJe0QBUKIsrqaQg4ONenRzKc1svoVF0FggT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com; spf=pass smtp.mailfrom=kunbus.com; dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b=dtm5Ff2l; arc=fail smtp.client-ip=40.107.21.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S1es+Pa4RreEkGHassAcwsGtZe0Dff1OpqCtDkZXx2TGYGAcX/wE8MBtTJKefRa6ATn8F8DMsGshsYidK1fHE0tVEW/q2UorLcJTaNFgsOoAnhJQg2AhtNNgQnj0Do9LDJqjCDlGDI2EaA3j2EVJFwv1nVnYv98KZyGWjMCQEvH2PAWzEqs0OIpeSlcNEzlgUy1yNtMUY2Ar9ZuVM9bizwOMmaskr+tFsVVQcxvGHkxvg7PNtfBIzF5xDrEVRfALYKwY1DTDh/2SpSgjvYv+bEpz2Pb1FGm/FGKD9eaJcHS35D05qRzcEBVS/ldwE61tonhLR6t0QM+UI/IJFlFQrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgRODO/v/WUbIc9KQWTZPBZmcxIupI9O3T7bSPZyBc4=;
 b=Drklg21bsbzz8gYsIHXsqW7Rq2Yo5/ZSdO9iyJ6kg5qmuOyfvY0dSFXH172n4uBmJf3z+t69DtJb6F9T9u3myaaKH68NodV+0o+iClxYccfdXUus1di4GRWqjn+F8+5eq+6e+XYK3eaogwpL+zZr9qxYP1AL7fWhzQvV0iKzxLa+uaYOZP+sf1UXxcCXIIFmWT+ukwDKzbiOVQTszH41njCycT9OPd8a5vu0nStdP1Xuh+rppkbjqGa+vM5tYDENceU+ZLgHczwqF5Tq+7hc+kBpU9usSuC4Y0FlL94n0dFjpjTaoWkkYrKB3YNT9apYyWKxEazgHL8tnqKV0ZAbHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgRODO/v/WUbIc9KQWTZPBZmcxIupI9O3T7bSPZyBc4=;
 b=dtm5Ff2luvj+0OVIJ4Meewogl4NPFxRAT6mDkLCh7yZUPd+lqJWNXk3CtLeJAfgLOUSDVCRRA7MfUGadOHEqZ+uUtHTKzie+oqu7uFiBN4+oTgV5i6Lw3XmkFh7scRLZ/K10xQ8rfhiCBNeP4yjo7EjnVbCcsqSTWd57osQTYzE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from PR3P193MB0846.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:ab::17)
 by DU4P193MB2607.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:56e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Fri, 7 Mar
 2025 08:38:52 +0000
Received: from PR3P193MB0846.EURP193.PROD.OUTLOOK.COM
 ([fe80::1ab7:2eff:ab2b:c486]) by PR3P193MB0846.EURP193.PROD.OUTLOOK.COM
 ([fe80::1ab7:2eff:ab2b:c486%6]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 08:38:52 +0000
Message-ID: <8117d025-3ea9-4b1e-bd34-493886c92c30@kunbus.com>
Date: Fri, 7 Mar 2025 09:38:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm, tpm_tis: Fix timeout handling when waiting for TPM
 status
To: Jonathan McDowell <noodles@earth.li>, Jarkko Sakkinen
 <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Z8gdKxsw2unC5UID@earth.li>
Content-Language: en-US
From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
In-Reply-To: <Z8gdKxsw2unC5UID@earth.li>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::6) To PR3P193MB0846.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:ab::17)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P193MB0846:EE_|DU4P193MB2607:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c8627a4-abad-4a34-27a1-08dd5d537d16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVNJVFoxOFlnNEpMeEh6MlVEWDkvMW1jaDdhc1ZpaDdRZ0lLVGIrZndNbTg4?=
 =?utf-8?B?Wm5lSW4vOS93TE9kcFN5RXVSclBNdnJxKzZSZ0R1Q1BLeTFkOGVJM1piSTIw?=
 =?utf-8?B?YXV6R3kxK2Z1SW1uTjF4RkZ0VkZFaXd1K1FmdG9BbXljZTFSeGlYTE1TWEkz?=
 =?utf-8?B?b0dQQnJhRGFSZDJscXRNYlBjTlgrSUJ0WVdBVEEvQ25pMllmQnk5WGl2MzBC?=
 =?utf-8?B?OGVRWnd5V2FvZFd2Rkl6MjM4VmV5VFRJY3VqSWhSYnNtUnJDY01qRWc5TDJj?=
 =?utf-8?B?ZFBhQjNRVnZ2bXE2ZjdTcmlEZVlUdFcyZ0djSXM0UjNCT0F4bTdOVHhrdC9T?=
 =?utf-8?B?OTlkU3hDeStiZk1ZU3pEbml6SHlHUWNEZ1pFa1RIbzhPNjQ3QU5QeGlTOWZ1?=
 =?utf-8?B?dVM1bnJiRnFpNkRoaTRiOStSMStNelVBWlc3Z2pkdmZ1UFNtR0xDRmdwUG01?=
 =?utf-8?B?K3dLTXJNcHQzN1Y3U2x0NUZIZEpEQWVpN1lIQWxOcENSWjI3MDlVOUp4dXFq?=
 =?utf-8?B?Sjllc015WkxodWFKK2FzZ0hNam5MVi9kYWlKbE92R3FuSC80UlNkRVU1cHVl?=
 =?utf-8?B?b0wrZHVsR1NPK0QvRSsrRFhzRGMrK1FTWFV2VFFIWXF0NnFkNGdvV0FlV2o3?=
 =?utf-8?B?YzRhZ0hOU002YXZMN3FDVUxWcnlFaDdDekI0ODFNYXFyRUdmcUJ6WDFOb3FM?=
 =?utf-8?B?ZUFGaFZQcVFXZEM0bmREQ3puL1BxdjJNR1FKZDZIMklCa0tISWg4U0tLREM2?=
 =?utf-8?B?UGQzWTRYb0ZnV001ajBWVkdpaFFVNHRXd3ZuNFczSjRlNmNKN3JrUW1iSitL?=
 =?utf-8?B?RlNOK0tnSUxlbGR4K0pjZVJGVEx4L1pMcXpJaG5OcGhaQmlaNGx0c2ttVzJG?=
 =?utf-8?B?bUpoZERoK1FlNjJFUWVxMVE1WTFibHFNVThTbEsvWFIyZDJpbk45OCtwMDVa?=
 =?utf-8?B?RWVEcWdWY0p3YWZDbUtDMloxV0QvSTVLMGRTWVYxUkpSVm1iYVk3NVArbDZD?=
 =?utf-8?B?L0ZneU01bXNKajBIRm5aVGdrSWM2c2haK0RXSm9qblZlZTJpT3hKUUtZKy9Z?=
 =?utf-8?B?NlBIN1FicytsVHNWa0I2TXcvQ3ozWVRrUkI3ckNOVUl2VjFhTjdCazBncFcx?=
 =?utf-8?B?Tkp6Q1JseVl2R0NxRDlTNDk0NGdGMVFmSlEzUzJXWm9ZRnNTMnBZTGRTREN5?=
 =?utf-8?B?eGpJcmJ6SmpJZllZY0V3SGlTanowOWJLZWtSelVyVnFJVGZCVzZCcDNQYVNC?=
 =?utf-8?B?ZU94UEVwYTN2RkZBNy90c3drc0JuTHp6dFpleXpESFF5YnBTeDc5ZXl2WkpI?=
 =?utf-8?B?UldsTVFPZzE2KzlRYXJ0UkR2d29YWlpVK3JyeXFtV3dpcnU0bnowZTJ6V1ly?=
 =?utf-8?B?cnVrMElQblhDWVozaG56cXRGS1lnaHZQMjNUNVJQcDhIWkUyWHliRk5uT3py?=
 =?utf-8?B?NnNYd0JkMzlybHl5ek0yZFBwdmtzaFZaMHJwenlMOGx6MkdlbXVkQWhldWR1?=
 =?utf-8?B?RHNENmx4dFlVaklGMHBGczY3Qm8zNVVLT0RjZlRWN2wvOXhlSGxjYnZDUW1U?=
 =?utf-8?B?Nlh5VXdhYmI2amx5OWhmYkRHVWxPQ2x1NnRwb2prcHhsKzY3SlhBcmcxaFdi?=
 =?utf-8?B?akdtNmt4bGJlZk1Na1FuTDB0c1hVSG9kc2NhbkxDTS94aGZVT1pPVXJraG0v?=
 =?utf-8?B?d3RuaURwWHJxRENVaGNBc09FNEUwK1VVNHl4QW9odEREOXlkQXl3aE1uYjMy?=
 =?utf-8?B?MHRpZVc1OHl0cllzOVVXamlzUDVKaEplenIyUWM0aHhFb3R4bVBFRXhnZTF0?=
 =?utf-8?B?b1FWRXFxQ3ZObHl3YWFWSmF3MWlsN0hvYUFnNXYzSXhTZG5rQlBBNlNRWmV2?=
 =?utf-8?Q?ChPKy4nUncH8o?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P193MB0846.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2F0YndHeUVlQUsrZk5sTzl0VjI2dm5DdFQ4YTlHMEJDZUQyU2E5eExKcnQ2?=
 =?utf-8?B?U3B0ZlNBdHp6VDBOV2hyeFhxcWxTSFJKWlIzS3VrTTFRL00wSXVicmxINFZx?=
 =?utf-8?B?K0tHMWVaa0JGUHdPOEpKR0V6ZUF1WkZEZ1FPbGZIQkRFT0dlRWd3SlVmY2tt?=
 =?utf-8?B?QmYydkJ5L2R1ZW1VZ2lGbmhRUVNrVUtSQTBlRzRRWkJRY2IxUU0wa01DT0lW?=
 =?utf-8?B?KzF4REhwWWd4aThwNDFUamwwMmtxQTNPaGlyWjdRZDRLekdMZFczRXliT1pE?=
 =?utf-8?B?aWlERTdhNHZNblduVm1ONDBGWWFTUk5XNUlCNXFmaHNRazh5bk0wSGZLdU5y?=
 =?utf-8?B?RnVyT3lvYmRKZmlCR2ZFUHJnVnBIanR4b1kzS1hwR2J2Wk1pRmVtUXVLTWpJ?=
 =?utf-8?B?QUxESHhsa0RMZjZZSUc5eFkxRW4yZ0UvRXYvUGlZRkszb3VjeWJhMU1oa2k2?=
 =?utf-8?B?Sk9WMHgrazllSG9US0tVNWZ5K2NnSEd0VGNEMi9SeGVUNTBsOVR3UjRaek9x?=
 =?utf-8?B?RDlDMnFLYWdoaDlBNVpweGNpNWxhQUt3QWs5a3grazkwcHBEOFh1aHVMM1hR?=
 =?utf-8?B?Mng3ZDByUFlYbkloSlNKakpmanVPWXVEVTVxNnZobnpPZGJSN2hPczZSM2Rq?=
 =?utf-8?B?a2pRLytnbHBtd3gxcnJZV040aDViZEZDK3cyWVgvRkJkRTBKTVNvTFlFVnhN?=
 =?utf-8?B?U0lxejVxeGtvSlFoTHJXeEhyZ2JtaHRRTVkvMW5jUlhBTnByQ0duUXp2cUdL?=
 =?utf-8?B?OTZpUFJ4b0tkT0ROMFNEUHg2SXNmSWJmK282dVg1TnFEMGUzdFZBd2VkaTJ3?=
 =?utf-8?B?aEtwVERRTVVEMUhGNTVRNVI5c1ZmamdpMVd4R2hibWFtUm11UlJENzNVYi9q?=
 =?utf-8?B?MU9xbnJma3M3OHByYThOeGQyVHVNNEtkZC8yNm9odDNNNUVXL3RyL1pvanJW?=
 =?utf-8?B?QTJVNEx1TkNtNjJ0WTdKcVJhazFSUVlGMlRpWE9QN1QxQ1ZhcCtKK3FucDJF?=
 =?utf-8?B?Z2Z0SDhjYkxndldBeGp1RFkvVWRMeXNmWGRWQnVEWnpsY0IrMzRuSjNBaEVK?=
 =?utf-8?B?UFFhcDVYTjRzWXFoa2ZlckVwTGc0c25zS3k0QTZRUnFUcGR2cmU2VGoxWVpp?=
 =?utf-8?B?ZXlDQ2g3QVFnSXNRTzVYRWdFVjcrdWFaRVgzU2xMU2o0Yy9oSnZ3cVFwWDU2?=
 =?utf-8?B?VTNCbWRDM21VZ1crTmRCUnVKR24xeUtZV0h5c2Y3U3ViZVRXTUZieUdoVmk1?=
 =?utf-8?B?RCt2UG9lTjVJOExtbmJZZUNuZ3MzNXl6OTJiNjFWQ2V3ejZuZjB0NkZOaHhx?=
 =?utf-8?B?Vm4wSnFGbWNieXhqUG9wY3ZNeDV3TnNtbjV4cTZLUXVhWGRNd1h2SGw1K0lV?=
 =?utf-8?B?NktONWgraUhIdHRHNCtTL2pGQjhtZ2NWaFN4UGt3UzNzN2ZKbkhvc3VMVG1i?=
 =?utf-8?B?K0VYVkxqNWdQRHB5U3FraXNHdGFzTis3aGlnWDFUbmt5QjF5bkdJaHJFdzRW?=
 =?utf-8?B?ZGducHpybDZVUmswdlVnaEJWNU1yVXZ6TDBEb0J5YmgzRGNvVFdqVmJjdVA0?=
 =?utf-8?B?dEpiZksyQ1lSS3Q5TDU0UDhKd0U0MVFZTFdRZmZmVTNsc0ZCZlQwVzVTWGt5?=
 =?utf-8?B?c1pOTXpoNjZFWGdFbUZNZ0hRUkpqYVhxMFo0ZDF4cm5JK25qL3BycHgzWkhJ?=
 =?utf-8?B?YlNQdDRQK1RBV2t6NFBFRSswK1pxZCtmK1cxZTFXdkRLbnEyYWxEVlQ2K0I3?=
 =?utf-8?B?ZWFVRVRiSHhLMVRtbmJlZS8wRmNoUWIvSjEwYVBValhkaHB6VVBJSGVvcUxN?=
 =?utf-8?B?TmdCVE1aaHJUODRPT3lxbXFsdUI2QjB4akhBdjAwNTBRdFBqb0g3WVpzZWtC?=
 =?utf-8?B?NVdzMFhmblo3ZXlXdVpkOXk5TnN2UG1zRThTNm45ZXlYbjVqYy9BTVNnWGda?=
 =?utf-8?B?RnpRd1NqdmIvQ3M4MmtFdVJrSmgybmlzQUNCYmx4ZmwvODdSSUc2U2JMQTVX?=
 =?utf-8?B?MmhrNXVCanllZnlnRzN0TkM2Tk8yS0NoK1dwV0VFRTZJejlXaXk1M3dzRzVl?=
 =?utf-8?B?RUlCZUpWM2dqYml6UWxDYzlHNmdJUlpRcE1xbEdUY1dhc1plQnliSHgxc0l3?=
 =?utf-8?B?bmp5b3pUMVlaa3k5U3JBbnlvOFd1YWNQZW0wbnNTYVEvSlJ5MkFuUXBCNmM4?=
 =?utf-8?B?SXlacEE2SEZMeTdBcHg4THA0Qlg3RjVaejB4SDVza1NyWlNQVEtoZjBRbHNn?=
 =?utf-8?B?L1hPNkNwK3p6dzBYdFo3TFNueC9nPT0=?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c8627a4-abad-4a34-27a1-08dd5d537d16
X-MS-Exchange-CrossTenant-AuthSource: PR3P193MB0846.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 08:38:52.0786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UlyrfSlx5C1x5CqpFhZNaS6ChKQqE96uRDsA/RS9bmzxsBtnGkPs6oS9UPnVRLgUlXu+ght4kNSXxS+YtmrHMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4P193MB2607


Hi Jonathan,

On 05.03.25 10:45, Jonathan McDowell wrote:

> From: Jonathan McDowell <noodles@meta.com>
> 
> The change to only use interrupts to handle supported status changes,
> then switch to polling for the rest, inverted the status test and sleep
> such that we can end up sleeping beyond our timeout and not actually
> checking the status. This can result in spurious TPM timeouts,
> especially on a more loaded system. Fix by switching the order back so
> we sleep *then* check. We've done a up front check when we enter the
> function so this won't cause an additional delay when the status is
> already what we're looking for.
> 
> Cc: stable@vger.kernel.org # v6.4+
> Fixes: e87fcf0dc2b4 ("tpm, tpm_tis: Only handle supported interrupts")
> Signed-off-by: Jonathan McDowell <noodles@meta.com>
> Reviewed-by: Michal Suchánek <msuchanek@suse.de>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index fdef214b9f6b..167d71747666 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -114,11 +114,11 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
>                 return 0;
>         /* process status changes without irq support */
>         do {
> +               usleep_range(priv->timeout_min,
> +                            priv->timeout_max);
>                 status = chip->ops->status(chip);
>                 if ((status & mask) == mask)
>                         return 0;
> -               usleep_range(priv->timeout_min,
> -                            priv->timeout_max);
>         } while (time_before(jiffies, stop));
>         return -ETIME;
>  }
> --
> 2.48.1
> 

FWIW:
Reviewed-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>

I cannot remember any more but I think the change of the logic in 
the while loop must have been a leftover from some tests I did
at this time. However it should not have been part of the patch, so
good that you found it and thanks for the fix!

BR,
Lino

