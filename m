Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C7E729CB8
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Jun 2023 16:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241133AbjFIOZL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Jun 2023 10:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241383AbjFIOY7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Jun 2023 10:24:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDA030F2;
        Fri,  9 Jun 2023 07:24:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DA83612DC;
        Fri,  9 Jun 2023 14:24:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFC0C433EF;
        Fri,  9 Jun 2023 14:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686320697;
        bh=lPZaYXwJNgQ8vlT2x3myxwgaKUg25CcT5sq/Ukhrut0=;
        h=Date:Subject:From:To:References:In-Reply-To:From;
        b=W8kTc9kAK3vwyM14HxhZNCGyCsgjneC7ZodooyfoMlG7QL799/YlXtnUntj2P8V5+
         xbEXsW87sQ6wqEkEv0B8Dc0R35BsxwV0G25Hr3XSxtbJqI8SoF4lXD//yb9IT5gox8
         fhF7ltXerFotqpYWdtd5KJwdnsqracFfgKWBV5ayFKoPeTpgrX5kYGtrXXjq9D/SxT
         ycrghnTvCqOkt575AxkfxUiqHod9waGPwil9p3nJLPpRc7S0lYwv+SE7sOkvblIBHW
         5aoTUbJHjz8pXitDcJjYjUVtf/qZHi/LgqHXCAYwhTOOq70KzaXOOv1s86EumoHGqj
         W3IrXHGIYfxtg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 09 Jun 2023 17:24:52 +0300
Message-Id: <CT86SNGF201H.2UZF8SN2MEKZ6@suppilovahvero>
Subject: Re: [PATCH v2] integrity: Fix possible multiple allocation in
 integrity_inode_get()
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Tianjia Zhang" <tianjia.zhang@linux.alibaba.com>,
        "Mimi Zohar" <zohar@linux.ibm.com>,
        "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>,
        "Paul Moore" <paul@paul-moore.com>,
        "James Morris" <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230530121453.10249-1-tianjia.zhang@linux.alibaba.com>
 <20230601064244.33633-1-tianjia.zhang@linux.alibaba.com>
In-Reply-To: <20230601064244.33633-1-tianjia.zhang@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu Jun 1, 2023 at 9:42 AM EEST, Tianjia Zhang wrote:
> When integrity_inode_get() is querying and inserting the cache, there
> is a conditional race in the concurrent environment.
>
> The race condition is the result of not properly implementing
> "double-checked locking". In this case, it first checks to see if the
> iint cache record exists before taking the lock, but doesn't check
> again after taking the integrity_iint_lock.
>
> Fixes: bf2276d10ce5 ("ima: allocating iint improvements")
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> Cc: <stable@vger.kernel.org> # v3.10+

s/v3.10/v4.14/

I.e. cover only currently maintained longterms, right?


> ---
>  security/integrity/iint.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> index c73858e8c6d5..a462df827de2 100644
> --- a/security/integrity/iint.c
> +++ b/security/integrity/iint.c
> @@ -43,12 +43,10 @@ static struct integrity_iint_cache *__integrity_iint_=
find(struct inode *inode)
>  		else if (inode > iint->inode)
>  			n =3D n->rb_right;
>  		else
> -			break;
> +			return iint;
>  	}
> -	if (!n)
> -		return NULL;
> =20
> -	return iint;
> +	return NULL;
>  }
> =20
>  /*
> @@ -113,10 +111,15 @@ struct integrity_iint_cache *integrity_inode_get(st=
ruct inode *inode)
>  		parent =3D *p;
>  		test_iint =3D rb_entry(parent, struct integrity_iint_cache,
>  				     rb_node);
> -		if (inode < test_iint->inode)
> +		if (inode < test_iint->inode) {
>  			p =3D &(*p)->rb_left;
> -		else
> +		} else if (inode > test_iint->inode) {
>  			p =3D &(*p)->rb_right;
> +		} else {
> +			write_unlock(&integrity_iint_lock);
> +			kmem_cache_free(iint_cache, iint);
> +			return test_iint;
> +		}
>  	}
> =20
>  	iint->inode =3D inode;
> --=20
> 2.24.3 (Apple Git-128)

Mimi, are you picking this?

Off-topic: how do you compile kernel on macOS, you're using VM right?
I'm just interested because I recently bought Mac mini for both
compiling and testing arm64. Optimal would be to be able to compile
the kernel on bare metal and then deploy to a VM...


BR, Jarkko
