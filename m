Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD56928E3EF
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Oct 2020 18:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbgJNQES (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Oct 2020 12:04:18 -0400
Received: from mail.hallyn.com ([178.63.66.53]:56608 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728035AbgJNQEN (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Oct 2020 12:04:13 -0400
X-Greylist: delayed 357 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Oct 2020 12:04:12 EDT
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 267FCCBF; Wed, 14 Oct 2020 10:58:15 -0500 (CDT)
Date:   Wed, 14 Oct 2020 10:58:15 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     "Roberts, William C" <william.c.roberts@intel.com>
Cc:     "tpm2@lists.01.org" <tpm2@lists.01.org>, ryaharpe@cisco.com,
        scmoser@cisco.com,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: QUEMU and TPM2 device emulation
Message-ID: <20201014155815.GA7562@mail.hallyn.com>
References: <SN6PR11MB34372D6EA769E056632095CFB8050@SN6PR11MB3437.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR11MB34372D6EA769E056632095CFB8050@SN6PR11MB3437.namprd11.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Oct 14, 2020 at 03:27:53PM +0000, Roberts, William C wrote:
> Has anyone ever setup a QUEMU instance with a virtualized TPM? I need to try and replicate an issue with the in-kernel Resource manager. My goal is to use the integrated QUEMU support
> To bring up an emulated TPM device and it's associated RM node @ /dev/tpmrm0.
> 
> I am looking at:
> https://android.googlesource.com/platform/external/qemu/+/emu-master-dev/docs/specs/tpm.txt
> 
> Which shows this command:
> 
> qemu-system-x86_64 -display sdl -enable-kvm \
>   -m 1024 -boot d -bios bios-256k.bin -boot menu=on \
>   -chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
>   -tpmdev emulator,id=tpm0,chardev=chrtpm \
>   -device tpm-tis,tpmdev=tpm0 test.img
> 
> <snip>
> #> dmesg | grep -i tpm
> [    0.711310] tpm_tis 00:06: 1.2 TPM (device=id 0x1, rev-id 1)
> 
> I have a few questions around this that I cannot seem to dig up any documentation on:
> 1. How to specify TPM2.0 device? The project https://github.com/stefanberger/swtpm/wiki seems to indicate it would be supported.
> 
> 2. Does anyone know the minimum QUEMU version for this support? I looked in the CHANGELOG here, https://wiki.qemu.org/ChangeLog from version 2.8 to 5.2 and never saw anything
> Call out TPM 2.0 specifically.

2.11 should suffice.

> 3. Does anyone have or know of better documentation to set this up? If their isn't better documentation, should we (read I) create it? This seems like a pretty handy feature.

I'm not sure how relevant this is any more, but I did this about two years ago
and documented it at https://s3hh.wordpress.com/2018/06/03/tpm-2-0-in-qemu/

Scott and/or Ryan (added to cc:) may have done it more recently.
