Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923DF246225
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Aug 2020 11:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgHQJLk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Aug 2020 05:11:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:50312 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgHQJLk (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Aug 2020 05:11:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3D27EB692;
        Mon, 17 Aug 2020 09:12:04 +0000 (UTC)
Date:   Mon, 17 Aug 2020 11:11:37 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: Re: [ima-evm-utils][PATCH] Install the swtpm package, if available
Message-ID: <20200817091137.GA26170@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200816193627.73935-1-zohar@linux.ibm.com>
 <d631253ca491bcdfe48ebd68a5acf7f26d75fb22.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d631253ca491bcdfe48ebd68a5acf7f26d75fb22.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> Note: Some travis/<distro>.sh scripts are links to other scripts.
> Don't fail the build of the linked script if the swtpm package doesn't
> exist.
...
> --- a/travis/fedora.sh
> +++ b/travis/fedora.sh
> @@ -41,6 +41,7 @@ yum -y install \
>         which
> 
>  yum -y install docbook5-style-xsl || true
> +yum -y install swtpm || true
Yes, that's probably the best way how to solve.
Sometimes I also passed $INSTALL to the script and had if clause.


> On Sun, 2020-08-16 at 15:36 -0400, Mimi Zohar wrote:
> >  # Only stop this test's software TPM.  Preferred method: "tsstpmcmd -stop"
> > @@ -48,22 +52,36 @@ cleanup() {

> >  # Try to start a software TPM if needed.
> >  swtpm_start() {
> > -       local swtpm
> > +       local swtpm swtpm1

> >         swtpm="$(which tpm_server)"
> > -       if [ -z "${swtpm}" ]; then
> > -               echo "${CYAN}SKIP: Softare TPM (tpm_server) not found${NORM}"
> > +       swtpm1="$(which swtpm)"
> > +       if [ -z "${swtpm}" ] && [ -z "${swptm1}" ]; then

> Need to fix "swptm1" typo.
+1

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Also, not related to this commit:
* add pgrep and pkill to _require (fix of a different commit)
* add magic constant 114 to exit codes (in tests/functions.sh)
* I'd like reuse exit codes in build.sh. I could source tests/functions.sh (they
look to be general enough, just I didn't like script in root directory depending
on it, as it's general enough for build without testing) have these constants in
separate file.

Kind regards,
Petr
