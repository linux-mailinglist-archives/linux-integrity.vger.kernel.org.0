Return-Path: <linux-integrity+bounces-8522-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBKsGBcul2kcvgIAu9opvQ
	(envelope-from <linux-integrity+bounces-8522-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Feb 2026 16:36:55 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAB91603C2
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Feb 2026 16:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81F673012CC0
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Feb 2026 15:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FEB348463;
	Thu, 19 Feb 2026 15:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9Y8eQbd"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10C4199920;
	Thu, 19 Feb 2026 15:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771515393; cv=none; b=R8VgNODAZE0cUyAK5+fppQdmUvKtGDmMWbt+K+sYmCn/SKEAl6C63O3p5rajmvvHf4VTsvEaMT8AHKg7/XJn4YZ+rJzhM6Xfkwixk5lZitcnifATnoZEe5xAKvIz5Ki7qi3wdW9BtYKYRxvb2Xxp6KYFHIaxTZS7nzkRANO4X9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771515393; c=relaxed/simple;
	bh=xvGScHjuinZ0ATzJQB4XWDn+7FfGiPuiuds790maVJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7sWn0jm99MR6P+3O/mWsftjTZwxoTw0GUmasEgn2q0BAfoR1us1GepskVekNBO4fI+I6gm8+7g6ZKRhrwtndNTcYaEhw5aIbNQC0qIkucgSwuqKBi5jEMAkbIgTlCxLqKeMwuoP0snYrQ+eK7DtluI3Da4z15eL7e4+At+mWWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9Y8eQbd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1105BC4CEF7;
	Thu, 19 Feb 2026 15:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771515392;
	bh=xvGScHjuinZ0ATzJQB4XWDn+7FfGiPuiuds790maVJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X9Y8eQbdJ27k5PgYNvucYbCou7PyhGWqSaSw5zQ9BMp5TfRnUEdlq6LpQNPShYF5f
	 5+FQ33fjy0j5phsKwCSp4c7vnv/kHZcBDSSjYmZlxE1Rtj1KPTdsrqJGBOt45xASBq
	 44TBES2c3aRoJck462y43Jn27YvOo7ETxGA06SfCErH9+rqHx3PFjCIsihwiliYBCg
	 veM9FYkRpCNI2Sz3gH5imjY0d+gVJfxUt6b95uJIf9Q9ucaEOWthJTA5KvIjlhbXNZ
	 UhYdrRsiVZ56wQU95sEc+CesXOgk3pKmiLRxYkB6wDl85KBhED/TFJPanXaK4uOKHr
	 DM1nWzuo7fGxA==
Date: Thu, 19 Feb 2026 15:27:56 +0100
From: Nicolas Schier <nsc@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
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
Message-ID: <aZcd7PpetL8J6CM4@derry.ads.avm.de>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-15-0b932db9b56b@weissschuh.net>
 <db1ed045-d7b6-49dc-b111-9fea7c30f8ab@suse.com>
 <28cf8d51-7530-41d5-a47b-cad5ecabd269@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28cf8d51-7530-41d5-a47b-cad5ecabd269@t-8ch.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8522-lists,linux-integrity=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,kernel.org,arndb.de,google.com,samsung.com,paul-moore.com,namei.org,hallyn.com,lwn.net,linux.ibm.com,ellerman.id.au,gmail.com,huawei.com,oracle.com,atomlin.com,oss.cyber.gouv.fr,proxmox.com,bzzt.net,mapreri.org,archlinux.org,heusel.eu,linutronix.de,vger.kernel.org,lists.ozlabs.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gnu.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1FAB91603C2
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 01:55:05PM +0100, Thomas Weißschuh wrote:
> On 2026-01-30 18:06:20+0100, Petr Pavlu wrote:
> > On 1/13/26 1:28 PM, Thomas Weißschuh wrote:
> > > Normally the .ko module files depend on a fully built vmlinux to be
> > > available for modpost validation and BTF generation. With
> > > CONFIG_MODULE_HASHES, vmlinux now depends on the modules
> > > to build a merkle tree. This introduces a dependency cycle which is
> > > impossible to satisfy. Work around this by building the modules during
> > > link-vmlinux.sh, after vmlinux is complete enough for modpost and BTF
> > > but before the final module hashes are
> > 
> > I wonder if this dependency cycle could be resolved by utilizing the
> > split into vmlinux.unstripped and vmlinux that occurred last year.
> > 
> > The idea is to create the following ordering: vmlinux.unstripped ->
> > modules -> vmlinux, and to patch in .module_hashes only when building
> > the final vmlinux.
> > 
> > This would require the following:
> > * Split scripts/Makefile.vmlinux into two Makefiles, one that builds the
> >   current vmlinux.unstripped and the second one that builds the final
> >   vmlinux from it.
> > * Modify the top Makefile to recognize vmlinux.unstripped and update the
> >   BTF generation rule 'modules: vmlinux' to
> >   'modules: vmlinux.unstripped'.
> > * Add the 'vmlinux: modules' ordering in the top Makefile for
> >   CONFIG_MODULE_HASHES=y.
> > * Remove the patching of vmlinux.unstripped in scripts/link-vmlinux.sh
> >   and instead move it into scripts/Makefile.vmlinux when running objcopy
> >   to produce the final vmlinux.
> > 
> > I think this approach has two main advantages:
> > * CONFIG_MODULE_HASHES can be made orthogonal to
> >   CONFIG_DEBUG_INFO_BTF_MODULES.
> > * All dependencies are expressed at the Makefile level instead of having
> >   scripts/link-vmlinux.sh invoke 'make -f Makefile modules'.
> > 
> > Below is a rough prototype that applies on top of this series. It is a
> > bit verbose due to the splitting of part of scripts/Makefile.vmlinux
> > into scripts/Makefile.vmlinux_unstripped.
> 
> That looks like a feasible alternative. Before adopting it, I'd like to
> hear the preference of the kbuild folks.
> 
> > diff --git a/Makefile b/Makefile
> > index 841772a5a260..19a3beb82fa7 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1259,7 +1259,7 @@ vmlinux_o: vmlinux.a $(KBUILD_VMLINUX_LIBS)
> >  vmlinux.o modules.builtin.modinfo modules.builtin: vmlinux_o
> >  	@:
> >  
> > -PHONY += vmlinux
> > +PHONY += vmlinux.unstripped vmlinux
> >  # LDFLAGS_vmlinux in the top Makefile defines linker flags for the top vmlinux,
> >  # not for decompressors. LDFLAGS_vmlinux in arch/*/boot/compressed/Makefile is
> >  # unrelated; the decompressors just happen to have the same base name,
> > @@ -1270,9 +1270,11 @@ PHONY += vmlinux
> >  #   https://savannah.gnu.org/bugs/?61463
> >  # For Make > 4.4, the following simple code will work:
> >  #  vmlinux: private export LDFLAGS_vmlinux := $(LDFLAGS_vmlinux)
> > -vmlinux: private _LDFLAGS_vmlinux := $(LDFLAGS_vmlinux)
> > -vmlinux: export LDFLAGS_vmlinux = $(_LDFLAGS_vmlinux)
> > -vmlinux: vmlinux.o $(KBUILD_LDS) modpost
> > +vmlinux.unstripped: private _LDFLAGS_vmlinux := $(LDFLAGS_vmlinux)
> > +vmlinux.unstripped: export LDFLAGS_vmlinux = $(_LDFLAGS_vmlinux)
> > +vmlinux.unstripped: vmlinux.o $(KBUILD_LDS) modpost
> > +	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.vmlinux_unstripped
> > +vmlinux: vmlinux.unstripped
> >  	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.vmlinux
> 
> Maybe we could keep them together in a single Makefile,
> and instead have different targets in it.
> 

yes, I think so, too.  I like the Petr's alternative.

Kind regards,
Nicolas

