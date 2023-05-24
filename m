Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1704970EF64
	for <lists+linux-integrity@lfdr.de>; Wed, 24 May 2023 09:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236332AbjEXH3k (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 May 2023 03:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239561AbjEXH3j (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 May 2023 03:29:39 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3E7A1;
        Wed, 24 May 2023 00:29:33 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 9C6F230025BE0;
        Wed, 24 May 2023 09:29:31 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 8DF7A31373E; Wed, 24 May 2023 09:29:31 +0200 (CEST)
Date:   Wed, 24 May 2023 09:29:31 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, peterhuewe@gmx.de,
        jgg@ziepe.ca, jsnitsel@redhat.com, hdegoede@redhat.com,
        oe-lkp@lists.linux.dev, lkp@intel.com,
        peter.ujfalusi@linux.intel.com, peterz@infradead.org,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        p.rosenberger@kunbus.com
Subject: Re: [PATCH 1/2] tpm, tpm_tis: Handle interrupt storm
Message-ID: <20230524072931.GA31483@wunner.de>
References: <20230522143105.8617-1-LinoSanfilippo@gmx.de>
 <CSU7G2UZSZ8K.22EGXU5CJTZBB@suppilovahvero>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CSU7G2UZSZ8K.22EGXU5CJTZBB@suppilovahvero>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, May 24, 2023 at 06:58:08AM +0300, Jarkko Sakkinen wrote:
> On Mon May 22, 2023 at 5:31 PM EEST, Lino Sanfilippo wrote:
> > +	/*
> > +	 * The worker to free the TPM interrupt (free_irq_work) may already
> > +	 * be scheduled, so make sure it is not scheduled again.
> > +	 */
> > +	if (!(chip->flags & TPM_CHIP_FLAG_IRQ))
> > +		return;
> > +
> > +	if (time_after(jiffies, priv->last_unhandled_irq + HZ/10))
> > +		priv->unhandled_irqs = 1;
> > +	else
> > +		priv->unhandled_irqs++;
> > +
> > +	priv->last_unhandled_irq = jiffies;
> > +
> > +	if (priv->unhandled_irqs > MAX_UNHANDLED_IRQS)
> > +		tpm_tis_handle_irq_storm(chip);
> 
> Why wouldn't we switch to polling mode even when there is a single
> unhandled IRQ?

An unhandled IRQ can be legitimate if the interrupt is shared
with other devices and the IRQ was raised by one of them.

So you only want to switch to polling if there's a significant
amount of unhandled IRQs in a short period of time.

Thanks,

Lukas
