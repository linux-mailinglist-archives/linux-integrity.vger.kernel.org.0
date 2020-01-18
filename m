Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37854141A81
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Jan 2020 00:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgARXvp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 18 Jan 2020 18:51:45 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:58266 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727008AbgARXvp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 18 Jan 2020 18:51:45 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9D5B18EE2AB;
        Sat, 18 Jan 2020 15:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1579391504;
        bh=I0nlQih6W3rW7HqQunCs4wmxwel8p75OfxYHqO1jdVQ=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=kT/TiOxlC400QgQ/O1WYqBQG91YeSXacbsFDXdbgMTqpVIu3voH6X8GZqNPG/mp+O
         DN9z/A/PAjeFErRi3qmlX40QcgXFX0wmjbMXQBvlPGgTA3bUNy3guknEV66JwUpaGU
         i0ZNLTgA4o+iE9RLlePrVKi1mVN/k1TjxHxsqScg=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xN2nEetGF5Ak; Sat, 18 Jan 2020 15:51:44 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id A5B7B8EE17D;
        Sat, 18 Jan 2020 15:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1579391504;
        bh=I0nlQih6W3rW7HqQunCs4wmxwel8p75OfxYHqO1jdVQ=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=kT/TiOxlC400QgQ/O1WYqBQG91YeSXacbsFDXdbgMTqpVIu3voH6X8GZqNPG/mp+O
         DN9z/A/PAjeFErRi3qmlX40QcgXFX0wmjbMXQBvlPGgTA3bUNy3guknEV66JwUpaGU
         i0ZNLTgA4o+iE9RLlePrVKi1mVN/k1TjxHxsqScg=
Message-ID: <1579391500.3421.35.camel@HansenPartnership.com>
Subject: Re: ima pcr question
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Date:   Sat, 18 Jan 2020 15:51:40 -0800
In-Reply-To: <20200118232004.lt2u2u6ryitrkaa2@cantor>
References: <20200114000602.h5k5rr2k6zl3dlts@cantor>
         <1578964659.5796.7.camel@linux.ibm.com>
         <20200117222920.2d42m3ahxznl64em@cantor>
         <1579302011.13499.9.camel@HansenPartnership.com>
         <20200118191414.m4gqggwfavkjlef4@cantor>
         <20200118232004.lt2u2u6ryitrkaa2@cantor>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2020-01-18 at 16:20 -0700, Jerry Snitselaar wrote:
> On Sat Jan 18 20, Jerry Snitselaar wrote:
> > On Fri Jan 17 20, James Bottomley wrote:
[...]
> > > The implication seems to be that on a DELL setting the bios
> > > default to sha256 turns off the TPM's sha1 pcr banks ... is that
> > > the case?
> > > 
> > > tssgetcapability -cap 5
> > > 
> > > should confirm or deny this.
> > > 
> > > James
> > > 
> > 
> > I believe so, I'm waiting to get access to the system here to
> > double check. Before with the intel stack, tpm2_pcrlist -s would
> > return both sha1 and sha256, but the plain tpm2_pcrlist command
> > would show only banks for one or the other depending on which
> > setting was in the bios. For the other it would just print
> > out the algorithm and nothing else.
> > 
> > I should be able to run the tss2 command later today.
> > 
> > Regards,
> > Jerry
> 
> with sha1 selected:
> 
> [root@dell-per830-01 ~]# tssgetcapability -cap 5
> 2 PCR selections
>      hash TPM_ALG_SHA1
>      TPMS_PCR_SELECTION length 3
>      ff ff ff 
>      hash TPM_ALG_SHA256
>      TPMS_PCR_SELECTION length 3
>      00 00 00 
> 
> with sha256 selected:
> 
> [root@dell-per830-01 ~]# tssgetcapability -cap 5
> 2 PCR selections
>      hash TPM_ALG_SHA1
>      TPMS_PCR_SELECTION length 3
>      00 00 00 
>      hash TPM_ALG_SHA256
>      TPMS_PCR_SELECTION length 3
>      ff ff ff 

OK, so that confirms the suspicion.  The only active bank is the one
you've selected in the bios ... I suppose it was done to avoid having
to measure through more than one bank, but it does mean IMA must cope
in the case the sha1 bank isn't active.

James

