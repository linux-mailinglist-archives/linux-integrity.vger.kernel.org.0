Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27822606C23
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Oct 2022 01:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJTXnF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 Oct 2022 19:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJTXnD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 Oct 2022 19:43:03 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E42E16DC3B
        for <linux-integrity@vger.kernel.org>; Thu, 20 Oct 2022 16:43:01 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id m6so1034573qkm.4
        for <linux-integrity@vger.kernel.org>; Thu, 20 Oct 2022 16:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3AP/tQZsCGWdqocUdGbR0U8FOgV3GYYbflK+bE4iCU=;
        b=n3in2a6l84dZ4h43JiWPEaU07Ag4vYTbida9+trrLRkXvVMbPcyx6HxtX8lAajFZFC
         DtoagUZ1PTH2sW0BvUiuWacOoD+b0oHxbdazrKo7R18xXMv8a3vvGZGyW62mYg4k6lkt
         3/foqWE3SI3G+FIcfErHPBsohl89rS5d99nOCfhFM+R8EWwDBwnmrXXAOdtpDHqEUdZo
         oMi4qWhGG7oSMxykmVnWYIwNz7FJ2k300VniYOJMoYM5/+paUqv5Ir8yBWQ898/Yzkzm
         ihj9GA65p7uqsk6bsfytPAf9WygErO/AX5iGn+8DsaW97NMJqf1dnss8tzD88E+2Oquw
         RSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q3AP/tQZsCGWdqocUdGbR0U8FOgV3GYYbflK+bE4iCU=;
        b=fLPSm/7X5iR1H8PhbXCTHT4GqMXnkodf/PCtRUcw/RChU3KGLIdD/ZTDF7xMtshFi7
         VBnnojGid8dxgeRYe33xQkoO2AY6gPt468KtVALtpPbjgK+Uq0pzepfo9u6+AV4Tlo/E
         NqtVawjFH5ARmK9nnARwEJYa2PQUy6LbT3BmjuwGHlhtYE8haJ86KrMP00obTKwSyboI
         cgFf8pF8faqdadrB9jKU4JEYTA8cXd2hGkkuccwOj5DIdV2fNlCWB43oxIFWIoxxSb1j
         oNKfdmXsSvHm5nd1QgTr9pnlKyb/Xxc4crIaRnoC2TehgiWgjtAiRFNkWXsn8b/fMdGY
         f8gA==
X-Gm-Message-State: ACrzQf3jP0ebfOh2gAkLDAZUVqGwixCRGeKXD7IHyjwhxKRSH9kw40Pk
        Ik4rjq3FKSi8d4roWR6MywqPoA==
X-Google-Smtp-Source: AMsMyM77ieCA9Ka3hBL0aoBJg1xvsJRStZW8qEvdIlyx1P3eg6ZqCcE+FSB11I0sMIsyLJKF0HZlSQ==
X-Received: by 2002:a05:620a:13b6:b0:6ee:cf79:bfa1 with SMTP id m22-20020a05620a13b600b006eecf79bfa1mr11569554qki.15.1666309380684;
        Thu, 20 Oct 2022 16:43:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id y13-20020a05620a25cd00b006bbf85cad0fsm8537748qko.20.2022.10.20.16.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 16:42:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1olfBj-00B3Bu-0U;
        Thu, 20 Oct 2022 20:42:59 -0300
Date:   Thu, 20 Oct 2022 20:42:58 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
        "gilad@benyossef.com" <gilad@benyossef.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
        "david@sigma-star.at" <david@sigma-star.at>,
        "michael@walle.cc" <michael@walle.cc>,
        "john.ernberg@actia.se" <john.ernberg@actia.se>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "j.luebbe@pengutronix.de" <j.luebbe@pengutronix.de>,
        "richard@nod.at" <richard@nod.at>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Sahil Malhotra <sahil.malhotra@nxp.com>,
        Kshitiz Varshney <kshitiz.varshney@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>
Subject: Re: [EXT] Re: [PATCH v0 3/8] crypto: hbk flags & info added to the
 tfm
Message-ID: <Y1HdAmy6ZfN8f5hJ@ziepe.ca>
References: <Yz/OEwDtyTm+VH0p@gondor.apana.org.au>
 <DU2PR04MB8630CBBB8ABDC3768320C18195209@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <Y0Q3JKnWSNIC4Xlu@zx2c4.com>
 <Y0UxY51KQoKCq59o@gondor.apana.org.au>
 <Y0XLqd/+C1sxq2G0@zx2c4.com>
 <Y0aDiLp7BztzwNez@gondor.apana.org.au>
 <Y0m2TU5k78I1AR+p@ziepe.ca>
 <Y1DN3SqEyFZd9i37@sol.localdomain>
 <Y1GgSX+ZmOsxhB2N@ziepe.ca>
 <Y1G9hKPT1MNQQxcG@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1G9hKPT1MNQQxcG@sol.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 20, 2022 at 02:28:36PM -0700, Eric Biggers wrote:
> On Thu, Oct 20, 2022 at 04:23:53PM -0300, Jason Gunthorpe wrote:
> > On Wed, Oct 19, 2022 at 09:26:05PM -0700, Eric Biggers wrote:
> > 
> > > Are you referring to the support for hardware-wrapped inline crypto keys?  It
> > > isn't upstream yet, but my latest patchset is at
> > > https://lore.kernel.org/linux-fscrypt/20220927014718.125308-2-ebiggers@kernel.org/T/#u.
> > > There's also a version of it used by some Android devices already.  Out of
> > > curiosity, are you using it in an Android device, or have you adopted it in some
> > > other downstream?
> > 
> > Unrelated to Android, similar functionality, but slightly different
> > ultimate purpose. We are going to be sending a fscrypt patch series
> > for mlx5 and nvme soonish.
> 
> That's interesting, though also slightly scary in that it sounds like you've
> already shipped some major fscrypt changes without review!

Heh, says the Android guy :)

Fortunately nothing major, we are enterprise focused, we need stuff in
real distros - we know know how to do it.

> > That sounds disappointing that we are now having parallel ways for the
> > admin to manipulate kernel owned keys.
> 
> Well, the keyrings subsystem never worked properly for fscrypt anyway.  At most,
> it's only useful for providing the key to the filesystem initially (by passing a
> key ID to FS_IOC_ADD_ENCRYPTION_KEY, instead of the key bytes), similar to what
> dm-crypt allows.  After that, the keyrings subsystem plays no role.

Sure, but loading the key into the keyring should allow many different
options, including things like TPM PCR secured keys (eg like
bitlocker) - we shouldn't allow user space the ability to see the key
data at all.

Duplicating this in every subsystem makes no sense, there is a
reasonable role for the keyring to play in solving these kinds of
problems for everything.

Jason
