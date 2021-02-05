Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCAA3116E8
	for <lists+linux-integrity@lfdr.de>; Sat,  6 Feb 2021 00:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhBEXUJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Feb 2021 18:20:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:52742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229703AbhBEKGd (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Feb 2021 05:06:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B66764FDB;
        Fri,  5 Feb 2021 10:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612519544;
        bh=scnkNV3b88L2nKBqb1usuyBtXEqbdj6p/tdhfcQT/fA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W6Q0p10ZV4qOxpqOl55bYsgZ4v+JW/RikcOOXr7vvwHLGR8do1jBfGRxnRD5fRXmk
         Qvd+HE/kP32hKgT/CbwF2O2Q9e/1KXPRXVlbWUqBllgxZEhnsGn1iVKa2ipj9SH7uK
         P5iQMU9NriKkEzsj/UnBTHkOLK3nzpA5jxUv+v7w=
Date:   Fri, 5 Feb 2021 11:05:42 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, bauerman@linux.ibm.com,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        sashal@kernel.org, tyhicks@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ima: Free IMA measurement buffer on error
Message-ID: <YB0YdqbbdAdbEOQw@kroah.com>
References: <20210204174951.25771-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204174951.25771-1-nramas@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Feb 04, 2021 at 09:49:50AM -0800, Lakshmi Ramasubramanian wrote:
> IMA allocates kernel virtual memory to carry forward the measurement
> list, from the current kernel to the next kernel on kexec system call,
> in ima_add_kexec_buffer() function.  In error code paths this memory
> is not freed resulting in memory leak.
> 
> Free the memory allocated for the IMA measurement list in
> the error code paths in ima_add_kexec_buffer() function.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Suggested-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> Fixes: 7b8589cc29e7 ("ima: on soft reboot, save the measurement list")
> ---
>  security/integrity/ima/ima_kexec.c | 1 +
>  1 file changed, 1 insertion(+)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
