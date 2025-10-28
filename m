Return-Path: <linux-integrity+bounces-7539-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEC6C13026
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Oct 2025 06:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6937B3A4EAD
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Oct 2025 05:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D46629D27D;
	Tue, 28 Oct 2025 05:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Th1tN+Ak"
X-Original-To: linux-integrity@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012043.outbound.protection.outlook.com [52.101.66.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EEE29BDBB;
	Tue, 28 Oct 2025 05:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761630406; cv=fail; b=gsI63v9Cyc8T/n2DTntNYe1nzAkIJIHkCU2rikz5ZU6inBfh3TuN00Zegz7SQ2497UXwhEs/Rclx/96x0DLMCLahJNNoJybE0pAufWPxarYhHcrKLjZ0qbVYn4Yy0++y/9NVIjh7iaHp13WAJGpm9l0+XZs/czUR9Y5csZ/3f1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761630406; c=relaxed/simple;
	bh=x7QhFXvoTdog7jcikrnbnwmtxBFk2jpskBaoUNi0xOI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EBdrJGdAt0C4B2dF1+vRLBL3N8AXfuWIEATgPMDQvzuQYkPCmuRx+No8BvY/pd/y27ENIuS2j/a/Kaz8ikIDr6fCFvY8H0EvDn03xu20BCgn4wOYqUiWb4iEXVJ9hJG6lpDcdnTMUDqYU83BUKemu70EfFThH0W84Ib8VUxHKFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Th1tN+Ak; arc=fail smtp.client-ip=52.101.66.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MhVPMT9oNxej3vsjOVw2leZ5Rmm55g8ek1iyzqeIulujP+og3VD7UGVVNbv6kffj07ezje9/rHTVjqwDPI8TDPWuilG5Rs/U42Mrl/fuvqPV+BTMop23qXar68KQ/fHfzVJ8q8kFjM9owcIjTPSIoslrsVNoeXouB0EijWQGgawkaLO6rACcje9Dzu1B3bmJtQUBHvGDuXiqSSq0dAibIsk2eyEG9LswdMTfMIqLLnJOXHK9MjwSr41CWETlJ8ZNbyyzD7W9UejHgTbEGLcXiEz/Rm2ZLZT8EeU2LCAhZsMj7LS838EWufht5bRO6M7HZGeQdlSLDZB+wX8KpT9aGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5IxQCAc3fMHoLbAhF7PuaFZjsdpKVZ2UNdSd1h/rS0=;
 b=demTTp+v4sWt9Yh38+Pe4xN26Rlsq0oAkxw4Ps8glM+KrWSyGOqgS4q4r9pzi4M73xBulX/33CoH5j30RP/NSnilbN/fwh1u+e/1gyO1uN9eykT6QFHsKXyv3cdJiALHF/bhs6xxzs3FmZCzjGfBW02NW2zWknZtdoCJFKzzmpKvVZ4sTGU5737B2p5bmpO9O5g+rSONRpLvu5gC0pjOo1Z4nt0ZDAiKSDG3jQTe0VHLd09TK4b8pCysKbaiFGYWjGrp1Tcei4YJwcmjZ7VmkBrSBIkGNNn9IiDV34lI0xmuPg3+2BIzc+9zVjEvcrDFWDQBVx0wNFvP0c7F6Emwcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5IxQCAc3fMHoLbAhF7PuaFZjsdpKVZ2UNdSd1h/rS0=;
 b=Th1tN+AkIXysihzBz/9A4Qc6Yu9lCfcnBJYzxH6slEomEenz6hOxafLhYMYoWWsDP1mStr0JMT9VHbZ8AG02KRKuM3VxkWDvntmLPuYZ3mfOK9X3nSsxCNVVhbT2lMc4ITNteF3uIWUXTTp25R4MFDTuDDlxpzx4mrvNELEPhAoq9fC2UgRVRwjbwE/LqLWtUjIxNQOXTR1sdW+O0to05s4d2/uQd8FhZHh/9VxaoYGMm6Nc4nFVsiMLEh1IBvXypuD10X2omrcfWhYFFrBzyFUYSGpi6tnhpjkTpOkqUfQc6g+HWpEJInd2i+tbNfswbUy5Svs9058Q3o2kdeRmLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8457.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:441::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 05:46:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 05:46:42 +0000
Message-ID: <9cbee028-81a7-4be6-aa31-907c7cc683e3@siemens.com>
Date: Tue, 28 Oct 2025 06:46:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwrng: tpm: Do not enable by default
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
 linux-crypto@vger.kernel.org
References: <bbc41534-a2d9-42dc-ac8a-ff8a0b4fd41f@siemens.com>
 <aP_NN3HwO4Hp0-9T@kernel.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <aP_NN3HwO4Hp0-9T@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8457:EE_
X-MS-Office365-Filtering-Correlation-Id: 12bd7b8b-9cfa-40d7-ffb3-08de15e55f18
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVNpc2E0b2JwN1lmOWJtTGlzL25HNzlqWDhBSUtBa0F2QXJHYVZUSUtqdXZv?=
 =?utf-8?B?SXF2bDhOTXo3NXVOeWlrTE9kY2tYUWdVTi92cDVNalU4b25KSEZSTUY0RXpl?=
 =?utf-8?B?Z3BDUXhCMWxUZTc3QUF0Z3FwVldnc1BkNFo4bEdLZVd5MjI5VStqMkppT3ZZ?=
 =?utf-8?B?cHlMTEJXWTNmWGE3NTBBU0lON2wyYWJkanoweFdkQnhYYzN5anpBZHhYTXpV?=
 =?utf-8?B?TTgrcStydFI5SXBKTkYzY2cydng0RjZ6c09ER0hLOEdmdU05SWVycE1zekxR?=
 =?utf-8?B?UDdNREtYYjQwbEYxYm5pL2NOOHJwQjN3Zmg0Z09kOEx1UEhCdkFpby9pdElU?=
 =?utf-8?B?RTZmMytOdE04bTY0cVZtZk5Ea0ovWEFFYnlDaVcrdEp3SWJOQWNUbHRtVkw5?=
 =?utf-8?B?OTExWkF4Zk5HdWp2MGJTT3lhRUpUTUc3TUJBQUttV3hPUnRsK0ZaWkFMd2lV?=
 =?utf-8?B?alJZcXZrTE5CRlBydEk4b2NsczBjM2NaaFFqUVhWblNSajZNYi9TdTFETGpa?=
 =?utf-8?B?NGJ6V29TcWRPd29lZTFWVllpV2hmelVxelNYcFZpYlRSRkY0MVNVUTdZZU9k?=
 =?utf-8?B?NktrZEhob0dxQVRFNFRuZDNZeUNGRXZEbk9MNnQwRmtFMGhuN2wzQUZjY3Rl?=
 =?utf-8?B?WngwekVCS2gwWWNOM3cvYlVBQkhpTEFFL1MzUHJkbHV6VnJnSkFKWDJLT1NP?=
 =?utf-8?B?emFydjIzRlY5TURFbElZSXZhb0VJdmtJd2M0SVltWGRxbW02OXZHbEZKeGVV?=
 =?utf-8?B?TVArOEE4cjBJd1RLanZiTGx5Vms2dDdiVWJsR0tyRG1vdVhVMUo4TXFmSGZo?=
 =?utf-8?B?K21uYldGeldNYkdXQUJqcldmRHVPWGdQc0JWTlNBSUhvakpjbms5QUN3d05C?=
 =?utf-8?B?dE5XRDgxd3FWV2lRZ1hEdlRlWjZNV3VEVlNSU2hSMkR6TkExUmJsNG1RQkpD?=
 =?utf-8?B?c09kUUFka1I1MHIwM25RdzF1cFBwR3NXOUFYUE9JVTgzeDFQZ1ZMU3BOWFpx?=
 =?utf-8?B?SWhMOW1wUnlzMWV5Nno2dzU0TGhKQnZvZ2x4alBlKyt4MWFwSGJVeEptR0o1?=
 =?utf-8?B?a3ZtSjBhNzFCL2MvZzNmcVlqb3BCQTF6T3d1TlUvM2xyOXByY1JQZ05POUpz?=
 =?utf-8?B?aEcxd3VxeW1lOW9ETVh5LzJEM0wrS0ZDZVdienhETEUwby92a2lKeXJlQ2ph?=
 =?utf-8?B?cEJjS3YwaC9WUGk5b1l0cVdlTE8xbTlTditldDN2VzVzdDQ4L3Fva1JLRVlP?=
 =?utf-8?B?bGNUNk5mZEVEK3luN1UrWGM0M1FOMHBtMm5NTXZuN1EvZjk2dzhEVnJkejNw?=
 =?utf-8?B?KzJqRStMWnl2N1ppc0lValVMS3RMOElMVHM4RzF6eU9xMnd3ZWZFR2JuR0h6?=
 =?utf-8?B?Q0NQNGJrSHRVSjFvaUhsRXo5MU5TTHRSY0lKVXo2dVd3eFh3MmNxVXlGM3Ux?=
 =?utf-8?B?RFdFdEJDRmVJZlhaV0xaamQrenBMWVZXZFZWTnptclgwa1ZLVVFXa0lYVUhL?=
 =?utf-8?B?SVNMa2lGSXZlbWRMZEN4bjIzZEtCVEZoVjE5TmlpcVVhcXFKWE9qSmg2SWpN?=
 =?utf-8?B?RSs5cmVnQ2JEVzJKTW9zSWwrejZCNnFwZ1dTN3ZOVUtqYkd2Tm5ZZ3FXcGlU?=
 =?utf-8?B?eUp1WlQ3WnFYSHRkcTM5WXhjbCtGZXZLMmtrWWU0bGNQQ1Z1YWk2eWdoTUFN?=
 =?utf-8?B?ZU9DYUlxeXUzSU9UYmtVVGROeFlTRXBaUlFKUERyRnZDNVh1UTcxSE9XNzdZ?=
 =?utf-8?B?ZnRuSlNQdW95N2pOOFUvbjdkMVYvUWVNLytJanFQTXVwdWpJUnlIMWVTQzd5?=
 =?utf-8?B?Wlg3SGtwcEZGbmtkRm9tK3dKZzJZMTd1RWVTMFBldFZKMmYrakQ5SmZZSXov?=
 =?utf-8?B?RXhKUlRJSHRuQUVsS2lxTXREWFhGUkxPcUhCcXl2ZnoweHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L00zbkhMTkJHUFdpWk9HRHl2dTdScm1oVFNmOHJkREY3QUVxSFhtRERLeHd2?=
 =?utf-8?B?SEJPZW9OSjkySUw5ZWswWXZiMW1VaDBuSVdvSnczbmJMbFN4SUFSTnFTeU9W?=
 =?utf-8?B?SHo3WnhNQVVJN0ZIUUNMSDk0TmVGN1h0cjF3bTV3S2ZhYnZVNDdtMWFJa3hU?=
 =?utf-8?B?SWVod1BzMUJFWXRFUHROc1ZtQkZNOGNneEZPa3VINnhBRzFQWDZWN3NyUG81?=
 =?utf-8?B?dExkSExKMEQwbnNtaXNlWk1zaGxGcDN5QXZIeGkvbWRGeko2V3J6YXlyWnF0?=
 =?utf-8?B?YXpKZmdITGVrWnpyY2lVQ3JodTczUHVDUGp3eVE3RHk2eE55WlhTVElYa3ZF?=
 =?utf-8?B?ZUFVVUpvU094RnFrQ0E4TlMrczlyUXh1N2l2RnBEVVpVZGdjT3ZFNEtaL0tU?=
 =?utf-8?B?SERrTE43eU9KUHg0SmZ1UFRLWVFLTWRHVDAzaENnbDJ2UUdWejF2R1VTOFYx?=
 =?utf-8?B?VTU3Z1pDSlg2ckFBYUxmNFlMeW9Jc0plaktpRiswbUpCZVZkcHY2VjhsejdX?=
 =?utf-8?B?STlUME1sWWRpQzcrWElLY2Z4SVIzTU9vSkVaWUJ5QkVtblhtWjc5WHRBQ0ZP?=
 =?utf-8?B?djRxTHZTV2lEaHVyQUJUT0tqczBRQzc1eUFObWJSNE9kSEkxQ0FCb0tpUHkx?=
 =?utf-8?B?TkQ2NTFvMjNMaGczQWpOUDRzeVBLbzl1WkVWNkhLcUd1cHhsY09ESVRTS3JJ?=
 =?utf-8?B?UURIZnlpMmNHYTZrdzdBRWYzNCtzL1hOK0JVeHVmdW45UGVDYU9MVHFpNkpI?=
 =?utf-8?B?ZnpLTTlkREpOK2UvczNrdmJ5TlBHdWhzN2ZTRktFUGtWOWZUa3hKNFUxaERl?=
 =?utf-8?B?aGFqSjdNRm5MYW9kK3VyMS9uVnVtWGNwOFBqSnp2TG9KSC9nL2xlVFU5ZElC?=
 =?utf-8?B?c3FveXBvREVwdFI4V085dm9HUmR6N2U1c3ZpcER0UExtb0hOMlB4RCtUTytO?=
 =?utf-8?B?cnJRM0RKRW5kV0ZiWmE2UnNiNlA3WkVISC9lc2JHSUd0QzRGL08yMEFKelNP?=
 =?utf-8?B?a0w0TmhxVjZXM1RDU2V1Y09PdjFCa2VlYnZIRy8vWDgvamVTZ1pOS2IrZDhQ?=
 =?utf-8?B?Q3hycUxMZk00VXo1ODdoTG9xZjBIOGlkQW41Z2hIZHk4RytETjN5TkJmMEhL?=
 =?utf-8?B?dzdtRGlCMVBsMzMySnV0aDBKcFlxM2tDN2d5ZVhnRlpFQkhOV3FUUzBLeDAx?=
 =?utf-8?B?c0Y2c09zYURhWjFMblZwRHdjMHlHTE1mVzM2YXo5V05LWUh6b1ByN2d0eFN6?=
 =?utf-8?B?UFdYNE8xTmRjZlhoWVpKUjR1MVdFR001ZlZZcExRakY3UWdhenlqTEpVOVdI?=
 =?utf-8?B?MmxGVEJacUxaRy91bVBObVZ4TzMxUGdHMTFBL2thSnR0VlRXWU0yZnFrbko5?=
 =?utf-8?B?TEtYeGY4QmN6RDQxWmk5UzZBRlgyNjVyMXNnTWFJTXhpNDdYdEFKZkJJaFhq?=
 =?utf-8?B?QjF1bG9SZWJNdHYxdHpCMlV6MkhJOXA0TjdRZW00bTVnUHBqeEUvdnQ1enRM?=
 =?utf-8?B?RFdwNXlFMjR4T1E1a0lYSlcxa3I1elpadFRPbEJOdUlBRURqdTRvUTFES0lx?=
 =?utf-8?B?T3Z0UWVXZXZrOTY3akthWGVXaDROMFdUa2kwa3VvbFJMcFR6RklzQ0Y0eG9m?=
 =?utf-8?B?bll3cUtITzJ0Rno2R255bllpVjlZcHJSQTNieCtGQjg2aHgyWkJyMDA0eVI5?=
 =?utf-8?B?b3BQV1hLVVArbjNITXpNS2ZjdkdyNSs5T3ovTVhpb2gwRmh1WEZPOFhwTXZO?=
 =?utf-8?B?cmtHSWg3QkR0Zy9YTlVOVnpFcGlHTkpUMVFwN0xEQmZ5eldqUklVVlR1QXYr?=
 =?utf-8?B?RmZkSTV3cDhMTFNhT1hoc25Jc1RKeWFEcW82Z3Y2ZFZpeTFHWExjUTdNQXl3?=
 =?utf-8?B?dEdYU05UNXBPbTU2OWhiMzBGMWZ5ZE9POUY5bjdIUGdJZXBPRFhSb3FOK2NB?=
 =?utf-8?B?NmdpRlJuckZXd3RlVEFaeDY1K1ljb2RaVWdxbGpyRTczam9XallveThzQWI4?=
 =?utf-8?B?NmRLVFRaUytERFVMWERmU0pXSmd0YVN3eUJNWnY3dkVVdHFwaXRZb3hsR1Js?=
 =?utf-8?B?dHF4VHNFSVZMRmUva2VZMkxESDJ6NEpGeXkrTE4ySVVUQTBOSUlDTUlmc0hj?=
 =?utf-8?Q?13aO3PC6JDaHlS54974gs+RzT?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12bd7b8b-9cfa-40d7-ffb3-08de15e55f18
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 05:46:42.1872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z7c2yRqFxmFb9mYFYwak3SYbgLA9YQDdHBcgQ5h3zNIr/2AxF2H/3kE/bJzhdQ3ZCzWjnTsd/ykPhz873UgqhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8457

On 27.10.25 20:51, Jarkko Sakkinen wrote:
> On Tue, Oct 21, 2025 at 02:46:15PM +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> As seen with optee_ftpm, which uses ms-tpm-20-ref [1], a TPM may write
>> the current time epoch to its NV storage every 4 seconds if there are
>> commands sent to it. The 60 seconds periodic update of the entropy pool
>> that the hwrng kthread does triggers this, causing about 4 writes per
>> requests. Makes 2 millions per year for a 24/7 device, and that is a lot
>> for its backing NV storage.
>>
>> It is therefore better to make the user intentionally enable this,
>> providing a chance to read the warning.
>>
>> [1] https://github.com/Microsoft/ms-tpm-20-ref
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Looking at DRBG_* from [1] I don't see anything you describe. If OPTEE
> writes NVRAM,  then the implementation is broken.

It's not OP-TEE, but it might be indeed an artifact of the reference
implementation that the fTPM is using because it is also targeting
simulation:

https://github.com/microsoft/ms-tpm-20-ref/blob/ee21db0a941decd3cac67925ea3310873af60ab3/TPMCmd/tpm/src/main/ExecCommand.c#L99
(Page 942 in [1])

-> ... ->

https://github.com/microsoft/ms-tpm-20-ref/blob/main/TPMCmd/tpm/src/subsystem/Time.c#L68
(Page 1075 in [1])

> 
> Also AFAIK, it is pre-seeded per power cycle. There's nothing that even
> distantly relates on using NVRAM.
> 
> [1] https://trustedcomputinggroup.org/wp-content/uploads/TPM-2.0-1.83-Part-4-Supporting-Routines-Code.pdf
> 
> BR, Jarkko

Given how detailed [1] is, we likely need to address that directly there
to avoid spreading this issue into fTPMs. Fact is, that there firmware
implementations out there which exactly do what [1] suggests: writing to
NV every 4 seconds on every command.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

