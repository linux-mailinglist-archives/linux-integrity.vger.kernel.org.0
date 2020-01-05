Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9863B13095F
	for <lists+linux-integrity@lfdr.de>; Sun,  5 Jan 2020 19:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgAESPU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 5 Jan 2020 13:15:20 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:35622 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726368AbgAESPU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 5 Jan 2020 13:15:20 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id DA21D8EE148;
        Sun,  5 Jan 2020 10:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1578248119;
        bh=U745jq8lRjQbSTIlLHXyTsRx7C7r1Lsp1URXar056rI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nAF3MaYiknkvZF+kw2CxV+2FDBhY0DoDPzZJmH4vOVD2HPI5GrGFf2bWEmGc9OwV6
         vJ8uQYNmUTTjOrCr8YvOVNa81HN88IlpE6i+rhwyzUaUup5kqq6/y7YFmxN0Vtu6I0
         8XYta1xPJEjbxAB5Z6hM9uarcpEc+LbgRXH9qTAg=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sZD2xperyc3o; Sun,  5 Jan 2020 10:15:18 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 22B3A8EE0D2;
        Sun,  5 Jan 2020 10:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1578248118;
        bh=U745jq8lRjQbSTIlLHXyTsRx7C7r1Lsp1URXar056rI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Oxjzlp+C6Wkhjndviivv1F9DyRt+DEQXoj/Fox5LykEeG7tMDTmWMTTJnRDk8XyOK
         9CzEa//IBVmfayjRk+Er9Mtte6hF4Yu5wu7M1i1lJ7e4OQWgun73YJQUD9Vc2bn1nI
         Ypto44XV9f0UlkKHEBTtixtGc7DOTG30iZ6TE6Gs=
Message-ID: <1578248115.3310.41.camel@HansenPartnership.com>
Subject: Re: [integrity:next-integrity-testing 5/5]
 security/integrity/ima/ima_asymmetric_keys.c:53:6: error: redefinition of
 'ima_init_key_queue'
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>
Date:   Sun, 05 Jan 2020 10:15:15 -0800
In-Reply-To: <48389231-dfcf-be6d-b543-6da8e3d55886@linux.microsoft.com>
References: <202001051708.DO90I9sl%lkp@intel.com>
         <48389231-dfcf-be6d-b543-6da8e3d55886@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2020-01-05 at 09:57 -0800, Lakshmi Ramasubramanian wrote:
> On 1/5/2020 1:00 AM, kbuild test robot wrote:
> 
> > 
> > > > security/integrity/ima/ima_asymmetric_keys.c:53:6: error:
> > > > redefinition of 'ima_init_key_queue'
> > 
> >      void ima_init_key_queue(void)
> >           ^~~~~~~~~~~~~~~~~~
> >     In file included from
> > security/integrity/ima/ima_asymmetric_keys.c:16:0:
> >     security/integrity/ima/ima.h:222:20: note: previous definition
> > of 'ima_init_key_queue' was here
> >      static inline void ima_init_key_queue(void) {}
> 
> In the given config file the following configs are specified
> 
> 	CONFIG_IMA=y
> 	CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=m
> 
> If CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is selected 
> ima_asymmetric_keys.c file is built and linked (as given in the 
> Makefile). ima_init_key_queue() is declared in ima.h
> 
> But if CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is not selected 
> ima_asymmetric_keys.c is not built. ima_init_key_queue() is declared
> as an empty function (static inline in ima.h)
> 
> #ifdef CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> void ima_init_key_queue(void);
> #else
> static inline void ima_init_key_queue(void) {}
> #endif /* CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE */
> 
> If I understand the reported build error, it looks like 
> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE was disabled first and then
> enabled later - in the same build sequence.
> 
> Is that correct?

I don't think so.  The specific problem is that
ASYMMETRIC_PUBLIC_KEY_SUBTYPE is defined as a tristate in
crypto/asymmetric_keys/Kconfig, so the above m setting for it is
perfectly legal regardless of the IMA setting.  This line you
introduced to the Makefile:

obj-$(CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += ima_asymmetric_keys.o

Then causes ima_asymmetric_keys.o to be added to obj-m causing the
kernel to think it's building it as a module.

To fix this, I think you have to force ASYMMETRIC_PUBLIC_KEY_SUBTYPE to
be built in if IMA is.

James

