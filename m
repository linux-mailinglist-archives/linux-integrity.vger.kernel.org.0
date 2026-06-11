Return-Path: <linux-integrity+bounces-9789-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id a7VtDu6vKmrruwMAu9opvQ
	(envelope-from <linux-integrity+bounces-9789-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jun 2026 14:54:06 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4236720F1
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jun 2026 14:54:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=polito.it header.s=selector1 header.b=BdJMnvfo;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9789-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9789-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=polito.it;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A94FB3087E67
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jun 2026 12:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4332E8DFC;
	Thu, 11 Jun 2026 12:51:10 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021129.outbound.protection.outlook.com [40.107.130.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264AF225788
	for <linux-integrity@vger.kernel.org>; Thu, 11 Jun 2026 12:51:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182270; cv=fail; b=X+lkMdLey7HrLvJajG71tt7haEUoxdYUVOrhCo2Zg2blbEGRXGyQky+Lp35IteYSUcuHjTGaEiy9XgLxah2L56NH2/9scNtKEB3k65BR5JIsV2HqqJydrUTGAvbbMcuwM2YAePqH+zWv6w/jxqTbt767VuE/AZ3oOyPQUahF3HQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182270; c=relaxed/simple;
	bh=xF3fgl5j6EnfTaqeK52zdiAAaJ+JdU0zcvLbsc2s9CU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZvfyFMVzDaf1CXmKUp/lnrL8vR2wqdbRtPjhinQSSlJ192FkUgQXvkXGH/68R2RbSHG3U8s3TB/fAMdRNpef5oglvOskQrRnmMDgAEJcTonwaANaJy4ZVlN/HdOvoDoKEkJ4RqzqrHj3nWqxCpR5jk4KF6oMMbvi1pqP9q7rutc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=BdJMnvfo; arc=fail smtp.client-ip=40.107.130.129
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fCzZjvcRT58nTNT+IeAzAIGssyIY6+1fDDRFKWY8f3oDyrPZpr/cMtopZ5TcC9GtcaNtX/XmrzbCIHFPY6fA0W6g0FcVmvlCkv9ax3Ce6m+Y6JqmsV4aJwFPNAyjLewocmRZQo6EYCMaDbGpv1ELHZRYmZhna4ZnChWo4vcYxM6GagZdEnXAsDwNBebJD4fYJ8JVJYLBkQp16D08qWxcwSZv1SBr3Cid0u8ScilhlwAYTfCdLKMk4aeIWtd4Yh2QVGbSChXWmjY0zpnnBTYIXyufJRLggM820LLRW1eRbTugLm38d53hrf23EHDosPUNnu4vuKHz7vLPHXxxirOhCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xF3fgl5j6EnfTaqeK52zdiAAaJ+JdU0zcvLbsc2s9CU=;
 b=V9r/WT1k+amGjp74cSuIJriurLLJjJ1SRl3cYysffK3YMtF9WcDhjTGzEnWfJlOj9hRARtsX8Kk9T0bKi0rcOsMScODiieEjCWXxDCzQcLAbZj4NrLBbn0+Ci1m5czYMgPIoJNpUK1qKsEy40aLQnDTOk/Q09PfmBc2ABMmhxWsRO3FUK1xnzVShfpHoo3382xrIHdbuNocv/1g9+3YRBThHaYERyzq/XZjPa5KSHre0oJpp+9QhbKRsLUfoHYfox/PfbmfC60zmpg3eTpTYmeSKCluT9rlZPjQeDkczAEt6rZfgPxME6eWMAS6m7AHGR+dXB4Dob4wS5g0zMG8N9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xF3fgl5j6EnfTaqeK52zdiAAaJ+JdU0zcvLbsc2s9CU=;
 b=BdJMnvfoB+8Z18t9PANscT8kZvJSincMBeFFK0LqfYrxn5ylfSyrlXcDYIcOn/gtapyQfsfTATT76gxI0wGJe1JEA7/Et7a3yko2jOj+dv2oUd3O1IXsdWycKa2cR91lANc7RteVMk833JwBFYW/TjFjyrKMpu8RRDW9r1IQGFk=
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com (2603:10a6:20b:253::20)
 by PAXPR05MB8014.eurprd05.prod.outlook.com (2603:10a6:102:156::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 12:51:03 +0000
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64]) by AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64%5]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 12:51:03 +0000
From: "Enrico  Bravi" <enrico.bravi@polito.it>
To: "roberto.sassu@huawei.com" <roberto.sassu@huawei.com>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"zohar@linux.ibm.com" <zohar@linux.ibm.com>, "dmitry.kasatkin@gmail.com"
	<dmitry.kasatkin@gmail.com>
CC: "eric.snowberg@oracle.com" <eric.snowberg@oracle.com>
Subject: Re: [RFC][PATCH v3 1/2] ima: measure loaded policy after write on
 securityfs policy file
Thread-Topic: [RFC][PATCH v3 1/2] ima: measure loaded policy after write on
 securityfs policy file
Thread-Index: AQHc7Rb/p4OAI86ozkSrMHU+y/Y+ebY38b4AgAF1/gA=
Date: Thu, 11 Jun 2026 12:51:03 +0000
Message-ID: <7149d8e873fe59fedffd23a06c9c647d42660328.camel@polito.it>
References: <20260526135118.289633-1-enrico.bravi@polito.it>
		 <20260526135118.289633-2-enrico.bravi@polito.it>
	 <f48148da72e9111235cb06d9c4d6c959d5c67035.camel@linux.ibm.com>
In-Reply-To: <f48148da72e9111235cb06d9c4d6c959d5c67035.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR05MB7880:EE_|PAXPR05MB8014:EE_
x-ms-office365-filtering-correlation-id: 225f0847-7b45-4604-2886-08dec7b818bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|786006|376014|38070700021|18002099003|22082099003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info:
 Rn8q1wTZgHDZ1gwLuAhP4sD5hauLG/we7/6MtLOZO81cLmfcN7frJXlnIWzfz6UpGWYsCXY7wk3TTxbBZK0GVf8bnON+x56TwmXn6NwwsWya4GCjtTw4XDoxG3KFdgmaFBr7XGmO6h74IDjWJsqQPduMPwObg/slSq3vOLnaT/4cEBq1XyHXlfA1YVjDzQdDSqDLsompOXaoNYJ1LBalivzZU5NFJFOysir2M9RXJnb8VZK43fQyefjRHZ+DwvPEz1MuP9gVOvbtLHcOz1JkRJ6I1InffGLKRJ+MOF/JyqiwtmTvsi6ZyMnvzuxUaubFojGAPK1fY32uoQ4N1W+k2WDz9WcsCzy4qFIOsDZ32oRgUNNFSBrxAhNT6/0+oLpYHzgsXXwme9o/teawfBCFxgEBeCDr3Jx53B+Qt8QWrtnZ0+lGwxsvZ7/d5oVgN5JtARE0bDion7jMFTmIB+6Xp8SNoXE1+GjcjG76SpvUk6u+p2s1DzCS8N4iZWO+XtvbLGNS5NxYmJCzUYGSGQYebpnv8nxepxa2AKVYVm9avI6ZJRCSzJuwHwk4Yyqgl/o/FfZTYv5iQ/gQYKQBmdYKLNWkQwcHP52cdD/h6tl7UuRfZg9y3RDqpY02Sq2WIz8rFP+fAlVMUkauLNGKbgOMZQGSIutJwds2uPx4nrcWxeq+YkHiwPsfBmCjhD/0B5gX5Nfl8/4YNkw97pf8yO0hFK8OFcbw7+LtXhPmCS5ozzYWxNCqzdHJagZFgEnNBOGk
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR05MB7880.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(786006)(376014)(38070700021)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MjRtbThOSjhUUW1yck9vaDd1b0FLRzhhSTJNb1d5eUloNHpxWTBxcG5KdUdr?=
 =?utf-8?B?dkZHVTZJbEFuUTBGVDA1cENtcWR6ZDI0QXhSQzQ4b3JoOFNKQWgzU2VINmFl?=
 =?utf-8?B?NGNYdDcyMW9kN2hvV3U1UU9tdFR2bFR3bVlkZ1Y5OTBJMUZWalhJOS9DaDRn?=
 =?utf-8?B?by9rOEp5SlRsT2R0L2txYUZwM2ZVODlTVkk1VDhRQm9BMXlqbkhlVzhGRWJ1?=
 =?utf-8?B?UFRjajYzQVFMWklDbnA0VVZsS0ZiSEo4QTc2VG1PU2hxdVlES3ZwRHU1Vno3?=
 =?utf-8?B?WWlURWhzTUpzaWxmK3VpN2pzcUJRQWtJTXJ1WGJzcHkxTzZnYUdMWUlGUGt4?=
 =?utf-8?B?ZnZIV1BPSVBYYWxHUVJhUzQ5QmFhbDFSZ2N4VUxqNEp2MUVtcjFvcmJRaTkw?=
 =?utf-8?B?UEtVTzNUa2hBY0ZQTVRUZG04cEV3U1RFZXZEWHczYzNkbWxvRnJ0NnR6b2Yx?=
 =?utf-8?B?aTY5dVJ4akZNdlhSdyt3a3lZUkdnR0hOU0hFbTBKSWI3RVdjNGZPN280VU5s?=
 =?utf-8?B?VVVpZEVnSHQ3cTVCd21UNjZUT1owVHpLRG5jMFNWR3l5c1lrRU8zV3dyMjEr?=
 =?utf-8?B?RmRvNE5JMmZhOUE2ZitmR0lKQ3dWNG5nT3RGS1AySW9kb3RzZU1VVFRyQlov?=
 =?utf-8?B?ZEFVbjZxSnllK1d2VUtjdjVJM1pEZzF5WWZReHQ2R3REOFkxTnBNa2FWZCt6?=
 =?utf-8?B?MlJiV3V0MG1QQ3BvUDFKS3NXSkFsaGF5RUxOVUgwYmFrUUl3dGhpeXd1SHc4?=
 =?utf-8?B?UjV2QVVNcHgweGJ3TmZuOUd1ekU5amJFRVhRTytnVWlGOVNhZ3dRUkh0cHBh?=
 =?utf-8?B?Vk1yYkZlZXAzWHVvR1lnMFp5d0VHZlgzV3FJYTh4VzUrMTYwVGR4NFd1QjJL?=
 =?utf-8?B?SC9xeVBWYzRKTVhOOGpzbU5YSFVtaVZxTEtUaU9wVjBTZUZPSlljT1hrYitD?=
 =?utf-8?B?eDNqckJRZ0czUmtxcDVodVlNa2dlcEZwbGJoSHpZSTJKeWhYOXh0L0RQY25x?=
 =?utf-8?B?NUt5Uys3VysyWFJLdFNxWUE2Nm5wUUxkQVZsNkE3TTBKL1ZlYWhjaWZjM3F1?=
 =?utf-8?B?b0wzZ2xjeWVMaC90eE5aOElUZnpnaHJRM1c1cXUvQmhGcmliMHJIRTNQd3o4?=
 =?utf-8?B?S3I3dXh3SlVzRTFaSWw1MzA0emI1WmR5aG1JNHM0WnhRalV6OSszV2ZzSlpw?=
 =?utf-8?B?N3NRU0RhK3RSY0dmNWxHSGE5cGlRKzUyUEhFVE5kT3RWeitnRUtMMlNhR0JE?=
 =?utf-8?B?NkExbGhhM3l0cDNpaTR4NTRINHV5OW1CYmVmYmpNNWlsbFpBRitpTXI1L1NP?=
 =?utf-8?B?UVRyWXZodDNGWHFxL3F2cytzUzBhOWRlTUwvQkVDT3NiQUNHOFNvU1F6N0J1?=
 =?utf-8?B?a2xWSTZWNkhGOGJ2UzRnWXhELzFvTmZubnl2K1d2czlvdXR1b2o0Q3pNVVpN?=
 =?utf-8?B?emE1WHVGSDhoMzdkQjNKT2JsNlQ5NHZyZmw1ZDFrMDB3N1hSNUZGbjdrUHlL?=
 =?utf-8?B?ZW5xbGgySG1HTGNuajZza042aCtQaUlRb1pRM2hZUU1uKzlLbUVuZnZrd3dR?=
 =?utf-8?B?a0x4MHZzZWpHM0VBOVhybHAxb0lwcXdzSUI2WUZmSE9HNWU2RmJ0ajVHbTE1?=
 =?utf-8?B?T29DOWd4OUZ3cGtHd1pRUFRUUHJBM0RkalhxYTN1dHJNQkJ3R2QzMklSR3BN?=
 =?utf-8?B?R1dIYXgxbzZ0bU5YMkp4eGxnOWt4SUpzalJrbUtnOTI4bnZZRjdRUVJGajNW?=
 =?utf-8?B?TEtKWDhiZk5HOXhkZk9ZRDN3dlhTYjdReTVOOTBmalNMUVp5d3RrRmMzY3R2?=
 =?utf-8?B?WXhudS9xRWt5MmF6K3owbXNLclo5OE5sS0dEdEJhVHVEdllhUWs3d2pzMDZ3?=
 =?utf-8?B?bG9acU8xMlZuUFZ1ekFaYlJGNGtiejlXTmo2dzJVdmdIU3UyR0NFN0xHTlZ3?=
 =?utf-8?B?Z3VaVXFyNWYwd0ZDMS9HbmJzUzlIMUdJbW1VWG1BTUtGS2dVTEFMejIzRkwz?=
 =?utf-8?B?RU04VHBQRnNpS0lOaHMxemp5dHRuY2JFSWhvbzQxOEJJWWhuWUQzVEZrUUN0?=
 =?utf-8?B?dklGY0owMTV4L0JWSjNFeFB2RnlKd1lDK1l6M2I3S2d0MytlR2ViSjQ3a3Bv?=
 =?utf-8?B?cmxDVmpQMVVWc3FiS2VweGYvaVhnaXV1a081ZEcrQUw0a2c5MWRESDdQTllr?=
 =?utf-8?B?WkJaY0ZERkpGVm5PSmEwc3FSZ2Z4OVBIZFgwZW81MlJZb0Y1bWp6UVB2TVJm?=
 =?utf-8?B?bjNhK1p0bkhyMmc2elNHbHlqWE1qUDJNdVBFMXc2aGdXTFJpVUpLS0JDQ1FT?=
 =?utf-8?B?RitPT3M4NGdyUElpUDB4UXVTejJMaTlPOGJ5c255VUNCTnZKS01NbG1YU01S?=
 =?utf-8?Q?0n5bVwi8c9dYjQX8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <98B8A8E016491A4F8A47191793A3362B@eurprd05.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 225f0847-7b45-4604-2886-08dec7b818bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2026 12:51:03.5540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VLsSuw3IflKjJML3a5zddrTLOgiGiMwPsQsX+8pqAn64GpPv0dDBKrd65+aTbtHrATs2YHIMmsTdtbVMI7os8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR05MB8014
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	FROM_NAME_EXCESS_SPACE(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[polito.it,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[polito.it:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9789-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,polito.it:dkim,polito.it:email,polito.it:mid,polito.it:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7A4236720F1

SGkgTWltaSwNCg0KT24gV2VkLCAyMDI2LTA2LTEwIGF0IDEwOjMyIC0wNDAwLCBNaW1pIFpvaGFy
IHdyb3RlOg0KPiBPbiBUdWUsIDIwMjYtMDUtMjYgYXQgMTU6NTEgKzAyMDAsIEVucmljbyBCcmF2
aSB3cm90ZToNCj4gPiBJTUEgcG9saWN5IGNhbiBiZSB3cml0dGVuIG11bHRpcGxlIHRpbWVzIGlu
IHRoZSBzZWN1cml0eWZzIHBvbGljeSBmaWxlDQo+ID4gYXQgcnVudGltZSBpZiBDT05GSUdfSU1B
X1dSSVRFX1BPTElDWT15LiBXaGVuIElNQV9BUFBSQUlTRV9QT0xJQ1kgaXMNCj4gPiByZXF1aXJl
ZCwgdGhlIHBvbGljeSBuZWVkcyB0byBiZSBzaWduZWQgdG8gYmUgbG9hZGVkLCB3cml0aW5nIHRo
ZSBhYnNvbHV0ZQ0KPiA+IHBhdGggb2YgdGhlIGZpbGUgY29udGFpbmluZyB0aGUgbmV3IHBvbGlj
eToNCj4gPiANCj4gPiBlY2hvIC9wYXRoL29mL2N1c3RvbV9pbWFfcG9saWN5ID4gL3N5cy9rZXJu
ZWwvc2VjdXJpdHkvaW1hL3BvbGljeQ0KPiA+IA0KPiA+IFdoZW4gdGhpcyBpcyBub3QgcmVxdWly
ZWQsIHBvbGljeSBjYW4gYmUgd3JpdHRlbiBkaXJlY3RseSwgcnVsZSBieSBydWxlOg0KPiA+IA0K
PiA+IGVjaG8gLWUgIm1lYXN1cmUgZnVuYz1CUFJNX0NIRUNLIG1hc2s9TUFZX0VYRUNcbiIgXA0K
PiA+IMKgwqDCoMKgwqDCoMKgICJhdWRpdCBmdW5jPUJQUk1fQ0hFQ0sgbWFzaz1NQVlfRVhFQ1xu
IiBcDQo+ID4gwqDCoMKgwqAgPiAvc3lzL2tlcm5lbC9zZWN1cml0eS9pbWEvcG9saWN5DQo+ID4g
DQo+ID4gSW4gdGhpcyBjYXNlLCBhIG5ldyBwb2xpY3kgY2FuIGJlIGxvYWRlZCB3aXRob3V0IGJl
aW5nIG1lYXN1cmVkIG9yDQo+ID4gYXBwcmFpc2VkLg0KPiA+IA0KPiA+IEFkZCBhIG5ldyBjcml0
aWNhbCBkYXRhIHJlY29yZCB0byBtZWFzdXJlIHRoZSB0ZXh0dWFsIHBvbGljeQ0KPiA+IHJlcHJl
c2VudGF0aW9uIHdoZW4gaXQgYmVjb21lcyBlZmZlY3RpdmUuDQo+ID4gVG8gdmVyaWZ5IHRoZSB0
ZW1wbGF0ZSBkYXRhIGhhc2ggdmFsdWUsIGNvbnZlcnQgdGhlIGJ1ZmZlciBwb2xpY3kgZGF0YQ0K
PiA+IHRvIGJpbmFyeToNCj4gPiBncmVwICJpbWFfcG9saWN5X2xvYWRlZCIgXA0KPiA+IAkvc3lz
L2tlcm5lbC9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2FzY2lpX3J1bnRpbWVfbWVhc3VyZW1lbnRz
IHwgXA0KPiA+IAl0YWlsIC0xIHwgY3V0IC1kJyAnIC1mIDYgfCB4eGQgLXIgLXAgfCBzaGEyNTZz
dW0NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBFbnJpY28gQnJhdmkgPGVucmljby5icmF2aUBw
b2xpdG8uaXQ+DQo+IA0KPiBUaGFua3MsIEVucmljby7CoCBKdXN0IGEgZmV3IGlubGluZSBjb21t
ZW50cy4NCg0KVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgeW91ciBmZWVkYmFjay4NCg0KPiA+IC0t
LQ0KPiA+IMKgc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWEuaMKgwqDCoMKgwqDCoMKgIHzCoCAx
ICsNCj4gPiDCoHNlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX2VmaS5jwqDCoMKgIHzCoCAyICsr
DQo+ID4gwqBzZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9mcy5jwqDCoMKgwqAgfMKgIDEgKw0K
PiA+IMKgc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfcG9saWN5LmMgfCA1NSArKysrKysrKysr
KysrKysrKysrKysrKysrKystLQ0KPiA+IMKgNCBmaWxlcyBjaGFuZ2VkLCA1NyBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9zZWN1cml0eS9pbnRl
Z3JpdHkvaW1hL2ltYS5oIGIvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWEuaA0KPiA+IGluZGV4
IDg5ZWJlOThmZmM1ZS4uYTIyM2QzZjMwZDg4IDEwMDY0NA0KPiA+IC0tLSBhL3NlY3VyaXR5L2lu
dGVncml0eS9pbWEvaW1hLmgNCj4gPiArKysgYi9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYS5o
DQo+ID4gQEAgLTQyNSw2ICs0MjUsNyBAQCB2b2lkICppbWFfcG9saWN5X3N0YXJ0KHN0cnVjdCBz
ZXFfZmlsZSAqbSwgbG9mZl90ICpwb3MpOw0KPiA+IMKgdm9pZCAqaW1hX3BvbGljeV9uZXh0KHN0
cnVjdCBzZXFfZmlsZSAqbSwgdm9pZCAqdiwgbG9mZl90ICpwb3MpOw0KPiA+IMKgdm9pZCBpbWFf
cG9saWN5X3N0b3Aoc3RydWN0IHNlcV9maWxlICptLCB2b2lkICp2KTsNCj4gPiDCoGludCBpbWFf
cG9saWN5X3Nob3coc3RydWN0IHNlcV9maWxlICptLCB2b2lkICp2KTsNCj4gPiArdm9pZCBpbWFf
bWVhc3VyZV9sb2FkZWRfcG9saWN5KHZvaWQpOw0KPiA+IMKgDQo+ID4gwqAvKiBBcHByYWlzZSBp
bnRlZ3JpdHkgbWVhc3VyZW1lbnRzICovDQo+ID4gwqAjZGVmaW5lIElNQV9BUFBSQUlTRV9FTkZP
UkNFCTB4MDENCj4gPiBkaWZmIC0tZ2l0IGEvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfZWZp
LmMNCj4gPiBiL3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX2VmaS5jDQo+ID4gaW5kZXggMTM4
MDI5YmZjY2UxLi44ZTlmODVlYzlhODYgMTAwNjQ0DQo+ID4gLS0tIGEvc2VjdXJpdHkvaW50ZWdy
aXR5L2ltYS9pbWFfZWZpLmMNCj4gPiArKysgYi9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9l
ZmkuYw0KPiA+IEBAIC02MCw2ICs2MCw4IEBAIHN0YXRpYyBjb25zdCBjaGFyICogY29uc3Qgc2Jf
YXJjaF9ydWxlc1tdID0gew0KPiA+IMKgI2VuZGlmDQo+ID4gwqAjaWYgSVNfRU5BQkxFRChDT05G
SUdfSU5URUdSSVRZX01BQ0hJTkVfS0VZUklORykgJiYNCj4gPiBJU19FTkFCTEVEKENPTkZJR19J
TUFfS0VZUklOR1NfUEVSTUlUX1NJR05FRF9CWV9CVUlMVElOX09SX1NFQ09OREFSWSkNCj4gPiDC
oAkiYXBwcmFpc2UgZnVuYz1QT0xJQ1lfQ0hFQ0sgYXBwcmFpc2VfdHlwZT1pbWFzaWciLA0KPiA+
ICsjZWxzZQ0KPiA+ICsJIm1lYXN1cmUgZnVuYz1DUklUSUNBTF9EQVRBIGxhYmVsPWltYV9wb2xp
Y3kiLA0KPiA+IMKgI2VuZGlmDQo+IA0KPiDCoE5vbmUgb2YgdGhlIG90aGVyIGFyY2ggIm1lYXN1
cmUiIHBvbGljeSBydWxlcyBhcmUgY29uZGl0aW9uYWwuwqAgU2hvdWxkIHRoZQ0KPiBuZXcNCj4g
Im1lYXN1cmUiIHJ1bGUgYmUgbGltaXRlZD8NCg0KVGhpcyBjb25kaXRpb24gYWltcyB0byBhdm9p
ZCBtZWFzdXJpbmcgdGhlIHBvbGljeSBsb2FkZWQgZXZlbiBpZiBhIHNpZ25lZCBwb2xpY3kNCmlz
IHJlcXVpcmVkLiBJbiB0aGF0IGNhc2UsIGl0IHdvdWxkIG5vdCBiZSBwb3NzaWJsZSB0byBkaXJl
Y3RseSB3cml0ZSB0aGUgcG9saWN5DQppbiB0aGUgc2VjdXJpdHlmcyBmaWxlLg0KDQo+ID4gwqAJ
Im1lYXN1cmUgZnVuYz1NT0RVTEVfQ0hFQ0siLA0KPiA+IMKgCU5VTEwNCj4gPiBkaWZmIC0tZ2l0
IGEvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfZnMuYw0KPiA+IGIvc2VjdXJpdHkvaW50ZWdy
aXR5L2ltYS9pbWFfZnMuYw0KPiA+IGluZGV4IDAxMmE1ODk1OWZmMC4uNzVjYjMwOGNmMDFmIDEw
MDY0NA0KPiA+IC0tLSBhL3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX2ZzLmMNCj4gPiArKysg
Yi9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9mcy5jDQo+ID4gQEAgLTQ3Niw2ICs0NzYsNyBA
QCBzdGF0aWMgaW50IGltYV9yZWxlYXNlX3BvbGljeShzdHJ1Y3QgaW5vZGUgKmlub2RlLA0KPiA+
IHN0cnVjdCBmaWxlICpmaWxlKQ0KPiA+IMKgCX0NCj4gPiDCoA0KPiA+IMKgCWltYV91cGRhdGVf
cG9saWN5KCk7DQo+ID4gKwlpbWFfbWVhc3VyZV9sb2FkZWRfcG9saWN5KCk7DQo+ID4gwqAjaWYg
IWRlZmluZWQoQ09ORklHX0lNQV9XUklURV9QT0xJQ1kpICYmICFkZWZpbmVkKENPTkZJR19JTUFf
UkVBRF9QT0xJQ1kpDQo+ID4gwqAJc2VjdXJpdHlmc19yZW1vdmUoZmlsZS0+Zl9wYXRoLmRlbnRy
eSk7DQo+ID4gwqAjZWxpZiBkZWZpbmVkKENPTkZJR19JTUFfV1JJVEVfUE9MSUNZKQ0KPiA+IGRp
ZmYgLS1naXQgYS9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9wb2xpY3kuYw0KPiA+IGIvc2Vj
dXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfcG9saWN5LmMNCj4gPiBpbmRleCBiZjJkN2JhNGMxNGEu
LmUwYjRkYWU5MjJiNiAxMDA2NDQNCj4gPiAtLS0gYS9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2lt
YV9wb2xpY3kuYw0KPiA+ICsrKyBiL3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX3BvbGljeS5j
DQo+ID4gQEAgLTE3LDYgKzE3LDcgQEANCj4gPiDCoCNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQo+
ID4gwqAjaW5jbHVkZSA8bGludXgvcmN1bGlzdC5oPg0KPiA+IMKgI2luY2x1ZGUgPGxpbnV4L3Nl
cV9maWxlLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC92bWFsbG9jLmg+DQo+ID4gwqAjaW5jbHVk
ZSA8bGludXgvaW1hLmg+DQo+ID4gwqANCj4gPiDCoCNpbmNsdWRlICJpbWEuaCINCj4gPiBAQCAt
MjAyMiw3ICsyMDIzLDYgQEAgY29uc3QgY2hhciAqY29uc3QgZnVuY190b2tlbnNbXSA9IHsNCj4g
PiDCoAlfX2ltYV9ob29rcyhfX2ltYV9ob29rX3N0cmluZ2lmeSkNCj4gPiDCoH07DQo+ID4gwqAN
Cj4gPiAtI2lmZGVmCUNPTkZJR19JTUFfUkVBRF9QT0xJQ1kNCj4gDQo+IFJlbW92aW5nIHRoZSBp
ZmRlZiwgaGVyZSwgZG9lcyBub3QgYWZmZWN0IHZpZXdpbmcgdGhlIElNQSBtZWFzdXJlbWVudCBs
aXN0cywNCj4gYnV0DQo+IGFsbG93cyBjb3B5aW5nIGFuZCBtZWFzdXJpbmcgdGhlIHBvbGljeSBy
dWxlcy7CoCBQbGVhc2UgaW5jbHVkZSBhIGNvbW1lbnQgaW4NCj4gdGhlDQo+IHBhdGNoIGRlc2Ny
aXB0aW9uLg0KDQpTdXJlLCB3aWxsIGFkZCBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQo+ID4gwqBl
bnVtIHsNCj4gPiDCoAltYXNrX2V4ZWMgPSAwLCBtYXNrX3dyaXRlLCBtYXNrX3JlYWQsIG1hc2tf
YXBwZW5kDQo+ID4gwqB9Ow0KPiA+IEBAIC0yMzI0LDcgKzIzMjQsNiBAQCBpbnQgaW1hX3BvbGlj
eV9zaG93KHN0cnVjdCBzZXFfZmlsZSAqbSwgdm9pZCAqdikNCj4gPiDCoAlzZXFfcHV0cyhtLCAi
XG4iKTsNCj4gPiDCoAlyZXR1cm4gMDsNCj4gPiDCoH0NCj4gPiAtI2VuZGlmCS8qIENPTkZJR19J
TUFfUkVBRF9QT0xJQ1kgKi8NCj4gPiDCoA0KPiA+IMKgI2lmIGRlZmluZWQoQ09ORklHX0lNQV9B
UFBSQUlTRSkgJiYNCj4gPiBkZWZpbmVkKENPTkZJR19JTlRFR1JJVFlfVFJVU1RFRF9LRVlSSU5H
KQ0KPiA+IMKgLyoNCj4gPiBAQCAtMjM4MSwzICsyMzgwLDU1IEBAIGJvb2wgaW1hX2FwcHJhaXNl
X3NpZ25hdHVyZShlbnVtIGtlcm5lbF9yZWFkX2ZpbGVfaWQNCj4gPiBpZCkNCj4gPiDCoAlyZXR1
cm4gZm91bmQ7DQo+ID4gwqB9DQo+ID4gwqAjZW5kaWYgLyogQ09ORklHX0lNQV9BUFBSQUlTRSAm
JiBDT05GSUdfSU5URUdSSVRZX1RSVVNURURfS0VZUklORyAqLw0KPiA+ICsNCj4gDQo+IFBsZWFz
ZSBhZGQga2VybmVsLWRvYyBoZXJlLCBzb21ldGhpbmcgbGlrZToNCj4gDQo+IC8qKg0KPiDCoCog
aW1hX21lYXN1cmVfbG9hZGVkX3BvbGljeSAtIG1lYXN1cmUgdGhlIGFjdGl2ZSBJTUEgcG9saWN5
IHJ1bGVzZXQNCj4gwqAqDQo+IMKgKiBNdXN0IGJlIGNhbGxlZCB3aXRoIGltYV93cml0ZV9tdXRl
eCBoZWxkLCBhcyBpdCBwZXJmb3JtcyB0d28NCj4gwqAqIHNlcGFyYXRlIFJDVSByZWFkIHBhc3Nl
cyBvdmVyIGltYV9ydWxlcyBhbmQgcmVsaWVzIG9uIHRoZSBtdXRleA0KPiDCoCogdG8gcHJldmVu
dCBjb25jdXJyZW50IHBvbGljeSB1cGRhdGVzIGJldHdlZW4gdGhlbS4NCj4gwqAqLw0KDQpTdXJl
LCB0aGFuayB5b3UuIElmIGl0IGlzIG9rIGZvciB5b3UgSSBjYW4gZGlyZWN0bHkgYWRkIHdoYXQg
eW91IHN1Z2dlc3RlZC4NCg0KPiA+ICt2b2lkIGltYV9tZWFzdXJlX2xvYWRlZF9wb2xpY3kodm9p
ZCkNCj4gPiArew0KPiA+ICsJY29uc3QgY2hhciAqZXZlbnRfbmFtZSA9ICJpbWFfcG9saWN5X2xv
YWRlZCI7DQo+ID4gKwljb25zdCBjaGFyICpvcCA9ICJtZWFzdXJlX2xvYWRlZF9pbWFfcG9saWN5
IjsNCj4gPiArCWNvbnN0IGNoYXIgKmF1ZGl0X2NhdXNlID0gIkVOT01FTSI7DQo+ID4gKwlzdHJ1
Y3QgaW1hX3J1bGVfZW50cnkgKnJ1bGVfZW50cnk7DQo+ID4gKwlzdHJ1Y3QgbGlzdF9oZWFkICpp
bWFfcnVsZXNfdG1wOw0KPiA+ICsJc3RydWN0IHNlcV9maWxlIGZpbGU7DQo+ID4gKwlpbnQgcmVz
dWx0ID0gLUVOT01FTTsNCj4gPiArCXNpemVfdCBmaWxlX2xlbjsNCj4gPiArCWNoYXIgcnVsZVsy
NTVdOw0KPiANCj4gVGhlIDI1NS1ieXRlIGJ1ZmZlciBtYXkgYmUgaW5zdWZmaWNpZW50IGZvciBj
dXN0b20gcG9saWN5IHJ1bGVzIHRoYXQgaW5jbHVkZQ0KPiBhZGRpdGlvbmFsIGZpZWxkcyBzdWNo
IGFzIExTTSBsYWJlbHMgYW5kIG90aGVyIGZpbGUgbWV0YWRhdGEsIHVubGlrZSB0aGUNCj4gc2lt
cGxlcg0KPiBidWlsdC1pbiBhbmQgYXJjaGl0ZWN0dXJlLXNwZWNpZmljIHJ1bGVzLiBQbGVhc2Ug
aW5jcmVhc2UgdGhlIGJ1ZmZlciBzaXplIHRvDQo+IGFjY29tbW9kYXRlIHRoZSB3b3JzdC1jYXNl
IHNlcmlhbGl6ZWQgcnVsZSBsZW5ndGguDQoNClllcywgSSB3cm9uZ2x5IHRvb2sgYXMgcmVmZXJl
bmNlIHRoZSBhcmNoIHBvbGljeSBydWxlcyBjYXNlLiBJIGRvbid0IGtub3cgaWYgdGhlDQp3b3Jz
dC1jYXNlIGNhbiBiZSBwcmVjaXNlbHkgZXN0aW1hdGVkLiBJIGNvdWxkIGluY3JlYXNlIHRoZSBi
dWZmZXIgc2l6ZSBhbmQNCmNoZWNrIGluIGFueSBjYXNlIGlmIHNlcV9oYXNfb3ZlcmZsb3dlZCgp
LiBDb3VsZCBpdCBiZSBhbiBpZGVhPw0KDQo+ID4gKw0KPiA+ICsJLyogY2FsY3VsYXRlIElNQSBw
b2xpY3kgcnVsZXMgbWVtb3J5IHNpemUgKi8NCj4gPiArCWZpbGUuYnVmID0gcnVsZTsNCj4gPiAr
CWZpbGUucmVhZF9wb3MgPSAwOw0KPiA+ICsJZmlsZS5zaXplID0gMjU1Ow0KPiA+ICsJZmlsZS5j
b3VudCA9IDA7DQo+ID4gKw0KPiANCj4gUGxlYXNlIGFkZCAibG9ja2RlcF9hc3NlcnRfaGVsZCgm
aW1hX3dyaXRlX211dGV4KTsiwqAgaGVyZS4NCg0KWWVzLCBhbmQgdGhpcyB3b3VsZCBhY3R1YWxs
eSBmYWlsIGJlY2F1c2UgSSdtIG5vdCBhY3F1aXJpbmcgaW1hX3dyaXRlX211dGV4IGluDQppbWFf
cmVsZWFzZV9wb2xpY3koKS4NCg0KPiA+ICsJcmN1X3JlYWRfbG9jaygpOw0KPiA+ICsJaW1hX3J1
bGVzX3RtcCA9IHJjdV9kZXJlZmVyZW5jZShpbWFfcnVsZXMpOw0KPiA+ICsJbGlzdF9mb3JfZWFj
aF9lbnRyeV9yY3UocnVsZV9lbnRyeSwgaW1hX3J1bGVzX3RtcCwgbGlzdCkgew0KPiA+ICsJCWlt
YV9wb2xpY3lfc2hvdygmZmlsZSwgcnVsZV9lbnRyeSk7DQo+ID4gKwkJZmlsZV9sZW4gKz0gZmls
ZS5jb3VudDsNCj4gPiArCQlmaWxlLmNvdW50ID0gMDsNCj4gPiArCX0NCj4gDQo+IFZhcmlhYmxl
cyBkZWZpbmVkIG9uIHRoZSBzdGFjayBuZWVkIHRvIGJlIGluaXRpYWxpemVkIGJlZm9yZSBiZWlu
ZyB1c2VkLg0KPiBQbGVhc2UNCj4gaW5paXRhbGl6ZSBmaWxlX2xlbiB0byB6ZXJvLg0KDQpTdXJl
LCB3aWxsIGZpeCB0aGF0Lg0KDQpUaGFuayB5b3UsDQoNCkVucmljbw0KDQo+ID4gKwlyY3VfcmVh
ZF91bmxvY2soKTsNCj4gPiArDQo+ID4gKwkvKiBjb3B5IElNQSBwb2xpY3kgcnVsZXMgdG8gYSBi
dWZmZXIgZm9yIG1lYXN1cmluZyAqLw0KPiA+ICsJZmlsZS5idWYgPSB2bWFsbG9jKGZpbGVfbGVu
KTsNCj4gPiArCWlmICghZmlsZS5idWYpIHsNCj4gPiArCQlpbnRlZ3JpdHlfYXVkaXRfbXNnKEFV
RElUX0lOVEVHUklUWV9QQ1IsIE5VTEwsIGV2ZW50X25hbWUsDQo+ID4gKwkJCQnCoMKgwqAgb3As
IGF1ZGl0X2NhdXNlLCByZXN1bHQsIDEpOw0KPiA+ICsJCXJldHVybjsNCj4gPiArCX0NCj4gPiAr
DQo+ID4gKwlmaWxlLnJlYWRfcG9zID0gMDsNCj4gPiArCWZpbGUuc2l6ZSA9IGZpbGVfbGVuOw0K
PiA+ICsJZmlsZS5jb3VudCA9IDA7DQo+ID4gKw0KPiA+ICsJcmN1X3JlYWRfbG9jaygpOw0KPiA+
ICsJaW1hX3J1bGVzX3RtcCA9IHJjdV9kZXJlZmVyZW5jZShpbWFfcnVsZXMpOw0KPiA+ICsJbGlz
dF9mb3JfZWFjaF9lbnRyeV9yY3UocnVsZV9lbnRyeSwgaW1hX3J1bGVzX3RtcCwgbGlzdCkgew0K
PiA+ICsJCWltYV9wb2xpY3lfc2hvdygmZmlsZSwgcnVsZV9lbnRyeSk7DQo+ID4gKwl9DQo+ID4g
KwlyY3VfcmVhZF91bmxvY2soKTsNCj4gPiArDQo+ID4gKwlpbWFfbWVhc3VyZV9jcml0aWNhbF9k
YXRhKCJpbWFfcG9saWN5IiwgZXZlbnRfbmFtZSwgZmlsZS5idWYsDQo+ID4gKwkJCQnCoCBmaWxl
LmNvdW50LCBmYWxzZSwgTlVMTCwgMCk7DQo+ID4gKw0KPiA+ICsJdmZyZWUoZmlsZS5idWYpOw0K
PiA+ICt9DQo+IA0KPiBUaGFua3MsDQo+IA0KPiBNaW1pDQo=

