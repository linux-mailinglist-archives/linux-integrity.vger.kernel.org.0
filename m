Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B0728E484
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Oct 2020 18:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730921AbgJNQcK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Oct 2020 12:32:10 -0400
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:43294 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727187AbgJNQcK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Oct 2020 12:32:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6AF251280434;
        Wed, 14 Oct 2020 09:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1602693130;
        bh=b2EvIMdZwvPmM5lo8nNitWdsO3Q7HwPuiDX0oc6T7W8=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=MTqWfETNoWVtSgzQam/gpunbJY56MSsrKwi6BdrsyMlZ/D0nB+2kx3ouDJ40jwmJ8
         utOZ4hhhkUXZjD+l33xqbjQv/onySMyih/alDMu/q2IdkQUmUYDgJEbM7LZlrk4D1s
         edw2zmYvak2BAVtvHFvbatrUbYauvpmoBTKr3nEA=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IqzPPexRVQFp; Wed, 14 Oct 2020 09:32:10 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 0B9DE1280401;
        Wed, 14 Oct 2020 09:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1602693130;
        bh=b2EvIMdZwvPmM5lo8nNitWdsO3Q7HwPuiDX0oc6T7W8=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=MTqWfETNoWVtSgzQam/gpunbJY56MSsrKwi6BdrsyMlZ/D0nB+2kx3ouDJ40jwmJ8
         utOZ4hhhkUXZjD+l33xqbjQv/onySMyih/alDMu/q2IdkQUmUYDgJEbM7LZlrk4D1s
         edw2zmYvak2BAVtvHFvbatrUbYauvpmoBTKr3nEA=
Message-ID: <dfbdf8575aa358864a99a9e51ccd885a943f27e5.camel@HansenPartnership.com>
Subject: Re: QUEMU and TPM2 device emulation
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Roberts, William C" <william.c.roberts@intel.com>,
        "tpm2@lists.01.org" <tpm2@lists.01.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Date:   Wed, 14 Oct 2020 09:32:08 -0700
In-Reply-To: <SN6PR11MB34372D6EA769E056632095CFB8050@SN6PR11MB3437.namprd11.prod.outlook.com>
References: <SN6PR11MB34372D6EA769E056632095CFB8050@SN6PR11MB3437.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-10-14 at 15:27 +0000, Roberts, William C wrote:
> Has anyone ever setup a QUEMU instance with a virtualized TPM? I need
> to try and replicate an issue with the in-kernel Resource manager. My
> goal is to use the integrated QUEMU support
> To bring up an emulated TPM device and it's associated RM node @
> /dev/tpmrm0.
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
> I have a few questions around this that I cannot seem to dig up any
> documentation on:
> 1. How to specify TPM2.0 device? The project 
> https://github.com/stefanberger/swtpm/wiki seems to indicate it would
> be supported.

All QEMU is doing is passing through a socket to something as a TPM. 
Either TPM 1.2 or 2.0 could be on the end of that socket, so what
really matters is what's at the other end of /tmp/mytpm1/swtpm-sock. 
If you change that to be TPM 2.0 then QEMU will see it.

James


