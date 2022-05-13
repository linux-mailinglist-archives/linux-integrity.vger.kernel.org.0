Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8631F5268F9
	for <lists+linux-integrity@lfdr.de>; Fri, 13 May 2022 20:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347598AbiEMSKY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 May 2022 14:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244159AbiEMSKX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 May 2022 14:10:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B325253D;
        Fri, 13 May 2022 11:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DB17B83029;
        Fri, 13 May 2022 18:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4F1C34100;
        Fri, 13 May 2022 18:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652465418;
        bh=QVFRHciwVHsT/StrKZNZPPyBLNp0Pv3TiO/oD8UrSLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O3D+iKn1wRG3Mgt93Dx8a0sfe8hCyc4kqJHi25y9xPg88/MH4jTk1xPdjsZywacre
         ly7tUzk0m7KNEpK9Fu460QX4M6OoSKHbnQw1zz1dAl6lhmdGzSgmzQOYpy2L5kczqp
         akHofx0s9JBZs/rJkPGqlz9MRNFezD2tRvxj5z1cemyP/y2ytFsdrRHrrl4ZoaACia
         9l0jCg8Rjjego6i1/espF8Dy4n4pnw9GqpAuSPtQ2pxt8A732G7c/AXVJt+qMyQwDg
         vBtDNXLwwkpQKIER6eqFbfSJam6qdBCM43entSW918d5wJ1LlfQIgWuz6MiUMdcddk
         G9pzrRPVEaMDg==
Date:   Fri, 13 May 2022 21:08:48 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de,
        p.rosenberger@kunbus.com, Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH v4 1/6] tpm, tpm_tis_spi: Request threaded irq
Message-ID: <Yn6esMyUl+QhECq+@kernel.org>
References: <20220509080559.4381-1-LinoSanfilippo@gmx.de>
 <20220509080559.4381-2-LinoSanfilippo@gmx.de>
 <YnucgDH3I87RI8PN@kernel.org>
 <486cec01-ec02-3f11-0b81-037e0700c503@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <486cec01-ec02-3f11-0b81-037e0700c503@gmx.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, May 11, 2022 at 09:18:39PM +0200, Lino Sanfilippo wrote:
> Hi,
> 
> On 11.05.22 at 13:22, Jarkko Sakkinen wrote:
> > On Mon, May 09, 2022 at 10:05:54AM +0200, Lino Sanfilippo wrote:
> >> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> >>
> >> Interrupt handling at least includes reading and writing the interrupt
> >> status register within the interrupt routine. Since accesses over the SPI
> >> bus are synchronized by a mutex, request a threaded interrupt handler to
> >> ensure a sleepable context during interrupt processing.
> >>
> >> Fixes: 1a339b658d9d ("tpm_tis_spi: Pass the SPI IRQ down to the driver")
> >> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> >
> > When you state that it needs a sleepable context, you should bring a
> > context why it needs it. This not to disregard the code change overally but
> > you cannot make even the most obvious claim without backing data.
> >
> 
> so what kind of backing data do you have in mind? Would it help to emphasize more
> that the irq handler is running in hard irq context in the current code and thus
> must not access registers over SPI since SPI uses a mutex (I consider it as basic
> knowledge that a mutex must not be taken in hard irq context)?

There's zero mention about specific lock you are talking about. Providing
the basic knowledge what you are trying to do is the whole point of the
commit message in the first place. I'd presume this patch is related to the
use bus_lock_mutex but it is fully ingored here.

BR, Jarkko
