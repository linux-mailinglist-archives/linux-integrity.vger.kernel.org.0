Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B865762EA
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Jul 2022 15:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiGONmF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 Jul 2022 09:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiGONmC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Jul 2022 09:42:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8567D790;
        Fri, 15 Jul 2022 06:42:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B841B82C21;
        Fri, 15 Jul 2022 13:42:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE3CC34115;
        Fri, 15 Jul 2022 13:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657892518;
        bh=bvF412/wms+G0kGt+VJteVVIxq+y+w0jFmoqv99im8s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rNBj8Wa/P6Inai/pOpqwqq1DbgHml5s0pia6Len43m6kbbUpbSVaIKpq5z6kACtfp
         C/yEixZFHgpOgXU6mrdPfHHz73s+pNJ2P2Ka7wo4qKS0hh2IYprBTb+VOqn+JLNTPk
         e4piHjwQSusLiqQG7tIFVBZEVxOCekvc+8B+S0xmtLI0hPa0ZoHHhsaIuPeWX637cg
         VSPlcAbI2Dt8JaMIYh54HeWkMitH2JjDSDYhtfaZYfDrBYHxtZFdmSjqZ7bpQblR56
         douwa0eFCPXeLZwfsEHn2JRdorz6iMHah5fnPVXiw5j/HYGpnVm/YR0FQe9mjlkkY3
         heSXTEthvVuRg==
Date:   Fri, 15 Jul 2022 16:41:54 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com
Subject: Re: [PATCH v7 07/10] tmp, tmp_tis: Implement usage counter for
 locality
Message-ID: <YtFuov88jumGF12J@kernel.org>
References: <20220629232653.1306735-1-LinoSanfilippo@gmx.de>
 <20220629232653.1306735-8-LinoSanfilippo@gmx.de>
 <Yr4x6KRSvzlXNdH2@kernel.org>
 <f0e33bc4-335c-322a-9295-18d6bc0b8286@gmx.de>
 <YsuQEoVuVa00gIdE@kernel.org>
 <62cec6b9-396b-83d0-b10f-78b0bb61e317@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62cec6b9-396b-83d0-b10f-78b0bb61e317@gmx.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jul 11, 2022 at 11:03:05PM +0200, Lino Sanfilippo wrote:
> 
> On 11.07.22 04:50, Jarkko Sakkinen wrote:
> > On Mon, Jul 04, 2022 at 07:45:12PM +0200, Lino Sanfilippo wrote:
> >>
> >>
> >> On 01.07.22 01:29, Jarkko Sakkinen wrote:
> >>
> >>>
> >>> I'm kind of thinking that should tpm_tis_data have a lock for its
> >>> contents?
> >>
> >> Most of the tpm_tis_data structure elements are set once during init and
> >> then never changed but only read. So no need for locking for these. The
> >> exceptions I see are
> >>
> >> - flags
> >> - locality_count
> >> - locality
> >
> > I'd still go for single data struct lock, since this lock would
> > be taken in every transmit flow.
> 
> Well in both cases, transmit and receive, we end up in wait_for_tmp_stat().
> Whatever lock we hold at this time cannot be taken in the interrupt
> handler, since this would deadlock (wait_for_tmp_stat() waits for the interrupt
> handler to complete but holds the lock that the interrupt handler needs to proceed).
> 
> So in the interrupt handler we need something that is not held during the whole
> transmit/receive flow.
> 
> This is the reason why the locality_count_mutex only protects the one thing we
> have to take care of in the interrupt handler, namely the locality counter.
> 
> 
> > It makes the whole thing easier
> > to maintain over time, and does not really affect scalability>
> > This brings me to another question: what does this lock protect
> > against given that tpm_try_get_ops() already takes tpm_mutex?
> > It's not clear and that should be somehow reasoned in the commit
> > message.
> 
> See above, we cannot take the tpm mutex in the interrupt handler for the same
> reason.

You should squash this then with the following patch.

Also, I'm not sure why you don't use kref for this.

> > Anyway, *if* a lock is needed the granularity should be the whole
> > struct.
> >
> > BR, Jarkko
> 
> Regards,
> Lino

BR, Jarkko
