Return-Path: <linux-integrity+bounces-8374-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDCYKoEVfWnpQAIAu9opvQ
	(envelope-from <linux-integrity+bounces-8374-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jan 2026 21:33:05 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26525BE6BD
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jan 2026 21:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 056DF3007BA1
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jan 2026 20:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDC032B99F;
	Fri, 30 Jan 2026 20:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="BKlfX2p6";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="P/GOKnWH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-edgeMUC220.fraunhofer.de (mail-edgemuc220.fraunhofer.de [192.102.154.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BFD2FC006;
	Fri, 30 Jan 2026 20:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.102.154.220
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769805183; cv=fail; b=mkHmRWQTVoPNJ+Q9VFQd97Uh3KizYbJ5FfkPZUY3JXm2SwO9vMMgjJNoTlR6/tehJldjKDtA82HRIP5Ux6rsBoFZlzIeJXJ/xr1rxtvT8ZhzFtTatMaaptaFLa0Fq2QFvl4OylY3MW0h1zLXg2noI0NIZQ1OxQqYBXgVmUrCBbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769805183; c=relaxed/simple;
	bh=8jCXMhmtz34lPTNhft+9ZdEWNjdPSsMFqH/T2yeQGwM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q+56t3qd6ryifd+A6wR8AtiLRLD9vb1Jg2/6paOBcsbAS8CIY5QEdoroAHTmCSnwQn5EhZDFstzwS1dvm5VnKoHa2k9Jp3bTtPyWXZdigrYOBZirYtLu5KCp7c3awRHoXROaZh3tlbmj9T7USSFNX8GSRp1shs8wV82TwqbTmHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de; spf=pass smtp.mailfrom=aisec.fraunhofer.de; dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b=BKlfX2p6; dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b=P/GOKnWH; arc=fail smtp.client-ip=192.102.154.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisec.fraunhofer.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1769805172; x=1801341172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=8jCXMhmtz34lPTNhft+9ZdEWNjdPSsMFqH/T2yeQGwM=;
  b=BKlfX2p6evFMbXHQ07lvo+WLv8J3hbV/JFBYs5tfywz7ob+agD9VEzx3
   nPg9JytiuRVd48XqU5NHy0h4q0+Y0tkmh0kVXgxNBSQ8ajuuwKCkXWdI8
   lji/pEWxEGWUx1GCKK3c/9L9P1ph5W3ViBgyQsn3BF07WWbs3EpRY8RM+
   I33Sn3/GdbSsIJActIPf1Cr6T0e0M6oe40vw8kvWxvPG7wMRmDfbqykub
   b1s3QOq851QB1Tyfa5xVqDt4P8IZ5TvjL4xkhVlNqQyJdvTy6LIupTxcU
   megdsW3cYxh3S60HtJYitL2H0U8CH6Su7YMWk9MhF0vi30kOOLbnh4uRF
   Q==;
X-CSE-ConnectionGUID: f7eHkISvQWSppw6b4ON/6Q==
X-CSE-MsgGUID: jukhzGyoQZS56bR57Jek/Q==
Authentication-Results: mail-edgeMUC220.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2GoBACSFH1p/8ejZsBaHgEBCxIMhFFBATYPgWqIJ44ln?=
 =?us-ascii?q?HKCUAMYFikPAQEBAQEBAQEBCAE9FAQBAQMBA4UAAo0TJzgTAQEBAQMBAQEBA?=
 =?us-ascii?q?QIFAQEBAQEBAQEBAQELAQEGAQIBAQEECAECgR2GCUYNgmKBJV5HAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBARECDRIWNiAEAjIBDQEBNwEPC0YxJQYOBYMCA?=
 =?us-ascii?q?YIkBBIDNhQGuFqBAYIMAQEGgQjaJxiBKIEiAwYJAYFDg3yEVwGEfoVpgk+BF?=
 =?us-ascii?q?TWCdT6CYQIBAVxsK4YvgRKBFIEOgiEDh1AGgUiCf4V5SAp4HANZLAFVEw0KC?=
 =?us-ascii?q?wcFgSNDAzUSKhUjSwUtHYEjIR0XEx9YGwcFEyMqBhwSAgMBAgI6UwyBdQICB?=
 =?us-ascii?q?IIQe4IBD4Z2gQAFLoEJDiICQV5SCxwuAwsYDUgRLDcUG0JuB45/GRoqgWQtI?=
 =?us-ascii?q?TwqJwETCA4CCWcrKhVSEQ2TB4M9Aa5hgT4HgjiBZ4welToaM5dgkiRnmQaOC?=
 =?us-ascii?q?ZYThHoCBAIEBQIQCIF/gX8zPoM2UhkPjiEJAxaDXoF/glk7vkx3AgEBAQYzB?=
 =?us-ascii?q?4JShA+LIzOBSwEB?=
IronPort-PHdr: A9a23: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
X-Talos-CUID: =?us-ascii?q?9a23=3ASi66dGgTV+DEQ5sVbMEC8mdH1jJufCLQ7HTxGFG?=
 =?us-ascii?q?BNl1xUKLLQwO33uQ6qp87?=
X-Talos-MUID: 9a23:LLpYkwWb8tTHfSnq/D3xhzFwG9Zv2paVVR4Hq8hZmcSHchUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,263,1763420400"; 
   d="scan'208";a="15799999"
Received: from mail-mtabi199.fraunhofer.de ([192.102.163.199])
  by mail-edgeMUC220.fraunhofer.de with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 30 Jan 2026 21:31:30 +0100
X-CSE-ConnectionGUID: w/uKaWslQnWt3DFjDczzCQ==
X-CSE-MsgGUID: qOzaMmvuRHC9ERRi0ctLjQ==
IronPort-SDR: 697d1521_CqDWJKxG3uSJkCk1Z5bA0S4JQZMaeEexaNc8k8Qg3+x1iT5
 Qedl7Bf7uMlPiZezy4m1jPAOSper5bKhVZ6/qxw==
X-IPAS-Result: =?us-ascii?q?A0BQBgAUFH1p/3+zYZlagS6DGVNBATYPYS5biCQBAYUsi?=
 =?us-ascii?q?HmccoJQA1cPAQMBAQEBAQgBPRQEAQGFBwKNEic4EwECAQECAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQEBAQEBCwEBBQEBAQIBAQYFgQ4Thk8NhlsCAQECEiABDQEBNwEPC0YxJ?=
 =?us-ascii?q?QYOBSKCYAGCJAQSAzYCAgIOBqpFAYFAAoxXgQGCDAEBBgQE2ycYgSiBIgMGC?=
 =?us-ascii?q?QGBQ4N8hFcBhH6FaYJPgRU1gnU+gmECAQGBSIZagRKBFIEOgiEDh1AGgUiCf?=
 =?us-ascii?q?4V5SAp4HANZLAFVEw0KCwcFgSNDAzUSKhUjSwUtHYEjIR0XEx9YGwcFEyMqB?=
 =?us-ascii?q?hwSAgMBAgI6UwyBdQICBIIQe4IBD4Z2gQAFLoEJDiICQV5SCxwuAwsYDUgRL?=
 =?us-ascii?q?DcUG0JuB45/GRoqgWQtITwqJwETCA4CCWcrKhVSEQ2TB4M9Aa5hgT4HgjiBZ?=
 =?us-ascii?q?4welToaM5dgkiRnmQaOCZYThHoCBAIEBQIQAQEGgX8lgVkzPoM2TwMZD44qA?=
 =?us-ascii?q?xaDXoF/glk7vkpEMwIBAQEGMweCUoQPiyOBfAEB?=
IronPort-PHdr: A9a23:Jd4u+RETxIfeL3u5jGHVgZ1Gf3BNhN3EVzX9l7I53usdOq325Y/re
 Vff7K8w0gyBVtDB5vZNm+fa9LrtXWUQ7JrS1RJKfMlCTRYYj8URkQE6RsmDDEzwNvnxaCImW
 s9FUQwt5CSgPExYE9r5fQeXrGe78DgSHRvyL09yIOH0EZTVlMO5y6W5/JiABmcAhG+Te7R3f
 jm/sQiDjdQcg4ZpNvQUxwDSq3RFPsV6l0hvI06emQq52tao8cxG0gF9/sws7dVBVqOoT+Edd
 vl1HD8mOmY66YjQuB/PQBGmylAcX24VwX8qSwLFuU76QrPj6Tn4qfImhwiYN+z1Z48kZx/h6
 I16Fx/OujcWChUGqXzbmMFMt5sO83fD7xYq+8n7R6KTC9okRvj6b8I3WFtGUtpVezRkLaK6S
 KIPF/tbOdpFhbPj/2slkUKEGCepXuismjQP2E/JhJIj8OQFTh/JwgkfG/EcjC3+qPHLNY0vX
 cat3o/t1iTCNK1x9W7+5dnOSxsDvrbRRqhiLPLD9GsNHkSdv1bL6rfpeGO70/ZX73al/e1HZ
 NCWrkUcgR52ujaSlvcgoLbKiLhK0nn59S4n8K0IGeaReHBCNI3sAN5RrSacL4xsXoY4Tnp1v
 Dpv0rQdos3TlEkizZ0mw1vad/WtUtHZs1TtTu+MJzd/in9/Pr6y1F6+8kmln/X1TdL8kE1Lo
 SxMjsTWuzgT2gbS5MmKRro1/kqo1TuVkQGGwu9eKF0yla3VJoRnxbg1l5EJtl/EEDOwk0Lz5
 JI=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:3VKw8a64wJqD383xMAPXwU2BI+orL9Y04lQ7vn2ZFiY7TiXIra
 yTdaoguCMc6AxxZJkh8erwXJVoJkmsiKKdgLNhQYtKOTOJhILGFvAF0WKP+UyDJ8S6zJ8n6U
 4CSdkONDSTNykCsS+S2mDReLxBsbq6GeKT9J3jJh9WPH9XgspbnmBE42igYyhLrF4sP+tHKH
 PQ3LsPmxOQPVAsKuirDHgMWObO4/XNiZLdeBYDQzoq8hOHgz+E4KPzV0Hw5GZUbxp/hZMZtU
 TVmQ3w4auu99m91x/nzmfWq7BbgsHoxNdvDNGFzpB9EESnti+YIKBaH5GStjE8p++irH4sjd
 n3uh8le+B+8WnYcG2ZqQbknyPgzDEtwXn/zkLwuwqqneXJABYBT+ZRj4NQdRXUr2ImodFHya
 pOm1mUspJGZCmw6BjV1pztbVVHh0C0qX0tnao4lHpES7YTb7dXsMg24F5VOI1oJlO01KkXVM
 1VSO3M7vdfdl2XK1rDuHN0/dCqVnMvWj+bX0k5vNCP2TQ+pgE086Ih/r1fop48zuN8d3EdjN
 60cZiA1Ys+A/P+VJgNStvoGqCMey7wqRGlChPmHb2oLtBDB5v3ke+E3FwE3pDbRHU29upApH
 24aiIhiYcTQTOYNSTc5uw8zvmKehT4YQjQ
X-Talos-CUID: =?us-ascii?q?9a23=3AHXKv62tS6BclQIqaXyGKE/hS6Is6NWD+xUjLJ3a?=
 =?us-ascii?q?+NnoyZJOXZVSC6ohdxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A4fxoiQ4vr0QVno48Tshbq0SQxoxxxLanLUUTjK8?=
 =?us-ascii?q?mkJipDxZxYzyBqDaOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,263,1763420400"; 
   d="scan'208";a="35171715"
Received: from exo-hybrid-bi.ads.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaBI199.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 21:31:30 +0100
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-03.ads.fraunhofer.de (10.225.9.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 30 Jan 2026 21:31:29 +0100
Received: from FR5P281CU006.outbound.protection.outlook.com (40.93.78.50) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 30 Jan 2026 21:31:29 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZJj/eJYRVW0uNT95EdpYPRCUaKFqtBlSLLH2jxwiMI1BMHa8cuaQlUmfj0pu6vvVqnYDGTLw9HK2dyOrjaArKnh5LQkQKSbQWPj+r89uMqdE/OTa80TvTnE1UiZ/scDrmBzPA+Pp22pDo5z2owD3fdYgFT6i4LflaVxbuUxHmi4I29pMxZA/34HG9co+FhrQD0AHyZqUmYg/hpgJwFMF45CFHA4NJRgteIf47dP1en2YsJMFnhFIaErYnhdZlUvwlHmBnAWMwlROz3J2C+6wmmB5YVctV+BkB1lVcKnv4E+tzGZlT1Y0rmS+4wAyYgPPERw5MbvJtrUyBKjMY5g8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7htLz3zjwp37IjbIkBWxVC+oBy7hNZxyUCW1udzeTSQ=;
 b=WnMVw/GoX3XIuur4izgLkxIainiLgYMsX7saMym89vrmxQTH4e3UAtw3Zvu0IVsa5C0x5jecWVIfLuv0o+Ux7JnreuieXga5BPpwV+nvcIxTBCX3RRc5mDoU6AD9qOEjpcy/xO+ASrsfFHDDZUQYh8+Z8K9YTVzaPe8Quhjms8G/yfLubW+gtuT3LGVybcn/8+HTvi7W41X3NRNki0K/CwGnKGFdBzEp5oU0y2Eju7DJ4eED1sDTaDx08AntUfsK1QCk2GOWewHNz8RVKbhq18HlIzgQD6wNup9FOJ95oq9k2+rjTFheIzLZHVPrMP8pYcEgX2II/eDh/hr0vDO8Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7htLz3zjwp37IjbIkBWxVC+oBy7hNZxyUCW1udzeTSQ=;
 b=P/GOKnWH2P3OzyEuYodtlDpMGInOAhpy2lTuBRv0XCT1RuFm2c+8c/6XW1WqKhL7vgvmWlKzT1BlLViBUdNpzNMsyi36OD1ke9nQcJw/5srz5PzUJJa/0Yk3+Sd/8Fmz24vVzoOYZQMCSBwopfU8XdBWkfR7pAUhc6XCUTSAXVQ=
Received: from BE3P281MB5296.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:d3::5) by
 BE3P281MB5513.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:dd::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.11; Fri, 30 Jan 2026 20:31:27 +0000
Received: from BE3P281MB5296.DEUP281.PROD.OUTLOOK.COM
 ([fe80::fc67:cc41:460c:3fdf]) by BE3P281MB5296.DEUP281.PROD.OUTLOOK.COM
 ([fe80::fc67:cc41:460c:3fdf%3]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 20:31:27 +0000
From: =?UTF-8?q?Johannes=20Wiesb=C3=B6ck?= <johannes.wiesboeck@aisec.fraunhofer.de>
To: <coxu@redhat.com>
CC: <dhowells@redhat.com>, <dmitry.kasatkin@gmail.com>, <ebiggers@kernel.org>,
	<eric.snowberg@oracle.com>, <keyrings@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-modules@vger.kernel.org>,
	<roberto.sassu@huawei.com>, <simo@redhat.com>, <zohar@linux.ibm.com>,
	<michael.weiss@aisec.fraunhofer.de>
Subject: Re: IMA and PQC
Date: Fri, 30 Jan 2026 21:31:26 +0100
Message-ID: <20260130203126.662082-1-johannes.wiesboeck@aisec.fraunhofer.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <aXrKaTem9nnWNuGV@Rk>
References: <aXrKaTem9nnWNuGV@Rk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::21) To BE3P281MB5296.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:d3::5)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE3P281MB5296:EE_|BE3P281MB5513:EE_
X-MS-Office365-Filtering-Correlation-Id: e8dfb589-8ca1-4d3e-35d1-08de603e8b11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T7TirDQA3/s9KvOgCwjzK6/RnVGgLBkm6pukyXDhuH4Kg4DM2YhyqzSFeJLD?=
 =?us-ascii?Q?ekeoKLX06oyn0LjHhNKhcohUSQTlZHdV54J+k+k1wTb6yqdJSxhGSpVCG5PC?=
 =?us-ascii?Q?uZITWmA9fLt3ALALSW3IREuB4TWzEyFOFiBv4l/fOE/7nR6qmFkCMnHCCmOZ?=
 =?us-ascii?Q?UVY25JiAczY49r7gmqDplkv42ny5p8iLxSEPBwUY68zxoVmfxEPu80Awe4S/?=
 =?us-ascii?Q?ML7Tv9x1GtGbWcIVU4P1X7ZU+afdS+Y6smz0cm24TUuXpjEw6WP/oLhJGC09?=
 =?us-ascii?Q?GUf8rAxT0//lumpR/W9mIpzLBnzHX1+py24pPsDLJ4g5SXjEH33OwGPvqbGd?=
 =?us-ascii?Q?NfnPXcCLGiiGc0TUIEGjw54oj4TPsesVLrPWCMT2jzrTcVzj7fJLXZ+qDXUj?=
 =?us-ascii?Q?+St7QVw/t5d756KxBfLwT4V8XhpahLYlPpZ/pRowjkN/QjyMztDzfnI9wMum?=
 =?us-ascii?Q?ebAT7iSnBl7Pc/0YSccz89IPNyifY1mqyeFHlJPyH5w8ZV+L1DsoXauaUaEz?=
 =?us-ascii?Q?gGm3VVdD6Y3yECK/Nq6lJ0Q9FLSXjaWxwrdcOFRIcu7DS56A/XrLA8iOPDyC?=
 =?us-ascii?Q?ypmgd4+vvdOzJo/qZzMwcX63EWJM0/fSs//O90oPf5RnqKLovBDdZw9d1Pgc?=
 =?us-ascii?Q?ewtKuKO8+mWUTHfkf3956VUcVXeYY+gjX98/bdqrh1Cd6FiOiaV8iMjlq4Hu?=
 =?us-ascii?Q?kENvAc7ubhBiooOyNgy6fgajLWVYj42idetgti1Q8T8JSWlEzj9DB4mhCTdN?=
 =?us-ascii?Q?ZZzkbMT3S+fZwsa+qoX1HuBq8/PGzlVKhrkDTBZCSl7W7iE7DCD1f1dS9ShX?=
 =?us-ascii?Q?bwERU8W9jjMaI7F9ojn5b2tXZm5mdEGfBEsVyDQOJUMEcckZduOfEKsO8k1r?=
 =?us-ascii?Q?AFkXhHGvfPELQPZY1PviGSFgjUzxUs2fzEjb3W655CK+QBH1FSFV/fDRzLDx?=
 =?us-ascii?Q?2DFjo2D/9PDRtIOQ95FQN38oReSOJV7l+awvv0mHnUgX+/mzP/Ld283ruXhE?=
 =?us-ascii?Q?35gxP6U+AU6SEj7tMN4c88ilXjAEuqqAceaXPdgDawA4dPjiATsZhvmiwp2D?=
 =?us-ascii?Q?O5MNLfwjVz4bXgNz1K7mx2J+0RrjG/zYoBmufyn9od/y+3DuSfe1F+5HffDO?=
 =?us-ascii?Q?F8flcl4TvuQ7pV4LDWeVY3IhSQrLvmdSzlg5vpCh6+7scamoO+NJCNsL0Yaa?=
 =?us-ascii?Q?WnggBBDUTXOs1vggZK3JVZKqrvzbV8TqLSPosRs6auTFcENgzB3ntbe0jOKj?=
 =?us-ascii?Q?tUhNOP+GSYBy2/OZvAQNoYv7ixOVmQsx5c4+RITRxFwWLO6RQriMKZbvEuhP?=
 =?us-ascii?Q?x+Z/sayo2Klj534ZXQg2Ry8S4nW0vsSyi2UhLujjaeAWhOwHPW2Y3X3Scqet?=
 =?us-ascii?Q?gjKetb0ygjNbuMckRvYyI1GwS09RIQdE+X1aDz8sS7iIW5IrYFRt/5FR9Wy0?=
 =?us-ascii?Q?27ZVd0chheX7zEV29QIXGaZF9une2DVVDFMeEfE6Dn1/bfXhrzEV5loOoBoM?=
 =?us-ascii?Q?GWeoM8Ba+4TJKMs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE3P281MB5296.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ogGViXYP/yh3ucvcheObRwjMR0fc2CLiFpO+GSP9WGqFhfPqAo772x8Z4+TL?=
 =?us-ascii?Q?QOkwxpC72EVWh+GNoe+0+f5RE9ncINtlOy+6Dtec15PP29VrKHiAgKg+w9Ic?=
 =?us-ascii?Q?WE00qcx7u4ZC6WW3cgdvmdgQ0kUv3cLpexUiJDHwOgVggYWU6wtZkDGcQFE6?=
 =?us-ascii?Q?vRVOj4QfY35Rl6/CP4GV6bhSiwnXZOgZ7qwk9DEty7i6jdYlyWZDQtVfRfB3?=
 =?us-ascii?Q?W/tokUDu4ZnWz22yYzkwI2khpj8ZW2G3Ef5fDrtP/Da/3keKm3/y92DZ/kZP?=
 =?us-ascii?Q?AAUmxpYjia4ENZVk8X/MBGZRCW4xfwiqfTrtzbiNQRIwQ/1Rhg8TIehBHSoE?=
 =?us-ascii?Q?ZVPIr9g23OsD0TuWJQGatDQEoXfB0vc7H7L1DqCz/pUQNlAput9n93prLnwu?=
 =?us-ascii?Q?6B77J9P1DXqjloSB38XURPQPFdgx3gEex9Jh956eHkGq+Oxq2TUJf+B2xBsm?=
 =?us-ascii?Q?bsaqQG7jnCDmqxjnrNXvGvfVV4bgfH1r2/tS2a9wUiNsoJ1G/TIC9ZggxfOd?=
 =?us-ascii?Q?cX67EnGToSZaTJ5cu4cs5xeBW7gckL0OmIjDk49ba4Yx/PuZaZgj8VM6EDxW?=
 =?us-ascii?Q?sxOpOeqA2IJ6rF8XQzvH0ySZpK08myUDnzNxJjsE4tD0lBwRPhNZ678PDtzL?=
 =?us-ascii?Q?jGtpq9BzzSAVaI6w5ho2G8R3gBuvD+tfJol8O6Q4YyZYxzDi4AL7aHoRCrN+?=
 =?us-ascii?Q?3FVnDvTDW9y7KSH/VAJbUFEhUYzDClwPQL6odz2XjaDAOVozA8xJiajIUpV8?=
 =?us-ascii?Q?P37W2joZ/JY3iZ/7WQWllu6TbolVnr14u5xBZkpTpboEnN3FcBZoEEa3yGiy?=
 =?us-ascii?Q?Pigf+BUstU567YvjFWbkdequ18F1wlRx4Fx6vy2u8qSapE7K37L5DTTXtM4b?=
 =?us-ascii?Q?0Q2kcNcn054oRiwKeQ9l/jzLjv8RoUsYV9susC4EHp5SG/RInz77lfZ0pybn?=
 =?us-ascii?Q?Celhy9+2pKgy4Ib9Uip+HX7laJTztkWJ0Q2ruyoZMGT1ROr3r5J1fLdT87rr?=
 =?us-ascii?Q?OLj9T+M1a62hvdJxS9VfERGLBmavqKY/GjB9x45C6CbniR72tOGpsd0ybuqf?=
 =?us-ascii?Q?kNV6PVPMHjhzf1licRUCslXZEe9dsCni2JnejWsQzvIa+lQ0SJFBrT02Oa1b?=
 =?us-ascii?Q?Xjqd117B+HbzuoKEmDxaK/kdyqAhmqftbvohYdlZpWsT7T8G2MKq4TXGM4+2?=
 =?us-ascii?Q?EC4Rr4GcwBMRCG2iKnv9AVVd5A69ctjr/XFBrXVIUJiCr4BCwhB6o/bd746p?=
 =?us-ascii?Q?HRy2kuYx+kVPOfX97SwJ70jX0pqDlE+uqjLC+TRR80gJSbtD2L9N8KCXbivF?=
 =?us-ascii?Q?vGte0JRspOHyaDBv3mBeOsTVXcyUDTSpU7e8PwwXxveNF/mrNEZLwt+0LfZo?=
 =?us-ascii?Q?qx7pO9FTEpr8nChlabnW6ui5QKkuN2rf7jBZ+WFsWqrcl9Yww+4YDoe0lgY0?=
 =?us-ascii?Q?0WRtad5mstX9OMnLzhJgadgALQAb0rSWXjzkmzqkXthxYV3DKT7mSKfzrtrZ?=
 =?us-ascii?Q?ehU0tbnLeImIdabVdSL5Us1PaENJ0wYakReEhG4BqNVsNMXyPA1ctYLBY+GR?=
 =?us-ascii?Q?T2x9qGygGvmuBFKxzTbbx8v+EFZxcAlxiPF1U62BYndOc4dY0V1k7JDFENgc?=
 =?us-ascii?Q?YskFpSAPyqo363JyYBXXi/8t6OBv2CbuGq9BaMR3ai/hdpzLFj1CEk1bsjo0?=
 =?us-ascii?Q?rRYVnCkoGw4PasQ5dI/v1ugqIz8NsxxnWRChaTYA2iAy8hbZn7rh6NrDkdTZ?=
 =?us-ascii?Q?4NPav3eU8EaPEubc80KoqUZfHv8i3ZndU0j5tsMJZfZwD/FEqnbO7Ex+ZqTS?=
X-MS-Exchange-AntiSpam-MessageData-1: bFR9InwH/MQdKkdR6Cddz6ZfsG9PRL744CWqJi9pHv/xpzXm3jZKon9v
X-MS-Exchange-CrossTenant-Network-Message-Id: e8dfb589-8ca1-4d3e-35d1-08de603e8b11
X-MS-Exchange-CrossTenant-AuthSource: BE3P281MB5296.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 20:31:27.1488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H+awbteCWQCGA3gvxcIc9OozxfsoCB8NsyfScgpZinN4FxYGcB52uh0WKRTM5Oz6zfS73wAK/gt0o14pBZ9APYPWorVHfe4bBCsTwqRZi1g4vCrJTe8SYUnJDrTxW6zX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE3P281MB5513
X-OriginatorOrg: aisec.fraunhofer.de
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.55 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MIXED_CHARSET(0.71)[subject];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[aisec.fraunhofer.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[aisec.fraunhofer.de:s=emailbd1,fraunhofer.onmicrosoft.com:s=selector2-fraunhofer-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,kernel.org,oracle.com,vger.kernel.org,huawei.com,linux.ibm.com,aisec.fraunhofer.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8374-lists,linux-integrity=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes.wiesboeck@aisec.fraunhofer.de,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[aisec.fraunhofer.de:+,fraunhofer.onmicrosoft.com:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nist.gov:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ietf.org:url];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 26525BE6BD
X-Rspamd-Action: no action

Hi all,

we conducted an evaluation regarding PQC use in IMA last year (see [1] for all
details) where we also considered the interplay of different PQC signatures and
file systems (ext4, btrfs, XFS, f2fs).

Coiby Xu <coxu@redhat.com> wrote:

>According to my experiments done so far, for verification speed,
>ML-DSA-65 is consistently faster than ECDSA P-384 which is used by
>current CentOS/RHEL to sign files in a package. 

Regarding performance, similar to Coiby, we found that all variants of ML-DSA
consistently outperformed ECDSA P-256.

>The size of a single ML-DSA-65 signature indeed increases dramatically
>compared with ECDSA P-384 (3309 bytes vs ~100 bytes). But I'm not sure
>it can be a big problem when considering the storage capacity. Take
>latest fresh CentOS Stream 10 x86_64 KVM guest as example, without any
>file system optimization, extra ~189MB disk space is needed if all files
>in /usr signed using by ML-DSA-65 where the disk size is 50G. But I
>don't have enough experience to tell how users will perceive it and I'll
>try to collect more feedback.
>
>For the details of my experiments, you can check
>https://gist.github.com/coiby/41cf3a4d59cd64fb19d35b9ac42e4cd7
>And here's the tldr; version,
>- Verification Speed: ML-DSA-65 is consistently ~10-12% faster
>   at verification than ECDSA P-384 when verifying all files in /usr;
>   ML-DSA-65 is 2.5x or 3x faster by "openssl speed"
>
>- Signing Speed: ML-DSA-65 appears ~25-30% slower when signing
>   all files in /usr; ML-DSA-65 is 4x or 4.8x slower by "openssl speed"
>
>- Storage overhead: For ML-DSA-65, /usr will increase by 189MB and
>   430MB when there are 27346 and 58341 files respectively. But total
>   size of pure IMA signatures are estimated (files x (3309+20) bytes) to
>   be ~87MB and ~185MB respectively.

Two relevant aspects we discovered regard the signature size. TL;DR:

1. Most file systems need to be tuned to support the larger extended attributes
(signatures) if their size goes above a certain threshold (e.g. enable EA_INODE
in ext4). This influences not only disk usage but overall compatibility between
file systems and PQC signatures. A file system that would not provide the
functionality to store larger extended attributes would be incompatible with
large signatures.

2. For most smaller signatures (like ML-DSA-44/65), we believe that the overhead
of signatures is actually compensated by fragmentation within the file systems.
For example, ext4 will allocate a full file system block for extended attributes.
As long as the signature size is below this block size, we did not observe less
free space on the file system despite the larger signatures.

Overall, we concluded that ML-DSA-65 provides the best combination of disk
overhead, performance and security level. Performace was good and for all
algorithms with larger signatures than ML-DSA-65, file systems would need to be
tuned.

>According to 
>https://www.ietf.org/archive/id/draft-salter-lamps-cms-ml-dsa-00.html
>ML-DSA-44 is intended to meet NIST's level 2 security category. Will
>NIST level 2 meet users' security requirements?

Regarding security levels:
For security levels, we referred to NIST IR 8547 ipd [2].
ECDSA P-256 has a classical security strength of 128bits (P-384: 192bits).
According to [2] Table 3, these levels are met by the different ML-DSA variants.
So, if you are migrating from ECDSA P-384, you need to use at least ML-DSA-65 to
meet the same security strength.

>-- 
>Best regards,
>Coiby

Best regards,
Johannes

[1] https://www.wsbck.net/publications/pqc-ima.pdf
[2] https://nvlpubs.nist.gov/nistpubs/ir/2024/NIST.IR.8547.ipd.pdf

