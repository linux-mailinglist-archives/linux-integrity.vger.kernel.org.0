Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1625D58849A
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Aug 2022 01:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbiHBXAn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Aug 2022 19:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiHBXAi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Aug 2022 19:00:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0602528A;
        Tue,  2 Aug 2022 16:00:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5873B8213F;
        Tue,  2 Aug 2022 23:00:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00C2C433C1;
        Tue,  2 Aug 2022 23:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659481235;
        bh=4KlFLMbqon6wM4SyCt0GNC1KbVuJruJzqoV9uK5RCis=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pH8rU5/p6LlptHFZHICoY5q70f4wzc4oQZrtoFIM07uzzOJvZSVPhI28j/uJ57fyR
         iw6Awbf89SGZFGfkNF17vYDdwhPjAdu0jP7gsEbJ9zlUqMbtwtlrMPz2vbDC9epEdt
         nO7cayPU3KIKx4rE+/gfOkFwtbvv7x4ux3sill1o5rwRuaR+SlNUGRyjg3SilkSdz8
         f7Yf21bsafFu5SLjGAeaBUgWRrMCEiw8Y/7OShAcIM88UDFQkVwrSU+QFggZoVC/qB
         bJzNS90ZxqOdNT4+aohZM3sTATluXjks+fbyNVEmtTZmIIPgZ4BYk7e01Iq8Ohipp5
         MD45lqeW3nznw==
Date:   Tue, 2 Aug 2022 16:00:33 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Matthew Garrett <mgarrett@aurora.tech>, dlunev@google.com,
        zohar@linux.ibm.com, jejb@linux.ibm.com,
        linux-integrity@vger.kernel.org, corbet@lwn.net, rjw@rjwysocki.net,
        gwendal@chromium.org, jarkko@kernel.org, linux-pm@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 04/10] security: keys: trusted: Allow storage of PCR
 values in creation data
Message-ID: <Yumskea9UJ9n0uPz@sol.localdomain>
References: <20220504232102.469959-1-evgreen@chromium.org>
 <20220504161439.4.I32591db064b6cdc91850d777f363c9d05c985b39@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504161439.4.I32591db064b6cdc91850d777f363c9d05c985b39@changeid>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, May 04, 2022 at 04:20:56PM -0700, Evan Green wrote:
> diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
> index aa108bea6739b3..2975827c01bec0 100644
> --- a/security/keys/trusted-keys/trusted_tpm1.c
> +++ b/security/keys/trusted-keys/trusted_tpm1.c
> @@ -713,6 +713,7 @@ enum {
>  	Opt_hash,
>  	Opt_policydigest,
>  	Opt_policyhandle,
> +	Opt_creationpcrs,
>  };
>  
>  static const match_table_t key_tokens = {
> @@ -725,6 +726,7 @@ static const match_table_t key_tokens = {
>  	{Opt_hash, "hash=%s"},
>  	{Opt_policydigest, "policydigest=%s"},
>  	{Opt_policyhandle, "policyhandle=%s"},
> +	{Opt_creationpcrs, "creationpcrs=%s"},
>  	{Opt_err, NULL}
>  };
>  
> @@ -858,6 +860,13 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>  				return -EINVAL;
>  			opt->policyhandle = handle;
>  			break;
> +		case Opt_creationpcrs:
> +			if (!tpm2)
> +				return -EINVAL;
> +			res = kstrtoint(args[0].from, 16, &opt->creation_pcrs);
> +			if (res < 0)
> +				return -EINVAL;
> +			break;

I thought that TPM1 is deprecated.  Are you sure you need more TPM1 features?

- Eric
