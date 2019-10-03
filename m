Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACE9ECA7AE
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Oct 2019 18:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732724AbfJCQz7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Oct 2019 12:55:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39774 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392882AbfJCQzz (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Oct 2019 12:55:55 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7F5978666C
        for <linux-integrity@vger.kernel.org>; Thu,  3 Oct 2019 16:55:54 +0000 (UTC)
Received: by mail-io1-f70.google.com with SMTP id a22so6055126ioq.23
        for <linux-integrity@vger.kernel.org>; Thu, 03 Oct 2019 09:55:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=AFNw8r3ckdAQvRI7p3wli5RDRwpNcfmosa2xDA/j64M=;
        b=WW7FzT5C9d3eKfkGUyHS2GR/1eqtIsEyGsFoafYDbDgL+D4osjl4wrQn4wexSJJpEo
         57Y+vQtyNQAAmtYcskAjFyycRF79/pmVHpZqPL1E/Vsv4LNJzt/3YvMCjvg1csYLjHd/
         3Wr+wIszs/pP1MsrNkzYbDsktQAsS1ZrWjd0YuXP8nHzrg5icxTmkEP4g3ti4qBvfxtH
         Lee6F4P01vm2QJJM+GpbQZZWymgWdVoYB3jRAk6sb23vS5MPDleGvQhpZ8u4PFZo5OaU
         +ThK+8T21dDIJ9GsMg+3fqcSwh4MoXIla5wlpCOHwEliaC2H0rCi84f/y7oo6ZWfLKLd
         wkMA==
X-Gm-Message-State: APjAAAXftP2pSy1h+kTFA+dmUAF48zR3QKhIzVl5w4XvQ9Jd1eWP8miT
        +ikRSwedVqlRZyUz6yqsaNWknYTqI2crO0kkH6GDF8+qZ/lKISS8VyElpDYw4lMD0p0s4XYD/OI
        GekxtR2Vy/m/Yx1CB0G/hsG3HeGUr
X-Received: by 2002:a02:93e5:: with SMTP id z92mr10465230jah.8.1570121753895;
        Thu, 03 Oct 2019 09:55:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxYbHe9CmPEmiKy806Pfucrl7KItPoDlO28A1+KaO7DdJmPkt21jDcVK/cZHblEHgayJ4x1Og==
X-Received: by 2002:a02:93e5:: with SMTP id z92mr10465197jah.8.1570121753579;
        Thu, 03 Oct 2019 09:55:53 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id i67sm2007185ilf.84.2019.10.03.09.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 09:55:52 -0700 (PDT)
Date:   Thu, 3 Oct 2019 09:55:51 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Klimov <aklimov@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v4 0/4] tpm: add update_durations class op to allow
 override of chip supplied values
Message-ID: <20191003165551.whfzgmhpm5r6ejpw@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Klimov <aklimov@redhat.com>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20190902142735.6280-1-jsnitsel@redhat.com>
 <20191002203533.GA17766@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191002203533.GA17766@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed Oct 02 19, Jarkko Sakkinen wrote:
>On Mon, Sep 02, 2019 at 07:27:32AM -0700, Jerry Snitselaar wrote:
>> We've run into a case where a customer has an STM TPM 1.2 chip
>> (version 1.2.8.28), that is getting into an inconsistent state and
>> they end up getting tpm transmit errors.  In really old tpm code this
>> wasn't seen because the code that grabbed the duration values from the
>> chip could fail silently, and would proceed to just use default values
>> and move forward. More recent code though successfully gets the
>> duration values from the chip, and using those values this particular
>> chip version gets into the state seen by the customer.
>>
>> The idea with this patchset is to provide a facility like the
>> update_timeouts operation to allow the override of chip supplied
>> values.
>>
>> changes from v3:
>>     * Assign value to version when tpm1_getcap is successful for TPM 1.1 device
>>       not when it fails.
>>
>> changes from v2:
>>     * Added patch 1/3
>>     * Rework tpm_tis_update_durations to make use of new version structs
>>       and pull tpm1_getcap calls out of loop.
>>
>> changes from v1:
>>     * Remove unneeded newline
>>     * Formatting cleanups
>>     * Change tpm_tis_update_durations to be a void function, and
>>       use chip->duration_adjusted to track whether adjustment was
>>       made.
>>
>> Jarkko Sakkinen (1):
>>       tpm: Remove duplicate code from caps_show() in tpm-sysfs.c
>>
>> Jerry Snitselaar (2):
>>       tpm: provide a way to override the chip returned durations
>>       tpm_tis: override durations for STM tpm with firmware 1.2.8.28
>>
>>
>
>I applied to my master branch.
>
>Probably hard to get wide testing given the "niche" case when the
>issue happens. Should be sufficient that the commonc case still
>works.
>
>/Jarkko

Yeah, it is a pain. The people with the problem systems tested an
earlier version of Alexey's patches. I have a system with a different
rev STM device, so I did some testing with a modified patch that keyed
off that revision, but it will be hard to get it wide exposure.
