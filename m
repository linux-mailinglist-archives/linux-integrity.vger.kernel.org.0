Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEBB01D41C9
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2020 01:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgENXnZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 May 2020 19:43:25 -0400
Received: from mga01.intel.com ([192.55.52.88]:36669 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728415AbgENXnZ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 May 2020 19:43:25 -0400
IronPort-SDR: dE/OXNRPB65SD0Pv1u1815GybNs5OFpSgSeW4coafxYAUNLpAO/BXsUBUkoc/bVJYED4clYbb2
 onOqAxQhm6wQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 16:43:24 -0700
IronPort-SDR: 0PcKf5kROprlU7FvR2CjmctlO7VJLKQn4o6TWazGRw3DBXAE4dQdy6dZGq6zvM7ICAe8BiPuVr
 5UquiIXhVxpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,392,1583222400"; 
   d="scan'208";a="410262240"
Received: from ashadrin-mobl1.ccr.corp.intel.com ([10.249.38.112])
  by orsmga004.jf.intel.com with ESMTP; 14 May 2020 16:43:17 -0700
Message-ID: <b59e8ef4070f1aba31b4351910d6e819802eb551.camel@linux.intel.com>
Subject: Re: [PATCH v4 2/4] KEYS: trusted: Introduce TEE based Trusted Keys
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>, dhowells@redhat.com,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Markus Wamser <Markus.Wamser@mixed-mode.de>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>
Date:   Fri, 15 May 2020 02:43:04 +0300
In-Reply-To: <CAFA6WYPr1iL-uJgSRu_61uv=2DhuEdDVdQLDuyPEOOK2jEgvyg@mail.gmail.com>
References: <1588758017-30426-1-git-send-email-sumit.garg@linaro.org>
         <1588758017-30426-3-git-send-email-sumit.garg@linaro.org>
         <ef2093f96eae7e9e6785f2c0ad00604d8adfd3be.camel@linux.intel.com>
         <CAFA6WYPr1iL-uJgSRu_61uv=2DhuEdDVdQLDuyPEOOK2jEgvyg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-05-14 at 12:57 +0530, Sumit Garg wrote:
> On Thu, 14 May 2020 at 05:58, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> > On Wed, 2020-05-06 at 15:10 +0530, Sumit Garg wrote:
> > > Add support for TEE based trusted keys where TEE provides the functionality
> > > to seal and unseal trusted keys using hardware unique key.
> > > 
> > > Refer to Documentation/tee.txt for detailed information about TEE.
> > > 
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > 
> > The implementation looks solid but how or who could possibly test this?
> > 
> > I do posses (personally, not from employer) bunch of ARM boards but my
> > TZ knowledge is somewhat limited (e.g. how can I get something running
> > in TZ).
> > 
> 
> Although, it should be fairly easy to test this implementation on an
> ARM board which supports OP-TEE. But since you are new to ARM
> TrustZone world, I would suggest you get used to OP-TEE on Qemu based
> setup. You could find pretty good documentation for this here [1] but
> for simplicity let me document steps here to test this trusted keys
> feature from scratch:
> 
> # Install prerequisites as mentioned here [2]
> 
> # Get the source code
> $ mkdir -p <optee-project>
> $ cd <optee-project>
> $ repo init -u https://github.com/OP-TEE/manifest.git -m qemu_v8.xml
> $ repo sync -j4 --no-clone-bundle
> 
> # Get the toolchain
> $ cd <optee-project>/build
> $ make -j2 toolchains
> 
> # As trusted keys work is based on latest tpmdd/master, so we can
> change Linux base as follows:
> $ cd <optee-project>/linux
> $ git remote add tpmdd git://git.infradead.org/users/jjs/linux-tpmdd.git
> $ git pull tpmdd
> $ git checkout -b tpmdd-master remotes/tpmdd/master
> # Cherry-pick and apply TEE features patch-set from this PR[3]
> # Apply this Linux trusted keys patch-set.
> 
> # Now move on to build the source code
> $ cd <optee-project>/build
> # Apply attached "keyctl_change" patch
> $ patch -p1 < keyctl_change
> $ make -j`nproc`
> CFG_IN_TREE_EARLY_TAS=trusted_keys/f04a0fe7-1f5d-4b9b-abf7-619b85b4ce8c
> 
> # Run QEMU setup
> $ make run-only
> # Type "c" on QEMU console to continue boot
> 
> # Now there should be two virtual consoles up, one for OP-TEE and
> other for Linux
> # On Linux console, you can play with "keyctl" utility to have trusted
> and encrypted keys based on TEE.
> 
> Do let me know in case you are stuck while following the above steps.
> 
> [1] https://optee.readthedocs.io/en/latest/building/devices/qemu.html#qemu-v8
> [2] https://optee.readthedocs.io/en/latest/building/prerequisites.html#prerequisites
> [3] https://lkml.org/lkml/2020/5/4/1062
> 
> -Sumit

Thanks I'll try this out as soon as the v5.8 release hassle is over!

/Jarkko

