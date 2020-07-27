Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C133C22E462
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Jul 2020 05:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgG0DZm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 26 Jul 2020 23:25:42 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:54872 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726701AbgG0DZm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 26 Jul 2020 23:25:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 261828EE1C8;
        Sun, 26 Jul 2020 20:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1595820342;
        bh=PuHjvwi7hSvGUiW0BerOn22ISzd6avHXTFelrVrW3Ug=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nTfPOunQFdEMZ2J0IRoNG0S348iX8oFkXUgAXs8DKCSgFdX8WLFU3gmapHnNBtCYS
         Csn7ewbntIAMgcbxx+2RioG2y4IeJJ6ToOT6hCPvF9oUAay0GyG1g9+RxmxDm0BDDH
         nPD453zBAaTTsud5j15xBFrJjMc7C2mOcSt1C4PY=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5EjXYI853W5F; Sun, 26 Jul 2020 20:25:42 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B13D08EE1C0;
        Sun, 26 Jul 2020 20:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1595820341;
        bh=PuHjvwi7hSvGUiW0BerOn22ISzd6avHXTFelrVrW3Ug=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nKhbbFsnCntr/UundlZ2H5D55jNLjSdtmiYGyUJHi+e43yEk0lJ6hu0Zkd2hA30Qv
         fumY26UBhijaUlgymhmBScREgACBeA/srW0O73f+kwKKLRVvQX87kphnvVsrPpI52P
         MAUx3y8r5mgaI8p+X/hFyhm9/VsicAkn4psPJONU=
Message-ID: <1595820339.32688.26.camel@HansenPartnership.com>
Subject: Re: [PATCH v3 1/1] tpm: add sysfs exports for all banks of PCR
 registers
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Date:   Sun, 26 Jul 2020 20:25:39 -0700
In-Reply-To: <20200724065745.GB1871046@linux.intel.com>
References: <20200722155739.26957-1-James.Bottomley@HansenPartnership.com>
         <20200722155739.26957-2-James.Bottomley@HansenPartnership.com>
         <20200724065745.GB1871046@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-07-24 at 09:57 +0300, Jarkko Sakkinen wrote:
> On Wed, Jul 22, 2020 at 08:57:39AM -0700, James Bottomley wrote:
> > use macro magic to create sysfs per hash groups with 24 PCR files
> > in
> 
> 'Use'
> 
> Please, just say what the patch does in plain English and dust the
> magic away.

The reason for the macro magic comment is that there are 3 checkpatch
errors and one warning from this, all spurious, because checkpatch
doesn't understand the syntax of macros that create macros.

> > them one for each possible agile hash of the TPM.  The files are
>                                                    ~~
> 
> I'd prefer a single space.

It's still listed in the style guides as best practice for monospaced
fonts, but at this point I've lost the will to care about it.

> > plugged in to a read function which is TPM version agnostic, so
> > this works also for TPM 1.2 although the hash is only sha1 in that
> > case. For every hash the TPM supports, a group named pcr-<hash> is
> > created and each of the PCR read files placed under it.
> 
> Yeah, the commit message is missing the statement what it does and
> goes straight away rationalizing "macro magic".

OK so how about

---
Create sysfs per hash groups with 24 PCR files in them one group, named
pcr-<hash>, for each agile hash of the TPM.  The files are plugged in
to a PCR read function which is TPM version agnostic, so this works
also for TPM 1.2 although the hash is only sha1 in that case.

Note: the macros used to create the hashes emit spurious checkpatch
warnings.  Do not try to "fix" them as checkpatch recommends otherwise
they'll break.
---

James

