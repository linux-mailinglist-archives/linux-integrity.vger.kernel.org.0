Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE3154D20D
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jun 2022 21:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242953AbiFOTzU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jun 2022 15:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242506AbiFOTzT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jun 2022 15:55:19 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5EE29372
        for <linux-integrity@vger.kernel.org>; Wed, 15 Jun 2022 12:55:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6AB38CE229F
        for <linux-integrity@vger.kernel.org>; Wed, 15 Jun 2022 19:55:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC68C34115;
        Wed, 15 Jun 2022 19:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655322915;
        bh=/nz210YLLlvWhbqxTRUp474GtlI0pOFkn5HZB4Vgkuo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qPSseb+N/gtizAeFPGiQ+uyUP9Ne/TQRh/GolGc7id9TF1X7VQ6CmV+57GfLi32da
         tQHKAOPC0qqi8VM/UEaQ3TbnuIvxCgPnOWIc+C340BabkItqV+LqVsxoDDHSCexKbE
         u6oP/KaAf7C07Ot6riVXA3aPs0RZLqUC4kLTKWVspy7ANGRNT/p+KqRIw1xCjA4k7W
         OksT1t4LkRKTokqYp9Nj7bLZCdCREZKI/nMrzPpW8D3bNzvDVw+cIeRyASfZn2JMpK
         42HAjCmWyJtnLYTzluERfrtub+0rzZXkKBleJmi34KNM9AcQWxTwpkXHvHoNjRMWpH
         AzfUZVUiQxhoA==
Date:   Wed, 15 Jun 2022 22:53:06 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
Subject: Re: CKI team seeing boot failures with 5.19 kernels on VMs with tpm
 device
Message-ID: <Yqo4ot+mIW+LsrxB@iki.fi>
References: <CALzcddv+khkc4vy4n0m6EAn=d2+9M5RRc92_TbxdCPMViJUC3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALzcddv+khkc4vy4n0m6EAn=d2+9M5RRc92_TbxdCPMViJUC3w@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jun 13, 2022 at 07:47:40AM -0700, Jerry Snitselaar wrote:
> This came to my attention this morning, and I was able to do a quick
> test and reproduce in a vm locally, using both the crb and tis
> emulation. 5.18 boots up fine.
> 
> The only thing I see that could impact both crb and tis in the tpm
> changes would be:
> 
> af402ee3c045 tpm: Add field upgrade mode support for Infineon TPM2
> modules | 2022-05-23 | (Stefan Mahnke-Hartmann)
> e57b2523bd37 tpm: Fix buffer access in tpm2_get_tpm_pt() | 2022-05-23
> | (Stefan Mahnke-Hartmann)
> 
> I'm going to poke around some more and see if I can figure out what is
> going on, but wanted to give you a heads up.
> 
> Regards,
> Jerry
> 

OK, thanks for spotting this.

BR, Jarkko
