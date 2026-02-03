Return-Path: <linux-integrity+bounces-8425-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGBgN0jwgWlAMwMAu9opvQ
	(envelope-from <linux-integrity+bounces-8425-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 13:55:36 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CACCBD96E5
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 13:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB52A3033AD0
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Feb 2026 12:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FF9346FA6;
	Tue,  3 Feb 2026 12:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="h3fezYnN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAE320B7ED;
	Tue,  3 Feb 2026 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770123309; cv=none; b=UJof4Hb6xKcflEtCB2xlZj/nykfeOswEjLhlj1Ub2xSXWEciqUWY8rQMPzNvdzkJONtU1E9r/uZJA2qwdgM6d2QbqLNXgZb4Wlzsdk1DcliCQwT4269qAc+LFudiVhaDIZ6ZxL86TseD0EFLgi8GFGqg+XNXI0/4S0n4OOQAprY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770123309; c=relaxed/simple;
	bh=8c+Pqi8S29ccrlKn7/Q5mxLVtC9FrsWFxplmCU6dgEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpuA3pychI9eMgfdJZvL9cDSMCQS4xcy+4Jd6bLpX5efsh37OY+odz13nUkDLLP+3/9ffY5oVcV72GAfQvts3nSjYW1CYpIUnQLcvx4gJQB6moagnw+GZjoyWLZNvmSu9EMcJRPznLGKG+H0cC2nUMIu7ugE5INFeLzNizw0ZA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=h3fezYnN; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1770123305;
	bh=8c+Pqi8S29ccrlKn7/Q5mxLVtC9FrsWFxplmCU6dgEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h3fezYnNYnXEKvq604yd2NerVugru+NdBANWM+DWnwaWb5ItwAC0VUZhIl5YUjCms
	 ygiVLrxrPvbovp2BJqy+bNMcWSa/VW1lTBYim8VFtMaE6qk2X2Xo1Ey0C4zQ14Aokc
	 Wog6ncF8YdRMXZU8PXR10lrOsiZ6bohkkWQdQQIY=
Date: Tue, 3 Feb 2026 13:55:05 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Daniel Gomez <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>, 
	Fabian =?utf-8?Q?Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, Arnout Engelen <arnout@bzzt.net>, 
	Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>, 
	Christian Heusel <christian@heusel.eu>, =?utf-8?B?Q8OianU=?= Mihai-Drosi <mcaju95@gmail.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 15/17] module: Introduce hash-based integrity checking
Message-ID: <28cf8d51-7530-41d5-a47b-cad5ecabd269@t-8ch.de>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-15-0b932db9b56b@weissschuh.net>
 <db1ed045-d7b6-49dc-b111-9fea7c30f8ab@suse.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db1ed045-d7b6-49dc-b111-9fea7c30f8ab@suse.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[weissschuh.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[weissschuh.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8425-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	FREEMAIL_CC(0.00)[kernel.org,arndb.de,google.com,samsung.com,paul-moore.com,namei.org,hallyn.com,lwn.net,linux.ibm.com,ellerman.id.au,gmail.com,huawei.com,oracle.com,linux.dev,atomlin.com,oss.cyber.gouv.fr,proxmox.com,bzzt.net,mapreri.org,archlinux.org,heusel.eu,linutronix.de,vger.kernel.org,lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@weissschuh.net,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[weissschuh.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[weissschuh.net:dkim,gnu.org:url,t-8ch.de:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CACCBD96E5
X-Rspamd-Action: no action

On 2026-01-30 18:06:20+0100, Petr Pavlu wrote:
> On 1/13/26 1:28 PM, Thomas Weißschuh wrote:
> > Normally the .ko module files depend on a fully built vmlinux to be
> > available for modpost validation and BTF generation. With
> > CONFIG_MODULE_HASHES, vmlinux now depends on the modules
> > to build a merkle tree. This introduces a dependency cycle which is
> > impossible to satisfy. Work around this by building the modules during
> > link-vmlinux.sh, after vmlinux is complete enough for modpost and BTF
> > but before the final module hashes are
> 
> I wonder if this dependency cycle could be resolved by utilizing the
> split into vmlinux.unstripped and vmlinux that occurred last year.
> 
> The idea is to create the following ordering: vmlinux.unstripped ->
> modules -> vmlinux, and to patch in .module_hashes only when building
> the final vmlinux.
> 
> This would require the following:
> * Split scripts/Makefile.vmlinux into two Makefiles, one that builds the
>   current vmlinux.unstripped and the second one that builds the final
>   vmlinux from it.
> * Modify the top Makefile to recognize vmlinux.unstripped and update the
>   BTF generation rule 'modules: vmlinux' to
>   'modules: vmlinux.unstripped'.
> * Add the 'vmlinux: modules' ordering in the top Makefile for
>   CONFIG_MODULE_HASHES=y.
> * Remove the patching of vmlinux.unstripped in scripts/link-vmlinux.sh
>   and instead move it into scripts/Makefile.vmlinux when running objcopy
>   to produce the final vmlinux.
> 
> I think this approach has two main advantages:
> * CONFIG_MODULE_HASHES can be made orthogonal to
>   CONFIG_DEBUG_INFO_BTF_MODULES.
> * All dependencies are expressed at the Makefile level instead of having
>   scripts/link-vmlinux.sh invoke 'make -f Makefile modules'.
> 
> Below is a rough prototype that applies on top of this series. It is a
> bit verbose due to the splitting of part of scripts/Makefile.vmlinux
> into scripts/Makefile.vmlinux_unstripped.

That looks like a feasible alternative. Before adopting it, I'd like to
hear the preference of the kbuild folks.

> diff --git a/Makefile b/Makefile
> index 841772a5a260..19a3beb82fa7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1259,7 +1259,7 @@ vmlinux_o: vmlinux.a $(KBUILD_VMLINUX_LIBS)
>  vmlinux.o modules.builtin.modinfo modules.builtin: vmlinux_o
>  	@:
>  
> -PHONY += vmlinux
> +PHONY += vmlinux.unstripped vmlinux
>  # LDFLAGS_vmlinux in the top Makefile defines linker flags for the top vmlinux,
>  # not for decompressors. LDFLAGS_vmlinux in arch/*/boot/compressed/Makefile is
>  # unrelated; the decompressors just happen to have the same base name,
> @@ -1270,9 +1270,11 @@ PHONY += vmlinux
>  #   https://savannah.gnu.org/bugs/?61463
>  # For Make > 4.4, the following simple code will work:
>  #  vmlinux: private export LDFLAGS_vmlinux := $(LDFLAGS_vmlinux)
> -vmlinux: private _LDFLAGS_vmlinux := $(LDFLAGS_vmlinux)
> -vmlinux: export LDFLAGS_vmlinux = $(_LDFLAGS_vmlinux)
> -vmlinux: vmlinux.o $(KBUILD_LDS) modpost
> +vmlinux.unstripped: private _LDFLAGS_vmlinux := $(LDFLAGS_vmlinux)
> +vmlinux.unstripped: export LDFLAGS_vmlinux = $(_LDFLAGS_vmlinux)
> +vmlinux.unstripped: vmlinux.o $(KBUILD_LDS) modpost
> +	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.vmlinux_unstripped
> +vmlinux: vmlinux.unstripped
>  	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.vmlinux

Maybe we could keep them together in a single Makefile,
and instead have different targets in it.

(...)

> @@ -98,70 +44,15 @@ remove-symbols := -w --strip-unneeded-symbol='__mod_device_table__*'
>  # To avoid warnings: "empty loadable segment detected at ..." from GNU objcopy,
>  # it is necessary to remove the PT_LOAD flag from the segment.
>  quiet_cmd_strip_relocs = OBJCOPY $@
> -      cmd_strip_relocs = $(OBJCOPY) $(patsubst %,--set-section-flags %=noload,$(remove-section-y)) $< $@; \
> -                         $(OBJCOPY) $(addprefix --remove-section=,$(remove-section-y)) $(remove-symbols) $@
> +      cmd_script_relocs = $(OBJCOPY) $(patsubst %,--set-section-flags %=noload,$(remove-section-y)) $< $@; \
> +                          $(OBJCOPY) $(addprefix --remove-section=,$(remove-section-y)) \
> +                                     $(remove-symbols) \
> +                                     $(patch-module-hashes) $@

cmd_script_relocs -> cmd_strip_relocs

(...)

