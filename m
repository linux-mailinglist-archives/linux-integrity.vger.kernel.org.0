Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACBAB41DF0A
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Sep 2021 18:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351117AbhI3Qbv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Sep 2021 12:31:51 -0400
Received: from smtp1.axis.com ([195.60.68.17]:29236 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350390AbhI3Qbu (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Sep 2021 12:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1633019408;
  x=1664555408;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YKTWABdQZqR7HaqaZXw25w4v3fuWDZ8wcygmkT5L9KE=;
  b=In0RHO6X0Ljc+WPYCnb+Unb6wlv4tP/HAl9AfldNUHwqK9LVqL8N0Pbk
   MPmydedDLHiSMtWwf7tsEdBpBYbw2LZXMAMP+lCyayK6ZJWDWUoVFA0qr
   5q8gEj4+2MQdMWsy7rOsiJB9OaPSKAa2rq1QgYB6G/3Okcmx49dmS57ZV
   M6AyCYZDqafnXfhL1h1Gu/LOzsARl2W/9D+8n8k+V72X8tQklw8hW10Cc
   sjhB1REneSRurGl/dyhOj7ZWTOSfSLnm4n6BLKmfAkKNhNCntlqjAWK/R
   qfJWX9nVU1Cut1lvTf8wZt1q7Mw59qZ6OWn9+uw1KK3i3+t6UXZHJQk6h
   A==;
Date:   Thu, 30 Sep 2021 18:30:05 +0200
From:   Borys Movchan <borysmn@axis.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        kernel <kernel@axis.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6] tpm: Add Upgrade/Reduced mode support for TPM2 modules
Message-ID: <20210930163005.yd4mfqybetorx5f5@lnxborysmn.se.axis.com>
References: <20210930160241.9691-1-borysmn@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210930160241.9691-1-borysmn@axis.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail04w.axis.com (10.20.40.10) To se-mail07w.axis.com
 (10.20.40.13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Coming back to my change, a quick reminder of the latest questions and some
updated answers:

> > If detected that the TPM is in the Upgrade or Failure mode, the function
> > sets TPM_CHIP_FLAG_LIMITED_MODE flag.
>
> Does this apply for TPM 1.2? Are there differences?

As I mentioned earlier, I am not familiar with TPM 1.2. However, to
generalize the answer, such a state, like a firmware upgrade does make
sense on TPM 1.2. From what I know it is performed using different calls
to TPM but the concept is there.

> Maybe for consistency call it TPM_CHIP_FLAG_UPGRADE_MODE? It makes easier
> to "connect dots" later on (has probably something to do TPM_RC_UPGRADE).

Reconsidered and implemented appropriate change. See the patch.

> > -     if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> > +     if (chip->flags & TPM_CHIP_FLAG_TPM2 && !(chip->flags & TPM_CHIP_FLAG_LIMITED_MODE)) {
>
> You cannot rely on validity of TPM_CHIP_FLAG_TPM2, as tpm_tis driver
> uses a TPM command to probe the TPM version.

I never intended to relay on TPM_CHIP_FLAG_TPM2. In this case the point
to avoid calling cdev_device_add if the chip is not TPM2 or is in
firmware Upgrade/Recovery mode.

> >        rc = tpm2_get_cc_attrs_tbl(chip);
> > +     if (rc) {
>
> Why all rc's apply?

The standard doesn't specify what RC should be returned if TPM is in
Recovery mode. What the standard agrees on is that the underlying call
will fail.

> > +             dev_info(&chip->dev, "TPM is in failure mode, functionality limited\n");
>
> Here is again a different name for the same thing (different than
> TPM_CHIP_FLAG_LIMITED_MODE).

The logic behind this check goes like that: Assume that if we reached
this point TPM is not in Upgrade mode. Although, it can still be in
Recovery mode. If the tpm2_get_cc_attrs_tbl() call fails, then my
assumption is that TPM requires firmware recovery.

This mode is introduced to handle situations when TPM firmware Upgrade
failed. In such a case TPM allows to flash only original firmware to bring
the functionality back. There is a predefined list of calls to which TPM
is going to answer in this mode. Responses to other calls are vendor-dependent.

Another assumption here is that if for some reason there is a communication
error occurred at this point it will be caught here. Any better ideas
on how to handle this are welcome.

--
Kind regards,
Borys
