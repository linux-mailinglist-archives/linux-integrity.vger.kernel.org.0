Return-Path: <linux-integrity+bounces-6398-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8581DAD3D32
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Jun 2025 17:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15A3A171072
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Jun 2025 15:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFBA2472A0;
	Tue, 10 Jun 2025 15:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dz1vt3Py";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dz1vt3Py"
X-Original-To: linux-integrity@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013045.outbound.protection.outlook.com [40.107.159.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929D7246784;
	Tue, 10 Jun 2025 15:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.45
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568969; cv=fail; b=jtkLDhjLFUiO+/V0JuGp152g6DbZrRIhpggS/KwNcU6euRatgmUs96u2HUYNHwVsAV2vNuZEU3taDZHc76TlwOuk56Q6am/u2Foj0p2iODniWjRElIb4DbH5gscKeScGxPWuy00B87MvRH19QXqbrflmt0DVzdx210olw/lpUME=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568969; c=relaxed/simple;
	bh=ZDhuLYT97ydcWWGMasR+UeJezhNO5aS5WpOLn99oxzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TEPIBj3TOaFw0DK7U/8LrcXXun9V1eQI4Otvrt5NMYHu6bLjpTijY79PL9uT7qpSLPVVYv+rZBvKhjT6vfR5UunP/kRh/+tnY52EyQ+2jyN7V+hTNbWsLYmcE4yoV510xPpPjp3Vy1/IFw5WAy5YtC8fvOJlIA+0OdHWgD1koZk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dz1vt3Py; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dz1vt3Py; arc=fail smtp.client-ip=40.107.159.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=SS4eF/v8MlTOohSeTajX1ZwK4Jp+1XcQ6IPzjeblf9shFiysXCBKQ5saknJKlI0dMDovBAITRM0tguQyBXa4tu66hlLB+9t1P0DNeYQMWgThc0tZqjGVSG4pWA7mQjqXH3umS2xfSnJsTg4begzu5n3cjijUbI36G6dVEqDX83RWWi142VFpIQg8LzvCnbEuB2GnzJEY9krPrw6CJlDd+VQN1Lo5NQO0/2VsZfZZbIAwdnjjlh5rmmhi6WF9pNNYlIBVfnyDhkJfTKtat/oANr81UMWv1GPmySwRxv4mwidtZQ6O7f0MMdf98s7iIuapgpY3s4NFwPW7BTyP+44A1g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDhuLYT97ydcWWGMasR+UeJezhNO5aS5WpOLn99oxzs=;
 b=M57khv+tewbHw2Xbdj3UMIhSzA/scKuomlKrjttGfJH232ptyoDedQr0Z6yKNSeRJMthWI8JWQPshzLw31W9oIBYfRT9ZpjgLragCas8E52QniYuUbK2mX8mMwDB4YUEMvdaLlM6NU9xvRXnYQfdbW32jVmGR8ihhOscoC6eWdPGgq+Y5p+oybtw/Wj5pradjBTttoa5CxapAgS7FypDNK0Rg5t0PEgn6FKZVvcwo2Uu4aHkNIiRDGv/eE7/aQr+4Emrw6YYFzAjMyjbbSPO90HuILtC3X4+Hy4J/4IZr7fBmqrzKwo2+z3kJp9emyHPDKXJrTizix3LL98UDwdaCg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDhuLYT97ydcWWGMasR+UeJezhNO5aS5WpOLn99oxzs=;
 b=dz1vt3PykMgbmYzQISZCvcsE6OaINBaCFxaL/Xu/f3ojQyu8pzaPr0iqSL6DkRoQ+6SGu9mtMpWVi4et5GqWCrjNe6UHXHrORtfhRLC0RwmJy7VoKi+mfv92q+MpdA8Rwkna1iQHfKwcsGIr3Z4YugZCe1pmyRCej1zYuTDDvGw=
Received: from DB7PR05CA0013.eurprd05.prod.outlook.com (2603:10a6:10:36::26)
 by PR3PR08MB5850.eurprd08.prod.outlook.com (2603:10a6:102:92::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Tue, 10 Jun
 2025 15:22:41 +0000
Received: from DB5PEPF00014B89.eurprd02.prod.outlook.com
 (2603:10a6:10:36:cafe::70) by DB7PR05CA0013.outlook.office365.com
 (2603:10a6:10:36::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Tue,
 10 Jun 2025 15:22:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B89.mail.protection.outlook.com (10.167.8.197) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Tue, 10 Jun 2025 15:22:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4MGZo/BZQ7YAHzRIf+/T7WLpzw/SIAcvJd6J6LZZI17/yaKxrBLGB0D0CGi/XKzJoEwqhv+xO2s62j0xrH7nItZWU3ofOaM82M1bkVjubnoi+9V8OhgFNAQo8/rnyPUWhHvIVy0yanUHqVjU+vcdt3usb1+0Br5aKsm1yD+Ti99aNxKQUEazktGoySwhP/VEY2lxrRG+NndU/kJzbhSu3/qySrEil//zGQRxa9xOnbD1bMBgTSD0901JvFgZzZgpTYziwwYTPBJLPx++RRopDGKO+5iU8xhft9uLy8MuyAPK9Fcti+wgo3/QxvWPkIxVQymPJ/LFUHCVeW2EHzPtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDhuLYT97ydcWWGMasR+UeJezhNO5aS5WpOLn99oxzs=;
 b=OoitVkgjoSC1JFAIM5F7K/MeDeWa0Rw4Z/7+5KI7F+y69tjzihjjDfrDSt3LiftL21JhAWQ7cx6Ycb9W0kzF4sYPJ5OMwwRRX9q9s1DeZSNKgHHD35d8/1TU1vA2SKnH0Z87g0xB7PHnTrt8YHJfRWh25ggAgJZnRqqBNhPQ6y0yoe7Kc1gqPT0tumXhSlD/tFg5gvEi5cIlw4hJNjzCVFYjyKVeNuzRamFTNXZuqFakw6421z2BB20eO2T0gGJRzcUHHEIoMAn7mbbriH2XXwZVpI89exf1teeXGugAf5amhmp5ti7lu8Bfildz+GTJjrCRi8hs25bvPhqtDiqHNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDhuLYT97ydcWWGMasR+UeJezhNO5aS5WpOLn99oxzs=;
 b=dz1vt3PykMgbmYzQISZCvcsE6OaINBaCFxaL/Xu/f3ojQyu8pzaPr0iqSL6DkRoQ+6SGu9mtMpWVi4et5GqWCrjNe6UHXHrORtfhRLC0RwmJy7VoKi+mfv92q+MpdA8Rwkna1iQHfKwcsGIr3Z4YugZCe1pmyRCej1zYuTDDvGw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by GV1PR08MB8154.eurprd08.prod.outlook.com
 (2603:10a6:150:92::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 10 Jun
 2025 15:22:08 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%7]) with mapi id 15.20.8835.018; Tue, 10 Jun 2025
 15:22:08 +0000
Date: Tue, 10 Jun 2025 16:22:04 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: sudeep.holla@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
	stuart.yoder@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 0/2] fix failure of integration IMA with tpm_crb_ffa
Message-ID: <aEhNnAxlToRMteA2@e129823.arm.com>
References: <20250610060334.2149041-1-yeoreum.yun@arm.com>
 <aEgmhwu1RP27yBpw@kernel.org>
 <aEgwpXXftXW6JNRy@e129823.arm.com>
 <aEg6Bgh8TqzK5nSu@kernel.org>
 <aEhDY4VlkIPYAjPE@e129823.arm.com>
 <aEhIPC95FisptBO5@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEhIPC95FisptBO5@kernel.org>
X-ClientProxiedBy: LO4P265CA0132.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::13) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|GV1PR08MB8154:EE_|DB5PEPF00014B89:EE_|PR3PR08MB5850:EE_
X-MS-Office365-Filtering-Correlation-Id: bfb35f21-4676-45b5-01de-08dda832a42f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?LkOxlpRIgOpPn3Z648OqnUlXXxv+9N7ZEvj67EyuSDNmlsXYtqApAnnCCoiQ?=
 =?us-ascii?Q?mtsC+WU0atC0UM3nqj+CsZSmJtmPe5ua6+45ZOxTljGJA61xq9ySoJBvN8LW?=
 =?us-ascii?Q?0rbE5XmxQL6Ox/jcM1vM9UgNRvcOkTTNAexOgX1hGTGPr3qzFMC4rdZlCPJn?=
 =?us-ascii?Q?TqeVEalyxsIgV/OGOGTNjB0e63PFnJceyMtUh9348zkdADGY4qasJZ/BULi2?=
 =?us-ascii?Q?JVXBmtA0U6PYD0/s6WyFA6zEDmEKsrETX5KCIIDwf0jfik2Mchp+4XCWVD4P?=
 =?us-ascii?Q?/z9ZXzfGImuTkklWLslNqufLX5+xWGwFw6eo5mv0YBF8Ow/1XyIzl6Hu6wQr?=
 =?us-ascii?Q?FVg6dxRVGQFApfkio/s63R4d68MMJmjNF+kUZBNWkoTIQ6i7JZRrfgW3iNO5?=
 =?us-ascii?Q?XIIihAusC1bNDayuh3KgcowyAnZ8BshrhiRrrYPycK9AVFkrH6oDlQpQwnGn?=
 =?us-ascii?Q?yFDBm4sj8Wuhmp/inl0Q2iIcde6IguqfcAyi6pnYyEWkMEonakqwXrWBZJJz?=
 =?us-ascii?Q?Z1NDhUH+XVnb08QZgQ7+AkNdto+bPDPKzsR1K62T+yl/vWS9uFIZP44F08Uh?=
 =?us-ascii?Q?8eMa80ilpSWffigENP0F6fWz5geDguwjLdO3b0Rg9S41z0OtHUB3/gFEBAF9?=
 =?us-ascii?Q?jX7T5G6B/QvdOcENwd371uDU864TsxT1gN9OEOccosGfeAvVGPndudJsSU+O?=
 =?us-ascii?Q?xAhe71sW+57cAeScmplx9RsmlH03iLLZMw5fCaMNgOKDjJBkK+0A9q9ceLZZ?=
 =?us-ascii?Q?w1Xr7DPmXQecx/D3DuD7cKRXtXZIKpQu4mJPVKQGc3fMFQTONfPVdBaZf/RV?=
 =?us-ascii?Q?pvyi9QXorhASqXywKXkhqovlcnqfSIAJpqByWKjpoyipuHB3FCogoPZZeDHe?=
 =?us-ascii?Q?fNFL4x76QflAcNuKW7K4KXFg+W5wDyed6mBRN0Oud8IxbRxwiV5me0WPyp3a?=
 =?us-ascii?Q?NAgaadhhAEZG5RpJTe4hBFJBkOcOgxnJeE4lm+uW/U4DSfNpOsNN1lDugkmr?=
 =?us-ascii?Q?WXoIUFiEyVG2+uGrZpE1Tcd1Iii75uE+PheiFskRwzMNGZD4QUT4R5h7srTx?=
 =?us-ascii?Q?A0e/1pGJL+M2h6y3wdnnBWTXwaXWyq6WS8uOur8VFvhdLKs6IFv5NT9BayEa?=
 =?us-ascii?Q?IlCJJEfZADhhJxY00Y+ZmdaJ95DGkfiGKQ2M0hs02/H1RNSVFMJT2uxvj5HD?=
 =?us-ascii?Q?cgij/Tr6H5onSCieZL0Je1d4PrQH1MqC4vCCvg8jsHy8rvFXNu8AJXD6AS7W?=
 =?us-ascii?Q?mnoQgGlSGngGOjTOnz095tWbac5dV00pvF5baZLfBcVI946cwJ8tQB5bD4DU?=
 =?us-ascii?Q?pbxU9zUTdjMDCOYtSIPLYaBgcXOVpEgKQKwkVHKSq11r8lFc0onyMD3OCoWA?=
 =?us-ascii?Q?uwV4vmgVMW64svkbRFBYZ9RJcE7fMyJCzkc/jiXv0/UBaNdNT9T9aFRFkD+d?=
 =?us-ascii?Q?Rg5oDjzXTnY=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8154
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B89.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e6279e4c-dd02-42f6-a0e9-08dda8329076
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|35042699022|82310400026|14060799003|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5lBh2KiuuOX1T4aPXApVioT/Of+N+NClhlIX3ixgIQRK+sAMB+bQHfiusOw2?=
 =?us-ascii?Q?6+Xx83zsTyWCshkv0VdOUHRcJQ8drD+O3CQ/XCSkD4Pi4V90RP4WqIRp+EDW?=
 =?us-ascii?Q?n1+c3xaz/PvT+UuC+7HfA/NCy0iBg/T++OJ6E8DZOJDI50vhpNf2sm1wQVjo?=
 =?us-ascii?Q?UtYcnqT3dw+x0V1MCEiaSx7SOtwTxtK1JLuZyz/pODd92Hnf9lVmr5VSKHZu?=
 =?us-ascii?Q?ociMI6yumRHxPvWKDNg2Fhm4s/ZSIpwHuUq9fVM82Cv38V1buv0LCkn4Ln+l?=
 =?us-ascii?Q?uwUi/z92op4vZa63ZyMMzXBw6LnD5+oiBVWaxlyPlwt0qEq+8K6T4wMlRGRe?=
 =?us-ascii?Q?Hs2zTlgIBv4LZK0vT8u/jYBzdY3EuipfrKb4buX730HksV8pKlTgLm6J4170?=
 =?us-ascii?Q?E/hClZu4RCMVxLB1kGx90W6vaiUFhTFYNvZ1SNXMp7LRkTZT8w1PeZQpzEmR?=
 =?us-ascii?Q?YROaMk1sgEdXCqWVEdIgWJcdK3rASS6tRucKd/OHiznLedm6BSP8MUeV/w7G?=
 =?us-ascii?Q?JezuH8gnbjlbzxvKiUNrypXBQ9i+35mckGlGtW8iKfbkZ+VrIbWd69guK55B?=
 =?us-ascii?Q?VpxTT43H9aVj7CEbD0mHhOqFAJFOQHVng+Z6VcWOjHTkBf+nRTFHSVbA+/Wm?=
 =?us-ascii?Q?rfJNjNWYcsl1g6/WmytYNMPnIm//UyuCsci/Hq4R9fE1D9u7fUhdHRxncxWC?=
 =?us-ascii?Q?DTxHwVDYeoIjNy0J5migV/WfCz+OYJ5O6sKNxs434r5OrFKkr+GoKBvniG6M?=
 =?us-ascii?Q?JXEo07Ga8v+b/Rump3d1tgEA34AS18Jc0OpVtiCFZz7HhXB4Wp4z92wHQ2jK?=
 =?us-ascii?Q?rwiuFTC0FDodPsY/xC+ZVD8Qaj498FPJGEO+9uJf899JnAn4JMvEGtiy7BlD?=
 =?us-ascii?Q?omrgZiccUN6CnxnYUF7QEunMkoO73h5uvQ0M3CgFRmNnS7bboxZZqxazMkzl?=
 =?us-ascii?Q?8kp23uw7DGEdKsaWhWqD2yqqNeVVuIaipn4XboCA/z4MDeT9opEhGr0hlZhV?=
 =?us-ascii?Q?9YdEalgYgWmdzXRGGV5ET6hgBsVsdsX+GQQVn2WHObXkH5LKRQ0kkj5+vJ/J?=
 =?us-ascii?Q?G8f3/6H76U9wRM8DVUx1Cu/HHAwmFO2v6bzqulMlRzZZ9M6jP9C5eO6jemfp?=
 =?us-ascii?Q?Bd5FhZy75DTuYsUBVLSXlIBuLUqnj3TgR6MbrUUSUQVRVb56jUaYYh0OLlyl?=
 =?us-ascii?Q?7hprNH95xCHqEU7P+mZ+jWgm4VmT1QVBi5irsaeEO5eFAi1p20+2UyIeh3Vz?=
 =?us-ascii?Q?OhFwDpbE6HTwaQG2MukxNA3rTh5Eu8i61R+OR5jxwXdBuN/TGLOkuXhxGYgM?=
 =?us-ascii?Q?LoM7AGRZGZbKPtURwIgSDNRvVIof4Js9aY9GGPa1BsjQlkQ5z0RlLxXGQPHP?=
 =?us-ascii?Q?tUdd7Ewl+wom8iSICtn8RJ+0IZSkw0A0TTx3gknG0N8yxXMNduaF+w5oWZ+1?=
 =?us-ascii?Q?n8dqNV7yPqxfosBvqO8lNfW5qwRxSC1ecj7PPPZmwFp5FgTPqLBxP9bkyQVC?=
 =?us-ascii?Q?KQVtvEnHVN0bu3rlDBtbQP5WuCUAIdJOsGH2?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(35042699022)(82310400026)(14060799003)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 15:22:41.0445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb35f21-4676-45b5-01de-08dda832a42f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B89.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5850

Hi Jarkko,

> > Unfortunately, when these components are built as built-in drivers,
> > the functions ffa_init(), tpm_crb_ffa_init(), and crb_acpi_driver_init() are
> > all executed during the device_initcall phase.
> > As a result, if crb_acpi_driver_init() is called before the ffa_device exists or
> > has been probed, it returns -EPROBE_DEFER,
>
> Please mention exactly this in the commit explicitly and then it should
> be in detail enough.

Okay. I'll add this in the next round in cover letter.

>
> > causing the probe to be deferred and retried later
> > during the deferred_probe_initcall phase.
>
> OK, if ffa_init() is leveled up in the initcall hierarchy, shouldn't
> that be enough as long as ko's can be found from initramfs?

As you mentioned, this is handled in Patch #1.
However, although ffa_init() is called first,
unless tpm_crb_ffa_init() is also invoked,
crb_acpi_driver_init() will fail with -EPROBE_DEFER.

Please note that IMA is always built-in and cannot be built as a module.
To generate boot_aggregate with TPM PCR values from 0 to 7,
the TPM-related modules must also be built-in and
properly initialized before init_ima(), which internally calls ima_init().

To ensure this, Patch #2 adds a routine to probe
the ffa_device() in tpm_crb_ffa_init().
This allows crb_acpi_driver_init() to successfully complete even if
it is called first, because tpm_crb_ffa_init() triggers
probing of the ffa_device via ffa_register() beforehand.

Thanks.
--
Sincerely,
Yeoreum Yun

