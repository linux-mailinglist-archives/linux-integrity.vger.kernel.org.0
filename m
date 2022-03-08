Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CEE4D1FC3
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Mar 2022 19:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349410AbiCHSLc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Mar 2022 13:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242020AbiCHSLb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Mar 2022 13:11:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7089056761;
        Tue,  8 Mar 2022 10:10:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C5A661521;
        Tue,  8 Mar 2022 18:10:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F285C340F4;
        Tue,  8 Mar 2022 18:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646763033;
        bh=J6ukM1xP6GAlq6zpYDaLwzd1rUA2wEw7PkKqVWPPW28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YoRgGYXz7iE7VygR4lvGo32RbgdfycwVZbe+XL2d5opg8fc7iG9FZ0L9Aem740U+D
         K1sY9skJpMJEpvwpUCsKsLCCUEwL3faXWufHm5hSeee0weZ3tKjWh6VWnh3n86tBlU
         rOg/XyDZNw36mz7jv7PodFhlRCe/QO6zAwhrQGNd0Jg5YD1GrYboPft4Ge9u7W3nh5
         zTUZgHs0wUO5NKMJvEEaPnlMlu0mV12X5Zi6NbBT+M73nPuO2Ad9PLykrOxrurliSh
         7XpUbhjyqc+CFvSjdtWfByWi0+rqG4x/eBo976GYIWhGLck1jJXOLuNq6AUOurTzrT
         fuskwsU6zwF/g==
Date:   Tue, 8 Mar 2022 10:10:31 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [GIT PULL] TPM DEVICE DRIVER updates for v5.18
Message-ID: <YiecF6W2XAcpC7dF@sol.localdomain>
References: <YidTCX0NOgDfHCp9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YidTCX0NOgDfHCp9@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 08, 2022 at 02:58:49PM +0200, Jarkko Sakkinen wrote:
>       KEYS: asymmetric: enforce that sig algo matches key algo

It looks like you applied v1 of this patch
(https://lore.kernel.org/r/20220201003414.55380-2-ebiggers@kernel.org) rather
than v2 (https://lore.kernel.org/r/20220208052448.409152-2-ebiggers@kernel.org).
I think that v2 is necessary because some callers of
public_key_verify_signature() leave pkey_algo as NULL.

Sorry for not spotting that you applied v1 earlier.

- Eric
