Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35A7FAFB59
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Sep 2019 13:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfIKL2l (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Sep 2019 07:28:41 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:38450 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfIKL2l (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Sep 2019 07:28:41 -0400
Received: by mail-lj1-f176.google.com with SMTP id y23so19284463ljn.5
        for <linux-integrity@vger.kernel.org>; Wed, 11 Sep 2019 04:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H9k0ftS+mDutcro++wIj7zgrmMIpQE4Mu9Segd7/ap0=;
        b=tosITbIEK0ApSQFj4IfoFrK9wC/HjS0cNGdj4j/UGn9nQLiX+btzTOkvmYefNSPRGP
         DNV+05W/4hxE/zpzcLqrhmvYRnlVR7UDB+K/FRlNwQHsIHN/FQhqHRgr9dub3w6Vi5ii
         iFLE0ydApKjO8xdrE6tUaIMK9IXAx3hAJxYibxLX58/JP980XS+VKzTOWKOhrVTa94s0
         HjWVk8P5N3VWeIhgiN1CGn2UuezLCkx4sY0hKn5fuI9VDV2UI4ZsW+P7H2Tq/p9SzeeP
         C4KgYa8cTizMSEQzMJrCjKJtxKXbreIViRx34281C9yCfwhPgDC666KsCt4Q21VDBpQ+
         vrkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H9k0ftS+mDutcro++wIj7zgrmMIpQE4Mu9Segd7/ap0=;
        b=aStxbgxtHkl4h0dbcUqpcuMQSt3y1djEeimtC63L81BmwTSV9l7OF4MRmpExtlvsfk
         Rq6vt25BOs/TL20cDR48N89Nyg96QYleUtEQbCsdN8huO4nV36o0N5Mt6y2YXODhq5EF
         gxFqO09QgfUFaNm/M6bo1GbPMn3Vm9O3KxuA+9C+7twM2e6RC2LkDwT12D8PNEyfQ4dq
         dzJQNlBzaoLgBglaeejz0p5vJMH1uJ1RQ5XSDDatvmtAlxiJwaozCj/ZucQi/iufX+gX
         aGaiJA6CLiFZLHRQ5GTUnl5pCvQ0pt+RDfx3Aj8nF0QHbn9uGBWQfz1iV7GgpCMtnjxW
         GQdw==
X-Gm-Message-State: APjAAAWZF76BDejxvKlE8W7uKFQNIST7naMDe+Ra4pONYo5a8FZ2Ssmt
        qEaRmAw/5hxAjIlqV9F7nkDSAhEWaAIGRxIHS2xiRg==
X-Google-Smtp-Source: APXvYqwXiSc5IxKfewSFA2A4qowklKxGvPAnpIe1tNTjhAkLNIbpjD3KSN2KjqsI32m2HIZpq8IKCun1b9Bj5nRz0B8=
X-Received: by 2002:a2e:5358:: with SMTP id t24mr23407822ljd.209.1568201319222;
 Wed, 11 Sep 2019 04:28:39 -0700 (PDT)
MIME-Version: 1.0
References: <c253ca7292b397f1352d2ee00fce0b011f84abff.camel@linux.intel.com>
 <1567952431.4614.140.camel@linux.ibm.com> <CAFA6WYPq8Tq6=jTqnWQf9w9pzdJu8AcX-CFBWPwoVmMaLEJKhg@mail.gmail.com>
 <20190910114336.GA7018@linux.intel.com> <20190911092708.GA20023@linux.intel.com>
 <20190911092926.GA20970@linux.intel.com> <20190911093637.GA21744@linux.intel.com>
 <CAFA6WYOdgxEjCYMsgqCUjq7mydH3apxmqxjkyLbqiKfc_1R5Tg@mail.gmail.com>
In-Reply-To: <CAFA6WYOdgxEjCYMsgqCUjq7mydH3apxmqxjkyLbqiKfc_1R5Tg@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 11 Sep 2019 16:58:27 +0530
Message-ID: <CAFA6WYNF0=q-rsOgv0Nuepbz_7Z50US6um7e6eWjm=E-eR+NpQ@mail.gmail.com>
Subject: Re: KEYS-TRUSTED git
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     jejb@linux.ibm.com, Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 11 Sep 2019 at 15:28, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Wed, 11 Sep 2019 at 15:06, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Wed, Sep 11, 2019 at 10:29:26AM +0100, Jarkko Sakkinen wrote:
> > > On Wed, Sep 11, 2019 at 10:27:08AM +0100, Jarkko Sakkinen wrote:
> > > > On Tue, Sep 10, 2019 at 12:43:36PM +0100, Jarkko Sakkinen wrote:
> > > > > On Mon, Sep 09, 2019 at 11:57:45AM +0530, Sumit Garg wrote:
> > > > > > @Jarkko: No worries, I understand the situation.
> > > > >
> > > > > I made the call to add them anyway to my TPM tree.
> > > >
> > > > Also,
> > > >
> > > > Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > >
> > > > I think I give a shot of doing one more PR to 5.4 because that would
> > > > help both your and James' work because this is the kind of intersection
> > > > point betwen them.
> > >
> > > Polished short summaries a bit:
> > >
> > > 1. Start with capital letter.
> > > 2. s/tpm2/TPM2/g
> >
> > Now also in my next branch. I wait for 24h or so and if no alarms are
> > rised I'll send a PR. The code changes for the most part mechanically
> > move stuff, which makes me confident that I can still do a PR with
> > these changes.
>
> Did you notice an issue reported by kbuild test robot? It looks like
> asymmetric keys based on TPM also relied on old tpm_buf method. So we
> need to transition them also to use new tpm_buf method. I can work on
> corresponding changes required but need your help to test it.
>

Patch: https://lkml.org/lkml/2019/9/11/312 to transition TPM
asymmetric keys code.

-Sumit

>
> >
> > /Jarkko
