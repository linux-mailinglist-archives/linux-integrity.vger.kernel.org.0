Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A522D0608
	for <lists+linux-integrity@lfdr.de>; Sun,  6 Dec 2020 17:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgLFQky (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 6 Dec 2020 11:40:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59016 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgLFQky (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 6 Dec 2020 11:40:54 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607272812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UxNaH561nB/6wMCKxSCm/5bzqrWkopP59aHNwUEfXOY=;
        b=irjdflqS5FY9QNzj8yWEc0CGDtedfGm3Fed9wbR37X8mUImXyniJAr95CnF8GzZQfXPL0X
        PF8CaqXUSMNzdW0Pk5EjFxOefJpKJ3q3FteUSVIxsIh0Tc+r/DvdDXVXEekB7Piyhl2Y2/
        Gt6wt90XA8kc70biQYfl8nJgw5azvWQAre113wb8dQ4k/leC2xHkd42Np/DB3pHQ8JwYjV
        tKN3xbJJnA2QouLmBbFNOoNP9DVqPqs0g7GIv84jSvSfjBgHClBYSImwFnKBXNfnDoKkHT
        3AfpN0IihmtNwDDfzVtbHgz0bMyHh9rNP9EjmiJ6abzZUKHhSANtj2DSe6AZvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607272812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UxNaH561nB/6wMCKxSCm/5bzqrWkopP59aHNwUEfXOY=;
        b=YoGEF3MW5EHD8I8tGxLjV2l9qtp6ZTGOjeT+9EUTRn+dmQaP6rZR+5yqYKsCV/sMsQA4cM
        60KKUekD3ZhH0TBQ==
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kernel test robot <lkp@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Matthew Garrett <mjg59@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com
Subject: Re: [PATCH v3 1/4] irq: export kstat_irqs
In-Reply-To: <20201205103954.GA17088@kernel.org>
References: <20201205014340.148235-1-jsnitsel@redhat.com> <20201205014340.148235-2-jsnitsel@redhat.com> <20201205103954.GA17088@kernel.org>
Date:   Sun, 06 Dec 2020 17:40:11 +0100
Message-ID: <87360i99ck.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Dec 05 2020 at 12:39, Jarkko Sakkinen wrote:
> On Fri, Dec 04, 2020 at 06:43:37PM -0700, Jerry Snitselaar wrote:
>> To try and detect potential interrupt storms that
>> have been occurring with tpm_tis devices it was suggested
>> to use kstat_irqs() to get the number of interrupts.
>> Since tpm_tis can be built as a module it needs kstat_irqs
>> exported.
>
> I think you should also have a paragraph explicitly stating that
> i915_pmu.c contains a duplicate of kstat_irqs() because it is not
> exported as of today. It adds a lot more weight to this given that
> there is already existing mainline usage (kind of).

It's abusage and just the fact that it exists is not an argument by
itself.

Thanks,

        tglx
