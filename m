Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D716173B086
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Jun 2023 08:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjFWGIl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 23 Jun 2023 02:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjFWGIk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 23 Jun 2023 02:08:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3F910DB;
        Thu, 22 Jun 2023 23:08:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BB4161989;
        Fri, 23 Jun 2023 06:08:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59347C433C9;
        Fri, 23 Jun 2023 06:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687500518;
        bh=iEBo0nryUklKbwszNwaFOULRadSZTxMhgHNcODezBMU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x8Vknzt0okM+8asd67EscMHeT04682pksCtlyF2tSNbUlnx+oXuvDIF9JUVF3YsQu
         NvcOX40u7NAeTmaRq1/aLKec3VHu7EXX7fbmwuCfvdEyVd/QtIssbHKZHGIfj4De++
         qe8u7RD1ZMgXTieEaksCDl+Fk+xk7dhrPGIG7y/Q=
Date:   Fri, 23 Jun 2023 08:08:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Sachin Sant <sachinp@linux.ibm.com>
Subject: Re: [PATCH] tpm: Ensure that tpm chip has ops to check if it's
 defective
Message-ID: <2023062317-daytime-angles-3c5a@gregkh>
References: <20230623030427.908-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623030427.908-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 22, 2023 at 10:04:27PM -0500, Mario Limonciello wrote:
> The ibmvtpm doesn't have `chip->ops` set, and so trying to check
> if it's a defective AMD fTPM doesn't work.
> 
> Add an extra check to tpm_amd_is_rng_defective() to ensure the
> TPM being checked has `chip->ops`.
> 
> Cc: Linux regressions mailing list <regressions@lists.linux.dev>
> Reported-by: Aneesh Kumar K. V <aneesh.kumar@linux.ibm.com>
> Reported-by: Sachin Sant <sachinp@linux.ibm.com>
> Link: https://lore.kernel.org/lkml/99B81401-DB46-49B9-B321-CF832B50CAC3@linux.ibm.com/
> Tested-by: Sachin Sant <sachinp@linux.ibm.com>
> Fixes: bd8621ca1510 ("tpm: Add !tpm_amd_is_rng_defective() to the hwrng_unregister() call site")
> Fixes: f1324bbc4011 ("tpm: disable hwrng for fTPM on some AMD designs")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/char/tpm/tpm-chip.c | 3 +++
>  1 file changed, 3 insertions(+)

No cc: stable on that list above?

greg k-h
