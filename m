Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36AF71F2193
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Jun 2020 23:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgFHVpU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 Jun 2020 17:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgFHVpT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Jun 2020 17:45:19 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D198C08C5C3
        for <linux-integrity@vger.kernel.org>; Mon,  8 Jun 2020 14:45:17 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id l27so20065295ejc.1
        for <linux-integrity@vger.kernel.org>; Mon, 08 Jun 2020 14:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Igh1IwPinYOHclngfiWXcdsSPSUfVMy900DjvDtZXdE=;
        b=LOXuySGWu6oAFpGSLwRnURotT4T7GHHSY8T9C0/cwfQxalBA7tF1N8cu7f0k4Vd7je
         2No1nZdIXfZBnRgD9v81wSb36UQ5bjRNEbUXERvVtplQxTrxs8dvo4A6Mtj+6t6MuDzi
         ZPhVp9z/CE+pLdK4Zo5eEp5VKji/83r2UQmLRNH/pOJxDdHWL1lEtlYwDBnmwE22ei2e
         VQq4KTiFCLaSadosS5Zvc+cH8vt4rjRvXGRHit6il9pQWF2iKmhaynrEo6pO8pp/HJ+s
         B/pvew9eTKduP1472XSQBRUT6f8V9ztWio0h6GyyWcS+SWRPCE8iWR/zDxiCEZPGa39s
         A/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Igh1IwPinYOHclngfiWXcdsSPSUfVMy900DjvDtZXdE=;
        b=Jh1jA/rW/weGZK6ANB6wtMzt86RIqVjC3TRvdFImbxXSOUgQs7gioeFspPg2qb6Zn1
         fDDjvXRdUX8J5ELvdDITgRX7TSMh8k2TCXQoVCfBeF/dUUrAvZQF+dRM5bVNFbm2wwFH
         S8r1iVcPHt4T6UWVc3vZ0NJEGx0U3g9tK5kIu4wwm3Xonjv/6MyuR7bHGoZl4wrGVRM2
         eDC+c7b78Nb+FZf9OX/a/D1zpYK7yPpWF03vjKLmgVZ1aL3tr0smMPX/k42oCGeCVCHT
         fAX6mP2NrD9E38LtBdkcVKlVK2aPEA5xSE++Sw/shIVSRBWIaabYl06iwCTLlQGQxML0
         aH8A==
X-Gm-Message-State: AOAM532DqLiyfw9/YN+0RmJYeZMcQ74maZPX7MIkQnBdt9syzCrKmxPB
        BhlbODy9EyP8C2a3NeluEwd6PHuydaXJoNWJ4IbTCyg=
X-Google-Smtp-Source: ABdhPJzM1blhuSfAtHWQKHod1napq/wyiCDkQzMZK14COSUGFvoq3xTJ7+bH9cmWhMvSg5A2bYc3wf0KPT0tdU0HpE0=
X-Received: by 2002:a17:906:2b81:: with SMTP id m1mr21816983ejg.488.1591652716065;
 Mon, 08 Jun 2020 14:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200607221449.2837-1-nramas@linux.microsoft.com> <1591617171.4638.33.camel@linux.ibm.com>
In-Reply-To: <1591617171.4638.33.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 8 Jun 2020 17:45:05 -0400
Message-ID: <CAHC9VhQpK+Shy2b2tv+vrTS+a8+zZbsrRG=pjzoMK0LApJg1Sg@mail.gmail.com>
Subject: Re: [PATCH v2] IMA: Add audit log for failure conditions
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jun 8, 2020 at 7:52 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> Hi Lakshmi,
>
> On Sun, 2020-06-07 at 15:14 -0700, Lakshmi Ramasubramanian wrote:
> > The final log statement in process_buffer_measurement() for failure
> > condition is at debug level. This does not log the message unless
> > the system log level is raised which would significantly increase
> > the messages in the system log. Change this log message to an audit
> > message for better triaging failures in the function.
> >
> > ima_alloc_key_entry() does not log a message for failure condition.
> > Add an audit message for failure condition in this function.
> >
> > Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>
> Audit messages should be at a higher level.  For example,
> "hashing_error", "collect_data", "invalid_pcr".  In the "invalid_pcr"
> case, the audit log contains the reason - "ToMToU" or "open_writers" -
> as to why the measurement list doesn't match the PCR.
>
> Here you would want "measuring_keys", "measuring_boot_cmdline" with
> the reason it failed, not the function name
> "process_buffer_measurement".
>
> Userspace needs to be aware of the new audit messages.  Maybe include
> samples of them in the cover letter.

Yes, examples of the audit record in the commit description (the cover
letter isn't recorded in the git log), are encouraged.

-- 
paul moore
www.paul-moore.com
