Return-Path: <linux-integrity+bounces-9891-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Gh7/LUMdTWo2vQEAu9opvQ
	(envelope-from <linux-integrity+bounces-9891-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 07 Jul 2026 17:37:39 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE06071D5A0
	for <lists+linux-integrity@lfdr.de>; Tue, 07 Jul 2026 17:37:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=polito.it header.s=selector1 header.b="M8xtkM/8";
	dmarc=pass (policy=quarantine) header.from=polito.it;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9891-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9891-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82931319A221
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jul 2026 15:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26857392C25;
	Tue,  7 Jul 2026 15:26:04 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023124.outbound.protection.outlook.com [40.107.159.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC2D42317C
	for <linux-integrity@vger.kernel.org>; Tue,  7 Jul 2026 15:26:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783437964; cv=fail; b=WXNYmEtTQ/WLx0EPY9meOT45ae8QwDca2vXv7umSOz08FedCMSYpZNE9WOdElttMcJrDbsLRtjPsHLmrucJMPZTpviPHRO7lpJA9DtrSbJITWX8Cdw2DO9lJjMfvLOPhm/FyUKIJizCSl50Sq8WZmzG7iRgQ9Hwb6b3NdwK22zQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783437964; c=relaxed/simple;
	bh=djdkKFcd6t0hnWF+rZhRf4xbMAL75PYukoKXomxS85Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J1NtV5/dWAlAVO5e8+C8rR5uLMzmZXQ0e/cgTuMYhn2bB8n3Jqgu2ZG7MybSzuDSSXnNI+oiBqO3TmYlqzBBreYs31fhqUvJs692UFRx3GGcZ85ZUcofIV8HeQDoHohPDFwpeShQ76luQ60aa2L1rWhbR8cE8CTvIqln5YHRXJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=M8xtkM/8; arc=fail smtp.client-ip=40.107.159.124
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uhy8Ob+wT0J7OPb0jpUPEZ3q9dI2YfF13zIHm2UaTQOXcr4Ew8RtLAHb/awBKFLBdaui2RiybvCh2zO7JZCW+2vqEqlRONh0K8gmlPl02TinH++yPI06X169aq9EXx68Ex+Y3ZcCJQmhdXSsJUz/LrRudwZSAXy+yv0pTdDLQze1cqs4TIXVZ5x9d/3DcWYtrFe6wC0SLOu7BnayXBN01onlf/4EtULCs+xchQ+OCLxliujMuyx8iWX4qQHojZCz8e+5isekR9mV3laSPc5mCyaav1/qePepTX13wqQ5KNf/dd4iyuVydcsIlSmnaNyl1TEbzYXvu0XHaeE86Dbx+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djdkKFcd6t0hnWF+rZhRf4xbMAL75PYukoKXomxS85Q=;
 b=f95rJYLh9Ra30Aud9AP+Xxcv/UXuYiHXx9wxpCs0F5I8B/BZd7aUyszbVlch/PLMkXWmlGOIIQzB8Kfv2vZxvGN6IHvZdvGJVzAGhn5j05hOEm7v0Yb3raybkSEVWAp8OU/W5r3zLT/YYkJSghi3mp3R68SDRe9vJ2w1+mav1MLpzOAlYjUp47aoJjzy460LI+FG3jFLBSXIGwxOrsbnkvt9sPpwHNOj5tcPybYVcCJ0EhgXcvhlwy09S8eUkNO4YfxNjPbnfWPoLNsnRSU1HPJQZ4Q2KScW9llmG1qR7Z5PaUygvvkdwZUsom8KPQ5iRLFpsbwm6TdihxpGD08JWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djdkKFcd6t0hnWF+rZhRf4xbMAL75PYukoKXomxS85Q=;
 b=M8xtkM/8rqELRYW321MrpXD6LP3O+l84PvzqwJ0CBgo13IGp7wkBa1xDP89tQVs3zckfU5ADN6QgK+KIXpHBUayU1o6eXEPPyx0liFjH8RiNpnbclqU33z7V1ztpoVBPCTFN2RZWnSeJipTjX0kwsSS3kurjBl4rshheSqkwZ+s=
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com (2603:10a6:20b:253::20)
 by DB9PR05MB9221.eurprd05.prod.outlook.com (2603:10a6:10:367::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 15:25:55 +0000
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64]) by AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64%5]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 15:25:54 +0000
From: "Enrico  Bravi" <enrico.bravi@polito.it>
To: "roberto.sassu@huawei.com" <roberto.sassu@huawei.com>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"zohar@linux.ibm.com" <zohar@linux.ibm.com>, "dmitry.kasatkin@gmail.com"
	<dmitry.kasatkin@gmail.com>
CC: "eric.snowberg@oracle.com" <eric.snowberg@oracle.com>
Subject: Re: [PATCH v5 2/2] ima: measure userspace policy writes before
 parsing
Thread-Topic: [PATCH v5 2/2] ima: measure userspace policy writes before
 parsing
Thread-Index: AQHdClXkImZXr7JmikahnsXqa0W9RbZhZcuAgADPVYA=
Date: Tue, 7 Jul 2026 15:25:54 +0000
Message-ID: <801419f4424e106dd2fe66d8291a2343708245ba.camel@polito.it>
References: <20260702190403.5844-1-enrico.bravi@polito.it>
		 <20260702190403.5844-3-enrico.bravi@polito.it>
	 <002330a72cdec8eaa554fddd5b8d428245ed83e4.camel@linux.ibm.com>
In-Reply-To: <002330a72cdec8eaa554fddd5b8d428245ed83e4.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR05MB7880:EE_|DB9PR05MB9221:EE_
x-ms-office365-filtering-correlation-id: cff375ec-bed4-4518-2138-08dedc3c098f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|786006|366016|376014|38070700021|18002099003|22082099003|11063799006|56012099006|4143699003|6133799003;
x-microsoft-antispam-message-info:
 DmZRhwNHxpE+PEmp7vVIt+MQ77g6qSenF1bQHy/etpLqvbQ5N7aYrhBYeu2OUESJQrBqCEHozcwycvSuMyTkAsWOYzL7iUitavd8YepPjMaJeZ1feFTQefGqzHMCpgc5iZYfnY7c/DGAL1FZqfG89uGsBcz0fAKKd+mjeujnU7a1BHdk9LtgBNb4IGVxHEOZuBIrTmyLeVciRAgThl6umpxPb1iJYYFqnJKMZQwyqZJdJUsVIrUNWC3WP+MsrYY1a7jG8iPBikJ8FqceRhhHWcS/bBpD4lx11pW4vKNMyGcjD9YVslYb6jZNO88uouny6ya1Fb+0uaG8l2/SENBspiEAn/vMNCgrWtfkNWKKYAJGddc9yGMXP77Jkv33iFUaOo+L5JFGpD/6Lh3kGiINKV58hCVIoUzynU/AyiPStbCRtwcCXcDrmUdGS9PYqW5WCI7FV/pJmxhfIl5uTqsGwwRhfr+K3Sn1rwoTDjuJgdzfBafjCFFvQlavW8PQmMOOq77++2P/Yz/G7FNrOMGJGjBUhHk1YRoepmZAyGc5TposmOo2pLTpYkhpB5RZCWa4ndwYOsfWc789C6MipWgtpRVPbZuexTaUM86k6iDM1jYBJo298UEP5J7GSfWANGltehEIGYfNY81AAA21CxyZgnZwoAhfdnrw/DIDvWKeD5Ve9w0pRiBukRddbuUKmbwTk/dVwnXJ2goS/sgtiLS84eta39DasaQYWSsThWIp3Vg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR05MB7880.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(786006)(366016)(376014)(38070700021)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(6133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U2NGbi82MDAyaXppWjNpOHFDK1E2MWhOSkYwdGVtTUJlTFA2YkxsNTZucXNL?=
 =?utf-8?B?VTJRcnlTU05WbzRuUGF6SUFJTFF0SHh0VFBnTm5iRmo3UFgzRXhOMU1SKzky?=
 =?utf-8?B?djNqeDNNOHpmQ3dpYWtGa0ZUTjdmY2gzUjBWb1hxaGYram04NTFMU21aK2dQ?=
 =?utf-8?B?cEtZM2hDSFkxVjJ4UlN1RzUvVnBrZXE4c2hmbEF2dG1xTzFRR3Zkb1l0dmxU?=
 =?utf-8?B?bEdYVThNeUxSb2g0Mi9veFk5MFJ3ajV1YzdjWXFDODd4T254YlFZbnU0cDQ1?=
 =?utf-8?B?YjhZb0ZOYngvTnpEdUZvYmYrM3VEeCt0cVk4R1orWXJTNUlydlVsTW13QnND?=
 =?utf-8?B?TDBSekY0cHJ4Z3BNeTBjaEsrWkhGczJCN29BajVmZTBWNEtnVTZHdDkvV0VJ?=
 =?utf-8?B?UDdpWjhwVU1IMXEzcDh0T1c1RlJIaVJGK1dHdVhuQkViUzRFenptVC9HNmpT?=
 =?utf-8?B?NUtQWExFU2hrZzdac05YNHREOUpDNWdWbkowckZhWnBVTXNhaGRQM1R4eWlp?=
 =?utf-8?B?VHh4RUJqVHpJTGwzSmJiaWtQMTY2aStVRklUWmZHWkhnQ3FLNmUzdVFmeU55?=
 =?utf-8?B?UXovL3pMZkVubGNGc052Qi9weUx3QUVVZ2VJaVo2RCtoQ2c0ekVTNVhHYU9N?=
 =?utf-8?B?UUZuT3NWRWRFZnEvekUvam03Zkx3RDUyaXIyak1yK21PSk5tQjQ3WmpWZjBm?=
 =?utf-8?B?eHNURlZsQmIyVlk2UE05a2JlbjV1am8wYkRqV1MyVEhsbjI1aUtacXdYZlo4?=
 =?utf-8?B?TTdQaGk3elVSNW1OT3d3SkJ0N1k2Q3dUU1NNYXpZNE14L25lcWxpcmIzZjRx?=
 =?utf-8?B?WkZ6UHdNWWdvNUFlSEE2dlRTam5UN1M0OHd5ZXE4NDNQR1ZnL201Y1FzajEr?=
 =?utf-8?B?MU1sdlNSL3NzblZwSEpKLzIvWHBPN2tvWEhiRWo2MzJxK1UvdHpZMFFrRE9V?=
 =?utf-8?B?ZlRDbzFqMlNZYitreWNkcGw3OFRkZmYzdUU0NktBbm4xdG1QbHUrZHpSVmR2?=
 =?utf-8?B?Nld0bVNGbGFPZENjMnlNbFRpOThTWGpQRzRvTW1WdUowdjRkTTYwS2RuVy9G?=
 =?utf-8?B?eUlLMVpqVkdEeXN1UFhjSjl5OW9DWUxDQW5DQnREV3ZjZnE2SjJkUWo4R0pk?=
 =?utf-8?B?OG11bzRudWtFVHhKTFN2bzNjbzdjejJFbWJHTWNndEhRenRJa2RyckY1TmJC?=
 =?utf-8?B?QkEra1F2NGxIeCthWnNieUFtdmtwYVpPOVpZcnFTMjZkSlREOUN3UitGbVNN?=
 =?utf-8?B?eVk5OUpwTnhYUEhqTXZiOWdoTzlHQkZYdkdFdi9jOUpaOW1GQnY3OHBSSmY2?=
 =?utf-8?B?cmRjZnpWSWJlR1BkcDd6N0JEL296MGpZTjlmdGNsRDJZdE1WVnhrMXN0WXAv?=
 =?utf-8?B?VDZoaVVtbE1LUFhhUmNzcDVUOVJaZkxNVFpZMTFON3dVVzRjZU01Vk9ycjNo?=
 =?utf-8?B?OHNYamkzcWFKMWRsejFkTFV1RHhoQTRNZUpsRmpmNXQ4dTlXd2NSTmJOZE0z?=
 =?utf-8?B?MDU5NE16a25BZFdiM2ZEMFRsOGcvTHlKSDNDbW5XSWs5YVdQMHF5RWpWMUls?=
 =?utf-8?B?R0lIL1BOSWEwSVhQRUxRN2RHV3BUWTFpV3RpMzNwUmh0RGlQNGJUbjJXY09s?=
 =?utf-8?B?SksrT25Vbm1GeUxKU3pvRHpnaktZSFNwNHFJdjhTb3NISVNMSFRwOG8wU3Bp?=
 =?utf-8?B?bEwrV3RMZmJoMDBzTm5wUDB6NUF2QWlPeXNEd2FmLzhyQlltVEk4TTJvNXVX?=
 =?utf-8?B?WEpFZ1dKVzBidHVCd25FMWxJNFVNcGdQU0JqK3pSa1JmSUdiN2FtUFBkUEZM?=
 =?utf-8?B?UnkvRm1zRWViMWtzbGZQaWZzZHpJbStMS1l2L1NMMmdhVWhzdkZBck83aVZ2?=
 =?utf-8?B?aWU4Ym1XeGdFVTg0aVBSYkZyM2FlQ3Uyc1Z5MFh0ZytNbGNFQmZmQUF3aXF4?=
 =?utf-8?B?M0pjYUk5Wjc3K3lPWlhrSG45VzVTSmQxb0RySE5NTC9JSzNpTHFQWVVnK1ZE?=
 =?utf-8?B?REE0OFRmWUJMSnBkUkVVcmUvSVloTkoya1RoYkVkWFV1VCsyZGFlVnp6Tldq?=
 =?utf-8?B?RmRPNjJNUm54OWdCNStWazZPZVArYzhGdVVmSUFDNzNLeHYzbXkrUnJIZkdZ?=
 =?utf-8?B?SnNhUGp4UTBXNG5DZGYwcU9sSU44Mys1ZGtoRFBOWmI5aStSazNhVTdQQlJs?=
 =?utf-8?B?RzVFSDNPeGhqZGxmYTUrZEZBdmxydGZoZi94K2pRVHZ5bGRURm1rWVhXdUZN?=
 =?utf-8?B?dHRTdG82NlpyZUh4WGtKUDVXMnNQWU55VUtSWDRHZ2xsNDlaTVc0ME5BZmht?=
 =?utf-8?B?SWdkRDl4SkFOU1MvUDdhdktpUGhVSnh6dTlIbTJMZXpoZjUyUkk3Q3VqYlZ4?=
 =?utf-8?Q?Abmys2mEx187jBDA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B818FC6612A73E4FB276600E0095639E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR05MB7880.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cff375ec-bed4-4518-2138-08dedc3c098f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 15:25:54.9092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ftXCWz8GMZUfOoht2YgcJQcrrp2cwj/gwnC7PhN7eDGAYNgt1CuETFjjrTn/kpQWibLOxV+bJ0M5c/gjbO7KAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR05MB9221
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	FROM_NAME_EXCESS_SPACE(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[polito.it,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[polito.it:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9891-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:roberto.sassu@huawei.com,m:linux-integrity@vger.kernel.org,m:zohar@linux.ibm.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[huawei.com,vger.kernel.org,linux.ibm.com,gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[enrico.bravi@polito.it,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[polito.it:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enrico.bravi@polito.it,linux-integrity@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DE06071D5A0

T24gTW9uLCAyMDI2LTA3LTA2IGF0IDIzOjAzIC0wNDAwLCBNaW1pIFpvaGFyIHdyb3RlOg0KPiBP
biBUaHUsIDIwMjYtMDctMDIgYXQgMjE6MDQgKzAyMDAsIEVucmljbyBCcmF2aSB3cm90ZToNCj4g
DQo+ID4gZGlmZiAtLWdpdCBhL3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX3BvbGljeS5jDQo+
ID4gYi9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9wb2xpY3kuYw0KPiA+IGluZGV4IGE2NWI3
ZTRiNjRkNi4uZDZkMjQ5MTkwNzA1IDEwMDY0NA0KPiA+IC0tLSBhL3NlY3VyaXR5L2ludGVncml0
eS9pbWEvaW1hX3BvbGljeS5jDQo+ID4gKysrIGIvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFf
cG9saWN5LmMNCj4gPiBAQCAtNTkxLDYgKzU5Myw3IEBAIHN0YXRpYyBib29sIGltYV9tYXRjaF9y
dWxlcyhzdHJ1Y3QgaW1hX3J1bGVfZW50cnkgKnJ1bGUsDQo+ID4gwqAJc3dpdGNoIChmdW5jKSB7
DQo+ID4gwqAJY2FzZSBLRVlfQ0hFQ0s6DQo+ID4gwqAJY2FzZSBDUklUSUNBTF9EQVRBOg0KPiA+
ICsJY2FzZSBQT0xJQ1lfQ0hFQ0s6DQo+ID4gwqAJCXJldHVybiAoKHJ1bGUtPmZ1bmMgPT0gZnVu
YykgJiYNCj4gPiDCoAkJCWltYV9tYXRjaF9ydWxlX2RhdGEocnVsZSwgZnVuY19kYXRhLCBjcmVk
KSk7DQo+ID4gwqAJZGVmYXVsdDoNCj4gDQo+IEhpIEVucmljbywNCj4gDQo+IFVubGlrZSB0aGUg
b3RoZXIgaG9va3MsIEtFWV9DSEVDSyBhbmQgQ1JJVElDQUxfREFUQSBhcmUgc3BlY2lhbCBjYXNl
cywgd2hpY2gNCj4gb25seSBhbGxvdyBhIHNldCBvZiBrZXlyaW5ncyBvciBsYWJlbHMgcmVzcGVj
dGl2ZWx5LsKgIFBPTElDWV9DSEVDSyBydWxlcyBjYW4NCj4gYmUNCj4gZGVmaW5lZCBpbiB0ZXJt
cyBvZiBvdGhlciBmaWxlIG1ldGFkYXRhIChlLmcuIHVpZCwgZ2lkLCAuLi4pLiBXaXRoIHRoaXMN
Cj4gY2hhbmdlLA0KPiBhbnkgb3B0aW9ucyBzcGVjaWZpZWQgb24gdGhlIHJ1bGUgd2lsbCBiZSBu
b3QgYmUgbWF0Y2hlZC4NCg0KSGkgTWltaSwNCg0KeW91J3JlIHJpZ2h0Lg0KDQo+IGltYV9tYXRj
aF9ydWxlX2RhdGEoKSBzaG91bGQgb25seSBiZSBjYWxsZWQgZm9yIGJ1ZmZlciBtZWFzdXJlbWVu
dHMsIHdoZW4NCj4gdGhlcmUNCj4gaXMgbm8gaW5vZGUuIA0KPiANCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcmV0dXJuICgocnVsZS0+ZnVuYyA9PSBmdW5jKSAmJiAhaW5vZGUgJiYN
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbWFfbWF0
Y2hfcnVsZV9kYXRhKHJ1bGUsIGZ1bmNfZGF0YSwgY3JlZCkpOw0KDQpJIHdhcyB0aGlua2luZyB0
aGF0IGluIHRoaXMgd2F5LCBpdCB3b3VsZCBub3QgdHJpZ2dlciB0aGUgbWVhc3VyZW1lbnQgd2hl
bg0KbG9hZGluZyB0aGUgcG9saWN5IGZyb20gYSBmaWxlLiBJZiBpbm9kZSBpcyBub3QgTlVMTCwg
aXQgZGlyZWN0bHkgcmV0dXJucyBmYWxzZQ0KaW5zdGVhZCBvZiBjb250aW51aW5nLiBXaGF0IGRv
IHlvdSB0aGluZyBvZiBzb21ldGhpbmcgbGlrZSB0aGlzOg0KDQogICAgICAgIHN3aXRjaCAoZnVu
Yykgew0KKyAgICAgICBjYXNlIFBPTElDWV9DSEVDSzoNCisgICAgICAgICAgICAgICBpZiAoaW5v
ZGUpDQorICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCisgICAgICAgICAgICAgICBmYWxs
dGhyb3VnaDsNCiAgICAgICAgY2FzZSBLRVlfQ0hFQ0s6DQogICAgICAgIGNhc2UgQ1JJVElDQUxf
REFUQToNCiAgICAgICAgICAgICAgICByZXR1cm4gKChydWxlLT5mdW5jID09IGZ1bmMpICYmDQog
ICAgICAgICAgICAgICAgICAgICAgICBpbWFfbWF0Y2hfcnVsZV9kYXRhKHJ1bGUsIGZ1bmNfZGF0
YSwgY3JlZCkpOw0KDQo+IE90aGVyd2lzZSB0aGUgcGF0Y2ggbG9va3MgZ29vZC4NCg0KVGhhbmsg
eW91LA0KDQpFbnJpY28NCg0KPiBNaW1pDQo=

