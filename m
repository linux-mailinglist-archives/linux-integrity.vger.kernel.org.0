Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8704912DE09
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Jan 2020 08:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbgAAHTm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Jan 2020 02:19:42 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37919 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgAAHTm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Jan 2020 02:19:42 -0500
Received: by mail-lj1-f194.google.com with SMTP id w1so15934609ljh.5;
        Tue, 31 Dec 2019 23:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e+pH9CjdsZ5QrriUvx4W/mVkNjY6xtY+zMdXJZGnRBQ=;
        b=S6hpHHd3xFsc+PM2a9xMh+xrp6wJ3AVxg1QGZCjqpyRqEUBfVXQk/JAysVCyM2we8J
         sCH+bTb37u7d99KdG+NFlHsWxXKVoK0KcENZ97RHdvUMSal2jw0s/1G7z3wDRo7m2cqW
         HF5W8pb4XMUD4bNAoV77BoMOSEEkfF+PH9EUXDiHL+yPW3vwVN523RBZ6PEg4PDqRoKG
         PrzKMHqxAE+o1Qapr725nJRaTXVmHmhZmJf/uyNPjSSDZU9w/+K9XoQpqP1Dw1pZHMTh
         EvdLtAVADlMcw1egjQecTZVhLtEtf9UApyBbm2z5wCZ8hswoILTLIIKdI3JOe2lTGLIu
         7oAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e+pH9CjdsZ5QrriUvx4W/mVkNjY6xtY+zMdXJZGnRBQ=;
        b=mexnFvOMTb7y2IOTKIVeIBFvxktJMT+LyVqtoXLSxoi6/U9DkwuyLvpamn/wvePFYU
         dP+aA7copfvACLyGmAn9AokRmzrx6KP4daXca4y6eRN+/AMSfn6uQ9LV1O9TpyeJQ/0M
         ZYul9eKcXT8OGKLGYiO9xapSBoslNtlz46P/5h6KYcilumz6ZAhFtJK/As5utfb6b+FH
         8vk5mx3qgkKAmQLM/YL0o2v+ZK0BzFv9SqtHKnpfGfP2AAROpOg0E4a0iy9FHj0xJ1Qo
         e0ESAt2OCBWWPRWEfX2IXU6vRn3kApVNcWr+r06q/F7AzdhOhl/Z3gzcWYW8Ha0ubp3u
         0Y3w==
X-Gm-Message-State: APjAAAWmblJcW5eXjbIVGaLuCxp9YkRHPo6npmS6h3G7saRVi6hYm16P
        u+Wvaa2VV9NVNA2P46dVRCfnkSRO9buiLNruGDI5lWS+
X-Google-Smtp-Source: APXvYqxSbgYyRrYe96cx7pzHWBWHoK1muXiL/t+auUcWKeK1YHdIWRuDBdBu5iY3lAtShbCsmY7Ap2Txnw4lk1FzWs0=
X-Received: by 2002:a2e:89d0:: with SMTP id c16mr45463618ljk.228.1577861378396;
 Tue, 31 Dec 2019 22:49:38 -0800 (PST)
MIME-Version: 1.0
References: <20191220074929.8191-1-janne.karhunen@gmail.com>
 <1576850665.5241.52.camel@linux.ibm.com> <CAE=NcrZUyLe1Ftk5wOuEMJBPnw+DBx9LACbk1JPJcpg8VdDiJQ@mail.gmail.com>
 <f2bc130034b6e1ca66c3f18dfa3a4fa68fcbc82a.camel@gmail.com>
In-Reply-To: <f2bc130034b6e1ca66c3f18dfa3a4fa68fcbc82a.camel@gmail.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Wed, 1 Jan 2020 08:49:27 +0200
Message-ID: <CAE=NcrZHmBTPJ=ih-sR1veY1egWSGGL2XmVS9EbA+SNb=N+sMQ@mail.gmail.com>
Subject: Re: [PATCH v1 - RFC] ima: export the measurement list when needed
To:     david.safford@gmail.com
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Ken Goldman <kgold@linux.ibm.com>, monty.wiseman@ge.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Dec 24, 2019 at 5:35 PM <david.safford@gmail.com> wrote:

> > That is a good question. I went this way as it did not feel right to
> > me that the kernel would depend on periodic, reliable userspace
> > functionality to stay running (we would have a circular dependency).
> > The thing is, once the kernel starts to run low on memory, it may
> > kill
> > that periodic daemon flushing the data for reasons unrelated to IMA.
> >
>
> I'm happy with either way (kernel writing, or userspace reading) the
> data, but with the v1 patch, there is no way for userspace to force
> that the list be flushed - it only flushes on full. I think it is
> important for userspace to be able to trigger a flush, such as just
> prior to a kexec, or prior to an attestation.

Indeed, will add in v2.


> Perhaps you could simply remove the length test in ima_export_list(),
> and export anytime the filename is provided? This could simplify
> attestation clients, which could ask for different files each time
> (list.1, list.2...), for automatic log maintenance. Since the template
> format does not have sequence numbers, this would also help keep
> track which records have already been seen.

Yes, will do something like this. Holidays cause some latency here,
but I will send an update next week.


--
Janne
