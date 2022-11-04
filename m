Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE6961A023
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Nov 2022 19:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbiKDSjC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Nov 2022 14:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbiKDSjA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Nov 2022 14:39:00 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5481E1D0CF
        for <linux-integrity@vger.kernel.org>; Fri,  4 Nov 2022 11:38:58 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d20so4612372plr.10
        for <linux-integrity@vger.kernel.org>; Fri, 04 Nov 2022 11:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GxUQcGD1ekL/2d9GXVQdlQ0tteAYOQEOTDd6IVlVtPY=;
        b=GjlhU7IoqaY718RNOR7DqWTG20zF6kOt5wgWynudn0ITp0+zDVD5QosZuVb9DcNI1E
         uLg7ZOVZiESDg9QBf+b2QS/Pn8Hc0gkXnTqzle1PVe0v7nwVonxi/nK9dqBJhmAlASAJ
         tuMCJ67J0Eu/2HZM0qT0wURiQPbKt5+sQ88DQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxUQcGD1ekL/2d9GXVQdlQ0tteAYOQEOTDd6IVlVtPY=;
        b=cu5FWOELrcOoPnhhheN86cC4X2EavHel19qR+ojhSYtnU5seQngkblVCJfVUymf5ZI
         VWDSRcG9kYbDRBSVWwx5s/HTySMfWrQrlOi5Dld/DF2uEh+CrbWEWwvvA3jj3mMBB/he
         2SRd4xmVt2SfuopHBRbDc+lmKLIxeMrGOy9QS3PoFE3Nrc854I5aOGJxuR9P1qjvom5E
         Lm+6Xrrf+rE6Dtvkh4BuhJrlzDlZ+ionuMy+N2L5JM0U93PU8tzxH5ktEFf60dIjCJXW
         c9bKWsn3vs8QSZAkevwXV9vX0+IznIzSmmX4pnxgkCYZQnuY4pXsjxS4u+Gbib6D3+az
         MQKQ==
X-Gm-Message-State: ACrzQf2nw+HOqM/jDdZDfO6ZkKU0sP6g4BAJcBOaSOfFhEsoE40k27YQ
        6vGQsurnU81FdRfcvpx4FU4BmQ==
X-Google-Smtp-Source: AMsMyM4Ns1LVB+0LABBHOJzWrjQNzMAUk0lZthXzQw3TR/Rcm2joh9j3MHvMTSFHaR/HR+59oKPNuw==
X-Received: by 2002:a17:902:8a90:b0:186:b145:f5ec with SMTP id p16-20020a1709028a9000b00186b145f5ecmr37462611plo.103.1667587137752;
        Fri, 04 Nov 2022 11:38:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d17-20020aa797b1000000b0056bcc744bdbsm2957812pfq.203.2022.11.04.11.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 11:38:57 -0700 (PDT)
Date:   Fri, 4 Nov 2022 11:38:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net, gwendal@chromium.org,
        apronin@chromium.org, Pavel Machek <pavel@ucw.cz>,
        Matthew Garrett <mgarrett@aurora.tech>,
        linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        zohar@linux.ibm.com, dlunev@google.com,
        Eric Biggers <ebiggers@kernel.org>,
        Ben Boeckel <me@benboeckel.net>, jarkko@kernel.org,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 07/11] PM: hibernate: Add kernel-based encryption
Message-ID: <202211041135.EAC889BA08@keescook>
References: <20221103180120.752659-1-evgreen@chromium.org>
 <20221103105558.v4.7.Ifff11e11797a1bde0297577ecb2f7ebb3f9e2b04@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103105558.v4.7.Ifff11e11797a1bde0297577ecb2f7ebb3f9e2b04@changeid>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Nov 03, 2022 at 11:01:15AM -0700, Evan Green wrote:
> [...]
> +config ENCRYPTED_HIBERNATION
> +	bool "Encryption support for userspace snapshots"
> +	depends on HIBERNATION_SNAPSHOT_DEV
> +	depends on CRYPTO_AEAD2=y
> +	default n

"default n" is the, err, default, so this line can be left out.

If someone more familiar with the crypto pieces can review the rest,
that would be good. :)

-- 
Kees Cook
