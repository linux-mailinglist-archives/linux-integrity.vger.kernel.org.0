Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D814B53FAEF
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jun 2022 12:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240675AbiFGKL4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Jun 2022 06:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240669AbiFGKLz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Jun 2022 06:11:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC1DA338C;
        Tue,  7 Jun 2022 03:11:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3A09B81EDB;
        Tue,  7 Jun 2022 10:11:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F64AC3411E;
        Tue,  7 Jun 2022 10:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654596711;
        bh=u/LeARG2hwxh21NjNwvi6BgnN1cum7FrrFPMu1OzkfY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ep4byXZ8izun2IJ+1pW7U1VjvjuX0mLio8JYSqFxp96ZTPtlppNuwjAgGzLO58DmO
         F1BS8dLeF3tRS57YXHB2AvkPU01RHWYxPVpx92soGPkInCwWYWmomoS9qYBNmd0ku0
         YxFLyuy9RTaY8uFE8iT3Ls3OI2sWZO3Mob0QDIvNY89Scx0xrDv690vrFmpi9mB2Ni
         CWPTE4foaaomaw1I+BJzDb48A7ytfFhQt0+boLnB0h0DeMLFoZuV9Nt0xooN6rLOn+
         bMikhScHjD8yv0fS1vf3q59YUNCycOQzHg5Fh17I+XYsHnJuayqQIPG0pCqkVnLbeF
         JRyee4eULKOWg==
Date:   Tue, 7 Jun 2022 13:09:56 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jianglei Nie <niejianglei2021@163.com>
Cc:     jejb@linux.ibm.com, zohar@linux.ibm.com, dhowells@redhat.com,
        jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] security:trusted_tpm2: Fix memory leak in
 tpm2_key_encode()
Message-ID: <Yp8j9FilcBMyeL2G@iki.fi>
References: <20220607074650.432834-1-niejianglei2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607074650.432834-1-niejianglei2021@163.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

"KEYS: trusted: fix memory leak in tpm2_key_encode()"

On Tue, Jun 07, 2022 at 03:46:50PM +0800, Jianglei Nie wrote:
> The function allocates a memory chunk for scratch by kmalloc(), but
                                        ~~~         ~~ 
                                        from        with

There's more than one function in Linux - maybe you'd rather want
to write: "tpm2_key_encode() allocates ..."

> it is never freed through the function, which leads to a memory leak.

You can just write "it is never freed, which leads to a memory leak."

> Handle those cases with kfree().

"Free the memory chunk with kfree() in the return paths."

> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>

Thank you finding this and providing a fix, it is highly appreciated.
Please don't take the nitpicking with the language personally. Just want
to have it documented in appropriate form.

BR, Jarkko
