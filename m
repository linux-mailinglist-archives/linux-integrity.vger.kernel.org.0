Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A27D586ED8
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Aug 2022 18:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbiHAQmv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Aug 2022 12:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbiHAQmu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Aug 2022 12:42:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D985B90;
        Mon,  1 Aug 2022 09:42:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C02660F6E;
        Mon,  1 Aug 2022 16:42:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988D3C433D6;
        Mon,  1 Aug 2022 16:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659372169;
        bh=DQ4noSUQRPScorU8fDb3IKwYMG7ZdcugAbAWD3extDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ic5eUIVwgaLfNSKjaUBrgSbP0o312UCTFo6eVANI5XwPJJMXOUNSLsBczeuVR/JJo
         16VDwx5WiBl4Akcn//oRARv6kF7dpZBgQpnhjn+6uogmg7h6YtV4B9bFVsqB4XMYc3
         we+mT0s7PPnvjhAUljRlA09F/S9cz1qMRcL4rtP4cyYIRsoyb4zBGoHvfP1ncAOnU3
         hUcFMJveamEKiGbfoRIA64HlFKlQTjEBiSS+sWisvPALVq2NdvRbxqI4GrcxYyvUg5
         YYAvsOZBccHe0imctXLxY8FuktcEbq0mlvqvQnX30F6BJYHSqA6DAuUGenmR5mFGeG
         UiwgfE40BdUnA==
Date:   Mon, 1 Aug 2022 19:42:43 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, peterhuewe@gmx.de,
        jgg@ziepe.ca, stefanb@linux.vnet.ibm.com, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com
Subject: Re: [PATCH v7 07/10] tmp, tmp_tis: Implement usage counter for
 locality
Message-ID: <YugCg5s8I5GIRWls@kernel.org>
References: <20220629232653.1306735-1-LinoSanfilippo@gmx.de>
 <20220629232653.1306735-8-LinoSanfilippo@gmx.de>
 <Yr4x6KRSvzlXNdH2@kernel.org>
 <f0e33bc4-335c-322a-9295-18d6bc0b8286@gmx.de>
 <570976c3-8292-092d-5e0c-25eef63f7f3c@kunbus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <570976c3-8292-092d-5e0c-25eef63f7f3c@kunbus.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jul 28, 2022 at 07:36:19PM +0200, Lino Sanfilippo wrote:
> 
> 
> On 04.07.22 19:45, Lino Sanfilippo wrote:
> > 
> > 
> > On 01.07.22 01:29, Jarkko Sakkinen wrote:
> > 
> >>
> >> I'm kind of thinking that should tpm_tis_data have a lock for its
> >> contents?
> > 
> > Most of the tpm_tis_data structure elements are set once during init and
> > then never changed but only read. So no need for locking for these. The
> > exceptions I see are
> > 
> > - flags
> > - locality_count
> > - locality
> > 
> > 
> > whereby "flags" is accessed by atomic bit manipulating functions and thus
> > does not need extra locking. "locality_count" is protected by the locality_count_mutex.
> > "locality" is only set in check_locality() which is called from tpm_tis_request_locality_locked()
> > which holds the locality_count_mutex. So check_locality() is also protected by the locality_count_mutex
> > (which for this reason should probably rather be called locality_mutex since it protects both the "locality_count"
> > and the "locality" variable).
> > 
> > There is one other place check_locality() is called from, namely the interrupt handler. This is also the only
> > place in which "locality" could be assigned another value than 0 (aka the default). In this case there
> > is no lock, so this could indeed by racy.
> > 
> > The solution I see for this is:
> > 1. remove the entire loop that checks for the current locality, i.e. this code:
> > 
> > 	if (interrupt & TPM_INTF_LOCALITY_CHANGE_INT)
> > 		for (i = 0; i < 5; i++)
> > 			if (check_locality(chip, i))
> > 				break;
> > 
> > So we avoid "locality" from being changed to something that is not the default.
> > 
> > 
> 
> I wonder if we need tpm_tis_data->locality at all: the claimed locality is already tracked in
> chip->locality and in TPM TIS we never use anything else than locality 0 so it never changes.
> 
> Is there any good reason not to remove it?

I think it would be a great idea to unify them.

BR, Jarkko
