Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392BC56D218
	for <lists+linux-integrity@lfdr.de>; Mon, 11 Jul 2022 02:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiGKAJF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 10 Jul 2022 20:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiGKAJF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 10 Jul 2022 20:09:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4899615714
        for <linux-integrity@vger.kernel.org>; Sun, 10 Jul 2022 17:09:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9403B80D19
        for <linux-integrity@vger.kernel.org>; Mon, 11 Jul 2022 00:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034CFC3411E;
        Mon, 11 Jul 2022 00:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657498141;
        bh=gx2AFFyDNl/pkaZKTmyC1uwZPFtkZYL7KdWVrOYP7xg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IyN8S73RwA9TpyCY2fHKfrm7NBh6g1/frK82PCAXNKzPtVLg7dSG2RYt9q2A88rfc
         RUSkM8BKGJMcL1ySjSWjVCZiHt7he2KTL+nxbPe8VffLIqJi+pZXjf3SUpPOKFaswx
         Xit3PvHTa7jiiPuqzDJqxRRHY1e3qEzeyaSEh4KPl5O8QEjDhXN4g+hNKt+z89P/mw
         wn8+inaUdQrjf8zZ/IpfzmQq9+JJDtvXbaApSz4ahGWo7YuO+8H8a+Lbl4ZWwrTdFQ
         wW6wYmZaecf74vrJtDtXX4krS30BftTaRcFytyUt7jtat0F0I4nlVAtclLVmp5ZTn7
         1TikUbSxDzk+Q==
Date:   Mon, 11 Jul 2022 03:08:56 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        WANG Xuerui <git@xen0n.name>
Subject: Re: [PATCH] tpm: eventlog: Fix section mismatch for
 DEBUG_SECTION_MISMATCH
Message-ID: <YstqGO4X8P6jY6Is@kernel.org>
References: <20220702080934.1168975-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220702080934.1168975-1-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Jul 02, 2022 at 04:09:34PM +0800, Huacai Chen wrote:
> If DEBUG_SECTION_MISMATCH enabled, __calc_tpm2_event_size() will not be
> inlined, this cause section mismatch like this:
> 
> WARNING: modpost: vmlinux.o(.text.unlikely+0xe30c): Section mismatch in reference from the variable L0 to the function .init.text:early_ioremap()
> The function L0() references
> the function __init early_memremap().
> This is often because L0 lacks a __init 
> annotation or the annotation of early_ioremap is wrong.
> 
> Fix it by using __always_inline instead of inline for the called-once
> function __calc_tpm2_event_size().
> 
> Reported-by: WANG Xuerui <git@xen0n.name>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  include/linux/tpm_eventlog.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
> index 739ba9a03ec1..20c0ff54b7a0 100644
> --- a/include/linux/tpm_eventlog.h
> +++ b/include/linux/tpm_eventlog.h
> @@ -157,7 +157,7 @@ struct tcg_algorithm_info {
>   * Return: size of the event on success, 0 on failure
>   */
>  
> -static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
> +static __always_inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
>  					 struct tcg_pcr_event *event_header,
>  					 bool do_mapping)
>  {
> -- 
> 2.27.0
> 

Please add

Fixes: 44038bc514a2 ("tpm: Abstract crypto agile event size calculations")

BR, Jarkko
