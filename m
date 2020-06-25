Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3896D20A75F
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2020 23:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405959AbgFYVYE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Jun 2020 17:24:04 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:42424 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405932AbgFYVYD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jun 2020 17:24:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 5F7198EE2F6;
        Thu, 25 Jun 2020 14:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1593120242;
        bh=q5iYVcYIczrHQ6I7vAkgk/OyuxnqDWbAdCwur4CtQ1Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=yAe0JFu/odk4cgKR1FaGEEy1MQWKWBxCF2N0YDnZWClREbV/rjDFh46O976PQ70dC
         +/LKTcE7ownE8qlcpi7w4p+EFtV0kPgZpt/wzWb/kMYrH5vSGSrq7dzY+aGYhFLeUl
         /8pArzKdEv21FZ3wPdMHy/TCRzU2EjdqOcdMJsZo=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 54TOidBT8hqz; Thu, 25 Jun 2020 14:24:02 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 9D2608EE079;
        Thu, 25 Jun 2020 14:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1593120242;
        bh=q5iYVcYIczrHQ6I7vAkgk/OyuxnqDWbAdCwur4CtQ1Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=yAe0JFu/odk4cgKR1FaGEEy1MQWKWBxCF2N0YDnZWClREbV/rjDFh46O976PQ70dC
         +/LKTcE7ownE8qlcpi7w4p+EFtV0kPgZpt/wzWb/kMYrH5vSGSrq7dzY+aGYhFLeUl
         /8pArzKdEv21FZ3wPdMHy/TCRzU2EjdqOcdMJsZo=
Message-ID: <1593120239.3332.17.camel@HansenPartnership.com>
Subject: Re: [PATCH v2] tpm_tis: Remove the HID IFX0102
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org,
        Kylene Jo Hall <kjhall@us.ibm.com>,
        "Ferry Toth :" <ferry.toth@elsinga.info>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@osdl.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Thu, 25 Jun 2020 14:23:59 -0700
In-Reply-To: <20200625211923.2jirvix6zbrbgj6e@cantor>
References: <20200625023111.270458-1-jarkko.sakkinen@linux.intel.com>
         <20200625062150.idm6j3vm2neyt4sh@cantor>
         <20200625210202.GA20341@linux.intel.com>
         <20200625211923.2jirvix6zbrbgj6e@cantor>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-06-25 at 14:19 -0700, Jerry Snitselaar wrote:
> On Fri Jun 26 20, Jarkko Sakkinen wrote:
> > On Wed, Jun 24, 2020 at 11:21:50PM -0700, Jerry Snitselaar wrote:
> > > On Thu Jun 25 20, Jarkko Sakkinen wrote:
> > > > Acer C720 running Linux v5.3 reports this in klog:
> > > > 
> > > > tpm_tis: 1.2 TPM (device-id 0xB, rev-id 16)
> > > > tpm tpm0: tpm_try_transmit: send(): error -5
> > > > tpm tpm0: A TPM error (-5) occurred attempting to determine the
> > > > timeouts
> > > > tpm_tis tpm_tis: Could not get TPM timeouts and durations
> > > > tpm_tis 00:08: 1.2 TPM (device-id 0xB, rev-id 16)
> > > > tpm tpm0: tpm_try_transmit: send(): error -5
> > > > tpm tpm0: A TPM error (-5) occurred attempting to determine the
> > > > timeouts
> > > > tpm_tis 00:08: Could not get TPM timeouts and durations
> > > > ima: No TPM chip found, activating TPM-bypass!
> > > > tpm_inf_pnp 00:08: Found TPM with ID IFX0102
> > > > 
> > > > % git --no-pager grep IFX0102 drivers/char/tpm
> > > > drivers/char/tpm/tpm_infineon.c:	{"IFX0102", 0},
> > > > drivers/char/tpm/tpm_tis.c:	{"IFX0102", 0},		
> > > > /* Infineon */
> > > > 
> > > > Obviously IFX0102 was added to the HID table for the TCG TIS
> > > > driver by
> > > > mistake.
> > > > 
> > > > Fixes: 93e1b7d42e1e ("[PATCH] tpm: add HID module parameter")
> > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=203877
> > > > Cc: Kylene Jo Hall <kjhall@us.ibm.com>
> > > > Reported-by: Ferry Toth: <ferry.toth@elsinga.info>
> > > > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com
> > > > >
> > > 
> > > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > 
> > Bugzilla has an example of similar behavior with v4.15. I'll apply
> > this asap.
> > 
> > /Jarkko
> > 
> 
> Any idea what happened to git.infradead.org? It was offline the other
> day, and at the moment not all repos from before seem to be there.

Infradead has been playing up for a while on other things (non git
services I use).

Perhaps it's time to get a kernel.org repository ...

James
