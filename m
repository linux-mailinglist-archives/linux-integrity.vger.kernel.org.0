Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8031C193
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2019 06:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbfENExc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 May 2019 00:53:32 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42417 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbfENExb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 May 2019 00:53:31 -0400
Received: by mail-pf1-f196.google.com with SMTP id 13so8421724pfw.9;
        Mon, 13 May 2019 21:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LkOJ6KXC11/Y4FBi0TytGsBTIahyfqyZdKmtY1CFDQ0=;
        b=So8Ue2Gc8rZSW5pW2l+Y2rKJ16D/6JWtXp5P/568wGipRi/2wpNuT8/3PqHOxVJwKJ
         7osnBCp7xvJlIE1ybL/+9Deox4alkHIXQtcH0Z39A/IMRflTKgN/xIsD2fGi9PztBTHp
         CzNf8XLulv42j5oUDgThNxCuEnG88a7by9j4JCOxNEbSyEVZuoWJyJf2/OvqdA7P91KC
         NpH9/Y8PCsUYJ+ef+MyKi+EF51Ks1l67le4roy04+hnDYKbWqcHMvL9kh29qJiipLAHy
         ngniRGoa6okI1WVwFnrPDtG38cKtkRRNTNagzoOJHmWBsd+BZwtYx/+aok8A2edI4Fh4
         42yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LkOJ6KXC11/Y4FBi0TytGsBTIahyfqyZdKmtY1CFDQ0=;
        b=DO3nXupkVfHqNM3V1Q7lmJtk3HdIsBQ+OLB1Kwq5s1FmrV2uZzdPsol62VjeG9R6D3
         3EeJwUh5Bjtoc+kmMiflCc7R0BBmV3DpPRjcp+n0EjdR6+Y2Nnc+FoL0+sB3ILGlQsuy
         5kAGOz+KHP86Eh4MZuNYr7uPUHiuD1NuWowiWhah6L+ka8mugVq9H3w08Oao6htb3rV9
         TR35cwPlxuCRKUSjOhkKa2QZgk5bjurFfd5r2khppkWvcxmhIjno5+IrYuvtGr7E4TaV
         R0HL+8p88R66e5i406i2514Rz1SU9MR8lJ90BGaM9hxpFUQE3ZnMnwDM64TjaWlE1TfZ
         GO9A==
X-Gm-Message-State: APjAAAVZjegWofu9m5jNKbnj89wJyJzUNxJP+qe4yyB122sesLpa/Ms4
        pSl5bEzPUhNbr+NAwkNLWeIOul4PesZZtQT9hvw=
X-Google-Smtp-Source: APXvYqz7xa2SkDRvZ5t+Uh8iZ0NKcv/Uh538AeL3a11JV6tjOrZWkN/RQkSc+BT6rlX8yOrJoR204s8WMB4p9+UnHhg=
X-Received: by 2002:aa7:95bb:: with SMTP id a27mr26957930pfk.30.1557809611110;
 Mon, 13 May 2019 21:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190510223744.10154-1-prsriva02@gmail.com> <20190510223744.10154-2-prsriva02@gmail.com>
 <1557766592.4969.22.camel@linux.ibm.com>
In-Reply-To: <1557766592.4969.22.camel@linux.ibm.com>
From:   prakhar srivastava <prsriva02@gmail.com>
Date:   Mon, 13 May 2019 21:53:44 -0700
Message-ID: <CAEFn8qJNzG5scBcdVbrXpY7ZEbku+yNbMZn3M=JUW8nNZbGKoQ@mail.gmail.com>
Subject: Re: [PATCH 1/3 v5] add a new ima hook and policy to measure the cmdline
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        inux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        ebiederm@xmission.com, vgoyal@redhat.com,
        Prakhar Srivastava <prsriva@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, May 13, 2019 at 9:56 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Fri, 2019-05-10 at 15:37 -0700, Prakhar Srivastava wrote:
>
> > +/*
> > + * process_buffer_measurement - Measure the buffer passed to ima log.
>
> "passed to ima log" is unnecessary.
>
> > + * (Instead of using the file hash use the buffer hash).
>
> This comment, if needed, belongs in the text description area below,
> not here.
>
> > + * @buf - The buffer that needs to be added to the log
> > + * @size - size of buffer(in bytes)
> > + * @eventname - event name to be used for buffer.
>
> Missing are the other fields.
>
> > + *
> > + * The buffer passed is added to the ima log.
> > + *
> > + * On success return 0.
> > + * On error cases surface errors from ima calls.
>
> Only IMA-appraise returns errors to the caller.  There's no point in
> returning an error.
>
>
> > + */
> > +static int process_buffer_measurement(const void *buf, int size,
> > +                             const char *eventname, const struct cred *cred,
> > +                             u32 secid)
>
> This should be "static void".
>
> > +{
> > +
> > +     if (action & IMA_MEASURE)
> > +             ret = ima_store_template(entry, violation, NULL, buf, pcr);
> > +
> > +     if (action & IMA_AUDIT)
> > +             ima_audit_measurement(iint, event_data.filename);
>
> The cover letter and patch description say this patch set is limited
> to measuring the boot command line - IMA-measurement.
>  ima_audit_measurement() adds file hashes in the audit log, which can
> be used for security analytics and/or forensics.  This is part of IMA-
> audit.  The call to ima_audit_measurement() is inappropriate.
>
To clarify, in one of the previous versions you mentioned it
might be helpful to add audit.
I might have misunderstood you, but i will remove the
audit_measurement and make other corrections.
Thankyou for your feedback.

- Thanks,
Prakhar Srivastava
 Mimi
