Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8212849FA
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Oct 2020 12:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgJFKBf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Oct 2020 06:01:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:43962 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgJFKBd (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Oct 2020 06:01:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 00B15B215;
        Tue,  6 Oct 2020 10:01:31 +0000 (UTC)
Date:   Tue, 6 Oct 2020 12:01:30 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3 0/4] TPM 2.0 fixes in IMA tests
Message-ID: <20201006100130.GA14868@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200929165021.11731-1-pvorel@suse.cz>
 <20200929231118.GA805493@linux.intel.com>
 <20200930055314.GA21664@dell5510>
 <20200930115939.GB7612@linux.intel.com>
 <20201001120125.GE32109@dell5510>
 <20201001183104.GA15664@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001183104.GA15664@linux.intel.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jarkko,

can rely on /dev/tpm0 and /dev/tpmrm0 for TPM detection?
i.e.:
/dev/tpmrm0 => TPM 2.0
/dev/tpm0 => both TPM 1.2 or 2.0
none of them => No TPM device

I'm trying to get reliably TPM version (1, 2 or no TPM) for various kernel
versions (including very old ones like 3.x):

So far I have:

cat /sys/class/tpm/tpm0/tpm_version_major

[ -f /sys/class/tpm/tpm0/device/caps -o -f /sys/class/misc/tpm0/device/caps ] => TPM 1.2

[ ! -d /sys/class/tpm/tpm0/ -a ! -d /sys/class/misc/tpm0/ ] => no TPM

Then I grep
dmesg | grep -q 'activating TPM-bypass' => no TPM
dmesg | grep -q '1\.2 TPM (device-id' => TPM 1.2
dmesg | grep -q '2\.0 TPM (device-id' => TPM 2.0

But according to Mimi there are still some TPM 2.0 devices which does not export
sysfs files.

And I'd prefer avoid using dmesg (not on some embedded targets and not sure if
reliable for all TPM devices).

If I understand James's commit fdc915f7f719 ("tpm: expose spaces via a device link /dev/tpmrm<n>")
from v4.12-rc1 correctly /dev/tpmrm0 is really for TPM 2.0. But how to detect it
for v4.0 - v4.11 when /sys/class/tpm detection fails?
I haven't found anything obvious in drivers/char/tpm/tpm2-cmd.c from v4.0.

Thanks for info.

Kind regards,
Petr
