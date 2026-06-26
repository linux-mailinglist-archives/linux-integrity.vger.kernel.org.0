Return-Path: <linux-integrity+bounces-9842-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gYCOEzRHPmoMCgkAu9opvQ
	(envelope-from <linux-integrity+bounces-9842-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jun 2026 11:32:36 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AB83A6CBB6F
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jun 2026 11:32:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=polito.it header.s=selector1 header.b=IPiXEs7A;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9842-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9842-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=polito.it;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BAAB0300B849
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jun 2026 09:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9412D7393;
	Fri, 26 Jun 2026 09:32:34 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023080.outbound.protection.outlook.com [52.101.83.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C6C30C168
	for <linux-integrity@vger.kernel.org>; Fri, 26 Jun 2026 09:32:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782466354; cv=fail; b=C2Rt2thq8Q2sSADxda7TYSI0WBiI1m6t3BgGa2Jv45y8+1Xl8uEGs9w3nJFRUIl5hCpL4qFgBLS064hqkF/H4NUYCxnNqm76YAcEYhCucSWKXFhjWBXY8643iWxaqh+R2fVyd9lCbntvRPJkvtHcyplhcLRbo/7yS8MUDuNqJfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782466354; c=relaxed/simple;
	bh=sko+PlmxJCv4oPjdzJTHZH+Ljuqc6mnoBL/TXWB4KbY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OMf5Oc2+UOcvbqMTHBIdQT/ufhSq0o4p99c+Lg0Weu1kjVKSBFXEZLvGplgeiMQj1p7ERkGWLZqYv/e2GLWZAecavAVSqeiVJNcX++qK2q+C27QAVntmVpuQfu33eQDxjJJZSEPW2xdL0M02c++b/8W1t7J2+00LNQrSUk34k5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=IPiXEs7A; arc=fail smtp.client-ip=52.101.83.80
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZLSvBTGfE/EHBI57VWbKEiyCkTHKrFNN0FJp0jsc0CxBVHrfnR19uX7qXgrW9qzC7/ZUHjadgg5COFcMvsF+ZLpkgWUHiDLh//0iPUy6ZPjPuv5aDkAnlUn4ID9yh0dJ1qoSuJ33par7ik3ZtijcNUVI4rPcALA2sp9ZvAHc7WoBdeaAuFnKHAkItqu1AdlzID4r/ZVI5f4YuIpTURNnSxqDkaD67MyEpqnO3Bjk71j7Rsie9voVPpeIlSNHvbgiU9XOtEyhzqC+Lt1JcxVW6aDujUxlr+DZAWonBYZmSIuGxmKDC05L/+1SPIW0LpVOsw3nMPnUwVIXb94iqKqm9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sko+PlmxJCv4oPjdzJTHZH+Ljuqc6mnoBL/TXWB4KbY=;
 b=J6rWad76SsZNxoAAgNOUlYhS7uSCiZhNhZvIGMUVUa0Pe4PX8SqGpGNxABR8HMJd5tR1L/VSK6xikOvfNfZkl4ic1lXd6QUcaP6B6OZG7GnqsKAWi9A8nqDL5m4F/0f/1gPsf6SR5NkVGFk4lTIOMlS446Anj8KvAMHN9YjHjU/kOTCxNghfDBLMSXl6GEkvAw8Z/iBXozP+4hMPJq55/lRBInPDM7BXM7Ky5vk6cln+UdTr5xBjajtQxtRw+evV5s+WtULkyYrNBIF9N/yVyA5khbw75+NFr0xRMWviwcpcyQwvfrlFQiDwXkk8EWSdS7HQ28Cj8sKeRC+yGOojMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sko+PlmxJCv4oPjdzJTHZH+Ljuqc6mnoBL/TXWB4KbY=;
 b=IPiXEs7AudFyP3264HcEKvkUooerhTBSoECF1IMku9BpHG8fKY/B6R78Tw6jOWxtDjmidgZyQ10L9bpkT3QE51Yjw3cD3X2td3PYADolS8lz6Epr/pWjzGMmkGB7eZFokNCm18unJmyXAswRCZjhySYiVLM/vxGvpRINycyfEDE=
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com (2603:10a6:20b:253::20)
 by AMDPR05MB12063.eurprd05.prod.outlook.com (2603:10a6:20b:73a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Fri, 26 Jun
 2026 09:32:27 +0000
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64]) by AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64%5]) with mapi id 15.21.0139.018; Fri, 26 Jun 2026
 09:32:26 +0000
From: "Enrico  Bravi" <enrico.bravi@polito.it>
To: "roberto.sassu@huawei.com" <roberto.sassu@huawei.com>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"zohar@linux.ibm.com" <zohar@linux.ibm.com>, "dmitry.kasatkin@gmail.com"
	<dmitry.kasatkin@gmail.com>
CC: "eric.snowberg@oracle.com" <eric.snowberg@oracle.com>
Subject: Re: [PATCH v4 1/2] ima: measure loaded policy after write on
 securityfs policy file
Thread-Topic: [PATCH v4 1/2] ima: measure loaded policy after write on
 securityfs policy file
Thread-Index: AQHc/nNlfixRMSHkm0WWEbcS7ec3nLZONRmAgAJrZgA=
Date: Fri, 26 Jun 2026 09:32:26 +0000
Message-ID: <a5ee67057fe003e0fd98f679e640c627af1f6b83.camel@polito.it>
References: <20260617155832.434517-1-enrico.bravi@polito.it>
		 <20260617155832.434517-2-enrico.bravi@polito.it>
	 <1f23b6cb35538f471dbb68534308784616130cb9.camel@linux.ibm.com>
In-Reply-To: <1f23b6cb35538f471dbb68534308784616130cb9.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR05MB7880:EE_|AMDPR05MB12063:EE_
x-ms-office365-filtering-correlation-id: 0f783e94-1fe5-4e6f-41de-08ded365d5fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|786006|366016|23010399003|376014|18002099003|22082099003|38070700021|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info:
 0NjLp9gCiq6ITLq9nri4CNqEv4lxUeK6knMThKjWFsVOSNfh1mbj6ZggsN0NUUmwbEinSiomPclDgLDSG8gDeFUoDtRZ2Y+v2qzZCDY0k8NSYM2Qazn7q3OCUH/79vHh10HM6c8k0VVXQUiunr4Uueyw7tKk4kLxNZq4DLefgdgYJ+U1cYZxmYn32C7r3ph4siBTmRiZ8PFs83u8LEinmSuA6dA5di10TFf/77K0InXPy9C8Xk1eGNJKKDzGGNhLKgkyg1mNc+Kt/zAZxqZDQCLhiHH6lfaE2OCCLXWKgBubihOz1wB+a64PnpUqShBDAYOTpxfMOl5BTMDxJh8OrEoGcqtdIKlrs/ygrSjuKwa1ms15N8BQNP11LF0PVLF7ZF3S11a8XBmLzFIe4AS4ti9SqTj0W7r+SQuZmhJOaTkJQ5C+B7zE1TJj0Ksr7r0BafiQ7NgCjGNc/Pqv7HqyGftwgAFD2onwJFoen5viCNKQSeEn7wJBRvE4jfrbkUyVZvjWbOzLHSZsy1yu5diWyHp32lrV2rmMa/wIpfVOeNTH23eiiLYechGHhuDAmGXKL/L0UlEcZkoKh3vFh/ujcpWEbYLRd6UHO+YZRaHFnfF7KpLDZQsDFqgnYO6jslURj2sGZHcahXORCFG9bp1MdJ6BhEq9XjbwuJKqUwAsvMGm3NS2xHZCd6fMxUTOAWm7rdbcxeDMBe7CPXvDf7QR5HAHwHEqsVRB93c/cEsHYmg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR05MB7880.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(786006)(366016)(23010399003)(376014)(18002099003)(22082099003)(38070700021)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SnRiRlVWYVpSRWpSYktMQjN1cmM5eVVHOGdYRWp3aHh5NmhUcFlGWmhlZEds?=
 =?utf-8?B?M0V0YngxemQ4NTJZdmMrbzUvSmN4SGJreTMrcXcwSnJqcHBSVlZZNElFeWVw?=
 =?utf-8?B?SENTOEZ2OUozenpWaytGZHBjYkc1cVp0ZTl0b05NMGMwY05YSVBtK3J3NUp5?=
 =?utf-8?B?ZFFSR1N6eGprc0FDcmZ4Q1lTUFhmWjVwaVBCK3U1SjRGUHFGaXhtc0ZNTlJZ?=
 =?utf-8?B?UGlkVFdveUZiaTJ2UnVUdmpVUzVWN3VzZ3RqejZOclQwTFZuc080VzVOWnNH?=
 =?utf-8?B?Yy8vRzh6Nk1qYkdnYk1EYnNKWkRkeGNnYkExZjE3U2RjWnFadGpaQm1oRjA4?=
 =?utf-8?B?bjJ0UVQyeTRGR2VBaHViR0d6WGYreUo3Qzc2UnFqRm0waGxRVWM0V3k4NFdG?=
 =?utf-8?B?dUdTcUgrakpLcThlVVlFNTZLWDN5RWtBUkVWU1REMHhqN1krMlgxYzg5N1Y1?=
 =?utf-8?B?TW14TGpvQk13d1p0SlpkcUtreG9lL1VKa3lRckx3VGZ0dTBrUmo1bnJWcWF6?=
 =?utf-8?B?c3h0V1ZNUkZYdnRWSStySS93UmpLWnhwdzlQZnFQUEVYSFB0SkdNcFFMUk9h?=
 =?utf-8?B?ek5QQTNFbW42L3dIcURyNEdlZFZnWFhZRmptb2xlV1pEbWwvQUZsVFJOOFZm?=
 =?utf-8?B?NmZJV2dNOHUxM0FCWWcyZUpPU00zaEVOUWJZL1FrTXc2TEFxS2ZPV1U0YUVt?=
 =?utf-8?B?a2ljMW1QdXBLT25JUVpabHFGblU0SVhmdlorTG5jdkVrOHFlYzNyQm5mWEU2?=
 =?utf-8?B?b0lrTGFuMVJnaXBwMDh3bFdSemZYbm5FUjVKME44YnA4ZXJYUFJ5SWJyaXRv?=
 =?utf-8?B?M3k4VDAzUFZMY0g3VHBBVUk5ZlNEWUFlVDFzaFhEdXRLMGh3ZnZtNmxqdGZK?=
 =?utf-8?B?aHFTOWdjUDloK0FZL1hmbmZEMlMzTlBLWVlWbDFFY3Y4SlcvYm9LNGNRSTJI?=
 =?utf-8?B?dDFuTmFKYlB1ZFVaL0ZxaU1YSitqVlhnWVVCTWoxZ1FmcGpneGNEN0tHZmly?=
 =?utf-8?B?bFMzUXZGZXE1WkFRMFp6a3hjSUJ0bnhNVm01a21sVFQzWnFPb3ZLVHJ3Qm9I?=
 =?utf-8?B?LzU4NGVjZWdxVFg3bHRvODRTN0lKL3kraXM2eUdPaG1udzVCWndoRGFWQVZn?=
 =?utf-8?B?YzJCU2VFZmsxblhiN0c4dDVMcUdIQ0ZobnRtcndOYW82LzhvSFdKeWZ6SUkx?=
 =?utf-8?B?N0svQkZJaE5JVXAvR2hiUDZaZ3FpN2N3dkZlcUpFWFRzVE1wODZDTDdNNVpt?=
 =?utf-8?B?Qmh5WDJEUFpkdnBMcUhWdUtURndlbjhQdXNCWDdpRHUzTjRMM2FWVjNpbk5L?=
 =?utf-8?B?MUpFT3Y3RUl3cEV6UjNVbG1ianNGVUhwZnpLYjlBZVFzSzNrUy9URDQvSm80?=
 =?utf-8?B?OG41UEFZR0lCcmtnUWdFbnJtQjhNRGxkYk9HNFFXYmJxVUJTc251Q05Cd3BZ?=
 =?utf-8?B?dXBIN1U3V3YwTkJ4dmU5WVJlT3IzVjA0elBPTElhNG1pRDNiODFQenQzYVE0?=
 =?utf-8?B?ZWliSHh2MWoyV05WWWZNZVBLeFlmU3k1OFdFaEc5ZVNTK1JUanYrNzhLYlo2?=
 =?utf-8?B?cVcvTmZiWGdaZzZBeldvYlF2OFdORjBHY3lwWjBTUDBKNnBmeXRvUDZzZSt4?=
 =?utf-8?B?YThGQ0pvQmNneHE4SHFSKzU2Tk8rTjlXdFFGMkpqZUFRTUhtcWV1YndBU3lI?=
 =?utf-8?B?U1BrRmhlMjRDL0tGSzNDMDdhUVpQb2dOSWdMbXlLL05ibDVpQVM1VGgvZE4r?=
 =?utf-8?B?SlBIc21zNUlTQXNRVjBSQkMyT1FwUVNRcUpxK1RuMElCL2h1MXQwaFBjNmZV?=
 =?utf-8?B?MStqMFVBSXlXNWJSNFd5aEh6N2ZxUzhBeFUyN3dyRFpDeVBXL21aT1lxZDVp?=
 =?utf-8?B?UnQzWlNqL0JiVlBpaUk5NmJ5ZkZ6VDExa3V2eDRWZlp5YStRVG10cHJ3WXZo?=
 =?utf-8?B?UDJpVEVDMHNzd2d2SHdTVFBLeHd2VFRXNlFJbUpnbjdzQlAxZkFQdzR5Z3FT?=
 =?utf-8?B?RGlneHF5b0tFK1VFWWlZNzdLQ1JmZi9BQU9VbzZnVDNYaW54ZTlyWkNidGla?=
 =?utf-8?B?TVZwRDJVVW5TV01hTWJkcUpXREhTOWJza3NDU2lTaUprcE0zQWFtc3VXZWcw?=
 =?utf-8?B?QzFmNllLQnZ0MEhGTjRFOUlKbnJLNC85cXVSbDkzMGtPVDNxVmRRVjExV2sx?=
 =?utf-8?B?KzFlWEhNRllieXJtLzJnU05KMGU3YVRuVURvdlg1MlZMVGVCQitkVHRBbWF5?=
 =?utf-8?B?TXpUd1FsNE5VeE0wV05KRk9yeHVsRGx6QlhRQ2JwL2RkTEtEa1FKaS9pV3ZG?=
 =?utf-8?B?RVhKS3pjQ2xLWlpiT25OZ0hnOC9FMFJ3VFhkZnFydmFHU2N4VXd5dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46749A4B1CC4DF489BDCC5F21EF31FEE@eurprd05.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f783e94-1fe5-4e6f-41de-08ded365d5fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2026 09:32:26.8066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sozjOVO7dWvX/kTUNOiVdIyWG06/bHC8F7ev1Z26o0eeBhlKsNbxwB/PwnsOn3ZrP5X0A9vI0Gmyk4RgZ3X+DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR05MB12063
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	FROM_NAME_EXCESS_SPACE(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[polito.it,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[polito.it:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9842-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AB83A6CBB6F

SGkgTWltaSwNCg0KT24gV2VkLCAyMDI2LTA2LTI0IGF0IDE2OjM1IC0wNDAwLCBNaW1pIFpvaGFy
IHdyb3RlOg0KPiBUaGUgU3ViamVjdCBsaW5lIG5lZWRzIHRvIGJlIHdyaXR0ZW4gZnJvbSBhIGhp
Z2hlciBwZXJzcGVjdGl2ZS7CoCBJdCBkZXNjcmliZXMNCj4gImhvdyIsIG5vdCAid2hhdCIuDQo+
IENvbnNpZGVyIHVzaW5nICJpbWE6IGFkZCBjcml0aWNhbCBkYXRhIG1lYXN1cmVtZW50IGZvciBs
b2FkZWQgcG9saWN5Ii4NCg0KeWVzLCB3aWxsIGNoYW5nZSBpdC4NCg0KPiBPbiBXZWQsIDIwMjYt
MDYtMTcgYXQgMTc6NTggKzAyMDAsIEVucmljbyBCcmF2aSB3cm90ZToNCj4gPiBJTUEgcG9saWN5
IGNhbiBiZSB3cml0dGVuIG11bHRpcGxlIHRpbWVzIGluIHRoZSBzZWN1cml0eWZzIHBvbGljeSBm
aWxlDQo+ID4gYXQgcnVudGltZSBpZiBDT05GSUdfSU1BX1dSSVRFX1BPTElDWT15LiBXaGVuIElN
QV9BUFBSQUlTRV9QT0xJQ1kgaXMNCj4gPiByZXF1aXJlZCwgdGhlIHBvbGljeSBuZWVkcyB0byBi
ZSBzaWduZWQgdG8gYmUgbG9hZGVkLCB3cml0aW5nIHRoZSBhYnNvbHV0ZQ0KPiA+IHBhdGggb2Yg
dGhlIGZpbGUgY29udGFpbmluZyB0aGUgbmV3IHBvbGljeToNCj4gPiANCj4gPiBlY2hvIC9wYXRo
L29mL2N1c3RvbV9pbWFfcG9saWN5ID4gL3N5cy9rZXJuZWwvc2VjdXJpdHkvaW1hL3BvbGljeQ0K
PiA+IA0KPiA+IFdoZW4gdGhpcyBpcyBub3QgcmVxdWlyZWQsIHBvbGljeSBjYW4gYmUgd3JpdHRl
biBkaXJlY3RseSwgcnVsZSBieSBydWxlOg0KPiA+IA0KPiA+IGVjaG8gLWUgIm1lYXN1cmUgZnVu
Yz1CUFJNX0NIRUNLIG1hc2s9TUFZX0VYRUNcbiIgXA0KPiA+IMKgwqDCoMKgwqDCoMKgICJhdWRp
dCBmdW5jPUJQUk1fQ0hFQ0sgbWFzaz1NQVlfRVhFQ1xuIiBcDQo+ID4gwqDCoMKgwqAgPiAvc3lz
L2tlcm5lbC9zZWN1cml0eS9pbWEvcG9saWN5DQo+ID4gDQo+ID4gSW4gdGhpcyBjYXNlLCBhIG5l
dyBwb2xpY3kgY2FuIGJlIGxvYWRlZCB3aXRob3V0IGJlaW5nIG1lYXN1cmVkIG9yDQo+ID4gYXBw
cmFpc2VkLg0KPiA+IA0KPiA+IEFkZCBhIG5ldyBjcml0aWNhbCBkYXRhIHJlY29yZCB0byBtZWFz
dXJlIHRoZSB0ZXh0dWFsIHBvbGljeQ0KPiA+IHJlcHJlc2VudGF0aW9uIHdoZW4gaXQgYmVjb21l
cyBlZmZlY3RpdmUuIEluY2x1ZGUgaW4gdGhlDQo+ID4gYXJjaGl0ZWN0dXJlLXNwZWNpZmljIHBv
bGljeSB0aGUgbmV3IGNyaXRpY2FsIGRhdGEgcmVjb3JkIG9ubHkgd2hlbiBpdA0KPiA+IGlzIG5v
dCBtYW5kYXRvcnkgdG8gbG9hZCBhIHNpZ25lZCBwb2xpY3kuIEFkZGl0aW9uYWxseSwgZW5hYmxl
IHRoZQ0KPiA+IHBvbGljeSBzZXJpYWxpemF0aW9uIGNvZGUgZXZlbiB3aGVuIENPTkZJR19JTUFf
UkVBRF9QT0xJQ1k9bi4NCj4gPiANCj4gPiBUbyB2ZXJpZnkgdGhlIHRlbXBsYXRlIGRhdGEgaGFz
aCB2YWx1ZSwgY29udmVydCB0aGUgYnVmZmVyIHBvbGljeSBkYXRhDQo+ID4gdG8gYmluYXJ5Og0K
PiA+IGdyZXAgImltYV9wb2xpY3lfbG9hZGVkIiBcDQo+ID4gwqDCoMKgwqDCoMKgwqAgL3N5cy9r
ZXJuZWwvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9hc2NpaV9ydW50aW1lX21lYXN1cmVtZW50cyB8
IFwNCj4gPiDCoMKgwqDCoMKgwqDCoCB0YWlsIC0xIHwgY3V0IC1kJyAnIC1mIDYgfCB4eGQgLXIg
LXAgfCBzaGEyNTZzdW0NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBFbnJpY28gQnJhdmkgPGVu
cmljby5icmF2aUBwb2xpdG8uaXQ+DQo+IA0KPiBUaGFuayB5b3UgZm9yIG1ha2luZyB0aGUgY2hh
bmdlcy4NCj4gDQo+IFsgLi4uIF0NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL3NlY3VyaXR5L2ludGVn
cml0eS9pbWEvaW1hX3BvbGljeS5jDQo+ID4gYi9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9w
b2xpY3kuYw0KPiA+IGluZGV4IGY3Zjk0MGE3NjkyMi4uMGE3MGQxMGRhNzBhIDEwMDY0NA0KPiA+
IC0tLSBhL3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX3BvbGljeS5jDQo+ID4gKysrIGIvc2Vj
dXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfcG9saWN5LmMNCj4gDQo+ID4gQEAgLTIzNzksMyArMjM3
OCw3MCBAQCBib29sIGltYV9hcHByYWlzZV9zaWduYXR1cmUoZW51bSBrZXJuZWxfcmVhZF9maWxl
X2lkDQo+ID4gaWQpDQo+ID4gwqAJcmV0dXJuIGZvdW5kOw0KPiA+IMKgfQ0KPiA+IMKgI2VuZGlm
IC8qIENPTkZJR19JTUFfQVBQUkFJU0UgJiYgQ09ORklHX0lOVEVHUklUWV9UUlVTVEVEX0tFWVJJ
TkcgKi8NCj4gPiArDQo+ID4gKy8qKg0KPiA+ICsqIGltYV9tZWFzdXJlX2xvYWRlZF9wb2xpY3kg
LSBtZWFzdXJlIHRoZSBhY3RpdmUgSU1BIHBvbGljeSBydWxlc2V0DQo+ID4gKyoNCj4gPiArKiBN
dXN0IGJlIGNhbGxlZCB3aXRoIGltYV93cml0ZV9tdXRleCBoZWxkLCBhcyBpdCBwZXJmb3JtcyB0
d28NCj4gPiArKiBzZXBhcmF0ZSBSQ1UgcmVhZCBwYXNzZXMgb3ZlciBpbWFfcnVsZXMgYW5kIHJl
bGllcyBvbiB0aGUgbXV0ZXgNCj4gPiArKiB0byBwcmV2ZW50IGNvbmN1cnJlbnQgcG9saWN5IHVw
ZGF0ZXMgYmV0d2VlbiB0aGVtLg0KPiA+ICsqLw0KPiA+ICt2b2lkIGltYV9tZWFzdXJlX2xvYWRl
ZF9wb2xpY3kodm9pZCkNCj4gPiArew0KPiA+ICsJY29uc3QgY2hhciAqZXZlbnRfbmFtZSA9ICJp
bWFfcG9saWN5X2xvYWRlZCI7DQo+ID4gKwljb25zdCBjaGFyICpvcCA9ICJtZWFzdXJlX2xvYWRl
ZF9pbWFfcG9saWN5IjsNCj4gPiArCXN0cnVjdCBpbWFfcnVsZV9lbnRyeSAqcnVsZV9lbnRyeTsN
Cj4gPiArCXN0cnVjdCBsaXN0X2hlYWQgKmltYV9ydWxlc190bXA7DQo+ID4gKwlzdHJ1Y3Qgc2Vx
X2ZpbGUgZmlsZTsNCj4gPiArCWludCByZXN1bHQgPSAtRU5PTUVNOw0KPiA+ICsJc2l6ZV90IGZp
bGVfbGVuID0gMDsNCj4gPiArCWNoYXIgcnVsZVs1MTJdOw0KPiA+ICsNCj4gPiArCS8qIGNhbGN1
bGF0ZSBJTUEgcG9saWN5IHJ1bGVzIG1lbW9yeSBzaXplICovDQo+ID4gKwlmaWxlLmJ1ZiA9IHJ1
bGU7DQo+ID4gKwlmaWxlLnJlYWRfcG9zID0gMDsNCj4gPiArCWZpbGUuc2l6ZSA9IDUxMjsNCj4g
PiArCWZpbGUuY291bnQgPSAwOw0KPiA+ICsNCj4gPiArCWxvY2tkZXBfYXNzZXJ0X2hlbGQoJmlt
YV93cml0ZV9tdXRleCk7DQo+ID4gKw0KPiA+ICsJcmN1X3JlYWRfbG9jaygpOw0KPiA+ICsJaW1h
X3J1bGVzX3RtcCA9IHJjdV9kZXJlZmVyZW5jZShpbWFfcnVsZXMpOw0KPiA+ICsJbGlzdF9mb3Jf
ZWFjaF9lbnRyeV9yY3UocnVsZV9lbnRyeSwgaW1hX3J1bGVzX3RtcCwgbGlzdCkgew0KPiA+ICsJ
CWltYV9wb2xpY3lfc2hvdygmZmlsZSwgcnVsZV9lbnRyeSk7DQo+ID4gKwkJaWYgKHNlcV9oYXNf
b3ZlcmZsb3dlZCgmZmlsZSkpIHsNCj4gPiArCQkJcmVzdWx0ID0gLUUyQklHOw0KPiA+ICsJCQlp
bnRlZ3JpdHlfYXVkaXRfbXNnKEFVRElUX0lOVEVHUklUWV9QQ1IsIE5VTEwsDQo+ID4gZXZlbnRf
bmFtZSwNCj4gPiArCQkJCQnCoMKgwqAgb3AsICJydWxlX2xlbmd0aCIsIHJlc3VsdCwgMSk7DQo+
ID4gKwkJCXJldHVybjsNCj4gDQo+IE9uIGZhaWx1cmUgdGhlIG5ldyBJTUEgcG9saWN5IHdpbGwg
bm90IGJlIG1lYXN1cmVkLiBJbnN0ZWFkIG9mIGhhcmQgY29kaW5nIHRoZQ0KPiBidWZmZXIgdG8g
NTEyLCBkZWZpbmUgYSBmaWxlIHN0YXRpYyBnbG9iYWwgdmFyaWFibGUgdG8ga2VlcCB0cmFjayBv
ZiB0aGUNCj4gbWF4aW11bQ0KPiBwb2xpY3kgcnVsZSBzaXplLsKgIGltYV9wYXJzZV9hZGRfcnVs
ZSgpIGFscmVhZHkgcmV0dXJucyB0aGUgcG9saWN5IHJ1bGUNCj4gbGVuZ3RoLg0KPiBCZWZvcmUg
cmV0dXJuaW5nIHVwZGF0ZSB0aGUgbWF4IHBvbGljeSBydWxlIHNpemUgdmFyaWFibGUgYXMgbmVj
ZXNzYXJ5Lg0KPiANCj4gSGVyZSBpbiBpbWFfbWVhc3VyZV9sb2FkZWRfcG9saWN5KCkgYWxsb2Nh
dGUvZnJlZSB0aGUgYnVmZmVyLg0KDQpZZXMsIHRoaXMgaXMgbXVjaCBiZXR0ZXIuIEluIHRoaXMg
d2F5IHRoZSBjaGVjayBvbiBzZXFfaGFzX292ZXJmbG93ZWQoKSBzaG91bGQNCm5vdCBiZSBuZWNl
c3NhcnkgYW55bW9yZS4NClRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHlvdXIgc3VnZ2VzdGlvbnMu
DQoNCkVucmljbw0KDQo+IE1pc3NpbmcgcmN1X3JlYWRfdW5sb2NrKCkgYmVmb3JlIHJldHVybmlu
Zy4NCj4gDQo+IHRoYW5rcywNCj4gDQo+IE1pbWkNCj4gDQo+ID4gKwkJfQ0KPiA+ICsNCj4gPiAr
CQlmaWxlX2xlbiArPSBmaWxlLmNvdW50Ow0KPiA+ICsJCWZpbGUuY291bnQgPSAwOw0KPiA+ICsJ
fQ0KPiA+ICsJcmN1X3JlYWRfdW5sb2NrKCk7DQo+ID4gKw0KPiA+ICsJLyogY29weSBJTUEgcG9s
aWN5IHJ1bGVzIHRvIGEgYnVmZmVyIGZvciBtZWFzdXJpbmcgKi8NCj4gPiArCWZpbGUuYnVmID0g
dm1hbGxvYyhmaWxlX2xlbik7DQo+ID4gKwlpZiAoIWZpbGUuYnVmKSB7DQo+ID4gKwkJaW50ZWdy
aXR5X2F1ZGl0X21zZyhBVURJVF9JTlRFR1JJVFlfUENSLCBOVUxMLCBldmVudF9uYW1lLA0KPiA+
ICsJCQkJwqDCoMKgIG9wLCAiRU5PTUVNIiwgcmVzdWx0LCAxKTsNCj4gPiArCQlyZXR1cm47DQo+
ID4gKwl9DQo+ID4gKw0KPiA+ICsJZmlsZS5yZWFkX3BvcyA9IDA7DQo+ID4gKwlmaWxlLnNpemUg
PSBmaWxlX2xlbjsNCj4gPiArCWZpbGUuY291bnQgPSAwOw0KPiA+ICsNCj4gPiArCXJjdV9yZWFk
X2xvY2soKTsNCj4gPiArCWltYV9ydWxlc190bXAgPSByY3VfZGVyZWZlcmVuY2UoaW1hX3J1bGVz
KTsNCj4gPiArCWxpc3RfZm9yX2VhY2hfZW50cnlfcmN1KHJ1bGVfZW50cnksIGltYV9ydWxlc190
bXAsIGxpc3QpIHsNCj4gPiArCQlpbWFfcG9saWN5X3Nob3coJmZpbGUsIHJ1bGVfZW50cnkpOw0K
PiA+ICsJfQ0KPiA+ICsJcmN1X3JlYWRfdW5sb2NrKCk7DQo+ID4gKw0KPiA+ICsJaW1hX21lYXN1
cmVfY3JpdGljYWxfZGF0YSgiaW1hX3BvbGljeSIsIGV2ZW50X25hbWUsIGZpbGUuYnVmLA0KPiA+
ICsJCQkJwqAgZmlsZS5jb3VudCwgZmFsc2UsIE5VTEwsIDApOw0KPiA+ICsNCj4gPiArCXZmcmVl
KGZpbGUuYnVmKTsNCj4gPiArfQ0K

