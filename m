Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9435E17319
	for <lists+linux-integrity@lfdr.de>; Wed,  8 May 2019 10:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbfEHIEM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 May 2019 04:04:12 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38075 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfEHIEL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 May 2019 04:04:11 -0400
Received: by mail-lj1-f195.google.com with SMTP id u21so7511006lja.5
        for <linux-integrity@vger.kernel.org>; Wed, 08 May 2019 01:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MboQM0y8L0nS2NfCh3up86+oE/Pdj7+IGsxyVI8uPIQ=;
        b=I/iXXp9M+zhW9uMOyTagtbPsUHkmbdS6uHCQ2JMfoYFmZELLEl1qSQtOd+rcz01anI
         i1Ehok7xZ5SVFX36AKClK4tRseTh+7UOhejSuUxWviPHxaHyv/X71LuQ58ytZSm0tWC4
         IZn6x8Tv81CeTjb4YyJXkYzjoZrnizkbhqsKWDu63KQRg78av3GJ8Z7NbLhwKDq4lNUF
         /fZpgEOzodlqs+rnBnJHDxGU568BD7iVhrjvPUjw6LYMJnfBMzAJR01/bp4ISkwwTMJp
         dnt71640GGyiDtru+SHyl+9xre/1x4ZrLPFgRX73ArMvsjWFR2dOhYmu4GeDFEkuOBUc
         JOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MboQM0y8L0nS2NfCh3up86+oE/Pdj7+IGsxyVI8uPIQ=;
        b=VuzSacTO489fLpb1G4jDI9g9CrBfBXze42X7ya/vekiCdh3mSjtJjMtvD4hR0fbqiQ
         vCEA7LebbjG6gOwDF8rA784jEU0LIX2rMlDQDgw9wnsGnyffeiijoJu1Ig/CPJUDoGnE
         gvweCo36XhiviMyH8G2q3q8cCkz+t1fxMJ+5V0301YOdY2RT/Tc4Hu0MERWe5FIWWlmB
         /cT6ktCsRe8zNPQWht9pMbXs0B31e108aQztTqNEmB5jtK8UatuME4cBVf0nU05aOWQd
         j5NUsdEgzkrmv6xXhe1mmasz4n8Je52Qi0HJCK4mzDOvRrsBwCX6WM6CUPEmqbk8NYBW
         ovtg==
X-Gm-Message-State: APjAAAWB/Q/aQn2Kd39pInxs851m+8Z3GiwYhS8sL0Bkm0dHlRtDCW0l
        krjDpjHYfvfatYG6U3/D1pW3ipVUlFvoEHqh8YBCmw==
X-Google-Smtp-Source: APXvYqwk4TVVF0rhziM/uH6ayroPA2i/zOL+wDU85AdrnkRqIFvu+7q9PvRYC0kpZ3K6ssDC1oUtCgYfVLfkNIREEAM=
X-Received: by 2002:a2e:9f44:: with SMTP id v4mr19974769ljk.72.1557302649494;
 Wed, 08 May 2019 01:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190506125341.5872-1-janne.karhunen@gmail.com> <1557236675.3971.89.camel@linux.ibm.com>
In-Reply-To: <1557236675.3971.89.camel@linux.ibm.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Wed, 8 May 2019 11:03:57 +0300
Message-ID: <CAE=NcrbGpgyoG=D6oqpPTo_J0sVLeCHMZDWnNHo1kM=v+m0z4A@mail.gmail.com>
Subject: Re: [PATCH] integrity: keep the integrity state of open files up to date
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, konsta.karsisto@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, May 7, 2019 at 4:46 PM Mimi Zohar <zohar@linux.ibm.com> wrote:

> > Core file operations (open, close, sync, msync, truncate)
> > update the measurement immediately. In order to maintain
> > sufficient write performance for writes, add a latency tunable
> > delayed work workqueue for computing the re-measurements.
>
> Would renaming or deleting the file affect the wq?

AFAIK no, but maybe it would indeed make sense to throw the wq job
away on unlink. Now it may do an extra hash for a file that no longer
exists.


> > Signed-off-by: Janne Karhunen <janne.karhunen@gmail.com>
> > Signed-off-by: Konsta Karsisto <konsta.karsisto@gmail.com>
>
> Good, by only touching the "collected" iint status, re-measuring/re-
> appraising files shouldn't be affected.
>
> As I don't I have a test environment for testing this sort of change,
> once the patches are ready, please Cc other interested parties.
>  Probably some of the embedded mailing lists, yocto, and Patrick Ohly.

Ok.


> > +++ b/include/linux/ima.h
> > @@ -20,6 +20,8 @@ extern int ima_bprm_check(struct linux_binprm *bprm);
> >  extern int ima_file_check(struct file *file, int mask);
> >  extern void ima_post_create_tmpfile(struct inode *inode);
> >  extern void ima_file_free(struct file *file);
> > +extern void ima_file_update(struct file *file);
> > +extern void ima_delayed_update(struct file *file);
>
> Instead of using ifdef's before calling these functions, define the
> associated stub functions as well.

Ok.


> > +EXPORT_SYMBOL_GPL(ima_delayed_update);
>
> Does this need to be exported?

The point was that this can be used as a global probe point. Call it
when you need something measured.


> > +     mutex_unlock(&iint->mutex);
> > +}
> > +EXPORT_SYMBOL_GPL(ima_file_update);
>
> And here?

Like above. Not happy with the idea?


--
Janne
