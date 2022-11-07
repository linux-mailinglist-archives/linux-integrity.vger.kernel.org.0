Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4832061F835
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Nov 2022 17:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbiKGQD6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Nov 2022 11:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiKGQD6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Nov 2022 11:03:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C360615835;
        Mon,  7 Nov 2022 08:03:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71C8EB812A9;
        Mon,  7 Nov 2022 16:03:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF97C433C1;
        Mon,  7 Nov 2022 16:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667837034;
        bh=fnARxNME0jc0CG8gY/lQUOV+hnDddKhjUOpquhiJfs4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GTZQFfC2yBDSUCS8d8l6I/gIHuimrmEU9GzWbUpFZlATEYH/nDBivkuLQ4CU7+Ix3
         X7WNazOkCpLo18TZVsZ2KdXYjKwKmCYpAMButSKP+I/m0ZCXPBhKxxy//l3zNRjPiC
         XbaFtKIT9NsT+LWGZrq7pMyi0AA/nHy9Gr+snJea+CZ3nanSjjC206AkZTgHFwfets
         Bf7R7vt3akUygJJnB2KfRBnb1yrtpnXMDgBY40PKo9EdN3JiRvjmv0jP7jKml8+kwJ
         s824U78Xk+pe8SAn/8gJv0QKZCgT0f7O5sK0OTrE/w/qcMhE33JwkdATEa7i5/l+mc
         J/3l+oiP9jhaQ==
Date:   Mon, 7 Nov 2022 18:03:49 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, peterhuewe@gmx.de,
        jgg@ziepe.ca, stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jandryuk@gmail.com, pmenzel@molgen.mpg.de, lukas@wunner.de,
        p.rosenberger@kunbus.com
Subject: Re: [PATCH v8 08/11] tpm, tpm: Implement usage counter for locality
Message-ID: <Y2ksZXP1dunRyul8@kernel.org>
References: <20221017235732.10145-1-LinoSanfilippo@gmx.de>
 <20221017235732.10145-9-LinoSanfilippo@gmx.de>
 <Y1TFzO1CBY8d4rfa@kernel.org>
 <fcf53b02-a505-46ac-006e-0e317f00bbe3@gmx.de>
 <Y2Bw/yhTs258Iiew@kernel.org>
 <57b193a6-8340-c883-04bc-6cfbc3c638cd@kunbus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57b193a6-8340-c883-04bc-6cfbc3c638cd@kunbus.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Nov 04, 2022 at 05:18:21PM +0100, Lino Sanfilippo wrote:
> 
> 
> On 01.11.22 02:06, Jarkko Sakkinen wrote:
> > On Tue, Oct 25, 2022 at 02:15:51AM +0200, Lino Sanfilippo wrote:
> 
> >> Actually thats on me, since it took me much too long to send the v8 after the v7 review.
> >>
> >> However the reason that we need a mutex here is that we not only increase or decrease
> >> the locality_counter under the mutex, but also do the locality request and release by
> >> writing to the ACCESS register. Since in the SPI case each communication over the spi bus
> >> is protected by the bus_lock_mutex of the SPI device we must not hold a spinlock when doing
> >> the register accesses.
> >>
> >> Concerning covering the whole tpm_tis_data struct:
> >> Most structure elements are set once at driver startup but never changed at driver
> >> runtime. So no locking needed for these. The only exception is "flags" and "locality_count"
> >> whereby "flags" is accessed by atomic bit manipulating functions and thus
> >> does not need extra locking. So "locality_count" is AFAICS the only element that needs to be
> >> protected by the mutex.
> > 
> > OK, but you should should still address this in commit message, e.g.
> > by mentioning that in the case of SPI bus mutex is required because
> > the bus itself needs to be locked in the mutex.
> > 
> > I.e. this a claim, definitely not an argument: "Ensure thread-safety by
> > protecting the counter with a mutex."
> > 
> 
> Ok, I will rephrase the commit message accordingly. 
> Thanks for the review!

Yeah, np. I.e. I understand your reasoning but it is easy to intuitively
think it as not the right solution. Thus, it deserves a remark, right?
:-)

BR, Jarkko
