Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24E3712DE00
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Jan 2020 08:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbgAAHNX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Jan 2020 02:13:23 -0500
Received: from mail-lj1-f171.google.com ([209.85.208.171]:46823 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgAAHNX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Jan 2020 02:13:23 -0500
Received: by mail-lj1-f171.google.com with SMTP id m26so35445988ljc.13
        for <linux-integrity@vger.kernel.org>; Tue, 31 Dec 2019 23:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=75PQXzhVAzpvhLKT8tUw9F6wlgp1CbSBICIpH9KR25E=;
        b=HHih2n4RhrQUgZba3ScwBiMPx++8nL4BVUE6OWaSw0IVbLl48cXir9ST/nx9TxjzoR
         9XICVcKL7K9iZ7xvnBOVls1VNUXk05Dh8menD3IuZxahIF+CzckIkRe/bXblbqmIsDgy
         0FaENhnJtsg5Y/Buil31GEajfnfVMx0hZbHqqkBzgrqnsBe9T1xJ8x6E0KS/z7GpL/dj
         P0xZIFhaiA7esMol89wiA2L2H4dqqRWjdFfIsXrgchdQlkt43nlAOQfnBoj3SHByxNsz
         D/GXc8WR2pd/NB6YWfyftvm814rm34YWcdiM5ATBRO+cHOeAfdflaReLohf+stIue41/
         la+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=75PQXzhVAzpvhLKT8tUw9F6wlgp1CbSBICIpH9KR25E=;
        b=GryHAhrOZ/s4Ry1hGac/U6h51dPnaFbJDTMtPpVXrID7ERYvHyrznNdYJxwKVlygqA
         0nnVDIM1NzVeU30rcocUAhpx6K0neWw2Hw+TVb10ziLeie1dvAaXNiY+bhFMlalM65JF
         qIYjiXBqHEGFD6bs28oR9dqR04e/5faPND8SjCbbyyobXI7KYrec9rBta7MyjDCdLRQ3
         4vK1EG8ulqWFvT0Uauh5+vzCkPgCQS1xvAKKF17PqPv0i+3ISDz1GsRq5my1jIWlKPxX
         UeqLOfEWkx2arO+A/JGE0mrJS7vXEZRxvVs2K291ZtD+P30yAEvRgY8RrrNP0y/xa19L
         KDMg==
X-Gm-Message-State: APjAAAVdLauYxmSfyqEVVfTKV9KP8cDjxpveTvriH+Urq1IYupwaPekn
        9x7EbKmagdL/1Ywdx9Yo61CNzLu2BaPjWzfEPaj1r+n+
X-Google-Smtp-Source: APXvYqysSE9vsNg+pNHnu4Ytt7B68YLgNKJm+n3uCG9lx3EY0G8S42hP9BuqJGxCb1kAcltSuCCA/G+Zj5IZYX4VSJ8=
X-Received: by 2002:a2e:461a:: with SMTP id t26mr45593129lja.204.1577861091787;
 Tue, 31 Dec 2019 22:44:51 -0800 (PST)
MIME-Version: 1.0
References: <CAE=Ncrb-kMDRgALnvXtKukSVLEw81rqxGv6+XXxg487Q_qLKGA@mail.gmail.com>
 <f48371ec-3754-05b8-3b31-da6842f9d486@linux.microsoft.com>
 <CAE=NcrZyFRkK7hQohZq5y5wANfbehJRrvs-3BeCOTg9SF=-X=g@mail.gmail.com> <7683ea32-06e8-eef2-ed4f-8ace37a0f458@linux.ibm.com>
In-Reply-To: <7683ea32-06e8-eef2-ed4f-8ace37a0f458@linux.ibm.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Wed, 1 Jan 2020 08:44:40 +0200
Message-ID: <CAE=NcrZXCOVaA01+vKzh01mOAqfk1yDYR6CDG8Ag6Ggeqe+jvA@mail.gmail.com>
Subject: Re: forever growing ima measurement list
To:     Ken Goldman <kgold@linux.ibm.com>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Dec 25, 2019 at 6:39 PM Ken Goldman <kgold@linux.ibm.com> wrote:

> > AFAIK Linux only does buffered io (with LRU) unless sync is being
> > explicitly asked. Exporting the file would be a rare event, so it will
> > not hopefully be a performance sensitive operation by any means.
>
> My experience is that the 100's of msec to do a TPM quote signature
> makes the rest of the attestation process negligible.

Right.


> In addition, an optimized system only sends the full log once, and
> deltas thereafter.  It would be nice if there was a fast way to
> skip to entry n without parsing the internals of each entry.  Perhaps
> this could be added as part of the "copy to a file" enhancement.

Sorry for the late response - we had a holiday far out without a
network. That's a good idea, I will try adding it.


--
Janne
