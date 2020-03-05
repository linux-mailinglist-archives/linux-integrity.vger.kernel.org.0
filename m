Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D227E17B04E
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Mar 2020 22:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgCEVKP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 Mar 2020 16:10:15 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42329 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgCEVKP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Mar 2020 16:10:15 -0500
Received: by mail-wr1-f67.google.com with SMTP id v11so6803732wrm.9;
        Thu, 05 Mar 2020 13:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=R+PGzB7QBkmxLrqxE3+DOkXyeGf/OpoVTm06v9y8aos=;
        b=nSdCOvQzF3QX1J14e07drWR926Ix5pJUxt4CB5rRDVJQw97A6ZpJIHnlzNKMZxmGrZ
         /cBSlaGBs8J5Ov1YoUxy7GdNGpLeiS7XCumZqJUWNknjgX9yP8ZA3X9LvZreNrvKPZke
         rAmXr6N/cNITiP84Dc0QMS83lTsANVhXKxn+KkY1CDwVDSEz7V3lmhlUCDX0C8NuNN4z
         GJt9wWtEHi4ns034Pba6dkSkDbnOFf3jUNyMxjvo7olP4yppRkVVVLkYWqSQxh4X4Gsv
         iRXN8ll6jRmCpTlxQZmufbc5XizHwejbbxKRunjHhYkPiwN94511qCLdJikJrPyHKluo
         dUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=R+PGzB7QBkmxLrqxE3+DOkXyeGf/OpoVTm06v9y8aos=;
        b=ji7os7fgH8M0wRXJJopUXwFLJRuZL29Vu3aqwEBNGFaK1YJESKCUxFLXgDGXYDqItH
         FJIIAHFtuPX+gQJ8x5KQtxY3HJJmYdPk/SR2EqNOke2G9DSSGDgX1xhtEwJqQ9msAHRP
         b3BqOOPupKTSEYdUC6IRF/5/ITBoJ+UFJSH0oJ2+RVi/g028F+Zv3tnKe4sy4n/wIekJ
         KYY33peXhAla/g8QbLJm4KNx0Sw116MIlRD4A4fzP6eSC+o9oMGculskm+i5dBmgjI2h
         lvEAllJNKsyqVlTmvew0p0KKjR2QGlCA3TCylcV6Noot8JSXqh9CCQ33j7j2KFIFxWZY
         twQQ==
X-Gm-Message-State: ANhLgQ1EoMjGRZr36uD7zUVt9QiIOOEuvklgc07RG9K8AN5s6wnIvozL
        gsy3CzppmV3dnMswoYGQf5A=
X-Google-Smtp-Source: ADFU+vsIWp72Qy//Y7eyylr7b2Bf1ieFhvhxXqkbeDhEz3Rt/Koe7g+MDjvNCPYcsAhXFULtgBAdTg==
X-Received: by 2002:adf:a19c:: with SMTP id u28mr754837wru.221.1583442611069;
        Thu, 05 Mar 2020 13:10:11 -0800 (PST)
Received: from felia ([2001:16b8:2d7c:7000:ec58:d834:7ed:456a])
        by smtp.gmail.com with ESMTPSA id g14sm46885651wrv.58.2020.03.05.13.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 13:10:10 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Thu, 5 Mar 2020 22:10:00 +0100 (CET)
X-X-Sender: lukas@felia
To:     James Bottomley <jejb@linux.ibm.com>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Sebastian Duda <sebastian.duda@fau.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: adjust to trusted keys subsystem creation
In-Reply-To: <1583441170.3927.37.camel@linux.ibm.com>
Message-ID: <alpine.DEB.2.21.2003052204060.7885@felia>
References: <20200304160359.16809-1-lukas.bulwahn@gmail.com> <9127f0318e8507ca0b4e146d9b99d9ecb27f7f28.camel@linux.intel.com> <alpine.DEB.2.21.2003052132540.5431@felia> <1583441170.3927.37.camel@linux.ibm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On Thu, 5 Mar 2020, James Bottomley wrote:

> On Thu, 2020-03-05 at 21:34 +0100, Lukas Bulwahn wrote:
> > 
> > On Thu, 5 Mar 2020, Jarkko Sakkinen wrote:
> > 
> > > On Wed, 2020-03-04 at 17:03 +0100, Lukas Bulwahn wrote:
> > > > Commit 47f9c2796891 ("KEYS: trusted: Create trusted keys
> > > > subsystem")
> > > > renamed trusted.h to trusted_tpm.h in include/keys/, and moved
> > > > trusted.c
> > > > to trusted-keys/trusted_tpm1.c in security/keys/.
> > > > 
> > > > Since then, ./scripts/get_maintainer.pl --self-test complains:
> > > > 
> > > >   warning: no file matches F: security/keys/trusted.c
> > > >   warning: no file matches F: include/keys/trusted.h
> > > > 
> > > > Rectify the KEYS-TRUSTED entry in MAINTAINERS now.
> > > > 
> > > > Co-developed-by: Sebastian Duda <sebastian.duda@fau.de>
> > > > Signed-off-by: Sebastian Duda <sebastian.duda@fau.de>
> > > > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > > > ---
> > > > Sumit, please ack.
> > > > Jarkko, please pick this patch.
> > > 
> > > I'll pick it when it is done. I acknowledge the regression but I
> > > see no reason for rushing as this does not break any systems in
> > > the wild.
> > > 
> > 
> > Agree. No need to rush this. I sent out a v3, and I hope to get
> > Sumit's ACK and then you can pick it for the next merge window.
> 
> From a process point of view, I don't quite understand this.  You're
> altering an entry in the MAINTAINERS file which belongs to the three
> maintainers of trusted keys, you only need our ack to do that, which
> picking up via the trusted key tree will substitute for.  It would be
> useful to have Sumit review this because he moved the files and there
> may be something we missed, but a reviewed-by: is a nice to have and
> not a block on the process.
>

Agree. I expect Sumit to acknowledge that the PATCH v3 "fixes" what he 
missed in his commit from his point of view. I do not use the Fixes: tag, 
because it just some basic administrative clean-up, but not any 
functional change; commits with Fixes: tags are quickly picked up for 
stable, but this patch should not be picked up, because changes to 
MAINTAINERS do not need to be reflected in stable branches.

There is no rush and no blocker here.

Lukas
