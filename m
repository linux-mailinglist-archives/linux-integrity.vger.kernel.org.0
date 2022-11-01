Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C356142C4
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Nov 2022 02:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiKAB0h (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 31 Oct 2022 21:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiKAB0g (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 31 Oct 2022 21:26:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDB6167DA
        for <linux-integrity@vger.kernel.org>; Mon, 31 Oct 2022 18:26:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAEE4614E1
        for <linux-integrity@vger.kernel.org>; Tue,  1 Nov 2022 01:26:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE38FC433C1;
        Tue,  1 Nov 2022 01:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667265995;
        bh=O1VF8D7D+X0X2hnCyCEdfHB+apGHQhsQJJjyxSfD8RE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nrpVotaFb913Y673RIF0KOglUlRLNJVKI7mLL8EaIAzkCTEywqXETqPhy2kHEkmOM
         +4YigCObca5zvjpjn832A93kYdRIty/sHP9APxi9S0xJBdoEWNjnIdajDFuC7HYABB
         GnxBGRNVkjFHSpuJHfbFMX/3iH+7dOa4Ho72VRmsJNU3KPz9nD79sQbRiSCkv04nuT
         8FO/Qg+/sUC6vQgUxmZDN+pLWpGT6t9EZZE8K38tOkGHTv/G1I6/bHHKSb4WgEV9X+
         taxh4picUtlz8/rcrK0yQIQgxiStdoZKNlNkiyiWVT5EeuA1wJ+xc+YsFcB0awNFuK
         uXQQVQvXbHdKA==
Date:   Tue, 1 Nov 2022 03:26:31 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, peterhuewe@gmx.de,
        linux-integrity@vger.kernel.org, jgg@ziepe.ca,
        samitolvanen@google.com
Subject: Re: [PATCH] tpm: Avoid function type cast of put_device()
Message-ID: <Y2B1x+NOQEzAYFOL@kernel.org>
References: <20221021123309.2770740-1-ardb@kernel.org>
 <Y1WxtIjnJvX0jAk1@kernel.org>
 <202210281407.29FF39D8@keescook>
 <CAMj1kXGe_WZU6y0h=S2g2N=EPCk=qaQm4Eemi8595uqUQ+mLyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGe_WZU6y0h=S2g2N=EPCk=qaQm4Eemi8595uqUQ+mLyA@mail.gmail.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Oct 30, 2022 at 10:23:27AM +0100, Ard Biesheuvel wrote:
> On Fri, 28 Oct 2022 at 23:08, Kees Cook <keescook@chromium.org> wrote:
> >
> > On Mon, Oct 24, 2022 at 12:27:16AM +0300, Jarkko Sakkinen wrote:
> > > [...]
> > > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> >
> > Who's tree can this land in?
> >
> 
> I'd expect the TPM maintainers to take this through the TPM tree.

It is now in:

git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ 

BR, Jarkko
