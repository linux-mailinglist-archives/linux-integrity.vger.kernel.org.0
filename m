Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D653C4ACCFA
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Feb 2022 02:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbiBHBFN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Feb 2022 20:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240354AbiBGXM6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Feb 2022 18:12:58 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD312C061355;
        Mon,  7 Feb 2022 15:12:56 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id m6so44643795ybc.9;
        Mon, 07 Feb 2022 15:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wQq+mHaX2NTw8edQ1piWfzulWZiGotWvejNP1a/WHXA=;
        b=isfraitWhRGlMJU5yWGEFJjAgZ2h8hn2M0bv6WDAuftAolDZK9XA10xhcXKRl6rb94
         Lu2YTxxxUFK9r4kVpKXZcDqHbNFXAq3M/NQtxWAxWU6Qfs3DCND/pp7uwO7sJosdY4ny
         /9vBtqBd05H+DhwRfXZGfcCiFZKw95XpV45hry9I+TFnZSlDf6+IgPsn8XlxTLfWDuYP
         xQ6LomxeYhe7kxPG7n0kLTv4KpJezzWcSd6u3OOBzs77fI1XZcFw61F5Ta2gwFw6PQS4
         1xG1sL4x+soscQSUxGAPhLyCvhMH//JPqNEnuYqW3eCPFBtjrTbD/yJ/9Qn0kZU5YYtp
         0JnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wQq+mHaX2NTw8edQ1piWfzulWZiGotWvejNP1a/WHXA=;
        b=0Yt7C4eCX+dvddQORyOJi1Neojd8RbYgSbtVGciWbrO6eD3QbQ0t/XHwYSYX893GbW
         JsYuwVrd5jlsG0HJPmBmJnqhQz6ukzbRxoHZ+MFBqo4C5TLmfm4JN02VbHJ7ad/KuLGD
         TILz1rPjUQHXxUMKwHNdwjdEfroEdeNr0l3E1wKRSI96a+Rh+LiTpvqxE8fJ4A0tcFWK
         K9iddeRkz4cvCFoHkBtMNcTgYZLvW29/l53276EUnELV91XxDiK5rtdc54N7udwWXQts
         IE0CrPXQfsclvtaK8xgPor61zBTcQAiiCaYqVvgvB10h/Bh5vdd9FcZgaXEgTcvJO23I
         9rAQ==
X-Gm-Message-State: AOAM531Boi6YKFpXk83oLe5cIbDDWoGOW77f5lX41T/aKuevK4rF7zGl
        kDz7Qdoww8Whbf88ry2pzIlQenEfbjkqKjXcNEBbnGS3i9kEE+vJ
X-Google-Smtp-Source: ABdhPJzVIXzrcgHdMz3A3fRll57H1Ml4LaWjCW0LwWcIaltsCm6YZYIZwy7v3kDRz8E1y6o8uyz5xHiPiu0JAPcWoqE=
X-Received: by 2002:a05:6902:4c2:: with SMTP id v2mr2126067ybs.429.1644275575771;
 Mon, 07 Feb 2022 15:12:55 -0800 (PST)
MIME-Version: 1.0
References: <20220204200342.48665-1-ztong0001@gmail.com> <a45010a4-2b86-aa22-d7bd-3c4839356cf1@pengutronix.de>
In-Reply-To: <a45010a4-2b86-aa22-d7bd-3c4839356cf1@pengutronix.de>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Mon, 7 Feb 2022 15:12:45 -0800
Message-ID: <CAA5qM4BtyFZJfwSjCfoAzMf5jZQNbi6jziPjOm+Z1_c98VEVYg@mail.gmail.com>
Subject: Re: [PATCH] KEYS: trusted: fix crash when TPM/TEE are built as module
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Andreas Rammhold <andreas@rammhold.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Feb 6, 2022 at 2:36 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> Hello Tong,
>
> On 04.02.22 21:03, Tong Zhang wrote:
> > when TCG_TPM and TEE are built as module, trusted_key_sources will be an
> > empty array, loading it won't do what it is supposed to do and unloading
> > it will cause kernel crash.
>
> Jarkko reported picking up an equivalent fix two months ago:
> https://lkml.kernel.org/keyrings/YadRAWbl2aiapf8l@iki.fi/
>
> But it seems to have never made it to Linus.
>
> Cheers,
> Ahmad
>
> >
> > To reproduce:
> > $ modprobe trusted
> > $ modprobe -r trusted
> >
> > [  173.749423] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> > [  173.755268] Backtrace:
> > [  173.755378]  cleanup_trusted [trusted] from sys_delete_module+0x15c/0x22c
> > [  173.755589]  sys_delete_module from ret_fast_syscall+0x0/0x1c
> >
> > To fix this issue, we also need to check CONFIG_TCG_TPM_MODULE and
> > CONFIG_TEE_MODULE.
> >
> > Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
> > Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> > ---
> >  security/keys/trusted-keys/trusted_core.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
> > index d5c891d8d353..b3a3b2f2d4a4 100644
> > --- a/security/keys/trusted-keys/trusted_core.c
> > +++ b/security/keys/trusted-keys/trusted_core.c
> > @@ -27,10 +27,10 @@ module_param_named(source, trusted_key_source, charp, 0);
> >  MODULE_PARM_DESC(source, "Select trusted keys source (tpm or tee)");
> >
> >  static const struct trusted_key_source trusted_key_sources[] = {
> > -#if defined(CONFIG_TCG_TPM)
> > +#if defined(CONFIG_TCG_TPM) || defined(CONFIG_TCG_TPM_MODULE)
> >       { "tpm", &trusted_key_tpm_ops },
> >  #endif
> > -#if defined(CONFIG_TEE)
> > +#if defined(CONFIG_TEE) || defined(CONFIG_TEE_MODULE)
> >       { "tee", &trusted_key_tee_ops },
> >  #endif
> >  };
>
>
> --
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

Hi Ahmad,
Thanks for letting me know.
That fix looks good to me.
- Tong
