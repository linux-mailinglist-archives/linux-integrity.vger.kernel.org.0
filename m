Return-Path: <linux-integrity+bounces-8163-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D5BCF01A6
	for <lists+linux-integrity@lfdr.de>; Sat, 03 Jan 2026 16:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C129A300E029
	for <lists+linux-integrity@lfdr.de>; Sat,  3 Jan 2026 15:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4573220F067;
	Sat,  3 Jan 2026 15:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b="T2C/KDKj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020074.outbound.protection.outlook.com [52.101.84.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608B210785
	for <linux-integrity@vger.kernel.org>; Sat,  3 Jan 2026 15:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767453677; cv=fail; b=WpVEEus2co5o9peHIodQGMR4EOtpEglpRaXsYfJQ1ZJVhIWk/JJowkwfGg8ZaVvICInC6xQ7f6uMusK+EHYrP64MCYm4Xo5Jjqu0e81hAzmRPnYOMqjw40c0g0yzUd2wDkjzH9+OuYEB8QfQRJkGEmPybiz+sPboAtLgEU1H3y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767453677; c=relaxed/simple;
	bh=n0sDHtGoU83n53NNAiX4dKG0so1LQFHSrx7wvbWj/8w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u6mN9MKrC5YJu5eVAK1BtfcZsvxf6//sSGSVyDCVfK1/ibVRRR60Pxs3NQa6kNavyzSTdXbjQ9IvsT/w6ojJ5cp6V/YW+YJLaYZ0Fij+/XiK4dXZ0CB7nRdAL8E07PuvrX2D7ZmKqcmKTUOZNCeB78l8r3T2FSs9KxEw7fD5zJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=T2C/KDKj; arc=fail smtp.client-ip=52.101.84.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=polito.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RzpBFJnz+GmDeFaIigmL0t8fVLVImMU6K6yvxwvxOFeyyKi40GFubxPwzeCWy4L6f3vAOjQrjUOcg1vwvEtVit14FWBc1xdJkEDfObHlxHz3CLoUODaZawfz/zlUTCHHCj4QEJSvV7sLUL/HUKfiL07EZ8mksMQV97h/afgBo3+52eWpNKDOQT0NI1nGlhHPAadxSuwCeUMSljJuCvkAotyE09Lw4iuJLzHD+Inj+VTCZ9pkKbc5Up7ug8Z+GbLBYqVEx8Cxtc5oKzHDYu4pW+rdCoVw7v2h+yPbgqkffvu3Ru0yA0zNDK5eTTAu7+3r2l0zsGIMZV+uzrKaC5ERFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0sDHtGoU83n53NNAiX4dKG0so1LQFHSrx7wvbWj/8w=;
 b=ETbCEpVAn0sr9XWkx/Z6crzdRqupD62qMzx1LtquZLki+mu1yxQDqQGpvMmHQPTV6cyNC8DDpKOeqTzOpVC6q4oUG6LyEWKIOSb8KzCSVu3qeBk3nJAB51Q3GaJG8FW1I/IkmFJyqsHI9cA3In0wov2NojRi7R33yPDuVdI9A0zMA6K4OFiQ1HQp4/s2O+PA7JEc4GZfDxRwswRBIzW0wwVRA1qU5hXDtrPTm0fhEdpX0+YHKaN8kRSakG8ZXNep7TFdUByGP3UsqYsQx3VzspuWu+CahwTS+B+9qgMRHq1MJ9pyxIjvi0c9akQchgDG7/ya/qsO6QtNFDMcGqK8iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0sDHtGoU83n53NNAiX4dKG0so1LQFHSrx7wvbWj/8w=;
 b=T2C/KDKjudO5tBa6YUJbuQDWZJSE3x+QAsBsh2yjr6VfFO5E0iUUf3PVDdmCVQEwHETa/AVUHePZ/K+5mwCLk3oSgnkYIGqY02NBvMgVXWni/iWFG0M0mWiTis2auZeBA5DIC+LILQ9Qto+Wi3wVtlsnhPKpd0/KGGIxSsunTBg=
Received: from DBBPR05MB6474.eurprd05.prod.outlook.com (2603:10a6:10:c8::12)
 by AM0PR05MB6818.eurprd05.prod.outlook.com (2603:10a6:20b:15f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 15:21:12 +0000
Received: from DBBPR05MB6474.eurprd05.prod.outlook.com
 ([fe80::a73d:a404:f0fd:dc2a]) by DBBPR05MB6474.eurprd05.prod.outlook.com
 ([fe80::a73d:a404:f0fd:dc2a%5]) with mapi id 15.20.9478.004; Sat, 3 Jan 2026
 15:21:11 +0000
From: "Enrico  Bravi" <enrico.bravi@polito.it>
To: "roberto.sassu@huawei.com" <roberto.sassu@huawei.com>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"zohar@linux.ibm.com" <zohar@linux.ibm.com>, "dmitry.kasatkin@gmail.com"
	<dmitry.kasatkin@gmail.com>
CC: "eric.snowberg@oracle.com" <eric.snowberg@oracle.com>
Subject: Re: [RFC][PATCH v2 2/2] ima: measure buffer sent to securityfs policy
 file
Thread-Topic: [RFC][PATCH v2 2/2] ima: measure buffer sent to securityfs
 policy file
Thread-Index: AQHcbq2jEJmrl9uqpkGqK6HOM1LFW7UtuYSAgBLySoA=
Date: Sat, 3 Jan 2026 15:21:11 +0000
Message-ID: <fb6bd0b439b3665e1858488e51d88214fd4ba820.camel@polito.it>
References: <20250225131255.154826-1-enrico.bravi@polito.it>
			 <20251216165620.683529-3-enrico.bravi@polito.it>
		 <1878eed2d61b7fe3879c6d911ae709ef08089f16.camel@linux.ibm.com>
In-Reply-To: <1878eed2d61b7fe3879c6d911ae709ef08089f16.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=polito.it;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR05MB6474:EE_|AM0PR05MB6818:EE_
x-ms-office365-filtering-correlation-id: 972af187-f68f-4b44-c148-08de4adbba6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|786006|366016|376014|1800799024|7142099003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dS9BYitOTEgxaDluR1lKRmlXY1IvMTNlWFIyQmttRHBTVjM2T3BBSEd6R1A4?=
 =?utf-8?B?R3VUajlYTnVUMndkdVA0bGxPMHRQT25zSk8wYVFHTXYzeWRqaTZMNzlSbWo1?=
 =?utf-8?B?aUtGd1FFR2dyM25lV0JLVytFck44R01WTDNDeTI1R0ZkdzlLc0NjR2YxU1Nh?=
 =?utf-8?B?TWx5WE0zc0JnQW92VDQ3NmxzOGgwYTFzNGJEbmJpZHlTNDdOUERsd0RPV2pQ?=
 =?utf-8?B?R2JKcGJKSyt1OVdsd1BDeDZPM09jTC95bXgzZThLeUtrRlRXZENjWlNSSFBo?=
 =?utf-8?B?ckNGQ3N2ZXc3KyttdExZZ3M2MWdLSkVnSnM5U0FlU205bi9lbVFZTlV0VnZL?=
 =?utf-8?B?Z0k3UE16OVNoWnA1K3RuRlZYTXlNcDYyMkdaUFM1ME1GZDFOZEJxdUsxY2lO?=
 =?utf-8?B?UW9oa1d0eHRwRW8wZkdoTVlDT1lUUDNOem93dUhCUFk4ckNtN0IzTlpmOC80?=
 =?utf-8?B?RitnaTI2VmtFejJtZDZHVTF4ZjFXMUFZWDVOZ3REM1A5OTFremFxMlpwYWsz?=
 =?utf-8?B?MDFTcGtUZFgwVk5yZnF3TFgzaERXNnN2S0RVc0ZWWC9CKzJPTlp6UXVOaVdK?=
 =?utf-8?B?WmlNSHdtNEk0VERmZFQxWjJva01wR0pUQkpjemtyTGxXS3BKU0t1YlMwRFhk?=
 =?utf-8?B?dm5PakpRb1JGQjE2SlBiS21VUG91YlVQSllNQ3djaDRQMlBVMTJiUTh2UDBI?=
 =?utf-8?B?b0JmeDEyeGd4YmNzQ1c5TDFFdGZKdmxRYzZEVGJKY1lCQlRoakZqcit2ZFhm?=
 =?utf-8?B?Ymlsd0ErRmVLMzc1VllKZDVSMytad3hQUnZ2alZLZGZTL1E1aUh6dW1ZYWh1?=
 =?utf-8?B?NTk3b2lxS3JNZ2VyYW9VZzZXc3JSekNOODk2Wms0Q2VTOFIxVWh1ZDRFbnpj?=
 =?utf-8?B?dGJ1RjJ0RWcrS2d3UDNCVXBGVlBxQnRwTUtWbS8yajZVemliQkVQNkpsdGJL?=
 =?utf-8?B?VzlsMmltTDFVbHZBZE5yaHByckNMZ0h0RngxdFFST1cxR081M0pXN1YwWGow?=
 =?utf-8?B?TmVwL3p4TWZJbTk2bjk4UW1jYUtJTzVmbzZNRzh4SUxRQ0RqUHJZZmRjNEJS?=
 =?utf-8?B?QkVkSWREMGJJYjB0MkdCdXRWS0pxOFpDREpLUXI5WHdOTWMrbnFmeVhYSDJk?=
 =?utf-8?B?OTN2Q0hMcEwvV0xsbHAyMWwwREJDa2E5OW4zZ2ppd1Z3akdvTUl4cjRhZm0v?=
 =?utf-8?B?cUtBaFdNUkVPcmN6WWZNU0FZbHVOTm9hQzRTd2dHck05TGVTVkwycHR2eDRl?=
 =?utf-8?B?bVhNcitEZnhzd3RLU1ZMY0k5UDM3bHpVbUt6MHJaZERlRFEzc0o4WE5LcG4r?=
 =?utf-8?B?V1BHaUJLZk00MHBzTnlMVU9ZbkFlWmhWemtnQ05HakZxdHhta01sQU9DRnFW?=
 =?utf-8?B?ZGhUNGczeVRlWkxWNktIRVJ0RlZrY2Z6VlRsWExDUGFuT0FyZDZRZHVIcHNl?=
 =?utf-8?B?WXVDTTdnTENiWW1LaW9YdVJhcGpDWHRidVIrM3JiUHdUc05DVzR4UUp3eks5?=
 =?utf-8?B?QnZjeTE3SXhudEpvNml5cXViNEl4OEVlT002U3V2ZE5UT0FldFNGd2FraU5x?=
 =?utf-8?B?STFPemlKdEh4NGdZQ2JGZEovRll6OWFtVGRRcko0N2Y0VWVDQlhUcnVUZkxO?=
 =?utf-8?B?bDlqWGFNZlhhT2ljeW5ZMDB6dGpidjBJZzVUWlZud0g0ak8za1Q4UU16WW1y?=
 =?utf-8?B?MldrTWJhMHAxbFVCUFM3bUd5dnVSbm9BZnB2MzVqYnd6NWs4bDFQNG8xT0pm?=
 =?utf-8?B?V0xsemEzUzhpVm52dHptcitvVm5wTU13YW1EVXhlb2ZGQU5hVG5qQnR6eGhP?=
 =?utf-8?B?cnM0UTFTeGZadVBOby9iWEpVRk0ydSttK3FGaXhDWXlUTXI1bG5nYTZCRnll?=
 =?utf-8?B?NjBzc3BqSUh4SnN2d29jL1pyemFFQStUWFBkZzU2dzNTNlpNUXV2QmtnQzIw?=
 =?utf-8?B?VDFpQk5RZkZtd011bXgycUtza3FQWFRUTkMxeGpKWWIzdmN2eFk2Qmp5NHBa?=
 =?utf-8?B?RTYzVGErZ3BSYlJONFljTmhTaW5oMVQvQ2ZyQlgvUEdDMWtiMUZuRjhoVmt3?=
 =?utf-8?Q?jPynEQ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR05MB6474.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(786006)(366016)(376014)(1800799024)(7142099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cm5uMWduTXdnUCt4ZU9jQUxIbGdPU1dWLzZod3NHRU9mdXJLemxjY1VYZ3RT?=
 =?utf-8?B?MUl3L1NrZ2trUFgvZU0rWENrakFDazA4ZGxLVEhLVklTakRycFNuSVhLYit2?=
 =?utf-8?B?Uy81TUdEMnk5aTI1Qjl3czFUZWlRN3kwL0tYcGcrT1RTcUtBSVRXSE5zZTFU?=
 =?utf-8?B?TGFtUkVHSzNrK01oZHNSY3NJeWcvN01HMlROQjhwaDRBVXdkNTVFdlRQOHdl?=
 =?utf-8?B?MlJuV1NjTWdyNWlFUVM1RU1rQ0FUaCtsMXlvWU9ac2VXT2ljcGlHaUhoWWFH?=
 =?utf-8?B?OHRibDcvb3B3M1VicGszL2pnWmxQL2xPMkZuOU8xTWZhNlF2SVpxbEV0RzM5?=
 =?utf-8?B?M1lEM1N0MHBhckhBeDVKK0EzOG5GNnA2MkhwT3pZc3h1VGJyVGI1azE3VUU2?=
 =?utf-8?B?OVIwOE5wQXk2Uk90RkliNVpVK0ZRdUs4WVBzVWswNVRlVmhwVXVYa2pXeGdU?=
 =?utf-8?B?NDJFUk1jcUx6M3ZLM3NYQjViM3BQQWVKR2U0QktWZDgzSUxwUTNuLzFFZDAw?=
 =?utf-8?B?M094TDRrcW9VODdTcmN0K2Z5V21OQVAzeWtYRmVBZW1MZGFhSGRFOW5DL0x3?=
 =?utf-8?B?WFZ6ZStLVEFLang0V3BjLzlHWHhqZlZOMU4vd0xQcm9EWjRUeE1nOWF2bGZn?=
 =?utf-8?B?aXBiZUJCZi9Eay80K1EyQkxNV28zR21ManJ1TGwwRGJWMDQ1cVNxRWNFTGww?=
 =?utf-8?B?ZGJmdWJoTlI5NkVjWVRpMDAxWXB6eGEwVldmWE1VMGEyU2dINkgzZFJrQ1lI?=
 =?utf-8?B?SjJaUUd0cGsvbGI3RUtCVVNDRndTSHlwMXlsVk1zUGdDa2hCZGg5c0d1cFM0?=
 =?utf-8?B?SW9oUTFxNHhTVm1PUHFURDlmZ2owdmIyYXB4R1dmVTVCcTJOSkJKR1ZwenFY?=
 =?utf-8?B?S3VNeUFmdUFwMmljOFZzUlR5Z3Y2MW96R3A1aXBubmYvN0FmRCttNmtVcEZL?=
 =?utf-8?B?elRvTFdXcUZzUFM5WStobGN1UmJPWUlqOGhOUit3RUgzZkNIcXlnZTBRNVpi?=
 =?utf-8?B?Q3k4dlcrdTZ3VUNFRHZPaGZYUmtoMzk5NXVOQVdGeXhMcWdoUHJSNUkyVXpu?=
 =?utf-8?B?ZFpWeXlMREtJTitoMnNRcC9pamxhbUF5bGZZZWw1OHdWMlNPSWRuNGlNR0Mr?=
 =?utf-8?B?b2l5d1EzcHhMbEZpK05yTXY4OVkvRTNZb05ERFpnenNpVTN5MlE2alY2MENP?=
 =?utf-8?B?dGMvZDZRVEc4YmxKbXk0Zm5IQUpYKzJuelhHWWhrMzZUWVgrU0hzQzBsd2Mx?=
 =?utf-8?B?L1NKWnNHaFRXa0pseUVkSlYvbVpKUUxQYVVnQlJPY3dSTTd3NnRJVXpWVzFp?=
 =?utf-8?B?bnZja2hZbU9nanQ3aGh0YllZbUpGZGhWbHJPdlVFUG9wNW9LR1VaSnBITXRy?=
 =?utf-8?B?UkZNV1ROM1h4Y3grUEFSNzJpbzZYdW04dGtiN0txdjd5T3RONi9QaFU4QWtI?=
 =?utf-8?B?ejlUMlkwekVnUDhpR0hGVldpZkoxSkcxbjBza212T3poNkdTT21wQ0pTNlhH?=
 =?utf-8?B?TDNIR1hJdys3bUg2ZkJXR21ldGN6M1NSc29SN2hmSlZZMnhrbHg4aHcrQlRT?=
 =?utf-8?B?ajZkdWoyb3E4ZHk4TWxZUERncDBKRm9Lem16MHpINUc5Y21QL2RFb2FoQVRQ?=
 =?utf-8?B?Q2lKL2M5Z0piTm4xS1U3UWNjZmhrRXN4ZGtISFdEZlh2M3g1elBWRlBKSFRx?=
 =?utf-8?B?bFBrOEY3ZFFHcUs0T3Qwampya08vSTZyVWxQcG52S2xnOVIrenIzQkNGSGVz?=
 =?utf-8?B?M1FlT0liRHZ3M3B5TDg1MUxwRm90amNZb1FuRUQzMmNUNGZYQW9rS3lrWm9F?=
 =?utf-8?B?aVRLeG4reEdpKzkwNG5FRUtucHQ5bkR5QmNoc0U4bUkxMFF2Q0F1N2RTT3R6?=
 =?utf-8?B?dU9xTDZXOTNpc1l5VHBLK0tKOXorL2Q4UjFYVkYzc0NITEJFUnowa1FrdGJB?=
 =?utf-8?B?aG9vMnNkZ3NlMk9zcXlqOGhVY0V2LzV1TmFtOXBmUFA1THVmOVlxODVHb3pG?=
 =?utf-8?B?QVhhMXFFQ0FoK0E0ZFJhbGhneUpCUTZsUmdueDFzdGFTRWIwKzRWMTBhUldm?=
 =?utf-8?B?czFXaStiQ1p2UUF0SXYyUldjeHA1ek5sWG41WThkL3V2V3JzRzB2ek53S3ZU?=
 =?utf-8?B?TmpWY2FPS0JPQ0Rmenl4MFBpNTFUYUhmV05iZkVidkhuWGJsTlJFQ2ZRbzJH?=
 =?utf-8?B?QnhyVFdvSFk1WGY4MU1pVG5WYkF2Q0p6N1oxSXJpU0VGZEpEY3dDeE95VWNL?=
 =?utf-8?B?QktrZ2FPM2hUU25zUURXZklTWXVSYlJqUFJ3aTNRRFJXcHUyY2JyYkk2VUx4?=
 =?utf-8?B?SlY4REtoMkFjdmhTRzY1c0VCTllaaGJOWXd2SHZRYzhBSkRFY3NVUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7523E7F539DD7E409924AE740C3E46F8@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR05MB6474.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 972af187-f68f-4b44-c148-08de4adbba6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2026 15:21:11.8837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ipTWI0wdL1r0A9z/9vk2YoY/4CsQrAs67papaynKKZo58P9Qe763RaE/AqdB6vjX4CGoA7WqCUZFsus4gdOYbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6818

T24gTW9uLCAyMDI1LTEyLTIyIGF0IDA5OjAxIC0wNTAwLCBNaW1pIFpvaGFyIHdyb3RlOg0KPiBI
aSBFbnJpY28sDQo+IA0KPiBPbiBUdWUsIDIwMjUtMTItMTYgYXQgMTc6NTYgKzAxMDAsIEVucmlj
byBCcmF2aSB3cm90ZToNCj4gPiBXaGVuIHNpZ25lZCBhIHBvbGljeSBpcyBub3QgbWFuZGF0b3J5
LCBpdCBpcyBwb3NzaWxlIHRvIHdyaXRlIHRoZSBJTUENCj4gPiBwb2xpY3kgZGlyZWN0bHkgb24g
dGhlIGNvcnJlc3BvbmRpbmcgc2VjdXJpdHlmcyBmaWxlOg0KPiA+IA0KPiA+IGVjaG8gLWUgIm1l
YXN1cmUgZnVuYz1CUFJNX0NIRUNLIG1hc2s9TUFZX0VYRUNcbiIgXA0KPiA+IMKgwqDCoMKgwqDC
oMKgICJhdWRpdCBmdW5jPUJQUk1fQ0hFQ0sgbWFzaz1NQVlfRVhFQ1xuIiBcDQo+ID4gwqDCoMKg
wqAgPiAvc3lzL2tlcm5lbC9zZWN1cml0eS9pbWEvcG9saWN5DQo+ID4gDQo+ID4gQWRkIGlucHV0
IGJ1ZmZlciBtZWFzdXJlbWVudCB0aGF0IGNhbiBiZSBjYXVnaHQgd2hlbiAnbWVhc3VyZQ0KPiA+
IGZ1bmM9UE9MSUNZX0NIRUNLJyBpcyBlbmFibGVkIChlLmcuLCBpbWFfcG9saWN5PXRjYikuDQo+
ID4gDQo+ID4gU3VnZ2VzdGVkLWJ5OiBSb2JlcnRvIFNhc3N1IDxyb2JlcnRvLnNhc3N1QGh1YXdl
aS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogRW5yaWNvIEJyYXZpIDxlbnJpY28uYnJhdmlAcG9s
aXRvLml0Pg0KPiA+IC0tLQ0KPiA+IMKgc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWEuaMKgwqDC
oMKgwqAgfMKgIDEgKw0KPiA+IMKgc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfZnMuY8KgwqAg
fMKgIDEgKw0KPiA+IMKgc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfbWFpbi5jIHwgMzggKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+IMKgMyBmaWxlcyBjaGFuZ2VkLCA0MCBp
bnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL3NlY3VyaXR5L2ludGVncml0eS9p
bWEvaW1hLmggYi9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYS5oDQo+ID4gaW5kZXggY2E3Yjk2
NjYzNjIzLi4zYjAwYzI5ODM1NWIgMTAwNjQ0DQo+ID4gLS0tIGEvc2VjdXJpdHkvaW50ZWdyaXR5
L2ltYS9pbWEuaA0KPiA+ICsrKyBiL3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hLmgNCj4gPiBA
QCAtNDI2LDYgKzQyNiw3IEBAIHZvaWQgKmltYV9wb2xpY3lfbmV4dChzdHJ1Y3Qgc2VxX2ZpbGUg
Km0sIHZvaWQgKnYsDQo+ID4gbG9mZl90ICpwb3MpOw0KPiA+IMKgdm9pZCBpbWFfcG9saWN5X3N0
b3Aoc3RydWN0IHNlcV9maWxlICptLCB2b2lkICp2KTsNCj4gPiDCoGludCBpbWFfcG9saWN5X3No
b3coc3RydWN0IHNlcV9maWxlICptLCB2b2lkICp2KTsNCj4gPiDCoHZvaWQgaW1hX21lYXN1cmVf
bG9hZGVkX3BvbGljeSh2b2lkKTsNCj4gPiAraW50IGltYV9tZWFzdXJlX3BvbGljeV93cml0ZShj
aGFyICpidWYsIHNpemVfdCBzaXplKTsNCj4gPiDCoA0KPiA+IMKgLyogQXBwcmFpc2UgaW50ZWdy
aXR5IG1lYXN1cmVtZW50cyAqLw0KPiA+IMKgI2RlZmluZSBJTUFfQVBQUkFJU0VfRU5GT1JDRSAw
eDAxDQo+ID4gZGlmZiAtLWdpdCBhL3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX2ZzLmMNCj4g
PiBiL3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX2ZzLmMNCj4gPiBpbmRleCA4OTk0NmQ4MDNk
NDQuLmYxYTVlZGQwNjBhZCAxMDA2NDQNCj4gPiAtLS0gYS9zZWN1cml0eS9pbnRlZ3JpdHkvaW1h
L2ltYV9mcy5jDQo+ID4gKysrIGIvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfZnMuYw0KPiA+
IEBAIC0zNjIsNiArMzYyLDcgQEAgc3RhdGljIHNzaXplX3QgaW1hX3dyaXRlX3BvbGljeShzdHJ1
Y3QgZmlsZSAqZmlsZSwgY29uc3QNCj4gPiBjaGFyIF9fdXNlciAqYnVmLA0KPiA+IMKgIMKgwqDC
oCAxLCAwKTsNCj4gPiDCoCByZXN1bHQgPSAtRUFDQ0VTOw0KPiA+IMKgIH0gZWxzZSB7DQo+ID4g
KyBpbWFfbWVhc3VyZV9wb2xpY3lfd3JpdGUoZGF0YSwgZGF0YWxlbik7DQo+ID4gwqAgcmVzdWx0
ID0gaW1hX3BhcnNlX2FkZF9ydWxlKGRhdGEpOw0KPiA+IMKgIH0NCj4gPiDCoCBtdXRleF91bmxv
Y2soJmltYV93cml0ZV9tdXRleCk7DQo+ID4gZGlmZiAtLWdpdCBhL3NlY3VyaXR5L2ludGVncml0
eS9pbWEvaW1hX21haW4uYw0KPiA+IGIvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfbWFpbi5j
DQo+ID4gaW5kZXggY2RkMjI1ZjY1YTYyLi42YThhZDQ3MTQ4ODEgMTAwNjQ0DQo+ID4gLS0tIGEv
c2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfbWFpbi5jDQo+ID4gKysrIGIvc2VjdXJpdHkvaW50
ZWdyaXR5L2ltYS9pbWFfbWFpbi5jDQo+ID4gQEAgLTI4LDYgKzI4LDcgQEANCj4gPiDCoCNpbmNs
dWRlIDxsaW51eC9pdmVyc2lvbi5oPg0KPiA+IMKgI2luY2x1ZGUgPGxpbnV4L2V2bS5oPg0KPiA+
IMKgI2luY2x1ZGUgPGxpbnV4L2NyYXNoX2R1bXAuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3No
bWVtX2ZzLmg+DQo+ID4gwqANCj4gPiDCoCNpbmNsdWRlICJpbWEuaCINCj4gPiDCoA0KPiA+IEBA
IC05ODYsNiArOTg3LDQzIEBAIHN0YXRpYyBpbnQgaW1hX3Bvc3RfbG9hZF9kYXRhKGNoYXIgKmJ1
ZiwgbG9mZl90IHNpemUsDQo+ID4gwqAgcmV0dXJuIDA7DQo+ID4gwqB9DQo+ID4gwqANCj4gPiAr
LyoqDQo+ID4gKyAqIGltYV9tZWFzdXJlX3BvbGljeV93cml0ZSAtIE1lYXN1cmUgdGhlIHBvbGlj
eSB3cml0ZSBidWZmZXINCj4gPiArICogQGJ1ZjogcG9pbnRlciB0byB0aGUgYnVmZmVyIGNvbnRh
aW5pbmcgdGhlIHBvbGljeSB3cml0ZSBkYXRhDQo+ID4gKyAqIEBzaXplOiBzaXplIG9mIHRoZSBi
dWZmZXINCj4gPiArICoNCj4gPiArICogTWVhc3VyZSB0aGUgYnVmZmVyIHNlbnQgdG8gdGhlIElN
QSBwb2xpY3kgc2VjdXJpdHlmcyBmaWxlLg0KPiA+ICsgKg0KPiA+ICsgKiBSZXR1cm4gMCBvbiBz
dWNjZXNzLCBhIG5lZ2F0aXZlIHZhbHVlIG90aGVyd2lzZS4NCj4gPiArICovDQo+ID4gK2ludCBp
bWFfbWVhc3VyZV9wb2xpY3lfd3JpdGUoY2hhciAqYnVmLCBzaXplX3Qgc2l6ZTANCj4gPiArew0K
PiA+ICsgc3RhdGljIGNvbnN0IGNoYXIgb3BbXSA9ICJtZWFzdXJlX2ltYV9wb2xpY3lfd3JpdGUi
Ow0KPiA+ICsgY29uc3QgY2hhciAqZmlsZV9uYW1lID0gImltYV93cml0ZV9wb2xpY3lfYnVmZmVy
IjsNCj4gPiArIHN0YXRpYyBjaGFyICphdWRpdF9jYXVzZSA9ICJFTk9NRU0iOw0KPiA+ICsgc3Ry
dWN0IGZpbGUgKnBvbGljeV9maWxlID0gTlVMTDsNCj4gPiArIHN0cnVjdCBsc21fcHJvcCBwcm9w
Ow0KPiA+ICsgaW50IHJldCA9IDA7DQo+ID4gKw0KPiA+ICsgcG9saWN5X2ZpbGUgPSBzaG1lbV9r
ZXJuZWxfZmlsZV9zZXR1cChmaWxlX25hbWUsIDAsIDApOw0KPiA+ICsgaWYgKElTX0VSUihwb2xp
Y3lfZmlsZSkpIHsNCj4gPiArIHJldCA9IFBUUl9FUlIocG9saWN5X2ZpbGUpOw0KPiA+ICsgYXVk
aXRfY2F1c2UgPSAiYWxsb2NfZmlsZSI7DQo+ID4gKyBpbnRlZ3JpdHlfYXVkaXRfbXNnKEFVRElU
X0lOVEVHUklUWV9QQ1IsIE5VTEwsICJpbWFfcG9saWN5X3dyaXRlIiwNCj4gPiArIMKgwqDCoCBv
cCwgYXVkaXRfY2F1c2UsIHJldCwgMSk7DQo+ID4gKyBnb3RvIG91dDsNCj4gPiArIH0NCj4gPiAr
DQo+ID4gKyBzZWN1cml0eV9jdXJyZW50X2dldGxzbXByb3Bfc3ViaigmcHJvcCk7DQo+ID4gKw0K
PiA+ICsgcmV0ID0gcHJvY2Vzc19tZWFzdXJlbWVudChwb2xpY3lfZmlsZSwgY3VycmVudF9jcmVk
KCksICZwcm9wLCBidWYsIHNpemUsDQo+ID4gKyDCoCBNQVlfUkVBRCwgUE9MSUNZX0NIRUNLKTsN
Cj4gDQo+IFRoZSBwdXJwb3NlIG9mIHRoaXMgcGF0Y2ggaXMgdG8gbWVhc3VyZSBJTUEgcG9saWN5
IHJ1bGVzIGFzIHRoZXkncmUgd3JpdHRlbiB0bw0KPiB0aGUgPHNlY3VyaXR5ZnM+IElNQSBwb2xp
Y3kgZmlsZSwgYmFzZWQgb24gdGhlIElNQSAibWVhc3VyZSBmdW5jPVBPTElDWV9DSEVDSyINCj4g
cG9saWN5IHJ1bGUuDQo+IA0KPiBMaWtlIGNyaXRpY2FsIGRhdGEsIGl0IHNob3VsZCBiZSBjYWxs
aW5nIHByb2Nlc3NfYnVmZmVyX21lYXN1cmVtZW50KCksIG5vdA0KPiBwcm9jZXNzX21lYXN1cmVt
ZW50KCkuDQo+IA0KPiBUaGUgZnVuY3Rpb25zIGltYV9tYXRjaF9ydWxlcygpIGFuZCBpbWFfbWF0
Y2hfcnVsZV9kYXRhKCkgbmVlZCB0byBiZSB1cGRhdGVkDQo+IHRvIHN1cHBvcnQgUE9MSUNZX0NI
RUNLLg0KDQpIaSBNaW1pLA0KDQpvayBzdXJlLCBJIGNhbiBzd2l0Y2ggdG8gcHJvY2Vzc19idWZm
ZXJfbWVhc3VyZW1lbnQoKS4NCg0KPiBUaGlzIGZ1bmN0aW9uIG5hbWluZyBpcyBvZmYgYW5kIHNo
b3VsZCBiZSByZW5hbWVkIHRvIGltYV9tZWFzdXJlX3BvbGljeV9idWYoKS4NCj4gDQo+IFBsZWFz
ZSB1cGRhdGUgdGhlIHBhdGNoIGRlc2NyaXB0aW9uIGFjY29yZGluZ2x5Lg0KDQpXaWxsIGRvLg0K
DQpUaGFua3MgYWdhaW4gZm9yIHlvdXIgZmVlZGJhY2suDQoNCkVucmljbw0KDQo+IE1pbWkNCj4g
DQo+ID4gKyBmcHV0KHBvbGljeV9maWxlKTsNCj4gPiArDQo+ID4gK291dDoNCj4gPiArIHJldHVy
biByZXQ7DQo+ID4gK30NCj4gPiArDQo+ID4gwqAvKioNCj4gPiDCoCAqIHByb2Nlc3NfYnVmZmVy
X21lYXN1cmVtZW50IC0gTWVhc3VyZSB0aGUgYnVmZmVyIG9yIHRoZSBidWZmZXIgZGF0YSBoYXNo
DQo+ID4gwqAgKiBAaWRtYXA6IGlkbWFwIG9mIHRoZSBtb3VudCB0aGUgaW5vZGUgd2FzIGZvdW5k
IGZyb20NCg==

