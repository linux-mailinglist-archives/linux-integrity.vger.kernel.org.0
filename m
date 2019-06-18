Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87633496B3
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Jun 2019 03:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfFRBbc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Jun 2019 21:31:32 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:32905 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbfFRBbc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Jun 2019 21:31:32 -0400
Received: by mail-io1-f68.google.com with SMTP id u13so26021526iop.0
        for <linux-integrity@vger.kernel.org>; Mon, 17 Jun 2019 18:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2WT4SOUGABYGWzHRzghnrNDzGsi4pV3a3Oj1deUpmBU=;
        b=t+ZZOMtbO+lttG5rT0PFjxj+7XqRqEGB/T1fAiceQjcihUlOlfke3ne94iEEn1NhTP
         FrNMyvz8aJAI3eSDqt0Ckt3gEmCKzsaprV9ZtjfhU55wr9jWrPeGSet0M/Z1W8fFyhZX
         lxgWNzr/oHhoinw911bAQsJhYffjPyHYGtBIz10V8ODPOxCQ0DvZYQQ7YwwxWTjil8sv
         J051DY8CrzdPq4V7QwGucwkAToTuYBGE1jFQIpUK5exRmW3MMhv6klb3Gaoe7EdNp2II
         jOlqU0QcCl2ODykKG07wCzZdLqinn8Q5bT1Q0P1Rq+DYtjFyi3dllF2uVoYIFOPw+rfs
         XxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2WT4SOUGABYGWzHRzghnrNDzGsi4pV3a3Oj1deUpmBU=;
        b=QQtVc1N1X8WcPEgsJH6quRxMJCr2ECImfRBU6ToBGmcWLhkqgx2/3u2DhITGmjQo8Y
         9bGRXY95DjFiwhsWpHHwCCLSfrLhFoDSNRGHDdYMAIO9MEeezkUMiRUo93hOcLD4rSQd
         xFQcteuGXGlDhoXvV+W2ssf47sPVU/TjWUyps+9I/FyNlOsc+ATN6//KhY/6FqAHu3wS
         M/E5/PWZWXrXAd5DCyUJQR+0SQh1n7a6Mg+F6SaXsxZz3zAvv1Nn5QciCn8k9/Ktb5J6
         g2fWXpb+c1ZXFzrqyWwQvSCCUtumTTU0jFcLTk4I7rOJo0vlaoLamiO6RegzKY6ngKzI
         rFBA==
X-Gm-Message-State: APjAAAV8mKteGmd3KWjjbuoDVzAiaSkm2i01UCYYw+IOnlDv1FR8/4TB
        P9uJSFQRoECDxI1EoLYM+pWfc3xwKwctZhaW60mwsxyC
X-Google-Smtp-Source: APXvYqwLVPt+lP4uSINHg/7/vesTWjAKRqePScw8/I7343un5tc9CbxJhurWzjz5x4Vtq1+QoliWIXEI14xZXNQpfDc=
X-Received: by 2002:a05:6602:220d:: with SMTP id n13mr10146995ion.104.1560821491398;
 Mon, 17 Jun 2019 18:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <f9f2a5ab-a880-7131-d0ca-fb3b72571478@linux.microsoft.com>
 <71cc3b9b-d045-8a69-5917-96b4c5654b16@linux.ibm.com> <0561ce44-f8f7-15f5-6eaf-fb97a785692a@linux.microsoft.com>
 <7da97815-a09a-de6f-dbf2-7d2c96a077bb@linux.ibm.com>
In-Reply-To: <7da97815-a09a-de6f-dbf2-7d2c96a077bb@linux.ibm.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 17 Jun 2019 18:31:19 -0700
Message-ID: <CACdnJusuFRXKXf7B+27PU7S8zHxZnrrQZdP2HBBNt2J97-qs0Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] [IMA] Measure public keys of BuiltIn Trusted Keys
To:     Ken Goldman <kgold@linux.ibm.com>
Cc:     Lakshmi <nramas@linux.microsoft.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Prakhar Srivastava <prsriva@linux.microsoft.com>,
        Balaji Balasubramanyan <balajib@linux.microsoft.com>,
        Jordan Hand <jorhand@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jun 17, 2019 at 10:05 AM Ken Goldman <kgold@linux.ibm.com> wrote:
> On 6/7/2019 1:15 PM, Lakshmi wrote:
> > By knowing what keys were used to install the IMA key(s) the service
> > knows whether or not to trust the signature validation performed by IMA
> > on the client.
>
> How does that happen?
>
> In order to trust the IMA validation, it has to attest to the code doing
> the validation, and to the IMA keys.

If you can assert that all code you've signed with your Secure Boot
signing key is trusted, and that all keys that are embedded within
code that's signed with your Secure Boot signing key are trusted, and
that all keys signed with those keys are trusted, then you just need a
mechanism to measure each component of that chain and attest to it.
This is, as an example, the default Bitlocker policy under Windows -
rather than seal the disk encryption secret to the full set of PCR
values, the secret is sealed to PCR7. If a non-Windows bootloader is
inserted into the boot process the PCR7 measurement will change (due
to it being signed with a different certificate) and the unsealing
will fail. Since Microsoft can assert that they will never sign
something that they don't trust, this avoids having to re-seal the
secret every time they update the bootloader.

> E.g., I can know that libfoo.so.1.2.3 is signed and who the signer is,
> but I may not trust anything older than libfoo.2.0.0.

If you want to construct more complex policies then you need to
examine more information :) This approach doesn't work for your case,
but if the policy concern is "I want to ensure that all code run on
this system came through my build pipeline" then you don't need to
look at individual signatures.
