Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60706228D2B
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Jul 2020 02:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgGVAjr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Jul 2020 20:39:47 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:41586 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726468AbgGVAjr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Jul 2020 20:39:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id CD2898EE269;
        Tue, 21 Jul 2020 17:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1595378386;
        bh=HemS2Wx1CbQ5r0AN07L/O+M5UepaijzVbSxf8O2v4qE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tfoIqvoTKrU8jpC0fFI4bV92tsGpQVC/Hs3KphAx4K/ShYjalN0PV1pzh4FjBDlCm
         lPvyx81mQMr+xeTgOvBqNI0jvuxCR8Viwt3ksE+UCxkThDSejOptqIJF5Rr8adU3rh
         XE43rccxmmaFy/wQ+trV+i/cOOzwx8hHbxOTtaek=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MCIGWM6Wk-SZ; Tue, 21 Jul 2020 17:39:46 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 674208EE207;
        Tue, 21 Jul 2020 17:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1595378386;
        bh=HemS2Wx1CbQ5r0AN07L/O+M5UepaijzVbSxf8O2v4qE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tfoIqvoTKrU8jpC0fFI4bV92tsGpQVC/Hs3KphAx4K/ShYjalN0PV1pzh4FjBDlCm
         lPvyx81mQMr+xeTgOvBqNI0jvuxCR8Viwt3ksE+UCxkThDSejOptqIJF5Rr8adU3rh
         XE43rccxmmaFy/wQ+trV+i/cOOzwx8hHbxOTtaek=
Message-ID: <1595378385.3575.31.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 1/1] tpm: add sysfs exports for all banks of PCR
 registers
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Tue, 21 Jul 2020 17:39:45 -0700
In-Reply-To: <877duwl8n9.fsf@redhat.com>
References: <20200721155615.12625-1-James.Bottomley@HansenPartnership.com>
         <20200721155615.12625-2-James.Bottomley@HansenPartnership.com>
         <87a6zslar5.fsf@redhat.com>
         <1595374674.3575.28.camel@HansenPartnership.com>
         <877duwl8n9.fsf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-07-21 at 17:02 -0700, Jerry Snitselaar wrote:
> James Bottomley @ 2020-07-21 16:37 MST:
> 
> > On Tue, 2020-07-21 at 16:16 -0700, Jerry Snitselaar wrote:
> > > James Bottomley @ 2020-07-21 08:56 MST:
> > 
> > [...]
> > > > +	/*
> > > > +	 * This will only trigger if someone has added an
> > > > additional
> > > > +	 * hash to the tpm_algorithms enum without
> > > > incrementing
> > > > +	 * TPM_MAX_HASHES.  This has to be a BUG_ON because
> > > > under
> > > > this
> > > > +	 * condition, the chip->groups array will overflow
> > > > corrupting
> > > > +	 * the chips structure.
> > > > +	 */
> > > > +	BUG_ON(chip->groups_cnt > TPM_MAX_HASHES);
> > > 
> > > Should this check be 3 + TPM_MAX_HASHES like below?
> > 
> > No, because at this point only a single additional group has been
> > addedin addition to the hashes groups.  The first line of
> > tpm_sysfs_add_device is
> > 
> > 	WARN_ON(chip->groups_cnt != 0);
> > 
> > And then we add the unnamed group.  This loop over the banks
> > follows it, so chip->groups_cnt should be nr_banks_allocated by the
> > end (it's the index, which is one fewer than the number of entries
> > in chip->groups[]).  We have a problem if nr_banks_allocated >
> > TPM_MAX_HASHES
> > 
> > which is what the BUG_ON checks.
> > 
> > James
> 
> If the chip supported all 5 listed cases wouldn't groups_cnt be 6 at
> this point?

Actually, yes, I think it would be because it's pointing at the next
free index not the current one.  So it should be BUG_ON (chip-
>groups_cnt > TPM_MAX_HASHES + 1)

James

