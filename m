Return-Path: <linux-integrity+bounces-6511-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4626AE7FA4
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jun 2025 12:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 418E94A1877
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jun 2025 10:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85266286D75;
	Wed, 25 Jun 2025 10:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="p50OylUF";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="p50OylUF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012014.outbound.protection.outlook.com [52.101.66.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C01123ABAD;
	Wed, 25 Jun 2025 10:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.14
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750847828; cv=fail; b=q3BDHn5v96WEoGB4OiAU0wDBZcAq8H8pbczMjD1UasAPLk/aPlLmMnFN3D6lE+2Ka1+OhnbJqRHmQq4Q4k48kCegrqKTdslgu70Dq+d1uLZuz7nh+4hK0GYBhv5vXngFS4+EoRK0hFaYeddzdw6SjwOkQoOSy4E6JjqvUTvZ4Bk=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750847828; c=relaxed/simple;
	bh=++mh41JNSQKCkNn/0Ab69qxZWbvRjHlaRECqSZMNBUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=omnWCLWvOqt1OW6EFQg8Tdn4MK68EXMIzWls7L+XnLq2jLuXP8e98X7iNdBtmjQEFT1tG7asOm4PURLO4F0BK/WvatgVOtLbOWAn2jgeP02zQ3QiqrBrTZQRVnfums7dr5HFDzQfJv9xARB7Lyu3wQUwQHjQMFIISz51W8xcpRk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=p50OylUF; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=p50OylUF; arc=fail smtp.client-ip=52.101.66.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=xHdjk9q5IG9QwkB+6rukUeAisrD1aArdhyi07F5dbcQcmuSmW9Hnb82p4k/gPtOYtLlckwEZjT0szCHH2bec25lKEQaWt3ZlzsSiQ9vX8VI7StsTvLSWBj6y37PwNi/M6XNP4xR1OwZBDVaQZgHj5yaXijEwh5hX3uCUp+hC2hN7S+ILFH/pV8b4o0u+vY/SKPdPngLVJnFaC3VLycbVnKayUBParc3JGn4lbyqJYzy3QJm2MTtfZvD7ZmOj9f0E4NtYp+luAXDPfubPKBUJUkFDZnKiDaiDNdvv6LgiFsFid6z9V/FsJLUgEZI4ciF+79QcYn9eOEHGG1m3iA7w0Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKp5E6llByYYH8hkXJ2KZv4tC/++11c+xgtL4WmGji0=;
 b=qkoS8imISxNP+ihT49VuLm6RBotw01l8L/nrpKzs2YgaRvodXKLW1kSMfAc/IM0y+8njNCTnrjlrphfYkFpNKdu0JOY/NzBm86ADMM5WoOdeaHepOwx6Rwi0lJervaH4KGN9hhy9x31HVVthOftyBIbb7bqvSO6gz67st/2+DqCA3Wgw6nBxs7dWBQP4fzGfKkOViErqzzQMChTpEwPVKLcnvL34yBfOE6ruGKt8gwqWxrDNo2uJzk93h1wF1PoCH6saAqZiStFsxBriOwDyw0eQya6AsD/vfH9jHR1xnjfz4mgIyQFaNrxwZYqHvdgbAvPyQmVoCXQlQxVnfcH6jw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKp5E6llByYYH8hkXJ2KZv4tC/++11c+xgtL4WmGji0=;
 b=p50OylUF5WqSaL4TvtjCkKHSEj5DvOg7FzYIbKq1faHq0raggowiFmze8/PzNYPsySqrQOe1eVJyQatXC1euPVD57eugq4lyX95MIZASpqgP8+3xLex1q+vHxTTWlPk887qZkfsiz18spCWHwXiqr5p1+4R+zv3b0LMi4wsvdK8=
Received: from PA7P264CA0214.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:374::14)
 by DB9PR08MB8459.eurprd08.prod.outlook.com (2603:10a6:10:3d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Wed, 25 Jun
 2025 10:36:59 +0000
Received: from AM4PEPF00025F96.EURPRD83.prod.outlook.com
 (2603:10a6:102:374:cafe::5b) by PA7P264CA0214.outlook.office365.com
 (2603:10a6:102:374::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Wed,
 25 Jun 2025 10:36:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00025F96.mail.protection.outlook.com (10.167.16.5) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.1 via
 Frontend Transport; Wed, 25 Jun 2025 10:36:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NuE7v4eeg6UZ0rzXzhGYUSH67lP8S2bHWp3Ej+7mXMxEQCa9O5uqktjZ4f5niQb3P2p4yMW/NM8GltsyiS+fcTjfebNXX6w3Cfn4EVYGcyiDDG2bwZdRTiDLOW00aZGaX+/gbK9tuEkZiyA3HUETUaQIhzNls6UyMJKRTE10l86N8cZ/VqUscPyg0lSH5MTI+xYI2UF2v89AvFWvSigkQIuW17hOto1vKJU0t4QoNfr1SY4hhkEqRz51rAhNPGbkY8tU3YkRnC6kpkeSOiACjCJUrnkNKo09v37ogp7DbqdP36cfpb+BiGpiowaLIs6/kJjt804Bod0mvW6OCm311w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKp5E6llByYYH8hkXJ2KZv4tC/++11c+xgtL4WmGji0=;
 b=jhEF5ME6G3cOEVbg3Z59rMCaiAaA/8MAq5dpIR/z/FFT6W8ugf8P9ebl4fk10fbTS8pRTDxQCMedDL7oEL14lNHUTZkRyLotEH3M78u2UXUwvf74uT7df/snPxykv3r2sm6IB0lISqONSLATgq0ALzVkgvqH9Z1dg3VJnggj1ewEBwC/zvUd16iV5C9OC0ICYteRdUG0Az+9Sz3FP0N2T/CWo/eQwNzOlHuNTRJpJoySBWBsr2hYiHTPY51KnrqAog15HAYHUkxtbPxvCIY//W8MdzE3l2TU4CUjrHVc4CIJowv35PgJgXwjKUEjV1WFDkjbtJWincBBI58qb990dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKp5E6llByYYH8hkXJ2KZv4tC/++11c+xgtL4WmGji0=;
 b=p50OylUF5WqSaL4TvtjCkKHSEj5DvOg7FzYIbKq1faHq0raggowiFmze8/PzNYPsySqrQOe1eVJyQatXC1euPVD57eugq4lyX95MIZASpqgP8+3xLex1q+vHxTTWlPk887qZkfsiz18spCWHwXiqr5p1+4R+zv3b0LMi4wsvdK8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by PA4PR08MB7409.eurprd08.prod.outlook.com
 (2603:10a6:102:2a1::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Wed, 25 Jun
 2025 10:36:22 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 10:36:22 +0000
Date: Wed, 25 Jun 2025 11:36:19 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: sudeep.holla@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
	stuart.yoder@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 0/2] generate boot_aggregate log in IMA with TPM using
 CRB over FF-A
Message-ID: <aFvRI5OwSLLKz300@e129823.arm.com>
References: <20250618102302.2379029-1-yeoreum.yun@arm.com>
 <aFs0of3uZdoMEJXc@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFs0of3uZdoMEJXc@kernel.org>
X-ClientProxiedBy: LO4P123CA0601.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::21) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|PA4PR08MB7409:EE_|AM4PEPF00025F96:EE_|DB9PR08MB8459:EE_
X-MS-Office365-Filtering-Correlation-Id: 94fef289-07d6-4fb0-fd51-08ddb3d4367c
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?e+CpBLB2fshh3+AbtDSakbWHHtwwyb3zz00/PnSTg2b7PL520egFblay1IoY?=
 =?us-ascii?Q?lu0pQtROl8aBB7JKs8Ju0L9OstyF6ZpfO+uT/WML+JsiqT/dVCFuECR1r1d5?=
 =?us-ascii?Q?STtpxyCpeE0JRtMZDm3KtSpnKEGQKSzQLvkgTaxITXNQkduHqmbQjYmC0KoG?=
 =?us-ascii?Q?04mCus2Zkl9jEdxRp1yxjflFKCq7AIwYUnB1iQYxYZhDawbSUBo9p6mnnWb0?=
 =?us-ascii?Q?U+Ukbzmx6EYq4q4u47a+Cp3fEjDrU1LzJRR+fS3YWUAsXk0o/1hnecc3QmDo?=
 =?us-ascii?Q?WCU8tbvDgaXsi4yyJUmCveucz0NV7XCclIFsr5xemOB/mkQGMhvxzYVskrHZ?=
 =?us-ascii?Q?Fo8FbfApqEpo2BckyLT+3O4l2ylFGNRTVRcKGg8nK8ASRff07i0kQS8kK+z9?=
 =?us-ascii?Q?AzsTATdNUu3Bkn2IRCNwGwPSSbvprS1ZjPwvd0Ukw8Bm3IYqe7MgOMr4mQ4w?=
 =?us-ascii?Q?wZo3pQwUtxe84gXEvODHxrH/fdOANnCyFX8dC754ZQvX2IM9gG0uRVCnqGKA?=
 =?us-ascii?Q?9FIlvfXw81Td8xxO6A+yV8i1YXR9eKWluMEJ8dcswr1KXd3UI+rtpMRNfNDh?=
 =?us-ascii?Q?1BvSjXJ9Ipq/7LbuGqzjETz3qaI8V4S/dfb+kqglTTddKufkqDHn7zkFb+SS?=
 =?us-ascii?Q?3ADpaY1ExgWO4fnBt+hH7I5PVFgZmRSm4n7NP1gOOzYg/8d6f/t55dnvr32p?=
 =?us-ascii?Q?IF2cTGnto3U/xT4IEVdlXJHDFYXffJ0cHOMoZ9TChiDkUVoaPNT4HmzgME81?=
 =?us-ascii?Q?urc9+laz1ATaapQenlhG1GUZd3hDW0En66rnaYWsRC8bvqVB8wkhSNfwdQ93?=
 =?us-ascii?Q?PccQrCKztQZzy8h2KQ5YmgoqGch1JXEICbGjuIUwsRtvM+fc6bi8usPrPgzQ?=
 =?us-ascii?Q?/hZPZUAmRItnCJEILakF/NOavYCE2HuP9z1UFONm6tb7oCilfkGWp4by9TgC?=
 =?us-ascii?Q?oMP+MIf+dwU1nfo6iMDBdqq5TOukB2yfouLvOTpmiF4uZUTTgiOnVcVO9gb7?=
 =?us-ascii?Q?q6eNn0KjaLM1rmj1+id3ZR2hHZ5cGSBs6gt+38nlyCgjxBn9d31CCsx6/VqK?=
 =?us-ascii?Q?cbZdOTBFaWBLpaYHAoiIhJ0raHYyiXmeHLQ70vTNicsj6SFe8MUleQoG354N?=
 =?us-ascii?Q?1Gox5uwxRFymD8f1Qwe7eMVyjYc0phmM1sqoPYlpz+gh/GGH1ftWfpypT/f/?=
 =?us-ascii?Q?+ctg4V/aBWIo2NjpfrZNmRQfB3i22HWeP+Vx3cGaJqIEOIan3LSGhmoT4EeD?=
 =?us-ascii?Q?COzoOs6wi52ri7GChutp/MDvlBEluj2xDjmJL5r/Mdq1bmtLJbgSR9aOM4wH?=
 =?us-ascii?Q?u4+lS/Efw+PXDuYrZ5B8SB1tIDe4yO3iHMtwbRzuzcI9N3g/88JQBMQVBh9x?=
 =?us-ascii?Q?8UBSm9fRdSX5yLtvLE0ldBN3K0kyV0BC7WQUaSTaWacLhasCTV8JGJDf2Kdq?=
 =?us-ascii?Q?ITckUPlZkzw=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7409
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00025F96.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	910a782a-04de-4be3-49c5-08ddb3d4208a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|35042699022|1800799024|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GN9O0+ODArr08lRwaaUfjjU9CxAwNAXhB9xHYIic/Netdt30Mzfe8e/KPC+I?=
 =?us-ascii?Q?OjTzsIS+JFVVFgasWgXEMZWcVJqguKxjB4yl37MA7meIpE+iid2jl34ENFeF?=
 =?us-ascii?Q?I9S9JeeBbw0r8Z1gW3v1V6YFZLToz7m7tWdPxnZuk1seWSEENRX4552a73Ja?=
 =?us-ascii?Q?ECLzg+oQ1Y7RoGbnhbgLBjcTjRW2Kv8/Nz7FOCbpFt9/3vN4+lyI4goFdjOy?=
 =?us-ascii?Q?ueajwGAX+h31NfI5n5n2QeITRulxgueC+j9D6ofExfQ8aKjRMyL80b/8azw3?=
 =?us-ascii?Q?FYX2p6PQ9wNBM1tBh8lHUPRENy5H95am4kxaxMfYF6L71UIa2sHsa9fOjUS6?=
 =?us-ascii?Q?pBytsBhKkei2vwV55CFUvmhEo/P2haC8rZ6437NzpOFBDehAA3hECW5ccASd?=
 =?us-ascii?Q?QDLVkB/by10Oi1M0RSEJf9+6sm0+eU9p7u/CLpc9XiGU7vDbRRsbUO4dVQKT?=
 =?us-ascii?Q?kfH6Q40w6nw8qs0BONRcpF/+2Gnj9huJVV1aBIJS9vgF3abAbY12b0mbpK48?=
 =?us-ascii?Q?eiH4XGJ0B3bFj79aNVMLcbcfTrOGNbNb9wipxPDXyzCvvgDVcssoSaYNhTrA?=
 =?us-ascii?Q?ouLYRc3dUHM2Lzif/rvZesZyTQOG/Z8RElIQcRUxvXmCyiRQmp8I21wyNppD?=
 =?us-ascii?Q?4vE6p0l6ZuOqqgw9mSeCdKYci8CAPmN+cteIp73csBijrCTfEXq+6E6PIH9c?=
 =?us-ascii?Q?ZB7jvY0HZVydFzL61qL+o5DbqfSH8FlPPdEKLu0uuQd/JmdzyduZAQQi/D2V?=
 =?us-ascii?Q?fXR6FTjg3al2II3VDExEHx/N9jzjsKs5lzmb8NJ/OCNMKly/++uCa7awBJhb?=
 =?us-ascii?Q?T5dkReGmNOQdI2K9ho6+6VgIYokSs160husnF08xb917KQQ4jHei+JcQvHzD?=
 =?us-ascii?Q?QnZxHgiuNULB9emUIQXSZ5pl6JTH8YennYC/ZfnaCguvSKTVRNhkS9ylWK74?=
 =?us-ascii?Q?wRQOP8bOwuivcdgrsDclSIYyOrX2dUqUykxBVeeHnBTvOYx/56za09Dj0diX?=
 =?us-ascii?Q?3CMbVdMAipqdXa7CxL+phLIAspcBayS4AFQ3LF3owTO7gKAWANbtVdwy4W7d?=
 =?us-ascii?Q?58WKlvwlpRDSKvFmIHspiYZIUv67WlotWuAZ0rapzFczoO4bENGWuYs5knyD?=
 =?us-ascii?Q?5uy0QXpzpg0/Vk/lDL8AKRWz6aOUqyUtiNnXxWYXsgUZbhOuD5MBJpToEkIC?=
 =?us-ascii?Q?f02YnSruGLdwJnqBrfYBmmmLtz5juePl8g4WavywkLYk0GlQhlyscjJM/Z/V?=
 =?us-ascii?Q?xBeKG2/O5ZKdOf4dOOYZ/1sfRws08IS32UhmwIY6WXn7VDyv/UNIybf30vBR?=
 =?us-ascii?Q?IlD/MOYZtHCLgDvJqmSwyZyhjSNc+pf2MQvNNPUCFdUA//Ih03CrpzdlQ6NH?=
 =?us-ascii?Q?5y7Afx0qMqqwTBpOdyp4Hpp3GEdN/USvT8/C+aAf/HNSsWFv9DtmWdQsZ/1y?=
 =?us-ascii?Q?IkHu8/lplnqLEkWeTpt+cptjJ830zE6AOxlv7NS9ofDOxdAUmvUXYrrV4NFG?=
 =?us-ascii?Q?iUXCqIb511NZltJy6azb/0OMpkdtaDgVb95h?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(35042699022)(1800799024)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 10:36:58.4142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94fef289-07d6-4fb0-fd51-08ddb3d4367c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F96.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8459

Hi Jarkko,

> On Wed, Jun 18, 2025 at 11:23:00AM +0100, Yeoreum Yun wrote:
> > To ensure the TPM device operating over the FF-A protocol with
> > the CRB interface is probed before IMA initialization,
> > the following conditions must be met:
> >
> >    1. The corresponding ffa_device must be registered,
> >       which is done via ffa_init().
> >
> >    2. The tpm_crb_driver must successfully probe this device via
> >       tpm_crb_ffa_init().
> >
> >    3. The tpm_crb driver using CRB over FF-A can then
> >       be probed successfully. (See crb_acpi_add() and
> >       tpm_crb_ffa_init() for reference.)
> >
> > Unfortunately, ffa_init(), tpm_crb_ffa_init(), and crb_acpi_driver_init() are
> > all registered with device_initcall, which means crb_acpi_driver_init() may
> > be invoked before ffa_init() and tpm_crb_ffa_init() are completed.
>
> I get the ffa_init() part i.e, moving it earlier. However for
> tpm_crb_ffa_init() and crb_acpi_driver_init(), modules.dep
> takes care that they are loaded in order.
> For IMA you will need the driver as built-in but that should
> be handled via kernel config, not via code changes.

In the case of "module" built, it's true.
However what I tell here is when "tpm_crb" and "tpm_crb_ffa" is built
as "built-in" in this case, it couldn't make a "dependency" between
the same initcall level: here is the case of this.

0000000000000888 l       .initcall6.init>-------0000000000000000 crb_acpi_driver_init
000000000000088c l       .initcall6.init>-------0000000000000000 tpm_crb_ffa_driver_init

in this case, wihtout code change, the crb_acpi_driver_init()
is failed since tpm_crb_ffa_driver_init() is called later.

and this couldn't be solved with kconfig --
ARM_FFA_TRANSPORT=y && CONFIG_TCG_CRB=y && CONFIG_TCG_CRB_FFA=y.

The Patch #2 is to proing the tpm_crb_ffa as part of
crb_acpi_driver_init() when TPM uses method ARM-FFA.

If there's another suggestion, let me know please.

Thanks

--
Sincerely,
Yeoreum Yun

