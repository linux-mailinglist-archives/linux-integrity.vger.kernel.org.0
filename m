Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692B955FBC1
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Jun 2022 11:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbiF2JVL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 Jun 2022 05:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiF2JVK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Jun 2022 05:21:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3341C369C0;
        Wed, 29 Jun 2022 02:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656494449;
        bh=EkAeX5N6w3YtqO8hOxSosvDf28tnCpFaYhH61mIA+xM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Z3XzPsNPYg2ClCI0TYTMVAZ3j9MQbwEiFofNt6OMebPo4MwuqH2ZElQFB/nSPB0JM
         xpYJ9b59N3B9Thw95ysi/UQIE49tQaLoCywMKDZv7+7rdqd6isTA2JtzVaugF2po8Z
         Tg8NkHQMF/uMnV+mBNGiz8DrjQOvhXRos0Jp5838=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.69] ([46.223.3.23]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MY68d-1o7w5c2P8v-00YOJ2; Wed, 29
 Jun 2022 11:20:49 +0200
Message-ID: <4b2b3a2b-fdc0-a684-d4b1-9725e5b87ccb@gmx.de>
Date:   Wed, 29 Jun 2022 11:20:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v6 5/9] tpm, tpm_tis: Only handle supported interrupts
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com
References: <20220621132447.16281-1-LinoSanfilippo@gmx.de>
 <20220621132447.16281-6-LinoSanfilippo@gmx.de> <Yrf/azvJlzWfOE9y@kernel.org>
 <6b950660-6a78-f329-39b4-11d585e4959c@gmx.de> <Yro4tl7g1IqkEszT@kernel.org>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <Yro4tl7g1IqkEszT@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ejJxBMc0f49kRY5+GOJpGpT422gdXQehGqrdv/3iJwEgq3wWlyZ
 qYetttZl/KJHTWMkWUuVufuUrsRIYQ1PisgVo8zEg2rNHSIOKFHicjDOzEqPyGQXuf6Gwk0
 3vhEwzXQO+5lyauP/40WgovM/N/QJrdkyWofMYdScQf2qt8Rm/2m6RrAwFkkbm75N98zqjl
 4QPV5fw30D2v8A84asZIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:p6CUeDtQxa4=:G3gxnADgZrEBnAOsQCCzbP
 uzEdPo2bpnPcUmlPVk57Xfu8LFAWi2rSGYH24mXPOQKRHIRjdMm8hhEn6KO+SOil1LsRup306
 koQplAiC5E6OVMd4eSA8wKojdE7X27+oNqfGfwKNcx6ydY7XqW9Uq+2sARWD20WxtvWC/oZOm
 FpNkDXwimmtjI4vk/Mze9qagNQsene0rdIUmrQSEeos+K+/uYPZceByABXwQCujhaVvk2GoEa
 KUduV5cpJsM2zo1zgD26wNZjxUbGdXPIJkK5+pmQemZXjAk3FOVdASi+apsJ23GzVKQY9ZrFh
 L/nOKKqLIEi44kAUoOXwsSE7jqKIZuQ8UUC+GiRz84qVj1fjZ8KdHGk6WWgxf7399ApQVgpfC
 2IB1I6so77thfOtZ8uHmhE1DtVtepGZsU53NLLNnP5K8jfcaurZmr41fV1uQSwzQi1xZ8d1g/
 s+yqAJjOBIZvQa142Wnc+BDyVuh6dSX4NiQx5t2vaM3z0MuGW0pTIyVaeOV2GSIG3DT2CtuSi
 xc/HbAtFd+sGpvm/2s79NxBRsEGadmAWpt8TzTGrGCS/d7OjcRmJtxUY4O1xpOMTKWlMZ8LCP
 re4R0JQlHN0zsVUpyo7ujAVcwqPG9JOOSNoG0jKx9PNC/IvnbpmE/1aQ7aVFk4kY/1i3e7UVy
 tKaI/mW/Y74T+xvM8rqprlg4F+42Ramyu5ggX2CKjDqQEfVMIOr3u+VIzA/uMNmDrMLpJ6WWy
 dIqsPB5oZbCPDfJf9UeYSZUXb0eevvoN5Y6Nbo3Q9mSlzfdOsavlAl0M2+1KGDL2W1ftfy8Ju
 vzkGO0SVptfwc+5UNeiZwIajx9Apm6XSqVo0wADILQShKdnpQBfO3sqaru+40g8SrEMvu+SCz
 LyqbCOhzKRXKY44QlYVq+d9Ec0o9hP+TLoGlosOev/Dh8mNR2C83YsghizFsj1fYgNqMLueyc
 zG0TFOcAxIX8knJW8S0BRd/UfeYw/vmjZ3YUPTgrFEHQ/YKPijIcnYMYMScHHUJ/HRDFOGvuV
 GzhBKHcs0Im4yzPZrpLM821wQP0kIC9mqLxDu0uqLaomQhkM2CT9OfQI0TXVtbXBJvzR5jqES
 92ms0ar/dOL7PZ0lAHsBny+fe9WLH5ACdxktQ8yg3ztT71dEZMApWyKhA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 28.06.22 01:09, Jarkko Sakkinen wrote:
> On Sun, Jun 26, 2022 at 02:18:17PM +0200, Lino Sanfilippo wrote:
>> On 26.06.22 at 08:40, Jarkko Sakkinen wrote:
>>>
>>> I would instead mask out bits and write a helper function
>>> taking care of this:
>>>
>>> static u8 tpm_tis_filter_sts_mask(u8 int_mask, u8 sts_mask)
>>> {
>>>         struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
>>>
>>>         if (!(int_mask & TPM_INTF_STS_VALID_INT))
>>>                 sts_mask &=3D ~TPM_STS_VALID;
>>>
>>>         if (!(int_mask & TPM_INTF_DATA_AVAIL_INT))
>>>                 sts_mask &=3D ~TPM_STS_DATA_AVAIL;
>>>
>>>         if (!(int_mask & TPM_INTF_CMD_READY_INT))
>>> 		sts_mask &=3D ~TPM_STS_COMMAND_READY;
>>>
>>>         return sts_mask;
>>> }
>>>
>>> Less operations and imho somewhat cleaner structure.
>>>
>>> Add suggested-by if you want.
>>
>> I thought of a helper like this before but then decided to
>> not introduce another function to keep the code changes minimal. But ye=
s,
>> it is indeed cleaner. I will do the change and resubmit the series.
>>
>> Thanks for the review!
>>
>> Regards,
>> Lino
>
> Yeah, please don't add suggested-by, it's such a minor detail
> in the overall patch :-)

I already created a separate patch which only contains moving the bit chec=
ks into the
helper function. For that patch the Suggested-by is fully justified IMHO.


Thanks for taking time to fix these
> glitches and also taking all the feedback into account (and
> also being patient).
>

No problem. Its always good to have some feedback from people that have a =
deeper insight
into the code. Especially when it is as complex as the TPM subsystem and d=
rivers.

Best regards,
Lino
