Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34FB34656E
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Mar 2021 17:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbhCWQhg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Mar 2021 12:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233376AbhCWQhW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Mar 2021 12:37:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE1EC061574
        for <linux-integrity@vger.kernel.org>; Tue, 23 Mar 2021 09:37:22 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1lOk1t-0005Kn-E2; Tue, 23 Mar 2021 17:37:17 +0100
Subject: Re: [PATCH v1 0/3] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
To:     =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        James Bottomley <jejb@linux.ibm.com>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
References: <cover.56fff82362af6228372ea82e6bd7e586e23f0966.1615914058.git-series.a.fatoum@pengutronix.de>
 <f0f43b30-3dfb-c2a0-7f69-6e5488f871cd@nxp.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <a07e5544-1e62-a8da-485e-6fcafd16bab9@pengutronix.de>
Date:   Tue, 23 Mar 2021 17:37:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <f0f43b30-3dfb-c2a0-7f69-6e5488f871cd@nxp.com>
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

On 21.03.21 21:01, Horia Geantă wrote:
>>  - [RFC] drivers: crypto: caam: key: Add caam_tk key type
>>    Franck added[3] a new "caam_tk" key type based on Udit's work. The key
>>    material stays within the kernel only, but can optionally be user-set
>>    instead of coming from RNG. James voiced the opinion that there should
>>    be just one user-facing generic wrap/unwrap key type with multiple
>>    possible handlers. David suggested trusted keys.
>>
> The whole point was to use caam "black blobs", with the main advantage of
> keys being kept encrypted in memory after "unsealing" the blobs.
> (Keys in blobs are encrypted with a persistent BKEK - blob KEK, derived from
> fuse-based OTPMK. OTOH black keys are keys encrypted with an ephemeral, random
> KEK that is stored in an internal caam register. When a black blob is unsealed,
> the key is practically rekeyed, the random key replacing the BKEK; key is never
> exposed in plaintext, rekeying happens in caam).
> 
> Current implementation uses "red blobs", which means keys are left unprotected
> in memory after blobs are unsealed.

Oh. I will reread the series when sending the v2 cover letter. Thanks for spotting.

(Sorry for the noise, missed this question first time)

>>  - Introduce TEE based Trusted Keys support
>>    Sumit reworked[4] trusted keys to support multiple possible backends with
>>    one chosen at boot time and added a new TEE backend along with TPM.
>>    This now sits in Jarkko's master branch to be sent out for v5.13
>>
>> This patch series builds on top of Sumit's rework to have the CAAM as yet another
>> trusted key backend.
>>
> Shouldn't the description under TRUSTED_KEYS (in security/keys/Kconfig)
> be updated to reflect the availability of multiple backends?
> 
> Thanks,
> Horia
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
