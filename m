Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96CC24663E
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Jun 2019 19:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfFNRwu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 14 Jun 2019 13:52:50 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35492 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbfFNRwr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 14 Jun 2019 13:52:47 -0400
Received: by mail-ot1-f68.google.com with SMTP id j19so3468158otq.2;
        Fri, 14 Jun 2019 10:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZWIf587I0I/IIO3dm5/wm1By4rJHZ+H19lkvJnydh20=;
        b=milTqAIRSdQkbg+N9Pa3KMpKvZDfQHcxJqP+24UT886LqQASMh+9tLPsoFbHhkmLhM
         cDxD3zdC3MY2sIYyeHmGdAUsx+NFQ3DMOxErlCmNTGLs4jp3ms2nc7iV4Nud4UChVh7h
         TQXphH1ZouQfXp6NWtHXjye70r/2+/r0JMHTP17p5y4XqqpzmR8lxUnUQ9yyN+936YhH
         aiI8aaxRrF9lByfeoFT40ulwJ8loD7sqcBFPxNdEmKA+prvMQmhB8OmTCzJI8WK894ke
         BbG0hi0dj8xIusdAwL1e3pS7KhE+ur14WbclFJCX78gaF0bPW7tLl3Lhio8wy+6YvRFI
         50hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZWIf587I0I/IIO3dm5/wm1By4rJHZ+H19lkvJnydh20=;
        b=jZXlXQtzuBOW+Su7L8RPo21bkgvQqmM8tgcge/4kviWZupeI0yO4YCuzWdz6y8l7Cs
         xRUfRTFopFVp4zqzMKsNuqXnmsfb6KRE87KtOdYQWxQNeWU10+blDzx5dDzEwd6GOjzB
         T8ndlsQDj3t/NEhM2OtmmZz6lwaDdV6ABVsljiPwi69WWHP/rlvpwCKKHnE0zc4vRH+8
         DS/0y7O+oDkXy4IMVTFrlTYADZ/B3KjMAIkYcPG3DMHjg6q4bmhhY6s2yvnuKlsj8Xb8
         QRjkTadI1ly3CMXE12VnfrXMlWzPfGsGhpprGkRFCeAtmiKCXUA3vzmxaKg6M6BFBpr8
         ozJQ==
X-Gm-Message-State: APjAAAXNw7ozXL7sgIW6XxKNFeevI6Iqn+y+kfrqtah+cnqvliHlIQ3J
        69C3BuXC7hB2Txm3d5TPEpS2I/yhBITOkPis+gToD4Et
X-Google-Smtp-Source: APXvYqzvCvm1eY5/2Sub7G3piT3spKXBEzftR3A6CCDw+d0ELK+Uz06CI/iqOgvM9+lOQptFqtfBk0NYnRxHxBrpOPg=
X-Received: by 2002:a9d:5911:: with SMTP id t17mr393254oth.159.1560534766509;
 Fri, 14 Jun 2019 10:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190612221549.28399-1-prsriva02@gmail.com> <20190612221549.28399-3-prsriva02@gmail.com>
 <1560455980.4805.57.camel@linux.ibm.com> <1560509860.4171.13.camel@linux.ibm.com>
 <1560521651.4072.7.camel@linux.ibm.com>
In-Reply-To: <1560521651.4072.7.camel@linux.ibm.com>
From:   prakhar srivastava <prsriva02@gmail.com>
Date:   Fri, 14 Jun 2019 10:52:35 -0700
Message-ID: <CAEFn8qL-Fumt82oZ6-J-dWA29ztLLraJ6iXc7+du=vNtyBQO4g@mail.gmail.com>
Subject: Re: [PATCH V8 2/3] Define a new ima template field buf
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        thiago Jung Bauermann <bauerman@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 14, 2019 at 7:14 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> > > > diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
> > > > index 993d0f1915ff..c8591406c0e2 100644
> > > > --- a/security/integrity/ima/ima_init.c
> > > > +++ b/security/integrity/ima/ima_init.c
> > > > @@ -50,7 +50,7 @@ static int __init ima_add_boot_aggregate(void)
> > > >   struct ima_template_entry *entry;
> > > >   struct integrity_iint_cache tmp_iint, *iint = &tmp_iint;
> > > >   struct ima_event_data event_data = {iint, NULL, boot_aggregate_name,
> > > > -                                     NULL, 0, NULL};
> > > > +                                     NULL, 0, NULL, NULL, 0};
> > >
> > > here, don't belong in this patch.  It belongs in "IMA: support for per
> > > policy rule template formats", in case it should ever be backported.
> > >  Please post this as a separate patch, that will be squashed with
> > > "IMA: support for per policy rule template formats".
> >
> > My mistake.  I should have picked up Thaigo's "ima: Use designated
> > initializers for struct ima_event_data".  Please drop these changes
> > instead.
>
> Sorry for the confusion.  I just pushed out Thiago's patch.
>
Just to clarify:
- no split up of patch is needed.
- only formatting needs to cleaned up.

Apologies for the formatting issues, my editor switches back to
tab as 4 chars.

Thanks,
Prakhar Srivastava
> thanks,
>
> Mimi
>
