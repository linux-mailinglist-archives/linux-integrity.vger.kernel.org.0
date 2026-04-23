Return-Path: <linux-integrity+bounces-9296-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gF9+M+UA6mk/rQIAu9opvQ
	(envelope-from <linux-integrity+bounces-9296-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 13:22:13 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A841451396
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 13:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 418C63020FDA
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 11:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086C8364036;
	Thu, 23 Apr 2026 11:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mbdZYB1k";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mbdZYB1k"
X-Original-To: linux-integrity@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013014.outbound.protection.outlook.com [40.107.162.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91959340A76;
	Thu, 23 Apr 2026 11:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.14
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776943330; cv=fail; b=jWWfz/OZKDzroQBHO7fBLuYLopaspP8bx/vi3OAV61HGDyIC/yELgUlMnaEVpVZlDU58TwdyPrC4ntCpfUxHk7kjxM0Hdps57LmRjeFxaud/KQCgfvDnPQM0INWg5hpNDlXg85OoBjuAszDODV4p5jDY6q3vnzkrS8kXhpv68As=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776943330; c=relaxed/simple;
	bh=5bTlJYqpVUk4BUA4O6Kfa0uPpqu95nx9s+a/cWZ9om4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DWxrCG1f7j8+l57mHs5aeU8PeFWnLaX6kU+C3RiU4gkXsnubl0/56sttsvTEwBdzVxKvZBtq6m1zIlur28fq+z9afe6+JXMBMdWpkZOP8Lq+HC4XoSvfe8cshvFkjOf18FQave4X/NH8qPSNhTMAtLyaFkG944qA+jW9fK6z+fk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=mbdZYB1k; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=mbdZYB1k; arc=fail smtp.client-ip=40.107.162.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=vAi/BTX9Epku/fJZthniGjguZIBgAjKtFtn0zKVPs11UWfYRWn1OPrmID7/rZyjJ45xbPx6f/x45100S+NSy7oI8TiSJ9Y1Hf1T/OFTQVBKdUFnAlxYDl8eh3ampjotCd+MJBTdvCuu1sdyTNbf5I0kcVJtmDsp1nrWTuw1mpwMPk+keTuCTS6qSyqIXNUAGZ05RrdvLPiNaDqTv1KPIBV9IWyPO3wiwd6+364ZMtStGBeVuZ6maBKOdmTbDqRIDRz59QG50liG8MH5mO3qUgX9ncDE9y6YHbLvh3XqgR9mSlG2uaqA2dx3kWTi874laWNZ16ivdwgeSesG3w41bgw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuAvQfh9HFuz7gJxgCG5s8Je1RioQrP+RiZQpkZlbVw=;
 b=ZCfcvQ9ESac/TTXxD3iXQ4hy2QtX8YsaoSylzDY7NU8LlfcRNvCcpT/b2QGIGQY/t9TUpn9oGp8Y791AbeTlJhkZB+tvMRuKGgeSsEbQKXzJNC2ILyNog2E89kNzJBYxcBvxwIuN2Lm+C2Fx2H+MZxPcP7OpH+plmVfPpOnp6ZaanvDqU8/INxZFMv8WSgHHiil42BrdDpsvUGlREWRvGvWWmaNKFnFTzThFm8JBGNZXQGpnxwWpCthnqaNcYqEyW2YMSjNqWT+J/QnZJCvwZuRZLCceGB+wFqO5geTnLoUOfVW1k+ZpARoTRpB9A7olJjrUrXhyC0GwrOO785UvSw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuAvQfh9HFuz7gJxgCG5s8Je1RioQrP+RiZQpkZlbVw=;
 b=mbdZYB1ki/66X5cVrWzl9PAP5hus9t1Cgw65OwS3qWGHnngY5PS4LsiGdVpij9gm/9Yg6Vau8ECNoLcNNKS7S/KZSoRb4ujNKsVZTuY7X+l1JCZJ8Z2PYfxZUEv1MBWIx/n8wVH3S7HmsMmKaMzRx9OG8wuIFzoTPYQAzFiOPsI=
Received: from DU2PR04CA0232.eurprd04.prod.outlook.com (2603:10a6:10:2b1::27)
 by DU4PR08MB11269.eurprd08.prod.outlook.com (2603:10a6:10:61d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 11:22:01 +0000
Received: from DB5PEPF00014B94.eurprd02.prod.outlook.com
 (2603:10a6:10:2b1:cafe::6c) by DU2PR04CA0232.outlook.office365.com
 (2603:10a6:10:2b1::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.21 via Frontend Transport; Thu,
 23 Apr 2026 11:22:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B94.mail.protection.outlook.com (10.167.8.232) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Thu, 23 Apr 2026 11:22:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lzjFcv/WXb8hIOX8NVCuPdG58jmw6onM2e5+x2jjShZtTG8iNW6ffJNY4amLOiK0Gs4LAXTaP3T0pEMlQAWx0fHQvv3MTPkd3XLScKzIiQRe64d+AhLQBwfXUPqCoXTaDoZOvHCPWOaX4tFQjImELSuO6d5NMhaB+A8xelri14wy6YCM4SRCV4L7lvFCVy/LQCeHikyQxtPW5KW83kzXoQw/9SpgNiIYkjiNBNIsu/mWG8A6Fmkw41dLTzrd/9tWg4DqkpztfAz2eABRuaAHHWGvWSIORrKkAdcAjRkqpubzeoWPkCrRlLbvMopffKg8XrSitb6FfGygC5Uv2M/Xsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuAvQfh9HFuz7gJxgCG5s8Je1RioQrP+RiZQpkZlbVw=;
 b=dxvjvDUI3jABMBB0ci3bq3rmy2gQScEDx2VFm0Qkwp+30lm3FMNamj82Vh0PsPOXs+xE0xTzAJwM9QGb+umq5r/Yy9HAYn2/wl0+ArKAlZeTs7b8uB1TKKkvsdU3v72mOJQHm4IzcKIH5hFpFpsbVaBEDOmaN7TvObIF8GV9S1kcgj9cxfVOtCP1snKT/BXzMD6vlOG+e+5mlQaLML+ch8IG8Et3pCutwdHfO5nv2I4ju4zZfav8mVOZtJCd1q+XD0nJQGQJAIx7SGxytALQ30lPMxOwA42EH1e0YYiivNScM6k69u/jfnB6FivKq5zb+GYeifyah5DEMHgp2ESsdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuAvQfh9HFuz7gJxgCG5s8Je1RioQrP+RiZQpkZlbVw=;
 b=mbdZYB1ki/66X5cVrWzl9PAP5hus9t1Cgw65OwS3qWGHnngY5PS4LsiGdVpij9gm/9Yg6Vau8ECNoLcNNKS7S/KZSoRb4ujNKsVZTuY7X+l1JCZJ8Z2PYfxZUEv1MBWIx/n8wVH3S7HmsMmKaMzRx9OG8wuIFzoTPYQAzFiOPsI=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by DU0PR08MB8955.eurprd08.prod.outlook.com
 (2603:10a6:10:466::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 11:20:56 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98%4]) with mapi id 15.20.9846.016; Thu, 23 Apr 2026
 11:20:56 +0000
Date: Thu, 23 Apr 2026 12:20:53 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com, jarkko@kernel.org, jgg@ziepe.ca,
	sudeep.holla@kernel.org, maz@kernel.org, oupton@kernel.org,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, noodles@meta.com,
	sebastianene@google.com
Subject: Re: [RFC PATCH v2 1/4] security: ima: call ima_init() again at
 late_initcall_sync for defered TPM
Message-ID: <aeoAlVEwzRUPrlVe@e129823.arm.com>
References: <20260422162449.1814615-1-yeoreum.yun@arm.com>
 <20260422162449.1814615-2-yeoreum.yun@arm.com>
 <6919248bdc85dac60277fa9d9c83d8bd258ca635.camel@linux.ibm.com>
 <aekXaU52fzvNYaUF@e129823.arm.com>
 <aekkVQwueKbFtG7C@e129823.arm.com>
 <82803bb3b471898a77084c449b73c7f7b4eb2149.camel@linux.ibm.com>
 <aem0SSQuE1e3pGOS@e129823.arm.com>
 <56a8aab50a3b5ce0a345fc2079fb2abc7d0f1b23.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56a8aab50a3b5ce0a345fc2079fb2abc7d0f1b23.camel@linux.ibm.com>
X-ClientProxiedBy: LO4P123CA0690.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::7) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|DU0PR08MB8955:EE_|DB5PEPF00014B94:EE_|DU4PR08MB11269:EE_
X-MS-Office365-Filtering-Correlation-Id: 342c6959-4c16-413d-c0a0-08dea12a8a0b
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 GzPVDgw3nhVpciSzpM8kZN3Q7yIwIbzMt267XYeLFiu6owEzpiYdmMOIHW81+8paoRQjcnvka12mvXsAeM71MHr4h3+UfK0/vkO/0Y99RSLGF6VItYSO6/Q0T1jhIxxNtj5EgS25Dvwv/tD5v5eWRiz0ZVGtXV29PFf7ZtBPa6GdoDQYr3u0BLU1N3fnBGPAvZiufZJuG5bS+ChLIpQYJedwP99BtEMtP17UkB9Fe34dIv5/Wq5808fWUp6Y2XMdpg/euO5ofGFQm/Crhwj9B7Wgy2P9ZSxhvxWErZt84HS3cOCsrD4LX5pN7Tu20DrcXH0c1sYRDO5z/LSyEx/VLE4iRMyHXBsSLRw7xCK+r3tMwE/8DRS0yLevdsiv5noeypR5HkzOWD91Jn+9sUTkS8DDUx1FAIEf08qS0X4fBOaapc9lqzGmwIPA4bMKXUmmhxFOy2ZYlN+ICupmrp3mhcHkp+9v5ipu2hmsh3V/zI4AZPJycuhJe6jj1CJhkDRKtxKItNf+44R1/ccxtZ1IttBexaFgdePRl14IfcESYiVYq2W8ZEuyQCL7JoaC3sE8vEHiU12x2SwBs73zdrIuKsRAaDdBkiuu/JkL/9NYkTHaOvhzDmeIzvE2LowouzKlWybYFJiX9dG2coHOFNOrjJkM9cRAnyj99jTiXIYMvJK1TcqNkAYIIBCevlD04eK8344efGBybEcwgCESrePvAVjLiBhdo+31G56UJXBbL+4=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 eTLW73+1gf+tPkkXAUwJbTnSrmA0GrT/ZzVbW5P/ptm7Z4YGd+r/DrMnucS3VUR1kE+lmpMzoz/nHW5GuSP2qaJyHT9ZflxUNrcF2r4PfsqLhiKi1KBfAfcSn+IP9sQvJujZ3/yRyjLXBKJZcguqQ1+eK0ZVBlciBJRmp0MqNeyl8eF/d0VcsQx22phnjkQtaUTpOru6hWKXMB4aTwK38pw9zXb9ZqPPzE8XQIfcu/Hto+kyBzx0K1Ghv0gn9fN4zFzzhH72K1t4j3dwUsv7Vy2qWtAwNY2yFeSvAHamxfm/VPJMO+iwOX+CWHFJkSaBtgMTuAJxDrTsZbHg+nDclA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8955
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B94.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	91ffc35c-c850-45f0-45a1-08dea12a637d
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|36860700016|14060799003|82310400026|376014|7416014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Kd3gG6W5B5PDKUKB+pT6jn8+NYD0BG41wDYX5Ghozy+enj7SbLPhxllAVfpLauH2ZtzDGadA/9e2KtniAyQSCbHjmRMZql7xGL/xSyGOSfOXHkD4zZM/ErsRt+DQtgjQp6B80tlEuDD/u3jk30hTo8b0+QImHkcXV/b3gJueXl9X2bGEuJHA/IK4y9++mKtY7mtI7hDXLuyGJhoox8cyAcKdmFizCFNfWrvOERgmRvRxziT1FYXHizynuwtoOXW2tKrvG3cB3Jro4eCqIZ5DXgHFb9xtX6CqggtRJN4WFdgFkvfi0PherDS83YZO5hazcyYef7eQFfZXm3w7dEpnGNRBlvjQ5LAOGuGdYU0iEdeYZIJgrWxKD/U8tgCejWjTrHJA7uFeNXeMpSdWs/DmsMc0FCzInG29kIK6KCn3PNlWU58hZStCfW1xDUpugZkJePqdVek0uYzHIuVPhoqQBBEb/KckHCD/6W95jAGq+K20OaBkFgVo4NyafrStdKPym7Q65JlQ1fWmcH2gg0nosF7NDr3HSRxJ/GH2y+EDiJ91olEQFjV3R7y7WXHpHeHpf119i+0LthSMwc8Xc1LAhoGnZrL1s0LzAcgVX3Ar2KTyU97ZYyLGENp0yhuFnOUrjs0f72cyVbbW4scWztSd3j6ZgmYOEBvUtpLr41K1TzPMZLZzMxwJtjx7nxFfEwf2uCUVv9CTyVfxOvbeEwmD6PdHZpmvlaBwOv7iaxYvo0k4+CSE3AwJArCqmcr27vgnTkWTY8aRROvZjOVogB4vkQ==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(36860700016)(14060799003)(82310400026)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Xtmf3inV3EWOz3SbxGSBqQQPPBULk0X1EmAQ9PCwqw4zzu/kqUGMWQtVWBupOj0XRGwP3xgMlgBB0Si6oVdIrVgaLuZQHAr6mxc6apwzVvu+7Za7+nyROOv3HwUBikywle056nJHFTzgmsQRjZOSIRY3oLtK5GufNOxSCdtBA0KL+C5R4gc7VDVNC74IrLyfGCal/ZQqh1iH/IXQYU/2Wyf0/ZmdHI0OvZI84rAxe4lqknrmOas+EJEaz+ykevKr+YdlU/eJcvpddhI1U/o9km+Okkqt6eiMpMmcZg0fiBs+grkjTy2G2IlGk+PKS2lf0i39JALF1rOcbieBtx//iOw+X6/BaBL+LOTFCF/1y1LtPngSFSTHLW+bODck3MWKRM1DUJIkUMEI4qa4vVd25f0JgFXfdEPgYS9HcegznHaj2g33efN0fRuzD7iF2y4I
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 11:22:00.8770
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 342c6959-4c16-413d-c0a0-08dea12a8a0b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B94.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB11269
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9296-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,huawei.com,gmail.com,oracle.com,kernel.org,ziepe.ca,arm.com,meta.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:dkim,arm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yeoreum.yun@arm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 4A841451396
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Mimi,

> On Thu, 2026-04-23 at 06:55 +0100, Yeoreum Yun wrote:
> > > On Wed, 2026-04-22 at 20:41 +0100, Yeoreum Yun wrote:
> > > > > Hi Mimi,
> > > > >
> > > > > > On Wed, 2026-04-22 at 17:24 +0100, Yeoreum Yun wrote:
> > > > > > > To generate the boot_aggregate log in the IMA subsystem with TPM PCR values,
> > > > > > > the TPM driver must be built as built-in and
> > > > > > > must be probed before the IMA subsystem is initialized.
> > > > > > >
> > > > > > > However, when the TPM device operates over the FF-A protocol using
> > > > > > > the CRB interface, probing fails and returns -EPROBE_DEFER if
> > > > > > > the tpm_crb_ffa device — an FF-A device that provides the communication
> > > > > > > interface to the tpm_crb driver — has not yet been probed.
> > > > > > >
> > > > > > > To ensure the TPM device operating over the FF-A protocol with
> > > > > > > the CRB interface is probed before IMA initialization,
> > > > > > > the following conditions must be met:
> > > > > > >
> > > > > > >    1. The corresponding ffa_device must be registered,
> > > > > > >       which is done via ffa_init().
> > > > > > >
> > > > > > >    2. The tpm_crb_driver must successfully probe this device via
> > > > > > >       tpm_crb_ffa_init().
> > > > > > >
> > > > > > >    3. The tpm_crb driver using CRB over FF-A can then
> > > > > > >       be probed successfully. (See crb_acpi_add() and
> > > > > > >       tpm_crb_ffa_init() for reference.)
> > > > > > >
> > > > > > > Unfortunately, ffa_init(), tpm_crb_ffa_init(), and crb_acpi_driver_init() are
> > > > > > > all registered with device_initcall, which means crb_acpi_driver_init() may
> > > > > > > be invoked before ffa_init() and tpm_crb_ffa_init() are completed.
> > > > > > >
> > > > > > > When this occurs, probing the TPM device is deferred.
> > > > > > > However, the deferred probe can happen after the IMA subsystem
> > > > > > > has already been initialized, since IMA initialization is performed
> > > > > > > during late_initcall, and deferred_probe_initcall() is performed
> > > > > > > at the same level.
> > > > > > >
> > > > > > > To resolve this, call ima_init() again at late_inicall_sync level
> > > > > > > so that let IMA not miss TPM PCR value when generating boot_aggregate
> > > > > > > log though TPM device presents in the system.
> > > > > > >
> > > > > > > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > > > > >
> > > > > > A lot of change for just detecting whether ima_init() is being called on
> > > > > > late_initcall or late_initcall_sync(), without any explanation for all the other
> > > > > > changes (e.g. ima_init_core).
> > > > > >
> > > > > > Please just limit the change to just calling ima_init() twice.
> > > > >
> > > > > My concern is that ima_update_policy_flags() will be called
> > > > > when ima_init() is deferred -- not initialised anything.
> > > > > though functionally, it might be okay however,
> > > > > I think ima_update_policy_flags() and notifier should work after ima_init()
> > > > > works logically.
> > > > >
> > > > > This change I think not much quite a lot. just wrapper ima_init() with
> > > > > ima_init_core() with some error handling.
> > > > >
> > > > > Am I missing something?
> > > >
> > > > Also, if we handle in ima_init() only, but it failed with other reason,
> > > > we shouldn't call again ima_init() in the late_initcall_sync.
> > > >
> > > > To handle this, It wouldn't do in the ima_init() but we need to handle
> > > > it by caller of ima_init().
> > >
> > > Only tpm_default_chip() is being called to set the ima_tpm_chip.  On failure,
> > > instead of going into TPM-bypass mode, return immediately.  There are no calls
> > > to anything else.  Just call ima_init() a second time.
> >
> > I’m not fully convinced this is sufficient.
> >
> > What I meant is the case where ima_init() fails due to other
> > initialisation steps, not only tpm_default_chip() (e.g. ima_fs_init()).
>
> The purpose of THIS patch is to add late_initcall_sync, when the TPM is not
> available at late_initcall.  This would be classified as a bug fix and would be
> backported.  No other changes should be included in this patch.

Okay.

> >
> > I’d also like to ask again whether it is fine to call
> > ima_update_policy_flags() and keep the notifier registered in the
> > deferred TPM case. While this may be functionally acceptable, it seems
> > logically questionable to do so when ima_init() has not completed.
>
> Other than extending the TPM, IMA should behave exactly the same whether there
> is a TPM or goes into TPM-bypass mode.
>
> >
> > There is also a possibility that a deferred case ultimately fails (e.g.
> > deferred at late_initcall, but then failing at late_initcall_sync
> > for another reason, even while entering TPM bypass mode). In that case,
> > it seems more appropriate to handle this state in the caller of
> > ima_init(), rather than inside ima_init() itself.
>
> If the TPM isn't found at late_initcall_sync(), then IMA should go into TPM-
> bypass mode.  Please don't make any other changes to the existing IMA behavior
> and hide it here behind the late_initcall_sync change.

Okay. you're talking called ima_update_policy_flags() at late_initcall
wouldn't be not a problem even in case of late_initcall_sync's ima_init()
get failed with "TPM-bypass mode".

I see then, I'll make a patch simpler then.

Thanks.

--
Sincerely,
Yeoreum Yun

