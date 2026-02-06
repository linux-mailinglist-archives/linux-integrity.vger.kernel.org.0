Return-Path: <linux-integrity+bounces-8473-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDggOVIhhmm/JwQAu9opvQ
	(envelope-from <linux-integrity+bounces-8473-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 06 Feb 2026 18:13:54 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA9A100CC9
	for <lists+linux-integrity@lfdr.de>; Fri, 06 Feb 2026 18:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7407302A05F
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Feb 2026 17:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BA1393DCB;
	Fri,  6 Feb 2026 17:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMP7LNGl"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36C035F8DF;
	Fri,  6 Feb 2026 17:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770397968; cv=none; b=rqX1gp9EKBSFpJT+Q8YnqEI7upsQWL/xV3lw+0eqRqEheN2x5oSOm84fT5r0nzA4h/sPFEA5Zjyz0CYDEP9IdZmgEwuzMF6byHKb14jRrd2MovxfWlEf8IrdZLE8Lpr1kEHOxtM5PBdxbKaAeScAgi2L0brCIhkC/tqSuzrDRt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770397968; c=relaxed/simple;
	bh=f51fr0RwPbgcilaL5p8ILUT8dwBt1G9K1Ep4iTQCoSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZnwNZpV6BcTpmiOsE+Sl9Rlmbeg/Sw/M5BnDs3w+bfkQnY73KMo5IgJfBzf3b3/LnCnisNRYNsk81K+kZqi+wgP2qXDFyBTGtSCnL+9uKVJn569Ytd7X3I7aqjEohcrVX41FtCcxOInjhbaE0mvl6u5o3nJtLynawksESZb3kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMP7LNGl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1DF7C116C6;
	Fri,  6 Feb 2026 17:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770397967;
	bh=f51fr0RwPbgcilaL5p8ILUT8dwBt1G9K1Ep4iTQCoSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CMP7LNGlV4Z5pl65Rd7unzogYBQIDSiH0zCtfTSI/EDUAvkpSMrd4HnjKZU17g/CD
	 BZXra/le1xACKpyF9UI9qrbi98RA1m2+XnuqbCNSbZXoiR7HHqcDRQ4sqLwoGcWIFt
	 Q0gGqwzFR96kUU/DPD+4x32K3EsCiCXwubYEJFJR671ERQ2Ep2XKeGvPhGyLcWKjSv
	 fw7+ENfiFAwGhG3sv9DyBKyBpOyMbc9ayAtcqhr+o75aqwj4Q4grNrv/gDBhW/g8Cd
	 JbLHFv4Zl7PQ8Ml8t4YQFXh/glEDKdROiw6yzoC0OnYLcSsCEqQjmFDxwsLqcxA46k
	 0vV8F35qk4E1A==
Date: Fri, 6 Feb 2026 18:12:37 +0100
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
Message-ID: <aYYhBe9hZsIW8LXP@levanger>
Mail-Followup-To: Nicolas Schier <nsc@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Nathan Chancellor <nathan@kernel.org>,
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
	TAGGED_FROM(0.00)[bounces-8473-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[39];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[suse.com,kernel.org,arndb.de,google.com,samsung.com,paul-moore.com,namei.org,hallyn.com,lwn.net,linux.ibm.com,ellerman.id.au,gmail.com,huawei.com,oracle.com,atomlin.com,oss.cyber.gouv.fr,proxmox.com,bzzt.net,mapreri.org,archlinux.org,heusel.eu,linutronix.de,vger.kernel.org,lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nsc@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gnu.org:url]
X-Rspamd-Queue-Id: 8DA9A100CC9
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

After the first run-through, the proposed alternative sounds good.
Unfortunately, I ran out of time for this week.  I can give a more
founded reply in a few days.

Kind regards,
Nicolas



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
> (...)
> 
> > @@ -98,70 +44,15 @@ remove-symbols := -w --strip-unneeded-symbol='__mod_device_table__*'
> >  # To avoid warnings: "empty loadable segment detected at ..." from GNU objcopy,
> >  # it is necessary to remove the PT_LOAD flag from the segment.
> >  quiet_cmd_strip_relocs = OBJCOPY $@
> > -      cmd_strip_relocs = $(OBJCOPY) $(patsubst %,--set-section-flags %=noload,$(remove-section-y)) $< $@; \
> > -                         $(OBJCOPY) $(addprefix --remove-section=,$(remove-section-y)) $(remove-symbols) $@
> > +      cmd_script_relocs = $(OBJCOPY) $(patsubst %,--set-section-flags %=noload,$(remove-section-y)) $< $@; \
> > +                          $(OBJCOPY) $(addprefix --remove-section=,$(remove-section-y)) \
> > +                                     $(remove-symbols) \
> > +                                     $(patch-module-hashes) $@
> 
> cmd_script_relocs -> cmd_strip_relocs
> 
> (...)

-- 
Nicolas

