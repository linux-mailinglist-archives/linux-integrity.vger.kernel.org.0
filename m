Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D4B6142C1
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Nov 2022 02:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiKABX0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 31 Oct 2022 21:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiKABXZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 31 Oct 2022 21:23:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9295210B5C
        for <linux-integrity@vger.kernel.org>; Mon, 31 Oct 2022 18:23:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14B526151B
        for <linux-integrity@vger.kernel.org>; Tue,  1 Nov 2022 01:23:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89EEEC433C1;
        Tue,  1 Nov 2022 01:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667265803;
        bh=kCTvckIAww+vWve8vjMTgkQ9dxqkTiuNq3jJ2ugyKjQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l4U8SGXrSzsWDq/HXj+p6M9GwhPk6m/Fun/T6MNxKB+8y6GObwfh7TDDF9rVmN5kt
         G3KLoDY7b4ZhHPC6g6fJIvSnJkHYZgdnb1QkzTyprqoSAOLuqjmkszbGlgwHQa2IR6
         HbEw8jZ/m81va18P3wXKnmwe97BEBoYCK5kNj5JmfbjjqGUjmQq1wj+tyL0RSYK4fc
         qNFrdkmM8gej5BD2gfvedugSQKkZYnCJ5wTybsCUSRyiMIVeRiDm/dy9ojNANOi/kx
         FMgHH6o1Q02gaqA9qpmi31/FcoVUvqDjYqMAfjU9/xKNvIaUb43P9tn6uzKQp9kQ+o
         SBeFxGnvRO0rw==
Date:   Tue, 1 Nov 2022 03:23:18 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, peterhuewe@gmx.de,
        linux-integrity@vger.kernel.org, jgg@ziepe.ca,
        samitolvanen@google.com
Subject: Re: [PATCH] tpm: Avoid function type cast of put_device()
Message-ID: <Y2B1Bla/uSXow/5c@kernel.org>
References: <20221021123309.2770740-1-ardb@kernel.org>
 <Y1WxtIjnJvX0jAk1@kernel.org>
 <202210281407.29FF39D8@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210281407.29FF39D8@keescook>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Oct 28, 2022 at 02:08:24PM -0700, Kees Cook wrote:
> On Mon, Oct 24, 2022 at 12:27:16AM +0300, Jarkko Sakkinen wrote:
> > [...]
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> Who's tree can this land in?

Sorry, I forgot to pick this, it's now applied to my tree.

> 
> -- 
> Kees Cook

BR, Jarkko
