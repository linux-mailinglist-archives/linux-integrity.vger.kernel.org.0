Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5609584372
	for <lists+linux-integrity@lfdr.de>; Thu, 28 Jul 2022 17:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiG1Pp7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 28 Jul 2022 11:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiG1Pp6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Jul 2022 11:45:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BEF683E9;
        Thu, 28 Jul 2022 08:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659023144;
        bh=Y1eiQDBCLtOWJT5tOY/AfapN0g45VAqL6KyLJVbgwgA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=bBRSSGto3AyPTYNx1OOoh6iI2XsheUOs2+lyK6lzHOpuL70s61rfpHVtYu7vFefDc
         D6NcHSvzbh6jnQlK/O2iPFIdZEkwUJvVBg1Axo8g294E6xaHXGRSFQXEOVO0Nz2Rh+
         EzpFuUcuenGxf4fYqSu4r8+brBuMW9sE3L3dsWXk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.212.134.103] ([80.237.181.220]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McH5Q-1nl2k00KLc-00cdjh; Thu, 28
 Jul 2022 17:45:44 +0200
Message-ID: <d3f16f0a-cc05-a6f1-17cb-2649b5ab42c8@gmx.de>
Date:   Thu, 28 Jul 2022 17:45:42 +0200
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
 <YsuQEoVuVa00gIdE@kernel.org> <744ad6e1-c4ad-1e6d-f94d-98aa5b105dc6@gmx.de>
 <YuJFuBFtImG/k+C0@kernel.org>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <YuJFuBFtImG/k+C0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M8kyeZpjwcqtwpFXUiqRvoOawsjS+LZu7WV3SQha2rAmR2qT1K/
 bTEd9Lb9z+/4myfCKjMGQ4oFy5P3Uwn1sWSMGuxKoN/7vDj/9pFEUjcA99rwwecKR77aAmv
 TytlmEidaWuxSOg2zuj9BkqZd4h0EAQsHfzwhcpd+U6gkmMXmWgDFjS/c3u4Xly1h7cQJvq
 k4C4XkaLPzvYLQznffTbw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G2RdEEMONck=:8N+TzQ0ruxwDShdmZR2e8U
 N46D7rvE4lFJv6LmAZdpVCC68YwS8aIvWFyS0secB8LXBA6E0uFHfpM4nr34CR5uF4NgLarvy
 loTcTdECHm23B0TdWr+b8fY4aZTziCJAKbwix4NQHKq+wbyCS4+OeD6WEG0tuWo5yv+bq3av+
 XPs9xbulezcCKiWlUvbEvL2OuMC0wDcCc/4oixDoY0tb3oxOSpy4nTAwwDngk+LjMHXn6nRYj
 3o7TRg/M3FoIQqEO2N37uaw5YYTyNJ4jmV4fz/T3zhQ25X56pGzaQOG2youhieXE3EAI5JAlI
 kx0cg4xV/NL6S2jB8o8rLutycVgR/ZaYSrbPhRjgjrwXOClOP+jSWsXdZRIMqiFbofY3IcnSu
 E9qT1sUOMBHTRIAtiP4aPjxWn30rEtRa5chelwatzGlPaP3HyOjs7XiiOnm0i1Eczm7Dg5rD1
 MI5HwWMPdLo9/C784s5+LukLuIF/DXPmNR36rETulgve5IOVeU+j7TYmkmfOVAknX3zAj+JPG
 f6gFEmvhkvCMkcyiJZKchMBVqOp4V4S3Zc5NA6oPekqXwNoUSpk++xE3iOXp5uv3x5Awmu63s
 eiqv+xRLvutB4TZ+925sNReqEqNAQHV7II8I/HYz+ayAvpRfDbbLzCOBwXFlCNtfEokJ7LKbs
 /qs9urr4HZOLaqsdAS3LgONb4APWKvOubnJqxwYx/khBI3O9kbt0KhQ8R34jVIvsrOmg2lQe9
 U8yWeJ9Yh4pNmQPNM+z75gCuLzUx8kNEmf2OQypfBJN+yJ4Ff2N+ITUC8B+AXJ5H8V1oAdpOc
 vBMp3wpcPGxOEaW15qHsM7w5quGaiiMx25dyEvvBkHoZ+Tr2iFl7SbH3kDe1OEk+RmYPH3K+Q
 451Kn2pjebER1mu5ZqIv7//1a/1CY3N/pi2qn9NtOa3zUcUKtcO+mIa0ir+sxFbNGm/soKILm
 X3TGlI7HXLcRm//YkWwWF/lIBV/HnqpQhTtDFSBmkUXieAZlhE57QO08ZQQGGcNR/hW28WgRR
 4HTrGtKWraZMzZh5xkPxTEafp7sQg2TZz8sYt8EwjZDVjzUiarnD47qvmcjtn3k/0HQJ7PCVS
 GMALvwpySW1bQn/Hzzhmg3U+G8dzNqYMaw3W4Vs2+ocFANyVTVEvUgw2A==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 28.07.22 10:15, Jarkko Sakkinen wrote:
> On Wed, Jul 27, 2022 at 02:16:56PM +0200, Lino Sanfilippo wrote:
>>
>>
>> On 11.07.22 04:50, Jarkko Sakkinen wrote:
>>> On Mon, Jul 04, 2022 at 07:45:12PM +0200, Lino Sanfilippo wrote:
>>>>
>>>>
>>>> On 01.07.22 01:29, Jarkko Sakkinen wrote:
>>>>
>>>>>
>>>>> I'm kind of thinking that should tpm_tis_data have a lock for its
>>>>> contents?
>>>>
>>>> Most of the tpm_tis_data structure elements are set once during init =
and
>>>> then never changed but only read. So no need for locking for these. T=
he
>>>> exceptions I see are
>>>>
>>>> - flags
>>>> - locality_count
>>>> - locality
>>>
>>> I'd still go for single data struct lock, since this lock would
>>> be taken in every transmit flow. It makes the whole thing easier
>>> to maintain over time, and does not really affect scalability.
>>>
>>
>> This means switching to a complete new locking scheme which affects man=
y
>> parts of the TIS core code. It is also not directly related to what thi=
s patch series
>> is about, namely activating the interrupts for TPM TIS.
>>
>> I suggest to first finish polishing this series especially since there =
have
>> only been minor issues in the last versions. Once the interrupts work w=
e
>> still can think of implementing another lock handling in a follow up se=
ries.
>
> So what if you would use kref instead here?
>

Sure, that should not be too difficult to do. I will implement this for th=
e next version.

Regards,
Lino
