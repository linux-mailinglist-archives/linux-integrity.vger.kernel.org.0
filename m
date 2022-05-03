Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5CB518C4C
	for <lists+linux-integrity@lfdr.de>; Tue,  3 May 2022 20:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241255AbiECS2m (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 May 2022 14:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbiECS2l (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 May 2022 14:28:41 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEC13F309;
        Tue,  3 May 2022 11:25:08 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 5287822248;
        Tue,  3 May 2022 20:25:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1651602306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9iC4cXPg9k+4gpVj29AuB8WPa1LP5MNPiMZNf/cbI60=;
        b=RkDedRUtGXV+rYDTtGD6Re5PzUJOBv4t7jgDYB3cDSNZ0v6oz4lwCp7IpoCeuwt+18s9MY
        PbLjrkr/lyl3evJtuCAESVCKxhGl+o8DYxappQloW/rX9+eHSPUo4f4RxMt8f654gPLeY4
        cWqIHbGZ4YO/qwb3alIBVDznZsUDoxo=
From:   Michael Walle <michael@walle.cc>
To:     a.fatoum@pengutronix.de
Cc:     davem@davemloft.net, david@sigma-star.at, dhowells@redhat.com,
        ebiggers@kernel.org, franck.lenormand@nxp.com,
        herbert@gondor.apana.org.au, horia.geanta@nxp.com,
        j.luebbe@pengutronix.de, jarkko@kernel.org, jejb@linux.ibm.com,
        jmorris@namei.org, kernel@pengutronix.de, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        matthias.schiffer@ew.tq-group.com, pankaj.gupta@nxp.com,
        richard@nod.at, serge@hallyn.com, sumit.garg@linaro.org,
        tharvey@gateworks.com, zohar@linux.ibm.com,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v8 3/6] crypto: caam - add in-kernel interface for blob generator
Date:   Tue,  3 May 2022 20:24:54 +0200
Message-Id: <20220503182454.2749454-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220428140145.870527-4-a.fatoum@pengutronix.de>
References: <20220428140145.870527-4-a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

> The NXP Cryptographic Acceleration and Assurance Module (CAAM)
> can be used to protect user-defined data across system reboot:
> 
>   - When the system is fused and boots into secure state, the master
>     key is a unique never-disclosed device-specific key
>   - random key is encrypted by key derived from master key
>   - data is encrypted using the random key
>   - encrypted data and its encrypted random key are stored alongside
>   - This blob can now be safely stored in non-volatile memory
> 
> On next power-on:
>   - blob is loaded into CAAM
>   - CAAM writes decrypted data either into memory or key register
> 
> Add functions to realize encrypting and decrypting into memory alongside
> the CAAM driver.
> 
> They will be used in a later commit as a source for the trusted key
> seal/unseal mechanism.

Thanks for the work on this and I'm excited to try this. I'm currently
playing with this and one thing I've noticed is that an export restricted
CAAM isn't handled properly.

That is, there are CAAM's which aren't fully featured. Normally, the
caam driver will take care of it. For example, see commit f20311cc9c58
("crypto: caam - disable pkc for non-E SoCs"). For the trusted keys case,
it would be nice if the kernel will not even probe (or similar).

Right now, everything seems to work fine, but once I try to add a new key,
I'll get the following errros:

# keyctl add trusted mykey "new 32" @u
add_key: Invalid argument
[   23.138714] caam_jr 8020000.jr: 20000b0f: CCB: desc idx 11: : Invalid CHA selected.
[   23.138740] trusted_key: key_seal failed (-22)

Again this is expected, because I run it on a non-E version. IMHO, it
should be that the trusted keys shouldn't be enabled at all. Like it is
for example if an unknown rng is given:

  trusted_key: Unsupported RNG. Supported: kernel, default

Thanks,
-michael
