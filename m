Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A37E1ACFFC
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Apr 2020 20:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgDPSyh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Apr 2020 14:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbgDPSyg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Apr 2020 14:54:36 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BA9C061A0C
        for <linux-integrity@vger.kernel.org>; Thu, 16 Apr 2020 11:54:36 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id f8so534505plt.2
        for <linux-integrity@vger.kernel.org>; Thu, 16 Apr 2020 11:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F6tOMgTpqub9c/Y4qzop7NWPtR6xBlA9/+nLetO5I3w=;
        b=HCP2FzM5SRzJv0Tzf0NoWqjant96CCWyvIq54O1OaxZcVtzG0AIqaXnBVBESP+BJSt
         cd4mEoIv5EJv0sY1qT9dC768doic/c8VzAXzNx+Eo2WOoEZbFOSeUu2KhMfEDuB53aH0
         nm3c/BWApkjR9vrRRl/GOzFoYf7wi0sdMvCAeE/CnsI7nDWddx/vg7xIeK5mpNXHSJXn
         npPEXqiyuV6Dlxt6a9c/vyyAwUGMkeKqKLnJfzpLihT+anntPgbiynKqdhODSyea71Ej
         ZVFq8Kkgsw6pqvbj3pCtsCMrGkOXAWbg4X4tG+lOwOB8zfubiivC9LsdrbP7QkID5o6y
         k0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F6tOMgTpqub9c/Y4qzop7NWPtR6xBlA9/+nLetO5I3w=;
        b=jecw4nNBmRSjlhe/gn6F2lOvjCIcRQC8bhac1Ffj4WntQQ2rp3P5xvgQBHxy/spLFE
         VjWSPhhai+QyVxm/SdeIJl1s3IDbvy0kD1WQDwveMDSjkPAlJjoEjEcegV/Jncd25WgS
         tt1+h3Pa4o82pyfNA2XDQ9NuBsLjOVExFH1qipTV3s+m6v8UtJ7f7yfu0eFl9ncaIkm4
         oTjCeLYFnwgmeCNzJLbHqc0t7sjVaiP1cg1CFVeS643ttirzQNdNy7Fz2kCqC0D3GL5r
         pHe3h1rzvv/Eaoo8dbJDzU3wo9xS15m+tpphgHW8jOHoAnMyUwL0+/pcgk4aFxKthvIR
         G0ZQ==
X-Gm-Message-State: AGi0PubCGUP79wX3IHJuiqxLjZ0Dd0DIcFFhaH4DKy6epYi20ZEDS3bE
        OadV8WPEE1qrTY/pUdwiDdkbFi0L9rA=
X-Google-Smtp-Source: APiQypJmtQZkxonpPnd4QwqDb18Dh0dIuDXC7KuuJJxqHZrRKN81mb9dWRs7X6deXsRWjLU6sA4A6Q==
X-Received: by 2002:a17:90a:fb89:: with SMTP id cp9mr6635090pjb.40.1587063275381;
        Thu, 16 Apr 2020 11:54:35 -0700 (PDT)
Received: from vader ([2620:10d:c090:400::5:844e])
        by smtp.gmail.com with ESMTPSA id u8sm3289031pjy.16.2020.04.16.11.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 11:54:34 -0700 (PDT)
Date:   Thu, 16 Apr 2020 11:54:33 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm_tis: work around status register bug in
 STMicroelectronics TPM
Message-ID: <20200416185433.GA701157@vader>
References: <6c55d7c1fb84e5bf2ace9f05ec816ef67bd873e1.1586990595.git.osandov@fb.com>
 <20200416170810.GD199110@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416170810.GD199110@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Apr 16, 2020 at 08:08:10PM +0300, Jarkko Sakkinen wrote:
> On Wed, Apr 15, 2020 at 03:45:22PM -0700, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > We've encountered a particular model of STMicroelectronics TPM that
> > transiently returns a bad value in the status register. This causes the
> > kernel to believe that the TPM is ready to receive a command when it
> > actually isn't, which in turn causes the send to time out in
> > get_burstcount(). In testing, reading the status register one extra time
> > convinces the TPM to return a valid value.
> > 
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> 
> So what is the bad value?

0xff. Sorry, I thought it would be clear from the code and comment in
the patch itself. Would you prefer for me to repeat it in the commit
message?
