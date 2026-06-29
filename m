Return-Path: <linux-integrity+bounces-9850-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3mkSBAFzQmru7QkAu9opvQ
	(envelope-from <linux-integrity+bounces-9850-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Jun 2026 15:28:33 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B90A6DB341
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Jun 2026 15:28:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=polito.it header.s=selector1 header.b="QFknu5/a";
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9850-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9850-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=polito.it;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 20FC83012C73
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Jun 2026 13:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AC6411683;
	Mon, 29 Jun 2026 13:07:54 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023134.outbound.protection.outlook.com [40.107.162.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAC8411670
	for <linux-integrity@vger.kernel.org>; Mon, 29 Jun 2026 13:07:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738473; cv=fail; b=PTtBMBGLAHbHBFT2ZvAC2hQWt51aUc7Sg5deWH8FMUcJ6AhGMeQr7IX8me3U9ubj2WUTaH7NVY2HbRFadnEM9eETYCO86aWgl0g1ZHHgAFXuakgxcH5zC+ett7qWFHudwKzlsdZdxQ0/3vuWzdUiQ4+gHjMm9tRcoyWLJApc0qU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738473; c=relaxed/simple;
	bh=gAqg6MzXfFL/hCkCjH76NOVSwOPLbMvVUYEWNo0VVXk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=it461feFSRYrw452sY1yTYH3YJi7Vu9FU8sspygRXnZYKO+czZylsw0/Ko5dx6s/sB1/qbCJS1rs2abhxSloa8OZfQ+mZ5Oc6KmoYiKYmoNEzPlUeUhMhrlGRnQS8I3lJwbO/Sgd9gIRjr4Z+YtzB5g2tV/PGc0mIarO2sj2QZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=QFknu5/a; arc=fail smtp.client-ip=40.107.162.134
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRLiH/84pl4vHMIFvc8Eod3Wnu7OoV3jjX07yfDFiYuUnHt/ldyEb5UhtnjV99CFk54tzHps1onhwQYS9Fk42NM18DgR9UXSJY7AGpeDyeUXBi2NpaxrNK/Ugi926PopxP2LubWTl+ZoUTQj8/c9BLFh/vmWfxz6mEvAVYGLZOcheKjGkuA+I7jZZMrxrrS/ooFZKdltoy+Qq3fUH8gTdf/Ts6yrOy++ijQZHYbFHR15BOVID6vjnj9u5NI8ye9r5rvPDog+IhPnTlhiOojnWm2hdgaTqe2yg4UOpXBXimxPylgl9bv2gPYr7Zm3babvS+TWN/bjDCKHrVUmTj/Tsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAqg6MzXfFL/hCkCjH76NOVSwOPLbMvVUYEWNo0VVXk=;
 b=sNnp6Xe7Af19SQ58lUAobccHZnltnnyh++34h0sOrhCPqHqSX9lQj8hFlCZ9y/6SypNQBmIx7ZZNIGwtbJ0w52jHEUndOy+WW7x+jpibBYGDk/luU9leCPxhGfE8DuaOxP+lMYlKgOxwmyhuOcn7KnMq7W1yuQVhfBeluMTlvq+w2cPDIhPCIG/62UtuXDmfyso/CnUhAlHNn56q7iT2ST7l5h75aStpGtBh5wPSQxPtQoWVNoqY9zFPofizoRuevjq0HxFwkDFPTl+nyTlPJc3lXCh+f9roO/aZ91Cwg93wxr2kt8yPo4gMMKql2HnaW2ARaESfjOfoI6IUVR/v5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAqg6MzXfFL/hCkCjH76NOVSwOPLbMvVUYEWNo0VVXk=;
 b=QFknu5/aJ/GwxS/EPg2RvbVVOTpzACU5hzhtot17zqhP/1PlOO4VcFthKmy4yGJg0rHzty249+Rv37RzUm2PWKEoXafbXyhtJ1il7AKfNXVgLtT+JcbuTgyX/nhnmsPOKix0M4eF5xVYyyWpqn7mt+3a4aCxRKMBYFsAHhjuCxA=
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com (2603:10a6:20b:253::20)
 by DU0PR05MB9215.eurprd05.prod.outlook.com (2603:10a6:10:35e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 13:07:48 +0000
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64]) by AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64%5]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 13:07:48 +0000
From: "Enrico  Bravi" <enrico.bravi@polito.it>
To: "roberto.sassu@huawei.com" <roberto.sassu@huawei.com>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"roberto.sassu@huaweicloud.com" <roberto.sassu@huaweicloud.com>,
	"zohar@linux.ibm.com" <zohar@linux.ibm.com>, "dmitry.kasatkin@gmail.com"
	<dmitry.kasatkin@gmail.com>
CC: "eric.snowberg@oracle.com" <eric.snowberg@oracle.com>
Subject: Re: [PATCH] ima: correctly recover number of violations after kexec
Thread-Topic: [PATCH] ima: correctly recover number of violations after kexec
Thread-Index: AQHdACBXEkKdWehZFUSS24iqdgk0ALZPR52AgAY45oCAAAMEgIAADMeA
Date: Mon, 29 Jun 2026 13:07:47 +0000
Message-ID: <12b989e9ecca9963e437c61f33d0b2559a8ab7f8.camel@polito.it>
References: <20260619191452.7179-1-enrico.bravi@polito.it>
		 <8f9626a5cc4c03e57d63d290ce151caeda9293e6.camel@huaweicloud.com>
		 <28db33177bcd021da5c907a7941ae93f87e91633.camel@polito.it>
	 <c4fcb3e90bea2ec98be110e29b17874b1d874b6d.camel@huaweicloud.com>
In-Reply-To: <c4fcb3e90bea2ec98be110e29b17874b1d874b6d.camel@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR05MB7880:EE_|DU0PR05MB9215:EE_
x-ms-office365-filtering-correlation-id: c2f8dfb2-dc6d-4f18-a911-08ded5df6ad5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|786006|23010399003|376014|1800799024|18002099003|22082099003|38070700021|11063799006|4143699003|56012099006|3023799007;
x-microsoft-antispam-message-info:
 35YFtyB6qG9A0cg1Wi34v21/ywYkLcjKcdzPsZoPa5GGQc7XPMVYAnHgrwa2Mtq1uLndU1y0IGQojttXPNeHTetIppSR2WH1xRdrZACwy+kavhB9qqL21lMzxXBLaQ64cY5DxJd7C+e7bJhdx+6MRGLcb8XY6XYrdQq0UrAD4B8nKj8slOg95Jkjruui2lou+B9JuojrhUp4Ucycw99utvLZbfLEwueriQMckTFDfEE47fsyJHDnX0R5LOFpaN2hRz18r3/zT8yrhSfLqqAUPhvREXO2i6cfkNk21E0FRug0R4QXyCdQcEYCKtj2rARlwUlOWgpp7d9TilzD+9imkKgJSRYrVR96HYu1xntnxbwTO7ZcZpTVgM8KvIJ6NyomonNUvLBk5bu8TZWVmxWc2GapoMZh4LQOGZFh40pBDkLNQ5QNcaQ3zWsSksqy9w76gaFKiD2GrMfCfOoM1pRV1VzB66q2Dh4TJUI4H0b0sTKeocS+RAZXNvG/PLyqnA2eLz3xMFB8JjdCJY3f/X5oPOOw4Zortq9Y5Poq/WE2XTcv2PWEXgfLc88avXWVsFGvtJ4GGvL9XQckvRbtW9trdYmXuJRuAVKnfkmOXaBMh6JHTJEPmhAlml2A39MdYDUPmPKzRRxN9C8zRFg+KM3dttADfouculJagBrV3ORFZST92GJBXO0EmJHzETwdi0Sv7tiloOxfD2KA2FwjB1kffxMW6xOQPRZJOsz6SK6A9mA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR05MB7880.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(786006)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(11063799006)(4143699003)(56012099006)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M3VoYXdEb0tpN1JSUWhCTFpKZlVUc0NjNy90b0NRMkV0YzNLNGNjK1haRmJ6?=
 =?utf-8?B?MloyTG9Ba3dMWm52SGNSR1hSNFpQODVJajFzaHU3Z3dGUXozSllNbThYWEZz?=
 =?utf-8?B?ZjE3enlwd0lUSEEwM0g1SnRKdkdKdVVuVkdwQmRhOWwvSGZiUmJMbFpqbWVy?=
 =?utf-8?B?VXFIczNqRnV6aFRobjBZQ1VaeWVnWS9hR1p3ZGQybllXNjVCSWU1YlM2WUwy?=
 =?utf-8?B?eGV4cUd4WW55bXBqR3cwb1BPZGJSQ0FpQTRCbm9ZNzlnWXIyeDR4M1ArVWQ4?=
 =?utf-8?B?YnNEU1dWb1h4ZjR1bnRxZzdLdnRueWZ3Z2NYajZMUEFqWVVHSzYxSWE3b1h6?=
 =?utf-8?B?UmhKdm1JcjFxZnlIaW5ySmxTa2VYa3NBUmRIWm9jaGxqRXIyZWR0MUk1bzBI?=
 =?utf-8?B?b3dyN1hmY2c2QkgrWGtlVzlIdEFYSEpnKzI2QUpFcXd2RXhqUytQVFdjeTZu?=
 =?utf-8?B?bThjbFJsazNPUG9EUHBYZFhwWEdDUlo0em1YdHRpYkxjT1AzS1ZQZFo0eVJj?=
 =?utf-8?B?eE82d3UvcHhEbXpGVkh3K0JYenlaSUZ6WDlQQVAvck1PdjBZL1FKWDMyQ2FC?=
 =?utf-8?B?NXpVOGh2TUh0TEFSdCtULzVqc0U0Sm9xckRhVmJoYVprYVIzbXFYcjlDT0Nn?=
 =?utf-8?B?Z3lHaS9aT1dqN0ozLzN0UUx6RW1XT1FFTkxLL2lDTFZJTkJ1NEcxYmpoU2th?=
 =?utf-8?B?aWlqMitGd21GRE1iZ01HZ1RFL1JPZnhrVGZEY0xHekFXeEE4Y3UxVVBEbVlq?=
 =?utf-8?B?RTVmdksxMlJDcWIxSnJzSWV5b2tQeU1VL2ZNcTBpa2xVS1ZCU2c1K0l4OFor?=
 =?utf-8?B?UUE5aE9Xd2txK09BVGc5TW1za3VEWnVxWmxuWjRRV2Y3ZkZoVkJLdjE5dFZk?=
 =?utf-8?B?L08xemg3ZWQ5K3VKby9KeEs5STNGY1gvaXByR2txZGIxb0haNXdubm5oQ2dD?=
 =?utf-8?B?eU90ak5RSUZ1eTZrWEErREwyaUtUTUt1WnhLRk4xSlQxa1JSeFdhVXdLT05k?=
 =?utf-8?B?a2p3TjhvZXcyQWYzTmtDVDAxUjZqNnlFTVRvT3kzdk0xaXFOUURMTi9VdXJ6?=
 =?utf-8?B?M2RNTWorY21zWUk0Sy9KY0FrVDBmSy9qTnZQLzQ4NHY2Z2FZYTg0aDE2WENS?=
 =?utf-8?B?b1hSUGM2TVNLS0FoaXRLc2djU2sreDdkMExIOWp1eXIyMGI0Rkw4QmErakpG?=
 =?utf-8?B?a2p5eGY1TzBQQUxBZzhsWXkwTy9zeDQzb2hsb0FGZEkzR01HZWltYmFMeXVF?=
 =?utf-8?B?cGM0ZzdQeThJY3FLQlFCa3NDNW5mS2FWdmhQeVVncE4va0ZsTnArN3VqNmxr?=
 =?utf-8?B?Wm8yNEJ2WTErdnRXckYxYktNNW5LR3c0cmhOK1plelkwc1pkQ2ZWL0xQTkVu?=
 =?utf-8?B?R09JaDZKeVNzZm0xRWVEbzQ3RWdac1JJZEJzQmJtWkFMdllNaUczYVNkaFlI?=
 =?utf-8?B?MTFKWFZZUnozckJoajg5d3FQWUp3R0VUQzZHZzl2eU9KRW91QVlxRUxrTTFE?=
 =?utf-8?B?M05sdHBtT0JZcnE0WE1FRThtRm1LeXpCYWxucWFxWm5CcjR6SzhaZXBLbENo?=
 =?utf-8?B?cVpZS0w4Ui85bEtOUHhVc3J5UFFMbGN1ZjVBYlE4OVEyVHJldjJyRFVpOGwx?=
 =?utf-8?B?VlRsN1dDY0FDWnk5NHozN2E5WG9wR1Q2NUdUNnZZVnp5M3BqRHo0Uzl3TmYz?=
 =?utf-8?B?NUlxcEhmd3A0TTQyNVRBdVUvbThodDNnZjJ3UmJsaU5ybmMxVVgzcHUyQnFs?=
 =?utf-8?B?ZUdNUk1LMXBycTV2SHNocjN2SGRRVUV3bFY4MWx5T3BWOU14SHlGV290UVBK?=
 =?utf-8?B?ejZpN0VZNFk3L29LVXRlSE5sMEFFNER2MVNWajZVRlpNZGVaQmZPWUNpazho?=
 =?utf-8?B?d1ZVN05JbnpmM2FyVXQvRnNmcW85R2lZcjNNSmNMMEF6WmVoZEZmUkNqb0dO?=
 =?utf-8?B?cmNNYzMvVTQwU0VQNHBTUTV4LzI4ZTJJNHpvY0R2VEc3WW5nclJpMFlRcWZm?=
 =?utf-8?B?aGkwN3R1SHhrUUJVQmtjaGxqMUdFZTlwblFTcVFzeGJ4SjMrcjlJNExpNFJJ?=
 =?utf-8?B?QkI4V3psRmRSaWpRdzV3RVkxSW9jb2VSb0FIL1JPVGg2VTNDcm4zeHlOWjNF?=
 =?utf-8?B?UjgrdUViU0hJVytmQkhUWFh4alAzUEJOOHU5RDRNUGwwVEJsdEJRUnBPeFc5?=
 =?utf-8?B?dlFPWlFHTk95SUo2MXcyanRMRXcwblpxbDAzZFlIR2ZjOGlhZG5lUTY3K1c3?=
 =?utf-8?B?Szd4UlZmWVViMjZGSEJXL1JIc0QzVHFJTk00UlFxSFBmMjU4TFZFS3dqUU5p?=
 =?utf-8?B?VTVVU3pKVTVGSTVwaHpoOWl4aU1jWUdzUGw4ejBiNXg2WlIzNnQwZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF390E4D00A33E408BF46825BCF6F6C3@eurprd05.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f8dfb2-dc6d-4f18-a911-08ded5df6ad5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 13:07:47.9633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Peb8n9yyWl3209fmsgcLvXGYa+fTYrNFgv/nZYOFcbYd1be3Vvge64C45T04jX3eUCz26VgqoHJPmgMXfpRueA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR05MB9215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	FROM_NAME_EXCESS_SPACE(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[polito.it,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[polito.it:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9850-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:roberto.sassu@huawei.com,m:linux-integrity@vger.kernel.org,m:roberto.sassu@huaweicloud.com,m:zohar@linux.ibm.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[huawei.com,vger.kernel.org,huaweicloud.com,linux.ibm.com,gmail.com];
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
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,huawei.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,polito.it:dkim,polito.it:email,polito.it:mid,polito.it:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0B90A6DB341

T24gTW9uLCAyMDI2LTA2LTI5IGF0IDE0OjIyICswMjAwLCBSb2JlcnRvIFNhc3N1IHdyb3RlOg0K
PiBPbiBNb24sIDIwMjYtMDYtMjkgYXQgMTI6MTEgKzAwMDAsIEVucmljb8KgIEJyYXZpIHdyb3Rl
Og0KPiA+IEhpIFJvYmVydG8sDQo+ID4gDQo+ID4gT24gVGh1LCAyMDI2LTA2LTI1IGF0IDE1OjEw
ICswMjAwLCBSb2JlcnRvIFNhc3N1IHdyb3RlOg0KPiA+ID4gT24gRnJpLCAyMDI2LTA2LTE5IGF0
IDIxOjE0ICswMjAwLCBFbnJpY28gQnJhdmkgd3JvdGU6DQo+ID4gPiA+IFdoZW4gcmVjb3Zlcmlu
ZyB0aGUgbWVhc3VyZW1lbnQgbGlzdCBhZnRlciBrZXhlYygpLCB0aGUgbnVtYmVyIG9mDQo+ID4g
PiA+IHZpb2xhdGlvbnMgaXMgbm90IHJlY292ZXJlZCBhcyB3ZWxsLCBjYXVzaW5nIGEgbWlzbWF0
Y2ggYmV0d2VlbiB0aGUNCj4gPiA+ID4gbnVtYmVyIHJlcG9ydGVkIGJ5IHRoZSA8c2VjdXJpdHlm
cz4vaW1hL3Zpb2xhdGlvbnMgdXNlciBpbnRlcmZhY2UgYW5kDQo+ID4gPiA+IHRoZSBhY3R1YWwg
dmFsdWUuIEluIGFkZGl0aW9uLCBjdXJyZW50bHkgaXQgaXMgYXNzdW1lZCB0aGF0IHdoZW4NCj4g
PiA+ID4gcmVjb3ZlcmluZyBhbiBlbnRyeSwgdGhpcyBpcyBhIHZpb2xhdGlvbiBpZiB0aGUgdGVt
cGxhdGUgZGF0YSBoYXNoDQo+ID4gPiA+IHJlYWQgZnJvbSB0aGUga2V4ZWMgYnVmZmVyIGlzIGFu
IGFsbC16ZXJvIGhhc2gsIHdoaWNoIGNhbiBhY3R1YWxseSBiZSBhDQo+ID4gPiA+IHZhbGlkIGhh
c2guDQo+ID4gPiANCj4gPiA+IFRoaXMgc2VudGVuY2UgaXMgYSBiaXQgY29udm9sdXRlZC4gUGxl
YXNlIHJld29yayBpdC4NCj4gPiA+IA0KPiA+ID4gPiBWZXJpZnkgdGhhdCBhbiBhbGwtemVybyBo
YXNoIGNvcnJlc3BvbmRzIHRvIGEgdmlvbGF0aW9uIGFuZCBjb25zZXF1ZW50bHkNCj4gPiA+ID4g
Y29ycmVjdGx5IHJlY292ZXIgdGhlIG51bWJlciBvZiB2aW9sYXRpb25zLg0KPiA+ID4gDQo+ID4g
PiBXZSBuZWVkIHRvIGNsYXJpZnkgdGhhdCB0aGlzIHBhdGNoIG9ubHkgZml4ZXMgZmFsc2UgcG9z
aXRpdmVzIChhIHJlY29yZA0KPiA+ID4gaXMgZGVjbGFyZWQgYXMgYSB2aW9sYXRpb24gZXZlbiBp
ZiBpdCBpc24ndCwgYW5kIHdlIGZpeCBpdCBieSBjcm9zcy0NCj4gPiA+IGNoZWNraW5nIHRoZSBT
SEExIG9mIHRoZSB0ZW1wbGF0ZSBkYXRhKS4NCj4gPiA+IA0KPiA+ID4gSG93ZXZlciwgd2UgYXJl
IG5vdCBmaXhpbmcgdGhlIGZhbHNlIG5lZ2F0aXZlcyAoaWYgdGhlIFNIQTEgb2YgdGhlDQo+ID4g
PiB0ZW1wbGF0ZSBkYXRhIGlzIHplcm9zLCB3ZSBkb24ndCBkZWNsYXJlIGl0IGFzIGEgdmlvbGF0
aW9uLCBidXQgaXQgY2FuDQo+ID4gPiBwb3RlbnRpYWxseSBiZSkuDQo+ID4gDQo+ID4gdGhhbmsg
eW91IHZlcnkgbXVjaCBmb3IgeW91ciBmZWVkYmFjay4gSSdsbCByZXdvcmsgdGhlIHBhdGNoIGRl
c2NyaXB0aW9uIHRvDQo+ID4gbWFrZQ0KPiA+IGl0IG1vcmUgY2xlYXIgYW5kIGRlc2NyaWJlIHdo
YXQgeW91IGhpZ2hsaWdodGVkLg0KPiA+IA0KPiA+ID4gPiBSZXBvcnRlZC1ieTogUm9iZXJ0byBT
YXNzdSA8cm9iZXJ0by5zYXNzdUBodWF3ZWkuY29tPg0KPiA+ID4gPiBDbG9zZXM6IGh0dHBzOi8v
Z2l0aHViLmNvbS9saW51eC1pbnRlZ3JpdHkvbGludXgvaXNzdWVzLzEzDQo+ID4gPiA+IFNpZ25l
ZC1vZmYtYnk6IEVucmljbyBCcmF2aSA8ZW5yaWNvLmJyYXZpQHBvbGl0by5pdD4NCj4gPiA+ID4g
DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiDCoHNlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX3RlbXBs
YXRlLmMgfCAyOCArKysrKysrKysrKysrKysrKysrKy0tLS0tLS0NCj4gPiA+ID4gwqAxIGZpbGUg
Y2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gPiA+ID4gDQo+ID4g
PiA+IGRpZmYgLS1naXQgYS9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV90ZW1wbGF0ZS5jDQo+
ID4gPiA+IGIvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfdGVtcGxhdGUuYw0KPiA+ID4gPiBp
bmRleCA3MDM0NTczZmI0MWUuLjE0N2YyMjhlZDI0NiAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvc2Vj
dXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfdGVtcGxhdGUuYw0KPiA+ID4gPiArKysgYi9zZWN1cml0
eS9pbnRlZ3JpdHkvaW1hL2ltYV90ZW1wbGF0ZS5jDQo+ID4gPiA+IEBAIC00MzAsNiArNDMwLDcg
QEAgaW50IGltYV9yZXN0b3JlX21lYXN1cmVtZW50X2xpc3QobG9mZl90IHNpemUsIHZvaWQNCj4g
PiA+ID4gKmJ1ZikNCj4gPiA+ID4gwqAJREVDTEFSRV9CSVRNQVAoaGRyX21hc2ssIEhEUl9fTEFT
VCk7DQo+ID4gPiA+IMKgCXVuc2lnbmVkIGxvbmcgY291bnQgPSAwOw0KPiA+ID4gPiDCoAlpbnQg
cmV0ID0gMDsNCj4gPiA+ID4gKwlpbnQgaTsNCj4gPiA+ID4gwqANCj4gPiA+ID4gwqAJaWYgKCFi
dWYgfHwgc2l6ZSA8IHNpemVvZigqa2hkcikpDQo+ID4gPiA+IMKgCQlyZXR1cm4gMDsNCj4gPiA+
ID4gQEAgLTUxNSwxNSArNTE2LDI4IEBAIGludCBpbWFfcmVzdG9yZV9tZWFzdXJlbWVudF9saXN0
KGxvZmZfdCBzaXplLCB2b2lkDQo+ID4gPiA+ICpidWYpDQo+ID4gPiA+IMKgCQlpZiAocmV0IDwg
MCkNCj4gPiA+ID4gwqAJCQlicmVhazsNCj4gPiA+ID4gwqANCj4gPiA+ID4gLQkJaWYgKG1lbWNt
cChoZHJbSERSX0RJR0VTVF0uZGF0YSwgemVybywgc2l6ZW9mKHplcm8pKSkgew0KPiA+ID4gPiAt
CQkJcmV0ID0gaW1hX2NhbGNfZmllbGRfYXJyYXlfaGFzaCgNCj4gPiA+ID4gLQkJCQkJCSZlbnRy
eS0NCj4gPiA+ID4gPnRlbXBsYXRlX2RhdGFbMF0sDQo+ID4gPiA+ICsJCXJldCA9IGltYV9jYWxj
X2ZpZWxkX2FycmF5X2hhc2goJmVudHJ5LQ0KPiA+ID4gPiA+dGVtcGxhdGVfZGF0YVswXSwNCj4g
PiA+ID4gwqAJCQkJCQllbnRyeSk7DQo+ID4gPiA+IC0JCQlpZiAocmV0IDwgMCkgew0KPiA+ID4g
PiAtCQkJCXByX2VycigiY2Fubm90IGNhbGN1bGF0ZSB0ZW1wbGF0ZQ0KPiA+ID4gPiBkaWdlc3Rc
biIpOw0KPiA+ID4gPiAtCQkJCXJldCA9IC1FSU5WQUw7DQo+ID4gPiA+IC0JCQkJYnJlYWs7DQo+
ID4gPiA+ICsJCWlmIChyZXQgPCAwKSB7DQo+ID4gPiA+ICsJCQlwcl9lcnIoImNhbm5vdCBjYWxj
dWxhdGUgdGVtcGxhdGUgZGlnZXN0XG4iKTsNCj4gPiA+ID4gKwkJCXJldCA9IC1FSU5WQUw7DQo+
ID4gPiA+ICsJCQlicmVhazsNCj4gPiA+ID4gKwkJfQ0KPiA+ID4gPiArDQo+ID4gPiA+ICsJCWlm
ICghbWVtY21wKGhkcltIRFJfRElHRVNUXS5kYXRhLCB6ZXJvLCBzaXplb2YoemVybykpDQo+ID4g
PiA+ICYmDQo+ID4gPiA+ICsJCcKgwqDCoCBtZW1jbXAoZW50cnktPmRpZ2VzdHNbaW1hX3NoYTFf
aWR4XS5kaWdlc3QsIHplcm8sDQo+ID4gPiA+IHNpemVvZih6ZXJvKSkpIHsNCj4gPiA+IA0KPiA+
ID4gSGVyZSBpdCB3b3VsZCBiZSBoZWxwZnVsIHRvIGhhdmUgYSBjb21tZW50IHNheWluZyB0aGF0
IHdlIGFyZSByZXZlcnRpbmcNCj4gPiA+IHRoZSBlZmZlY3Qgb2YgaW1hX2NhbGNfZmllbGRfYXJy
YXlfaGFzaCgpOiB3ZSB0cmllZCB0byB2ZXJpZnkgaWYgdGhlDQo+ID4gPiBlbnRyeSBpcyBhIHZp
b2xhdGlvbiwgaXQgaXMsIGJ1dCB0aGVuIHdlIGhhdmUgdG8gc2V0IHRoZSB0ZW1wbGF0ZQ0KPiA+
ID4gZGlnZXN0IGJhY2sgdG8gemVybyBhZnRlciB0aGUgY2FsY3VsYXRpb24uDQo+ID4gDQo+ID4g
U3VyZSwgd2lsbCBhZGQgaXQgaW4gdGhlIG5leHQgdmVyc2lvbi4NCj4gPiANCj4gPiA+ID4gKwkJ
CWZvciAoaSA9IDA7IGkgPCBOUl9CQU5LUyhpbWFfdHBtX2NoaXApICsNCj4gPiA+ID4gaW1hX2V4
dHJhX3Nsb3RzOyBpKyspIHsNCj4gPiA+ID4gKwkJCQkvKiBVbm1hcHBlZCBUUE0gYWxnb3JpdGht
cyAqLw0KPiA+ID4gPiArCQkJCWlmICghaW1hX2FsZ29fYXJyYXlbaV0udGZtKSB7DQo+ID4gPiA+
ICsJCQkJCW1lbXNldChlbnRyeS0NCj4gPiA+ID4gPmRpZ2VzdHNbaV0uZGlnZXN0LCAwLA0KPiA+
ID4gPiArCQkJCQnCoMKgwqDCoMKgwqAgVFBNX0RJR0VTVF9TSVpFKTsNCj4gPiA+ID4gKwkJCQkJ
Y29udGludWU7DQo+ID4gPiA+ICsJCQkJfQ0KPiA+ID4gPiArDQo+ID4gPiA+ICsJCQkJbWVtc2V0
KGVudHJ5LT5kaWdlc3RzW2ldLmRpZ2VzdCwgMCwNCj4gPiA+ID4gKwkJCQnCoMKgwqDCoMKgwqAg
aW1hX2FsZ29fYXJyYXlbaV0uZGlnZXN0X3NpemUpOw0KPiA+ID4gDQo+ID4gPiBNYXliZSB3ZSBj
YW4ganVzdCB1c2UgdGhlIGluc3RydWN0aW9uIGFib3ZlIGluc3RlYWQgb2YgZGlmZmVyZW50aWF0
aW5nDQo+ID4gPiBmb3IgdW5tYXBwZWQgYWxnb3JpdGhtcz8gZGlnZXN0X3NpemUgaXMgdGFrZW4g
ZnJvbSB0aGUgVFBNIGluIHRoYXQNCj4gPiA+IGNhc2UuDQo+ID4gDQo+ID4gWWVzIHlvdSdyZSBy
aWdodC4gSXQgc2hvdWxkIG5vdCBiZSBuZWNlc3NhcnkgdG8gdHJlYXQgdW5tYXBwZWQgYWxnb3Jp
dGhtcw0KPiA+IGRpZmZlcmVudGx5LiBJIHdhcyB0aGlua2luZyB0aGF0IGl0IGNvdWxkIGJlIGRp
cmVjdGx5IHVzZWQNCj4gPiBUUE0yX01BWF9ESUdFU1RfU0laRQ0KPiA+IGluc3RlYWQuIFdoYXQg
ZG8geW91IHRoaW5rPw0KPiANCj4gT3Igc2l6ZW9mKCksIGxvb2tzIG1vcmUgcm9idXN0Lg0KDQpT
dXJlLCB5b3UncmUgcmlnaHQuIFRoYW5rIHlvdS4NCg0KRW5yaWNvDQoNCj4gVGhhbmtzDQo+IA0K
PiBSb2JlcnRvDQo+IA0KPiA+IEVucmljbw0KPiA+IA0KPiA+ID4gVGhhbmtzDQo+ID4gPiANCj4g
PiA+IFJvYmVydG8NCj4gPiA+IA0KPiA+ID4gPiDCoAkJCX0NCj4gPiA+ID4gKwkJCWF0b21pY19s
b25nX2luYygmaW1hX2h0YWJsZS52aW9sYXRpb25zKTsNCj4gPiA+ID4gwqAJCX0NCj4gPiA+ID4g
wqANCj4gPiA+ID4gwqAJCWVudHJ5LT5wY3IgPSAhaW1hX2Nhbm9uaWNhbF9mbXQgPyAqKHUzMg0K
PiA+ID4gPiAqKShoZHJbSERSX1BDUl0uZGF0YSkgOg0KPiA+ID4gPiANCj4gPiA+ID4gYmFzZS1j
b21taXQ6IDhjZDk1MjBkMzVhNmMzOGRiNjU2N2U5N2RkOTNiMWYxMWYxODVkYzYNCg==

