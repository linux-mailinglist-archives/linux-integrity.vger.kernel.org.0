Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5AC131438
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Jan 2020 15:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgAFO6C (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Jan 2020 09:58:02 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51152 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726422AbgAFO6C (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jan 2020 09:58:02 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id E0C5B8EE105;
        Mon,  6 Jan 2020 06:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1578322681;
        bh=c9bTRxU5ip6U7WDjQQHifIpxjbQmFCmwONV+Txp6wDI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=J6gv98tBIgtR++a69eCaz41UFql8zPal9jCh9xfJYG/5Tr28uNFcN8Btz4jXE2rpP
         DFZX/qfSx6cpS1V5uL0DVOtMJOabXKQcwaeToTsxSEtkNclUerK5jzZCJkkYGhp84w
         HVc9IsKNLDV0BbTTPI8juxPHyVlQ2nte1XrCYQJA=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0RDftdKXJvYi; Mon,  6 Jan 2020 06:58:01 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4D6628EE0FC;
        Mon,  6 Jan 2020 06:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1578322681;
        bh=c9bTRxU5ip6U7WDjQQHifIpxjbQmFCmwONV+Txp6wDI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=J6gv98tBIgtR++a69eCaz41UFql8zPal9jCh9xfJYG/5Tr28uNFcN8Btz4jXE2rpP
         DFZX/qfSx6cpS1V5uL0DVOtMJOabXKQcwaeToTsxSEtkNclUerK5jzZCJkkYGhp84w
         HVc9IsKNLDV0BbTTPI8juxPHyVlQ2nte1XrCYQJA=
Message-ID: <1578322680.3455.6.camel@HansenPartnership.com>
Subject: Re: [integrity:next-integrity-testing 5/5]
 security/integrity/ima/ima_asymmetric_keys.c:53:6: error: redefinition of
 'ima_init_key_queue'
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org
Date:   Mon, 06 Jan 2020 06:58:00 -0800
In-Reply-To: <dd99db8f-08de-d7ac-3d63-0717fc6c7ba5@linux.microsoft.com>
References: <202001051708.DO90I9sl%lkp@intel.com>
         <48389231-dfcf-be6d-b543-6da8e3d55886@linux.microsoft.com>
         <1578248115.3310.41.camel@HansenPartnership.com>
         <2a24e191-fc31-a502-7463-b6e90f91e1c5@linux.microsoft.com>
         <1578251768.3310.49.camel@HansenPartnership.com>
         <dd99db8f-08de-d7ac-3d63-0717fc6c7ba5@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2020-01-05 at 19:58 -0800, Lakshmi Ramasubramanian wrote:
> On 1/5/20 11:16 AM, James Bottomley wrote:
> 
> > Well, yes, you just need to condition the build of
> > ima_asymmetric_keys
> > on a boolean instead of a tristate, so you introduce an
> > intermediate
> > one:
> > 
> > config IMA_ASYMMETRIC_KEYS
> > 	bool
> > 	default y
> > 	depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
> > 
> > James
> 
> Thanks for your help James.
> 
> Hi Mimi,
> 
> I have defined a new config as James has suggested above and
> verified the kernel builds fine with the ".config" files given by
> "kbuild test robot <lkp@intel.com>".
> 
> Would it be possible to share all the ".config" files that
> "kbuild test robot" would build with? I'll make sure my changes
> build fine with all those.

I'm afraid it's not possible: the kbuild robot is doing make
randconfig, which generates a random configuration for the kernel.  The
randconfig testing is the easiest way to detect Kconfig problems like
this one.  You can, of course, do make randconfig yourself, but you
have to run through it a lot of times to get the coverage the robot
gets.

James

