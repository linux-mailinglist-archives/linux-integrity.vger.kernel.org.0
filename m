Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72DE028CD7D
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Oct 2020 14:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbgJMMAP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Oct 2020 08:00:15 -0400
Received: from mga02.intel.com ([134.134.136.20]:14109 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728481AbgJML72 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Oct 2020 07:59:28 -0400
IronPort-SDR: PpIHyXp+/qzvkeT84o78c5M1SCrAluqNEqAKGYMU16OHAMPDZR2RrZ0Foa9+rfq/xmFiWZbcgk
 hp7TeW7m+BVw==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="152827280"
X-IronPort-AV: E=Sophos;i="5.77,370,1596524400"; 
   d="scan'208";a="152827280"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 04:59:26 -0700
IronPort-SDR: +CYsTsmY3BO6jXl4YwQVqxzg7Mj0arD3Ox/RU3pLCDxWtYp6149sOP9VzZdMh63RZ3hO4rpB44
 8ZJkg+6UaVKg==
X-IronPort-AV: E=Sophos;i="5.77,370,1596524400"; 
   d="scan'208";a="530368699"
Received: from sobrien1-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.35.215])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 04:59:21 -0700
Date:   Tue, 13 Oct 2020 14:59:18 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Markus Wamser <Markus.Wamser@mixed-mode.de>,
        Luke Hinds <lhinds@redhat.com>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v7 1/4] KEYS: trusted: Add generic trusted keys framework
Message-ID: <20201013115918.GB141833@linux.intel.com>
References: <1602065268-26017-1-git-send-email-sumit.garg@linaro.org>
 <1602065268-26017-2-git-send-email-sumit.garg@linaro.org>
 <20201013014304.GC41176@linux.intel.com>
 <CAFA6WYN1n_x1wUefXEf-4Y+bUZybNAMeD9cirvz4WQnK2E7djw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYN1n_x1wUefXEf-4Y+bUZybNAMeD9cirvz4WQnK2E7djw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Oct 13, 2020 at 04:23:36PM +0530, Sumit Garg wrote:
> On Tue, 13 Oct 2020 at 07:13, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Wed, Oct 07, 2020 at 03:37:45PM +0530, Sumit Garg wrote:
> > > Current trusted keys framework is tightly coupled to use TPM device as
> > > an underlying implementation which makes it difficult for implementations
> > > like Trusted Execution Environment (TEE) etc. to provide trusted keys
> > > support in case platform doesn't posses a TPM device.
> > >
> > > Add a generic trusted keys framework where underlying implementations
> > > can be easily plugged in. Create struct trusted_key_ops to achieve this,
> > > which contains necessary functions of a backend.
> > >
> > > Also, add a module parameter in order to select a particular trust source
> > > in case a platform support multiple trust sources.
> > >
> > > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> >
> > This is exactly kind of place where I think static_call() should be
> > taken into use, which is a v5.10 feature [1]. For background and
> > context, I'd read [2].
> 
> This looks like an interesting feature. But I am not sure about the
> real benefits that it will provide in case of trusted keys. If we are
> looking at it performance wise then I think the gain will be
> negligible when compared with slow TPM communication interface (eg.
> SPI, I2C) or when compared with context switching involved in TEE.
> 
> Also, it requires arch specific support too which currently seems to
> be limited to x86 only.

Please, do not purposely add indirect calls, unless you  must. Here it's
not a must.

static_call() is the correct kernel idiom to define what you are doing
in this patch. arch's will catch up.

> > The other thing that I see that does not make much else than additional
> > complexity, is trusted_tpm.ko. We can do with one trusted.ko.
> >
> 
> Current implementation only builds a single trusted.ko module. There
> isn't any trusted_tpm.ko.
> -Sumit

You're right, I'm sorry. I misread this:

-static void __exit cleanup_trusted(void)
+static void __exit exit_tpm_trusted(void)
 {
 	if (chip) {
 		put_device(&chip->dev);
@@ -1257,7 +1029,11 @@  static void __exit cleanup_trusted(void)
 	}
 }
 
-late_initcall(init_trusted);
-module_exit(cleanup_trusted);
-
-MODULE_LICENSE("GPL");
+struct trusted_key_ops tpm_trusted_key_ops = {
+	.migratable = 1, /* migratable by default */
+	.init = init_tpm_trusted,
+	.seal = tpm_trusted_seal,
+	.unseal = tpm_trusted_unseal,
+	.get_random = tpm_trusted_get_random,
+	.exit = exit_tpm_trusted,
+};

Please remove "__init" and  "__exit" for the functions as they are used
as fields as members of a struct that has neither life span. That messed
up my head.

Please use a single convention for the function names. It would
be optimal to prefix with the subsystem name because that makes easier
to use tracing tools:  trusted_tpm_<callback name> would work.

/Jarkko
