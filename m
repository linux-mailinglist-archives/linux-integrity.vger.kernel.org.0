Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518154C17B2
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Feb 2022 16:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242425AbiBWPtq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Feb 2022 10:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242208AbiBWPtq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Feb 2022 10:49:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53AABDE4A;
        Wed, 23 Feb 2022 07:49:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E1E261849;
        Wed, 23 Feb 2022 15:49:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB38C340E7;
        Wed, 23 Feb 2022 15:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645631356;
        bh=aWvaG7nzuzyHquY8bpBTQACN4I4gRDs4skzuQWQs7YE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ab2gje/MvL1A3j4Oevncz76dSxJLPB7j8odE6B6/JB1w4bO5dAKx7ajoyp86ZQcRH
         BqRlPqF4uPRLDvPWfip/jE12urqyGCvNEbLb7hIPZGaxK6GIpoZvkcBNvdj5H5vRBu
         DJD0XhCN9tL0emb4weOuRVEDDQegQ3zKZQ/ecvHDKKdiGPcRT5luTPZE43ROSHIgxk
         59JG3fnABgsogkCg22PXwzg+JGB9bL3wTtJJbUSTvZr1sRST02rhhpVeShdjO/nU79
         czta7EkgTDs2sFy/LxSVMu7rJGrkWyLPhA6ewv65r8TBy0fyTDqOse+n3Eidor29ej
         X9zGoEU169Zqw==
Date:   Wed, 23 Feb 2022 16:49:52 +0100
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Unintended file entry addition in commit 7ed88a03b15b ("certs:
 Check that builtin blacklist hashes are valid")?
Message-ID: <YhZXoPqSdfdXEfgx@iki.fi>
References: <CAKXUXMwrvq=aDWcZRKk-0UEiKQtywDbiVSJnsxnAc_sBoSNY6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKXUXMwrvq=aDWcZRKk-0UEiKQtywDbiVSJnsxnAc_sBoSNY6w@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Feb 23, 2022 at 02:50:42PM +0100, Lukas Bulwahn wrote:
> Dear Jarkko, dear Mickaël,
> 
> The commit 7ed88a03b15b ("certs: Check that builtin blacklist hashes
> are valid") adds a file entry for scripts/extract-cert.c in the
> CERTIFICATE HANDLING section in MAINTAINERS.
> 
> Hence, ./scripts/get_maintainers.pl --self-test=patterns complains:
> 
>   warning:  no file matches  F: scripts/extract-cert.c
> 
> I could not see that line being added in the original patch, i.e.,
> https://lore.kernel.org/all/20210712170313.884724-3-mic@digikod.net/,
> but it was only part of the context of that patch. In linux-next, it
> appears to be part of the commit above.
> 
> That seems to be introduced while applying or rebasing the patch to
> some later version. If that is the case, you can probably just drop
> this line "F: scripts/extract-cert.c" in the MAINTAINERS file.

Thank you, I removed the entry. I had to solve a merge conflict with
this patch, and made a human error.

BR, Jarkko
