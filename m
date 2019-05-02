Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9331113FA
	for <lists+linux-integrity@lfdr.de>; Thu,  2 May 2019 09:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfEBHPC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 May 2019 03:15:02 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35791 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEBHPC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 May 2019 03:15:02 -0400
Received: by mail-io1-f67.google.com with SMTP id r18so1208343ioh.2
        for <linux-integrity@vger.kernel.org>; Thu, 02 May 2019 00:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0j/hy+dXgc/RAD1S28k76wVU38bkzXROFiJee/uy828=;
        b=cw7o1hclMVDYD/mFSXXORj8k6owJ56onVZPfH09xygF9uxK4qjYMP+dvtxhcH8xSVX
         unyG8nRFxcr+vKPkF0aqwp2FJ6t44k02rHFxIP+3FZID4voAH48LxjsffUcNfI48hlpj
         BQg/QNZnuXxe64Uy2niIYoZzJcqprwnFK7Yuy3zilrCeV1kZ4m9oX3GRQ9kCnwpgy4W2
         JXTyOvMsSYAwZF/xGCUjdWF/2z6GsXLBZMuWpHsx2EaYhZC0qLPwvipUzFrBHsxhU8Pi
         awPEKVdHmGODJf6c0uVZCgrNapYJCSfmu/I5c13IkBxSvbyGyEoMguLbtWCYdtlebfxi
         CZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0j/hy+dXgc/RAD1S28k76wVU38bkzXROFiJee/uy828=;
        b=Xkd4y+kgBegHeRjtmPydOnVTvv040S4sLe/OD0XrsUII9liKnoYNW2Hltr3brRnypM
         utE/Kg/hMBb65R6W1yZ8J0IiylGO7MSiTK90BQP9y/YraIDFpAsjbKymhMkmGx1CbUWh
         hnHoknksXJSO93v/ZEK/l9ykNWVGCQmSkGstoTxHDEcSoOOe33Vul00yZ+jaXfQMNbP9
         Mo0L24RhHw1XI8hnZzVwPggOSL92iTZBbRv2egmx7xyT063LwKbmWWx+6Exg6GElRUtn
         rp6vpcIBiNi3g/djM72tgobZTwnpeTITineRjFavk3kJdJ6ZyVdqS7xBhhUc27Y8qfbO
         Jqhg==
X-Gm-Message-State: APjAAAWtL3uJEUJiVGmdZOrM1L1l5X5cYjZAHVz10RlEHQnEydG4owv9
        c6XtgLARDdOs37PZt8Uv2+6dgLn7h9v7CMMWGFuk0w==
X-Google-Smtp-Source: APXvYqyLXFhanRapf4HA+mfoEWHn5Jxfo9LLiiHWDJl2//wytx+jBGTeO77YmBHW8+v51a7Y5BRQwKsa/QawpWYEXPg=
X-Received: by 2002:a6b:7b47:: with SMTP id m7mr1443589iop.173.1556781301704;
 Thu, 02 May 2019 00:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190227202658.197113-1-matthewgarrett@google.com>
 <20190227202658.197113-3-matthewgarrett@google.com> <CAJzaN5pUJoOCz5-ZDSnTb6dbVPuy0QwmFD0CeofAGK+bRQx0og@mail.gmail.com>
 <CACdnJutpBPAX6TOGgs3Ng2v_cC5hAf-3pHThESvjQ9vbvQeVkA@mail.gmail.com>
In-Reply-To: <CACdnJutpBPAX6TOGgs3Ng2v_cC5hAf-3pHThESvjQ9vbvQeVkA@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 2 May 2019 09:14:49 +0200
Message-ID: <CAKv+Gu9PF4u=-7QL4e36Q3S5kC4+5Z=yLYHLT9jE+eNY7YUV7A@mail.gmail.com>
Subject: Re: [PATCH V5 2/4] tpm: Reserve the TPM final events table
To:     Matthew Garrett <mjg59@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Bartosz Szczepanek <bsz@semihalf.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

(+ Ingo)

On Tue, 30 Apr 2019 at 21:52, Matthew Garrett <mjg59@google.com> wrote:
>
> On Tue, Apr 30, 2019 at 6:07 AM Bartosz Szczepanek <bsz@semihalf.com> wrote:
> >
> > I may be a little late with this comment, but I've just tested these
> > patches on aarch64 platform (from the top of jjs/master) and got
> > kernel panic ("Unable to handle kernel read", full log at the end of
> > mail). I think there's problem with below call to
> > tpm2_calc_event_log_size(), where physical address of efi.tpm_log is
> > passed as (void *) and never remapped:
>
> Yes, it looks like this is just broken. Can you try with the attached patch?

I'm a bit uncomfortable with EFI code that is obviously broken and
untested being queued for the next merge window in another tree.

What is currently queued there? Can we revert this change for the time
being, and resubmit it via the EFI tree for v5.3?
