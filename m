Return-Path: <linux-integrity+bounces-9906-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zXyaAV3QUGqt5QIAu9opvQ
	(envelope-from <linux-integrity+bounces-9906-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jul 2026 12:58:37 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9A6739E89
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jul 2026 12:58:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=vivo.com header.s=selector2 header.b=nFrqmHsY;
	dmarc=pass (policy=quarantine) header.from=vivo.com;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9906-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9906-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C671302FB5B
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jul 2026 10:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC988411670;
	Fri, 10 Jul 2026 10:53:54 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013036.outbound.protection.outlook.com [52.101.127.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750EC411662;
	Fri, 10 Jul 2026 10:53:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783680834; cv=fail; b=HiUhGMI1Hmx7hXa2NuUySYZltPjsnTghH9g9BT4mtIM7oqSKGhnFAcVOR/vCWhhtndE9+/88Zwl2NGPC1L43D0VSk3WaJdPEYuu1U3KVJ3HoXuWIfTI5yFQ8ER5rbcrN652DyKeknPH3fyCxvjf1uhprgJj7GSE/ftzO7UfiL2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783680834; c=relaxed/simple;
	bh=6rIgodERjOnxji0VxDYkzvPsdoEcfjDOqQr+rk3Gc7k=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Ceo8zcO3GbO0eOIGVi9bnLUAbMQ7uYdPGUWPS6zav1umaZ6yizzO7uzZQ5PQrjNTUMhMh5yZssIJtIW/satqWqjt+zHfRY1k7zPc6fliTcegU2ULV1Q9VUwluo/go/unWwTw2qAh/wCCnm8leVp8JmWrmfrHiV+se4g0nTsq9bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=nFrqmHsY; arc=fail smtp.client-ip=52.101.127.36
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RUyOlhSuFJNDyGGt070vfDY+iD6cmVfqa5Oz2RlaSJ1fXmQS6Ylkd3Oi7E4XDeb1W7Yf4h6HqKRVgx4s8P/IqxWSSHeKiCYiSofkYxbRMtwv3a8crkX7Vlwm5E+Ai59p20DKW+GzUYCS9MsEBH+iDNE5yPn3k1QXpuvhbDH6O4KAJNp1nHFOPtN36YvX/1Z5WIcYYjnGJltNXWlLjFYejIMImf7nB2QnzLOx/k5TpTc9MB/cpELyT5soxM44iouZFgL02yk61L33R1V0LKV5aTKqSquBzDEc8hAc3sJNYtqr45xmVht8VfwPDC/ODYr/VflKNYR+QU1v40P8U+AY9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtUIIIkUEO0/7dcww6thEuMNyIG/zSJjR9J9+Tn2ARY=;
 b=uU2z2OkKHdTfm3zlMGH0Ax+bLA7zkx3NTcPQyMDgmcv9DK0aI02MOquJw1mvLYD27P3AhszP7lGY7jivbgkY6IOh7ugz+bsf8cZehTRzYIF0E9cZGz5+Jp691kfkVF1Zuaz9AsI+KZzFMXxzCmLW0AU5V/uzAtJfmJ+bBZKSfJxQ/c68RFK441EJb3p8+rzoak/dexEjq1wJ/Vrsgn2o4DEL/mGw8QIRvOlCUkEL3YAXTDMWJMtdlWEZtpM+uAXwiDL91/8WWjVSOMnds2HqJdseU9qPYN6yMJFrsRs5/PaiICvCJwJS9X0prdZTKnYb3SatHV6qJHUJHKYA5PXOGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtUIIIkUEO0/7dcww6thEuMNyIG/zSJjR9J9+Tn2ARY=;
 b=nFrqmHsY7W1d2qa3s2z8tBfqHeyhxkuyD4uNAgM2EZK6TRFD6hVnDn6yAD8NFguLGMrLKGM9NLlYNmOGtR5yxaziR/EEAT2t9AqFX6tXRRV8Gd3lHS55CMwe65gSn3ecUtrCQ8ORn4UMdNat2k5XF/0i5evtmdYdmdATqP09boAcCJ9O6dnIfkcGIUOU9itKfTrlggPvxEgZ+GoJfIWMCkxc6rGDGJQzjdicK9OdNEbIsVT2vb6ZtmVcrBrBzU37a5Uvw7X2GM1ZGtOt3PBzJLwawnmx38Z6pQcydVTeRCgfriO26GBLbkT0o79lb/FJHjNWDORg455NKx3suxtTXg==
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SG2PR06MB5264.apcprd06.prod.outlook.com (2603:1096:4:1dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 10:53:45 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 10:53:45 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Hadar Gat <hadar.gat@arm.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jia Jie Ho <jiajie.ho@starfivetech.com>,
	Deepak Saxena <dsaxena@plexity.net>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Eli Billauer <eli.billauer@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Pan Chuang <panchuang@vivo.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Alper Ak <alperyasinak1@gmail.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-crypto@vger.kernel.org (open list:HARDWARE RANDOM NUMBER GENERATOR CORE),
	linux-kernel@vger.kernel.org (open list),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-integrity@vger.kernel.org (open list:TPM DEVICE DRIVER)
Subject: [PATCH 0/3] char: Remove redundant error messages on IRQ request failure
Date: Fri, 10 Jul 2026 18:53:05 +0800
Message-Id: <20260710105318.376496-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0021.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::12) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SG2PR06MB5264:EE_
X-MS-Office365-Filtering-Correlation-Id: 3452e3ee-cc03-4b57-ebe6-08dede718329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|52116014|1800799024|7416014|376014|921020|38350700014|11063799006|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	BDvtLmdyweEICNaNtp/VZt931HWUHSSw+omgv8/tlFmGosQM6puiloiCKzUC0jd64nxortTEFk5sDXX7m1LB6L1oIeC69RF3MqapesnMHrNXqU0sAzCgnaakPQ1N7OubgRVQaN2I1nYol15wl180b4cns6Dwr1zx45Tvt1/0LVjILdY/zRrVbQKElTihK75fvCF0TisDfYAT9FC2M98XIYzv2yEAcCL9bFbvdVSXZ/fzbp6Mvt7oHzQXgIU9wbX6qKTnVsaYRN/uADHgXwLpG7yusYyLSdIgntsMLcH3Khfp8QLEbTTQEZFVfn7YjKpruZG8NYg0mFjXctmq18xsSZdsjPTLTy8xnd/V2L230TEjWZ+9keY2F+h8BPzIAv2LqDV0XHDKAz/qo9V9XMETvahh6LayWze/HRtMAfk7/74mSOjAgXdkymVN0F3nOW2zKTwXJUbvJzG7vbTpojBjFUIq50CcOMnRnOCrAxSMsg82Nel3YXVZAZbdafIBqc918To87pjsN2FKsxsdcVKz31IxtMczLLZlan0azDYdC9o8ulh75w7lfJIK861u8q1ZGzPReqOaX1p8jzMz0VOLmG4GckCxgLBPJhGE9eMYBTq0CUsVyk3xD78aJDzEgBaCuceuPYXKbFcjFXFZ4e7wqKOYm0+F5nbZ3T0iHy8AiuFXHaAitoAdPD6tB1/IxOlfaiUHSeKvqgLBtTn6gElhPt1WF0BSGzcQIIS+MiPXRedsu6gWm2RqPi8MnIM5RyoL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(52116014)(1800799024)(7416014)(376014)(921020)(38350700014)(11063799006)(56012099006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FmPnunQaMiOvoX40x7ILvl+sH7VNlu7Ud0uihMPliw0dBakxlKKzf4b2lUBM?=
 =?us-ascii?Q?tkcHsBZlEIPrMD75pksuQnUUwXkRSS8mQ6FyOFxIg20yqE28FwytzGRL3dmt?=
 =?us-ascii?Q?jKVVO/Kev3FfCOoCe4vFSTOKkLyiuCWreu3I1NZr1xMOcD5vw/kfKUh6xulU?=
 =?us-ascii?Q?cchrJqKC/0IVLx1CdM60sW+uUDHTGdHapgBTWNqBtBwaM716ozeQxdeOk9F+?=
 =?us-ascii?Q?4eDxYTM2Xy+HC27TSx+86s4Pivh227FJ5IuFfHWrcU2iuIjYaDtLzpHTKokq?=
 =?us-ascii?Q?s3acUUgOBq/dFCIwLBVwOxQYvcIVsEvEkDyXCLKsUtAnEUAeq7IoGCvuVAeA?=
 =?us-ascii?Q?CDWAVoiQxVCoxJFKuepsG+LPCBaVazD7nM5a5FXpG/BmX+F6yoyF3nw9Ntfl?=
 =?us-ascii?Q?uN2/CSMpnBZYm188yKMjSmReLnXu4yzsX7Vch6+XsIT+5HUTehzhHb9Bxq8c?=
 =?us-ascii?Q?U5oNTpczGEV0bNnL2IyH8chX5PvrC+cvUAMfLB8lXhnJP29/sNwU/30le3Gr?=
 =?us-ascii?Q?GaTfAgrPfDbVwOgarmG8B7ysuF+1CGauTSsQsI3bKPY79Ayc22MSWsoDR0KS?=
 =?us-ascii?Q?H3pW6NqVgZUIpxxtSL0fOLLDqKACshqTmopI1AMp0k4RZhYcSH4oxf2WLeuq?=
 =?us-ascii?Q?sqR4egf078XvE6I1Ibctb084R4Y9tX8O/m/4TnPHgqmDMw6Q4/OKUCmtsHli?=
 =?us-ascii?Q?O8WKsB936ufmYc2ExfTuoSb2lm7BvnrNLNfjrJbmDdQksdoKVMsGRPphatd/?=
 =?us-ascii?Q?mYrnJPbhMjMzpUMhnGO3iETUFBWDPiEe3she2Ufu19ecA59x0sVeBOdBPBxw?=
 =?us-ascii?Q?lBrsjVPFbYi/EsCeKKJMvurJ/dAk32ov+YQ+18U7UEvVMXv4vCjOwkh6SyYq?=
 =?us-ascii?Q?9xUc1uk7+S5ngRXoKFqqwKA688jHiIuHKiytzAM6NzVy63Uh5Z/j5h6zKkF7?=
 =?us-ascii?Q?eFi8rgFz+xtz99OqghDwVifUdVxp6staXIvfNm7s+wZeX6DaTbJ/ZGY+NKyf?=
 =?us-ascii?Q?gsTn8usukYIf1YWbXdUCUd3RPdyY1zi07VPkO82S6pDAh2Bf77/NchFJg5Sx?=
 =?us-ascii?Q?oH+EORbbbra4zOnF2jNH5b2QUN+anxtp8gX1LYy8Fpe02tEeZL2T6qrqikDY?=
 =?us-ascii?Q?bSXbUosFTiJlssLjPYbJU4Jn9je0V2Bc12b8+dLI1677fzSo/+mkZY1xggX4?=
 =?us-ascii?Q?c/kfdKYVt12ffathaW28sZSqrCjRq2ihkfXgi6gtkFn5iU9h47UzoC/KNvIV?=
 =?us-ascii?Q?RPFM4KdAx+IqRbhR8s1Lf4e7r3Hni6/9PRC5r4LJb+rrGABFrYzXCh0ERcSr?=
 =?us-ascii?Q?V8tP9YSCfzlZnHN6G6LQUOPZ71EFXP/S7iFWfoiBJrkV+B5evArnDZn+Hwvk?=
 =?us-ascii?Q?0uJxT+0HKtOVcbWF1Vp6nRDsN407pZILk4grNHTL2ruu9wUOwQq0JWwaA4Cj?=
 =?us-ascii?Q?efunN5nl1OHpC+NX5zq303dcPzD67uElewNjDt1aAiVV6ZacIQ0+fCR0H0PM?=
 =?us-ascii?Q?ATh6OqkBgeJHnwpbsDsEzNlLksNflMlmbLb5Z5NKneAzyTPSMTaSPPZUeKHm?=
 =?us-ascii?Q?PN4ZdABiI8j7CxsM8ZCQCqqOluj6F3pjtQGoAEkeUpm9K6kxzAAVUNp6nT5T?=
 =?us-ascii?Q?2e07YYmpsQfAiNp3116TdQEMskH0CJ1KQ7pEmrh3QUWXcCm/j85UTojkjYiN?=
 =?us-ascii?Q?hGlkeM9l78EjA8/CMBPtGPmxuJNl62TknXYWOCGjDQfFOnvLlQEORvgeGP65?=
 =?us-ascii?Q?VabZxQq5pg=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3452e3ee-cc03-4b57-ebe6-08dede718329
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 10:53:44.9211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N/2Df5X4Glvj08aPNPQvpJe/yXe3nbAZuR9+rkTkaSrP1N1Aaxs+6SGvJk1q/BdJmHnEQrrAl8eKUf/GLILBqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5264
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[vivo.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[vivo.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9906-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_TO(0.00)[selenic.com,gondor.apana.org.au,arm.com,nxp.com,pengutronix.de,gmail.com,starfivetech.com,plexity.net,gmx.de,kernel.org,ziepe.ca,arndb.de,linuxfoundation.org,wp.pl,sakamocchi.jp,google.com,vivo.com,baylibre.com,redhat.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:olivia@selenic.com,m:herbert@gondor.apana.org.au,m:hadar.gat@arm.com,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:kernel@pengutronix.de,m:festevam@gmail.com,m:jiajie.ho@starfivetech.com,m:dsaxena@plexity.net,m:peterhuewe@gmx.de,m:jarkko@kernel.org,m:jgg@ziepe.ca,m:eli.billauer@gmail.com,m:arnd@arndb.de,m:gregkh@linuxfoundation.org,m:dakr@kernel.org,m:olek2@wp.pl,m:o-takashi@sakamocchi.jp,m:bhelgaas@google.com,m:panchuang@vivo.com,m:u.kleine-koenig@baylibre.com,m:alperyasinak1@gmail.com,m:sgarzare@redhat.com,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:imx@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-integrity@vger.kernel.org,m:elibillauer@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[panchuang@vivo.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[vivo.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[panchuang@vivo.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vivo.com:from_mime,vivo.com:dkim,vivo.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B9A6739E89

Commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()") added automatic error logging to
devm_request_threaded_irq() and devm_request_any_context_irq()
via the new devm_request_result() helper, which prints device
name, IRQ number, handler functions, and error code on failure.

Since devm_request_irq() is a static inline wrapper around
devm_request_threaded_irq(), it also benefits from this
automatic logging.

Remove the now-redundant dev_err() and dev_err_probe() calls
in char drivers that follow these devm_request_*_irq()
functions, as the core now provides more detailed diagnostic
information on failure.

Pan Chuang (3):
  hwrng: drivers - Remove redundant dev_err()/dev_err_probe()
  tpm: Remove redundant dev_err()
  char: xillybus: Remove redundant dev_err()

 drivers/char/hw_random/airoha-trng.c  | 4 +---
 drivers/char/hw_random/cctrng.c       | 2 +-
 drivers/char/hw_random/imx-rngc.c     | 2 +-
 drivers/char/hw_random/jh7110-trng.c  | 3 +--
 drivers/char/hw_random/omap-rng.c     | 5 +----
 drivers/char/hw_random/xgene-rng.c    | 2 +-
 drivers/char/tpm/st33zp24/st33zp24.c  | 5 +----
 drivers/char/tpm/tpm_i2c_nuvoton.c    | 2 --
 drivers/char/tpm/tpm_tis_i2c_cr50.c   | 4 +---
 drivers/char/xillybus/xillybus_of.c   | 5 +----
 drivers/char/xillybus/xillybus_pcie.c | 5 +----
 11 files changed, 10 insertions(+), 29 deletions(-)

-- 
2.34.1


