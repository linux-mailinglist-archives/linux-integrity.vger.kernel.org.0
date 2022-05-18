Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346B152B1AD
	for <lists+linux-integrity@lfdr.de>; Wed, 18 May 2022 07:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiERFED (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 May 2022 01:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiERFEB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 May 2022 01:04:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E692815A0E;
        Tue, 17 May 2022 22:04:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E28C61749;
        Wed, 18 May 2022 05:04:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FB8C385A5;
        Wed, 18 May 2022 05:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652850239;
        bh=lSzlfK/0P+B4mxaeyy93zDIWo7rAvWr2cqZq2BGe2cM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iPryZ3oC1Rn6JBWJVmSUzTmW+fjDSrinGRBzxM9sETeE0T+IIJsQ3VxRMTfGvQARH
         d5RBwOBSRuR4AvIko46Toh+sHz199Hj5kmumTywYOrZMH9mHsNTFvRTOG4bX+Waj2/
         xaPvazDpcV0fCpuKZ0H2n2lLZXHbYD7ANEPFYBuaanzupW1wVhXlu4ZG1RCW2wqv+6
         8wDp7VlGs5YMwL1MnT8Jo2yuO8Qb+lpsbScqQlaGYYyA1SdGG3gQCKx49Umpl9HBE3
         Xs0mD7Xxt6n1uE+PTSlpWyWMiq6ECHt0UbtpyZ/2WnjgC/L3APqJIBT0jFiY8/7Br6
         WhvoQQ3Pcv0jw==
Date:   Wed, 18 May 2022 00:13:26 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     GUO Zihua <guozihua@huawei.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, linux-hardening@vger.kernel.org
Subject: Re: [RESEND] evm: Refector struct evm_xattr
Message-ID: <20220518051326.GB16144@embeddedor>
References: <20220518011439.184809-1-guozihua@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518011439.184809-1-guozihua@huawei.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, May 18, 2022 at 09:14:39AM +0800, GUO Zihua wrote:
> struct evm_xattr is only used for EVM_XATTR_HMAC type evm digest and is
> glued together one flexible array and one fixed length array. The
> original intention seems to be shortening the code as the "data" field
> would always be a SHA1 digest.
> 
> This implementation is not complying with GCC's specification about
> flexible array and spars yield the following warning:

The sparse warning has nothing to do with any GCC specification. It's
perfectly fine to apply the sizeof operator to a struct-with-flex-array.
However, it might be suspicious if the intention is to also get the
_dynamic_ size of the flexible array, because in that case the size of
the flex array is always zero. See the example below:

	struct foo {
		uint8_t len;
		struct boo data[];
	};

	sizeof(struct foo) == 1

Also, you sent this patch twice in the last 24 hours. Give the maintainers
time to review your patch (usually a couple of weeks) before resending it.

> 
> security/integrity/evm/evm_main.c:852:30: warning: using sizeof on a flexible
> structure
> security/integrity/evm/evm_main.c:862:32: warning: using sizeof on a flexible
> structure

Regarding the warnings above, please take a look at my response to your
other patch (the same applies in this case). :)

Thanks
--
Gustavo

> 
> Fix it by:
> 1. Remove struct evm_xattr and use struct evm_ima_xattr_data directly.
> 2. Get array size with struct_size instead of sizeof.
> 
> Reference: https://github.com/KSPP/linux/issues/174
> 
> Fixes: 6be5cc5246f80 ("evm: add support for different security.evm data types")
> Signed-off-by: GUO Zihua <guozihua@huawei.com>
> ---
>  security/integrity/evm/evm_main.c | 14 ++++++++------
>  security/integrity/integrity.h    |  6 ------
>  2 files changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index 7d87772f0ce6..f2c4501a287a 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -211,7 +211,8 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
>  	/* check value type */
>  	switch (xattr_data->type) {
>  	case EVM_XATTR_HMAC:
> -		if (xattr_len != sizeof(struct evm_xattr)) {
> +		if (xattr_len != struct_size(*xattr_data, data,
> +					     SHA1_DIGEST_SIZE)) {
>  			evm_status = INTEGRITY_FAIL;
>  			goto out;
>  		}
> @@ -842,24 +843,25 @@ int evm_inode_init_security(struct inode *inode,
>  				 const struct xattr *lsm_xattr,
>  				 struct xattr *evm_xattr)
>  {
> -	struct evm_xattr *xattr_data;
> +	struct evm_ima_xattr_data *xattr_data;
>  	int rc;
>  
>  	if (!(evm_initialized & EVM_INIT_HMAC) ||
>  	    !evm_protected_xattr(lsm_xattr->name))
>  		return 0;
>  
> -	xattr_data = kzalloc(sizeof(*xattr_data), GFP_NOFS);
> +	xattr_data = kzalloc(struct_size(*xattr_data, data,
> +			     SHA1_DIGEST_SIZE), GFP_NOFS);
>  	if (!xattr_data)
>  		return -ENOMEM;
>  
> -	xattr_data->data.type = EVM_XATTR_HMAC;
> -	rc = evm_init_hmac(inode, lsm_xattr, xattr_data->digest);
> +	xattr_data->type = EVM_XATTR_HMAC;
> +	rc = evm_init_hmac(inode, lsm_xattr, xattr_data->data);
>  	if (rc < 0)
>  		goto out;
>  
>  	evm_xattr->value = xattr_data;
> -	evm_xattr->value_len = sizeof(*xattr_data);
> +	evm_xattr->value_len = struct_size(*xattr_data, data, SHA1_DIGEST_SIZE);
>  	evm_xattr->name = XATTR_EVM_SUFFIX;
>  	return 0;
>  out:
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index 3510e413ea17..91b16d620dd9 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -86,12 +86,6 @@ struct evm_ima_xattr_data {
>  	u8 data[];
>  } __packed;
>  
> -/* Only used in the EVM HMAC code. */
> -struct evm_xattr {
> -	struct evm_ima_xattr_data data;
> -	u8 digest[SHA1_DIGEST_SIZE];
> -} __packed;
> -
>  #define IMA_MAX_DIGEST_SIZE	64
>  
>  struct ima_digest_data {
> -- 
> 2.36.0
> 
