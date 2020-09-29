Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37CB27D1E6
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Sep 2020 16:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbgI2Oxk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Sep 2020 10:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbgI2Oxj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Sep 2020 10:53:39 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD0AC061755;
        Tue, 29 Sep 2020 07:53:39 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id k25so3742827qtu.4;
        Tue, 29 Sep 2020 07:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LxdLM+iHttbSOumhWDZv97egHmbUeQtF2b9Swdl0B60=;
        b=hX4Y+3jtPvmClo/JSzRgoXA7gAjY0UBMBegDnAUpaUUZ7Q0TCFt3Rbmkl9e7xFp03h
         8RrDQvip4qZZDm6p9y5GvJy67aDdmxQjqTE7g9ieImWJKEl8VeBCjiA9BP4ZEUbtvAW4
         mksZA6rG6G59SjA9ixhEV2oGgk2ayn5BlCQESHVEBZfgoxvEQ7lrj9uLsAX+LwH5REbL
         EMMRnX6vmW+F3Pj22TnZiHbIJiwkPW9TZRZGq+UK9OJ2hEmuFLUCISVsl7Xs9pEOrgpc
         skwvBWO7Fb5zomGupjbOUIUAXxGPqeje0IPbSJhKm6/deaEvFM/NFc/a2yKxsIbPhRv0
         jswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=LxdLM+iHttbSOumhWDZv97egHmbUeQtF2b9Swdl0B60=;
        b=C75rfI0z3PCzjVhWYYoLDKS+MNyEXQFSBWGOrGtepD+p9EywGTjI0TB268DC2nYwE6
         QX/mqORA8t6mUFcV80UAkSx4C73PkrA1C0sEEkQv0Y5WIw9Be4WXmsMIkAER36Okdwo6
         F10kZGq3kOammhcIb1/x2a/Bs9obqdGnMn1QrpHwCROgg073Z6XsroqHXDiLCypzplAP
         Dfu2/td+e7yoMyBhCjrXL7z4+nDpu9R1NvdLpoXYcDfxOwU2peAvBL+NbW+LOjOtgXZ4
         Lo2gtInDX31Vii3suz9hrnzfOAd70xDlAIx1NHQke24x7nz07rs+CndwWWP+tNkBOVcO
         5NLw==
X-Gm-Message-State: AOAM531ZdjlNQkIKDXo8x/T70l/KJJNk5PTguVT1cSW0wlcX+KjKCeum
        B0Rwy5adIYBr92d+CVjWX6c=
X-Google-Smtp-Source: ABdhPJymfyNEfxzlEcxwwnxSu38R7ekXhi2LVXO3vbzyz7NOzIeyRuscN1rfk14H6x5irwigFmaiaA==
X-Received: by 2002:ac8:6a06:: with SMTP id t6mr3700476qtr.1.1601391218859;
        Tue, 29 Sep 2020 07:53:38 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 192sm4923961qkm.110.2020.09.29.07.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 07:53:38 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 29 Sep 2020 10:53:35 -0400
To:     Ross Philipson <ross.philipson@oracle.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH 07/13] x86: Secure Launch kernel early boot stub
Message-ID: <20200929145335.GA2454775@rani.riverdale.lan>
References: <1600959521-24158-1-git-send-email-ross.philipson@oracle.com>
 <1600959521-24158-8-git-send-email-ross.philipson@oracle.com>
 <20200924173801.GA103726@rani.riverdale.lan>
 <c9ab2edf-1aaf-a1c9-92d5-2d37382a3163@oracle.com>
 <20200925191842.GA643740@rani.riverdale.lan>
 <d34c189c-4528-0458-0b84-cfd36dc068b3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d34c189c-4528-0458-0b84-cfd36dc068b3@oracle.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Sep 29, 2020 at 10:03:47AM -0400, Ross Philipson wrote:
> On 9/25/20 3:18 PM, Arvind Sankar wrote:
> > You will also need to avoid initializing data with symbol addresses.
> > 
> > 	.long mle_header
> > 	.long sl_stub_entry
> > 	.long sl_gdt
> > 
...
> > 
> > The other two are more messy, unfortunately there is no easy way to tell
> > the linker what we want here. The other entry point addresses (for the
> > EFI stub) are populated in a post-processing step after the compressed
> > kernel has been linked, we could teach it to also update kernel_info.
> > 
> > Without that, for kernel_info, you could change it to store the offset
> > of the MLE header from kernel_info, instead of from the start of the
> > image.

Actually, kernel_info is currently placed inside .rodata, which is quite
a ways into the compressed kernel, so an offset from kernel_info would
end up having to be negative, which would be ugly. I'll see if I can
come up with some way to avoid this.

> > 
> > For the MLE header, it could be moved to .head.text in head_64.S, and
> > initialized with
> > 	.long rva(sl_stub)
> > This will also let it be placed at a fixed offset from startup_32, so
> > that kernel_info can just be populated with a constant.
> 
> Thank you for the detailed reply. I am going to start digging into this now.
> 
> Ross
> 
> > 
> 
