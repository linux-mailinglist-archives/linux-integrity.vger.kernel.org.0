Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E96A819FD80
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Apr 2020 20:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbgDFSvQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Apr 2020 14:51:16 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46295 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgDFSvP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Apr 2020 14:51:15 -0400
Received: by mail-lf1-f67.google.com with SMTP id q5so306923lfb.13
        for <linux-integrity@vger.kernel.org>; Mon, 06 Apr 2020 11:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qhtGc2NWi/8OTbqNFI47F+sBa8PMVgXlDImrvNA4WeI=;
        b=RF4PSQ9c4jPFn4H6RVBhebbVanX6GFbOLrOG5+Unj/WUoFPubwZM11fvBIKGAYwftJ
         Zgm2/O4v03W3DbXDUVS5ljY+yaztJk2uzRBoyCkU0mLc6LU0jSv0IOXAuA1GEq8rg9HK
         ld0K+E7Oks5lW3gbwj/gxVyDwi/yekrFAjEvo25NCwULZylzAHMP6WrFLp0ZhZIZ4OAq
         bM2zu1Wlb/74JizmfMIZwlN4iMv8M4LBl9PVzlCAc1iBmukHpwtb1U6BTlmT5igQ6C5P
         CnFUZd4WJEv0u/3EViJf+WnVIozV4rPWDXauNMMUn13fLREesEcNaXKQ3gkLbo7ZcMbO
         1G4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qhtGc2NWi/8OTbqNFI47F+sBa8PMVgXlDImrvNA4WeI=;
        b=dHruHht5PMhLoGddayS2nxoVQFlo+77osCCNMtT36nmm7wyInrJwdNpHbQRI382oj4
         lvhIq4AoyGZyTibR/ygIsyeRhJ2DvTxiGD9suSK4lKkkjN47MmS0lrjtAxjVh38J9rOk
         CgrytL3VlLMadyBY+PSZEwA0536xeUlGa3h0QVhSuV9SAmbfNmgGHxhKh9PGrKs7E/1z
         OVnbZyY7A2KYt8ayeEnLFoXW8g/ixkOF8rEyEeZ5De6gw1gf+DwDxbMcPNOzieOFK/8t
         43g/atakBi/VWkxqfXMHzb9zH3+puAEPML+nsWOUx4xINRz3nbwrZijY9b4wc8QircIZ
         Or6g==
X-Gm-Message-State: AGi0PuakIkm5kF76hT3m9FnpeorjlUZ1LH9HqY7GT8vVPtjcyP4W5heV
        OAGJVwr6HPfVEXcY+czSt+5ACzEIVbkM9nac+WpxIA==
X-Google-Smtp-Source: APiQypKCNJNdNFC2PRonEgYGyMcSGGcujUHyRc434pzWMUoZss+1QGGz8dv1ab/TAjDHReQ3qA2uS582dsE/9/zblCs=
X-Received: by 2002:a19:c850:: with SMTP id y77mr13013340lff.45.1586199073198;
 Mon, 06 Apr 2020 11:51:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200406181045.1024164-1-deven.desai@linux.microsoft.com>
In-Reply-To: <20200406181045.1024164-1-deven.desai@linux.microsoft.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 6 Apr 2020 20:50:46 +0200
Message-ID: <CAG48ez3JV-tzjRLdcys6Fz9LKYaB1h-1GaeAzkUYtY1RgxsB6g@mail.gmail.com>
Subject: Re: [RESEND PATCH 00/11] Integrity Policy Enforcement LSM (IPE)
To:     deven.desai@linux.microsoft.com
Cc:     agk@redhat.com, Jens Axboe <axboe@kernel.dk>, snitzer@redhat.com,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        tyhicks@linux.microsoft.com,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Sasha Levin <sashal@kernel.org>,
        jaskarankhurana@linux.microsoft.com, nramas@linux.microsoft.com,
        mdsakib@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Apr 6, 2020 at 8:10 PM <deven.desai@linux.microsoft.com> wrote:
> Overview:
> ------------------------------------
> IPE is a Linux Security Module, which allows for a configurable
> policy to enforce integrity requirements on the whole system. It
> attempts to solve the issue of Code Integrity: that any code being
> executed (or files being read), are identical to the version that
> was built by a trusted source.

Where's patch 02/11? lore at
https://lore.kernel.org/linux-security-module/20200406183619.GA77626@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net/T/#t
has everything other than that patch.
