Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A195929C7E3
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Oct 2020 19:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371300AbgJ0S50 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Oct 2020 14:57:26 -0400
Received: from mail.rosalinux.ru ([195.19.76.54]:35748 "EHLO mail.rosalinux.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S371299AbgJ0S5Z (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Oct 2020 14:57:25 -0400
X-Greylist: delayed 327 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Oct 2020 14:57:24 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id C735DDC8993D8;
        Tue, 27 Oct 2020 21:57:22 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id iTeuNSPj9jIP; Tue, 27 Oct 2020 21:57:22 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.rosalinux.ru (Postfix) with ESMTP id 475E3DC8993DA;
        Tue, 27 Oct 2020 21:57:22 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru 475E3DC8993DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
        s=A1AAD92A-9767-11E6-A27F-AC75C9F78EF4; t=1603825042;
        bh=gHSjuv4zqufkD8/M6KiP8rH4zr24xcIEfcNGQH7ILFI=;
        h=To:From:Message-ID:Date:MIME-Version;
        b=Wu1KHJ8h+4lBlRYFK68EE7vkfqnwSM9pzynuPYRkbfSurosBkk8ruo7hCGgZ0p4UU
         ji2np1MwIJb5HFJ79pVTLnCJbD9RSgop7U1V9RWuO+CIDi4DrXIaHYApXkg6P2VN84
         boPfsWGpVyO5N77zzos8SU0T4TFaKs32pG67h+z5PFzfOsffUBnuCNZSM6drEmtOnn
         Xtoci25/zMuCivCwP5/8CXkNT+MSIBqVuHpjElwFZpy2/FfLwlocObA3Zx7L1mzGkm
         srJRdbeC/bJtRpXog8xiNfQD39zbrFBrjR1fbZZ/2O2kZmBRIJvn5KUq67MZ9aw9C4
         8dx+OiuM1FGZA==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
        by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UzshRGyib86J; Tue, 27 Oct 2020 21:57:22 +0300 (MSK)
Received: from [192.168.1.173] (broadband-90-154-70-7.ip.moscow.rt.ru [90.154.70.7])
        by mail.rosalinux.ru (Postfix) with ESMTPSA id D2552DC8993D8;
        Tue, 27 Oct 2020 21:57:21 +0300 (MSK)
Subject: Re: [PATCH ima-evm-utils] boot_aggregate.test: Skip if CONFIG_IMA not
 enabled
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>
References: <20201019200803.35255-1-petr.vorel@gmail.com>
 <e274a823ca408f33c11ea03878442189e62d9f9b.camel@linux.ibm.com>
 <20201020180231.GA14580@dell5510> <20201027184933.GA5210@sequoia>
From:   Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
Message-ID: <96983bdf-9f0a-b936-f24b-95161201da3a@rosalinux.ru>
Date:   Tue, 27 Oct 2020 21:57:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201027184933.GA5210@sequoia>
Content-Type: text/plain; charset=utf-8
Content-Language: ru-RU
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

27.10.2020 21:49, Tyler Hicks =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> I can help with the Ubuntu status. IMA is still enabled there. You can
> see CONFIG_IMA set to 'y' in the 20.04 LTS (Focal) and most recent 20.1=
0
> release (Groovy):
>
> https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/foca=
l/tree/debian.master/config/annotations#n12861
> https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/groo=
vy/tree/debian.master/config/annotations#n13173
>
> Tyler

Sorry for a bit offtop, by the way, does any Linux distro ship packages w=
ith IMA-signed files?

I know that work was done to support it in DEB and RPM and at least in RP=
M it was upstreamized.

We are going to try shipping IMA-signed packages in ROSA, it would be nic=
e to study experience of other distros if there is any.

