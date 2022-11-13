Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C483A6272CC
	for <lists+linux-integrity@lfdr.de>; Sun, 13 Nov 2022 23:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbiKMWBN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 13 Nov 2022 17:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiKMWBN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 13 Nov 2022 17:01:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1201054A;
        Sun, 13 Nov 2022 14:01:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A051260BDE;
        Sun, 13 Nov 2022 22:01:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D8AC433C1;
        Sun, 13 Nov 2022 22:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668376870;
        bh=K5+D7God8Baxo1J6cPFLSl608FEFDRggQ4yke5n3xdE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YU8MQ8uMV2XGwHl63jHpURf7CVlgD2sGJcgA/Vo+inaOVcnjT5WSW2iyX72mpUFOj
         iCKmhuiRkxg05XsVFjGnyWJGL5uoWzsT3pZRXB1kujV3uphhELxAe+ajAAF3ExVVeV
         9JBXvRpzHaeIY2u8ld5OOK3gcoqilNy7qFC7L2MQ2uBMF/xGFsZ1PcjRdEJKjgwZ84
         0KAwSycBi6In4UgdButVUW6xxLEIicmsTcKkaekhG9JgUWw4z+E6owDOzac7c5xUb9
         xnuVK41dQkrLdni402swB4wKlQzm9WHn5X9dWDGhyD8koWrT6keFjwzzJmZMFmkoc4
         FD2u3YES7Dq2Q==
Date:   Sun, 13 Nov 2022 14:01:07 -0800
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
        Matthew Garrett <matthewgarrett@google.com>,
        Ben Boeckel <linux@me.benboeckel.net>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v5 05/11] security: keys: trusted: Allow storage of PCR
 values in creation data
Message-ID: <Y3FpI4GHO9pHYZUH@sol.localdomain>
References: <20221111231636.3748636-1-evgreen@chromium.org>
 <20221111151451.v5.5.I32591db064b6cdc91850d777f363c9d05c985b39@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111151451.v5.5.I32591db064b6cdc91850d777f363c9d05c985b39@changeid>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Nov 11, 2022 at 03:16:30PM -0800, Evan Green wrote:
> +       creationpcrs= hex integer representing the set of PCRs to be
> +                     included in the creation data. For each bit set, the
> +                     corresponding PCR will be included in the key creation
> +                     data. Bit 0 corresponds to PCR0. Currently only the first
> +                     PC standard 24 PCRs are supported on the currently active
> +                     bank. Leading zeroes are optional. TPM2 only.

What does "currently active bank" mean?

> +		/* PCR bitmask */
> +		for (i = 0; i < 3; i++) {
> +			char tmp = 0;
> +
> +			for (j = 0; j < 8; j++) {
> +				char bit = (i * 8) + j;
> +
> +				if (options->creation_pcrs & (1 << bit))
> +					tmp |= (1 << j);
> +			}
> +			tpm_buf_append_u8(&buf, tmp);
> +		}

Why not just:

	tpm_buf_append_u8(&buf, options->creation_pcrs);
	tpm_buf_append_u8(&buf, options->creation_pcrs >> 8);
	tpm_buf_append_u8(&buf, options->creation_pcrs >> 16);

Also what if bit 24 or above is set?  Should an error be returned?

- Eric
