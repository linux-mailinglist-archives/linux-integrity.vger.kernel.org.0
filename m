Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA6D1D38DD
	for <lists+linux-integrity@lfdr.de>; Thu, 14 May 2020 20:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgENSGd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 May 2020 14:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726532AbgENSGd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 May 2020 14:06:33 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C10C061A0C
        for <linux-integrity@vger.kernel.org>; Thu, 14 May 2020 11:06:33 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id r2so1226530ilo.6
        for <linux-integrity@vger.kernel.org>; Thu, 14 May 2020 11:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8qWZjfPNPeZVwJ+ttL8j414cG6OOVM8EPD8XZYqVff0=;
        b=ptd0FWt22/sTokSUEWQqFBto54E3rIiVRfyn8/K9iHJik0OfMrreWGMUvwgQYMv4n3
         Xgg51aO51JNj7KLXHDKEANHgJ2fTIO3rqH/BgFYfuBgJTQPUktdquglQpjui95OWwyXM
         S3OQmpJ359Ttt8Dz1hWLZc1jFVZBPKh/mKOJ5ecF0WfCYmLLqQER6ckmFGK/ALKowAr7
         kvypgXsWSDPi4vJ5pYdTpzRHIbO7DiJMK6cq6lycmmSMr0T/OgFligCbMYvBx8RgKANO
         NIZ/jPmicIV2prwApcvPgwt080iGhAt7p87EmTwj7GApn/sKhIQ5Yz8xIHak98hMyBCu
         xdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8qWZjfPNPeZVwJ+ttL8j414cG6OOVM8EPD8XZYqVff0=;
        b=B9Dami01wCw5Ehl2TAz6DgzNo/t2neSorOPFq3hGa7T5cNdPOlVUrQ71tsGDQ6PRTh
         xhb2XeMYGBC3GWVYbvmIbXXq5twC7GnQ4QTD1jIgxJUjxW5s//npkihxjzbQvHucoAXk
         46cPv/qsADZjlyFofb0svAuBbWg8eI5q6i8ANTQF+wAa191W1WAyl1CX8J4xd8a91E99
         Yb0Rxm8xAHlcGBJziO3Ga8AdoDhIsXRboFu+vSg/OfL8H23CfjkYDOj6t9SCoDb9X2xT
         1zyZNsNI3wXjX9oYSXFMWOK6pfFN9PsPl7Jm2VSJ7kT3MNH1V40179jFn+RYl6aA0iwt
         djeg==
X-Gm-Message-State: AOAM532F3kAimZyFsMQt1BCm78G3S9zkpPR6LbT86VrpzfVCqpJpywQQ
        tKDDkTDAuHZ0wRjcM+KzPjO3j1p+u3bU6y++jVKSHA==
X-Google-Smtp-Source: ABdhPJxQ2G/I+phiA1Oxlw5adMrjtQur2AcgiBWHOsJp9LSYDeOS8LI7xvExvWg9TJjCtc8o/+w8WdCwRpBFyVn4fug=
X-Received: by 2002:a05:6e02:ecb:: with SMTP id i11mr5847140ilk.169.1589479592114;
 Thu, 14 May 2020 11:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200512040113.277768-1-loic.yhuel@gmail.com> <CACdnJuv8OyQpO4achWJb2HeB8Jb6Ejq9LsG64659JSay-a9O5A@mail.gmail.com>
 <116341780ff56884d2f03aa9b90a8f9566b91540.camel@linux.intel.com>
 <CANMwUkir2WTA7-J--Y_QFz8ZX5dHNTtLru19FHYew1uyxyKYNA@mail.gmail.com>
 <29fb28c4-9642-0265-a926-455377066b75@redhat.com> <CAMj1kXHFKajuvd5KkrQTozebKzaO1LaMQdd37unLs_dGR0UwVg@mail.gmail.com>
 <789b40ad-3017-b2cc-df15-d2739787d05e@redhat.com> <CAMj1kXFs6Z8VwqRMHf_OOZct4xNnNqiVOGBO0TtLfirg7WX8Eg@mail.gmail.com>
 <9ebd9e60-12dd-a6df-923c-dc9c6dbd709b@redhat.com>
In-Reply-To: <9ebd9e60-12dd-a6df-923c-dc9c6dbd709b@redhat.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 14 May 2020 11:06:20 -0700
Message-ID: <CACdnJutqe03fypMBSQrXcBovOJ+-Vy0C1T54GJ_BD4miMUq9fQ@mail.gmail.com>
Subject: Re: [PATCH] tpm: check event log version before reading final events
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        =?UTF-8?Q?Lo=C3=AFc_Yhuel?= <loic.yhuel@gmail.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, May 14, 2020 at 6:51 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> That's what is not clear to me. For example, if a firmware follows the
> spec what happens during EBS() when a TPM2 only supports the SHA-1 format?
>
> Does the firmware always log events during EBS() even when it won't provide
> a Final Events Table? If so, are the SHA-1 logs always incomplete?

In my experience, yes. We deal with this by just brute forcing all
possible PCR5 events until we find a solution that matches.
