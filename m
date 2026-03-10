Return-Path: <linux-integrity+bounces-8967-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INkVCs2OsGkukgIAu9opvQ
	(envelope-from <linux-integrity+bounces-8967-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Mar 2026 22:36:13 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D24652585E3
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Mar 2026 22:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B15D6302D5A7
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Mar 2026 21:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2809F3DD522;
	Tue, 10 Mar 2026 21:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFsrzVKi"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018B838AC64;
	Tue, 10 Mar 2026 21:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773178570; cv=none; b=g/oRt8gTQmo5qVO/OtVa1DTxChnA8l+IvWruyBWOmrGSeg08EpYX+y498mQ8Lx8QzUgZ4WX06jS8rV6E9vWh9pPFl+x4o5qoXSIPm4NvgHaaK3XrJTVQATHkah+RZV/IUEWzyhUkBe6MHZw+374TpqobU6dsVLWVhi3tsjKBOIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773178570; c=relaxed/simple;
	bh=Xg4CGBK3u8/ArgMip1X0dYT6v82ryRISxkCSzREkPSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyA7XzZa8/rjYNwqKeKZbs3acCpeVhvd8EzU6us+K7MIAaaXRAlDMDOgZDpo+0E9zOL9fyLuGrP3foHw7GYXyfqvlmbIhMecUzz7Xg/8xTdOrwXiAz6gT2T2GeZegQAdSoWJFboyB+myizpds3XGsPUVx4QxSprpyVeSnxWEbqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rFsrzVKi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47922C19423;
	Tue, 10 Mar 2026 21:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773178569;
	bh=Xg4CGBK3u8/ArgMip1X0dYT6v82ryRISxkCSzREkPSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rFsrzVKiD8VQjeGuN+nEd00lZPd0I4jL+qZRfGtN3x1gIsiu+MJ8jFnr83Y+560yY
	 SpEl2asG9qxhQgwS/T+7OdXOjJP4Uie/qk7vLBGXJ0YEdOMD+VtIK3iVBP5xb5t+sR
	 AWlWnw+zk3tSDoW3EImfYu5Du8Uy4F2++O1V2FGVqKKSjV9YKUWJsj37oEu5TaaYv0
	 h0LIbjKFNgwn0zf9efYj16MNz7kz27oGqtw+c1YEGZVjJ1TxHDJwF3v+Gs1h4mihps
	 jFoLf8wbuiKkjVBnQqE0JrNES33AIWTX6ZkcyETw1CBNFaoCmmu6oY8B5yjWBz8zag
	 9wnK1qInBajjw==
Date: Tue, 10 Mar 2026 14:36:06 -0700
From: Eric Biggers <ebiggers@kernel.org>
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
	Nicolas Schier <nicolas.schier@linux.dev>,
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
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
Subject: Re: [PATCH v4 06/17] kbuild: add stamp file for vmlinux BTF data
Message-ID: <20260310213606.GD120274@quark>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-6-0b932db9b56b@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260113-module-hashes-v4-6-0b932db9b56b@weissschuh.net>
X-Rspamd-Queue-Id: D24652585E3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8967-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[41];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,arndb.de,suse.com,google.com,samsung.com,paul-moore.com,namei.org,hallyn.com,lwn.net,linux.ibm.com,ellerman.id.au,gmail.com,huawei.com,oracle.com,linux.dev,atomlin.com,oss.cyber.gouv.fr,proxmox.com,bzzt.net,mapreri.org,archlinux.org,heusel.eu,linutronix.de,vger.kernel.org,lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,weissschuh.net:email,link-vmlinux.sh:url]
X-Rspamd-Action: no action

On Tue, Jan 13, 2026 at 01:28:50PM +0100, Thomas Weiﬂschuh wrote:
> The upcoming module hashes functionality will build the modules in
> between the generation of the BTF data and the final link of vmlinux.
> Having a dependency from the modules on vmlinux would make this
> impossible as it would mean having a cyclic dependency.
> Break this cyclic dependency by introducing a new target.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  scripts/Makefile.modfinal | 4 ++--
>  scripts/link-vmlinux.sh   | 6 ++++++
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> index 149e12ff5700..adfef1e002a9 100644
> --- a/scripts/Makefile.modfinal
> +++ b/scripts/Makefile.modfinal
> @@ -56,8 +56,8 @@ if_changed_except = $(if $(call newer_prereqs_except,$(2))$(cmd-check),      \
>  	printf '%s\n' 'savedcmd_$@ := $(make-cmd)' > $(dot-target).cmd, @:)
>  
>  # Re-generate module BTFs if either module's .ko or vmlinux changed
> -%.ko: %.o %.mod.o .module-common.o $(objtree)/scripts/module.lds $(and $(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),$(objtree)/vmlinux) FORCE
> -	+$(call if_changed_except,ld_ko_o,$(objtree)/vmlinux)
> +%.ko: %.o %.mod.o .module-common.o $(objtree)/scripts/module.lds $(and $(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),$(objtree)/.tmp_vmlinux_btf.stamp) FORCE
> +	+$(call if_changed_except,ld_ko_o,$(objtree)/.tmp_vmlinux_btf.stamp)
>  ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>  	+$(if $(newer-prereqs),$(call cmd,btf_ko))
>  endif
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 4ab44c73da4d..8c98f8645a5c 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -111,6 +111,7 @@ vmlinux_link()
>  gen_btf()
>  {
>  	local btf_data=${1}.btf.o
> +	local btf_stamp=.tmp_vmlinux_btf.stamp
>  
>  	info BTF "${btf_data}"
>  	LLVM_OBJCOPY="${OBJCOPY}" ${PAHOLE} -J ${PAHOLE_FLAGS} ${1}
> @@ -131,6 +132,11 @@ gen_btf()
>  	fi
>  	printf "${et_rel}" | dd of="${btf_data}" conv=notrunc bs=1 seek=16 status=none
>  
> +	info STAMP $btf_stamp
> +	if ! cmp --silent $btf_data $btf_stamp; then
> +		cp $btf_data $btf_stamp
> +	fi

A "stamp file" is traditionally an empty file that is written when some
build step has completed.  The above code is instead copying the entire
.tmp_vmlinux1.btf.o file (megabytes in size) to .tmp_vmlinux_btf.stamp.

So, it's not clear to me why the stamp file is needed at all, versus
depending directly on .tmp_vmlinux1.btf.o.

I guess 'make' doesn't know about the dependencies of
.tmp_vmlinux1.btf.o.  But the same is true of the stamp file, right?  So
either way, how would 'make' know to finish rebuilding the file before
starting to execute the "Re-generate module BTFs" rule?

Also, passing the long option '--silent' to 'cmp' creates a dependency
on the GNU implementation of 'cmp', which isn't documented as a kernel
build dependency.  Probably better to use the short option '-s'.

Also, the stamp file isn't being deleted by 'make clean'.  It looks like
it would need to be added to cleanup() in link-vmlinux.sh.

- Eric

