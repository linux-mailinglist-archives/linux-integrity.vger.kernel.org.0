Return-Path: <linux-integrity+bounces-7053-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A05B0B534A7
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Sep 2025 15:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0753189BF7A
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Sep 2025 13:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C838332BF49;
	Thu, 11 Sep 2025 13:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b="BJdc5wso";
	dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b="jgBdK+hm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx08-0057a101.pphosted.com (mx08-0057a101.pphosted.com [185.183.31.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41E21A08A4;
	Thu, 11 Sep 2025 13:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.31.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599088; cv=fail; b=kMcdrZrFJ8ysMdig2pB/gMwV4C76H/9CFOL+4MaoldLDy/NzD2hBBA6WWcfpmDhZDIjh41ztYGqPxfEennwhfU0hQNIzJyJSBZWhawhhoc1pXX29ID9bKGcItMbaXxfWFYG2RuDQ5+RC5v7M5DkRf4qZk/bl4B9tMWL8/Q53AsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599088; c=relaxed/simple;
	bh=oddrOvDSZH978Y9QNUk8o/ykca7AgmrP9gE8mOLccnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=pfglU0YchE8OS6WGg5my9m8Lfih/XQjGwXQEs1oLRoXABZqKAZmY5Qw31LqpRLRdEX9pU9yYTdSfokRQEzTL1MBFfGdUMZY0x23qq4rhuTQ5CxxxcscRk/iYzgOtJoOhZ8Nf9snSExQ8DYpKI1DBhYl0IX8sAPIsb/yd6pfm4NA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com; spf=pass smtp.mailfrom=westermo.com; dkim=pass (2048-bit key) header.d=westermo.com header.i=@westermo.com header.b=BJdc5wso; dkim=pass (1024-bit key) header.d=beijerelectronicsab.onmicrosoft.com header.i=@beijerelectronicsab.onmicrosoft.com header.b=jgBdK+hm; arc=fail smtp.client-ip=185.183.31.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=westermo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westermo.com
Received: from pps.filterd (m0214196.ppops.net [127.0.0.1])
	by mx07-0057a101.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58B3xk6X4116943;
	Thu, 11 Sep 2025 15:52:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=westermo.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=270620241; bh=oddrOvDSZH978Y9QNUk8o/
	ykca7AgmrP9gE8mOLccnQ=; b=BJdc5wso3Hf4sjU8+GwhmH4osIFSQxPH/Cru/E
	vy0rUZje6sE+sAH37lwc3phgAuEM78D5PvL+5cwPjeDNng8Fn0bVnS9YUmiDtK4S
	wlyQZI+CG5lw8TAKnDAU1TQPy7p1DUgXrpcnyyWAhVOW/ynGuX/VuEepH/fc/bQu
	nCG5SqsBpa4hIQ5ctGfXXANSCyIG7CdA3IOm10u8K8h7h46Wv+/IfduJ1/naH/3f
	QPXbLpFeyYRmNWNPIAf8yD5Yv9i+XiGuibkis9xJ+uLchjwRQngZm0wc+ymJSlXS
	tEpO6T7LWLC+t9hT2a1xBq921sreG2dnrjj8DieNKwCy9BKw==
Received: from eur02-am0-obe.outbound.protection.outlook.com (mail-am0eur02on2122.outbound.protection.outlook.com [40.107.247.122])
	by mx07-0057a101.pphosted.com (PPS) with ESMTPS id 492jwga7fb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 15:52:44 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z7Q6CI45G/ZX7BQ11NRYcshfXD0RQlDNGVUj0n8Fx9rMQMHuN30xp1nudwaEbkvDIysp8dCsAGRnObCcqOuh2tt1Jah1yZA47r9q+o0Z+4WKNr/hH+MyId9fOEJeSHtVum3LmldjWrLW0l62V+fyOHvDOAAw3o8CRHaU+EV18d7Xu6N+6prNSTKpSheH/+Z5jL+PWsqVZc1/eyvm/TeDNHTb6AzaOCvvyp3psO7FUxFH4TNUtfp3KQCq+14CntSc+IF93Cce3lYGdhbqOgKMd6ZXGy87nILHCri9bGGWSz1lU67+bxVsidM9Jl7fbCuMkaQ+TOBFT5m+GtYL9tNB1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oddrOvDSZH978Y9QNUk8o/ykca7AgmrP9gE8mOLccnQ=;
 b=j/XdEHogklqWyQu+zL1BssZFRZH1gwQvP5j/ws0m8cbSTzQk/lmulH1gq3P3jTUK+8zAmj/m0allgDM0G0MKCH6XNo0d5xNtZUgn/D8XNo6+0Y99F9kRhzoiUOqiVkzGOSl+y+N+Goi+cEx2NwZo8STkK0wyQNWeUz67W6rSqDg2E1jfJFSYqIj8YtBHTMQxoGwVumpjhOZ2ha9gfmlCJtagS7a4ubgq+YImKmRVYWaf9OW4DKYTe3V+KJZY8PXRBwTbLDT/7dOyvA71kWliYi84QpNFHpuoltWNVcPZwqp/708oQS38q8gBIHC+T3BVUxo7clky3nKuzQdkRtOS/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=westermo.com; dmarc=pass action=none header.from=westermo.com;
 dkim=pass header.d=westermo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=beijerelectronicsab.onmicrosoft.com;
 s=selector1-beijerelectronicsab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oddrOvDSZH978Y9QNUk8o/ykca7AgmrP9gE8mOLccnQ=;
 b=jgBdK+hmyMya+eGXXSPnZwzyfYuVFUY6dQaVg3iWfVJlj9Jj3y98YbZhiCHClF4G14QpI961ltoMo/Dp9iLY5SkkSbVXZLtRAPLfkSyBi3/x3g49jAiyT/xZAGS2DEtGP3HccV8zCzRIpzHNb65HlXQhRgDmySDAW3bEepqVw6E=
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM (2603:10a6:d10:17c::10)
 by PR3P192MB0762.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:4d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 13:52:39 +0000
Received: from FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0]) by FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 ([fe80::8e66:c97e:57a6:c2b0%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 13:52:39 +0000
Date: Thu, 11 Sep 2025 15:52:33 +0200
From: Alexander Wilhelm <alexander.wilhelm@westermo.com>
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc: linux-integrity@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: tpm: SLM9670 does not work on T1023
Message-ID: <aMLUIVjHZ6CFvd33@fue-alewi-winx>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/2.2.12 (2023-09-09)
X-ClientProxiedBy: HE1PR0902CA0043.eurprd09.prod.outlook.com
 (2603:10a6:7:15::32) To FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:d10:17c::10)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWP192MB2997:EE_|PR3P192MB0762:EE_
X-MS-Office365-Filtering-Correlation-Id: 44830f0f-926b-4a90-1f51-08ddf13a78bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUtMc3Z3NVJ1Sit2S0E5UmFZNjRXSDVBK29HSFhRejVLTGNSN2NoN3VPMitz?=
 =?utf-8?B?ZjlSWFllc0pFcHRKcE9PZmJiaWI2TGp6K2FVSS9sN1dhTW1lZkpYL3VtaEFM?=
 =?utf-8?B?UFdRVyt1cGNjdHgxdlV2SWFKYjh0VklxazZteU1iekQzVEpkRWVQcXRISDJJ?=
 =?utf-8?B?cFA1cGZ3SnAzc2JEQ3RxS3MzTTlYM2ZWcWRxb0NZSDhWS0JwQ21hZ05aNVlC?=
 =?utf-8?B?cCtUb0lEWldUazc5OERha0E1V202bUx2SXBkMVQ2aFZNcDRSbUVCdHRTalU5?=
 =?utf-8?B?amFYYUpnY2tTQzJkVExiQThoaUtSN3NLemVmVUJ5WCtmeE43ZG4vU1A1TmtZ?=
 =?utf-8?B?NXoxZGt1eFpmMzlDRjdjM3ZtTC9DZjhkR0Uvall2S1ljVjBSeFlZUUd0Rkg2?=
 =?utf-8?B?NWh4ZlY0VEdqZXhHUzBlYkFzOWIyM3BQNXlFMDZnZjFJWVYyT3lXTXpVdnRo?=
 =?utf-8?B?UE1kTjhMTWlvOXQ1NUhvV21lMnovMlVtVm1sTjd3elJmQ1AyQ1RZbG91TXdJ?=
 =?utf-8?B?aTJBd1U5VVlFZ1FtTml5YzhVK3lTdkNwZm11Slo1VWYzNUxaNmw3aVIxNVZR?=
 =?utf-8?B?UWVIYis5aW5uNDFIWmZhemNqWE52amJCLzg3VWlvTDl6cmdEM1docS84RXBr?=
 =?utf-8?B?WHhYb3gzcUxjZEhLaVVqOXhjUldpalA4RlQ2cGZDbWRERHplQVpQUEc5UE9v?=
 =?utf-8?B?dm82VnFEencrWnJySjR6THl3QjRDcGhaUlM4bU5ZOGVRZGhTbFVvNm9WMHBl?=
 =?utf-8?B?M0pEWGo0bzdXZW13dDRaMVFNcEFTdDFDc3QxUU9lU1JvK01UclhaNE5JbnRI?=
 =?utf-8?B?amlRUHBDSVFsSE9MWWxqb21MMnRYY0pCWFNtS00zR3N6dmkyMWhLb01Bc1dK?=
 =?utf-8?B?QmpzSkluV2p6RGJRWVl0eUh2U2FST3dYbXM5L2hCYmxJVVNiSGdsdmpLV2U3?=
 =?utf-8?B?a2w3eXg5R1VvUFdiRGdXNU9KYVh5V2k3V1g1VzBhb0VEZjN5Nzh3SmsyVUd4?=
 =?utf-8?B?c2ZvbUkwd2t5b1lvc1A0eVRCNUVUNzhrckdvcUpwTmNqQmQ4cWhhenhMQzVa?=
 =?utf-8?B?anBJS3h0U0tvNWpsYUQyTkhqYnNTLzU1WGNUOEdtbUVBeW1COHo4TldKR0Z1?=
 =?utf-8?B?TTNDZStxNEZ2ZjhjbGZxb2Q5SmxUeDFSUDg5b3llbExVTW9iOVVjYnQ4U2xy?=
 =?utf-8?B?YjFRa0IwVVlLblhSK3ZuUVYwWThtRWdzSCs4VzJRZmxsd2cyQUxjanR0dERn?=
 =?utf-8?B?T2V0R3RpOXUvNml5ME5WbkpIV09mUkxXaE1qTWI3MHlkakw5YmdQdzh1b09i?=
 =?utf-8?B?ZHdkWVhsMUdNOEV6M3hwaGxpVnpVTU9TWENiWlhEbXV6UC9BeC9JdjcxcXg5?=
 =?utf-8?B?bHlUeHo3dFRvNmJYVnNtQVdOb1pNQ1JvNlVreGIxSUl2Snh6TWJaU28rRTQ3?=
 =?utf-8?B?K0FobE9XdzRPOWlCRGx3NmlDcHByQXhHZzUxWXYwRlU5a1JKejRLa1F6RTJm?=
 =?utf-8?B?aXAyVmtud3ZLRWlDSFRKQlZlZEc5QXJwNXdHVS9sZTJKcjBKQkR4ZmMxa1VX?=
 =?utf-8?B?RERBbllyVHF3ZlJTZElaNWVrTUUzSzYxRmxTQnl6VjR0SXJPNmN4MTlJa2xk?=
 =?utf-8?B?a0Q0b2dJOWVjdDJhVVpRN053NWhlcDJUalExZTExUUtKRkJOL2ZmSnhoWXo4?=
 =?utf-8?B?VFNOUFdtQWdZR3ExSjJSYWdQajFacGRTbGFXV3lXUWNXTWp5TlZPQ1ZESzd6?=
 =?utf-8?B?alpqWUowMU9WZUdtdEo2N25wSXhORUlBMWgyb3VGMGRRelg5NW9NTS9SYjhE?=
 =?utf-8?B?UHhQM2xZT0Q2UG5HdWpUaHRscHJjZUprWVdZTXZNa1hzRDI0NHJIRGo0UzdF?=
 =?utf-8?B?RC9VeU1YTVMydm95aitPUmpGTjJFQTJ6TmV0U2xRWUpWN1RDOW00emd4REQ1?=
 =?utf-8?Q?YBG2N7dD8o8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRWP192MB2997.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2dnMW1Sb01LYkZzM1RuZ3pIZ0F0TlMzVEZYclFsQ1ovVmFuMTdFMlQyVGxL?=
 =?utf-8?B?eFJJcjF2NTNqSWk0Vk0wUUJFdHBUMmhucjRmYjViRjh1VGVUZWV5TnplZnNK?=
 =?utf-8?B?cFh3Ni8vZVRWZGNkRWV5WUdka0owM3IreC9PMm1DaXljSEVwUFNjWlY1dTRX?=
 =?utf-8?B?L1FxSUtaU3JWSHdoWlVzU1FRWDB3UVdPZGsrMnp3bG10OVF1eVd6UXluR3g4?=
 =?utf-8?B?aUhBcjRYR1JFUFpYYko2OGJkd2dCbm9nTm1Idzh1bXpFNXBiMGhnSG1MamNz?=
 =?utf-8?B?OFRjUFdHdnNuRGc1S3lxYjZSNUV3MW1VTWdjUWZVckwzcVIweXpNRmNCaW5U?=
 =?utf-8?B?RmVydXUrTGhRSnIxUTZtT0lPbmRhd3piby9sc3FtczNFTlZWL1ZDWEh5QkhE?=
 =?utf-8?B?TnNXbHgvK0ZNbHN5VThvU1ZIakMwbTVpRm9LcHpsTjNPMnIva0hJdW4zNTZC?=
 =?utf-8?B?ZnI2RE9SQzltL3BXemNGUkdCbko2OE1zdTBTa1BYbGt2Q3NtS0xjdk1EbHUy?=
 =?utf-8?B?VzUzbUJHQXlZVHRVK01KTDFLSlBUQ3NTd0ZzSkFxb0JRYXBvMWtqT0dIL2Mv?=
 =?utf-8?B?cnp0NkdIaWxCWk5jY2c1d3U0VDQrSlBhckxvdHJ2T2lPc01zNVZaSTExVVlr?=
 =?utf-8?B?N3h5QkdLcHBYdElua2dKK2ZpMnh4UnRuejgxZjh2b0J0ZmYvYS9YdjBFZEpT?=
 =?utf-8?B?ZDVXN1ZkSWpObFgyV1E5OXBHNDlQdTEvQ0hJQW1tVjN0Tk1jdkdTUE9qakpj?=
 =?utf-8?B?aWZjRTU4QVorWFFVb1g5ajhiZW5pVUE1U21uQ1pPWE0rTDJReGMwMDdBNmFh?=
 =?utf-8?B?ckpVdnhEa1RNM1hMbkFHalRRaVJneDl5SSt5UlZia0JpVGNxdk56ZUtWLzBP?=
 =?utf-8?B?NHZyNmlZcnNnNGRIVlVzRmRDWG9VZ3lqWnVjRVl2TVRvaEt6bVR4ZTJ3Z1gv?=
 =?utf-8?B?aUhOUFlVbzRaYkZYMHJXYzNicVRqWTZZdDVsYW13RzBsTm5EUEJGbnhadkw2?=
 =?utf-8?B?NXhhMy9mMlJkODg0dW04K2xncUFjaWtZa1BheklxTmd4WDdOeWRtRy9zdjBt?=
 =?utf-8?B?VXlqNDhpRlJQWUNiV0ZRVTdjUm14NVlOdjdwSU9ZeG1oTVRuVmx1SUxWMHk2?=
 =?utf-8?B?TWQrR0dTNStFUFp0aStERTdKcm1qNmdwV0VKWjBFK1NpSnc4NW83Q2ZycnpB?=
 =?utf-8?B?bkpScHZ3SmlJczdLSmtZL1RISDhYVmZlbUZqQnY4cTJaT3BOTmFIZEVpU2V4?=
 =?utf-8?B?VXdEZkFldEl4QVo4TjVBdXczQzErZjBsZ24wWnFtekN2ZUVucUpaTFdIZmlx?=
 =?utf-8?B?UzBzMmJHNGZaVzJ5cVFJbVJLcGFGbHk4V0twb2pzL2JCRFdOTHVNVE1xNjl0?=
 =?utf-8?B?elYwRmJpaDg5bGN1aW5ySzA4ZWtMUStXa21ZbVQ3eFlwYy8zcjRDaFcvanJJ?=
 =?utf-8?B?bGZQUHhPdnBiejRIL3hxSnNIRDBULzBYV0ErTU5vRk9pNEphRXYzY2pLKzJZ?=
 =?utf-8?B?djlybkliR0xFTms3L25maDlWQSttbmlNYlAxbkVvMFVmdncyVVp0THBxUVd0?=
 =?utf-8?B?dTF1bkh5UnFyUCtPaWRkL2h5UXdtTi9wTnNJZXUwQjhtMld6VW1CNEV6VTZZ?=
 =?utf-8?B?RjM3QUhEQVEyK0RMdTNlbFRmOGVxYStIYy9mVzlBRGpwTnVILzBpcGQ1QU1o?=
 =?utf-8?B?Z2ZGakRScEtNNFgyQ0FXY2E0SWRGN3Z0Q3dRTW9IU1NtSHV3SVF2cDJKTzBk?=
 =?utf-8?B?M2dXODZ1ZDJQT0FtMHVsaU5mVVBmZ0ltZWNrWktjbmZzSnRwS001N20ra04r?=
 =?utf-8?B?QkVoUWZlWTRFUGZ6Ty9NakFmbmd6SnNYaW82RjEramdjV09lMzBNdDdLa2ta?=
 =?utf-8?B?WlV3MTBPVnFmOVhiaU0xSm9oTDlmZUErQlNoTmxpOWxEa2RhOHRwWFhlR3d0?=
 =?utf-8?B?Ylk1VEFuaFJ3MXJQUFZxTGcxQzZwMVdOUnhaNU4wdXR3cTIvNzk3YTZGRWx6?=
 =?utf-8?B?bzhhSXF0c0U5emVVNGdFL0gzMlZPeHNoQi94SnZLNW9BcXo3eXQwOXpKQjNm?=
 =?utf-8?B?ejhUS05yYWVEL0d1bFFwTXF2T1gvWThZNVloWklSQW1IemJHREZsSitualFY?=
 =?utf-8?Q?cFf2D9VaqrY8++o99Odj+hHlL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oDMON9deBRdXQ4J+nwvpcKRgNAkGLNFR6nqDjviu9UvPsLbMxObpE2SG833c8KGgnfhx4vACj7aT5XcQ6FZOBhSBXq/vtrofLpwUGlBBnTCn7guilTREn63SwtOdKRWkyrbg8B7f5uHfuEfvypbvU0G72IgWuqQd0e6HTD7I4qCKgt5JfP2iYGWr+RgNucNsY5fFtuKi6Qw4iC95W37TpKx8SlrZz4sk8+TIVzxjkXLmJRwPXf/mDyt0S4J0amV9zQh4LmwIaSGWPR8cPK1qvs+qwu3PY8fPybs4hEtJ1Y7gVv9zBV09PJNqn8nRaE25S9cmpBZKNUyyl4ufEZf2/BsFvRWp8AmZaeLdGC8VeYggTg7vnFZX+aeVWhEwCFATpVcb/uBCyuW9dxaGtKaG6ElNUB4xfHNyPVdWG0NsdBlCx9nPllbb0LZKyyFZwkxXSpq4GnhSD5n/TtSBPafcp7Oh16JnuQui8YSvc6NB8T7gPH/GK5vb3En1efRmU59cUWShv3sAP0oG62mFda2GwHQRmsHLYQiVCa7GjYr03ahb75pg6/Z71T+BHxSLHA08mcoevwcxovsy8ZY7MnF2HQ/ce262xfIlRTUpu02wM9LJ0fQTvWc2XTyulvHIZqfj
X-OriginatorOrg: westermo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44830f0f-926b-4a90-1f51-08ddf13a78bd
X-MS-Exchange-CrossTenant-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 13:52:39.3005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b2e9b91-de77-4ca7-8130-c80faee67059
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FVWwIzyyhE5x4ym0J0Bk8ee9TLDpBq9rynREK50jmgPhemCG7JQAph7DoiRbIhmxEPYlAcwACJt968OqJGeCyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P192MB0762
X-MS-Exchange-CrossPremises-AuthSource: FRWP192MB2997.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 14
X-MS-Exchange-CrossPremises-Mapi-Admin-Submission:
X-MS-Exchange-CrossPremises-MessageSource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-OriginalClientIPAddress: 104.151.95.196
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-Antispam-ScanContext:
	DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-Processed-By-Journaling: Journal Agent
X-OrganizationHeadersPreserved: PR3P192MB0762.EURP192.PROD.OUTLOOK.COM
X-Proofpoint-GUID: Fl7eYSEC6bhXRTVPz6IGmmh0eiCAFD3O
X-Proofpoint-ORIG-GUID: Fl7eYSEC6bhXRTVPz6IGmmh0eiCAFD3O
X-Authority-Analysis: v=2.4 cv=L9cdQ/T8 c=1 sm=1 tr=0 ts=68c2d42d cx=c_pps
 a=hqJzBl7Ahnt1scFs/UlQVQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=8gLI3H-aZtYA:10
 a=5WlnoM2IXMwQxd68EiMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTExMDEyMiBTYWx0ZWRfX2MJhvjP4Uct9
 69ykIaPZPAJ2Bd9kgxjXA5XRnjbA9tshFVWmkY/JPGza/OBOPO1uEwTHRIQyBW7GcOiX5CPvULW
 eE1KPwx6Y6RxdMRFJ/Vp46ig6F7akmD1K9jtRiGAeA/MSMPIB569CltlLe4NCcbBPKddUpviq47
 x6UdeydikMK+42ZVauUfddIBIPksoweshXQhIf8QgqdreNhbgD56Kc1cSYjilqD3XbZ4NQmc2Zg
 jbxYe9eEQS9wZbjhdxQC2a7mE8a9GeM3WYSRXbkSUgDi1uTtU5xJ4f6VVFI5gK3eA/UBCUUkcco
 5oKvAKz3zOmknilIG7bV5VtDFJykgcNYou3ZDKzjNUB0IqejgUB3LMbJnh115o=

Hello devs,

I'm trying to bring up the SLM9670 TPM 2.0 device connected via SPI on a QorIQ
T1023-based board. Pin control is fully configured through the RCW, so I haven't
added any additional properties in the device tree. The SPI controller accesses
the TPM using `#CS0`.

However, the driver reads an incorrect vendor ID (0x1000000) and hangs during
the startup sequence. A logic analyzer shows that the chip select line goes high
immediately after transmitting 4 bytes, which, according to various forum
discussions, does not comply with the TPM specification. Unfortunately, I
haven't found a definitive solution to this issue.

Could this be a bug in the `spi-fsl-espi` driver, or is it possibly a hardware
limitation of the T1023? I've come across some suggestions that involve using a
GPIO as an alternative chip select instead of the one provided by the SPI
controller. Can anyone confirm whether this workaround is viable? I’d prefer to
avoid a PCB redesign unless it's absolutely necessary.


Best regards
Alexander Wilhelm

