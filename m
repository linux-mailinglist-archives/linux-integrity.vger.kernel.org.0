Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFF2627395
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Nov 2022 00:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbiKMXrM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 13 Nov 2022 18:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiKMXrL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 13 Nov 2022 18:47:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC61BF79;
        Sun, 13 Nov 2022 15:47:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82F37B80CC2;
        Sun, 13 Nov 2022 23:47:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74760C433D6;
        Sun, 13 Nov 2022 23:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668383227;
        bh=sTQ+ydYWVemOPSCEQW3WV6b08jB8FPMJHxsu9Hmd25M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jYYqcBYD02plh277+Tatc358hT4bdbZ2Qe4pkvImiCqx7xeKhkgJZniTpbp23MLrU
         a9aMKIRZ4KMQvIc0Imzzu7KaFvE4de5IKU/lZmL7knIHc4XlscuXs5+nW4f8FJ2Hdu
         3QFvUkHl3I6iqDc86NtV1QVuQRALcERZT3oOC0LNNTcCqyxWulLpWj/slsqVOVNHEB
         iBaXDNeouqf4Oup3cgw4+ZAN665uDxiU+LoDn287gkgpfeobk+s88xKfQWUgDakTuN
         NXIU2GsX6AfG547l5abUZ4+vSTo0QrioYAwVtbb0F/KP1Nut+wkul2iDq6X1ts6yRM
         Rce5biN3fLtRg==
Date:   Sun, 13 Nov 2022 15:47:04 -0800
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
        Matthew Garrett <mjg59@google.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v5 10/11] PM: hibernate: Verify the digest encryption key
Message-ID: <Y3GB+CXfAWnV/3qH@sol.localdomain>
References: <20221111231636.3748636-1-evgreen@chromium.org>
 <20221111151451.v5.10.I504d456c7a94ef1aaa7a2c63775ce9690c3ad7ab@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111151451.v5.10.I504d456c7a94ef1aaa7a2c63775ce9690c3ad7ab@changeid>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Nov 11, 2022 at 03:16:35PM -0800, Evan Green wrote:
> We want to ensure that the key used to encrypt the digest

What is meant by "the key used to encrypt the digest"?

> was created by
> the kernel during hibernation. To do this we request that the TPM
> include information about the value of PCR 23 at the time of key
> creation in the sealed blob. On resume, we can make sure that the PCR
> information in the creation data blob (already certified by the TPM to
> be accurate) corresponds to the expected value. Since only
> the kernel can touch PCR 23, if an attacker generates a key themselves
> the value of PCR 23 will have been different, allowing us to reject the
> key and boot normally instead of resuming.

It seems that PCR 23 is already included in the authorization policy for the
key, so why is this extra part needed?

- Eric
