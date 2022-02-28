Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF574C6C68
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Feb 2022 13:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbiB1M0s (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Feb 2022 07:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbiB1M0m (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Feb 2022 07:26:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478777486D
        for <linux-integrity@vger.kernel.org>; Mon, 28 Feb 2022 04:25:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8BAE6112B
        for <linux-integrity@vger.kernel.org>; Mon, 28 Feb 2022 12:25:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09778C340E7;
        Mon, 28 Feb 2022 12:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646051137;
        bh=VBOeAKuWt7cRIF8Cuvjg63LPQyZbOMX8ea01ixQTxas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BXLRYTSRrFxlE9S8amtvBijZ/nqLQZXn1r0ZKF/fqQKESvJj8iTFaAafVoV3mT7+U
         AXBvhl0I5BTSVvrEnImITvq44vtwfiZY0cOwPc0LKDuZ5rQFiVWUrI4CnDaKpj4vdQ
         sv4I/YeihTSEk2XZqDP0JOx5fx8Jd3LxWxYGzvX7CfHrgaugY2aAnU55kv0ZZfrrOC
         +Lky4rgiGjKaTWdxnMz+yckxsaCUYWgwCDC/RDnCcXJj6ClPMCzKWGriJ7KFnulGnH
         lQ4mfq9x7iek82UivcniPKxoXg5lvuVDlN8MuuxhUL8n8iQSM+Gu4zeYfb7ck/AB93
         7PAB5WaQqtgqQ==
Date:   Mon, 28 Feb 2022 13:26:15 +0100
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add missing
 security/integrity/platform_certs
Message-ID: <Yhy/ZxNdQT43sSOF@iki.fi>
References: <20220223193256.301493-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223193256.301493-1-zohar@linux.ibm.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Feb 23, 2022 at 02:32:56PM -0500, Mimi Zohar wrote:
> Define a new KEYS/KEYRINGS_INTEGRITY record so that any changes
> to platform_certs/ are posted on the linux-integrity mailing list
> as well.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fdf0420ba477..6328cd4535bc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10660,6 +10660,14 @@ F:	include/linux/keyctl.h
>  F:	include/uapi/linux/keyctl.h
>  F:	security/keys/
>  
> +KEYS/KEYRINGS_INTEGRITY
> +M:	Jarkko Sakkinen <jarkko@kernel.org>
> +M:	Mimi Zohar <zohar@linux.ibm.com>
> +L:	linux-integrity@vger.kernel.org
> +L:	keyrings@vger.kernel.org
> +S:	Supported
> +F:	security/integrity/platform_certs
> +
>  KFENCE
>  M:	Alexander Potapenko <glider@google.com>
>  M:	Marco Elver <elver@google.com>
> -- 
> 2.27.0
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
