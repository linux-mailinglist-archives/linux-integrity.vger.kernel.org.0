Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCB11F0072
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jun 2020 21:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgFETiF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Jun 2020 15:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbgFETiF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Jun 2020 15:38:05 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C75FC08C5C3
        for <linux-integrity@vger.kernel.org>; Fri,  5 Jun 2020 12:38:04 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id mb16so11367190ejb.4
        for <linux-integrity@vger.kernel.org>; Fri, 05 Jun 2020 12:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eOF1BRH3hqUoMNIFRgJb8qWo4oAn8/8kkqpSwUrcV0E=;
        b=yLfHIAagpugDB4geFiVAXJJTQZXB+jW2HjJpn1vVvldz+/22CHGCzrUNeAIPsbbOvS
         Vj0WWKVboNAgnySpxH8lKz1enjBLbx+U5WnUNrph8o3tPLdFlnq4xLjeFaiD7zPvZ1HI
         E8vYm7qpO0BZDhJ5aa3p4Z+TUaHWun5mYVXiUYGP08452NKK4T0k3te3woXIIPw9YBVE
         a0T4s5ywxePv/JEhyEsXaKRaDhNAcQU2hG19R8cToaq5nYYP1zWYwiHczsHKzCW6EgA9
         q6UTJD57gk60CAfMC6sMGWtxCUx2KdpUpGUH6a4iVzNYkxQ8OyDLll7pBr07DdJfQFZI
         X9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eOF1BRH3hqUoMNIFRgJb8qWo4oAn8/8kkqpSwUrcV0E=;
        b=T+/T34xWCk4yzfUFBgD1NjP9IjsPzpUOVx10FGHWVBVYkrjjSA6IPWDkneaZdYB+Wi
         N2Hdvq6FNUDXpv/KzXk1hde4V4p/jf4/ApNopMqeGCdAAChaNCzRewoZjTuPGxPz4YgZ
         VbwmQ6DAOOBXNfsfRoqQ0GaFbk0e3iZBlAV0RWy55Ae+gGzNOZj1i9LcAStQOS0G8Ik8
         xSvd2tNZUN/ITQGhiut22MgPVMAaNMIkgEkAYINvhuSkHvw17B9jb59R7bOe/5Zc3Myo
         EQZVdZaGeSw1wFwV4y+GVhKQIkVC0Q1w9+t+l0CdVy53YneikDdvghyUKYPU64dnhQmj
         Xw4w==
X-Gm-Message-State: AOAM532vNfV47WoSdZTV2kirUK28os8ShRGOkH5m4iaMWZ9OMxp+aYZA
        NeeagkQ4jaGPp96Bb+Yfh4hoTdn8eIpaHysszfzt
X-Google-Smtp-Source: ABdhPJynBTUuAesu8TZmhXmvdaQE0Ftl+C+xkFDUiYKUtjaE5qcD7vJ2l61mQAblJihXIT2xzHwpHUX6JZ9vZlZOznI=
X-Received: by 2002:a17:906:e257:: with SMTP id gq23mr9631120ejb.398.1591385882972;
 Fri, 05 Jun 2020 12:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200604163243.2575-1-nramas@linux.microsoft.com> <1591382782.5816.36.camel@linux.ibm.com>
In-Reply-To: <1591382782.5816.36.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 5 Jun 2020 15:37:52 -0400
Message-ID: <CAHC9VhS-EP=Kk3GKRzAGAYa5mqupkLQCHz_m_DgoAKRWcSTgLA@mail.gmail.com>
Subject: Re: [PATCH] IMA: Add log statements for failure conditions
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, tusharsu@linux.microsoft.com,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 5, 2020 at 2:46 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> [Cc'ing Paul Moore]

If it's audit related, it's generally best to CC the linux-audit list,
not just me (fixed).

It's not clear to me what this pr_err() is trying to indicate other
than *something* failed.  Can someone provide some more background on
this message?

> Hi Lakshmi,
>
> On Thu, 2020-06-04 at 09:32 -0700, Lakshmi Ramasubramanian wrote:
> > The final log statement in process_buffer_measurement() for failure
> > condition is at debug level. This does not log the message unless
> > the system log level is raised which would significantly increase
> > the messages in the system log. Change this log message to error level,
> > and add eventname and ima_hooks enum to the message for better triaging
> > failures in the function.
> >
> > ima_alloc_key_entry() does not log a message for failure condition.
> > Add an error message for failure condition in this function.
> >
> > Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>
> These messages should probably be turned into audit messages.  Look at
> integerity_audit_msg().
>
> Mimi
>
> > ---
> >  security/integrity/ima/ima_main.c       | 3 ++-
> >  security/integrity/ima/ima_queue_keys.c | 2 ++
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > index 9d0abedeae77..3b371f31597b 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -756,7 +756,8 @@ void process_buffer_measurement(const void *buf, int size,
> >
> >  out:
> >       if (ret < 0)
> > -             pr_devel("%s: failed, result: %d\n", __func__, ret);
> > +             pr_err("%s failed. eventname: %s, func: %d, result: %d\n",
> > +                    __func__, eventname, func, ret);
> >
> >       return;
> >  }
> > diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
> > index cb3e3f501593..e51d0eb08d8a 100644
> > --- a/security/integrity/ima/ima_queue_keys.c
> > +++ b/security/integrity/ima/ima_queue_keys.c
> > @@ -88,6 +88,8 @@ static struct ima_key_entry *ima_alloc_key_entry(struct key *keyring,
> >
> >  out:
> >       if (rc) {
> > +             pr_err("%s failed. keyring: %s, result: %d\n",
> > +                    __func__, keyring->description, rc);
> >               ima_free_key_entry(entry);
> >               entry = NULL;
> >       }
>


-- 
paul moore
www.paul-moore.com
