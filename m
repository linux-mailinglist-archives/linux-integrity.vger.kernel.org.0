Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA69346557
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Mar 2021 17:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbhCWQf7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Mar 2021 12:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbhCWQfp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Mar 2021 12:35:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EF8C061574
        for <linux-integrity@vger.kernel.org>; Tue, 23 Mar 2021 09:35:45 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1lOk0M-0004wd-Am; Tue, 23 Mar 2021 17:35:42 +0100
Subject: Re: [PATCH v1 3/3] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
To:     =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
References: <cover.56fff82362af6228372ea82e6bd7e586e23f0966.1615914058.git-series.a.fatoum@pengutronix.de>
 <319e558e1bd19b80ad6447c167a2c3942bdafea2.1615914058.git-series.a.fatoum@pengutronix.de>
 <01e6e13d-2968-0aa5-c4c8-7458b7bde462@nxp.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <45a9e159-2dcb-85bf-02bd-2993d50b5748@pengutronix.de>
Date:   Tue, 23 Mar 2021 17:35:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <01e6e13d-2968-0aa5-c4c8-7458b7bde462@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello Horia,

On 21.03.21 21:48, Horia Geantă wrote:
> On 3/16/2021 7:02 PM, Ahmad Fatoum wrote:
> [...]
>> +struct trusted_key_ops caam_trusted_key_ops = {
>> +	.migratable = 0, /* non-migratable */
>> +	.init = trusted_caam_init,
>> +	.seal = trusted_caam_seal,
>> +	.unseal = trusted_caam_unseal,
>> +	.exit = trusted_caam_exit,
>> +};
> caam has random number generation capabilities, so it's worth using that
> by implementing .get_random.

If the CAAM HWRNG is already seeding the kernel RNG, why not use the kernel's?

Makes for less code duplication IMO.

> 
> Horia
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
