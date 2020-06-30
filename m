Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F4C20FC8B
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Jun 2020 21:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgF3TQD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Jun 2020 15:16:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54823 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726217AbgF3TQC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Jun 2020 15:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593544559;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=Mwn+YbY3lCFD0nRhYZ0J/9ZQb28iUEBrVkjj0x5okkw=;
        b=S4kS9GEDXWpysACLSp06FFblqZ52CiItj52UM0SX5OriG5qpo3eYdLWwXzEZ2ED9ZMnnrY
        /Xt0XrCXOhgL5fFLZUmlfXPVDLavKu3vdhRU238udNg3mFuVuf1rKgRlwGKmcphb46u0TV
        yyO3iEYfe0ikz7UjRscHGHoCkWHlK+o=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-AwdhpFmPN1uAZU3jxYc8Xw-1; Tue, 30 Jun 2020 15:15:20 -0400
X-MC-Unique: AwdhpFmPN1uAZU3jxYc8Xw-1
Received: by mail-qt1-f198.google.com with SMTP id c26so15107562qtq.6
        for <linux-integrity@vger.kernel.org>; Tue, 30 Jun 2020 12:15:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Mwn+YbY3lCFD0nRhYZ0J/9ZQb28iUEBrVkjj0x5okkw=;
        b=TRsq0WZKo/rd1+yUh5zSGlai5AakK8JQhMtjWjyVqzV0HWmHQuPIiP6wLSCBEqIWct
         whhejerP7djyUZ9RoBheugGH3xEBM+kU8P7AVsnEpFs8hAcOCQYnMWqw0V2NByPRWP0Z
         e1BHneuwcgET51oDm+Lzkv8Cp/Uuawo9/4ldgmrCDQw6gkjw0adKFQ71bWWb7sSKROSV
         /EgoNb/S7mjT9IzG82JU0slQnBTtlUWSvriHg76oIjrtlmzh7uSDmOXC/6akv9VQWqnu
         NsOtAnGnPwAp/2dpdVCHjOEscaZ6tpp7/WVRNHv/P4ulgNxBu3had2WfN/Tbe0yG0JPE
         V5Kg==
X-Gm-Message-State: AOAM531pRbSpLkWEG2ukTWYo3+AwCpb7D+mX1hMGvVjosNLxGSA7OqzA
        ilE49ux+2bz9gFxQnW6D3tA3yejAvLuwg//pfdNIqo0YFI1X1llSHLpFf0ypEiPAk2Fq96NiDNB
        73j9wOKHZkgB3fmoWTTgzXVFQMx0k
X-Received: by 2002:ac8:b4c:: with SMTP id m12mr1796488qti.321.1593544517989;
        Tue, 30 Jun 2020 12:15:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHjEeEV/Zp7eB4dHo6T90utCK96FWHB2uNZoUKDQzH4ehEwW36m6TcSOBtvR80+MWgIMg8vw==
X-Received: by 2002:ac8:b4c:: with SMTP id m12mr1796465qti.321.1593544517659;
        Tue, 30 Jun 2020 12:15:17 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id u6sm3840440qtc.34.2020.06.30.12.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 12:15:16 -0700 (PDT)
Date:   Tue, 30 Jun 2020 12:15:15 -0700
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
Message-ID: <20200630191515.m3hi6gmn4ya7hvji@cantor>
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
 <20200625211923.2jirvix6zbrbgj6e@cantor>
 <20200626130851.GA7853@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200626130851.GA7853@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri Jun 26 20, Jarkko Sakkinen wrote:
>On Thu, Jun 25, 2020 at 02:19:23PM -0700, Jerry Snitselaar wrote:
>> On Fri Jun 26 20, Jarkko Sakkinen wrote:
>> > On Wed, Jun 24, 2020 at 11:21:50PM -0700, Jerry Snitselaar wrote:
>> > > On Thu Jun 25 20, Jarkko Sakkinen wrote:
>> > > > Acer C720 running Linux v5.3 reports this in klog:
>> > > >
>> > > > tpm_tis: 1.2 TPM (device-id 0xB, rev-id 16)
>> > > > tpm tpm0: tpm_try_transmit: send(): error -5
>> > > > tpm tpm0: A TPM error (-5) occurred attempting to determine the timeouts
>> > > > tpm_tis tpm_tis: Could not get TPM timeouts and durations
>> > > > tpm_tis 00:08: 1.2 TPM (device-id 0xB, rev-id 16)
>> > > > tpm tpm0: tpm_try_transmit: send(): error -5
>> > > > tpm tpm0: A TPM error (-5) occurred attempting to determine the timeouts
>> > > > tpm_tis 00:08: Could not get TPM timeouts and durations
>> > > > ima: No TPM chip found, activating TPM-bypass!
>> > > > tpm_inf_pnp 00:08: Found TPM with ID IFX0102
>> > > >
>> > > > % git --no-pager grep IFX0102 drivers/char/tpm
>> > > > drivers/char/tpm/tpm_infineon.c:	{"IFX0102", 0},
>> > > > drivers/char/tpm/tpm_tis.c:	{"IFX0102", 0},		/* Infineon */
>> > > >
>> > > > Obviously IFX0102 was added to the HID table for the TCG TIS driver by
>> > > > mistake.
>> > > >
>> > > > Fixes: 93e1b7d42e1e ("[PATCH] tpm: add HID module parameter")
>> > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=203877
>> > > > Cc: Kylene Jo Hall <kjhall@us.ibm.com>
>> > > > Reported-by: Ferry Toth: <ferry.toth@elsinga.info>
>> > > > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>> > >
>> > > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
>> >
>> > Bugzilla has an example of similar behavior with v4.15. I'll apply this
>> > asap.
>> >
>> > /Jarkko
>> >
>>
>> Any idea what happened to git.infradead.org? It was offline the other day,
>> and at the moment not all repos from before seem to be there.
>
>Now the kernel tree is back online.
>
>/Jarkko
>

Hi Jarkko, I still see your linux-tpmdd repository as not being online:

git remote show tpmdd
fatal: remote error: access denied or repository not exported: /users/jjs/linux-tpmdd.git

Regards,
Jerry

