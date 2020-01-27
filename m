Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C60114A063
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Jan 2020 10:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgA0JDR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Jan 2020 04:03:17 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45209 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728783AbgA0JDR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jan 2020 04:03:17 -0500
Received: by mail-lf1-f65.google.com with SMTP id 203so5620504lfa.12;
        Mon, 27 Jan 2020 01:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DXfnqEIQEOAhuNRF2FUN6s3o9e2/oC31wR3fFMNGkiE=;
        b=qtxvWxObid+2MA4/tm/VpUDXwukFbWbCwYUzze8luXOh4IZFk0pwnYvJHB4Ii1lGO1
         DWIgw8K1bL6pfUkhnjzdPadDlkK8IgmZ+35odazC5GSkIrsYKEwtFZVCgYzHBGX1QOfb
         kLTHac/tjeLJxKSiHJhwaSVJBRA1yQD+ZQ/JR5xhBXC8x1Qp6kfnPuWgQSeXAp71tnR9
         sYQafvmx6eUHXSJeBiExiTtKF3iiMMoEcABm9sPH/wgM2YaiX79QtV0t8tsTc0nB3tA9
         LxIfuGB2ShaalZpofVsEz/EN53UgxnpTXGG8X4CwQgp1FvUs3uJYPJk5V4wWn1Gt1/g0
         2hzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DXfnqEIQEOAhuNRF2FUN6s3o9e2/oC31wR3fFMNGkiE=;
        b=ovZeNYH7sFg94Aw+c1AhL0SMeGoOtKJJRS7K2mtaYje5Dr932xfF4+U3v/cJ2nx4Ci
         veqLiJFumVgDL1PYxejIGL+LLF6yF9QCbO0QWiwA2F9VS6asM98KmKBEs9sHPun4Qh1R
         pLbKnls2zxnSeP3MR7Xk0OVis6W/+Z9Qa5H/vNmKiiNW4exXfgU5hNJsqVXhZ4Lk+UjD
         ee2DjEqlowQHPAd04DuLacK87aigb1NnsvJYjZSqMuqhoF1vg6fDbM2pPT7wqHekcoWx
         kX3fvxcGYgLJvpZpgxZLokpsad4mGJlQF1WJeZ62Fzp2G+MQXmxIm2YjLhKEhJrVZ4IP
         Hm6w==
X-Gm-Message-State: APjAAAVS1L85p5aWbggdHccKukXROxh9NF31iI+xxIzJzNOkogi/Ba/s
        v88843KLcDb/CinXu1yaVACexXPJL2nqMVk94mU=
X-Google-Smtp-Source: APXvYqxkofUqRYz+zn0PnNHWJ1ZSGZdXmiBbKJjh5pseS2rOXfP47mtwrF46PrrLbzfzuHkJK2Vd6GP+lBvoUKhaWwA=
X-Received: by 2002:ac2:485c:: with SMTP id 28mr7533478lfy.118.1580115795046;
 Mon, 27 Jan 2020 01:03:15 -0800 (PST)
MIME-Version: 1.0
References: <20200108111743.23393-1-janne.karhunen@gmail.com>
 <CAE=NcrZrbRinOAbB+k1rjhcae3nqfJ8snC_EnY8njMDioM7=vg@mail.gmail.com>
 <1579708579.5182.77.camel@linux.ibm.com> <CAE=NcraSfo0fwxCnFQd08Ga59DsvxPTch-n_iN7fxt+3RdmP+A@mail.gmail.com>
 <1580058069.5990.36.camel@linux.ibm.com>
In-Reply-To: <1580058069.5990.36.camel@linux.ibm.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Mon, 27 Jan 2020 11:03:03 +0200
Message-ID: <CAE=Ncrawp7BPikkg0-ww2dO2_+tDPkaGxCpwMbDX4yqYWuYBWQ@mail.gmail.com>
Subject: Re: [PATCH v2] ima: export the measurement list when needed
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Ken Goldman <kgold@linux.ibm.com>, david.safford@gmail.com,
        monty.wiseman@ge.com, "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Jan 26, 2020 at 7:01 PM Mimi Zohar <zohar@linux.ibm.com> wrote:

> > > I don't think it is common, and probably not acceptable, for the
> > > kernel to open a file for writing.
> >
> > Ok. It just means that the kernel cannot do its own memory management
> > and will depend on the user flushing the memory often enough to
> > prevent something bad from happening. Is this more common in the
> > kernel than writing out a file?
>
> Ok, there are examples of both passing a file descriptor and passing a
> pathname from userspace, but even in the case of passing a pathname,
> userspace normally creates the file.

Sorry, I was slow to get your proposal. I'll try to see how that would
look like.


> There's been discussion in the past of defining an integrity
> capability.  Are we at that point where we really do need to define an
> integrity capability or is everyone comfortable with relying on
> CAP_SYS_ADMIN?

Every time something like this is being proposed there is a lot of
shouting from people that they want their root user (renamed as
CAP_SYS_ADMIN) back. I'd be happy with such bit and several others,
too.


> When implementing this feature of exporting and truncating the
> measurement list, please keep in mind how this would work in the
> context of IMA namespaces.

That could be rough. I'll try to think about it.


--
Janne
