Return-Path: <linux-integrity+bounces-7614-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2B3C43B76
	for <lists+linux-integrity@lfdr.de>; Sun, 09 Nov 2025 11:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B856188947D
	for <lists+linux-integrity@lfdr.de>; Sun,  9 Nov 2025 10:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3F2267AF2;
	Sun,  9 Nov 2025 10:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="c7eXga6X"
X-Original-To: linux-integrity@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011013.outbound.protection.outlook.com [52.101.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6220221299;
	Sun,  9 Nov 2025 10:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762682675; cv=fail; b=JsDwmO51jt5J8uaVOmWgook+gM+UL6xr6nhiIGPFkAqfEesF22hYROpUO4JcnvmsMGTla+hQk3g8dZ8ZIk+PsnLsirecPFW9PJ4TFlH+jQL1I5qbtORYTFZ1G0TXYCm2KEHMXHnNdkJFI1+qNVK8+pbqgyhZ7Soah4krx4RoEzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762682675; c=relaxed/simple;
	bh=+whY9Oj1Rq3jzsrPO02FjCLWC3F0Y6/NGpj1ZU39Onc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y2oserjW3OZfILyzAIgosZRYxF5dJcsNXGY5n4CSDLgMI5sPyBJpXY7CYpAln98G9UuHFSoDswOMhVDylPiiZMTFQ8E035D/AzKvhPjRJ/1cyMFib+kDcfv9fQi0ReBhq4Sly0k7tcBeNobM6/vu2sxfEC/GmpNthW48+8mraW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=c7eXga6X; arc=fail smtp.client-ip=52.101.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KfvCDJPxJEavmsN877PAhpCRh1UDfqUFoyFRbdnBsnlrMD46UCLI/EMupaoHi3Gg6PTlbr/LOb//OelnxTAhKgeBYPko8wc4AiLu+ilzqOXAtMODqlxSJIHu+X94F1zhAcO8XNRaojYcm3PI3ehnqOggp3NuBhaLNEBCDpgu4Q+SqeJP+q0oyk4uv3hLekVI5brxgCjTIl4HJoXqBZaF8ix+p6B/IjiktkesrZI+04YF1RUFZsnDV4DnKUuFIfNgX2d8PYp414cHWFNlT266oDRI40hDHDdr/vmN5O31U2fYjpcc/JgUXnQ349K/tLFXkX6mpV54TF64ieVZUKp1sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wdDgZDSeRdZu76HW1QkXuuYk7+p5ovG7R4jk0fWHtU=;
 b=mLLVutgdimcO8IVkAOMANh7eL6r4+OXbAngox+s3K7vHb0amdVsYkN/dgYrTEUtW2kYOadYrba0kIBb2uFqtUsyobdT06IBKY2OmqiVzC3l4nM7kmKT+9mNpfM2CXr75PnJeevKwLAmsG5GmufNdJFInoycFleLAdOXpFR2a08+iOpTuZ8yuT3DXOLhFa/gcBEAJ7WsN8mQB9ENtxt25MWXK0p4YaoVnzFb3R6nRJknX+7pxDRY9lODA8WnfCqoxnqswlN1k1DzARKoQY/aWxLREi0TZA07/+9tcwtY2cMbgddeSbcth/yYHDKiEQ0q9adL0Efs6pIFcA2lkvXvJrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wdDgZDSeRdZu76HW1QkXuuYk7+p5ovG7R4jk0fWHtU=;
 b=c7eXga6XW8gjgZ3wdP9ew+/CSv6fLADYAvskOH91J54dM9glWU1woSJ09yOH+pAPHSDxUN7TIPG+Lnu8XVhgYAPJR9z+UPkzuTDHI6lvba7ZFoZbW08zJpt2JYALszvXq9S8Pf0mcexGmHBY5jZK3HHRR0IzdXj5rtsuyZBttO+mGZcENDiZqAdkn+9cVyNIHSIxKLuzVKcNE9rm77MvvBLRU0NxyHbEkfkeaC8V4Ui4JdkeOioIrsAOaMly4+wLwEAsZpkYlB15p8kFJgqZp0b7/B/b+XYr0JcKLCgyongrtuQ5MHBbGbF/HonbBVsIvWmGl/1U8O9BapYTiWxZwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7381.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:447::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Sun, 9 Nov
 2025 10:04:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9298.010; Sun, 9 Nov 2025
 10:04:29 +0000
Message-ID: <a10203a2-56b5-40f7-ac46-8ad586cf52f2@siemens.com>
Date: Sun, 9 Nov 2025 11:04:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwrng: tpm: Do not enable by default
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
 linux-crypto@vger.kernel.org
References: <bbc41534-a2d9-42dc-ac8a-ff8a0b4fd41f@siemens.com>
 <aP_NN3HwO4Hp0-9T@kernel.org>
 <9cbee028-81a7-4be6-aa31-907c7cc683e3@siemens.com>
 <aRAb7KEPmPmoyQbm@kernel.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <aRAb7KEPmPmoyQbm@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0429.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7381:EE_
X-MS-Office365-Filtering-Correlation-Id: 997ef087-d96f-48ba-72b0-08de1f775eb0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGRaRmtrUmMwUHkyYnJqdmsrbHZmSFgyUyt2L1Z2NzRJVVhJQ0VEMjJUQzVN?=
 =?utf-8?B?OFpwaGl5MlFXc0w3VU0rWGYyZEI0eFg4bXJzUEdFU2xIQi83cThaRERlVHZV?=
 =?utf-8?B?bE01NnFwb2VKd1ZnaStpZU1TY3hKV1l2eXdoQTdtU2RuK3M5QXI1TXBtN0dn?=
 =?utf-8?B?ZmRweG9VZDRkZGN3bDZxYzEvZmY4ZlBmVEpHSmdxWmhJRWhJb1JGT3BlcHV1?=
 =?utf-8?B?eWF4bXUxU21mQmtsN29GamJqUUpvL1BJeGZITmRHL3dsSEZRMXVqZWQxTmU2?=
 =?utf-8?B?WE55VjVaNmo2eWVVOEhpU3lvRjljUkl2bkM5VUZiMVdKTzB6dXA3bmRpVmJH?=
 =?utf-8?B?cFoxemRvSVVqTEQ0U1FQUks4eUUyWlhnTzRFeE5Za3hsckVDd0lwZW5DYkgv?=
 =?utf-8?B?ZGRpc2xDNENxNXRsRzVGcGJweXZ4STNEUXZObDd0VkVDOUhFL3I2aVpVelZk?=
 =?utf-8?B?SVFYVTZ3Y2V3QU1ta0RtN1E3QUVxWk5wM3hqaTdtMXd6WUZ5bW0yUHhrTUxw?=
 =?utf-8?B?S0NwaWVxZVRmRjFCRDV1QTd1VGt3Y3hYTENFdDhjZ1lsZklEOU1RWEU0d09l?=
 =?utf-8?B?d3FVcjRjRjFTU29UemdWc3RkaXYvdERCTEkzOHo1YUZSRmdka25kRUtmYlho?=
 =?utf-8?B?bTFNaWVGUHhqR0xDQllsUEZ2OXMwbVlkY1BUR1JlQXQzdkJIdmxjNDlyOGox?=
 =?utf-8?B?WU4wUTh1NVV0dGFQdGlvQldDbEw2c3hUNW4waDBIVEhMc25PUXFvcXptL01P?=
 =?utf-8?B?YWEvOWhlRTR5cjlVcnZOUVRBZUNST0FFZEdFaDNvdVNmeHNGeVgvTG9BY2gv?=
 =?utf-8?B?dmY4ZmtDTU0wMUd0WGkyTno3TGxjN3NTMGs3citueUphYzczWUo1WDBpbWpt?=
 =?utf-8?B?MDVFMXFBRGk0a3ZpdGU4R0x2c2gwc3o2M2QvRjBTRkFFNHN2V2IrL3JWMlNW?=
 =?utf-8?B?ZlQyS2Q2dXVZdWNIVCtzdk83b3hrVDhqYVR1KzZxZ0VWcTg2WFRwNnA2VjZs?=
 =?utf-8?B?OUh4K1Z3c016QmJ3SlZUakp2WDliMlJRM2g3U1g5R29RRWxkYTduTFgwRzVu?=
 =?utf-8?B?bU1MMnVUVzE2WFpqdDhRNGpiQjdpTzlDTHplUDIxQnI0akxpbDRsTG1hbnZZ?=
 =?utf-8?B?d0VFc1FtV3NJb1RGVmpXNThwUUp5Y1hHSjJ5RVcxbVNJaVcxSEF6ZktOWlFa?=
 =?utf-8?B?enQzRVFsaWUyWHUwNk5McFhZZEtveXFkSEt3WDJ2OG9IWGlDaStMV3VvTzV0?=
 =?utf-8?B?TnNwUmJsZ0dNLytDQzBnN2RaRmlUaTU2NmJjZjdvSURiQmdmNDFOcmlkNHE0?=
 =?utf-8?B?Ujg5VWtJSTZoTkIzRTFvT1J5M0N4QVhDbVFISzhOT3lIV0Raelh0cGxYc25Q?=
 =?utf-8?B?aHlQQWJzekhOS3JHODNZWHhnSytOZXBWMXd5ZTlvSmxJMlJaeEs3Ti9FSGxY?=
 =?utf-8?B?RDhzQXFpY2pBQk9GbkFuOHJRNTIyVUlCV28wRzR3KzRhYlViVHBncXBuVTlC?=
 =?utf-8?B?ektlR1ZFYXUzT3NoYU5WSjlhNXlYTzhHdytBMm9NMldpV294TUkxM1ZybkdX?=
 =?utf-8?B?M0RIYTNxUFYxMFlUNFJqTDMxWUZTcVhQcE1HcGNMTjVOcUhwU01pZCtiR2Nt?=
 =?utf-8?B?R3YvOXVkU09lbFEyU24zYmoxM29OalF5YXNRcXJEUURZQ1JLVkZYZDBoRTRj?=
 =?utf-8?B?WVBpTUtIMFViTHRLT1VQQllGOWx3cW52RlhTQStaVVlkeUtkbmhLOGlDdElT?=
 =?utf-8?B?K3VzYlNYRjkxQUlKWk9YVXY0YXRadm9RT0l3ZlZBbXNEc2VBejlKYUpFQ2Rx?=
 =?utf-8?B?Q3BmZ1B6NjJkaXR5THZDNnJJMEIrdkNaRGkvV2piVTBuZ0xZNVRWdGtJaG1C?=
 =?utf-8?B?RlZHVDN0amI2VlVsMzFuRm9MTzFCMFZDdXBwVTZDZjc4SXpoL0hsdHZqYUpu?=
 =?utf-8?Q?L2kxWtmM26c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGlMZmJIdWJyQWVXZVZFMHFlalB5TWxkS2NpQ09SYVhpR1hsQVBiaDlHZ0Ir?=
 =?utf-8?B?aUt6dGp2Vkp3OERPbGdnN3U3L3c4d2pFS0FzVUJaUHp0UklraldkaHc0cVI1?=
 =?utf-8?B?MGdTcXpaOEhKejVsRlo2eEw0OTA4aVBRbDdyV1o2dE1BSGRBaElGUXZFVXV6?=
 =?utf-8?B?TiszRnBQQ1pSTmprenNGVXpTYkxWdnBFRG5MeCtycE43OEZuazdrTXliMVU0?=
 =?utf-8?B?dzZYOXBXdm84a2kvWWJFOUN5cVFCL0NHeVZCSU5GeEtTWWxMNnRLSGt1YWx2?=
 =?utf-8?B?ZG1ScXJtdHRRMmh5L2FLY0tVUTM2Z21SdzZWZlNYVFZHQzhvNmpTZ1MyZHVN?=
 =?utf-8?B?OE5nL2VpelhDK2pHWkh2REZGNXhIVDVIU09kTnJzWGRKazRmT2YzQ2RHT1dT?=
 =?utf-8?B?RHR6RnJmQTdaL09BV1Y4OTVZaDZka2ZHVkxxWXpjdk5VUU1YdEpOQmRHcmpa?=
 =?utf-8?B?aXVYeEp6b2dUTS92UGl6MFNNVnlKay9ETjFBZzIvVEc4Mis2WnY3MWdLTkx0?=
 =?utf-8?B?ZVF2b2xPQ0c2QlRwNWVSRFVvdjRkeGsxMXJTU290K20rbnFreHJ2RXlVMHpL?=
 =?utf-8?B?VkdPUHV3SmxEbCs1K2JnajVqRmd4VlFMV2lvZGNBandzQTZ5MnIzekVRRlNJ?=
 =?utf-8?B?endJTUZJS3ZvY2cwM3QvTjdiTlZkSDJ6SE43VFpLbzJWWXhlR29BNVRGeFA5?=
 =?utf-8?B?ME9MQzdBeHovcm9wbXROSUFGdXJid3NUVVZsU0RiWXBMNTJHSFk3SzMwZ2RC?=
 =?utf-8?B?cC9zZTlIS1FZeVF5OThxb0FaTVE5OXBqM2tZSVkxQlFwQW1QNHozUEd5Mkxs?=
 =?utf-8?B?V28vVW5yR1RGNTFyQXF6VFBMcUpSWjkwYy94UDlNT3F2TUFHemRRYThYUVVD?=
 =?utf-8?B?cm1PbHFWZG9wRzdyYXAzZlBKeWsyM09XZ0tSY2xQZ0VhWW1ma0h4WlNHMDlz?=
 =?utf-8?B?aXk4c0ZKR25IS1ZQYkFWbmZtVnpVLzRlaS8vSkpsYzdQeHhSL2FhSmk5TWRE?=
 =?utf-8?B?ekNXQm1Vcmgwa21GT3d3UCt3RGlKSjBWK1NYbTdiNDE0QkVSMytkVHY1TGJa?=
 =?utf-8?B?OUlSc2VpK0JQT3F5UlFla3dXSERnanVpV1pDV2dBYVJrb3VxSU1TOHpIY25E?=
 =?utf-8?B?Tk1wWnUyTytBTlNXMXdGbnZYck9xb3lKdjZldDVzczl6YkZLT2JTWUdTVlZL?=
 =?utf-8?B?dXZmOVVpUmRKVThXb0ZVKytYaWdhK29KWUhnMzFCcXprenNpMkpyTGZlazYz?=
 =?utf-8?B?Q1RzOGZ1ZFF0REE1MXRtcVFrbW1UUStUSTlhOVdYdHh0d1FDdmtqNHpSRW1U?=
 =?utf-8?B?aFBJSk1telFiR1M0dU1FQloxOVFQMlpGeW9OTFAzUXp4U0hORzg4ck1PYWc3?=
 =?utf-8?B?dFg1ZDZtclA1M0ZjZXo1UWNEc1piR3RDYWtBQU14Q3JnZHJDWWFzRlU5bmNo?=
 =?utf-8?B?TkpTT2V3UDdSSEhhSWd0MGxNc0NvTTNSVkNoZ256M3RsRVZaMWVEQjZhNnZ4?=
 =?utf-8?B?NEhHckMyVit4MmFKQVJDK2kzQkFiUVpYOEpUVmFwMXlxTWtZTlpobHgzbENh?=
 =?utf-8?B?ekdTNUYxNzI1MmtzM1ZnQ2ZvTzNCMnRTelE2enQrQ1FnTG8wbmlkMnh4VjVW?=
 =?utf-8?B?M0l1QnlMa2Fma2JEQ2tIL3ladkZXODg2YXZYaGNrVy9LNlFJU3A0Z3BzK2lq?=
 =?utf-8?B?bkRVdnVpeVM2QUYvZkhBa1VEVDQyYmFZVlNZY3lXWVFkNjdFZEd6QnV6UjM2?=
 =?utf-8?B?TFhJUldpTHI0REZiOHIreTdwbHhHajNqNEtKY2xsbEVxenZndWVpU0ZQOVJw?=
 =?utf-8?B?NEQyTmZLdHl1S2pnWTdnUGlhMmRtYnI1T2lLVnA5d2E5UjRhMVN1R1QxNnZU?=
 =?utf-8?B?aUZPandUUjNEbHVseU1IVzU4NUpmV09OUHdvSi9ESjhSd2F1MGxMRXR0VERk?=
 =?utf-8?B?VWgvZWtKMDhoVnZsN3BZZjllb1lUNWRuQlFnYWphUVdjRFhEdjlUcE85UzVL?=
 =?utf-8?B?NERVL1dZS1J6bTE1UjhwZkhYUjN5WHRsdnY4dXlPK01yams0RHBxcXhjRzIw?=
 =?utf-8?B?L2JyL3ByOWtQZDVTUVFWV0NzeWVUdGZ2NzFaOWg4WC9nNGozUDliVW1aZXRy?=
 =?utf-8?Q?NCwxF4i19Jcu3FFO3PuugLIPp?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 997ef087-d96f-48ba-72b0-08de1f775eb0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2025 10:04:29.4480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rfe2H1V493c+g5TfQGBb+jt+hCc9BRfzZ0SG/w6sKkwJG95FRRnGB7wk7r/Dqpe44zTqPaxi/+8ZkvI7gCicMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7381

On 09.11.25 05:43, Jarkko Sakkinen wrote:
> On Tue, Oct 28, 2025 at 06:46:39AM +0100, Jan Kiszka wrote:
>> On 27.10.25 20:51, Jarkko Sakkinen wrote:
>>> On Tue, Oct 21, 2025 at 02:46:15PM +0200, Jan Kiszka wrote:
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> As seen with optee_ftpm, which uses ms-tpm-20-ref [1], a TPM may write
>>>> the current time epoch to its NV storage every 4 seconds if there are
>>>> commands sent to it. The 60 seconds periodic update of the entropy pool
>>>> that the hwrng kthread does triggers this, causing about 4 writes per
>>>> requests. Makes 2 millions per year for a 24/7 device, and that is a lot
>>>> for its backing NV storage.
>>>>
>>>> It is therefore better to make the user intentionally enable this,
>>>> providing a chance to read the warning.
>>>>
>>>> [1] https://github.com/Microsoft/ms-tpm-20-ref
>>>>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> Looking at DRBG_* from [1] I don't see anything you describe. If OPTEE
>>> writes NVRAM,  then the implementation is broken.
>>
>> It's not OP-TEE, but it might be indeed an artifact of the reference
>> implementation that the fTPM is using because it is also targeting
>> simulation:
>>
>> https://github.com/microsoft/ms-tpm-20-ref/blob/ee21db0a941decd3cac67925ea3310873af60ab3/TPMCmd/tpm/src/main/ExecCommand.c#L99
>> (Page 942 in [1])
>>
>> -> ... ->
>>
>> https://github.com/microsoft/ms-tpm-20-ref/blob/main/TPMCmd/tpm/src/subsystem/Time.c#L68
>> (Page 1075 in [1])
>>
>>>
>>> Also AFAIK, it is pre-seeded per power cycle. There's nothing that even
>>> distantly relates on using NVRAM.
>>>
>>> [1] https://trustedcomputinggroup.org/wp-content/uploads/TPM-2.0-1.83-Part-4-Supporting-Routines-Code.pdf
>>>
>>> BR, Jarkko
>>
>> Given how detailed [1] is, we likely need to address that directly there
>> to avoid spreading this issue into fTPMs. Fact is, that there firmware
>> implementations out there which exactly do what [1] suggests: writing to
>> NV every 4 seconds on every command.
> 
> We don't reference code as a certified hardware product, sorry.
> 

Means what?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

