Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51EFC345554
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Mar 2021 03:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhCWCJ7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Mar 2021 22:09:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:56244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230006AbhCWCJg (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Mar 2021 22:09:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1C4F61879;
        Tue, 23 Mar 2021 02:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616465374;
        bh=ufnIUitM6J9bdBLPikS0KcX15SkgkXsKGzaL8cA1yxA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VQTaQllVZjaiFZCJxHedeNkn0uIffF8PuwFBRFByKELN/Ji7UcYFlenv6fTaLX8Ov
         Q9vvQRW3oKvLbFO5EjHFF3n/TVjlZpGWM1MqpLTe3oHxLSc8wLGWKWwpTv4R+zsO38
         9WYuZY+khuE9yO/3g4HD3XP6+bAaGbvdVZypmV3wdpKJyeXnns5K4Hzbvy+GjghaoF
         QW7r3YEK0/c70ZXu0B6dS8Gk+3/KyJAoJhcUQtTPPYDSptop1WrJqHFHekgNPcvfc4
         CcHL0yyFjSUo0oXY16ONWZTSGhhCX1hHnhOqwzhRcydTYsB+LBzmT/Q00nMzNFvJeT
         15VsvQYG7D5iw==
Date:   Tue, 23 Mar 2021 04:09:05 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Paul Enuta <paulenuta@gmail.com>
Cc:     linux-integrity@vger.kernel.org
Subject: Re: 5.10.y Kernel Panic while poweroff and reboot - Null Pointer
 Exception - with TPM-Module SLB 9670
Message-ID: <YFlNwaLhuwPiIzYF@kernel.org>
References: <20210322205720.12F8CC061756@lindbergh.monkeyblade.net>
 <CAEjsYA4vSatmpK7dExmK=+-21xEfv01diTSxUUj4EZW5tAVb_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEjsYA4vSatmpK7dExmK=+-21xEfv01diTSxUUj4EZW5tAVb_w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Mar 22, 2021 at 11:01:09PM +0200, Paul Enuta wrote:
> Dear all,
> 
> As described in the issue here:
>  https://github.com/raspberrypi/linux/issues/4228
> and here:
>  https://www.raspberrypi.org/forums/viewtopic.php?f=75&t=303564&p=1817702#p1839351
> starting with kernel 5.10.XX we encounter a system hang with kernel
> panic at poweroff or reboot if we have dtoverlay=tpm-slb9670 loaded.
> Applying the patch proposed here:
> https://github.com/raspberrypi/linux/issues/4228#issuecomment-804081079
> and rebuilding the kernel solves the issue.
> 
> Please review the issue and provide guidance finding the cause and solving.
> 
> Kind regards,
> Paul Enuta


So does this happen with the latest mainline? Patched kernels are not our
concern.


/Jarkko
