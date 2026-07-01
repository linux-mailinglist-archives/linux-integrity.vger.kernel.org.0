Return-Path: <linux-integrity+bounces-9859-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z6gIJ4mJRGo2wgoAu9opvQ
	(envelope-from <linux-integrity+bounces-9859-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 01 Jul 2026 05:29:13 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E964A6E9795
	for <lists+linux-integrity@lfdr.de>; Wed, 01 Jul 2026 05:29:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hotmail.com header.s=selector1 header.b=fxtD7ffS;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9859-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9859-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=hotmail.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B147730421C8
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Jul 2026 03:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9B93655C2;
	Wed,  1 Jul 2026 03:29:11 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013073.outbound.protection.outlook.com [52.103.74.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2F91531E8;
	Wed,  1 Jul 2026 03:29:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782876551; cv=fail; b=WKl3/0CU3jGusTuYVAp7MffJVaNGOUwsUnGsbfpSl6z0S+Tfe3qTezkAAQ0ZiXfaqzLWAKC4w7Tnq6gSHECgAFVcFTUOG7gV3WczgoGMLNK2EAZ43R1aliDOMY4AQyG099WAOTCW7gAGDSs0HxAQuX5MPSQ27JMdpZhImSkiF4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782876551; c=relaxed/simple;
	bh=ouqMbgIDm7ow1OTahdhfeP+rhkSmsH/WpC8eP29YvMY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZLOG/rkHrdQh8e7nBu+Lmdl8ikTED9F84IQywTFntMSHBZz2tCIMfsGL1PRxWlHVsjCR2ukGlHiYcwuNZIc0xW8y7Xf+QSs/cA7DgOO7AJpFQbXuFPodjAp9/0hywdLtyqhzbsAQOdUMm+19X6JxdrebQi5ZDS6duDplgqf/QSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=fxtD7ffS; arc=fail smtp.client-ip=52.103.74.73
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lEfonfu+SCAluExq2r9SnW0h/9uEh7tzHIYaPWI8yumjetdcQiL/TcIwq0nwpeN8azK2wUlovlp2nsT0aRYQ+iYFhRWiojypNROrd+p7svV63pEeJhrsdBP3HIW6AoG3YNyzp0KAYI4DH2MqU2+w8916xFjP9Ln8l/ITwn0BKaqzynSM7LSSdqbCcFxXjXKWDEgawfzP3BGuauuyctMnZJbmjbxQ79Y1HkqwMqgbYRQoIzFA2ceuu6RfEACM/ZN9XjH+I48GmQKzl0a7ytF8IBF/epB83skk3hYNgVBdQBI6L1U6iWqwYOJIwxWCbkcvB2ynjJzEdXH+Xa5yTicn1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErW+6EK3mXFurUZfepSXAdiyKBP4miK50Z6tfKbk75s=;
 b=ckbsSvxF+Fm+uzADvC7syGOIJHEvVY6H9W3VmKje+BlyW6KHlJjitAnFyuw71Dg/CjF9HazGDYb94XBFClXAb5EhTboaSNs5O49LOchirv5Aj2cYTVYZ6S/LAiLOGzbWolkwEW3AZ3mj0NtEKpm/aaEFH8aus0CeFwwznOQgOdxLTDUAKcYrbIW9jqrzuCDvuHkguKzo3vAlI7v/YVi8yr/1qmugA7siHm0uafEsbcnPKFqlO/1qyKuyV2CASOYvwkRN3eL2nKOP/d4SdXm8mNdoa8VX8ugfN4+Y6dT3CPGZnmy6djjQ8f/kVQUEg04rIhdAv08OWiiunMOzbML04A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErW+6EK3mXFurUZfepSXAdiyKBP4miK50Z6tfKbk75s=;
 b=fxtD7ffSXbzl66NtQvWk6kURXw0ZtLjko+1vvt9T3XdmLorteyB206hiuEXv4l7uEn2rgifjdpHDP1z8tL2padoD6u5FGxEEbiEqbCsxWco2Qo22wZRU2+HnZyDIYcTEo3GqGeHdmLtIzYZ03YC8q0WEcNiZeoaiZCCwt+DMXQ9rM77WwqJIbe75SlroIyzIZKTuyAUM9kw2f3jjkUHe6mjm2RQ3cJ1SMLX+EWf/BL8TmguvMVWk7ZdLxuigBAAJ1aEsFU++FMv8iXIJTEboi50XGgF5FZEUrZIM0Jxq4IzSkWy4LvIi+wHhW5w8CrfMJS29bRzbgCoDFMJLtMqTpw==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by TYZPR04MB6279.apcprd04.prod.outlook.com (2603:1096:400:288::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 03:29:04 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%5]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 03:29:04 +0000
Message-ID:
 <SE3PR04MB8922E2267F05A514AD33F9D3F3F62@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Wed, 1 Jul 2026 11:28:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] riscv: Fix a NULL pointer dereference in
 machine_kexec_prepare
To: Tao Liu <ltao@redhat.com>, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, bhe@redhat.com, zohar@linux.ibm.com,
 roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com, linux-integrity@vger.kernel.org,
 pratyush@kernel.org, Markus.Elfring@web.de, kernel-janitors@vger.kernel.org
References: <20260701025732.66330-2-ltao@redhat.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260701025732.66330-2-ltao@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0059.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::20) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID:
 <f47ff8af-beee-48ea-ba49-95386526213e@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|TYZPR04MB6279:EE_
X-MS-Office365-Filtering-Correlation-Id: 5055ffdf-0315-445d-9a8c-08ded720e658
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|12121999013|19101099003|25010399006|15080799012|5072599009|4140399003|55001999006|6090799003|23021999003|8060799015|19110799012|4302099013|440099028|3412199025|10035399007|40105399003|52005399003|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bnVNMHdoclcwLzZzY3czOFZtL1ZqVHRFK1BYNnRFdU1GTzJCeTVZRkRSakdS?=
 =?utf-8?B?Q3M0L1hCTnFBQll5YWN6TGNsc1krV0l1Z1pib29lZ1lSQTdOOWdrU09ySTRF?=
 =?utf-8?B?MnpBZWZjUUFnSWVCZzViNWtkOG1OR2FFZkttTVdOcFY5VDlFNktvSXNUa3BM?=
 =?utf-8?B?V0V1UnJ6VHB1Nm56aHBzWWxyU2diTmtpMS83UDVpLzZLR0lMcDlkSzJQVWR5?=
 =?utf-8?B?QXBpVE9uVTdZcEEvOEZRMnRmcTBnOXhVN1pBWEdDUzVyN3FFUkZLZ29mVUY5?=
 =?utf-8?B?OWJydGV1Q0xZeUZWS3hoa2lKNFM0RjZRRVBPZnVtV3BZeXZtT1dINzdhYUNj?=
 =?utf-8?B?UGkzWjlRVnpXUEhNK1ZlMjFYNkVqdldtcUdJMlBINjFnTzk0aDVxRitlbGJT?=
 =?utf-8?B?NmFHZ3hUVm10Lzh5RllQTzB1NUhXNDdXa0J3WXNyVU1IWmZlMEovVElCZnMy?=
 =?utf-8?B?WDRDdXZhNEFXd3Bya0YyV2lpMjN6Uy9ialdsNzQwL3ljalFPdy9OMmtYclZ0?=
 =?utf-8?B?bG9VQlBobHp6ZGMrR25xYUFYcjNqZFJ2OHdEUHdXbnIxaFN2TmNkbjM2Z3Ux?=
 =?utf-8?B?cFZsVnRZSDhIRnI1VEgwZEluWWpsNWYxdWlNbU1uMnpuQm9PS1FSdklia1o1?=
 =?utf-8?B?RFd0NWIxTXJiUzg4eWtMQjZjU2Njdkg3TXJjTWRLNFlPMnFXRHg3ZHJKRW0r?=
 =?utf-8?B?OFlGblF2dkVOdW03MXJYVmRIcFZudTBsckxwN1JaaSswUUZSM1hNWDdCZXgy?=
 =?utf-8?B?V1E2dE14dURhV2tSelV2V3Y5SExiZ3JtcEFJTS9CVVJVRXc4REdXa0toY09B?=
 =?utf-8?B?NmovSit6NWpRdWU5MWNxZkprOUNlVG1BVXp1ZXQxUFBnam5GMkZPeHpYZVpV?=
 =?utf-8?B?K09EMElZMXQ4Y2N0NDRVZ3h2NDhQWkJoaVBMZDBiOTROeDJGZVNESHNxUFVp?=
 =?utf-8?B?dElDOUxPRjUvY0MvR1k0UnVTV2ZwTVhrZVRhK0ZxYlZUb3NYeG41NlNKMlNG?=
 =?utf-8?B?ckpxQzVkS2Y5YldXMllJNmNYb1p1Yjhrb1VQMlR4L2dPOVRtemJTV1FxcTFS?=
 =?utf-8?B?R0l5bnU4ZDM0OURNOVIzYllCWnJZNXVkbzZhaVZoR1MzRjZ2V2lrbVVtRERH?=
 =?utf-8?B?Z1VIUWt5dVhvOU94WVZ2Z2ZnMm80TVN3Tk85UGt1c3NiWlJYMnBzVTJoTjky?=
 =?utf-8?B?UC9tV0NhV1ZCbGR6YjJ0S2IxVDlHWjRyYlRDSzVHS1pGSm5xb3BXS0JLWUlX?=
 =?utf-8?B?WWRTdjR5dzViQkJsNjBVS1N0MG4yaUhRaGNZRHRONWtBTXdHb09lRDd1b1hB?=
 =?utf-8?B?NGlablpWaHhrSnVuT1BNVFQ5aEl3eDRSRXJ1YjBpNm1SWER4Q3JNWk5ZejVY?=
 =?utf-8?B?SlU5ZDZ3cEYxSjZlTEhFTmFta3dyWXhPT1gzOFFVMDc0aVcyWVRsakJFRXlp?=
 =?utf-8?B?THBWYmRPQUVEcVlxZWwybkV2STZsY2xWc0p1NGM0eHB3WkxlM3dsREtOMDN2?=
 =?utf-8?Q?w4DKGE3SF4+y9USupXMaVpHsxnU?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXROaXRRYUppOTZna2xDR0dpTm0zRGk0aG8zaVIwekoyZCtnUW1md2lZNXZu?=
 =?utf-8?B?UTRNMWp4WGR0d3FYbUZiWENkZUpJeVhBaHUzVDRETW94MWo1U3RURUpmUDJz?=
 =?utf-8?B?Z0lhOGdqYk5jWXhBMEUyNi9IZXZwZFFlWlA3WHhlOEMvVVduY0dpSkFndUdZ?=
 =?utf-8?B?UjM2YjlZcVVhYld6dlJvMlppZGNBRVY5L3lPTWZaTS8rZFh0UU1JRVJ6VjFR?=
 =?utf-8?B?ZTZCSTV0OG9hVFZiMkI2T0tBK096UTdxbllJUjUwbTBLYlRvd3FGQUcyZUlS?=
 =?utf-8?B?R1hmdHdOcGhJRkRVeTMySjJuRVJaMUs2Ykw0a2dLdjFDbzViZUlRcGd1eDhM?=
 =?utf-8?B?RnpzckNJMXlDNVBWU0VoTUtrTTcyaXZySnE4aHNtWE5NZmsvbDVBY0JnVTFT?=
 =?utf-8?B?SEd4YTBwMUdYZ250K1BDT0VXbUJzZjZxRytabzZtRDlmeW96d0g5TVg2ZTRW?=
 =?utf-8?B?YmRzUnM3RUhtUkx2SU5jeGNoZ1ZFZGdYOG5WSXRsWnAxWUhyZk5neHFCVkJ6?=
 =?utf-8?B?ZUpJeFgya2VSL3Y3UXJYNkNJdmVGL09tWHBGbUdaRjZsM0RxRFpteXRzMXRG?=
 =?utf-8?B?c2FtSFo3RHMyTWVNL2F4RGJnbWpBUk00RERtZ0t3bVJkbVdObXF2S2Z5akl0?=
 =?utf-8?B?dzVUejRhY2RIa2RzYU44VHpHS0NndG1RMlZhVEMxVmJsVmVUZFRyVjlZYkJQ?=
 =?utf-8?B?UzBjREpEUUQ1QjNTeEJuYzlVMWhJMmFxTm5lYWNhclJMTDBoVGo4T2hpSlE0?=
 =?utf-8?B?UmxKY29rSjVxOWl4NFpWelY0eCszeEZJQnJNUGJQZTNGckYvbThDOFN1VFVD?=
 =?utf-8?B?UHQzRXlmSnJrR2hFL3lCTWw1ZmtuKzVMdnpGK25qRktNbi8rQzlnZlVkWGRi?=
 =?utf-8?B?MFk4amZhcE92akJPL2R3V1I2TWhRQlFPb1JQUXBzVlFsZVFHVnpPbGdUVUxG?=
 =?utf-8?B?cW1YWDlnenhZOGEzSUlLaXpHR215OEVmMno3UUgwRHhtL01iWWVtQkg1cHAw?=
 =?utf-8?B?cW5NV0xXbENESXBNbEJFcXY2eWRDeWd2Y3NBd3BXNHU3VUNWTzJjWTlJK1Iv?=
 =?utf-8?B?OXhxc3U1Y2VPNytoRS9yaGNxaUNFZ090WFhTZnp1VU8xa0laWGN3SEJYdzhZ?=
 =?utf-8?B?TzVaMzhuMXVXamhLcEp6NU9STk1LWDh6aG9hMGFsU1pUS3BWcDVzOG1IQmtJ?=
 =?utf-8?B?MThiNU1ONTU0SUVQeFJhNGRPeGgxMTZCSUdIUWNtbW0wVHRYeWdmbERDRFJN?=
 =?utf-8?B?SUFrWUd5aklUczJtSFBXL0VzUW9Qc0MrRlJIT2tMRG9lVmFUakp4MVpQSU9I?=
 =?utf-8?B?UDBSU0tGMUVhQ2g3UVJWem1NVm9wSFJpWHZ3dGZWNHNWNS90VUVyZWc5bUdH?=
 =?utf-8?B?a28zZ2ZtZ3lvWXFnQXlGZkpZeWRvVThmUkRUY25PM3JBRENWMmRWR3JBTzlQ?=
 =?utf-8?B?Y2g5bUNUa3UyV1oxYWtJQlora2czc1I3WXFReUpOMjhDWE5ZQUpDdndyZG1v?=
 =?utf-8?B?TUoyOFJ6Y3dtWE9obnJQNlFqV0k5UmNiRjBLZlVxRkxQZWpnK0RhRTZYTFpm?=
 =?utf-8?B?bzJDOXhKdlBXREg1MkxDc3R6YzBjOFR0a24xbEpmSFh5UUNjZnBSWmtFLzV3?=
 =?utf-8?B?ZjJtVkJtUnR5WDVzMDQrMi9iZFNaRGp5YlhURk1KSnkyakJtc3A0Z3ZOcjFK?=
 =?utf-8?B?Lzdla3RJNXA1bENQOFk1QkRVVmU3T3B1Rml0WUY2VG4zSEF3WEFaZEJxMVhm?=
 =?utf-8?B?KzZGVi90clE4b1NPaVM5M1F1OGZab0xLQzJKU0xHMTZkTjNMQ0VjRkgvWi91?=
 =?utf-8?B?NVo1ajFIYnNBVFVVSW1IZDVYd1pMaHR5YUtPL2ZMVy9sRnAyTFRDUzN2Y1JJ?=
 =?utf-8?Q?a5jklfsrcxPlF?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5055ffdf-0315-445d-9a8c-08ded720e658
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 03:29:04.2425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6279
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hotmail.com,none];
	R_DKIM_ALLOW(-0.20)[hotmail.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ltao@redhat.com,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:linux-riscv@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:kexec@lists.infradead.org,m:bhe@redhat.com,m:zohar@linux.ibm.com,m:roberto.sassu@huawei.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:linux-integrity@vger.kernel.org,m:pratyush@kernel.org,m:Markus.Elfring@web.de,m:kernel-janitors@vger.kernel.org,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[nutty.liu@hotmail.com,linux-integrity@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[hotmail.com];
	FORGED_MUA_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,redhat.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,kernel.org,web.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nutty.liu@hotmail.com,linux-integrity@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9859-lists,linux-integrity=lfdr.de];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[hotmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E964A6E9795


On 7/1/2026 10:57 AM, Tao Liu wrote:
> A NULL pointer dereference issue is noticed in riscv's machine_kexec_prepare,
> where image->segment[i].buf might be NULL and copied unchecked.
>
> The NULL buf comes from security/integrity/ima/ima_kexec.c:
> ima_add_kexec_buffer(), where kbuf is added by kexec_add_buffer(),
> but kbuf.buffer is NULL.
>
> Fix this by simply adding a check before copy.
>
> Fixes: b7fb4d78a6ad ("RISC-V: use memcpy for kexec_file mode")
> Acked-by: Baoquan He <bhe@redhat.com>
> Acked-by: Pratyush Yadav <pratyush@kernel.org>
> Signed-off-by: Tao Liu <ltao@redhat.com>
It would be better to add the log of the dereference calltrace.
Otherwise,
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>
> v3 -> v2: Add fixes tag; Replace "reference" to "dereference".
> link to v2: https://lore.kernel.org/linux-riscv/20260627222602.23594-2-ltao@redhat.com/
> link to v1: https://lore.kernel.org/linux-riscv/20260529032739.13264-2-ltao@redhat.com/
>
> ---
>   arch/riscv/kernel/machine_kexec.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
> index 2306ce3e5f22..afc68f6a4aa1 100644
> --- a/arch/riscv/kernel/machine_kexec.c
> +++ b/arch/riscv/kernel/machine_kexec.c
> @@ -41,6 +41,13 @@ machine_kexec_prepare(struct kimage *image)
>   		if (image->segment[i].memsz <= sizeof(fdt))
>   			continue;
>   
> +		/*
> +		 * Some segments (e.g. IMA) reserve space but have no buffer
> +		 * loaded yet. Skip them as they cannot contain an FDT.
> +		 */
> +		if (image->segment[i].buf == NULL)
> +			continue;
> +
>   		if (image->file_mode)
>   			memcpy(&fdt, image->segment[i].buf, sizeof(fdt));
>   		else if (copy_from_user(&fdt, image->segment[i].buf, sizeof(fdt)))

