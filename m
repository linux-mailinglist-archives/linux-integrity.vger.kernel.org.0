Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBA20AD31A
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Sep 2019 08:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbfIIG17 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Sep 2019 02:27:59 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45533 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbfIIG17 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Sep 2019 02:27:59 -0400
Received: by mail-lj1-f196.google.com with SMTP id q64so951634ljb.12
        for <linux-integrity@vger.kernel.org>; Sun, 08 Sep 2019 23:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4AnsXWc++S5LkXHTpAfCh/YWJ7C1+32GsM7I37o2460=;
        b=D2wEzaKdCaWzX0botC+B9UcIZVI299ld6FUD6DGof3sLEBp641RhBED5XonYC0WXOm
         P7Rdk+epj8zcozcW1QDhyK1j2RffaCQIw0DmaeRvVSsrsmX0WOF0cWvN3uDihJkXa5fN
         0rU2VJkb6KQhTmtAckprUTmCysBRSTEcc2k0lmAb4je6qYcIJg+F9viCBBDBtRGHS6n5
         uqc3mY8SxP2zfY6GmG741aCF7PLCBuKYZIaWOm1ic4++1I/fP1wA2F7vNk4Qub5MJuMi
         foI9IJjvs78H1v/F7NY80waKZgwRcRevhWUnccuivE87WZfwDXThCUsTUmL1D5YwDGqL
         oxxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4AnsXWc++S5LkXHTpAfCh/YWJ7C1+32GsM7I37o2460=;
        b=G2bEJYmdEe8YNCBYujVcVVUlLMheZC9hHB+faw2wAStqu8RDTK6gwlt2OSXppzH21E
         eOlI+FMjruYk/UjL+XZ9QWDstfO3GQbiWKYK8pePu7L9q/DR7nx1pSXtr/pHL/BBUWYq
         uXnVN8sPAneRbMbnCEqzMNWQshTQ0aHPNQhgDjdjl707ZX0nHhTCipAgxMSIspqWDMUm
         /Q6a16mi2bapoXcvyYEO9II/yMdeTjYYfNtVhZfuqhI0PfnrXbFVbAAhtMz00hmN/4d5
         zA2YR94adW4RQLhz6ja3TO/p6Kz9ZpN4Hl+vRbDpJpgQdD99J0jGwHKjeSilx2RJCoD6
         m4KQ==
X-Gm-Message-State: APjAAAW1TZknmDyxIwqev0QIEpoK5tgNEoAEpvUgUAkgxiYelmIVrb4B
        2N5ZONMf+sd3Qs5oGgm/K269HW8YuTuKfHQPB7W2Yg==
X-Google-Smtp-Source: APXvYqwyIuuOyuyziWA5aZipTXbu9CYBLzgfb2oQ4gGQ/akpuEbVQ2OClHiwZ8b2Qtckcw1GfMmCDUwBisRzKPw7PBk=
X-Received: by 2002:a2e:504f:: with SMTP id v15mr14941188ljd.67.1568010477095;
 Sun, 08 Sep 2019 23:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <c253ca7292b397f1352d2ee00fce0b011f84abff.camel@linux.intel.com> <1567952431.4614.140.camel@linux.ibm.com>
In-Reply-To: <1567952431.4614.140.camel@linux.ibm.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 9 Sep 2019 11:57:45 +0530
Message-ID: <CAFA6WYPq8Tq6=jTqnWQf9w9pzdJu8AcX-CFBWPwoVmMaLEJKhg@mail.gmail.com>
Subject: Re: KEYS-TRUSTED git
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 8 Sep 2019 at 19:50, Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Sun, 2019-09-08 at 03:10 +0300, Jarkko Sakkinen wrote:
> > It seems that at least vast majority of the trusted keys patches flow
> > through my tree to the mainline. Still, it is undocumented in the
> > MAINTAINERS file.
> >
> > So, should I just add my TPM tree as the upstream there? Or should I
> > just create a new GIT for trusted keys? My TPM PR goes to Linux ATM.
> > Should my trusted keys PR go to David instead? That would definitely
> > require own tree.
> >
> > With Sumit's recent work trusted keys is turning more than just being
> > TPM keys so now it is a good time to consider the flow... Sumit, I'm
> > sorry that I haven't added your first series yet. I need to first sync
> > up how we are going to move forward.

@Jarkko: No worries, I understand the situation.

>
> Thanks, Jarkko.  Agreed, trusted keys is becoming more than just TPM
> based keys.  Now would be a good time to set up at least a separate
> branch or GIT repo.

+1

>
> Are all "trust" methods equivalent?  As new "trust" methods are
> defined, there should be a document describing the trust method, with
> a comparison to the TPM.

For Trusted Execution Environment (TEE) as a new "trust" method, I
have tried to document it here [1]. Please share your thoughts on this
patch [1] in case I missed something. I would be happy to incorporate
your feedback. Also, can you elaborate on "comparison to the TPM",
what specifics parameters are you looking for documentation?

[1] https://patchwork.kernel.org/patch/11065679/

-Sumit

>
> (It would be nice to have some kernel selftests to ensure existing
> methods don't break.)
>
> Mimi
>
