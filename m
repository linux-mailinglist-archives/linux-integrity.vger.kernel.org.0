Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5B493345F
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Jun 2019 17:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbfFCP5w (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Jun 2019 11:57:52 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41311 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfFCP5w (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Jun 2019 11:57:52 -0400
Received: by mail-lf1-f68.google.com with SMTP id 136so2484941lfa.8
        for <linux-integrity@vger.kernel.org>; Mon, 03 Jun 2019 08:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dUIziqCaWwis11FMwxs4RVtYQ55XI7b2gVYUu/408e4=;
        b=Y9F5pclKlBDwBsGlUcTkFo2gE0Lxa9w08Yi6C3Mbtmu/srmp1rs9zU93TrlT9tgQfK
         w1ylShU+Ekv0VietSgqGx05CQtDkHwJOghI4QVY1lsw3x6VspFDaorn0ZQDEkytyQJ4m
         C7Awrm7vc+GExhX+DrlE4GlGbcPuNCJS58WFf8fWwsSRrNhQ4ZOC6FHBouceunr/SkGT
         LUXSnwrkPkw4p4+CzVuH1bzwMI3/tDtsG3n4Cz3aGamKcKzR5Vuw2O25bnPA6nuWy6Fc
         AtQZbjcyBkoAmfms8Qe6xJa32tiH32IbgjqMTi5KzCJqYFgkgTKSzw4Tgle403rRmy0e
         eioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dUIziqCaWwis11FMwxs4RVtYQ55XI7b2gVYUu/408e4=;
        b=jOg2WHyVw3lSAkVywDnSOOfAtROX41u8C/jIXKfZhxEOpPwu387kmxXfphpTtgea8A
         jJZqsNin6UW+981pbP1UwmXAZ5hgbR3Rlkn1OSB7DV+5h60cDOxUkZ9s1qQxuMA+f8Ue
         MySwXTuRfyw6wc7csChTOAxsX0HQ1kFb0dOefp1HZRRMoLNhHYTGg9xTLwh/qem77M53
         L0IegDZIx9CsYEzv10p6JzQVPZlsutGsaoUEL+IlpMpp+e5uAzgKZOH7/VkI3w6ocweB
         N6zWONRPSHPgxFtiZvxu1JG3VzyhIkKI0S0szI1IxP0LQ0IGsD/wzz5mnkO64M4WQa0U
         MBzg==
X-Gm-Message-State: APjAAAWQ8bRbsupdr6Mh4xU2eYRUb5+968rrmWxN3ldrkESDENnhDhta
        TE3jaBDzInUiMV7NDQFBjnFEEfl/FPuhPZIr9BTk
X-Google-Smtp-Source: APXvYqyIjVbFfm6bTAY+PP8RHZbzsFMuXP1lJL7n3NHTAvCY8HdOf04hV+rUc65GZ60suBUkENcT3xTGX2zIASzg8DA=
X-Received: by 2002:ac2:410a:: with SMTP id b10mr13586267lfi.175.1559577470486;
 Mon, 03 Jun 2019 08:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190531140237.9199-1-janne.karhunen@gmail.com>
In-Reply-To: <20190531140237.9199-1-janne.karhunen@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 3 Jun 2019 11:57:38 -0400
Message-ID: <CAHC9VhSJ9GnUqU4cj-OzWinGndgLOHrhtmeayLG2f3iow1Tptg@mail.gmail.com>
Subject: Re: [PATCH 1/2] LSM: switch to blocking policy update notifiers
To:     Janne Karhunen <janne.karhunen@gmail.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, May 31, 2019 at 10:03 AM Janne Karhunen
<janne.karhunen@gmail.com> wrote:
> Atomic policy updaters are not very useful as they cannot
> usually perform the policy updates on their own. Since it
> seems that there is no strict need for the atomicity,
> switch to the blocking variant.
>
> Signed-off-by: Janne Karhunen <janne.karhunen@gmail.com>
> ---
>  security/security.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/security/security.c b/security/security.c
> index 23cbb1a295a3..c5e69ce81521 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -39,7 +39,7 @@
>  #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
>
>  struct security_hook_heads security_hook_heads __lsm_ro_after_init;
> -static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
> +static BLOCKING_NOTIFIER_HEAD(lsm_notifier_chain);
>
>  static struct kmem_cache *lsm_file_cache;
>  static struct kmem_cache *lsm_inode_cache;
> @@ -432,19 +432,19 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>
>  int call_lsm_notifier(enum lsm_event event, void *data)

As I mentioned in the other thread, I would like to see "blocking", or
similar, added to the lsm_notifier functions with this change.  It
makes it easier if/when we need to add both atomic and blocking
variants, as well as making it much more clear which version is being
used (helpful even now with just one variant).

For example: call_lsm_notifier() -> call_lsm_blocking_notifier(),
register_lsm_notifier() -> register_lsm_blocking_notifier().

>  {
> -       return atomic_notifier_call_chain(&lsm_notifier_chain, event, data);
> +       return blocking_notifier_call_chain(&lsm_notifier_chain, event, data);
>  }
>  EXPORT_SYMBOL(call_lsm_notifier);
>
>  int register_lsm_notifier(struct notifier_block *nb)
>  {
> -       return atomic_notifier_chain_register(&lsm_notifier_chain, nb);
> +       return blocking_notifier_chain_register(&lsm_notifier_chain, nb);
>  }
>  EXPORT_SYMBOL(register_lsm_notifier);
>
>  int unregister_lsm_notifier(struct notifier_block *nb)
>  {
> -       return atomic_notifier_chain_unregister(&lsm_notifier_chain, nb);
> +       return blocking_notifier_chain_unregister(&lsm_notifier_chain, nb);
>  }
>  EXPORT_SYMBOL(unregister_lsm_notifier);
>
> --
> 2.17.1
>


-- 
paul moore
www.paul-moore.com
