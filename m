Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4409F8EF0F
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Aug 2019 17:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732370AbfHOPGy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Aug 2019 11:06:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbfHOPGy (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Aug 2019 11:06:54 -0400
Received: from localhost.localdomain (ool-18bba523.dyn.optonline.net [24.187.165.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C71D12084D;
        Thu, 15 Aug 2019 15:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565881612;
        bh=h87oyHb/jDVyBLnySLgKHX4dvlaW3Dq+FlV+2DQZ09w=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=V+dTycUTuRDgALjRVZkxEq9eu2k8qOyjjDRNH92NGSH3VtAHne5cSeWxUl+ec9K9R
         FrLzSHgQQY/tgqFto8gZ9nYLZ8NSiZir+RRe7GbB3v6Qp06QkLZvUOmkQ5q/KCf8vR
         tMlXKRCP7uBRl24Wb+xLk7N/MCEfa3iU+XxgblqM=
Message-ID: <1565881609.9424.7.camel@kernel.org>
Subject: Re: [RFC/RFT v4 0/5] Add generic trusted keys framework/subsystem
From:   Mimi Zohar <zohar@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-security-module@vger.kernel.org, dhowells@redhat.com,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        peterhuewe@gmx.de, jgg@ziepe.ca, jejb@linux.ibm.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>
Date:   Thu, 15 Aug 2019 11:06:49 -0400
In-Reply-To: <CAFA6WYPU0oREaHROhhRsEXJTijvER8G4riBk4e4=Bd5XgGFqtQ@mail.gmail.com>
References: <1565682784-10234-1-git-send-email-sumit.garg@linaro.org>
         <1565789078.10490.10.camel@kernel.org>
         <CAFA6WYPU0oREaHROhhRsEXJTijvER8G4riBk4e4=Bd5XgGFqtQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-08-15 at 18:33 +0530, Sumit Garg wrote:
> Hi Mimi,
> 
> On Wed, 14 Aug 2019 at 18:54, Mimi Zohar <zohar@kernel.org> wrote:
> >
> > Hi Sumit,
> >
> > On Tue, 2019-08-13 at 13:22 +0530, Sumit Garg wrote:
> > > This patch-set is an outcome of discussion here [1]. It has evolved very
> > > much since v1 to create, consolidate and generalize trusted keys
> > > subsystem.
> > >
> > > This framework has been tested with trusted keys support provided via TEE
> > > but I wasn't able to test it with a TPM device as I don't possess one. It
> > > would be really helpful if others could test this patch-set using a TPM
> > > device.
> >
> > With the "CONFIG_HEADER_TEST" and "CONFIG_KERNEL_HEADER_TEST" config
> > options enabled, which is required for linux-next, it fails to build.
> >
> 
> TBH, I wasn't aware about this test feature for headers. 

It's new to me too.

> It looks like
> the header which fails this test is "include/keys/trusted_tpm.h" which
> is basically a rename of "include/keys/trusted.h" plus changes in this
> patch-set.
> 
> And "include/keys/trusted.h" header is already put under blacklist
> here: "include/Kbuild +68" as it fails to build. So its that rename
> due to which build failure is observed now.
> 
> It seems to be an easy fix for this build failure via following changes:
> 
> diff --git a/include/keys/trusted_tpm.h b/include/keys/trusted_tpm.h
> index 7b593447920b..ca1bec0ef65d 100644
> --- a/include/keys/trusted_tpm.h
> +++ b/include/keys/trusted_tpm.h
> @@ -2,6 +2,9 @@
>  #ifndef __TRUSTED_TPM_H
>  #define __TRUSTED_TPM_H
> 
> +#include <keys/trusted-type.h>
> +#include <linux/tpm_command.h>
> +
>  /* implementation specific TPM constants */
>  #define MAX_BUF_SIZE                   1024
>  #define TPM_GETRANDOM_SIZE             14
> 
> So I will include above changes in this patch-set and also remove
> "include/keys/trusted.h" header from the blacklist.

That works, thanks.  With this patch set, at least the EVM trusted key
is properly being decrypted by the encrypted key with both a TPM 1.2
and PTT TPM 2.0.  My laptop still boots properly.  Over the weekend
I'll try to actually review the patches.

Mimi
