Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722D2639BC2
	for <lists+linux-integrity@lfdr.de>; Sun, 27 Nov 2022 17:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiK0Qdt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 27 Nov 2022 11:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiK0Qds (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 27 Nov 2022 11:33:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEDF115E;
        Sun, 27 Nov 2022 08:33:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83523B80AFD;
        Sun, 27 Nov 2022 16:33:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8273C433D6;
        Sun, 27 Nov 2022 16:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669566825;
        bh=O1C8cypGcMBwJKOESk6VxY/nmfSMo8T0mND3k3/mp5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KrQXtGKOuCSQwoUxLn1hmE+D7u/ZHAllH4T3+MrdsNCGImgRixFMzSEvLEfFeaM24
         eV7Xcsb30Q7Uc0zPTTYm+lOCmDA8Mp/XAWU3FUxelu3ZDsDqbrZQl4glm+17SDPM7Q
         +y2Wlc7Nv/LcR/GMUukZphSxBa3fdGjVvrA70yjUbwXgzC5Lyx8s3LKyXiAmHURxBr
         q+axbaEwG7u78j/NZmCPI/RsYScNVYWSjM9m3M65gVon68HyT++SxgZnT5767CeALT
         YAjkBzYK0V2mmIuO+5IG9eR9G3zti3BuuxJya/v9Jh3XnGe1W/3ANyygmFGUgxA+96
         Ldsxp77QHkmog==
Date:   Sun, 27 Nov 2022 18:33:41 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     Evan Green <evgreen@chromium.org>, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux-integrity@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>, gwendal@chromium.org,
        dianders@chromium.org, apronin@chromium.org,
        Pavel Machek <pavel@ucw.cz>, Ben Boeckel <me@benboeckel.net>,
        rjw@rjwysocki.net, Kees Cook <keescook@chromium.org>,
        dlunev@google.com, zohar@linux.ibm.com,
        Matthew Garrett <mgarrett@aurora.tech>,
        linux-pm@vger.kernel.org, Matthew Garrett <mjg59@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v5 03/11] tpm: Allow PCR 23 to be restricted to
 kernel-only use
Message-ID: <Y4ORZT2t/KhL5jfn@kernel.org>
References: <20221111231636.3748636-1-evgreen@chromium.org>
 <20221111151451.v5.3.I9ded8c8caad27403e9284dfc78ad6cbd845bc98d@changeid>
 <8ae56656a461d7b957b93778d716c6161070383a.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ae56656a461d7b957b93778d716c6161070383a.camel@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Nov 14, 2022 at 12:11:20PM -0500, James Bottomley wrote:
> On Fri, 2022-11-11 at 15:16 -0800, Evan Green wrote:
> > Introduce a new Kconfig, TCG_TPM_RESTRICT_PCR, which if enabled
> > restricts usermode's ability to extend or reset PCR 23.
> 
> Could I re ask the question here that I asked of Matthew's patch set:
> 
> https://lore.kernel.org/all/b0c4980c8fad14115daa3040979c52f07f7fbe2c.camel@linux.ibm.com/
> 
> Which was could we use an NVRAM index in the TPM instead of a PCR?  The
> reason for asking was that PCRs are rather precious and might get more
> so now that Lennart has some grand scheme for using more of them in his
> unified boot project.  Matthew promised to play with the idea but never
> got back to the patch set to say whether he investigated this or not.

Even for PCR case it would be better to have it configurable through
kernel command-line, including a disabled state, which would the
default.

This would be backwards compatible, and if designed properly, could
more easily extended for NV index later on.

BR, Jarkko
