Return-Path: <linux-integrity+bounces-9359-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHyxGOAW8mljnwEAu9opvQ
	(envelope-from <linux-integrity+bounces-9359-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 16:34:08 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F8C495DBE
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 16:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D2D663019D65
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 14:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFD8352F87;
	Wed, 29 Apr 2026 14:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="q1HALRb2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010057.outbound.protection.outlook.com [52.101.84.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BE222301;
	Wed, 29 Apr 2026 14:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473207; cv=fail; b=IooSG858brjGc4X7HOMh0+Fif5tdFahFc7Mc1XhNjRWftxtm8CQ2ouUDrg5wPdGf7a0aKcD8MJ6Rn9IoTRiDpj1FEBZQdNK5Qp1hjm03X9ydZZPCWWAWGoG+ALCtmmt7o65ahoJ1BxxRWpbXJaaPpi5jF1q5mfPsv/AcS3BgzfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473207; c=relaxed/simple;
	bh=hSCMHnBuiFtI7MeCm0V+Dhc6dhzRhklELIiVVFWmdg4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PZzPqqrgwoXPzmLXfA60kqJvoE+FJmIPRiPsfkGEsF1/OcN0UQjFALxdWMtFFNEBNivWRM6OKAnUHn21JCvyyyYuhwopI76D5CDCgDfzeU3fMiRSWJoTRYPae0IwF2teO1ahptNc4RU+NPBgwT3uYgkPOGrNvc3ZCbL0wAdbk5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=q1HALRb2; arc=fail smtp.client-ip=52.101.84.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQ+AGcljdniU0ZtIbxh3u63rW1OWQ6PMvxsWk7QnbmnYy0FNd3lkJI6RwX5x7XrOEHQyWMTwEQZZQlDovZTYEynKMjkIIHMBtO35PyndJkqGTxR7zFy2WzeTmWUcaTCQeNgckZQQgiea0MQMjlLfSDu03BUJOffiFOGYDlpNq4obGdYYRN6caHmfve2ey9p95jIOWsETJa+HZGUTVlpRcirXUMrQzR+39WVgoJ5osFFSDKBEXTDud6l8lVkdB7n7HQ0OtJ26alM3mOdznkCTYldFdFTidAbvgN6KVPaxULE4Y4RX1e0vgdh093SD2Ef+L2ZycR6mr68e0gpohongLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSCMHnBuiFtI7MeCm0V+Dhc6dhzRhklELIiVVFWmdg4=;
 b=XrusZ8V0jzJ4j4TZnj7CfD/X2GaoiGMDNake+dMYd9zSDXJdm3xRBm9wk/rb9ytzsagMOuC069mEJxIr91/GpWwsLJjAi4ibwUdBhdUpjT62tbbDvrKp0CVjHdF+RLvrNIZ4K9tq2X89neD6aRhVKSc0vf84TzRE9uU1w1o/OBt/C+fwxE7BPmPpNr/sPb2z5R99t1yl6zIP23mCbWPvcQUlNPsZXb9nQllGKu3PDoTzCzr/zzYqIVr2ZqBhtO1M8hXYb5GM/LHjy/w6hyubb4cdt2P45FwTS27it1TxOw69Eg1wWiCRMM7K5wY6M5PpQRsnlhjxHwY/M+m5Z2JUng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSCMHnBuiFtI7MeCm0V+Dhc6dhzRhklELIiVVFWmdg4=;
 b=q1HALRb2FSRyODQkR0PenlmxoRT+uA/s3E4clwW3KpEqlJHllmXJXDku97lvtr+iCPPyJ+GzaNYd2WcsY3/wlDpipn+tMnmv2DD0JqyMKs4waf7yTa7qkb2d0GoFTx8T+fHDICLOzSroMqlZDNWZJReJhmtLIteoNQIQZZyhes6lc8/VEv5nr+oeLC9HSZ25jFuRi2wnGw6N6Px3kF95LdDKzZkkBEUWyZ0MNRFJ0ucCBoe/gFUK+xw+iXpiUP54pxq7TEq+HEmxUJ8NDZwlVRlzMvK4AloH2Utx1Rx0BoPkIrnW+LiWEnXs8HjAh3XDYaGv9NxddvoTMeUCtUBdlg==
Received: from DU2PR10MB7645.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:497::7)
 by VE1PR10MB3934.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:16e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 14:33:21 +0000
Received: from DU2PR10MB7645.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e295:f11e:ecf3:deff]) by DU2PR10MB7645.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e295:f11e:ecf3:deff%4]) with mapi id 15.20.9870.020; Wed, 29 Apr 2026
 14:33:21 +0000
From: "Niedermayr, BENEDIKT" <benedikt.niedermayr@siemens.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
CC: Peter Huewe <peterhuewe@gmx.de>, "linux-integrity@vger.kernel.org"
	<linux-integrity@vger.kernel.org>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, Jens Wiklander <jens.wiklander@linaro.org>,
	OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "Bauer, Sven"
	<svenbauer@siemens.com>, "Zeschg, Thomas" <thomas.zeschg@siemens.com>,
	"Gylstorff, Quirin" <quirin.gylstorff@siemens.com>
Subject: Re: [PATCH] hwrng: tpm: Do not enable by default
Thread-Topic: [PATCH] hwrng: tpm: Do not enable by default
Thread-Index: AQHc19gjaqb6B7t2BU+H2jw48g+0M7TVRm+AgSDUIAA=
Date: Wed, 29 Apr 2026 14:33:20 +0000
Message-ID: <96df7b4d-cf1b-471d-9b4b-8741a80fbcc3@siemens.com>
References: <bbc41534-a2d9-42dc-ac8a-ff8a0b4fd41f@siemens.com>
 <aP_NN3HwO4Hp0-9T@kernel.org>
In-Reply-To: <aP_NN3HwO4Hp0-9T@kernel.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR10MB7645:EE_|VE1PR10MB3934:EE_
x-ms-office365-filtering-correlation-id: bb714d4d-ceb4-4dbd-c30d-08dea5fc4324
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003|55112099003|38070700021;
x-microsoft-antispam-message-info:
 VUP7eZtV5A+8c739QVEtbML+8SetZNPxkVqNvNC5RAt00zYM7tDCTW/UW02dvWJDWrK0X8AHdhykretwHe+vLubOVdCZAHEHRBQFCjon7vhrNRTeWoIO4+Cw+ikWBSyJX35+FBGHAwy8zT6wDbJMKrsyKER2JxRV4zg0Xlk6aIgEkjz4ZXnaCkhPEROHUv9i5C5hx0r4LbOMPoPqyuVt0/I6hpLLhyXWEedltjwS7TgZ26HOJlRkedFc5af9dgSaam2B7ieQ5qlluEugyaeO4hNt2Gv5STS/k2Onsu38V1FOcGujaDStppmqmkSfWIlGL9u3TGaOq1N90Ipeykm65ZDvER25arjlBJU7emkTAPTWXYvS0Z+ZoR8A81SjbdTBKjE4zpAVHP9zF0T/3uUJkQZMq/TxF7I7I27SkDMPNWG6pgLt6Er+em1bT7PAL7T0DTQu+UGT/gsacDE1x6erLlhH7Kb1A89sm1OeEMQ1HLfJucSRPwg8aSLmpG/fjxTXuw+aKhF9Xcqe3wN3AI5KlYlFYuRjSyn2D2l3GZvBVBJ6ijDGX2JrkwhBpXyfMxtP7vSsbpwo4fQEAIs4iD9Y6nT3AV5jspnIV5+80QKq6yqlyRVYHenSON6pZwRZUfqP0gx+QXW/aH2Fvqj7RQJyy6TXWE6HcrKaRTnndWtJHIaTt8Qjt/xFXQUZ+k8kGtuowfGgnfG8EaGG6Ce/zNTI5flUH7tAMvNyWFTQYYOkQTAo98aBgfRI2V+SmuBQ7kdo
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR10MB7645.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(55112099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Zy95MkF3d0QwV05FdVpSaTM3blN4SUxFRGJ4ZGxac0o4ZXJoaHdkM0NrWllj?=
 =?utf-8?B?SHdYMnJGUXdtT2dpUnZQOTh0aUwwbFUzdjM1MEFHUXhyd1VOQ2tFQTNkODJv?=
 =?utf-8?B?b2JaVlNud0h2WHVLdCtrZ3ZEaVpGYTRNQTBoTUxxVStrSkJaREcxaGpGdXZy?=
 =?utf-8?B?Z1V4RTRjYkI0MEVJcWRTOEY0cjE1NTh2S3BoS3ZSWm1HUTNvU0x2MWk4MmJx?=
 =?utf-8?B?TjRLNkNqQWUwWlpTYnJiOHBGYjNkNWpGQXVlT2NjcjZrQldDbjJCZjJTTGs3?=
 =?utf-8?B?ODRVakk3cCt5c2UvaW9kZmJTNEM3VkQ4UUhCcU9mMG80MXROaFh5Tm1TL04w?=
 =?utf-8?B?L0JmMHZLdlNNK3hTTksyVTdVRnVFMEdndFVBMCtjYVBodSs0bjQ1aFR6eE1y?=
 =?utf-8?B?aFJOcm80RjkxeVYrQ1NKL3VjOS9paFgyYVpHTjVEdWNrd0lPUGJOOE8vSHI1?=
 =?utf-8?B?akVMVTQxSCtDaHNVbGF1VzZCOUxQUXpWQU92SU4rMU5CWFZYeittQk82M2ly?=
 =?utf-8?B?ZkpRSVBXRm94cFVGUVBiblBZZTRXWVlaQWlvYXg0SFNyS2FxME1FT08yanBC?=
 =?utf-8?B?dWtkRG5UbHdlWHhnRlVFSEVkRVg4VWFRQmFkVHpDWkJjNUl6YTB1QmphT1dQ?=
 =?utf-8?B?aE5OSTByVnV0b1dNZVlCSy9oUHRPZGRGRjhqcVl4T2lUSGNmaVB0RGJNL2ly?=
 =?utf-8?B?SktiUFNlQkNsby8wamNKWlM2KzBQMHE4bWxkNGU1VENzeUh6ei9PQ3pyV2ZV?=
 =?utf-8?B?Nks4VmJjL0JBNXF6eEt0QWxqNjdFTzVnb3NkRUN3THRzWGVvd1lOTVJlT3hZ?=
 =?utf-8?B?M0VwOFBUU0pOMThHZlFvQ1RsWVdyYkpVd0ZjOEZ6anpBSEUvOWJVZGNhY0Mr?=
 =?utf-8?B?d2VNOTVKcTJQRlRlN3R2Zk5hVXlTQTd5RFlBZHRzWWFVRWpCR0NiSld6ajJh?=
 =?utf-8?B?TzVERnFkcTl3YTR0NmhjdFB6TnpMaEF6a1FmeVZQNnZsUzRZYmJSdVp0aVNx?=
 =?utf-8?B?czZMMWJPd2RVeDI0cmxrZUY0bFlsTk5QaUp0dTZBU0Y4bWRSdjkvcWVxTDlS?=
 =?utf-8?B?WGtPK0pNc2tCMUViVDRVSGl6UzRSZjdhQjRMdnQ1dkt0bkJOYXdBSS9UUXZG?=
 =?utf-8?B?UThxWTZnZkU0NUZxL2E0bEhSQjI2bWdxSjBNaFRKZFpmb0Jua2NyOWxzanhJ?=
 =?utf-8?B?Q1ZnM01SRE55dTB1SXR0NFpGN1l5UTBwYUkyWHVVL0FrRFpFZVNFVmprR1Ny?=
 =?utf-8?B?QWdlNXBvMnhPeGIzQjRLQW9nZDE4NzA1U0IyMjdYV2x4aVVXNE16aytSWWNn?=
 =?utf-8?B?LzFKR1lrMGZmRU9UUDFjMSs5dFVRSGpIOUN6UVZldHRZb05CM1piN3QrcmJW?=
 =?utf-8?B?cnlVR2JnZWJLSzNoUjFZVExaZllBQXNMZjZMdUN4MjJGeWhPRCtKVnQrRFhq?=
 =?utf-8?B?ZWtYV3I5Skd2Uy9ZZHJKMCtTQ1ZrR0ZxVjNka3hmdUJPdEhhWUtDRnZSNE5w?=
 =?utf-8?B?dEgzOHROekJwc0RiMFdpTVNEZlNidkxlZTkrQ1JubndlTjZaK1Y1NHMyckg2?=
 =?utf-8?B?Mlc1ZjJvdklHRDNDQ2dIL0xpRUsvQThJVEtZQ3RjQ0lWV1RLVEJmeGkweWdI?=
 =?utf-8?B?cU1YSUJ2VHZaQzNKOFhoUVJveENiWmFqZkxRcmhhN1gwbmRxUDFwRTQ2QU9T?=
 =?utf-8?B?dCtGRkYyOTJFelFhVnI1VTY3ZXRsZG5XM3dMUXJYV3QyN1RZdE9JVytsd2Fj?=
 =?utf-8?B?dHFmelBLMkREMTRPS2YvcXZ1a2tTREt2MVJ6VlhudVdqaWFOUVV2dHhEb1E2?=
 =?utf-8?B?QzUza2tWT3VTRGhzeHlwYmpPcUF2SG1nWnJZeVVIaFdmSys4bWloVTdKNDlq?=
 =?utf-8?B?b2ZlRUtEN2NZOFhtUzczVlpmc21Yb0FHZllCeC8vU3BPdTlMWGVGbi9wVFJn?=
 =?utf-8?B?UFNqemtEOHIrODNCc2NVMm44ams3MXMxeE9lUmFvaFRBcDVjOEkvaU9PSGMz?=
 =?utf-8?B?b1pKcFdVN3NSUklVaDQ0ZCtsQ2JWWGU4ZEhhSmZ3WC9HNGliZUNja3ZIUjQy?=
 =?utf-8?B?d2JraWxTbkx0Z0xPVmg4d1pjcVNSendxSTk3aWhnS3V0SHdBWjV0WXJBd2VQ?=
 =?utf-8?B?Wjd1YWpacFJ2UUJhUy9qTStlV0p0MVlyTytQV1E4dXZxQlZVNlo1UXU4K2Vw?=
 =?utf-8?B?aVdmRDdESzZTcTlsMnkxQlU4ZlVuYjlwUC8vR3FVL0s5WU13NmI1bnlYMCtL?=
 =?utf-8?B?U1lNRkUycXpwYjZwNzFiNTRCSnVvWVNwZ0ZGS05uSThQZ2NaeFN2MjU2OE9w?=
 =?utf-8?B?ejk1eEpBNjFwUklLM2RLVGU5MlF0OE9lcmZsQWpoYjhwSWQ4S2tVeCt5NGFO?=
 =?utf-8?Q?rktwRdJX4HmYrTtA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <36E376E54A85BB409B240C4FB6FF4D27@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR10MB7645.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bb714d4d-ceb4-4dbd-c30d-08dea5fc4324
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2026 14:33:20.9662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JIXUAvGG3hTZWs6Peu4nuutW5Fkd4aFWnevXJ/oB/yaxgt/LvKnriAHlrmxLdPRAgwKgDVWjVjCIJgbeQ7J9NO8ATM891A4GJzXyz0EwO3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3934
X-Rspamd-Queue-Id: D8F8C495DBE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,vger.kernel.org,linaro.org,lists.trustedfirmware.org,siemens.com];
	TAGGED_FROM(0.00)[bounces-9359-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[siemens.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[benedikt.niedermayr@siemens.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	HAS_WP_URI(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,siemens.com:email,siemens.com:dkim,siemens.com:mid]

T24gMTAvMjcvMjUgMjA6NTEsIEphcmtrbyBTYWtraW5lbiB3cm90ZToNCj4gT24gVHVlLCBPY3Qg
MjEsIDIwMjUgYXQgMDI6NDY6MTVQTSArMDIwMCwgSmFuIEtpc3prYSB3cm90ZToNCj4+IEZyb206
IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+DQo+Pg0KPj4gQXMgc2VlbiB3aXRo
IG9wdGVlX2Z0cG0sIHdoaWNoIHVzZXMgbXMtdHBtLTIwLXJlZiBbMV0sIGEgVFBNIG1heSB3cml0
ZQ0KPj4gdGhlIGN1cnJlbnQgdGltZSBlcG9jaCB0byBpdHMgTlYgc3RvcmFnZSBldmVyeSA0IHNl
Y29uZHMgaWYgdGhlcmUgYXJlDQo+PiBjb21tYW5kcyBzZW50IHRvIGl0LiBUaGUgNjAgc2Vjb25k
cyBwZXJpb2RpYyB1cGRhdGUgb2YgdGhlIGVudHJvcHkgcG9vbA0KPj4gdGhhdCB0aGUgaHdybmcg
a3RocmVhZCBkb2VzIHRyaWdnZXJzIHRoaXMsIGNhdXNpbmcgYWJvdXQgNCB3cml0ZXMgcGVyDQo+
PiByZXF1ZXN0cy4gTWFrZXMgMiBtaWxsaW9ucyBwZXIgeWVhciBmb3IgYSAyNC83IGRldmljZSwg
YW5kIHRoYXQgaXMgYSBsb3QNCj4+IGZvciBpdHMgYmFja2luZyBOViBzdG9yYWdlLg0KPj4NCj4+
IEl0IGlzIHRoZXJlZm9yZSBiZXR0ZXIgdG8gbWFrZSB0aGUgdXNlciBpbnRlbnRpb25hbGx5IGVu
YWJsZSB0aGlzLA0KPj4gcHJvdmlkaW5nIGEgY2hhbmNlIHRvIHJlYWQgdGhlIHdhcm5pbmcuDQo+
Pg0KPj4gWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9NaWNyb3NvZnQvbXMtdHBtLTIwLXJlZg0KPj4N
Cj4+IFNpZ25lZC1vZmYtYnk6IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+DQo+
IA0KPiBMb29raW5nIGF0IERSQkdfKiBmcm9tIFsxXSBJIGRvbid0IHNlZSBhbnl0aGluZyB5b3Ug
ZGVzY3JpYmUuIElmIE9QVEVFDQo+IHdyaXRlcyBOVlJBTSwgIHRoZW4gdGhlIGltcGxlbWVudGF0
aW9uIGlzIGJyb2tlbi4NCj4gDQo+IEFsc28gQUZBSUssIGl0IGlzIHByZS1zZWVkZWQgcGVyIHBv
d2VyIGN5Y2xlLiBUaGVyZSdzIG5vdGhpbmcgdGhhdCBldmVuDQo+IGRpc3RhbnRseSByZWxhdGVz
IG9uIHVzaW5nIE5WUkFNLg0KPiANCj4gWzFdIGh0dHBzOi8vdHJ1c3RlZGNvbXB1dGluZ2dyb3Vw
Lm9yZy93cC1jb250ZW50L3VwbG9hZHMvVFBNLTIuMC0xLjgzLVBhcnQtNC1TdXBwb3J0aW5nLVJv
dXRpbmVzLUNvZGUucGRmDQoNCkhpIGFsbCwNCg0Kd2UgcmVjZW50bHkgYWxzbyBzdHVtYmxlZCBv
dmVyIHRoaXMgaXNzdWUgd2hpY2ggbGVkIG1lIGhlcmUgdG8gdGhpcyANCnRocmVhZCBhbmQgbWF5
YmUgYWRkaW5nIG91ciBvYnNlcnZhdGlvbnMgaGVscHMgdG8gY2xhcmlmeSB0aGluZ3MgaGVyZSBh
IA0KYml0IChob3BlZnVsbHkpIG9yIGF0IGxlYXN0IGF1Z21lbnRzIHRoZSBpbmZvcm1hdGlvbiBy
ZWxhdGVkIHRvIGZpcm13YXJlIA0KVFBNIGJhc2VkIGltcGxlbWVudGF0aW9uIGJhc2VkIG9uIG1z
LXRwbS0yMC1yZWYuDQoNCkJhc2VkIG9uIHRoZSBvcHRlZV9mdHBtIHJlcG8sIGFzIEphbiBhbHJl
YWR5IGRlc2NyaWJlZCwgd2hpY2ggY3VycmVudGx5IA0KcmVmZXJlbmNlcyBjb21taXQgOThiNjBh
NDRhYmE3IG9mIFsxXSBzdWZmZXJzIHRoaXMgZXhhY3QgaXNzdWUgYmVjYXVzZSANCm9mIHRoZSBO
Vl9DTE9DS19VUERBVEVfSU5URVJWQUwgWzJdIHdoaWNoIGlzIHNldCB0byAiMTIiIGFuZCBpc3N1
ZXMgYSANCndyaXRlIGZvciBlYWNoIGNvbW1hbmQgYWZ0ZXIgfjQgc2Vjb25kcyBoYXZlIHBhc3Nl
ZC4NCg0KVGhpcyBjb25maWcgaGFzIGJlZW4gY2hhbmdlZCB0byAiMjIiIChvbiBjdXJyZW50IG1h
c3RlciBicmFuY2ggWzNdKSANCndoaWNoIGlzIHRoZSBhbGxvd2VkIG1heGltdW0gd2hlbiBmb2xs
b3dpbmcgdGhlIFRQTSBzcGVjIChjaGFwdGVyIDM2LjMuMiANCmluIFs0XSkgd2hpY2ggbGVhZHMg
dG8gcm91bmQgYWJvdXQgNzAgbWludXRlcywgYnV0IG9wdGVlX2Z0cG0gZGlkbid0IA0KbW92ZSBh
aGVhZCB0byB0aGlzIGNvbW1pdCwgeWV0Lg0KVGhpcyBjb25maWcgZXhpc3RzIGZvciBiZWluZyBh
YmxlIHRvIGFkYXB0IHRoZSB3cml0ZSBjeWNsZXMgdG8gdGhlIA0Kc3BlY2lmaWMgd2VhciBjb25k
aXRpb25zIG9mIHRoZSBoYXJkd2FyZS4NCg0KTW9yZW92ZXIgdGhlIG1zLXRwbS0yMC1yZWYgcmVw
byBzZWVtcyB0byBub3QgYmUgbWFpbnRhaW5lZCBhbnltb3JlIGFuZCANCm9uZSBzaG91bGQgcmF0
aGVyIHN3aXRjaCB0byBbNl0uDQoNClNvIHRoZXJlIGFyZSBjdXJyZW50bHkgZmlybXdhcmUgVFBN
IGltcGxlbWVudGF0aW9ucyBvdXQgdGhlcmUgdGhhdCBsZWFkIA0KdG8gdGhlc2UgZnJlcXVlbnQg
d3JpdGVzLg0KDQpBRkFJSyBzaW5jZSB0aGUgdHBtLTIwLXJlZiBpbXBsZW1lbnRhdGlvbiBiYXNp
Y2FsbHkgb25seSBzdXBwb3J0cyBhIGZpbGUgDQpvbiBkaXNrIG9yIFJBTSBiYWNraW5nIHN0b3Jh
Z2UsIHRoZSBvcHRlZV9mdHBtIHJlcG8gWzVdIHByb3ZpZGVzIGl0J3MgDQpvd24gX3BsYXRfTlYq
IGltcGxlbWVudGF0aW9ucyB0aGF0IHJlcGxhY2UgdGhlIGRlZmF1bHQgb25lcyBhbmQgZmluYWxs
eSANCmNhbGwgT1AtVEVFJ3MgVEVFXyogc2VjdXJlIHN0b3JhZ2UgQVBJLCB3aGljaCB0aGVuIHJv
dXRlcyB0byB3aGF0ZXZlciANCmJhY2tlbmQgT1AtVEVFIGlzIGNvbmZpZ3VyZWQgd2l0aCAoUkVF
LUZTIG9yIFJQTUIpIOKAkyBJbiBvdXIgY2FzZSB0aGUgUlBNQi4NCg0KQmVjYXVzZSB0aGVyZSBh
cmUgY3VycmVudGx5IGltcGxlbWVudGF0aW9ucyBvdXQgdGhlcmUgKGUuZy4gc3RhcnQgdXNpbmcg
DQpvcHRlZV9mdHBtKSBpdCBtYXkgbWFrZSBzZW5zZSB0byBhZGQgdGhpcyBpbmZvcm1hdGlvbiB0
byB0aGUga2VybmVsIA0KY29uZmlnJ3MgaGVscCB0ZXh0IGF0IGxlYXN0Pw0KDQpXZSBhcmUgY3Vy
cmVudGx5IHRyeWluZyB0byBidW1wIG9wdGVlX2Z0cG0gdG8gdXNlIHRoZSBtb3JlIHJlY2VudCB2
MS44NCwgDQpidXQgc2luY2Ugd2UncmUgbm8gVENHIG1lbWJlciB0aGUgUFJzIG9uIGdpdGh1YiBj
b3VsZCBnZXQgYSBiaXQgDQphZHZlbnR1cm91cyAoUFIncyBub3QgdXBzdHJlYW0sIHlldCkuDQpV
bnRpbCB0aGVuIHRoaXMgaXMgYSB2YWxpZCBpc3N1ZSB0aGF0IGV4aXN0cy4uLg0KDQoNClsyXSAN
Cmh0dHBzOi8vZ2l0aHViLmNvbS9taWNyb3NvZnQvbXMtdHBtLTIwLXJlZi9ibG9iLzk4YjYwYTQ0
YWJhNzliMTVmY2NlMWMwZDFlNDZjZjU5MTg0MDBmNmEvVFBNQ21kL3RwbS9pbmNsdWRlL1RwbVBy
b2ZpbGUuaCNMMTk5IA0KDQoNClszXSANCmh0dHBzOi8vZ2l0aHViLmNvbS9taWNyb3NvZnQvbXMt
dHBtLTIwLXJlZi9ibG9iLzk4YjYwYTQ0YWJhNzliMTVmY2NlMWMwZDFlNDZjZjU5MTg0MDBmNmEv
VFBNQ21kL3RwbS9pbmNsdWRlL1RwbVByb2ZpbGUuaCNMMjAwDQoNCls0XSANCmh0dHBzOi8vdHJ1
c3RlZGNvbXB1dGluZ2dyb3VwLm9yZy93cC1jb250ZW50L3VwbG9hZHMvVFBNLTIuMC0xLjgzLVBh
cnQtMS1BcmNoaXRlY3R1cmUucGRmDQoNCls1XSBodHRwczovL2dpdGh1Yi5jb20vT1AtVEVFL29w
dGVlX2Z0cG0NCg0KWzZdIGh0dHBzOi8vZ2l0aHViLmNvbS9UcnVzdGVkQ29tcHV0aW5nR3JvdXAv
VFBNDQoNCkJSLA0KQmVuZWRpa3QNCg0K

