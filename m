Return-Path: <linux-integrity+bounces-5883-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80572A8A6FA
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Apr 2025 20:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C63A71900F6E
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Apr 2025 18:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F111E221549;
	Tue, 15 Apr 2025 18:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jH/zPe8Y";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jH/zPe8Y"
X-Original-To: linux-integrity@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB008BE5;
	Tue, 15 Apr 2025 18:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.82
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744742569; cv=fail; b=j/xFFU/XLhKyi/sr7ecncejt2yOf88CdQlMjA8n1OOixGpmQhofDe3g+vtapUhrYdAnmns2/XG1jOI7fQ44/Ps0hwoV4nslpmOKomKtuBR9+MTpgOSGVYeWNTr3hkQRl9hH5C3/KRb6z3QBC3qtZW2EvZjnGQlZY+Z0/42F1CRk=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744742569; c=relaxed/simple;
	bh=nBNANgPsLmpaPDGgpVH+dysko5DJM+FYipAP6TWhkl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OVruumW4iI7G5qOaUrOLZ/i7dUJE2yY9B1OL7nPef1mzZImErvZjG9+J/q2OsEo40XJ4T9t1ILV2Fq0XRmZmwNTYs5R1Nv8xzJqYlfc52epZvdRgN/kY7iOWGsAd/mkHnAfC/aEEEX4Mj6Q+gX9cs9qdrbc4+UUMtewoime542M=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jH/zPe8Y; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jH/zPe8Y; arc=fail smtp.client-ip=40.107.22.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=HpoH9AMpsL3Aoap1j8VtukQsURCLiTfSsiRFQ+QcQtt4nWYMpo95NqEgtWpKnRlBRXbB9W5HDoZoD1wZ0o0a2JlAz0HxPs6rS7aMOo9tqSHjA6ZgkkolaO7ZZY6S4nVwCjdsCq1MtE0ygsGYvWPV6MuHAcCm5g00agqWZ8nWhdVIeYvJbzkYgGa9EXauAaJDuR+gLMfVQkT3cAx7nRPsRRs+TV4o8/8HJotESHbexx+CK/EuXGqhPmVLbmQzNrWuw58z/KFna3qyDhyhWdzc53LYFWPaeXN3Pq95Jh3N1vOIU7DHuWl1McFLml2pW7+4wzgHYc6zCzlin4E1xhHLzQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9SQDjHXQN0ahzsb2hGyleymXZ+hnMw3b+OkQQlic0A=;
 b=mozVbqvHJs/I73etbeNao/WHKv09pAiAX4GAnusHeOOUxkwA+3owVYXrQSj2XAIDdijyXic8jrcyM6nts9GG2NXvgDEJFoOrYjvYF0FAUDlQJ9SfrDPomMGWX1wlVrzB00lnKaoYOTq31at8mlYlRMEUJIxcc8gCfQ30odVlXvu8l5IU9/QTiGVRpnoJPO3Kou9a11LWvfCq+TOZi2LavzIFhovgeb3n3//c7d2YaoCrcsCi6D86X3oHeNU17phjJfrs8sBsmigsJnlHzwlXa1OmnH63kgfblMmSMWv04ytcrE7X4yMrKPuUh9B163IlZEH/F8F9kH0lXciRYbeWnA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=redhat.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9SQDjHXQN0ahzsb2hGyleymXZ+hnMw3b+OkQQlic0A=;
 b=jH/zPe8Y72XSeyb0Qift14nEMDm7hGN9BUQ4YEYA+8R695ovnjR45plxCa9A2ZusOQYFUNCf/acBQKTSlgxDofxCdDSd7IJonLNM5+HBQy8wZnwZOer48hbS/uuwSxjK5uiT+wZGP0AA3b3YBLNaXA8AsTUoP7Jy7lMflhEEsCo=
Received: from AM8P189CA0021.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::26)
 by DU2PR08MB10203.eurprd08.prod.outlook.com (2603:10a6:10:491::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 18:42:39 +0000
Received: from AM4PEPF00027A6B.eurprd04.prod.outlook.com
 (2603:10a6:20b:218:cafe::70) by AM8P189CA0021.outlook.office365.com
 (2603:10a6:20b:218::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.36 via Frontend Transport; Tue,
 15 Apr 2025 18:42:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A6B.mail.protection.outlook.com (10.167.16.89) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Tue, 15 Apr 2025 18:42:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N8ydB7we/GYFlNya7wq+NaWOXVDrxKJV21rJ1/z/RAtR3DQ0e0FggmxRpN8tCqCOimRqRoqjgL6O8k0XJVIEjC+1rmSJYwJpBnr1GvrpLBF9QB6psMjJCiNqVYV98dBrnDWxWdJXFqMkFI8aQzHLIHdGbGeo7uUNQ0lxMPyKKdTxnH2xqZ+SE5VWd7akQGub2Yh+MN1Xug0lS8rqaXMkdLX7bMBt3A8fx6RKa2cJmoKU7l9Z6qRJDjF4Bhbv9rRHPYDjR2YjVKre9T8RDqdyg1kKbZ0LfbbvLKrUDUP0eF9IfAlEONKRpl1CN7C+mxZ6Hh2FRa7FZs55yt6jJ2L3sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9SQDjHXQN0ahzsb2hGyleymXZ+hnMw3b+OkQQlic0A=;
 b=eDqjOebiwARRG9TlP/FecX8Sm0yWnKfIstvXuyfEbc01oaYDn1HtKmGqO5Do6zgtnovvhXG9hK/Co1AkytnLspP8EB3sOvsNYnnLGrqIsbZtBRf5Wv3moMwilqzM3mOi8CJI7Dcba62pQ8pWGJUjhsK0/yLkckclR339syVVMh9RUNrseGMHAvB7zuEhpseN5XmVk6eT8fCrnA0l55usaDYLK6Ts7XT2iDxnIrir2n2VbbAxE2K1SfWV1IOjo7vl4w1p4brnVILeX34ml8rNVzGwzhY2KZWUSluT0Vro9gmtZ6hd/Z9qlO14BIxyNHJyjrOyLxNHB9ibVCNhQMTxzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9SQDjHXQN0ahzsb2hGyleymXZ+hnMw3b+OkQQlic0A=;
 b=jH/zPe8Y72XSeyb0Qift14nEMDm7hGN9BUQ4YEYA+8R695ovnjR45plxCa9A2ZusOQYFUNCf/acBQKTSlgxDofxCdDSd7IJonLNM5+HBQy8wZnwZOer48hbS/uuwSxjK5uiT+wZGP0AA3b3YBLNaXA8AsTUoP7Jy7lMflhEEsCo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS8PR08MB8492.eurprd08.prod.outlook.com
 (2603:10a6:20b:565::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 18:42:04 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%6]) with mapi id 15.20.8632.025; Tue, 15 Apr 2025
 18:42:03 +0000
Date: Tue, 15 Apr 2025 19:42:01 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
	sudeep.holla@arm.com, stuart.yoder@arm.com,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] tpm_crb_ffa: use dev_xx() macro to print log
Message-ID: <Z/6oeYLYVlAy4Azj@e129823.arm.com>
References: <20250415075712.2157073-1-yeoreum.yun@arm.com>
 <20250415075712.2157073-3-yeoreum.yun@arm.com>
 <yglnqdykvvof7iwviaacqnmmoanhhoefgmaulw7nrlf6zotbgj@obuqtycczzm7>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yglnqdykvvof7iwviaacqnmmoanhhoefgmaulw7nrlf6zotbgj@obuqtycczzm7>
X-ClientProxiedBy: LO4P265CA0012.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::7) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AS8PR08MB8492:EE_|AM4PEPF00027A6B:EE_|DU2PR08MB10203:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ef64af0-7b3b-4004-1ff1-08dd7c4d4b72
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?FnODzbfZxJhgljXXJxGrW+MkfD0UUZt5sMsMZb0+0pM92i9bg3vMDYsoB0ov?=
 =?us-ascii?Q?aj35m5RASO8IAHUay/cNhG/ultBU487m9fFhqPH49lExOmLy0StKGQkaXy3t?=
 =?us-ascii?Q?caHmA3lH72dqV+wRT/c/aSxMRQpUT2f2J307ubIaalb7YP1lufHCq7XHPza0?=
 =?us-ascii?Q?dC2W17OSSzU2mL+pm0mn62l2Z2WS8qL9WD+TgVzHFIkQpXrlGKMTaGhZKj9S?=
 =?us-ascii?Q?LVyRweM3BlH/6rqLpi84M0e6NxRC8S12HYWcaiuXbGie1TG0KC8fL7aqfOMH?=
 =?us-ascii?Q?O/L4B/1onogSY830yXgIBDI9p70RT4tGHE7YIXWxkJJtLlEI4egeIZ4NOUm6?=
 =?us-ascii?Q?pbaE3Mh78P9VrYbntRQPSlZ8wXFoiHejEiCviLf8FX2aaxQQQYG//UbknvGu?=
 =?us-ascii?Q?U2u0/9jQyVhaE6Cn5gufoOapxhFL4UoDWcnuBgj/ELPs3XUiFbvubpwlHDg/?=
 =?us-ascii?Q?NjFyNfls5gLiukVG0cGtXCnwcTkTuag72TzpWjDogEeKdL1fO0id9nZliXCF?=
 =?us-ascii?Q?hglEgD/+nwlw53BUfIy6oqwwbj0BqkwE9EnQT4jjEE3x/cOBpfR9BLwUpqGD?=
 =?us-ascii?Q?5/kA+2oFKSmfWGuP5FA7C/OL/Pe4Ja1J9BxF7dHpC9fO1uzPMn81GeJbg4k3?=
 =?us-ascii?Q?qIu3Jh2P0GMjo2Rk6rf9hAnpDHszzTXdGXRRSg3Ri9yFiLEz7sd/OBhfPkAl?=
 =?us-ascii?Q?x8IvLGN3MVbPQT9eVneBJz83JunMCFkpB5/Xkcntl4VpGItmVKKiiXOwl+ka?=
 =?us-ascii?Q?sXKf85vtkkhtp1G7UJ3c98ZB5AWlJyPuPJkXxj2B5VRL0kObTWrzMluotrPC?=
 =?us-ascii?Q?A6JVKN7Xv+l53Np9gTQc4o1RZC7aBM/ZsqawzUCol9Iwas+mT3P7Lnmt1M4E?=
 =?us-ascii?Q?78hZyVgvt6GZyglW0EPHwgX4TB+T0FZBKGmXc2vCg5hP7iiCUf9f7WNCiw5Z?=
 =?us-ascii?Q?D0Edmvt1gD6qGdAsGwOMmhzGJeT6QhKk7b11+6Urnoiy1pE0tGdELy0IAvNq?=
 =?us-ascii?Q?z1j32Ih+Mmc8JdreiHwh7Q/CIXZRPmFIQW474BKifMXkQ5ZbdpA81JfXxwDx?=
 =?us-ascii?Q?tXX6d1v2GiD+K7wOyVEC3HBW8ePAhUK7+97DykJY4BNzJCWeCjG3uub4HUgw?=
 =?us-ascii?Q?se/BzQn36brg8huGMDT4hKGP5lutU1FEaW93OI+hMqh41HAQwwfWEGeEs2hA?=
 =?us-ascii?Q?lWwqECGd4yhgRRSRq4s804BhmSRGaIhlMwnUe6+1aI4MEsZNGEdz8jYb9PvV?=
 =?us-ascii?Q?w01CdXpgWC38jV/MZeanVgeIEM26l21D62vg/r0x6L1kz0daExC2R+V+ZFvR?=
 =?us-ascii?Q?DTZp+8HMN5WL9nCVWirQA0WeOYkRg476hFzAFQUHj0ft5rFu9JJFOohxXMVJ?=
 =?us-ascii?Q?SqGSNRKBDwP3OGBHsE8KN18nHcLZye45jHMmMyNYsa1f3KZ8+Zttrh796sEr?=
 =?us-ascii?Q?HvTvqx7PIBY=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8492
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A6B.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f8954785-59e8-4f59-def3-08dd7c4d3717
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|35042699022|14060799003|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+ISuPnUs3QxbzKxVavKrjrTDTY9Oq7eYrXtESnXBC1mMnZHZZAlMhwWvFVJK?=
 =?us-ascii?Q?ZoaENgP3HpnpCkJ3m5W+utS3BCqBi82quE7hhro3S12ksceL2wv6hcQ6WwDF?=
 =?us-ascii?Q?ZFLafRpMPOT/R8GK9fI3P5WVu7ric2s7kFRRx4Uf8V4/4D7AAEd1b/Hu375P?=
 =?us-ascii?Q?kwW2Qp2W8r6u9ZVQ6Bs/qUn3CT2zXUpX9pKJveV+caxAuSqabYE/PJ0WzGKp?=
 =?us-ascii?Q?6A3e7Y4l4AUpLr77HAfSaX/VhCTVWMK6YyttwI/mC/V3KoixIopKfzcsUxN+?=
 =?us-ascii?Q?0JPJ0C054hOO9krTFGKCFPG5Y6ai1g/FxaqxBWUlxRLqeSVX9PDrPG5uasQl?=
 =?us-ascii?Q?4U/1WVWERIjQwXcflBHSsfsDVj8Y3ipDIbWKSeGfk8lRNaadjQ/Q3p1ND7pS?=
 =?us-ascii?Q?HfX16D220AZxllqEuvsKnu21rLgiFIZrnuqjDrbV1muiQHBeGWuMuC72X9XD?=
 =?us-ascii?Q?cV4MM7mxa58hIqD9M64BkPToH9HAkxhEuBaQrIQXUagk4bQVF5nyo4X6r/eK?=
 =?us-ascii?Q?PNGb6zLiI4vp4K9LjU99siNwO1pwZnzBmWfZXWex1Pb4IDXJdba8Od8zWOEZ?=
 =?us-ascii?Q?QRB0YB7hGhP7Wx59T419gcf6b3wtZXoi07fpjxsCOGdAShl6qDGf3LTfVpLJ?=
 =?us-ascii?Q?x5jt7nF5+/r7TX/yf8azThQLg5btsd48ym9DVFPI5Zz4RZmbDF4sxYyK+Tqb?=
 =?us-ascii?Q?n+GYFBs1yqVgo59Yp655rei/Rgo3T0iMVrJna57KpUWjchL4PDo6xfjVyO+s?=
 =?us-ascii?Q?lsntunbSnaXxQLUoXhuDtml4lfn0h6iJkVql9/06JUkvxCE4Poa80HHblg5s?=
 =?us-ascii?Q?+58EOrLcrKHfeh8M4U27KQbutZe8jMb1dX8U8dXCN4mfnkvt/ROdBOWIktPl?=
 =?us-ascii?Q?tJSADUc/AVjHhcuY+7GhYPxjGQdZEJu4B1JgSB21vVIYgohlcCe6ZPzeUPWt?=
 =?us-ascii?Q?m4aZcjuhn89Jb66jGSc6CTrYIpTrLBdOO4fV+jt5dsHlkrNw25TZQ6iwrrCS?=
 =?us-ascii?Q?5wao6jqFpFF4sFm1WzlisM6ojDaQkYRh9OLUa5sxbsdBj70GuPY9GVJePkBD?=
 =?us-ascii?Q?bmkiT0/O/cvQT5Wt+M6XEwYWUEKsjRWqiqviYtimOCWDhlGrNmlMfTF155Ah?=
 =?us-ascii?Q?EgXv9TrEbAS/LiGFkabwDjN8Yf2YQZX+OPWta7ptU/iVcaJ09YEErCYI+ajb?=
 =?us-ascii?Q?GJd51eNTztBwDZh/vwa5QFfInadQaqz0B0xjBikhEBkVYub7Eva4WycQlbKI?=
 =?us-ascii?Q?Z8B0ZXlw/nkE1D/p1mKwjbIhKhxyDFQeqO3swtoRPMisSLHdIBeAzOWu9HBW?=
 =?us-ascii?Q?xjL9nTI/Lt01WdIYmtmsDSBpjZUzaU9E2KlmnrUvqEP/Yn/PPNe42N91IMjq?=
 =?us-ascii?Q?zl9TU/jZFqK9ffgjKdwiDMJxbPeZv2vtU6UvQX89tw2aUqRzqHY5Zt+DJMxU?=
 =?us-ascii?Q?vzebc8s8oUhQEnjL3sTvjBhmbQ8t1nTig+tMQ9cAacTPhbBJJ56ehls5EAgY?=
 =?us-ascii?Q?QFfFXpv09Qc2HpIRrj7Kzy1SkNoRwW7q/I7i?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(35042699022)(14060799003)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 18:42:37.5793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef64af0-7b3b-4004-1ff1-08dd7c4d4b72
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A6B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10203

Hi,

> On Tue, Apr 15, 2025 at 08:57:12AM +0100, Yeoreum Yun wrote:
> > Instread of pr_xxx() macro, use dev_xxx() to print log.
> >
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > ---
> > drivers/char/tpm/tpm_crb_ffa.c | 8 ++++----
> > 1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
> > index fed775cf53ab..0bb8098e93ae 100644
> > --- a/drivers/char/tpm/tpm_crb_ffa.c
> > +++ b/drivers/char/tpm/tpm_crb_ffa.c
> > @@ -303,7 +303,7 @@ static int tpm_crb_ffa_probe(struct ffa_device *ffa_dev)
> >
> > 	if (!ffa_partition_supports_direct_recv(ffa_dev) &&
> > 	    !ffa_partition_supports_direct_req2_recv(ffa_dev)) {
> > -		pr_err("TPM partition doesn't support direct message receive.\n");
> > +		dev_warn(&ffa_dev->dev, "partition doesn't support direct message receive.\n");
>
> It's pre-existent, but since we are here, should we put \n also in the other
> messages besides this one?
>
> That said, maybe I'd mention in the commit message that we changed some
> errors to warnings and why.
>

Okay. I'll respin it.

Thanks

>
> > 		return -EINVAL;
> > 	}
> >
> > @@ -324,17 +324,17 @@ static int tpm_crb_ffa_probe(struct ffa_device *ffa_dev)
> > 	rc = tpm_crb_ffa_get_interface_version(&tpm_crb_ffa->major_version,
> > 					       &tpm_crb_ffa->minor_version);
> > 	if (rc) {
> > -		pr_err("failed to get crb interface version. rc:%d", rc);
> > +		dev_err(&ffa_dev->dev, "failed to get crb interface version. rc:%d", rc);
> > 		goto out;
> > 	}
> >
> > -	pr_info("ABI version %u.%u", tpm_crb_ffa->major_version,
> > +	dev_info(&ffa_dev->dev, "ABI version %u.%u", tpm_crb_ffa->major_version,
> > 		tpm_crb_ffa->minor_version);
> >
> > 	if (tpm_crb_ffa->major_version != CRB_FFA_VERSION_MAJOR ||
> > 	    (tpm_crb_ffa->minor_version > 0 &&
> > 	    tpm_crb_ffa->minor_version < CRB_FFA_VERSION_MINOR)) {
> > -		pr_err("Incompatible ABI version");
> > +		dev_warn(&ffa_dev->dev, "Incompatible ABI version");
> > 		goto out;
> > 	}
> >
> > --
> > LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> >
>

--
Sincerely,
Yeoreum Yun

