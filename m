Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD22417AFCD
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Mar 2020 21:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgCEUeu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 Mar 2020 15:34:50 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35081 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgCEUet (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Mar 2020 15:34:49 -0500
Received: by mail-wr1-f66.google.com with SMTP id r7so8678787wro.2;
        Thu, 05 Mar 2020 12:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=IDOTEX11cunJSK+e5Q+/5P0CmencMvVLWVjAvP7JoBg=;
        b=GP5tt6YW+x2vfFIOuHGuEtOwPJ31wSu8bMffq4kwjBcgfaoO+KGCdoN2vf+B9m6j3A
         Y1TpOMUaA0QHkG+w8eGXnC9mhtw4dWqZ8z3NT+d1/XIKd3gEENs/eZ0CPuH3SQdF7/gY
         b0zTewP08bXCMySJQALV9PXB5veSyZ+l+BLIhUZWbt24HMJYPAq5XnGlu7pefpOipgqR
         JfWHSuoN5DDS5z8LT2odU4FA66bHlaxDOYXlZC8Tn7Ji0z1cCVpK/xenUJpvErk2rXj0
         NzB42/iq4DKY1LZ9aTRCVkW96KIiAT/aJkLx2vkN5txyi+G6MKWDpoIqlWyEmntITab7
         aOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=IDOTEX11cunJSK+e5Q+/5P0CmencMvVLWVjAvP7JoBg=;
        b=C2My93hjjVGB724sV+Jeuj9fTBuRx94JlD5CZgLUxaFT9aVl2AwL67pHFRHxikZOjF
         MDUDt759hmYu0tnjQHEp2406d2tbk9RipDhhzdW5WydvUzGTvgrgHlqJIvKeMqrfbe2g
         2hOZjTcZ+fAfZDnWEVjPl7ssawId35mScgJj58zBiGeOQ1ixV+S6HTk0XXuNeo+vwFc/
         pz3xcIaxQOjkTDP+2cwebs3BuUbhiOH3l0tRgxdbsD8JXS4H55cFNKWb4YtmMVRKNoSX
         SDAXiNz0ZCyAXk6xAOsGP0oas2LuohJ6A01g1nkOJ/XICBPEkrhdPRB/frHffTNMFpGp
         dZHQ==
X-Gm-Message-State: ANhLgQ1n/U2FO86imDgDgZUqpydvctweOsEvIamXn/TKNU1nfIuFPeTZ
        gFZWit6GAlFgbDHFV3yuWOo=
X-Google-Smtp-Source: ADFU+vtY445MTs3NyObNXlzsuoAccoC6ePupE9JkiNBaYEwr8Mdj9KfVCySxnpTg0Xp8bL4N3rdaoA==
X-Received: by 2002:adf:9282:: with SMTP id 2mr734439wrn.124.1583440487893;
        Thu, 05 Mar 2020 12:34:47 -0800 (PST)
Received: from felia ([2001:16b8:2d7c:7000:ec58:d834:7ed:456a])
        by smtp.gmail.com with ESMTPSA id c14sm32242324wro.36.2020.03.05.12.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 12:34:47 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Thu, 5 Mar 2020 21:34:46 +0100 (CET)
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
Subject: Re: [PATCH] MAINTAINERS: adjust to trusted keys subsystem creation
In-Reply-To: <9127f0318e8507ca0b4e146d9b99d9ecb27f7f28.camel@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2003052132540.5431@felia>
References: <20200304160359.16809-1-lukas.bulwahn@gmail.com> <9127f0318e8507ca0b4e146d9b99d9ecb27f7f28.camel@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On Thu, 5 Mar 2020, Jarkko Sakkinen wrote:

> On Wed, 2020-03-04 at 17:03 +0100, Lukas Bulwahn wrote:
> > Commit 47f9c2796891 ("KEYS: trusted: Create trusted keys subsystem")
> > renamed trusted.h to trusted_tpm.h in include/keys/, and moved trusted.c
> > to trusted-keys/trusted_tpm1.c in security/keys/.
> > 
> > Since then, ./scripts/get_maintainer.pl --self-test complains:
> > 
> >   warning: no file matches F: security/keys/trusted.c
> >   warning: no file matches F: include/keys/trusted.h
> > 
> > Rectify the KEYS-TRUSTED entry in MAINTAINERS now.
> > 
> > Co-developed-by: Sebastian Duda <sebastian.duda@fau.de>
> > Signed-off-by: Sebastian Duda <sebastian.duda@fau.de>
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> > Sumit, please ack.
> > Jarkko, please pick this patch.
> 
> I'll pick it when it is done. I acknowledge the regression but I
> see no reason for rushing as this does not break any systems in
> the wild.
> 

Agree. No need to rush this. I sent out a v3, and I hope to get Sumit's 
ACK and then you can pick it for the next merge window.


Lukas
