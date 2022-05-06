Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90ED651D5FD
	for <lists+linux-integrity@lfdr.de>; Fri,  6 May 2022 12:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238562AbiEFK4F (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 May 2022 06:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiEFK4E (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 May 2022 06:56:04 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CF65C362;
        Fri,  6 May 2022 03:52:19 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id EE63522246;
        Fri,  6 May 2022 12:52:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1651834336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hBTLRDXX7HYWGSCeHSGr2YftxW57WhXM3Qvb9yVkUQk=;
        b=hAWKHoWNoWZfeKBbrvLwwZUOCIaV0Huaxz+PHJqpLVZdnH/5+RDd/z4htrynCe85SCOmNw
        Jgv/BprTb1DY6+XBz0tjeqOTmMSU13D8llXKPYwvLrHE98OCaqSFNuaY24kEjvMFVy68h1
        NH7Id3QryZVY5LUiKPbvxjEB004JDC4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 06 May 2022 12:52:13 +0200
From:   Michael Walle <michael@walle.cc>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        James Bottomley <jejb@linux.ibm.com>, kernel@pengutronix.de,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Eric Biggers <ebiggers@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Andreas Rammhold <andreas@rammhold.de>,
        Tim Harvey <tharvey@gateworks.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v9 0/7] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
In-Reply-To: <20220506062553.1068296-1-a.fatoum@pengutronix.de>
References: <20220506062553.1068296-1-a.fatoum@pengutronix.de>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <49e1738c55c73819ee0e2cac0be74d81@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Am 2022-05-06 08:25, schrieb Ahmad Fatoum:
> Series applies on top of v5.18-rc5. Would be great if this could make 
> it
> into v5.19.
> 
> v8 was here:
> https://lore.kernel.org/linux-integrity/09e2552c-7392-e1da-926b-53c7db0b118d@pengutronix.de
> 
> Changelog is beneath each individual patch. Compared to v8, only code
> change is checking whether CAAM can support blobbing at init-time as
> apparently some Layerscape SoCs are available in a non-E(ncryption)
> variant that doesn't do AES. Previously, adding trusted keys on such
> SoCs would return an error with a cryptic error message.
> 
> 
> The Cryptographic Acceleration and Assurance Module (CAAM) is an IP 
> core
> built into many newer i.MX and QorIQ SoCs by NXP.
> 
> Its blob mechanism can AES encrypt/decrypt user data using a unique
> never-disclosed device-specific key.
> 
> There has been multiple discussions on how to represent this within the 
> kernel:
> 
> The Cryptographic Acceleration and Assurance Module (CAAM) is an IP 
> core
> built into many newer i.MX and QorIQ SoCs by NXP.
> 
> Its blob mechanism can AES encrypt/decrypt user data using a unique
> never-disclosed device-specific key. There has been multiple
> discussions on how to represent this within the kernel:
> 
>  - [RFC] crypto: caam - add red blobifier
>    Steffen implemented[1] a PoC sysfs driver to start a discussion on 
> how to
>    best integrate the blob mechanism.
>    Mimi suggested that it could be used to implement trusted keys.
>    Trusted keys back then were a TPM-only feature.
> 
>  - security/keys/secure_key: Adds the secure key support based on CAAM.
>    Udit Agarwal added[2] a new "secure" key type with the CAAM as 
> backend.
>    The key material stays within the kernel only.
>    Mimi and James agreed that this needs a generic interface, not 
> specific
>    to CAAM. Mimi suggested trusted keys. Jan noted that this could 
> serve as
>    basis for TEE-backed keys.
> 
>  - [RFC] drivers: crypto: caam: key: Add caam_tk key type
>    Franck added[3] a new "caam_tk" key type based on Udit's work. This 
> time
>    it uses CAAM "black blobs" instead of "red blobs", so key material 
> stays
>    within the CAAM and isn't exposed to kernel in plaintext.
>    James voiced the opinion that there should be just one user-facing 
> generic
>    wrap/unwrap key type with multiple possible handlers.
>    David suggested trusted keys.
> 
>  - Introduce TEE based Trusted Keys support
>    Sumit reworked[4] trusted keys to support multiple possible backends 
> with
>    one chosen at boot time and added a new TEE backend along with TPM.
>    This now sits in Jarkko's master branch to be sent out for v5.13
> 
> This patch series builds on top of Sumit's rework to have the CAAM as
> yet another
> trusted key backend.
> 
> The CAAM bits are based on Steffen's initial patch from 2015. His work 
> had been
> used in the field for some years now, so I preferred not to deviate
> too much from it.
> 
> This series has been tested with dmcrypt[5] on an i.MX6Q/DL and an 
> i.MX8M[6].
> 
> Looking forward to your feedback.

For the whole series:

Tested-by: Michael Walle <michael@walle.cc> # on ls1028a (non-E and E)

-michael
