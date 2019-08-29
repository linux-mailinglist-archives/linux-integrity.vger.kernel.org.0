Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1075A12A9
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Aug 2019 09:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfH2Hct (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Aug 2019 03:32:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:40762 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726075AbfH2Hct (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Aug 2019 03:32:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 15E90B03B;
        Thu, 29 Aug 2019 07:32:48 +0000 (UTC)
Date:   Thu, 29 Aug 2019 09:32:46 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Piotr =?iso-8859-2?Q?Kr=F3l?= <piotr.krol@3mdeb.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        Ken Goldman <kgold@linux.ibm.com>
Subject: Re: TPM 2.0 Linux sysfs interface
Message-ID: <20190829073246.GA28007@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <3329329f-4bf4-b8cd-dee8-eb36e513c728@3mdeb.com>
 <1567004581.6115.33.camel@linux.ibm.com>
 <e8b2496b-7d53-f9d7-f2b7-779b87a4132a@3mdeb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8b2496b-7d53-f9d7-f2b7-779b87a4132a@3mdeb.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Piotr,

...
> >> Why is this important?
> >> - there seem to be no default method to distinguish if we dealing with
> >> TPM 1.2 or 2.0 in the system. 

> > Agreed, this affects both the LTP IMA tests and ima-evm-utils package,
> > which need to support both TPM 1.2 and 2.0 for the forseeable future.
> > The LTP IMA tests check different sysfs files to determine if it is
> > TPM 1.2 or TPM 2.0 (eg. /sys/class/tpm/tpm0/device/description,
> > /sys/class/tpm/tpm0/device/pcrs and /sys/class/misc/tpm0/device/pcrs),
> > but the "description" file is not defined by all TPM 2.0's.  It
> > shouldn't be that difficult to define a single common sysfs file.

> Thank you for that use cases I will point to that during LPC discussion.
Thanks.

> Jarkko said that what he potential can cope with is:
> /sys/class/tpm/tpm0/protocol_major

> But maybe version file is also good to go, depends what it should return
> and how that information should be obtained for various TPM versions.

...
> I'm still looking into use case to provide correct examples. I'm
> thinking about edge computing devices e.g. Azure IoT Edge, AWS IoT and
> Greengrass and its ability to perform trusted boot, but do not have
> something well exercised yet.

> Definitely there is automatic validation of hardware modules which is
> time sensitive and faster access to basic functions verification, then
> more savings to manufacturer.

> For research purposes I tried couple queries on GitHub to check who use
> pcrs throughs sysfs [1][2]. Among others you can find CoreOS, Android,
> already mentioned LTP, some google projects. Quite a lot of user space
> code to be fixed. Maybe if I will have enough time I will prepare
> statistics about usage of given endpoints to quantify how those affect
> system.
BTW: codesearch.debian.net shows nothing using pcrs in whole
Debian distro [3] [4], nothing is on gitlab either.

> [1]
> https://github.com/search?q=%22%2Fsys%2Fclass%2Ftpm%2Ftpm0%2Fdevice%2Fpcrs%22&type=Code
> [2]
> https://github.com/search?q=%22%2Fsys%2Fclass%2Fmisc%2Ftpm0%2Fdevice%2Fpcrs%22&type=Code
[3] https://codesearch.debian.net/search?q=%2Fsys%2Fclass%2Ftpm%2Ftpm0%2Fdevice%2Fpcrs&literal=1
[4] https://codesearch.debian.net/search?q=%2Fsys%2Fclass%2Fmisc%2Ftpm0%2Fdevice%2Fpcrs&literal=1

Kind regards,
Petr
