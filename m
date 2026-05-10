Return-Path: <linux-integrity+bounces-9517-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4L+nMMPtAGpUOgEAu9opvQ
	(envelope-from <linux-integrity+bounces-9517-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 10 May 2026 22:42:43 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F015064C1
	for <lists+linux-integrity@lfdr.de>; Sun, 10 May 2026 22:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DBA83004C3E
	for <lists+linux-integrity@lfdr.de>; Sun, 10 May 2026 20:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8580932E151;
	Sun, 10 May 2026 20:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="PmU/sFH2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013006.outbound.protection.outlook.com [52.101.83.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9934225A642;
	Sun, 10 May 2026 20:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778445758; cv=fail; b=ej5/9Kikj0Dex64ERteMCFZD8PciRjKjLGsIhH3qQ3JWsuaieWZFdEuCdnHEa8lrXkB9qeNaD/pLbEm2BAtVYL/uiS2TlpdSxxcGgilT3evSsCsye2GsQgKpfLFDlhisdzighDITKdgSHdHM2fDjPsjqOdpjuPHbexly/P+IAKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778445758; c=relaxed/simple;
	bh=E0hZXsMBWxhfWtjIRzYNGAyWjCK8gG6ymJO1xQSdx7c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t8vVAGI2WNDjPwVxMYwl1VNDHF8kfmjs1Qoelb4HikJ+Ukikha/wFR3cZRNMyQK/4y0QsbLdTeMND00NTRxDPl96sPT1aJ/b8jJI+US3tATdtZ08jmN+WbuXaYgOl4uKkfs++L6PpdDnf0TPNQ5QBu9JwSePh16IBHOJ7fL+D1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=PmU/sFH2; arc=fail smtp.client-ip=52.101.83.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KKoIXTFHiWMruCKtXJZc6LbAw+yP3PqQfjZTGE7EqDlQlHU+Mb7+uiv7e/RCwJlmZ/cj0/2l4EF3bESJf6hCVYvZZY0D9L1lfg2tsMoonK+7/DtIScJn57UlrImTWJp76Iq8d0hReLCgbQlWs0o+ehxcdMEhexGc4C1nwVsXNKpH+C1ZCysyX12Es0HwuMMdEd0RXv7vhdbLzK7q6id2s2ZGPvJXDD3ijaFIMU6QcGVEIWQPu1JoOKUZ6eo2cIqCDz7MsdKo3m63otUWCehBOmr3dSzquGiRuoIyLYu0lnas5O+HmTGJakFHfMNqTbB2B4CUGWqRUIbN47VminovVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/SrZ/F2Ug/ECFt2Z5AQp7dBg1BRSFk5EpmMDNxPEIY=;
 b=VMPQm8KIjL9jVVil/5zy8fNSgAnuarQkBM0FuKL2DuPlrz1Byx/S7JwRcNSpkcn/ZiseFr9vYkOJD4SucRuZ3FH6hL8sW+R13o0nrxE8eRqE7DhwpMpbLplTXGnUi4J9S7pBhShlvPtVl195SI3Cp/xzxlkXphbwYyUgXvrILtjOpN5EA4gX1C0Hc5ENpB0/erImUOWH9Y1l4tIc+ooq8I9loybmv5EZeXLdMyDPSMPLpcQm/vtgvfVhd+wqaj7v5JA/QFrWyrQDDttEs0KIKcehPnEbDspgUmv5gIMgrcAa5CjHKAGYzlxwNa1flDBX/9ij9SDQivzyEJjZHQIWqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/SrZ/F2Ug/ECFt2Z5AQp7dBg1BRSFk5EpmMDNxPEIY=;
 b=PmU/sFH2S2mNYFiTyYntelwDmC9J8fFEIyX8f03oSoLnY+R4CaOxeBZpj2YOjJDli+ZngY4Vl0577f0ot7klOYraZK3I6CFdU6hL/0nVzfQpxjDddP8vE6hLK7zIgLf6+5A7eN9yze4OdMXTOPWLob2s5qAF9tVM75w4FyUuwjAa1c9E4/vNw3219/00KdSYcZKmcpnW87QYvOxq6C6/Hcli3ro6nFpeKzhHdtSHiPczDdWVkCI/nfzDShHdNUQUQBDoClGB2xwvAL2LOYIq8EjzgkEu4oNa+Rdv5TotjOb8kO3Gv0b5x/3aBr47WfeuzU+pEUcx5H3EUrN7BZfKFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6146.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:99::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Sun, 10 May
 2026 20:42:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9891.021; Sun, 10 May 2026
 20:42:31 +0000
Message-ID: <2d00dd26-9190-4e25-bda2-b2ac9bcd5180@siemens.com>
Date: Sun, 10 May 2026 22:42:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwrng: tpm: Do not enable by default
To: Jarkko Sakkinen <jarkko@kernel.org>,
 "Niedermayr, BENEDIKT" <benedikt.niedermayr@siemens.com>
Cc: Peter Huewe <peterhuewe@gmx.de>,
 "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "Bauer, Sven" <svenbauer@siemens.com>,
 "Zeschg, Thomas" <thomas.zeschg@siemens.com>,
 "Gylstorff, Quirin" <quirin.gylstorff@siemens.com>
References: <bbc41534-a2d9-42dc-ac8a-ff8a0b4fd41f@siemens.com>
 <aP_NN3HwO4Hp0-9T@kernel.org>
 <96df7b4d-cf1b-471d-9b4b-8741a80fbcc3@siemens.com>
 <af9QQah4QN5VD-4P@kernel.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <af9QQah4QN5VD-4P@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: 79426654-cfdd-4ddc-54ee-08deaed4a803
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|55112099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	l2r3xX9T8IWs+nq3LDhFvyp1ln/WVdz2JT4Z0DHU6/pBPkF/ZcXHaaoxaBl1BQXoeQWN0UY6tlsSaE6L5mu+bL9C9yWfPIeIfaCjojPSrwoAX4KJXQCuUvGRa2nWkpgGxtXy5DA6MOc04ZZqkGtJ+gy3HvohCs/S4Da9vKu1dTjYav02PAbH91Wfciaj67ccdAIP8gt0moX3Nex5Jjv6hcHtF6hQfS7AZZ42w7/00TByv6BCLamr7u9pWPoDIEZtr2FE01YlrymUreadqLeRqEU/oLHPFKYGT7/fD5pCdsSEeFDx1j1P4gq67t+pqlZuDomgtz5Pi93W09xrAjW0w6DGp8dfm3X8gAeLqN+sRyYQAlwFNe2WBon49KdRWZ661lF0sgvfPTCxdTaWiyu9JcaN+7IUBhL3vxOWSc0EexiQHYYu2AdSog7UJI5hTr3Tf41aisXIvOnHZfNe3CFlv4GxtEERQAUaDNskjoXx5y/8xQNVdei2mkhSVtfEysoM21kgu87pjnTDnaLvwPqkSyoUu0SDs4L65OygLJMQs2Aa2wtJ91+Ae4kLUOUykJkW3hPfZ/DlU9l75qFiU/nQrt95Gr3mA7MQ+LvGaRnP8qVO8jhHjjeV//7ETf2vLgPkn81yjXY6FvWgeWuUxEBHKw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(55112099003)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEVSbVRla3FobEJkM0NyZkpRQkZmQ05lYkFSZlQ5dUJkb1RQaTBwYzZtQjJv?=
 =?utf-8?B?VVdhRjBXQXlSRU1pci9kNGNoaEp6cEk4Nlo3d2VOZzZQQ1hROTU0N1B1QXpx?=
 =?utf-8?B?VFRYYXZtUUtIUEY0NHEycVlISHAxeWZoUUdNdGR0SUt3VWVBYWtZdzZramQ0?=
 =?utf-8?B?b2llRGRCUWtUWjRUU2tSUlRmd21rOUtOMUpBYWxqSGtFbFZveXV5UFBCSyti?=
 =?utf-8?B?UlFyNmUwY3JDRkRkY3F5Vll6eFI0VHRVdk1IbVdFUVpPOHhmRFNxUXFoU0Q4?=
 =?utf-8?B?ZjBwQXBxVE5kRHZzVUNNM0tuL2t4ZCsrRTRoT3c3MUxkNVB1UGt4YksweFE4?=
 =?utf-8?B?TURjeEJMV3licW1zd2h4NTY2S1dKdW1UdS9oRzl4L0Y5c2x3QzVJUXFBNU90?=
 =?utf-8?B?SGNJVFdtSmtaQ1NoM0VVcnZhVTh2STZyTjVBRWhpVXR5d1FLRmgyN0tqeTB0?=
 =?utf-8?B?cmRKWlVLZTEvUjRsSlBBTXl4cEh5N1BBbmFzTDJtaDc2eTlyS1htSjU4QWdn?=
 =?utf-8?B?QWpDNjlvUkVwd3Q5bnhkcHhuUndoZURYbXlUcXRtTHh4RlVJNnFmTlpzN2Jx?=
 =?utf-8?B?NDhsNUFXRDBQcy81a3ZHUW5LMGNWV1NGRm5SUkE0Q3NLc0U0cHNsWHc5c095?=
 =?utf-8?B?aGp2QUFIWGFFS2JERzlzWmhQdHY0b2oxTWhFQ05RWDIwekh5cFJUVTdBQ290?=
 =?utf-8?B?UFVwaXF3elljMm95UDBSbTFsaWNPdHpNNE5vcnU3c0psaXBSQnp1VzBzT25i?=
 =?utf-8?B?Tkp6NEtacjFDZjh0dWhGK3VjRWpURlRwRlFhRnBoVkxiNWkxSW5YWk9oeXhF?=
 =?utf-8?B?N2tpZXNTclFFdkJMcWpxYUhhOTlZMFZmdDF4UVhEUzVWWGV0aDRzR3RmTTdU?=
 =?utf-8?B?MjAwRXh3RlRzRmFQN0VEVElBTnlTdldCb0IrYURab09EUEhYK2FBQitiTXdZ?=
 =?utf-8?B?TkMxNHJFclVWaDR6Y1RZQVE4cHoyV0Q4Q1RyMzk1L2pac0Z2NTZ0bEFSRzdr?=
 =?utf-8?B?TUFsaGx0aXNwU3UwTnhPYnFFMndRWEdreklQbDZrRGZTTWlzcjZ3SUxtTEww?=
 =?utf-8?B?dXo1NTJDZXR3WGx3SVVpdTFER2xhajVmWWo3SEl2NCtuVGtLSHlGYTQzVXBr?=
 =?utf-8?B?R3JYMStvc2VZVFBHMGYvZDF6VEVvc2RTcVFEaXFnaW5Ebmo2TVN3d0ZuT3ZM?=
 =?utf-8?B?VU1WQ2cwUXVKVXpZWUxGVmU4ZkwxOFQ5Y2JVOEE5OU43eXVGa2dPMmFERzBE?=
 =?utf-8?B?VGZtZ2UxdVByUllBZzFLM0J0QTBUTHZLd0MzT0RUSlVTdkRyU3pCbFlCeTdw?=
 =?utf-8?B?ZFpzSHRUUnd0bllGTDZzcDlzd1AzZzJDOVNFTjlCM0lWcW1wNnZaN1lhVlc2?=
 =?utf-8?B?MTR3L3kyMjR6bWpSVVFwWi9lTk1PUnJkZE45S0tZUDBpNDJaTUI5MVBTc0hW?=
 =?utf-8?B?VHIrZENib0tuUDkzM3haQTd1VFZVUUJsdzlaUTEvRjV4Yk5qWDRjQ0ZDM3JF?=
 =?utf-8?B?bGZZcjVnUHZWVEdHQmRJckRURXU0VGszTjQ1WVJ5OVhGQVBFOGEwUkVUSEFT?=
 =?utf-8?B?aFE1QWlXaFVvdXV6ZVlJQlkvMDUrMVRGNWlCeUVOSFlpZXlOWHdCZ3pHS1l1?=
 =?utf-8?B?Y2tVeDlvOVhTa25YM1lkQjNYZDNQTy8zSkVTdWVZUERlTnJPZUVSL1pES09B?=
 =?utf-8?B?VkFGTnNzSndub2dPdm5OMngxWi9GaFZkWityWjYyMFJMRXpYcjFtZm1uREJ3?=
 =?utf-8?B?YkxOVGs5ZjVkaFVxNURhdW5sNFM5RVRQRFhOa2d6bEYrUDgyVW12bkt4S3I4?=
 =?utf-8?B?bkE2YVppQUJoS0taL3NFeXUrU2tJK0ZpQmpqeFpNZXFHUkZVdzQ2UmpKWmUw?=
 =?utf-8?B?NnJ0NWR4cysrQ2NKYXBQUm15MEozRXk1dW04UHJIb2RwdVBFWWRGN20rSjAr?=
 =?utf-8?B?SzFpZC9nYjFTTFd1RTlJMWVqTkJWTzNHMGQyWWpSWDBOL0M1ZlJWR1JyaTd4?=
 =?utf-8?B?alZldEwwTktsa1VXYXZ5cTc0d0JYeXFFQjNZb0x6THZhYllmZEN3TkhRR2dO?=
 =?utf-8?B?V042d3hoamtvQklNSFNsc3hlU0kyUXZoYW84d1AxaVBSdlI5OEZRZXJJNGFN?=
 =?utf-8?B?NDhoUXRYcGRreWI1a0hKR0Z2Z2lzOW5wYXdCakp0L25qcTBpNlBmbDNrY3Vu?=
 =?utf-8?B?N3JRREFEY2kyUmZ3bmNMMDBDUTVUVDl0dGQ4UHJKWWNNdUlpdnRQL3I0WG5j?=
 =?utf-8?B?WWs2YTlxK0tkNUlMaGJiaGF3ZUY1Q3I3eDRWUldCdnlEbkg4bVQzV05xUVpK?=
 =?utf-8?B?UC9ZSWhGL0Jad2dnbWdnb2ZRZ0hxcnRybzQxOEU4WFdqc2kycEpJdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79426654-cfdd-4ddc-54ee-08deaed4a803
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 20:42:30.9993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qw6WJUSVukcMJOIqae0djdBKQtdMW80jQgFwaG5bhneSRBPgcJ7H5661ghNa+LaqNNLjoLdDGYJmfbj0AH+Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6146
X-Rspamd-Queue-Id: 29F015064C1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,vger.kernel.org,linaro.org,lists.trustedfirmware.org,siemens.com];
	TAGGED_FROM(0.00)[bounces-9517-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[siemens.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jan.kiszka@siemens.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	HAS_WP_URI(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,siemens.com:email,siemens.com:mid,siemens.com:dkim,trustedcomputinggroup.org:url]
X-Rspamd-Action: no action

On 09.05.26 17:18, Jarkko Sakkinen wrote:
> On Wed, Apr 29, 2026 at 02:33:20PM +0000, Niedermayr, BENEDIKT wrote:
>> On 10/27/25 20:51, Jarkko Sakkinen wrote:
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
>>>
>>> Also AFAIK, it is pre-seeded per power cycle. There's nothing that even
>>> distantly relates on using NVRAM.
>>>
>>> [1] https://trustedcomputinggroup.org/wp-content/uploads/TPM-2.0-1.83-Part-4-Supporting-Routines-Code.pdf
>>
>> Hi all,
>>
>> we recently also stumbled over this issue which led me here to this 
>> thread and maybe adding our observations helps to clarify things here a 
>> bit (hopefully) or at least augments the information related to firmware 
>> TPM based implementation based on ms-tpm-20-ref.
>>
>> Based on the optee_ftpm repo, as Jan already described, which currently 
>> references commit 98b60a44aba7 of [1] suffers this exact issue because 
>> of the NV_CLOCK_UPDATE_INTERVAL [2] which is set to "12" and issues a 
>> write for each command after ~4 seconds have passed.
>>
>> This config has been changed to "22" (on current master branch [3]) 
>> which is the allowed maximum when following the TPM spec (chapter 36.3.2 
>> in [4]) which leads to round about 70 minutes, but optee_ftpm didn't 
>> move ahead to this commit, yet.
>> This config exists for being able to adapt the write cycles to the 
>> specific wear conditions of the hardware.
>>
>> Moreover the ms-tpm-20-ref repo seems to not be maintained anymore and 
>> one should rather switch to [6].
>>
>> So there are currently firmware TPM implementations out there that lead 
>> to these frequent writes.
> 
> Really this would need a product and official bug bulletin for it to
> even consider a workaround. Speculation does not count.
> 

The key point Benedikt tries to make here is that the TPM 2 spec forces
any vendor to do something about persisting the last seen time at least
every 70 min. If they didn't do that, then they would violate the space
- arguably a bug. But, correct, it does not tell us anything about how
this happens in a random firmware TPM implementation.

>>
>> AFAIK since the tpm-20-ref implementation basically only supports a file 
>> on disk or RAM backing storage, the optee_ftpm repo [5] provides it's 
>> own _plat_NV* implementations that replace the default ones and finally 
>> call OP-TEE's TEE_* secure storage API, which then routes to whatever 
>> backend OP-TEE is configured with (REE-FS or RPMB) – In our case the RPMB.
>>
>> Because there are currently implementations out there (e.g. start using 
>> optee_ftpm) it may make sense to add this information to the kernel 
>> config's help text at least?
> 
> Your first forum to report such issues is the TPM vendor.

I would still not recommend anyone relying on a firmware TPM to turn on
CONFIG_HW_RANDOM_TPM if there are viable alternatives. In case of the
open source stack with optee_os + optee_ftpm, we know that at least one
exists: CONFIG_HW_RANDOM_OPTEE.

So, if there is no good place to document this in the kernel, maybe it
is worth to document it in optee_ftpm instead.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

