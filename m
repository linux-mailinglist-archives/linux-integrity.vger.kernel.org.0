Return-Path: <linux-integrity+bounces-5856-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E63A86B1B
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Apr 2025 07:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C89391B839F3
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Apr 2025 05:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E272584037;
	Sat, 12 Apr 2025 05:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="miLC1zij";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="miLC1zij"
X-Original-To: linux-integrity@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011020.outbound.protection.outlook.com [52.101.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB99C17B502;
	Sat, 12 Apr 2025 05:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.20
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744436579; cv=fail; b=Xc22YupTzSxA43baeIE3uJnW3RaFtp0L2ClbXNBNTJcRJ2Gn+RC/aBMEq6SPclefmMsL6D7TCJb7mum5XhEpWndbRJ7cDkR0Y4OnUboFLBdauIyNEsIB3AZjvO+QaqfYfbgW4vBd3iW8r5eLc9IdTJe0p61Qzq2k7E/3hOqzXe8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744436579; c=relaxed/simple;
	bh=VVBPfq55fvcq9zvmq07LWwVaY9KfKDn8y5Hk3YWBW+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hEAoTVqZE9gD9YiyaM212q5KxWJZvXIzjnt2OY6kuzv0CeuGlnNzTxb0Ioe6+cAaa/KJ3VFrUK8HilOclAXAfufzyPUv3z9pyRbQ0OteeiQp6ITCR5vMyWMKJm2YjPveS2vHekvY+luosCcUpzg9d83eBzbo84fTBYAh34ksuGk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=miLC1zij; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=miLC1zij; arc=fail smtp.client-ip=52.101.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=IEC+av8eJHE736eFqTbfIELHDmcStKm+YZEouGq00VKDPTvZRM5lziocwkF3J1YE6Yx0WHjm/MKP4pKOQ2x0c/p9eTk5IBaEq9U0Fb4aqi2lRwJ+RoNYTUyCbVvyBjUZRnE+veSVuwO1CzStGYZ5nD6D3Shfy2b0YeC+X25fQTxAn9mrRhRxtgQVdgH86RB69j5PamuSV7o2MUTL2iGjahtga5TQjnXo3AmmSI2QJ1Dz0hHdDntier2SMZ2CPZT0WLKXMxLO78urVS7F/1kA7l0nnD/fQRYLKcu9qF+Y84UHBYecCNmrPph6fo5xYEI/Fltt+9xS4QrML5L2/TAbvA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVBPfq55fvcq9zvmq07LWwVaY9KfKDn8y5Hk3YWBW+I=;
 b=nrnZ0ipVyac4cSWxd7e0OoSVmDoTWr/OW7wn3tjjJ0FxWYJOlMxC94ZU2boRw+ahwBOX2JZbrvck0HEgHA7YmNMMhlejlxVaYbTgB59YV//D1Cb8EAis9PYzdR+HFjUY8WL1oOnj7NOhlUqwjjnI4KP9V3DYtSedCkCtIcCnoP+Yx6zkFk58XEG81pzALU86Y9/O6a8JhvfnwdqeQ2MBW/VW1fNz82tgbpl/ltpZQgaOjZd90sLPwEtdENkXtACUsSm2CHbr1OR2brqs8m1PdE0d74r/SEGmQ4wGnCd97ROdwqupoY3zPHQ0HXPnJxFw8cUAz3Ebqihpv/EF1X0nAw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmx.de smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVBPfq55fvcq9zvmq07LWwVaY9KfKDn8y5Hk3YWBW+I=;
 b=miLC1zij7OMEPhWttXPBOFYJLgN58R1O3YLtRet+J3aM4E9S120O0oZ88Rj9yHyPNUaOToRGN5OyDbhcCDrhdeE1WIHxt1Fwwwm39PRnXOaBq81DZ75j+IOVN4aA0ef7e8MGpLyvnsSg4bxzlwuPt9iumTxk0UogR5YzdntR5io=
Received: from AS8PR04CA0127.eurprd04.prod.outlook.com (2603:10a6:20b:127::12)
 by VI0PR08MB10460.eurprd08.prod.outlook.com (2603:10a6:800:203::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.29; Sat, 12 Apr
 2025 05:42:50 +0000
Received: from AM3PEPF0000A78F.eurprd04.prod.outlook.com
 (2603:10a6:20b:127:cafe::ff) by AS8PR04CA0127.outlook.office365.com
 (2603:10a6:20b:127::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.29 via Frontend Transport; Sat,
 12 Apr 2025 05:42:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A78F.mail.protection.outlook.com (10.167.16.118) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Sat, 12 Apr 2025 05:42:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=drSSWN/BfDcuI1Qcvr+B6GJDYPjeF7+Tp/unNFfn12ZvSrh3FnzoH94JH/dwVQnPPkmtZ+kQRSPj5jbZOgzGwIMntUSktrbdtK7Tvi2wD3VU/hIXBgZ0029bDWZ5o0u57j60kbydJ6Vb1oixP7LyvGZ7HcQ9NvcVkYM8Q5HSwxiIfmGK2rE4Nmw0yyHAvmkQEtmu6vj7zYHpydftO5RN2FjzUG60EG6vOlm9W22Uys1eZZ64Cs/V6ZjaiijW6C2FEYlqY2k0uNBOVrkh4Ydj5cf7AWzqO5bma4n5ZmyzelqKDHPDWYto3fl8OQVvzzfsfTECteRo2RKdd8B6mywwJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVBPfq55fvcq9zvmq07LWwVaY9KfKDn8y5Hk3YWBW+I=;
 b=DTtipmTAbim/RvHAGLuH0sNflN+6ds+9op1Ss7Q/R3b4PbaCZgszPsTu5J7tVOmfhJHwnC7/zC8ZmD2IIUc+T5yqzpBK4tyynF7be+n8u5pDrA1UAEjbuEu3FlkRXe6+ZP7IPo8AIvn973IZL330QEI77Un99822O5t66tOwtotefY0lnPBtqJ2PXs0R49nLPmzIefUXXfn38+xJ8OteEqWkuPymB6xLQ17hBCN+YxCvFJDP18nb/P71/5m0wIO2JannNJWUT+s6/yY5NVvArqwQzfI/zFBdiyGDnV/4qTm/xqN0GfBHSRK6MINJflJZJU3yHNKaqzS5VRvYRr3htQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVBPfq55fvcq9zvmq07LWwVaY9KfKDn8y5Hk3YWBW+I=;
 b=miLC1zij7OMEPhWttXPBOFYJLgN58R1O3YLtRet+J3aM4E9S120O0oZ88Rj9yHyPNUaOToRGN5OyDbhcCDrhdeE1WIHxt1Fwwwm39PRnXOaBq81DZ75j+IOVN4aA0ef7e8MGpLyvnsSg4bxzlwuPt9iumTxk0UogR5YzdntR5io=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AM8PR08MB5843.eurprd08.prod.outlook.com
 (2603:10a6:20b:1df::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.30; Sat, 12 Apr
 2025 05:42:16 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%6]) with mapi id 15.20.8632.025; Sat, 12 Apr 2025
 05:42:16 +0000
Date: Sat, 12 Apr 2025 06:42:14 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
	stuart.yoder@arm.com, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm_ffa_crb: access tpm service over FF-A direct
 message request v2
Message-ID: <Z/n9NlSgbWb/Dxfi@e129823.arm.com>
References: <20250411090856.1417021-1-yeoreum.yun@arm.com>
 <20250411-olive-wolverine-of-chaos-513a2b@sudeepholla>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411-olive-wolverine-of-chaos-513a2b@sudeepholla>
X-ClientProxiedBy: LO4P123CA0684.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::17) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AM8PR08MB5843:EE_|AM3PEPF0000A78F:EE_|VI0PR08MB10460:EE_
X-MS-Office365-Filtering-Correlation-Id: 86997c7d-fd0f-465a-2b0c-08dd7984dbad
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?yKftDyy1tfBJIP22X/IExamm/3NTvUbe3niWnDZsTEfH6TMxshJh0/vdH3p3?=
 =?us-ascii?Q?qrNwE2jfwWVaBJszoY8ufejN90vbLG6r97q0vWsSCBWMFaFOGqh5f/tIqliR?=
 =?us-ascii?Q?aBHzedy6zLLp4UWWyo8CRFjmu+ALYo7+LW79b4Ypf/dagwQJAz61OJ6Hysji?=
 =?us-ascii?Q?lk8ndQejlQpP6XXCe3eR32cFtjG+xbO7BoiMyqneJrSr1CHVoPtTe/wjFC+3?=
 =?us-ascii?Q?WOG7OPdgFCVE7UUROIjeL1UygselG1aRCxFuDYa0BGuylaW+9MooY+nTVElL?=
 =?us-ascii?Q?o2MyVou8Zua9LchWTGlkruwnmElrmI5+fVQ/wA6VqG7F2p8YdiF0s1Evkpwj?=
 =?us-ascii?Q?7iW59QcAUZVTjMMRF8RdE9vNbBDUBEQKKUBO82JwJ1qIbPT4CPQjnBciwX9H?=
 =?us-ascii?Q?eSSkDVxkDqcj9rtbsOC7DZFHXOtNbJGhvxR95U5YfCKgQ4Qb/s/zUyz8A7hx?=
 =?us-ascii?Q?umWKoG8xqtMMFl/WnZxROsjDLX+lorkPNWp+oeEYVLedabl+stxMEu+kHb+4?=
 =?us-ascii?Q?QcITjjtlxmgzZETvB7XSBASQhSh34p37FXRy4StgAQGleumvYW1KZvgi+yh4?=
 =?us-ascii?Q?gClUPmIZ/lPmY8itIF7rOdue5mogGaVG10zhhExv+y4/RGix+qmRh2CvO9Yy?=
 =?us-ascii?Q?ZofxSUfWAWuUYX9pYlyL2LaG+uLePUYRe0bB52OJwFfST0ClasYdulwl7J6v?=
 =?us-ascii?Q?i0y006d37AstufN5E+2pzbGG9jutSGOwHvDOUYCB14/nWeofbjNnP8XSd08Y?=
 =?us-ascii?Q?LS+akwdhoUTJpsQvZZuFpK4PNoQvRV8zZR6xiZqsfQ4FL9Aox7Mab7k5Q9mZ?=
 =?us-ascii?Q?Xhdm6BwBCQMaoE3tlNsfQM78S7A9XbueHqDzuAWkAp8V/O5tBDPe8RtLz+ax?=
 =?us-ascii?Q?6GbAJy9q81V95qznYPoc57lYa2qvzrt29m0oLizHn8nYijNG4y+DZcZr4EAW?=
 =?us-ascii?Q?jt5r4KRhmcT+bwOJgIjNGU0D4vdgQuIhx39adiY0vybamQpNRaViMbbvhjAH?=
 =?us-ascii?Q?prK1980B/vU/q0jEhLYU3Ap4f6qYeLK5xPC2mzMTHt5fZNHRsj8TM72plYLN?=
 =?us-ascii?Q?CnMxVwR4phW/WReqMT2DApUBoIApjL3FrsXhmUdllSJn2UFhTLl8Jx696xzO?=
 =?us-ascii?Q?9Zj+YEao+QOO/6xDUTpfsNDExRJ0opBNPdU/ZOP1xqH1OTWjEQBZSF1x10Cg?=
 =?us-ascii?Q?fwRIAjFvo9dTrZ272NaIoDGLQzYEypmNvsX4D8hRJMSwJeNSSFaRRTJpE9Zz?=
 =?us-ascii?Q?FpE/cr+jwmVgrrX89I1NDc6tMCkBoZfBi/cDQI+gJSXtybjAqHxB+q9i/fQU?=
 =?us-ascii?Q?+Rnk0OWWF/gzdsDPS1cn1655c1Fla+u9J9T2VSAyc0CrAxHpHf+W6r61aoje?=
 =?us-ascii?Q?lLlrmgLTEb77te10kdVeNyM5Sjn4snJm9TFzf5NVdbnuDHxl4rjXuh1TpsKC?=
 =?us-ascii?Q?uMKQrxPlw7s=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5843
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A78F.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0711042e-967a-4fe6-6aed-08dd7984c88d
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|35042699022|82310400026|14060799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PQWHo3mLLQoTrDzY+4uvB3gv0qIeh7EsgJ+1tHv12+yKJFcJFxfQtN/Mhfzx?=
 =?us-ascii?Q?NTovkLJ4aA8geOUbkQiMfcbCv7R7Of4w/TZlWPV3mgvXH/hzX/W3LKqk2Ggh?=
 =?us-ascii?Q?5317EpN3ouwxMOWuNLeBnGbutKO8bXH6ckStrrKr0I+3fj740wG7GNcH+GYi?=
 =?us-ascii?Q?q99BzTGdfh9Tv7ISARXoOpqTVimPqolOXyNejuynoBoMNCViBgcbjz/2zjOg?=
 =?us-ascii?Q?k2EK3Qzk8RzoOZdNudmB+0/UdVLJFwAkF66gYQE7NysUIA9OgyncM1WTenRl?=
 =?us-ascii?Q?yEPHGHjFva+QjDHPAO4TM527tq8ItRoiSQinNl6JMZXo/+tkIlGDROwArxtA?=
 =?us-ascii?Q?mlpe7NCS4S/3OjSt1j77tTc3ANMAVrU0r2wfOsDdhZKe9tuV5dGKm4zug+ON?=
 =?us-ascii?Q?ZWJl0Zm39Es3UxCgeVZS2D7TmneuVYo2Ot2Cfd4XK8vtfOOpaD+rtRJETc7x?=
 =?us-ascii?Q?tp9NEt5OOKTRYHDWjTf17zhksfZ7Emc7w2wxGZYm6esLU/OH9uhePHLpJajj?=
 =?us-ascii?Q?AdCeClJNN9jnD0tOHUB9lYISv86mJLQV4KAh333ZywRE2SP2p6MwB6wPvFDU?=
 =?us-ascii?Q?flCHKGhTVgr9BUNZcQ/rG8uq7J0Gj4tNhv0ElpkguCtVyANM3AW21uO6e9dX?=
 =?us-ascii?Q?HdW37nPDmuQ/cvjZYPcNbpas23sAkEzpqvfNaQd8AAMc5ITtD3pALmIYKIvO?=
 =?us-ascii?Q?KH03/myFWF1itmVUBYblQnUeMwopWtfNBwHWogsxTi/u8zcTs74zIqXjJ64i?=
 =?us-ascii?Q?jgu88UXPeTVnZ2QSuvHw5YXhx62QNvREaDyd/NLXx6cKX3yc/CASg2nJ242o?=
 =?us-ascii?Q?PY/a33Jq63Cfp1UOxjkQRiZ0+uDy5LZaJ0QYf61DWLtRQL/BRWOc6Htn9Y0x?=
 =?us-ascii?Q?ElQUVtQmZlb0+aKjzghQrqHQfIFyjAf+RYoxSaP0EQuwoHRtlvWldInT5efw?=
 =?us-ascii?Q?5Z7WF5T7mwJSx6oQerA/bv+QWlgb2b+r3mdaHy/1esYEx0HPzCG6OEFPFnX3?=
 =?us-ascii?Q?qN5fmtLJ4XJxVGKX0GYguztUTHPZhz7Yk6a2U51+eLe3Oe8h9mGR8pVPM+dg?=
 =?us-ascii?Q?6ZaKnGvTVESCwzGHxdiL6ZCSl8Lm2HGWxwXhZDYQcNjh5XODwpziZTiOLvvX?=
 =?us-ascii?Q?AUvQXWiaygT0SqGLszAxq8C5u/SwzRts73Ws1IGuzsCniY5OXGVAadJy/gwH?=
 =?us-ascii?Q?zEpvNo6+oMRU92h7qC0VfVj2OyUq+jsFOmhNqdW9OhGpBNxCtkOR0Roq7wgq?=
 =?us-ascii?Q?k8t0NVm1LjcCP/h4u0tOljpJC3c5zmkO1Iar00plOuImQ1fD0gtyYabFaj06?=
 =?us-ascii?Q?JFPq1kzW6QnO91H24oK0Ecb66pjY2wbaBjOZOH43UuHXMTF2+04WOCoo+Lsr?=
 =?us-ascii?Q?az67LkfOPHRW62J96kOduuhhS8Pvc7HmvpllarOBVZEJtDX318wlhjACXjG8?=
 =?us-ascii?Q?knQQBGA3s4EgjTm0xc7r0F2umJt6QwJszeAnB1+6MkpkQhQImb8QXX5VkjLU?=
 =?us-ascii?Q?Zk/ShKj/lqwRPYri4bcF1ONOJyh3GpkxY2QP?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(35042699022)(82310400026)(14060799003)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2025 05:42:48.3900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86997c7d-fd0f-465a-2b0c-08dd7984dbad
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A78F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10460

On Fri, Apr 11, 2025 at 10:17:49AM +0100, Sudeep Holla wrote:
> On Fri, Apr 11, 2025 at 10:08:56AM +0100, Yeoreum Yun wrote:
> > For secure partition with multi service, tpm_ffa_crb can access tpm
> > service with direct message request v2 interface according to chapter 3.3,
> > TPM Service Command Response Buffer Interface Over FF-A specification [0].
> >
> > This patch reflects this spec to access tpm service over
> > FF-A direct message request v2 ABI.
> >
>
> From FF-A interface usage perspective,
>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
>
>
> --
> Regards,
> Sudeep

Thanks!

--
Sincerely,
Yeoreum Yun

