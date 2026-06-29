Return-Path: <linux-integrity+bounces-9848-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Zt9NEIdiQmrU5wkAu9opvQ
	(envelope-from <linux-integrity+bounces-9848-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Jun 2026 14:18:15 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D656D9F43
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Jun 2026 14:18:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=polito.it header.s=selector1 header.b="JY/eCqCf";
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9848-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9848-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=polito.it;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B78283026C20
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Jun 2026 12:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A54F360EEA;
	Mon, 29 Jun 2026 12:11:22 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023111.outbound.protection.outlook.com [40.107.162.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE1E3BB4A
	for <linux-integrity@vger.kernel.org>; Mon, 29 Jun 2026 12:11:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782735082; cv=fail; b=T78JIJMI5WE51NNeY/Yn+nKoBb0EX3T13Q/+uc7bjnDF/god+VBhHxkOkU18SATlh3Vr/Y84vtcVS+Bq2hARPsnjkgaWa1SL6hKMjkmATjBSeXnpvV9sgeX61PBXXjyVYehZbumU+1pXvy7wb7Ywtind59E4C5w+NyGg5DnMtdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782735082; c=relaxed/simple;
	bh=Na2apAfldIDhlyeOECwqMhpu4wof+52NSYlL7ar7amw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J2giuBnFeCVdBz0qllMsZAZGMQV0dNM48OzIVcNt2pzDwe2Me8Pm7X6O+vWCwlxXgoMylaJrxDYXxm6qrTYF63opW0J9jROkzoBBX1Z6xZHzU5ZKXjoiuZ1iepcs1bjOefhuaz5gzao/faaBkcY/Wr8vc6s8lbny86b87TPjFPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=JY/eCqCf; arc=fail smtp.client-ip=40.107.162.111
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qANuxOD8zEi8Jaff0lqcJejImJJvtDR53KA5eyVIYMJ8lOPjHNNa+jyUXvtDaOSer7CQOUgjIUdUeXTqDN9zwJBE58JTBUwi7cxonYT4cED5TbMf0l/SRbJugf6QFFD/BxLKZYyC3ov6mVwlq1v+48wWePiSVx6HmUs76Nq15gqpj18gaA1xPlzpXztSmXLPWSwSg3yQ3V+b3jxHe11HnM/Wl9JxpjgIgP+zoviajkPViCGlYuxRCkWYzuSkvaVFEbHD5W12uXyK3Uf6ObZrFk+xhiNnCStY0Mel+a7Yf0s2eaAl2EzCfUd6R0ofoC0Upc6OfKsgyejHWxz5GvWROQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Na2apAfldIDhlyeOECwqMhpu4wof+52NSYlL7ar7amw=;
 b=rPcx45jCJ6kIRq9qUfa/aTJtsYCLnCLrXLUtjvsJXnU6z1wYk91IUJd/njPI59yrGLlfVKVv5CFvLoJprdi4F2RbaqgLPzTiJ+Q/EAVb1blZVE3pYWO+70F2rgPnT1cHPQVYR3eZx7kpqQzxsDS/9wHzXomyyWpNx3Ub1Hs61NLJWWTZ32R3ycXV7EMmIzWvW1+XBnrMJAsMB9UDyo4gvE/GoBl7RchZKpMVH+gLuplVEePQ8u/lDOMTClYb6a1/9uGPLCPkUEPArGb+MQLixOyW4AiWB1bvy7ryjvmDdGZ3iuPPTiIyysUhoRZmql5w+OcV+loZH/GHUBOVpyGvig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Na2apAfldIDhlyeOECwqMhpu4wof+52NSYlL7ar7amw=;
 b=JY/eCqCf8NfdB+Knf12vHJr3ezl/KH0S0TADezx4IG6AIMudRgeaHN269K7Uth0n5bvq7Twjv+ayFjF7SfNQcQQFt55lPnn1epiOPUA/iFgvyZYKEYxpYSuztH60cYaROz0ka/Rtj2D/a3uHUSUD6c6RklEcteYzx3VZ3cLeWvI=
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com (2603:10a6:20b:253::20)
 by AS8PR05MB8104.eurprd05.prod.outlook.com (2603:10a6:20b:33e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 12:11:16 +0000
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64]) by AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64%5]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 12:11:15 +0000
From: "Enrico  Bravi" <enrico.bravi@polito.it>
To: "roberto.sassu@huawei.com" <roberto.sassu@huawei.com>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"roberto.sassu@huaweicloud.com" <roberto.sassu@huaweicloud.com>,
	"zohar@linux.ibm.com" <zohar@linux.ibm.com>, "dmitry.kasatkin@gmail.com"
	<dmitry.kasatkin@gmail.com>
CC: "eric.snowberg@oracle.com" <eric.snowberg@oracle.com>
Subject: Re: [PATCH] ima: correctly recover number of violations after kexec
Thread-Topic: [PATCH] ima: correctly recover number of violations after kexec
Thread-Index: AQHdACBXEkKdWehZFUSS24iqdgk0ALZPR52AgAY45oA=
Date: Mon, 29 Jun 2026 12:11:15 +0000
Message-ID: <28db33177bcd021da5c907a7941ae93f87e91633.camel@polito.it>
References: <20260619191452.7179-1-enrico.bravi@polito.it>
	 <8f9626a5cc4c03e57d63d290ce151caeda9293e6.camel@huaweicloud.com>
In-Reply-To: <8f9626a5cc4c03e57d63d290ce151caeda9293e6.camel@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR05MB7880:EE_|AS8PR05MB8104:EE_
x-ms-office365-filtering-correlation-id: 5027e6d2-dd20-4353-33ea-08ded5d784fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|786006|23010399003|376014|1800799024|18002099003|22082099003|38070700021|4143699003|11063799006|56012099006|3023799007;
x-microsoft-antispam-message-info:
 9LgkiqFB6RlpYLfADmPCk2tnWfVd+gj3o2qqhLUfyS6Bw2DtI4Ytpuag1DNyOWv47Qy1YmR70XNqKZctx7HRxNGUW3wdo0gw+8Stjw5hI9nYl2WmZi/rP9Nhcfe2xXJVD0ecJEvg7gpFNAlG59g3xkRdY3boFW5P6vG2+Bh4gGrfO8wBgQWBJgn/UXaWYQ1tf3Jhp/PWtJprsuW1xNN7IrdjzIrKhKsGogBAYoyqc34WpW6csSiRSZJPD8w/Xpinl7QVCKKsRCj0sshJMdtnXoHNmeBXvWgjOC4jdCYV1QYtYpXHt9gsdQCHLXGD8tsKhaAYSv3O15QM68S760e3pLm1urCcSER8IzMRDEiU7sm4GdI+KOWSL8HS8GcjDBowYjkks4Dz+2HVukdy2V38I07VhCAaGzrAxo61jD2nu1abP1DAgfof8AU2rCqJ/bOTeLJ0naRgg7DbbKIf9U340SIHfk5kkBSI3ftwY1uM7WKPGet657QlXSByp6oyNAeZjbkGO89FSRQ8+kzaOaEEzVXMKp8DVMo3XzVzj3W8+mrSnYJysqQ22ECeJkrqRY/1+Kz6UuvLdeiseGB5fktaK8v+m/xnTHkNgnVZgC/pBKGFGvT4zkaB1r2sef3LawaesfXlZUsdBQPNreq8WMpU2g4ozZ6UvE9WL+JquHir/ZVRwlTDeP9sYWOWHRYBBcZX34P7QWzMeBncp05MBT0dfFeOB+Ea8atDeEohLpHjV4M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR05MB7880.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(786006)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(4143699003)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TmI4SEpxVWFpUTY0Q3QxVjRwN2dobmFlSzkrTmZUNklyQlJrOFpTUkRLMlRL?=
 =?utf-8?B?WDB3aTJIRnQyUy9BZGp2RFdlSGJaODB5cE5LUytXY1h5cnpXaGxvNDdhTzNM?=
 =?utf-8?B?bXdmWnBCdHhsdENDb2JYR2FqUHBqYnd0RVk4VDVQLzJ6UHpZSGpiT3prNWNo?=
 =?utf-8?B?U2N0SERYRGNLUU53UTVSemFHaWFsbEZFeGdDWHRHUmNiQzJ2QTMzYnp2ZkZY?=
 =?utf-8?B?VVZpRFlId2JkdXYwNWNpRUY4bzdGNEk0bVNmQ1V3dzlBU3JpclVsb21ENklK?=
 =?utf-8?B?RGpXYjlldmFzZGR3S3NCbk9HRmVydFJ4dTFqQmt6TGRQMmJ0UU5HT2pNYjNW?=
 =?utf-8?B?YXN5TUJua2lEc2lscFZNT0pZVUd2Y0Q5aVZ1ditzK1lSMklFWmRvR282KzZM?=
 =?utf-8?B?SGs1M3ZXKzlvN0w4bEIvRGlIQTF5TnBheG93RmxORkwzRHFiZVNlWGdCNkZw?=
 =?utf-8?B?WHZXYmgwYmhNQVo2K1l6ZzlEdjJ5UUhSVUFDSHkxeWphbGdIRWFER1Rlbkg3?=
 =?utf-8?B?ZkpORjc2N1FidndlVWFJQkVqQlVaaUZUU0VvSmZxcEwxVk9lY3ZBOThoaG04?=
 =?utf-8?B?d0kzTWx0c3RQOUpOdURxdmxhaXB1b1ZUNy80M3RrZVZQUllQNkRLem16UGZF?=
 =?utf-8?B?aDhWU0dIWkNZTVE4QVREV2tDazJBOUg0NURIbFRMeXg3WFY1T3FvcnJXS2JI?=
 =?utf-8?B?UGNWbENIWHlyUXdkZEdhOVFrYU5VSmEzelJ3ZCtyR0loeXNjWjIzZ2w5am5v?=
 =?utf-8?B?UDk4THR4RG0yQ21lM0p0YUZqVnp4YnFkTWE5aHowK2pSQ09VVGUydHNzTmsw?=
 =?utf-8?B?NFQ0NzJKbFdjbUVDekFQMENpZFo4QUdGV1laU3EvMWpsdWNDZ1BESzRNSkxa?=
 =?utf-8?B?bTFaUzBaOFFYVHNwajA1L0dQdlhtLzRYaWEwdFJvVElicGxBZzFjZG1sTlZi?=
 =?utf-8?B?Vml6WmhsOFdacmFkRXBxRDl4VTU4SlVPbnR5VHBxK3htZHpEUGJybFFMby9T?=
 =?utf-8?B?ck5wZDZEMGRQcnVnTWFDSXI3d0dnYlMzZWtDNlozU0g2WjQ2Sk1xMjJmOHNx?=
 =?utf-8?B?UkJOU0JBZnAzUE1mVmVLWlRiUllBb24wYnJnSk04Q1haWXBFa2VycWVZY3RJ?=
 =?utf-8?B?ZUgwclhkYUdBYS9WV1FPa1NBNXlvbGp2WGd1UEJrbDFHRzN0MTBtaFdaMWVE?=
 =?utf-8?B?ZTJZUG5sWEc4a3puNEliaDFFQ3RWWXB5WE5WRnIreVd3SlRrbGJOZ3JJb21i?=
 =?utf-8?B?MVJiYlE1aHVBZ1d3Z09CL3pmY3hxRWlmTGN6dEZQU1loWTl4VVRucGk5UW12?=
 =?utf-8?B?b1BBZGxNWi9hbVZXRFVDS2R2RGhUWGtqWXIramM0NmZxZFpvNFVBbEwzb1du?=
 =?utf-8?B?ZFNvMmt5VCtKQ2hCcGVpZVNIUlhncjU5WFZ5amkzaXBvUlVuRjRwS1Q0L2lY?=
 =?utf-8?B?MHRJT3AwODBQaWdZMU1zbWtGM0t3aXpUaU9HSEdRNzJYckNNaGVxeXlnSldn?=
 =?utf-8?B?VzY1UmhqRHBOTGJiTVNqSHB4ZXllS20zVW5xWEpLWFBRR0tURVIzVHZHVEIx?=
 =?utf-8?B?YmFCVy9FanFsRHo1aDZBRko2VytaZDNwWWZhdzk4amp2bHJ1c0xYaHdnY2tB?=
 =?utf-8?B?dXhFZEl1WnVqRXpBUGk0R0NIV3RMYXNKbCtIbHRSZ2dXSzlPUHNXQ2ZhU0hI?=
 =?utf-8?B?TG5UakF5c0RiWXlRWXNtcXdKUHMwejk3NUJSbm1TK05MQVBTZUNFaEdBM1kz?=
 =?utf-8?B?OXhNOHQ4QlRkVmxwZU9lMlY4Q1pZUGRaZlNiclhEc3RpQXcyRUhzczNuV3dE?=
 =?utf-8?B?NVJ2QllnQzFuZ0YzSFBPdUFlUWJDM1hnMmE2Y0VJcmkyRHBtNGlQbm1ocGdB?=
 =?utf-8?B?ang1T2wvNUMzRGFJd1BFMG5Ob2s3dVRDT0trNHh4ZWJ1aDNzWDM4TnZOblMr?=
 =?utf-8?B?Nk1WMnJMN2Raazdpa3RyNU1uOHJlTkRpZ0g0YVhYRUNXR21HNmQxN2VURVdy?=
 =?utf-8?B?UXVNQk5XZCtWeTJQVFN2VlZWdzZFaGdFdDFQRHlQQUh0NGpIQ1R5cUVJMlRy?=
 =?utf-8?B?QitEeG1TbzNLZWkrU250Q2w2S2RMUmMyWnlGbDE4YTlVbDNocytQOTJJY0xy?=
 =?utf-8?B?VytSbzkyS3E2REE4Wmc5ZkIxMWNmZ2ZoVUQ2SUxxbnBtRzZMbGt1MmxUaGw2?=
 =?utf-8?B?MjFMV1FSUTJaejZYbUxvNlFqbnRMZWFkYmhGYVVoMTJFWE96cCs5K0JEczJy?=
 =?utf-8?B?YXVGNzBZOEJJTzA3YzRXalRCZlZJWDAyWmc5VHk4K2RMUzQ1MXB2MzM3MFJj?=
 =?utf-8?B?NldBdlBnZitGQThxTEROSmxHUmZZT05yaXpSbUxhR2VEZDRSYWlET2ZRMmkx?=
 =?utf-8?Q?Gwto3b4zh5OrjbKg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D588EB2CD26E04CAA810804A6E65512@eurprd05.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5027e6d2-dd20-4353-33ea-08ded5d784fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 12:11:15.8532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: coeAh05puoHYtntMRBdbufKEWprR0lTl83NBb3nnw3ZV/VFSBhjly4n8LWDdNUzJqTjeLHlrIuY5f8INjCJVHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR05MB8104
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
	TAGGED_FROM(0.00)[bounces-9848-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,huawei.com:email,polito.it:dkim,polito.it:email,polito.it:mid,polito.it:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 81D656D9F43

SGkgUm9iZXJ0bywNCg0KT24gVGh1LCAyMDI2LTA2LTI1IGF0IDE1OjEwICswMjAwLCBSb2JlcnRv
IFNhc3N1IHdyb3RlOg0KPiBPbiBGcmksIDIwMjYtMDYtMTkgYXQgMjE6MTQgKzAyMDAsIEVucmlj
byBCcmF2aSB3cm90ZToNCj4gPiBXaGVuIHJlY292ZXJpbmcgdGhlIG1lYXN1cmVtZW50IGxpc3Qg
YWZ0ZXIga2V4ZWMoKSwgdGhlIG51bWJlciBvZg0KPiA+IHZpb2xhdGlvbnMgaXMgbm90IHJlY292
ZXJlZCBhcyB3ZWxsLCBjYXVzaW5nIGEgbWlzbWF0Y2ggYmV0d2VlbiB0aGUNCj4gPiBudW1iZXIg
cmVwb3J0ZWQgYnkgdGhlIDxzZWN1cml0eWZzPi9pbWEvdmlvbGF0aW9ucyB1c2VyIGludGVyZmFj
ZSBhbmQNCj4gPiB0aGUgYWN0dWFsIHZhbHVlLiBJbiBhZGRpdGlvbiwgY3VycmVudGx5IGl0IGlz
IGFzc3VtZWQgdGhhdCB3aGVuDQo+ID4gcmVjb3ZlcmluZyBhbiBlbnRyeSwgdGhpcyBpcyBhIHZp
b2xhdGlvbiBpZiB0aGUgdGVtcGxhdGUgZGF0YSBoYXNoDQo+ID4gcmVhZCBmcm9tIHRoZSBrZXhl
YyBidWZmZXIgaXMgYW4gYWxsLXplcm8gaGFzaCwgd2hpY2ggY2FuIGFjdHVhbGx5IGJlIGENCj4g
PiB2YWxpZCBoYXNoLg0KPiANCj4gVGhpcyBzZW50ZW5jZSBpcyBhIGJpdCBjb252b2x1dGVkLiBQ
bGVhc2UgcmV3b3JrIGl0Lg0KPiANCj4gPiBWZXJpZnkgdGhhdCBhbiBhbGwtemVybyBoYXNoIGNv
cnJlc3BvbmRzIHRvIGEgdmlvbGF0aW9uIGFuZCBjb25zZXF1ZW50bHkNCj4gPiBjb3JyZWN0bHkg
cmVjb3ZlciB0aGUgbnVtYmVyIG9mIHZpb2xhdGlvbnMuDQo+IA0KPiBXZSBuZWVkIHRvIGNsYXJp
ZnkgdGhhdCB0aGlzIHBhdGNoIG9ubHkgZml4ZXMgZmFsc2UgcG9zaXRpdmVzIChhIHJlY29yZA0K
PiBpcyBkZWNsYXJlZCBhcyBhIHZpb2xhdGlvbiBldmVuIGlmIGl0IGlzbid0LCBhbmQgd2UgZml4
IGl0IGJ5IGNyb3NzLQ0KPiBjaGVja2luZyB0aGUgU0hBMSBvZiB0aGUgdGVtcGxhdGUgZGF0YSku
DQo+IA0KPiBIb3dldmVyLCB3ZSBhcmUgbm90IGZpeGluZyB0aGUgZmFsc2UgbmVnYXRpdmVzIChp
ZiB0aGUgU0hBMSBvZiB0aGUNCj4gdGVtcGxhdGUgZGF0YSBpcyB6ZXJvcywgd2UgZG9uJ3QgZGVj
bGFyZSBpdCBhcyBhIHZpb2xhdGlvbiwgYnV0IGl0IGNhbg0KPiBwb3RlbnRpYWxseSBiZSkuDQoN
CnRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHlvdXIgZmVlZGJhY2suIEknbGwgcmV3b3JrIHRoZSBw
YXRjaCBkZXNjcmlwdGlvbiB0byBtYWtlDQppdCBtb3JlIGNsZWFyIGFuZCBkZXNjcmliZSB3aGF0
IHlvdSBoaWdobGlnaHRlZC4NCg0KPiA+IFJlcG9ydGVkLWJ5OiBSb2JlcnRvIFNhc3N1IDxyb2Jl
cnRvLnNhc3N1QGh1YXdlaS5jb20+DQo+ID4gQ2xvc2VzOiBodHRwczovL2dpdGh1Yi5jb20vbGlu
dXgtaW50ZWdyaXR5L2xpbnV4L2lzc3Vlcy8xMw0KPiA+IFNpZ25lZC1vZmYtYnk6IEVucmljbyBC
cmF2aSA8ZW5yaWNvLmJyYXZpQHBvbGl0by5pdD4NCj4gPiANCj4gPiAtLS0NCj4gPiDCoHNlY3Vy
aXR5L2ludGVncml0eS9pbWEvaW1hX3RlbXBsYXRlLmMgfCAyOCArKysrKysrKysrKysrKysrKysr
Ky0tLS0tLS0NCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCA3IGRlbGV0
aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2lt
YV90ZW1wbGF0ZS5jDQo+ID4gYi9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV90ZW1wbGF0ZS5j
DQo+ID4gaW5kZXggNzAzNDU3M2ZiNDFlLi4xNDdmMjI4ZWQyNDYgMTAwNjQ0DQo+ID4gLS0tIGEv
c2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfdGVtcGxhdGUuYw0KPiA+ICsrKyBiL3NlY3VyaXR5
L2ludGVncml0eS9pbWEvaW1hX3RlbXBsYXRlLmMNCj4gPiBAQCAtNDMwLDYgKzQzMCw3IEBAIGlu
dCBpbWFfcmVzdG9yZV9tZWFzdXJlbWVudF9saXN0KGxvZmZfdCBzaXplLCB2b2lkICpidWYpDQo+
ID4gwqAJREVDTEFSRV9CSVRNQVAoaGRyX21hc2ssIEhEUl9fTEFTVCk7DQo+ID4gwqAJdW5zaWdu
ZWQgbG9uZyBjb3VudCA9IDA7DQo+ID4gwqAJaW50IHJldCA9IDA7DQo+ID4gKwlpbnQgaTsNCj4g
PiDCoA0KPiA+IMKgCWlmICghYnVmIHx8IHNpemUgPCBzaXplb2YoKmtoZHIpKQ0KPiA+IMKgCQly
ZXR1cm4gMDsNCj4gPiBAQCAtNTE1LDE1ICs1MTYsMjggQEAgaW50IGltYV9yZXN0b3JlX21lYXN1
cmVtZW50X2xpc3QobG9mZl90IHNpemUsIHZvaWQNCj4gPiAqYnVmKQ0KPiA+IMKgCQlpZiAocmV0
IDwgMCkNCj4gPiDCoAkJCWJyZWFrOw0KPiA+IMKgDQo+ID4gLQkJaWYgKG1lbWNtcChoZHJbSERS
X0RJR0VTVF0uZGF0YSwgemVybywgc2l6ZW9mKHplcm8pKSkgew0KPiA+IC0JCQlyZXQgPSBpbWFf
Y2FsY19maWVsZF9hcnJheV9oYXNoKA0KPiA+IC0JCQkJCQkmZW50cnktPnRlbXBsYXRlX2RhdGFb
MF0sDQo+ID4gKwkJcmV0ID0gaW1hX2NhbGNfZmllbGRfYXJyYXlfaGFzaCgmZW50cnktPnRlbXBs
YXRlX2RhdGFbMF0sDQo+ID4gwqAJCQkJCQllbnRyeSk7DQo+ID4gLQkJCWlmIChyZXQgPCAwKSB7
DQo+ID4gLQkJCQlwcl9lcnIoImNhbm5vdCBjYWxjdWxhdGUgdGVtcGxhdGUNCj4gPiBkaWdlc3Rc
biIpOw0KPiA+IC0JCQkJcmV0ID0gLUVJTlZBTDsNCj4gPiAtCQkJCWJyZWFrOw0KPiA+ICsJCWlm
IChyZXQgPCAwKSB7DQo+ID4gKwkJCXByX2VycigiY2Fubm90IGNhbGN1bGF0ZSB0ZW1wbGF0ZSBk
aWdlc3RcbiIpOw0KPiA+ICsJCQlyZXQgPSAtRUlOVkFMOw0KPiA+ICsJCQlicmVhazsNCj4gPiAr
CQl9DQo+ID4gKw0KPiA+ICsJCWlmICghbWVtY21wKGhkcltIRFJfRElHRVNUXS5kYXRhLCB6ZXJv
LCBzaXplb2YoemVybykpICYmDQo+ID4gKwkJwqDCoMKgIG1lbWNtcChlbnRyeS0+ZGlnZXN0c1tp
bWFfc2hhMV9pZHhdLmRpZ2VzdCwgemVybywNCj4gPiBzaXplb2YoemVybykpKSB7DQo+IA0KPiBI
ZXJlIGl0IHdvdWxkIGJlIGhlbHBmdWwgdG8gaGF2ZSBhIGNvbW1lbnQgc2F5aW5nIHRoYXQgd2Ug
YXJlIHJldmVydGluZw0KPiB0aGUgZWZmZWN0IG9mIGltYV9jYWxjX2ZpZWxkX2FycmF5X2hhc2go
KTogd2UgdHJpZWQgdG8gdmVyaWZ5IGlmIHRoZQ0KPiBlbnRyeSBpcyBhIHZpb2xhdGlvbiwgaXQg
aXMsIGJ1dCB0aGVuIHdlIGhhdmUgdG8gc2V0IHRoZSB0ZW1wbGF0ZQ0KPiBkaWdlc3QgYmFjayB0
byB6ZXJvIGFmdGVyIHRoZSBjYWxjdWxhdGlvbi4NCg0KU3VyZSwgd2lsbCBhZGQgaXQgaW4gdGhl
IG5leHQgdmVyc2lvbi4NCg0KPiA+ICsJCQlmb3IgKGkgPSAwOyBpIDwgTlJfQkFOS1MoaW1hX3Rw
bV9jaGlwKSArDQo+ID4gaW1hX2V4dHJhX3Nsb3RzOyBpKyspIHsNCj4gPiArCQkJCS8qIFVubWFw
cGVkIFRQTSBhbGdvcml0aG1zICovDQo+ID4gKwkJCQlpZiAoIWltYV9hbGdvX2FycmF5W2ldLnRm
bSkgew0KPiA+ICsJCQkJCW1lbXNldChlbnRyeS0+ZGlnZXN0c1tpXS5kaWdlc3QsIDAsDQo+ID4g
KwkJCQkJwqDCoMKgwqDCoMKgIFRQTV9ESUdFU1RfU0laRSk7DQo+ID4gKwkJCQkJY29udGludWU7
DQo+ID4gKwkJCQl9DQo+ID4gKw0KPiA+ICsJCQkJbWVtc2V0KGVudHJ5LT5kaWdlc3RzW2ldLmRp
Z2VzdCwgMCwNCj4gPiArCQkJCcKgwqDCoMKgwqDCoCBpbWFfYWxnb19hcnJheVtpXS5kaWdlc3Rf
c2l6ZSk7DQo+IA0KPiBNYXliZSB3ZSBjYW4ganVzdCB1c2UgdGhlIGluc3RydWN0aW9uIGFib3Zl
IGluc3RlYWQgb2YgZGlmZmVyZW50aWF0aW5nDQo+IGZvciB1bm1hcHBlZCBhbGdvcml0aG1zPyBk
aWdlc3Rfc2l6ZSBpcyB0YWtlbiBmcm9tIHRoZSBUUE0gaW4gdGhhdA0KPiBjYXNlLg0KDQpZZXMg
eW91J3JlIHJpZ2h0LiBJdCBzaG91bGQgbm90IGJlIG5lY2Vzc2FyeSB0byB0cmVhdCB1bm1hcHBl
ZCBhbGdvcml0aG1zDQpkaWZmZXJlbnRseS4gSSB3YXMgdGhpbmtpbmcgdGhhdCBpdCBjb3VsZCBi
ZSBkaXJlY3RseSB1c2VkIFRQTTJfTUFYX0RJR0VTVF9TSVpFDQppbnN0ZWFkLiBXaGF0IGRvIHlv
dSB0aGluaz8NCg0KRW5yaWNvDQoNCj4gVGhhbmtzDQo+IA0KPiBSb2JlcnRvDQo+IA0KPiA+IMKg
CQkJfQ0KPiA+ICsJCQlhdG9taWNfbG9uZ19pbmMoJmltYV9odGFibGUudmlvbGF0aW9ucyk7DQo+
ID4gwqAJCX0NCj4gPiDCoA0KPiA+IMKgCQllbnRyeS0+cGNyID0gIWltYV9jYW5vbmljYWxfZm10
ID8gKih1MzINCj4gPiAqKShoZHJbSERSX1BDUl0uZGF0YSkgOg0KPiA+IA0KPiA+IGJhc2UtY29t
bWl0OiA4Y2Q5NTIwZDM1YTZjMzhkYjY1NjdlOTdkZDkzYjFmMTFmMTg1ZGM2DQo=

