Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCEB25F2E4
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Sep 2020 07:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgIGF7R (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Sep 2020 01:59:17 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:41692 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726978AbgIGF7J (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Sep 2020 01:59:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D0B078EE2DC;
        Sun,  6 Sep 2020 22:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1599458347;
        bh=Or0SVuVrdAcVHUuDT9zpHcKD3PknBu6a7y2XFnn4bFU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CYYGOj4yc1HiPBWmKmBeYWRoirsX9YFJ/+CPwgZRIAH8lCrnTNHBteMwn0yvDse9y
         eEHmvIlhYKxYkrA67IBk9hg8HMxXjlZH+z2XpkDzy6F6CpGhLnOGnu+LpvAXlC4dkT
         cTfDys08oxcUIMy5YeBQ3569lEBcNuRLOyx0vHrE=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LW7Br5N1N1IY; Sun,  6 Sep 2020 22:59:06 -0700 (PDT)
Received: from [153.66.254.174] (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 7DB7B8EE111;
        Sun,  6 Sep 2020 22:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1599458346;
        bh=Or0SVuVrdAcVHUuDT9zpHcKD3PknBu6a7y2XFnn4bFU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=h0gxypHe7m0pocps91ShwhTO1yvKhbd7mxXdkPmR71z4UbzblyMJ9Yx6oMu8nKyeO
         yejspzXfyLTGjfIU6bbR9QjGO0sz6xBXHK9g0Ak4A2q+s9chWJVdsyRkHwQFf42qdn
         yvSwzHFv0SX+kr4jHm+zd3VuOgJzNer2zN7oF2Ts=
Message-ID: <1599458343.28278.1.camel@HansenPartnership.com>
Subject: Re: [PATCH RESEND v4 1/1] tpm: add sysfs exports for all banks of
 PCR registers
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Greg KH <greg@kroah.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-api@vger.kernel.org
Date:   Sun, 06 Sep 2020 22:59:03 -0700
In-Reply-To: <20200907053935.GB279469@kroah.com>
References: <20200906203245.18429-1-James.Bottomley@HansenPartnership.com>
         <20200906203245.18429-2-James.Bottomley@HansenPartnership.com>
         <20200907053935.GB279469@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-09-07 at 07:39 +0200, Greg KH wrote:
> On Sun, Sep 06, 2020 at 01:32:45PM -0700, James Bottomley wrote:
> > Create sysfs per hash groups with 24 PCR files in them one group,
> > named pcr-<hash>, for each agile hash of the TPM.  The files are
> > plugged in to a PCR read function which is TPM version agnostic, so
> > this works also for TPM 1.2 but the hash is only sha1 in that case.
> > 
> > Note: the macros used to create the hashes emit spurious checkpatch
> > warnings.  Do not try to "fix" them as checkpatch recommends,
> > otherwise
> > they'll break.
> 
> Oh you are just ensuring yourself a world of hurt for drive-by
> patches that everyone submits.  Don't do this if you can help it at
> all.

Well, what do you suggest: macros that generate macros can't use
brackets around the arguments because the macro generation becomes
wrong.  This is the thing that checkpatch is insisting on because the
usual fault people commit in macros that generate C code is forgetting
that unless you bracket the arguments in the macro they can have
unintended side effects.

James

