Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 817B9A083E
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Aug 2019 19:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfH1RPs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Aug 2019 13:15:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:43028 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726315AbfH1RPr (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Aug 2019 13:15:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E05A7AE7F;
        Wed, 28 Aug 2019 17:15:46 +0000 (UTC)
Date:   Wed, 28 Aug 2019 19:15:44 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Piotr =?iso-8859-2?Q?Kr=F3l?= <piotr.krol@3mdeb.com>,
        linux-integrity@vger.kernel.org, Ken Goldman <kgold@linux.ibm.com>
Subject: Re: TPM 2.0 Linux sysfs interface
Message-ID: <20190828171544.GA20276@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <3329329f-4bf4-b8cd-dee8-eb36e513c728@3mdeb.com>
 <1567004581.6115.33.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1567004581.6115.33.camel@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi, Piotr,

> [Cc'ing Petr Vorel]
Thanks Mimi.

> Hi Piotr,

> On Tue, 2019-08-27 at 01:24 +0200, Piotr Król wrote:
> > Hi all,
> > I'm moving here discussion that I started with Jarkko and Peter on LinkedIn.

> > I'm preparing for 2 talks during LPC 2019 System Boot MC and one of it
> > will discuss TPM 2.0 sysfs support [1]. This was discussed couple times
> > [2] and explained why it is not done yet by Jarkko [3].

> > Why is this important?
> > - there seem to be no default method to distinguish if we dealing with
> > TPM 1.2 or 2.0 in the system. 

> Agreed, this affects both the LTP IMA tests and ima-evm-utils package,
> which need to support both TPM 1.2 and 2.0 for the forseeable future.
> The LTP IMA tests check different sysfs files to determine if it is
> TPM 1.2 or TPM 2.0 (eg. /sys/class/tpm/tpm0/device/description,
> /sys/class/tpm/tpm0/device/pcrs and /sys/class/misc/tpm0/device/pcrs),
> but the "description" file is not defined by all TPM 2.0's.  It
> shouldn't be that difficult to define a single common sysfs file.
+1. I'd appreciate have simple /sys/class/tpm/tpm0/version file.

> > - distros use various tools to detect TPM based on sysfs (e.g. Qubes OS
> > scripts)
> > - tpm2-software has ton of dependencies, is not easy to build,
> > development is way faster then distros can manage and packages are often
> > out of date or even broken, so using it can be troublesome
> > - for deeply embedded systems adding fully-featured tpm2-software
> > doesn't make sense e.g. if we just need PCRs values

> > Jarkko comment on detecting 1.2 vs 2.0:
> > "Detecting TPM 2.0 is dead easy: send any idempotent TPM 2.0 command and
> > check if the tag field matches 0x8002 (TPM_NO_SESSIONS). The sysfs
> > features for TPM 1.2 are for the large part useless as you can get the
> > same data by using TPM commands."

> > Ok, but doesn't this mean I need TPM2 software stack?
> > Peter mentioned that it can be tricky to invoke such tools early in boot
> > process.

> ima-evm-utils now uses the TPM 2.0 TSS[1] to read the PCRs.  I haven't
> tried using it during boot, but I don't forsee a problem. I guess it
> depends on how early you need to read the PCRs.
I'd prefer using library instead of tsspcrread binary ("tsspcrread -halg sha1
-ha %d -ns 2> /dev/null"; better link to shared lib than depend on presence of
binary), but looking into ibmtpm20tss-tss git the functionality is really
provided only in tsspcrread (utils/pcrread.c).
I'd expect it'd be in libibmtss.so.0 or libibmtssutils.so.0, but it's not :(.

> Mimi

> [1] https://git.code.sf.net/p/ibmtpm20tss/tss

Kind regards,
Petr
