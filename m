Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951FC639EA3
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Nov 2022 02:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiK1BMC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 27 Nov 2022 20:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiK1BMB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 27 Nov 2022 20:12:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29DDDE97;
        Sun, 27 Nov 2022 17:12:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A956B80C7E;
        Mon, 28 Nov 2022 01:11:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94C9C433D6;
        Mon, 28 Nov 2022 01:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669597918;
        bh=3fPkgOheoZmcDFjDgG6fQpiUasBlp2sBUqz1jQvqnhI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BUNbPlqeWIqVhKA5td9kEkPFInYFIHg0m89OhQcWBwdhZb4121VmMlvkJ/gA9W+Nu
         Ygkvux1VAZaYUBYxEc8SIbIVptg6HE1FW/fa8y1FkrTncBnCkDQa6BY9aT97Xwu9AL
         SDpwpRftypKGUH+jdWjd6j+Su12q+fU/o8uu4jBEJTnLKn+BfDYv/up/kXRfWrCPGQ
         udTqhICUBKv/E49TqjJz1t7ubId/B1VAZhbRN4igi0Ou6m+AxO6iNiN/AHCA1Dh1yw
         IbAQ0ELoo/oCxEZXDJnwIRj2A1yKH6pCzXZVDO6qovZHmCl/VSJCfV0PPVXfckfdFj
         6zgvKBg5dMbFQ==
Date:   Mon, 28 Nov 2022 03:11:53 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Pearson <markpearson@lenovo.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 1/3] certs: log hash value on blacklist error
Message-ID: <Y4QK2cmptp4vpRj/@kernel.org>
References: <20221118040343.2958-1-linux@weissschuh.net>
 <20221118040343.2958-2-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221118040343.2958-2-linux@weissschuh.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

"Make blacklisted hash available in klog"

On Fri, Nov 18, 2022 at 05:03:41AM +0100, Thomas Weiﬂschuh wrote:
> Without this information these logs are not actionable.

Without blacklisted hash?

> For example on duplicate blacklisted hashes reported by the system
> firmware users should be able to report the erroneous hashes to their
> system vendors.
> 
> While we are at it use the dedicated format string for ERR_PTR.

Lacks the beef so saying "while we are at it" makes no sense.

> Fixes: 6364d106e041 ("certs: Allow root user to append signed hashes to the blacklist keyring")

Why does this count as a bug?

> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  certs/blacklist.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/certs/blacklist.c b/certs/blacklist.c
> index 41f10601cc72..6e260c4b6a19 100644
> --- a/certs/blacklist.c
> +++ b/certs/blacklist.c
> @@ -192,7 +192,7 @@ static int mark_raw_hash_blacklisted(const char *hash)
>  				   KEY_ALLOC_NOT_IN_QUOTA |
>  				   KEY_ALLOC_BUILT_IN);
>  	if (IS_ERR(key)) {
> -		pr_err("Problem blacklisting hash (%ld)\n", PTR_ERR(key));
> +		pr_err("Problem blacklisting hash %s: %pe\n", hash, key);
>  		return PTR_ERR(key);
>  	}
>  	return 0;
> -- 
> 2.38.1
> 

BR, Jarkko
