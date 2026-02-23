Return-Path: <linux-integrity+bounces-8543-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJ1rBqHKnGlHKQQAu9opvQ
	(envelope-from <linux-integrity+bounces-8543-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Feb 2026 22:46:09 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD6617DB63
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Feb 2026 22:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FB86310AEC6
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Feb 2026 21:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E5B3793A0;
	Mon, 23 Feb 2026 21:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="DtNafl26"
X-Original-To: linux-integrity@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5A437881C;
	Mon, 23 Feb 2026 21:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883015; cv=none; b=E2nMgB4w8hch24c6olU98JA5Z7yiYIBxokDuOygNfT3Ka184xSOR8CsUheA3EfKW39c7i2J8GzAZPN6e0bY0K1VAC8Ovl5g+vOsX+zs0TVQGVc1HDzpbndreX6BhQ9H+s7iivWqO7cVQeHh3nIaOLaTVS99oGdJGIjvfdp3l0mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883015; c=relaxed/simple;
	bh=f/RGyyEjxiTV1HAvGsXVhUhx0QauEA+D4aTLJ9rlFUY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRrsUiW8FOeSFiwNooKAceXfJyKZ3mfpxO97Xf3Dba1qZ7m6LHmB64kFfnfOTQH+HX0R54taKipg7aBaaGi8Jn9gMmX+d77Wd32inYY9ZBn3yq/1elk0desqj/JfJLRQqkPU+E6p/RUS4q7kgE/jZ5YNLpLY9X6SHsT6arrcNNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=DtNafl26; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1771883011;
	bh=f/RGyyEjxiTV1HAvGsXVhUhx0QauEA+D4aTLJ9rlFUY=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=DtNafl26QWwqrEhxfMVJt7qi0VOQ+517xajhYFHcF+PGQBS3hyDAm0AZBdaYhEIV0
	 BPTveOVyjJh7AzZ2ede0B0Zo9hAemmvCqhanqT/ftLkbYfKvroulfGOCMEty+YjZ/s
	 N4rhaBsvNOn/4HeDhUervVSBgCJam9Inr6UpFbdI=
Date: Mon, 23 Feb 2026 22:43:30 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Nicolas Schier <nsc@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Aaron Tomlin <atomlin@atomlin.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>, 
	Fabian =?utf-8?Q?Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, Arnout Engelen <arnout@bzzt.net>, 
	Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>, 
	Christian Heusel <christian@heusel.eu>, =?utf-8?B?Q8OianU=?= Mihai-Drosi <mcaju95@gmail.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 15/17] module: Introduce hash-based integrity checking
Message-ID: <06054e9a-2b7a-4063-98b8-7d6c539e543f@t-8ch.de>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-15-0b932db9b56b@weissschuh.net>
 <aZol1Rsa2tX-WNaZ@derry.ads.avm.de>
 <0d70db8d-702b-46ec-a010-298fe6515aab@t-8ch.de>
 <aZyfcDCWOBJJztQ2@levanger>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZyfcDCWOBJJztQ2@levanger>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[weissschuh.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[weissschuh.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8543-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[kernel.org,arndb.de,suse.com,google.com,samsung.com,paul-moore.com,namei.org,hallyn.com,lwn.net,linux.ibm.com,ellerman.id.au,gmail.com,huawei.com,oracle.com,atomlin.com,oss.cyber.gouv.fr,proxmox.com,bzzt.net,mapreri.org,archlinux.org,heusel.eu,linutronix.de,vger.kernel.org,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[39];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@weissschuh.net,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[weissschuh.net:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[weissschuh.net:email,weissschuh.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,breakpoint.cc:email]
X-Rspamd-Queue-Id: ACD6617DB63
X-Rspamd-Action: no action

On 2026-02-23 19:41:52+0100, Nicolas Schier wrote:
> On Mon, Feb 23, 2026 at 08:53:29AM +0100, Thomas Weißschuh wrote:
> > On 2026-02-21 22:38:29+0100, Nicolas Schier wrote:
> > > On Tue, Jan 13, 2026 at 01:28:59PM +0100, Thomas Weißschuh wrote:
> > > > The current signature-based module integrity checking has some drawbacks
> > > > in combination with reproducible builds. Either the module signing key
> > > > is generated at build time, which makes the build unreproducible, or a
> > > > static signing key is used, which precludes rebuilds by third parties
> > > > and makes the whole build and packaging process much more complicated.
> > > > 
> > > > The goal is to reach bit-for-bit reproducibility. Excluding certain
> > > > parts of the build output from the reproducibility analysis would be
> > > > error-prone and force each downstream consumer to introduce new tooling.
> > > > 
> > > > Introduce a new mechanism to ensure only well-known modules are loaded
> > > > by embedding a merkle tree root of all modules built as part of the full
> > > > kernel build into vmlinux.
> > > > 
> > > > Non-builtin modules can be validated as before through signatures.
> > > > 
> > > > Normally the .ko module files depend on a fully built vmlinux to be
> > > > available for modpost validation and BTF generation. With
> > > > CONFIG_MODULE_HASHES, vmlinux now depends on the modules
> > > > to build a merkle tree. This introduces a dependency cycle which is
> > > > impossible to satisfy. Work around this by building the modules during
> > > > link-vmlinux.sh, after vmlinux is complete enough for modpost and BTF
> > > > but before the final module hashes are
> > > > 
> > > > The PKCS7 format which is used for regular module signatures can not
> > > > represent Merkle proofs, so a new kind of module signature is
> > > > introduced. As this signature type is only ever used for builtin
> > > > modules, no compatibility issues can arise.
> > > > 
> > > > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > > > ---
> > > >  .gitignore                                   |   1 +
> > > >  Documentation/kbuild/reproducible-builds.rst |   5 +-
> > > >  Makefile                                     |   8 +-
> > > >  include/asm-generic/vmlinux.lds.h            |  11 +
> > > >  include/linux/module_hashes.h                |  25 ++
> > > >  include/linux/module_signature.h             |   1 +
> > > >  kernel/module/Kconfig                        |  21 +-
> > > >  kernel/module/Makefile                       |   1 +
> > > >  kernel/module/hashes.c                       |  92 ++++++
> > > >  kernel/module/hashes_root.c                  |   6 +
> > > >  kernel/module/internal.h                     |   1 +
> > > >  kernel/module/main.c                         |   4 +-
> > > >  scripts/.gitignore                           |   1 +
> > > >  scripts/Makefile                             |   3 +
> > > >  scripts/Makefile.modfinal                    |  11 +
> > > >  scripts/Makefile.modinst                     |  13 +
> > > >  scripts/Makefile.vmlinux                     |   5 +
> > > >  scripts/link-vmlinux.sh                      |  14 +-
> > > >  scripts/modules-merkle-tree.c                | 467 +++++++++++++++++++++++++++
> > > >  security/lockdown/Kconfig                    |   2 +-
> > > >  20 files changed, 685 insertions(+), 7 deletions(-)
> > > > 
> > > [...]
> > > 
> > > > diff --git a/kernel/module/hashes_root.c b/kernel/module/hashes_root.c
> > > > new file mode 100644
> > > > index 000000000000..1abfcd3aa679
> > > > --- /dev/null
> > > > +++ b/kernel/module/hashes_root.c
> > > > @@ -0,0 +1,6 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > > +
> > > > +#include <linux/module_hashes.h>
> > > > +
> > > > +/* Blank dummy data. Will be overridden by link-vmlinux.sh */
> > > > +const struct module_hashes_root module_hashes_root __module_hashes_section = {};
> > > > diff --git a/kernel/module/internal.h b/kernel/module/internal.h
> > > > index e2d49122c2a1..e22837d3ac76 100644
> > > > --- a/kernel/module/internal.h
> > > > +++ b/kernel/module/internal.h
> > > > @@ -338,6 +338,7 @@ void module_mark_ro_after_init(const Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
> > > >  			       const char *secstrings);
> > > >  
> > > >  int module_sig_check(struct load_info *info, const u8 *sig, size_t sig_len);
> > > > +int module_hash_check(struct load_info *info, const u8 *sig, size_t sig_len);
> > > >  
> > > >  #ifdef CONFIG_DEBUG_KMEMLEAK
> > > >  void kmemleak_load_module(const struct module *mod, const struct load_info *info);
> > > > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > > > index 2a28a0ece809..fa30b6387936 100644
> > > > --- a/kernel/module/main.c
> > > > +++ b/kernel/module/main.c
> > > > @@ -3362,8 +3362,10 @@ static int module_integrity_check(struct load_info *info, int flags)
> > > >  
> > > >  	if (IS_ENABLED(CONFIG_MODULE_SIG) && sig_type == PKEY_ID_PKCS7) {
> > > >  		err = module_sig_check(info, sig, sig_len);
> > > > +	} else if (IS_ENABLED(CONFIG_MODULE_HASHES) && sig_type == PKEY_ID_MERKLE) {
> > > > +		err = module_hash_check(info, sig, sig_len);
> > > >  	} else {
> > > > -		pr_err("module: not signed with expected PKCS#7 message\n");
> > > > +		pr_err("module: not signed with signature mechanism\n");
> > > >  		err = -ENOPKG;
> > > 
> > > To prevent others from running into the same issue:
> > > 
> > > My first test got stuck here, as I tested with virtme-ng, which symlinks
> > > modules from build tree to /lib/modules/$(uname -r)/..., resulting in
> > > 
> > >     [   15.956855] module: not signed with signature mechanism
> > >     modprobe: ERROR: could not insert 'efivarfs': Package not installed
> > > 
> > > As the modules_install step was missing, modules were not being signed.
> > 
> > Currently the signing is deferred to installation time to keep in sync
> > with regular module signing and to keep the logic simpler by not having
> > to gracefully handle previously-signed files.
> > But this could be changed.
> 
> I did not want to suggest changing the behaviour, that would make things
> more complicated to prevent needless rebuilds.  I just wanted to mention
> it here to prevent others from burning time.

Understood.

> > > [...]
> > > > diff --git a/scripts/modules-merkle-tree.c b/scripts/modules-merkle-tree.c
> > > > new file mode 100644
> > > > index 000000000000..a6ec0e21213b
> > > > --- /dev/null
> > > > +++ b/scripts/modules-merkle-tree.c
> > > > @@ -0,0 +1,467 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > > +/*
> > > > + * Compute hashes for modules files and build a merkle tree.
> > > > + *
> > > > + * Copyright (C) 2025 Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
> > > > + * Copyright (C) 2025 Thomas Weißschuh <linux@weissschuh.net>
> > > > + *
> > > > + */
> > > > +#define _GNU_SOURCE 1
> > > > +#include <arpa/inet.h>
> > > > +#include <err.h>
> > > > +#include <unistd.h>
> > > > +#include <fcntl.h>
> > > > +#include <stdarg.h>
> > > > +#include <stdio.h>
> > > > +#include <string.h>
> > > > +#include <stdbool.h>
> > > > +#include <stdlib.h>
> > > > +
> > > > +#include <sys/stat.h>
> > > > +#include <sys/mman.h>
> > > > +
> > > > +#include <openssl/evp.h>
> > > > +#include <openssl/err.h>
> > > > +
> > > > +#include "ssl-common.h"
> > > > +
> > > > +static int hash_size;
> > > > +static EVP_MD_CTX *ctx;
> > > > +
> > > > +struct module_signature {
> > > > +	uint8_t		algo;		/* Public-key crypto algorithm [0] */
> > > > +	uint8_t		hash;		/* Digest algorithm [0] */
> > > > +	uint8_t		id_type;	/* Key identifier type [PKEY_ID_PKCS7] */
> > > > +	uint8_t		signer_len;	/* Length of signer's name [0] */
> > > > +	uint8_t		key_id_len;	/* Length of key identifier [0] */
> > > > +	uint8_t		__pad[3];
> > > > +	uint32_t	sig_len;	/* Length of signature data */
> > > > +};
> > > > +
> > > > +#define PKEY_ID_MERKLE 3
> > > > +
> > > > +static const char magic_number[] = "~Module signature appended~\n";
> > > 
> > > This here will be the forth definition of struct module_signature,
> > > increasing the risk of unwanted diversion.  I second Petr's suggestion
> > > to reuse a _common_ definition instead.
> > 
> > Ack.
> > 
> > > (Here, even include/linux/module_signature.h could be included itself.)
> > 
> > I'd like to avoid including internal headers from other components.
> > We could move it to an UAPI header. Various other subsystems use those
> > for not-really-UAPI but still ABI definitions.
> 
> Yeah, ack.

What exactly is the 'ack' for?
* Avoiding to include internal headers?
* Moving the definition to UAPI headers?

(...)

> > > Can you verify if I get the mechanics roughly correct?
> > > 
> > >   * Modules are merkle tree leaves.  Modules are built and logically
> > >     paired by the order from modules.order; a single left-over module is
> > >     paired with itself.
> > > 
> > >   * Hashes of paired modules are hashed again (branch node hash);
> > >     hashes of pairs of branch nodes' hashes are hashed again;
> > >     repeat until we reach the single merkle tree root hash
> > > 
> > >   * The final merkle tree root hash (and the count of tree levels) is
> > >     included in vmlinux
> > 
> > The merkle tree code was written by Sebastian so he will have the best
> > knowledge about it. But this is also my understanding.
> 
> I'd like to see some (rough) description in Documentation or in a commit
> message at least, otherwise future me will have to ask that again.

Ack in general. I'd prefer to document it in a source code comment,
though. That feels like the best fit to me.


Thomas

