Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD740588486
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Aug 2022 00:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiHBWsk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Aug 2022 18:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiHBWsi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Aug 2022 18:48:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7BA1145E;
        Tue,  2 Aug 2022 15:48:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B01B60B15;
        Tue,  2 Aug 2022 22:48:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E3FC433D6;
        Tue,  2 Aug 2022 22:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659480516;
        bh=0dq0SPJ+MNzOXKikEBuNFM2CFX8syRV95tVbi6gKTJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SZgvM3sQrPDEN79tnz9pIQmW0z/2fx6mqOAiKu4pQe+ZmpJQLsh+kL2jmgZqoE8rI
         o3T0KxA8NJyvAfxpi00l6o8szmrfeeJSZy+8WQly1IZ6oy/NMcDA457p8O33Vlq8EJ
         gmxupBSH61gUZoGgp2bxNyU/hMP7eKY90Rqv1DRW/enkBtwaXVd1UxijtHJhx2TCY7
         szFwymnhtLz/b0TWlFwynzmQ8uPxvAUrwZ8Yfjg9EuoOSN13TzQ3ce9byt4h0KQ0Ru
         I5pDETXYf6XYjXWKTsB1iNY2v3AsN9vOg4UsPfDqdknKHQ6xd84hsNUmFmYsELpaRZ
         yfjvhIrs51wkw==
Date:   Tue, 2 Aug 2022 15:48:34 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Matthew Garrett <mgarrett@aurora.tech>, dlunev@google.com,
        zohar@linux.ibm.com, jejb@linux.ibm.com,
        linux-integrity@vger.kernel.org, corbet@lwn.net, rjw@rjwysocki.net,
        gwendal@chromium.org, jarkko@kernel.org, linux-pm@vger.kernel.org,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 08/10] PM: hibernate: Mix user key in encrypted hibernate
Message-ID: <YumpwkIz+S+zDfol@sol.localdomain>
References: <20220504232102.469959-1-evgreen@chromium.org>
 <20220504161439.8.I87952411cf83f2199ff7a4cc8c828d357b8c8ce3@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504161439.8.I87952411cf83f2199ff7a4cc8c828d357b8c8ce3@changeid>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, May 04, 2022 at 04:21:00PM -0700, Evan Green wrote:
> +/*
> + * Allow user mode to fold in key material for the data portion of the hibernate
> + * image.
> + */
> +struct uswsusp_user_key {
> +	/* Kernel returns the metadata size. */
> +	__kernel_loff_t meta_size;
> +	__u32 key_len;
> +	__u8 key[16];
> +	__u32 pad;
> +};

Shouldn't the key field be 32 bytes?

> +/* Derive a key from the kernel and user keys for data encryption. */
> +static int snapshot_use_user_key(struct snapshot_data *data)
> +{
> +	struct shash_desc *desc;
> +	u8 digest[SHA256_DIGEST_SIZE];
> +	struct trusted_key_payload *payload;
> +	struct crypto_shash *tfm;
> +	int ret;
> +
> +	tfm = crypto_alloc_shash("sha256", 0, 0);
> +	if (IS_ERR(tfm)) {
> +		ret = -EINVAL;
> +		goto err_rel;
> +	}
> +
> +	desc = kmalloc(sizeof(struct shash_desc) +
> +		       crypto_shash_descsize(tfm), GFP_KERNEL);
> +	if (!desc) {
> +		ret = -ENOMEM;
> +		goto err_rel;
> +	}
> +
> +	desc->tfm = tfm;
> +	ret = crypto_shash_init(desc);
> +	if (ret != 0)
> +		goto err_free;
> +
> +	/*
> +	 * Hash the kernel key and the user key together. This folds in the user
> +	 * key, but not in a way that gives the user mode predictable control
> +	 * over the key bits. Hash in all 32 bytes of the key even though only 16
> +	 * are in active use as extra salt.
> +	 */
> +	payload = data->key->payload.data[0];
> +	crypto_shash_update(desc, payload->key, MIN_KEY_SIZE);
> +	crypto_shash_update(desc, data->user_key, sizeof(data->user_key));
> +	crypto_shash_final(desc, digest);
> +	ret = crypto_aead_setkey(data->aead_tfm,
> +				 digest,
> +				 SNAPSHOT_ENCRYPTION_KEY_SIZE);
> +
> +err_free:
> +	kfree(desc);
> +
> +err_rel:
> +	crypto_free_shash(tfm);
> +	return ret;
> +}

Just select CRYPTO_LIB_SHA256, and you can use sha256_init/update/final which
would be much simpler.  Similarly with sha256_data() that is added by the next
patch; you could just call sha256().

- Eric
