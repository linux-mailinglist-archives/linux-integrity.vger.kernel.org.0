Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD1993D5CA
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jun 2019 20:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392060AbfFKStK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Jun 2019 14:49:10 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37647 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389470AbfFKStK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Jun 2019 14:49:10 -0400
Received: by mail-ot1-f67.google.com with SMTP id r10so12937223otd.4;
        Tue, 11 Jun 2019 11:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dz7olQKnFjj7omxNegzsPSUMtfyoczAclzprO/pRrIY=;
        b=iSB2gUM+ptPC8s0fS0yg8bC2jBrbkuG0brKiZ4ngrjTHi+relJzZSSVPJM7dV94t4l
         gU3KxxHGPU01Yx9AGtudkpc9rU439Z9qNm3rbjoR5B/7iJeXRxqHwfcr5IZ5SzddM02Z
         KFRpUqromvZR6N5vo4caAUKNaf/cIIjAM5oIYD3ofGrEBW3cvf0nloSJTi5gamBihAiv
         FzelkkfRr6VNAb86okmqCnZj+o+BTjCDQj5h9tZYGKgI0cXtUrf8gfFpchkWy7HNq+iw
         Cyuqx6i0a88zbJDV9n7NKk+saN6/gz2eWAgEsIJEic7/Fsq1u7zC5GPzYX4zGn3XlKfY
         OUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dz7olQKnFjj7omxNegzsPSUMtfyoczAclzprO/pRrIY=;
        b=OL5iXDPyZkqwlIa9GsGDeQFXHEYsC7gyK3YBuH8brfM+r4a0QeiFTzWyH7W5fGgYf3
         +9h3GtbTieRqNZGSmSBwahxWNi0xckovOunBMdeosDkPNIspmegnqKRc4W7PQW5XmRIT
         clxKc9orK/6dJS5KF6v0WFC5KeVSHZhtDGc/OJgMvMyM2KBb8Ym0pw4Xq30jJFvC38Bt
         scJfTgN0LZDFJKBazyYCSIqNxXGryNu15JY7yIMh7Q2bUfK243WdAbOcQHbXtxFCjIxH
         fYlSlkiq5DX/FffVX8ZQMtsvVC7rPGvc2zzAjtEVqW+WSz9OGRhc2xDAxqOJBu55htCe
         VYdQ==
X-Gm-Message-State: APjAAAWouTOPTmlq3Yo5scWq1UpHpT+A6+fbenATqG3lO+gJK/OqdM9b
        5QyMRxXdxnwz9NL+MdMP6MFXnGewIBDH28LButcEAQ==
X-Google-Smtp-Source: APXvYqzkhILMzkowVhwzSSm9im2xIoXr2H9SzdfAW6Yt/vy3tjIAvRSX0L7L/0gRotVLYOYkXaULmE+GUytAFw0YSBc=
X-Received: by 2002:a9d:7245:: with SMTP id a5mr36283933otk.232.1560278949767;
 Tue, 11 Jun 2019 11:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190607002330.2999-1-prsriva02@gmail.com> <1560267426.4464.173.camel@linux.ibm.com>
In-Reply-To: <1560267426.4464.173.camel@linux.ibm.com>
From:   prakhar srivastava <prsriva02@gmail.com>
Date:   Tue, 11 Jun 2019 11:48:58 -0700
Message-ID: <CAEFn8q+RgSnJaWAJT+xN-CZWCsaOVqrPunT3icd_ua2bpkp_SQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] add new ima hook ima_kexec_cmdline to measure
 kexec boot cmdline args
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>, vgoyal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jun 11, 2019 at 8:37 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> Hi Prakhar,
>
> The patch/patch set title in the Subject line should not explain "how"
> you add a new feature.  In this case an appropriate patch set title
> would be, "Add support for measuring the boot command line".
>  Similarly, the first patch in this patch set could be named "Define a
> new IMA hook to measure the boot command line arguments".
>
> On Thu, 2019-06-06 at 17:23 -0700, Prakhar Srivastava wrote:
> > The motive behind the patch series is to measure the boot cmdline args
> > used for soft reboot/kexec case.
>
> When mentoring, I suggest starting out with a simple status statement
> (eg. "The kexec boot command line arguments are not currently being
> measured."), followed by the problem statement in the first paragraph.
>
> >
> > For secure boot attestation, it is necessary to measure the kernel
>
> Secure boot enforces local file data integrity.  The term here should
> be "trusted boot attestation".
>
> > command line and the kernel version.
>
> The original version of this patch set included the kernel version.
> This version is just measuring the boot command line arguments.
>
Sorry missed it while updating the cover letter.
<snip>

> > The ima logs need to be carried over to the next kernel, which will be followed
> > up by other patchsets for x86_64 and arm64.
> >
> > The kexec cmdline hash
>
> ^stored in the "d-ng" field of the template data
>
I will add another template-name for ima-buf
> > can be verified using
>
> > sudo cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements |
> >   grep  kexec-cmdline | cut -d' ' -f 6 | xxd -r -p | sha256sum
>
> Until per policy template field rule support is added, a template name
> needs to be defined.  Please define "ima-buf" as:
> {.name = "ima-buf", .fmt = "d-ng|n-ng|buf"}
>
> I'm still seeing some scripts/checkpatch "WARNING: line over 80
> characters".  scripts/Lindent should provide the correct way of
> formatting these lines.
>
> Some people feel that references to Lindent should be removed, but I
> tend to agree with the Documentation/hwmon/submitting-patches.rst
> comment pertaining to scripts/Lindent.
>
> "* Running your patch or driver file(s) through checkpatch does not
> mean its formatting is clean. If unsure about formatting in your new
> driver, run it through Lindent. Lindent is not perfect, and you may
> have to do some minor cleanup, but it is a good start."
>
I will double check fix the issues.
> Examples of where the line formatting is off is the call to
> ima_get_action() in process_buffer_measurement() and the call to
> process_buffer_measurement() in ima_kexec_cmdline().
>
Thanks,
Prakhar Srivastava
> thanks,
>
> Mimi
<snip>
