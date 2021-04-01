Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B4D351462
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Apr 2021 13:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbhDALN6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Apr 2021 07:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbhDALN3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Apr 2021 07:13:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220E6C0613E6
        for <linux-integrity@vger.kernel.org>; Thu,  1 Apr 2021 04:13:29 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1lRvGO-0001R7-F8; Thu, 01 Apr 2021 13:13:24 +0200
Subject: Re: [PATCH v1 0/3] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
To:     Richard Weinberger <richard@nod.at>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        horia geanta <horia.geanta@nxp.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        aymen sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        davem <davem@davemloft.net>,
        James Bottomley <jejb@linux.ibm.com>,
        kernel <kernel@pengutronix.de>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        david <david@sigma-star.at>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        "open list, ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>
References: <cover.56fff82362af6228372ea82e6bd7e586e23f0966.1615914058.git-series.a.fatoum@pengutronix.de>
 <ca2a7c17-3ed0-e52f-2e2f-c0f8bbe10323@pengutronix.de>
 <CAFLxGvyj1aZ_3MuxJC6onejchV_6A8WbNR1vTLpSBF5QTxvLyQ@mail.gmail.com>
 <897df7dd-83a1-3e3e-1d9f-5a1adfd5b2fb@pengutronix.de>
 <1263763932.139584.1617272457698.JavaMail.zimbra@nod.at>
 <27d7d3fa-5df8-1880-df21-200de31cc629@pengutronix.de>
 <717795270.139671.1617274418087.JavaMail.zimbra@nod.at>
 <c72f93be-04e8-bb52-7252-4b4131648100@pengutronix.de>
 <1713376107.139705.1617275134320.JavaMail.zimbra@nod.at>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <638717a5-a456-24a7-b0ab-9f71adb13687@pengutronix.de>
Date:   Thu, 1 Apr 2021 13:13:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1713376107.139705.1617275134320.JavaMail.zimbra@nod.at>
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

Hello Richard,

On 01.04.21 13:05, Richard Weinberger wrote:
> Ahmad,
> 
> ----- Ursprüngliche Mail -----
>> Von: "Ahmad Fatoum" <a.fatoum@pengutronix.de>
>>> I don't want you to force to use cryptsetup.
>>
>> I'd love to use cryptsetup with LUKS and trusted keys eventually. I'll take
> 
> But using LUKS would mean that cryptsetup has access to the plain disc encryption key material?
> This would be a no-go for many systems out there, key material must not accessible to userspace.
> I know, distrusting userspace root is not easy, but doable. :)

The LUKS2 format supports tokens. I see no reason why the encrypted blob
couldn't be stored there along with the usual metadata. cryptsetup would
then load it as kernel trusted key and use it for dmcrypt decryption.

This will mean we have to part ways with features such as having multiple
keys, but I think it's worth it to have a plug and play solution for
trusted keys.

Of course, someone needs to implement this first ^^.

Cheers,
Ahmad

> 
> Thanks,
> //richard
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
