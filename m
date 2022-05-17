Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27DB52A7DE
	for <lists+linux-integrity@lfdr.de>; Tue, 17 May 2022 18:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350861AbiEQQZk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 May 2022 12:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbiEQQZi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 May 2022 12:25:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044EA3B28E
        for <linux-integrity@vger.kernel.org>; Tue, 17 May 2022 09:25:37 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nr00b-0007lD-3L; Tue, 17 May 2022 18:25:17 +0200
Message-ID: <6da32ccf-1735-c47f-02c3-f7a8c736dbe3@pengutronix.de>
Date:   Tue, 17 May 2022 18:25:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [PATCH v10 2/7] KEYS: trusted: allow use of kernel RNG for key
 material
To:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>
Cc:     kernel@pengutronix.de, Sumit Garg <sumit.garg@linaro.org>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        David Gstir <david@sigma-star.at>,
        Michael Walle <michael@walle.cc>,
        John Ernberg <john.ernberg@actia.se>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Eric Biggers <ebiggers@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
References: <20220513145705.2080323-1-a.fatoum@pengutronix.de>
 <20220513145705.2080323-3-a.fatoum@pengutronix.de>
 <1c6a5ce2564c29a06eca255072a379351a5fc026.camel@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <1c6a5ce2564c29a06eca255072a379351a5fc026.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello Mimi,

[Cc'ing RNG maintainers in case they want to chime in]

On 17.05.22 17:52, Mimi Zohar wrote:
> On Fri, 2022-05-13 at 16:57 +0200, Ahmad Fatoum wrote:
>>  static int __init init_trusted(void)
>>  {
>> +       int (*get_random)(unsigned char *key, size_t key_len);
>>         int i, ret = 0;
>>  
>>         for (i = 0; i < ARRAY_SIZE(trusted_key_sources); i++) {
>> @@ -322,6 +333,28 @@ static int __init init_trusted(void)
>>                             strlen(trusted_key_sources[i].name)))
>>                         continue;
>>  
>> +               /*
>> +                * We always support trusted.rng="kernel" and "default" as
>> +                * well as trusted.rng=$trusted.source if the trust source
>> +                * defines its own get_random callback.
>> +                */
>  
> While TEE trusted keys support was upstreamed, there was a lot of
> discussion about using kernel RNG.  One of the concerns was lack of or
> insuffiencent entropy during early boot on embedded devices.  This
> concern needs to be clearly documented in both Documentation/admin-
> guide/kernel-parameters.txt and Documentation/security/keys/trusted-
> encrypted.rst.

If a user decides to use kernel RNG for trusted keys, wait_for_random_bytes()
called first thing in the used get_random_bytes_wait() will (quoting
documentation) "wait for the input pool to be seeded and thus [is] guaranteed
to supply cryptographically secure random numbers."

Does this address your concerns about Kernel RNG use?

Thanks,
Ahmad

> 
> thanks,
> 
> Mimi
> 
>> +               get_random = trusted_key_sources[i].ops->get_random;
>> +               if (trusted_rng && strcmp(trusted_rng, "default")) {
>> +                       if (!strcmp(trusted_rng, "kernel")) {
>> +                               get_random = kernel_get_random;
>> +                       } else if (strcmp(trusted_rng, trusted_key_sources[i].name) ||
>> +                                  !get_random) {
>> +                               pr_warn("Unsupported RNG. Supported: kernel");
>> +                               if (get_random)
>> +                                       pr_cont(", %s", trusted_key_sources[i].name);
>> +                               pr_cont(", default\n");
>> +                               return -EINVAL;
>> +                       }
>> +               }
>> +
>> +               if (!get_random)
>> +                       get_random = kernel_get_random;
>> +
>>                 static_call_update(trusted_key_init,
>>                                    trusted_key_sources[i].ops->init);
> 
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
