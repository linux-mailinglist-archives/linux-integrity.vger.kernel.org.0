Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6564212453E
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Dec 2019 12:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfLRLDO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Dec 2019 06:03:14 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39439 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfLRLDN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Dec 2019 06:03:13 -0500
Received: by mail-wm1-f67.google.com with SMTP id 20so1269704wmj.4
        for <linux-integrity@vger.kernel.org>; Wed, 18 Dec 2019 03:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=VaysA7IlqDXPOxdOsGsKdFEXVpxF1pTwFbagFkrgqas=;
        b=U2faBm6YN6xKP04YNzJdCmz51sgXVZJdXiGPwmZIfoea9S2p56z2XfJkwcCH5vv8LI
         +LoL/NJii26fgLloWu/qa9bF+t5ZyO+2iYLRDh7972llndvkCQdO0AnZ72/esc+eb2uW
         4U9W/MqrU5Tc7sEGC1R1i0Wp8VSdrw3qE9GzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=VaysA7IlqDXPOxdOsGsKdFEXVpxF1pTwFbagFkrgqas=;
        b=ic+tz95eEy+a1pPw3QYfBW8LcSPieevuMH87QX0gxwrndcnyrt+yQOhpyiIm3rWkaL
         pLIIwX/zgnl7gfrjiK5JDrwwvdVoLXb54BsjbgveuIVWv3bCRxKKi2oDDQuqp4mbgRux
         5iHUJr8ppquVtCCZVYuNhPfxxbVaKOr7WMVXaEDxjdS36qHexlCZ3+GVwMd+g4fIC/WW
         CFLG8CbSB3Pzm+wyQpXd23RHLDxc6N93uby0sa6htsrutxL1X7SdU0CP+T9i24VjIQOB
         pRseBqpEnwY+uUcwlPZfs/tQgkl8sfQukdlnk7A/yEGbUue91YibToPKX3EtvZ1ej/gU
         7cug==
X-Gm-Message-State: APjAAAWfYeGT92K9P8wjWZaXNq7yq5DyLbloCjOd3+diPrLpZs0gQ9PA
        H19+YuatTW2eACPUcA1gHRo+5A==
X-Google-Smtp-Source: APXvYqwEDw33xSM9dXOl1KdYfEr2bPMTWkcfxRl2JYVvpLiSuj3PN1cLzNAr2b8ZKPibkIXBg/Q/Ug==
X-Received: by 2002:a05:600c:2148:: with SMTP id v8mr2628992wml.111.1576666991755;
        Wed, 18 Dec 2019 03:03:11 -0800 (PST)
Received: from ?IPv6:2620:0:105f:304:c29:4454:35de:5c04? ([2620:0:105f:304:c29:4454:35de:5c04])
        by smtp.gmail.com with ESMTPSA id 16sm2050765wmi.0.2019.12.18.03.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 03:03:10 -0800 (PST)
Message-ID: <2ae5127d76cbf78140fb2d6108c9ec70c7d8ae5d.camel@chromium.org>
Subject: Re: [PATCH] integrity: Expose data structures required for
 include/linux/integrity.h
From:   Florent Revest <revest@chromium.org>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-integrity@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, revest@google.com,
        allison@lohutok.net, armijn@tjaldur.nl, bauerman@linux.ibm.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, kpsingh@chromium.org
Date:   Wed, 18 Dec 2019 12:03:09 +0100
In-Reply-To: <1576624105.4579.379.camel@linux.ibm.com>
References: <20191217134748.198011-1-revest@chromium.org>
         <e9e366d3-6c5d-743b-ffde-6b95b85884a2@schaufler-ca.com>
         <1576624105.4579.379.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-12-17 at 18:08 -0500, Mimi Zohar wrote:
> On Tue, 2019-12-17 at 08:25 -0800, Casey Schaufler wrote:
> > On 12/17/2019 5:47 AM, Florent Revest wrote:
> > > From: Florent Revest <revest@google.com>
> > > 
> > > include/linux/integrity.h exposes the prototype of
> > > integrity_inode_get().
> > > However, it relies on struct integrity_iint_cache which is
> > > currently
> > > defined in an internal header, security/integrity/integrity.h.
> > > 
> > > To allow the rest of the kernel to use integrity_inode_get,
> > 
> > Why do you want to do this?
> 
> ditto

My team works on KRSI (eBPF MAC policies presented at LSS by KP Singh).
https://lkml.org/lkml/2019/9/10/393 We identified file hashes gathered
from the integrity subsystem as an interesting field that we could
potentially someday expose to eBPF programs through helpers.

One of the reason behind writing KRSI is to replace a custom kernel
auditing module that currently needs to redefine those structures to
access them. I imagine other kernel modules could benefit from a file
hash API too.

This is the least intrusive patch I could come up with that allows us
to lookup a hash from an inode. I was surprised to find that
integrity_inode_get was exposed but not the structures it returns.

If the community is interested in a different file hash API, I'd be
happy to iterate on this patch based on your feedback.

> > >  this patch
> > > moves the definition of the necessary structures from a private
> > > header
> > > to a global kernel header.

