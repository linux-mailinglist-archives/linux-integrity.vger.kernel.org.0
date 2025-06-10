Return-Path: <linux-integrity+bounces-6395-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C12AD3B70
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Jun 2025 16:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8BE1BA0EEB
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Jun 2025 14:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8F5207DF7;
	Tue, 10 Jun 2025 14:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="pf+IU0ty";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="pf+IU0ty"
X-Original-To: linux-integrity@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011050.outbound.protection.outlook.com [52.101.65.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC4B2045B5;
	Tue, 10 Jun 2025 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.50
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749566352; cv=fail; b=hIYgvDnsd86KkdEjzlw2SwBvQ82Rj1BVqsA/Eu87xyAEITq3KXjws2Kq/1Fv6WkcZdmtztWLvmSwpwpV79dVlLwrAp+ySnFEOgnOqN6/fJOZqd5kN/lgzU0h6ai9tgWukvMW9QAXjpjg5Jr28FAXkVof7CqP81Lqoo11CW7Hnvg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749566352; c=relaxed/simple;
	bh=fUmotHfSS7c4+n/IQ+iycdxFy5QdQyOYns8Qlkv8AKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R/R117QwXVfhGjXy1nUwDyEJ2aLmW+a68TzpcOWzLo8vudRx4689qWhp+SnqjHkasW0hG34/oovzaiAG+gn57hH0gMAOzO3V0RvyXMs4wu2uiTLashWQZU88tKcsTVziCg738yCub5CQ9qpFRuXqMYEVb8nysrNNLakvXnyGKMM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=pf+IU0ty; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=pf+IU0ty; arc=fail smtp.client-ip=52.101.65.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=hoBY9ok1bugeitDQPLXXKJWfem7C1bqpSwQRN+TYaVMGj3ZjDoRYBzigGYpL+/AxQ1Ydc30mdWui83pfPc2wNWGs/L8bz3QDfTEGHekOKwKJ3EiZlQD+yfKbsavkxItvKsDIEI535/mCVyM6PVwcow94MR1XlkrJlO1SvmcsQKhwmayHAnhbz4Z7t+e8kbQ4v5+YJ4R0iGSF7Zq+sCGOwfz5mQjcWdHGSsIh6pnrFZObUXW6mSFO7rhAoC9wQw+f/OZfCegrV6zlWfCPj8UcjoRDtxQZkAfb9E/V3fsE8VpdQn+EScoDWU7mKM9jXosYOxFwPonCxwz4Waavb1iAdg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BP73ih4Z4WBIsNAff3IkrdUaMhN9zV7bG7hFT2vQHjc=;
 b=r7TAorsYsnVOFgXLgn5oE7wSlhKK0ob/R++AS5Wqh7Tw+v9YCSgS2yoeWrKgg/0vI4c8YnKrUlcp5My5/yfCEk8te2ybl65WTJhhCyrp7WECv+PIC04HwcuTJZU7GDB3F1eoot9PBgfQVpymAGSXPAn4C4fw5u7sYYdHGNyF0zILksQREE0hrI+bjIXRYPBtj1Ovhr9II6bHbpX4OVawLdEabfdemzz4JmKH0EzUbXuiAKmGu+OUUx8ASUENiB8FBCfoof9kCUWN5J+o/XfjBAzNz0rmj16uVokYIXxE2DMB9l/jWeBcqQdXfzjcqaq8qK3UrEUxTPdsf0XTJ9iAeQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BP73ih4Z4WBIsNAff3IkrdUaMhN9zV7bG7hFT2vQHjc=;
 b=pf+IU0ty0ylaKISFjF768NZAHxdx9ou6VF7/5J63k9WWZJxgoGyK82xAyJqdn3xl/Xz6m8K300D3mK3lcmqd+BEZ8FALM4fXenTItHZOzsiqa+TouPPfE9LTCgI9H3DukWOfpRG44tAcePgfM94adbByLHCVYPMTcDH28MxMH60=
Received: from PR1P264CA0091.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:345::10)
 by AS2PR08MB8904.eurprd08.prod.outlook.com (2603:10a6:20b:5f8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.27; Tue, 10 Jun
 2025 14:39:05 +0000
Received: from AMS0EPF00000195.eurprd05.prod.outlook.com
 (2603:10a6:102:345:cafe::a) by PR1P264CA0091.outlook.office365.com
 (2603:10a6:102:345::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Tue,
 10 Jun 2025 14:39:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF00000195.mail.protection.outlook.com (10.167.16.215) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Tue, 10 Jun 2025 14:39:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WZ9/4pGfXcdzS+J/c81GhYuuHaCdqj0zi/96RhNZZGm67pDD0kSp6T2942RIN85FYFyD30ZKA3nsTpCoVF/gn/nw1mef3IDZL86IGltcPflYTtPV1bYHHAXbrS++pOrJOZyqhkds3zG9xXTpjo7bZpJhMAjedbMxdgwvKiR1hjjjpGFiUvg5RlaAMhLap/t3Gesi/8d9XexSH1f9JdrQNJ6Hj/Px49cHGgGqTdAH0wg46l3DhoZAlMqtCrHl55a2c2adt0NRnR+aBrlaXmsVWNkfffEKbW8TyUCSuMxvc0t5GfBt8JL76jiZxk6wLnAfIErt7niZ/fJsiksCs/3fUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BP73ih4Z4WBIsNAff3IkrdUaMhN9zV7bG7hFT2vQHjc=;
 b=qwUJhD7cWKnLeZsQtTN5wOEuytXnKSeKTe4DDHsbOHohjgBQ3t+p3DSIfbhBBstZEC54J6ZZUeYt0eY3H7HpdcgkFKhECOblYGdIXvDWQ8X/xz78y2JT/JDjle+MKIOKCAty+uTXXf1+vGAHNDq13/ID6vehZxIYM8acZtd/cmUWpJymdESxY/wg84K252va4wntDm84exk2OGVwMxw4LAOeJncuHoUhbWw+MCDPaLiBBCKWJHVc/H64bqaq+Qh+3VjKf4BrwgWW4UHYBVRZ9rJpC1a2cotoZGhg6sX39FYLd2cMRzbU+P+9+kwmJ4VApYCfeWkAhbV4yQPT0E2Scg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BP73ih4Z4WBIsNAff3IkrdUaMhN9zV7bG7hFT2vQHjc=;
 b=pf+IU0ty0ylaKISFjF768NZAHxdx9ou6VF7/5J63k9WWZJxgoGyK82xAyJqdn3xl/Xz6m8K300D3mK3lcmqd+BEZ8FALM4fXenTItHZOzsiqa+TouPPfE9LTCgI9H3DukWOfpRG44tAcePgfM94adbByLHCVYPMTcDH28MxMH60=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DBBPR08MB5945.eurprd08.prod.outlook.com
 (2603:10a6:10:1f7::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Tue, 10 Jun
 2025 14:38:33 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.8835.018; Tue, 10 Jun 2025
 14:38:30 +0000
Date: Tue, 10 Jun 2025 15:38:27 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: sudeep.holla@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
	stuart.yoder@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 0/2] fix failure of integration IMA with tpm_crb_ffa
Message-ID: <aEhDY4VlkIPYAjPE@e129823.arm.com>
References: <20250610060334.2149041-1-yeoreum.yun@arm.com>
 <aEgmhwu1RP27yBpw@kernel.org>
 <aEgwpXXftXW6JNRy@e129823.arm.com>
 <aEg6Bgh8TqzK5nSu@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEg6Bgh8TqzK5nSu@kernel.org>
X-ClientProxiedBy: LNXP265CA0082.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::22) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|DBBPR08MB5945:EE_|AMS0EPF00000195:EE_|AS2PR08MB8904:EE_
X-MS-Office365-Filtering-Correlation-Id: 98652c1c-2f68-4b6c-a8b5-08dda82c8d20
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?LE/Avp94UTHTifP3aLv7pcgGbxtZYXQeY3d00YUtFRVzzRQShEqQWVB00xyg?=
 =?us-ascii?Q?+IlOLzUF3B7cp0e4I5ZxOATr8PMx5WDIVPbqhwu7TtLFM8Pu1G7d1g0HZt6S?=
 =?us-ascii?Q?9harD+A68BtT3XmqctNpiCi94Wf5qdTdANMJ9lSM75u52k9ZGUqJj07iifvi?=
 =?us-ascii?Q?Pl3CLcpe9ALfTE1A3Q1cUh7JC5bIn0TCYv7OJCTS1upKYVtsRA8ARy6WYz+P?=
 =?us-ascii?Q?ji/t0XvD8AwCJMx9ESz0k0kVHOl9fUM9oTGBJ+ti0MsN8OfO04B/XJPX9eFm?=
 =?us-ascii?Q?BDwISwiCUibmIqX9Suc8kdoAhS45uAh6mAktLZUQSF4NSQ22ZaAH274rvb4k?=
 =?us-ascii?Q?TAIXwEDzZNAkXbCoFf9LiuD0k++RSJ24fc9Fs8toSL5uJSGdfvlV5numK/nu?=
 =?us-ascii?Q?ZbbXH+lVuzqG5SBW73YhrmldxfplXgo3QyC5baNOd2iRW9vxyhgidnYFu1Jh?=
 =?us-ascii?Q?29pEgYQghwAsfbnpQTDLegZqQDgrraVuoyeF+JXsTq1P9lzj6ZKl/6+V5SBp?=
 =?us-ascii?Q?Z89Kx7i20uKiWb5ER8L1yy9W+DMkXPSC6ybrSY7ToL/YWhmRblKgKN3Etcp5?=
 =?us-ascii?Q?D51Yl1BVCX/UBQ+n+XGHYSqHIM4yqAZXfW2g7x4+4GqKRquaN/FVY3CC+4bx?=
 =?us-ascii?Q?6dcO6oRPq22GtcUqVpCkFj/pde1xxGDO+Aj02nfM7t24FmuAxT5cqDGUJPU9?=
 =?us-ascii?Q?vXTrpIYo2+oK/v5L9FtZwjCJUIXLpZrYVBJmERdhVhoP5K/gKEVSpt3KJOY7?=
 =?us-ascii?Q?h2j2WeiQGw/cnEW6AJjG6ocQmCNLmM2ZHs84cJEc4nCiQPGUZ9LNjDnIqA/D?=
 =?us-ascii?Q?qlvzzhCB4wL/kTO7YlWsyBp35c5GswLRVa5T4NE7V6zjCtZJ6746RbdpD3UE?=
 =?us-ascii?Q?Nen1QBJhmqD8ky59CtP/miCXqaEo/FU3QyyNwSQrVmonMtQRE+EvYNcLGfhj?=
 =?us-ascii?Q?nxVnxh2cmeYGJNa5ZC+BAFjnNxaCNNxPED+vqroQ2raRzQxmlY9PHKj+id4W?=
 =?us-ascii?Q?xXiKI057BIBpOtRsHcCi+/1kRYV5PRjvZLiPeH0g8M+WZjSCVxSm+jLJ9PTi?=
 =?us-ascii?Q?HcNrCqpp0gX0J7idhPBHpGiUgDODnUMc32IHcQpgrYXrkbGYWzxulLedyrCL?=
 =?us-ascii?Q?p0/J/GEQFC5azFM/taQWQF2pd7n95k+C5YyOUN3iX+WFcbRn4DXgUakes2xS?=
 =?us-ascii?Q?S26Qw02LU5DggNY9KwrnB1QzaIa9yHA5ao/SDkjEDUJbGoXU85I+hikM159V?=
 =?us-ascii?Q?apPjy8KDdZuoJEDXIiNLwBDdW/mZwmEXB8+35uEeoX0ljQ1iX7A37B77i2oN?=
 =?us-ascii?Q?G/9NiIerRZSdgV32KAqDt3LdVw+GH/4agiM8sbD+xML3Ec7wn5BFh1nS/32a?=
 =?us-ascii?Q?avWtBBnA6Hmg8QTcumMxVCPREcCyRf4/J++ilYpZmc50uxbsETDWz/EZehg0?=
 =?us-ascii?Q?C6ZMNkPgGQU=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5945
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF00000195.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	2eaafe8a-e51c-47d9-e95f-08dda82c780c
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|35042699022|1800799024|82310400026|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vt6wBaSgrOt58C+rzc1wgvjcVYQO7sVWREF0nhW1MoEAY8S0kjJTBgG1LtDH?=
 =?us-ascii?Q?s9zIa7NFaf2wIo/vIUtzTNwOd08+nwUTyxQal8YSQVtLzIc5d78fm69dH7dF?=
 =?us-ascii?Q?l9KwBH6EvCwB7gTVKY9dpdBJ5Ey0526rqY4tRI77Tv7YUtPNcwYqv3ItEpNZ?=
 =?us-ascii?Q?wrUwXbOVz0pdWuZd8w9M5LoNEz2asy4poYvlnRkDDJGfx70AyZRgR7/WGm9P?=
 =?us-ascii?Q?E0jOp/30aA2gdfYKPCvx4ITucxtpk69OI0gbIJUMa9cA72Mda5ulClVHF/QW?=
 =?us-ascii?Q?b32c/JXsKOF8EXuSzkvth0ySClTd344xruIEsT6c4hpaZlF6bZvrRYOP3p40?=
 =?us-ascii?Q?1IyVelBkJYSZ9W5ttnzVLlzsXX/cc/HRFE69p8dRhiGUgIV1KH3OYc5SMOBU?=
 =?us-ascii?Q?uw6LVwOlyS/DM6DIRPcNS1Gab9NoVMNMn7UIntRl1eITvONbzYqDREtxXEyT?=
 =?us-ascii?Q?gfELCxZGkRLPQ4/NIzeOOl8ZiMvA2ohg+ZQTuYjiVRnh2nS45kB/hodE52G0?=
 =?us-ascii?Q?huIkYc6dkckHSM9OKY7Nkmlpw3sa3soQdepEaInimF6KI379t5A8nCtRspXE?=
 =?us-ascii?Q?jmCiycS2RHXjWnqhp9jOXhnnqV4vQSlQMvDmjye5vIWXhasRfacehk5F73Fo?=
 =?us-ascii?Q?JMWv89f8zXJgniLXRMSMN1dLm5q1DELCw47VKiNkDezfxUC81hdKyl+Gc4r2?=
 =?us-ascii?Q?hxJg1b1D/18XMD/ohapx200nPVcPbIOShv3rZUT/2tTl11dVZVH5nTS9UK+G?=
 =?us-ascii?Q?9naLmVxWfXnvrYJMdOudzgwSQZ8cqolJV1x/+nAgRSNfwVKQpKpsUEyQKbMV?=
 =?us-ascii?Q?2W3K5K0SZI/hoAb1CVwdpLrAmvV4iJZ+3SfHU2AuftXh0Xff8ApUtHdFLoSm?=
 =?us-ascii?Q?sRPobQIOF23ZHkjTVKE0YK5KoO0cEr5n8YCuO31bX/6msUW6maty0i7v0hkO?=
 =?us-ascii?Q?UhyDSkNmrqOhYkjJKaL8uS/amWuIEhwqdKh6mcAcVnDtas7yn5TTGLNzU7Rd?=
 =?us-ascii?Q?KQQ5HahoLxrsx1JGcV8kRfmJW1CG8pYFt6fIj8tw/u3b/EC5LfreKf8kGX6P?=
 =?us-ascii?Q?NQHtkb/DgfslJrV9A3hpiI6EfWZIWFpP4HuT+AL4kxBPh7YBcShI3aT+cYfm?=
 =?us-ascii?Q?7BY5pyhz7FqiP2BztHoZI99/tvSsSVj361hQgBsWSUiygKcn0mJF9TmWrrPw?=
 =?us-ascii?Q?EjwK3mLZdElgHdqWyXcSKJCAs6Kirc1SCx5c/gEvRP6BXc2mS1+lVb+4heHs?=
 =?us-ascii?Q?LJW1gYpEemXBp/MIVuJP7HbSFmaRqvzf4QNk+dqO5U7GP5uBKszzCULDesoS?=
 =?us-ascii?Q?5gZwGTJ7rUT6WwLkvba8bH81Te1CB/BqJlP/wzAbkQlU00wWxE3jfNWpYbCY?=
 =?us-ascii?Q?rgMgL/3P1hJ42lBKWdUqNpsltTCjTSvzv2tAXxD5XePV0g9I77BxVVqAcO55?=
 =?us-ascii?Q?rL7heLJxlkaO/AQ5jDskI83u2pYq0ss0mhP29rMNw7sgKbjIZcSGHwk2Gs8w?=
 =?us-ascii?Q?8wPn4DZ/0CEEd48+AWQ7ctcxXXnG1zo5LF8F?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(35042699022)(1800799024)(82310400026)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 14:39:05.5335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98652c1c-2f68-4b6c-a8b5-08dda82c8d20
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000195.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8904

Hi Jarkko,

[...]
>
> >
> > >
> > > >   0000000000000a9c l  .initcall6.init>  ffa_init
> > > >
> > > > In this situation, the IMA subsystem fails to integrate with the TPM device
> > > > because the TPM was not available at the time ima_init() was called.
> > > > As a result, you may see the following message in the kernel log:
> > > >
> > > >   | ima: No TPM chip found, activating TPM-bypass!
> > >
> > > TPM initializes before IMA, so there should not be a problem.
> >
> > If you see my commit message it describes the situation why this happen.
> > when crb_acpi_driver_init() is called but before tpm_crb_ffa_init() is
> > called, the secure partition doesn't probe. so crb_acpi_driver_init()
> > would be failed wiith -EPROBE.
>
> What is "secure partition" and why it doesn't probe at the time of
> crb_acpi_driver_init()?

secure partition is a secure service provider and among this service,
there is TPM services using CRB over FF-A.

This service is represented with "ffa_device" generated in
ffa_init() in arm_ffa driver.

tpm_crb_ffa driver attaches to this device and provide the interface to
tpm_crb for communicating TPM device via CRB over FF-A.

tpm_crb can communicate this TPM device after this ffa_device is probed.
Therefore to probe the tpm_crb which uses CRB over FF-A:
  1. related ffa_device should be registered which is done via ffa_init().
  2. tpm_crb_driver success to probe above device which is done
     via tpm_crb_ffa_init().
  3. tpm_crb which uses CRB over FF-A can be probed above this is
     probed. -- See crb_acpi_add() and tpm_crb_ffa_init().

Unfortunately, when they're built as built-in,
ffa_init(), tpm_crb_ffa_init() and crb_acpi_driver_init() are deployed in
device_initcall. So, If crb_acpi_driver_init() is called,
If there is no ffa_device or ffa_device isn't probe yet,
It returns -EPROBE in crb_acpi_driver_init() so it's delayed to probe
to deferred_probe_initcall.


A secure partition is a secure service provider.
Among the services it offers, one includes TPM services that
use the CRB interface over FF-A (Firmware Framework for Arm).

This service is represented by an ffa_device, which is created
during the ffa_init() routine in the arm_ffa driver.
The tpm_crb_ffa driver attaches to this ffa_device and
provides an interface to the tpm_crb driver,
enabling communication with the TPM device via CRB over FF-A.

The tpm_crb driver can only communicate with the TPM device
once the corresponding ffa_device has been probed.

Therefore, for a tpm_crb driver that uses CRB over FF-A to be probed properly:
  1. The associated ffa_device must be registered, which happens via ffa_init().
  2. The tpm_crb_driver must successfully probe this device through tpm_crb_ffa_init().
  3. Once that is complete, the tpm_crb driver using CRB over FF-A can then be probed.
     See crb_acpi_add() and tpm_crb_ffa_init() for details.

Unfortunately, when these components are built as built-in drivers,
the functions ffa_init(), tpm_crb_ffa_init(), and crb_acpi_driver_init() are
all executed during the device_initcall phase.
As a result, if crb_acpi_driver_init() is called before the ffa_device exists or
has been probed, it returns -EPROBE_DEFER,
causing the probe to be deferred and retried later
during the deferred_probe_initcall phase.

>
> >
> > In this situation, init_ima() which call ima_init() can be called first.
> > NOTE, init_ima() is deployed in late_initcall and
> > the "deferred_probe device" is tried again in
> > deferred_probe late initcall.
> > However, even the deferred_probe can be call later then init_ima().
> >
> > 000000000000012c l       .initcall7.init>-------0000000000000000 init_ima
> > 000000000000016c l       .initcall7.init>-------0000000000000000 deferred_probe_initcall7
> >
> > That's why init_ima() is failed to init with TPM when It is deffered.
> >
> > Would you let me know why you said it's not a problem?
>
> What has deferred_probe_initcall has to do with this? Not actually
> asking just pointing out stuff that you should open up.

What I want to point out is that
If the TPM device is failed to init in its initcall, and defered
the IMA can be failed to find out the TPM device
since init_ima() is called first before deferred_probe_initcall.

--
Sincerely,
Yeoreum Yun

