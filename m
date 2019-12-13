Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3C6A11DDD4
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Dec 2019 06:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732048AbfLMFkV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Dec 2019 00:40:21 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41445 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfLMFkU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Dec 2019 00:40:20 -0500
Received: by mail-lj1-f195.google.com with SMTP id h23so1246886ljc.8
        for <linux-integrity@vger.kernel.org>; Thu, 12 Dec 2019 21:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DkSPsot3GXRYYdZ3U5uWzHwAnyLiFJ6kkLCQgA1k8o4=;
        b=cXGL4ydZX8/vHkWbZlXDFb6QUPU86j6+rcDO01I2nSZWqW2qiiBSsa0f7f1lwU7lx9
         nOZpzt3NaSKO7xlWKuYtsIM7SkHxbSY6zUTeX4qJesAX7H2g3bC8gaLxZZgsgoZGf9ZW
         uusq70oiAyhl/4d3sIHVPsIVY1l3bjjtDKhr6uvAK25kLHbBkPwDilzEPgoLG+OJ/g2q
         WP+CUmaEM762ronafLYsb41jTYRRYplV20Ta1/vZlmNbd9iqWmwj1WOL38zx363xxXnx
         QKURuf27i1qJiyOB2Ce2ox7l65jV+gP0DBJLlSKh9WXbDQSyH4C31J18vaUTF66fHX8f
         WpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DkSPsot3GXRYYdZ3U5uWzHwAnyLiFJ6kkLCQgA1k8o4=;
        b=mupbbg0CPx/xiqRErjkT+PB9f1JyDgfIZ4fY09nUkgs84mDW3E3NPA5iX70rdYGKVA
         /RnGmYo2QqkxQI5XEQP97mooCQZwaWKCjBOmbp95tVCMHpOJyTdaQbz5GAQ1+jIzBsUC
         j+4XcM45kOEDdofkfaQUQoZmgui4t0YPJQ/l/92hm1i7nymGdElx4jZbLFHKlloS1E+t
         Y2j+fOfixWtHC1ZYuqk08z3BQjJQ6bedBA6k71CspHkN1m5wfZfJ17/hgKs1inj3F9cm
         up0Df5JUHQenfNzYGqFnrRkjyMwfaqjZmJ843zUYfvZuuGpdTC73n1EePDJuhLUX6cFk
         U44A==
X-Gm-Message-State: APjAAAXJetG59xVIlORAUYLgWDLUP6mtkZz8VMBG+8WcqIAdntLYU1Bl
        8dVgv4osDuXvQPAHI4+wAyOCz9ILod4tJcVNvY+b5HY5
X-Google-Smtp-Source: APXvYqx0SEY+iOMA1jgQlzSYw6fDxaTHq5PPq8BQydtz1KszgiKcgNKETDBy/GeGXok/jb6u2daDTw7P4f+QiVE/N3E=
X-Received: by 2002:a2e:8544:: with SMTP id u4mr8116610ljj.191.1576215618510;
 Thu, 12 Dec 2019 21:40:18 -0800 (PST)
MIME-Version: 1.0
References: <1576173515.15886.7.camel@HansenPartnership.com>
In-Reply-To: <1576173515.15886.7.camel@HansenPartnership.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 13 Dec 2019 11:10:05 +0530
Message-ID: <CAFA6WYMpVDN9n4aVJQ+UU6gstKJjnPnSmJmkMJ8pS9dsgOcVmw@mail.gmail.com>
Subject: Re: [PATCH URGENT FIX] security: keys: trusted: fix lost handle flush
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 12 Dec 2019 at 23:28, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> The original code, before it was moved into security/keys/trusted-keys
> had a flush after the blob unseal.  Without that flush, the volatile
> handles increase in the TPM until it becomes unusable and the system
> either has to be rebooted or the TPM volatile area manually flushed.
> Fix by adding back the lost flush, which we now have to export because
> of the relocation of the trusted key code may cause the consumer to be
> modular.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Fixes: 2e19e10131a0 ("KEYS: trusted: Move TPM2 trusted keys code")
>

Overall looks good to me with following minor comment.

> ---
>  drivers/char/tpm/tpm.h                    | 1 -
>  drivers/char/tpm/tpm2-cmd.c               | 1 +
>  include/linux/tpm.h                       | 1 +
>  security/keys/trusted-keys/trusted_tpm2.c | 1 +
>  4 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index b9e1547be6b5..5620747da0cf 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -218,7 +218,6 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
>  int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
>                     struct tpm_digest *digests);
>  int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max);
> -void tpm2_flush_context(struct tpm_chip *chip, u32 handle);
>  ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,
>                         u32 *value, const char *desc);
>
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index fdb457704aa7..13696deceae8 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -362,6 +362,7 @@ void tpm2_flush_context(struct tpm_chip *chip, u32 handle)
>         tpm_transmit_cmd(chip, &buf, 0, "flushing context");
>         tpm_buf_destroy(&buf);
>  }
> +EXPORT_SYMBOL_GPL(tpm2_flush_context);
>
>  struct tpm2_get_cap_out {
>         u8 more_data;
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 0d6e949ba315..03e9b184411b 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -403,6 +403,7 @@ extern int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
>  extern int tpm_send(struct tpm_chip *chip, void *cmd, size_t buflen);
>  extern int tpm_get_random(struct tpm_chip *chip, u8 *data, size_t max);
>  extern struct tpm_chip *tpm_default_chip(void);
> +void tpm2_flush_context(struct tpm_chip *chip, u32 handle);

Shouldn't this be declared as "extern" similar to other APIs? Also, I
think we need "#else" part for this API as well.

-Sumit

>  #else
>  static inline int tpm_is_tpm2(struct tpm_chip *chip)
>  {
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index a9810ac2776f..08ec7f48f01d 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -309,6 +309,7 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
>                 return rc;
>
>         rc = tpm2_unseal_cmd(chip, payload, options, blob_handle);
> +       tpm2_flush_context(chip, blob_handle);
>
>         return rc;
>  }
> --
> 2.16.4
>
