Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61EC220A759
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2020 23:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403806AbgFYVTi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Jun 2020 17:19:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53137 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2403817AbgFYVTi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jun 2020 17:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593119977;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=2lclZavUqG1NJdj5nMJohBdjSpQQimkahY/d0zlVvwg=;
        b=DlzhJA/XFNbbwAJBgxdLfvwQFttW5KF6rI8o27a+8Bj639oGH/+Fr8Gx1QPOoH6TWSwIM0
        hnqRZ5BQ5vDL6B1U26cc8owTo7WASxAby9Lid6b6f1EXYLhiCWEkTOFGy+cKXJTTLx/Kbs
        vU6nPs4D56AwuBmf4/Rqgr7iLM9SY7E=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-WQSGtuXQPHeqzfn3iimAug-1; Thu, 25 Jun 2020 17:19:26 -0400
X-MC-Unique: WQSGtuXQPHeqzfn3iimAug-1
Received: by mail-qv1-f72.google.com with SMTP id j6so4955839qvl.13
        for <linux-integrity@vger.kernel.org>; Thu, 25 Jun 2020 14:19:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=2lclZavUqG1NJdj5nMJohBdjSpQQimkahY/d0zlVvwg=;
        b=rzNyV+RjrEAMJvW47LISwBG9o8FrA7AzlvEXbzPO0OWTgrt4KYjgH2I/SkRr4Hj0Jr
         ZyvVtdkGLOHnGov7g6qRl17DHMQAQQ8VWeZXDcz01yk6VWzPbiFB2JIC+uCqcTeVC6eB
         FU3snFeQ6gLNftwnzMT1bNYNtWIOjUr44wrbiECt1JCgSsE7lFS49EAhAWAfNtLkcThn
         rfkpwApQnNIMFHOXVmkwg0FKGkXZetoNZlahW4U4+PEQV8fGmm4O7syBaHUtpU7mONIt
         MHCWDpY/DXQ+NMyRsqhgDAj1CWkfpPQHbkcYjwbNdvf5tqoXoIPHsdOvdoBSLfeNbd+3
         8w0g==
X-Gm-Message-State: AOAM531Z7S3GMQXZEZfRZoqU0uVosEn/OEE5KSdYxScqFCcZd5A07Xbk
        gh1AgiI170/jFlwk5JhWMAbU1FWw0suQxHJMa91aSyrgRLBBrI7c9X4vd9YQdeEFdgDGbOFu75d
        4zOLcgNySMZf6e1FATYcvQx7JiZ8n
X-Received: by 2002:ac8:100b:: with SMTP id z11mr35104073qti.157.1593119966253;
        Thu, 25 Jun 2020 14:19:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLsblqiQ5p6JQcg9nR90CbIca50stzT8Rss65J3PKeFju/t3M5PIfwaG5G288ynT70MLHDYA==
X-Received: by 2002:ac8:100b:: with SMTP id z11mr35104052qti.157.1593119965971;
        Thu, 25 Jun 2020 14:19:25 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id o145sm7078267qke.2.2020.06.25.14.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 14:19:25 -0700 (PDT)
Date:   Thu, 25 Jun 2020 14:19:23 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org,
        Kylene Jo Hall <kjhall@us.ibm.com>,
        "Ferry Toth :" <ferry.toth@elsinga.info>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@osdl.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tpm_tis: Remove the HID IFX0102
Message-ID: <20200625211923.2jirvix6zbrbgj6e@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, Kylene Jo Hall <kjhall@us.ibm.com>,
        "Ferry Toth :" <ferry.toth@elsinga.info>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@osdl.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200625023111.270458-1-jarkko.sakkinen@linux.intel.com>
 <20200625062150.idm6j3vm2neyt4sh@cantor>
 <20200625210202.GA20341@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200625210202.GA20341@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri Jun 26 20, Jarkko Sakkinen wrote:
>On Wed, Jun 24, 2020 at 11:21:50PM -0700, Jerry Snitselaar wrote:
>> On Thu Jun 25 20, Jarkko Sakkinen wrote:
>> > Acer C720 running Linux v5.3 reports this in klog:
>> >
>> > tpm_tis: 1.2 TPM (device-id 0xB, rev-id 16)
>> > tpm tpm0: tpm_try_transmit: send(): error -5
>> > tpm tpm0: A TPM error (-5) occurred attempting to determine the timeouts
>> > tpm_tis tpm_tis: Could not get TPM timeouts and durations
>> > tpm_tis 00:08: 1.2 TPM (device-id 0xB, rev-id 16)
>> > tpm tpm0: tpm_try_transmit: send(): error -5
>> > tpm tpm0: A TPM error (-5) occurred attempting to determine the timeouts
>> > tpm_tis 00:08: Could not get TPM timeouts and durations
>> > ima: No TPM chip found, activating TPM-bypass!
>> > tpm_inf_pnp 00:08: Found TPM with ID IFX0102
>> >
>> > % git --no-pager grep IFX0102 drivers/char/tpm
>> > drivers/char/tpm/tpm_infineon.c:	{"IFX0102", 0},
>> > drivers/char/tpm/tpm_tis.c:	{"IFX0102", 0},		/* Infineon */
>> >
>> > Obviously IFX0102 was added to the HID table for the TCG TIS driver by
>> > mistake.
>> >
>> > Fixes: 93e1b7d42e1e ("[PATCH] tpm: add HID module parameter")
>> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=203877
>> > Cc: Kylene Jo Hall <kjhall@us.ibm.com>
>> > Reported-by: Ferry Toth: <ferry.toth@elsinga.info>
>> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>>
>> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
>
>Bugzilla has an example of similar behavior with v4.15. I'll apply this
>asap.
>
>/Jarkko
>

Any idea what happened to git.infradead.org? It was offline the other day,
and at the moment not all repos from before seem to be there.

