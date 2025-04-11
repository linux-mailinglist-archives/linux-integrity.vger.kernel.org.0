Return-Path: <linux-integrity+bounces-5830-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82911A8577D
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 11:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C32529C136C
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Apr 2025 09:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419FD298982;
	Fri, 11 Apr 2025 09:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Mf61Iwed";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Mf61Iwed"
X-Original-To: linux-integrity@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010037.outbound.protection.outlook.com [52.101.69.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EDB298CAF;
	Fri, 11 Apr 2025 09:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.37
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362262; cv=fail; b=ckQAP1YxoUdHZjmR5JUwGcniC5a7y1KSZVmLm7HNTCrDvwh4p02sStZ/eO3OVMaN+5LhNKJVf58nFKnDDGuFes64/VFASu3mwEBN5ut1x1Q5UbONVumEmswJIC13YMii+0oWLSggPq1Asjxp4e4SLVGdEpAzALVo01u1Pl+XiXo=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362262; c=relaxed/simple;
	bh=zXrzeppS3LktoGdD0AUDO6mdyf5BbwWkrEL+s1Q+pmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rZr3a7+6z9l7r7vhP/Aq1grrz91gqKAu/mlgiv7/YhNXrPc0rXHCWqDgzsdqA0MCHv/WMurxo/2sZRyv/1oZrh07rYenARXfpTu6s9PzHAWN03NCfuvKsYzUr47xiX6xVh6baru9F9+gq+fRZPzaxhBo/FBCUh+SvwH23F5eFqY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Mf61Iwed; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Mf61Iwed; arc=fail smtp.client-ip=52.101.69.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=JDzMtpst3hkj9hG5CwlOaQNPYlMHDwIInKTrdOglLU96Sopwmo+jVuYrWMjoGyedn2Ji8GNYnIYNG8UAtm3Bo2Fp3cSkQrGCQiGESuQ1+2YE1cHz7fwbhbEGQ57HoqTyVBfpWPMNHDxBoQeZWjRLDLGlwfpdHDZhR+bQpqN/vL+QqOEiAr+zxyIYdDwHD/FGGTXQSwm18dRDeYNhEX0BQa402e/3WS/LSGRqPY/z8haxDqXjr84C3Dko6xfrWp+sw638zHp+LHG3IHIzT3x9BkztsESk0cDvqKYcnW5IPrzHUMhRAN4uzHcBcv4fYdSa8E+ked/AuLydZzcNm34DFg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtP3zxkEeWhQM4W01D6DZhEvXU8jdFfGvmLMTPdQaME=;
 b=jBipDaiDTj/qdpxpyBWRAJNDT2p8AEAGwGidWq/itamP6HPYMwB4xQINRAIa6YTrlLpw0PTu3cbbc94bsPlfGe2isj2qSpMWPUhpsR0UGoWdARhCtls1wij2b1xFHp6U9aZ1B4QP3E/vyl74CXqRRgzTTKYfAtz7hbri/qpfHfwBjsaaAOazzbseookQJ+FBHFGAnyCahg9HC8gYvzctQ9c3BAuKy25qP3yyAm1+Xd5CnTqyTdTw5JRAqXmCEc856PNKHinYLAAjYYuipVV2xL3VWnq3ILkhrmm8xez6pgI0V+fRItsrpUYBVZlPZVVPlhEVsX69EeYuYxjx4twd4A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtP3zxkEeWhQM4W01D6DZhEvXU8jdFfGvmLMTPdQaME=;
 b=Mf61IwedOnhphX4N+SfyL9ErMFMCK9kqpMyq1NYHWzpetilKs/orS6WWT3haBsqgruSF4HgsfhmGO15P3pBfkU6Ysz7JUQVq+whgzI4p2Rw3Zzm8h5TQirD9adFFi0dFSq5181e9WfZzSu/smKEkfkNSI6kVSyaCvTlu/rOhmC8=
Received: from DU2PR04CA0070.eurprd04.prod.outlook.com (2603:10a6:10:232::15)
 by PAVPR08MB8799.eurprd08.prod.outlook.com (2603:10a6:102:32b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Fri, 11 Apr
 2025 09:04:12 +0000
Received: from DB1PEPF000509FC.eurprd03.prod.outlook.com
 (2603:10a6:10:232:cafe::e5) by DU2PR04CA0070.outlook.office365.com
 (2603:10a6:10:232::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.41 via Frontend Transport; Fri,
 11 Apr 2025 09:04:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509FC.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.13
 via Frontend Transport; Fri, 11 Apr 2025 09:04:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BzTo8qNLLAHrFOAsOSm4/q1yKfv1GNsQtBRaPk4jt77aZvIFETED/JHJHhGp6amUy1esR5+G2tptCDaRCnLAQCDhybc2tfxNaNmWj6uIzdNxfD2yIgsZIhnos+dLZWpxALBtSO0KUrOB04nYj0xJ4gmPYUlJRDK+r00btvyuuW9fAPn04Zr0YEbGFjTOylHQpkv4A8I+rrsIza8eHIgHVrLZXk0+NQgiKRJL49LYi+wDrXjVBO/u3R8Ghz+SmSjvoIo8ueBl1UwdIQk6oNQ2uQ+y1EuZVs8Itdgwod/gIRep0VM0pTvwCMnv4eeXW8FhepaD1BsDRJcU1wGgqyyJDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtP3zxkEeWhQM4W01D6DZhEvXU8jdFfGvmLMTPdQaME=;
 b=TlkZoKNca6xxpDPmIqcMgz0CEZDJda/EWxw4AKM7EUKbrv1YWTyoVxFbDebbFqiBJhlHGg7Ee3ABqDMiWNy99+tyPMTqv+8OnvEtOVvCBOEwVx5VkFYX9uqWG3yvz61H0yMLXWSoXpzR7DW7qb0cKqus8Lunrf229wUcta4CjV7pDNKYx3NAOIXr3CjfGZeFTnUBGhUPkt2iH4XqukngGkJUUgryD3Ba2yU6L6w4cvtH587zFNjOzCO98hWajutVR111DWhZ7MHTvnQ6GbjyDG4IEA0yk1WqCgHs4bhN/khEhkEFNLtU9oihEh27t48VA0CVyZvoKMP50wYdPUHYSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtP3zxkEeWhQM4W01D6DZhEvXU8jdFfGvmLMTPdQaME=;
 b=Mf61IwedOnhphX4N+SfyL9ErMFMCK9kqpMyq1NYHWzpetilKs/orS6WWT3haBsqgruSF4HgsfhmGO15P3pBfkU6Ysz7JUQVq+whgzI4p2Rw3Zzm8h5TQirD9adFFi0dFSq5181e9WfZzSu/smKEkfkNSI6kVSyaCvTlu/rOhmC8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DB9PR08MB7582.eurprd08.prod.outlook.com
 (2603:10a6:10:306::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Fri, 11 Apr
 2025 09:03:39 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%6]) with mapi id 15.20.8632.021; Fri, 11 Apr 2025
 09:03:38 +0000
Date: Fri, 11 Apr 2025 10:03:36 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, sudeep.holla@arm.com,
	stuart.yoder@arm.com, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm_ffa_crb: access tpm service over FF-A direct message
 request v2
Message-ID: <Z/ja6KO/03EkNz4z@e129823.arm.com>
References: <20250410110701.1244965-1-yeoreum.yun@arm.com>
 <Z_jN3pRlv1PuwHGn@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_jN3pRlv1PuwHGn@kernel.org>
X-ClientProxiedBy: LO0P123CA0014.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::18) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|DB9PR08MB7582:EE_|DB1PEPF000509FC:EE_|PAVPR08MB8799:EE_
X-MS-Office365-Filtering-Correlation-Id: e7ae3b33-f451-43b6-644b-08dd78d7d36f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?TCe3GmcEfWsyAwCCQNfpebKouI+nBwLkvDRkQLSIdhuedSgpv09K7y/LKTVX?=
 =?us-ascii?Q?DOQ3qM0laOgKcPHrdeY+ow+QEU7iwAn2On5cCrf7Tcft34eIxTHr4TtwoTig?=
 =?us-ascii?Q?YUF5WOagdHuF70z5kb3Ai2eMKkOETvA7OkE4Gl2uloedlJwzgF+2czUOlZU1?=
 =?us-ascii?Q?YO8SOu3u70khVqzLw7g+3jK4Vue45CqR88dxpsnqV8TIqGp9JzTvT0xGmh+w?=
 =?us-ascii?Q?IBlLa8GhHmyog0Ou7JOnmPtd0y4El0GOUGRN+9HQvieKMUHUvgudgXk18kq5?=
 =?us-ascii?Q?6vD5yNNlkqM6InZpFhGZj8xmDI1zyJcdEjo2m9vi+acyfgRGeJ4oZQOpddb9?=
 =?us-ascii?Q?WkzbDVst2+tftjzm3MEheHlXOJONDqG5QYtJ211MKxSAmUu+SNRXiz+f6KDT?=
 =?us-ascii?Q?4nvS0wwJt8EqOYx9c2M/Ldq8vtGDdP6LBLCDwsw3B5D77Nm+Ia/uiWZ3gUpm?=
 =?us-ascii?Q?Fqd5N0QZPvmeAUfPKq9wGfYXRFJ78z6p/PYsaOD9exdK9M/gK1ts6l43j539?=
 =?us-ascii?Q?p/r329Hf6K4NdB9f0aKy7tZMFFcC7gIsWu/KuSvjmpDwim3bZg2oZ5mhbXiI?=
 =?us-ascii?Q?fpLPtNxTXQ5QiTaYQ3bwNoU57M6OqZAq4hWiiYl/+JCwuJnFule7BU8THBV3?=
 =?us-ascii?Q?nAnhxFFp3EDmdI5R8EHQ+xWLJZlWGwnIAMK7KPeay5Y7GZ8gc1h6Zh5H0tku?=
 =?us-ascii?Q?u01odpkivmP13dAM8i+hNXZ/gJ1DFfmjM1Zd2a6LCWP3haYlJQjmIGoTTgmG?=
 =?us-ascii?Q?0xl+15C5yGDbIS7F7AiuV4GAEOa2s+Kkm/ljZqusnvwssqkmE0Cyag316tJe?=
 =?us-ascii?Q?PW+4GjbnonzQI2jviOVV4fAZQZb937RuquWNLkiVMFowYawUBb89GXiMsQIS?=
 =?us-ascii?Q?DII7sT9ewYUmM/4nBQmBvAXMQF3vrKWa/sryg8pyK8YMZZFpjBatWB05Exrd?=
 =?us-ascii?Q?//VRgyTPFHKA6I556xCfYpSv1DcV1rgjQOShwMwoTdBRJTykHW464Ef3v38a?=
 =?us-ascii?Q?4h9x6gqSae/ssHJ+h2+EE2hGPCtfGmhfQyxu2BHr4KFhdX9EnrpQVEqndMlC?=
 =?us-ascii?Q?6rmNtyS+qi6OQD+XWRrcewLQ++3Xo7TUbVd35VvJPPyVoM7/THCyCpoXogM8?=
 =?us-ascii?Q?iBDcDqdTJS7ehZ/4eCxsjKWtv4Lu8QnIz0i4vsCkAJsuPf+OKhyE7kYFr3er?=
 =?us-ascii?Q?BrlQsAfU5GZ1uFoKxed0SJq0KCjaPQQ37ltgb3oSvDaUEBuwvJsp3ZNKZIWu?=
 =?us-ascii?Q?idJBjhx97WV3DB+Jnio5BByRRhBxbmzazpkKyGrN1uOxJCIsVyjsUZv3UIV2?=
 =?us-ascii?Q?V7oMyDS0KQ8YC5eSIcbjr92LBm80sO1vypUPjlU96XaiHBdDoYtXpSdmqFJO?=
 =?us-ascii?Q?k+tWx5NBpjwRFUkE3CFDTwP6T8qxbFhjOKK4lpfJ/9CPWoakUCxWXxuK6nNl?=
 =?us-ascii?Q?g23G+eq63Qs=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7582
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509FC.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	7671e2f7-42ad-4da0-fd89-08dd78d7bf78
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|14060799003|1800799024|36860700013|35042699022|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yoKXZRigf7A6+AjSGlRDquB7vgb5Xxy1BEXu+3eRx7qW0q9csWheUF5aMTym?=
 =?us-ascii?Q?FSqZauEGaAOrtVlWBjil9mnqmO5xtYCNIPHyRrMgJPIG4oGm3eBBPux+1/BV?=
 =?us-ascii?Q?wF1KxFfUfI4y5xuo/88n7ufIXxYJHFK4i4F6Iqpk9zU8UHdqmED5C97Zbpzc?=
 =?us-ascii?Q?W1BBGRwazcPNxjg0peVB/JBXnGRgyuKiMtpxjNvXx4ZwBbQ1Y2ID1q3itzRC?=
 =?us-ascii?Q?vP6+rqIb3R6ie8nUWDxuUYOmQ4oI4nYWRl7e9lm73+wDj8upgnN3WDOIuIYB?=
 =?us-ascii?Q?ty45Nnzz+3eN83uZ3acBnPI51z6MzkkM4wAqvHevF6ENsb+mEA52PDPnICWD?=
 =?us-ascii?Q?ywNMzCjVp1APXCi/jC69EvYSEgXigrTS0kGD9dOp0O3eErF0uUTvLRKRJHpw?=
 =?us-ascii?Q?KW+6Zb5NwJn0sOlWGxXJgRhyeLm9LqTxdCao7bnWq021FtLyTfqXssmAfJ0Q?=
 =?us-ascii?Q?PULH2GWFsCU49knT3ooj119te5DTc9pI1RqWmvlC0VBvBjyW461dYwGu9H6J?=
 =?us-ascii?Q?YYEyfsjm6ZuXfoG8GFOS743Z13iS73fY2xrd99QP/Kot71ZeijGR+RhXlfvP?=
 =?us-ascii?Q?f2lOlB2yUTD+Nv4iVu+el/5K0GvalXtiMyw4pozD5ssgFCsOWyCkx8A32Aw5?=
 =?us-ascii?Q?ArRndY8gJCiMRRR8EoFTdG59Iau5AadLqASsJlVMeb3+RDFEpPm8pl1LAxHZ?=
 =?us-ascii?Q?WgFJiZy0n5txd2UAm85SXcDAL2tgDKwIgBfvGeZpXuhn3NSVbweboAJlQs8b?=
 =?us-ascii?Q?JbdFU7OtwvHbkuNheoZeyJNioj4m+O290APsBY9+vp6z3r8h2pK9fkUwhZvc?=
 =?us-ascii?Q?9vwF6jCmB5ctilHiNQ3SPsTs9HCy70d+/QOW0o6Zz/d52A1yV3s6nUHnUI8H?=
 =?us-ascii?Q?LSW6ii7YnJNOXqfbcbJ3G117tjESUX7S5EYx2fKh5DQspEJD38wmbT+GxlHe?=
 =?us-ascii?Q?0peYBHgLL3I+GnEpc5nHZ4DDj5IH1n14Efk79QywdN4Pwya7FpuCH/oNknkw?=
 =?us-ascii?Q?Edpklv3zc700DcCVgJpxwwQBscg3okc3zwUHfatWYThEJNLslltqK+XitOYE?=
 =?us-ascii?Q?smc2nQw4a4sNhNZ10Zy2uGmEtNHHALQCpTDXvdcJLdDmCaXW4k/iJKqnFFdh?=
 =?us-ascii?Q?AV5w8t9i97SRtiZOOzR2/zJNxW3ZMEBGKEAzo6xxBM0wjy7B9F8XmU5KtRDL?=
 =?us-ascii?Q?PaQADQFbsljl09WeSNfUMwBQ2YpIv3Ka3c1D+bbkeWwrK6aEvIGpWu5/pB4q?=
 =?us-ascii?Q?9Su3eqwaVutYIZ0ns83TTIfwiLtQgodx4Kx90CoZsTQaPoY9vzQ7Bx2bielV?=
 =?us-ascii?Q?bmU15cNcdAaUE1/Lo0d+xCUXTjOpA2YbNZrenRy8LX39a4OJuWUhdNY3GtUn?=
 =?us-ascii?Q?HE25/jl9IczJ12SrDIDQETE3mSwWduzgO348jQsz2fo4xcp9ANrh58kleRg2?=
 =?us-ascii?Q?w1ZL5wih3FB1l2LZqlKvAmTZ6tuukMF5LxSvRXLRyAfTDsxy93cdbxKZEKQX?=
 =?us-ascii?Q?LKWGWdj9m8oeQsQgfKUH7Pffx1wOIrbMZJIW?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(14060799003)(1800799024)(36860700013)(35042699022)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 09:04:11.5979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ae3b33-f451-43b6-644b-08dd78d7d36f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8799

Hi Jarkko,

> > @@ -277,7 +301,8 @@ static int tpm_crb_ffa_probe(struct ffa_device *ffa_dev)
> >
> >  	tpm_crb_ffa = ERR_PTR(-ENODEV); // set tpm_crb_ffa so we can detect probe failure
> >
> > -	if (!ffa_partition_supports_direct_recv(ffa_dev)) {
> > +	if (!ffa_partition_supports_direct_recv(ffa_dev) &&
> > +			!ffa_partition_supports_direct_req2_recv(ffa_dev)) {
>
> 	if (!ffa_partition_supports_direct_recv(ffa_dev) &&
> 	    !ffa_partition_supports_direct_req2_recv(ffa_dev)) {
>
> BR, Jarkko

Thanks. I'll send with indentation fix.

--
Sincerely,
Yeoreum Yun

