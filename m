Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0E0B4C088
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Jun 2019 20:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfFSSJJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Jun 2019 14:09:09 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37705 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfFSSJJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Jun 2019 14:09:09 -0400
Received: by mail-ot1-f65.google.com with SMTP id s20so20265029otp.4;
        Wed, 19 Jun 2019 11:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=7YcByxGXUw5LMc+rlNuhB508AqJoOvFBfjRJvJRAQ7Y=;
        b=oRJsiyoE84TBWpFKdwgGnUjy0ejDq4xWJTDXx5BajtyDJ4RHy5NAAc70RqB1VeiPjs
         B5hCzHUF4bvK5EKQOZUB4xoXM7lyx4LLP2HbDONB016tQpKenc0W0dAhXzRFjGHiBcTk
         vYWY8g6GV/Vch1CLLasHLAPxfNtZMM12CBwrCXcBY8WiPZZmYG87WkDbuLIGxr2/7oFC
         SAlGNP/0PXElpQsyBZC01qwaex0pFV5Aom3Up91zPx4vrxeXZUKST9Vt0B1LWKWyxuu2
         HdwI7trWUinGJD+3l8jCmx8vRTR8LX3xviBQH8MiKbPODTJsBkYTQbshui2KKC51j8AH
         88jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=7YcByxGXUw5LMc+rlNuhB508AqJoOvFBfjRJvJRAQ7Y=;
        b=MEflbk9GIuT09egKeFKZ4KMTxfze5mn6OdSuWl9iu3r959nILtgogGo1u1y0y7+gmK
         V4WmF1VTbf9/WEeGuF5+xVnqBg4pdbggmfpT0cwJrUuMneYZkOBI14VH0kM/gp2OwM9v
         lza6i3UPXIvXZWgwKKubowZxfhVMz5zS25M8hfTC8l3qTPS3j16xGJml240w+vfRc+XI
         QjXV3iAt/ENWhTbmwJGxCwxiQ5T4EBfZNbHJRw13YCdafGdXoTA1EzQXTBJFUE6tQNRn
         vTE5TRIqeNlz4qvi6dMOaobxngd6mFG2Q6qKmRFSeZuenEg9FcyRR5hIIytlYKc7Ynr5
         7hOw==
X-Gm-Message-State: APjAAAU86MC95IBKAzECRYr9jcxMqpshACvJS+HWL5n9S0/odaQWTVEw
        QY0fPtFQg/6fZga1rdJqWkPm5OkVStlBTTDNTbk=
X-Google-Smtp-Source: APXvYqx1IN2EoKUQWCI8vjuPw1ijUb3IvGgsjr+DRMccro7g4XMVK6WzWLdqpOvQHGmGBfeLCbCd3wJlQvNhTbLKtFc=
X-Received: by 2002:a9d:7245:: with SMTP id a5mr32776501otk.232.1560967748321;
 Wed, 19 Jun 2019 11:09:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190617183507.14160-1-prsriva02@gmail.com> <20190617183507.14160-3-prsriva02@gmail.com>
 <1560952466.3975.40.camel@linux.ibm.com>
In-Reply-To: <1560952466.3975.40.camel@linux.ibm.com>
From:   prakhar srivastava <prsriva02@gmail.com>
Date:   Wed, 19 Jun 2019 11:08:56 -0700
Message-ID: <CAEFn8qK9Tg99PA_=Ukm=CwSE6ajjUL2FxLs0ZiVdGLvG_baK_A@mail.gmail.com>
Subject: Re: [PATCH 2/3] IMA:Define a new template field buf
To:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

<snip>
> >       if (iint->measured_pcrs & (0x1 << pcr))
> > diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
> > index 993d0f1915ff..c8591406c0e2 100644
> > --- a/security/integrity/ima/ima_init.c
> > +++ b/security/integrity/ima/ima_init.c
> > @@ -50,7 +50,7 @@ static int __init ima_add_boot_aggregate(void)
> >       struct ima_template_entry *entry;
> >       struct integrity_iint_cache tmp_iint, *iint = &tmp_iint;
> >       struct ima_event_data event_data = {iint, NULL, boot_aggregate_name,
> > -                                         NULL, 0, NULL};
> > +                                         NULL, 0, NULL, NULL, 0};
> >       int result = -ENOMEM;
> >       int violation = 0;
> >       struct {
> >
>
> These changes shouldn't be necessary.  Please rebase these patches on
> top of the latest next-queued-testing branch (git remote update).  "IMA: support for per
> policy rule template formats" is still changing.
>
> Minor nit.  When re-posting the patches please update the patch titles
> so that there is a space between the subsystem name and the patch
> title (eg. "ima: define ...").
>
I believe the above event_data changes are needed, to store/read the
buffer length and buffer itself. The only exception will be if needed will be to
remove ima-buf as a template instead used a template_fmt in the policy
with KEXEC_CMDLINE from the "IMA: support for per
 policy rule template formats" is still changing.".
In my view even ima-buf is needed as it simplifies the usage.

Please let me know if I misunderstood your comment.
> Mimi
>
