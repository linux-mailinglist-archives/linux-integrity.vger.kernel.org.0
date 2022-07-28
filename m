Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E8F583A23
	for <lists+linux-integrity@lfdr.de>; Thu, 28 Jul 2022 10:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbiG1IP5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 28 Jul 2022 04:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbiG1IP4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Jul 2022 04:15:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459F3CE01;
        Thu, 28 Jul 2022 01:15:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9CA961BA0;
        Thu, 28 Jul 2022 08:15:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1410C433D6;
        Thu, 28 Jul 2022 08:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658996155;
        bh=/m2yuIjtmhX7sFDuqcZZi68Qe5oW8kgCP6tQn5ihcTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l8z0fA4d3WL4ubdKlk1TEtv4uuRaGIdw+/nCBM5JFlX8Ev8QIzGaTJG7tmRZbmlJV
         kreAeNNOwZE4BvzB4yD/AYYAUMYEDqZbeJgR6CPy5CDSelNxDu0GfK6ZkFpxWux6Oa
         cnNOU2gY4f8kNAyn0ugAdQ6wWHqt9w+Z0Y7PHsRZzoRZbi1tNLHJGmh7yGDvR/eXDf
         x79f+UeTVlR9Zohn1XCHsjVFIdAg8d13MTqo4N+Xq6bDncF6iDgVrBJ9UHox8bpLGm
         WRHVN6DWXztRQsnNx7kFki8BJcK+7mMrarnPvkWJD0JGilxoZXuQMRDfD6fIeEHrAP
         NSTq889MeP24Q==
Date:   Thu, 28 Jul 2022 11:15:52 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com
Subject: Re: [PATCH v7 07/10] tmp, tmp_tis: Implement usage counter for
 locality
Message-ID: <YuJFuBFtImG/k+C0@kernel.org>
References: <20220629232653.1306735-1-LinoSanfilippo@gmx.de>
 <20220629232653.1306735-8-LinoSanfilippo@gmx.de>
 <Yr4x6KRSvzlXNdH2@kernel.org>
 <f0e33bc4-335c-322a-9295-18d6bc0b8286@gmx.de>
 <YsuQEoVuVa00gIdE@kernel.org>
 <744ad6e1-c4ad-1e6d-f94d-98aa5b105dc6@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <744ad6e1-c4ad-1e6d-f94d-98aa5b105dc6@gmx.de>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jul 27, 2022 at 02:16:56PM +0200, Lino Sanfilippo wrote:
> 
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
> > be taken in every transmit flow. It makes the whole thing easier
> > to maintain over time, and does not really affect scalability.
> >
> 
> This means switching to a complete new locking scheme which affects many
> parts of the TIS core code. It is also not directly related to what this patch series
> is about, namely activating the interrupts for TPM TIS.
> 
> I suggest to first finish polishing this series especially since there have
> only been minor issues in the last versions. Once the interrupts work we
> still can think of implementing another lock handling in a follow up series.

So what if you would use kref instead here?

On surface this looks like ad-hoc kref but I could wrong too (as always).

BR, Jarkko
