Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812BF582635
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Jul 2022 14:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbiG0MRN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Jul 2022 08:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiG0MRM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Jul 2022 08:17:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0249048CAE;
        Wed, 27 Jul 2022 05:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658924217;
        bh=9rqtGCgPNwdvoouvIw62KMlkkvKBwy/u6kWoAY6g0O0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=CpAd7/nNjCYpPQ3dRdph51VA/t/6Tp/oNiwPv7zJLOMZ1G/xaSlQpYPGIu7c6szOC
         FwVOx3INeB48gkPeJJBNnl8NsTK29dphgxBQjdFF4P2t9BCwt+vuPZiX7yNbr4HSDj
         mSW30vfDwkbLIbjGPN0iZ9n7taZC7ag/5y0kWoUc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.69] ([46.223.2.199]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mwwdl-1nWyIc2hgJ-00yP70; Wed, 27
 Jul 2022 14:16:57 +0200
Message-ID: <744ad6e1-c4ad-1e6d-f94d-98aa5b105dc6@gmx.de>
Date:   Wed, 27 Jul 2022 14:16:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 07/10] tmp, tmp_tis: Implement usage counter for
 locality
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com
References: <20220629232653.1306735-1-LinoSanfilippo@gmx.de>
 <20220629232653.1306735-8-LinoSanfilippo@gmx.de>
 <Yr4x6KRSvzlXNdH2@kernel.org> <f0e33bc4-335c-322a-9295-18d6bc0b8286@gmx.de>
 <YsuQEoVuVa00gIdE@kernel.org>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <YsuQEoVuVa00gIdE@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jND3pvPI9LaMSApRKzpArZ1WkIA2tYqrkQQzBAWPOqyc6mhROIJ
 V8kG8gI3oILX3iVoqyd/mggYvchX2C2Q+N9BC0HGpnaXSGmIy+dhFD3jQ9L4CZiIy8vGSjW
 5s/H0mfHssN2780MbgCGDIbHA1URkMkoCKQ/89nnFpqOL31zgWAjh+r/9S/MRai97VWKMeo
 UVsn0FH12XRNtaeMR8H7w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0JjASvmbeto=:3aKtAxXgzy/WFm0/zR6UY8
 ohjwB+bhBYtMAOuXKdLAqusnRNvqinYLYNNaxxVMz7iGEwlH/U3SG76YAsGKqWTb1DRQWq1UU
 uVkE/+i1JxaFN680Y4BMuG/KPmEfLQoDgu8HvnKqNqwWHQACPcCanmz+hKVuCslp4hvTqwR3A
 sPNxiHNwewjOYY85bogzsEun5mnuUuNV9zILHExsQOZvYBmffX/C9lwsdii7bKZMA063jVsJo
 /n3O+XEBbszCji+X0faPsU/n0u5sCsG2srhKBs3F9dPnHRtfQ213S2KdzbeRLIBuBclPSYewX
 VbbRN/PLs7Ly4LrwxfHpRV7q65tGncyHaTj87yhu9URZL0Sm974iQTHR+qTx4mXoeLW7/1PIe
 2rMdbgC8T9e5IdCRJmgrshTkv+8vvbKM6hd3ngHRc2NZHhRAxHA0WmFmD2k9X8Dwe5qDtHWUP
 6CQ2KJXocdSXgQE7SUziwI4sEUOTewXB0EbHv3bgdqbNxMoYJp2u3d7wck3XzmPZ0Lyg+3E2b
 ZnqWzJGJVmNayWUpWn1lNEEbScO5KocMcO37XGNKNFy7GMmJf5obQSMxNPSzMFAfOtOv+Gx/u
 FTjiJynd14yxsFR6BMmHuQ0xQollRNTI/JSuwNrTSwGYvGmRRjvHZ9llXjRJKl9HYchRNNkd3
 yGdzg58y2vP5ieHiYZRo16b3x6B4YwWc2OSRUppnO7+Qb7BXRIHnj6hP3yyyN/sU+Nd5ie1K1
 qsUVE4MkALOXYz0J+sK0uJyQg9S/TY8zcQjFt1sKo9aV2eLGolNmDSDEW2+vJStkhuQGrRskI
 BOFUT760QqHXNhgqp1O+QDpp+ppq0v2+4GSjuVWEnBCO+qe4spq1f4izgws0yPp7OyEKT3dtf
 +RpJEpr1oUH/Q2qs12gmMLWebTmO/79gGi0fqRmo0r1cc1LccMNWNN6NbiDvO56Kr8moK3+OH
 giCt68liUEDhLV8O6IASbFsxYmU9wtyOtYadBNnnxzCun9loAsZJu9S8Sz1bdY25a0Qy38dJA
 mzkpo9/2som4D5nF65r9wP6IMQDUsaywLuqdEGgJStcaRXNEA9pZ5lLCQAIIyANEKHrOPIs3Z
 nDoZmkJzfgBejzlwfWot8IJD2RWO3b5HwDt8y+SDVSp3nNks1F8cQKaYw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 11.07.22 04:50, Jarkko Sakkinen wrote:
> On Mon, Jul 04, 2022 at 07:45:12PM +0200, Lino Sanfilippo wrote:
>>
>>
>> On 01.07.22 01:29, Jarkko Sakkinen wrote:
>>
>>>
>>> I'm kind of thinking that should tpm_tis_data have a lock for its
>>> contents?
>>
>> Most of the tpm_tis_data structure elements are set once during init an=
d
>> then never changed but only read. So no need for locking for these. The
>> exceptions I see are
>>
>> - flags
>> - locality_count
>> - locality
>
> I'd still go for single data struct lock, since this lock would
> be taken in every transmit flow. It makes the whole thing easier
> to maintain over time, and does not really affect scalability.
>

This means switching to a complete new locking scheme which affects many
parts of the TIS core code. It is also not directly related to what this p=
atch series
is about, namely activating the interrupts for TPM TIS.

I suggest to first finish polishing this series especially since there hav=
e
only been minor issues in the last versions. Once the interrupts work we
still can think of implementing another lock handling in a follow up serie=
s.


> This brings me to another question: what does this lock protect
> against given that tpm_try_get_ops() already takes tpm_mutex?
> It's not clear and that should be somehow reasoned in the commit
> message.
>
> Anyway, *if* a lock is needed the granularity should be the whole
> struct.
>
> BR, Jarkko

Regards,
Lino
