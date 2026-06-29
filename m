Return-Path: <linux-integrity+bounces-9846-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V52BDL87QmqX2QkAu9opvQ
	(envelope-from <linux-integrity+bounces-9846-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Jun 2026 11:32:47 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC206D8408
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Jun 2026 11:32:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=polito.it header.s=selector1 header.b=SHSKE+pz;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9846-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9846-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=polito.it;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BF8430247D4
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Jun 2026 09:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A2A306498;
	Mon, 29 Jun 2026 09:27:00 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020117.outbound.protection.outlook.com [52.101.84.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5C05B21A
	for <linux-integrity@vger.kernel.org>; Mon, 29 Jun 2026 09:26:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782725220; cv=fail; b=pGxUdxMoA/EHyeL03Yy86ZDHEcJRJGQeOKk9xsHQkreTICeVWxqqC8aJsnuwzxLkbxxvyCBLT6jKNWSHIrPEQwn/vGOFkCaopfbU3mpcwpCaA+yFUByYdhXBfuoOC7xvD9OQ1nH/wg5JNTC3RZ5oDCp+sZ7dBuo6bVQr/mnAmUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782725220; c=relaxed/simple;
	bh=VRONqn/rfkJlkee/wWozVirmvFzCMn0c0L29xio6m7A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MuzFUy0hKbhbjThH5N8taRASE4T9czKycUHTDn+N3alpq9ALpLE8raMsd9NsVpeva8ii+hrAJ9Ryi+mrZkEO/SS/xjcf+46Vxiqbg7nmUHFW7NZSqLnxEZGiBRWsNluykPfOvFzxEhcLC2k3qWCAXfzlITKdSRJDPvzOKEEmbXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=SHSKE+pz; arc=fail smtp.client-ip=52.101.84.117
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iy+wOZFFIsp5eGlcsI1GRD3uRGIWDDeqyU22VxCJXKU5yDWwQB6ugimdTja5B0ZUavGIdJqgrwkUeMkv5J1B7zsubZFH305kKXpnmA4yl4XP1cxvG39kdoXsQJ0HRyW9+IwmKP1U/jgEVGnHa7UfAjCR9WB9Rt5x3yfF0c2HHQd/bAN25MRFIfJVJQHX8stsUlVB01yRlOKQSZDp5ZT+GL7uohWuzs5EvkpBC9UJuY8POWpIfxSZeH4hMQQo/j1x84poRBZEnDMHjdtIOfWvalggF32HNxTOpJIsB8XwtOQ5WcQnFmv3zGS41VVeunZIGEJydIt39CZULMFkOtYwuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRONqn/rfkJlkee/wWozVirmvFzCMn0c0L29xio6m7A=;
 b=x99qbS8qNZIy1SAbQbfTrHSX3vV84FtN+aVBUDOStgvnRZTqODrhC9HySIkNlorXeJw6iNBfSwixD8ecxqltXROwCVwX+vtIWpKL/wnGnTJJj5M+VkiYBubLyBFBPjXMhcn+vtvBDwlyfbtXF7wIZy54ALJjHXZKlnpNjFzEIFMO1i72ybk5oTGdgg8pnBoXdkwkHUJQ9vgrHLZ5CpmX9obxyZQcmC9vsjqqnzyeySBTvtoO0NwFRkuQUMfJe337/+4XSUL3Kgt8L2uSHIb1MEKKEi42DVXbCXJq+8Sd0mLnofGFOfYiJT+bFMlYnBmrQauGBDLVzwP2KYq1U01+SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRONqn/rfkJlkee/wWozVirmvFzCMn0c0L29xio6m7A=;
 b=SHSKE+pzREkT4SWwsypXBcxmP5Sfnt/gUIk/uCZd3r4gCODfezZTpQ6+l5aKyqOsgoZbnZY7TKi+zJ2vHGXymjohfVWaCQHEt5ujU4YZIdZ/bAki+7unBlShUu1ZWtzcm0S+vNyW0tLy/xzXXmjHmSn1O32lwVEiA8KRIDKc6Nw=
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com (2603:10a6:20b:253::20)
 by DU0PR05MB9741.eurprd05.prod.outlook.com (2603:10a6:10:412::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 29 Jun
 2026 09:26:47 +0000
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64]) by AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64%5]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 09:26:46 +0000
From: "Enrico  Bravi" <enrico.bravi@polito.it>
To: "roberto.sassu@huawei.com" <roberto.sassu@huawei.com>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"zohar@linux.ibm.com" <zohar@linux.ibm.com>, "dmitry.kasatkin@gmail.com"
	<dmitry.kasatkin@gmail.com>
CC: "eric.snowberg@oracle.com" <eric.snowberg@oracle.com>
Subject: Re: [PATCH v4 2/2] ima: measure buffer sent to securityfs policy file
Thread-Topic: [PATCH v4 2/2] ima: measure buffer sent to securityfs policy
 file
Thread-Index: AQHc/nN9eKBkDA8OPkGhlSCbQJvLt7ZOgIwAgAbVXAA=
Date: Mon, 29 Jun 2026 09:26:46 +0000
Message-ID: <28759e3a57545d6d401ed111f38bd7e8b2ecf59d.camel@polito.it>
References: <20260617155832.434517-1-enrico.bravi@polito.it>
		 <20260617155832.434517-3-enrico.bravi@polito.it>
	 <997ae675fb1f987876226b3c6072c3f82a0d95cb.camel@linux.ibm.com>
In-Reply-To: <997ae675fb1f987876226b3c6072c3f82a0d95cb.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR05MB7880:EE_|DU0PR05MB9741:EE_
x-ms-office365-filtering-correlation-id: 953e8eed-a96f-4e43-25ab-08ded5c08a98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|786006|366016|6133799003|18002099003|22082099003|11063799006|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info:
 7ISMRWiPDApCCYyJpXQdFqAbdTIwQIIP7Sv4FXodC1Za0MzfXG7SLCq430VX+TPbbq/P7oFHPiu3qhc7Pr+dbAj9TzpyLr5CV8uN3fOlKeBi41JROiXfSQY1nTn3yMIpN744hDkbIex6YYiQm9SlXyPsyrK1W//NIk2qTzf3ffpyyOHl+U0fYyVkv7MGPgP8hlI+a8qkCO9f8RZI0DI0kJSNki6oVCJrcUdcMRonOjnbNxCESoD6SeWL0fKL0zUNu5YfEJ3SQO14lsZSRdg85qWHQYhZ4XnN0Ln4t3XXDvfod6RlpyeIXKIy7U2bWKpOKdTLd/Ux9rLTbtcXff8S1tQtIvUufz9JdZg1IWD564T//a7Vp/kcEvpQMlc5pbfc3CVQodbF2phaf4ej1jDIKjdNi8xlUoKJVsTmKjfR43PqCi8Q9A1sMe3iZIaZO5ABLsh87+de03RDO2CVptxq49tuyV96Bpl/tnStRdBUDPYRRf+m0mMJi1I7FtVS3AVmOXEkso3k9P3UdO0Gz+F+shcTOvf1wwc8lB6bSlK7bATPgZu4wtfRwYoZLuYxyneq+MT+P44yXc7PJ2eTM+SLX9FiL0Wu5s+P9X9XFQrwlje8Dcmvza76ePNcqhwpVnMN5iM1nJWmsGapa5oJxKNV2t+JIXfCmypOplzuSV+HtPGxwY9JEkU5oVJkJEeyPnyuRk34hq2Yg9Dcdn56cakScExyOncfMUgYB7UhKLcha0w=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR05MB7880.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(786006)(366016)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UFVNSDc3L1ZMc25jSVFTajFRelFrUmhsTE5nQWo5V1QrQlMvbkNGNTRrOHli?=
 =?utf-8?B?dWdVb1lxMVgwNGhlTEh2Z2dCTlp1ZmdlWmlsMTZ1enJEWnR4bi9wQlFnaksx?=
 =?utf-8?B?Z1J6QTBVb2NNeDlDYVZ4dUxaQTVibjR6dEJMTFRaTDZIQjEyKzQ3ZmxHSkZx?=
 =?utf-8?B?T0dMSEQ3VkpFVXpxOUpZZTQ1WWZmdGJlclhubkFtZHJ2MVNLWkZyaWxMNXZz?=
 =?utf-8?B?R2R6dEZzQ0ZPWlNIMmtWU2hSZjNWNWt5WEhVN0tkeTUvK2V1K09Nc25Ta0xC?=
 =?utf-8?B?dlgyUVEzZm5SR3JCKzhlVVUwOS9TZEtOMll0Y3R3NHl5UDhMOE14TFRJVjlE?=
 =?utf-8?B?MXJpSG5EZmNQZ21UamdDQzM3U0Q4OW9QMlo4Rjh3SEtCaUpHNFowckIra2w3?=
 =?utf-8?B?RVFiMFpENm4yTW96cmtnWStXamxLRXRpZGR4a0dmRnFBc2ljR0xHQWxWYzdN?=
 =?utf-8?B?WWFkZThxWU1yTWdHb2k3MDNCbDdOaFBhbEErRks2SytTeEdPYVZmSWIycFJv?=
 =?utf-8?B?eW1xTXl3S1ZnNVgxNXpLMXloVXFqakJBbjRSazF2Z003dG0wV3cwTWR1WERQ?=
 =?utf-8?B?U2oyVitFeTBLdDZMaUI3L1l5VUpuMHpDUkNGTkk3cHd0Q3FyRHZ6djNkMlpq?=
 =?utf-8?B?MFVSb1RqY0ZCVlBjQ0RIRC82ZlNJdmdxZ2FMbWtPUUU5aUVralBEdHowNHhW?=
 =?utf-8?B?RkdrQ1FJTmJJYlplbEwxMXVPTXdwZWhSWU8rNnJPakFGdXAvS1lEMTdqWVJt?=
 =?utf-8?B?MXpzQUJTbFlFZEZSa29FTkZ0OWF3UU9KWFlhK0Q4djFpSjNyU0ErVUlXNWd5?=
 =?utf-8?B?N2QwdmdyR2orUFNidXRjL04wSndXNGl1ZkdxdGNHamxrV3phM2VWNVZBVkF4?=
 =?utf-8?B?UXZTOHFKc1l4ZHNxdSt3ZkNRYTVheUhUTGxtR0FSb1ZRUlQrNmRmb3NRREkx?=
 =?utf-8?B?cER6cEpYbjhEWXdDQmZUMHRselJRdlFLU2tIZi9yYWxvdHdMUU8reGwvK2g5?=
 =?utf-8?B?cTM4TVpZaDBsQ2pUajh5ampNQWoxVDEzM0FwbmhJZi9yTFVRek9wanpRT1cr?=
 =?utf-8?B?cTlwVXdlQ2ZZRHhLWGhYNnVhTmp4NmcxbVB4SlFoak1oNHVHTFplRUNRbnJQ?=
 =?utf-8?B?Sk1FQy8xREpldTdncWpmckJrZVpDeFN3T3ZTNVBiSmZhYkl5aHZKYTMrMVVl?=
 =?utf-8?B?MytNeXF0MzM3Z2RDNE5jQUxEaGhQaVZrb3Q3UzU3K2VlSE5UNXBlbVF3eTRp?=
 =?utf-8?B?ZWUrR1J5RDJjOUtuMnNIeEZJc2F0bEpQSkZyNUpxcVU2UFFwb25qN3hBNC81?=
 =?utf-8?B?alUxYUhYSmNaanlyanNkT281OU1qK0p0RGYrV3F1VVhDUzREOUxCYkZ5alVU?=
 =?utf-8?B?TS9OcDRXbjdrL2dCSkdUS1ZEa0Jxblpid2ZqT1AwS2JOc05LdDRIL3pWUVVJ?=
 =?utf-8?B?U3hXTjl4VVZhclNhM2RLMFFhS2dWMGJTSUFRaDVGU3B1YTBoM2kyZkxISzJ0?=
 =?utf-8?B?TC9sOGpKOVE1QVBybHRpUmwwMlBDZ1N5MzlyaU16T21mSXQ4THRCS1UwT1RB?=
 =?utf-8?B?SkJid1QxUU05bmRPc3ZOVFNpL1F0ZWV4SEhsNU4zdWJiQ29IUG5VRTY2a3J4?=
 =?utf-8?B?WGRrVmMzQW42ODJYWDV4Yk9QVHpYMEFPZS9BWFpBMEl3MkR0ejZ0TWpuRWxo?=
 =?utf-8?B?TzFuSzExVEl4TmhIbXJ6dXVXS3o1cElpbU5jZWVKWlVXVmZVc2daOUZTeVY5?=
 =?utf-8?B?TGVWeDBUNmdlS3h2K1h4aGpMZ25PdkxJNG9qc29vZlp5ZjZGT2lzLzlZcFhK?=
 =?utf-8?B?dmhMV0RIL1hSL0VkRnVqNFBjMHB3clZTZlJ1d0VKNFdzT3lyV3U4N3Ryd2o3?=
 =?utf-8?B?ajJmbHpBeU5aOHljNzJiNERqczJoWkFNQjlqRThUWHZ0QVBKWW9DVzR2L2dx?=
 =?utf-8?B?V09vbHNObjUvbXlIRmdlUXV1WUpZK2hLV1h6YXZ3cDZSS2NkV1JYOEMyWmJ0?=
 =?utf-8?B?ZHQrTjlybENYVVgrU0U2Q3k2c3J3Sk11bWpyT3dBbkR5SUY1QVlVQUVkdDdo?=
 =?utf-8?B?UC83UGVud3pKMk4xdENUdkhDK3VkME96bStRNnFlRFVUd24rdEI3a2xrc3BB?=
 =?utf-8?B?YkttNDA4UGRvaHhBVFA3a1BKNEROVzNkd0UwVy8zYnkyMVpKbFJlMmxZcDFI?=
 =?utf-8?B?aHVsV2RjNi9jQ2tHeXB2czJpbUtWd2RCb24zc3hvZDlTMnkzN0NtVWtqZWJx?=
 =?utf-8?B?bEFNbHVoRU5ZdFZTZGU3eWdqcHprb09ZOXUrbFN4NWpXQUZrQzg0ZlYrbnJY?=
 =?utf-8?B?YVd0bVR6amdiYitsRGZOSkMzSFRtSjNkS2htR0crNFphRG5jbkNvQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <21CFE06A8CC23648BB493BB4F646DA15@eurprd05.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 953e8eed-a96f-4e43-25ab-08ded5c08a98
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 09:26:46.8471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: txQfwjtRiCyUqYWAraySP1Fvw2x1KPc+R+6fdE51F55I7TvV3zolWRSBkpamM754sm52iT39+2VF10W11Mbozg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR05MB9741
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
	TAGGED_FROM(0.00)[bounces-9846-lists,linux-integrity=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huawei.com:email,polito.it:dkim,polito.it:email,polito.it:mid,polito.it:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7CC206D8408

SGkgTWltaSwNCg0KT24gV2VkLCAyMDI2LTA2LTI0IGF0IDIxOjA1IC0wNDAwLCBNaW1pIFpvaGFy
IHdyb3RlOg0KPiBUaGUgU3ViamVjdCBsaW5lIGRlc2NyaWJlcyAiaG93Iiwgbm90ICJ3aGF0Ii4g
Q29uc2lkZXIgcmVuYW1pbmcgaXQgdG8gImltYToNCj4gbWVhc3VyZSB1c2Vyc3BhY2UgcG9saWN5
IHdyaXRlcyBiZWZvcmUgcGFyc2luZyIuDQoNCnRoYW5rIHlvdSwgd2lsbCBmaXggaXQuDQoNCj4g
T24gV2VkLCAyMDI2LTA2LTE3IGF0IDE3OjU4ICswMjAwLCBFbnJpY28gQnJhdmkgd3JvdGU6DQo+
ID4gV2hlbiBhIHNpZ25lZCBwb2xpY3kgaXMgbm90IG1hbmRhdG9yeSwgaXQgaXMgcG9zc2libGUg
dG8gd3JpdGUgdGhlIElNQQ0KPiA+IHBvbGljeSBkaXJlY3RseSBvbiB0aGUgY29ycmVzcG9uZGlu
ZyBzZWN1cml0eWZzIGZpbGU6DQo+IA0KPiBXaGVuIGEgc2lnbmVkIHBvbGljeSBpcyBub3QgbWFu
ZGF0b3J5LCB1c2Vyc3BhY2UgY2FuIHdyaXRlIElNQSBwb2xpY3kgcnVsZXMNCj4gZGlyZWN0bHkg
dG8gdGhlIHNlY3VyaXR5ZnMgcG9saWN5IGZpbGU6DQo+ID4gDQo+ID4gZWNobyAtZSAibWVhc3Vy
ZSBmdW5jPUJQUk1fQ0hFQ0sgbWFzaz1NQVlfRVhFQ1xuIiBcDQo+ID4gwqDCoMKgwqDCoMKgwqAg
ImF1ZGl0IGZ1bmM9QlBSTV9DSEVDSyBtYXNrPU1BWV9FWEVDXG4iIFwNCj4gPiDCoMKgwqDCoCA+
IC9zeXMva2VybmVsL3NlY3VyaXR5L2ltYS9wb2xpY3kNCj4gPiANCj4gPiBvciBieSBjYXQnaW5n
IHRoZSBlbnRpcmUgSU1BIGN1c3RvbSBwb2xpY3kgZmlsZToNCj4gPiANCj4gPiBjYXQgaW1hLXBv
bGljeS1maWxlID4gL3N5cy9rZXJuZWwvc2VjdXJpdHkvaW1hL3BvbGljeQ0KPiANCj4gQmVjYXVz
ZSB0aGVzZSBydWxlcyBvcmlnaW5hdGUgZnJvbSB1c2Vyc3BhY2UgYW5kIGNyb3NzIHRoZSB1c2Vy
c3BhY2Uva2VybmVsDQo+IHRydXN0IGJvdW5kYXJ5LCBtZWFzdXJlIHRoZSByYXcgd3JpdGUgYnVm
ZmVyIGJlZm9yZSBwYXJzaW5nLg0KDQpUaGFua3MgZm9yIHRoZXNlIHN1Z2dlc3Rpb25zLCBJJ2xs
IHVwZGF0ZSB0aGUgcGF0Y2ggZGVzY3JpcHRpb24uDQoNCj4gPiANCj4gPiBBZGQgaW5wdXQgYnVm
ZmVyIG1lYXN1cmVtZW50LCByZWdhcmRsZXNzIG9mIHdoZXRoZXIgdGhlIG5ldyBwb2xpY3kNCj4g
PiB3aWxsIGJlIGFjY2VwdGVkIG9yIG5vdCwgdGhhdCBjYW4gYmUgY2F1Z2h0IHdoZW4NCj4gPiAn
bWVhc3VyZSBmdW5jPVBPTElDWV9DSEVDSycgaXMgZW5hYmxlZCAoZS5nLiwgaW1hX3BvbGljeT10
Y2IpLiBUaGUNCj4gPiBtZWFzdXJlbWVudCB0ZW1wbGF0ZSBpcyBmb3JjZWQgdG8gaW1hLWJ1Zi4N
Cj4gDQo+ID4gVGhpcyBmb2xsb3dzIHRoZSAibWVhc3VyZSAmIGxvYWQiIHBhcmFkaWdtLCBleHBv
c2luZyBwb3RlbnRpYWwgYnVncyBpbg0KPiA+IHRoZSBwb2xpY3kgY29kZSBhbmQgZGV0ZWN0aW5n
IGF0dGVtcHRzIHRvIGNvcnJ1cHQgSU1BLiBJdCBhbHNvIGNvbXBsZXRlcw0KPiA+IHRoZSBQT0xJ
Q1lfQ0hFQ0sgaG9vaywgd2hpY2ggYWxyZWFkeSBtZWFzdXJlcyBwYXJ0aWFsIHBvbGljeSBsb2Fk
IGJ5IGZpbGUuDQo+IA0KPiA+IA0KPiA+IFRvIHZlcmlmeSB0aGUgdGVtcGxhdGUgZGF0YSBoYXNo
IHZhbHVlLCBjb252ZXJ0IHRoZSBidWZmZXIgcG9saWN5IGRhdGENCj4gPiB0byBiaW5hcnk6DQo+
ID4gZ3JlcCAiaW1hX3BvbGljeV93cml0dGVuIiBcDQo+ID4gCS9zeXMva2VybmVsL3NlY3VyaXR5
L2ludGVncml0eS9pbWEvYXNjaWlfcnVudGltZV9tZWFzdXJlbWVudHMgfCBcDQo+ID4gCXRhaWwg
LTEgfCBjdXQgLWQnICcgLWYgNiB8IHh4ZCAtciAtcCB8IHNoYTI1NnN1bQ0KPiA+IA0KPiA+IFN1
Z2dlc3RlZC1ieTogUm9iZXJ0byBTYXNzdSA8cm9iZXJ0by5zYXNzdUBodWF3ZWkuY29tPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IEVucmljbyBCcmF2aSA8ZW5yaWNvLmJyYXZpQHBvbGl0by5pdD4NCj4g
PiAtLS0NCj4gPiDCoHNlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hLmjCoMKgwqDCoMKgwqDCoCB8
wqAgMSArDQo+ID4gwqBzZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9mcy5jwqDCoMKgwqAgfMKg
IDEgKw0KPiA+IMKgc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfbWFpbi5jwqDCoCB8IDE5ICsr
KysrKysrKysrKysrKysrKysNCj4gPiDCoHNlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX3BvbGlj
eS5jIHzCoCAzICsrKw0KPiA+IMKgNCBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspDQo+
ID4gDQo+ID4gZGlmZiAtLWdpdCBhL3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hLmggYi9zZWN1
cml0eS9pbnRlZ3JpdHkvaW1hL2ltYS5oDQo+ID4gaW5kZXggYmVmYTIyMTcxNmU1Li5kNDc3ZmMw
NjgyMWYgMTAwNjQ0DQo+ID4gLS0tIGEvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWEuaA0KPiA+
ICsrKyBiL3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hLmgNCj4gPiBAQCAtNDU1LDYgKzQ1NSw3
IEBAIHZvaWQgKmltYV9wb2xpY3lfbmV4dChzdHJ1Y3Qgc2VxX2ZpbGUgKm0sIHZvaWQgKnYsDQo+
ID4gbG9mZl90ICpwb3MpOw0KPiA+IMKgdm9pZCBpbWFfcG9saWN5X3N0b3Aoc3RydWN0IHNlcV9m
aWxlICptLCB2b2lkICp2KTsNCj4gPiDCoGludCBpbWFfcG9saWN5X3Nob3coc3RydWN0IHNlcV9m
aWxlICptLCB2b2lkICp2KTsNCj4gPiDCoHZvaWQgaW1hX21lYXN1cmVfbG9hZGVkX3BvbGljeSh2
b2lkKTsNCj4gPiAraW50IGltYV9tZWFzdXJlX3BvbGljeV9idWYoY29uc3QgY2hhciAqYnVmLCBz
aXplX3QgYnVmX2xlbik7DQo+ID4gwqANCj4gPiDCoC8qIEFwcHJhaXNlIGludGVncml0eSBtZWFz
dXJlbWVudHMgKi8NCj4gPiDCoCNkZWZpbmUgSU1BX0FQUFJBSVNFX0VORk9SQ0UJMHgwMQ0KPiA+
IGRpZmYgLS1naXQgYS9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9mcy5jDQo+ID4gYi9zZWN1
cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9mcy5jDQo+ID4gaW5kZXggNjVlNzgxMmM3MDJmLi5hMjc3
YzkxMzU5NDQgMTAwNjQ0DQo+ID4gLS0tIGEvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfZnMu
Yw0KPiA+ICsrKyBiL3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX2ZzLmMNCj4gPiBAQCAtMzU2
LDYgKzM1Niw3IEBAIHN0YXRpYyBzc2l6ZV90IGltYV93cml0ZV9wb2xpY3koc3RydWN0IGZpbGUg
KmZpbGUsIGNvbnN0DQo+ID4gY2hhciBfX3VzZXIgKmJ1ZiwNCj4gPiDCoAkJCQnCoMKgwqAgMSwg
MCk7DQo+ID4gwqAJCXJlc3VsdCA9IC1FQUNDRVM7DQo+ID4gwqAJfSBlbHNlIHsNCj4gPiArCQlp
bWFfbWVhc3VyZV9wb2xpY3lfYnVmKGRhdGEsIGRhdGFsZW4pOw0KPiANCj4gU2hvdWxkIGZhaWx1
cmUgdG8gbWVhc3VyZSB0aGUgaW5wdXQgcG9saWN5IHJ1bGVzIGJlIGF1ZGl0ZWQ/DQoNCnByb2Nl
c3NfYnVmZmVyX21lYXN1cmVtZW50KCkgaXMgYWxyZWFkeSBhdWRpdGluZyBpbiBjYXNlIG9mIGZh
aWx1cmUgYmVmb3JlDQpyZXR1cm5pbmcuIERvIHlvdSB0aGluayBpdCBpcyBuZWNlc3NhcnkgdG8g
YXVkaXQgYWxzbyBhdCB0aGlzIHBvaW50Pw0KDQo+ID4gwqAJCXJlc3VsdCA9IGltYV9wYXJzZV9h
ZGRfcnVsZShkYXRhKTsNCj4gPiDCoAl9DQo+ID4gwqAJbXV0ZXhfdW5sb2NrKCZpbWFfd3JpdGVf
bXV0ZXgpOw0KPiA+IGRpZmYgLS1naXQgYS9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9tYWlu
LmMNCj4gPiBiL3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX21haW4uYw0KPiA+IGluZGV4IDVj
ZWE1M2ZjMzZkZi4uNTk5NDk1MzA0NzEyIDEwMDY0NA0KPiA+IC0tLSBhL3NlY3VyaXR5L2ludGVn
cml0eS9pbWEvaW1hX21haW4uYw0KPiA+ICsrKyBiL3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1h
X21haW4uYw0KPiA+IEBAIC0xMjIxLDYgKzEyMjEsMjUgQEAgaW50IGltYV9tZWFzdXJlX2NyaXRp
Y2FsX2RhdGEoY29uc3QgY2hhcg0KPiA+ICpldmVudF9sYWJlbCwNCj4gPiDCoH0NCj4gPiDCoEVY
UE9SVF9TWU1CT0xfR1BMKGltYV9tZWFzdXJlX2NyaXRpY2FsX2RhdGEpOw0KPiA+IMKgDQo+ID4g
Ky8qKg0KPiA+ICsgKiBpbWFfbWVhc3VyZV9wb2xpY3lfYnVmIC0gTWVhc3VyZSB0aGUgcG9saWN5
IHdyaXRlIGJ1ZmZlcg0KPiANCj4gQ29uc2lkZXIgcmVuYW1pbmcgdGhpcyBmdW5jdGlvbiB0byBp
bWFfbWVhc3VyZV9wb2xpY3lfaW5wdXQoKSwgd2hpY2ggcGFyYWxsZWxzDQo+IHRoZSBmdW5jdGlv
biBpbWFfbWVhc3VyZV9sb2FkZWRfcG9saWN5KCkgaW4gdGhlIGZpcnN0IHBhdGNoLg0KDQpNeSBp
bnRlbnRpb24gd2l0aCB0aGUgcHJldmlvdXMgaW1hX21lYXN1cmVfcG9saWN5X3dyaXRlKCkgbmFt
ZSB3YXMgdG8gaGlnaGxpZ2h0DQp0aGUgZmFjdCBpdCBpcyBub3QgbWVhc3VyaW5nIGV2ZXJ5IGRh
dGEgc2VudCB0byB0aGUgcG9saWN5IGZpbGUuIEZvciBleGFtcGxlLA0Kd3JpdGluZyB0aGUgcGF0
aCBvZiB0aGUgZmlsZSBmcm9tIHdoaWNoIHJlYWRpbmcgdGhlIG5ldyBwb2xpY3kgZG9lcyBub3Qg
dHJpZ2dlcg0KdGhpcyBtZWFzdXJlbWVudC4gRXZlbnR1YWxseSwgd2hhdCBkbyB5b3UgdGhpbmsg
b2YgaW1hX21lYXN1cmVfcmF3X3BvbGljeSgpIG9yDQppbWFfbWVhc3VyZV91bnBhcnNlZF9wb2xp
Y3koKT8NCg0KVGhhbmsgeW91IHZlcnkgbXVjaCwNCg0KRW5yaWNvDQoNCj4gTWltaQ0KPiANCj4g
PiArICogQGJ1ZjogcG9pbnRlciB0byB0aGUgYnVmZmVyIGNvbnRhaW5pbmcgdGhlIHBvbGljeSB3
cml0ZSBkYXRhDQo+ID4gKyAqIEBidWZfbGVuOiBzaXplIG9mIHRoZSBidWZmZXINCj4gPiArICoN
Cj4gPiArICogTWVhc3VyZSB0aGUgYnVmZmVyIHNlbnQgdG8gdGhlIElNQSBwb2xpY3kgc2VjdXJp
dHlmcyBmaWxlLg0KPiA+ICsgKg0KPiA+ICsgKiBSZXR1cm4gMCBvbiBzdWNjZXNzLCBhIG5lZ2F0
aXZlIHZhbHVlIG90aGVyd2lzZS4NCj4gPiArICovDQo+ID4gK2ludCBpbWFfbWVhc3VyZV9wb2xp
Y3lfYnVmKGNvbnN0IGNoYXIgKmJ1Ziwgc2l6ZV90IGJ1Zl9sZW4pDQo+ID4gK3sNCj4gPiArCWlm
ICghYnVmIHx8ICFidWZfbGVuKQ0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+ICsNCj4gPiAr
CXJldHVybiBwcm9jZXNzX2J1ZmZlcl9tZWFzdXJlbWVudCgmbm9wX21udF9pZG1hcCwgTlVMTCwg
YnVmLA0KPiA+IGJ1Zl9sZW4sDQo+ID4gKwkJCQkJwqAgImltYV9wb2xpY3lfd3JpdHRlbiIsDQo+
ID4gUE9MSUNZX0NIRUNLLCAwLA0KPiA+ICsJCQkJCcKgIE5VTEwsIGZhbHNlLCBOVUxMLCAwKTsN
Cj4gPiArfQ0KPiA+ICsNCj4gPiDCoCNpZmRlZiBDT05GSUdfSU5URUdSSVRZX0FTWU1NRVRSSUNf
S0VZUw0KPiA+IMKgDQo+ID4gwqAvKioNCg==

