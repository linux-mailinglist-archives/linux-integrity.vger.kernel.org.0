Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8A7F17C74D
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Mar 2020 21:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgCFUu5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 Mar 2020 15:50:57 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41309 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgCFUu5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Mar 2020 15:50:57 -0500
Received: by mail-ed1-f67.google.com with SMTP id m25so4039403edq.8;
        Fri, 06 Mar 2020 12:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=VdqUnRTWp10pjgFX5EvP6C5xXn2Jmo+eBLSoySWldqs=;
        b=hRXsBV3GZGSJ2YmU0tyU/P3Ckp0n1Ke0qs57bW80TW6GStW1yVT8bz+MK7Z+c/NrNv
         lOklGzmD7TG1rPBwMkkY2azr3tphv8GjcbwdI0ccxfmUrMa+2iK89/wAVwnq3MxbPZCg
         5bPxhQ+SrxATXfH2vX7Ku1JEXPQ3vr5XN+zSY5ZmlRvGoyYQ9GDb/oa76jL/hxctgqsD
         DKi3TflY1iO7+iPY3/PSmwN2DFs3jox5UCMzAPN7MpH8dFkcmqw32kCKoAwgg12RtjOe
         w5+jerXZzIBSp64mzI+QG2NyuI/GcV5vM3J4VV3LxpKEXP/jDSy9VttVGmT/NDW7UATc
         vwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=VdqUnRTWp10pjgFX5EvP6C5xXn2Jmo+eBLSoySWldqs=;
        b=UnHUdwUY20dhGw+hoL9PCO66IQih6dtjkSRhWkdlX/rgR+0SBdBWLOQgNWVJ9WLyZY
         y5Lhz2vF6nzaVLq9lT42zdXwjcTj/HheMvbE0FkEgsX10FwDnoR23rJyEWx2dy3fozmK
         ZjyaA641pd/xKNILMVc6nFLJT0lQnfWKtXdmOARXA97ojZKIKW1qmkI+oG3ao5BCwzTa
         gP/CHOEkmUsY+Sy+VdZyASFgPsPnJS83qdBuwINWjopJ0//2FsMg/YiXfcegNt14vqMG
         YYm8biOTi66Yb/rWyFzsGJQDNFFhdMW8qT/HSsAQC6vHXVhuMm9hzL2sR5SuTDvg576J
         7bwg==
X-Gm-Message-State: ANhLgQ3sp/pISbeDsnpUQxNxkvQGaI9eqSQj7DfG764t22RzTND+DJx1
        Qs24iKXiMEIw+GkAYRz9VIg=
X-Google-Smtp-Source: ADFU+vt2dJD/PPlFZud7douKhwIZ+dTq7co7j3G37z0Dc1lWVvfrT/Ni4yD+IsB0sjh2s8hGZD3/qg==
X-Received: by 2002:a05:6402:cac:: with SMTP id cn12mr5044832edb.280.1583527854576;
        Fri, 06 Mar 2020 12:50:54 -0800 (PST)
Received: from felia ([2001:16b8:2d12:b200:a423:5ade:d131:da88])
        by smtp.gmail.com with ESMTPSA id f20sm1471839edm.38.2020.03.06.12.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 12:50:53 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Fri, 6 Mar 2020 21:50:44 +0100 (CET)
X-X-Sender: lukas@felia
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Sebastian Duda <sebastian.duda@fau.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] MAINTAINERS: adjust to trusted keys subsystem
 creation
In-Reply-To: <20200306193127.GJ7472@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2003062148050.2990@felia>
References: <20200305203013.6189-1-lukas.bulwahn@gmail.com> <20200306193127.GJ7472@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On Fri, 6 Mar 2020, Jarkko Sakkinen wrote:

> On Thu, Mar 05, 2020 at 09:30:13PM +0100, Lukas Bulwahn wrote:
> > Commit 47f9c2796891 ("KEYS: trusted: Create trusted keys subsystem")
> > renamed trusted.h to trusted_tpm.h in include/keys/, and moved trusted.c
> > to trusted-keys/trusted_tpm1.c in security/keys/.
> > 
> > Since then, ./scripts/get_maintainer.pl --self-test complains:
> > 
> >   warning: no file matches F: security/keys/trusted.c
> >   warning: no file matches F: include/keys/trusted.h
> > 
> > Rectify the KEYS-TRUSTED entry in MAINTAINERS now and ensure that all
> > files in security/keys/trusted-keys/ are identified as part of
> > KEYS-TRUSTED.
> > 
> > Co-developed-by: Sebastian Duda <sebastian.duda@fau.de>
> > Signed-off-by: Sebastian Duda <sebastian.duda@fau.de>
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> 
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> > Changes to v1:
> >   - use a global pattern for matching the whole security/keys/trusted-keys/
> >     directory.
> > Changes to v2:
> >   - name the correct directory in the commit message
> > 
> > Sumit, please ack.
> > Jarkko, please pick this patch v3.
> 
> Please tell me why you emphasize the moment when a patch that does not
> fix a critical bug is picked?
> 
> Do you have systems that break because the MAINTAINERS file is not
> updated?
> 
> It will end up in v5.7 PR for sure but saying things like that is same
> as saying that there would be some catastrophically urgent need to still
> squeeze the patch into v5.6. Unless you actually have something critical
> in your hand, please stop doing that.
> 

Got it. I did not intend to emphasize any urgency; I will not continue 
to do that for patches of this clean-up type.

Lukas
