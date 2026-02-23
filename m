Return-Path: <linux-integrity+bounces-8541-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4O+5Ao6fnGnPJgQAu9opvQ
	(envelope-from <linux-integrity+bounces-8541-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Feb 2026 19:42:22 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E99417BA37
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Feb 2026 19:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 11C1D3011682
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Feb 2026 18:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9BD368268;
	Mon, 23 Feb 2026 18:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DK8QjHK0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559FD30DD22;
	Mon, 23 Feb 2026 18:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872132; cv=none; b=FUxaZkREEU01lWl2fCAHhx6GkWnUI+l9yvzFMxnH4UvKtZsQh/YX9o3PsT0QieSkI92rzdFZ8ox2ae+ZRXqBD8GGFVROBhpuEQYF25L0m1/XG3YZUzLyRZYUD7wN7v6+hbMlFHsAZBmc7YfFexNPIN99drlfXb+7wO9RoixDCt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872132; c=relaxed/simple;
	bh=rCHmm/zok/ZHYhXcvb3BF39F3olQG5YTVbanELl+Bew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7l8HQrLPMKg39v9o714OkOzuveT/8XrREaQfH4Jc/9xXG6W+Zgo2npQdiTu/9JQ5K8bmlMottfT389CGc0Mnyi3WbBX58yKcEZfPjky0Kp1sKkzo7KzyAGYhQYDVxp5bzK96sy887D2w1+FkyAF/d3VjtOgVisP1d9ie8LFdMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DK8QjHK0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709E6C116C6;
	Mon, 23 Feb 2026 18:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771872132;
	bh=rCHmm/zok/ZHYhXcvb3BF39F3olQG5YTVbanELl+Bew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DK8QjHK0ArTdo0esgtiCQsgDKxZaepF19ebhrRv6gpMnFJmkZCUOY/vBwLWk4S0Hr
	 jeE98gLGcP4Ym2xfc5E0GjYCF7QA4hl2VSMouUR0B0gX7MBSqWFfe3Dv5RT/06FG7k
	 pOYexreZSggTeyisgt2W7jyCfdEf0q8MOj8/XK/IX7x2+LGL00UVWk7MhGMWy2u/VD
	 FKEVZdxFzPp3vAbavWlo04c/BnGbugnbetDM37BSzKhHz6mH4PUbnePbGYFQjNZLvK
	 Tvsoyfb0adJkDjOy4pnS6Uq/oZLqlCqjKueb+LTn1Z9620sBfpD62Ed4clE8B5gBoZ
	 8aXhrmCuJp56w==
Date: Mon, 23 Feb 2026 19:41:52 +0100
From: Nicolas Schier <nsc@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Fabian =?iso-8859-1?Q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>,
	Arnout Engelen <arnout@bzzt.net>,
	Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>,
	Christian Heusel <christian@heusel.eu>,
	=?iso-8859-1?Q?C=E2ju?= Mihai-Drosi <mcaju95@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 15/17] module: Introduce hash-based integrity checking
Message-ID: <aZyfcDCWOBJJztQ2@levanger>
Mail-Followup-To: Nicolas Schier <nsc@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Fabian =?iso-8859-1?Q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>,
	Arnout Engelen <arnout@bzzt.net>,
	Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>,
	Christian Heusel <christian@heusel.eu>,
	=?iso-8859-1?Q?C=E2ju?= Mihai-Drosi <mcaju95@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-15-0b932db9b56b@weissschuh.net>
 <aZol1Rsa2tX-WNaZ@derry.ads.avm.de>
 <0d70db8d-702b-46ec-a010-298fe6515aab@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d70db8d-702b-46ec-a010-298fe6515aab@t-8ch.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8541-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[39];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,arndb.de,suse.com,google.com,samsung.com,paul-moore.com,namei.org,hallyn.com,lwn.net,linux.ibm.com,ellerman.id.au,gmail.com,huawei.com,oracle.com,atomlin.com,oss.cyber.gouv.fr,proxmox.com,bzzt.net,mapreri.org,archlinux.org,heusel.eu,linutronix.de,vger.kernel.org,lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nsc@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,stackexchange.com:url,link-vmlinux.sh:url,weissschuh.net:email,breakpoint.cc:email,espacenet.com:url]
X-Rspamd-Queue-Id: 7E99417BA37
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 08:53:29AM +0100, Thomas Weiﬂschuh wrote:
> On 2026-02-21 22:38:29+0100, Nicolas Schier wrote:
> > On Tue, Jan 13, 2026 at 01:28:59PM +0100, Thomas Weiﬂschuh wrote:
> > > The current signature-based module integrity checking has some drawbacks
> > > in combination with reproducible builds. Either the module signing key
> > > is generated at build time, which makes the build unreproducible, or a
> > > static signing key is used, which precludes rebuilds by third parties
> > > and makes the whole build and packaging process much more complicated.
> > > 
> > > The goal is to reach bit-for-bit reproducibility. Excluding certain
> > > parts of the build output from the reproducibility analysis would be
> > > error-prone and force each downstream consumer to introduce new tooling.
> > > 
> > > Introduce a new mechanism to ensure only well-known modules are loaded
> > > by embedding a merkle tree root of all modules built as part of the full
> > > kernel build into vmlinux.
> > > 
> > > Non-builtin modules can be validated as before through signatures.
> > > 
> > > Normally the .ko module files depend on a fully built vmlinux to be
> > > available for modpost validation and BTF generation. With
> > > CONFIG_MODULE_HASHES, vmlinux now depends on the modules
> > > to build a merkle tree. This introduces a dependency cycle which is
> > > impossible to satisfy. Work around this by building the modules during
> > > link-vmlinux.sh, after vmlinux is complete enough for modpost and BTF
> > > but before the final module hashes are
> > > 
> > > The PKCS7 format which is used for regular module signatures can not
> > > represent Merkle proofs, so a new kind of module signature is
> > > introduced. As this signature type is only ever used for builtin
> > > modules, no compatibility issues can arise.
> > > 
> > > Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> > > ---
> > >  .gitignore                                   |   1 +
> > >  Documentation/kbuild/reproducible-builds.rst |   5 +-
> > >  Makefile                                     |   8 +-
> > >  include/asm-generic/vmlinux.lds.h            |  11 +
> > >  include/linux/module_hashes.h                |  25 ++
> > >  include/linux/module_signature.h             |   1 +
> > >  kernel/module/Kconfig                        |  21 +-
> > >  kernel/module/Makefile                       |   1 +
> > >  kernel/module/hashes.c                       |  92 ++++++
> > >  kernel/module/hashes_root.c                  |   6 +
> > >  kernel/module/internal.h                     |   1 +
> > >  kernel/module/main.c                         |   4 +-
> > >  scripts/.gitignore                           |   1 +
> > >  scripts/Makefile                             |   3 +
> > >  scripts/Makefile.modfinal                    |  11 +
> > >  scripts/Makefile.modinst                     |  13 +
> > >  scripts/Makefile.vmlinux                     |   5 +
> > >  scripts/link-vmlinux.sh                      |  14 +-
> > >  scripts/modules-merkle-tree.c                | 467 +++++++++++++++++++++++++++
> > >  security/lockdown/Kconfig                    |   2 +-
> > >  20 files changed, 685 insertions(+), 7 deletions(-)
> > > 
> > [...]
> > 
> > > diff --git a/kernel/module/hashes_root.c b/kernel/module/hashes_root.c
> > > new file mode 100644
> > > index 000000000000..1abfcd3aa679
> > > --- /dev/null
> > > +++ b/kernel/module/hashes_root.c
> > > @@ -0,0 +1,6 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +
> > > +#include <linux/module_hashes.h>
> > > +
> > > +/* Blank dummy data. Will be overridden by link-vmlinux.sh */
> > > +const struct module_hashes_root module_hashes_root __module_hashes_section = {};
> > > diff --git a/kernel/module/internal.h b/kernel/module/internal.h
> > > index e2d49122c2a1..e22837d3ac76 100644
> > > --- a/kernel/module/internal.h
> > > +++ b/kernel/module/internal.h
> > > @@ -338,6 +338,7 @@ void module_mark_ro_after_init(const Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
> > >  			       const char *secstrings);
> > >  
> > >  int module_sig_check(struct load_info *info, const u8 *sig, size_t sig_len);
> > > +int module_hash_check(struct load_info *info, const u8 *sig, size_t sig_len);
> > >  
> > >  #ifdef CONFIG_DEBUG_KMEMLEAK
> > >  void kmemleak_load_module(const struct module *mod, const struct load_info *info);
> > > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > > index 2a28a0ece809..fa30b6387936 100644
> > > --- a/kernel/module/main.c
> > > +++ b/kernel/module/main.c
> > > @@ -3362,8 +3362,10 @@ static int module_integrity_check(struct load_info *info, int flags)
> > >  
> > >  	if (IS_ENABLED(CONFIG_MODULE_SIG) && sig_type == PKEY_ID_PKCS7) {
> > >  		err = module_sig_check(info, sig, sig_len);
> > > +	} else if (IS_ENABLED(CONFIG_MODULE_HASHES) && sig_type == PKEY_ID_MERKLE) {
> > > +		err = module_hash_check(info, sig, sig_len);
> > >  	} else {
> > > -		pr_err("module: not signed with expected PKCS#7 message\n");
> > > +		pr_err("module: not signed with signature mechanism\n");
> > >  		err = -ENOPKG;
> > 
> > To prevent others from running into the same issue:
> > 
> > My first test got stuck here, as I tested with virtme-ng, which symlinks
> > modules from build tree to /lib/modules/$(uname -r)/..., resulting in
> > 
> >     [   15.956855] module: not signed with signature mechanism
> >     modprobe: ERROR: could not insert 'efivarfs': Package not installed
> > 
> > As the modules_install step was missing, modules were not being signed.
> 
> Currently the signing is deferred to installation time to keep in sync
> with regular module signing and to keep the logic simpler by not having
> to gracefully handle previously-signed files.
> But this could be changed.

I did not want to suggest changing the behaviour, that would make things
more complicated to prevent needless rebuilds.  I just wanted to mention
it here to prevent others from burning time.

> > [...]
> > > diff --git a/scripts/modules-merkle-tree.c b/scripts/modules-merkle-tree.c
> > > new file mode 100644
> > > index 000000000000..a6ec0e21213b
> > > --- /dev/null
> > > +++ b/scripts/modules-merkle-tree.c
> > > @@ -0,0 +1,467 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +/*
> > > + * Compute hashes for modules files and build a merkle tree.
> > > + *
> > > + * Copyright (C) 2025 Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
> > > + * Copyright (C) 2025 Thomas Weiﬂschuh <linux@weissschuh.net>
> > > + *
> > > + */
> > > +#define _GNU_SOURCE 1
> > > +#include <arpa/inet.h>
> > > +#include <err.h>
> > > +#include <unistd.h>
> > > +#include <fcntl.h>
> > > +#include <stdarg.h>
> > > +#include <stdio.h>
> > > +#include <string.h>
> > > +#include <stdbool.h>
> > > +#include <stdlib.h>
> > > +
> > > +#include <sys/stat.h>
> > > +#include <sys/mman.h>
> > > +
> > > +#include <openssl/evp.h>
> > > +#include <openssl/err.h>
> > > +
> > > +#include "ssl-common.h"
> > > +
> > > +static int hash_size;
> > > +static EVP_MD_CTX *ctx;
> > > +
> > > +struct module_signature {
> > > +	uint8_t		algo;		/* Public-key crypto algorithm [0] */
> > > +	uint8_t		hash;		/* Digest algorithm [0] */
> > > +	uint8_t		id_type;	/* Key identifier type [PKEY_ID_PKCS7] */
> > > +	uint8_t		signer_len;	/* Length of signer's name [0] */
> > > +	uint8_t		key_id_len;	/* Length of key identifier [0] */
> > > +	uint8_t		__pad[3];
> > > +	uint32_t	sig_len;	/* Length of signature data */
> > > +};
> > > +
> > > +#define PKEY_ID_MERKLE 3
> > > +
> > > +static const char magic_number[] = "~Module signature appended~\n";
> > 
> > This here will be the forth definition of struct module_signature,
> > increasing the risk of unwanted diversion.  I second Petr's suggestion
> > to reuse a _common_ definition instead.
> 
> Ack.
> 
> > (Here, even include/linux/module_signature.h could be included itself.)
> 
> I'd like to avoid including internal headers from other components.
> We could move it to an UAPI header. Various other subsystems use those
> for not-really-UAPI but still ABI definitions.

Yeah, ack.

> (...)
> 
> > > +static inline char *xasprintf(const char *fmt, ...)
> > > +{
> > > +	va_list ap;
> > > +	char *strp;
> > > +	int ret;
> > > +
> > > +	va_start(ap, fmt);
> > > +	ret = vasprintf(&strp, fmt, ap);
> > > +	va_end(ap);
> > > +	if (ret == -1)
> > > +		err(1, "Memory allocation failed");
> > > +
> > > +	return strp;
> > > +}
> > 
> > Please consider moving these x* functions into scripts/include/xalloc.h
> > for reuse.  (I am sure someone else wrote this already, but I can't find
> > it...)
> 
> Petr suggested it somewhere, it is done for the next revision.
> 
> > thanks for all your efforts for reproducibility!
> > 
> > As I have no clue about that:  Is the patent for merkle trees [1] a
> > problem when integrating that here?
> 
> That should have expired a long time ago [2].
> And fs-verity is also using merkle trees.

Great, thanks.


> > Can you verify if I get the mechanics roughly correct?
> > 
> >   * Modules are merkle tree leaves.  Modules are built and logically
> >     paired by the order from modules.order; a single left-over module is
> >     paired with itself.
> > 
> >   * Hashes of paired modules are hashed again (branch node hash);
> >     hashes of pairs of branch nodes' hashes are hashed again;
> >     repeat until we reach the single merkle tree root hash
> > 
> >   * The final merkle tree root hash (and the count of tree levels) is
> >     included in vmlinux
> 
> The merkle tree code was written by Sebastian so he will have the best
> knowledge about it. But this is also my understanding.

I'd like to see some (rough) description in Documentation or in a commit
message at least, otherwise future me will have to ask that again.


> > 'make && find . -name '*.ko' -exec rm {} \; && make' does not rebuild
> > the in-tree modules.  Shifting the module-hashes support from
> > scripts/link-vmlinux.sh to scripts/Makefile.vmlinux might (make it
> > easier) to fix this again.
> 
> I'll take a look at it.

Thanks!

Kind regards,
Nicolas



> > [1]: https://worldwide.espacenet.com/patent/search/family/022107098/publication/US4309569A?q=pn%3DUS4309569
> 
> [2] https://patents.stackexchange.com/questions/17901/validity-of-patent-on-merkle-trees
> 
> 
> Thomas

-- 
Nicolas

