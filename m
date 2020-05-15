Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008B71D5971
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2020 20:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgEOSsb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 May 2020 14:48:31 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:53106 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726238AbgEOSsa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 May 2020 14:48:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 78AF58EE2CA;
        Fri, 15 May 2020 11:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1589568510;
        bh=tZrweX0tkgYDBJDM7CQZADN/+baWsc5alB3079xmtLg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=S2g4dqsPsHHHXV8D+8ebwedOebA/CZpPFHdQpNoY4FKKJ6KHlmSkWT1z/TaaKuQrd
         oM4s/vTxpQdhWxHc7TwfHVm8PvTIXRjQ2ARXDpC6u9avjGBdHKpGluMv7HZcpoguQa
         BGo6enpAWs9hKdpliusk1ssmD2jhXaiHyuKx/yp0=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ksUs2LWULTpS; Fri, 15 May 2020 11:48:29 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id D4A298EE25D;
        Fri, 15 May 2020 11:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1589568509;
        bh=tZrweX0tkgYDBJDM7CQZADN/+baWsc5alB3079xmtLg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=J4/C7Cles1RooYzIVRHRDpYwvtzBsxQ61HQqPnIIY19dZlutuCfms+XKArsH8rjrS
         9sKwCrORhQrxpXjLNJfo75Moo61L3FMO/IeoKo3LOJQliguuzDpvkJh8exhJGV2/B+
         u+e2/SQOG38h7M/3RjF8eF4G5lg5qKuzvtX/YM7U=
Message-ID: <1589568507.3653.18.camel@HansenPartnership.com>
Subject: Re: [PATCH v9 0/8] TPM 2.0 trusted keys with attached policy
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Date:   Fri, 15 May 2020 11:48:27 -0700
In-Reply-To: <20200515093000.naogi4a7j22bzggz@cantor>
References: <20200507231147.27025-1-James.Bottomley@HansenPartnership.com>
         <23639de13874c00e6bb2b816b4db0b586c9a074c.camel@linux.intel.com>
         <483c4f1af7be41c8d091b11d4484b606ebd319b7.camel@linux.intel.com>
         <1589514263.5759.25.camel@HansenPartnership.com>
         <20200515084702.GA3404@linux.intel.com>
         <20200515093000.naogi4a7j22bzggz@cantor>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-05-15 at 02:30 -0700, Jerry Snitselaar wrote:
> On Fri May 15 20, Jarkko Sakkinen wrote:
> > On Thu, May 14, 2020 at 08:44:23PM -0700, James Bottomley wrote:
[...]
> > > However, I don't have keyctl_read_alloc in my tree, so it may be
> > > an incompatibility with another patch set.  What's your base and
> > > what other patches do you have applied?
> > 
> > http://git.infradead.org/users/jjs/linux-tpmdd.git
> > 
> > Or exactly:
> > 
> > git://git.infradead.org/users/jjs/linux-tpmdd.git (master)
> > 
> > /Jarkko
> > 
> 
> keyctl_read_alloc is in the userspace keyctl program, right?
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/keyutils.git

Hm, right thanks!  I just confirmed that linux-tpmdd.git with these
patches applied still works for me.  I'm using the keyctl in debian
testing, which identifies itself as version 1.6-6

I'll try building from git.

James

