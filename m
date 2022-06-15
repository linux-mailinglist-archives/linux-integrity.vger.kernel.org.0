Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5728354D47E
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Jun 2022 00:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344991AbiFOWWa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jun 2022 18:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236639AbiFOWW3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jun 2022 18:22:29 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81612B8;
        Wed, 15 Jun 2022 15:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655331733;
        bh=7Nz3pQkBpBxV+DkrOjcNVQfPVA5p4xkVtV9V6hPRVM8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=NYJ1SEnZz+enh6MvRSRIj+TS9Esvz6eKEiD63SPVr2FTZjBYKj4G8ySaa0aCXCkjE
         Bi4ij6O2iCJ7gt5xgc1Fd4RtZ17knq8XdjaHlI8y5Qblmgl6nyhtAZh2/LMIOyLKF5
         uBYD1J22I7Ud5ccF7JNMBfSCQytI8nFT2sZK2Jjw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.33] ([46.223.2.17]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPGRp-1oMgWG1zYr-00Pgxa; Thu, 16
 Jun 2022 00:22:13 +0200
Subject: Re: [PATCH v5 07/10] tmp, tmp_tis: Implement usage counter for
 locality
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com
References: <20220610110846.8307-1-LinoSanfilippo@gmx.de>
 <20220610110846.8307-8-LinoSanfilippo@gmx.de> <Yqojlh5J0660gfaT@iki.fi>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <2b9e9b38-5ed7-aff1-9ead-534e9d857eda@gmx.de>
Date:   Thu, 16 Jun 2022 00:22:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <Yqojlh5J0660gfaT@iki.fi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VhHTR5MUWapQwJwyqqOUTn/M2J7ABp8kLCBSIPYlwZTW/h4SvTX
 cxqQCuPX6ayPrM8lK9eAYLAs9fQDLROLQrDhu2oRNZrxgk7lk+yY84YPGJ8Ru0XmLk337TJ
 r8slzKD11LrMTYgbt0Jc7rO2zVLeCSz7D0pevFZxdHMK3pb0bwzwrj/T4as//8mptcZQX0p
 /rWetRDASyCFLkhfVZ0GQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MMWC7xhLkC4=:ocooFn7ROfYkQVdr8qBxB4
 2JAtU0VAkIhIePC7svNAA7tccTlvc4Xq6ce2ITB84Au4KvyAmwMX4+SgcMGqkRzgjDdY3UM2x
 Y0flyFtVvvsINoM+EKhefU/j0ydEforH4r3yWjtOg+gdpVpw3Iu/cO95gsUrYkrSn51kkLgiD
 2IXIh5zxAxmdxZtFOs56QrnSBewb5rLoQ0QiZ7CPKRqolqS+2JIrLn7+M3ClK8z1ALQONyuG1
 r3dL21THnffWYsxf1F9MCqsw3off2mbh3bnxA9cjNN0Ifb89Yz2G5IP+p/mjDKEnibXMR/7Lx
 p5585N2C4niolx6Y9ON8PaMszMwWdpKv24FHJA4rTCWolhL0eEPIxsTQhbkQdMrUCQlfRMQMW
 583ln+uNgSn7Uo4nlLMqfIgXUvvO5M6/oJyd+DjJMyoVAw0Dfl+knpBZYY8QWDvXvMjghnDw3
 73P37Qrymy+hn26otcby6s0B2b1a7LGxVoaMAhZkQJVrbOqUfsgr+N7g1iapWO21Z6Jy5y4HO
 7Vd3ckNIgsvjR9PjnkKhMpnnX+oPqlQSseM3ieQgTTIyUOnYhiHaJHz/9cTpe0xbMwERzN/fP
 V/ces7f0/bWD3lKCrTGPNP1+fJvL0OMWMsHqI6aLQ0BkVwQebSG78uYP6vg+kEs57p+6QuH9v
 MnhJpGOCR4s0780ia9ohe2yCncNLKBr/0p03RoTuLo8reH4r9iL94kau+V8JtlHR2CK8/ccBW
 gF/CYdYnC0ucfHRvKzuriRhI/3ClhQFmHqnxLiSyyRZ70vZcGzFzd/+szzXIKaqXPTBLY5xuK
 zy/FWTOiN2WCVy2hHKOOGcnm0lgkeF/WSQVnho909w7Mg1XnNvfPQe5AhMWdAQjbAj4e1hkXR
 OpNKAPgXC+FL4TB1GDJBCRXyLV2LTI4xPM/37zbP8AqAnysoJXyxy1+3Ryy6gs1yohwI8wCAt
 qFXivYjcgbG+ag3th1Ct0CW/FuIPZj8hdwQjb7PBOzaHxMr3ohiHf7wa/Ykpudlz/JKLcFzTc
 agCJHPS7uh00oroGr/TC0vxUky6RA86wOJWkEihahHER/s8ZnA6svonfTquLRdwhUJkyznUaL
 eYjz4jFvt9icflX7S0uvyF+1LE9jWCv+mwdNoSrjCblmERFXbKgQxj+jA==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 15.06.22 at 20:23, Jarkko Sakkinen wrote:
> On Fri, Jun 10, 2022 at 01:08:43PM +0200, LinoSanfilippo@gmx.de wrote:
>> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>
>> Implement a usage counter for the (default) locality used by the TPM TI=
S
>> driver:
>> Request the locality from the TPM if it has not been claimed yet, other=
wise
>> only increment the counter. Also release the locality if the counter is=
 0
>> otherwise only decrement the counter. Ensure thread-safety by protectin=
g
>> the counter with a mutex.
>>
>> This allows to request and release the locality from a thread and the
>> interrupt handler at the same time without the danger to interfere with
>> each other.
>>
>> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>> ---
>>  drivers/char/tpm/tpm_tis_core.c | 30 ++++++++++++++++++++++++++++--
>>  drivers/char/tpm/tpm_tis_core.h |  2 ++
>>  2 files changed, 30 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis=
_core.c
>> index 028bec44362d..0ef74979bc2c 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -158,16 +158,26 @@ static bool check_locality(struct tpm_chip *chip,=
 int l)
>>  	return false;
>>  }
>>
>> +static int release_locality_locked(struct tpm_tis_data *priv, int l)
>> +{
>> +	tpm_tis_write8(priv, TPM_ACCESS(l), TPM_ACCESS_ACTIVE_LOCALITY);
>
> nit: empty line here
>
> Also it would not hurt to prefix it with tpm_tis.
>
> This is for simple and practical reasons, like grepping. I don't
> mind if you do that also for other functions (if you want to).
>

Ok, will do so.

Regards,
Lino
