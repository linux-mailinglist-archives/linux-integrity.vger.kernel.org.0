Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FEE614EC8
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Nov 2022 17:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiKAQFP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Nov 2022 12:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKAQFN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Nov 2022 12:05:13 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5689763DE
        for <linux-integrity@vger.kernel.org>; Tue,  1 Nov 2022 09:05:11 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id kt23so38148322ejc.7
        for <linux-integrity@vger.kernel.org>; Tue, 01 Nov 2022 09:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I/cb3fLlP4r0R6IO3o2dl3Vt5UxkO9Zjm9AlKSl8wdY=;
        b=skDq99Zb3UdScH8gh0j1/FFXAxIpFUbs19hVzeskkLnfssZatyrNs80QUjs4iEySUe
         eAo+WJoe+VCWfoGW6zVIifud9HDndBt7c0mgsK+GFzC+O1Sls/Pj5wd8mYFeRmAy4XPF
         TJeB6dBDl/KV2jrYbFNAvnu+qv5RvpRa82FdtgpEgvkmdaUrb2YrBFg94O+7HHfHhljr
         MnL/Fprx0naHzVql1157LtnmqG311Ft/sftQCuxdQ946w/+8rXBkPRWiCqdYcqjfXO0s
         gQMpaXRQUU9MOXcoMwE7qhQNLx2PzTiO7VX2LZXxrP+ILB4XiOkjNM0tc7p5tVOFCMAx
         houQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/cb3fLlP4r0R6IO3o2dl3Vt5UxkO9Zjm9AlKSl8wdY=;
        b=Py5zfan0owInNlc9s/6IvBhVS1tcxby4w/hn5dTOgJh8pF4NuSwq5/+KvrkTLpQAIb
         +Xr613XsZxswT8EcvkupC8sECpMj1q8AmMYUXn74vybh3J6TIs1ri5/6gVqySqg37A3A
         VL63at8d2+BOaXAYpbyNNy62jgXvn9YX5i6klD1vmkCX0p06LRyDKkpnKVH3BwhHafxX
         eKnBBTUH9HDxuR/v3Gd6mXPJKKCWjeoKf9CrbtlgkSS+6lBA1QdfwwBMtlWF7AnL0JYz
         KLpiS6Dacn1llA4iIQgLp0i9WPTiL96F1ocX6I8BX8iNM7Gp7FTeUBLLGcktVWikTrMY
         eNpw==
X-Gm-Message-State: ACrzQf05KL12PHJ6g/xw7iuBfBxlvh2RZDzpznYGWq4Il0j436MvyJdk
        cSPj7BZmaHmzmMQXGtgsathJpd18L74PgO6LeX7F8Q==
X-Google-Smtp-Source: AMsMyM4CH+SD2K6EdqyO34b6d0wZs9I0Ed+dneTLw+Okscj4Br5m5Dsw5C0L/Cqv9iwoY9r8L9osJ0SQCgUWpRiEPn4=
X-Received: by 2002:a17:906:6a1b:b0:7ad:ba1e:879b with SMTP id
 qw27-20020a1709066a1b00b007adba1e879bmr15806485ejc.311.1667318709512; Tue, 01
 Nov 2022 09:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221101020352.939691-1-jsd@semihalf.com> <20221101020352.939691-3-jsd@semihalf.com>
In-Reply-To: <20221101020352.939691-3-jsd@semihalf.com>
From:   Tim Van Patten <timvp@google.com>
Date:   Tue, 1 Nov 2022 10:04:58 -0600
Message-ID: <CANkg5ezwYT+ZsiRDW9fe1m4vyncOEDFamq0jXTxmWO37d4i3Nw@mail.gmail.com>
Subject: Re: [PATCH 2/3] char: tpm: cr50: Use generic request/relinquish
 locality ops
To:     Jan Dabros <jsd@semihalf.com>
Cc:     linux-integrity@vger.kernel.org, jarkko@kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, gregkh@linuxfoundation.org,
        arnd@arndb.de, rrangel@chromium.org, apronin@google.com,
        mw@semihalf.com, upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Oct 31, 2022 at 8:04 PM Jan Dabros <jsd@semihalf.com> wrote:
>  /**
> - * tpm_cr50_check_locality() - Verify TPM locality 0 is active.
> + * tpm_cr50_check_locality() - Verify if required TPM locality is active.
>   * @chip: A TPM chip.
> + * @loc: Locality to be verified
>   *
>   * Return:
> - * - 0:                Success.
> + * - loc:      Success.
>   * - -errno:   A POSIX error code.
>   */
> -static int tpm_cr50_check_locality(struct tpm_chip *chip)
> +static int tpm_cr50_check_locality(struct tpm_chip *chip, int loc)
>  {
>         u8 mask = TPM_ACCESS_VALID | TPM_ACCESS_ACTIVE_LOCALITY;
>         u8 buf;
>         int rc;
>
> -       rc = tpm_cr50_i2c_read(chip, TPM_I2C_ACCESS(0), &buf, sizeof(buf));
> +       rc = tpm_cr50_i2c_read(chip, TPM_I2C_ACCESS(loc), &buf, sizeof(buf));
>         if (rc < 0)
>                 return rc;
>
>         if ((buf & mask) == mask)
> -               return 0;
> +               return loc;
>
>         return -EIO;
>  }

Why is it useful to return the same `loc` value that was passed in,
rather than just returning `0`? The caller already knows the value of
`loc`, so they aren't being told anything new.

I think this should continue to return `0` for success.


> - * tpm_cr50_request_locality() - Request TPM locality 0.
> + * tpm_cr50_request_locality() - Request TPM locality.
>   * @chip: A TPM chip.
> + * @loc: Locality to be requested.
>   *
>   * Return:
> - * - 0:                Success.
> + * - loc:      Success.

Same as above. Return `0`.

> @@ -374,7 +386,9 @@ static u8 tpm_cr50_i2c_tis_status(struct tpm_chip *chip)
>  {
>         u8 buf[4];
>
> -       if (tpm_cr50_i2c_read(chip, TPM_I2C_STS(0), buf, sizeof(buf)) < 0)
> +       WARN_ONCE((chip->locality < 0), "Incorrect tpm locality value\n");

For each of these ` WARN_ONCE((chip->locality < 0), ...).`, can it
return immediately rather than attempting to continue using an invalid
locality value? Do the following commands have a chance of succeeding
with the invalid value?

-- 

Tim Van Patten | ChromeOS | timvp@google.com | (720) 432-0997
