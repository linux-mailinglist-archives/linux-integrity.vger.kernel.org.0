Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A230B43BCDF
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Oct 2021 00:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237432AbhJZWKU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 Oct 2021 18:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237390AbhJZWKQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Oct 2021 18:10:16 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3898BC061570
        for <linux-integrity@vger.kernel.org>; Tue, 26 Oct 2021 15:07:52 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id g141so769556wmg.4
        for <linux-integrity@vger.kernel.org>; Tue, 26 Oct 2021 15:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=V17WmCwRtXGRdK392LhVvTE5PcTWawWUf/aqzjOa1QM=;
        b=oPlxGXYSCOKlcmzZcP6ZHp0gWhs31+1MHvyUGdjV08ijNi/vu3cpQExSdhZ0Wqpstg
         6eJfLMi4UvcvdWdp+KavOEqRTkocN7lCDQCvYqOdUwLndpIhMN+3Yt094vuzF+bLq6p8
         BSadi15PG0LG4hj/QLyrJ8YM9GvEMu99A9A67oM+chlrcFGzaerBi3K/zTsj/KzSytDE
         awhCpC26q+GOwMgwtVh8M7sMqUlUbBNQqLlkSPQrUX6xtgNXPmRN3htMplK+BfiBHuuq
         qotIdSiBrM+3jI5aBg3XeDr1dWVaMhFswxnjG3oLGgW1/epbOIYIb5CGm/rQprUXFL7q
         MWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=V17WmCwRtXGRdK392LhVvTE5PcTWawWUf/aqzjOa1QM=;
        b=vk2OPXp0DtTQALR+FrdQGVJMsfLLpbz0ilD+eU/nO5wJnXpEA12qoVeu0a1gpNjfjJ
         lHlKH1KA/xAku2yLzrFOVL83mhJTQQZ10uTDUesMUtm4tTryjLZb9n8+d6DB7OzyOuOI
         VsSXL3xLZBBgITD+cfhktRELjvPA42S/Dls8beJOL8auRXb8j9heM7BPhm2zdE9zpSuJ
         el73id0krxzrJ/k/NMkdVkcIqyaTtbYdjRcLl7qaXvtG4FrYD/TIfflpFPbjpL56SjhT
         VNEZ1vvQMAhzSu0gx/f9tnUKosw7Ph6ct+wPt5MAjWthQz3OTuJIMBZM5NHLsbl03oJP
         Oeiw==
X-Gm-Message-State: AOAM531/XfVBQ7/OZYGeTqqMt/Kap78Ro94RWnAeDoc5wYb6X/KQNPeQ
        AIhqg3snp/y46SAMfFFhK7/rPxsIjP8=
X-Google-Smtp-Source: ABdhPJwQfJZrf55oirJ1uzTDplQgg1EK5snHzU6fTkzE0ndb+i5IuckyWyydAjFOyV6G78v3VkEgaQ==
X-Received: by 2002:a05:600c:ac1:: with SMTP id c1mr1474407wmr.99.1635286070825;
        Tue, 26 Oct 2021 15:07:50 -0700 (PDT)
Received: from pevik (gw1.ms-free.net. [185.243.124.10])
        by smtp.gmail.com with ESMTPSA id f7sm1960818wmg.14.2021.10.26.15.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 15:07:50 -0700 (PDT)
Date:   Wed, 27 Oct 2021 00:07:36 +0200
From:   Petr Vorel <petr.vorel@gmail.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH ima-evm-utils 2/2] upgrade to glibc-2.34 uses clone3
 causing CI to fail
Message-ID: <YXh8KDsB1Q1AXwIQ@pevik>
Reply-To: Petr Vorel <petr.vorel@gmail.com>
References: <20211026024929.535519-1-zohar@linux.ibm.com>
 <20211026024929.535519-2-zohar@linux.ibm.com>
 <20211026143054.7khp5jxcyn2fzira@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026143054.7khp5jxcyn2fzira@altlinux.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Vitaly,

> Mimi,

> On Mon, Oct 25, 2021 at 10:49:29PM -0400, Mimi Zohar wrote:
> > Both opensuse/tumbleweed and Alt Linux have upgraded to glibc-2.34,
> > causing the CI testing to fail.  Disable seccomp (which is not needed
> > anyway, since GA uses throwable virtual environments anyway).

> JFYI. We decided to update our glibc package to fall-back from clone3 to
> clone in case it's EPERM. So, after some time (perhaps a day) this
> workaround will not be needed for ALT Linux. But this will not hurts
> either and may be beneficial in the future.

I see, 09e37c71 ("__clone_internal: fallback to clone(2)/clone2(2) if clone3(2)
fails with EPERM" [1]. Interesting.

Kind regards,
Petr

[1] http://git.altlinux.org/gears/g/glibc.git?p=glibc.git;a=commitdiff;h=09e37c7111e39b7c70846aea30941c03c43e6f54
