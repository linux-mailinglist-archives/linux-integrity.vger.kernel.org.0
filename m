Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643D547D426
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Dec 2021 16:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237677AbhLVPOu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Dec 2021 10:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbhLVPOt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Dec 2021 10:14:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825D0C061574
        for <linux-integrity@vger.kernel.org>; Wed, 22 Dec 2021 07:14:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE679B81C15
        for <linux-integrity@vger.kernel.org>; Wed, 22 Dec 2021 15:14:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F409C36AE5;
        Wed, 22 Dec 2021 15:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640186086;
        bh=nUjCwmf8SSNTMrQzrlXBhIUByzrrLSrL9RF1vc6ABZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qg2YDKXd4x4ayyEcBa8Yk+IfpuFrlCaR/yYgFhQoa6/3ivGRBqtIgVs1codtcTa/z
         oP6z2IfRUhtRjE2DGe63Dfedidxn7Q2lq4B12rg28Dp/VzQ8oWth1mBtrL++aRxYCj
         fghMdtmyEsKf9YrQUVDhQamYMdCiwenQS0zMNyb4GGo6t8OMk8s2NtKAD972GMK5wh
         G8nhx+eeFi8QgJHvPK2a5Num/TVormPiJptZdtOcIIKcHVMFj/f8cr3VrJUD1+30mO
         WOX8MbMKQOAdcIYZBGDJtZBi+I9X3EU7hgfnA5NkhrVRJrSRcCniw7BbpuWhQr9jM0
         kbTvGdoCHuauw==
Date:   Wed, 22 Dec 2021 09:14:43 -0600
From:   Eric Biggers <ebiggers@kernel.org>
To:     Yael Tiomkin <yaelt@google.com>
Cc:     ltp@lists.linux.it, zohar@linux.ibm.com, pvorel@suse.cz,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] syscalls/keyctl09: test encrypted keys.
Message-ID: <YcNA4w6mof+zKIak@quark>
References: <20211221023721.129689-1-yaelt@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221023721.129689-1-yaelt@google.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Dec 20, 2021 at 09:37:21PM -0500, Yael Tiomkin wrote:
> diff --git a/testcases/kernel/syscalls/keyctl/keyctl09.c b/testcases/kernel/syscalls/keyctl/keyctl09.c
> new file mode 100644
> index 000000000..507cd5628
> --- /dev/null
> +++ b/testcases/kernel/syscalls/keyctl/keyctl09.c
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2021 Google, Inc.
> + */
> +
> +/*\
> + * [Description]
> + * Test that encrypted keys can be instantiated using user-provided decrypted
> + * data (plaintext), and separately, using kernel-generated key material.
> + */
> +

This test doesn't seem to work as intended.

First, it fails if CONFIG_ENCRYPTED_KEYS is unset (it should be skipped):

	keyctl09.c:33: TFAIL: Failed to instantiate encrypted key using payload decrypted data

Second, I don't have your patch "Instantiate key with user-provided decrypted
data" (https://lore.kernel.org/r/20211213192030.125091-1-yaelt@google.com) in my
kernel, so instantiating a key using "user-provided decrypted data" is not
implemented by the kernel.  However, the test still passes regardless:

	keyctl09.c:49: TPASS: Encrypted keys were successfully instantiated and read    

The test should detect when "user-provided decrypted data" is not supported by
the kernel, and report that the test of that is being skipped in that case.

- Eric
