Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 422EA21A44
	for <lists+linux-integrity@lfdr.de>; Fri, 17 May 2019 17:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbfEQPFA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 May 2019 11:05:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:34936 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728935AbfEQPFA (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 May 2019 11:05:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 772F3AF3A;
        Fri, 17 May 2019 15:04:59 +0000 (UTC)
Date:   Fri, 17 May 2019 17:04:56 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Nayna <nayna@linux.vnet.ibm.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        ltp@lists.linux.it
Subject: Re: [PATCH] ima: skip verifying TPM 2.0 PCR values
Message-ID: <20190517150456.GA11796@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1558041162.3971.2.camel@linux.ibm.com>
 <fccc3abd-f3ce-fdb1-55d7-c18ce116446c@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fccc3abd-f3ce-fdb1-55d7-c18ce116446c@linux.vnet.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Nayna,

...
> > +	local tpm_description="/sys/class/tpm/tpm0/device/description"
...

> I do not see a "description" file on either my PowerPC or x86 systems with
> TPM 2.0.  Perhaps instead of testing for the "description" file, if the
> "pcrs" file is not found, emit a more verbose informational message, for eg.
> - "pcrs file is not found - either you are running a TPM 2.0, or having
> sysfs failed to show pcrs for TPM 1.2"
Some people are using /sys/class/tpm/tpm0/device/description [1] for testing TPM
version. From the discussion on [1] I also got an expression that the file is
not always presented. If there is really no reliable way to detect TPM version
from sysfs (huh!) your approach would make sense for me.

> Thanks & Regards,
>       - Nayna

Kind regards,
Petr

[1] https://github.com/tpm2-software/tpm2-tools/issues/604
