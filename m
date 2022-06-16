Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A204654E19E
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Jun 2022 15:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376329AbiFPNOR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Jun 2022 09:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbiFPNOL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Jun 2022 09:14:11 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C7132069;
        Thu, 16 Jun 2022 06:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655385230;
        bh=9JzekwRcTTH87yPrLP08+Xsxgb/jf6L+u5cxUoWlAO8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=gRpToD2tXV6pmlHyDurQ5A8QN3he/k9KP64IhB/96PWLH1z99CuMDgn9VoBMCYviR
         nalHoejsKRZlREJp4aw6gNbkobZnP7ShCgJfqDTvyzHGfF2FPr4tMoyF02GlqvLf6+
         pgLwAwEhtzdsLVpaHwWIeUPiyi+8wGSHzvFb69Cc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.33] ([46.223.2.17]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvsEn-1nkhwH1xKB-00stVu; Thu, 16
 Jun 2022 15:13:50 +0200
Subject: Re: [PATCH v5 10/10] tpm, tpm_tis: Enable interrupt test
To:     =?UTF-8?Q?Michael_Niew=c3=b6hner?= <linux@mniewoehner.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James.Bottomley@hansenpartnership.com,
        twawrzynczak <twawrzynczak@chromium.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.sanfilippo@kunbus.com, lukas@wunner.de, p.rosenberger@kunbus.com
References: <20220610110846.8307-1-LinoSanfilippo@gmx.de>
 <20220610110846.8307-11-LinoSanfilippo@gmx.de> <YqokW/cNLrrsZ2ib@iki.fi>
 <c610a318258198f72a53541c551c0c595a205329.camel@mniewoehner.de>
 <1c90aba2-5874-7251-ff19-4b6c5bc19962@gmx.de>
 <8ed1c322b6f3dc36427c6a5704df0caab2dcec11.camel@mniewoehner.de>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <14583fe9-a374-1022-3aac-1f05fa8f6e94@gmx.de>
Date:   Thu, 16 Jun 2022 15:13:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8ed1c322b6f3dc36427c6a5704df0caab2dcec11.camel@mniewoehner.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V6aNRS4pfcmJAUy62E3547AvrfhU/+gvMRP+QY/0PxiJ1yHRKEc
 GGdhxJmFJ1fyMPMEmxiDHEKg9nTE/epumuQNnE+Mdo4jmeHn7Jc3nWzawlhpk0AvvItfk5J
 DJXj/Sf5mDgtCzFxXvT9ZryaK05u/lEngncSQKfsIboK/qqOMeLl20HGtuOnqj3zni0sa+t
 PT3RImWXsTPc/d7xj1Djg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4C7SLbBP5eQ=:fbuonv0A4Gu1Y6rT0+NZqP
 g8v+6GPip3G9NCCPUinlr7npqmG4smMninR1+ZQ16lk7qcpZX6qjsJfEfnPkIx9ZXWZ9kwaeK
 ezKJc1mBmEvkmN1mA6hEb89tZvyT7OYGS4agdhUgJrXMzXur4xOAef9FMj5bo0YX1RBz5fmXC
 SliYysMpRCO9/la3ez55BHvIvETwdaBWWusTtFex+kgJ/Azc+R0hgbZR9+0YzMQ6mQJ7ylesI
 zJcHHErz/73EewrQFEJ6h+EG2Kb58rHt7790Gbeasw8WzNwoFi709EOz/9TmNqTR3bpwLjogA
 6gZNk0jUQckb7faQSdpuqLs8TvfdL/XzCqQSozj7BypSn3tAgnlJDwtyCLGbrDPZ+4bs6IJ9n
 f7lDk4J8Ep/ypSY7/RXGGaB79ps+tFRqupY2VGDqhrwiwhh5BAiDPuLhUQayQ5nqoMNrWmway
 0JcN99rs8PAlXdjvM7oM7BdXv7QpIOlj0RVYi6rGOpk4PMsGhZrACmiSzdd0qyaeUd9Fcw0XF
 +65gyz8tB+8loiH7VlfWmEgHeX2FQYFeOwVlF+UDSQ6fYpDJVqu5nnD6X2tWTChbWCdi98BpX
 4mkxw0ogwdHmBPvh/jl8z5XCHaa2LarawDOxfJkq3Uqlku4WBiDYa4tcHw2htUxkn3LJyiKDj
 Ddu+DRj4/vpnC1uc6ayzXkFMVdmqXyDRd7Ape7iQ19AjdD75zns8z1HziyEw19CM4N2S4IdpH
 Lg/VtP45kNuz3hqmZpS6fdcr+2352MSqWfoq2W0kRy3kLCEsGJAViQ6DZkkP7zsq/M/NSu03i
 c+j2e5X3upH6R9J7PbgChs8EgzPKWH7p+em7lROZZKYowFu8iq37OSjQ2LF5M/TTGps1+CD0r
 gDlgEm7yvY+zWAmmllmIdxzN76P/N9eD1HbrGzObVZ+AlrRKWjz+cZWkW1bgvk/jLUT9GwjpA
 xdJ6pU8mYI4wvbqgo/uQot2QqWGbtI1f9MNfk4oCG8n9fOYxlNRProBZa/jrfs0xSVCmM4Qsm
 279/+0DR3s4ONzkwbLB238Naf/UDJr/9HgyaG4vE1cJWo1Mg7olb/bdFST+3EoZZVIguhnUnH
 CvzyjkFZU7/o9Of6w/s/lwcPLRxkP2SYaAQ3Mp/RtSbO14Zjimx03PQkA==
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Michael,

On 16.06.22 at 15:03, Michael Niew=C3=B6hner wrote:
> Hi Lino,
>
> On Thu, 2022-06-16 at 01:30 +0200, Lino Sanfilippo wrote:
>>
>> Hi Michael,
>>
>> On 15.06.22 at 23:54, Michael Niew=C3=B6hner wrote:
>>
>>>
>>> Hi guys,
>>>
>>> for me this series causes boot problems - somehow feels like an interr=
upt
>>> storm...
>>
>>
>> Thanks for this info. Which hardware do you use?
>>
>>> Not sure yet, which commit is causing that
>>> @Tim could you test on any of your devices, please?
>>>
>>> BR
>>> Michael
>>>
>>
>> Regards,
>> Lino
>
> looks like something was wrong with the devices firmware... I flashed a =
fresh
> image and everything is totally fine now - TPM gets detected without the
> "interrupts not working" error! :-)
>
> Test device: Clevo L140MU, FW v1.07.12, TPM 2.0 Infineon SLB9670 (SPI)
>


Good to hear that everything is fine now, thanks a lot for testing!

Best regards,
Lino

