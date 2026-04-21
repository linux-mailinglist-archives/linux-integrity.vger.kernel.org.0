Return-Path: <linux-integrity+bounces-9262-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDwEBqs+52no5QEAu9opvQ
	(envelope-from <linux-integrity+bounces-9262-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Apr 2026 11:08:59 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1200E438A52
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Apr 2026 11:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C85143001191
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Apr 2026 09:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969E1388E6D;
	Tue, 21 Apr 2026 09:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ao2w7kDf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013018.outbound.protection.outlook.com [40.107.159.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2565034E746
	for <linux-integrity@vger.kernel.org>; Tue, 21 Apr 2026 09:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776762287; cv=fail; b=eKoMvEy58uOKC4jm791uP66u6SajF4pkaBLg4lGYLkKDYpg0ph12+oO0d+evw3u9XTaAKcwks0ZstmOSvWfQWsDChSy4WQb73GBpiYsiXsf11s22julySgL+14vnKeLCf3kCA28J9FO4Dp3aec/2V+8QvRI6EJVxitBtJoU8oPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776762287; c=relaxed/simple;
	bh=cpz0oZi3MVHTrq/K+HnD+N5uhetYjG5VnMxyMqSGU50=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pavs6LBUqqlHWWzJUGOwj7S+cxnlOROjgT9GmfdfdJYZLHEGFyLZmwGH+vGc1zKxj+bnlrNO12vx1Gu/k6qTwaxh9zsaeEMmG/C3moHklDCOmmnxS/1dgM2HT49ZZFvSuojmYwOnVWJDOR7hYtyRjXERxtRBy+XAtvapNt1x2IY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ao2w7kDf; arc=fail smtp.client-ip=40.107.159.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GipHis2IP0IpwebQHlHz++Bv3sbLwYgdVvEkS0pMjmVxsYAl9q70/AZUD9gSA3cQlfY1U6eBZg+O5MUNMvAjUgnfraF05+tu8eaIJVB4Far2BdY6wmsv7IngmNWXVdtjOjYTm0yQc2EnbW4Zh94bZ5LBcekE7G1TCe2oALg5BIaGCfJ9tM6XIQ+LhViak5GtHdCSH139H+ca90YyIm1KBes4+DKtIVTM2ijl8cxEDJgIiMOIN1uZnpKXWTHB/XIXQJwdH6JgI0uIo1pPqnMNH5MEQRetWPw5TTcbkQ/nzVZtpgtTRA8f6qkLLHqq6PDejZQDeWerCUdXnBhJZJJhjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpz0oZi3MVHTrq/K+HnD+N5uhetYjG5VnMxyMqSGU50=;
 b=zGG0bgpqjqRrbXumoigh6aGyLGNCmKpso+Z4mNut4NttmfHHBwCVORbBj0ZEPSNJuUXuI0mk6Nz+VQwIn651hjZjqlCa0aTL/Tcjb9dCVG+YY8MgujBmqX5BqKXErEqA1u0/8pJSE4vDirHlgAb/XX8Ekz8rTDxrfXDSRU6fr1D82hP8bCp/dexHi8IkJg0GnHqc2eIQgc41mMMGdDn1UlGwZJAPbl/z5idoR5gn39xdq4ch+w1RxOom9ZV9KjJ10+8Ws2HNLXUsUJnRAgipRmO4SIvMoeY4WYssHcvd98+5g/cbmzk5EcHWiJNAk7a2UZ/twbDK87pVruKvGr6d5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpz0oZi3MVHTrq/K+HnD+N5uhetYjG5VnMxyMqSGU50=;
 b=Ao2w7kDfjKIt2WqX3629JSO9iLypz8OrgcfvcTRpTRjYA/8+yjTy9LUauc+uHmlu/gCJIzb30DinVuWQfkiD0MIvq8r4WmBiORJJPoI4MqGRx53cOq9Y5EOQzdZSiavU9aJ94LT0ITY9QJ+mEaMAju8/F7L36YJJ6md6+ZsJrV+4wSkHfsD5klIToCoAW25MxF5TGA/AHU1SwcGpXjN3DAEGGvg/iJI9yQFt6/fVKe8NDj0AtSWfwrXMZ7DEdgZJ0e3daM7DB0W9fNIaPfqpmcYJ+fuzW4les9irSy1ek8CcsODg5t6Kf1SXv2NOqPn8bEm4Dl4olB0fb5jlq+9nig==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB12450.eurprd04.prod.outlook.com (2603:10a6:10:602::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.31; Tue, 21 Apr
 2026 09:04:43 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 09:04:43 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Stefan Wahren <wahrenst@gmx.net>, Peter Huewe <peterhuewe@gmx.de>, Jarkko
 Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-integrity@vger.kernel.org"
	<linux-integrity@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, Frank Li <frank.li@nxp.com>, Sascha Hauer
	<s.hauer@pengutronix.de>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: tpm: spi: do not call blocking ops when !TASK_RUNNING; during
 shutdown
Thread-Topic: tpm: spi: do not call blocking ops when !TASK_RUNNING; during
 shutdown
Thread-Index: AQHc0LAg/CBfUW4c2UyRiQrEqWTHj7XpOdaA
Date: Tue, 21 Apr 2026 09:04:43 +0000
Message-ID:
 <PAXPR04MB84598325136E394E0A7D94D6882C2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <e7974d35-0d50-4742-8747-822f28915e00@gmx.net>
In-Reply-To: <e7974d35-0d50-4742-8747-822f28915e00@gmx.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DB9PR04MB12450:EE_
x-ms-office365-filtering-correlation-id: ff0f4bab-6dbb-4f7e-a58c-08de9f850725
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 W1qZbvwz2ea0p2FuToKgKrPkJ6y8+z8taPbzv2lLldjMlbcPV8iBsVLj0og1IacIIrzX1ktoJajC72dyR73wSm2eNhUdB9FCSIzBy6JjCMCEfGOXcryq5lIXeI/hKHlHE1hxi10Kec2OdsJYXeXx7KRhW3bYdmYkPCSRHQESCAYKEaqWcHKH3acuM3H7O2MxhAyxuS5Q5H0BpTPCnUBTunzWynCDNlQjRtV5ZMRvVpXDuwQnP3NAQTNgtbt6Q+Z8o1IpfKFfiqrRDyyYBJ6nKnO6n2pMVG+uELYDZVo6QXqbfp559kCrBo6H6UBxjF8/oeoJlW1p8yPzzu0zRiXHAVFLSvbCVh8cK5hDUW8vtAy4Rl69i6IJTI3FYE0Nf3gl14GpO/U2soDyRwNwu7Nc1STH4oJS00xUa/3YgADLF6ytAMP1Z64VQrgObfGcku8pHejpC2cSk27dQioVHJcdYpJEL7LfxBa04jB38wQVQ0vGnuqDYXcnUJD/4piRvZ0QTfJUSpNxQL1CwOc3S5hyxsPURbwNgRGlll27MHvU3xmMf5jW9w9/p/0ca1znuJthbk63p96qpdHa+pooHZusRfpz9Knh/4slUf4gjzolvOLdYPIDFAG3Q0FyxppuE+RcYXAPXVokw0rMbxMTyJnpJ1QhPpEX2rY75z6QNUFUY3vntBCoJGvfCgfwKdTy3bwVcfzw70YDQPf48TCq10XaLdIOhYg9ZrAqYq3FQs0npoasw3d6Uhiss3dtiIGdTqL0nYCRqx8/nJSa7sKFJ/j/L62zHCGipcavZ3EE69Z/8Bc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QXplZVRWaVFpaFd2SU80UzBvOHNRQkNLenpPVkJORDZJdThST3pqUWhobG96?=
 =?utf-8?B?RE15VFljNytRczlzenVvSnMrMERmWkJTN05HNElFTnk3amtpMjIvVDl6Z1FU?=
 =?utf-8?B?QlUvOEh0VzFKWkl4NStHUEMxQ0JjcC8xY1Rha202K3Q3b2FPZnVGN2hraW9z?=
 =?utf-8?B?M2Rhc0R5QlRrb0NRdEhPTnRVb0lhV2ZFbktJRC82c0JoZkRCelFGNjRqTUlw?=
 =?utf-8?B?S0ZPUjBJYVpSMmRpNDNpM2VHV0FxbmwzTldzSnJqYi9xOEdzZnZWWEhVZDRT?=
 =?utf-8?B?bzNmZlRJL2RSUUM3L3VGSnk0NDNKOHQ0MlJ6L0N4THR4UGl4N3lNY3c4bTdi?=
 =?utf-8?B?NGNhWUk0VVhlUGxmTU9HT3crc0hnZzltemNraTFsZ3FML3hlUzRsckNFdm1x?=
 =?utf-8?B?SHFDNGh3ckhyL0wyOXpuak9aZG5tOWJoN3RtZVNFYzJ3ZHRrSm0xSUpnd0Z6?=
 =?utf-8?B?c1dnS2QrTTl6MHNjWld5enE1U0dyYmxKUmZWMFlMRklUZ05YblRIeC9XL2hZ?=
 =?utf-8?B?Z0FQeEFrUlNLRFljSXdBSUo4NGFiWU8xTkNIYnlyaEZlbUIvaW1BeUV5NjRP?=
 =?utf-8?B?NVYvTlJQNXd3U0xzL01uNDZFMXBWajN3cTJNMDdUdWxJTUp5V1I5ZElDeS96?=
 =?utf-8?B?NmgrUnV2RGxzN3ZnRHU5alp4d3pCQ3NRQUM5TDIrbkg1UDRlbTdpL05tMlQ1?=
 =?utf-8?B?VFJDTXJpMmg4ZnA5bTlxVlRob0toSzBZMk1hcTB2em1kZG41UGNUcmwxWEdq?=
 =?utf-8?B?ZnBKRDJocWE4LzVpdnQ1NmxTbWY2ZUR0cTVPc1dpYXFwQktnOWttZG5xZ2pQ?=
 =?utf-8?B?L1ZTbEY4K1RYWDkxTG5wOWc3RnBiWjdiL25BSE4vMnUyNHB0RE1SLzhYUis3?=
 =?utf-8?B?Q0Y1dmYxMG5MMWRkMFV5cE1PM01ISXlsWFBtbjF2OXVIRkIya1FmSnYrY0ZT?=
 =?utf-8?B?QjNVNWF4bkNkSkRGOThRSzdmLzRReW0rVHJZOVNGVDNoVktMYi9JUHR3eE5B?=
 =?utf-8?B?ODdDNGFxKzIwclRkY0YzN0JieDI4QTRlOUtnbTJEOHVNd3VkRGpualZReDBi?=
 =?utf-8?B?UFdHbGpjcXFzbkxKQUU5czQ4aTA0YmtKbXpuZlRRQXRXSXg0L3prR0xvUi9a?=
 =?utf-8?B?V01LTjh2clFJVk5HRmlhR0w1SDlqaWpwVG1uNCtMOXdvdWVJSmwwRUt0dngv?=
 =?utf-8?B?aWw0OWhUUXlqYTBvYU1tU1BhVkd0bmp3dWxMVG5IZGMyaDA3VDdCZmlwaHpP?=
 =?utf-8?B?cExhbGlnanlBTFF1ektCMzFKQU01b2hpay91ZWJPNzQzTUlDYmJXekhIUlht?=
 =?utf-8?B?N0x2L21ybVNZLzN3UmpITlZnRkVVYVNzRk1zOUJ3bnM2ekZkTzFRTTFNVjhs?=
 =?utf-8?B?RUp1cFZONVJVQ2EvNFplL3p3NEt4QXNTQXlxMVRoRDdleW04Myt5bi9nRnNt?=
 =?utf-8?B?QnE3RUxqR3VhSEVqaUJweXMrbnlXd2kyUUZmbko5OTB5dnJQT29xbWdpQVd0?=
 =?utf-8?B?SjlmSXo1cHhLejNqOTIzUmNLTTV5dDJrcTlnc045MFFTeDl4NThmaFdEbHJ6?=
 =?utf-8?B?a2hSVkRtL3hoNzA4eUJBQVByREgvTnZIYWMwZm9pUHZ6aHZKOHMrYTI4ZXZh?=
 =?utf-8?B?NStLdjg1RHd2VS84WUN2bHg4WTRHVS9KNU9xM0VLOVVSUkc4dUhqL2thcDJz?=
 =?utf-8?B?SWZuK2J5allBOE13N3dVYUdyWmloYTU3RFhmSHR4TDlOYkIrbVdTRVZkQTUz?=
 =?utf-8?B?dXZJNm5QamE5cmRHbWY5cS80cVZjbS9wODFCdW1YNWhIUlJvQzJHYkJBcHht?=
 =?utf-8?B?VGFKK3BKem00YU5QVDlvZTdldEdFcSs1c0RSNWlsNUVKQVFiMlRWYk8zUVND?=
 =?utf-8?B?cFgyVE5qak5QL1NjK3ZmTUhnOVJPRGlydzFYSkZ2MzQ4VDhDRklDcW1HdFJo?=
 =?utf-8?B?cnYyNjdIdWVtS0MrTTVmZlVWWjl0Q1hLUnI2dW5mR1ByWkZ4YlViZkQzVzRZ?=
 =?utf-8?B?N3dXNzNMMGxHZnNYd3ViYXUrOGdCdXR4SGNvN05JWHZkRXdXdzJXUjdEWHRW?=
 =?utf-8?B?SWk4N0NlNmhpQXUvVHNoZExJN1hNTEdmNy9XVjM0STZkN2pka2RpU203T2Ju?=
 =?utf-8?B?UkE0M0RUMEhkMUJDUmQ0VC9SeWo3NktqTkVDMWR2Z1J2K3R5UThUTVlWaDJP?=
 =?utf-8?B?Y3l5WlVQRDFHVTFKVHJyVG8zUmY0bkFLZ3FJUE1Hc1ZESGNNbnBTU295U0hP?=
 =?utf-8?B?RUdCYXVyVUpZT3NzTGdISnBiV2hqeE9sUW9xa3F0cjBEZjh3V09tbFhHV3oz?=
 =?utf-8?Q?VjW/BqwCVRoUCBuEDO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff0f4bab-6dbb-4f7e-a58c-08de9f850725
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2026 09:04:43.2070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A39Fzcgv0kbwqfXmgmMuUOMissVTGXMiEiv4k0goAD/1PTwLiQhyc+hbWfTjz4/c3jh2Iy0bo3z54t2snFuAmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB12450
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9262-lists,linux-integrity=lfdr.de];
	FREEMAIL_TO(0.00)[gmx.net,gmx.de,kernel.org,ziepe.ca];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peng.fan@nxp.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,PAXPR04MB8459.eurprd04.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 1200E438A52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiBTdWJqZWN0OiB0cG06IHNwaTogZG8gbm90IGNhbGwgYmxvY2tpbmcgb3BzIHdoZW4gIVRBU0tf
UlVOTklORzsNCj4gZHVyaW5nIHNodXRkb3duDQo+IA0KPiBIaSwNCj4gd2UgdXNlIGEgY3VzdG9t
IGkuTVg5MyBib2FyZCwgd2hpY2ggYmFzZWQgb24gUGh5dGVjIFBoeWNvcmUgaS5NWDkzDQo+IHdp
dGggYSBUUE0gY29ubmVjdGVkIHZpYSBTUEkuIElmIEkgZW5hYmxlDQo+IENPTkZJR19ERUJVR19B
VE9NSUNfU0xFRVA9eSBpbiBvdXIga2VybmVsIGNvbmZpZyB3aXRoIG1haW5saW5lDQo+IGtlcm5l
bCA2LjE4LjIzIGFuZCByZWJvb3Qgb3VyIGJvYXJkLCBJIHdpbGwgZ2V0IHRoZSBmb2xsb3dpbmcg
d2FybmluZzoNCj4gZmZmZjAwMDAwMDBkODAwMA0KDQpUaGUgaXNzdWUgc2VlbXMgYXQgZHJpdmVy
cy9jaGFyL3RwbS90cG1fdGlzX2NvcmUuYw0KICA5NCAgICAgICAgICAgICAgICAgcmMgPSB3YWl0
X2V2ZW50X2ludGVycnVwdGlibGVfdGltZW91dCgqcXVldWUsICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgDQogIDk1ICAgICAgICAgICAgICAgICAgICAgICAgIHdhaXRfZm9y
X3RwbV9zdGF0X2NvbmQoY2hpcCwgc3RzX21hc2ssIGNoZWNrX2NhbmNlbCwgICAgICAgICAgICAg
ICAgICAgICAgICANCiAgOTYgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAmY2FuY2VsZWQpLCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIA0KICA5NyAgICAgICAgICAgICAgICAgICAgICAgICB0aW1lb3V0KTsNCg0Kd2FpdF9ldmVu
dF9pbnRlcnJ1cHRpYmxlX3RpbWVvdXQgc2V0IHRhc2sgdG8gIVRBU0tfUlVOTklORywNCmJ1dCB3
YWl0X2Zvcl90cG1fc3RhdF9jb25kIHN0aWxsIGNhbGxzIGludG8gbXV0ZXhfbG9jay4NCg0KUmVn
YXJkcw0KUGVuZw0KDQo+IFvCoCDCoDQzLjQyMjEzNV0gQ2FsbCB0cmFjZToNCj4gW8KgIMKgNDMu
NDI0NTcwXcKgIF9fbWlnaHRfc2xlZXArMHg3NC8weDdjIChQKQ0KPiBbwqAgwqA0My40Mjg0ODdd
wqAgbXV0ZXhfbG9jaysweDI0LzB4ODANCj4gW8KgIMKgNDMuNDMxNzk3XcKgIHNwaV9idXNfbG9j
aysweDIwLzB4NTANCj4gW8KgIMKgNDMuNDM1MjgxXcKgIHRwbV90aXNfc3BpX3RyYW5zZmVyX2Z1
bGwrMHg3MC8weDJjNA0KPiBbwqAgwqA0My40Mzk5NzldwqAgdHBtX3Rpc19zcGlfcmVhZF9ieXRl
cysweDNjLzB4NDgNCj4gW8KgIMKgNDMuNDQ0MzIxXcKgIHRwbV90aXNfc3RhdHVzKzB4NTgvMHhm
OA0KPiBbwqAgwqA0My40NDc5NzhdwqAgd2FpdF9mb3JfdHBtX3N0YXRfY29uZCsweDMwLzB4OTAN
Cj4gW8KgIMKgNDMuNDUyMzI5XcKgIHdhaXRfZm9yX3RwbV9zdGF0KzB4MWNjLzB4MmUwDQo+IFvC
oCDCoDQzLjQ1NjQxOV3CoCB0cG1fdGlzX3NlbmRfZGF0YSsweGRjLzB4MzM0DQo+IFvCoCDCoDQz
LjQ2MDQyM13CoCB0cG1fdGlzX3NlbmRfbWFpbisweDc0LzB4MTYwDQo+IFvCoCDCoDQzLjQ2NDQy
N13CoCB0cG1fdGlzX3NlbmQrMHhkNC8weDEzYw0KPiBbwqAgwqA0My40Njc5OThdwqAgdHBtX3Ry
YW5zbWl0KzB4YzQvMHgzYzQNCj4gW8KgIMKgNDMuNDcxNTY5XcKgIHRwbV90cmFuc21pdF9jbWQr
MHgzOC8weGQ0DQo+IFvCoCDCoDQzLjQ3NTM5OV3CoCB0cG0yX3NodXRkb3duKzB4NmMvMHhhNA0K
PiBbwqAgwqA0My40Nzg5NzBdwqAgdHBtX2NsYXNzX3NodXRkb3duKzB4NjAvMHg4OA0KPiBbwqAg
wqA0My40ODI5NzRdwqAgZGV2aWNlX3NodXRkb3duKzB4MTMwLzB4MjVjDQo+IFvCoCDCoDQzLjQ4
Njg5MV3CoCBrZXJuZWxfcmVzdGFydCsweDQ0LzB4YTQNCj4gW8KgIMKgNDMuNDkwNTQ5XcKgIF9f
ZG9fc3lzX3JlYm9vdCsweDExNC8weDI1NA0KPiBbwqAgwqA0My40OTQ0NjZdwqAgX19hcm02NF9z
eXNfcmVib290KzB4MjQvMHgzMA0KPiBbwqAgwqA0My40OTg0NzBdwqAgaW52b2tlX3N5c2NhbGwr
MHg0OC8weDEwYw0KPiBbwqAgwqA0My41MDIyMTRdwqAgZWwwX3N2Y19jb21tb24uY29uc3Rwcm9w
LjArMHg0MC8weGUwDQo+IFvCoCDCoDQzLjUwNjkxMV3CoCBkb19lbDBfc3ZjKzB4MWMvMHgyOA0K
PiBbwqAgwqA0My41MTAyMjJdwqAgZWwwX3N2YysweDM0LzB4ZWMNCj4gW8KgIMKgNDMuNTEzMjcz
XcKgIGVsMHRfNjRfc3luY19oYW5kbGVyKzB4YTAvMHhlNA0KPiBbwqAgwqA0My41MTc0NDFdwqAg
ZWwwdF82NF9zeW5jKzB4MTk4LzB4MTljDQo+IA0KPiBCZXN0IHJlZ2FyZHMNCg0K

