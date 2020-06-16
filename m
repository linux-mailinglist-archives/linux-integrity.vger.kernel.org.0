Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350211FAB2E
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jun 2020 10:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgFPI3O (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jun 2020 04:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgFPI3N (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jun 2020 04:29:13 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB93C03E96A
        for <linux-integrity@vger.kernel.org>; Tue, 16 Jun 2020 01:29:11 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id n23so22426595ljh.7
        for <linux-integrity@vger.kernel.org>; Tue, 16 Jun 2020 01:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iUa26xbgXJeW35l3tPgw/qFl/EH6eao+CWqtytwfzpQ=;
        b=iMCa5KT2ALytLHCboqE4ka0Vk2yBe2jHv5q9UFQVadNvRX3zx00OIPajzJCVE19Yft
         NeN7/m9OMHOktHEjg4ng9Rgq+NvUIt1DxbCKPzNuvMctWuZ6RWKtXcxCp5LE2kIhwbzk
         1BOutYp1/+XG6uSXw5UjGgRbXfnLdvJ3J+jL9zoo2aBgRHrQjh4S4jFjwS7ur6ydhC38
         bhCOgGLsvhkV8PYh8xKJSsdhZy2EXyW7Cp+/EjD0irhb0/GBJo//2qP1Yq9AsS4UI3/n
         b+fyFAzy5mzEU8RTsFITTmVbZMWJw/oWGoSg1oStrROaTzMkjmT27u1BV+nJ8tK7aeR9
         EH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iUa26xbgXJeW35l3tPgw/qFl/EH6eao+CWqtytwfzpQ=;
        b=dLNovvZ9Di2SphKoHvnm/58dor/bxmUY2Gcg85h63ne7NjfraFMcOruPSNlmyPBU6Z
         KXSMSO5HeKNZOuXbhPs9jDuVYYfbL1H6smJX5wXS6FRUqfbk8ddmJ4bZ7gmkmL1JDCsb
         HICxBmk9gwsVxHvNU10VJMc1ef2llByBGAKPBUvl+rvKxZnRvSpIDsUBjKcBDxNwPfS4
         K93RrK8yyNz+WPgHhh3V8erSEz3nEWt1MiJv4OblESvfuT/l7gqciMj8P1Q9vji8rbug
         AxKkt+sELpsZzKezjbCTvVahOIHznDbxTjgfaoW7Hu27uI2KcBXwnydZJJlnxzkhV3hS
         J3aA==
X-Gm-Message-State: AOAM531csF+PupYZOINh7jYOJ0pUwCc7869RJe/wWUmQD9ZLLR74Anl+
        FTpX/6rjZtf3ANi3tMX/Dtbm9w==
X-Google-Smtp-Source: ABdhPJyxAvXQd0bbF0EOVrxP5P6EeKTwx53AuI93eQUjvSBO15+WDlfO8iO2KrF0+EN/zJdjr4qivw==
X-Received: by 2002:a2e:45d6:: with SMTP id s205mr907846lja.101.1592296150212;
        Tue, 16 Jun 2020 01:29:10 -0700 (PDT)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id s9sm4247916ljc.43.2020.06.16.01.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 01:29:09 -0700 (PDT)
Date:   Tue, 16 Jun 2020 10:29:07 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Maxim Uvarov <maxim.uvarov@linaro.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        peterhuewe@gmx.de, Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCHv8 0/3] optee: register drivers on optee bus
Message-ID: <20200616082907.GA2305431@jade>
References: <20200604175851.758-1-maxim.uvarov@linaro.org>
 <CAD8XO3YTz=xN2k5h8HsrYsLUgmC6dD57XbBj63e+3_xFF1H0rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD8XO3YTz=xN2k5h8HsrYsLUgmC6dD57XbBj63e+3_xFF1H0rw@mail.gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Maxim and Jarkko,

On Mon, Jun 15, 2020 at 05:32:40PM +0300, Maxim Uvarov wrote:
> ping.
> Patchset was reviewed and all comments are codeverd. Optee-os patches
> were merged. These kernel patches look like they are hanging
> somewhere...

I'm almost OK with this patchset, except that
Documentation/ABI/testing/sysfs-bus-optee-devices needs to be updated
for the new kernel version and TEE mailing list which we're changing right
now.

The last patch touches files I'm not maintainer of. That patch depends
on the previous patches so it makes sense to keep them together.  If a
TPM device driver maintainer would ack that patch I can take it via my
tree. Or we can do it the other way around (with a v9 patchset),
whichever is preferred.

Cheers,
Jens

> 
> Thanks,
> Maxim.
> 
> On Thu, 4 Jun 2020 at 20:58, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
> >
> > v8: - fix v7 check.
> > v7: - check return value of dev_set_name() (Jarkko Sakkinen)
> > v6: - description, comments, patches reorder and destroy workqueue (Sumit Garg)
> > v5: - removed pr_err and fix typos in description (Jarkko Sakkinen)
> >     - added missed kfree in optee_open()
> > v4: - sysfs entry is optee-ta-uuid (Jerome Forissier, Sumit Garg)
> >     - added Documentation/ABI/testing/sysfs-bus-optee-devices (Greg Kroah-Hartman)
> > v3: - support tee-suppicant restart (Jens Wiklander)
> >     - description and comments (Jarkko Sakkinen)
> >     - do not name optee drivers by index in sysfs (Sumit Garg)
> > v2: - write TEE with capital letters.
> >     - declare __optee_enumerate_device() as static.
> >
> > Maxim Uvarov (3):
> >   optee: use uuid for sysfs driver entry
> >   optee: enable support for multi-stage bus enumeration
> >   tpm_ftpm_tee: register driver on TEE bus
> >
> >  .../ABI/testing/sysfs-bus-optee-devices       |  8 +++
> >  MAINTAINERS                                   |  1 +
> >  drivers/char/tpm/tpm_ftpm_tee.c               | 70 ++++++++++++++++---
> >  drivers/tee/optee/core.c                      | 27 ++++++-
> >  drivers/tee/optee/device.c                    | 38 +++++-----
> >  drivers/tee/optee/optee_private.h             | 10 ++-
> >  6 files changed, 119 insertions(+), 35 deletions(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-optee-devices
> >
> > --
> > 2.17.1
> >
