Return-Path: <linux-integrity+bounces-9291-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEyKLOP06WmepQIAu9opvQ
	(envelope-from <linux-integrity+bounces-9291-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 12:30:59 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A745E450B0E
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 12:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DC5F301CC57
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 10:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8499537D127;
	Thu, 23 Apr 2026 10:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="A+k07idL";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="A+k07idL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011045.outbound.protection.outlook.com [40.107.130.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADB739E191;
	Thu, 23 Apr 2026 10:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.45
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776940255; cv=fail; b=lrItaEB/PsWfDAyQHxUIsa1N779duGV6rGaULyAmdIABaxM0pX6fmOTH/K/d+WoJIa0gViNbxJ+ew/SOgHQkd70ovkzN2z0pCBlLtqztsTkMAVfj2f1cwXPHfE5i+AMBGZSg3J78PaU3rNyzgA8yyAuosMkpY/wEMjTFBHuPZbA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776940255; c=relaxed/simple;
	bh=Sb/Z1XXot5hwEnfRDvLqc28KEyCv/YMfxx3ikRB2rgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P0IMho1OaPVtXzBAhFe6slk98nltG02/kkOWRGR+H+RnArsmhI9qRqZzW7W3INq6754Mev49wNxAejtrOjAvt+WkTQL+mliOQJCFkd+yybebogzAcOcw/v/1Swv0QN2lITFUX81uYvCcU4+rkAeG0k9g5iTgeou7gz9voTuODDg=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=A+k07idL; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=A+k07idL; arc=fail smtp.client-ip=40.107.130.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=wBgO6Ou5Ml81y/ftZ58Xs678dtn0Q9CBmRDhwyg02YA9TwWdMcEw4xyXJ5DAYPipn5so1W6A1+a675Re/++V8VQks8JbljPUL00uu1jkbWsqZP3pWB3anGvupSaTKcMCIfkV+ujyv5ztnc0uCZoJkidtVGJJ68FxKLvhNfbgDNxCltb4Z0DlptrEX1SR/pFZoOBF/e7VF0aey6WXz/n1LJv56Bn4Wpc+zA1aOFP+0PS7WmFvzL2hQNNEN3iz1tpLw7+JO56YSc4i7v1mRH5O/v7Ep0+X4hsGitH7DUnhH9IWHwo9BQ4+6Y5fjHC/Uj86AlBumiZvmFHwFKohZwv3pg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXRfu1fgu7Ku4V2oitAJJSzVzqrhO0j6eixyAt6wKDk=;
 b=wmiFnlwatK4bdK9BCgmh4iBC6p31VYl7/PvqUa613GmdH6yzNy9PF6PNyuOJDsJrwnyuV2cSNpdI2ZowW/hSteuXU0ySdkbw450uK/IwamaKpm1xNrJd5guIDKINikjfW1v8LB7CmEdqrVjrIdUxxnqfQfRPUwcCbVpLheirB0qEw9BGZH56XNVi3OKBruKCF/8E5FctL+iap/jK3mmee2AC5s706nQSCmwz6fRhsTEaBzK/a8PoppjgLN0WU8KUSsENZLuY13QHnn8tVTNEkawDWcyRDej5IfIg/4c4xvPBJ+AX6julRE7xevgAdauL4eAb1j6Iet9I7rXCEFFzsA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXRfu1fgu7Ku4V2oitAJJSzVzqrhO0j6eixyAt6wKDk=;
 b=A+k07idLnSPNM//fHrs/aOrrecObrJR5G9z72zqtKBldfW06v6DkCZwpX2kIF76I9Id8k+ZAvWJZC7F8RBpsa5EaQ4TwV3P06UoJir2wb0Zi48szuB7M3wWQg0DrNX6oIyhWxBYYYBEQVq2dYJeOWENfvCJr3YQTkstH474RJLc=
Received: from AS9PR04CA0062.eurprd04.prod.outlook.com (2603:10a6:20b:48b::12)
 by AMDPR08MB11649.eurprd08.prod.outlook.com (2603:10a6:20b:73c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 10:30:45 +0000
Received: from AMS0EPF000001B3.eurprd05.prod.outlook.com
 (2603:10a6:20b:48b:cafe::cf) by AS9PR04CA0062.outlook.office365.com
 (2603:10a6:20b:48b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.21 via Frontend Transport; Thu,
 23 Apr 2026 10:30:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001B3.mail.protection.outlook.com (10.167.16.167) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Thu, 23 Apr 2026 10:30:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8HxhWytirnFxbBQ03BnJ2inuAMI350GqFEpVTLXFFkGo26DzC2vDKouSz6ogzF2j9ALON1OC3ilngeEIKQUJqBQclEAjUYR/zxh6m14riTgy2HGy6quFuTXXlc/9mVyF/uVD3rg8paPmTsEfWYaE3xhKEkdxPLDgTe3eFspR8Q60/g4qTLpCxjx+obBLqABwbTU0Nkv0DRH+vkxRwUn0/MoyzyjfnqdpbjwegRlVS8Pvh3sziKxSKjqtpvMBry5Cvp95LngwX9xbFRFfowqFX+u9mbXwG+LnesgkpSvqze1K7uwqZrR2XIiHQuGaOqML5ngGt+GDb7+OsRjcoD77Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXRfu1fgu7Ku4V2oitAJJSzVzqrhO0j6eixyAt6wKDk=;
 b=dgIETMyesncFXHXMYsa6IIoHkYRYLYl9ns6Dlm2xAEyi+l7e9pIposx6hSa1HNnHwrC8Y2CnBybyMgVlCVOseyay3NdTkur84mP0ShLclIuNYbbBYfdQsV/7AjADd6XOWctvKpbdHcqSKpjVlwesYbD26FdWR+mBloNNfaojtBkV0wRaX0zZyrvSHBebViS7FMkOppfE3z7nMOWBzvUV4yKcK49TwM1ty8pFO96RGTIv795YeZwQ9/ws41wLO4e4tczD9GmBLSTi7POl0lzALX8jw4QupEB/lV7qQV+3ixkTdUhEHFurr3KWPqfYiCXRNfYviS/3wadHLo3EHOJz9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXRfu1fgu7Ku4V2oitAJJSzVzqrhO0j6eixyAt6wKDk=;
 b=A+k07idLnSPNM//fHrs/aOrrecObrJR5G9z72zqtKBldfW06v6DkCZwpX2kIF76I9Id8k+ZAvWJZC7F8RBpsa5EaQ4TwV3P06UoJir2wb0Zi48szuB7M3wWQg0DrNX6oIyhWxBYYYBEQVq2dYJeOWENfvCJr3YQTkstH474RJLc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS4PR08MB7710.eurprd08.prod.outlook.com
 (2603:10a6:20b:511::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 10:29:40 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::8c9b:58d2:2080:eb98%4]) with mapi id 15.20.9846.016; Thu, 23 Apr 2026
 10:29:39 +0000
Date: Thu, 23 Apr 2026 11:29:35 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	zohar@linux.ibm.com, roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
	jarkko@kernel.org, jgg@ziepe.ca, sudeep.holla@kernel.org,
	oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org,
	noodles@meta.com, sebastianene@google.com
Subject: Re: [RFC PATCH v2 4/4] firmware: arm_ffa: check pkvm initailised
 when initailise ffa driver
Message-ID: <aen0j3qM2k06OdXC@e129823.arm.com>
References: <20260422162449.1814615-1-yeoreum.yun@arm.com>
 <20260422162449.1814615-5-yeoreum.yun@arm.com>
 <865x5i13dl.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <865x5i13dl.wl-maz@kernel.org>
X-ClientProxiedBy: LO4P123CA0529.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::6) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AS4PR08MB7710:EE_|AMS0EPF000001B3:EE_|AMDPR08MB11649:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f45b54f-f1cb-40a7-6a23-08dea12360b9
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 3rhAFRAB41W1onlOuTyyuIx68A86JtAbw8PwHbyfGKalxSpl6x1iXhqP2N2eaBt9tO3LkpH8tGtFJ4e+Ah/iAjuE+prJg6AqBwJEOcm/sNaoEi0VlN/ajfdepdYq1pDqpH0ngl8Ff2mAxAVmU5AEyqhFTHXSBnXcZXcSSeWCZroAJXA4aDKgXYr2pSE6qq806WikmsX+zD0ESuSxLDS6CEPHxRp8to39YgHW7WDMl3t526W10QAPu6JAg4WaueIuCi4+bJ3wfD0LVm6G95S2kWoe/rAZ4rWclrO+zhFWZqYLNCd9Mfd+LgFWXp9XkeS2bIbjHhcON+aUVTpGb1k8ZjDWtu/FtZg9cGv7EdIN7RZynPuL/8J+VWHxdvMHKrzPXTyCoU9h66ys5W2c68frH4OJwTMEq4v+1qgC9DWHKsRS5zxrgKBBnBFcnp494K7AuknehDR7L+Gl8UB7UbzfVLvFpSS/I6ync4slrOvPV9dIrWW1JiM9RxvH6ZkHD5jUVhNCFAyWDbs2qGaOz8XnPar+SZ3dQFVSLWGo0BSUt1R79vC5vAAqmMqahnQ7NmKX2D/QLodm+ZTkV3rcvyJKD2O/rQUEzLFhfgN2XiZNS8wQ+RIdYh0aBLIjhjMY82XWkDVSGxvvNTR/fEXRdTlTb4plrFUmBWuWBJO83FJwp2FQtCcIXpvJkGY5ufR0Pk18AJvSJAjLOo1prA63iQJnSj+KLoatu/PMl3Q6a3BlcZ4=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 Jhf67sORar80KjP1OLLp1sZcBQFnBedMAwfCkL86DL1TXSiCsjhA26nd9zauw6KL8Sys7JnLndZDXv2mkNMFmUNLHjcvl9lioMTHG+705nSZjBwByIbZPgPZf+hyaDXgtveqU+X+yabKqwrNA/BIpcBL9WeDQwkdRniYrESv2MkKRpZcohMsRzEkibEERJmOUPvqV4vmPLc+pgplj+Wn+sqb1cE9KPC8A0snDxO8ulP2pJXlR6F0HFBCIUxZAPWjKdEt31TdKyLL35Ge3tYqtoAhPe8Qq0UCAWGeY0ThtD8tV4NRJnhdQyN7iyJyDMz1Ox0e17HqiBXa2MFsAIRYLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7710
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B3.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	fe781ea9-7d02-450a-413d-08dea123397a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|1800799024|14060799003|7416014|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vt6Dxg5l1azSQ/NupTUegpGONSIeqmE6qN6Jqx5K/wM/N9MiUu7eekLjdcTlgymcDqsbOzQE9FW6x2RUB/U7CfzbJQ3z/J9vXJEP30kGzJcnG2LdhA75tSWMCFtv0yN8bSbxLdy1woIAjhVQddcfOP50SvRy/x+1zM3Z0LLFDzU0vJpInRNXpxvovz6BodPy3krTDBqja9NifbliPfD4voh8iee9+FE0Ym/a2udtyzKq+YXO83kKW2MVfpTs4JvM+S6NufCwjguNpZ0oBTz2/VhArtOY2gMv3UyguSnu+oUUdyrWHBncA/X+/O3Y5CNI2Cc7EbGti5HaDfpcErx1siZvaYG9PWu/9Oy9P+NP1dqOAASxVYqBUjBxIZd4YLS4QzrDG2RVRX9wqVx78kvYGO4aXfE/oVgJs938sPPiUO6Jy+1LKMEzoOt5NfrEGGyS1IvmhQFU7ka/AwUuPDucYaGKIbaTQn540Uzjvy/tGKXZRdUXi5UPKnZuuQnq6mTpSF4csXTHkuqM5SVYCoM/eKsat3uGmqdS9qwLL/mT2UJLekYAEfekfCAH84qnozs0RLmuXXWuJz8yTj4b1diLmOtA6Lf7IebEc+HahKcNQllOxjmrPYiV6RgkVFGASzZoT+ppUcJc/uB76qJgNmfiGNjyQqGTHvYQ57d+8Pzhg9moJ/KSojqLsKqmQU+0b3rR8rf7PYSTeWnI5m92rZy8DO3nFH5ThQ2Z10d8IKSkRyBuyyfu00XjiQWuJ/xrHyWuuSYArPapnK9Y97neo9luRg==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(1800799024)(14060799003)(7416014)(376014)(36860700016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ulEsJQgaTy5MVImC3ISyML3BchvvU7U7Qa8JJnzYO9wwnuAyyq+doazP+ncJ3dj3JwCZlwyMM0wmpuCKNIVYfqM1uD34xjrmU5M2HJS88cSW9Yo92AbUqTLzSIare05xr6P+mrM9CoR5VTKY1fXQiKQJBLQ+rWlLCB/wFUXiPQhpSVnJaoFiTn4x3E6x1IvinUewzfNL2QJdz6dT3YYcFITAUkVNaoEhOC1nEtUG0weh09UA5k5mTvNLf7ie+9nV+2zScQ+ARhKVdUcJEdJbi+DoD7cYB3S5UUeEOmUWSxpNGN+PhmI7/+sXxlKMDakPZDIJOt2P0DO1/dT60tq+ywUVdUXWgwdZLMjznvmbRXIVzHS9axF8LyfJq1QGCBuD7Ka20KmTkMM1lKezkNb2RqNKKoKAzigyjizi6DVR9WSERoc7sxZQHOf5Nz3ciXRr
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 10:30:45.1032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f45b54f-f1cb-40a7-6a23-08dea12360b9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B3.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR08MB11649
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
	TAGGED_FROM(0.00)[bounces-9291-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,kernel.org,ziepe.ca,arm.com,meta.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:dkim,arm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,e129823.arm.com:mid];
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
X-Rspamd-Queue-Id: A745E450B0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Marc,

> On Wed, 22 Apr 2026 17:24:49 +0100,
> Yeoreum Yun <yeoreum.yun@arm.com> wrote:
> >
> > When pKVM is enabled, the FF-A driver must be initialized after pKVM.
> > Otherwise, pKVM cannot negotiate the FF-A version or
> > obtain RX/TX buffer information, leading to failures in FF-A calls.
> >
> > During FF-A driver initialization, check whether pKVM has been initialized.
> > If pKVM isn't initailised, register notifier and do initialisation
> > of FF-A driver when pKVM is initialized.
> >
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > ---
> >  arch/arm64/include/asm/virt.h     | 11 ++++++++++
> >  arch/arm64/kvm/arm.c              | 21 ++++++++++++++++++
> >  arch/arm64/kvm/pkvm.c             |  2 ++
> >  drivers/firmware/arm_ffa/common.h |  4 ++--
> >  drivers/firmware/arm_ffa/driver.c | 36 ++++++++++++++++++++++++++++++-
> >  drivers/firmware/arm_ffa/smccc.c  |  2 +-
> >  6 files changed, 72 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
> > index b51ab6840f9c..ad038a3b8727 100644
> > --- a/arch/arm64/include/asm/virt.h
> > +++ b/arch/arm64/include/asm/virt.h
> > @@ -68,6 +68,8 @@
> >  #include <asm/sysreg.h>
> >  #include <asm/cpufeature.h>
> >
> > +struct notifier_block;
> > +
> >  /*
> >   * __boot_cpu_mode records what mode CPUs were booted in.
> >   * A correctly-implemented bootloader must start all CPUs in the same mode:
> > @@ -166,6 +168,15 @@ static inline bool is_hyp_nvhe(void)
> >  	return is_hyp_mode_available() && !is_kernel_in_hyp_mode();
> >  }
> >
> > +enum kvm_arm_event {
> > +	PKVM_INITIALISED,
> > +	KVM_ARM_EVENT_MAX,
> > +};
>
> Well, no.
>
> You are adding a whole infrastructure for something that happens
> *once* in the lifetime of the system. What's next? D-Bus?
>
> We already have a dependency mechanism, which I pointed to you last
> time, and that you conveniently ignored. If that's not working for
> you, then consider improving it.
>
> If we had a whole set of in-kernel users depending on some global KVM
> state change, we could look into it. But they are none, and all KVM
> state changes are per-vcpu rather global.
>
> So I'm not entertaining this invasive infrastructure for something so
> limited.

I think I misunderstood your suggestion at first — I wasn’t ignoring it,
and I apologise for that.

I initially considered hooking into /dev/kvm registration,
but there doesn’t seem to be a dedicated class or bus notifier for misc devices:

  - https://lore.kernel.org/all/aecf57rWloQwDh6v@e129823.arm.com/


Also, as I understand it, to make use of device_link,
FF-A would need to represent itself (and pKVM) as proper devices.

However, even if we rely on notifiers for when the pKVM device and
FF-A device are added, the ordering becomes problematic.
When the pKVM device is added and probed, the FF-A consumer would add into
deferred list be device core and  deferred_probe is triggered later
(during late_initcall).

In other words, once FF-A itself is deferred,
the deferred probe queue would look something like:

  (device depending on FF-A) → (some FF-A device) → (FF-A core)

especially since finalise_pkvm() runs at late_initcall_sync.

Unfortunately, deferred_probe_initcall() (also at late_initcall) only
calls driver_deferred_probe_trigger() twice. In this scenario,
the last device in the chain would not be probed immediately but only after a timeout.
As a result, IMA would also fail to find the device in time.

This is why I felt that device_link might not be suitable in this case —
although I may be misunderstanding something.

If this understanding is correct, I’m not sure what alternative we have,
other than adding some kind of notifier support (bus or class) to
the misc driver, or introducing a custom notifier.

Am I missing something?

--
Sincerely,
Yeoreum Yun

