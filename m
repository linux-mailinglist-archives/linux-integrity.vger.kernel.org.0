Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0B8563CC1
	for <lists+linux-integrity@lfdr.de>; Sat,  2 Jul 2022 01:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiGAXVJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 1 Jul 2022 19:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiGAXVI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 1 Jul 2022 19:21:08 -0400
X-Greylist: delayed 2351 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Jul 2022 16:21:04 PDT
Received: from the.earth.li (the.earth.li [IPv6:2a00:1098:86:4d:c0ff:ee:15:900d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274E572EE7
        for <linux-integrity@vger.kernel.org>; Fri,  1 Jul 2022 16:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
        s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=JzHdET9cI0rqnpP4vus42b0FOXQF+WsNOFJzBEVine8=; b=qttwagg+uWX4ASRoGEuW7zkPkE
        ySrWYiJbgRshQxuc2moHoT5BYqulkg0EsjhapRTsFDD2HklH+nyUjPGGyNnfZ9sQ1HMYjqQZSluU1
        gVWlUwJAqNTi/AziVgmKufm+0oYUwCo9JzQM+sys6L1wNMGGngd1+LD9t7rAbR59Azeg0DPpJO35I
        NAtrNzbWywccQNMAoP/4+2xQ5wjhIvanGJ2o9Vy7lwvFEIhzaasllo9IGXjpWir/CxbYAa+HVGlBn
        JSfAYkewVZaX8l2qsavch0JTlp5u/95e8oCE57TXVrSe4rzbbo6beuqhFajJA6imeqBHAQYGM6QCK
        rMGwTU8g==;
Received: from noodles by the.earth.li with local (Exim 4.94.2)
        (envelope-from <noodles@earth.li>)
        id 1o7PKg-005kk8-0P; Fri, 01 Jul 2022 23:41:50 +0100
Date:   Fri, 1 Jul 2022 23:41:49 +0100
From:   Jonathan McDowell <noodles@earth.li>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH] ima: fix violation measurement list record
Message-ID: <Yr94LQGboFv4f1xG@earth.li>
References: <20220701201325.396766-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701201325.396766-1-zohar@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jul 01, 2022 at 04:13:25PM -0400, Mimi Zohar wrote:
> Although the violation digest in the IMA measurement list is always
> zeroes, the size of the digest should be based on the hash algorithm.
> Until recently the hash algorithm was hard coded to sha1.  Fix the
> violation digest size included in the IMA measurement list.
> 
> This is just a cosmetic which should not affect attestation.
> 
> Reported-by: Stefan Berger <stefanb@linux.ibm.com>
> Fixes: 09091c44cb73 ("ima: use IMA default hash algorithm for integrity violations")
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  security/integrity/ima/ima_template_lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
> index c877f01a5471..67359845c975 100644
> --- a/security/integrity/ima/ima_template_lib.c
> +++ b/security/integrity/ima/ima_template_lib.c
> @@ -326,7 +326,7 @@ static int ima_eventdigest_init_common(const u8 *digest, u32 digestsize,
>  		 * Make room for the digest by increasing the offset of
>  		 * IMA_DIGEST_SIZE.
>  		 */
> -		offset += IMA_DIGEST_SIZE;
> +		offset += hash_digest_size[hash_algo];

Update the comment as well?

>  	return ima_write_template_field_data(buffer, offset + digestsize,
>  					     fmt, field_data);
> -- 
> 2.27.0
> 

J.

-- 
This isn't an office. It's Hell with fluorescent lighting.
