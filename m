Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54922287609
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Oct 2020 16:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730595AbgJHO3h (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Oct 2020 10:29:37 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:32768 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730594AbgJHO3h (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Oct 2020 10:29:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 70D978EE194;
        Thu,  8 Oct 2020 07:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1602167376;
        bh=iSpbr6Q1Ni0TEGoOuIvz7SN1H1KmNHKdhp/5ZQG6cK8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NVPMcZ8kZfNXDAUc35z7XOpgL2qg0YsNpXtWSwYcXN+o930bUHZK6FIxedd6gRA02
         aZTFXpaOcLSiC9AEPvNCu78HkS7/3ooskNtDHJKAwhSm3bEuR2qgGQPP8553u83RNR
         2KLdBuEjGOfHBhg8nr6VgJNUo7HwY5iCaVGxSQVc=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3BmeBs-dNa-B; Thu,  8 Oct 2020 07:29:36 -0700 (PDT)
Received: from jarvis (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C18E18EE120;
        Thu,  8 Oct 2020 07:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1602167376;
        bh=iSpbr6Q1Ni0TEGoOuIvz7SN1H1KmNHKdhp/5ZQG6cK8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NVPMcZ8kZfNXDAUc35z7XOpgL2qg0YsNpXtWSwYcXN+o930bUHZK6FIxedd6gRA02
         aZTFXpaOcLSiC9AEPvNCu78HkS7/3ooskNtDHJKAwhSm3bEuR2qgGQPP8553u83RNR
         2KLdBuEjGOfHBhg8nr6VgJNUo7HwY5iCaVGxSQVc=
Message-ID: <a66c31ec1e49afa7c4111c884774afb6d68d0254.camel@HansenPartnership.com>
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Petr Vorel <pvorel@suse.cz>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Date:   Thu, 08 Oct 2020 07:29:34 -0700
In-Reply-To: <20201008114518.GB27671@dell5510>
References: <20200817213506.4474-1-James.Bottomley@HansenPartnership.com>
         <20200817213506.4474-2-James.Bottomley@HansenPartnership.com>
         <20201008114518.GB27671@dell5510>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-10-08 at 13:45 +0200, Petr Vorel wrote:
> Hi,
> 
> > Create sysfs per hash groups with 24 PCR files in them one group,
> > named pcr-<hash>, for each agile hash of the TPM.  The files are
> > plugged in to a PCR read function which is TPM version agnostic, so
> > this works also for TPM 1.2 but the hash is only sha1 in that case.
> > Note: the macros used to create the hashes emit spurious checkpatch
> > warnings.  Do not try to "fix" them as checkpatch recommends,
> > otherwise
> > they'll break.
> > Signed-off-by: James Bottomley <
> > James.Bottomley@HansenPartnership.com>
> > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > Tested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Tested-by: Petr Vorel <pvorel@suse.cz>
> On both TPM 1.2 and TPM 2.0.
> /sys/class/tpm/tpm0/pcr-sha*/* is exporting well on both.
> James, thanks for implementing nice API!

You're welcome

> BTW are all of these just TPM 1.2 specific?
> /sys/class/tpm/tpm0/device/enabled
> /sys/class/tpm/tpm0/device/pcrs

These two are

> /sys/kernel/security/tpm0/binary_bios_measurements

But this one isn't ... although the format is different from 1.2 to 2.0
and the 2.0 version didn't appear until around 4.16.

James


