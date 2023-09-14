Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C607A093C
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Sep 2023 17:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbjINP3Z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Sep 2023 11:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240878AbjINP3Y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Sep 2023 11:29:24 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2071.outbound.protection.outlook.com [40.107.21.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404BBC6
        for <linux-integrity@vger.kernel.org>; Thu, 14 Sep 2023 08:29:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UArLS4Q6HOjH1h/lPZo7lLjCNDPJHgKy2SuwbCY8H68kPJk8YhPgNdL7i1DNLADKYVlUVI9hzJamUS4xxAGyK5Ornlf0Zp3Xmp0NQ2dVSamuPapIN9PzpMOz4cQwF2ifeC+i4hB636PL4jx5oG88euiHLRl6Ytr+J53qulvjncD66aPFNwi5YjaENTCQ6vcxqDRZ1/2hhc4hpPjPJfq/0hUpLg6QNXb1q+iiCDzONGZR4arevDR9qVv+lpJQfujxLj2y9xn+gWL9GNssR90EY8yips5haG/podbUYtMVRnz6Pjw8KK5JH5sVIWBCslIOcEkEN7cRvp3ekLS+Bq/ERA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ic6Y08V/1KorqPv4iYV6x6x8rx2ijRj5Wd9bOsAuZ2w=;
 b=WVLDa1eNJEAOwD6jVXdJsBuSul62FMKGMvqwzYGOllJl85Qy4TcFPT0dcU6VfQ6S3Si7FKYpZitZvTUYGEAJfNiqXPKMTafxymK0WpBJhkuwtgkRMkOHjNWq20UZP2zX75DeO/FIUj2zrBe4cVpQmnkZGOcCmq+y8M2Kk2OETGYJF+DBpA8vv8fpunsteVMBFvUwfn30PvqHXCGuORfRR5nbSqU+Obae5MojFOpWkPK69U21csf3OwbdMXItwgGYXq5fvOmW4p4SWU/JFF3f/Vp64H62Golm+buywO7j3N37FctpeQrIyxZahXJGMtyOQH8pxXKbE7y2h/CYuuGqqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ic6Y08V/1KorqPv4iYV6x6x8rx2ijRj5Wd9bOsAuZ2w=;
 b=fv5ntIUBYff5DgW8GSJx4TMZWQxgX13LGnU1kPaKbs99c6xx11rUH2xWM0g/Qx/7B01FRjF5Y6w3/gusT/lvgEmB2gUCMqcX1gVNxfPEB25UiwpHXgUkfNThcv824QFbEgDTK3G0XaaCfhjHek13wm+w4ze3JbfdzAK3DABMae0zkwJsHKVRQL29KfbkUWFTwzDS14/QrZ0gLn83rg1GLooIkk9EG5xnGHg9hhw+v4NQkhT1D7qgcEsh+0QMAJqEmixbdh971bTbW0reQkLhtkHCD5jSp1bu4Z4Gr0xjP3FyHrkJsyb1LfOaXIebEm/ibaoebjZRQpPAEg8uRMJ6Eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DU2PR04MB8790.eurprd04.prod.outlook.com (2603:10a6:10:2e1::23)
 by AM9PR04MB8323.eurprd04.prod.outlook.com (2603:10a6:20b:3e5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 15:29:16 +0000
Received: from DU2PR04MB8790.eurprd04.prod.outlook.com
 ([fe80::f749:b27f:2187:6654]) by DU2PR04MB8790.eurprd04.prod.outlook.com
 ([fe80::f749:b27f:2187:6654%6]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 15:29:16 +0000
Message-ID: <9a1e2ac0-54a8-b88b-3953-22624da5d4b2@suse.com>
Date:   Thu, 14 Sep 2023 17:29:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] tpm_tis: don't flush never initialized work
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org
References: <908e5878-61f9-7a75-129f-ac236fbc8b0a@suse.com>
 <CVIQPE7W60RN.2QQ8DLCMFV4CW@suppilovahvero>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <CVIQPE7W60RN.2QQ8DLCMFV4CW@suppilovahvero>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::20) To DU2PR04MB8790.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8790:EE_|AM9PR04MB8323:EE_
X-MS-Office365-Filtering-Correlation-Id: cb5e578f-3cf8-4e8e-4d5b-08dbb5375b5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S98LqRmqxRN21tOWPyvuJNK0mQkCgDz/yxFylVqlIE2mUxtsjgqtB4hZGTWWS3jWUjezFr+0GRioQre/7r55MGFoRhQQXx59j3sX356KWYe37idnyo4heUxtwo/Cipyo+PTVVp92ig5JgIP83i3vVUPvcadHzL/r+wkBn7QtNCQdnVBzfDGJ7P+GG216J5zQewSTGNQN2R6hox7jd68K6INCglnGTk93HUHib7j1kf68WQvFLU4UTwzoPeUu+hoS747JMn/4oZDV/d+SbOXQr2euD/3SRxCj/CrpRev1ppTgoaKyGO3ydLhHd2hqoySUavS/z/sK4Ue53+9MOtj6um/q5A9l6m6M4vScFze+mWRw5VFfwCXdTRJxcvhCHxkAxWBwfX/9tXovcBswKDktlhX9fM8nm30OHO3y329HECeRHkzSplrqw6KBilDLZrttTOc+pt5gvNU0GlnmwN6anhitNquV3GnruuW/Kz15LF2saRunnD3Jp8rpxDwvwMB6BPglt0YQzkqo9UXFiqbth2UB9S6WTF8L2pnSHmFkGZLnVJOTyQqZdJhrd1PekUvL0T+PJn1aljVmWRrB69EDgwYjXv0eKTyyHWni1dWZwppoYmcq9tC6rt0id0nlh3n0xZ6iHgLo+4/2I/cLCgYZdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(376002)(136003)(39860400002)(186009)(1800799009)(451199024)(8936002)(31696002)(86362001)(8676002)(4326008)(2906002)(5660300002)(6666004)(36756003)(53546011)(6506007)(6486002)(6512007)(2616005)(26005)(38100700002)(966005)(478600001)(83380400001)(31686004)(41300700001)(6916009)(66556008)(66946007)(316002)(54906003)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnpJT1JHdFdyRXpZTGRQUDVMc21OdFA2czdtNTZqZ1JiOWlQa0I2U0d1alpQ?=
 =?utf-8?B?d1NpZ0x1VXFSOTB1VXF2MFpDN1hBVHhOcStHRVl6ZmlWS25kQUtld3dacDJ2?=
 =?utf-8?B?eDc5dWFweFU1N285K1pFY0M3OWp0SUxJSFYvalp1THlhN1FUVXZqV3UwYkVO?=
 =?utf-8?B?ZXFoWVVEZFFpblRrbENXenBzaDVhSEtWbkVFVVZtRXd4TnFRcVFySDAyR05L?=
 =?utf-8?B?aVdpQ0xBdzk5cEV0OFEwMFpxRzlTUDduWm92eStSS1l1OGlIV012SHBJOFJZ?=
 =?utf-8?B?ODFYTm1URVk2b2ROajNHM2ZnL3N1YUU4Tk11SEdtMUtEN0lEb0xMbVVEcHUx?=
 =?utf-8?B?ZGZRbUN1VnBJNjA0ZWlzcmN0MWxlQzF4ekM0VzhLSVgxcnZCRExOczV2WGU0?=
 =?utf-8?B?VzJpU2ZoUkJ1NFZzOVdVbzcweUZkQURUL1kzVjBIUzVFU1VtUG9Qa3ZaQlVE?=
 =?utf-8?B?OTlIQ0QxUHdaSmtSTmdSSGhVWUdoSmlQRlk3TzhsSG54bGtUSW4wOElSdWNN?=
 =?utf-8?B?VzZWUDdxdHFFQlBhM3ZUOG5iSmdRdjk1aDFkZ2tHYWJWRUErblA1SExScXVV?=
 =?utf-8?B?cEg3V014aHRySDgyejZmQ1hwbVlEMkhnNzFHK0RRRVBVVFFKc0hmZlU2Mlp1?=
 =?utf-8?B?azRudGpvYVR1b0ZmOTE0b3NPeWtzSUk2WjJkSlczd2pzREtrajVhWC80NjRO?=
 =?utf-8?B?NCtNdC9kSUxzdk1wQUlzZjlYTTVUUFg4OXh5dlZLT1hjVTBQSXNBenhJaGxB?=
 =?utf-8?B?cERpZkQvT3VmZ0kwcEFQTDhFY1FpLzYranRPaFNwU2JBWXpkbFVlbWNnaVAx?=
 =?utf-8?B?OXNyZ0ZvdUNuMUpiQ0loYWkrRVNLVWlSL1JoM2ZXcHJnU1ozSlhzUCttN0I4?=
 =?utf-8?B?R2FheElHUlZmM0ZmWG1Eb2xoU0FoYjAweEc5eUkzd3ZjRi9IMm9JUTN4TXhK?=
 =?utf-8?B?ekt2Q0E4Y3NkTGVwUjZ1YjdpRE9EbG94VU1CM3k0a2dkOGk3YjhCR1BjckZ4?=
 =?utf-8?B?NXZ1NEJZbXJVSCtGUElsZm11RjRpcE1FcUxiZ29aTDR3VU1xb005a0RJb1lm?=
 =?utf-8?B?WnBFekhZa3dmNEgzMnJMVEJRb0YzN1FuZnEveURHWnhGRlRES0EzM0krZWti?=
 =?utf-8?B?eHFIbCsvaHdEb1B4TUdEVTQycjN2ZmNRZWJnZUJDSXRNMU40SlByVENGT3NJ?=
 =?utf-8?B?eGdMU2lxclJQRVVLajVUMHR1dGp3QzZ2a3I1RHcrcDZGR3RwUGprRHpqMXB2?=
 =?utf-8?B?WXFqV1E0TU9kUDNwVVQvazJSVmFSLzI3bFlEbnRsQjhBV1BibUN2NnlQZzJ4?=
 =?utf-8?B?Zk5LNWk5NDdWd3ByM1RUbHdaN3BkU3JGd3I4c2FaVzAxelRZNFRJNWFpWTA3?=
 =?utf-8?B?dTJwWGVxbVErSXRvSWc0WHVKV2xRQTkwc21lWXp6eU9OU1daUm5mMXN4ZDJU?=
 =?utf-8?B?VGlZSjN0NTM4U0R0b2dsL1VBRVNWYkRUU3EremZjSHBPZzk5akhNNlRtak9y?=
 =?utf-8?B?U2t0VDY4alpSbis0Z0VEdHM2M1dpcGl3NDZGRHlpeE5vT2RHSWhaY2I4N252?=
 =?utf-8?B?MU9nL3hTa1dTOWJWMzJQWlR0aWxZSVJ1NXVpaXE5cnduZ2FCM2JkNHpTV25Q?=
 =?utf-8?B?bkpvbGRFSUJlaWgydnhFd2Y1R1dSNkkvWXUwVW5KY0kvaEVxK2EzZGl4MjAr?=
 =?utf-8?B?eFNLL20wcUdXNEZwWEdiTklMaURlZTZOSVdQaUNEMnVRVGhJTmdzWXM3SGxU?=
 =?utf-8?B?cjF3Q0xJbjBydEQ1akVuSUxlV0FKVlhkRkdUMnZaUGdjNDVIa2syTGdGSWZV?=
 =?utf-8?B?OEpKc0FqTzZXMzNzRVJPdlUrZ0pRK3NTWU9aOVByWDRtNmxyRDJ2V09rNDR5?=
 =?utf-8?B?MjYzTytZWXU4bFNNWitlbTcwNFJpR29qR3FpY2haL3l1RlB0ZWIwNDlxWjE2?=
 =?utf-8?B?OVpzOXVKMHdFTURSYkgvUkczK2dVZXdGU0hnSTY0cFFrRWtUSUxYU2plL0xC?=
 =?utf-8?B?dGxMck5oWWdvc3ZsQ2d3TXRzRFpqK0hlMjVJNUcwMCtRVS9Wd29LelpIUmhL?=
 =?utf-8?B?V3ROQWR1bVFZNEU2MUxLbjRLVEpJc09TSFYzNkRqSXpzOGdnOWt3ZUt2M3BU?=
 =?utf-8?Q?8ilHSMH66PdgLmVv3SRCirgDm?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5e578f-3cf8-4e8e-4d5b-08dbb5375b5f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 15:29:16.4916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aphr4zJVicxQsmiNbGGY//hNXVW3NUw8NZuHQTw7a7LlfS6dXimuZrg8XZomj0b46lAzPPKemXs6spVAF/PGgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8323
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 14.09.2023 17:19, Jarkko Sakkinen wrote:
> On Thu Sep 14, 2023 at 5:28 PM EEST, Jan Beulich wrote:
>> tpm_tis_core_init() may fail before tpm_tis_probe_irq_single() is
>> called, in which case tpm_tis_remove() unconditionally calling
>> flush_work() is triggering a warning for .func still being NULL.
>>
>> Fixes: 481c2d14627d ("tpm,tpm_tis: Disable interrupts after 1000 unhandled IRQs")
>> Signed-off-by: Jan Beulich <jbeulich@suse.com>
>> ---
>> An alternative would be to move INIT_WORK(), but where to put it is far
>> more difficult to tell for an outsider than simply making the flush call
>> conditional.
>>
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -1022,7 +1022,8 @@ void tpm_tis_remove(struct tpm_chip *chi
>>  		interrupt = 0;
>>  
>>  	tpm_tis_write32(priv, reg, ~TPM_GLOBAL_INT_ENABLE & interrupt);
>> -	flush_work(&priv->free_irq_work);
>> +	if (priv->free_irq_work.func)
>> +		flush_work(&priv->free_irq_work);
>>  
>>  	tpm_tis_clkrun_enable(chip, false);
>>  
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> Jan, I'm about to leave to vacation but will be back after next week.
> 
> Do you think that the fix can hold up unti that?

There's no rush from my pov, as I have helped myself. Nevertheless ...

> The feature is opt-in as I documented to kernel-parameters.txt:
> 
> 	tpm_tis.interrupts= [HW,TPM]
> 			Enable interrupts for the MMIO based physical layer
> 			for the FIFO interface. By default it is set to false
> 			(0). For more information about TPM hardware interfaces
> 			defined by Trusted Computing Group (TCG) see
> 			https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-profile-ptp-specification/

... I'm not doing anything non-default. The issue here is that part of
interrupt cleanup occurs without interrupt setup having happened. So
I'm inclined to think that the warning is independent of (and perhaps
more likely to observe without) use of that optional functionality.

Jan
