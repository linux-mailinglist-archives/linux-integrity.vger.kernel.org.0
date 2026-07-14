Return-Path: <linux-integrity+bounces-9936-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qZbVBm4AVmroxgAAu9opvQ
	(envelope-from <linux-integrity+bounces-9936-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jul 2026 11:25:02 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A603752D0B
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jul 2026 11:25:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=polito.it header.s=selector1 header.b=f8pZJV1N;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9936-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9936-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=polito.it;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A1A13116FBC
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jul 2026 09:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D6D42669A;
	Tue, 14 Jul 2026 09:20:05 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021096.outbound.protection.outlook.com [52.101.70.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0293F3FA5EF
	for <linux-integrity@vger.kernel.org>; Tue, 14 Jul 2026 09:20:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784020805; cv=fail; b=ML5ehaI0BZ1Gk2VY6NOemmGlMJK+ABuiMVre2tapkIjoOZ5Qi/IxZsKt1R++eUEX7liRss4e9qdnlb+2zXw72StBc14C2QFsV/fURPLd0xmpHUD6d92qyIua/lWaLrFLsDp8kg2FinUn1MxZ9jz+TnkSKtt2d+6GYkBiKq6kvUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784020805; c=relaxed/simple;
	bh=zvNIYSaqfxkW8otoPuZLvMeDV+vMC/gvUfe/e5F96ZM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H5HJ3tkNp8VymZB7jUFcMc7MoWaXwEYVnQyWrUI7BRIO8pgAZwf+FE3w7jBRwmiUeO+vXZN6fAhsllKGq3l8R6BB0mJ3j8CHOQ9eJCS/ucwFyQUqJVci4lWebdkmKsHWPxukbnQMtLSePxyXLjHPfZJz3UGZadIeCD9bmIpgeIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=f8pZJV1N; arc=fail smtp.client-ip=52.101.70.96
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZDdNS8hJefONb1mELNj6TnETQt3JSCpwJJ8Rmzdpb7q0ANMpIBt980ITiBRdSXmMWGL6ZdWch2U30tYO62FAQ+VrVEAez19l/+uHOSrGfNKr4RHIlSWiYPFLZ65qv9VNuGNpdN4brpk+AfEwhbisWIz2yyPTpGYZm0j5XOuTS6x41ZrhleF8Px/1lO9KvaCFk6R475IiZcVbLtoQJiBdvhRRrxd6DvJXNJSoXC2EBrVjGsri9F4puHS4W91K+0N5e/3oUqS/XSLAtNZLv8AMw0lZaHnRVg3ouM3n1WCOaEL+0qNOdTUK9Ra3kZAVa1zSM8HKubcSfZBr3nMi1zZYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvNIYSaqfxkW8otoPuZLvMeDV+vMC/gvUfe/e5F96ZM=;
 b=m3dYDL3Nvoj6i6GT6zvsJqYb1A7kPdWk2IqzTtP6+loGlI1mGFGvPEaC5TmxQ9Rw067de+rcTZ1g4W+3XPoVcGWhKvNqIFs6lhFgLr5dWyfUSPJ882JTG1jYMTG5yqusshK2Itsyup9teyTRHoyCBfPLMJhLjOnwaETds7iXTDH5xOdOZDCJwIlSbl8BEF0SaQ6xSx8o+H60iE8qep7p9voPTPcnCsJbZe8F1lyLpAPc5QYfDn8QRpWz/ZwqFSWmrReFMEc/Fcb4p8CBHftNC/1ZtXJG7rQBNqHTq61PZxJhbaouHH+4lNt7kpFQUaN62LJqFAV+7/O9IB65WchN8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvNIYSaqfxkW8otoPuZLvMeDV+vMC/gvUfe/e5F96ZM=;
 b=f8pZJV1NUdTbcl9kjlH5agsC8SfWOCoaBWIucMX323PSzvbrt3LmAT2vkZi/Gmt84XBvCXx/mbDXmgJ9kBBiu/QxtSHsUTjceo6gfhJDL6/jwjPjaQmRP/9WWkiyedFbMvzIBTY8WJUXFHAIzSF+NreTARX3Bj73oZsLgmZ5lMU=
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com (2603:10a6:20b:253::20)
 by AM9PR05MB8337.eurprd05.prod.outlook.com (2603:10a6:20b:3a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Tue, 14 Jul
 2026 09:19:58 +0000
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64]) by AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64%5]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 09:19:58 +0000
From: "Enrico  Bravi" <enrico.bravi@polito.it>
To: "roberto.sassu@huawei.com" <roberto.sassu@huawei.com>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"zohar@linux.ibm.com" <zohar@linux.ibm.com>, "dmitry.kasatkin@gmail.com"
	<dmitry.kasatkin@gmail.com>
CC: "eric.snowberg@oracle.com" <eric.snowberg@oracle.com>
Subject: Re: [PATCH v6 0/2] ima: measure write on securityfs policy file
Thread-Topic: [PATCH v6 0/2] ima: measure write on securityfs policy file
Thread-Index: AQHdEqEVdKDNqQ3tA0axC+XpZoWlQ7ZrvEMAgAECWoA=
Date: Tue, 14 Jul 2026 09:19:58 +0000
Message-ID: <aa6587411f07e770622e9f6435849404aa97cb61.camel@polito.it>
References: <20260713080954.28520-1-enrico.bravi@polito.it>
	 <6003ccfc3e6077ff14dd3f8d2fda6c5c4d5b71dd.camel@linux.ibm.com>
In-Reply-To: <6003ccfc3e6077ff14dd3f8d2fda6c5c4d5b71dd.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR05MB7880:EE_|AM9PR05MB8337:EE_
x-ms-office365-filtering-correlation-id: b088e072-2a7c-4200-46cd-08dee189136d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|786006|23010399003|1800799024|376014|18002099003|22082099003|38070700021|11063799006|56012099006|3023799007|4143699003;
x-microsoft-antispam-message-info:
 41KhFb5HMynCWsTVZGD4y7jWyOxq8H7wT59YA9yPhA124kLirkKXdgRxe0NvT+FJneIuDPGRE83q2c67qwWBXs+iXyFBLFhIMhPWhtjp1Ao1IpDi5O9tOZXy4YaFh+ZtwAjrOlnSzOVoUnYNvac5CdXTnZQhg/AsdvV/z8qgLN4a/amOOj7yBwcR6MSk64M4dR3TIIE02w9cQOWoYfO2LdURmAm0015l3SP5nNtHROqOEfw2bx3QYOdGIGsOuJNwA2RZSobZ9e/2liqGdxxrPlUCdcknMqPhoZPUlzQJiWL2Ngq914WsYYlBj3JoXdtizp7pei73lNt8tJ07903t9hJkxjusZIzVS76wAdgEfhLqaaaPjrmCbSDe2PAZvkEiJE9v1JDRzk4thDhsutC9SRdLNe0Fgs+rGrEtnWrdQPAI7Yl3OpAevNo/j60Uq7LOpEjnSX79hhhgXN3J1ooayHVk0nPQwbM0/DLSdkGsQqCyJOY2ThiaXEYWtd5eC47INEZ3HbMJ5TzW/XI/Lk7HHgmPx6sjN7ZK7zApDUqaY+KJve+NFa2QO9VV9Xr80rqx/gws8b8uE5vAJOuXWT9muiNiXiShxMtsrdNPHFt8ZOa1+9d+r2vcHWZDux1xkH/Wya4X/7OTFTxxQTzAypZnhRMYX8f4KEjwDNtPkfSU25wvIOKcfp0k7Bg7zNVz++tGUIryhZq1bxcG586AU3COUZ05hRvjALVXmboMFr2q9T0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR05MB7880.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(786006)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(38070700021)(11063799006)(56012099006)(3023799007)(4143699003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bmFhME9rRnpvTFF0RmpTRTE1YTY5MGJwWWJmb1djRHFEMDVHaFJ2V2pUZGhR?=
 =?utf-8?B?bklqckpjQzFYcXY4M3hQaDQ1YVpaNzN4V01LY2sxWjBuR1Zqa2tlYVRDdG5p?=
 =?utf-8?B?VUpKWlh4M3B5d0k0R0NtOEhDOVFkQXJLZ21WTVBZRTJublhwZUpoMVhhdnBp?=
 =?utf-8?B?ZElBek1MUW5aTzV6d0lvOUw4NWRNdHFZQTF3NjZra1FXTThQUEZhUmkzenZZ?=
 =?utf-8?B?RytmaXhjL28yclVwU2Z1YnBvYXJPcjczY3pidlhPeXk1OXRTWnFwYm4xYk82?=
 =?utf-8?B?czFzOFdQU2JEdTFxMHVxNUhGN2NBUEYrWk56NC9Ga3U0L2xVeE95bGhsVFl2?=
 =?utf-8?B?d2Z5RElWa1VYNnRMK0JMUU11SzdROFc2QVRqaVJiR2swYlVRRGw5REZoSTlk?=
 =?utf-8?B?bUxxZEdmVUtNbElIR20wOWZ5RXIwMzh3amUxNEtNUS9nOVhvVm5YeTJBeXow?=
 =?utf-8?B?Sk5MMkRFa05aUTFCczkzbGxVcmZXLzhTdjZ4WUUwZWliMGQwM2FrSWNObm9v?=
 =?utf-8?B?YUY3VnFVT0oySWVUVDVmZ09BRkpkZ3hQTlVrSGdvSVhZNGh5WXZhZndBYU5F?=
 =?utf-8?B?UFJ5VmpQRStYNkh0Tm1wQmxYZHFvOGFFUkpZemxYOVRxQ3ZCcFBjalREWnMr?=
 =?utf-8?B?OWNIM0JZNnBObWZqL3VydUc4SGFuU29tMHZad2JvNUs4U3U5ei85QWwrSURW?=
 =?utf-8?B?TDNubEFnVXpMY1B0N1luVVQvdk9UQ2c1TmJ0N2lzbHJSTU9UV0o5cnVvMUFx?=
 =?utf-8?B?czVsWENxdGQySWNNbkV6a0RGTnFFQWx2NTNYNFhHVzE1cDgwSzdob1pDdDZ6?=
 =?utf-8?B?cHc1UlN5U0l2UHpLdzVYTFRxSDJLNDhsTzM5M0IyZHQwRlhncUVEOWZJN0M1?=
 =?utf-8?B?VFJjeTBqekxxbXNGelg1cmxvaDkrQmFFTjBMSjhBNE4vaTdTcnNLcUN5K3BU?=
 =?utf-8?B?em9SY21INUJHdk9ZSVNiay9lNm12QzJCWnZYWEtmQmt6Z0s0UW9TeDIzUlRS?=
 =?utf-8?B?L1ZMRU5LZjJ1a205L25jWWx3NEVqQXNBT0lEVzlpQk5uQmFyZnYzODJTbjNr?=
 =?utf-8?B?QzhPME1CU1NnN3dTWUI5ditwem5kQzhxTHQxTDVxU3BpeHVKQzFWRExyYmNj?=
 =?utf-8?B?MTIrWm9kQzFJb291WWRxcnFQZTk5TGk5eXFWMktJa2s5dHI5c3g0ZTJVV3p3?=
 =?utf-8?B?bWdLVjMvZzdXTkVlOVVGZXpVY0R5SmxLRUpTUjNQcUFnZGZDQ3J5SHRSUTVy?=
 =?utf-8?B?NENOT0tZTWZoK0NUSWtxTXNDSjVoRGFRemhxdkxCWVFEZ3paUUZ4ODNacUp3?=
 =?utf-8?B?TlRJdU1nV2Z1VUZRa2wrS3Rub1MzNTBGS3UwSWJrSjZ1MGxIMU1tU20vTU91?=
 =?utf-8?B?TEFzcC9iN1dyK2pzVFk0VTVmSlR5VVBZcmwxQnB6Vmo0SmlZMHBUTDA4dTRD?=
 =?utf-8?B?cmRlbUdvcmE5Y1ZrdkxVRjlRak81K1E0MnhQeGxENk1pcnhwU0czN2ZjK2sw?=
 =?utf-8?B?elJaTUJidzFxVzY0WElLNXA2NkpNNDB3MzBtQ1V1anIvcWF1c3QwTEZQQnRL?=
 =?utf-8?B?WkR1L1ZCQXNEOGsrTXVsemtGRWU4NkJ4VW9samxzaGRGbGp3QzFEcXRUSFBi?=
 =?utf-8?B?ajhCOEp5SFJZUldUclJCY00rcGQ1ZzBUbHVKREVGQ3R2Wjc2eXk0WE02bmtl?=
 =?utf-8?B?VG96UVQyNjJKVDR3cE05VmdhbmExbDg2RENIOHFPeExhb2N2Y3g4a29hL2dW?=
 =?utf-8?B?Z0RIcUtqVFRKN1EvMG1jeW9sTUlBSU8vRGVZVWpRRHp0Zzcwc2YvK2s3Ukcy?=
 =?utf-8?B?SFhQUVJtMWZuRkZPNTlBZldTZVJ6cExDaWM0R0taZng0anZGWSsraStHMXdK?=
 =?utf-8?B?ekdJSnFCVGpRNFZiRDhpTEJJNnc5TGk2MHlMTEF6RmJDMjZxbEdGbGluVC9n?=
 =?utf-8?B?WmEyVjc2WDFHWGdWVHF1OHRyMEVxN2RoN2N0bWllYlZWNXQvSy9qQUtlTlVh?=
 =?utf-8?B?OGNSejJHZzVxQ2ZyY0hncTlyZlVHcVFSRHJSWncxS04xTjAvZCtOVUlJTnBv?=
 =?utf-8?B?aUQ0cUNlRFg1TEdmZVE5QzNZbC9SV2lDRXEwZElISHlIbFV3QjFmNGhyTS9B?=
 =?utf-8?B?ekgwTnBybnpjdHBOaE51Ymh6WE5PbW9JU0RuekRFU3RiU1NpK0ZwRkVNUWxB?=
 =?utf-8?B?RnQxdXc5QnRWRWZvYzBhT3h6QUtGV3grUUE3QzV4YXl5Zmc5VmM5Q0NmT1FK?=
 =?utf-8?B?Ni9Ia1FzME9ZTXNiTjhIV1hwaXdNQzBqZnBpTnVUdHdKckJyeUdUOTV3RlFs?=
 =?utf-8?B?UlVPRDZ1ait6dVgvQlMrOWJWanZxYlRueUV2eXk0K01UQkdxZ2ZJQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1F6627C0F47364EBDF57FCAB394F599@eurprd05.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b088e072-2a7c-4200-46cd-08dee189136d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 09:19:58.5451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tolo+GIkGgubA+zI1wDu0gvd73kd+FkwQ8E49SABLZ4+8Ea2LT6e38eLgsa49s7OgmXGSXFeq6urkinL4mRiCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR05MB8337
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
	TAGGED_FROM(0.00)[bounces-9936-lists,linux-integrity=lfdr.de];
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
X-Rspamd-Queue-Id: 5A603752D0B

T24gTW9uLCAyMDI2LTA3LTEzIGF0IDEzOjU1IC0wNDAwLCBNaW1pIFpvaGFyIHdyb3RlOg0KPiBP
biBNb24sIDIwMjYtMDctMTMgYXQgMTA6MDkgKzAyMDAsIEVucmljbyBCcmF2aSB3cm90ZToNCj4g
PiBUaGlzIHNlcmllcyBhaW1zIHRvIGludHJvZHVjZSBpbnRlZ3JpdHkgbWVhc3VyZW1lbnRzIHdo
ZW4gdGhlIElNQSBwb2xpY3kgaXMNCj4gPiB3cml0dGVuIG9uIHRoZSBzZWN1cml0eWZzIGZpbGUu
DQo+ID4gSW4gcGFydGljdWxhciwgd2hlbiBhIHNpZ25lZCBwb2xpY3kgaXMgbm90IG1hbmRhdG9y
eSwgaXQgY2FuIGJlIHdyaXR0ZW4NCj4gPiBkaXJlY3RseSBvbiB0aGUgc2VjdXJpdHlmcyBmaWxl
LiBUaGlzIGFsbG93cyB0byBvdmVycmlkZSB0aGUgYm9vdCBwb2xpY3kNCj4gPiBhdCB0aGUgZmly
c3Qgd3JpdGUsIGFuZCBhcHBlbmQgbmV3IHBvbGljeSBydWxlcyBhdCB0aGUgc3Vic2VxdWVudCB3
cml0ZXMgKGlmDQo+ID4gQ09ORklHX0lNQV9XUklURV9QT0xJQ1k9eSkuIEluIHRoaXMgY2FzZSBu
ZXcgcG9saWN5IGNhbiBiZSBsb2FkZWQNCj4gPiB3aXRob3V0IGJlaW5nIG1lYXN1cmVkLg0KPiA+
IA0KPiA+IFRoZSBwYXRjaCAjMSBpbnRyb2R1Y2VzIGEgbmV3IGNyaXRpY2FsLWRhdGEgcmVjb3Jk
IGZvciB0aGUgbmV3bHkgbG9hZGVkDQo+ID4gcG9saWN5LiBUaGUgbWVhc3VyZW1lbnQgaXMgcGVy
Zm9ybWVkIG92ZXIgdGhlIHRleHR1YWwgcmVwcmVzZW50YXRpb24gb2YgdGhlDQo+ID4gbmV3IHBv
bGljeSBvbmNlIGl0IGJlY29tZXMgZWZmZWN0aXZlIChhZnRlciBpbWFfdXBkYXRlX3BvbGljeSgp
KS4gQXMNCj4gPiBzdWdnZXN0ZWQgYnkgTWltaSwgdGhlIG5ldyBjcml0aWNhbC1kYXRhIHJ1bGUg
aXMgYWRkZWQgdG8gdGhlIGFyY2gNCj4gPiBzcGVjaWZpYyBwb2xpY3kgcnVsZXMgKG9ubHkgd2hl
biBhIHNpZ25lZCBwb2xpY3kgaXMgbm90IG1hbmRhdG9yeSkuDQo+ID4gDQo+ID4gVGhlIHBhdGNo
ICMyLCBmb2xsb3dpbmcgd2hhdCB3YXMgc3VnZ2VzdGVkIGJ5IFJvYmVydG8sIG1lYXN1cmVzIHRo
ZSBpbnB1dA0KPiA+IGJ1ZmZlciBzZW50IHRvIHRoZSBzZWN1cml0eWZzIHBvbGljeSBmaWxlLCBy
ZWdhcmRsZXNzIG9mIHdoZXRoZXIgdGhlIG5ldw0KPiA+IHBvbGljeSB3aWxsIGJlIGFjY2VwdGVk
IG9yIG5vdC4gVGhpcyBpcyBkb25lIGJ5IGNhbGxpbmcNCj4gPiBwcm9jZXNzX2J1ZmZlcl9tZWFz
dXJlbWVudCgpLCBlbmFibGluZyBQT0xJQ1lfQ0hFQ0sgaW4gaW1hX21hdGNoX3J1bGVzKCkgYW5k
DQo+ID4gaW1hX21hdGNoX3J1bGVfZGF0YSgpIGluIG9yZGVyIHRvIGNhdGNoIGl0IHdoZW4gJ21l
YXN1cmUgZnVuYz1QT0xJQ1lfQ0hFQ0snDQo+ID4gaXMgZGVmaW5lZCAoZS5nLiwgaW1hX3BvbGlj
eT10Y2IpLg0KPiA+IA0KPiA+IENoYW5nZXMgaW4gdjY6DQo+ID4gwqAtIEZpeGVkIGEgbWVyZ2Ug
Y29uZmxpY3QuDQo+ID4gwqAtIEluaXRpYWxpemVkIHN0cnVjdCBzZXFfZmlsZSBmaWxlLg0KPiA+
IMKgLSBGaXhlZCBzb21lIGxpbmVzIGxvbmdlciB0aGFuIDgwIGNoYXJhY3RlcnMuDQo+ID4gwqAt
IE1vdmVkIGZyb20gdm1hbGxvYygpIHRvIGttYWxsb2MoKS4NCj4gPiDCoC0gQ29ycmVjdGVkIFBP
TElDWV9DSEVDSyBiZWhhdmlvdXIgaW4gaW1hX21hdGNoX3J1bGVzKCkuDQo+IA0KPiBUaGFua3Ms
IEVucmljby7CoCBUaGUgcGF0Y2hlcyBhcmUgbm93IHF1ZXVlZC4NCg0KVGhhbmsgeW91IE1pbWku
DQoNCkVucmljbw0K

