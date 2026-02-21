Return-Path: <linux-integrity+bounces-8535-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMXUJOglmmnCZAMAu9opvQ
	(envelope-from <linux-integrity+bounces-8535-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 21 Feb 2026 22:38:48 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9A916DF06
	for <lists+linux-integrity@lfdr.de>; Sat, 21 Feb 2026 22:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8AA0302D123
	for <lists+linux-integrity@lfdr.de>; Sat, 21 Feb 2026 21:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896CD30BB91;
	Sat, 21 Feb 2026 21:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpvIeLgC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E14A1EA7F4;
	Sat, 21 Feb 2026 21:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771709923; cv=none; b=FzIFG6chbEw1B36TMZMorLGRY4L9gz0XFzyS2ffDjcLHKkO/9Nvl35Or7keNqBdgvq7h6X7f/ESrq5XZ4R7SeX3hk0BwJaMA8nyaH9tuSQT6RRiPnrPWFL2oJ4bcq6/06HfKgvrXS3Xbly9FozmOmP3CRR7Rd3uZ8vGf5Py1j+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771709923; c=relaxed/simple;
	bh=6f/BlOCaBHYHn12tHM4Bu5uqu60c5HeyFZykyfi11cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/xA0e5gnMlJW2RyAOeV5YEU4Rv+w5HMPhQARfoM6zKP9OnpCJ+8ve/5PV+VgvIvMFPD4uaWkDxfzsrqcjDz+aAqc8lZgkDCYvrG/+fgn46tOvxCLpzJsjufxYqp+YaExwV0OTYhTgOngaOosjh+XICu4bgilmFgX6CYa6V5tGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpvIeLgC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1BAC4CEF7;
	Sat, 21 Feb 2026 21:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771709923;
	bh=6f/BlOCaBHYHn12tHM4Bu5uqu60c5HeyFZykyfi11cE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RpvIeLgCkECuxu/6gXgTQN2VJvSNRxp9H8NYfUdN96cKwgGi5TbrmXVpqRCoCmv0U
	 8OmVb/vAvTcOeCQNkRiA6vTqRcn92yFQi7lxqql889K9VGxhBd2S3Lrj2uruF0W3N1
	 q3LW64Hu0Jzi9dPzsRlC27O5F+KqMpmiiRlL3h9J6chn3swUA+7qCqSMMa9Du9alRE
	 n1uxljy0MYxcWwo+BPYiNoKWc70PEpCrYmTd15UI34v+JYgQMoWBOrCxOrEnrqaV3n
	 FPWWMoa5bu7H3KoDUUcK3RIt06OjrYY/5chzuNfvAD15oxT3h127uPEAVN2/0On/Hr
	 JnQUEuIrWpOoA==
Date: Sat, 21 Feb 2026 22:38:29 +0100
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
Message-ID: <aZol1Rsa2tX-WNaZ@derry.ads.avm.de>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-15-0b932db9b56b@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260113-module-hashes-v4-15-0b932db9b56b@weissschuh.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8535-lists,linux-integrity=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,arndb.de,suse.com,google.com,samsung.com,paul-moore.com,namei.org,hallyn.com,lwn.net,linux.ibm.com,ellerman.id.au,gmail.com,huawei.com,oracle.com,atomlin.com,oss.cyber.gouv.fr,proxmox.com,bzzt.net,mapreri.org,archlinux.org,heusel.eu,linutronix.de,vger.kernel.org,lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[39];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nsc@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[link-vmlinux.sh:url,derry.ads.avm.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,breakpoint.cc:email]
X-Rspamd-Queue-Id: 3A9A916DF06
X-Rspamd-Action: no action

Hi Thomas,

On Tue, Jan 13, 2026 at 01:28:59PM +0100, Thomas Weiﬂschuh wrote:
> The current signature-based module integrity checking has some drawbacks
> in combination with reproducible builds. Either the module signing key
> is generated at build time, which makes the build unreproducible, or a
> static signing key is used, which precludes rebuilds by third parties
> and makes the whole build and packaging process much more complicated.
> 
> The goal is to reach bit-for-bit reproducibility. Excluding certain
> parts of the build output from the reproducibility analysis would be
> error-prone and force each downstream consumer to introduce new tooling.
> 
> Introduce a new mechanism to ensure only well-known modules are loaded
> by embedding a merkle tree root of all modules built as part of the full
> kernel build into vmlinux.
> 
> Non-builtin modules can be validated as before through signatures.
> 
> Normally the .ko module files depend on a fully built vmlinux to be
> available for modpost validation and BTF generation. With
> CONFIG_MODULE_HASHES, vmlinux now depends on the modules
> to build a merkle tree. This introduces a dependency cycle which is
> impossible to satisfy. Work around this by building the modules during
> link-vmlinux.sh, after vmlinux is complete enough for modpost and BTF
> but before the final module hashes are
> 
> The PKCS7 format which is used for regular module signatures can not
> represent Merkle proofs, so a new kind of module signature is
> introduced. As this signature type is only ever used for builtin
> modules, no compatibility issues can arise.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  .gitignore                                   |   1 +
>  Documentation/kbuild/reproducible-builds.rst |   5 +-
>  Makefile                                     |   8 +-
>  include/asm-generic/vmlinux.lds.h            |  11 +
>  include/linux/module_hashes.h                |  25 ++
>  include/linux/module_signature.h             |   1 +
>  kernel/module/Kconfig                        |  21 +-
>  kernel/module/Makefile                       |   1 +
>  kernel/module/hashes.c                       |  92 ++++++
>  kernel/module/hashes_root.c                  |   6 +
>  kernel/module/internal.h                     |   1 +
>  kernel/module/main.c                         |   4 +-
>  scripts/.gitignore                           |   1 +
>  scripts/Makefile                             |   3 +
>  scripts/Makefile.modfinal                    |  11 +
>  scripts/Makefile.modinst                     |  13 +
>  scripts/Makefile.vmlinux                     |   5 +
>  scripts/link-vmlinux.sh                      |  14 +-
>  scripts/modules-merkle-tree.c                | 467 +++++++++++++++++++++++++++
>  security/lockdown/Kconfig                    |   2 +-
>  20 files changed, 685 insertions(+), 7 deletions(-)
> 
[...]

> diff --git a/kernel/module/hashes_root.c b/kernel/module/hashes_root.c
> new file mode 100644
> index 000000000000..1abfcd3aa679
> --- /dev/null
> +++ b/kernel/module/hashes_root.c
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <linux/module_hashes.h>
> +
> +/* Blank dummy data. Will be overridden by link-vmlinux.sh */
> +const struct module_hashes_root module_hashes_root __module_hashes_section = {};
> diff --git a/kernel/module/internal.h b/kernel/module/internal.h
> index e2d49122c2a1..e22837d3ac76 100644
> --- a/kernel/module/internal.h
> +++ b/kernel/module/internal.h
> @@ -338,6 +338,7 @@ void module_mark_ro_after_init(const Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
>  			       const char *secstrings);
>  
>  int module_sig_check(struct load_info *info, const u8 *sig, size_t sig_len);
> +int module_hash_check(struct load_info *info, const u8 *sig, size_t sig_len);
>  
>  #ifdef CONFIG_DEBUG_KMEMLEAK
>  void kmemleak_load_module(const struct module *mod, const struct load_info *info);
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 2a28a0ece809..fa30b6387936 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3362,8 +3362,10 @@ static int module_integrity_check(struct load_info *info, int flags)
>  
>  	if (IS_ENABLED(CONFIG_MODULE_SIG) && sig_type == PKEY_ID_PKCS7) {
>  		err = module_sig_check(info, sig, sig_len);
> +	} else if (IS_ENABLED(CONFIG_MODULE_HASHES) && sig_type == PKEY_ID_MERKLE) {
> +		err = module_hash_check(info, sig, sig_len);
>  	} else {
> -		pr_err("module: not signed with expected PKCS#7 message\n");
> +		pr_err("module: not signed with signature mechanism\n");
>  		err = -ENOPKG;

To prevent others from running into the same issue:

My first test got stuck here, as I tested with virtme-ng, which symlinks
modules from build tree to /lib/modules/$(uname -r)/..., resulting in

    [   15.956855] module: not signed with signature mechanism
    modprobe: ERROR: could not insert 'efivarfs': Package not installed

As the modules_install step was missing, modules were not being signed.


[...]
> diff --git a/scripts/modules-merkle-tree.c b/scripts/modules-merkle-tree.c
> new file mode 100644
> index 000000000000..a6ec0e21213b
> --- /dev/null
> +++ b/scripts/modules-merkle-tree.c
> @@ -0,0 +1,467 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Compute hashes for modules files and build a merkle tree.
> + *
> + * Copyright (C) 2025 Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
> + * Copyright (C) 2025 Thomas Weiﬂschuh <linux@weissschuh.net>
> + *
> + */
> +#define _GNU_SOURCE 1
> +#include <arpa/inet.h>
> +#include <err.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <stdarg.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <stdbool.h>
> +#include <stdlib.h>
> +
> +#include <sys/stat.h>
> +#include <sys/mman.h>
> +
> +#include <openssl/evp.h>
> +#include <openssl/err.h>
> +
> +#include "ssl-common.h"
> +
> +static int hash_size;
> +static EVP_MD_CTX *ctx;
> +
> +struct module_signature {
> +	uint8_t		algo;		/* Public-key crypto algorithm [0] */
> +	uint8_t		hash;		/* Digest algorithm [0] */
> +	uint8_t		id_type;	/* Key identifier type [PKEY_ID_PKCS7] */
> +	uint8_t		signer_len;	/* Length of signer's name [0] */
> +	uint8_t		key_id_len;	/* Length of key identifier [0] */
> +	uint8_t		__pad[3];
> +	uint32_t	sig_len;	/* Length of signature data */
> +};
> +
> +#define PKEY_ID_MERKLE 3
> +
> +static const char magic_number[] = "~Module signature appended~\n";

This here will be the forth definition of struct module_signature,
increasing the risk of unwanted diversion.  I second Petr's suggestion
to reuse a _common_ definition instead.

(Here, even include/linux/module_signature.h could be included itself.)

> +
> +struct file_entry {
> +	char *name;
> +	unsigned int pos;
> +	unsigned char hash[EVP_MAX_MD_SIZE];
> +};
> +
> +static struct file_entry *fh_list;
> +static size_t num_files;
> +
> +struct leaf_hash {
> +	unsigned char hash[EVP_MAX_MD_SIZE];
> +};
> +
> +struct mtree {
> +	struct leaf_hash **l;
> +	unsigned int *entries;
> +	unsigned int levels;
> +};
> +
> +static inline void *xcalloc(size_t n, size_t size)
> +{
> +	void *p;
> +
> +	p = calloc(n, size);
> +	if (!p)
> +		errx(1, "Memory allocation failed");
> +
> +	return p;
> +}
> +
> +static void *xmalloc(size_t size)
> +{
> +	void *p;
> +
> +	p = malloc(size);
> +	if (!p)
> +		errx(1, "Memory allocation failed");
> +
> +	return p;
> +}
> +
> +static inline void *xreallocarray(void *oldp, size_t n, size_t size)
> +{
> +	void *p;
> +
> +	p = reallocarray(oldp, n, size);
> +	if (!p)
> +		errx(1, "Memory allocation failed");
> +
> +	return p;
> +}
> +
> +static inline char *xasprintf(const char *fmt, ...)
> +{
> +	va_list ap;
> +	char *strp;
> +	int ret;
> +
> +	va_start(ap, fmt);
> +	ret = vasprintf(&strp, fmt, ap);
> +	va_end(ap);
> +	if (ret == -1)
> +		err(1, "Memory allocation failed");
> +
> +	return strp;
> +}

Please consider moving these x* functions into scripts/include/xalloc.h
for reuse.  (I am sure someone else wrote this already, but I can't find
it...)

> 
> 

thanks for all your efforts for reproducibility!

As I have no clue about that:  Is the patent for merkle trees [1] a
problem when integrating that here?

Can you verify if I get the mechanics roughly correct?

  * Modules are merkle tree leaves.  Modules are built and logically
    paired by the order from modules.order; a single left-over module is
    paired with itself.

  * Hashes of paired modules are hashed again (branch node hash);
    hashes of pairs of branch nodes' hashes are hashed again;
    repeat until we reach the single merkle tree root hash

  * The final merkle tree root hash (and the count of tree levels) is
    included in vmlinux


'make && find . -name '*.ko' -exec rm {} \; && make' does not rebuild
the in-tree modules.  Shifting the module-hashes support from
scripts/link-vmlinux.sh to scripts/Makefile.vmlinux might (make it
easier) to fix this again.

Kind regards,
Nicolas



[1]: https://worldwide.espacenet.com/patent/search/family/022107098/publication/US4309569A?q=pn%3DUS4309569


-- 
Nicolas

