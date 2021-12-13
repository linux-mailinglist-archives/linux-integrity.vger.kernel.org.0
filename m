Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650F5472A58
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Dec 2021 11:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244302AbhLMKjy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Dec 2021 05:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244213AbhLMKjr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Dec 2021 05:39:47 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B21DC050B20
        for <linux-integrity@vger.kernel.org>; Mon, 13 Dec 2021 02:29:17 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1mwia1-0006sI-QH; Mon, 13 Dec 2021 11:29:13 +0100
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [PATCH v4 2/5] KEYS: trusted: allow users to use kernel RNG for
 key material
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>, kernel@pengutronix.de,
        Sumit Garg <sumit.garg@linaro.org>,
        David Gstir <david@sigma-star.at>,
        Tim Harvey <tharvey@gateworks.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Eric Biggers <ebiggers@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <cover.8f40b6d1b93adc80aed2cac29a134f7a7fb5ee98.1633946449.git-series.a.fatoum@pengutronix.de>
 <9bd8c969d5c656825a35aab6fb0725282a8a62cc.1633946449.git-series.a.fatoum@pengutronix.de>
 <YawE8cQ2SZjxqWUo@iki.fi>
Message-ID: <3f58a16d-ae57-bb78-f04e-878dd5408a4f@pengutronix.de>
Date:   Mon, 13 Dec 2021 11:29:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YawE8cQ2SZjxqWUo@iki.fi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello Jarkko,

On 05.12.21 01:16, Jarkko Sakkinen wrote:
> On Mon, Oct 11, 2021 at 12:02:35PM +0200, Ahmad Fatoum wrote:
>> The two existing trusted key sources don't make use of the kernel RNG,
>> but instead let the hardware doing the sealing/unsealing also
>> generate the random key material. However, Users may want to place
> 
> "Users" -> "users"

Will fix for v5.

>> +static bool trusted_kernel_rng;
>> +module_param_named(kernel_rng, trusted_kernel_rng, bool, 0);
>> +MODULE_PARM_DESC(kernel_rng, "Generate key material from kernel RNG");
> 
> It's not then always kernel RNG, i.e. that is a very misleading name.

trusted.kernel_rng=1 always forces kernel RNG, trusted.kernel_rng=0 will
choose trust source default.

> I'd prefer trusted_rng with string values "kernel", "tee". That makes
> it explicit what you are using.

This is also a bit misleading for trust sources that don't provide their
own RNG, either because the driver doesn't implement it, or because the
IP doesn't have its own RNG (like DCP on NXP's i.MX6UL SoC).

For v5, I'd implement following 'tristate-with-strings' scheme:

 trusted.rng=""
	=> Use trust source default, fall back to kernel RNG if there's none
           (trusted.kernel_rng=0 in current patch)

 trusted.rng=kernel
	=> Always use kernel RNG
           (trusted.kernel_rng=1 in current patch)

 trusted.rng=$trusted.source
	=> Use trust source default, but error out if trust source
           doesn't implement its own RNG to avoid misleading users
           about key randomness source

 trusted.rng="anything-else"
	=> Error out with warning that only valid values are
	   "kernel,${trust.source}" where trust.source is the currently
	   active one.

Sounds good?

Cheers,
Ahmad

> 
> /Jarkko
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
