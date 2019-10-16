Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFFDD88DD
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Oct 2019 09:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfJPHCP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 16 Oct 2019 03:02:15 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43842 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfJPHCP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 Oct 2019 03:02:15 -0400
Received: by mail-lj1-f196.google.com with SMTP id n14so22760370ljj.10;
        Wed, 16 Oct 2019 00:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5oSsDNvXvsGV6CzNkWpdPR+sTK76BWHvlu1tQbUWenU=;
        b=pJliqJj64q2dRIoPcClE+AKzJFpZlbmkvfy5sjO/7USN43uZ47HdcEYAeAtnQECfL3
         wgmK1rauj0x2vPU2brvz55VTz7lZO1Q3F4V0GCPsEsxVpNuCdeo+Hsa8NYkbMma8xIjX
         Kk44SeE70U0hXSaGXBw4protPvwTB6oDJWS+vHRX3YNkdUWoAlzi0LXXTClPaMtzz7Dk
         4JOv8oyk9i0bWXdWb1zopBh4p5f8IlvM41UQuMP54HmYfQrWY3kbOAuO79zdmzxqfUCU
         sZV+qyv7ElkFbzHPCpV3FmE40cJBvzK52Be2EBTYaiz1wtKlcmkz9AC3OFt5N4Relo8V
         rp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5oSsDNvXvsGV6CzNkWpdPR+sTK76BWHvlu1tQbUWenU=;
        b=mtrWsQV9CxGES3QXxJ80SjynuX+18A+Q11yCnWuLcVJWTnXF/7Blt/1SpUzqEZEJM4
         jcC5JSpktoK58iTjsfgb41+MhJBB02cCkHHzMxlK01XtyBgZgE/PX4xJIwfZ6lxANiT8
         k7shEm3KozBf/ppqe5KkNucRiosNJJsTSBI9b/lVNu1Y5DiN662Pjw3tWZbLu5vAtPX1
         ZrwVd3rkG0hlG3JcIHRTGzPytl96jeoDcbORpqplOIrkWI+5IVVg1ziQu0SOX7Zx0Y23
         /HBl26HOpm9tnGauKFaiQ/fKrKkUIlwIYErVEgSBTlGKfPa10B4dGVGIzW8RcKp8ud3L
         21tA==
X-Gm-Message-State: APjAAAWUCckMv2LlGIfFE+JY/pIjS1P6NZNBYmIxKWbppmc72yzKrQpX
        H+PQ/HFX+sH0Ks17mMcUnwnweZXMjQ1bUlYJTQw=
X-Google-Smtp-Source: APXvYqw80yFTdCAtYRGvXllj9QyFwE19YDrz7m13QpjqE/GKfXA7OePux1S0wjWsqMGUvqIsOf8UIyo2S0YtsI2r1M8=
X-Received: by 2002:a2e:8197:: with SMTP id e23mr25431233ljg.228.1571209333102;
 Wed, 16 Oct 2019 00:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <20191015124702.633-1-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20191015124702.633-1-jarkko.sakkinen@linux.intel.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Wed, 16 Oct 2019 10:02:01 +0300
Message-ID: <CAE=NcraH_6nDe4Ax9axsbsrMf+EggCQFibY3dpNNgGm7NYTtJQ@mail.gmail.com>
Subject: Re: [PATCH] tpm: Salt tpm_get_random() result with get_random_bytes()
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org,
        David Safford <david.safford@ge.com>,
        Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Oct 15, 2019 at 3:50 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> Salt the result that comes from the TPM RNG with random bytes from the
> kernel RNG. This will allow to use tpm_get_random() as a substitute for
> get_random_bytes().  TPM could have a bug (making results predicatable),
> backdoor or even an inteposer in the bus. Salting gives protections
> against these concerns.

The current issue in the randomness from my point of view is that
encrypted filesystems, ima etc in common deployments require high
quality entropy just few seconds after the system has powered on for
the first time. It is likely that people want to keep their keys
device specific, so the keys need to be generated on the first boot
before any of the filesystems mount.

Issue is wider than the tpm alone. Tpm is not generally present in the
mobile (or even embedded-) systems, but the kernel entropy pool is.
Kernel entropy pool on the other hand normally takes ages to
initialize, and it is initialized from a source (interrupt timestamps)
that does not classify as high-quality entropy. Thus, in the default
configurations the first boot cannot proceed as there is no entropy to
generate keys from and the boot cannot be paused or the entropy
collection ends. I have a hunch that to get past this deadlock many
people end up using very, very low quality entropy present at the krng
at that time. Solving this properly should be in everyone's interests.
This is a bad trap.

I'm personally working around this by using multiple entropy sources
to feed the kernel entropy pool directly from the hwrng driver
initialization function(s) before we enter the userspace. Maybe we
could create a KConfig option that forces people to consciously choose
from the trust sources present in the system which ones are to be used
to feed the krng before we enter the userspace. It would be mandatory
to choose one or more sources rather than us silently running them
into a trap. During the boot some sort of message should be displayed
telling the user how the krng actually got initialized. There is lot
of junk happening on the console early on, but this absolutely vital
piece of information is completely hidden - that you have to read from
the source.


--
Janne
