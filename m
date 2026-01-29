Return-Path: <linux-integrity+bounces-8367-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDRyJyOue2lOHwIAu9opvQ
	(envelope-from <linux-integrity+bounces-8367-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Jan 2026 19:59:47 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DDBB3C13
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Jan 2026 19:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1FC213004427
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Jan 2026 18:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F2E30DED8;
	Thu, 29 Jan 2026 18:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IPx3Xjk4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Zgw0lc4a"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D05B30DD24;
	Thu, 29 Jan 2026 18:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769713181; cv=fail; b=pWmORBpRP2zFhN4nU3X8eCQ88YV5A65FD/fL42KYEuOZeQH61ve/T4aVC6qN4dPVjkHduHJNzjTU5+wr6ABxpDt2VOUtO5mtzaj4YSZZfc3N6kjt/COnLOA62EuwQMi2iyP2aLYT3bjMXBvhqdPZU/dUHhUe8pmVcLOIVpEZVRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769713181; c=relaxed/simple;
	bh=vsHYHY2vNAcSF1IXnQRXq0jx3BKjHrmcH5kFslxXb/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z7fLE45PA1S0ZQq4PCdBbD1TYSHToxWvaN3uv6VQPO0tiAbw7T7Y7APrgmhKm5qLd86HG2WJLbh9b7XyNmLHa58QmoX6Vofd+ErLDjLW7T/JEL0x1MiBzgNWgnbErkIDTAKasN+bwSwigPC1zdFpBWfx++xSiqzBNoztaac4cIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IPx3Xjk4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Zgw0lc4a; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TDgIkn542568;
	Thu, 29 Jan 2026 18:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=dyYD68MDQL2t1zdox+q9EFf34cwAGyXpLSlS2O+C9gI=; b=
	IPx3Xjk40AU3HSH/mmh0cFK9ba7XrL4VXfH97JjYPv64ASgCBwqidyIQbmOBbpAu
	nW02CGLSxTaJmj0j2Zt6HTnaPJlsU88FVvdHttn6qR/YcEOzD+yI8r0r/QJ+euTK
	MKXfCierGycPRqQ2jbAlMI/wpnqant5C9kFADd4niDjmr4KgDCKzx1GssjBT/WLN
	o+xv6KyFemlYP8+Bm2E0PWO4z35quIuAMVe+GTNePkHRNz0MsGo4sYBQkfbTZoz/
	Tv743RuO93b2W94J9n8peA2rxRc5XFgfXu0KfqYyTdAMoL8h622712o6HN4aX151
	x98TAQ9fGNdK/SVO7l9QHw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4by5dj3jjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Jan 2026 18:58:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60TIBgSk019784;
	Thu, 29 Jan 2026 18:58:28 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013039.outbound.protection.outlook.com [40.93.201.39])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhj1t2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Jan 2026 18:58:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vE+u7AhyQCFOXB/ipLUX3vKAfrLFwi5dF3UrhM87KrBsOhRtmc/xEYZwWSMtwgkVwRGUh+pkfGqeCc4csH/X1Gtz40JrkRIqfDgegFf7QYF9UGBwbPya7sF8JudzflzQZSM34xP3vqMUqrg9AAJzkDfuEJvDqIXJc1+/pytssSNKXO/nsi6UiDIYqAynqXWqNVNpPL84l0jlMm1paphCOmzEToS9hKNibvXtE78sXcmGmHNE15zN+8D70fz9q7xmE4EaLohDV6SqWeLrMGdUIuJP5S2f46ICTmC9gmTO1fFrAGuaK+r24G7cU5dScSeM2m6zoqeFHc2Cb09YLHL0mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dyYD68MDQL2t1zdox+q9EFf34cwAGyXpLSlS2O+C9gI=;
 b=Lb1EBYts2fnb39kJXSrmeOvyOdnWa0P6uhwDCPPcCoN5BeY4VncW190Si0J/srfcxhsgBLLMMww2E7QZ/Qb4ox47vqn0WUXiq8XRxc6I6MJsAGrdJUCWDGs4bNAn6XjBzKXk+sDHCDzncxidhnbZ7TTfGrnxyoEdM2YBEVnf54PMTOtkE0Kdcs21HccGlbbnH8vT0VxB87diWGes64k2+gRy9HESviO7xi8jWHmvLYJEpYujvHzzCtXU4BeSvISnYyg+a59CLShvuPZ3ZkmXN+3lvrdjh1yKlJtSm+w0Qx1WOOLDwJOqTcxNMWEZsXDYsjr9VRnvkkV/38XprjwszA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dyYD68MDQL2t1zdox+q9EFf34cwAGyXpLSlS2O+C9gI=;
 b=Zgw0lc4aTlPI8H3wBI7NFHAn8KaGZiT/OzIAzYztzwyRyj2CM39N5/VtKn/09allsNYPzWL1yPR53NZWCzaEoyhyTaDsQ2QsE5atuIap9mQtnbetgIaxjP4I+oUpn4jlPlfRmREnVnD6YUEvpu/s+2DAaIwmqwXpcVVmMEqn9no=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by SA1PR10MB997678.namprd10.prod.outlook.com (2603:10b6:806:4b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Thu, 29 Jan
 2026 18:58:25 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Thu, 29 Jan 2026
 18:58:25 +0000
Date: Thu, 29 Jan 2026 18:58:23 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, zohar@linux.ibm.com,
        roberto.sassu@huawei.com, wufan@kernel.org, mic@digikod.net,
        gnoack@google.com, kees@kernel.org, mortonm@chromium.org,
        casey@schaufler-ca.com, penguin-kernel@i-love.sakura.ne.jp,
        nicolas.bouchinet@oss.cyber.gouv.fr, xiujianfeng@huawei.com,
        linux-mm <linux-mm@kvack.org>, David Hildenbrand <david@redhat.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 10/11] lsm: consolidate all of the LSM framework
 initcalls
Message-ID: <5392220f-c29e-4cbd-8dae-59fbea4c6491@lucifer.local>
References: <20251017202456.484010-36-paul@paul-moore.com>
 <20251017204815.505363-12-paul@paul-moore.com>
 <20251017204815.505363-21-paul@paul-moore.com>
 <0146e385-935b-4f66-9e6d-51bb47ae4bdc@lucifer.local>
 <14638978-b133-457a-ae9c-31ba54e3964c@lucifer.local>
 <74286aca-a565-489f-ad2c-886c650ea2bc@suse.cz>
 <01cb28cb-56b7-4862-bf27-07e4bf17115e@lucifer.local>
 <CAHC9VhS_y2gy2nAK7C-OpchME0pzS34-QN2bY9t5SRBXArz8Xw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhS_y2gy2nAK7C-OpchME0pzS34-QN2bY9t5SRBXArz8Xw@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0164.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::13) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|SA1PR10MB997678:EE_
X-MS-Office365-Filtering-Correlation-Id: 6047d3c0-d665-491a-15ab-08de5f6861ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGt2WUVMZ3hKYnoxL0JWUUVhWWpSVEJtendlME9PRE80OWo2bWprbFNlWXgz?=
 =?utf-8?B?QWtuV2l6ZWpLcVlZZjJJSHJGREp5NCtITVdOcFJQbXl1eXVtRUZJOFBhdWEv?=
 =?utf-8?B?N3Y3SUxFS3VXMi94OUh6ZE1nUUludFJ3Q1ZVakMrY0s0L2VKSFArMURTcE85?=
 =?utf-8?B?U0pCU3kxaERwZUZ5TFdPbFlGRkFHS2JNbWIzbFd2QVhlUk5XSG1JL0x5RFg4?=
 =?utf-8?B?Qmx5bjNnejN3YUQ1NHExSytRU25udmhscG1yQzI3MkNabkhFbm5VNUMwQ0cv?=
 =?utf-8?B?bnUwcDkxaHhqQmhUQkY4QzY3by9YLzBzZDFYTW9qS2RrcXRZOFpkTVBla2ls?=
 =?utf-8?B?ZUNjZDF6amgwOVJ0YTZjZWRKV1Z0ODdha1ZSZis4NjAxWU9YOGthTjZDNWkw?=
 =?utf-8?B?dGR4RTV0TTAvcjZPK1h5eERhVTdJaUgvSzA0Y1pPNWtEOHJ0MktoTmFUYzh5?=
 =?utf-8?B?QUdlWUJsNkx0elBTek5taFNDRXpJYkw4aWwrMDIwR1hVcUN6bXI1S2VhdnRU?=
 =?utf-8?B?TmdkMUE0d1NwVUJrZERucHVvSUE1aHhTeTZyclFhYkU5eVgxVW4wTm5ydWE1?=
 =?utf-8?B?ZUZlQ0oxOWtLUUR4Zy9GeGdUbkVDK2RGWkl4K0tRM2NhZytsY2lJaDgvOGRk?=
 =?utf-8?B?djhKVUZQV01iSi9YZGF1WVc0MUpxKzhiNDlTazZUd0sySkJXdk1aS1FNTy80?=
 =?utf-8?B?RGkxTWRwYzVuSUNveXVKREkzVjBwVkFUMk8yNlZYc2VBU0lobVczbHdsbTR3?=
 =?utf-8?B?RjJFTzN5dnVCUlBPaWlmaUcxejhSMy9DOVFCQjBTa1BLVWI0R2pZZ0RVdDg2?=
 =?utf-8?B?OTJNbmR2S2F2VEFqSG1LVEJqTU80TWdHcWx0Rzgzd2dZNDNTdmdrRk1Od25v?=
 =?utf-8?B?SGJaMkhSNkpMZ3RWa01ISUFmM1pXWmlHUVd1aVRwYnZSTHFNanllak9hSWtP?=
 =?utf-8?B?TzlUSFBtR0EvL2xpUlpqZnpSekd0WkVwbEJoSTRyNWt6dXFkaEJpeW1mOGVD?=
 =?utf-8?B?VVVSWllWdEpoNXY1dmUxNTJ3KzBFSTc1VitWMytPMEFrZklzVjlpaEFSa0J5?=
 =?utf-8?B?Ni95dHN3dnRwUXpGa0d4TFJ6VXFOR3RjZlRaUjFqVENtWXNvQ2VWeFRUQk5K?=
 =?utf-8?B?L2Qyd0NJYW1DdThoRVBoNWY4ZExhb3doOFZpY1B6YWxFb2R5QktwbUxTWlNQ?=
 =?utf-8?B?cFNVV2NsS2lvZVlwaTN2enJ1U3d6VGNwUUVlZXppZHBoa3JYMmF1N01xVWs1?=
 =?utf-8?B?NGFRa1BXeFRPdFBUeElSTGRPWUtGWThFU3F0RDdWdnE3Tys3VkMwbXVIejRR?=
 =?utf-8?B?VzQvT1RSczRSWFc5T2c3VnRIbGlSK0x0aDAzOHQrZi9ERlV6SEVDbjdlaDFM?=
 =?utf-8?B?TTJWVm1iMjc5V21HT3ZtYm5aaFlXT1VLcDhWd1NNS2lEMUZqektLcWo1ckJi?=
 =?utf-8?B?VjJrZEpLQUJuai8ycEZSVDF2aUY2SEV2SlI4SkhnQlZ0WURoNi85R1VNZjJ6?=
 =?utf-8?B?VTlQeTJSdi83a1FmSkdSekVFN0liU0V1SHo0SkF1SWZRYXpSY3RhY016Wnhi?=
 =?utf-8?B?YUZkL3NudElWeUE4b2VUbUE1U3RISTc4eGhJcS9pcTY4VTJPMVFKOG5Qcmx1?=
 =?utf-8?B?MmVPQ20yVENuWnJ0NTkrV2tObWxRZDFzTGFNUnpUMjVaZDFRVklnL0hsdGwv?=
 =?utf-8?B?UjM0NDBLSVZMTVhOWW9NVEo4Z3BDY1pPTXBPZjdxNk9DSWVPQ0h2THZuVU1B?=
 =?utf-8?B?bE9VQjdiU3F3dzRDWW5LN2VkOTRzZHBESnVPL0U1bGNYRmNxZ0FRQVRVc1pL?=
 =?utf-8?B?VURnOUlWQVJKdzk5WWxNczM3M3FRY3BuaEMzUEdsNi9BZENxendHVDFDY1dN?=
 =?utf-8?B?SlM5WE1LZmNDS0E3dStSbUdRTm41UzM0a3dBZGVxWmYvK1dtZVBWcmRUVTBG?=
 =?utf-8?B?ZCsweDZvSjhiS1NzMG40WEZPL21COTZaQjVuSTZPSUR0R2NhR256SUNCMDZ6?=
 =?utf-8?B?aGdqZ3NyL2dvMWxma0srY2RUc0xmY3dpcGhVd3Qza3BvVEkvSHNIOWUzMWF0?=
 =?utf-8?B?YmZ1VnNGcWxOc1o1NWN1VUxKazNNeklERU90UWxvV3B2bmhlRFVvTmZhc1Nz?=
 =?utf-8?Q?OsGM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VytsWTFKaktkNWE4NzRHWmxpbUlySUxENEN6bjhPbTh5aUpGSkc5bDRxM2dU?=
 =?utf-8?B?eE95Uk5OSzcyWFpqSjF0ZnVmdlVwaENkVW1TWDc3UFZPVkVYcWVVQ0FKenZP?=
 =?utf-8?B?eTB3NDZ1TlhLRHFVVzdUY3JLdWtZYUN0bE12UCt3ZmhNVk9ibndnMEFySzNq?=
 =?utf-8?B?MVFkQzdhdXlzb0IwR1YzSXVNQ3p4b1lLWlVsalRjUnAxT0VWRURCVVk2Sm5q?=
 =?utf-8?B?bmYyaGNMR1VxdTNnaTJiaWNJcGdIcG1xWERDNTNkYU9YTS9uTmppeDJjaFFN?=
 =?utf-8?B?Y2RqTG1kSFFvQmt6VnFmeHBUTHQrTEljODJwSnJDNFg4a0lrZFZHZGl5bnM4?=
 =?utf-8?B?SzJlRWRKOUdxbkhXMnhZN2xyZXdFdGkwMFptSklJdjZZNkRXVkpuRTN1YjlQ?=
 =?utf-8?B?bzdkZ2JnWUZOQmhsWmhvQmcrMThEY3MwU2FPWnZkWis2dHpNR09SSlUrNW9T?=
 =?utf-8?B?N1ZLZHpqYk04QWhOWkJPTWNBNER5TkJkUDRnNUo0U1k2RUJIR2NLRDFjRDRU?=
 =?utf-8?B?Ny9KZm5GTktzbnFRQ1IvZTZkWFU5TWgrNXEwN1NVQlcyQ1NWWGJOOTRzZnZt?=
 =?utf-8?B?cGxIVm9zajUwemFzN0pkd2d2VTU5dlR6eFdLS3ZyYXArN2dsRU1vRXhpN0Ri?=
 =?utf-8?B?NTNpOFlrTVJtcU5VbElITnlWS3hZTFVubWpWR1d2V2htbGJDYzRodVhQZEtF?=
 =?utf-8?B?UUI5WU9sUFR4cXF2LzdKL3NYQXJ5YVJ3dkFXK210NzN0RXhVdTY0LytyNnNF?=
 =?utf-8?B?RUtQODlLcW5Bb2R3MmwvaU9PcDgrb3hpMy9FN01DUjdPWDM5elpGc3RYa2Nz?=
 =?utf-8?B?elFJZnNDMi9xZ0hMdmhaeFNJTEFCeWJ4K215WCtwaXFDaVdDa1RsN0x6MUNQ?=
 =?utf-8?B?a0dRVjlJWVdGMXF4eDQrRE5DbEE0bFVrMjB0NG5KdGhCTDMyZWN0SXdqbGo0?=
 =?utf-8?B?TWdzdkFZTy9GL3JvUjZLbW5jUEtCbERQQS9TS1NTNVNLNzNDb040dmJYUHNT?=
 =?utf-8?B?UWQ0R092NThhMnc4UzdQTW9ZbWVPdHpnVTVscEF1azlqWDBxMmNySXF2OXlN?=
 =?utf-8?B?cWdPeU12azRGOW5HdkFRVmJtaklPZFpvNHh0T0Y5ZUx5cmRBN3lmb2pXam5u?=
 =?utf-8?B?bXVsUmMvUzRWMXZGeHN2T05oSVE5eStjQ2xpaXNpVWVzWkpGaXZKeTNZN2J2?=
 =?utf-8?B?QmMxTGJWSm0zTU9naDBGU0x3cEk1aWpxVERKTHkrb29jYUZUdlAwQnhUNTZ1?=
 =?utf-8?B?aG9sSkhtc2VubW9WRzlsQmlpMmtqaWVTVkFXWm44QjJ2RHF2WVdtSndmOVhL?=
 =?utf-8?B?ZDR5UGJCVzZLSC81MzRRSFoyZ0RNR1BWR25BK1lVKzYrMWg1RExoN0p3aHEr?=
 =?utf-8?B?NVFLUUVTcE9VWlQ4ZG5ydHBkYUVGa0w0a0d1ci8yVGQ5V05KN00wcXVuaFVu?=
 =?utf-8?B?b2ZKdlNydTBjZTE5MGxMa3VzOXRtWVNiUWpRNWJxQUNvYTdSZHBlTkQ0N0pZ?=
 =?utf-8?B?THRuVGlXOGpETDc1UlVMT2hqU0JyejhKQTNMTlg4WDR6UmNXWlZ1NTU2Y0Mz?=
 =?utf-8?B?NnlyRHFrTnlsaWY1ckZ1YldEczJQVUwyRldQTmVDdkxPYlFpeGtQR2VPRW5S?=
 =?utf-8?B?Qm5ZMjh0Q1JYeVJ5M0kvQ1hwWG1IM1lrempVaCttZVliT1RZejlLenJTNVRB?=
 =?utf-8?B?OUd1bmFiT3YyOGx5U2VNUENzazFJTGJCdU5JK0d2ZnNxRUY3V3RFOW80VjJG?=
 =?utf-8?B?V3NzKzNTeU1vZERlUFd1eTZYajRiMUhzaWNZUXptdkRHM09JM2wzOGdLSUxI?=
 =?utf-8?B?WGJmMEc5dENHMjlQRlVQMTBGK3RxZ0pSY1ZscDllQVZVU3d6c1dtd1NYRTlo?=
 =?utf-8?B?dmIyaGcvaWZLSWtHNkVsMlpQYWVCU2RDS0xPc2dYWnZRZENWNWhQYjYxdEth?=
 =?utf-8?B?MitvQ3QyVVZzVEVyRWV6bGJwamgwTUxwT0V1NVN4L21YRFU3aXBlbjltZDFv?=
 =?utf-8?B?WjUwN2ZKL1NYZzBuRmxtVm1CMDNGMldwTXZXN3FKL0hPS0h5VFBNRXkrY2pB?=
 =?utf-8?B?ZmJpVW5JMGMxanBLZnNubmVOclJMalV4RVdrbU1NS20wc1dWSTNIb2pYK2pS?=
 =?utf-8?B?Smw4Q25XdlhhbGNoYkh4a0dFVmJVT1F0NUphZzRCUWRHUXZsdXVmYXVpdVhW?=
 =?utf-8?B?U0VQUEppK1lQY0ZIRjh3bDVrcCs5UG93dmNUd2F3dk9mSzFzd2t1NWtZaWR6?=
 =?utf-8?B?dmhVQlh6akttMmpSL01TckowTTA4YUdSRDNScHZRMlk3elc5SXA5TzJEaHh3?=
 =?utf-8?B?UVNHUTZXZUxwOFVpMnBMUmZaVWtMOUc1akxzaVR6ODM4Zk5jbzNObzN0NmEw?=
 =?utf-8?Q?n57KTFznFG1bweRs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uyi+YzSd1kStDM4R9H+h9REvEd8ygCiWnfET9kuhwacvEH82ndciwDxls/SMyXKXHaedwpcRPJhw97nlCh+zUjSOPSGL8POuyYTMthPUooxIdqj1eJkjMLOed809gw2DqGBbi2xMDMnPhyZS3sbArvwl7BdoF2ZRTJUhqinUpEWFhxneTPSwIOs384DklAaUJDYCmWxtKCxwVWFyNZZx6ie4tS9JO8eH/nUymQJsiQj7qfcun9SCQa2b05pDxQvc82Qe9iwSyYjwb2ST6BuGl9ZnardXhJ1yz0AmS7VcAxARlwG21+5izsV1wVaoy2uXnHKyF88A3L3JbbZq/qmoGkYd+bu0b3LfnbkWsa335+OsIDggO/wxG5ZQLEwy/niH28JsiJm/LfvsCtVaVJOCIblGn/GBVZryOf0adscts2K69rTqoT8FECcLl8i6UcLcagrviv9lJeovQ0pIl6KsmQgB3e0qXFl6XUZVDaH7qf3bihyJWyOAaXuaYVZXFkYGfmLqVkH1UZ6ztgkpXKES550HIsC+d/UIwY3NyZfRGbt5/guOoPKWn+3vlg+SANQsGTJM58GSdP6yZoUYtBZ7UCAUoDBCavELUJrJ6KLbFHg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6047d3c0-d665-491a-15ab-08de5f6861ad
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 18:58:25.3968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cRfKBwzYgYhv5Vc3d1GnHF/igveIGPBTJPaB58mt9c2Zi2ax7jGJrw1ko37a0gfGjhjCplMpJlkcd6yKm6cis2NQRene/vceBpXWjMw+UqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997678
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601290135
X-Proofpoint-ORIG-GUID: 31seKvMfQjJiYDGH6IjIbYoLmo1HvbMc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEzNSBTYWx0ZWRfX1RnTDlTiCb7P
 QZPkD4VPbo0fkniF5n8ius82Ee2fzvNyFXMxAcTpE0lunnV8LzpP3ATiU/8pwrRjNWmTRM7NfQ3
 DIM24sKG7Ph3LTotYyjs+wldXJZogLEpxU1KLqCuH3m1jHZmrR6yJTAGI/LWaqsHUa1yi5i6rgb
 qwBWUZCpIXPXQ9Wz2lLXEcCju00i6FwM0IZLAv33qJtk1hfdct8MvMgUe7rWL4ZXQxY6ujZrg8Q
 EDlaHFLbr2OBcm0b8YIHxvtbfKzoj6pUmKJ4tjtFRHLFJEv06L57AmlznrArIAuc/Bj6LKxjawO
 mULknaa3/lghBp2hmb9NZSLRJzjl3JkjC/NZhhR6CzhE4z7a01I2tQX3b72PsBpK9jwmmNpdHBS
 ij2yDpKkWkd3e6vV84Srz64AeuV9kpqWy5at6NoTF7XUZKwTIN4VJt0DJzFBJEqX41GQvs2MtYq
 Ng4eDoOq5mNRjunTw1FqeSoRwAD89Yln4YpgGNkI=
X-Authority-Analysis: v=2.4 cv=IrsTsb/g c=1 sm=1 tr=0 ts=697badd5 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=xVhDTqbCAAAA:8 a=5tvMn72Hn-DxAdUq3O8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GrmWmAYt4dzCMttCBZOh:22 cc=ntf awl=host:12103
X-Proofpoint-GUID: 31seKvMfQjJiYDGH6IjIbYoLmo1HvbMc
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8367-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim,paul-moore.com:url,oracle.com:email,oracle.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: B7DDBB3C13
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 01:31:05PM -0500, Paul Moore wrote:
> On Thu, Jan 29, 2026 at 12:11 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Thu, Jan 29, 2026 at 06:02:00PM +0100, Vlastimil Babka wrote:
> > > Agreed, the mmap_min_addr should stay visible and applied unconditionally.
> > > AFAICS the only relation to SECURITY/LSM is whether CONFIG_LSM_MMAP_MIN_ADDR
> > > is used as an additional lower limit to both CONFIG_DEFAULT_MMAP_MIN_ADDR
> > > and the sysctl-written value?
> >
> > Thanks, yeah we should probably actually move the non-LSM-relevant stuff
> > out to mm to be honest.
>
> Yes, definitely.  Send the LSM and VM lists some patches after the
> upcoming merge window closes and I'll make sure they are merged once
> fully ACK'd.

Great thank you! Will add to todo. I think that's a sensible thing we can
do to help you keep this code sane.

>
> > But that's future work, for an -rc8 hotfix ...
>
> Expect a patch later today.

Perfect thank you very much!

>
> --
> paul-moore.com

Cheers, Lorenzo

