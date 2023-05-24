Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB5A70FA1D
	for <lists+linux-integrity@lfdr.de>; Wed, 24 May 2023 17:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbjEXPaf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 May 2023 11:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjEXPae (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 May 2023 11:30:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0870F5;
        Wed, 24 May 2023 08:30:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D6B763385;
        Wed, 24 May 2023 15:30:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A74C433D2;
        Wed, 24 May 2023 15:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684942232;
        bh=apv7fp2JStfK/1O9ZPoYlUJJmLzvR6yZ/dFs2Sq5Cl8=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=bKSS11QXhFSdLKI+N5lXBXvtHnz5/ib84JrDNKJoClE//sLm1NMoXl9VeucC2+OAX
         2kVfV8zfWHHSlkz4qvziDZfUkYJqEVrA7Gr5AXz61O56wvgepoA+ban1Du68+koiae
         wF4C0/UTAuxlnKVwSZ5l77Y7T8lu6uQir1aMtRy592pW8k9NsbFljp7/52ZXedO+F2
         IV0aBm4u1muOXGf+D27FD1n2USc7u4pkr6whlm4SgmlG4SpshaiwSf5dIBxNaRBNhy
         fvj7vB9OpEuybJ9J+FnkoKBDITr0CavIEXUVDYEMFa+O96GB7LaXiI2dVNxfOJr+Ai
         9STys3pU031dw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 24 May 2023 18:30:27 +0300
Message-Id: <CSUM65JDEX5D.8GL20PUI2XDV@suppilovahvero>
Cc:     <jsnitsel@redhat.com>, <hdegoede@redhat.com>,
        <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <peter.ujfalusi@linux.intel.com>, <peterz@infradead.org>,
        <linux@mniewoehner.de>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <l.sanfilippo@kunbus.com>,
        <lukas@wunner.de>, <p.rosenberger@kunbus.com>
Subject: Re: [PATCH 1/2] tpm, tpm_tis: Handle interrupt storm
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jarkko Sakkinen" <jarkko@kernel.org>,
        "Lino Sanfilippo" <LinoSanfilippo@gmx.de>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>
X-Mailer: aerc 0.14.0
References: <20230522143105.8617-1-LinoSanfilippo@gmx.de>
 <CSU7G2UZSZ8K.22EGXU5CJTZBB@suppilovahvero>
In-Reply-To: <CSU7G2UZSZ8K.22EGXU5CJTZBB@suppilovahvero>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed May 24, 2023 at 6:58 AM EEST, Jarkko Sakkinen wrote:
> >  	rc =3D tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &interrup=
t);
> >  	if (rc < 0)
> > -		return IRQ_NONE;
> > +		goto unhandled;
> > =20
> >  	if (interrupt =3D=3D 0)
> > -		return IRQ_NONE;
> > +		goto unhandled;
> > =20
> >  	set_bit(TPM_TIS_IRQ_TESTED, &priv->flags);
> >  	if (interrupt & TPM_INTF_DATA_AVAIL_INT)
> > @@ -780,10 +829,14 @@ static irqreturn_t tis_int_handler(int dummy, voi=
d *dev_id)
> >  	rc =3D tpm_tis_write32(priv, TPM_INT_STATUS(priv->locality), interrup=
t);
> >  	tpm_tis_relinquish_locality(chip, 0);
> >  	if (rc < 0)
> > -		return IRQ_NONE;
> > +		goto unhandled;
> > =20
> >  	tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &interrupt);
> >  	return IRQ_HANDLED;
> > +
> > +unhandled:
> > +	tpm_tis_process_unhandled_interrupt(chip);
> > +	return IRQ_HANDLED;
> >  }

Some minor glitches I noticed.

You could simplify the flow by making the helper to return IRQ_NONE.

E.g.=20

	tpm_tis_relinquish_locality(chip, 0);
	if (rc < 0)
		return tpm_tis_process_unhandled_interrupt(chip);

I'd recommend changing the function name simply tpm_tis_rollback_interrupt(=
).

Also tpm_tis_handle_irq_storm() is a pretty bad function name=20
because handle also can mean anything. You are resetting to the
polling mode, right?

So perhaps that could be e.g. tpm_tis_reenable_polling? I'm open
for any other name but it really needs to give a hint what the
function does.

BR, Jarkko
