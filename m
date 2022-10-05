Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472B45F5B69
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Oct 2022 23:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbiJEVHo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Oct 2022 17:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiJEVHn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Oct 2022 17:07:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1613696FD;
        Wed,  5 Oct 2022 14:07:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3B6A61755;
        Wed,  5 Oct 2022 21:07:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B97FC433D6;
        Wed,  5 Oct 2022 21:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665004060;
        bh=o+JFjGfmGHxvtniPCHVArgFUusf7mfq6V3+g8hM52Bg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TzkDU6Gz53krWick2tUSigiRx+pTsOKCEIa2kG1t874l4+wFrV9VKtb+G2L7A+84T
         ziFgKkYLCDQMWDvlamT+bvgvoCkJymZG/DXXZPfQyVXB/S4mI+QZYma4/d0sodx9rn
         +jdG9svsP07uSuLLNwLYuQJ/o8vzsG/pTlJgUYPw47BmHzE9lrUwBgH+SFdUflvRzu
         P+wkThklRSRX4LrZNFS/Sc1emv4s+xPNF7nxYwPj9TJLySj96rBULCOGUrSIME30Uz
         ZhrcjL914QqyWccBWbls+94h6h2jUE5HLxe3zgdhSlLvaZGrw5vTDNadoE0euj2MRb
         IfAVgTs35C6Mw==
Date:   Thu, 6 Oct 2022 00:07:35 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Morten Linderud <morten@linderud.pw>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [PATCH] tpm/eventlog: Don't abort tpm_read_log on faulty ACPI
 config
Message-ID: <Yz3yFxZ+qj2Qz4az@kernel.org>
References: <20210920203447.4124005-1-morten@linderud.pw>
 <Yzy2STXGSBmSLhmA@kernel.org>
 <20221005093128.nsudft5yl32xj2gg@framework>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005093128.nsudft5yl32xj2gg@framework>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Oct 05, 2022 at 11:31:28AM +0200, Morten Linderud wrote:
> On Wed, Oct 05, 2022 at 01:40:09AM +0300, Jarkko Sakkinen wrote:
> > On Mon, Sep 20, 2021 at 10:34:47PM +0200, Morten Linderud wrote:
> > > Some vendors report faulty values in the acpi TPM2 table. This causes
> > 
> > s/acpi/ACPI/
> > 
> > > the function to abort with EIO and essentially short circuits the
> > 
> > s/the function/tpm_read_log()/
> > 
> > > tpm_read_log function as we never even attempt to read the EFI
> > > configuration table for a log.
> > 
> > > 
> > > This changes the condition to only look for a positive return value,
> > > else hands over the eventlog discovery to the EFI configuration table
> > > which should hopefully work better.
> > 
> > Please, write in imperative ("Change...").
> > 
> > Also exlicitly state how are you changing the check for
> > tpm_read_log_acpi() in tpm_read_log().
> > 
> > You could *even* have a snippet how the checks change
> > here for clarity.
> > 
> > > It's unclear to me if there is a better solution to this then just
> > > failing. However, I do not see any clear reason why we can't properly
> > > fallback to the EFI configuration table.
> > 
> > This paragraph should not be part of the commit message.
> > 
> > Rest of the commit message made sense can you add also fixes tag
> > as this is clearly a bug fix?
> > 
> > Also, please remove the two spurious diff's from the commit that
> > are not relevant for a stable bug fix (pr_warn() and comment
> > removal).
> 
> Yo,
> 
> This is the v1 of the patch which you reviewed a year ago.
> https://marc.info/?l=linux-integrity&m=163225066613340&w=2
> 
> V2 mostly fixed the commit message, but there where some more pointers. I'm
> happy to submit a V3 if we can agree on all the details.
> 
> V2 review is here:
> https://marc.info/?l=linux-integrity&m=165475008823837&w=2

Send v3 with fixes tag and it is fine.

BR, Jarkko
