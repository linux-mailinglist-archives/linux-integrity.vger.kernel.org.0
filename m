Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15828618B59
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Nov 2022 23:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiKCWY0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Nov 2022 18:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiKCWYY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Nov 2022 18:24:24 -0400
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88B85617D
        for <linux-integrity@vger.kernel.org>; Thu,  3 Nov 2022 15:24:22 -0700 (PDT)
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id C107372C983;
        Fri,  4 Nov 2022 01:24:21 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 740004A472A;
        Fri,  4 Nov 2022 01:24:21 +0300 (MSK)
Date:   Fri, 4 Nov 2022 01:24:21 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Stefan Berger <stefanb@linux.ibm.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH ima-evm-utils v5 02/17] log and reset 'errno' after
 failure to open non-critical files
Message-ID: <20221103222421.fhtdymd2spiejvuh@altlinux.org>
References: <20221103183904.103562-1-zohar@linux.ibm.com>
 <20221103183904.103562-3-zohar@linux.ibm.com>
 <20221103220531.ok6bwddhxmq6oxky@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20221103220531.ok6bwddhxmq6oxky@altlinux.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Nov 04, 2022 at 01:05:31AM +0300, Vitaly Chikunov wrote:
> Mimi,
> 
> On Thu, Nov 03, 2022 at 02:38:49PM -0400, Mimi Zohar wrote:
> > Define a log_errno_reset macro to emit the errno string at or near the
> > time of error, similar to the existing log_errno macro, but also reset
> > errno to avoid dangling or duplicate errno messages on exit.
> > 
> > The initial usage is for non-critical file open failures.
> > 
> > Suggested-by: Vitaly Chikunov <vt@altlinux.org>
> > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > ---
> >  src/evmctl.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Vitaly Chikunov <vt@altlinux.org>
> 
> > 
> > diff --git a/src/evmctl.c b/src/evmctl.c
> > index 0412bc0ac2b0..54123bf20f03 100644
> > --- a/src/evmctl.c
> > +++ b/src/evmctl.c
> > @@ -2055,7 +2060,6 @@ static int ima_measurement(const char *file)
> >  	int err_padded = -1;
> >  	int err = -1;
> >  
> > -	errno = 0;
> >  	memset(zero, 0, MAX_DIGEST_SIZE);
> >  
> >  	pseudo_padded_banks = init_tpm_banks(&num_banks);
> > @@ -2072,6 +2076,8 @@ static int ima_measurement(const char *file)
> >  		init_public_keys(imaevm_params.keyfile);
> >  	else				/* assume read pubkey from x509 cert */
> >  		init_public_keys("/etc/keys/x509_evm.der");
> > +	if (errno)
> > +		log_errno_reset(LOG_DEBUG, "Failed to initialize public keys");
> 
> Library prints appropriate error messages, so this is perhaps just to
> clear errno. But it's not necessarily completely failed, but maybe
> failure in one key. So I would say "Failure in initializing public
> keys" to be precise.
> 
> ps.
> 
> BTW, init_public_keys API call cannot return error except by errno,
> but it does not set it consistently so some errors may be missed.
> 
> init_public_keys loops calling read_pub_pkey
> 
>                 entry->key = read_pub_pkey(keyfile, 1);
>                 if (!entry->key) {
>                         free(entry);
>                         continue;
>                 }
> 
> and read_pub_pkey have such code:
> 
>         if (!keyfile)
>                 return NULL;
> 
> In that case some key is not read but we don't get any error notification.
> 
> I think it's legal, by the right of being library, so set `errno =
> EINVAL` there somewhere. But, I'm not sure where - as we should not
> clobber existing errno values. Perhaps, errno setting should be added to
> libimaevm consistently to all functions, but this is huge task, so I
> would not suggest to do it now. Just suggestion for the future
> developments, maybe.

Just to compare with other library - libtracefs sets errno _sometimes_,
for example, their API call tracefs_dynevent_get have:

  struct tracefs_dynevent *
  tracefs_dynevent_get(enum tracefs_dynevent_type type, const char *system,
		       const char *event)
  {
  ...
	  if (!event) {
		  errno = -EINVAL;
		  return NULL;
	  }

	  count = get_all_dynevents(type, system, &events);
	  if (count <= 0)
		  return NULL;
  ...

So it sets errno sometimes, but not always, which I am not sure is correct
approach. This needs to be discussed more with library experts.

Thanks,

