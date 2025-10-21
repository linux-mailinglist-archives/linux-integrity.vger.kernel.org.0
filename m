Return-Path: <linux-integrity+bounces-7511-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E7BBF687A
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Oct 2025 14:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF28850588A
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Oct 2025 12:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0293321DE;
	Tue, 21 Oct 2025 12:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="jJ7yrR9Y"
X-Original-To: linux-integrity@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010070.outbound.protection.outlook.com [52.101.69.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3404D3314DE;
	Tue, 21 Oct 2025 12:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761050783; cv=fail; b=fs5o7DZJYgEyw7IbS+Rf7+D83oRRuGErGlqSbC3ZwWcFQ63nOs9LUn6a6lN6ml2gRQzt5fYLP4TTZMYDYibTfAXOvlqLDw7Lt1eRVVsGTF704sRR0sZuCodciNzY3Y2dWYFCI+zMz5KAQm3AU/0PGz/HopNf3pz7UQDLEPU6q9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761050783; c=relaxed/simple;
	bh=rKFDNRUaqofbunaMhOcxPDHiwF+1rv8fo9cPbGBD5gw=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=JjKYAzu+z8FF9L8YO4fyZEzX3jRQkqp+8255jtH0p6wv+HVyrMwewNiBFlffDp5S4QbIlGRZSzRQxCsbdjnCya86OeGaDe2YjC9DjhRc5Sp+C3J0dQgdiH2ReMfczKrZxKDZSCBl3jGfz5rkzdjpQGjplMUGTMXTSJtth/YACuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=jJ7yrR9Y; arc=fail smtp.client-ip=52.101.69.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMZwRYqeG+OSbJegJIeaDTCMd7+1vvcGeHrpE2p3Wxk87ziSkjN9WyDH1JIElPw/yiW9mKoQimvs1yc66aUZ3BNjlQD3ZlM+cAS7SazJyRJqG9Ndf7epO3KhxYDmhApugC/pB7X8lzmfGEmOJWPIrxmTolUbmL0Y2oplXjyy600lv1q59sMv4FoRkgjt6g4rh2+dY2z/W5cZA46UNuo+8tPH3QJ/QEteVi4PG8jYDk172177fisInZ6zDxaWLBndn46Cm/RNBLlpg+SibzVhf+QpzW32hIx16beAh8YW2B8K1e9pKH2BWFrKeIjK4H+AUwPgQM2s3QFpzOmsEhYz+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PD/rWWf/cmzpL0oDg+SI2HgDKqI+QHP1IlyXBTQ58pY=;
 b=ln+377udcpJozDO+f/BPoez1OgL9FkPr0pq16TpeeZRt8HQcUigPjH8azvoEXBPuCsmAJ42X6lseVtYY9YBQ6ejHXUtnkRl7NHw/pfpt/Iq7bswzPa45ndwt1xGuypKJ7jAmM6fB0reP3JVzFUd3dLQyyc9kVoInemiTN+7Wrx680fYlLi3cvCU3fsgnRTVlQOwX5C5oLsa/nbdSrk+qEoGkBOV2zewzOEVYA4ichRLArFS5MSTuvMzG0/h7sOnu6qa8ce55GbocxbvFCRBDHxXseCadFSJRT/SY+T8bcl28yVefj12TuuB+vpyyqZn2mXXHIARP8r12Gn8hAgMIKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PD/rWWf/cmzpL0oDg+SI2HgDKqI+QHP1IlyXBTQ58pY=;
 b=jJ7yrR9Yap/hPFZw1rbtysEByESTNL0P0gGkZ/iXYQ4J5iMMiUIg2Cn3GFAzjdZJGbqLSyBnrZJwT3tllAbO+77q2LRUZRuYLBBVuxpB4unabECGQ8dL0ojScbVBzfBuJ8A0XQYtb2drkXTfNwIgyjS2bIkuDxLoDoJ7k6QskRzqnT4jRTzHLM0W1CRLQpesP8/iaT9TQRptKbUJnoeXYNSvwLgvm12eOTXgimvzO0n26I/kgQYdJunW86zp14nyFv05BPwU5X8rxa07LOCwB60Cx9WyPBuHs9hQd6cKWzTVh1Lf2zON82zN+fvQp1Yko9AIXCmN48zyvW+Oo0v2hA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB5PR10MB7890.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:48f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 12:46:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9228.015; Tue, 21 Oct 2025
 12:46:17 +0000
Message-ID: <bbc41534-a2d9-42dc-ac8a-ff8a0b4fd41f@siemens.com>
Date: Tue, 21 Oct 2025 14:46:15 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] hwrng: tpm: Do not enable by default
Content-Language: en-US
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
 linux-integrity@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
 linux-crypto@vger.kernel.org
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0398.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB5PR10MB7890:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ca769bc-5f2c-45f9-09fa-08de109fd394
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eUZRZEVIc2RFVGt5aGRMVFhIU3haUzQ5UzcyVGlQcU4vaVpSVEFDcDUxVDhN?=
 =?utf-8?B?ZmVXZDBOUUVrL2k1N0FBSTNVTnp4aW95dVhYYmVvdmhCLzVSS1Rqbk9uTERW?=
 =?utf-8?B?MUlOOVBKbHA3MHJWVm05YzN0bk9UNHpqeUdYRDFiUmpUL2VodDUzT0xSb2V3?=
 =?utf-8?B?VjNBRkFUUjZ3RXBmci9iL1U5SWhoRHJ5eFptKzJTdUVzeTBRRlpVMVo2TXNB?=
 =?utf-8?B?VkMvUmhuU2JKdnZpR0VjVkdmYUFjSGZFSElHU01jWXlURWJsZit3Mm9meTdB?=
 =?utf-8?B?KzFXSWxCb1Z3YkN1dVUxK0x5eU9VT21ML3BvbUFaQ2JCeEh4WEhEaWxGamZw?=
 =?utf-8?B?Tml0WWczMFcxUStBOGVIZzQ4UmF1eTJwMDB5VS94dmZoNFFTdTlqeC9BYklz?=
 =?utf-8?B?bDYrZ0U5S0FKVnQ2M1NlMWNJd0pmcWVPWjQ3YUx3MjhPbFJCVzJCMEk4U3dC?=
 =?utf-8?B?MEVDS1hBbmJxTkNZTmJnUGE1Vmo2OU5DcWkzTmg4dGU2K0xlR1Z1MGt2am5Z?=
 =?utf-8?B?M0FzRm12UkJESTVROWo2M1d5V3VaSkJtUUgwaXUraVg4VHdCdDB5eURUOWI5?=
 =?utf-8?B?cmRNTTBuVFM2YUJSQWlPWFRGMThLQVptLzVMNHorbElzZlNKVXhLbWtJY2lH?=
 =?utf-8?B?QkExSkJ2YVAzOUdtWmRDL21PS2p5TWRZM21XRFN5SlFEalUwOWRmNko3bFdn?=
 =?utf-8?B?V2FTUmJKeUYzTER1Tm0vUWpFQ0IrVVZaOXVrdW9rU0thZ2sxNFVXYUVaeWhz?=
 =?utf-8?B?YllWSDdPNDgrL0RibFdnNmo0NE9Tc2ZSQkczczY0ME5WbW9NZ2xjQ1NrRXNX?=
 =?utf-8?B?eGk4TUM3bzY5QlB3dSsvbVI2QlN5OE84YUVNY21MVjFJTVZmSmh1bGZ1dEtB?=
 =?utf-8?B?Z0cyQ0p1cWlJb3U3R2E4cXhrWWwyQkhoVUR4UGE3STZvdmJWOURjLzBEZE5k?=
 =?utf-8?B?VFJhaHlyd2NwendHTEgxYnhmM0lXblZVSWJEUHY2MnJTb0grUGo5RWpYV040?=
 =?utf-8?B?NEVHUER2WEFHK3VWZ0RYNU1PME4xRS9jQmM2OXZ5NFFXdi95UmZudDVRU3hI?=
 =?utf-8?B?TlhobTM3RHhvQitKcWMxbnNRdWZZTUlNMyt3MXZ1VnFCVEkvR2JQckhYQWpF?=
 =?utf-8?B?NzRRZzgvWUh6US8xc3FRV1dFVVp0bjVYcVBZSnRWRklrMmI2cmtGb05qWTBI?=
 =?utf-8?B?MXpUMEFzQTVKTU9YSHpxa3UzTE92ZXVFRVRzTmY3aXVKOHQrWTBzekVPWWtJ?=
 =?utf-8?B?NmNMNUtCajAzdHNMd01PZWVUZGxKTjRoejV1RUZ3S2RXNEdhVmw4dnRtTmdB?=
 =?utf-8?B?NVZFd2Nob3locllTRjhpNEJVdXZ6cEJGMVFDeWJZUWxxNExCOUxoUE81VDV3?=
 =?utf-8?B?R2c0TU1pVEQvTitMSW5kbkJMKytHTXB1SFlZdGo2R0tPYzNOY09NbmljVXlv?=
 =?utf-8?B?Y2pGRDN1bWFhT1h6ZjlNMmc1UEc3UXpNL3VITGNTN2hhSTVDdTExeHZHT0tn?=
 =?utf-8?B?bVF3bGd4UjlONmVHenY3UmxkVzNnR21aUGR0YXU2Mi9SOWZoTlZHZVRWOFJz?=
 =?utf-8?B?VTlvRndFbHZXTEd6RU1UbDVzK2xZRmxTVWt1QTNUMzErMHJ4c3JxbTU0OUJV?=
 =?utf-8?B?MHN6eWlqYzl0TktiUEkwY244bytQZWtaa1cwc2duV24zYkJNT0t5MHMxa3dm?=
 =?utf-8?B?UU9qVHRUNElqRVRaamFXY0t3T0tsRnAxaTl0bFIrQ25jYWppSWk5WkFicWF1?=
 =?utf-8?B?M1kvT2hvMXJqN1dzYi9KUGtTSERld29SUVhZVEIvV2FIRm9QMVZUWC9UT3kz?=
 =?utf-8?B?ckZWZkRSYVZaRzhGK3NWYjZBMEpPMW5GTGNVeGg0MGVQWjltYlVaMHNXSGpY?=
 =?utf-8?B?OGFJTmUrQnIzbzNqN1VyU2I4ekh0Qnk3bDk2YkZ1SStPVUcwdkI1ZWtvOWNO?=
 =?utf-8?Q?ejUqVqR4/qJ1tlPlhWrEFuS1h+wfwAZo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUxpN2sxdHd6NGZUclRtR3VVRjdaYWc4ZEFnZmNka2FHUmRwWWx4TGZaUmsw?=
 =?utf-8?B?R2xybDEyVk5mR1o4MnM0c1dWdFpwWnZYc3pOa2xLS082ME84QVJXR2dRSnhT?=
 =?utf-8?B?K1Q4R1kvelpmMlFWTmdiV3JDSUdVOFJPSTJHcGtOOVJ2L09DZGdRTnUzeTRG?=
 =?utf-8?B?VUZwU1N2V0wwS3JxNnpKYURrd0RlSHFpM0lCeERGUjJPRUlSZThCT2xQZUMz?=
 =?utf-8?B?M0JCbFV5S1JnOWk0SktmOGlpckFKTjdydHNmSmQyUVBnTlI2cTZJUzl3Tzd6?=
 =?utf-8?B?Qm1OWVFER1R3QTZyL3QvQm5rQUU0YjFPajQwOEJFVExuQW9XOTJ6ZWR5T1FM?=
 =?utf-8?B?RGVPNm5NVEJ2QVU5WENOdjQrcnlXZlMyQVl6azlpY1h0NDEzRjZabkdqOG5v?=
 =?utf-8?B?dE1pS0hXVlk2Y0F1MUxncWtoeDVRT2lIM0NvanFXRDBPRjJjV0NKWG1PNlFX?=
 =?utf-8?B?VlVTekxMTWxlMjJVWGloelNhRDczTjNUSG45REZidk1STmk3bGx1c2V2YnA4?=
 =?utf-8?B?R0hqYVJjRGZ6M0NSUDVTRVZpUWNrN2JSa2wyQ3UwMUJpcXJUN01FcmIrYjBx?=
 =?utf-8?B?OVNMTUJBcURRQU9CZ2dsMUhUL3hqejZsaHFUWmZMSTVEWmEvTFBpRDNVWFFH?=
 =?utf-8?B?eFdNaGVIWmppZWNjM253dS9iWm85UThBUFFIazZ4MGFSbFIzNjNHczFEOSsr?=
 =?utf-8?B?dXVNOXBjSWtPeE1abldnd05WMktyQXBPVEdYZEdCZFZ1SzVxamtBa201YVlH?=
 =?utf-8?B?clRJUitvbzhXUXVTOXhrSTQwN204emoxTFR5eEFsUFJ0TzY2WkpEUmpSbkp2?=
 =?utf-8?B?WmJJTFpkQnFHTDRQK3ZaZ2xFaVh4UUdkbkVXSUQvYmNvbGlWZDh3TFhLdVpS?=
 =?utf-8?B?bVJEcmUyaG42eWpZVmxvOFJGWEUzK3ZKWW5tci9pdi9yUUZlODJoaGZ6QUpl?=
 =?utf-8?B?RjlYQVFsL0UxSy9zYlg5SjRGL1JUNE5JQzBFYXZIa3dhejdKaGZaSk1qNW0y?=
 =?utf-8?B?b0NsM0ozV04zaCt0YUJpTExvSUVkOEdYdzEyWXE5N2JxZjVKSktwdUVHMEZu?=
 =?utf-8?B?YmRJbC8wS1dsLzNnVnpMaFBPeVl2dFExZ3RqNlRMdVFJQTdYVzVYMTYwQzAz?=
 =?utf-8?B?UDhGbGxnY3VkYTh4MFpXbmtGOFNVTWtxUFRNSFhMczM1VWM5U0x3aERqaHdJ?=
 =?utf-8?B?b0RjbE51K2pVblNXZHJhMVMwZW1oODd2dnlRTnJZTlFubHZVRCtpdGg3UHh4?=
 =?utf-8?B?TGtlU1FFRnNvN1dadWk2eUlWSit1aWhkRU1PZlgxOFd0aCtwMVVsaEwydWx4?=
 =?utf-8?B?aEVMNnRJdnlZVDV3WnRHRzQ0UTdZTDQ3MFpDcGtxWkJyaUJpdEN2Zm1teVVq?=
 =?utf-8?B?K0pzRnB5aFBYbGtYUGZNNi9aaFc4d0tycXhKb09qdmxMbk11MDAzUE9OYUM0?=
 =?utf-8?B?MWhhMjFQN2lTMzl3WDVQdFg5bUx5S0QzRGpaTXlsbFVQNWN6WldDaHl2ZExu?=
 =?utf-8?B?NllPcTc1QnhLZHRRSjZUVElualJPRk9XR0JrMSsvUVZSUjFGVjBsWlhyN0tJ?=
 =?utf-8?B?b3FQQmo1NmJmR24xb0lISUZoMi9qUTQwSndaTExsZmxLSWVaUTV5VGx0T0JH?=
 =?utf-8?B?Y2xqUC8ySXUxOWcyUTZTNUgxa2tTRXpsdmYzK1h6eDhvZXBQR2ZvcGpLVzJP?=
 =?utf-8?B?WW5UOGk4bVdTSWQ0UThreFE2SmpZaUh3YWF5ZnJZQUpFdGFPSUV1R0plVCt3?=
 =?utf-8?B?TWk0dEdVWkZkcVpFdmNBZ1YrVS9GemlITEVTVEc1UUlsZzVKRFJyRS9Lc2JB?=
 =?utf-8?B?WlplU1V4cFQxZ0x6OURzLzFhQ3RxWkNDZHArY3Frei9JZWNqUFZDTEoxNDRw?=
 =?utf-8?B?SFMxMkNiNC9weVIrUUFGUDQ4KzhtZC93ekZ1ZmI5aWtCcTl3VHRUc2FWSVhV?=
 =?utf-8?B?SnFSUDFUMGdzeTVWNFJoMndPenoyR1RmOFcyWFBNeVhKTVNFSGs2NmJ5S01R?=
 =?utf-8?B?b0E5NzVJbjFmKzUrQWQzamdicmdab2pLL0xLVjkxU2JtNHRIbU1CKzJhenhw?=
 =?utf-8?B?MzlYbm9Uc1NST3FKaERGYklEUkI1ckczRVROK1FnMjRiWjNkeXdWZkVJd0dC?=
 =?utf-8?Q?GrL5u0E0NdJN1sfqHhcQ+BiNa?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca769bc-5f2c-45f9-09fa-08de109fd394
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 12:46:17.0835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: acsGeyUX9iFxSe6MadRtsCIWeiEg/Ie5zeKQRd3GpOvLe3GxebPzZ4feEiUSEk3ZsL1QeguNv7gV1AwU2o1aAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7890

From: Jan Kiszka <jan.kiszka@siemens.com>

As seen with optee_ftpm, which uses ms-tpm-20-ref [1], a TPM may write
the current time epoch to its NV storage every 4 seconds if there are
commands sent to it. The 60 seconds periodic update of the entropy pool
that the hwrng kthread does triggers this, causing about 4 writes per
requests. Makes 2 millions per year for a 24/7 device, and that is a lot
for its backing NV storage.

It is therefore better to make the user intentionally enable this,
providing a chance to read the warning.

[1] https://github.com/Microsoft/ms-tpm-20-ref

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/char/tpm/Kconfig | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 8a8f692b6088..d64c929cacbe 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -45,13 +45,17 @@ config TCG_TPM2_HMAC
 config HW_RANDOM_TPM
 	bool "TPM HW Random Number Generator support"
 	depends on TCG_TPM && HW_RANDOM && !(TCG_TPM=y && HW_RANDOM=m)
-	default y
 	help
 	  This setting exposes the TPM's Random Number Generator as a hwrng
 	  device. This allows the kernel to collect randomness from the TPM at
 	  boot, and provides the TPM randomines in /dev/hwrng.
 
-	  If unsure, say Y.
+	  WARNING: Specifically firmware-based TPMs, possibly also hardware
+	  variants, can wear-out from the frequent requests issued by the
+	  Hardware Random Number Generator Core when filling the kernel's
+	  entropy pool. These requests are sent once every minute by default,
+	  and the TPM may write the current time to its NV storage for each of
+	  them.
 
 config TCG_TIS_CORE
 	tristate
-- 
2.51.0

