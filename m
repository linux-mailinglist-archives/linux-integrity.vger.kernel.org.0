Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE9A33F21E
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Mar 2021 15:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbhCQOD2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Mar 2021 10:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbhCQODE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Mar 2021 10:03:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1364C06174A
        for <linux-integrity@vger.kernel.org>; Wed, 17 Mar 2021 07:03:03 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1lMWlI-0003Jo-MJ; Wed, 17 Mar 2021 15:03:00 +0100
Subject: Re: [PATCH v1 3/3] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>, kernel@pengutronix.de,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>, keyrings@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>
References: <cover.56fff82362af6228372ea82e6bd7e586e23f0966.1615914058.git-series.a.fatoum@pengutronix.de>
 <319e558e1bd19b80ad6447c167a2c3942bdafea2.1615914058.git-series.a.fatoum@pengutronix.de>
 <CAFLxGvxmRcvkweGSRSLGEm5MJDM4M7nzkp9FwOwmhZ+h2RE0vA@mail.gmail.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <91b01387-1814-0719-8a21-2beb150dfcd6@pengutronix.de>
Date:   Wed, 17 Mar 2021 15:02:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAFLxGvxmRcvkweGSRSLGEm5MJDM4M7nzkp9FwOwmhZ+h2RE0vA@mail.gmail.com>
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

Hello Richard,

On 17.03.21 00:14, Richard Weinberger wrote:
> Ahmad,
> 
> On Tue, Mar 16, 2021 at 6:24 PM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>> +#include <keys/trusted_caam.h>
>> +#include <keys/trusted-type.h>
>> +#include <linux/build_bug.h>
>> +#include <linux/key-type.h>
>> +#include <soc/fsl/caam-blob.h>
>> +
>> +struct caam_blob_priv *blobifier;
> 
> Who is using this pointer too?
> Otherwise I'd suggest marking it static.

You're right. Will do in v2.

>>  module_param_named(source, trusted_key_source, charp, 0);
>> -MODULE_PARM_DESC(source, "Select trusted keys source (tpm or tee)");
>> +MODULE_PARM_DESC(source, "Select trusted keys source (tpm, tee or caam)");
> 
> I didn't closely follow the previous discussions, but is a module
> parameter really the right approach?
> Is there also a way to set it via something like device tree?

Compiled-on sources are considered in the order: tpm, tee then caam.
Module parameters are the only override currently available.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
