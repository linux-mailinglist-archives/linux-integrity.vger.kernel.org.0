Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77221D5A91
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2020 22:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgEOUKT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 May 2020 16:10:19 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:54010 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726212AbgEOUKT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 May 2020 16:10:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 05CBE8EE2CA;
        Fri, 15 May 2020 13:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1589573419;
        bh=VT544V8rDmya17vB+HgvGWXT61gdNFTwaz1A3voKWwQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ux79Q4pNNPRuZ0e0j9LZYuy5xkWFoyMXjqgh9Ykgbd/YNnrmbh99SJOr9gWi5vWXP
         3BjJnLjojuXBMT+gv702ep3SZn6E7bOd1ZN5FkfCRaWDPYrPcRw7L1/d8QLAJn4FFz
         qcwdQh+jmLAwMhgk11zSqJxshWp1xrAsp1/QY+rY=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DXtdTBwwcwgE; Fri, 15 May 2020 13:10:18 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 7A4EB8EE25D;
        Fri, 15 May 2020 13:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1589573418;
        bh=VT544V8rDmya17vB+HgvGWXT61gdNFTwaz1A3voKWwQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Ukep2Ouph8SMFuMJJN5nQVr3KjmsTKVmYS05993+czWrL7c4NLjC5bTdnuZfr4rUh
         HD7Uq2qnE+zFL5VAFxf5BVPcxwP32q7ui3p63hW05KPdEdfKv9YwCKSxhPR+06qtBw
         JPr3WSCVrqig8aqMrQjftGWIFVjKdH4TOWZdlGl0=
Message-ID: <1589573417.3653.28.camel@HansenPartnership.com>
Subject: Re: [PATCH v9 0/8] TPM 2.0 trusted keys with attached policy
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Date:   Fri, 15 May 2020 13:10:17 -0700
In-Reply-To: <1589571278.3653.22.camel@HansenPartnership.com>
References: <20200507231147.27025-1-James.Bottomley@HansenPartnership.com>
         <23639de13874c00e6bb2b816b4db0b586c9a074c.camel@linux.intel.com>
         <483c4f1af7be41c8d091b11d4484b606ebd319b7.camel@linux.intel.com>
         <1589514263.5759.25.camel@HansenPartnership.com>
         <20200515084702.GA3404@linux.intel.com>
         <20200515191758.ieojyk5xhsx2hzzd@cantor>
         <1589571278.3653.22.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-05-15 at 12:34 -0700, James Bottomley wrote:
> On Fri, 2020-05-15 at 12:17 -0700, Jerry Snitselaar wrote:
> > On Fri May 15 20, Jarkko Sakkinen wrote:
> > > On Thu, May 14, 2020 at 08:44:23PM -0700, James Bottomley wrote:
> > > > On Fri, 2020-05-15 at 05:22 +0300, Jarkko Sakkinen wrote:
> 
> [...]
> > > > > sudo ./keyctl-smoke.sh
> > > > > 566201053 (0x80000000)
> > > > > keyctl_read_alloc: Permission denied
> > 
> > I get keyctl_read_alloc -EPERM when I 'sudo su' and try to play
> > with
> > keyctl print.
> > If I 'sudo su -' and then try it works as expected. Also works for
> > normal user.
> 
> OK, I confirm on debian as well.  If I create a key as real root and
> then try to sudo su keyctl pipe it as an ordinary user, I get EPERM.
> 
> It smells like a cockup in real vs effective permissions somewhere in
> the keyctl handler.

OK, so the problem is

sudo keyctl list @s

Still shows the session keys of the previous user

that causes sudo keyctl show on a root owned key to fail the
is_key_possessed() check, returning -EACCESS which gets translated to
EPERM

if you do

sudo su -

Then keyctl list @s shows the root session keyring and everything works

I think that means the solution is not to run the smoke test under sudo
but to do sudo -s and then run it.

James


