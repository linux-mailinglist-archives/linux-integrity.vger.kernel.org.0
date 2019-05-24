Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5895929EBB
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2019 21:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391372AbfEXTBE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 May 2019 15:01:04 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:32865 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbfEXTBD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 May 2019 15:01:03 -0400
Received: by mail-lj1-f195.google.com with SMTP id w1so9608997ljw.0;
        Fri, 24 May 2019 12:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g4NY5igK720iST0ZqksnXPMdeVhURcjF5b3jQL4XTAk=;
        b=nZDUMrdZFOuilz6e5qQyTjTvEiXum7FlwXXgQLyyMlONfRjHW3A1KvZB5WbJPMBzrn
         dOD6C2NVmnuCR7UdyUxvi9VPlK8vkw8yQokRTrOyj6jst0sUyoIAKuyVbVQ4Iv0lq5XN
         Ogy6al8qXyJ6hdEaq7KDVCLPXNdLm6eMP1qWlCeAlSPg6eWK7MFXIz5teGk/3FSIfqCB
         8pn1vyFUqE6j1tjXL0+DLdNgK5FSXGT91vOencR/f7yHoqoFs/l5v+S3oUIKjoCONeNG
         n+TV7tONUTgAe8Qv7PNisyoeefxixuwimbHT5bwGJnjX+sJhc/KaghFN3z992Zlkt+ba
         u8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g4NY5igK720iST0ZqksnXPMdeVhURcjF5b3jQL4XTAk=;
        b=KhDT2J7rv9C9w2Jo1LvvUv4Uo+Vt5ZBVnnzrqAF0aBfFhtODL7tZILDxF1T8hjgnhA
         UC47LIMzQ4EH0y5FHKw6Tgj7oKInmlxRrB4qDujh7kAOWPyaEtUkHzfyn7HvOSrOFcr3
         MLS36nwjZLjQkgZu+HVHVTZaK+vHuqN+BS5iWWvzhV86dixb8ep8/22Uc85WW+QPj4XX
         UC+x/OXcLo9AovejLPhVqMuM+0iJuggxx3bszTj/TwM9cHwS9e96fN01is5NELB0QOBZ
         bOKfUNgtBDIkmgOtAlh8yXhz1Yu3DCC7Wo9MNUJqyVuZnhd0S5zhsuF0UvsBvxPbC7pb
         fTvw==
X-Gm-Message-State: APjAAAUxT+6VRVyUjKXmgCnzhDlieo+srogWaUo8AGUZofuvV2FNqohZ
        8Oq1dWlma807ap/O9fNmfNDmuAebVbJOhJus5xE=
X-Google-Smtp-Source: APXvYqxXAFWzFCxZxFnA4PUrU9IucIJE8/g7Si7oGm8ZNHWfkocNip3ywp9WoVQk0HDlKIXQMs6mhkQclw5h4eDRMuY=
X-Received: by 2002:a2e:5d4f:: with SMTP id r76mr38040077ljb.49.1558724461772;
 Fri, 24 May 2019 12:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190521000645.16227-1-prsriva02@gmail.com> <20190521000645.16227-3-prsriva02@gmail.com>
 <1558710722.3977.68.camel@linux.ibm.com> <a7acac28-156e-80d1-b759-cb0c59f73169@huawei.com>
 <cb0eb785-9050-738e-c1bf-8e769fe096fa@huawei.com> <1558721385.3977.84.camel@linux.ibm.com>
In-Reply-To: <1558721385.3977.84.camel@linux.ibm.com>
From:   prakhar srivastava <prsriva02@gmail.com>
Date:   Fri, 24 May 2019 12:00:50 -0700
Message-ID: <CAEFn8q+8QUs8iCP+Q3VujTkTU+XYYPGY8O8+KT1=6vvc-khJFg@mail.gmail.com>
Subject: Re: Re:
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthew Garrett <mjg59@google.com>,
        vgoyal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, May 24, 2019 at 11:09 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> > >> As mentioned, the first patch description should include a shell
> > >> command for verifying the digest in the kexec boot command line
> > >> measurement list record against /proc/cmdline.  This patch description
> > >> should include a shell command showing how to verify the digest based
> > >> on the new field.  Should the new field in the ascii measurement list
> > >> be displayed as a string, not hex?
> > >
> > > We should define a new type. If the type is DATA_FMT_STRING, spaces are
> > > replaced with '_'.
> >
> > Or better. Leave it as hex, otherwise there would be a parsing problem
> > if there are spaces in the data for a field.
>
> After making a few changes, the measurement list contains the
> following kexec-cmdline data:
>
> 10 edc32d1e3a5ba7272280a395b6fb56a5ef7c78c3 ima-buf
> sha256:4f43b7db850e
> 88c49dfeffd4b1eb4f021d78033dfb05b07e45eec8d0b45275
> kexec-cmdline
> 726f6f
> 743d2f6465762f7364613420726f2072642e6c756b732e757569643d6c756b73
> 2d6637
> 3633643737632d653236622d343431642d613734652d62363633636334643832
> 656120
> 696d615f706f6c6963793d7463627c61707072616973655f746362
>
> There's probably a better shell command, but the following works to
> verify the digest locally against the /proc/cmdline:
>
> $ echo -n -e `cat /proc/cmdline | sed 's/^.*root=/root=/'` | sha256sum
> 4f43b7db850e88c49dfeffd4b1eb4f021d78033dfb05b07e45eec8d0b4527f65  -
>
> If we leave the "buf" field as ascii-hex, what would the shell command
> look like when verifying the digest based on the "buf" field?
>
> Mimi
>
To quickly test the sha256 i used the my /proc/cmdline
ro quiet splash vt.handoff=1 ima_policy=tcb ima_appraise=fix
ima_template_fmt=n-ng|d-ng|sig|buf ima_hash=sha256

export $VAL=
726f2071756965742073706c6173682076742e68616e646f66663d3120
696d615f706f6c6963793d74636220696d615f61707072616973653d666
97820696d615f74656d706c6174655f666d743d6e2d6e677c642d6e677c
7369677c62756620696d615f686173683d736861323536

echo -n -e $VAL | xxd -r -p | sha256sum
0d0b891bb730120d9593799cba1a7b3febf68f2bb81fb1304b0c963f95f6bc58  -

I will run it through the code as well, but the shell command should work.

Thanks,
Prakhar Srivastava
