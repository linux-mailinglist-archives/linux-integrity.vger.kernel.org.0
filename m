Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C7530DC9F
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Feb 2021 15:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbhBCOYH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 3 Feb 2021 09:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbhBCOXM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Feb 2021 09:23:12 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on0627.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::627])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2F3C0613D6;
        Wed,  3 Feb 2021 06:22:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWjmQmgKJT6qwNnv2FbqNxkYFQhzfv1Iq47hjoe5N2wvDnnwGIpPv1fM6ffI58W1zW80SF6BWSET3E/G3RQJs+nMhhlK8XbeZNQ//gbxGjGnZTvSF1MLgupbGNGHDW+0rEa8XdG2IogBq2onzqZ8TOJ/l3jnB+DY1ntTJgUBvv79zvLh9ndPgDlvuV+d47WljA2UUStA6MuvV+O5UVdPG8Cp9gpXMIOpcuTOh60F2NJKPhVb5uB1qG6eyTeJUqbjh7KyzxXyt0mN+OcdwLnaAVA/5ErpvY6TV9EisleAcJ9y3KwAJo4YA+luu3SnYjj2Z5cVJpzAP20Q1DWiPyL5cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rD7svGZLUongtAf1Fbz8h5J0c0AlxExkS+RvqRT3v4=;
 b=nPqJGl9CPcqSgXbD9JseA8htfUD+5K9ajTrPlrh+1j17KIs4shnG+pbnWOfq7s+xriKPDqsooSppvYPcshAUOdHjDmj0jOFH6csejuc9bq4yz5uBe7WCd7DtwmtPdATxCEV+31X4fZ6rZUDLQKfKuJrFrVl3i93kD2Q7l/WsPFWV6MjqT/Dqnk9EiY4XnBH2+hWYIm4yTZc1gntZKgZ9+N/CBhDnmzg2a8kBCJW2/3AxLUYTNX6AbtN3ngpfizLPmUk5uVTOc/cRcuIwt0DIGg6yRkkofSrbA+TaG2S8irENNBjLRkOunmBg+UmaNPyGmGtL0GMnEDyMezt4N6/xNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rD7svGZLUongtAf1Fbz8h5J0c0AlxExkS+RvqRT3v4=;
 b=XkIRh1MmR/ey5lHNUcvnzQnxGgsyd3EY9neib69QgOOI/1PxH8ChADRBbqmeOktTapDjxUo7cSbMR2dXewvvOPJJ3GryCQnpJzT2dgbNv7iZqryWWcYzPcDxGRFfR6PDKaXhwx8QAb6GzBdANeKKnjtBvNvgU2jY8/nMcGmMBLM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=kunbus.com;
Received: from PR3P193MB0894.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:a0::11)
 by PR3P193MB0880.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Wed, 3 Feb
 2021 14:22:08 +0000
Received: from PR3P193MB0894.EURP193.PROD.OUTLOOK.COM
 ([fe80::2839:56c8:759b:73]) by PR3P193MB0894.EURP193.PROD.OUTLOOK.COM
 ([fe80::2839:56c8:759b:73%5]) with mapi id 15.20.3784.022; Wed, 3 Feb 2021
 14:22:08 +0000
Subject: Re: [PATCH v2 3/3] tpm: in tpm2_del_space check if ops pointer is
 still valid
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1612303743-29017-1-git-send-email-LinoSanfilippo@gmx.de>
 <1612303743-29017-4-git-send-email-LinoSanfilippo@gmx.de>
 <YBn5kwEIoggc71xY@kernel.org>
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
Message-ID: <995b242a-d8ec-9310-d272-960b3f025115@kunbus.com>
Date:   Wed, 3 Feb 2021 15:22:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YBn5kwEIoggc71xY@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [87.130.101.138]
X-ClientProxiedBy: AM4PR0302CA0012.eurprd03.prod.outlook.com
 (2603:10a6:205:2::25) To PR3P193MB0894.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:a0::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.23.16.111] (87.130.101.138) by AM4PR0302CA0012.eurprd03.prod.outlook.com (2603:10a6:205:2::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Wed, 3 Feb 2021 14:22:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 552ecf20-e25a-4a44-0112-08d8c84f16e2
X-MS-TrafficTypeDiagnostic: PR3P193MB0880:
X-Microsoft-Antispam-PRVS: <PR3P193MB0880D13C4BAC88C3312F0668FAB49@PR3P193MB0880.EURP193.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f6EtSXlSypORnXO7ZPHZ+NA1jvcBfeTxC8XEJPdTX5touFBPcoWWqpmzbUe+ZX1PtuZdfcfawdG6x9lFkuxaujiKmeGoQaxeBJqpBzjkSHmx8eQAtvGQc8Q0FPENXMzpi+YM642gLMxcd/XqB59R7DZvz9x41hrRH1Q/ZBzZcEtnl7kZ2XNVB87HuDSuOAqoemRldP54YBpQyoOyT5PeCbCvBra6BMIlroXN1G91mCOaSqHUfjW0hGSA8JMy28mIP3vfx2LkuZ2ixVNTcORWPdWONqjk7FCMbXVetMfNL0sr7Dt9pmYFOSNQrC8YIsa0WQHqbaM6AwG/RKHXCbM3r5g+f5rzi9D52l+5kGv0Aif0ggS3JB2vq5E/p49d5Kl3B6UfBk/N/f0Ncqi22d95opyqkEU8iKtCfh7cNT168fy9drAJVzK56GLPtu6Iuq1TQCDvh1lD1br//ckSqaXTuuOqFSnq90DhosMRYDJ1XNlsHw3IKHubyz0TrbYtYcutZCV8WiwTOPVsfQVJgD0EY6MuAc8t+414JCrV8vCtl1zUkWyRkqfSKeqs/6cQ0qIPK+Hd30AEgcEuGlW2c8WBw7j/2rfX4MdfVzWm6/hjhcs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P193MB0894.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39830400003)(396003)(136003)(366004)(86362001)(53546011)(2906002)(8676002)(478600001)(31696002)(52116002)(16576012)(5660300002)(110136005)(66556008)(2616005)(36756003)(956004)(4326008)(8936002)(26005)(66476007)(186003)(16526019)(66946007)(83380400001)(6486002)(316002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZmJic2pTM05pVWJBZDFaRzQreFZLbUo4dm9rKy90eG42V3F6d0VxQ01EYjVQ?=
 =?utf-8?B?TW9nNUxXRVZEYVdxbmd6dDVUN2IxQnYwcHJGN0FTMVl2eXlyaUk0dnV0STlX?=
 =?utf-8?B?MmRnUnpGWnIxdE94eWc5WVVSSm9ic3loVENtWGxrY3QvUnV4Rk9oZ2dKUnRY?=
 =?utf-8?B?L3k4MXFKMnJJVXdNMVNRWGI1ZFpNekpJbGw3TTRPYWoyMXZYY1pUcVRBMlk4?=
 =?utf-8?B?b0xrY2lwMDMzOVZENXlGTHdncjc2WDlDTXpPc1hTbnJXdG5zRnF0dVF0NWdB?=
 =?utf-8?B?YlZFYWNaem0zMG94UkhNNHNBWGRZMitOR1dVQ1Y1MHJjSDZOek14cWZNRDZD?=
 =?utf-8?B?dHR5QWs5QzlaMitETjFGSFpZVDloU2poRXhsb25HdzNaKzZ3UVBSaUxhVDky?=
 =?utf-8?B?UkhDUExBOEpJRnBsUjE2Y3BVVEhGYmtOb2NQemNTZ0NOV2drc0lXSHBIdC9y?=
 =?utf-8?B?QUVMdHQvMHpHRHk4YW1hZndXUmV4TVBTNjVha2Jld3crRVhoNzNXRHA0MEhi?=
 =?utf-8?B?eGJmWHhlTUM0L1B2T3MwUGw4NDNSbDJ1SithLzc3Vnk3bXkwbVZsNmRmU1BH?=
 =?utf-8?B?MExxbWlpZGJFMEEva0tLNGNWTUhFS1dFcFFURysyQTYrZHZrSjlVakV2STg0?=
 =?utf-8?B?akhXS01wZ3JTT0xKTDE3RDdsZEdHbWc2OWkzZGI0VWF6S0IvQUxJQ29BWUJs?=
 =?utf-8?B?anYvOTZKMjcwdzRaZEZnSUVsTE8yVENDYzlxSFNpLzdtNkYranh1M0IvOW5x?=
 =?utf-8?B?L2EwNXY0b2xQTkplUzJ5VytlUUl3TjN1YVRXUXk0UGkzN1lWR1dqdm1QZnpH?=
 =?utf-8?B?QWttRVhPNFZ0Q1QvbFZ3NTJuTVd4LzNHZVBKZFo1Y05ZVUFNN2REOVFNMFV0?=
 =?utf-8?B?OFFkYzFEWGVyN1B5NjhJVWNVd3QrYkdRejVjVCt2Zk9hQUR1ZmxURC94TEtq?=
 =?utf-8?B?Zi9ZM2djeUVUSzk1WE1jWWtKYmVNaGdQdTlUNjJnNk9pbDdXWHpqYTdGaUU4?=
 =?utf-8?B?c29TUnhVUUZNeEE2WjYrVnN1R1c5TXYxOG91NTZSRFNCV3dtVzFnSC9IdlF6?=
 =?utf-8?B?MExQWlYzdVZ3VnNLQkd1NEplZHVaeUFucFdmdVBhd1dRR2orUjk4Mld6SEwy?=
 =?utf-8?B?azdJbkxEcUJJRTlnL0x1U05xaVRvZ1VLVXRudFl6aHVzcnhJcDRua3YyTUIz?=
 =?utf-8?B?SWJrQzNudnBUT3E1RDJrUGdmeGZFZkZVR3IzM3AveUlpTmoxc2RVdkFOenpm?=
 =?utf-8?B?TWpZY04zaFNtcW1Rb3RMb0JtMHpQUlFXWURXankxQTZtcmczYjN2NHdvMDFF?=
 =?utf-8?B?OXJhTEZKbmhkV0FCWHJLQjdINDhuQ2RXWUYwVllucEZCUzRicExiZUNBT3pi?=
 =?utf-8?B?RjRRbmhPVmxHYmhLK0tPVzMyWml2MmtudTNnanZuRHZiV1daTHA4TVdJMEU1?=
 =?utf-8?Q?tzjHZy6k?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 552ecf20-e25a-4a44-0112-08d8c84f16e2
X-MS-Exchange-CrossTenant-AuthSource: PR3P193MB0894.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 14:22:08.6220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mkL6ynDZ8ynnGjWg5aJluyi2SWHmH4HbE9CoJpzqJQAPZCJq1U2FPPSEKBm8bThT4mKTISVomF0nKlI32T1SxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P193MB0880
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 03.02.21 02:17, Jarkko Sakkinen wrote:
> On Tue, Feb 02, 2021 at 11:09:03PM +0100, Lino Sanfilippo wrote:
>> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>
>> In tpm2_del_space() the sessions are flushed by means of the tpm_chip
>> operations. However the concerning operations pointer my already be NULL at
>                                                         ~~
>                                                         may
> 
> What is "concerniog operations"? Unfamiliar term. Maybe just consistently
> se chip->ops? Now you have also "tpm_chip operations" and chip->ops, in
> addition to "concerning operations" in one paragraph commit message.

'concerning' referred to 'operations pointer'. But yes, using multiple times
 a different term for the same thing is quite confusing. I will fix this. 

>> this time in case that the chip has been unregistered (see
>> tpm_chip_unregister() which calls tpm_del_char_device() which sets
>> chip->ops to NULL).
>> Before accessing chip->ops check if it is still valid. Skip flushing
>> the sessions in this case.
>>
>> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> Instead of cross referencing please describe the scenario (i.e.
> the sequence of operations) of failure.
> 
> Fixes tag is also missing.
> 

Right, will add it.

Thanks,
Lino
