Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12F413513FF
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Apr 2021 12:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbhDAK5n (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Apr 2021 06:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233845AbhDAK5b (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Apr 2021 06:57:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C80C0613E6
        for <linux-integrity@vger.kernel.org>; Thu,  1 Apr 2021 03:57:31 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1lRv0w-0007Ml-Ho; Thu, 01 Apr 2021 12:57:26 +0200
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
 <CAFLxGvzWLje+_HFeb+hKNch4U1f5uypVUOuP=QrEPn_JNM+scg@mail.gmail.com>
 <ca2a7c17-3ed0-e52f-2e2f-c0f8bbe10323@pengutronix.de>
 <CAFLxGvyj1aZ_3MuxJC6onejchV_6A8WbNR1vTLpSBF5QTxvLyQ@mail.gmail.com>
 <897df7dd-83a1-3e3e-1d9f-5a1adfd5b2fb@pengutronix.de>
 <1263763932.139584.1617272457698.JavaMail.zimbra@nod.at>
 <27d7d3fa-5df8-1880-df21-200de31cc629@pengutronix.de>
 <717795270.139671.1617274418087.JavaMail.zimbra@nod.at>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <c72f93be-04e8-bb52-7252-4b4131648100@pengutronix.de>
Date:   Thu, 1 Apr 2021 12:57:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <717795270.139671.1617274418087.JavaMail.zimbra@nod.at>
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

On 01.04.21 12:53, Richard Weinberger wrote:
> Ahmad,
> 
> ----- Ursprüngliche Mail -----
>> Do you mean systemd-cryptsetup? It looks to me like it's just a way to supply
>> the keyphrase. With trusted keys and a keyphrase unknown to userspace, this
>> won't work.
> 
> Nah, I meant existing scripts/service Files.
> 
>> I don't (yet) see the utility of it without LUKS. Perhaps a command dump on how
>> to do the same I did with dmsetup, but with cryptsetup plain instead could
>> help me to see the benefits?
> 
> My reasoning is simple, why do I need a different tool when there is already one
> that could do the task too?
> Usually the systems I get my hands on use already dm-crypt with cryptsetup in some way.
> So I have the tooling already in my initramfs, etc.. and need to adopt the callers of cryptsetup a little.
> 
> If I need all of a sudden different/additional tooling, it means more work, more docs to write,
> more hassle with crypto/system reviewers, etc...
> 
> I don't want you to force to use cryptsetup.

I'd love to use cryptsetup with LUKS and trusted keys eventually. I'll take
a look and see if cryptsetup plain maybe a suitable stop-gap solution for us.

> The only goal was pointing out that it can be done with cryptsetup and that there
> is already code such that no work is done twice.
> One the kernel side it does not matter.

Thanks for the pointer,
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
