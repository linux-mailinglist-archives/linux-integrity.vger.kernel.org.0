Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06CD62738E
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Nov 2022 00:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbiKMXoS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 13 Nov 2022 18:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKMXoR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 13 Nov 2022 18:44:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49F2EAF;
        Sun, 13 Nov 2022 15:44:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B06BE60DE2;
        Sun, 13 Nov 2022 23:44:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77EF9C433B5;
        Sun, 13 Nov 2022 23:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668383055;
        bh=LoWCb3lNyJ4hJnSzs3SkHUb0L90gwz2LPeVQQzyt9xg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OdcYn3Y4o07Q0rQZk0bdOGeLqiWE/K+pGGr/a4JRvy3QoDRJrtbwzEe6XQL1zI5/1
         hpm+4swzpvVby42b7sCdmRPO32IdIy996vH7qflYIS7hp27Q8PKrPGqS+9KRAbWJT4
         WrO2BDTS4ygusIaePN+6/kmyvyZ/J0B6GsS2NkdmiNZeLJSy5Tz2yoWeim8/IujjhG
         IOb0e2d7kiojRlIxC+/v8woutyshA8um3EXmDzb6h/pwPtGmiGt00Ky8qwZIjL+ULP
         oe6TSiWU0/caz8ZV4gS/vQfbdmx5THKPkLgOW8Vzwn6XBjx5uzOLS+zPPD7SeE80Q8
         enT7FcO9wE+DA==
Date:   Sun, 13 Nov 2022 15:44:12 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-integrity@vger.kernel.org, gwendal@chromium.org,
        dianders@chromium.org, apronin@chromium.org,
        Pavel Machek <pavel@ucw.cz>, Ben Boeckel <me@benboeckel.net>,
        rjw@rjwysocki.net, jejb@linux.ibm.com,
        Kees Cook <keescook@chromium.org>, dlunev@google.com,
        zohar@linux.ibm.com, Matthew Garrett <mgarrett@aurora.tech>,
        jarkko@kernel.org, linux-pm@vger.kernel.org,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v5 09/11] PM: hibernate: Mix user key in encrypted
 hibernate
Message-ID: <Y3GBTCwcRcI0oGQO@sol.localdomain>
References: <20221111231636.3748636-1-evgreen@chromium.org>
 <20221111151451.v5.9.I87952411cf83f2199ff7a4cc8c828d357b8c8ce3@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111151451.v5.9.I87952411cf83f2199ff7a4cc8c828d357b8c8ce3@changeid>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Nov 11, 2022 at 03:16:34PM -0800, Evan Green wrote:
> Limiting this to the data portion allows the kernel to receive the page
> map and prepare its giant allocation even if this user key is not yet
> available (ie the user has not yet finished typing in their password).

What is meant by the "data portion"?

> +int snapshot_set_user_key(struct snapshot_data *data,
> +	struct uswsusp_user_key __user *key)
> +{
> +	struct uswsusp_user_key user_key;
> +	unsigned int key_len;
> +	int rc;
> +	loff_t size;
> +
> +	/*
> +	 * Return the metadata size, the number of bytes that can be fed in before
> +	 * the user data key is needed at resume time.
> +	 */
> +	size = snapshot_get_meta_data_size();
> +	rc = put_user(size, &key->meta_size);
> +	if (rc)
> +		return rc;
> +
> +	rc = copy_from_user(&user_key, key, sizeof(struct uswsusp_user_key));
> +	if (rc)
> +		return rc;

This isn't correctly checking the return value of copy_from_user().

> +
> +	BUILD_BUG_ON(sizeof(data->user_key) < sizeof(user_key.key));
> +
> +	key_len = min_t(__u32, user_key.key_len, sizeof(data->user_key));
> +	if (key_len < 8)
> +		return -EINVAL;

Shouldn't -EINVAL also be returned if key_len is too large?

- Eric
