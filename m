Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17E13E43AE
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Aug 2021 12:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbhHIKRU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Aug 2021 06:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbhHIKRR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Aug 2021 06:17:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF7BC0613D3
        for <linux-integrity@vger.kernel.org>; Mon,  9 Aug 2021 03:16:57 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1mD2L1-0006Uv-IB; Mon, 09 Aug 2021 12:16:55 +0200
Subject: Re: [PATCH 0/4] KEYS: trusted: Introduce support for NXP CAAM-based
 trusted keys
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        James Bottomley <jejb@linux.ibm.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        David Gstir <david@sigma-star.at>,
        Eric Biggers <ebiggers@kernel.org>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Richard Weinberger <richard@nod.at>,
        James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, kernel@pengutronix.de,
        linux-integrity@vger.kernel.org,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        "Serge E. Hallyn" <serge@hallyn.com>
References: <cover.9fc9298fd9d63553491871d043a18affc2dbc8a8.1626885907.git-series.a.fatoum@pengutronix.de>
 <b9e44f8e-84a0-90be-6cfc-d3a0bde12178@pengutronix.de>
 <20210809093519.er32rmspuvkrww45@kernel.org>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <8321cac9-350b-1325-4b7e-390f4f292070@pengutronix.de>
Date:   Mon, 9 Aug 2021 12:16:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210809093519.er32rmspuvkrww45@kernel.org>
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

On 09.08.21 11:35, Jarkko Sakkinen wrote:
> On Fri, Aug 06, 2021 at 05:12:19PM +0200, Ahmad Fatoum wrote:
>> Dear trusted key maintainers,
>>
>> On 21.07.21 18:48, Ahmad Fatoum wrote:
>>> Series applies on top of
>>> https://lore.kernel.org/linux-integrity/20210721160258.7024-1-a.fatoum@pengutronix.de/T/#u
>>>
>>> v2 -> v3:
>>>  - Split off first Kconfig preparation patch. It fixes a regression,
>>>    so sent that out, so it can be applied separately (Sumit)
>>>  - Split off second key import patch. I'll send that out separately
>>>    as it's a development aid and not required within the CAAM series
>>>  - add MAINTAINERS entry
>>
>> Gentle ping. I'd appreciate feedback on this series.
> 
> Simple question: what is fscrypt?

For supported file systems, fscrypt[1] allows you to encrypt at a directory level.
It has no trusted key integration yet, which is something I am trying to upstream
in parallel to this series, so I eventually can use fscrypt together with CAAM-backed
trusted keys on an unpatched kernel.

If it interests you, I described[2] my CAAM+ubifs+fscrypt use case in the
discussion thread on my fscrypt-trusted-keys v1. Jan, a colleague of mine, held a
talk[3] on the different solutions for authenticated and encrypted storage, which
you may want to check out.

I'd really appreciate feedback here on the the CAAM parts of this series, so this can
eventually go mainline.

Thanks,
Ahmad


[1]: https://www.kernel.org/doc/html/v5.13/filesystems/fscrypt.html
[2]: https://lore.kernel.org/linux-fscrypt/367ea5bb-76cf-6020-cb99-91b5ca82d679@pengutronix.de/
[3]: https://www.youtube.com/watch?v=z_y84v9076c

> 
> /Jarkko
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
