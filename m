Return-Path: <linux-integrity+bounces-8549-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEJ5AfHPnWn4SAQAu9opvQ
	(envelope-from <linux-integrity+bounces-8549-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Feb 2026 17:21:05 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B311189B9F
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Feb 2026 17:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 161273019045
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Feb 2026 16:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0583A4F5C;
	Tue, 24 Feb 2026 16:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dE5DsgJe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2466915C158;
	Tue, 24 Feb 2026 16:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771949829; cv=none; b=S6qMwrriie1roBXeAN6pfx93S3G3cfxaarWgWwbBzIGv8Be1YOkrY+dxcPJLFsTSUwu8XL/a8v2fQAb1y0LJX7F9l5DQdLqgZZo+rbXYPT3+zr4WT/Q7HREA7zwF5kkRd5kPTggDd5T6pJVmVVEQGQNezDZtmQCZ/s7JMWYbmeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771949829; c=relaxed/simple;
	bh=SXv8kNok4zxMnc5pPBCN8E77XIiooRBkXlI+BOUS8Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p07QnTuF645xLHf2PmQ5IVhPmAv5mAsEqXWd5g48U2457vAqOASgk6w9PF7uzLT6JSp/YrKxt9Ab0KErPXgqUs0EtrQhLMg1/pNVHsefvIpVpMeLSpx3IB2eTx0ImjkMhiLZnrptPC5lF+jm5RfbtNoROh/7Fxd6WKmh6k6iS+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dE5DsgJe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2CAC116D0;
	Tue, 24 Feb 2026 16:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771949828;
	bh=SXv8kNok4zxMnc5pPBCN8E77XIiooRBkXlI+BOUS8Dc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dE5DsgJe4eWwAhLUkc52afWpncNFQHm3ITfjxXTQs8pZ3HAdZoxX3E9+yw84PuWfc
	 8hv0jBSBocClUd7acb2nBgtY0uf3R+6IJ9CaSBzL6ITcI6T+FBM4oFlesEeJM8ib+K
	 5uZ/5NDfic7g+vqbPRCzSUckWiK+3QDVPDhtTPlOjE84675xU/g2iZz6oR/8YvKW4l
	 4AL1i725kN9lXS1UU2SngsrbrekRgSdTqNC7/UOua/J6J9V+z4azuGI6LX2qWBuTwE
	 SZwRe4f0R4aadCnfUfk4peBnSm5w+WJWSP6gTO15tqNeDIuiLzQBAAPazq1vUyzKiJ
	 dizgCboB6pIOA==
Date: Tue, 24 Feb 2026 17:14:52 +0100
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
Message-ID: <aZ3OfJJSJgfOb0rJ@levanger>
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
 <aZyfcDCWOBJJztQ2@levanger>
 <06054e9a-2b7a-4063-98b8-7d6c539e543f@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06054e9a-2b7a-4063-98b8-7d6c539e543f@t-8ch.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8549-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[39];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,arndb.de,suse.com,google.com,samsung.com,paul-moore.com,namei.org,hallyn.com,lwn.net,linux.ibm.com,ellerman.id.au,gmail.com,huawei.com,oracle.com,atomlin.com,oss.cyber.gouv.fr,proxmox.com,bzzt.net,mapreri.org,archlinux.org,heusel.eu,linutronix.de,vger.kernel.org,lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nsc@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,weissschuh.net:email,breakpoint.cc:email]
X-Rspamd-Queue-Id: 5B311189B9F
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 10:43:30PM +0100, Thomas Weiﬂschuh wrote:
> On 2026-02-23 19:41:52+0100, Nicolas Schier wrote:
> > On Mon, Feb 23, 2026 at 08:53:29AM +0100, Thomas Weiﬂschuh wrote:
> > > On 2026-02-21 22:38:29+0100, Nicolas Schier wrote:
> > > > On Tue, Jan 13, 2026 at 01:28:59PM +0100, Thomas Weiﬂschuh wrote:
[...]
> > > > [...]
> > > > > diff --git a/scripts/modules-merkle-tree.c b/scripts/modules-merkle-tree.c
> > > > > new file mode 100644
> > > > > index 000000000000..a6ec0e21213b
> > > > > --- /dev/null
> > > > > +++ b/scripts/modules-merkle-tree.c
> > > > > @@ -0,0 +1,467 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > > > +/*
> > > > > + * Compute hashes for modules files and build a merkle tree.
> > > > > + *
> > > > > + * Copyright (C) 2025 Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
> > > > > + * Copyright (C) 2025 Thomas Weiﬂschuh <linux@weissschuh.net>
> > > > > + *
> > > > > + */
> > > > > +#define _GNU_SOURCE 1
> > > > > +#include <arpa/inet.h>
> > > > > +#include <err.h>
> > > > > +#include <unistd.h>
> > > > > +#include <fcntl.h>
> > > > > +#include <stdarg.h>
> > > > > +#include <stdio.h>
> > > > > +#include <string.h>
> > > > > +#include <stdbool.h>
> > > > > +#include <stdlib.h>
> > > > > +
> > > > > +#include <sys/stat.h>
> > > > > +#include <sys/mman.h>
> > > > > +
> > > > > +#include <openssl/evp.h>
> > > > > +#include <openssl/err.h>
> > > > > +
> > > > > +#include "ssl-common.h"
> > > > > +
> > > > > +static int hash_size;
> > > > > +static EVP_MD_CTX *ctx;
> > > > > +
> > > > > +struct module_signature {
> > > > > +	uint8_t		algo;		/* Public-key crypto algorithm [0] */
> > > > > +	uint8_t		hash;		/* Digest algorithm [0] */
> > > > > +	uint8_t		id_type;	/* Key identifier type [PKEY_ID_PKCS7] */
> > > > > +	uint8_t		signer_len;	/* Length of signer's name [0] */
> > > > > +	uint8_t		key_id_len;	/* Length of key identifier [0] */
> > > > > +	uint8_t		__pad[3];
> > > > > +	uint32_t	sig_len;	/* Length of signature data */
> > > > > +};
> > > > > +
> > > > > +#define PKEY_ID_MERKLE 3
> > > > > +
> > > > > +static const char magic_number[] = "~Module signature appended~\n";
> > > > 
> > > > This here will be the forth definition of struct module_signature,
> > > > increasing the risk of unwanted diversion.  I second Petr's suggestion
> > > > to reuse a _common_ definition instead.
> > > 
> > > Ack.
> > > 
> > > > (Here, even include/linux/module_signature.h could be included itself.)
> > > 
> > > I'd like to avoid including internal headers from other components.
> > > We could move it to an UAPI header. Various other subsystems use those
> > > for not-really-UAPI but still ABI definitions.
> > 
> > Yeah, ack.
> 
> What exactly is the 'ack' for?
> * Avoiding to include internal headers?
> * Moving the definition to UAPI headers?

ah, sorry.  I think reduction of duplicated definitions is good; moving
these definitions to UAPI headers sounds like a valid compromise to me.


> (...)
> 
> > > > Can you verify if I get the mechanics roughly correct?
> > > > 
> > > >   * Modules are merkle tree leaves.  Modules are built and logically
> > > >     paired by the order from modules.order; a single left-over module is
> > > >     paired with itself.
> > > > 
> > > >   * Hashes of paired modules are hashed again (branch node hash);
> > > >     hashes of pairs of branch nodes' hashes are hashed again;
> > > >     repeat until we reach the single merkle tree root hash
> > > > 
> > > >   * The final merkle tree root hash (and the count of tree levels) is
> > > >     included in vmlinux
> > > 
> > > The merkle tree code was written by Sebastian so he will have the best
> > > knowledge about it. But this is also my understanding.
> > 
> > I'd like to see some (rough) description in Documentation or in a commit
> > message at least, otherwise future me will have to ask that again.
> 
> Ack in general. I'd prefer to document it in a source code comment,
> though. That feels like the best fit to me.

Great, thanks.

-- 
Nicolas

