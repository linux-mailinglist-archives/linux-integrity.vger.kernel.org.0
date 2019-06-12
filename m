Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDC2427C6
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Jun 2019 15:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731586AbfFLNiV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Jun 2019 09:38:21 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33974 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfFLNiV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Jun 2019 09:38:21 -0400
Received: by mail-lf1-f66.google.com with SMTP id y198so12148490lfa.1;
        Wed, 12 Jun 2019 06:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UY7y21dJsB+Vv+KTHZT1+SWlrWTMbptqQp8qZ6+ki6s=;
        b=SSOoBNlVOLDGP8PYIeqfIt7SpPWUxfxRDatw1IBPlWgrNBCr20Qg/QKyojIXTgREGr
         owZZ+EKhols5lg72JZBG7udRCMga60byNpjnqnj6TN4J7+mQgaVqc8LLY9kLApEbQAqh
         ca9QlZWgHhd4amLx/a0okzEs/+Kmuy3tIK2NZnA+4j44kJmWCGdv0/dLiYaq58YsluNF
         AtvLBHxmTLHSYEilMJQnCjUgysiXhf3Uz4DHog7eK0s+25gMZP6z+upkNph6KHR9cKGs
         Ut+jj9gFZuPIS5Azuavt5MOCoCl1BGjD1eQPzc8v/Dw2TauChpIgbK5XMfP/S8Suv/3Y
         k2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UY7y21dJsB+Vv+KTHZT1+SWlrWTMbptqQp8qZ6+ki6s=;
        b=cuVWNA59rTAgjsyRykmpuxAY+Ac22lr2viG7jNMnOi9SVbh3y85sXwE6cp4gcV69Zc
         4UN5AS+E+plTigLdintgixhVf5FOBlALyYZcyN4AS3JrvbW9e9+iVmBEW+VHH2fVDW0f
         w3fuyiCBrSFHLzDRv7iLoIBWu5QC3Scu+KuPZPl+y9w2S44PT/H4kIuetydWvxwm+zZ6
         TDtS+815bWbEzUnyHe+sVLgnsFwCyqLkjohIqIMKZu7mpX312LnXkwLiWfakI7+24GJA
         Mc6VVNLjLyQP7KF6iFCLBwH4nAmnfq3u0edMl5+adWEZs5v5GgFPoPbv0FaajPEorJbT
         0k4A==
X-Gm-Message-State: APjAAAVPGVHrsqn8TpRktv8ODy5iQbp6UXXDTLLkF0KAUPFQh0HK2Y8x
        nPkAF2d0U6bLisWRVCRDDb25CrrzsqELf6dxx8g=
X-Google-Smtp-Source: APXvYqyEoGOZ+eJm+g9aXZHaL7rE5MlALz8e6JnCIbzCeHuzDE1MQEh0In9CcTmycqNACTY+0UE1+ARCguPzJX4YAMg=
X-Received: by 2002:a19:ae01:: with SMTP id f1mr40375570lfc.29.1560346698799;
 Wed, 12 Jun 2019 06:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190606112620.26488-1-roberto.sassu@huawei.com>
 <CAE=NcraYOw9B3RFu3_DbJs9nPT87AtQEptC7zF4kAu4FP8YhxA@mail.gmail.com> <d9efe3c7-20dd-bbb0-40d8-40f69cba5b88@huawei.com>
In-Reply-To: <d9efe3c7-20dd-bbb0-40d8-40f69cba5b88@huawei.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Wed, 12 Jun 2019 16:38:07 +0300
Message-ID: <CAE=NcraHqzST=SZNcrSgpv5EqfyUfpCCb7iQ0Oh6uohL3yiCdw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] ima/evm fixes for v5.2
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@huawei.com,
        mjg59@google.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, silviu.vlasceanu@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jun 12, 2019 at 4:11 PM Roberto Sassu <roberto.sassu@huawei.com> wrote:

> > - after initialization
> >    - deny reading|writing anything without security.ima
> >    - deny reading|writing anything invalid
> >    - allow everything else
> >
> > The logic is pretty handy as it even creates additional layer of
> > security around the early initialization files as they become
> > unreadable after use.
>
> What if they should be legitimately used after the HMAC key is unsealed
> and before switching to the persistent root file system?

Any examples? Log files and such are mostly 'one way' and should
probably be whitelisted in the policy?


> > Now, if we initialize the system with a random key like in your patch,
> > this logic is to change quite drastically? It sounds to me the
> > userland may actually break, all the userland initialization files in
> > the existing ima configurations that do not use digsigs would become
> > unreadable given that the random key is put in? Remember, those files
> > can be protected via other means (most commonly signed ramdisk).
>
> No, the first patch is about adding the ability to verify files created
> during each boot. For any other file, EVM returns INTEGRITY_UNKNOWN as
> before. The second patch changes the behavior, as INTEGRITY_UNKNOWN is
> considered as an error for the enforce-evm appraisal mode. The second
> patch aims at making the system more secure, as no file would be
> accessible unless it is verified.
>
> It is true that configurations without digsigs won't work anymore but
> the alternative is accepting any file until the HMAC key is unsealed.

That's a pretty big change for the userland IMHO. Quite a few
configurations out there will break, including mine I believe, so I
hope there is a solid reason asking people to change their stuff. I'm
fine holding off all writing until it is safe to do so for now..


--
Janne
