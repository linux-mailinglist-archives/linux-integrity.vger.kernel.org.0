Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9648223FA3
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Jul 2020 17:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgGQPfQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Jul 2020 11:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgGQPfP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Jul 2020 11:35:15 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF43C0619D2;
        Fri, 17 Jul 2020 08:35:15 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id e18so7691391ilr.7;
        Fri, 17 Jul 2020 08:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jWFR5o+rLcHr6gQ9i4ZRMRc2XwQllNXVeyLEXvcDyqU=;
        b=thN/THn4iUNzs7Zw+EhsCXiABO9WgEv1JIQa2OlXRKhXBasNjdSR+etGHN0QPWhtj3
         NmNM+K5g3pqD6vzmdFUsryVGDBFX1CRqmZ27lCJLTwh+jptu5E3hYnQR7Ifh2MnHHgYe
         MLKlAP8gsJYvj0bhoruVQ2nM/N48lQmpaWKHYJE7QB1uB9Wp6taMWOPEGYji7zf/73+F
         WyWUBb3K9w9KV1S6JoUPxFcSlvIetYP8UwxXcyciNowCt9dqamlhYRP2plYJi8AjLn7m
         3GCKBnA/nu3LmHozF41mEJ+laXapFqHNm8OS+2k5AxhCXW4p528BAuBps7wCs7Y1ymOG
         NfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jWFR5o+rLcHr6gQ9i4ZRMRc2XwQllNXVeyLEXvcDyqU=;
        b=ZYk69al5zENQNe4EblfBguqH4Px7BijmFnAz5W+z3IEowINuHesDxUBOojiSSPq+Bt
         JYg89QEpuSNXf6pWJ8NP4t9Jhe9FOxZGD3G6U9vVmnBgU74lHItGRUPaWUPqRgWr1WSD
         Nm7cposUhnIYpgWM3J4nsQLGncf19cm9YMoC3/HEUpZ/v/xjuX4SDXKsPPE9JVshnvoN
         shdC6t4Rzd/tLLPN8GBHSRoPWx7XxvyvqayK8J6Xy+iwaMpghhSzrfi7o5VVreJM9UX7
         MfULURQ5srvnDReNf4e+1gUYRAt3yxg63XP/B4+btUc8uEYZkGFMP8jR1QpW96NT89NI
         wWdw==
X-Gm-Message-State: AOAM532QT28hSep7AxZqP23cg5lYJcaloyo44dFrHkDGjRnxn02AKrnk
        9qZm/PiFRn9vI6WIPaNFPixQi9ijkhgxWXlHhFg=
X-Google-Smtp-Source: ABdhPJxHE7aaEDjc30un5GGc1JQ0IJZaN/KWa3ptEgEKy/F2F3Su9D/D3HY6ZCO1lM/KMTGhQ2KEcYqpdIm1NWqjCfM=
X-Received: by 2002:a92:d84d:: with SMTP id h13mr10902476ilq.102.1595000114409;
 Fri, 17 Jul 2020 08:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200709061911.954326-1-tyhicks@linux.microsoft.com> <20200709061911.954326-9-tyhicks@linux.microsoft.com>
In-Reply-To: <20200709061911.954326-9-tyhicks@linux.microsoft.com>
From:   Konsta Karsisto <konsta.karsisto@gmail.com>
Date:   Fri, 17 Jul 2020 18:35:03 +0300
Message-ID: <CAAEqDhD-wCGY7ykjSsNgCri4ykWPi9cP3j1zoQPWddB4r92Kqw@mail.gmail.com>
Subject: Re: [PATCH v3 08/12] ima: Shallow copy the args_p member of
 ima_rule_entry.lsm elements
To:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

Found one glitch with this change, see below:

On Thu, Jul 9, 2020 at 9:22 AM Tyler Hicks <tyhicks@linux.microsoft.com> wrote:
>
> The args_p member is a simple string that is allocated by
> ima_rule_init(). Shallow copy it like other non-LSM references in
> ima_rule_entry structs.
>
> There are no longer any necessary error path cleanups to do in
> ima_lsm_copy_rule().
>
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> ---
>
> * v3
>   - No change
> * v2
>   - Adjusted context to account for ima_lsm_copy_rule() directly calling
>     ima_lsm_free_rule() and the lack of explicit reference ownership
>     transfers
>   - Added comment to ima_lsm_copy_rule() to document the args_p
>     reference ownership transfer
>
>  security/integrity/ima/ima_policy.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 9842e2e0bc6d..b02e1ffd10c9 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -300,10 +300,13 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
>                         continue;
>
>                 nentry->lsm[i].type = entry->lsm[i].type;
> -               nentry->lsm[i].args_p = kstrdup(entry->lsm[i].args_p,
> -                                               GFP_KERNEL);
> -               if (!nentry->lsm[i].args_p)
> -                       goto out_err;
> +               nentry->lsm[i].args_p = entry->lsm[i].args_p;
> +               /*
> +                * Remove the reference from entry so that the associated
> +                * memory will not be freed during a later call to
> +                * ima_lsm_free_rule(entry).
> +                */
> +               entry->lsm[i].args_p = NULL;

This assignment necessitates a change in the code below...

>                 security_filter_rule_init(nentry->lsm[i].type,
>                                           Audit_equal,
> @@ -314,11 +317,6 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
>                                 (char *)entry->lsm[i].args_p);

... you should refer to nentry->lsm[i].args_p here!

Other than that,

Reviewed-by: Konsta Karsisto <konsta.karsisto@gmail.com>


Konsta

>         }
>         return nentry;
> -
> -out_err:
> -       ima_lsm_free_rule(nentry);
> -       kfree(nentry);
> -       return NULL;
>  }
>
>  static int ima_lsm_update_rule(struct ima_rule_entry *entry)
> --
> 2.25.1
>
